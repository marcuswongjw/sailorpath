import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { sailors } from "@/db/schema";
import { asc, eq } from "drizzle-orm";
import {
  normalizeNationality,
  normalizeYearsList,
  sailorDbErrorHint,
  toDateOnly,
  validateGoldPromotion,
} from "@/lib/seriesMembership";
import {
  todayYmdSg,
  validateHalfBoundaryDate,
} from "@/lib/datesSg";

const DATE_FIELDS = [
  "goldEntryDate",
  "silverEntryDate",
  "dropDate",
  "dob",
] as const;

function num(v: unknown) {
  if (v === "" || v == null) return null;
  return Number.isFinite(Number(v)) ? Number(v) : null;
}

function failDb(e: unknown) {
  const hint = sailorDbErrorHint(e);
  if (hint) {
    console.error("sailors DB", e);
    return NextResponse.json({ error: hint }, { status: 500 });
  }
  return jsonError(e);
}

export async function GET() {
  try {
    await requireSuperadmin();
    const rows = await db.select().from(sailors).orderBy(asc(sailors.name));
    return NextResponse.json({ sailors: rows });
  } catch (e) {
    return failDb(e);
  }
}

export async function POST(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();
    const handle =
      (body.handle as string)?.trim() ||
      String(body.name || "")
        .toLowerCase()
        .replace(/[^a-z0-9]+/g, "-")
        .replace(/^-|-$/g, "");

    let silverEntryDate = toDateOnly(body.silverEntryDate);
    let goldEntryDate = toDateOnly(body.goldEntryDate);
    const dropDate = toDateOnly(body.dropDate);
    // SG Series Fleet: Guest | Series (legacy Gold/Silver → Series)
    const { normalizeSgSeriesMembership } = await import(
      "@/lib/seriesMembership"
    );
    let currentFleet = normalizeSgSeriesMembership(body.currentFleet);
    if (body.currentFleet === "" || body.currentFleet == null) {
      currentFleet = "Guest";
    }

    const goldBoundaryErr = validateHalfBoundaryDate(
      goldEntryDate,
      "Gold entry date"
    );
    if (goldBoundaryErr) {
      return NextResponse.json({ error: goldBoundaryErr }, { status: 400 });
    }
    const dropBoundaryErr = validateHalfBoundaryDate(
      dropDate,
      "Drop date"
    );
    if (dropBoundaryErr) {
      return NextResponse.json({ error: dropBoundaryErr }, { status: 400 });
    }

    const goldErr = validateGoldPromotion({
      currentFleet,
      goldEntryDate,
      silverEntryDate,
    });
    if (goldErr) {
      return NextResponse.json({ error: goldErr }, { status: 400 });
    }

    // Series without any entry date → stamp silver entry (required to rank)
    if (
      String(currentFleet || "").toLowerCase() === "series" &&
      !silverEntryDate &&
      !goldEntryDate
    ) {
      silverEntryDate = todayYmdSg();
    }

    const values: Record<string, unknown> = {
      name: body.name,
      handle,
      sailNumber: body.sailNumber || "SGP 000",
      club: body.club || "N/A",
      school: body.school || null,
      gender: body.gender || null,
      bio: body.bio || null,
      goldEntryDate,
      silverEntryDate,
      dropDate,
      currentFleet: currentFleet || "Guest",
      nationalSquadStatus: body.nationalSquadStatus || null,
      dob: toDateOnly(body.dob),
      weight: num(body.weight),
      instagram: body.instagram || null,
      avatarUrl:
        body.avatarUrl === "" || body.avatarUrl == null
          ? null
          : String(body.avatarUrl).trim(),
      natSquadStatusJan25: body.natSquadStatusJan25 || null,
      natSquadStatusJul25: body.natSquadStatusJul25 || null,
      natSquadStatusJan26: body.natSquadStatusJan26 || null,
      natSquadStatusJul26: body.natSquadStatusJul26 || null,
      histRankingJun24: num(body.histRankingJun24),
      histRankingDec24: num(body.histRankingDec24),
      histRankingJun25: num(body.histRankingJun25),
      histRankingDec25: num(body.histRankingDec25),
      histRankingJun26: num(body.histRankingJun26),
      worlds: normalizeYearsList(body.worlds),
      european: normalizeYearsList(body.european),
      asian: normalizeYearsList(body.asian),
      seaGames: normalizeYearsList(body.seaGames),
    };

    // nationality only if provided (column may be missing until migration 005)
    const nat = normalizeNationality(body.nationality);
    if (nat) values.nationality = nat;

    try {
      const [row] = await db
        .insert(sailors)
        .values(values as typeof sailors.$inferInsert)
        .returning();
      return NextResponse.json({ sailor: row });
    } catch (e) {
      // Retry without nationality if column not migrated yet
      if (
        values.nationality != null &&
        /nationality/i.test(e instanceof Error ? e.message : String(e))
      ) {
        delete values.nationality;
        const [row] = await db
          .insert(sailors)
          .values(values as typeof sailors.$inferInsert)
          .returning();
        return NextResponse.json({
          sailor: row,
          warning:
            "Saved without nationality — run 005_nationality.sql in Supabase to enable that field.",
        });
      }
      throw e;
    }
  } catch (e) {
    console.error(e);
    return failDb(e);
  }
}

