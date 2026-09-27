import { NextResponse } from "next/server";
import { requireSuperadmin } from "@/lib/auth";
import { db } from "@/db";
import { sailors, regattaResults } from "@/db/schema";
import { findDuplicateSailorPairs } from "@/lib/nameMatch";
import { mergeSailors } from "@/lib/mergeSailors";
import { createAdminRequestId } from "@/lib/adminLog";
import { logAdminChange } from "@/lib/adminChangeLog";
import { revalidatePublicRankings } from "@/lib/revalidatePublic";

export async function POST(req: Request) {
  const requestId = createAdminRequestId();
  const t0 = Date.now();
  try {
    const auth = await requireSuperadmin();
    
    console.log("Starting bulk merge of high-similarity duplicates...");
    
    const allSailors = await db.select().from(sailors);
    const pairs = findDuplicateSailorPairs(
      allSailors.map(s => ({
        id: s.id,
        name: s.name,
        sailNumber: s.sailNumber,
      })),
      0.99
    );

    if (pairs.length === 0) {
      return NextResponse.json({ message: "No high-similarity duplicates found." });
    }

    const results = await db.select().from(regattaResults);
    const resultsCountMap = new Map<string, number>();
    for (const r of results) {
      resultsCountMap.set(r.sailorId, (resultsCountMap.get(r.sailorId) ?? 0) + 1);
    }

    const getScore = (s: any) => {
      let n = 0;
      if (s.goldEntryDate) n += 5;
      if (s.silverEntryDate) n += 2;
      if (s.sailNumber && !/^SGP\s*0+$/i.test(s.sailNumber)) n += 3;
      if (s.dob) n += 1;
      if (s.club && s.club !== "N/A") n += 1;
      if (s.currentFleet) n += 2;
      if (s.nationalSquadStatus) n += 1;
      n += resultsCountMap.get(s.id) ?? 0;
      return n;
    };

    let mergedCount = 0;
    const mergedPairs: string[] = [];

    for (const pair of pairs) {
      const sailorA = allSailors.find(s => s.id === pair.a.id);
      const sailorB = allSailors.find(s => s.id === pair.b.id);
      if (!sailorA || !sailorB) continue;

      const scoreA = getScore(sailorA);
      const scoreB = getScore(sailorB);
      const keepId = scoreB > scoreA ? sailorB.id : sailorA.id;
      const mergeId = keepId === sailorA.id ? sailorB.id : sailorA.id;

      try {
        await mergeSailors({
          keepId,
          mergeId,
          forceOwnershipConflict: true,
        });
        
        mergedCount++;
        mergedPairs.push(`${sailorA.name} + ${sailorB.name}`);

        void logAdminChange({
          actorUserId: auth.userId,
          actorEmail: auth.email,
          action: "sailors.merge_bulk",
          entityType: "sailor",
          entityId: keepId,
          entityLabel: sailorA.name,
          summary: `Bulk merged duplicate sailor ${sailorB.name} into ${sailorA.name}`,
          source: "/api/admin/sailors/bulk-merge-high-similarity",
          requestId,
        });
      } catch (e) {
        console.error(`Failed to merge ${keepId} and ${mergeId}:`, e);
      }
    }

    await revalidatePublicRankings();

    return NextResponse.json({
      message: `Successfully merged ${mergedCount} high-similarity duplicate pairs.`,
      count: mergedCount,
      merged: mergedPairs,
      durationMs: Date.now() - t0,
    });
  } catch (e: any) {
    console.error("Bulk merge error:", e);
    return NextResponse.json(
      { error: e.message || "Internal server error" },
      { status: e.status || 500 }
    );
  }
}
