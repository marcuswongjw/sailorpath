import { NextResponse } from "next/server";
import { and, eq, isNull, or, sql } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { sailors } from "@/db/schema";
import { hasSilverHistory } from "@/lib/seriesMembership";
import { revalidatePublicRankings } from "@/lib/revalidatePublic";
import { adminLog, createAdminRequestId } from "@/lib/adminLog";

/** Singapore calendar date YYYY-MM-DD for drop-date comparisons. */
function sgTodayYmd(): string {
  return new Date().toLocaleDateString("en-CA", {
    timeZone: "Asia/Singapore",
  });
}

/** List Silver series members eligible for Gold promotion */
export async function GET() {
  try {
    await requireSuperadmin();
    const today = sgTodayYmd();

    // SQL-prefilter: not already Gold, not past drop, and has Silver/Series signal.
    // Final pass still uses hasSilverHistory for legacy fleet-tag edge cases.
    const rows = await db
      .select({
        id: sailors.id,
        name: sailors.name,
        handle: sailors.handle,
        sailNumber: sailors.sailNumber,
        silverEntryDate: sailors.silverEntryDate,
        goldEntryDate: sailors.goldEntryDate,
        currentFleet: sailors.currentFleet,
        nationalSquadStatus: sailors.nationalSquadStatus,
        dropDate: sailors.dropDate,
      })
      .from(sailors)
      .where(
        and(
          isNull(sailors.goldEntryDate),
          or(
            sql`${sailors.dropDate} is null`,
            sql`${sailors.dropDate}::text > ${today}`
          ),
          or(
            sql`${sailors.silverEntryDate} is not null`,
            sql`lower(trim(coalesce(${sailors.currentFleet}, ''))) in ('silver', 'gold', 'series')`
          )
        )
      );

    const candidates = rows.filter((s) => hasSilverHistory(s));
    return NextResponse.json({
      candidates: candidates.map((s) => ({
        id: s.id,
        name: s.name,
        handle: s.handle,
        sailNumber: s.sailNumber,
        silverEntryDate: s.silverEntryDate,
        currentFleet: s.currentFleet,
        nationalSquadStatus: s.nationalSquadStatus,
      })),
    });
  } catch (e) {
    return jsonError(e);
  }
}

/** Promote sailor to Gold (requires Silver history) */
export async function POST(req: Request) {
  const requestId = createAdminRequestId();
  const t0 = Date.now();
  try {
    const auth = await requireSuperadmin();
    const body = await req.json();
    const sailorId = String(body.sailorId || "").trim();
    if (!sailorId) {
      return NextResponse.json({ error: "sailorId required" }, { status: 400 });
    }
    const [s] = await db
      .select()
      .from(sailors)
      .where(eq(sailors.id, sailorId))
      .limit(1);
    if (!s) {
      return NextResponse.json({ error: "Sailor not found" }, { status: 404 });
    }
    if (!hasSilverHistory(s)) {
      return NextResponse.json(
        { error: "Gold requires Silver history first" },
        { status: 400 }
      );
    }
    const { validateHalfBoundaryDate, currentPeriodFromSgToday } = await import(
      "@/lib/datesSg"
    );
    const { periodBounds } = await import("@/lib/ranking");
    // Default to current half start (1 Jan / 1 Jul) — not calendar today
    const defaultGold = periodBounds(currentPeriodFromSgToday()).start;
    const goldDate =
      body.goldEntryDate || s.goldEntryDate || defaultGold;
    const boundaryErr = validateHalfBoundaryDate(
      goldDate,
      "Gold entry date"
    );
    if (boundaryErr) {
      return NextResponse.json({ error: boundaryErr }, { status: 400 });
    }

    const [updated] = await db
      .update(sailors)
      .set({
        // Guest | Series only — Gold vs Silver is from goldEntryDate
        currentFleet: "Series",
        goldEntryDate: goldDate,
        updatedAt: new Date(),
      })
      .where(eq(sailors.id, sailorId))
      .returning();

    revalidatePublicRankings(`promote:${sailorId}`);
    adminLog({
      requestId,
      action: "promote.gold",
      path: "/api/admin/promote",
      role: auth.role,
      actorUserId: auth.userId,
      actorEmail: auth.email,
      entityType: "sailor",
      entityId: sailorId,
      entityLabel: s.name,
      outcome: "ok",
      ms: Date.now() - t0,
      meta: { goldEntryDate: String(goldDate).slice(0, 10) },
    });
    return NextResponse.json({
      ok: true,
      sailor: updated,
      message: `Promoted ${s.name} to Gold (Series + gold entry ${goldDate}).`,
    });
  } catch (e) {
    adminLog({
      requestId,
      action: "promote.gold",
      path: "/api/admin/promote",
      outcome: "error",
      ms: Date.now() - t0,
      error: e instanceof Error ? e.message : String(e),
    });
    console.error("promote", e);
    return jsonError(e);
  }
}
