import { NextResponse } from "next/server";
import { and, desc, eq, sql } from "drizzle-orm";
import { getAuthContext, jsonError } from "@/lib/auth";
import { canManageSailor } from "@/lib/claimAccess";
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
  const ok = await canManageSailor(
    sailorId,
    userId,
    isAdmin,
    sailor.parentId
  );
  if (!ok) {
    return {
      error: "You can only edit results after claim is approved",
      status: 403 as const,
    };
  }
  return { sailor };
}

/**
 * Allow only http(s) absolute URLs or site-relative paths for user-supplied
 * evidence/official links — blocks javascript: and other dangerous schemes.
 */
function parseSafeUrl(
  v: unknown
): { ok: true; value: string | null } | { ok: false } {
  if (v == null || v === "") return { ok: true, value: null };
  const s = String(v).trim();
  if (!s) return { ok: true, value: null };
  if (s.startsWith("/") && !s.startsWith("//")) {
    return { ok: true, value: s.slice(0, 500) };
  }
  try {
    const u = new URL(s);
    if (u.protocol === "http:" || u.protocol === "https:") {
      return { ok: true, value: s.slice(0, 500) };
    }
  } catch {
    /* fall through */
  }
  return { ok: false };
}

/**
 * GET /api/account/results?sailorId=<id>
 * Fetches all results (official series & owner logbook non-ranking) for a sailor.
 */
export async function GET(req: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }
    const { searchParams } = new URL(req.url);
    const sailorId = String(searchParams.get("sailorId") || "").trim();
    if (!sailorId) {
      return NextResponse.json(
        { error: "sailorId is required" },
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

    const rows = await db
      .select({
        id: regattaResults.id,
        rank: regattaResults.rank,
        nettScore: regattaResults.nettScore,
        totalScore: regattaResults.totalScore,
        isDns: regattaResults.isDns,
        isOverseasCommitment: regattaResults.isOverseasCommitment,
        evidenceUrl: regattaResults.evidenceUrl,
        evidenceName: regattaResults.evidenceName,
        evidenceType: regattaResults.evidenceType,
        officialUrl: regattaResults.officialUrl,
        evidenceNotes: regattaResults.evidenceNotes,
        verificationStatus: regattaResults.verificationStatus,
        verifiedAt: regattaResults.verifiedAt,
        regattaId: regattas.id,
        regattaName: regattas.name,
        regattaDate: regattas.date,
        regattaEndDate: regattas.endDate,
        venue: regattas.venue,
        boatClass: regattas.boatClass,
        division: regattas.division,
        geography: regattas.geography,
        totalFleetSize: regattas.totalFleetSize,
        countsForRanking: regattas.countsForRanking,
        slug: regattas.slug,
      })
      .from(regattaResults)
      .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
      .where(eq(regattaResults.sailorId, sailorId))
      .orderBy(desc(regattas.date));

    const mappedRows = rows.map((r) => {
      const isOfficial = !r.slug?.startsWith("log-") || Boolean(r.countsForRanking);
      return {
        ...r,
        verificationStatus: isOfficial
          ? "verified"
          : r.verificationStatus || "self_reported",
      };
    });

    return NextResponse.json({ results: mappedRows });
  } catch (e) {
    return jsonError(e);
  }
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

    const venue = body.venue ? String(body.venue).trim().slice(0, 120) : null;
    const endDate =
      typeof body.endDate === "string" && /^\d{4}-\d{2}-\d{2}/.test(body.endDate)
        ? body.endDate.slice(0, 10)
        : null;
    const division = String(body.division || "NonRanking").trim().slice(0, 40) || "NonRanking";

    const ev = parseSafeUrl(body.evidenceUrl);
    if (!ev.ok) {
      return NextResponse.json(
        { error: "Evidence URL must be a valid http(s) link" },
        { status: 400 }
      );
    }
    const evidenceUrl = ev.value;
    const evidenceName = body.evidenceName ? String(body.evidenceName).trim().slice(0, 200) : null;
    const off = parseSafeUrl(body.officialUrl);
    if (!off.ok) {
      return NextResponse.json(
        { error: "Official results URL must be a valid http(s) link" },
        { status: 400 }
      );
    }
    const officialUrl = off.value;
    const evidenceNotes = body.evidenceNotes ? String(body.evidenceNotes).trim().slice(0, 500) : null;
    // Strip query/hash before the suffix test — Supabase signed URLs look like
    // ".../doc.pdf?token=..." and would otherwise be misclassified as images.
    const evidencePath = evidenceUrl?.split(/[?#]/)[0].toLowerCase();
    const evidenceType =
      body.evidenceType && ["pdf", "image", "link"].includes(body.evidenceType)
        ? body.evidenceType
        : evidencePath?.endsWith(".pdf")
        ? "pdf"
        : evidenceUrl
        ? "image"
        : officialUrl
        ? "link"
        : null;

    const verificationStatus = (evidenceUrl || officialUrl) ? "pending_review" : "self_reported";

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
        endDate,
        venue,
        totalFleetSize,
        division,
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
        evidenceUrl,
        evidenceName,
        evidenceType,
        officialUrl,
        evidenceNotes,
        verificationStatus,
      })
      .returning();

    void trackUsage({
      eventType: "personal_result",
      path: "/api/account/results",
      role: auth.role,
      meta: { geography, hasEvidence: Boolean(evidenceUrl || officialUrl) },
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
        endDate: reg.endDate,
        venue: reg.venue,
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
        boatClass: reg.boatClass,
        countsForRanking: false,
        evidenceUrl: result.evidenceUrl,
        evidenceName: result.evidenceName,
        evidenceType: result.evidenceType,
        officialUrl: result.officialUrl,
        evidenceNotes: result.evidenceNotes,
        verificationStatus: result.verificationStatus,
        verifiedAt: result.verifiedAt,
      },
    });
  } catch (e) {
    console.error("account results POST", e);
    return jsonError(e);
  }
}

