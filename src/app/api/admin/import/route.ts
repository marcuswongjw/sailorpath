import { NextResponse } from "next/server";
import { eq } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattaResults, regattas, sailorAliases, sailors } from "@/db/schema";
import {
  combinedNameSimilarity,
  findSailorByName,
  suggestSailorByName,
} from "@/lib/nameMatch";
import {
  normalizeDob,
  normalizeOptionalText,
  normalizeSailNumber,
  toNumber,
} from "@/lib/normalize";
import { makeGuestHandle, slugify } from "@/lib/slug";
import { normalizeNationality } from "@/lib/seriesMembership";
import { trackUsage } from "@/lib/usage";
import type { ImportPossibleDuplicate } from "@/types/import";

export type { ImportPossibleDuplicate };

/** Pairwise similar names within the import sheet (60%+). */
function findWithinFileDuplicates(
  names: string[],
  minSimilarity = 0.6
): ImportPossibleDuplicate[] {
  const out: ImportPossibleDuplicate[] = [];
  const seen = new Set<string>();
  for (let i = 0; i < names.length; i++) {
    for (let j = i + 1; j < names.length; j++) {
      const a = names[i];
      const b = names[j];
      if (!a || !b || a === b) continue;
      const sim = combinedNameSimilarity(a, b);
      if (sim < minSimilarity) continue;
      const key = [a, b].map((n) => n.toLowerCase()).sort().join("|");
      if (seen.has(key)) continue;
      seen.add(key);
      out.push({
        kind: "within-file",
        importName: a,
        otherName: b,
        similarity: Math.round(sim * 100) / 100,
        band: sim >= 0.8 ? "high" : "medium",
        note: "Two rows in this file look like the same sailor",
      });
    }
  }
  return out.sort((x, y) => y.similarity - x.similarity);
}

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
      rows: {
        name: string;
        rank: number | null;
        nett: number | null;
        total?: number | null;
        club?: string | null;
        nationality?: string | null;
        sailNumber?: string | null;
        dob?: string | number | null;
        birthYear?: string | number | null;
      }[];
      createMissing?: boolean;
    } = body;

    if (!regattaName || !eventDate || !Array.isArray(rows)) {
      return NextResponse.json({ error: "Invalid payload" }, { status: 400 });
    }

    const cleanRows = rows
      .map((r) => {
        const sailNumber = normalizeSailNumber(r.sailNumber);
        // Full DOB preferred; birth year alone is year-only (YYYY-01-01 placeholder)
        const fullDob = normalizeDob(r.dob);
        const yearOnlyDob = !fullDob ? normalizeDob(r.birthYear) : null;
        // If client already put year into dob and also sent birthYear, treat as year-only
        const birthYearHint =
          r.birthYear != null && r.birthYear !== ""
            ? normalizeDob(r.birthYear)
            : null;
        const dob = fullDob || yearOnlyDob;
        const dobIsYearOnly = Boolean(
          yearOnlyDob ||
            (birthYearHint && fullDob && fullDob === birthYearHint)
        );
        return {
          name: String(r.name || "").trim(),
          rank: toNumber(r.rank),
          nett: toNumber(r.nett),
          total: toNumber((r as { total?: number | null }).total),
          club: normalizeOptionalText(r.club),
          nationality:
            normalizeNationality(r.nationality) ||
            normalizeOptionalText(r.nationality),
          sailNumber,
          dob,
          dobIsYearOnly,
        };
      })
      .filter((r) => r.name.length > 0);

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

    let sailorList = await db
      .select({
        id: sailors.id,
        name: sailors.name,
        sailNumber: sailors.sailNumber,
        dob: sailors.dob,
        club: sailors.club,
        nationality: sailors.nationality,
      })
      .from(sailors);
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

    // Snapshot DB before creates so "vs-db" warnings use pre-import sailors
    const dbBeforeImport = sailorList.map((s) => ({
      id: s.id,
      name: s.name,
    }));

    // Within-file similar names (before create — pure sheet check)
    possibleDuplicates.push(
      ...findWithinFileDuplicates(cleanRows.map((r) => r.name))
    );

    for (const row of cleanRows) {
      try {
        let hit = findSailorByName(row.name, sailorList, aliasList);
        let sailorId: string | null = hit?.sailor.id ?? null;

        if (hit) {
          matchHow[hit.how] = (matchHow[hit.how] || 0) + 1;
          // Soft fuzzy match used — surface for admin review
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

        // Before creating a guest: flag close DB names that did not auto-match
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
          // Guests only: never auto-admit to SG series (no fleet / entry dates)
          const [createdSailor] = await db
            .insert(sailors)
            .values({
              name: row.name,
              handle,
              sailNumber: row.sailNumber || "SGP 000",
              club: row.club || "N/A",
              ...(row.nationality ? { nationality: row.nationality } : {}),
              ...(row.dob ? { dob: row.dob } : {}),
              // currentFleet / goldEntryDate / silverEntryDate intentionally omitted
            })
            .returning({
              id: sailors.id,
              name: sailors.name,
              sailNumber: sailors.sailNumber,
              dob: sailors.dob,
              club: sailors.club,
              nationality: sailors.nationality,
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

        // Optional profile enrichment from sheet (only when columns present)
        const existing = sailorList.find((s) => s.id === sailorId);
        const profilePatch: {
          sailNumber?: string;
          dob?: string;
          club?: string;
          nationality?: string;
          updatedAt: Date;
        } = { updatedAt: new Date() };
        let profileChanged = false;

        if (row.sailNumber) {
          const cur = (existing?.sailNumber || "").trim();
          const isPlaceholder = !cur || /^SGP\s*0+$/i.test(cur) || cur === "N/A";
          if (isPlaceholder || cur.toLowerCase() !== row.sailNumber.toLowerCase()) {
            profilePatch.sailNumber = row.sailNumber;
            profileChanged = true;
          }
        }
        if (row.dob) {
          const curDob = existing?.dob ? String(existing.dob).slice(0, 10) : "";
          if (!curDob) {
            profilePatch.dob = row.dob;
            profileChanged = true;
          } else if (curDob !== row.dob) {
            // Don't wipe a full DOB (e.g. 2013-05-12) with year-only 2013-01-01
            if (
              row.dobIsYearOnly &&
              curDob.startsWith(row.dob.slice(0, 4))
            ) {
              /* keep existing full date for same birth year */
            } else {
              profilePatch.dob = row.dob;
              profileChanged = true;
            }
          }
        }
        // Club: update when sheet has a value and it differs (incl. fill N/A)
        if (row.club) {
          const cur = (existing?.club || "").trim();
          if (!cur || cur === "N/A" || cur.toLowerCase() !== row.club.toLowerCase()) {
            profilePatch.club = row.club;
            profileChanged = true;
          }
        }
        // Nationality: same optional update pattern
        if (row.nationality) {
          const cur = (existing?.nationality || "").trim();
          if (!cur || cur.toLowerCase() !== row.nationality.toLowerCase()) {
            profilePatch.nationality = row.nationality;
            profileChanged = true;
          }
        }

        if (profileChanged) {
          await db
            .update(sailors)
            .set(profilePatch)
            .where(eq(sailors.id, sailorId));
          updatedProfiles++;
          // Keep in-memory list in sync for later rows
          sailorList = sailorList.map((s) =>
            s.id === sailorId
              ? {
                  ...s,
                  sailNumber: profilePatch.sailNumber ?? s.sailNumber,
                  dob: profilePatch.dob ?? s.dob,
                  club: profilePatch.club ?? s.club,
                  nationality: profilePatch.nationality ?? s.nationality,
                }
              : s
          );
        }

        // Rank is always integer; nett/total may be fractional (14.5)
        const rank = row.rank != null ? Math.round(row.rank) : 999;
        // Nett optional — only store when sheet has a nett value
        const nett = row.nett != null ? row.nett : null;
        const total = row.total != null ? row.total : null;

        await db
          .insert(regattaResults)
          .values({
            regattaId: reg.id,
            sailorId,
            rank,
            nettScore: nett,
            totalScore: total,
            isDns: false,
          })
          .onConflictDoUpdate({
            target: [regattaResults.sailorId, regattaResults.regattaId],
            set: {
              rank,
              nettScore: nett,
              totalScore: total,
              isDns: false,
              updatedAt: new Date(),
            },
          });
        matched++;

        if (hit && hit.how !== "exact") {
          try {
            await db.insert(sailorAliases).values({
              sailorId,
              aliasName: row.name,
            });
            aliasList.push({ sailorId, aliasName: row.name });
          } catch {
            /* exists */
          }
        }
      } catch (rowErr) {
        rowErrors++;
        const msg =
          rowErr instanceof Error ? rowErr.message : String(rowErr);
        if (errorSamples.length < 5) {
          errorSamples.push(`${row.name}: ${msg.slice(0, 160)}`);
        }
        // Common: integer column vs decimal nett before migration 003
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

    const needsNettMigration = errorSamples.some((e) =>
      /integer|real|numeric|type/i.test(e)
    );

    possibleDuplicates.sort((a, b) => b.similarity - a.similarity);

    const dupeNote =
      possibleDuplicates.length > 0
        ? ` · ${possibleDuplicates.length} possible duplicate name(s) flagged (60%+ similar) — review below / merge in Database.`
        : "";

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
      message:
        matched === 0 && rowErrors > 0
          ? `Import failed for all rows. ${
              needsNettMigration
                ? "Likely cause: nett_score is still INTEGER — run migration 003 in Supabase (allows 14.5 points)."
                : "See errors below."
            }`
          : `Imported ${reg.name}: ${matched}/${cleanRows.length} results saved (${created} guests auto-created, ${updatedProfiles} profiles updated from sail # / birth year / club / nationality). Fleet tags unchanged — admit series members as Silver (then Gold) in Database. ${rowErrors} row errors, ${unmatched.filter((u) => !u.error).length} unmatched.${dupeNote}`,
      regatta: reg,
      matched,
      created,
      updatedProfiles,
      unmatched,
      possibleDuplicates,
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
