import { NextResponse } from "next/server";
import { and, eq, gte } from "drizzle-orm";
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

/**
 * Why this was slow:
 * - One request loaded ALL results × regattas for data-quality + extended
 * - Ops re-scanned every sailor/regatta for gold coverage
 * - Serverless has no durable process cache (memory cache often misses)
 *
 * Fix: two-part API.
 *   part=core  — inventory, usage, ops, change log  (seconds → sub-second when cached)
 *   part=deep  — extended metrics + data quality     (heavy; loaded after UI paints)
 */
const CORE_CACHE_MS = 60_000;
const DEEP_CACHE_MS = 120_000;

type Payload = Record<string, unknown>;

export async function GET(req: Request) {
  try {
    await requireSuperadmin();
    const url = new URL(req.url);
    const days = Math.min(
      90,
      Math.max(1, Number(url.searchParams.get("days") || 7) || 7)
    );
    const part = url.searchParams.get("part") === "deep" ? "deep" : "core";
    const forceRefresh = url.searchParams.get("refresh") === "1";
    const cacheKey = `admin-stats:v3:${part}:${days}`;
    const ttl = part === "deep" ? DEEP_CACHE_MS : CORE_CACHE_MS;

    if (!forceRefresh) {
      const hit = cacheGet<Payload>(cacheKey, ttl);
      if (hit) {
        return NextResponse.json({
          ...hit,
          cached: true,
          cacheAgeMs: cacheAgeMs(cacheKey),
        });
      }
    }

    const t0 = Date.now();
    const payload =
      part === "deep"
        ? await buildDeep(days, t0)
        : await buildCore(days, t0);

    cacheSet(cacheKey, payload);

    return NextResponse.json(payload, {
      headers: {
        // Allow browser to reuse for a short window; auth still required
        "Cache-Control": "private, max-age=20, stale-while-revalidate=90",
      },
    });
  } catch (e) {
    return jsonError(e);
  }
}

async function buildCore(days: number, t0: number): Promise<Payload> {
  // Light path only — no full result table scans
  const [inventory, usage, opsHealth, changeLog] = await Promise.all([
    getProductInventory(),
    getUsageSummary(days),
    getOpsHealth(days),
    listAdminChanges({ limit: 30, days }).catch(() => [] as never[]),
  ]);

  return {
    ok: true,
    part: "core",
    generatedAt: new Date().toISOString(),
    computeMs: Date.now() - t0,
    inventory,
    usage,
    opsHealth,
    changeLog,
    changeLogHint:
      !changeLog || (Array.isArray(changeLog) && changeLog.length === 0)
        ? "No entries yet, or run migration 023_admin_change_log.sql in Supabase."
        : null,
    // Placeholders so UI doesn't break before deep arrives
    extended: null,
    dataQuality: null,
    deepPending: true,
    cached: false,
    cacheAgeMs: 0,
  };
}

async function buildDeep(days: number, t0: number): Promise<Payload> {
  const [extended, dataQuality] = await Promise.all([
    getExtendedAdminStats(days),
    loadDataQualityLite(),
  ]);

  return {
    ok: true,
    part: "deep",
    generatedAt: new Date().toISOString(),
    computeMs: Date.now() - t0,
    extended,
    dataQuality,
    deepPending: false,
    cached: false,
    cacheAgeMs: 0,
  };
}

/**
 * Data quality without loading every result row.
 * Only ranking Optimist results from the last ~3 years — enough for flags.
 */
async function loadDataQualityLite() {
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
    const cutoff = new Date();
    cutoff.setMonth(cutoff.getMonth() - 18);
    const cutoffYmd = cutoff.toISOString().slice(0, 10);

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
        .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
        .where(
          and(
            gte(regattas.date, cutoffYmd),
            // Prefer series results only (far fewer rows)
            eq(regattas.countsForRanking, true)
          )
        )
        .limit(3000)
        .catch(async () => {
          // Fallback if countsForRanking filter fails
          return db
            .select({
              sailorId: regattaResults.sailorId,
              regattaDate: regattas.date,
              regattaName: regattas.name,
              division: regattas.division,
              countsForRanking: regattas.countsForRanking,
              boatClass: regattas.boatClass,
            })
            .from(regattaResults)
            .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
            .where(gte(regattas.date, cutoffYmd))
            .limit(8000);
        }),
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
      goldBeforeEntry: dataQuality.goldBeforeEntry.slice(0, 30),
      goldWithoutEntryCount: dataQuality.goldWithoutEntry.length,
      goldWithoutEntry: dataQuality.goldWithoutEntry.slice(0, 30),
      overAgeOptimistCount: dataQuality.overAgeOptimist.length,
      overAgeOptimist: dataQuality.overAgeOptimist.slice(0, 30),
      unrecognizedNationalityCount:
        dataQuality.unrecognizedNationality.length,
      unrecognizedNationality:
        dataQuality.unrecognizedNationality.slice(0, 30),
    };
  } catch (e) {
    console.warn("stats dataQuality", e);
    return empty;
  }
}