/** Update personal non-ranking result or attach/update evidence. */
export async function PATCH(req: Request) {
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
        evidenceUrl: regattaResults.evidenceUrl,
        officialUrl: regattaResults.officialUrl,
        regattaSlug: regattas.slug,
        regattaName: regattas.name,
        regattaDate: regattas.date,
        regattaEndDate: regattas.endDate,
        regattaVenue: regattas.venue,
        regattaDivision: regattas.division,
        regattaFleetSize: regattas.totalFleetSize,
        regattaGeography: regattas.geography,
        regattaBoatClass: regattas.boatClass,
      })
      .from(regattaResults)
      .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
      .where(eq(regattaResults.id, resultId))
      .limit(1);

    if (!row) {
      return NextResponse.json({ error: "Result not found" }, { status: 404 });
    }
    if (row.countsForRanking !== false) {
      return NextResponse.json(
        { error: "Official ranking series results can only be updated by admins" },
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

    // Only personal logbook regattas (created via POST here, slug `log-…`)
    // may have their event details edited by an owner. Shared non-ranking
    // regattas (e.g. admin imports) hold other sailors' results, so an owner
    // of one result must not rename/reschedule the whole event.
    const isPersonalLog = row.regattaSlug.startsWith("log-");

    const resultPatch: Record<string, unknown> = { updatedAt: new Date() };
    const regattaPatch: Record<string, unknown> = { updatedAt: new Date() };

    if (body.rank !== undefined) {
      resultPatch.rank = Math.max(1, Math.round(Number(body.rank) || 1));
    }
    if (body.nettScore !== undefined) {
      const n =
        body.nettScore === "" || body.nettScore == null
          ? null
          : Number(body.nettScore);
      resultPatch.nettScore = n != null && Number.isFinite(n) ? n : null;
    }
    if (body.totalScore !== undefined) {
      const n =
        body.totalScore === "" || body.totalScore == null
          ? null
          : Number(body.totalScore);
      resultPatch.totalScore = n != null && Number.isFinite(n) ? n : null;
    }
    if (body.evidenceUrl !== undefined) {
      const p = parseSafeUrl(body.evidenceUrl);
      if (!p.ok) {
        return NextResponse.json(
          { error: "Evidence URL must be a valid http(s) link" },
          { status: 400 }
        );
      }
      resultPatch.evidenceUrl = p.value;
    }
    if (body.evidenceName !== undefined) {
      resultPatch.evidenceName = body.evidenceName ? String(body.evidenceName).trim().slice(0, 200) : null;
    }
    if (body.officialUrl !== undefined) {
      const p = parseSafeUrl(body.officialUrl);
      if (!p.ok) {
        return NextResponse.json(
          { error: "Official results URL must be a valid http(s) link" },
          { status: 400 }
        );
      }
      resultPatch.officialUrl = p.value;
    }
    if (body.evidenceNotes !== undefined) {
      resultPatch.evidenceNotes = body.evidenceNotes ? String(body.evidenceNotes).trim().slice(0, 500) : null;
    }
    if (body.evidenceType !== undefined) {
      resultPatch.evidenceType =
        body.evidenceType && ["pdf", "image", "link"].includes(body.evidenceType)
          ? body.evidenceType
          : null;
    }

    // Reset verification only when evidence actually changed — the edit form
    // echoes back unchanged URLs, which must not regress a verified result.
    const nextEvidenceUrl =
      body.evidenceUrl !== undefined
        ? (resultPatch.evidenceUrl as string | null)
        : row.evidenceUrl;
    const nextOfficialUrl =
      body.officialUrl !== undefined
        ? (resultPatch.officialUrl as string | null)
        : row.officialUrl;
    if (
      nextEvidenceUrl !== row.evidenceUrl ||
      nextOfficialUrl !== row.officialUrl
    ) {
      resultPatch.verifiedAt = null;
      resultPatch.verifiedBy = null;
      if (nextEvidenceUrl || nextOfficialUrl) {
        resultPatch.verificationStatus = "pending_review";
        if (isPersonalLog) regattaPatch.reviewedAt = null;
      } else {
        // Evidence removed entirely — back to self-reported
        resultPatch.verificationStatus = "self_reported";
      }
    }

    if (isPersonalLog) {
      if (body.name !== undefined && String(body.name).trim()) {
        regattaPatch.name = String(body.name).trim().slice(0, 160);
      }
      if (body.date !== undefined && /^\d{4}-\d{2}-\d{2}/.test(String(body.date))) {
        regattaPatch.date = String(body.date).slice(0, 10);
      }
      // Blank fleet size means "keep existing" (the field is optional in the form)
      if (
        body.totalFleetSize !== undefined &&
        body.totalFleetSize !== null &&
        body.totalFleetSize !== ""
      ) {
        regattaPatch.totalFleetSize = Math.max(1, Math.round(Number(body.totalFleetSize) || 1));
      }
      if (body.geography !== undefined) {
        regattaPatch.geography = String(body.geography || "INT").trim().toUpperCase().slice(0, 12) || "INT";
      }
      if (body.boatClass !== undefined) {
        regattaPatch.boatClass = String(body.boatClass || "Optimist").trim().slice(0, 40) || "Optimist";
      }
      if (body.venue !== undefined) {
        regattaPatch.venue = body.venue ? String(body.venue).trim().slice(0, 120) : null;
      }
      if (body.endDate !== undefined) {
        regattaPatch.endDate =
          typeof body.endDate === "string" && /^\d{4}-\d{2}-\d{2}/.test(body.endDate)
            ? body.endDate.slice(0, 10)
            : null;
      }
    }

    const [updatedResult] = await db
      .update(regattaResults)
      .set(resultPatch)
      .where(eq(regattaResults.id, resultId))
      .returning();

    let updatedReg;
    if (isPersonalLog) {
      [updatedReg] = await db
        .update(regattas)
        .set(regattaPatch)
        .where(eq(regattas.id, row.regattaId))
        .returning();
    }
    const reg = updatedReg ?? {
      id: row.regattaId,
      name: row.regattaName,
      slug: row.regattaSlug,
      date: row.regattaDate,
      endDate: row.regattaEndDate,
      venue: row.regattaVenue,
      division: row.regattaDivision,
      totalFleetSize: row.regattaFleetSize,
      geography: row.regattaGeography,
      boatClass: row.regattaBoatClass,
    };

    return NextResponse.json({
      ok: true,
      entry: {
        id: updatedResult.id,
        resultId: updatedResult.id,
        regattaId: reg.id,
        regattaName: reg.name,
        regattaSlug: reg.slug,
        regattaDate: reg.date,
        endDate: reg.endDate,
        venue: reg.venue,
        division: reg.division,
        fleetSize: reg.totalFleetSize,
        totalFleetSize: reg.totalFleetSize,
        rank: updatedResult.rank,
        nettScore: updatedResult.nettScore,
        totalScore: updatedResult.totalScore,
        isDns: false,
        isDNS: false,
        isOverseasCommitment: false,
        raceCount: null,
        geography: reg.geography,
        boatClass: reg.boatClass,
        countsForRanking: false,
        evidenceUrl: updatedResult.evidenceUrl,
        evidenceName: updatedResult.evidenceName,
        evidenceType: updatedResult.evidenceType,
        officialUrl: updatedResult.officialUrl,
        evidenceNotes: updatedResult.evidenceNotes,
        verificationStatus: updatedResult.verificationStatus,
        verifiedAt: updatedResult.verifiedAt,
      },
    });
  } catch (e) {
    console.error("account results PATCH", e);
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
