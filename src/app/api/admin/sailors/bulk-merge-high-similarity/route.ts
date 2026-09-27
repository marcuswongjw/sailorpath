import { NextResponse } from "next/server";
import { requireSuperadmin } from "@/lib/auth";
import { db } from "@/db";
import { sailors, regattaResults } from "@/db/schema";
import { findDuplicateSailorPairs } from "@/lib/nameMatch";
import { mergeSailors } from "@/lib/mergeSailors";
import { createAdminRequestId } from "@/lib/adminLog";
import { logAdminChange } from "@/lib/adminChangeLog";
import { revalidatePublicRankings } from "@/lib/revalidatePublic";

export const maxDuration = 300;
const MAX_MERGES_PER_REQUEST = 15;

export async function POST() {
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
        sailNumberIlca4: s.sailNumberIlca4,
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

    const getScore = (s: (typeof allSailors)[number]) => {
      let n = 0;
      // Prefer a claimed record so an unclaimed duplicate can never displace it.
      if (s.parentId) n += 1000;
      if (s.goldEntryDate) n += 5;
      if (s.silverEntryDate) n += 2;
      if (s.sailNumber && !/^SGP\s*0+$/i.test(s.sailNumber)) n += 3;
      if (s.sailNumberIlca4 && !/^SGP\s*0+$/i.test(s.sailNumberIlca4)) n += 3;
      if (s.dob) n += 1;
      if (s.club && s.club !== "N/A") n += 1;
      if (s.currentFleet) n += 2;
      if (s.nationalSquadStatus) n += 1;
      n += resultsCountMap.get(s.id) ?? 0;
      return n;
    };

    // Merge connected groups, rather than stale pairs. This handles A/B/C
    // duplicate groups without trying to merge a record after it was deleted.
    const parent = new Map<string, string>();
    const find = (id: string): string => {
      const p = parent.get(id) ?? id;
      if (p === id) return id;
      const root = find(p);
      parent.set(id, root);
      return root;
    };
    for (const pair of pairs) {
      parent.set(pair.a.id, pair.a.id);
      parent.set(pair.b.id, pair.b.id);
    }
    for (const pair of pairs) {
      const a = find(pair.a.id);
      const b = find(pair.b.id);
      if (a !== b) parent.set(b, a);
    }
    const groups = new Map<string, typeof allSailors>();
    for (const id of parent.keys()) {
      const sailor = allSailors.find((row) => row.id === id);
      if (!sailor) continue;
      const root = find(id);
      groups.set(root, [...(groups.get(root) ?? []), sailor]);
    }

    let mergedCount = 0;
    const mergedPairs: string[] = [];

    mergeGroups: for (const members of groups.values()) {
      const [survivor, ...duplicates] = [...members].sort(
        (a, b) => getScore(b) - getScore(a) || a.createdAt.getTime() - b.createdAt.getTime()
      );
      for (const duplicate of duplicates) {
      if (mergedCount >= MAX_MERGES_PER_REQUEST) break mergeGroups;
      try {
        await mergeSailors({
          keepId: survivor.id,
          mergeId: duplicate.id,
          forceOwnershipConflict: true,
        });
        
        mergedCount++;
        mergedPairs.push(`${survivor.name} + ${duplicate.name}`);

        void logAdminChange({
          actorUserId: auth.userId,
          actorEmail: auth.email,
          action: "sailors.merge_bulk",
          entityType: "sailor",
          entityId: survivor.id,
          entityLabel: survivor.name,
          summary: `Bulk merged duplicate sailor ${duplicate.name} into ${survivor.name}`,
          source: "/api/admin/sailors/bulk-merge-high-similarity",
          requestId,
        });
      } catch (e) {
        console.error(`Failed to merge ${survivor.id} and ${duplicate.id}:`, e);
      }
      }
    }

    await revalidatePublicRankings();

    return NextResponse.json({
      message: `Successfully merged ${mergedCount} high-similarity duplicate pairs.`,
      count: mergedCount,
      hasMore: mergedCount >= MAX_MERGES_PER_REQUEST,
      merged: mergedPairs,
      durationMs: Date.now() - t0,
    });
  } catch (e: unknown) {
    console.error("Bulk merge error:", e);
    const error = e instanceof Error ? e : new Error("Internal server error");
    const status =
      typeof e === "object" && e !== null && "status" in e && typeof e.status === "number"
        ? e.status
        : 500;
    return NextResponse.json(
      { error: error.message },
      { status }
    );
  }
}
