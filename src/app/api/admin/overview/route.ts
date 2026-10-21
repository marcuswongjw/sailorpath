import { getSeparateSailorPairs } from "@/lib/sailorDuplicateDecisionStore";
import { duplicatePairKey } from "@/lib/sailorDuplicateDecisions";
import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db, ensureCoreSchema, withSequentialDatabaseReads } from "@/db";
import { regattas, regattaResults, sailors } from "@/db/schema";
import { desc, sql } from "drizzle-orm";
import { buildAdminOverview } from "@/lib/admin/adminOverview";
import { findDuplicateSailorPairs } from "@/lib/nameMatch";
import { getPlatformDemographics } from "@/lib/adminStats";

export const dynamic = "force-dynamic";

async function duplicateCount(signal?: AbortSignal) {
  const [rows, separatePairs] = await withSequentialDatabaseReads(
    [
      () =>
        db
          .select({
            id: sailors.id,
            name: sailors.name,
            sailNumber: sailors.sailNumber,
          })
          .from(sailors),
      () => getSeparateSailorPairs(),
    ],
    { label: "admin.overview.duplicates", signal },
  );
  const separate = new Set(separatePairs.map((pair) => pair.pairKey));
  return findDuplicateSailorPairs(rows).filter(
    (pair) => !separate.has(duplicatePairKey(pair.a.id, pair.b.id)),
  ).length;
}

/**
 * Compact server-aggregated overview summary for the admin console.
 * Replaces full table downloads of 8,477+ results and 1,108+ sailors
 * with index group-by counts and minimal projections.
 */
export async function GET(request: Request) {
  try {
    await requireSuperadmin(request?.signal);
    if (typeof ensureCoreSchema === "function") {
      await ensureCoreSchema();
    }
    const section = new URL(request.url).searchParams.get("section");
    if (section === "duplicates") {
      return NextResponse.json(
        {
          duplicateCount: await duplicateCount(request.signal),
          generatedAt: new Date().toISOString(),
        },
        { headers: { "Cache-Control": "private, no-store" } },
      );
    }

    const [resultCountRows, regattaRows] = await withSequentialDatabaseReads(
      [
        // Fast index group-by aggregate for result counts per regatta
        () =>
          db
            .select({
              regattaId: regattaResults.regattaId,
              count: sql<number>`count(*)::int`,
            })
            .from(regattaResults)
            .groupBy(regattaResults.regattaId),
        // Regatta metadata for publication readiness checks
        () =>
          db
            .select({
              id: regattas.id,
              name: regattas.name,
              slug: regattas.slug,
              // Stable ISO calendar strings; do not decode unused timestamp columns.
              date: sql<string>`${regattas.date}::text`,
              endDate: sql<string | null>`${regattas.endDate}::text`,
              totalFleetSize: regattas.totalFleetSize,
              division: regattas.division,
              raceCount: regattas.raceCount,
              geography: regattas.geography,
              boatClass: regattas.boatClass,
              countsForRanking: regattas.countsForRanking,
              status: regattas.status,
              venue: regattas.venue,
              organizer: regattas.organizer,
              norUrl: regattas.norUrl,
              registrationUrl: regattas.registrationUrl,
              officialResultsUrl: regattas.officialResultsUrl,
              officialResultsSourceName: regattas.officialResultsSourceName,
              isSelectionTrial: regattas.isSelectionTrial,
              selectionEventId: regattas.selectionEventId,
              eventId: regattas.eventId,
              scheduleNotes: regattas.scheduleNotes,
            })
            .from(regattas)
            .orderBy(desc(regattas.date)),
      ],
      { label: "admin.overview.get", signal: request?.signal },
    );

    const resultCounts = new Map<string, number>();
    for (const row of resultCountRows) {
      resultCounts.set(row.regattaId, Number(row.count) || 0);
    }

    const overview = buildAdminOverview(regattaRows, resultCounts);
    const demographics = await getPlatformDemographics();
    // Existing consumers retain the combined response. Daily event checks do
    // not wait for the independent identity scan.
    const duplicates =
      section === "events" ? null : await duplicateCount(request.signal);

    return NextResponse.json(
      {
        resultCounts: Object.fromEntries(resultCounts),
        sheets: overview.sheets,
        ready: overview.ready,
        missingResults: overview.missingResults,
        blocked: overview.blocked,
        incomplete: overview.incomplete,
        duplicateCount: duplicates,
        demographics,
        generatedAt: new Date().toISOString(),
        counts: {
          ready: overview.ready.length,
          missingResults: overview.missingResults.length,
          blocked: overview.blocked.length,
          incomplete: overview.incomplete.length,
          duplicateSailors: duplicates,
        },
      },
      {
        headers: {
          "Cache-Control": "private, no-store",
        },
      },
    );
  } catch (error) {
    return jsonError(error);
  }
}
