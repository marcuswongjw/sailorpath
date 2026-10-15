/**
 * How a stored result should be labelled for sailors and parents.
 *
 * Ranking-series rows are official. Personal logbook rows (`log-` slugs) keep
 * the status the owner saved. A shared non-ranking sheet is official only when
 * it was actually verified — a pending or self-reported row on that sheet must
 * not be relabelled as verified just because the slug is not a personal log.
 */
export function displayedResultVerificationStatus(input: {
  slug?: string | null;
  countsForRanking?: boolean | null;
  verificationStatus?: string | null;
}): "verified" | "pending_review" | "self_reported" | "rejected" {
  const slug = input.slug ?? "";
  const stored = input.verificationStatus;
  if (input.countsForRanking) return "verified";
  if (slug.startsWith("log-")) {
    if (
      stored === "pending_review" ||
      stored === "verified" ||
      stored === "rejected"
    ) {
      return stored;
    }
    return "self_reported";
  }
  if (
    stored === "pending_review" ||
    stored === "self_reported" ||
    stored === "rejected"
  ) {
    return stored;
  }
  return "verified";
}

export function resultCountsAsVerified(input: {
  slug?: string | null;
  countsForRanking?: boolean | null;
  verificationStatus?: string | null;
}): boolean {
  return displayedResultVerificationStatus(input) === "verified";
}
