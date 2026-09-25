import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db, ensureCoreSchema } from "@/db";
import { regattas } from "@/db/schema";
import { eq } from "drizzle-orm";
import { slugifyWithDate } from "@/lib/slug";
import { MIN_RACES_FOR_RANKING } from "@/lib/ranking";
import { asOptionalRaceCount, asPositiveInteger } from "@/lib/validate";
import { revalidatePublicRankings } from "@/lib/revalidatePublic";
import { logAdminChange } from "@/lib/adminChangeLog";
import { linkRegattaEvents } from "@/lib/admin/linkRegattaEvents";

export async function GET(req: Request) {
  try {
    await requireSuperadmin();
    if (typeof ensureCoreSchema === "function") {
      await ensureCoreSchema();
    }
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
    if (typeof ensureCoreSchema === "function") {
      await ensureCoreSchema();
    }
    const body = await req.json();

    // Link 2026 calendar weekends to the class sheets already stored.
    // Does not create or publish scoreboards.
    if (body.action === "seed-2026") {
      const linked = await linkRegattaEvents();
      revalidatePublicRankings("regattas:link:2026");
      void logAdminChange({
        actorUserId: auth.userId,
        actorEmail: auth.email,
        action: "regattas_link_2026",
        entityType: "regatta_event",
        summary: `Linked ${linked.linked} class sheets to ${linked.events} events`,
        details: linked,
      });
      return NextResponse.json({
        ok: true,
        ...linked,
        message: `Linked ${linked.linked} class sheets to ${linked.events} events`,
      });
    }

    if (!body.name || !body.date) {
      return NextResponse.json(
        { error: "name and date are required" },
        { status: 400 }
      );
    }
    const slug =
      (body.slug as string)?.trim() ||
      slugifyWithDate(String(body.name), String(body.date));
    const fleetSizeResult = asPositiveInteger(
      body.totalFleetSize == null || body.totalFleetSize === ""
        ? 50
        : body.totalFleetSize,
      "totalFleetSize"
    );
    if (!fleetSizeResult.ok) {
      return NextResponse.json({ error: fleetSizeResult.error }, { status: 400 });
    }
    const totalFleetSize = fleetSizeResult.value;
    const division = body.division || "Gold";
    const raceCountResult = asOptionalRaceCount(body.raceCount);
    if (!raceCountResult.ok) {
      return NextResponse.json({ error: raceCountResult.error }, { status: 400 });
    }
    const raceCount = raceCountResult.value;
    const geography =
      body.geography != null && String(body.geography).trim()
        ? String(body.geography).trim().toUpperCase().slice(0, 12)
        : "SG";
    const boatClass =
      body.boatClass != null && String(body.boatClass).trim()
        ? String(body.boatClass).trim().slice(0, 40)
        : "Optimist";
    // Default: counts for series ranking. Off = non-ranking (trial / training / etc.)
    // Fewer than 3 completed races → non-ranking for every class.
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
      raceCount != null &&
      raceCount < MIN_RACES_FOR_RANKING
    ) {
      countsForRanking = false;
      rankingNote = `Regatta with ${raceCount} race(s) is non-ranking (minimum ${MIN_RACES_FOR_RANKING} races required for ranking series).`;
    }

    const venue = body.venue ? String(body.venue).trim() : null;
    const endDate = body.endDate ? String(body.endDate).slice(0, 10) : null;
    const norUrl = body.norUrl ? String(body.norUrl).trim() : null;
    const registrationUrl = body.registrationUrl ? String(body.registrationUrl).trim() : null;
    const isSelectionTrial = Boolean(body.isSelectionTrial);
    const organizer = body.organizer ? String(body.organizer).trim() : null;
    const scheduleNotes = body.scheduleNotes ? String(body.scheduleNotes).trim() : null;
    const status = body.status || "published";

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
        venue,
        endDate,
        norUrl,
        registrationUrl,
        isSelectionTrial,
        organizer,
        scheduleNotes,
        status,
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
          venue,
          endDate,
          norUrl,
          registrationUrl,
          isSelectionTrial,
          organizer,
          scheduleNotes,
          status,
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
    if (typeof ensureCoreSchema === "function") {
      await ensureCoreSchema();
    }
    const body = await req.json();
    if (!body.id) {
      return NextResponse.json({ error: "id required" }, { status: 400 });
    }

    const patch: Record<string, unknown> = { updatedAt: new Date() };
    if (body.name !== undefined) patch.name = String(body.name).trim();
    if (body.date !== undefined) patch.date = String(body.date);
    if (body.division !== undefined) patch.division = body.division || "Gold";
    if (body.totalFleetSize !== undefined) {
      const fsr = asPositiveInteger(body.totalFleetSize, "totalFleetSize");
      if (!fsr.ok) {
        return NextResponse.json({ error: fsr.error }, { status: 400 });
      }
      patch.totalFleetSize = fsr.value;
    }
    if (body.raceCount !== undefined) {
      const raceCountResult = asOptionalRaceCount(body.raceCount);
      if (!raceCountResult.ok) {
        return NextResponse.json({ error: raceCountResult.error }, { status: 400 });
      }
      patch.raceCount = raceCountResult.value;
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
    if (body.venue !== undefined) {
      patch.venue = body.venue === "" || body.venue == null ? null : String(body.venue).trim();
    }
    if (body.endDate !== undefined) {
      patch.endDate = body.endDate === "" || body.endDate == null ? null : String(body.endDate).slice(0, 10);
    }
    if (body.norUrl !== undefined) {
      patch.norUrl = body.norUrl === "" || body.norUrl == null ? null : String(body.norUrl).trim();
    }
    if (body.registrationUrl !== undefined) {
      patch.registrationUrl = body.registrationUrl === "" || body.registrationUrl == null ? null : String(body.registrationUrl).trim();
    }
    if (body.isSelectionTrial !== undefined) {
      patch.isSelectionTrial = Boolean(body.isSelectionTrial);
    }
    if (body.organizer !== undefined) {
      patch.organizer = body.organizer === "" || body.organizer == null ? null : String(body.organizer).trim();
    }
    if (body.scheduleNotes !== undefined) {
      patch.scheduleNotes = body.scheduleNotes === "" || body.scheduleNotes == null ? null : String(body.scheduleNotes).trim();
    }
    if (body.status !== undefined) {
      patch.status = body.status;
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

    // Promoting an already-ranking regatta would clobber its division /
    // geography / fleet size with suggestion defaults — refuse instead.
    if (body.action === "promote" && existing?.countsForRanking) {
      return NextResponse.json(
        { error: "Regatta already counts for ranking" },
        { status: 409 }
      );
    }
    const races = effectiveRaceCount == null ? null : Number(effectiveRaceCount);
    if (
      body.action === "promote" &&
      races != null &&
      races < MIN_RACES_FOR_RANKING
    ) {
      return NextResponse.json(
        {
          error: `Cannot promote: ${races} completed race(s). Ranking needs at least ${MIN_RACES_FOR_RANKING}.`,
        },
        { status: 400 }
      );
    }
    let rankingNote: string | null = null;
    if (races != null && races < MIN_RACES_FOR_RANKING) {
      patch.countsForRanking = false;
      rankingNote = `Regatta with ${races} race(s) is non-ranking (minimum ${MIN_RACES_FOR_RANKING} races required for ranking series).`;
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
