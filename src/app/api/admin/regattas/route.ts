import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattas } from "@/db/schema";
import { asc, eq } from "drizzle-orm";
import { slugifyWithDate } from "@/lib/slug";
import {
  isAnyIlcaClass,
  ILCA_MIN_RACES_FOR_RANKING,
} from "@/lib/ilcaRanking";
import { revalidatePublicRankings } from "@/lib/revalidatePublic";
import { logAdminChange } from "@/lib/adminChangeLog";

export async function GET(req: Request) {
  try {
    await requireSuperadmin();
    const sp = new URL(req.url).searchParams;
    const all = sp.get("all") === "1" || !sp.has("limit");
    const limitRaw = Number(sp.get("limit"));
    const offsetRaw = Number(sp.get("offset"));
    // Regatta list is usually small; default returns all (capped).
    const limit = all
      ? Math.min(
          2000,
          Number.isFinite(limitRaw) && limitRaw > 0 ? limitRaw : 2000
        )
      : Math.min(
          100,
          Number.isFinite(limitRaw) && limitRaw > 0 ? limitRaw : 50
        );
    const offset = Math.max(0, Number.isFinite(offsetRaw) ? offsetRaw : 0);

    const { count, desc } = await import("drizzle-orm");
    const [rows, totalRow] = await Promise.all([
      db
        .select()
        .from(regattas)
        .orderBy(desc(regattas.date))
        .limit(limit)
        .offset(offset),
      db.select({ n: count() }).from(regattas),
    ]);

    return NextResponse.json({
      regattas: rows,
      total: Number(totalRow[0]?.n || 0),
      limit,
      offset,
    });
  } catch (e) {
    return jsonError(e);
  }
}

export async function POST(req: Request) {
  try {
    const auth = await requireSuperadmin();
    const body = await req.json();
    if (!body.name || !body.date) {
      return NextResponse.json(
        { error: "name and date are required" },
        { status: 400 }
      );
    }
    const slug =
      (body.slug as string)?.trim() ||
      slugifyWithDate(String(body.name), String(body.date));
    const totalFleetSize = Number(body.totalFleetSize) || 50;
    const division = body.division || "Gold";
    const raceCount =
      body.raceCount === "" || body.raceCount == null
        ? null
        : Math.max(0, Math.round(Number(body.raceCount))) || null;
    const geography =
      body.geography != null && String(body.geography).trim()
        ? String(body.geography).trim().toUpperCase().slice(0, 12)
        : "SG";
    const boatClass =
      body.boatClass != null && String(body.boatClass).trim()
        ? String(body.boatClass).trim().slice(0, 40)
        : "Optimist";
    // Default: counts for series ranking. Off = non-ranking (trial / training / etc.)
    // ILCA: insufficient completed races → force non-ranking.
    let countsForRanking = body.countsForRanking !== false;
    let finalDivision = division || "Gold";
    if (division === "NonRanking") {
      countsForRanking = false;
      finalDivision = "NonRanking";
    } else if (body.countsForRanking === false) {
      countsForRanking = false;
    }
    let rankingNote: string | null = null;
    if (
      isAnyIlcaClass(boatClass) &&
      raceCount != null &&
      raceCount < ILCA_MIN_RACES_FOR_RANKING
    ) {
      countsForRanking = false;
      rankingNote = `ILCA event with ${raceCount} race(s) is non-ranking (minimum ${ILCA_MIN_RACES_FOR_RANKING} races for series).`;
    }

    const [row] = await db
      .insert(regattas)
      .values({
        name: String(body.name).trim(),
        slug,
        date: String(body.date),
        totalFleetSize,
        division: finalDivision,
        raceCount,
        geography,
        boatClass,
        countsForRanking,
      })
      .onConflictDoUpdate({
        target: regattas.slug,
        set: {
          name: String(body.name).trim(),
          date: String(body.date),
          totalFleetSize,
          division: finalDivision,
          raceCount,
          geography,
          boatClass,
          countsForRanking,
          updatedAt: new Date(),
        },
      })
      .returning();

    revalidatePublicRankings(`regattas:upsert:${row.id}`);
    void logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: "regatta.upsert",
      entityType: "regatta",
      entityId: row.id,
      entityLabel: row.name || null,
      summary: `Upserted regatta ${row.name}`,
      details: {
        date: row.date,
        division: row.division,
        boatClass: row.boatClass,
        countsForRanking: row.countsForRanking,
        totalFleetSize: row.totalFleetSize,
      },
      source: "/api/admin/regattas",
    });
    return NextResponse.json({ regatta: row, rankingNote });
  } catch (e) {
    console.error("regattas POST", e);
    return jsonError(e);
  }
}

