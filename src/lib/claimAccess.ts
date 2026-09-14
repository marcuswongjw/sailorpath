import { and, eq } from "drizzle-orm";
import { db } from "@/db";
import { sailorClaims, sailors } from "@/db/schema";

/**
 * Verifies whether a user can manage / edit a sailor profile.
 * Allowed if:
 * 1. User is superadmin
 * 2. User matches sailors.parentId
 * 3. User has an approved claim in sailorClaims
 */
export async function canManageSailor(
  sailorId: string,
  userId: string | null | undefined,
  isAdmin = false,
  knownParentId?: string | null
): Promise<boolean> {
  if (isAdmin) return true;
  if (!userId || !sailorId) return false;

  if (knownParentId !== undefined && knownParentId && knownParentId === userId) {
    return true;
  }

  // If knownParentId was not provided, check the sailor row
  if (knownParentId === undefined) {
    const [s] = await db
      .select({ parentId: sailors.parentId })
      .from(sailors)
      .where(eq(sailors.id, sailorId))
      .limit(1);
    if (s?.parentId && s.parentId === userId) return true;
  }

  // Check if this user has an approved claim
  const [claim] = await db
    .select({ id: sailorClaims.id })
    .from(sailorClaims)
    .where(
      and(
        eq(sailorClaims.sailorId, sailorId),
        eq(sailorClaims.requesterId, userId),
        eq(sailorClaims.status, "approved")
      )
    )
    .limit(1);

  return Boolean(claim);
}

/**
 * Returns a map of sailorId -> relation for all approved claims belonging to a user.
 */
export async function getApprovedClaimRelationsForUser(
  userId: string
): Promise<Map<string, string>> {
  if (!userId) return new Map();

  const rows = await db
    .select({
      sailorId: sailorClaims.sailorId,
      relation: sailorClaims.relation,
    })
    .from(sailorClaims)
    .where(
      and(
        eq(sailorClaims.requesterId, userId),
        eq(sailorClaims.status, "approved")
      )
    );

  const map = new Map<string, string>();
  for (const r of rows) {
    map.set(r.sailorId, r.relation || "parent");
  }
  return map;
}
