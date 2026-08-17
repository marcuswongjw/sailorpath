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
import { cacheAgeMs, cacheGet, cacheSet } from "@/lib/statsCache";

/** Warm-instance cache — stats are expensive (many table scans). */
const STATS_CACHE_MS = 45_000;

type StatsPayload = Record<string, unknown>;

/**
 * GET /api/admin/stats?days=7&refresh=1
 * Superadmin: inventory + usage + extended metrics + data quality + change log.
 * Cached ~45s per `days` bucket unless refresh=1.
 */
export async function GET(req: Request) {
  try {
    await requireSuperadmin();
    const url = new URL(req.url);
    const days = Math.min(
      90,
      Math.max(1, Number(url.searchParams.get("days") || 7) || 7)
    );
    const forceRefresh = url.searchParams.get("refresh") === "1";
    const cacheKey = `admin-stats:v2:${days}`;

    if (!forceRefresh) {
      const hit = cacheGet<StatsPayload>(cacheKey, STATS_CACHE_MS);
      if (hit) {
        return NextResponse.json({
          ...hit,
          cached: true,
          cacheAgeMs: cacheAgeMs(cacheKey),
        });
      }
    }

    const t0 = Date.now();

    // Everything in parallel — previously dataQuality + changeLog ran after
    // the heavy work and doubled wall-clock time.
    const [inventory, usage, opsHealth, extended, dataQuality, changeLog] =
      await Promise.all([
        getProductInventory(),
        getUsageSummary(days),
        getOpsHealth(days),
        getExtendedAdminStats(days),
        loadDataQuality(),
        listAdminChanges({ limit: 40, days }).catch(() => [] as never[]),
      ]);

    const payload: StatsPayload = {
      ok: true,
      generatedAt: new Date().toISOString(),
      computeMs: Date.now() - t0,
      inventory,
      usage,
      opsHealth,
      extended,
      dataQuality,
      changeLog,
      changeLogHint:
        !changeLog || (Array.isArray(changeLog) && changeLog.length === 0)
          ? "No entries yet, or run migration 023_admin_change_log.sql in Supabase."
          : null,
      cached: false,
      cacheAgeMs: 0,
    };

    cacheSet(cacheKey, payload);

    return NextResponse.json(payload, {
      headers: {
        "Cache-Control": "private, max-age=30, stale-while-revalidate=60",
      },
    });
  } catch (e) {
    return jsonError(e);
  }
}

async function loadDataQuality() {
  const empty = {
    emptySeries: 0,
    goldBeforeEntryCount: 0,
    goldBeforeEntry: [] as never[],
    goldWithoutEntryCount: 0,
    goldWithoutEntry: [] as never[],
    overAgeOptimistCount: 0,
    overAgeOptimist: [] as never[],
    unrecognizedNationalityCount: 0,
    unrecognizedNationality: [] as never[],
  };

  try {
    // Slim columns only — full sailor rows were a major cost
    const [sailorRows, links] = await Promise.all([
      db
        .select({
          id: sailors.id,
          name: sailors.name,
          dob: sailors.dob,
          dropDate: sailors.dropDate,
          silverEntryDate: sailors.silverEntryDate,
          goldEntryDate: sailors.goldEntryDate,
          currentFleet: sailors.currentFleet,
          nationality: sailors.nationality,
        })
        .from(sailors),
      db
        .select({
          sailorId: regattaResults.sailorId,
          regattaDate: regattas.date,
          regattaName: regattas.name,
          division: regattas.division,
          countsForRanking: regattas.countsForRanking,
          boatClass: regattas.boatClass,
        })
        .from(regattaResults)
        .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id)),
    ]);

    const byId = new Map(sailorRows.map((s) => [s.id, s]));
    const dataQuality = buildDataQualityReport(
      sailorRows,
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

    return {
      emptySeries: dataQuality.emptySeries,
      goldBeforeEntryCount: dataQuality.goldBeforeEntry.length,
      goldBeforeEntry: dataQuality.goldBeforeEntry.slice(0, 40),
      goldWithoutEntryCount: dataQuality.goldWithoutEntry.length,
      goldWithoutEntry: dataQuality.goldWithoutEntry.slice(0, 40),
      overAgeOptimistCount: dataQuality.overAgeOptimist.length,
      overAgeOptimist: dataQuality.overAgeOptimist.slice(0, 40),
      unrecognizedNationalityCount:
        dataQuality.unrecognizedNationality.length,
      unrecognizedNationality:
        dataQuality.unrecognizedNationality.slice(0, 40),
    };
  } catch (e) {
    console.warn("stats dataQuality", e);
    return empty;
  }
}
