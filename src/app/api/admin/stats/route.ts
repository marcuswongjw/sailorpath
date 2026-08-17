import { NextResponse } from "next/server";
import { count, desc, eq, gte, isNotNull, isNull } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import {
  profiles,
  regattaResults,
  regattas,
  sailorClaims,
  sailors,
  supportMessages,
  usageEvents,
} from "@/db/schema";
import { listAdminChanges } from "@/lib/adminChangeLog";
import { todayYmdSg } from "@/lib/datesSg";
import { cacheAgeMs, cacheGet, cacheSet } from "@/lib/statsCache";

/**
 * Lean admin stats only — inventory counts + small usage sample + claim ops.
 * No full-table result joins, gold coverage walks, or extended analytics.
 */
const CACHE_MS = 90_000;
const USAGE_ROW_CAP = 1500;

type Payload = Record<string, unknown>;

export async function GET(req: Request) {
  try {
    await requireSuperadmin();
    const url = new URL(req.url);
    const days = Math.min(
      30,
      Math.max(1, Number(url.searchParams.get("days") || 7) || 7)
    );
    const forceRefresh = url.searchParams.get("refresh") === "1";
    const cacheKey = `admin-stats:v4-lite:${days}`;

    if (!forceRefresh) {
      const hit = cacheGet<Payload>(cacheKey, CACHE_MS);
      if (hit) {
        return NextResponse.json({
          ...hit,
          cached: true,
          cacheAgeMs: cacheAgeMs(cacheKey),
        });
      }
    }

    const t0 = Date.now();
    const since = new Date();
    since.setDate(since.getDate() - days);
    const today = todayYmdSg();

    const [
      inv,
      usageRows,
      lastSeries,
      lastImport,
      claimCounts,
      changeLog,
    ] = await Promise.all([
      loadInventory(),
      db
        .select({
          eventType: usageEvents.eventType,
          path: usageEvents.path,
          sessionId: usageEvents.sessionId,
        })
        .from(usageEvents)
        .where(gte(usageEvents.createdAt, since))
        .orderBy(desc(usageEvents.createdAt))
        .limit(USAGE_ROW_CAP)
        .catch(() => [] as never[]),
      db
        .select({ date: regattas.date })
        .from(regattas)
        .where(eq(regattas.countsForRanking, true))
        .orderBy(desc(regattas.date))
        .limit(1)
        .catch(() => [] as { date: string }[]),
      db
        .select({ createdAt: usageEvents.createdAt })
        .from(usageEvents)
        .where(eq(usageEvents.eventType, "import"))
        .orderBy(desc(usageEvents.createdAt))
        .limit(1)
        .catch(() => [] as { createdAt: Date }[]),
      loadClaimCounts(),
      listAdminChanges({ limit: 20, days }).catch(() => [] as never[]),
    ]);

    // Aggregate usage in memory (capped rows)
    const byTypeMap = new Map<string, number>();
    const pathMap = new Map<string, number>();
    const sessions = new Set<string>();
    let rankingViews = 0;
    let profileViews = 0;
    let claimsSubmitted = 0;
    let claimsApproved = 0;
    let claimsRejected = 0;

    for (const r of usageRows) {
      byTypeMap.set(r.eventType, (byTypeMap.get(r.eventType) || 0) + 1);
      if (r.path) pathMap.set(r.path, (pathMap.get(r.path) || 0) + 1);
      if (r.sessionId) sessions.add(r.sessionId);
      if (r.eventType === "ranking_view") rankingViews += 1;
      if (r.eventType === "profile_view") profileViews += 1;
      if (r.eventType === "claim_submit") claimsSubmitted += 1;
      if (r.eventType === "claim_approved") claimsApproved += 1;
      if (r.eventType === "claim_rejected") claimsRejected += 1;
    }

    const byType = [...byTypeMap.entries()]
      .map(([eventType, c]) => ({ eventType, count: c }))
      .sort((a, b) => b.count - a.count);
    const topPaths = [...pathMap.entries()]
      .map(([path, c]) => ({ path, count: c }))
      .sort((a, b) => b.count - a.count)
      .slice(0, 10);

    const lastSeriesRegattaDate = lastSeries[0]?.date || null;
    let daysSinceLastSeriesRegatta: number | null = null;
    if (lastSeriesRegattaDate) {
      const a = new Date(`${lastSeriesRegattaDate}T00:00:00Z`).getTime();
      const b = new Date(`${today}T00:00:00Z`).getTime();
      if (Number.isFinite(a) && Number.isFinite(b)) {
        daysSinceLastSeriesRegatta = Math.max(
          0,
          Math.round((b - a) / 86400000)
        );
      }
    }

    const lastImportAt = lastImport[0]?.createdAt
      ? new Date(lastImport[0].createdAt).toISOString()
      : null;
    let daysSinceLastImport: number | null = null;
    if (lastImportAt) {
      daysSinceLastImport = Math.max(
        0,
        Math.round((Date.now() - new Date(lastImportAt).getTime()) / 86400000)
      );
    }

    const payload: Payload = {
      ok: true,
      generatedAt: new Date().toISOString(),
      computeMs: Date.now() - t0,
      days,
      inventory: inv,
      usage: {
        sinceDays: days,
        totalEvents: usageRows.length,
        uniqueSessions: sessions.size,
        byType,
        topPaths,
        rankingViews,
        profileViews,
        claimsSubmitted,
        claimsApproved,
        claimsRejected,
        truncated: usageRows.length >= USAGE_ROW_CAP,
      },
      ops: {
        lastSeriesRegattaDate,
        daysSinceLastSeriesRegatta,
        lastImportAt,
        daysSinceLastImport,
        claimsPending: claimCounts.pending,
        claimsApprovedAll: claimCounts.approved,
        claimsRejectedAll: claimCounts.rejected,
        supportNew: inv.supportNew,
      },
      changeLog,
      changeLogHint:
        !changeLog || (Array.isArray(changeLog) && changeLog.length === 0)
          ? "No entries yet, or run migration 023_admin_change_log.sql."
          : null,
      cached: false,
      cacheAgeMs: 0,
    };

    cacheSet(cacheKey, payload);
    return NextResponse.json(payload, {
      headers: {
        "Cache-Control": "private, max-age=30, stale-while-revalidate=120",
      },
    });
  } catch (e) {
    return jsonError(e);
  }
}

