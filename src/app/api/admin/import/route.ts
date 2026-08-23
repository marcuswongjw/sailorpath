import { NextResponse } from "next/server";
import { createHash } from "node:crypto";
import { and, eq, inArray, max, notInArray } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import {
  regattaRaceResults,
  regattaResults,
  regattas,
  sailorAliases,
  sailors,
} from "@/db/schema";
import type { OfficialRaceResultInput } from "@/types/raceResult";
import {
  buildSailorNameIndex,
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
import {
  isUnrecognizedCountry,
  nationalityFromAnySailNumber,
  normalizeGeography,
  normalizeNationalityCode,
} from "@/lib/countries";
import { trackUsage } from "@/lib/usage";
import { revalidatePublicRankings } from "@/lib/revalidatePublic";
import { adminLog, createAdminRequestId } from "@/lib/adminLog";
import type { ImportPossibleDuplicate } from "@/types/import";
import type {
  RegattaImportDiscrepancy,
  RegattaImportReview,
} from "@/types/import";
import {
  isAnyIlcaClass,
  ILCA_MIN_RACES_FOR_RANKING,
} from "@/lib/ilcaRanking";
import { normalizeImportGender } from "@/lib/gender";
import { birthYear as birthYearFromDob } from "@/lib/age";
import { MAX_IMPORT_ROWS } from "@/lib/importLimits";

export type { ImportPossibleDuplicate };

/** Allow long Optimist fleet imports on Vercel (default is often 10–15s). */
export const maxDuration = 60;

const MAX_DUPLICATE_FLAGS = 40;
const MAX_REVIEW_DETAILS = 500;

type ReviewUploadRow = {
  name: string;
  rank: number | null;
  nett: number | null;
  total: number | null;
  races: OfficialRaceResultInput[];
};

function sameImportValue(a: unknown, b: unknown): boolean {
  if (a == null && b == null) return true;
  if (typeof a === "number" || typeof b === "number") {
    const left = Number(a);
    const right = Number(b);
    return Number.isFinite(left) && Number.isFinite(right) && left === right;
  }
  return String(a) === String(b);
}

async function buildExistingRegattaReview(args: {
  existing: typeof regattas.$inferSelect;
  uploadedName: string;
  fleetSize: number;
  geography: string;
  ranking: boolean;
  raceCount: number | null;
  rows: ReviewUploadRow[];
}): Promise<RegattaImportReview> {
  const current = await db
    .select({
      resultId: regattaResults.id,
      sailorId: regattaResults.sailorId,
      sailorName: sailors.name,
      rank: regattaResults.rank,
      nett: regattaResults.nettScore,
      total: regattaResults.totalScore,
    })
    .from(regattaResults)
    .innerJoin(sailors, eq(regattaResults.sailorId, sailors.id))
    .where(eq(regattaResults.regattaId, args.existing.id));

  const sailorIds = current.map((row) => row.sailorId);
  const resultIds = current.map((row) => row.resultId);
  const [aliases, storedRaces] = await Promise.all([
    sailorIds.length
      ? db
          .select({ sailorId: sailorAliases.sailorId, aliasName: sailorAliases.aliasName })
          .from(sailorAliases)
          .where(inArray(sailorAliases.sailorId, sailorIds))
      : Promise.resolve([]),
    resultIds.length
      ? db
          .select({
            regattaResultId: regattaRaceResults.regattaResultId,
            raceNumber: regattaRaceResults.raceNumber,
            score: regattaRaceResults.score,
            scoringCode: regattaRaceResults.scoringCode,
            discarded: regattaRaceResults.discarded,
            rawValue: regattaRaceResults.rawValue,
          })
          .from(regattaRaceResults)
          .where(inArray(regattaRaceResults.regattaResultId, resultIds))
      : Promise.resolve([]),
  ]);

  const index = buildSailorNameIndex(
    current.map((row) => ({ id: row.sailorId, name: row.sailorName })),
    aliases
  );
  const currentBySailor = new Map(current.map((row) => [row.sailorId, row]));
  const racesByResult = new Map<string, typeof storedRaces>();
  for (const race of storedRaces) {
    const list = racesByResult.get(race.regattaResultId) || [];
    list.push(race);
    racesByResult.set(race.regattaResultId, list);
  }

  const discrepancies: RegattaImportDiscrepancy[] = [];
  const summary = {
    addedSailors: 0,
    removedSailors: 0,
    changedResults: 0,
    addedRaces: 0,
    removedRaces: 0,
    changedRaces: 0,
    metadataChanges: 0,
  };
  let totalDiscrepancies = 0;
  const add = (item: RegattaImportDiscrepancy) => {
    totalDiscrepancies++;
    if (discrepancies.length < MAX_REVIEW_DETAILS) discrepancies.push(item);
  };
  const metadata = [
    ["Name", args.existing.name, args.uploadedName],
    ["Fleet size", args.existing.totalFleetSize, args.fleetSize],
    ["Geography", args.existing.geography, args.geography],
    ["Ranking status", args.existing.countsForRanking, args.ranking],
    ["Race count", args.existing.raceCount, args.raceCount],
  ] as const;
  for (const [field, before, after] of metadata) {
    if (sameImportValue(before, after)) continue;
    summary.metadataChanges++;
    add({ kind: "metadata", field, before: String(before ?? "—"), after: String(after ?? "—") });
  }

  const matchedSailorIds = new Set<string>();
  for (const uploaded of args.rows) {
    const hit = findSailorByName(uploaded.name, index);
    const stored = hit ? currentBySailor.get(hit.sailor.id) : null;
    if (!stored) {
      summary.addedSailors++;
      add({ kind: "sailor-added", sailorName: uploaded.name, field: "Competitor", before: null, after: "Added" });
      continue;
    }
    matchedSailorIds.add(stored.sailorId);
    const aggregates = [
      ["Rank", stored.rank, uploaded.rank == null ? 999 : Math.round(uploaded.rank)],
      ["Nett", stored.nett, uploaded.nett],
      ["Total", stored.total, uploaded.total],
    ] as const;
    for (const [field, before, after] of aggregates) {
      if (sameImportValue(before, after)) continue;
      summary.changedResults++;
      add({ kind: "result", sailorName: stored.sailorName, field, before, after });
    }

    const oldRaces = new Map(
      (racesByResult.get(stored.resultId) || []).map((race) => [race.raceNumber, race])
    );
    const newRaces = new Map(uploaded.races.map((race) => [race.raceNumber, race]));
    const raceNumbers = new Set([...oldRaces.keys(), ...newRaces.keys()]);
    for (const raceNumber of [...raceNumbers].sort((a, b) => a - b)) {
      const before = oldRaces.get(raceNumber);
      const after = newRaces.get(raceNumber);
      if (!before && after) {
        summary.addedRaces++;
        add({ kind: "race-added", sailorName: stored.sailorName, field: `R${raceNumber}`, before: null, after: after.rawValue });
      } else if (before && !after) {
        summary.removedRaces++;
        add({ kind: "race-removed", sailorName: stored.sailorName, field: `R${raceNumber}`, before: before.rawValue, after: null });
      } else if (
        before &&
        after &&
        (!sameImportValue(before.score, after.score) ||
          !sameImportValue(before.scoringCode, after.scoringCode) ||
          before.discarded !== after.discarded)
      ) {
        summary.changedRaces++;
        add({ kind: "race-changed", sailorName: stored.sailorName, field: `R${raceNumber}`, before: before.rawValue, after: after.rawValue });
      }
    }
  }

  for (const stored of current) {
    if (matchedSailorIds.has(stored.sailorId)) continue;
    summary.removedSailors++;
    add({ kind: "sailor-removed", sailorName: stored.sailorName, field: "Competitor", before: "Present", after: "Missing from upload" });
  }

  const reviewToken = createHash("sha256")
    .update(JSON.stringify({ regattaId: args.existing.id, updatedAt: args.existing.updatedAt, discrepancies }))
    .digest("hex");
  return {
    reviewToken,
    regattaId: args.existing.id,
    regattaName: args.existing.name,
    uploadedName: args.uploadedName,
    discrepancies,
    truncated: totalDiscrepancies > discrepancies.length,
    summary,
  };
}

/** Pairwise similar names within the import sheet (60%+). Cap pairs for speed. */
function findWithinFileDuplicates(
  names: string[],
  minSimilarity = 0.6,
  maxPairs = MAX_DUPLICATE_FLAGS
): ImportPossibleDuplicate[] {
  const out: ImportPossibleDuplicate[] = [];
  const seen = new Set<string>();
  // Cap comparisons for large fleets — O(n²) Levenshtein was blowing past
  // serverless timeouts so the browser saw "Failed to fetch" after DB writes.
  const list = names.slice(0, 120);
  for (let i = 0; i < list.length; i++) {
    for (let j = i + 1; j < list.length; j++) {
      if (out.length >= maxPairs) {
        return out.sort((x, y) => y.similarity - x.similarity);
      }
      const a = list[i];
      const b = list[j];
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
  const requestId = createAdminRequestId();
  const t0 = Date.now();
  try {
    const auth = await requireSuperadmin();
    const body = await req.json();
    const {
      regattaName,
      eventDate,
      division,
      totalFleetSize,
      geography,
      boatClass,
      countsForRanking,
      raceCount: raceCountRaw,
      rows,
      createMissing = true,
      confirmedRegattaId,
      confirmedReviewToken,
    }: {
      regattaName: string;
      eventDate: string;
      division?: string;
      totalFleetSize?: number;
      /** ISO 3166-1 alpha-2 event country (default SG) */
      geography?: string;
      boatClass?: string;
      /** false = non-ranking (logbook / overseas / other) */
      countsForRanking?: boolean;
      /** Completed races; ILCA &lt; 3 → force non-ranking */
      raceCount?: number | null;
      rows: {
        name: string;
        rank: number | null;
        nett: number | null;
        total?: number | null;
        club?: string | null;
        school?: string | null;
        nationality?: string | null;
        gender?: string | null;
        sailNumber?: string | null;
        dob?: string | number | null;
        birthYear?: string | number | null;
        races?: OfficialRaceResultInput[];
      }[];
      createMissing?: boolean;
      /** Required only after reviewing discrepancies for an existing event. */
      confirmedRegattaId?: string | null;
      confirmedReviewToken?: string | null;
    } = body;

    if (!regattaName || !eventDate || !Array.isArray(rows)) {
      return NextResponse.json({ error: "Invalid payload" }, { status: 400 });
    }

    if (Array.isArray(rows) && rows.length > MAX_IMPORT_ROWS) {
      return NextResponse.json(
        {
          error: `Too many rows (${rows.length}). Import at most ${MAX_IMPORT_ROWS} results per upload — split the spreadsheet and import in batches.`,
          maxRows: MAX_IMPORT_ROWS,
          inputRows: rows.length,
        },
        { status: 400 }
      );
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
        const gender = normalizeImportGender(
          (r as { gender?: string | null }).gender
        );
        return {
          name: String(r.name || "").trim(),
          rank: toNumber(r.rank),
          nett: toNumber(r.nett),
          total: toNumber((r as { total?: number | null }).total),
          club: normalizeOptionalText(r.club),
          school: normalizeOptionalText(
            (r as { school?: string | null }).school
          ),
          nationalityRaw: normalizeOptionalText(r.nationality),
          nationality: normalizeNationalityCode(r.nationality),
          gender,
          sailNumber,
          dob,
          dobIsYearOnly,
          races: Array.isArray(r.races)
            ? r.races
                .filter(
                  (race) =>
                    Number.isInteger(Number(race.raceNumber)) &&
                    Number(race.raceNumber) > 0 &&
                    Number.isFinite(Number(race.score))
                )
                .slice(0, 100)
                .map((race) => ({
                  raceNumber: Number(race.raceNumber),
                  score: Number(race.score),
                  scoringCode: race.scoringCode
                    ? String(race.scoringCode).trim().toUpperCase().slice(0, 12)
                    : null,
                  discarded: Boolean(race.discarded),
                  rawValue: String(race.rawValue || race.score).trim().slice(0, 40),
                }))
            : [],
        };
      })
      .filter((r) => r.name.length > 0);

    if (!cleanRows.length) {
      return NextResponse.json(
        { error: "No named rows to import (check Name column)" },
        { status: 400 }
      );
    }

    const hasOfficialRaces = cleanRows.some((row) => row.races.length > 0);
    if (hasOfficialRaces) {
      try {
        await db.select({ id: regattaRaceResults.id }).from(regattaRaceResults).limit(1);
      } catch (error) {
        const message = error instanceof Error ? error.message : String(error);
        if (/regatta_race_results|does not exist|relation/i.test(message)) {
          return NextResponse.json(
            {
              error:
                "Official race-results storage is not installed yet. Run migration 044_official_race_results.sql in Supabase, then import again.",
              migration: "044_official_race_results.sql",
            },
            { status: 503 }
          );
        }
        throw error;
      }
    }

    const slug = `${slugify(regattaName)}-${eventDate}`;
    const fleetSize = totalFleetSize || cleanRows.length || 50;
    const geo =
      normalizeGeography(geography) ||
      String(geography || "SG")
        .trim()
        .toUpperCase()
        .slice(0, 8) ||
      "SG";
    const boat = String(boatClass || "Optimist").trim() || "Optimist";
    const raceCount =
      raceCountRaw == null ||
      (typeof raceCountRaw === "number" && !Number.isFinite(raceCountRaw))
        ? null
        : Math.max(0, Math.round(Number(raceCountRaw))) || null;
    let ranking =
      countsForRanking === false || countsForRanking === true
        ? countsForRanking
        : true;
    // ILCA: insufficient races → non-ranking for national series
    if (
      isAnyIlcaClass(boat) &&
      raceCount != null &&
      raceCount < ILCA_MIN_RACES_FOR_RANKING
    ) {
      ranking = false;
    }
    // Non-ranking events use NonRanking division tag for admin filters when not set
    const div =
      division ||
      (ranking === false
        ? isAnyIlcaClass(boat)
          ? "Open"
          : "NonRanking"
        : isAnyIlcaClass(boat)
          ? "Open"
          : "Gold");

    /**
     * Prefer matching an existing regatta by date + boat class + division so
     * re-import / title renames (e.g. "20230311 SYSC Gold" → "SYSC Gold (Mar 23)")
     * update the same row instead of creating a duplicate via a new slug.
     * Fall back to slug conflict upsert.
     */
    const sameDay = await db
      .select()
      .from(regattas)
      .where(
        and(
          eq(regattas.date, eventDate),
          eq(regattas.boatClass, boat),
          eq(regattas.division, div)
        )
      )
      .limit(5);

    const [slugMatch] =
      sameDay.length === 0
        ? await db
            .select()
            .from(regattas)
            .where(eq(regattas.slug, slug))
            .limit(1)
        : [];
    const existingTarget =
      sameDay.find((candidate) => candidate.slug === slug) ||
      (sameDay.length > 0 ? sameDay[0] : slugMatch);

    if (confirmedRegattaId && existingTarget?.id !== confirmedRegattaId) {
      return NextResponse.json(
        {
          error:
            "The matched regatta changed after review. Process the document again before updating.",
        },
        { status: 409 }
      );
    }

    if (existingTarget) {
      const review = await buildExistingRegattaReview({
        existing: existingTarget,
        uploadedName: regattaName,
        fleetSize,
        geography: geo,
        ranking,
        raceCount,
        rows: cleanRows,
      });
      if (
        review.discrepancies.length > 0 &&
        (confirmedRegattaId !== existingTarget.id ||
          confirmedReviewToken !== review.reviewToken)
      ) {
        return NextResponse.json({
          requiresConfirmation: true,
          message: `Review ${review.discrepancies.length}${review.truncated ? "+" : ""} discrepancy item(s) before updating “${existingTarget.name}”.`,
          review,
        });
      }
    }

    let reg: (typeof regattas.$inferSelect) | undefined;

    if (existingTarget && sameDay.length >= 1) {
      // Prefer exact slug match among same-day fleet; else sole match; else first
      const target = existingTarget;

      // Refresh slug to new title only if free (or already ours)
      let nextSlug = target.slug;
      if (target.name !== regattaName && slug !== target.slug) {
        const [slugTaken] = await db
          .select({ id: regattas.id })
          .from(regattas)
          .where(eq(regattas.slug, slug))
          .limit(1);
        if (!slugTaken || slugTaken.id === target.id) {
          nextSlug = slug;
        }
      }

      const [updated] = await db
        .update(regattas)
        .set({
          name: regattaName,
          slug: nextSlug,
          totalFleetSize: fleetSize,
          geography: geo,
          countsForRanking: ranking,
          raceCount,
          updatedAt: new Date(),
        })
        .where(eq(regattas.id, target.id))
        .returning();
      reg = updated;
    } else {
      const [upserted] = await db
        .insert(regattas)
        .values({
          name: regattaName,
          slug,
          date: eventDate,
          totalFleetSize: fleetSize,
          division: div,
          geography: geo,
          boatClass: boat,
          countsForRanking: ranking,
          raceCount,
        })
        .onConflictDoUpdate({
          target: regattas.slug,
          set: {
            name: regattaName,
            totalFleetSize: fleetSize,
            division: div,
            date: eventDate,
            geography: geo,
            boatClass: boat,
            countsForRanking: ranking,
            raceCount,
            updatedAt: new Date(),
          },
        })
        .returning();
      reg = upserted;
    }

    if (!reg) {
      return NextResponse.json(
        { error: "Failed to create or update regatta" },
        { status: 500 }
      );
    }

    let sailorList = await db
      .select({
        id: sailors.id,
        name: sailors.name,
        sailNumber: sailors.sailNumber,
        sailNumberIlca4: sailors.sailNumberIlca4,
        dob: sailors.dob,
        gender: sailors.gender,
        club: sailors.club,
        school: sailors.school,
        nationality: sailors.nationality,
        silverEntryDate: sailors.silverEntryDate,
        goldEntryDate: sailors.goldEntryDate,
      })
      .from(sailors);

    // Latest result dates: any event for club/school; class-specific for sail numbers.
    const latestDateBySailor = new Map<string, string>();
    const latestOptimistDateBySailor = new Map<string, string>();
    const latestIlca4DateBySailor = new Map<string, string>();
    try {
      const latestRows = await db
        .select({
          sailorId: regattaResults.sailorId,
          maxDate: max(regattas.date),
          boatClass: regattas.boatClass,
        })
        .from(regattaResults)
        .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
        .groupBy(regattaResults.sailorId, regattas.boatClass);
      for (const row of latestRows) {
        const d = String(row.maxDate || "").slice(0, 10);
        if (!row.sailorId || !/^\d{4}-\d{2}-\d{2}$/.test(d)) continue;
        const prev = latestDateBySailor.get(row.sailorId);
        if (!prev || d > prev) latestDateBySailor.set(row.sailorId, d);
        const bc = String(row.boatClass || "Optimist")
          .trim()
          .toLowerCase();
        const isIlca4 =
          bc === "ilca 4" ||
          bc === "ilca4" ||
          bc === "laser 4.7" ||
          bc === "laser4.7";
        if (isIlca4) {
          const p = latestIlca4DateBySailor.get(row.sailorId);
          if (!p || d > p) latestIlca4DateBySailor.set(row.sailorId, d);
        } else {
          const p = latestOptimistDateBySailor.get(row.sailorId);
          if (!p || d > p) latestOptimistDateBySailor.set(row.sailorId, d);
        }
      }
    } catch (e) {
      console.warn("import latest-date aggregate failed, continuing", e);
    }

    const {
      shouldApplyProfileFromRegatta,
      shouldApplySailNumberFromRegatta,
      buildProfilePatchFromRow,
    } = await import("@/lib/profileFromRegatta");
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
    /** Nationality changes / mismatches for admin review */
    const nationalityFlags: {
      sailorId: string;
      name: string;
      previous: string | null;
      imported: string | null;
      raw: string | null;
      action:
        | "updated"
        | "from_sail"
        | "mismatch_older"
        | "unrecognized"
        | "unchanged";
      detail: string;
    }[] = [];
    let nationalityUpdated = 0;
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
      gender: string | null;
      birthYear: number | null;
      nationality: string | null;
    }[] = [];
    const pendingAliases: { sailorId: string; aliasName: string }[] = [];
    const pendingOfficialRaces: {
      sailorId: string;
      races: OfficialRaceResultInput[];
    }[] = [];

    // Snapshot DB before creates so "vs-db" warnings use pre-import sailors
    const dbBeforeImport = sailorList.map((s) => ({
      id: s.id,
      name: s.name,
    }));
    // Rebuild when we create guests mid-import (see below)
    let nameIndex = buildSailorNameIndex(sailorList, aliasList);
    const beforeImportIndex = buildSailorNameIndex(dbBeforeImport);

    // Within-file similar names (before create — pure sheet check)
    possibleDuplicates.push(
      ...findWithinFileDuplicates(cleanRows.map((r) => r.name))
    );

    for (const row of cleanRows) {
      try {
        const hit = findSailorByName(row.name, nameIndex);
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
          const sug = suggestSailorByName(row.name, beforeImportIndex);
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
          const bcLower = boat.trim().toLowerCase();
          const createIsIlca4 =
            bcLower === "ilca 4" ||
            bcLower === "ilca4" ||
            bcLower === "laser 4.7" ||
            bcLower === "laser4.7";
          // Guests only: never auto-admit to SG series (no fleet / entry dates)
          const [createdSailor] = await db
            .insert(sailors)
            .values({
              name: row.name,
              handle,
              // Optimist primary number; ILCA 4 uses dedicated column when class is ILCA 4
              sailNumber: createIsIlca4
                ? "SGP 000"
                : row.sailNumber || "SGP 000",
              ...(createIsIlca4 && row.sailNumber
                ? { sailNumberIlca4: row.sailNumber }
                : {}),
              club: row.club || "N/A",
              ...(row.school ? { school: row.school } : {}),
              ...(row.nationality
                ? {
                    nationality: row.nationality,
                    nationalityFromSail: false,
                  }
                : row.nationalityRaw
                  ? {
                      nationality: normalizeNationalityCode(row.nationalityRaw),
                      nationalityFromSail: false,
                    }
                  : (() => {
                      const fromSail = nationalityFromAnySailNumber(
                        row.sailNumber
                      );
                      return fromSail
                        ? {
                            nationality: fromSail,
                            nationalityFromSail: true,
                          }
                        : {};
                    })()),
              ...(row.dob ? { dob: row.dob } : {}),
              ...(row.gender ? { gender: row.gender } : {}),
              // currentFleet / goldEntryDate / silverEntryDate intentionally omitted
            })
            .returning({
              id: sailors.id,
              name: sailors.name,
              sailNumber: sailors.sailNumber,
              sailNumberIlca4: sailors.sailNumberIlca4,
              dob: sailors.dob,
              gender: sailors.gender,
              club: sailors.club,
              school: sailors.school,
              nationality: sailors.nationality,
              nationalityFromSail: sailors.nationalityFromSail,
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
          // Keep indexed matcher in sync with guests created mid-import
          nameIndex = buildSailorNameIndex(sailorList, aliasList);
          created++;
          matchHow["created"] = (matchHow["created"] || 0) + 1;
        }

        if (!sailorId) {
          const sug = suggestSailorByName(row.name, beforeImportIndex);
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

        // Profile enrichment: club/school by any-class latest date;
        // sail # is class-specific (Optimist vs ILCA 4) for dual numbers under 15.
        const existing = sailorList.find((s) => s.id === sailorId);
        const applyClubSchool = shouldApplyProfileFromRegatta({
          regattaDate: eventDate,
          latestResultDate: latestDateBySailor.get(sailorId) || null,
        });
        const applySail = shouldApplySailNumberFromRegatta({
          regattaDate: eventDate,
          boatClass: boat,
          latestOptimistDate: latestOptimistDateBySailor.get(sailorId) || null,
          latestIlca4Date: latestIlca4DateBySailor.get(sailorId) || null,
        });
        const { patch: fieldPatch, changed: fieldChanged } =
          buildProfilePatchFromRow(
            {
              sailNumber: row.sailNumber,
              club: row.club,
              school: row.school,
              boatClass: boat,
            },
            {
              sailNumber: existing?.sailNumber,
              sailNumberIlca4: existing?.sailNumberIlca4,
              club: existing?.club,
              school: existing?.school,
            },
            applyClubSchool,
            applySail
          );
        const profilePatch: Record<string, unknown> = {
          updatedAt: new Date(),
          ...fieldPatch,
        };
        let profileChanged = fieldChanged.length > 0;

        // Gender + birth year/DOB: latest regatta wins (same rule as club/school)
        if (row.gender) {
          const curG = String(existing?.gender || "")
            .trim()
            .toUpperCase()
            .slice(0, 1);
          if (!curG) {
            // Always fill empty gender when sheet has it
            profilePatch.gender = row.gender;
            profileChanged = true;
            fieldChanged.push("gender");
          } else if (curG !== row.gender && applyClubSchool) {
            profilePatch.gender = row.gender;
            profileChanged = true;
            fieldChanged.push("gender");
          }
        }
        if (row.dob) {
          const curDob = existing?.dob ? String(existing.dob).slice(0, 10) : "";
          if (!curDob) {
            profilePatch.dob = row.dob;
            profileChanged = true;
            fieldChanged.push("dob");
          } else if (curDob !== row.dob && applyClubSchool) {
            if (
              row.dobIsYearOnly &&
              curDob.startsWith(row.dob.slice(0, 4))
            ) {
              /* keep full DOB for same year */
            } else {
              profilePatch.dob = row.dob;
              profileChanged = true;
              fieldChanged.push("dob");
            }
          } else if (!applyClubSchool && curDob !== row.dob) {
            // Older event with different BY — leave profile; no flag unless needed
          }
        }
        // Nationality: latest regatta wins (same date rule as club/school).
        // Flag mismatches so admin can correct wrong tags.
        // If still empty, derive from sail number country prefix (SGP 115 → SGP).
        if (row.nationalityRaw || row.nationality) {
          const curNorm =
            normalizeNationalityCode(existing?.nationality) ||
            (existing?.nationality
              ? String(existing.nationality).trim().toUpperCase()
              : null);
          const nextNat = row.nationality;
          const unrecognized =
            Boolean(row.nationalityRaw) &&
            (isUnrecognizedCountry(row.nationalityRaw) || !nextNat);

          if (unrecognized) {
            nationalityFlags.push({
              sailorId,
              name: row.name,
              previous: curNorm,
              imported: nextNat,
              raw: row.nationalityRaw,
              action: "unrecognized",
              detail: `Could not map “${row.nationalityRaw}” to a country list code — set nationality manually if needed.`,
            });
          } else if (nextNat) {
            const same =
              curNorm &&
              curNorm.toLowerCase() === nextNat.toLowerCase();
            if (!same) {
              if (applyClubSchool) {
                // Latest regatta nationality input wins (most accurate)
                profilePatch.nationality = nextNat;
                profilePatch.nationalityFromSail = false;
                profileChanged = true;
                fieldChanged.push("nationality");
                nationalityUpdated++;
                nationalityFlags.push({
                  sailorId,
                  name: existing?.name || row.name,
                  previous: curNorm,
                  imported: nextNat,
                  raw: row.nationalityRaw,
                  action: "updated",
                  detail: curNorm
                    ? `Updated nationality ${curNorm} → ${nextNat} (latest regatta ${String(eventDate).slice(0, 10)}).`
                    : `Set nationality ${nextNat} from regatta results.`,
                });
              } else {
                // Older regatta than current profile latest — do not overwrite
                nationalityFlags.push({
                  sailorId,
                  name: existing?.name || row.name,
                  previous: curNorm,
                  imported: nextNat,
                  raw: row.nationalityRaw,
                  action: "mismatch_older",
                  detail: `Import has ${nextNat} but profile keeps ${curNorm || "—"} (this event is older than latest result).`,
                });
              }
            }
          }
        }

        // If nationality still empty (no import column), derive from sail # prefix.
        {
          const curAfter =
            normalizeNationalityCode(
              (profilePatch.nationality as string) || existing?.nationality
            ) || null;
          if (!curAfter) {
            const fromSail = nationalityFromAnySailNumber(
              (profilePatch.sailNumber as string) || row.sailNumber,
              (profilePatch.sailNumberIlca4 as string) ||
                existing?.sailNumberIlca4,
              existing?.sailNumber
            );
            if (fromSail) {
              profilePatch.nationality = fromSail;
              profilePatch.nationalityFromSail = true;
              profileChanged = true;
              if (!fieldChanged.includes("nationality")) {
                fieldChanged.push("nationality");
              }
              nationalityUpdated++;
              nationalityFlags.push({
                sailorId,
                name: existing?.name || row.name,
                previous: null,
                imported: fromSail,
                raw: row.sailNumber || existing?.sailNumber || null,
                action: "from_sail",
                detail: `Set nationality ${fromSail} from sail number (flagged for admin review).`,
              });
            }
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
              (f === "sailNumber" ||
                f === "sailNumberIlca4" ||
                f === "club" ||
                f === "school" ||
                f === "nationality") &&
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
                  sailNumberIlca4:
                    (profilePatch.sailNumberIlca4 as string) ??
                    s.sailNumberIlca4,
                  dob: (profilePatch.dob as string) ?? s.dob,
                  club: (profilePatch.club as string) ?? s.club,
                  school: (profilePatch.school as string) ?? s.school,
                  nationality:
                    (profilePatch.nationality as string) ?? s.nationality,
                  gender: (profilePatch.gender as string) ?? s.gender,
                }
              : s
          );
          const ed = String(eventDate).slice(0, 10);
          const prevL = latestDateBySailor.get(sailorId);
          if (!prevL || ed >= prevL) latestDateBySailor.set(sailorId, ed);
          const bc = boat.trim().toLowerCase();
          const isIlca4 =
            bc === "ilca 4" ||
            bc === "ilca4" ||
            bc === "laser 4.7" ||
            bc === "laser4.7";
          if (isIlca4) {
            const p = latestIlca4DateBySailor.get(sailorId);
            if (!p || ed >= p) latestIlca4DateBySailor.set(sailorId, ed);
          } else {
            const p = latestOptimistDateBySailor.get(sailorId);
            if (!p || ed >= p) latestOptimistDateBySailor.set(sailorId, ed);
          }
        }
        affectedSailorIds.add(sailorId);

        // Rank is always integer; nett/total may be fractional (14.5)
        const rank = row.rank != null ? Math.round(row.rank) : 999;
        // Nett optional — only store when sheet has a nett value
        const nett = row.nett != null ? row.nett : null;
        const total = row.total != null ? row.total : null;

        // Denormalize gender, birth year, nationality onto this result
        // (after any profile updates from this row)
        const sailorNow = sailorList.find((s) => s.id === sailorId);
        const resultGender =
          row.gender ||
          (sailorNow?.gender
            ? String(sailorNow.gender).trim().toUpperCase().slice(0, 1)
            : null);
        const gNorm =
          resultGender === "M" || resultGender === "F" ? resultGender : null;
        const by =
          birthYearFromDob(sailorNow?.dob) ??
          (row.dob ? Number(String(row.dob).slice(0, 4)) : null);
        const birthYear =
          by != null && Number.isFinite(by) && by >= 1990 && by <= 2035
            ? Math.round(by)
            : null;
        const resultNat =
          row.nationality ||
          normalizeNationalityCode(sailorNow?.nationality) ||
          null;

        // Collect for batch upsert (avoids N round-trips that timed out serverless)
        pendingResults.push({
          regattaId: reg.id,
          sailorId,
          rank,
          nettScore: nett,
          totalScore: total,
          isDns: false,
          gender: gNorm,
          birthYear,
          nationality: resultNat,
        });
        if (row.races.length) {
          pendingOfficialRaces.push({ sailorId, races: row.races });
        }
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

    // Parallel upsert results in chunks (sequential N inserts timed out serverless
    // after DB writes completed — browser saw "Failed to fetch").
    if (pendingResults.length) {
      const CHUNK = 15;
      for (let i = 0; i < pendingResults.length; i += CHUNK) {
        const chunk = pendingResults.slice(i, i + CHUNK);
        await Promise.all(
          chunk.map((r) =>
            db
              .insert(regattaResults)
              .values(r)
              .onConflictDoUpdate({
                target: [regattaResults.sailorId, regattaResults.regattaId],
                set: {
                  rank: r.rank,
                  nettScore: r.nettScore,
                  totalScore: r.totalScore,
                  isDns: r.isDns,
                  gender: r.gender,
                  birthYear: r.birthYear,
                  nationality: r.nationality,
                  updatedAt: new Date(),
                },
              })
          )
        );
      }
    }

    const authoritativeReplace =
      confirmedRegattaId === reg.id && rowErrors === 0 && unmatched.length === 0;
    let removedRaceRows = 0;
    let removedResultRows = 0;

    if (pendingResults.length && (pendingOfficialRaces.length || authoritativeReplace)) {
      const sailorIds = pendingResults.map((item) => item.sailorId);
      const storedResults = await db
        .select({ id: regattaResults.id, sailorId: regattaResults.sailorId })
        .from(regattaResults)
        .where(
          and(
            eq(regattaResults.regattaId, reg.id),
            inArray(regattaResults.sailorId, sailorIds)
          )
        );
      const resultIdBySailor = new Map(
        storedResults.map((result) => [result.sailorId, result.id])
      );
      const officialRows = pendingOfficialRaces.flatMap((item) => {
        const regattaResultId = resultIdBySailor.get(item.sailorId);
        if (!regattaResultId) return [];
        return item.races.map((race) => ({ ...race, regattaResultId }));
      });
      const CHUNK = 25;
      for (let i = 0; i < officialRows.length; i += CHUNK) {
        await Promise.all(
          officialRows.slice(i, i + CHUNK).map((race) =>
            db
              .insert(regattaRaceResults)
              .values(race)
              .onConflictDoUpdate({
                target: [
                  regattaRaceResults.regattaResultId,
                  regattaRaceResults.raceNumber,
                ],
                set: {
                  score: race.score,
                  scoringCode: race.scoringCode,
                  discarded: race.discarded,
                  rawValue: race.rawValue,
                  updatedAt: new Date(),
                },
              })
          )
        );
      }
      if (authoritativeReplace && storedResults.length) {
        const racesBySailor = new Map(
          pendingOfficialRaces.map((item) => [
            item.sailorId,
            new Set(item.races.map((race) => race.raceNumber)),
          ])
        );
        const sailorByResultId = new Map(
          storedResults.map((result) => [result.id, result.sailorId])
        );
        const currentOfficialRows = await db
          .select({
            id: regattaRaceResults.id,
            regattaResultId: regattaRaceResults.regattaResultId,
            raceNumber: regattaRaceResults.raceNumber,
          })
          .from(regattaRaceResults)
          .where(
            inArray(
              regattaRaceResults.regattaResultId,
              storedResults.map((result) => result.id)
            )
          );
        const obsoleteRaceIds = currentOfficialRows
          .filter((race) => {
            const sailorId = sailorByResultId.get(race.regattaResultId);
            return !sailorId || !racesBySailor.get(sailorId)?.has(race.raceNumber);
          })
          .map((race) => race.id);
        if (obsoleteRaceIds.length) {
          const removed = await db
            .delete(regattaRaceResults)
            .where(inArray(regattaRaceResults.id, obsoleteRaceIds))
            .returning({ id: regattaRaceResults.id });
          removedRaceRows = removed.length;
        }
      }
    }

    if (authoritativeReplace && pendingResults.length) {
      const keptSailorIds = pendingResults.map((result) => result.sailorId);
      const removed = await db
        .delete(regattaResults)
        .where(
          and(
            eq(regattaResults.regattaId, reg.id),
            notInArray(regattaResults.sailorId, keptSailorIds)
          )
        )
        .returning({ id: regattaResults.id });
      removedResultRows = removed.length;
    }

    // Best-effort alias inserts in parallel chunks
    if (pendingAliases.length) {
      const seenAlias = new Set<string>();
      const unique = pendingAliases.filter((a) => {
        const k = `${a.sailorId}|${a.aliasName.toLowerCase()}`;
        if (seenAlias.has(k)) return false;
        seenAlias.add(k);
        return true;
      });
      const CHUNK = 15;
      for (let i = 0; i < unique.length; i += CHUNK) {
        const chunk = unique.slice(i, i + CHUNK);
        await Promise.all(
          chunk.map(async (a) => {
            try {
              await db.insert(sailorAliases).values({
                sailorId: a.sailorId,
                aliasName: a.aliasName,
              });
            } catch {
              /* exists */
            }
          })
        );
      }
    }

    // Stamp gender, birth year, nationality onto ALL results for sailors who have them
    // (source of truth: sailor profile after this import's updates)
    let resultsDemographicsUpdated = 0;
    const affectedIds = [...affectedSailorIds];
    if (affectedIds.length) {
      try {
        for (const sid of affectedIds) {
          const s = sailorList.find((x) => x.id === sid);
          if (!s) continue;
          const g = String(s.gender || "")
            .trim()
            .toUpperCase()
            .slice(0, 1);
          const gender = g === "M" || g === "F" ? g : null;
          const by = birthYearFromDob(s.dob);
          const nat = normalizeNationalityCode(s.nationality);
          if (!gender && by == null && !nat) continue;
          const patch: {
            gender?: string | null;
            birthYear?: number | null;
            nationality?: string | null;
            updatedAt: Date;
          } = { updatedAt: new Date() };
          if (gender) patch.gender = gender;
          if (by != null) patch.birthYear = by;
          if (nat) patch.nationality = nat;
          const updated = await db
            .update(regattaResults)
            .set(patch)
            .where(eq(regattaResults.sailorId, sid))
            .returning({ id: regattaResults.id });
          resultsDemographicsUpdated += updated.length;
        }
      } catch (e) {
        console.warn("result demographics stamp after import", e);
      }
    }

    // Recompute silver_entry_date — only for sailors touched by this import
    let silverUpdated = 0;
    if (affectedIds.length) {
      try {
        const silverLinks = await db
          .select({
            sailorId: regattaResults.sailorId,
            regattaDate: regattas.date,
            division: regattas.division,
            countsForRanking: regattas.countsForRanking,
            boatClass: regattas.boatClass,
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
            boatClass: l.boatClass,
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

    // Single audit summary (not N per-row inserts — was adding latency)
    if (matched > 0 || created > 0 || updatedProfiles > 0) {
      void logAdminChange({
        action: "import.regatta",
        entityType: "regatta",
        entityId: reg.id,
        entityLabel: reg.name,
        summary: `Imported ${matched}/${cleanRows.length} results for ${regattaName} (${eventDate}, ${boat}, ${geo}, ${ranking ? "ranking" : "non-ranking"}); ${created} guests, ${updatedProfiles} profiles, ${nationalityUpdated} nationality, ${resultsDemographicsUpdated} result gender/BY stamps, ${silverUpdated} silver dates, ${removedResultRows} obsolete results removed`,
        details: {
          matched,
          created,
          updatedProfiles,
          nationalityUpdated,
          resultsDemographicsUpdated,
          silverUpdated,
          rowErrors,
          authoritativeReplace,
          removedResultRows,
          removedRaceRows,
          profileFields: profileChangeFields,
          nationalityFlagCount: nationalityFlags.length,
        },
        source: "/api/admin/import",
      });
    }

    const needsNettMigration = errorSamples.some((e) =>
      /integer|real|numeric|type/i.test(e)
    );

    possibleDuplicates.sort((a, b) => b.similarity - a.similarity);
    const dupeFlags = possibleDuplicates.slice(0, MAX_DUPLICATE_FLAGS);

    const dupeNote =
      dupeFlags.length > 0
        ? ` · ${possibleDuplicates.length} possible duplicate name(s) flagged (60%+ similar) — review below / merge in Database.`
        : "";

    const natNote =
      nationalityFlags.length > 0
        ? ` · ${nationalityUpdated} nationality update(s), ${nationalityFlags.length} nationality flag(s) to review.`
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
        nationalityUpdated,
      },
    });

    // Bust ISR + shared ranking caches so Gold/Silver/ILCA refresh promptly.
    if (matched > 0) {
      revalidatePublicRankings(`import:${reg.id}`);
    }

    adminLog({
      requestId,
      action: "import.regatta",
      path: "/api/admin/import",
      role: auth.role,
      actorUserId: auth.userId,
      actorEmail: auth.email,
      entityType: "regatta",
      entityId: reg.id,
      entityLabel: reg.name,
      outcome: matched > 0 ? "ok" : "error",
      ms: Date.now() - t0,
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
          : `Imported ${reg.name}: ${matched}/${cleanRows.length} results saved (${created} guests auto-created, ${updatedProfiles} profiles updated when event is latest, ${nationalityUpdated} nationality from latest results, gender/birth year stamped on ${resultsDemographicsUpdated} result row(s), ${silverUpdated} silver entry dates recomputed${authoritativeReplace ? `, ${removedResultRows} obsolete result row(s) removed` : ""}). Fleet tags unchanged — admit series members as Silver (then Gold) in Database. ${rowErrors} row errors, ${unmatched.filter((u) => !u.error).length} unmatched.${dupeNote}${natNote}`,
      regatta: reg,
      matched,
      created,
      updatedProfiles,
      nationalityUpdated,
      nationalityFlags: nationalityFlags.slice(0, 80),
      resultsDemographicsUpdated,
      silverUpdated,
      unmatched: unmatched.slice(0, 80),
      possibleDuplicates: dupeFlags,
      inputRows: cleanRows.length,
      authoritativeReplace,
      removedResultRows,
      removedRaceRows,
      rowErrors,
      matchHow,
      errorSamples,
      hint: needsNettMigration
        ? "Supabase SQL Editor → run: ALTER TABLE public.regatta_results ALTER COLUMN nett_score TYPE real USING nett_score::real;"
        : undefined,
    });
  } catch (e) {
    adminLog({
      requestId,
      action: "import.regatta",
      path: "/api/admin/import",
      outcome: "error",
      ms: Date.now() - t0,
      error: e instanceof Error ? e.message : String(e),
    });
    console.error(e);
    return jsonError(e);
  }
}