export async function PATCH(req: Request) {
  try {
    const auth = await requireSuperadmin();
    const body = await req.json();
    if (!body.id) {
      return NextResponse.json({ error: "id required" }, { status: 400 });
    }

    const patch: Record<string, unknown> = { updatedAt: new Date() };
    if (body.name !== undefined) patch.name = String(body.name).trim();
    if (body.date !== undefined) patch.date = String(body.date);
    if (body.division !== undefined) patch.division = body.division || "Gold";
    if (body.totalFleetSize !== undefined) {
      patch.totalFleetSize = Number(body.totalFleetSize) || 50;
    }
    if (body.raceCount !== undefined) {
      patch.raceCount =
        body.raceCount === "" || body.raceCount == null
          ? null
          : Math.max(0, Math.round(Number(body.raceCount))) || null;
    }
    if (body.geography !== undefined) {
      patch.geography =
        body.geography === "" || body.geography == null
          ? "SG"
          : String(body.geography).trim().toUpperCase().slice(0, 12);
    }
    if (body.boatClass !== undefined) {
      patch.boatClass =
        body.boatClass === "" || body.boatClass == null
          ? "Optimist"
          : String(body.boatClass).trim().slice(0, 40);
    }
    if (body.slug !== undefined && body.slug) {
      patch.slug = String(body.slug).trim();
    }
    if (body.countsForRanking !== undefined) {
      patch.countsForRanking = Boolean(body.countsForRanking);
      if (!body.countsForRanking && patch.division == null) {
        /* keep division unless promoting */
      }
    }
    // Promote / dismiss suggestions
    if (body.action === "promote") {
      patch.countsForRanking = true;
      patch.reviewedAt = new Date();
      if (body.division) patch.division = body.division;
      if (body.geography !== undefined) {
        patch.geography = String(body.geography || "SG")
          .trim()
          .toUpperCase()
          .slice(0, 12);
      }
      if (body.totalFleetSize !== undefined) {
        patch.totalFleetSize = Number(body.totalFleetSize) || 50;
      }
      if (body.boatClass !== undefined) {
        patch.boatClass = String(body.boatClass || "Optimist").slice(0, 40);
      }
      if (!body.division || body.division === "NonRanking") {
        patch.division = "Gold";
      }
    }
    if (body.action === "dismiss") {
      patch.reviewedAt = new Date();
      patch.countsForRanking = false;
    }
    if (body.reviewedAt === null) {
      patch.reviewedAt = null;
    }

    // Resolve effective boat class + race count for ILCA min-races rule
    const [existing] = await db
      .select({
        boatClass: regattas.boatClass,
        raceCount: regattas.raceCount,
        countsForRanking: regattas.countsForRanking,
      })
      .from(regattas)
      .where(eq(regattas.id, body.id))
      .limit(1);

    const effectiveBoatClass =
      (patch.boatClass as string | undefined) ?? existing?.boatClass ?? "Optimist";
    const effectiveRaceCount =
      patch.raceCount !== undefined
        ? (patch.raceCount as number | null)
        : existing?.raceCount ?? null;
    let rankingNote: string | null = null;
    if (
      isAnyIlcaClass(effectiveBoatClass) &&
      effectiveRaceCount != null &&
      Number(effectiveRaceCount) < ILCA_MIN_RACES_FOR_RANKING &&
      body.action !== "promote"
    ) {
      patch.countsForRanking = false;
      rankingNote = `ILCA event with ${effectiveRaceCount} race(s) is non-ranking (minimum ${ILCA_MIN_RACES_FOR_RANKING} races for series).`;
    }

    const [row] = await db
      .update(regattas)
      .set(patch as typeof regattas.$inferInsert)
      .where(eq(regattas.id, body.id))
      .returning();

    if (!row) {
      return NextResponse.json({ error: "Regatta not found" }, { status: 404 });
    }
    revalidatePublicRankings(`regattas:patch:${row.id}`);
    void logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: body.action === "promote"
        ? "regatta.promote"
        : body.action === "dismiss"
          ? "regatta.dismiss"
          : "regatta.patch",
      entityType: "regatta",
      entityId: row.id,
      entityLabel: row.name || null,
      summary:
        body.action === "promote"
          ? `Promoted regatta ${row.name} to ranking`
          : body.action === "dismiss"
            ? `Dismissed regatta suggestion ${row.name}`
            : `Updated regatta ${row.name}`,
      details: {
        fields: Object.keys(patch).filter((k) => k !== "updatedAt"),
        action: body.action || null,
      },
      source: "/api/admin/regattas",
    });
    return NextResponse.json({ regatta: row, rankingNote });
  } catch (e) {
    console.error("regattas PATCH", e);
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
    // Results cascade via FK onDelete: cascade
    const deleted = await db
      .delete(regattas)
      .where(eq(regattas.id, id))
      .returning({ id: regattas.id, name: regattas.name });
    if (!deleted[0]) {
      return NextResponse.json({ error: "Regatta not found" }, { status: 404 });
    }
    revalidatePublicRankings(`regattas:delete:${id}`);
    void logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: "regatta.delete",
      entityType: "regatta",
      entityId: deleted[0].id,
      entityLabel: deleted[0].name || null,
      summary: `Deleted regatta ${deleted[0].name || id}`,
      source: "/api/admin/regattas",
    });
    return NextResponse.json({ ok: true, id });
  } catch (e) {
    console.error("regattas DELETE", e);
    return jsonError(e);
  }
}
