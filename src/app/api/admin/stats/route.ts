import { NextResponse } from "next/server";
import { eq } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import {
  getOpsHealth,
  getProductInventory,
  getUsageSummary,
} from "@/lib/usage";
import { getExtendedAdminStats } from "@/lib/adminExtendedStats";
import { db } from "@/db";
import { regattaResults, regattas, sailors } from "@/db/schema";
import { buildDataQualityReport } from "@/lib/dataQuality";
import { listAdminChanges } from "@/lib/adminChangeLog";
import { todayYmdSg } from "@/lib/datesSg";

/**
 * GET /api/admin/stats?days=7
 * Superadmin: inventory + usage + extended metrics + data quality + change log.
 */
export async function GET(req: Request) {
  try {
    await requireSuperadmin();
    const url = new URL(req.url);
    const days = Math.min(
      90,
      Math.max(1, Number(url.searchParams.get("days") || 7) || 7)
    );

    const [inventory, usage, opsHealth, extended] = await Promise.all([
      getProductInventory(),
      getUsageSummary(days),
      getOpsHealth(days),
      getExtendedAdminStats(days),
    ]);

    // Data quality
    let dataQuality: ReturnType<typeof buildDataQualityReport> | null = null;
    try {
      const sailorRows = await db.select().from(sailors);
      const links = await db
        .select({
          sailorId: regattaResults.sailorId,
          regattaDate: regattas.date,
          regattaName: regattas.name,
          division: regattas.division,
          countsForRanking: regattas.countsForRanking,
          boatClass: regattas.boatClass,
        })
        .from(regattaResults)
        .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id));

      const byId = new Map(sailorRows.map((s) => [s.id, s]));
      dataQuality = buildDataQualityReport(
        sailorRows.map((s) => ({
          id: s.id,
          name: s.name,
          dob: s.dob,
          dropDate: s.dropDate,
          silverEntryDate: s.silverEntryDate,
          goldEntryDate: s.goldEntryDate,
          currentFleet: s.currentFleet,
          nationality: s.nationality,
        })),
        links.map((l) => {
          const s = byId.get(l.sailorId);
          return {
            sailorId: l.sailorId,
            sailorName: s?.name || l.sailorId,
            goldEntryDate: s?.goldEntryDate,
            regattaDate: l.regattaDate,
            regattaName: l.regattaName,
            division: l.division,
            countsForRanking: l.countsForRanking,
            boatClass: l.boatClass,
          };
        }),
        todayYmdSg()
      );
    } catch (e) {
      console.warn("stats dataQuality", e);
    }

    const changeLog = await listAdminChanges({ limit: 80, days });

    return NextResponse.json({
      ok: true,
      generatedAt: new Date().toISOString(),
      inventory,
      usage,
      opsHealth,
      extended,
      dataQuality: dataQuality
        ? {
            emptySeries: dataQuality.emptySeries,
            goldBeforeEntryCount: dataQuality.goldBeforeEntry.length,
            goldBeforeEntry: dataQuality.goldBeforeEntry.slice(0, 50),
            goldWithoutEntryCount: dataQuality.goldWithoutEntry.length,
            goldWithoutEntry: dataQuality.goldWithoutEntry.slice(0, 50),
            overAgeOptimistCount: dataQuality.overAgeOptimist.length,
            overAgeOptimist: dataQuality.overAgeOptimist.slice(0, 50),
            unrecognizedNationalityCount:
              dataQuality.unrecognizedNationality.length,
            unrecognizedNationality:
              dataQuality.unrecognizedNationality.slice(0, 50),
          }
        : {
            emptySeries: 0,
            goldBeforeEntryCount: 0,
            goldBeforeEntry: [],
            goldWithoutEntryCount: 0,
            goldWithoutEntry: [],
            overAgeOptimistCount: 0,
            overAgeOptimist: [],
            unrecognizedNationalityCount: 0,
            unrecognizedNationality: [],
          },
      changeLog,
      changeLogHint:
        changeLog.length === 0
          ? "No entries yet, or run migration 023_admin_change_log.sql in Supabase."
          : null,
    });
  } catch (e) {
    return jsonError(e);
  }
}
