import { NextResponse } from "next/server";
import { eq, inArray, max } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattaResults, regattas, sailorAliases, sailors } from "@/db/schema";
import {
  combinedNameSimilarity,
  findSailorByName,
  suggestSailorByName,
} from "@/lib/nameMatch";
import { makeGuestHandle, slugify } from "@/lib/slug";
import { trackUsage } from "@/lib/usage";
import {
  buildImportMessage,
  cleanImportRows,
  findWithinFileDuplicates,
  IMPORT_MAX_DUPLICATE_FLAGS,
  IMPORT_RESULT_CHUNK,
  type RawImportRow,
} from "@/lib/importRegatta";
import { runInChunks } from "@/lib/runInChunks";
import type { ImportPossibleDuplicate } from "@/types/import";

export type { ImportPossibleDuplicate };

/** Allow long Optimist fleet imports on Vercel (default is often 10–15s). */
export const maxDuration = 60;

type SailorMatchRow = {
  id: string;
  name: string;
  sailNumber: string | null;
  dob: string | null;
  club: string | null;
  school: string | null;
  nationality: string | null;
  silverEntryDate: string | null;
  goldEntryDate: string | null;
};

export async function POST(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();
    const {
      regattaName,
      eventDate,
      division,
      totalFleetSize,
      rows,
      createMissing = true,
    }: {
      regattaName: string;
      eventDate: string;
      division?: string;
      totalFleetSize?: number;
      rows: RawImportRow[];
      createMissing?: boolean;
    } = body;

    if (!regattaName || !eventDate || !Array.isArray(rows)) {
      return NextResponse.json({ error: "Invalid payload" }, { status: 400 });
    }

    const cleanRows = cleanImportRows(rows);
    if (!cleanRows.length) {
      return NextResponse.json(
        { error: "No named rows to import (check Name column)" },
        { status: 400 }
      );
    }

    const slug = `${slugify(regattaName)}-${eventDate}`;
    const fleetSize = totalFleetSize || cleanRows.length || 50;

    const [reg] = await db
      .insert(regattas)
      .values({
        name: regattaName,
        slug,
        date: eventDate,
        totalFleetSize: fleetSize,
        division: division || "Gold",
      })
      .onConflictDoUpdate({
        target: regattas.slug,
        set: {
          name: regattaName,
          totalFleetSize: fleetSize,
          division: division || "Gold",
          date: eventDate,
          updatedAt: new Date(),
        },
      })
      .returning();

    let sailorList: SailorMatchRow[] = await db
      .select({
        id: sailors.id,
        name: sailors.name,
        sailNumber: sailors.sailNumber,
        dob: sailors.dob,
        club: sailors.club,
        school: sailors.school,
        nationality: sailors.nationality,
        silverEntryDate: sailors.silverEntryDate,
        goldEntryDate: sailors.goldEntryDate,
      })
      .from(sailors);

    // Latest ranking result date per sailor (aggregated)
    const latestDateBySailor = new Map<string, string>();
    try {
      const latestRows = await db
        .select({
          sailorId: regattaResults.sailorId,
          maxDate: max(regattas.date),
        })
        .from(regattaResults)
        .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
        .where(eq(regattas.countsForRanking, true))
        .groupBy(regattaResults.sailorId);
      for (const row of latestRows) {
        const d = String(row.maxDate || "").slice(0, 10);
        if (row.sailorId && /^\d{4}-\d{2}-\d{2}$/.test(d)) {
          latestDateBySailor.set(row.sailorId, d);
        }
      }
    } catch (e) {
      console.warn("import latest-date aggregate failed, continuing", e);
    }

    const { shouldApplyProfileFromRegatta, buildProfilePatchFromRow } =
      await import("@/lib/profileFromRegatta");
    const { deriveAllSilverEntryDates } = await import(
      "@/lib/deriveFleetEntryDates"
    );
    const { logAdminChange } = await import("@/lib/adminChangeLog");

    const affectedSailorIds = new Set<string>();
    const profileChangeFields: string[] = [];
    const aliasList = await db
      .select({
        sailorId: sailorAliases.sailorId,
        aliasName: sailorAliases.aliasName,
      })
      .from(sailorAliases);

    let matched = 0;
    let created = 0;
    let updatedProfiles = 0;
    let rowErrors = 0;
    const unmatched: {
      rawName: string;
      rank: number | null;
      nett: number | null;
      suggestedId: string | null;
      suggestedName: string | null;
      similarity: number;
      error?: string;
    }[] = [];
    const matchHow: Record<string, number> = {};
    const errorSamples: string[] = [];
    const possibleDuplicates: ImportPossibleDuplicate[] = [];
    const vsDbSeen = new Set<string>();
    const pendingResults: {
      regattaId: string;
      sailorId: string;
      rank: number;
      nettScore: number | null;
      totalScore: number | null;
      isDns: boolean;
    }[] = [];
    const pendingAliases: { sailorId: string; aliasName: string }[] = [];

    const dbBeforeImport = sailorList.map((s) => ({
      id: s.id,
      name: s.name,
    }));

    possibleDuplicates.push(
      ...findWithinFileDuplicates(cleanRows.map((r) => r.name))
    );

    for (const row of cleanRows) {
      try {
        const hit = findSailorByName(row.name, sailorList, aliasList);
        let sailorId: string | null = hit?.sailor.id ?? null;

        if (hit) {
          matchHow[hit.how] = (matchHow[hit.how] || 0) + 1;
          if (hit.how.startsWith("fuzzy")) {
            const sim = combinedNameSimilarity(row.name, hit.sailor.name);
            if (sim >= 0.6 && sim < 1) {
              const key = `${row.name.toLowerCase()}|${hit.sailor.id}`;
              if (!vsDbSeen.has(key)) {
                vsDbSeen.add(key);
                possibleDuplicates.push({
                  kind: "vs-db",
                  importName: row.name,
                  otherName: hit.sailor.name,
                  otherId: hit.sailor.id,
                  similarity: Math.round(sim * 100) / 100,
                  band: sim >= 0.8 ? "high" : "medium",
                  note: "Matched to existing sailor via fuzzy name — confirm correct",
                });
              }
            }
          }
        }

        if (!sailorId) {
          const sug = suggestSailorByName(row.name, dbBeforeImport);
          if (sug && sug.similarity >= 0.6) {
            const key = `${row.name.toLowerCase()}|${sug.id}`;
            if (!vsDbSeen.has(key)) {
              vsDbSeen.add(key);
              possibleDuplicates.push({
                kind: "vs-db",
                importName: row.name,
                otherName: sug.name,
                otherId: sug.id,
                similarity: Math.round(sug.similarity * 100) / 100,
                band: sug.similarity >= 0.8 ? "high" : "medium",
                note: createMissing
                  ? "Created as guest but similar name already in database — consider merge"
                  : "Similar name already in database",
              });
            }
          }
        }

        if (!sailorId && createMissing) {
          const handle = makeGuestHandle(row.name);
          const [createdSailor] = await db
            .insert(sailors)
            .values({
              name: row.name,
              handle,
              sailNumber: row.sailNumber || "SGP 000",
              club: row.club || "N/A",
              ...(row.school ? { school: row.school } : {}),
              ...(row.nationality ? { nationality: row.nationality } : {}),
              ...(row.dob ? { dob: row.dob } : {}),
            })
            .returning({
              id: sailors.id,
              name: sailors.name,
              sailNumber: sailors.sailNumber,
              dob: sailors.dob,
              club: sailors.club,
              school: sailors.school,
              nationality: sailors.nationality,
              silverEntryDate: sailors.silverEntryDate,
              goldEntryDate: sailors.goldEntryDate,
            });
          sailorId = createdSailor.id;
          sailorList = [...sailorList, createdSailor];
          try {
            await db.insert(sailorAliases).values({
              sailorId: createdSailor.id,
              aliasName: row.name,
            });
            aliasList.push({
              sailorId: createdSailor.id,
              aliasName: row.name,
            });
          } catch {
            /* alias exists */
          }
          created++;
          matchHow["created"] = (matchHow["created"] || 0) + 1;
        }

        if (!sailorId) {
          const sug = suggestSailorByName(row.name, sailorList);
          unmatched.push({
            rawName: row.name,
            rank: row.rank,
            nett: row.nett,
            suggestedId: sug?.id ?? null,
            suggestedName: sug?.name ?? null,
            similarity: sug?.similarity ?? 0,
          });
          continue;
        }

        const existing = sailorList.find((s) => s.id === sailorId);
        const applyProfile = shouldApplyProfileFromRegatta({
          regattaDate: eventDate,
          latestResultDate: latestDateBySailor.get(sailorId) || null,
        });
        const { patch: fieldPatch, changed: fieldChanged } =
          buildProfilePatchFromRow(
            {
              sailNumber: row.sailNumber,
              club: row.club,
              school: row.school,
            },
            {
              sailNumber: existing?.sailNumber,
              club: existing?.club,
              school: existing?.school,
            },
            applyProfile
          );
        const profilePatch: Record<string, unknown> = {
          updatedAt: new Date(),
          ...fieldPatch,
        };
        let profileChanged = fieldChanged.length > 0;

        if (row.dob) {
          const curDob = existing?.dob ? String(existing.dob).slice(0, 10) : "";
          if (!curDob) {
            profilePatch.dob = row.dob;
            profileChanged = true;
            fieldChanged.push("dob");
          } else if (curDob !== row.dob) {
            if (row.dobIsYearOnly && curDob.startsWith(row.dob.slice(0, 4))) {
              /* keep full DOB for same year */
            } else {
              profilePatch.dob = row.dob;
              profileChanged = true;
              fieldChanged.push("dob");
            }
          }
        }
        if (row.nationality) {
          const cur = (existing?.nationality || "").trim();
          if (!cur || cur.toLowerCase() !== row.nationality.toLowerCase()) {
            profilePatch.nationality = row.nationality;
            profileChanged = true;
            fieldChanged.push("nationality");
          }
        }

        if (profileChanged) {
          await db
            .update(sailors)
            .set(profilePatch as typeof sailors.$inferInsert)
            .where(eq(sailors.id, sailorId));
          updatedProfiles++;
          for (const f of fieldChanged) {
            if (
              (f === "sailNumber" || f === "club" || f === "school") &&
              !profileChangeFields.includes(f)
            ) {
              profileChangeFields.push(f);
            }
          }
          sailorList = sailorList.map((s) =>
            s.id === sailorId
              ? {
                  ...s,
                  sailNumber:
                    (profilePatch.sailNumber as string) ?? s.sailNumber,
                  dob: (profilePatch.dob as string) ?? s.dob,
                  club: (profilePatch.club as string) ?? s.club,
                  school: (profilePatch.school as string) ?? s.school,
                  nationality:
                    (profilePatch.nationality as string) ?? s.nationality,
                }
              : s
          );
          const ed = String(eventDate).slice(0, 10);
          const prevL = latestDateBySailor.get(sailorId);
          if (!prevL || ed >= prevL) latestDateBySailor.set(sailorId, ed);
        }
        affectedSailorIds.add(sailorId);

        const rank = row.rank != null ? Math.round(row.rank) : 999;
        const nett = row.nett != null ? row.nett : null;
        const total = row.total != null ? row.total : null;

        pendingResults.push({
          regattaId: reg.id,
          sailorId,
          rank,
          nettScore: nett,
          totalScore: total,
          isDns: false,
        });
        matched++;

        if (hit && hit.how !== "exact") {
          pendingAliases.push({ sailorId, aliasName: row.name });
        }
      } catch (rowErr) {
        rowErrors++;
        const msg =
          rowErr instanceof Error ? rowErr.message : String(rowErr);
        if (errorSamples.length < 5) {
          errorSamples.push(`${row.name}: ${msg.slice(0, 160)}`);
        }
        const hint = /integer|numeric|invalid input|nett/i.test(msg)
          ? " (run SQL migration 003_nett_score_real.sql — nett must allow decimals like 14.5)"
          : "";
        unmatched.push({
          rawName: row.name,
          rank: row.rank,
          nett: row.nett,
          suggestedId: null,
          suggestedName: null,
          similarity: 0,
          error: msg.slice(0, 120) + hint,
        });
      }
    }

    // Parallel chunked upserts — sequential N inserts timed out serverless
    if (pendingResults.length) {
      await runInChunks(pendingResults, IMPORT_RESULT_CHUNK, async (r) => {
        await db
          .insert(regattaResults)
          .values(r)
          .onConflictDoUpdate({
            target: [regattaResults.sailorId, regattaResults.regattaId],
            set: {
              rank: r.rank,
              nettScore: r.nettScore,
              totalScore: r.totalScore,
              isDns: r.isDns,
              updatedAt: new Date(),
            },
          });
      });
    }

    if (pendingAliases.length) {
      const seenAlias = new Set<string>();
      const unique = pendingAliases.filter((a) => {
        const k = `${a.sailorId}|${a.aliasName.toLowerCase()}`;
        if (seenAlias.has(k)) return false;
        seenAlias.add(k);
        return true;
      });
      await runInChunks(unique, IMPORT_RESULT_CHUNK, async (a) => {
        try {
          await db.insert(sailorAliases).values({
            sailorId: a.sailorId,
            aliasName: a.aliasName,
          });
        } catch {
          /* exists */
        }
      });
    }

    // Silver entry dates — only sailors touched by this import
    let silverUpdated = 0;
    const affectedIds = [...affectedSailorIds];
    if (affectedIds.length) {
      try {
        const silverLinks = await db
          .select({
            sailorId: regattaResults.sailorId,
            regattaDate: regattas.date,
            division: regattas.division,
            countsForRanking: regattas.countsForRanking,
          })
          .from(regattaResults)
          .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
          .where(inArray(regattaResults.sailorId, affectedIds));
        const derived = deriveAllSilverEntryDates(
          silverLinks.map((l) => ({
            sailorId: l.sailorId,
            regattaDate: l.regattaDate,
            division: l.division,
            countsForRanking: l.countsForRanking,
          }))
        );
        for (const sid of affectedIds) {
          const next = derived.get(sid);
          if (!next) continue;
          const cur = sailorList.find((s) => s.id === sid);
          const prev = cur?.silverEntryDate
            ? String(cur.silverEntryDate).slice(0, 10)
            : null;
          if (prev === next) continue;
          await db
            .update(sailors)
            .set({ silverEntryDate: next, updatedAt: new Date() })
            .where(eq(sailors.id, sid));
          silverUpdated++;
        }
      } catch (e) {
        console.warn("silver recompute after import", e);
      }
    }

    if (matched > 0 || created > 0 || updatedProfiles > 0) {
      void logAdminChange({
        action: "import.regatta",
        entityType: "regatta",
        entityId: reg.id,
        entityLabel: reg.name,
        summary: `Imported ${matched}/${cleanRows.length} results for ${regattaName} (${eventDate}); ${created} guests, ${updatedProfiles} profiles, ${silverUpdated} silver dates`,
        details: {
          matched,
          created,
          updatedProfiles,
          silverUpdated,
          rowErrors,
          profileFields: profileChangeFields,
        },
        source: "/api/admin/import",
      });
    }

    const needsNettMigration = errorSamples.some((e) =>
      /integer|real|numeric|type/i.test(e)
    );
    possibleDuplicates.sort((a, b) => b.similarity - a.similarity);
    const dupeFlags = possibleDuplicates.slice(0, IMPORT_MAX_DUPLICATE_FLAGS);
    const unmatchedNoError = unmatched.filter((u) => !u.error).length;

    void trackUsage({
      eventType: "import",
      path: "/admin",
      role: "superadmin",
      meta: {
        matched,
        created,
        inputRows: cleanRows.length,
        rowErrors,
      },
    });

    return NextResponse.json({
      message: buildImportMessage({
        regattaName: reg.name,
        matched,
        inputRows: cleanRows.length,
        created,
        updatedProfiles,
        silverUpdated,
        rowErrors,
        unmatchedCount: unmatchedNoError,
        duplicateCount: possibleDuplicates.length,
        needsNettMigration,
      }),
      regatta: reg,
      matched,
      created,
      updatedProfiles,
      silverUpdated,
      unmatched: unmatched.slice(0, 80),
      possibleDuplicates: dupeFlags,
      inputRows: cleanRows.length,
      rowErrors,
      matchHow,
      errorSamples,
      hint: needsNettMigration
        ? "Supabase SQL Editor → run: ALTER TABLE public.regatta_results ALTER COLUMN nett_score TYPE real USING nett_score::real;"
        : undefined,
    });
  } catch (e) {
    console.error(e);
    return jsonError(e);
  }
}