export async function PATCH(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();
    if (!body.id) {
      return NextResponse.json({ error: "id required" }, { status: 400 });
    }

    const [existing] = await db
      .select({
        id: sailors.id,
        currentFleet: sailors.currentFleet,
        goldEntryDate: sailors.goldEntryDate,
        silverEntryDate: sailors.silverEntryDate,
        dropDate: sailors.dropDate,
      })
      .from(sailors)
      .where(eq(sailors.id, body.id))
      .limit(1);

    if (!existing) {
      return NextResponse.json({ error: "Sailor not found" }, { status: 404 });
    }

    const goldErr = validateGoldPromotion({
      currentFleet:
        body.currentFleet !== undefined
          ? body.currentFleet
          : existing.currentFleet,
      goldEntryDate:
        body.goldEntryDate !== undefined
          ? body.goldEntryDate
          : existing.goldEntryDate,
      silverEntryDate:
        body.silverEntryDate !== undefined
          ? body.silverEntryDate
          : existing.silverEntryDate,
      existing,
    });
    if (goldErr) {
      return NextResponse.json({ error: goldErr }, { status: 400 });
    }

    const { normalizeSgSeriesMembership } = await import(
      "@/lib/seriesMembership"
    );
    const patch: Record<string, unknown> = { updatedAt: new Date() };
    for (const f of [
      "name",
      "handle",
      "sailNumber",
      "club",
      "school",
      "gender",
      "bio",
      "nationalSquadStatus",
      "instagram",
      "avatarUrl",
      "natSquadStatusJan25",
      "natSquadStatusJul25",
      "natSquadStatusJan26",
      "natSquadStatusJul26",
    ] as const) {
      if (body[f] !== undefined) patch[f] = body[f] === "" ? null : body[f];
    }
    if (body.currentFleet !== undefined) {
      patch.currentFleet =
        body.currentFleet === "" || body.currentFleet == null
          ? "Guest"
          : normalizeSgSeriesMembership(body.currentFleet) || "Guest";
    }
    for (const f of DATE_FIELDS) {
      if (body[f] !== undefined) {
        patch[f] = body[f] === "" || body[f] == null ? null : toDateOnly(body[f]);
      }
    }
    if (body.goldEntryDate !== undefined) {
      const err = validateHalfBoundaryDate(
        patch.goldEntryDate as string | null,
        "Gold entry date"
      );
      if (err) return NextResponse.json({ error: err }, { status: 400 });
    }
    if (body.dropDate !== undefined) {
      const err = validateHalfBoundaryDate(
        patch.dropDate as string | null,
        "Drop date"
      );
      if (err) return NextResponse.json({ error: err }, { status: 400 });
    }
    if (body.nationality !== undefined) {
      patch.nationality =
        body.nationality === "" || body.nationality == null
          ? null
          : normalizeNationality(body.nationality);
    }
    for (const f of ["worlds", "european", "asian", "seaGames"] as const) {
      if (body[f] !== undefined) {
        patch[f] =
          body[f] === "" || body[f] == null
            ? null
            : normalizeYearsList(body[f]);
      }
    }
    // When admitting to Series with no entry dates, stamp silver entry (not Gold)
    if (
      body.currentFleet !== undefined &&
      String(patch.currentFleet || "").toLowerCase() === "series" &&
      !patch.silverEntryDate &&
      !existing.silverEntryDate &&
      !patch.goldEntryDate &&
      !existing.goldEntryDate
    ) {
      patch.silverEntryDate = todayYmdSg();
    }
    for (const f of [
      "weight",
      "histRankingJun24",
      "histRankingDec24",
      "histRankingJun25",
      "histRankingDec25",
      "histRankingJun26",
    ] as const) {
      if (body[f] !== undefined) {
        patch[f] =
          body[f] === "" || body[f] == null ? null : Number(body[f]);
      }
    }

    try {
      const [row] = await db
        .update(sailors)
        .set(patch as typeof sailors.$inferInsert)
        .where(eq(sailors.id, body.id))
        .returning();
      if (!row) {
        return NextResponse.json({ error: "Sailor not found" }, { status: 404 });
      }
      return NextResponse.json({ sailor: row });
    } catch (e) {
      // Retry without nationality if column not migrated
      if (
        "nationality" in patch &&
        /nationality/i.test(e instanceof Error ? e.message : String(e))
      ) {
        delete patch.nationality;
        const [row] = await db
          .update(sailors)
          .set(patch as typeof sailors.$inferInsert)
          .where(eq(sailors.id, body.id))
          .returning();
        if (!row) {
          return NextResponse.json(
            { error: "Sailor not found" },
            { status: 404 }
          );
        }
        return NextResponse.json({
          sailor: row,
          warning:
            "Saved without nationality — run 005_nationality.sql in Supabase to enable that field.",
        });
      }
      throw e;
    }
  } catch (e) {
    console.error("sailors PATCH", e);
    return failDb(e);
  }
}

export async function DELETE(req: Request) {
  try {
    await requireSuperadmin();
    const id = new URL(req.url).searchParams.get("id");
    if (!id) return NextResponse.json({ error: "id required" }, { status: 400 });
    const deleted = await db
      .delete(sailors)
      .where(eq(sailors.id, id))
      .returning({ id: sailors.id });
    if (!deleted[0]) {
      return NextResponse.json({ error: "Sailor not found" }, { status: 404 });
    }
    return NextResponse.json({ ok: true, id });
  } catch (e) {
    console.error("sailors DELETE", e);
    return failDb(e);
  }
}
