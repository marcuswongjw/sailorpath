import { NextResponse } from "next/server";
import { and, eq } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import {
  equipmentItems,
  equipmentLogs,
  equipmentUsages,
  parentNotes,
  raceObservations,
  regattaResults,
  sailorAliases,
  sailorClaims,
  sailors,
} from "@/db/schema";
import { revalidatePublicRankings } from "@/lib/revalidatePublic";

/**
 * Merge duplicate sailor profiles.
 * POST { keepId, mergeId, forceOwnershipConflict?: boolean }
 *
 * Moves results, aliases, equipment, notes, observations, and claims onto keep,
 * then deletes merge. Refuses conflicting ownership unless forceOwnershipConflict.
 */
export async function POST(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();
    const keepId = String(body.keepId || "").trim();
    const mergeId = String(body.mergeId || "").trim();
    const forceOwnershipConflict = body.forceOwnershipConflict === true;

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

    const keepOwner = keepSailor.parentId || null;
    const mergeOwner = mergeSailor.parentId || null;
    if (
      keepOwner &&
      mergeOwner &&
      keepOwner !== mergeOwner &&
      !forceOwnershipConflict
    ) {
      return NextResponse.json(
        {
          error:
            "Both profiles are claimed by different accounts. Unclaim one side first, or pass forceOwnershipConflict=true to keep the survivor’s owner and drop the duplicate’s link.",
          code: "OWNERSHIP_CONFLICT",
          keepOwner,
          mergeOwner,
        },
        { status: 409 }
      );
    }

    const txResult = await db.transaction(async (tx) => {
      const mergeResults = await tx
        .select()
        .from(regattaResults)
        .where(eq(regattaResults.sailorId, mergeId));

      let resultsMoved = 0;
      let resultsMergedConflict = 0;
      let resultsDroppedConflict = 0;

      for (const row of mergeResults) {
        const existing = await tx
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
          await tx
            .update(regattaResults)
            .set({ sailorId: keepId, updatedAt: new Date() })
            .where(eq(regattaResults.id, row.id));
          resultsMoved++;
        } else {
          const keepRank = existing[0].rank ?? 9999;
          const mergeRank = row.rank ?? 9999;
          if (mergeRank < keepRank) {
            await tx
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
            await tx
              .update(regattaResults)
              .set({ totalScore: row.totalScore, updatedAt: new Date() })
              .where(eq(regattaResults.id, existing[0].id));
            resultsMergedConflict++;
          } else {
            resultsDroppedConflict++;
          }
          await tx
            .delete(regattaResults)
            .where(eq(regattaResults.id, row.id));
        }
      }

      // Move aliases from merge → keep
      const mergeAliases = await tx
        .select()
        .from(sailorAliases)
        .where(eq(sailorAliases.sailorId, mergeId));

      let aliasesMoved = 0;
      for (const a of mergeAliases) {
        try {
          await tx
            .update(sailorAliases)
            .set({ sailorId: keepId })
            .where(eq(sailorAliases.id, a.id));
          aliasesMoved++;
        } catch {
          await tx.delete(sailorAliases).where(eq(sailorAliases.id, a.id));
        }
      }

      for (const aliasName of [mergeSailor.name, mergeSailor.sailNumber].filter(
        Boolean
      ) as string[]) {
        if (!aliasName || aliasName === "SGP 000") continue;
        try {
          await tx.insert(sailorAliases).values({
            sailorId: keepId,
            aliasName: String(aliasName).trim(),
          });
          aliasesMoved++;
        } catch {
          /* already exists */
        }
      }

      // Equipment inventory + session usages
      const equipmentMoved = await tx
        .update(equipmentItems)
        .set({ sailorId: keepId, updatedAt: new Date() })
        .where(eq(equipmentItems.sailorId, mergeId))
        .returning({ id: equipmentItems.id });
      await tx
        .update(equipmentUsages)
        .set({ sailorId: keepId })
        .where(eq(equipmentUsages.sailorId, mergeId));

      // Legacy equipment logs
      await tx
        .update(equipmentLogs)
        .set({ sailorId: keepId })
        .where(eq(equipmentLogs.sailorId, mergeId));

      // Parent notes
      const notesMoved = await tx
        .update(parentNotes)
        .set({ sailorId: keepId, updatedAt: new Date() })
        .where(eq(parentNotes.sailorId, mergeId))
        .returning({ id: parentNotes.id });

      // Claims — re-point to keep (unique constraints are soft)
      const claimsMoved = await tx
        .update(sailorClaims)
        .set({ sailorId: keepId, updatedAt: new Date() })
        .where(eq(sailorClaims.sailorId, mergeId))
        .returning({ id: sailorClaims.id });

      // Observations — skip rows that would collide on unique(sailor, regatta, race)
      const mergeObs = await tx
        .select()
        .from(raceObservations)
        .where(eq(raceObservations.sailorId, mergeId));
      let observationsMoved = 0;
      let observationsDropped = 0;
      for (const obs of mergeObs) {
        const clash = await tx
          .select({ id: raceObservations.id })
          .from(raceObservations)
          .where(
            and(
              eq(raceObservations.sailorId, keepId),
              eq(raceObservations.regattaId, obs.regattaId),
              eq(raceObservations.raceNumber, obs.raceNumber)
            )
          )
          .limit(1);
        if (clash[0]) {
          await tx
            .delete(raceObservations)
            .where(eq(raceObservations.id, obs.id));
          observationsDropped++;
        } else {
          await tx
            .update(raceObservations)
            .set({ sailorId: keepId, updatedAt: new Date() })
            .where(eq(raceObservations.id, obs.id));
          observationsMoved++;
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
        "natSquadStatusJan27",
        "natSquadStatusJul27",
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
      if (
        (!keepSailor.sailNumber ||
          /^SGP\s*0+$/i.test(keepSailor.sailNumber)) &&
        mergeSailor.sailNumber &&
        !/^SGP\s*0+$/i.test(mergeSailor.sailNumber)
      ) {
        fill.sailNumber = mergeSailor.sailNumber;
      }
      if (
        !String(keepSailor.sailNumberIlca4 || "").trim() &&
        String(mergeSailor.sailNumberIlca4 || "").trim()
      ) {
        fill.sailNumberIlca4 = mergeSailor.sailNumberIlca4;
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

      // Ownership: prefer keep; if keep unclaimed, adopt merge owner
      let ownershipTransferred = false;
      if (!keepOwner && mergeOwner) {
        fill.parentId = mergeOwner;
        fill.ownerRelation =
          mergeSailor.ownerRelation || keepSailor.ownerRelation || null;
        ownershipTransferred = true;
      }

      if (Object.keys(fill).length > 1) {
        await tx.update(sailors).set(fill).where(eq(sailors.id, keepId));
      }

      await tx.delete(sailors).where(eq(sailors.id, mergeId));

      const [updatedKeep] = await tx
        .select()
        .from(sailors)
        .where(eq(sailors.id, keepId))
        .limit(1);

      return {
        updatedKeep,
        resultsMoved,
        resultsMergedConflict,
        resultsDroppedConflict,
        aliasesMoved,
        equipmentMoved: equipmentMoved.length,
        notesMoved: notesMoved.length,
        claimsMoved: claimsMoved.length,
        observationsMoved,
        observationsDropped,
        ownershipTransferred,
      };
    });

    revalidatePublicRankings(`sailors:merge:${keepId}`);
    return NextResponse.json({
      ok: true,
      message: `Merged “${mergeSailor.name}” into “${keepSailor.name}”.`,
      keep: txResult.updatedKeep,
      mergeDeleted: mergeId,
      resultsMoved: txResult.resultsMoved,
      resultsMergedConflict: txResult.resultsMergedConflict,
      resultsDroppedConflict: txResult.resultsDroppedConflict,
      aliasesMoved: txResult.aliasesMoved,
      equipmentMoved: txResult.equipmentMoved,
      notesMoved: txResult.notesMoved,
      claimsMoved: txResult.claimsMoved,
      observationsMoved: txResult.observationsMoved,
      observationsDropped: txResult.observationsDropped,
      ownershipTransferred: txResult.ownershipTransferred,
    });
  } catch (e) {
    console.error("sailors merge", e);
    return jsonError(e);
  }
}
