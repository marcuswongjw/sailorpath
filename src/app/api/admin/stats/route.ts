import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { getAdminStats } from "@/lib/adminStats";

export const dynamic = "force-dynamic";
export const runtime = "nodejs";

/**
 * Lean live Stats for the admin console.
 * COUNT aggregates only — few SQL round-trips.
 */
export async function GET() {
  try {
    await requireSuperadmin();
    const stats = await getAdminStats();
    return NextResponse.json(stats, {
      headers: {
        // Short private cache so rapid tab switches don't re-hit the DB.
        "Cache-Control": "private, max-age=30, stale-while-revalidate=60",
      },
    });
  } catch (e) {
    console.error("[admin/stats]", e);
    return jsonError(e);
  }
}
