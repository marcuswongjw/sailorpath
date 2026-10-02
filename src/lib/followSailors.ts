/**
 * Follow rules shared by the API and tests.
 * The database unique key is (follower_profile_id, sailor_id).
 * RLS allows a row only when auth.uid() equals follower_profile_id.
 */

export function followPairKey(followerProfileId: string, sailorId: string): string {
  return `${followerProfileId}:${sailorId}`;
}

export function followPairsAreUnique(
  pairs: readonly { followerProfileId: string; sailorId: string }[]
): boolean {
  const keys = pairs.map((pair) =>
    followPairKey(pair.followerProfileId, pair.sailorId)
  );
  return new Set(keys).size === keys.length;
}

/** Mirrors followed_sailors policies: the follower owns the row. */
export function followerOwnsRow(
  followerProfileId: string,
  authUid: string | null | undefined
): boolean {
  return Boolean(authUid) && authUid === followerProfileId;
}

export type FollowDecision =
  | { ok: true; alreadyFollowing: boolean }
  | { ok: false; reason: "own-sailor" };

/**
 * A linked owner already has the sailor on the parent/sailor dashboard.
 * Repeating the same follower+sailor pair is a no-op, not a second row.
 */
export function decideFollow(input: {
  followerProfileId: string;
  sailorOwnerProfileId: string | null;
  existingFollowerProfileIds: readonly string[];
}): FollowDecision {
  if (
    input.sailorOwnerProfileId &&
    input.sailorOwnerProfileId === input.followerProfileId
  ) {
    return { ok: false, reason: "own-sailor" };
  }
  return {
    ok: true,
    alreadyFollowing: input.existingFollowerProfileIds.includes(
      input.followerProfileId
    ),
  };
}

/** Missing or true means emails stay on. Only an explicit false opts out. */
export function notifyFollowedResultsEnabled(
  value: boolean | null | undefined
): boolean {
  return value !== false;
}
