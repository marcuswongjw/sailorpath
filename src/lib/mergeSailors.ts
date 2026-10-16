import { eq, inArray } from "drizzle-orm";
import { db } from "@/db";
import { buildSailorMergePlan } from "@/lib/sailorMergePlan";
import { toAdminAuditJsonValue } from "@/lib/adminAuditDetails";
import {
  asianOptimistIndexDuplicateReviews,
  asianOptimistIndexSailors,
  adminChangeLog,
  coachActionReviews,
  coachDevelopmentRecords,
  coachFollowedSailors,
  followedSailors,
  coachSailorNotes,
  coachSquadMembers,
  equipmentItems,
  equipmentLogs,
  equipmentUsages,
  newsArticles,
  parentNotes,
  raceObservations,
  regattaResultParticipants,
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
  { table: "regattaResultParticipants", strategy: "repoint-entry-membership" },
  { table: "regattaRaceResults", strategy: "reconcile-through-result" },
  { table: "asianOptimistIndexSailors", strategy: "repoint" },
  { table: "asianOptimistIndexDuplicateReviews", strategy: "target-wins-conflict" },
  { table: "sailorAliases", strategy: "repoint" },
  { table: "sailorClaims", strategy: "repoint" },
  { table: "raceObservations", strategy: "target-wins-conflict" },
  { table: "equipmentLogs", strategy: "repoint" },
  { table: "equipmentItems", strategy: "repoint" },
  { table: "equipmentUsages", strategy: "repoint" },
  { table: "newsArticles", strategy: "repoint" },
  { table: "parentNotes", strategy: "repoint" },
  { table: "coachSquadMembers", strategy: "target-wins-conflict" },
  { table: "coachFollowedSailors", strategy: "target-wins-conflict" },
  { table: "followedSailors", strategy: "target-wins-conflict" },
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
  | "SAME_SAILOR"
  | "PREFLIGHT_REQUIRED"
  | "IDENTITY_CONFLICT"
  | "STALE_MERGE_PLAN";

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
  reviewToken?: string;
  identityEvidence?: string;
  actor?: { userId: string; email?: string | null };
};

