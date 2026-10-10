import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db, ensureCoreSchema } from "@/db";
import {
  regattaRaceResults,
  regattaResultParticipants,
  regattaResults,
  regattas,
  sailors,
} from "@/db/schema";
import { and, asc, eq, inArray } from "drizzle-orm";
import { revalidatePublicRankings } from "@/lib/revalidatePublic";
import {
  asOptionalNumber,
  asRank,
  asUuid,
} from "@/lib/validate";
import { logAdminChange } from "@/lib/adminChangeLog";
import {
  crewRuleFromRegatta,
  normalizeResultParticipants,
  validateParticipantCount,
} from "@/lib/regattaParticipants";

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

async function attachParticipants<T extends { id: string }>(rows: T[]) {
  if (!rows.length) return rows.map((row) => ({ ...row, participants: [] }));
  const participants = await db
    .select({
      id: regattaResultParticipants.id,
      resultId: regattaResultParticipants.regattaResultId,
      sailorId: regattaResultParticipants.sailorId,
      sailorName: sailors.name,
      sailorHandle: sailors.handle,
      sourceName: regattaResultParticipants.sourceName,
      displayOrder: regattaResultParticipants.displayOrder,
      role: regattaResultParticipants.role,
      matchStatus: regattaResultParticipants.matchStatus,
      rankingCredit: regattaResultParticipants.rankingCredit,
    })
    .from(regattaResultParticipants)
    .leftJoin(sailors, eq(regattaResultParticipants.sailorId, sailors.id))
    .where(
      inArray(
        regattaResultParticipants.regattaResultId,
        rows.map((row) => row.id)
      )
    )
    .orderBy(
      asc(regattaResultParticipants.regattaResultId),
      asc(regattaResultParticipants.displayOrder)
    );
  const byResult = new Map<string, typeof participants>();
  for (const participant of participants) {
    const list = byResult.get(participant.resultId) || [];
    list.push(participant);
    byResult.set(participant.resultId, list);
  }
  return rows.map((row) => ({
    ...row,
    participants: byResult.get(row.id) || [],
  }));
}

async function attachOfficialRaces<
  T extends { id: string; isDns: boolean | null; isOverseasCommitment: boolean | null },
>(rows: T[]) {
  if (!rows.length) return [];
  const rowsWithParticipants = await attachParticipants(rows);
  const raceRows = await db
    .select({
      regattaResultId: regattaRaceResults.regattaResultId,
      raceNumber: regattaRaceResults.raceNumber,
      score: regattaRaceResults.score,
      scoringCode: regattaRaceResults.scoringCode,
      discarded: regattaRaceResults.discarded,
      rawValue: regattaRaceResults.rawValue,
    })
    .from(regattaRaceResults)
    .where(inArray(regattaRaceResults.regattaResultId, rows.map((row) => row.id)))
    .orderBy(asc(regattaRaceResults.regattaResultId), asc(regattaRaceResults.raceNumber));
  const racesByResult = new Map<string, typeof raceRows>();
  for (const race of raceRows) {
    const list = racesByResult.get(race.regattaResultId) || [];
    list.push(race);
    racesByResult.set(race.regattaResultId, list);
  }
  return rowsWithParticipants.map((row) => ({
    ...row,
    isDNS: row.isDns,
    isOverseasCommitment: row.isOverseasCommitment,
    raceResults: (racesByResult.get(row.id) || []).map((race) => ({
      raceNumber: race.raceNumber,
      score: race.score,
      scoringCode: race.scoringCode,
      discarded: race.discarded,
      rawValue: race.rawValue,
    })),
  }));
}

