import { NextResponse } from "next/server";
import { eq } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattaResults, regattas, sailorAliases, sailors } from "@/db/schema";
import {
  findSailorByName,
  suggestSailorByName,
} from "@/lib/nameMatch";
import { normalizeNationality } from "@/lib/seriesMembership";

function slugify(name: string) {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "");
}

function makeHandle(name: string) {
  const base = slugify(name) || "sailor";
  return `${base}-${Date.now().toString(36).slice(-4)}${Math.random()
    .toString(36)
    .slice(2, 5)}`;
}

function toNumber(v: unknown): number | null {
  if (v == null || v === "") return null;
  const n = typeof v === "number" ? v : Number(String(v).replace(/,/g, ""));
  return Number.isFinite(n) ? n : null;
}

/** Normalize sail number; empty → null (column optional). */
function normalizeSailNumber(v: unknown): string | null {
  if (v == null || v === "") return null;
  const s = String(v).trim().replace(/\s+/g, " ");
  if (!s || /^n\/?a$/i.test(s) || s === "-" || s === "—") return null;
  return s;
}

/** Optional text fields (club, nationality). */
function normalizeOptionalText(v: unknown): string | null {
  if (v == null || v === "") return null;
  const s = String(v).trim().replace(/\s+/g, " ");
  if (!s || /^n\/?a$/i.test(s) || s === "-" || s === "—") return null;
  return s;
}

/**
 * Accept full DOB (YYYY-MM-DD / Excel-ish) or birth year only (2013).
 * Year-only becomes YYYY-01-01. Empty → null (column optional).
 */
function normalizeDob(v: unknown): string | null {
  if (v == null || v === "") return null;
  if (typeof v === "number" && Number.isFinite(v)) {
    // Excel serial or plain year
    if (v >= 1990 && v <= 2035 && Number.isInteger(v)) {
      return `${v}-01-01`;
    }
    // Excel serial date
    const epoch = Date.UTC(1899, 11, 30);
    const d = new Date(epoch + v * 86400000);
    if (!Number.isNaN(d.getTime())) return d.toISOString().slice(0, 10);
    return null;
  }
  const s = String(v).trim();
  if (!s) return null;
  if (/^\d{4}$/.test(s)) {
    const y = Number(s);
    if (y >= 1990 && y <= 2035) return `${y}-01-01`;
    return null;
  }
  if (/^\d{4}-\d{2}-\d{2}/.test(s)) return s.slice(0, 10);
  const m = s.match(/^(\d{1,2})[\/\-.](\d{1,2})[\/\-.](\d{4})$/);
  if (m) {
    const [, a, b, y] = m;
    // Prefer D/M/Y common in SG; if first > 12 treat as D/M/Y
    const day = Number(a) > 12 ? a : b;
    const month = Number(a) > 12 ? b : a;
    return `${y}-${month.padStart(2, "0")}-${day.padStart(2, "0")}`;
  }
  const parsed = Date.parse(s);
  if (!Number.isNaN(parsed)) return new Date(parsed).toISOString().slice(0, 10);
  return null;
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

    for (const row of cleanRows) {
      try {
        let hit = findSailorByName(row.name, sailorList, aliasList);
        let sailorId: string | null = hit?.sailor.id ?? null;

        if (hit) {
          matchHow[hit.how] = (matchHow[hit.how] || 0) + 1;
        }

        if (!sailorId && createMissing) {
          const handle = makeHandle(row.name);
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

    return NextResponse.json({
      message:
        matched === 0 && rowErrors > 0
          ? `Import failed for all rows. ${
              needsNettMigration
                ? "Likely cause: nett_score is still INTEGER — run migration 003 in Supabase (allows 14.5 points)."
                : "See errors below."
            }`
          : `Imported ${reg.name}: ${matched}/${cleanRows.length} results saved (${created} guests auto-created, ${updatedProfiles} profiles updated from sail # / birth year / club / nationality). Fleet tags unchanged — admit series members as Silver (then Gold) in Database. ${rowErrors} row errors, ${unmatched.filter((u) => !u.error).length} unmatched.`,
      regatta: reg,
      matched,
      created,
      updatedProfiles,
      unmatched,
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
