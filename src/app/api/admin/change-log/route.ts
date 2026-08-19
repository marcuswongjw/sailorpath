import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { listAdminChanges } from "@/lib/adminChangeLog";

export const dynamic = "force-dynamic";
export const runtime = "nodejs";

/**
 * Superadmin-only audit trail from `admin_change_log`.
 * Query: ?limit=50&days=30
 */
export async function GET(req: Request) {
  try {
    await requireSuperadmin();
    const url = new URL(req.url);
    const limitRaw = Number(url.searchParams.get("limit") || "50");
    const daysRaw = Number(url.searchParams.get("days") || "30");
    const limit = Number.isFinite(limitRaw) ? limitRaw : 50;
    const days = Number.isFinite(daysRaw) ? daysRaw : 30;

    const rows = await listAdminChanges({ limit, days });
    return NextResponse.json(
      {
        changes: rows.map((r) => ({
          ...r,
          createdAt:
            r.createdAt instanceof Date
              ? r.createdAt.toISOString()
              : r.createdAt,
        })),
      },
      {
        headers: {
          "Cache-Control": "private, max-age=15, stale-while-revalidate=30",
        },
      }
    );
  } catch (e) {
    console.error("[admin/change-log]", e);
    return jsonError(e);
  }
}
