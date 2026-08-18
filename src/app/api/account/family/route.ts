import { NextResponse } from "next/server";
import { and, desc, eq, inArray } from "drizzle-orm";
import { getAuthContext, jsonError } from "@/lib/auth";
import { db } from "@/db";
import {
  equipmentItems,
  parentNotes,
  regattaResults,
  regattas,
  sailorClaims,
  sailors,
} from "@/db/schema";
import { getCachedFleetRankings } from "@/lib/queries";
import { parseClaimRelation, relationFromNote } from "@/lib/claimRelation";
import { mapEquipmentRow } from "@/lib/equipment";
import { currentPeriodFromSgToday } from "@/lib/datesSg";
import {
  periodLabel,
  resolveSailorFleet,
  type SailorRecord,
} from "@/lib/ranking";
import { normalizeSgSeriesMembership } from "@/lib/seriesMembership";

type StandingSummary = {
  periodLabel: string;
  fleet: string;
  overallRank: number;
  fleetSize: number;
  best3of5: number;
  trendNote: string;
};

/**
 * GET /api/account/family — linked athletes for parent / owner dashboard.
 * Batches DB reads (no per-athlete N+1).
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
        goldEntryDate: sailors.goldEntryDate,
        silverEntryDate: sailors.silverEntryDate,
        dropDate: sailors.dropDate,
        natSquadStatusJan25: sailors.natSquadStatusJan25,
        natSquadStatusJul25: sailors.natSquadStatusJul25,
        natSquadStatusJan26: sailors.natSquadStatusJan26,
        natSquadStatusJul26: sailors.natSquadStatusJul26,
        natSquadStatusJan27: sailors.natSquadStatusJan27,
        natSquadStatusJul27: sailors.natSquadStatusJul27,
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

    const ids = owned.map((s) => s.id);
    const period = currentPeriodFromSgToday();

    const [goldBoard, silverBoard, allRecentResults, allGear, allNotes] =
      await Promise.all([
        ids.length
          ? getCachedFleetRankings("Gold", period.year, period.half).catch(
              () => []
            )
          : Promise.resolve([]),
        ids.length
          ? getCachedFleetRankings("Silver", period.year, period.half).catch(
              () => []
            )
          : Promise.resolve([]),
        ids.length
          ? db
              .select({
                sailorId: regattaResults.sailorId,
                regattaName: regattas.name,
                regattaDate: regattas.date,
                rank: regattaResults.rank,
                boatClass: regattas.boatClass,
              })
              .from(regattaResults)
              .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
              .where(inArray(regattaResults.sailorId, ids))
              .orderBy(desc(regattas.date))
              .catch(() => [])
          : Promise.resolve([]),
        ids.length
          ? db
              .select()
              .from(equipmentItems)
              .where(inArray(equipmentItems.sailorId, ids))
              .catch(() => [])
          : Promise.resolve([]),
        ids.length
          ? db
              .select()
              .from(parentNotes)
              .where(
                and(
                  inArray(parentNotes.sailorId, ids),
                  eq(parentNotes.authorUserId, auth.userId)
                )
              )
              .orderBy(desc(parentNotes.createdAt))
              .catch(() => [])
          : Promise.resolve([]),
      ]);

    // Top 3 recent results per sailor
    const recentBySailor = new Map<
      string,
      {
        regattaName: string;
        regattaDate: string;
        rank: number;
        boatClass: string | null;
      }[]
    >();
    for (const r of allRecentResults) {
      const list = recentBySailor.get(r.sailorId) || [];
      if (list.length >= 3) continue;
      list.push({
        regattaName: r.regattaName,
        regattaDate: String(r.regattaDate).slice(0, 10),
        rank: r.rank,
        boatClass: r.boatClass,
      });
      recentBySailor.set(r.sailorId, list);
    }

    // Equipment alerts per sailor
    const gearAlertsBySailor = new Map<
      string,
      { count: number; alerts: { label: string; reason: string }[] }
    >();
    for (const g of allGear) {
      const mapped = mapEquipmentRow({
        ...g,
        acquiredOn: g.acquiredOn ? String(g.acquiredOn) : null,
        retiredOn: g.retiredOn ? String(g.retiredOn) : null,
        lastUsedOn: g.lastUsedOn ? String(g.lastUsedOn) : null,
      });
      if (!mapped.needsAttention || mapped.status === "retired") continue;
      const cur = gearAlertsBySailor.get(g.sailorId) || {
        count: 0,
        alerts: [],
      };
      cur.count += 1;
      if (cur.alerts.length < 3) {
        cur.alerts.push({
          label: mapped.label || mapped.brand || mapped.category || "Gear",
          reason: mapped.attentionReason || "Needs attention",
        });
      }
      gearAlertsBySailor.set(g.sailorId, cur);
    }

    // Notes per sailor (already filtered to author; keep 5 each)
    const notesBySailor = new Map<
      string,
      { id: string; body: string; createdAt: string }[]
    >();
    for (const n of allNotes) {
      const list = notesBySailor.get(n.sailorId) || [];
      if (list.length >= 5) continue;
      list.push({
        id: n.id,
        body: n.body,
        createdAt: n.createdAt ? new Date(n.createdAt).toISOString() : "",
      });
      notesBySailor.set(n.sailorId, list);
    }

    const athletes = owned.map((s) => {
      const relation =
        parseClaimRelation(s.ownerRelation) ||
        parseClaimRelation(
          claims.find((c) => c.sailorId === s.id && c.status === "approved")
            ?.relation
        ) ||
        relationFromNote(
          claims.find((c) => c.sailorId === s.id && c.status === "approved")
            ?.note
        ) ||
        null;

      let standing: StandingSummary | null = null;
      try {
        const n = normalizeSgSeriesMembership(s.currentFleet);
        const record = {
          ...s,
          currentFleet: n || s.currentFleet,
        } as SailorRecord;
        const fleetInfo = resolveSailorFleet(record, period);
        if (fleetInfo?.active) {
          const board =
            fleetInfo.fleet === "Silver" ? silverBoard : goldBoard;
          const me = board.find((x) => x.id === s.id);
          if (me) {
            const overallRank = board.findIndex((x) => x.id === s.id) + 1;
            const carry = me.regattaScores.filter((rs) => rs.isCarryForward)
              .length;
            standing = {
              periodLabel: periodLabel(period),
              fleet: me.fleet,
              overallRank,
              fleetSize: board.length,
              best3of5: me.overallScore,
              trendNote:
                carry > 0
                  ? `Includes ${carry} carry-forward score${carry === 1 ? "" : "s"} from previous half`
                  : `Best 3 of ${Math.min(5, me.regattaScores.length)} scoring events`,
            };
          }
        }
      } catch {
        standing = null;
      }

      const gear = gearAlertsBySailor.get(s.id);

      return {
        id: s.id,
        name: s.name,
        handle: s.handle,
        sailNumber: s.sailNumber,
        sailNumberIlca4: s.sailNumberIlca4,
        club: s.club,
        school: s.school,
        gender: s.gender,
        nationality: s.nationality,
        avatarUrl: s.avatarUrl,
        currentFleet: s.currentFleet,
        nationalSquadStatus: s.nationalSquadStatus,
        dob: s.dob,
        ownerRelation: relation,
        standing,
        recentResults: recentBySailor.get(s.id) || [],
        equipmentAlertCount: gear?.count || 0,
        equipmentAlerts: gear?.alerts || [],
        notes: notesBySailor.get(s.id) || [],
      };
    });

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
      isParentStyle:
        auth.role === "parent" ||
        athletes.some((a) => a.ownerRelation === "parent") ||
        athletes.length > 1,
    });
  } catch (e) {
    return jsonError(e);
  }
}
