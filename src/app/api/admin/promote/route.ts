import { NextResponse } from "next/server";
import { eq } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { sailors } from "@/db/schema";
import { hasSilverHistory } from "@/lib/seriesMembership";

/** List Silver series members eligible for Gold promotion */
export async function GET() {
  try {
    await requireSuperadmin();
    const rows = await db.select().from(sailors);
    const candidates = rows.filter((s) => {
      // Already left Optimist
      if (s.dropDate) {
        const ymd = String(s.dropDate).slice(0, 10);
        const today = new Date().toLocaleDateString("en-CA", {
          timeZone: "Asia/Singapore",
        });
        if (/^\d{4}-\d{2}-\d{2}$/.test(ymd) && ymd <= today) return false;
      }
      const alreadyGold = Boolean(s.goldEntryDate);
      if (alreadyGold) return false;
      return hasSilverHistory(s);
    });
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
  try {
    await requireSuperadmin();
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
    const goldDate =
      body.goldEntryDate ||
      s.goldEntryDate ||
      new Date().toISOString().slice(0, 10);

    const [updated] = await db
      .update(sailors)
      .set({
        currentFleet: "Gold",
        goldEntryDate: goldDate,
        updatedAt: new Date(),
      })
      .where(eq(sailors.id, sailorId))
      .returning();

    return NextResponse.json({
      ok: true,
      sailor: updated,
      message: `Promoted ${s.name} to Gold Fleet.`,
    });
  } catch (e) {
    console.error("promote", e);
    return jsonError(e);
  }
}
