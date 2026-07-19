import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattaResults, regattas, sailors } from "@/db/schema";
import { eq, sql } from "drizzle-orm";
import {
  activeSailorsForFleet,
  missingDnsPairs,
  rankingRegattasForFleet,
} from "@/lib/fillDns";
import type { Period, RegattaRecord, SailorRecord } from "@/lib/ranking";

function parseBool(v: unknown): boolean {
  return (
    v === true ||
    v === "true" ||
    v === "Y" ||
    v === "y" ||
    v === "yes" ||
    v === 1 ||
    v === "1"
  );
}

function parseDns(body: Record<string, unknown>): boolean {
  return parseBool(body.isDns ?? body.isDNS);
}

function parseOverseas(body: Record<string, unknown>): boolean {
  return parseBool(
    body.isOverseasCommitment ?? body.overseasCommitment ?? body.overseas
  );
}

function seriesMatchesDivision(
  s: {
    currentFleet?: string | null;
    goldEntryDate?: string | null;
    silverEntryDate?: string | null;
    manuallyDropped?: boolean | null;
  },
  division: string
): boolean {
  if (s.manuallyDropped) return false;
  const cf = String(s.currentFleet || "")
    .trim()
    .toLowerCase();
  const isGold = cf === "gold" || Boolean(s.goldEntryDate);
  const isSilver =
    cf === "silver" || Boolean(s.silverEntryDate) || isGold;
  // Silver-only: tagged silver, or silver entry without gold promotion path for display
  const silverFleet =
    cf === "silver" ||
    (Boolean(s.silverEntryDate) && !isGold) ||
    (cf !== "gold" && Boolean(s.silverEntryDate) && !s.goldEntryDate);

  const div = (division || "Gold").toLowerCase();
  if (div === "gold") return isGold;
  if (div === "silver") return silverFleet || (isSilver && !isGold);
  // Both
  return isGold || Boolean(s.silverEntryDate) || cf === "silver" || cf === "gold";
}

/** Clear DNS when rank is better (lower) than fleet size + 1 */
async function healFalseDnsFlags() {
  try {
    await db.execute(sql`
      UPDATE regatta_results AS r
      SET is_dns = false, updated_at = now()
      FROM regattas AS g
      WHERE r.regatta_id = g.id
        AND r.is_dns = true
        AND COALESCE(r.is_overseas_commitment, false) = false
        AND r.rank < (COALESCE(g.total_fleet_size, 50) + 1)
    `);
  } catch (e) {
    console.warn("healFalseDnsFlags", e);
  }
}

export async function GET() {
  try {
    await requireSuperadmin();
    // Keep DNS flags consistent with ranks across the board
    await healFalseDnsFlags();
    const rows = await db.select().from(regattaResults);
    return NextResponse.json({
      results: rows.map((r) => ({
        ...r,
        isDNS: r.isDns,
        isOverseasCommitment: r.isOverseasCommitment,
      })),
    });
  } catch (e) {
    return jsonError(e);
  }
}

