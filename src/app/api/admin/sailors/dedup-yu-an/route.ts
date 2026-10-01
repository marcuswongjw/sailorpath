import { NextResponse } from "next/server";
import { jsonError, requireSuperadmin } from "@/lib/auth";
import { db } from "@/db";
import { sailors, sailorAliases } from "@/db/schema";
import { eq } from "drizzle-orm";
import { logAdminChange } from "@/lib/adminChangeLog";
import { revalidatePublicRankings } from "@/lib/revalidatePublic";
import { mergeSailors } from "@/lib/mergeSailors";

export async function POST() {
  try {
    const auth = await requireSuperadmin();

    const allSailors = await db.select().from(sailors);
    const yuAnRows = allSailors.filter((s) => {
      const clean = s.name.toLowerCase().replace(/[^a-z]/g, "");
      return (
        clean === "yuanli" ||
        clean === "liyuan" ||
        ["yu an li", "yu an", "li yu'an", "li yu an", "yu an, li", "li, yu an"].includes(s.name.trim().toLowerCase())
      );
    });

    if (yuAnRows.length <= 1) {
      return NextResponse.json({
        ok: true,
        message:
          yuAnRows.length === 1
            ? "Only 1 Yu An record found, no merge needed."
            : "No Yu An records found.",
        count: yuAnRows.length,
      });
    }

    // Rank candidate records to select canonical survivor:
    // Prefer sail_number '2056', then exact name 'Yu An Li' / 'Yu an Li'
    yuAnRows.sort((a, b) => {
      const scoreA =
        (a.sailNumber === "2056" ? 50 : 0) +
        (a.name.toLowerCase() === "yu an li" ? 100 : 0);
      const scoreB =
        (b.sailNumber === "2056" ? 50 : 0) +
        (b.name.toLowerCase() === "yu an li" ? 100 : 0);
      return scoreB - scoreA;
    });

    const keep = yuAnRows[0];
    const duplicates = yuAnRows.slice(1);
    let mergedCount = 0;
    const mergedNames: string[] = [];

    for (const dup of duplicates) {
      await mergeSailors({
        keepId: keep.id,
        mergeId: dup.id,
        forceOwnershipConflict: true,
      });
      mergedCount++;
      mergedNames.push(dup.name);
    }

    // Update canonical survivor attributes
    await db
      .update(sailors)
      .set({
        name: "Yu An Li",
        gender: "F",
        sailNumber: "2056",
        club: keep.club && keep.club !== "N/A" ? keep.club : "Constant Wind",
        school: keep.school || "TAO NAN SCHOOL",
        nationality: "SGP",
        currentFleet: "Series",
        updatedAt: new Date(),
      })
      .where(eq(sailors.id, keep.id));

    // Ensure all name variations are stored as aliases for future imports
    await db
      .insert(sailorAliases)
      .values([
        { sailorId: keep.id, aliasName: "Yu an Li" },
        { sailorId: keep.id, aliasName: "LI YU'AN" },
        { sailorId: keep.id, aliasName: "Li Yu'An" },
        { sailorId: keep.id, aliasName: "Li Yu An" },
        { sailorId: keep.id, aliasName: "Yu An Li" },
      ])
      .onConflictDoNothing({ target: sailorAliases.aliasName });

    void logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: "sailors.dedup_results",
      entityType: "sailor",
      entityId: keep.id,
      entityLabel: "Yu An Li",
      summary: `Merged ${mergedCount} duplicate profile(s) (${mergedNames.join(", ")}) into Yu An Li`,
      details: { keepId: keep.id, duplicates: mergedNames },
      source: "/api/admin/sailors/dedup-yu-an",
    });

    await revalidatePublicRankings();

    return NextResponse.json({
      ok: true,
      mergedCount,
      survivorId: keep.id,
      mergedNames,
    });
  } catch (e: unknown) {
    return jsonError(e);
  }
}
