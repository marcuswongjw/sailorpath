import { NextResponse } from "next/server";
import { requireSuperadmin } from "@/lib/auth";
import { db } from "@/db";
import { sailors, regattaResults, regattas } from "@/db/schema";
import { eq, and, gte, lt, sql } from "drizzle-orm";
import { logAdminChange } from "@/lib/adminChangeLog";
import { revalidatePublicRankings } from "@/lib/revalidatePublic";

export async function POST() {
  try {
    const auth = await requireSuperadmin();
    
    console.log("Scanning for drop date inconsistencies...");
    
    // 1. Get all sailors who have a drop date
    const sailorsWithDrop = await db.select().from(sailors).where(sql`${sailors.dropDate} IS NOT NULL`);
    
    let correctedCount = 0;
    const correctedSailors: string[] = [];

    for (const sailor of sailorsWithDrop) {
      const dropDate = new Date(sailor.dropDate);
      if (isNaN(dropDate.getTime())) continue;

      // 2. Find the latest regatta date for this sailor
      const latestRegatta = await db
        .select({ maxDate: sql`max(${regattas.date})` })
        .from(regattaResults)
        .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
        .where(eq(regattaResults.sailorId, sailor.id));

      const maxDateStr = latestRegatta[0]?.maxDate;
      if (!maxDateStr) continue;

      const maxDate = new Date(maxDateStr);
      if (isNaN(maxDate.getTime())) continue;

      // 3. If dropDate < maxDate, the drop date is inconsistent
      if (dropDate < maxDate) {
        await db.update(sailors)
          .set({ dropDate: null, updatedAt: new Date() })
          .where(eq(sailors.id, sailor.id));
        
        correctedCount++;
        correctedSailors.push(`${sailor.name} (Drop: ${sailor.dropDate} < Latest Regatta: ${maxDateStr})`);

        void logAdminChange({
          actorUserId: auth.userId,
          actorEmail: auth.email,
          action: "sailor.fix_drop_date",
          entityType: "sailor",
          entityId: sailor.id,
          entityLabel: sailor.name,
          summary: `Removed inconsistent drop date ${sailor.dropDate} (later regatta found on ${maxDateStr})`,
          source: "/api/admin/sailors/fix-drop-dates",
        });
      }
    }

    await revalidatePublicRankings();

    return NextResponse.json({
      ok: true,
      correctedCount,
      details: correctedSailors,
    });
  } catch (e: any) {
    console.error(e);
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}
