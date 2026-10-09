import { eq } from "drizzle-orm";
import { db } from "@/db";
import { profiles } from "@/db/schema";
import {
  profileRoleFromRelation,
  type ClaimRelation,
} from "@/lib/claimRelation";

export type ClaimRoleNotice = {
  to: string;
  name: string | null;
  previousRole: string;
  nextRole: string;
  relation: "parent" | "sailor";
};

/**
 * Sets profiles.role for a parent or sailor claim.
 * Coach and superadmin accounts are left unchanged and are not emailed.
 * Returns the notice even when the role string was already correct, so an
 * approval still tells the user.
 * Pass the caller's transaction to keep the profile write atomic with approval.
 */
export async function applyClaimAccountRole(
  userId: string,
  relation: ClaimRelation,
  database: Pick<typeof db, "select" | "update"> = db
): Promise<ClaimRoleNotice | null> {
  const targetRole = profileRoleFromRelation(relation);
  if (!targetRole) return null;
  const [prof] = await database
    .select({
      role: profiles.role,
      email: profiles.email,
      fullName: profiles.fullName,
    })
    .from(profiles)
    .where(eq(profiles.id, userId))
    .limit(1);
  if (!prof || prof.role === "superadmin" || prof.role === "coach") return null;
  if (prof.role !== targetRole) {
    await database
      .update(profiles)
      .set({ role: targetRole, updatedAt: new Date() })
      .where(eq(profiles.id, userId));
  }
  return {
    to: prof.email,
    name: prof.fullName,
    previousRole: prof.role,
    nextRole: targetRole,
    relation: targetRole,
  };
}