async function loadInventory() {
  const [
    sailorN,
    regattaN,
    resultN,
    profileN,
    claimPending,
    supportNew,
    claimed,
    unclaimed,
  ] = await Promise.all([
    db.select({ n: count() }).from(sailors),
    db.select({ n: count() }).from(regattas),
    db.select({ n: count() }).from(regattaResults),
    db.select({ n: count() }).from(profiles),
    db
      .select({ n: count() })
      .from(sailorClaims)
      .where(eq(sailorClaims.status, "pending")),
    db
      .select({ n: count() })
      .from(supportMessages)
      .where(eq(supportMessages.status, "new")),
    db
      .select({ n: count() })
      .from(sailors)
      .where(isNotNull(sailors.parentId)),
    db
      .select({ n: count() })
      .from(sailors)
      .where(isNull(sailors.parentId)),
  ]);

  return {
    sailors: Number(sailorN[0]?.n || 0),
    regattas: Number(regattaN[0]?.n || 0),
    results: Number(resultN[0]?.n || 0),
    profiles: Number(profileN[0]?.n || 0),
    claimsPending: Number(claimPending[0]?.n || 0),
    supportNew: Number(supportNew[0]?.n || 0),
    sailorsClaimed: Number(claimed[0]?.n || 0),
    sailorsUnclaimed: Number(unclaimed[0]?.n || 0),
  };
}

async function loadClaimCounts() {
  try {
    const [p, a, r] = await Promise.all([
      db
        .select({ n: count() })
        .from(sailorClaims)
        .where(eq(sailorClaims.status, "pending")),
      db
        .select({ n: count() })
        .from(sailorClaims)
        .where(eq(sailorClaims.status, "approved")),
      db
        .select({ n: count() })
        .from(sailorClaims)
        .where(eq(sailorClaims.status, "rejected")),
    ]);
    return {
      pending: Number(p[0]?.n || 0),
      approved: Number(a[0]?.n || 0),
      rejected: Number(r[0]?.n || 0),
    };
  } catch {
    return { pending: 0, approved: 0, rejected: 0 };
  }
}
