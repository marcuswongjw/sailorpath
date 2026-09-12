import { and, eq, inArray } from "drizzle-orm";
import { db } from "@/db";
import {
  coachActionReviews,
  coachDevelopmentRecords,
  coachFollowedSailors,
  coachSailorNotes,
  coachSquadMembers,
  equipmentItems,
  equipmentLogs,
  equipmentUsages,
  parentNotes,
  raceObservations,
  regattaRaceResults,
  regattaResults,
  sailorAliases,
  sailorClaims,
  sailors,
} from "@/db/schema";

/**
 * Keep this inventory in sync with every FK in schema.ts that ultimately points
 * at sailors.id. The dependent race-score table is listed explicitly because a
 * conflicting result must move its scores before the source result is deleted.
 */
export const SAILOR_RELATIONSHIP_MERGE_PLAN = [
  { table: "regattaResults", strategy: "reconcile-regatta" },
  { table: "regattaRaceResults", strategy: "reconcile-through-result" },
  { table: "sailorAliases", strategy: "repoint" },
  { table: "sailorClaims", strategy: "repoint" },
  { table: "raceObservations", strategy: "target-wins-conflict" },
  { table: "equipmentLogs", strategy: "repoint" },
  { table: "equipmentItems", strategy: "repoint" },
  { table: "equipmentUsages", strategy: "repoint" },
  { table: "parentNotes", strategy: "repoint" },
  { table: "coachSquadMembers", strategy: "target-wins-conflict" },
  { table: "coachFollowedSailors", strategy: "target-wins-conflict" },
  { table: "coachSailorNotes", strategy: "reconcile-target-note" },
  { table: "coachDevelopmentRecords", strategy: "repoint" },
  { table: "coachActionReviews", strategy: "target-wins-conflict" },
] as const;

type Identified = { id: string };

/** Pure conflict planner: target rows are canonical; non-conflicting source rows move. */
export function splitSourceRowsByTargetConflict<T extends Identified>(
  sourceRows: readonly T[],
  targetRows: readonly T[],
  conflictKey: (row: T) => string
): { moveIds: string[]; conflictIds: string[] } {
  const targetKeys = new Set(targetRows.map(conflictKey));
  const moveIds: string[] = [];
  const conflictIds: string[] = [];

  for (const row of sourceRows) {
    (targetKeys.has(conflictKey(row)) ? conflictIds : moveIds).push(row.id);
  }

  return { moveIds, conflictIds };
}

export type SailorMergeErrorCode =
  | "KEEP_NOT_FOUND"
  | "MERGE_NOT_FOUND"
  | "OWNERSHIP_CONFLICT"
  | "SAME_SAILOR";

export class SailorMergeError extends Error {
  constructor(
    public readonly code: SailorMergeErrorCode,
    message: string,
    public readonly status: number,
    public readonly details: Record<string, string | null> = {}
  ) {
    super(message);
    this.name = "SailorMergeError";
  }
}

export type MergeSailorsOptions = {
  keepId: string;
  mergeId: string;
  forceOwnershipConflict?: boolean;
};