export async function POST(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();

    if (
      body.action === "healFalseDns" ||
      body.action === "clearFalseDns"
    ) {
      await healFalseDnsFlags();
      return NextResponse.json({
        ok: true,
        message:
          "Cleared DNS on any result where rank is better than fleet size + 1.",
      });
    }

    /**
     * fillDnsPeriod: ensure every active Gold/Silver sailor for a half-year has a
     * result row for each ranking regatta in that period (missing → DNS = N+1).
     * Body: { action, fleet: "Gold"|"Silver", year, half: "Jan-Jun"|"Jul-Dec" }
     */
    if (
      body.action === "fillDnsPeriod" ||
      body.action === "fillDNSPeriod" ||
      body.action === "ensureFleetDns"
    ) {
      const fleet =
        String(body.fleet || "Gold").toLowerCase() === "silver"
          ? "Silver"
          : "Gold";
      const year = Number(body.year) || new Date().getFullYear();
      const half = (
        body.half === "Jan-Jun" ? "Jan-Jun" : "Jul-Dec"
      ) as Period["half"];
      const period: Period = { year, half };

      const [sailorRows, regattaRows, resultRows] = await Promise.all([
        db.select().from(sailors),
        db.select().from(regattas),
        db
          .select({
            sailorId: regattaResults.sailorId,
            regattaId: regattaResults.regattaId,
          })
          .from(regattaResults),
      ]);

      const sailorRecords: SailorRecord[] = sailorRows.map((row) => ({
        id: row.id,
        name: row.name,
        handle: row.handle,
        sailNumber: row.sailNumber,
        club: row.club,
        school: row.school,
        nationality: row.nationality,
        goldEntryDate: row.goldEntryDate,
        silverEntryDate: row.silverEntryDate,
        dropDate: row.dropDate,
        currentFleet: row.currentFleet,
        manuallyDropped: row.manuallyDropped,
        dob: row.dob,
        gender: row.gender,
        nationalSquadStatus: row.nationalSquadStatus,
      }));

      const regattaRecords: RegattaRecord[] = regattaRows.map((r) => ({
        id: r.id,
        name: r.name,
        slug: r.slug,
        date: r.date,
        totalFleetSize: r.totalFleetSize,
        division: r.division,
      }));

      const existingKeys = new Set(
        resultRows.map((r) => `${r.sailorId}|${r.regattaId}`)
      );
      const pairs = missingDnsPairs({
        fleet,
        period,
        sailors: sailorRecords,
        regattas: regattaRecords,
        existingKeys,
      });
      const events = rankingRegattasForFleet(fleet, period, regattaRecords);
      const fleetSailors = activeSailorsForFleet(
        fleet,
        period,
        sailorRecords
      );

      let created = 0;
      for (const p of pairs) {
        const [row] = await db
          .insert(regattaResults)
          .values({
            sailorId: p.sailorId,
            regattaId: p.regattaId,
            rank: p.dnsPoints,
            nettScore: null,
            totalScore: null,
            isDns: true,
            isOverseasCommitment: false,
          })
          .onConflictDoNothing()
          .returning();
        if (row) created++;
      }

      return NextResponse.json({
        ok: true,
        message: `Ensured DNS for ${fleet} fleet ${half} ${year}: ${created} missing results created (rank = each regatta fleet size + 1). ${fleetSailors.length} active sailors × ${events.length} ranking regattas.`,
        created,
        fleet,
        period,
        activeSailors: fleetSailors.length,
        rankingRegattas: events.map((e) => ({
          id: e.id,
          name: e.name,
          date: e.date,
          totalFleetSize: e.totalFleetSize,
          dnsPoints: (e.totalFleetSize || 0) + 1,
        })),
        missingBefore: pairs.length,
      });
    }

    // Bulk: create DNS for fleet members missing a result at ONE regatta
    if (body.action === "fillDns" || body.action === "fillDNS") {
      const regattaId = String(body.regattaId || "").trim();
      if (!regattaId) {
        return NextResponse.json(
          { error: "regattaId required for fillDns" },
          { status: 400 }
        );
      }
      const [reg] = await db
        .select()
        .from(regattas)
        .where(eq(regattas.id, regattaId))
        .limit(1);
      if (!reg) {
        return NextResponse.json({ error: "Regatta not found" }, { status: 404 });
      }

      const dnsPoints = Math.max(1, (reg.totalFleetSize || 0) + 1);
      // Infer period half from regatta date
      const d = new Date(reg.date);
      const year = d.getFullYear();
      const half: Period["half"] =
        d.getMonth() < 6 ? "Jan-Jun" : "Jul-Dec";
      const period: Period = { year, half };
      const div = (reg.division || "Gold").toLowerCase();
      const fleet: "Gold" | "Silver" =
        div === "silver" ? "Silver" : "Gold";

      const sailorRows = await db.select().from(sailors);
      const sailorRecords: SailorRecord[] = sailorRows.map((row) => ({
        id: row.id,
        name: row.name,
        handle: row.handle,
        sailNumber: row.sailNumber,
        club: row.club,
        goldEntryDate: row.goldEntryDate,
        silverEntryDate: row.silverEntryDate,
        dropDate: row.dropDate,
        currentFleet: row.currentFleet,
        manuallyDropped: row.manuallyDropped,
      }));
      // For "Both" division, fill for both fleets
      const fleets: ("Gold" | "Silver")[] =
        div === "both" ? ["Gold", "Silver"] : [fleet];
      const eligibleIds = new Set<string>();
      for (const f of fleets) {
        for (const s of activeSailorsForFleet(f, period, sailorRecords)) {
          eligibleIds.add(s.id);
        }
      }
      // Fallback if no period-active sailors (date outside half): seriesMatchesDivision
      if (eligibleIds.size === 0) {
        for (const s of sailorRows) {
          if (seriesMatchesDivision(s, reg.division || "Gold")) {
            eligibleIds.add(s.id);
          }
        }
      }

      const existing = await db
        .select({
          sailorId: regattaResults.sailorId,
        })
        .from(regattaResults)
        .where(eq(regattaResults.regattaId, regattaId));
      const have = new Set(existing.map((e) => e.sailorId));

      let created = 0;
      const createdRows: (typeof regattaResults.$inferSelect)[] = [];
      for (const sailorId of eligibleIds) {
        if (have.has(sailorId)) continue;
        const [row] = await db
          .insert(regattaResults)
          .values({
            sailorId,
            regattaId,
            rank: dnsPoints,
            nettScore: null,
            totalScore: null,
            isDns: true,
            isOverseasCommitment: false,
          })
          .onConflictDoNothing()
          .returning();
        if (row) {
          created++;
          createdRows.push(row);
        }
      }

      return NextResponse.json({
        ok: true,
        message: `Created ${created} DNS results (score ${dnsPoints} = fleet ${reg.totalFleetSize} + 1) for active ${reg.division} fleet members missing this regatta.`,
        created,
        dnsPoints,
        eligible: eligibleIds.size,
        alreadyHadResults: have.size,
        results: createdRows.map((r) => ({ ...r, isDNS: r.isDns })),
      });
    }

    if (!body.sailorId || !body.regattaId) {
      return NextResponse.json(
        { error: "sailorId and regattaId are required" },
        { status: 400 }
      );
    }
    const isOverseasCommitment = parseOverseas(body);
    // Overseas commitment is not generic DNS (different scoring rule)
    let isDns = parseDns(body);
    if (isOverseasCommitment) isDns = false;

    const [regMeta] = await db
      .select({ totalFleetSize: regattas.totalFleetSize })
      .from(regattas)
      .where(eq(regattas.id, body.regattaId))
      .limit(1);
    const dnsPoints = Math.max(1, (regMeta?.totalFleetSize || 50) + 1);

    let rank = Math.round(Number(body.rank));
    if (!Number.isFinite(rank) || rank <= 0) {
      // Default DNS points from regatta fleet size when marking DNS without rank
      if (isDns) {
        rank = dnsPoints;
      } else {
        rank = 999;
      }
    }
    // Real finish better than DNS (fleet+1) → not a DNS
    if (isDns && rank < dnsPoints) {
      isDns = false;
    }
    // Nett is optional (e.g. overseas commitment has ranking points but no race nett)
    const nettScore =
      body.nettScore != null && body.nettScore !== ""
        ? Number(body.nettScore)
        : null;
    const totalScore =
      body.totalScore != null && body.totalScore !== ""
        ? Number(body.totalScore)
        : null;

    const [row] = await db
      .insert(regattaResults)
      .values({
        sailorId: body.sailorId,
        regattaId: body.regattaId,
        rank,
        nettScore,
        totalScore,
        isDns,
        isOverseasCommitment,
      })
      .onConflictDoUpdate({
        target: [regattaResults.sailorId, regattaResults.regattaId],
        set: {
          rank,
          nettScore,
          totalScore,
          isDns,
          isOverseasCommitment,
          updatedAt: new Date(),
        },
      })
      .returning();

    return NextResponse.json({
      result: {
        ...row,
        isDNS: row.isDns,
        isOverseasCommitment: row.isOverseasCommitment,
      },
    });
  } catch (e) {
    console.error("results POST", e);
    return jsonError(e);
  }
}

