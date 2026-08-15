/** Claim / ownership relation for a linked account on a sailor profile. */

export type ClaimRelation = "parent" | "sailor" | "other";

export function parseClaimRelation(raw: unknown): ClaimRelation | null {
  const s = String(raw || "")
    .trim()
    .toLowerCase();
  if (s === "parent" || s === "sailor" || s === "other") return s;
  return null;
}

/** Parse `[parent] note…` style notes from older claims. */
export function relationFromNote(note: string | null | undefined): ClaimRelation | null {
  if (!note) return null;
  const m = String(note).trim().match(/^\[(parent|sailor|other)\]/i);
  if (!m) return null;
  return parseClaimRelation(m[1]);
}

export function relationLabel(r: ClaimRelation | null | undefined): string {
  if (r === "parent") return "Parent / guardian";
  if (r === "sailor") return "Sailor (self)";
  if (r === "other") return "Coach / other";
  return "—";
}

/**
 * Account role to set on approve (never demote superadmin).
 * parent / sailor map to profiles.role; other leaves role unchanged.
 */
export function profileRoleFromRelation(
  relation: ClaimRelation
): "parent" | "sailor" | null {
  if (relation === "parent") return "parent";
  if (relation === "sailor") return "sailor";
  return null;
}
