import { NextResponse } from "next/server";
import { and, eq, sql } from "drizzle-orm";
import { getAuthContext, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattaResults, regattas, sailors } from "@/db/schema";
import { slugify } from "@/lib/slug";
import { normalizeDob } from "@/lib/normalize";
import { trackUsage } from "@/lib/usage";

async function assertOwner(sailorId: string, userId: string, isAdmin: boolean) {
  const [sailor] = await db
    .select({ id: sailors.id, parentId: sailors.parentId })
    .from(sailors)
    .where(eq(sailors.id, sailorId))
    .limit(1);
  if (!sailor) return { error: "Sailor not found", status: 404 as const };
  if (!isAdmin && sailor.parentId !== userId) {
    return {
      error: "You can only edit results after claim is approved",
      status: 403 as const,
    };
  }
  return { sailor };
}

/**
 * Owner-added non-ranking logbook result (overseas / training / non-series).
 * Creates a personal regatta (counts_for_ranking=false) + one result row.
 */
export async function POST(req: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }
    const body = await req.json();
    const sailorId = String(body.sailorId || "").trim();
    const name = String(body.name || "").trim().slice(0, 160);
    const dateRaw = body.date;
    const date =
      typeof dateRaw === "string" && /^\d{4}-\d{2}-\d{2}/.test(dateRaw)
        ? dateRaw.slice(0, 10)
        : normalizeDob(dateRaw);

    if (!sailorId || !name || !date) {
      return NextResponse.json(
        { error: "sailorId, name, and date (YYYY-MM-DD) required" },
        { status: 400 }
      );
    }

    const gate = await assertOwner(
      sailorId,
      auth.userId,
      auth.role === "superadmin"
    );
    if ("error" in gate && gate.error) {
      return NextResponse.json({ error: gate.error }, { status: gate.status });
    }

    const rank = Math.max(1, Math.round(Number(body.rank) || 1));
    const totalFleetSize = Math.max(
      rank,
      Math.round(Number(body.totalFleetSize) || rank)
    );
    const nett =
      body.nettScore === "" || body.nettScore == null
        ? null
        : Number(body.nettScore);
    const total =
      body.totalScore === "" || body.totalScore == null
        ? null
        : Number(body.totalScore);
    const geography = String(body.geography || "INT")
      .trim()
      .toUpperCase()
      .slice(0, 12) || "INT";
    const boatClass = String(body.boatClass || "Optimist")
      .trim()
      .slice(0, 40) || "Optimist";

    const baseSlug = `log-${slugify(name) || "event"}-${date}-${sailorId.slice(0, 8)}`;
    let slug = baseSlug;
    // Ensure unique slug
    for (let i = 0; i < 5; i++) {
      const [hit] = await db
        .select({ id: regattas.id })
        .from(regattas)
        .where(eq(regattas.slug, slug))
        .limit(1);
      if (!hit) break;
      slug = `${baseSlug}-${Math.random().toString(36).slice(2, 5)}`;
    }

    const [reg] = await db
      .insert(regattas)
      .values({
        name,
        slug,
        date,
        totalFleetSize,
        division: "NonRanking",
        geography,
        boatClass,
        countsForRanking: false,
        raceCount: null,
      })
      .returning();

    const [result] = await db
      .insert(regattaResults)
      .values({
        regattaId: reg.id,
        sailorId,
        rank,
        nettScore:
          nett != null && Number.isFinite(nett) ? nett : null,
        totalScore:
          total != null && Number.isFinite(total) ? total : null,
        isDns: false,
        isOverseasCommitment: false,
      })
      .returning();

    void trackUsage({
      eventType: "personal_result",
      path: "/api/account/results",
      role: auth.role,
      meta: { geography },
    });

    return NextResponse.json({
      ok: true,
      regatta: reg,
      result,
      entry: {
        id: result.id,
        resultId: result.id,
        regattaId: reg.id,
        regattaName: reg.name,
        regattaSlug: reg.slug,
        regattaDate: reg.date,
        division: reg.division,
        fleetSize: reg.totalFleetSize,
        totalFleetSize: reg.totalFleetSize,
        rank: result.rank,
        nettScore: result.nettScore,
        totalScore: result.totalScore,
        isDns: false,
        isDNS: false,
        isOverseasCommitment: false,
        raceCount: null,
        geography: reg.geography,
        countsForRanking: false,
      },
    });
  } catch (e) {
    console.error("account results POST", e);
    return jsonError(e);
  }
}

/** Delete owner-added non-ranking result (+ regatta if only this sailor). */
export async function DELETE(req: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }
    const body = await req.json();
    const resultId = String(body.resultId || body.id || "").trim();
    if (!resultId) {
      return NextResponse.json({ error: "resultId required" }, { status: 400 });
    }

    const [row] = await db
      .select({
        resultId: regattaResults.id,
        sailorId: regattaResults.sailorId,
        regattaId: regattaResults.regattaId,
        countsForRanking: regattas.countsForRanking,
      })
      .from(regattaResults)
      .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
      .where(eq(regattaResults.id, resultId))
      .limit(1);

    if (!row) {
      return NextResponse.json({ error: "Not found" }, { status: 404 });
    }
    if (row.countsForRanking !== false) {
      return NextResponse.json(
        {
          error:
            "Series ranking results can only be changed by SailorPath admins",
        },
        { status: 403 }
      );
    }

    const gate = await assertOwner(
      row.sailorId,
      auth.userId,
      auth.role === "superadmin"
    );
    if ("error" in gate && gate.error) {
      return NextResponse.json({ error: gate.error }, { status: gate.status });
    }

    await db.delete(regattaResults).where(eq(regattaResults.id, resultId));

    // Drop personal regatta if no other results remain
    const [left] = await db
      .select({ n: sql<number>`count(*)::int` })
      .from(regattaResults)
      .where(eq(regattaResults.regattaId, row.regattaId));
    if (!left?.n) {
      await db.delete(regattas).where(
        and(
          eq(regattas.id, row.regattaId),
          eq(regattas.countsForRanking, false)
        )
      );
    }

    return NextResponse.json({ ok: true });
  } catch (e) {
    return jsonError(e);
  }
}
