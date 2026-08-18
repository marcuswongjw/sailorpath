import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { getCachedAdminStats } from "@/lib/adminStats";

/**
 * Lean live Stats for the admin console.
 * COUNT / DISTINCT aggregates only — cached ~60s.
 */
export async function GET() {
  try {
    await requireSuperadmin();
    const stats = await getCachedAdminStats();
    return NextResponse.json(stats);
  } catch (e) {
    return jsonError(e);
  }
}