export async function PATCH(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();
    if (!body.id) {
      return NextResponse.json({ error: "id required" }, { status: 400 });
    }

    const patch: Record<string, unknown> = { updatedAt: new Date() };
    if (body.rank !== undefined) patch.rank = Number(body.rank) || 999;
    if (body.nettScore !== undefined) {
      patch.nettScore =
        body.nettScore === "" || body.nettScore == null
          ? null
          : Number(body.nettScore);
    }
    if (body.totalScore !== undefined) {
      patch.totalScore =
        body.totalScore === "" || body.totalScore == null
          ? null
          : Number(body.totalScore);
    }
    if (body.isDns !== undefined || body.isDNS !== undefined) {
      patch.isDns = parseDns(body);
    }
    if (
      body.isOverseasCommitment !== undefined ||
      body.overseasCommitment !== undefined ||
      body.overseas !== undefined
    ) {
      patch.isOverseasCommitment = parseOverseas(body);
      // Mutual exclusivity with generic DNS when overseas is set
      if (patch.isOverseasCommitment === true) {
        patch.isDns = false;
      }
    }
    if (body.sailorId !== undefined) patch.sailorId = body.sailorId;
    if (body.regattaId !== undefined) patch.regattaId = body.regattaId;

    const [existing] = await db
      .select()
      .from(regattaResults)
      .where(eq(regattaResults.id, body.id))
      .limit(1);

    // If turning on DNS without changing rank, set default fleet+1
    if (patch.isDns === true && body.rank === undefined && existing) {
      const [reg] = await db
        .select({ totalFleetSize: regattas.totalFleetSize })
        .from(regattas)
        .where(eq(regattas.id, existing.regattaId))
        .limit(1);
      if (reg && (existing.isDns !== true || body.forceDnsScore)) {
        if (!existing.isDns && !existing.isOverseasCommitment) {
          const pts = (reg.totalFleetSize || 50) + 1;
          patch.rank = pts;
        }
      }
    }

    // Rank better than DNS (fleet+1) → clear DNS flag
    if (existing) {
      const [reg] = await db
        .select({ totalFleetSize: regattas.totalFleetSize })
        .from(regattas)
        .where(
          eq(
            regattas.id,
            (body.regattaId as string) || existing.regattaId
          )
        )
        .limit(1);
      const dnsPts = Math.max(1, (reg?.totalFleetSize || 50) + 1);
      const finalRank =
        patch.rank !== undefined
          ? Number(patch.rank)
          : Number(existing.rank);
      const willBeDns =
        patch.isDns !== undefined
          ? Boolean(patch.isDns)
          : Boolean(existing.isDns);
      const overseas =
        patch.isOverseasCommitment !== undefined
          ? Boolean(patch.isOverseasCommitment)
          : Boolean(existing.isOverseasCommitment);
      if (
        willBeDns &&
        !overseas &&
        Number.isFinite(finalRank) &&
        finalRank < dnsPts
      ) {
        patch.isDns = false;
      }
    }

    const [row] = await db
      .update(regattaResults)
      .set(patch as typeof regattaResults.$inferInsert)
      .where(eq(regattaResults.id, body.id))
      .returning();

    if (!row) {
      return NextResponse.json({ error: "Result not found" }, { status: 404 });
    }
    return NextResponse.json({
      result: {
        ...row,
        isDNS: row.isDns,
        isOverseasCommitment: row.isOverseasCommitment,
      },
    });
  } catch (e) {
    console.error("results PATCH", e);
    return jsonError(e);
  }
}

export async function DELETE(req: Request) {
  try {
    await requireSuperadmin();
    const id = new URL(req.url).searchParams.get("id");
    if (!id) {
      return NextResponse.json({ error: "id required" }, { status: 400 });
    }
    const deleted = await db
      .delete(regattaResults)
      .where(eq(regattaResults.id, id))
      .returning({ id: regattaResults.id });
    if (!deleted[0]) {
      return NextResponse.json({ error: "Result not found" }, { status: 404 });
    }
    return NextResponse.json({ ok: true, id });
  } catch (e) {
    console.error("results DELETE", e);
    return jsonError(e);
  }
}
