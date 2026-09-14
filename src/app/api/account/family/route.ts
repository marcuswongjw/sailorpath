import { NextResponse } from "next/server";
import { and, asc, desc, eq, gte, inArray, or } from "drizzle-orm";
import { getAuthContext, jsonError } from "@/lib/auth";
import { db } from "@/db";
import {
  coachDevelopmentRecords,
  equipmentItems,
  parentNotes,
  regattaResults,
  regattas,
  sailorClaims,
  sailors,
} from "@/db/schema";
import { getCachedFleetRankings } from "@/lib/queries";
import { computeOptimistSelectionData } from "@/lib/selectionQueries";
import { parseClaimRelation, relationFromNote } from "@/lib/claimRelation";
import { mapEquipmentRow } from "@/lib/equipment";
import { currentPeriodFromSgToday } from "@/lib/datesSg";
import { SINGAPORE_REGATTAS_2026 } from "@/lib/calendar/singaporeRegattas2026";
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

    const [
      goldBoard,
      silverBoard,
      allRecentResults,
      allGear,
      allNotes,
      selectionData,
      allCoachRecords,
      upcomingRegattas,
    ] = await Promise.all([
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
      computeOptimistSelectionData().catch(() => null),
      ids.length
        ? db
            .select({
              id: coachDevelopmentRecords.id,
              sailorId: coachDevelopmentRecords.sailorId,
              type: coachDevelopmentRecords.type,
              category: coachDevelopmentRecords.category,
              title: coachDevelopmentRecords.title,
              detail: coachDevelopmentRecords.detail,
              recordDate: coachDevelopmentRecords.recordDate,
              status: coachDevelopmentRecords.status,
            })
            .from(coachDevelopmentRecords)
            .where(inArray(coachDevelopmentRecords.sailorId, ids))
            .orderBy(desc(coachDevelopmentRecords.recordDate))
            .limit(20)
            .catch(() => [])
        : Promise.resolve([]),
      db
        .select({
          id: regattas.id,
          name: regattas.name,
          date: regattas.date,
          endDate: regattas.endDate,
          boatClass: regattas.boatClass,
          division: regattas.division,
          slug: regattas.slug,
        })
        .from(regattas)
        .where(
          or(
            gte(regattas.date, new Date().toISOString().slice(0, 10)),
            gte(regattas.endDate, new Date().toISOString().slice(0, 10))
          )
        )
        .orderBy(asc(regattas.date))
        .limit(10)
        .catch(() => []),
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

    // Equipment summary & alerts per sailor
    const gearBySailor = new Map<
      string,
      {
        primaryItems: {
          id: string;
          category: string;
          brand: string | null;
          model: string | null;
          label: string | null;
          condition: string;
          status: string;
          isPrimary: boolean;
        }[];
        alertCount: number;
        alerts: { label: string; reason: string }[];
      }
    >();
    for (const g of allGear) {
      const mapped = mapEquipmentRow({
        ...g,
        acquiredOn: g.acquiredOn ? String(g.acquiredOn) : null,
        retiredOn: g.retiredOn ? String(g.retiredOn) : null,
        lastUsedOn: g.lastUsedOn ? String(g.lastUsedOn) : null,
      });
      const cur = gearBySailor.get(g.sailorId) || {
        primaryItems: [],
        alertCount: 0,
        alerts: [],
      };
      if (g.isPrimary || cur.primaryItems.length < 5) {
        cur.primaryItems.push({
          id: g.id,
          category: g.category,
          brand: g.brand,
          model: g.model,
          label: g.label,
          condition: g.condition,
          status: g.status,
          isPrimary: g.isPrimary,
        });
      }
      if (mapped.needsAttention && mapped.status !== "retired") {
        cur.alertCount += 1;
        if (cur.alerts.length < 4) {
          cur.alerts.push({
            label: mapped.label || mapped.brand || mapped.category || "Gear",
            reason: mapped.attentionReason || "Needs attention",
          });
        }
      }
      gearBySailor.set(g.sailorId, cur);
    }

    // Coach development observations per sailor
    const coachFeedbackBySailor = new Map<
      string,
      {
        id: string;
        type: string;
        category: string | null;
        title: string;
        detail: string | null;
        recordDate: string;
        status: string;
      }[]
    >();
    for (const cr of allCoachRecords) {
      const list = coachFeedbackBySailor.get(cr.sailorId) || [];
      if (list.length < 10) {
        list.push({
          id: cr.id,
          type: cr.type,
          category: cr.category,
          title: cr.title,
          detail: cr.detail,
          recordDate: String(cr.recordDate).slice(0, 10),
          status: cr.status,
        });
      }
      coachFeedbackBySailor.set(cr.sailorId, list);
    }

    // Notes per sailor (already filtered to author; keep 10 each)
    const notesBySailor = new Map<
      string,
      { id: string; body: string; createdAt: string }[]
    >();
    for (const n of allNotes) {
      const list = notesBySailor.get(n.sailorId) || [];
      if (list.length >= 10) continue;
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

      let selectionTrials: {
        rank: number;
        nettScore: number;
        eventsSailed: number;
        isQualifiedAsian: boolean;
        isQualifiedPerth: boolean;
        asianTeamRank?: number;
        gapToCutoff?: number;
      } | null = null;

      if (selectionData?.combinedScores?.length) {
        const rankIdx = selectionData.combinedScores.findIndex(
          (c) => c.sailorId === s.id
        );
        if (rankIdx !== -1) {
          const row = selectionData.combinedScores[rankIdx];
          const asianIdx = selectionData.asianTeam.selected.findIndex(
            (m) => m.sailorId === s.id
          );
          const isQualifiedAsian = asianIdx !== -1;
          const isQualifiedPerth = selectionData.perthCamp.picks.some(
            (p) => p.sailorId === s.id
          );
          const cutoffScore = selectionData.combinedScores[4]?.combinedScore;
          let gapToCutoff: number | undefined = undefined;
          if (cutoffScore != null && row.combinedScore != null) {
            gapToCutoff = row.combinedScore - cutoffScore;
          }
          selectionTrials = {
            rank: rankIdx + 1,
            nettScore: row.combinedScore,
            eventsSailed: row.eventsSailed,
            isQualifiedAsian,
            isQualifiedPerth,
            asianTeamRank: isQualifiedAsian ? asianIdx + 1 : undefined,
            gapToCutoff,
          };
        }
      }

      const gear = gearBySailor.get(s.id);

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
        selectionTrials,
        recentResults: recentBySailor.get(s.id) || [],
        primaryGear: gear?.primaryItems || [],
        equipmentAlertCount: gear?.alertCount || 0,
        equipmentAlerts: gear?.alerts || [],
        coachFeedback: coachFeedbackBySailor.get(s.id) || [],
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

    const todayStr = new Date().toISOString().slice(0, 10);
    const seenSlugs = new Set<string>();
    const formattedUpcoming: Array<{
      id: string;
      name: string;
      date: string;
      boatClass: string | null;
      division: string | null;
      slug: string;
    }> = [];

    for (const r of upcomingRegattas) {
      if (r.name.includes("SAF Yacht Club Open")) continue;
      seenSlugs.add(r.slug);
      formattedUpcoming.push({
        id: r.id,
        name: r.name,
        date: String(r.date).slice(0, 10),
        boatClass: r.boatClass,
        division: r.division,
        slug: r.slug,
      });
    }

    for (const r of SINGAPORE_REGATTAS_2026) {
      if (r.name.includes("SAF Yacht Club Open")) continue;
      const end = r.endDate || r.startDate;
      if (end < todayStr) continue;
      if (seenSlugs.has(r.slug)) continue;
      seenSlugs.add(r.slug);
      formattedUpcoming.push({
        id: r.slug,
        name: r.name,
        date: r.startDate,
        boatClass: r.boatClass,
        division: r.division,
        slug: r.slug,
      });
    }

    formattedUpcoming.sort((a, b) => a.date.localeCompare(b.date));

    return NextResponse.json({
      email: auth.email,
      role: auth.role,
      athletes,
      pendingClaims,
      upcomingRegattas: formattedUpcoming.slice(0, 5),
      isParentStyle:
        auth.role === "parent" ||
        athletes.some((a) => a.ownerRelation === "parent") ||
        athletes.length > 1,
    });
  } catch (e) {
    return jsonError(e);
  }
}
