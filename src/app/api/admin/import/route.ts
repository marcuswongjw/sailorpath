import { NextResponse } from "next/server";
import { createHash, randomUUID } from "node:crypto";
import { and, eq, inArray, max, notInArray, or, sql } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db, ensureCoreSchema } from "@/db";
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
  cleanOptimistSailNumber,
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
import { isAnyIlcaClass, ILCA_MIN_RACES_FOR_RANKING } from "@/lib/ilcaRanking";
import { normalizeImportGender } from "@/lib/gender";
import { birthYear as birthYearFromDob } from "@/lib/age";
import { MAX_IMPORT_ROWS } from "@/lib/importLimits";
import { NEW_IMPORT_TARGET, resolveImportTarget } from "@/lib/importTarget";
import { asPositiveInteger, asRank } from "@/lib/validate";

export type { ImportPossibleDuplicate };

/** Allow long Optimist fleet imports on Vercel (default is often 10–15s). */
export const maxDuration = 300;

const MAX_DUPLICATE_FLAGS = 40;
const MAX_REVIEW_DETAILS = 500;

type ReviewUploadRow = {
  name: string;
  rank: number | null;
  nett: number | null;
  total: number | null;
  isDns: boolean;
  races: OfficialRaceResultInput[];
};

type ImportNationalityFlag = {
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
};

type ImportUnmatchedRow = {
  rawName: string;
  rank: number | null;
  nett: number | null;
  suggestedId: string | null;
  suggestedName: string | null;
  similarity: number;
  error?: string;
};

