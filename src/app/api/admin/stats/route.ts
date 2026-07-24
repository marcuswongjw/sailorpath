import { NextResponse } from "next/server";
import { eq } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { getProductInventory, getUsageSummary } from "@/lib/usage";
import { db } from "@/db";
import { regattaResults, regattas, sailors } from "@/db/schema";
import { findGoldBeforeEntryIssues } from "@/lib/dataQuality";
import { listAdminChanges } from "@/lib/adminChangeLog";

/**
 * GET /api/admin/stats?days=7
 * Superadmin: inventory + usage + data quality + change log.
 */
export async function GET(req: Request) {
  try {
    await requireSuperadmin();
    const url = new URL(req.url);
    const days = Math.min(
      90,
      Math.max(1, Number(url.searchParams.get("days") || 7) || 7)
    );

    const [inventory, usage] = await Promise.all([
      getProductInventory(),
      getUsageSummary(days),
    ]);

    // Data quality
    let emptySeries = 0;
    let goldBeforeEntry: ReturnType<typeof findGoldBeforeEntryIssues> = [];
    try {
      const sailorRows = await db.select().from(sailors);
      emptySeries = sailorRows.filter((s) => {
        const cf = String(s.currentFleet || "")
          .trim()
          .toLowerCase();
        const isSeriesTag =
          cf === "series" ||
          cf === "gold" ||
          cf === "silver" ||
          cf === "in sg fleet" ||
          cf === "member";
        return isSeriesTag && !s.goldEntryDate && !s.silverEntryDate;
      }).length;

      const links = await db
        .select({
          sailorId: regattaResults.sailorId,
          regattaDate: regattas.date,
          regattaName: regattas.name,
          division: regattas.division,
          countsForRanking: regattas.countsForRanking,
        })
        .from(regattaResults)
        .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id));

      const byId = new Map(sailorRows.map((s) => [s.id, s]));
      goldBeforeEntry = findGoldBeforeEntryIssues(
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
          };
        })
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
      dataQuality: {
        emptySeries,
        goldBeforeEntryCount: goldBeforeEntry.length,
        goldBeforeEntry: goldBeforeEntry.slice(0, 50),
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
