import { NextResponse } from "next/server";
import { desc, eq } from "drizzle-orm";
import { getAuthContext, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { sailorClaims, sailors } from "@/db/schema";
import { getSailorSeriesStanding } from "@/lib/queries";
import { parseClaimRelation, relationFromNote } from "@/lib/claimRelation";

/**
 * GET /api/account/family — linked athletes for parent / owner dashboard.
 */
export async function GET() {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }

    const owned = await db
      .select({
        id: sailors.id,
        name: sailors.name,
        handle: sailors.handle,
        sailNumber: sailors.sailNumber,
        sailNumberIlca4: sailors.sailNumberIlca4,
        club: sailors.club,
        school: sailors.school,
        gender: sailors.gender,
        nationality: sailors.nationality,
        avatarUrl: sailors.avatarUrl,
        currentFleet: sailors.currentFleet,
        ownerRelation: sailors.ownerRelation,
        nationalSquadStatus: sailors.nationalSquadStatus,
        dob: sailors.dob,
      })
      .from(sailors)
      .where(eq(sailors.parentId, auth.userId));

    const claims = await db
      .select({
        id: sailorClaims.id,
        status: sailorClaims.status,
        relation: sailorClaims.relation,
        note: sailorClaims.note,
        createdAt: sailorClaims.createdAt,
        sailorId: sailorClaims.sailorId,
        sailorName: sailors.name,
        sailorHandle: sailors.handle,
      })
      .from(sailorClaims)
      .innerJoin(sailors, eq(sailorClaims.sailorId, sailors.id))
      .where(eq(sailorClaims.requesterId, auth.userId))
      .orderBy(desc(sailorClaims.createdAt));

    const athletes = await Promise.all(
      owned.map(async (s) => {
        let standing: {
          periodLabel: string;
          fleet: string;
          overallRank: number;
          fleetSize: number;
          best3of5: number;
          trendNote: string;
        } | null = null;
        try {
          const st = await getSailorSeriesStanding(s.id);
          if (st) {
            standing = {
              periodLabel: st.periodLabel,
              fleet: st.fleet,
              overallRank: st.overallRank,
              fleetSize: st.fleetSize,
              best3of5: st.best3of5,
              trendNote: st.trendNote,
            };
          }
        } catch {
          standing = null;
        }

        const relation =
          parseClaimRelation(s.ownerRelation) ||
          parseClaimRelation(
            claims.find(
              (c) => c.sailorId === s.id && c.status === "approved"
            )?.relation
          ) ||
          relationFromNote(
            claims.find(
              (c) => c.sailorId === s.id && c.status === "approved"
            )?.note
          ) ||
          null;

        return {
          ...s,
          ownerRelation: relation,
          standing,
        };
      })
    );

    const pendingClaims = claims
      .filter((c) => c.status === "pending")
      .map((c) => ({
        ...c,
        relation:
          parseClaimRelation(c.relation) || relationFromNote(c.note) || null,
      }));

    return NextResponse.json({
      email: auth.email,
      role: auth.role,
      athletes,
      pendingClaims,
      /** Hint for UI: parent dashboard vs self-managed */
      isParentStyle:
        auth.role === "parent" ||
        athletes.some((a) => a.ownerRelation === "parent") ||
        athletes.length > 1,
    });
  } catch (e) {
    return jsonError(e);
  }
}