type ImportTransactionOutcome = {
  reg: typeof regattas.$inferSelect;
  matched: number;
  created: number;
  updatedProfiles: number;
  nationalityUpdated: number;
  resultsDemographicsUpdated: number;
  silverUpdated: number;
  rowErrors: number;
  unmatched: ImportUnmatchedRow[];
  possibleDuplicates: ImportPossibleDuplicate[];
  nationalityFlags: ImportNationalityFlag[];
  matchHow: Record<string, number>;
  errorSamples: string[];
  authoritativeReplace: boolean;
  removedResultRows: number;
  removedRaceRows: number;
  profileChangeFields: string[];
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

class ImportConflictError extends Error {}

async function buildExistingRegattaReview(args: {
  existing: typeof regattas.$inferSelect;
  uploadedName: string;
  fleetSize: number;
  geography: string;
  ranking: boolean;
  raceCount: number | null;
  rows: ReviewUploadRow[];
}, connection: Pick<typeof db, "select"> = db): Promise<RegattaImportReview> {
  const db = connection;
  const current = await db
    .select({
      resultId: regattaResults.id,
      sailorId: regattaResults.sailorId,
      sailorName: sailors.name,
      rank: regattaResults.rank,
      nett: regattaResults.nettScore,
      total: regattaResults.totalScore,
      isDns: regattaResults.isDns,
    })
    .from(regattaResults)
    .innerJoin(sailors, eq(regattaResults.sailorId, sailors.id))
    .where(eq(regattaResults.regattaId, args.existing.id));

  const sailorIds = current.map((row) => row.sailorId);
  const resultIds = current.map((row) => row.resultId);
  const [aliases, storedRaces] = await Promise.all([
    sailorIds.length
      ? db
          .select({
            sailorId: sailorAliases.sailorId,
            aliasName: sailorAliases.aliasName,
          })
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
    add({
      kind: "metadata",
      field,
      before: String(before ?? "—"),
      after: String(after ?? "—"),
    });
  }

  const matchedSailorIds = new Set<string>();
  for (const uploaded of args.rows) {
    const hit = findSailorByName(uploaded.name, index);
    const stored = hit ? currentBySailor.get(hit.sailor.id) : null;
    if (!stored) {
      summary.addedSailors++;
      add({
        kind: "sailor-added",
        sailorName: uploaded.name,
        field: "Competitor",
        before: null,
        after: "Added",
      });
      continue;
    }
    matchedSailorIds.add(stored.sailorId);
    const aggregates = [
      [
        "Rank",
        stored.rank,
        uploaded.rank == null ? 999 : Math.round(uploaded.rank),
      ],
      ["Nett", stored.nett, uploaded.nett],
      ["Total", stored.total, uploaded.total],
      ["DNS", stored.isDns ? "Yes" : "No", uploaded.isDns ? "Yes" : "No"],
    ] as const;
    for (const [field, before, after] of aggregates) {
      if (sameImportValue(before, after)) continue;
      summary.changedResults++;
      add({
        kind: "result",
        sailorName: stored.sailorName,
        field,
        before: before == null ? null : String(before),
        after: after == null ? null : String(after),
      });
    }

    const currentRaces = new Map(
      (racesByResult.get(stored.resultId) || []).map((race) => [
        race.raceNumber,
        race,
      ])
    );
    const uploadedRaces = new Map(
      uploaded.races.map((race) => [race.raceNumber, race])
    );
    for (const [raceNumber, race] of uploadedRaces) {
      const existingRace = currentRaces.get(raceNumber);
      if (!existingRace) {
        summary.addedRaces++;
        add({
          kind: "race-added",
          sailorName: stored.sailorName,
          field: `Race ${raceNumber}`,
          before: null,
          after: race.rawValue,
        });
        continue;
      }
      const scoreChanged = !sameImportValue(existingRace.score, race.score);
      const codeChanged = !sameImportValue(
        existingRace.scoringCode,
        race.scoringCode
      );
      const discardChanged = existingRace.discarded !== race.discarded;
      if (scoreChanged || codeChanged || discardChanged) {
        summary.changedRaces++;
        add({
          kind: "race-changed",
          sailorName: stored.sailorName,
          field: `Race ${raceNumber}`,
          before: existingRace.rawValue,
          after: race.rawValue,
        });
      }
    }
    for (const [raceNumber, race] of currentRaces) {
      if (!uploadedRaces.has(raceNumber)) {
        summary.removedRaces++;
        add({
          kind: "race-removed",
          sailorName: stored.sailorName,
          field: `Race ${raceNumber}`,
          before: race.rawValue,
          after: null,
        });
      }
    }
  }

  for (const stored of current) {
    if (!matchedSailorIds.has(stored.sailorId)) {
      summary.removedSailors++;
      add({
        kind: "sailor-removed",
        sailorName: stored.sailorName,
        field: "Competitor",
        before: "Present",
        after: null,
      });
    }
  }

  const reviewToken = createHash("sha256")
    .update(
      JSON.stringify({
        regattaId: args.existing.id,
        updatedAt: args.existing.updatedAt.toISOString(),
        totalDiscrepancies,
        summary,
        sample: discrepancies.slice(0, 50),
      })
    )
    .digest("hex");

  return {
    regattaId: args.existing.id,
    regattaName: args.existing.name,
    uploadedName: args.uploadedName,
    truncated: totalDiscrepancies > discrepancies.length,
    summary,
    discrepancies,
    reviewToken,
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
      const key = [a, b]
        .map((n) => n.toLowerCase())
        .sort()
        .join("|");
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
  let lastT = t0;
  const stageTimings: Record<string, number> = {};

  const recordStage = (stage: string) => {
    const now = Date.now();
    const duration = now - lastT;
    stageTimings[stage] = duration;
    lastT = now;
    console.info(
      `[admin/import] [${requestId}] stage=${stage} durationMs=${duration} totalMs=${
        now - t0
      }`
    );
    return duration;
  };

  try {
    const auth = await requireSuperadmin();
    if (typeof ensureCoreSchema === "function") {
      await ensureCoreSchema();
    }
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
      geography?: string;
      boatClass?: string;
      countsForRanking?: boolean;
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
        isDns?: boolean;
        races?: OfficialRaceResultInput[];
      }[];
      createMissing?: boolean;
      confirmedRegattaId?: string | null;
      confirmedReviewToken?: string | null;
    } = body;

    if (!regattaName || !eventDate || !Array.isArray(rows)) {
      return NextResponse.json({ error: "Invalid payload" }, { status: 400 });
    }

    if (Array.isArray(rows) && rows.length > MAX_IMPORT_ROWS) {
      return NextResponse.json(
        {
          error: `Too many rows (${rows.length}). Import at most ${MAX_IMPORT_ROWS} results; do not split an existing event into replacement uploads.`,
          maxRows: MAX_IMPORT_ROWS,
          inputRows: rows.length,
        },
        { status: 400 }
      );
    }

    const parsedRows = rows
      .map((r) => {
        const sailNumber = normalizeSailNumber(r.sailNumber);
        const fullDob = normalizeDob(r.dob);
        const yearOnlyDob = !fullDob ? normalizeDob(r.birthYear) : null;
        const birthYearHint =
          r.birthYear != null && r.birthYear !== ""
            ? normalizeDob(r.birthYear)
            : null;
        const dob = fullDob || yearOnlyDob;
        const dobIsYearOnly = Boolean(
          yearOnlyDob || (birthYearHint && fullDob && fullDob === birthYearHint)
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
          isDns: r.isDns === true,
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
                  rawValue: String(race.rawValue || race.score)
                    .trim()
                    .slice(0, 40),
                }))
            : [],
        };
      })
      .filter((r) => r.name.length > 0);

    if (!parsedRows.length) {
      return NextResponse.json(
        { error: "No named rows to import (check Name column)" },
        { status: 400 }
      );
    }

    const cleanRows: Array<(typeof parsedRows)[number] & { rank: number }> = [];
    for (const [index, row] of parsedRows.entries()) {
      const rank = asRank(row.rank, `row ${index + 1} rank`);
      if (!rank.ok) {
        return NextResponse.json({ error: rank.error }, { status: 400 });
      }
      cleanRows.push({ ...row, rank: rank.value });
    }

    const fleetSizeInput =
      totalFleetSize == null ? cleanRows.length : totalFleetSize;
    const fleetSizeResult = asPositiveInteger(fleetSizeInput, "totalFleetSize");
    if (!fleetSizeResult.ok) {
      return NextResponse.json(
        { error: fleetSizeResult.error },
        { status: 400 }
      );
    }
    const fleetSize = fleetSizeResult.value;

    const hasOfficialRaces = cleanRows.some((row) => row.races.length > 0);
    if (hasOfficialRaces) {
      try {
        await db
          .select({ id: regattaRaceResults.id })
          .from(regattaRaceResults)
          .limit(1);
      } catch (error) {
        const message = error instanceof Error ? error.message : String(error);
        if (/regatta_race_results|does not exist|relation/i.test(message)) {
          return NextResponse.json(
            {
              error:
                "Race-score storage is temporarily unavailable. Contact platform support before retrying this import.",
            },
            { status: 503 }
          );
        }
        throw error;
      }
    }

    const slug = `${slugify(regattaName)}-${eventDate}`;
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
    if (
      isAnyIlcaClass(boat) &&
      raceCount != null &&
      raceCount < ILCA_MIN_RACES_FOR_RANKING
    ) {
      ranking = false;
    }
    const div =
      division ||
      (ranking === false
        ? isAnyIlcaClass(boat)
          ? "Open"
          : "NonRanking"
        : isAnyIlcaClass(boat)
        ? "Open"
        : "Gold");

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
      .limit(50);

    const [slugMatch] = await db
      .select()
      .from(regattas)
      .where(eq(regattas.slug, slug))
      .limit(1);
    const targetResolution = resolveImportTarget({
      sameDay,
      incomingSlug: slug,
      slugMatch: slugMatch || null,
      selectedId: confirmedRegattaId,
    });
    if (targetResolution.kind === "selection-required") {
      return NextResponse.json(
        {
          error:
            "Same-day regattas match this import. Select an event to update or create a separate event.",
          requiresTargetSelection: true,
          candidates: sameDay.map((candidate) => ({
            id: candidate.id,
            name: candidate.name,
            slug: candidate.slug,
            date: String(candidate.date),
            division: candidate.division,
            boatClass: candidate.boatClass,
          })),
        },
        { status: 409 }
      );
    }
    if (targetResolution.kind === "selected-target-not-found") {
      return NextResponse.json(
        {
          error:
            "The selected regatta is no longer a valid same-day match. Process the document again before updating.",
        },
        { status: 409 }
      );
    }
    const existingTarget =
      targetResolution.kind === "target" ? targetResolution.target : null;

    if (
      confirmedRegattaId &&
      confirmedRegattaId !== NEW_IMPORT_TARGET &&
      existingTarget?.id !== confirmedRegattaId
    ) {
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
          message: `Review ${review.discrepancies.length}${
            review.truncated ? "+" : ""
          } discrepancy item(s) before updating “${existingTarget.name}”.`,
          review,
        });
      }
    }

    recordStage("validation");

    const wantsStream = req.headers.get("accept")?.includes("application/x-ndjson");

    const runImportProcess = async (
      onProgress?: (stage: string, progress: number, message: string) => Promise<void>
    ) => {
      await onProgress?.("candidates", 20, "Loading candidate competitor records from database…");

      const {
        shouldApplyProfileFromRegatta,
        shouldApplySailNumberFromRegatta,
        buildProfilePatchFromRow,
      } = await import("@/lib/profileFromRegatta");
      const { deriveAllSilverEntryDates } = await import(
        "@/lib/deriveFleetEntryDates"
      );

      // 1. Candidate sailor & alias query restricted to imported workbook data
      const cleanRowNames = [
        ...new Set(cleanRows.map((r) => r.name.trim()).filter(Boolean)),
      ];
      const cleanLowerNames = [
        ...new Set(cleanRowNames.map((n) => n.toLowerCase())),
      ];
      const cleanSailNumbers = [
        ...new Set(
          cleanRows
            .map((r) => normalizeSailNumber(r.sailNumber))
            .filter((s): s is string => Boolean(s))
        ),
      ];
      const cleanTokens = [
        ...new Set(
          cleanRowNames
            .flatMap((name) =>
              name
                .toLowerCase()
                .replace(/[^a-z0-9s'-]/g, " ")
                .split(/[s'-]+/)
            )
            .filter((token) => token.length >= 2)
        ),
      ];

      const matchingAliases =
        cleanLowerNames.length > 0
          ? await db
              .select({
                sailorId: sailorAliases.sailorId,
                aliasName: sailorAliases.aliasName,
              })
              .from(sailorAliases)
              .where(inArray(sql`lower(${sailorAliases.aliasName})`, cleanLowerNames))
          : [];

      const candidateSailorIds = new Set<string>(
        matchingAliases.map((a) => a.sailorId)
      );
      if (existingTarget) {
        const existingResults = await db
          .select({ sailorId: regattaResults.sailorId })
          .from(regattaResults)
          .where(eq(regattaResults.regattaId, existingTarget.id));
        for (const r of existingResults) candidateSailorIds.add(r.sailorId);
      }

      const candidateConditions = [];
      if (cleanLowerNames.length > 0) {
        candidateConditions.push(
          inArray(sql`lower(${sailors.name})`, cleanLowerNames)
        );
      }
      if (cleanSailNumbers.length > 0) {
        candidateConditions.push(
          inArray(sailors.sailNumber, cleanSailNumbers)
        );
        candidateConditions.push(
          inArray(sailors.sailNumberIlca4, cleanSailNumbers)
        );
      }
      if (candidateSailorIds.size > 0) {
        candidateConditions.push(
          inArray(sailors.id, [...candidateSailorIds])
        );
      }
      if (cleanTokens.length > 0) {
        const tokenPatterns = cleanTokens
          .slice(0, 50)
          .map((t) => `%${t.toLowerCase()}%`);
        candidateConditions.push(
          sql`lower(${sailors.name}) LIKE ANY(ARRAY[${sql.join(
            tokenPatterns.map((p) => sql`${p}`),
            sql`, `
          )}])`
        );
      }

      let sailorList =
        candidateConditions.length > 0
          ? await db
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
                nationalityFromSail: sailors.nationalityFromSail,
                silverEntryDate: sailors.silverEntryDate,
                goldEntryDate: sailors.goldEntryDate,
              })
              .from(sailors)
              .where(or(...candidateConditions))
          : [];

      const candidateIds = sailorList.map((s) => s.id);
      const aliasList = [...matchingAliases];
      if (candidateIds.length > 0) {
        const candidateAliases = await db
          .select({
            sailorId: sailorAliases.sailorId,
            aliasName: sailorAliases.aliasName,
          })
          .from(sailorAliases)
          .where(inArray(sailorAliases.sailorId, candidateIds));
        const seenAliasKeys = new Set(
          aliasList.map((a) => `${a.sailorId}|${a.aliasName.toLowerCase()}`)
        );
        for (const ca of candidateAliases) {
          const k = `${ca.sailorId}|${ca.aliasName.toLowerCase()}`;
          if (!seenAliasKeys.has(k)) {
            seenAliasKeys.add(k);
            aliasList.push(ca);
          }
        }
      }

      const candidateAndTargetSailorIds = [
        ...new Set([...candidateIds, ...candidateSailorIds]),
      ];
      const latestDateBySailor = new Map<string, string>();
      const latestOptimistDateBySailor = new Map<string, string>();
      const latestIlca4DateBySailor = new Map<string, string>();

      if (candidateAndTargetSailorIds.length > 0) {
        const latestRows = await db
          .select({
            sailorId: regattaResults.sailorId,
            maxDate: max(regattas.date),
            boatClass: regattas.boatClass,
          })
          .from(regattaResults)
          .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
          .where(inArray(regattaResults.sailorId, candidateAndTargetSailorIds))
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
      }

      recordStage("candidateFetch");
      await onProgress?.("matching", 45, "Matching competitors and detecting duplicates…");

      const affectedSailorIds = new Set<string>();
      const profileChangeFields: string[] = [];
      let matched = 0;
      let created = 0;
      let updatedProfiles = 0;
      const nationalityFlags: ImportNationalityFlag[] = [];
      let nationalityUpdated = 0;
      const rowErrors = 0;
      const unmatched: ImportUnmatchedRow[] = [];
      const matchHow: Record<string, number> = {};
      const errorSamples: string[] = [];
      const possibleDuplicates: ImportPossibleDuplicate[] = [];
      const vsDbSeen = new Set<string>();

      const regattaId = existingTarget ? existingTarget.id : randomUUID();

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
      const createdGuests: (typeof sailors.$inferInsert)[] = [];
      const createdGuestAliases: (typeof sailorAliases.$inferInsert)[] = [];
      const profileUpdates: {
        id: string;
        patch: typeof sailors.$inferInsert;
      }[] = [];

      const dbBeforeImport = sailorList.map((s) => ({
        id: s.id,
        name: s.name,
      }));
      let nameIndex = buildSailorNameIndex(sailorList, aliasList);
      const beforeImportIndex = buildSailorNameIndex(dbBeforeImport);
      const isIlcaImport = [
        "ilca 4",
        "ilca4",
        "laser 4.7",
        "laser4.7",
      ].includes(boat.trim().toLowerCase());

      const sailorsByClassSailNumber = new Map<string, typeof sailorList>();
      for (const sailor of sailorList) {
        const sailNumber = normalizeSailNumber(
          isIlcaImport ? sailor.sailNumberIlca4 : sailor.sailNumber
        );
        if (!sailNumber) continue;
        sailorsByClassSailNumber.set(sailNumber, [
          ...(sailorsByClassSailNumber.get(sailNumber) || []),
          sailor,
        ]);
      }

      possibleDuplicates.push(
        ...findWithinFileDuplicates(cleanRows.map((r) => r.name))
      );

      for (const row of cleanRows) {
        const hit = findSailorByName(row.name, nameIndex);
        const sailMatches = row.sailNumber
          ? sailorsByClassSailNumber.get(row.sailNumber) || []
          : [];
        const matchedBySailNumber = sailMatches.length === 1;
        let sailorId: string | null = matchedBySailNumber
          ? sailMatches[0].id
          : hit?.sailor.id ?? null;

        if (matchedBySailNumber) {
          matchHow["sail-number"] = (matchHow["sail-number"] || 0) + 1;
        }

        if (hit && !matchedBySailNumber) {
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
          const newGuestId = randomUUID();
          const guestRecord = {
            id: newGuestId,
            name: row.name,
            handle,
            sailNumber: createIsIlca4
              ? "0"
              : cleanOptimistSailNumber(row.sailNumber),
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
          };
          createdGuests.push(guestRecord);
          createdGuestAliases.push({
            sailorId: newGuestId,
            aliasName: row.name,
          });
          sailorId = newGuestId;
          const fullGuest = {
            ...guestRecord,
            sailNumberIlca4: guestRecord.sailNumberIlca4 || null,
            dob: guestRecord.dob || null,
            gender: guestRecord.gender || null,
            school: guestRecord.school || null,
            nationality: guestRecord.nationality || null,
            nationalityFromSail: guestRecord.nationalityFromSail ?? false,
            silverEntryDate: null,
            goldEntryDate: null,
          };
          sailorList.push(fullGuest);
          aliasList.push({ sailorId: newGuestId, aliasName: row.name });
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
        const { patch: sourcePatch, changed: fieldChanged } =
          buildProfilePatchFromRow(
            {
              sailNumber: row.sailNumber,
              sailNumberIlca4: row.sailNumber,
              club: row.club,
              school: row.school,
              boatClass: boat,
            },
            existing || {},
            applyClubSchool,
            applySail
          );
        const profilePatch: Record<string, unknown> = { ...sourcePatch };
        let profileChanged = fieldChanged.length > 0;

        if (row.nationalityRaw || row.sailNumber) {
          const curNat = existing?.nationality;
          const curNorm = normalizeNationalityCode(curNat);
          const nextNat = row.nationality;
          const unrecognized =
            row.nationalityRaw &&
            !nextNat &&
            isUnrecognizedCountry(row.nationalityRaw);

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
              curNorm && curNorm.toLowerCase() === nextNat.toLowerCase();
            if (!same) {
              if (applyClubSchool) {
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
                    ? `Updated nationality ${curNorm} → ${nextNat} (latest regatta ${String(
                        eventDate
                      ).slice(0, 10)}).`
                    : `Set nationality ${nextNat} from regatta results.`,
                });
              } else {
                nationalityFlags.push({
                  sailorId,
                  name: existing?.name || row.name,
                  previous: curNorm,
                  imported: nextNat,
                  raw: row.nationalityRaw,
                  action: "mismatch_older",
                  detail: `Import has ${nextNat} but profile keeps ${
                    curNorm || "—"
                  } (this event is older than latest result).`,
                });
              }
            }
          } else if (!curNorm && !existing?.nationalityFromSail) {
            const fromSail = nationalityFromAnySailNumber(
              row.sailNumber || existing?.sailNumber
            );
            if (fromSail) {
              if (applyClubSchool) {
                profilePatch.nationality = fromSail;
                profilePatch.nationalityFromSail = true;
                profileChanged = true;
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

        const isNewGuest = createdGuests.some((g) => g.id === sailorId);
        if (!isNewGuest && profileChanged) {
          const cleanPatch: Record<string, unknown> = {};
          for (const [k, v] of Object.entries(profilePatch)) {
            if (v !== undefined) cleanPatch[k] = v;
          }
          if (Object.keys(cleanPatch).length > 0) {
            profileUpdates.push({
              id: sailorId,
              patch: cleanPatch as typeof sailors.$inferInsert,
            });
            updatedProfiles++;
          }
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

        const rank = row.rank != null ? Math.round(row.rank) : 999;
        const nett = row.nett != null ? row.nett : null;
        const total = row.total != null ? row.total : null;

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

        pendingResults.push({
          regattaId,
          sailorId,
          rank,
          nettScore: nett,
          totalScore: total,
          isDns: row.isDns,
          gender: gNorm,
          birthYear,
          nationality: resultNat,
        });
        if (row.races.length) {
          pendingOfficialRaces.push({ sailorId, races: row.races });
        }
        matched++;

        if (!matchedBySailNumber && hit && hit.how !== "exact") {
          pendingAliases.push({ sailorId, aliasName: row.name });
        }
      }

      if (unmatched.length) {
        throw new ImportConflictError(
          "Some competitors could not be matched. No changes were saved. Check the sailor names and retry."
        );
      }
      if (
        new Set(pendingResults.map((result) => result.sailorId)).size !==
        pendingResults.length
      ) {
        throw new ImportConflictError(
          "Multiple rows matched the same sailor. No changes were saved. Resolve duplicate or ambiguous names before retrying."
        );
      }

      recordStage("matching");
      await onProgress?.("saving", 70, "Writing regatta, competitors, and race results to database…");

      // 2. Short atomic write transaction (read committed)
      const outcome = await db.transaction(
        async (tx): Promise<ImportTransactionOutcome> => {
          if (existingTarget) {
            const [current] = await tx
              .select()
              .from(regattas)
              .where(eq(regattas.id, existingTarget.id));
            if (
              !current ||
              current.updatedAt.getTime() !== existingTarget.updatedAt.getTime()
            ) {
              throw new ImportConflictError(
                "This event changed while the import was being prepared. Review it again before saving."
              );
            }
            const review = await buildExistingRegattaReview(
              {
                existing: current,
                uploadedName: regattaName,
                fleetSize,
                geography: geo,
                ranking,
                raceCount,
                rows: cleanRows,
              },
              tx
            );
            if (
              review.discrepancies.length &&
              confirmedReviewToken !== review.reviewToken
            ) {
              throw new ImportConflictError(
                "Results changed after review. Import the file again to review the current differences."
              );
            }
          }

          let reg: typeof regattas.$inferSelect | undefined;

          if (existingTarget && sameDay.length >= 1) {
            const target = existingTarget;
            let nextSlug = target.slug;
            if (target.name !== regattaName && slug !== target.slug) {
              const [slugTaken] = await tx
                .select({ id: regattas.id })
                .from(regattas)
                .where(eq(regattas.slug, slug))
                .limit(1);
              if (!slugTaken || slugTaken.id === target.id) {
                nextSlug = slug;
              }
            }

            const [updated] = await tx
              .update(regattas)
              .set({
                name: regattaName,
                slug: nextSlug,
                totalFleetSize: fleetSize,
                geography: geo,
                countsForRanking: ranking,
                reviewedAt: ranking === false ? new Date() : target.reviewedAt,
                raceCount,
                updatedAt: new Date(),
              })
              .where(eq(regattas.id, target.id))
              .returning();
            reg = updated;
          } else {
            const [upserted] = await tx
              .insert(regattas)
              .values({
                id: regattaId,
                name: regattaName,
                slug,
                date: eventDate,
                totalFleetSize: fleetSize,
                division: div,
                geography: geo,
                boatClass: boat,
                countsForRanking: ranking,
                reviewedAt: ranking === false ? new Date() : null,
                raceCount,
              })
              .returning();
            reg = upserted;
          }

          if (!reg) {
            throw new Error("Failed to create or update regatta");
          }

          // Insert new guest sailors in bulk
          if (createdGuests.length > 0) {
            await tx.insert(sailors).values(createdGuests);
            if (createdGuestAliases.length > 0) {
              await tx
                .insert(sailorAliases)
                .values(createdGuestAliases)
                .onConflictDoNothing({ target: sailorAliases.aliasName });
            }
          }

          // Apply profile updates
          if (profileUpdates.length > 0) {
            for (const update of profileUpdates) {
              await tx
                .update(sailors)
                .set(update.patch)
                .where(eq(sailors.id, update.id));
            }
          }

          // Multi-row bulk upsert regattaResults
          if (pendingResults.length) {
            const CHUNK_SIZE = 50;
            for (let i = 0; i < pendingResults.length; i += CHUNK_SIZE) {
              const chunk = pendingResults.slice(i, i + CHUNK_SIZE);
              await tx
                .insert(regattaResults)
                .values(chunk)
                .onConflictDoUpdate({
                  target: [regattaResults.sailorId, regattaResults.regattaId],
                  set: {
                    rank: sql`excluded.rank`,
                    nettScore: sql`excluded.nett_score`,
                    totalScore: sql`excluded.total_score`,
                    isDns: sql`excluded.is_dns`,
                    gender: sql`excluded.gender`,
                    birthYear: sql`excluded.birth_year`,
                    nationality: sql`excluded.nationality`,
                    updatedAt: sql`now()`,
                  },
                });
            }
          }

          const authoritativeReplace =
            confirmedRegattaId === reg.id &&
            rowErrors === 0 &&
            unmatched.length === 0;
          let removedRaceRows = 0;
          let removedResultRows = 0;

          if (
            pendingResults.length &&
            (pendingOfficialRaces.length || authoritativeReplace)
          ) {
            const sailorIds = pendingResults.map((item) => item.sailorId);
            const storedResults = await tx
              .select({
                id: regattaResults.id,
                sailorId: regattaResults.sailorId,
              })
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

            // Multi-row bulk upsert regattaRaceResults
            if (officialRows.length > 0) {
              const RACE_CHUNK_SIZE = 100;
              for (let i = 0; i < officialRows.length; i += RACE_CHUNK_SIZE) {
                const chunk = officialRows.slice(i, i + RACE_CHUNK_SIZE);
                await tx
                  .insert(regattaRaceResults)
                  .values(chunk)
                  .onConflictDoUpdate({
                    target: [
                      regattaRaceResults.regattaResultId,
                      regattaRaceResults.raceNumber,
                    ],
                    set: {
                      score: sql`excluded.score`,
                      scoringCode: sql`excluded.scoring_code`,
                      discarded: sql`excluded.discarded`,
                      rawValue: sql`excluded.raw_value`,
                      updatedAt: sql`now()`,
                    },
                  });
              }
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
              const currentOfficialRows = await tx
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
                  return (
                    !sailorId ||
                    !racesBySailor.get(sailorId)?.has(race.raceNumber)
                  );
                })
                .map((race) => race.id);
              if (obsoleteRaceIds.length) {
                const removed = await tx
                  .delete(regattaRaceResults)
                  .where(inArray(regattaRaceResults.id, obsoleteRaceIds))
                  .returning({ id: regattaRaceResults.id });
                removedRaceRows = removed.length;
              }
            }
          }

          if (authoritativeReplace && pendingResults.length) {
            const keptSailorIds = pendingResults.map(
              (result) => result.sailorId
            );
            const removed = await tx
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

          // Bulk insert aliases
          if (pendingAliases.length) {
            const seenAlias = new Set<string>();
            const unique = pendingAliases.filter((a) => {
              const k = `${a.sailorId}|${a.aliasName.toLowerCase()}`;
              if (seenAlias.has(k)) return false;
              seenAlias.add(k);
              return true;
            });
            if (unique.length > 0) {
              const ALIAS_CHUNK = 50;
              for (let i = 0; i < unique.length; i += ALIAS_CHUNK) {
                const chunk = unique.slice(i, i + ALIAS_CHUNK);
                await tx
                  .insert(sailorAliases)
                  .values(chunk)
                  .onConflictDoNothing({ target: sailorAliases.aliasName });
              }
            }
          }

          // Keep historical demographic propagation and derived fleet dates in
          // the same transaction as the imported results. If either step
          // fails, the uploaded regatta is rolled back as one atomic unit.
          let resultsDemographicsUpdated = 0;
          let silverUpdated = 0;
          const affectedIds = [...affectedSailorIds];
          const sailorById = new Map(sailorList.map((s) => [s.id, s]));

          if (affectedIds.length) {
            const patches: {
              sid: string;
              gender: string | null;
              birthYear: number | null;
              nationality: string | null;
            }[] = [];
            for (const sid of affectedIds) {
              const sailor = sailorById.get(sid);
              if (!sailor) continue;
              const rawGender = String(sailor.gender || "")
                .trim()
                .toUpperCase()
                .slice(0, 1);
              const gender =
                rawGender === "M" || rawGender === "F" ? rawGender : null;
              const birthYear = birthYearFromDob(sailor.dob);
              const nationality = normalizeNationalityCode(sailor.nationality);
              if (!gender && birthYear == null && !nationality) continue;
              patches.push({
                sid,
                gender,
                birthYear: birthYear ?? null,
                nationality: nationality || null,
              });
            }

            const BATCH_SIZE = 50;
            for (let i = 0; i < patches.length; i += BATCH_SIZE) {
              const batch = patches.slice(i, i + BATCH_SIZE);
              const batchIds = batch.map((patch) => patch.sid);
              const genderCases = batch
                .filter((patch) => patch.gender)
                .map(
                  (patch) =>
                    sql`WHEN ${regattaResults.sailorId} = ${patch.sid} THEN ${patch.gender}`
                );
              const birthYearCases = batch
                .filter((patch) => patch.birthYear != null)
                .map(
                  (patch) =>
                    sql`WHEN ${regattaResults.sailorId} = ${patch.sid} THEN ${patch.birthYear}`
                );
              const nationalityCases = batch
                .filter((patch) => patch.nationality)
                .map(
                  (patch) =>
                    sql`WHEN ${regattaResults.sailorId} = ${patch.sid} THEN ${patch.nationality}`
                );

              const setFields: Record<string, unknown> = {
                updatedAt: sql`now()`,
              };
              if (genderCases.length) {
                setFields.gender = sql`CASE ${sql.join(
                  genderCases,
                  sql` `
                )} ELSE ${regattaResults.gender} END`;
              }
              if (birthYearCases.length) {
                setFields.birthYear = sql`CASE ${sql.join(
                  birthYearCases,
                  sql` `
                )} ELSE ${regattaResults.birthYear} END`;
              }
              if (nationalityCases.length) {
                setFields.nationality = sql`CASE ${sql.join(
                  nationalityCases,
                  sql` `
                )} ELSE ${regattaResults.nationality} END`;
              }

              const updated = await tx
                .update(regattaResults)
                .set(setFields)
                .where(inArray(regattaResults.sailorId, batchIds))
                .returning({ id: regattaResults.id });
              resultsDemographicsUpdated += updated.length;
            }

            const silverLinks = await tx
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
              silverLinks.map((link) => ({
                sailorId: link.sailorId,
                regattaDate: link.regattaDate,
                division: link.division,
                countsForRanking: link.countsForRanking,
                boatClass: link.boatClass,
              }))
            );
            const silverUpdates: { sid: string; next: string }[] = [];
            for (const sid of affectedIds) {
              const next = derived.get(sid);
              if (!next) continue;
              const current = sailorById.get(sid)?.silverEntryDate;
              const previous = current ? String(current).slice(0, 10) : null;
              if (previous !== next) silverUpdates.push({ sid, next });
            }

            for (let i = 0; i < silverUpdates.length; i += BATCH_SIZE) {
              const batch = silverUpdates.slice(i, i + BATCH_SIZE);
              const cases = batch.map(
                (update) =>
                  sql`WHEN ${sailors.id} = ${update.sid} THEN ${update.next}::date`
              );
              await tx
                .update(sailors)
                .set({
                  silverEntryDate: sql`CASE ${sql.join(cases, sql` `)} ELSE ${
                    sailors.silverEntryDate
                  } END`,
                  updatedAt: sql`now()`,
                })
                .where(inArray(sailors.id, batch.map((update) => update.sid)));
              silverUpdated += batch.length;
            }
          }

          return {
            reg,
            matched,
            created,
            updatedProfiles,
            nationalityUpdated,
            resultsDemographicsUpdated,
            silverUpdated,
            rowErrors,
            unmatched,
            possibleDuplicates,
            nationalityFlags,
            matchHow,
            errorSamples,
            authoritativeReplace,
            removedResultRows,
            removedRaceRows,
            profileChangeFields,
          };
        }
      );

      recordStage("atomicWrite");
      await onProgress?.(
        "finalizing",
        96,
        "Imported results and derived competitor data atomically. Finalizing rankings…"
      );

      const {
        reg,
        created: finalCreated,
        updatedProfiles: finalUpdatedProfiles,
        authoritativeReplace,
        removedResultRows,
        removedRaceRows,
        possibleDuplicates: finalDupeList,
        resultsDemographicsUpdated,
        silverUpdated,
      } = outcome;

      if (matched > 0 || finalCreated > 0 || finalUpdatedProfiles > 0) {
        const { logAdminChange } = await import("@/lib/adminChangeLog");
        void logAdminChange({
          action: "import.regatta",
          entityType: "regatta",
          entityId: reg.id,
          entityLabel: reg.name,
          summary: `Imported ${matched}/${
            cleanRows.length
          } results for ${regattaName} (${eventDate}, ${boat}, ${geo}, ${
            ranking ? "ranking" : "non-ranking"
          }); ${finalCreated} guests, ${finalUpdatedProfiles} profiles, ${nationalityUpdated} nationality, ${resultsDemographicsUpdated} result gender/BY stamps, ${silverUpdated} silver dates, ${removedResultRows} obsolete results removed`,
          details: {
            matched,
            created: finalCreated,
            updatedProfiles: finalUpdatedProfiles,
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

      finalDupeList.sort((a, b) => b.similarity - a.similarity);
      const dupeFlags = finalDupeList.slice(0, MAX_DUPLICATE_FLAGS);

      const dupeNote =
        dupeFlags.length > 0
          ? ` · ${finalDupeList.length} possible duplicate name(s) flagged (60%+ similar) — review below / merge in Database.`
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
          created: finalCreated,
          inputRows: cleanRows.length,
          rowErrors,
          nationalityUpdated,
        },
      });

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
          created: finalCreated,
          inputRows: cleanRows.length,
          rowErrors,
          ...Object.fromEntries(
            Object.entries(stageTimings).map(([k, v]) => [`timing_${k}`, v])
          ),
        },
      });

      recordStage("finalizing");

      return {
        message:
          matched === 0 && rowErrors > 0
            ? `Import failed for all rows. ${
                needsNettMigration
                  ? "Score storage needs maintenance before decimal nett values can be saved."
                  : "See errors below."
              }`
            : `Imported ${reg.name}: ${matched}/${
                cleanRows.length
              } results saved (${finalCreated} guests auto-created, ${finalUpdatedProfiles} profiles updated when event is latest, ${nationalityUpdated} nationality from latest results, gender/birth year stamped on ${resultsDemographicsUpdated} result row(s), ${silverUpdated} silver entry dates recomputed${
                authoritativeReplace
                  ? `, ${removedResultRows} obsolete result row(s) removed`
                  : ""
              }). Fleet tags unchanged — admit series members as Silver (then Gold) in Database. ${rowErrors} row errors, ${
                unmatched.filter((u) => !u.error).length
              } unmatched.${dupeNote}${natNote}`,
        regatta: reg,
        matched,
        created: finalCreated,
        updatedProfiles: finalUpdatedProfiles,
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
          ? "Contact platform support before retrying this import."
          : undefined,
      };
    };

    if (wantsStream) {
      const stream = new TransformStream();
      const writer = stream.writable.getWriter();
      const encoder = new TextEncoder();

      (async () => {
        try {
          const onProgress = async (
            stage: string,
            progress: number,
            message: string
          ) => {
            const payload = JSON.stringify({
              type: "progress",
              stage,
              progress,
              message,
            });
            await writer.write(encoder.encode(payload + "\n"));
          };

          const result = await runImportProcess(onProgress);
          const finalPayload = JSON.stringify({
            type: "result",
            ...result,
          });
          await writer.write(encoder.encode(finalPayload + "\n"));
        } catch (e) {
          const errorMsg =
            e instanceof ImportConflictError
              ? e.message
              : e instanceof Error
              ? e.message
              : String(e);
          const errorPayload = JSON.stringify({
            type: "error",
            error: errorMsg,
          });
          await writer.write(encoder.encode(errorPayload + "\n"));
          console.error("[admin/import stream error]", e);
        } finally {
          await writer.close();
        }
      })();

      return new Response(stream.readable, {
        headers: {
          "Content-Type": "application/x-ndjson",
          "Cache-Control": "no-cache, no-transform",
        },
      });
    }

    const outcome = await runImportProcess();
    return NextResponse.json(outcome);
  } catch (e) {
    if (e instanceof ImportConflictError) {
      return NextResponse.json({ error: e.message }, { status: 409 });
    }
    adminLog({
      requestId,
      action: "import.regatta",
      path: "/api/admin/import",
      outcome: "error",
      ms: Date.now() - t0,
      error: e instanceof Error ? e.message : String(e),
      meta: {
        ...Object.fromEntries(
          Object.entries(stageTimings).map(([k, v]) => [`timing_${k}`, v])
        ),
      },
    });
    console.error(e);
    return jsonError(e);
  }
}
