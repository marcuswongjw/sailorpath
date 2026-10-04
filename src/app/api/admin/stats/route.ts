import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { getAdminStats, StatsTimeoutError, withStatsQueryTimeout } from "@/lib/adminStats";

export const dynamic = "force-dynamic";
export const runtime = "nodejs";
export const maxDuration = 30;

/**
 * Lean live Stats for the admin console.
 * COUNT aggregates only — few SQL round-trips.
 */
export async function GET() {
  try {
    await withStatsQueryTimeout(requireSuperadmin());
    const stats = await getAdminStats();
    return NextResponse.json(stats, {
      headers: {
        // Account activity is private; the client query cache handles tab switches.
        "Cache-Control": "private, no-store",
      },
    });
  } catch (e) {
    console.error("[admin/stats]", e);
    if (e instanceof StatsTimeoutError) {
      return NextResponse.json({ error: e.message }, { status: 503 });
    }
    return jsonError(e);
  }
}
