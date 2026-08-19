import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattaResults, regattas, sailors } from "@/db/schema";
import { eq, sql } from "drizzle-orm";
import { revalidatePublicRankings } from "@/lib/revalidatePublic";
import {
  activeSailorsForFleet,
  missingDnsPairs,
  rankingRegattasForFleet,
} from "@/lib/fillDns";
import {
  resolveSailorFleet,
  type Period,
  type RegattaRecord,
  type SailorRecord,
} from "@/lib/ranking";
import { periodHalfFromYmd } from "@/lib/datesSg";
import {
  asOptionalNumber,
  asRank,
  asUuid,
} from "@/lib/validate";
import { logAdminChange } from "@/lib/adminChangeLog";

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

/**
 * Eligible for DNS fill on a regatta: same rules as ranking board
 * (Guest/Series + gold entry/drop via resolveSailorFleet).
 */
function sailorEligibleForRegattaDns(
  s: SailorRecord,
  division: string,
  period: Period
): boolean {
  const res = resolveSailorFleet(s, period);
  if (!res?.active) return false;
  const div = (division || "Gold").toLowerCase();
  if (div === "both") return true;
  if (div === "silver") return res.fleet === "Silver";
  // Gold (default)
  return res.fleet === "Gold";
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

export async function GET(req: Request) {
  try {
    await requireSuperadmin();
    const sp = new URL(req.url).searchParams;
    const regattaId = (sp.get("regattaId") || "").trim();
    const all = sp.get("all") === "1";
    const limitRaw = Number(sp.get("limit"));
    const offsetRaw = Number(sp.get("offset"));
    const { count } = await import("drizzle-orm");

    // Prefer per-regatta loads for the results editor (biggest win).
    // Ranking tabs pass all=1 with a hard cap.
    if (regattaId) {
      const idCheck = asUuid(regattaId, "regattaId");
      if (!idCheck.ok) {
        return NextResponse.json({ error: idCheck.error }, { status: 400 });
      }
      const rows = await db
        .select()
        .from(regattaResults)
        .where(eq(regattaResults.regattaId, idCheck.value));
      return NextResponse.json({
        results: rows.map((r) => ({
          ...r,
          isDNS: r.isDns,
          isOverseasCommitment: r.isOverseasCommitment,
        })),
        regattaId: idCheck.value,
        total: rows.length,
      });
    }

    if (!all) {
      return NextResponse.json(
        {
          error:
            "Pass regattaId=… for one event, or all=1 for ranking/analysis (capped).",
        },
        { status: 400 }
      );
    }

    const limit = Math.min(
      20000,
      Number.isFinite(limitRaw) && limitRaw > 0 ? limitRaw : 20000
    );
    const offset = Math.max(0, Number.isFinite(offsetRaw) ? offsetRaw : 0);

    const [rows, totalRow] = await Promise.all([
      db.select().from(regattaResults).limit(limit).offset(offset),
      db.select({ n: count() }).from(regattaResults),
    ]);

    return NextResponse.json({
      results: rows.map((r) => ({
        ...r,
        isDNS: r.isDns,
        isOverseasCommitment: r.isOverseasCommitment,
      })),
      total: Number(totalRow[0]?.n || 0),
      limit,
      offset,
      all: true,
    });
  } catch (e) {
    return jsonError(e);
  }
}

export async function POST(req: Request) {
  try {
    const auth = await requireSuperadmin();
    const body = await req.json();

    if (
      body.action === "healFalseDns" ||
      body.action === "clearFalseDns"
    ) {
      await healFalseDnsFlags();
      revalidatePublicRankings("results:healFalseDns");
      void logAdminChange({
        actorUserId: auth.userId,
        actorEmail: auth.email,
        action: "result.heal_false_dns",
        entityType: "bulk",
        entityId: null,
        entityLabel: null,
        summary: "Cleared false DNS flags where rank better than fleet size + 1",
        source: "/api/admin/results",
      });
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
        // Required so personal/non-ranking logbook events are excluded
        countsForRanking: r.countsForRanking !== false,
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

      revalidatePublicRankings(`results:fillDnsPeriod:${fleet}:${year}:${half}`);
      void logAdminChange({
        actorUserId: auth.userId,
        actorEmail: auth.email,
        action: "result.fill_dns_period",
        entityType: "bulk",
        entityId: null,
        entityLabel: `${fleet} ${half} ${year}`,
        summary: `Filled DNS for ${fleet} ${half} ${year}: ${created} created`,
        details: {
          created,
          fleet,
          year,
          half,
          activeSailors: fleetSailors.length,
          rankingRegattas: events.length,
          missingBefore: pairs.length,
        },
        source: "/api/admin/results",
      });
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
      if (reg.countsForRanking === false) {
        return NextResponse.json(
          {
            error:
              "Cannot fill DNS for a non-ranking (personal/logbook) regatta. Mark counts_for_ranking=true first if it should count.",
          },
          { status: 400 }
        );
      }

      const dnsPoints = Math.max(1, (reg.totalFleetSize || 0) + 1);
      // Infer period half from regatta date (YYYY-MM-DD / SG calendar)
      const halfInfo = periodHalfFromYmd(reg.date);
      if (!halfInfo) {
        return NextResponse.json(
          { error: "Regatta date invalid for period DNS fill" },
          { status: 400 }
        );
      }
      const period: Period = {
        year: halfInfo.year,
        half: halfInfo.half,
      };
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
      // Fallback: same resolveSailorFleet rules (handles division Both / edge cases)
      if (eligibleIds.size === 0) {
        for (const s of sailorRecords) {
          if (sailorEligibleForRegattaDns(s, reg.division || "Gold", period)) {
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

      revalidatePublicRankings(`results:fillDns:${reg.id}`);
      void logAdminChange({
        actorUserId: auth.userId,
        actorEmail: auth.email,
        action: "result.fill_dns",
        entityType: "regatta",
        entityId: reg.id,
        entityLabel: reg.name || null,
        summary: `Filled DNS for ${reg.name}: ${created} created`,
        details: {
          created,
          dnsPoints,
          eligible: eligibleIds.size,
          alreadyHadResults: have.size,
          division: reg.division,
        },
        source: "/api/admin/results",
      });
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

    const sailorIdR = asUuid(body.sailorId, "sailorId");
    const regattaIdR = asUuid(body.regattaId, "regattaId");
    if (!sailorIdR.ok || !regattaIdR.ok) {
      return NextResponse.json(
        {
          error: !sailorIdR.ok
            ? sailorIdR.error
            : regattaIdR.ok
              ? "sailorId and regattaId are required"
              : regattaIdR.error,
        },
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
      .where(eq(regattas.id, regattaIdR.value))
      .limit(1);
    const dnsPoints = Math.max(1, (regMeta?.totalFleetSize || 50) + 1);

    let rank: number;
    if (body.rank === null || body.rank === undefined || body.rank === "") {
      // Default DNS points from regatta fleet size when marking DNS without rank
      rank = isDns ? dnsPoints : dnsPoints;
      if (!isDns) {
        return NextResponse.json(
          { error: "rank is required for non-DNS results (integer ≥ 1)" },
          { status: 400 }
        );
      }
    } else {
      const rankR = asRank(body.rank);
      if (!rankR.ok) {
        return NextResponse.json({ error: rankR.error }, { status: 400 });
      }
      rank = rankR.value;
    }
    // Real finish better than DNS (fleet+1) → not a DNS
    if (isDns && rank < dnsPoints) {
      isDns = false;
    }
    // Nett is optional (e.g. overseas commitment has ranking points but no race nett)
    const nettR = asOptionalNumber(body.nettScore, {
      min: 0,
      max: 100_000,
      field: "nettScore",
    });
    const totalR = asOptionalNumber(body.totalScore, {
      min: 0,
      max: 100_000,
      field: "totalScore",
    });
    if (!nettR.ok) {
      return NextResponse.json({ error: nettR.error }, { status: 400 });
    }
    if (!totalR.ok) {
      return NextResponse.json({ error: totalR.error }, { status: 400 });
    }
    const nettScore = nettR.value;
    const totalScore = totalR.value;

    const [row] = await db
      .insert(regattaResults)
      .values({
        sailorId: sailorIdR.value,
        regattaId: regattaIdR.value,
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

    revalidatePublicRankings(`results:upsert:${row.id}`);
    let sailorLabel: string | null = null;
    let regattaLabel: string | null = null;
    try {
      const [[sailorRow], [regattaRow]] = await Promise.all([
        db
          .select({ name: sailors.name })
          .from(sailors)
          .where(eq(sailors.id, row.sailorId))
          .limit(1),
        db
          .select({ name: regattas.name })
          .from(regattas)
          .where(eq(regattas.id, row.regattaId))
          .limit(1),
      ]);
      sailorLabel = sailorRow?.name || null;
      regattaLabel = regattaRow?.name || null;
    } catch {
      /* labels optional */
    }
    void logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: "result.upsert",
      entityType: "result",
      entityId: row.id,
      entityLabel:
        sailorLabel && regattaLabel
          ? `${sailorLabel} @ ${regattaLabel}`
          : sailorLabel || regattaLabel,
      summary: `Upserted result${sailorLabel ? ` for ${sailorLabel}` : ""}${regattaLabel ? ` at ${regattaLabel}` : ""}`,
      details: {
        sailorId: row.sailorId,
        regattaId: row.regattaId,
        sailorName: sailorLabel,
        regattaName: regattaLabel,
        rank: row.rank,
        isDns: row.isDns,
        isOverseasCommitment: row.isOverseasCommitment,
      },
      source: "/api/admin/results",
    });
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
    const auth = await requireSuperadmin();
    const body = await req.json();
    const idR = asUuid(body.id, "id");
    if (!idR.ok) {
      return NextResponse.json({ error: idR.error }, { status: 400 });
    }

    const patch: Record<string, unknown> = { updatedAt: new Date() };
    if (body.rank !== undefined) {
      const rankR = asRank(body.rank);
      if (!rankR.ok) {
        return NextResponse.json({ error: rankR.error }, { status: 400 });
      }
      patch.rank = rankR.value;
    }
    if (body.nettScore !== undefined) {
      const nettR = asOptionalNumber(body.nettScore, {
        min: 0,
        max: 100_000,
        field: "nettScore",
      });
      if (!nettR.ok) {
        return NextResponse.json({ error: nettR.error }, { status: 400 });
      }
      patch.nettScore = nettR.value;
    }
    if (body.totalScore !== undefined) {
      const totalR = asOptionalNumber(body.totalScore, {
        min: 0,
        max: 100_000,
        field: "totalScore",
      });
      if (!totalR.ok) {
        return NextResponse.json({ error: totalR.error }, { status: 400 });
      }
      patch.totalScore = totalR.value;
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
    if (body.sailorId !== undefined) {
      const s = asUuid(body.sailorId, "sailorId");
      if (!s.ok) {
        return NextResponse.json({ error: s.error }, { status: 400 });
      }
      patch.sailorId = s.value;
    }
    if (body.regattaId !== undefined) {
      const r = asUuid(body.regattaId, "regattaId");
      if (!r.ok) {
        return NextResponse.json({ error: r.error }, { status: 400 });
      }
      patch.regattaId = r.value;
    }

    const [existing] = await db
      .select()
      .from(regattaResults)
      .where(eq(regattaResults.id, idR.value))
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
      .where(eq(regattaResults.id, idR.value))
      .returning();

    if (!row) {
      return NextResponse.json({ error: "Result not found" }, { status: 404 });
    }
    revalidatePublicRankings(`results:patch:${row.id}`);
    let sailorLabel: string | null = null;
    let regattaLabel: string | null = null;
    try {
      const [[sailorRow], [regattaRow]] = await Promise.all([
        db
          .select({ name: sailors.name })
          .from(sailors)
          .where(eq(sailors.id, row.sailorId))
          .limit(1),
        db
          .select({ name: regattas.name })
          .from(regattas)
          .where(eq(regattas.id, row.regattaId))
          .limit(1),
      ]);
      sailorLabel = sailorRow?.name || null;
      regattaLabel = regattaRow?.name || null;
    } catch {
      /* labels optional */
    }
    void logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: "result.patch",
      entityType: "result",
      entityId: row.id,
      entityLabel:
        sailorLabel && regattaLabel
          ? `${sailorLabel} @ ${regattaLabel}`
          : sailorLabel || regattaLabel,
      summary: `Updated result${sailorLabel ? ` for ${sailorLabel}` : ""}${regattaLabel ? ` at ${regattaLabel}` : ""}`,
      details: {
        sailorId: row.sailorId,
        regattaId: row.regattaId,
        sailorName: sailorLabel,
        regattaName: regattaLabel,
        fields: Object.keys(patch).filter((k) => k !== "updatedAt"),
        rank: row.rank,
        isDns: row.isDns,
      },
      source: "/api/admin/results",
    });
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
    const auth = await requireSuperadmin();
    const id = new URL(req.url).searchParams.get("id");
    if (!id) {
      return NextResponse.json({ error: "id required" }, { status: 400 });
    }
    const deleted = await db
      .delete(regattaResults)
      .where(eq(regattaResults.id, id))
      .returning({
        id: regattaResults.id,
        sailorId: regattaResults.sailorId,
        regattaId: regattaResults.regattaId,
        rank: regattaResults.rank,
      });
    if (!deleted[0]) {
      return NextResponse.json({ error: "Result not found" }, { status: 404 });
    }
    revalidatePublicRankings(`results:delete:${id}`);
    void logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: "result.delete",
      entityType: "result",
      entityId: deleted[0].id,
      entityLabel: null,
      summary: `Deleted result ${id}`,
      details: {
        sailorId: deleted[0].sailorId,
        regattaId: deleted[0].regattaId,
        rank: deleted[0].rank,
      },
      source: "/api/admin/results",
    });
    return NextResponse.json({ ok: true, id });
  } catch (e) {
    console.error("results DELETE", e);
    return jsonError(e);
  }
}