export async function GET(req: Request) {
  try {
    await requireSuperadmin();
    if (typeof ensureCoreSchema === "function") {
      await ensureCoreSchema();
    }
    const sp = new URL(req.url).searchParams;
    const regattaId = (sp.get("regattaId") || "").trim();
    const includeRaces = sp.get("includeRaces") === "1";
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
      const results = includeRaces
        ? await attachOfficialRaces(rows)
        : (await attachParticipants(rows)).map((r) => ({
            ...r,
            isDNS: r.isDns,
            isOverseasCommitment: r.isOverseasCommitment,
          }));
      return NextResponse.json({
        results,
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
      results: (await attachParticipants(rows)).map((r) => ({
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
    if (typeof ensureCoreSchema === "function") {
      await ensureCoreSchema();
    }
    const body = await req.json();

    /**
     * fillDnsPeriod — removed. Optimist Tier 2 DNS is scored at ranking time as
     * max(sheet place) + 1 after results are uploaded. Do not invent fill rows.
     */
    if (
      body.action === "fillDnsPeriod" ||
      body.action === "fillDNSPeriod" ||
      body.action === "ensureFleetDns"
    ) {
      return NextResponse.json(
        {
          error:
            "Fill DNS period is removed. Absentees are auto-scored at ranking time as max(sheet place) + 1 after results upload. Official sheet DNS ranks are kept as published.",
          deprecated: true,
        },
        { status: 410 }
      );
    }

    // Bulk: create DNS for fleet members missing a result at ONE regatta
    /**
     * fillDns — removed. Tier 2 absentees are auto-scored at ranking time.
     */
    if (body.action === "fillDns" || body.action === "fillDNS") {
      return NextResponse.json(
        {
          error:
            "Fill DNS is removed. Absentees not on the uploaded sheet are auto-scored as max(sheet place) + 1 at ranking time. Do not create fill rows.",
          deprecated: true,
        },
        { status: 410 }
      );
    }

    const regattaIdR = asUuid(body.regattaId, "regattaId");
    if (!regattaIdR.ok) {
      return NextResponse.json(
        {
          error: regattaIdR.error,
        },
        { status: 400 }
      );
    }
    const normalizedParticipants = normalizeResultParticipants(
      body.participants,
      body.sailorId
    );
    if (!normalizedParticipants.ok) {
      return NextResponse.json({ error: normalizedParticipants.error }, { status: 400 });
    }
    for (const participant of normalizedParticipants.participants) {
      const sailorId = asUuid(participant.sailorId, "participant.sailorId");
      if (!sailorId.ok) {
        return NextResponse.json({ error: sailorId.error }, { status: 400 });
      }
      participant.sailorId = sailorId.value;
    }
    const isOverseasCommitment = parseOverseas(body);
    // Overseas commitment is not generic DNS (different scoring rule)
    let isDns = parseDns(body);
    if (isOverseasCommitment) isDns = false;

    const [regMeta] = await db
      .select({
        totalFleetSize: regattas.totalFleetSize,
        entryType: regattas.entryType,
        minParticipants: regattas.minParticipants,
        maxParticipants: regattas.maxParticipants,
      })
      .from(regattas)
      .where(eq(regattas.id, regattaIdR.value))
      .limit(1);
    if (!regMeta) {
      return NextResponse.json({ error: "Regatta not found" }, { status: 404 });
    }
    const participantRule = crewRuleFromRegatta(regMeta);
    const participantCountError = validateParticipantCount(
      participantRule,
      normalizedParticipants.participants
    );
    if (participantCountError) {
      return NextResponse.json({ error: participantCountError }, { status: 400 });
    }
    const profiles = await db
      .select({ id: sailors.id, name: sailors.name })
      .from(sailors)
      .where(inArray(sailors.id, normalizedParticipants.participants.map((p) => p.sailorId)));
    if (profiles.length !== normalizedParticipants.participants.length) {
      return NextResponse.json(
        { error: "One or more selected sailor profiles no longer exist" },
        { status: 400 }
      );
    }
    const profilesById = new Map(profiles.map((profile) => [profile.id, profile]));
    const participants = normalizedParticipants.participants.map((participant) => ({
      ...participant,
      sourceName: participant.sourceName || profilesById.get(participant.sailorId)?.name || "Unknown sailor",
      role: participantRule.entryType === "individual" ? "solo" : participant.role,
      rankingCredit:
        participantRule.entryType === "individual" || participant.rankingCredit === true,
    }));
    const primarySailorId = participants[0].sailorId;
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

    const existingForPrimary = await db
      .select({ id: regattaResults.id })
      .from(regattaResults)
      .where(
        and(
          eq(regattaResults.sailorId, primarySailorId),
          eq(regattaResults.regattaId, regattaIdR.value)
        )
      )
      .limit(1);
    const occupiedEntries = await db
      .select({ resultId: regattaResultParticipants.regattaResultId })
      .from(regattaResultParticipants)
      .innerJoin(
        regattaResults,
        eq(regattaResultParticipants.regattaResultId, regattaResults.id)
      )
      .where(
        and(
          eq(regattaResults.regattaId, regattaIdR.value),
          inArray(regattaResultParticipants.sailorId, participants.map((p) => p.sailorId))
        )
      );
    const conflict = occupiedEntries.find(
      (entry) => entry.resultId !== existingForPrimary[0]?.id
    );
    if (conflict) {
      return NextResponse.json(
        { error: "A selected sailor already has a result entry at this regatta" },
        { status: 409 }
      );
    }

    const [row] = await db.transaction(async (tx) => {
      const [saved] = await tx
        .insert(regattaResults)
        .values({
          sailorId: primarySailorId,
          regattaId: regattaIdR.value,
          entryLabel: String(body.entryLabel || "").trim().slice(0, 500) || participants.map((p) => p.sourceName).join(" / "),
          entrySailNumber: String(body.entrySailNumber || "").trim().slice(0, 100) || null,
          entryBoardNumber: String(body.entryBoardNumber || "").trim().slice(0, 100) || null,
          entryType: participantRule.entryType,
          rank,
          nettScore,
          totalScore,
          isDns,
          isOverseasCommitment,
        })
        .onConflictDoUpdate({
          target: [regattaResults.sailorId, regattaResults.regattaId],
          set: {
            entryLabel: String(body.entryLabel || "").trim().slice(0, 500) || participants.map((p) => p.sourceName).join(" / "),
            entrySailNumber: String(body.entrySailNumber || "").trim().slice(0, 100) || null,
            entryBoardNumber: String(body.entryBoardNumber || "").trim().slice(0, 100) || null,
            entryType: participantRule.entryType,
            rank,
            nettScore,
            totalScore,
            isDns,
            isOverseasCommitment,
            updatedAt: new Date(),
          },
        })
        .returning();
      await tx
        .delete(regattaResultParticipants)
        .where(eq(regattaResultParticipants.regattaResultId, saved.id));
      await tx.insert(regattaResultParticipants).values(
        participants.map((participant) => ({
          regattaResultId: saved.id,
          sailorId: participant.sailorId,
          sourceName: participant.sourceName,
          displayOrder: participant.displayOrder,
          role: participant.role,
          matchStatus: "matched" as const,
          rankingCredit: participant.rankingCredit,
        }))
      );
      return [saved];
    });

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
    const [resultWithParticipants] = await attachParticipants([row]);
    return NextResponse.json({
      result: {
        ...resultWithParticipants,
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
