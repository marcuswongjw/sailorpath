import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { getProductInventory, getUsageSummary } from "@/lib/usage";

/**
 * GET /api/admin/stats?days=7
 * Superadmin: product inventory + usage summary.
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

    return NextResponse.json({
      ok: true,
      generatedAt: new Date().toISOString(),
      inventory,
      usage,
    });
  } catch (e) {
    return jsonError(e);
  }
}
