import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattaResults, regattas, sailors } from "@/db/schema";
import { eq } from "drizzle-orm";

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

export async function GET() {
  try {
    await requireSuperadmin();
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

    // Bulk: create DNS rows for series members missing a result at this regatta
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
      const allSailors = await db.select().from(sailors);
      const eligible = allSailors.filter((s) =>
        seriesMatchesDivision(s, reg.division || "Gold")
      );
      const existing = await db
        .select({
          sailorId: regattaResults.sailorId,
        })
        .from(regattaResults)
        .where(eq(regattaResults.regattaId, regattaId));
      const have = new Set(existing.map((e) => e.sailorId));

      let created = 0;
      const createdRows: (typeof regattaResults.$inferSelect)[] = [];
      for (const s of eligible) {
        if (have.has(s.id)) continue;
        const [row] = await db
          .insert(regattaResults)
          .values({
            sailorId: s.id,
            regattaId,
            rank: dnsPoints,
            nettScore: dnsPoints,
            totalScore: null,
            isDns: true,
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
        message: `Created ${created} DNS results (score ${dnsPoints} = fleet ${reg.totalFleetSize} + 1) for non-starters in ${reg.division} series.`,
        created,
        dnsPoints,
        eligible: eligible.length,
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

    let rank = Math.round(Number(body.rank));
    if (!Number.isFinite(rank) || rank <= 0) {
      // Default DNS points from regatta fleet size when marking DNS without rank
      if (isDns) {
        const [reg] = await db
          .select({ totalFleetSize: regattas.totalFleetSize })
          .from(regattas)
          .where(eq(regattas.id, body.regattaId))
          .limit(1);
        rank = (reg?.totalFleetSize || 50) + 1;
      } else {
        rank = 999;
      }
    }
    const nettScore =
      body.nettScore != null && body.nettScore !== ""
        ? Number(body.nettScore)
        : rank;
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
      patch.nettScore = Number(body.nettScore) || 0;
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

    // If turning on DNS without changing rank, set default fleet+1
    if (patch.isDns === true && body.rank === undefined) {
      const [existing] = await db
        .select()
        .from(regattaResults)
        .where(eq(regattaResults.id, body.id))
        .limit(1);
      if (existing) {
        const [reg] = await db
          .select({ totalFleetSize: regattas.totalFleetSize })
          .from(regattas)
          .where(eq(regattas.id, existing.regattaId))
          .limit(1);
        if (reg && (existing.isDns !== true || body.forceDnsScore)) {
          // only auto-set if was not already DNS or explicit force
          if (!existing.isDns && !existing.isOverseasCommitment) {
            const pts = (reg.totalFleetSize || 50) + 1;
            patch.rank = pts;
            if (body.nettScore === undefined) patch.nettScore = pts;
          }
        }
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