export async function mergeSailors({
  keepId,
  mergeId,
  forceOwnershipConflict = false,
}: MergeSailorsOptions) {
  if (keepId === mergeId) {
    throw new SailorMergeError(
      "SAME_SAILOR",
      "Cannot merge a sailor into themselves",
      400
    );
  }

  // This service deliberately owns the only transaction. Callers must not wrap it.
  return db.transaction(async (tx) => {
    const lockedSailors = await tx
      .select()
      .from(sailors)
      .where(inArray(sailors.id, [keepId, mergeId]))
      .for("update");
    const keepSailor = lockedSailors.find((row) => row.id === keepId);
    const mergeSailor = lockedSailors.find((row) => row.id === mergeId);

    if (!keepSailor) {
      throw new SailorMergeError(
        "KEEP_NOT_FOUND",
        "keep sailor not found",
        404
      );
    }
    if (!mergeSailor) {
      throw new SailorMergeError(
        "MERGE_NOT_FOUND",
        "merge (duplicate) sailor not found",
        404
      );
    }

    const keepOwner = keepSailor.parentId || null;
    const mergeOwner = mergeSailor.parentId || null;
    if (
      keepOwner &&
      mergeOwner &&
      keepOwner !== mergeOwner &&
      !forceOwnershipConflict
    ) {
      throw new SailorMergeError(
        "OWNERSHIP_CONFLICT",
        "Both profiles are claimed by different accounts. Unclaim one side first, or pass forceOwnershipConflict=true to keep the survivor’s owner and drop the duplicate’s link.",
        409,
        { keepOwner, mergeOwner }
      );
    }

    const now = new Date();
    const mergeResults = await tx
      .select()
      .from(regattaResults)
      .where(eq(regattaResults.sailorId, mergeId));

    let resultsMoved = 0;
    let resultsMergedConflict = 0;
    let resultsDroppedConflict = 0;
    let raceScoresMoved = 0;
    let raceScoresDroppedConflict = 0;

    for (const sourceResult of mergeResults) {
      const [targetResult] = await tx
        .select()
        .from(regattaResults)
        .where(
          and(
            eq(regattaResults.sailorId, keepId),
            eq(regattaResults.regattaId, sourceResult.regattaId)
          )
        )
        .limit(1);

      if (!targetResult) {
        await tx
          .update(regattaResults)
          .set({ sailorId: keepId, updatedAt: now })
          .where(eq(regattaResults.id, sourceResult.id));
        resultsMoved++;
        continue;
      }

      // Preserve all non-conflicting official race scores before deleting the
      // duplicate aggregate result (whose FK would otherwise cascade them).
      const [sourceScores, targetScores] = await Promise.all([
        tx
          .select({ id: regattaRaceResults.id, raceNumber: regattaRaceResults.raceNumber })
          .from(regattaRaceResults)
          .where(eq(regattaRaceResults.regattaResultId, sourceResult.id)),
        tx
          .select({ id: regattaRaceResults.id, raceNumber: regattaRaceResults.raceNumber })
          .from(regattaRaceResults)
          .where(eq(regattaRaceResults.regattaResultId, targetResult.id)),
      ]);
      const scorePlan = splitSourceRowsByTargetConflict(
        sourceScores,
        targetScores,
        (row) => String(row.raceNumber)
      );
      if (scorePlan.conflictIds.length > 0) {
        await tx
          .delete(regattaRaceResults)
          .where(inArray(regattaRaceResults.id, scorePlan.conflictIds));
      }
      if (scorePlan.moveIds.length > 0) {
        await tx
          .update(regattaRaceResults)
          .set({ regattaResultId: targetResult.id, updatedAt: now })
          .where(inArray(regattaRaceResults.id, scorePlan.moveIds));
      }
      raceScoresMoved += scorePlan.moveIds.length;
      raceScoresDroppedConflict += scorePlan.conflictIds.length;

      const keepRank = targetResult.rank ?? 9999;
      const mergeRank = sourceResult.rank ?? 9999;
      if (mergeRank < keepRank) {
        await tx
          .update(regattaResults)
          .set({
            rank: sourceResult.rank,
            nettScore: sourceResult.nettScore,
            totalScore: sourceResult.totalScore ?? targetResult.totalScore,
            updatedAt: now,
          })
          .where(eq(regattaResults.id, targetResult.id));
        resultsMergedConflict++;
      } else if (
        targetResult.totalScore == null &&
        sourceResult.totalScore != null
      ) {
        await tx
          .update(regattaResults)
          .set({ totalScore: sourceResult.totalScore, updatedAt: now })
          .where(eq(regattaResults.id, targetResult.id));
        resultsMergedConflict++;
      } else {
        resultsDroppedConflict++;
      }

      await tx
        .delete(regattaResults)
        .where(eq(regattaResults.id, sourceResult.id));
    }

    // Alias names are globally unique, so changing sailor_id cannot conflict.
    const aliasesMoved = await tx
      .update(sailorAliases)
      .set({ sailorId: keepId })
      .where(eq(sailorAliases.sailorId, mergeId))
      .returning({ id: sailorAliases.id });

    const aliasCandidates = Array.from(
      new Set([mergeSailor.name, mergeSailor.sailNumber].map((value) => value?.trim()))
    ).filter((value): value is string => Boolean(value) && value !== "SGP 000");
    let aliasesAdded = 0;
    for (const aliasName of aliasCandidates) {
      const inserted = await tx
        .insert(sailorAliases)
        .values({ sailorId: keepId, aliasName })
        .onConflictDoNothing({ target: sailorAliases.aliasName })
        .returning({ id: sailorAliases.id });
      aliasesAdded += inserted.length;
    }

    // Unique(squad_id, sailor_id): keep the target membership on collision.
    const [sourceSquads, targetSquads] = await Promise.all([
      tx
        .select({ id: coachSquadMembers.id, squadId: coachSquadMembers.squadId })
        .from(coachSquadMembers)
        .where(eq(coachSquadMembers.sailorId, mergeId)),
      tx
        .select({ id: coachSquadMembers.id, squadId: coachSquadMembers.squadId })
        .from(coachSquadMembers)
        .where(eq(coachSquadMembers.sailorId, keepId)),
    ]);
    const squadPlan = splitSourceRowsByTargetConflict(
      sourceSquads,
      targetSquads,
      (row) => row.squadId
    );
    if (squadPlan.conflictIds.length > 0) {
      await tx
        .delete(coachSquadMembers)
        .where(inArray(coachSquadMembers.id, squadPlan.conflictIds));
    }
    if (squadPlan.moveIds.length > 0) {
      await tx
        .update(coachSquadMembers)
        .set({ sailorId: keepId })
        .where(inArray(coachSquadMembers.id, squadPlan.moveIds));
    }

    // Unique(coach_id, sailor_id): keep the target follow on collision.
    const [sourceFollows, targetFollows] = await Promise.all([
      tx
        .select({ id: coachFollowedSailors.id, coachId: coachFollowedSailors.coachId })
        .from(coachFollowedSailors)
        .where(eq(coachFollowedSailors.sailorId, mergeId)),
      tx
        .select({ id: coachFollowedSailors.id, coachId: coachFollowedSailors.coachId })
        .from(coachFollowedSailors)
        .where(eq(coachFollowedSailors.sailorId, keepId)),
    ]);
    const followPlan = splitSourceRowsByTargetConflict(
      sourceFollows,
      targetFollows,
      (row) => row.coachId
    );
    if (followPlan.conflictIds.length > 0) {
      await tx
        .delete(coachFollowedSailors)
        .where(inArray(coachFollowedSailors.id, followPlan.conflictIds));
    }
    if (followPlan.moveIds.length > 0) {
      await tx
        .update(coachFollowedSailors)
        .set({ sailorId: keepId })
        .where(inArray(coachFollowedSailors.id, followPlan.moveIds));
    }

    // Unique(coach_id, sailor_id): preserve the canonical target note row. If
    // possible, append distinct source text without violating the 4,000-char check.
    const [sourceCoachNotes, targetCoachNotes] = await Promise.all([
      tx
        .select({ id: coachSailorNotes.id, coachId: coachSailorNotes.coachId, note: coachSailorNotes.note })
        .from(coachSailorNotes)
        .where(eq(coachSailorNotes.sailorId, mergeId)),
      tx
        .select({ id: coachSailorNotes.id, coachId: coachSailorNotes.coachId, note: coachSailorNotes.note })
        .from(coachSailorNotes)
        .where(eq(coachSailorNotes.sailorId, keepId)),
    ]);
    const coachNotePlan = splitSourceRowsByTargetConflict(
      sourceCoachNotes,
      targetCoachNotes,
      (row) => row.coachId
    );
    const targetNoteByCoach = new Map(
      targetCoachNotes.map((row) => [row.coachId, row])
    );
    for (const sourceNote of sourceCoachNotes) {
      if (!coachNotePlan.conflictIds.includes(sourceNote.id)) continue;
      const targetNote = targetNoteByCoach.get(sourceNote.coachId);
      if (!targetNote || targetNote.note === sourceNote.note) continue;
      const combined = `${targetNote.note}\n\nMerged from duplicate sailor:\n${sourceNote.note}`;
      if (combined.length <= 4000) {
        await tx
          .update(coachSailorNotes)
          .set({ note: combined, updatedAt: now })
          .where(eq(coachSailorNotes.id, targetNote.id));
      }
    }
    if (coachNotePlan.conflictIds.length > 0) {
      await tx
        .delete(coachSailorNotes)
        .where(inArray(coachSailorNotes.id, coachNotePlan.conflictIds));
    }
    if (coachNotePlan.moveIds.length > 0) {
      await tx
        .update(coachSailorNotes)
        .set({ sailorId: keepId })
        .where(inArray(coachSailorNotes.id, coachNotePlan.moveIds));
    }

    // Development history has no unique sailor constraint, so every row moves.
    const developmentMoved = await tx
      .update(coachDevelopmentRecords)
      .set({ sailorId: keepId })
      .where(eq(coachDevelopmentRecords.sailorId, mergeId))
      .returning({ id: coachDevelopmentRecords.id });

    // Unique(coach_id, action_key): retain an existing canonical target review.
    const [sourceActions, targetActions] = await Promise.all([
      tx
        .select({ id: coachActionReviews.id, coachId: coachActionReviews.coachId, actionKey: coachActionReviews.actionKey })
        .from(coachActionReviews)
        .where(eq(coachActionReviews.sailorId, mergeId)),
      tx
        .select({ id: coachActionReviews.id, coachId: coachActionReviews.coachId, actionKey: coachActionReviews.actionKey })
        .from(coachActionReviews)
        .where(eq(coachActionReviews.sailorId, keepId)),
    ]);
    const actionPlan = splitSourceRowsByTargetConflict(
      sourceActions,
      targetActions,
      (row) => JSON.stringify([row.coachId, row.actionKey])
    );
    if (actionPlan.conflictIds.length > 0) {
      await tx
        .delete(coachActionReviews)
        .where(inArray(coachActionReviews.id, actionPlan.conflictIds));
    }
    if (actionPlan.moveIds.length > 0) {
      await tx
        .update(coachActionReviews)
        .set({ sailorId: keepId })
        .where(inArray(coachActionReviews.id, actionPlan.moveIds));
    }

    // Parent/owner observations have a unique sailor/regatta/race key.
    const [sourceObservations, targetObservations] = await Promise.all([
      tx
        .select({
          id: raceObservations.id,
          regattaId: raceObservations.regattaId,
          raceNumber: raceObservations.raceNumber,
        })
        .from(raceObservations)
        .where(eq(raceObservations.sailorId, mergeId)),
      tx
        .select({
          id: raceObservations.id,
          regattaId: raceObservations.regattaId,
          raceNumber: raceObservations.raceNumber,
        })
        .from(raceObservations)
        .where(eq(raceObservations.sailorId, keepId)),
    ]);
    const observationPlan = splitSourceRowsByTargetConflict(
      sourceObservations,
      targetObservations,
      (row) => JSON.stringify([row.regattaId, row.raceNumber])
    );
    if (observationPlan.conflictIds.length > 0) {
      await tx
        .delete(raceObservations)
        .where(inArray(raceObservations.id, observationPlan.conflictIds));
    }
    if (observationPlan.moveIds.length > 0) {
      await tx
        .update(raceObservations)
        .set({ sailorId: keepId, updatedAt: now })
        .where(inArray(raceObservations.id, observationPlan.moveIds));
    }

    // Remaining direct FKs have no sailor-based unique constraint.
    const equipmentMoved = await tx
      .update(equipmentItems)
      .set({ sailorId: keepId, updatedAt: now })
      .where(eq(equipmentItems.sailorId, mergeId))
      .returning({ id: equipmentItems.id });
    const equipmentUsagesMoved = await tx
      .update(equipmentUsages)
      .set({ sailorId: keepId })
      .where(eq(equipmentUsages.sailorId, mergeId))
      .returning({ id: equipmentUsages.id });
    const equipmentLogsMoved = await tx
      .update(equipmentLogs)
      .set({ sailorId: keepId })
      .where(eq(equipmentLogs.sailorId, mergeId))
      .returning({ id: equipmentLogs.id });
    const notesMoved = await tx
      .update(parentNotes)
      .set({ sailorId: keepId, updatedAt: now })
      .where(eq(parentNotes.sailorId, mergeId))
      .returning({ id: parentNotes.id });
    const claimsMoved = await tx
      .update(sailorClaims)
      .set({ sailorId: keepId, updatedAt: now })
      .where(eq(sailorClaims.sailorId, mergeId))
      .returning({ id: sailorClaims.id });

    // Fill blank profile fields on the target from the duplicate.
    const fill: Record<string, unknown> = { updatedAt: now };
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
    for (const field of textFields) {
      const keepValue = keepSailor[field];
      const mergeValue = mergeSailor[field];
      const blank =
        keepValue == null ||
        keepValue === "" ||
        (field === "club" && keepValue === "N/A");
      if (blank && mergeValue != null && mergeValue !== "" && mergeValue !== "N/A") {
        fill[field] = mergeValue;
      }
    }
    if (
      (!keepSailor.sailNumber || /^SGP\s*0+$/i.test(keepSailor.sailNumber)) &&
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
    for (const field of ["dob", "goldEntryDate", "silverEntryDate", "dropDate"] as const) {
      if (!keepSailor[field] && mergeSailor[field]) fill[field] = mergeSailor[field];
    }
    for (const field of [
      "weight",
      "histRankingJun24",
      "histRankingDec24",
      "histRankingJun25",
      "histRankingDec25",
      "histRankingJun26",
    ] as const) {
      if (keepSailor[field] == null && mergeSailor[field] != null) {
        fill[field] = mergeSailor[field];
      }
    }

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

    // Every direct and dependent relationship is now safe; this delete should
    // cascade nothing except an unexpected future FK omitted from the plan.
    await tx.delete(sailors).where(eq(sailors.id, mergeId));

    const [updatedKeep] = await tx
      .select()
      .from(sailors)
      .where(eq(sailors.id, keepId))
      .limit(1);

    return {
      keepSailor,
      mergeSailor,
      updatedKeep,
      resultsMoved,
      resultsMergedConflict,
      resultsDroppedConflict,
      raceScoresMoved,
      raceScoresDroppedConflict,
      aliasesMoved: aliasesMoved.length + aliasesAdded,
      equipmentMoved: equipmentMoved.length,
      equipmentUsagesMoved: equipmentUsagesMoved.length,
      equipmentLogsMoved: equipmentLogsMoved.length,
      notesMoved: notesMoved.length,
      claimsMoved: claimsMoved.length,
      observationsMoved: observationPlan.moveIds.length,
      observationsDropped: observationPlan.conflictIds.length,
      squadMembershipsMoved: squadPlan.moveIds.length,
      squadMembershipsDroppedConflict: squadPlan.conflictIds.length,
      followedSailorsMoved: followPlan.moveIds.length,
      followedSailorsDroppedConflict: followPlan.conflictIds.length,
      coachNotesMoved: coachNotePlan.moveIds.length,
      coachNotesReconciledConflict: coachNotePlan.conflictIds.length,
      developmentRecordsMoved: developmentMoved.length,
      actionReviewsMoved: actionPlan.moveIds.length,
      actionReviewsDroppedConflict: actionPlan.conflictIds.length,
      ownershipTransferred,
    };
  });
}
