import { getSeparateSailorPairs } from "@/lib/sailorDuplicateDecisionStore";
import { duplicatePairKey } from "@/lib/sailorDuplicateDecisions";
import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db, ensureCoreSchema, withDatabaseRetry } from "@/db";
import { regattas, regattaResults, sailors } from "@/db/schema";
import { desc, sql } from "drizzle-orm";
import { buildAdminOverview } from "@/lib/admin/adminOverview";
import { findDuplicateSailorPairs } from "@/lib/nameMatch";

export const dynamic = "force-dynamic";

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

    const { overview, duplicateCount } = await withDatabaseRetry(
      async () => {
        const [resultCountRows, regattaRows, sailorRows, separatePairs] = await Promise.all([
          // Fast index group-by aggregate for result counts per regatta
          db
            .select({
              regattaId: regattaResults.regattaId,
              count: sql<number>`count(*)::int`,
            })
            .from(regattaResults)
            .groupBy(regattaResults.regattaId),
          // Regatta metadata for publication readiness checks
          db.select({
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
          }).from(regattas).orderBy(desc(regattas.date)),
          // Lightweight sailor projection strictly for duplicate detection
          db
            .select({
              id: sailors.id,
              name: sailors.name,
              sailNumber: sailors.sailNumber,
            })
            .from(sailors),
          getSeparateSailorPairs(),
        ]);

        const resultCounts = new Map<string, number>();
        for (const row of resultCountRows) {
          resultCounts.set(row.regattaId, Number(row.count) || 0);
        }

        const overviewData = buildAdminOverview(regattaRows, resultCounts);
        const duplicates = findDuplicateSailorPairs(
          sailorRows.map((s) => ({
            id: s.id,
            name: s.name,
            sailNumber: s.sailNumber,
          }))
        );

        return {
          overview: overviewData,
          duplicateCount: duplicates.filter(p => !separatePairs.some(d => d.pairKey === duplicatePairKey(p.a.id, p.b.id))).length,
        };
      },
      { label: "admin.overview.get", signal: request?.signal }
    );

    return NextResponse.json(
      {
        sheets: overview.sheets,
        ready: overview.ready,
        missingResults: overview.missingResults,
        blocked: overview.blocked,
        incomplete: overview.incomplete,
        duplicateCount,
        counts: {
          ready: overview.ready.length,
          missingResults: overview.missingResults.length,
          blocked: overview.blocked.length,
          incomplete: overview.incomplete.length,
          duplicateSailors: duplicateCount,
        },
      },
      {
        headers: {
          "Cache-Control": "private, no-store",
        },
      }
    );
  } catch (error) {
    return jsonError(error);
  }
}