export async function mergeSailors({
  keepId,
  mergeId,
  reviewToken,
  identityEvidence,
  actor,
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
      .orderBy(sailors.id)
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

    const plan = await buildSailorMergePlan(tx, keepId, mergeId);
    if (!plan.canMerge) {
      throw new SailorMergeError("IDENTITY_CONFLICT", plan.conflicts.join(" "), 409);
    }
    if (!reviewToken || !identityEvidence || identityEvidence.trim().length < 10 || identityEvidence.length > 2000) {
      throw new SailorMergeError("PREFLIGHT_REQUIRED", "Review this explicit survivor/source pair and record official identity evidence before merging.", 409);
    }
    if (reviewToken !== plan.reviewToken) {
      throw new SailorMergeError("STALE_MERGE_PLAN", "These profiles or results changed after review. Review a fresh merge plan.", 409);
    }
    const keepOwner = keepSailor.parentId || null;
    const mergeOwner = mergeSailor.parentId || null;

    const now = new Date();
    const mergeResults = await tx
      .select()
      .from(regattaResults)
      .where(eq(regattaResults.sailorId, mergeId));

    let resultsMoved = 0;
    const resultsMergedConflict = 0;
    const resultsDroppedConflict = 0;
    const raceScoresMoved = 0;
    const raceScoresDroppedConflict = 0;
    // Preflight rejects every shared sheet before any write. Update ownership
    // only: result IDs, every race/discard/code, totals and evidence stay intact.
    for (const sourceResult of mergeResults) {
      await tx.update(regattaResults)
        .set({ sailorId: keepId, updatedAt: now })
        .where(eq(regattaResults.id, sourceResult.id));
      resultsMoved++;
    }

    // A duplicate can also be the second sailor in a crew entry. Repoint that
    // membership without duplicating the boat result; if both duplicate
    // profiles were listed on the same entry, retain the canonical member only.
    const [sourceParticipants, targetParticipants] = await Promise.all([
      tx
        .select({
          id: regattaResultParticipants.id,
          regattaResultId: regattaResultParticipants.regattaResultId,
        })
        .from(regattaResultParticipants)
        .where(eq(regattaResultParticipants.sailorId, mergeId)),
      tx
        .select({
          id: regattaResultParticipants.id,
          regattaResultId: regattaResultParticipants.regattaResultId,
        })
        .from(regattaResultParticipants)
        .where(eq(regattaResultParticipants.sailorId, keepId)),
    ]);
    const targetEntryIds = new Set(
      targetParticipants.map((participant) => participant.regattaResultId)
    );
    const duplicateParticipantIds = sourceParticipants
      .filter((participant) => targetEntryIds.has(participant.regattaResultId))
      .map((participant) => participant.id);
    const movedParticipantIds = sourceParticipants
      .filter((participant) => !targetEntryIds.has(participant.regattaResultId))
      .map((participant) => participant.id);
    if (duplicateParticipantIds.length > 0) {
      await tx
        .delete(regattaResultParticipants)
        .where(inArray(regattaResultParticipants.id, duplicateParticipantIds));
    }
    if (movedParticipantIds.length > 0) {
      await tx
        .update(regattaResultParticipants)
        .set({ sailorId: keepId, updatedAt: now })
        .where(inArray(regattaResultParticipants.id, movedParticipantIds));
    }

    // Alias names are globally unique, so changing sailor_id cannot conflict.
    const aliasesMoved = await tx
      .update(sailorAliases)
      .set({ sailorId: keepId })
      .where(eq(sailorAliases.sailorId, mergeId))
      .returning({ id: sailorAliases.id });

    const aliasCandidates = Array.from(
      new Set([mergeSailor.name].map((value) => value?.trim()))
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

    // Unique(follower_profile_id, sailor_id): keep the target follow on collision.
    const [sourceProfileFollows, targetProfileFollows] = await Promise.all([
      tx
        .select({
          id: followedSailors.id,
          followerProfileId: followedSailors.followerProfileId,
        })
        .from(followedSailors)
        .where(eq(followedSailors.sailorId, mergeId)),
      tx
        .select({
          id: followedSailors.id,
          followerProfileId: followedSailors.followerProfileId,
        })
        .from(followedSailors)
        .where(eq(followedSailors.sailorId, keepId)),
    ]);
    const profileFollowPlan = splitSourceRowsByTargetConflict(
      sourceProfileFollows,
      targetProfileFollows,
      (row) => row.followerProfileId
    );
    if (profileFollowPlan.conflictIds.length > 0) {
      await tx
        .delete(followedSailors)
        .where(inArray(followedSailors.id, profileFollowPlan.conflictIds));
    }
    if (profileFollowPlan.moveIds.length > 0) {
      await tx
        .update(followedSailors)
        .set({ sailorId: keepId })
        .where(inArray(followedSailors.id, profileFollowPlan.moveIds));
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
    const newsArticlesMoved = await tx
      .update(newsArticles)
      .set({ relatedSailorId: keepId, updatedAt: now })
      .where(eq(newsArticles.relatedSailorId, mergeId))
      .returning({ id: newsArticles.id });
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
    // Index identities are independent of the source result rows. Repointing
    // them preserves the public profile link even when an imported profile is
    // merged into an established SailorPath sailor.
    const indexSailorsMoved = await tx
      .update(asianOptimistIndexSailors)
      .set({ sailorId: keepId, matchStatus: "matched", updatedAt: now })
      .where(eq(asianOptimistIndexSailors.sailorId, mergeId))
      .returning({ id: asianOptimistIndexSailors.id });

    // An Index duplicate-review row names a candidate SailorPath profile. If
    // that candidate is merged, retain the survivor's review on collision so
    // its administrator decision and audit trail stay canonical.
    const [sourceIndexReviews, targetIndexReviews] = await Promise.all([
      tx
        .select({
          id: asianOptimistIndexDuplicateReviews.id,
          indexSailorId: asianOptimistIndexDuplicateReviews.indexSailorId,
        })
        .from(asianOptimistIndexDuplicateReviews)
        .where(eq(asianOptimistIndexDuplicateReviews.candidateSailorId, mergeId)),
      tx
        .select({
          id: asianOptimistIndexDuplicateReviews.id,
          indexSailorId: asianOptimistIndexDuplicateReviews.indexSailorId,
        })
        .from(asianOptimistIndexDuplicateReviews)
        .where(eq(asianOptimistIndexDuplicateReviews.candidateSailorId, keepId)),
    ]);
    const indexReviewPlan = splitSourceRowsByTargetConflict(
      sourceIndexReviews,
      targetIndexReviews,
      (row) => row.indexSailorId
    );
    if (indexReviewPlan.conflictIds.length > 0) {
      await tx
        .delete(asianOptimistIndexDuplicateReviews)
        .where(inArray(asianOptimistIndexDuplicateReviews.id, indexReviewPlan.conflictIds));
    }
    if (indexReviewPlan.moveIds.length > 0) {
      await tx
        .update(asianOptimistIndexDuplicateReviews)
        .set({ candidateSailorId: keepId, updatedAt: now })
        .where(inArray(asianOptimistIndexDuplicateReviews.id, indexReviewPlan.moveIds));
    }

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
      (!keepSailor.sailNumber || /^(?:SGP\s*)?0+$/i.test(keepSailor.sailNumber)) &&
      mergeSailor.sailNumber &&
      !/^(?:SGP\s*)?0+$/i.test(mergeSailor.sailNumber)
    ) {
      fill.sailNumber = mergeSailor.sailNumber;
    }
    if (
      !String(keepSailor.sailNumberIlca4 || "").trim() &&
      String(mergeSailor.sailNumberIlca4 || "").trim()
    ) {
      fill.sailNumberIlca4 = mergeSailor.sailNumberIlca4;
    }
    if (
      !String(keepSailor.boardNumber || "").trim() &&
      String(mergeSailor.boardNumber || "").trim()
    ) {
      fill.boardNumber = mergeSailor.boardNumber;
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
      // When merging a claimed profile into an unclaimed one, the claimed
      // sailor/parent edits are recognised as correct and final:
      for (const field of [
        "name",
        "bio",
        "instagram",
        "avatarUrl",
        "school",
        "club",
        "sailNumber",
        "sailNumberIlca4",
        "boardNumber",
        "dob",
        "weight",
        "sailingJourney",
        "gender",
        "nationality",
        "hullBrand",
        "sailMake",
        "foilBrand",
        "mast",
        "equipmentNotes",
        "hullBrandIlca4",
        "sailMakeIlca4",
        "foilBrandIlca4",
        "mastIlca4",
        "equipmentNotesIlca4",
      ] as const) {
        if (mergeSailor[field] != null && mergeSailor[field] !== "") {
          fill[field] = mergeSailor[field];
        }
      }
    }
    if (Object.keys(fill).length > 1) {
      await tx.update(sailors).set(fill).where(eq(sailors.id, keepId));
    }

    // Commit the reviewed pair and identity evidence atomically with the merge.
    await tx.insert(adminChangeLog).values({
      actorUserId: actor?.userId || null,
      actorEmail: actor?.email || null,
      action: "sailors.merge_reviewed",
      entityType: "sailor",
      entityId: keepId,
      entityLabel: keepSailor.name,
      summary: `Merged ${mergeSailor.name} into ${keepSailor.name} after explicit identity review.`,
      details: toAdminAuditJsonValue({ keepId, mergeId, reviewToken, identityEvidence, sourceProfile: mergeSailor, resultsMoved, participantLinksMoved: movedParticipantIds.length }),
      source: "/api/admin/sailors/merge",
    });

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
      newsArticlesMoved: newsArticlesMoved.length,
      notesMoved: notesMoved.length,
      claimsMoved: claimsMoved.length,
      indexSailorsMoved: indexSailorsMoved.length,
      indexDuplicateReviewsMoved: indexReviewPlan.moveIds.length,
      indexDuplicateReviewsDroppedConflict: indexReviewPlan.conflictIds.length,
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
