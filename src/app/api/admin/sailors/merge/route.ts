import { NextResponse } from "next/server";
import { and, eq } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattaResults, sailorAliases, sailors } from "@/db/schema";

/**
 * Merge duplicate sailor profiles.
 * POST { keepId, mergeId }
 * - Moves all regatta_results from mergeId → keepId (on conflict keeps keepId row,
 *   or takes merge row if keep has worse rank / missing)
 * - Moves aliases; adds merge name as alias of keep
 * - Fills blank keep profile fields from merge
 * - Deletes merge sailor (cascade leftovers)
 */
export async function POST(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();
    const keepId = String(body.keepId || "").trim();
    const mergeId = String(body.mergeId || "").trim();

    if (!keepId || !mergeId) {
      return NextResponse.json(
        { error: "keepId and mergeId are required" },
        { status: 400 }
      );
    }
    if (keepId === mergeId) {
      return NextResponse.json(
        { error: "Cannot merge a sailor into themselves" },
        { status: 400 }
      );
    }

    const [keep, merge] = await Promise.all([
      db.select().from(sailors).where(eq(sailors.id, keepId)).limit(1),
      db.select().from(sailors).where(eq(sailors.id, mergeId)).limit(1),
    ]);
    if (!keep[0]) {
      return NextResponse.json({ error: "keep sailor not found" }, { status: 404 });
    }
    if (!merge[0]) {
      return NextResponse.json(
        { error: "merge (duplicate) sailor not found" },
        { status: 404 }
      );
    }

    const keepSailor = keep[0];
    const mergeSailor = merge[0];

    const mergeResults = await db
      .select()
      .from(regattaResults)
      .where(eq(regattaResults.sailorId, mergeId));

    let resultsMoved = 0;
    let resultsMergedConflict = 0;
    let resultsDroppedConflict = 0;

    for (const row of mergeResults) {
      const existing = await db
        .select()
        .from(regattaResults)
        .where(
          and(
            eq(regattaResults.sailorId, keepId),
            eq(regattaResults.regattaId, row.regattaId)
          )
        )
        .limit(1);

      if (!existing[0]) {
        await db
          .update(regattaResults)
          .set({ sailorId: keepId, updatedAt: new Date() })
          .where(eq(regattaResults.id, row.id));
        resultsMoved++;
      } else {
        // Both have a result for same regatta — keep better (lower) rank
        const keepRank = existing[0].rank ?? 9999;
        const mergeRank = row.rank ?? 9999;
        if (mergeRank < keepRank) {
          await db
            .update(regattaResults)
            .set({
              rank: row.rank,
              nettScore: row.nettScore,
              totalScore: row.totalScore ?? existing[0].totalScore,
              updatedAt: new Date(),
            })
            .where(eq(regattaResults.id, existing[0].id));
          resultsMergedConflict++;
        } else if (
          existing[0].totalScore == null &&
          row.totalScore != null
        ) {
          await db
            .update(regattaResults)
            .set({ totalScore: row.totalScore, updatedAt: new Date() })
            .where(eq(regattaResults.id, existing[0].id));
          resultsMergedConflict++;
        } else {
          resultsDroppedConflict++;
        }
        await db
          .delete(regattaResults)
          .where(eq(regattaResults.id, row.id));
      }
    }

    // Move aliases from merge → keep
    const mergeAliases = await db
      .select()
      .from(sailorAliases)
      .where(eq(sailorAliases.sailorId, mergeId));

    let aliasesMoved = 0;
    for (const a of mergeAliases) {
      try {
        await db
          .update(sailorAliases)
          .set({ sailorId: keepId })
          .where(eq(sailorAliases.id, a.id));
        aliasesMoved++;
      } catch {
        // unique alias conflict — delete duplicate alias
        await db.delete(sailorAliases).where(eq(sailorAliases.id, a.id));
      }
    }

    // Keep merge name (and sail number label) as aliases for future import matching
    for (const aliasName of [mergeSailor.name, mergeSailor.sailNumber].filter(
      Boolean
    ) as string[]) {
      if (!aliasName || aliasName === "SGP 000") continue;
      try {
        await db.insert(sailorAliases).values({
          sailorId: keepId,
          aliasName: String(aliasName).trim(),
        });
        aliasesMoved++;
      } catch {
        /* already exists */
      }
    }

    // Fill blank profile fields on keep from merge
    const fill: Record<string, unknown> = { updatedAt: new Date() };
    const textFields = [
      "club",
      "school",
      "nationality",
      "gender",
      "bio",
      "nationalSquadStatus",
      "currentFleet",
      "instagram",
      "natSquadStatusJan25",
      "natSquadStatusJul25",
      "natSquadStatusJan26",
      "natSquadStatusJul26",
      "worlds",
      "european",
      "asian",
      "seaGames",
    ] as const;
    for (const f of textFields) {
      const kv = keepSailor[f];
      const mv = mergeSailor[f];
      const blank =
        kv == null ||
        kv === "" ||
        (f === "club" && kv === "N/A");
      if (blank && mv != null && mv !== "" && mv !== "N/A") {
        fill[f] = mv;
      }
    }
    // sail number: replace placeholder only
    if (
      (!keepSailor.sailNumber ||
        /^SGP\s*0+$/i.test(keepSailor.sailNumber)) &&
      mergeSailor.sailNumber &&
      !/^SGP\s*0+$/i.test(mergeSailor.sailNumber)
    ) {
      fill.sailNumber = mergeSailor.sailNumber;
    }
    const dateFields = [
      "dob",
      "goldEntryDate",
      "silverEntryDate",
      "dropDate",
    ] as const;
    for (const f of dateFields) {
      if (!keepSailor[f] && mergeSailor[f]) fill[f] = mergeSailor[f];
    }
    const intFields = [
      "weight",
      "histRankingJun24",
      "histRankingDec24",
      "histRankingJun25",
      "histRankingDec25",
      "histRankingJun26",
    ] as const;
    for (const f of intFields) {
      if (keepSailor[f] == null && mergeSailor[f] != null) {
        fill[f] = mergeSailor[f];
      }
    }

    if (Object.keys(fill).length > 1) {
      await db.update(sailors).set(fill).where(eq(sailors.id, keepId));
    }

    // Delete duplicate sailor (results should already be moved; cascade cleans rest)
    await db.delete(sailors).where(eq(sailors.id, mergeId));

    const [updatedKeep] = await db
      .select()
      .from(sailors)
      .where(eq(sailors.id, keepId))
      .limit(1);

    return NextResponse.json({
      ok: true,
      message: `Merged “${mergeSailor.name}” into “${keepSailor.name}”.`,
      keep: updatedKeep,
      mergeDeleted: mergeId,
      resultsMoved,
      resultsMergedConflict,
      resultsDroppedConflict,
      aliasesMoved,
    });
  } catch (e) {
    console.error("sailors merge", e);
    return jsonError(e);
  }
}
