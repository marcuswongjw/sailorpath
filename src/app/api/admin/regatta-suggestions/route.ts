import { NextResponse } from "next/server";
import { and, desc, eq, inArray, isNull, or } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattaResults, regattas, sailors } from "@/db/schema";
import { revalidatePublicRankings } from "@/lib/revalidatePublic";
import { logAdminChange } from "@/lib/adminChangeLog";

/**
 * GET /api/admin/regatta-suggestions
 * Non-ranking regattas not yet reviewed, or any regattas containing
 * pending-review evidence results (queue for verify / promote / dismiss).
 */
export async function GET() {
  try {
    await requireSuperadmin();

    // 1. Find all regatta IDs that have results awaiting verification
    const pendingResultRegattas = await db
      .selectDistinct({ regattaId: regattaResults.regattaId })
      .from(regattaResults)
      .where(eq(regattaResults.verificationStatus, "pending_review"));

    const pendingRegattaIds = pendingResultRegattas.map((r) => r.regattaId);

    const conditions = [
      and(eq(regattas.countsForRanking, false), isNull(regattas.reviewedAt)),
    ];
    if (pendingRegattaIds.length > 0) {
      conditions.push(inArray(regattas.id, pendingRegattaIds));
    }

    const rows = await db
      .select({
        id: regattas.id,
        name: regattas.name,
        slug: regattas.slug,
        date: regattas.date,
        totalFleetSize: regattas.totalFleetSize,
        division: regattas.division,
        geography: regattas.geography,
        boatClass: regattas.boatClass,
        countsForRanking: regattas.countsForRanking,
        reviewedAt: regattas.reviewedAt,
        createdAt: regattas.createdAt,
      })
      .from(regattas)
      .where(or(...conditions))
      .orderBy(desc(regattas.createdAt));

    const withSailors = await Promise.all(
      rows.map(async (r) => {
        const results = await db
          .select({
            resultId: regattaResults.id,
            rank: regattaResults.rank,
            nettScore: regattaResults.nettScore,
            totalScore: regattaResults.totalScore,
            sailorId: sailors.id,
            sailorName: sailors.name,
            sailorHandle: sailors.handle,
            evidenceUrl: regattaResults.evidenceUrl,
            evidenceName: regattaResults.evidenceName,
            evidenceType: regattaResults.evidenceType,
            officialUrl: regattaResults.officialUrl,
            evidenceNotes: regattaResults.evidenceNotes,
            verificationStatus: regattaResults.verificationStatus,
            verifiedAt: regattaResults.verifiedAt,
          })
          .from(regattaResults)
          .innerJoin(sailors, eq(regattaResults.sailorId, sailors.id))
          .where(eq(regattaResults.regattaId, r.id));
        return { ...r, results };
      })
    );

    return NextResponse.json({
      suggestions: withSailors,
      count: withSailors.length,
    });
  } catch (e) {
    return jsonError(e);
  }
}

/**
 * PATCH /api/admin/regatta-suggestions
 * Supports:
 * - action: "verify" (resultId) -> marks evidence verified
 * - action: "reject" (resultId) -> marks evidence rejected
 * - action: "dismiss" (regattaId) -> marks regatta reviewed
 * - action: "promote" (regattaId, division, geography, totalFleetSize) -> promotes to ranking regatta
 */
export async function PATCH(req: Request) {
  try {
    const auth = await requireSuperadmin();
    const body = await req.json().catch(() => ({}));
    const action = String(body.action || "").trim().toLowerCase();

    if (action === "verify") {
      const resultId = String(body.resultId || "").trim();
      if (!resultId) {
        return NextResponse.json(
          { error: "resultId is required" },
          { status: 400 }
        );
      }
      const [updated] = await db
        .update(regattaResults)
        .set({
          verificationStatus: "verified",
          verifiedAt: new Date(),
          verifiedBy: auth.userId,
          updatedAt: new Date(),
        })
        .where(eq(regattaResults.id, resultId))
        .returning();

      if (!updated) {
        return NextResponse.json(
          { error: "Result not found" },
          { status: 404 }
        );
      }

      revalidatePublicRankings(`admin:result:verify:${resultId}`);
      void logAdminChange({
        actorUserId: auth.userId,
        actorEmail: auth.email,
        action: "regatta_result.verify",
        entityType: "regatta_result",
        entityId: resultId,
        entityLabel: `Result ${resultId}`,
        summary: `Verified regatta result evidence`,
        details: { verificationStatus: "verified" },
        source: "/api/admin/regatta-suggestions",
      });

      return NextResponse.json({ ok: true, result: updated });
    }

    if (action === "reject") {
      const resultId = String(body.resultId || "").trim();
      if (!resultId) {
        return NextResponse.json(
          { error: "resultId is required" },
          { status: 400 }
        );
      }
      const [updated] = await db
        .update(regattaResults)
        .set({
          verificationStatus: "rejected",
          verifiedAt: new Date(),
          verifiedBy: auth.userId,
          updatedAt: new Date(),
        })
        .where(eq(regattaResults.id, resultId))
        .returning();

      if (!updated) {
        return NextResponse.json(
          { error: "Result not found" },
          { status: 404 }
        );
      }

      revalidatePublicRankings(`admin:result:reject:${resultId}`);
      void logAdminChange({
        actorUserId: auth.userId,
        actorEmail: auth.email,
        action: "regatta_result.reject",
        entityType: "regatta_result",
        entityId: resultId,
        entityLabel: `Result ${resultId}`,
        summary: `Rejected regatta result evidence`,
        details: { verificationStatus: "rejected" },
        source: "/api/admin/regatta-suggestions",
      });

      return NextResponse.json({ ok: true, result: updated });
    }

    if (action === "dismiss") {
      const regattaId = String(body.regattaId || body.id || "").trim();
      if (!regattaId) {
        return NextResponse.json(
          { error: "regattaId is required" },
          { status: 400 }
        );
      }
      const [updated] = await db
        .update(regattas)
        .set({
          reviewedAt: new Date(),
          updatedAt: new Date(),
        })
        .where(eq(regattas.id, regattaId))
        .returning();

      if (!updated) {
        return NextResponse.json(
          { error: "Regatta not found" },
          { status: 404 }
        );
      }

      void logAdminChange({
        actorUserId: auth.userId,
        actorEmail: auth.email,
        action: "regatta.dismiss",
        entityType: "regatta",
        entityId: regattaId,
        entityLabel: updated.name,
        summary: `Dismissed regatta suggestion ${updated.name}`,
        details: { reviewedAt: updated.reviewedAt },
        source: "/api/admin/regatta-suggestions",
      });

      return NextResponse.json({ ok: true, regatta: updated });
    }

    if (action === "promote") {
      const regattaId = String(body.regattaId || body.id || "").trim();
      if (!regattaId) {
        return NextResponse.json(
          { error: "regattaId is required" },
          { status: 400 }
        );
      }
      const division = body.division ? String(body.division) : "Gold";
      const geography = body.geography ? String(body.geography) : "SGP";
      const totalFleetSize = Number(body.totalFleetSize) || 50;

      const [updated] = await db
        .update(regattas)
        .set({
          countsForRanking: true,
          division,
          geography,
          totalFleetSize,
          reviewedAt: new Date(),
          updatedAt: new Date(),
        })
        .where(eq(regattas.id, regattaId))
        .returning();

      if (!updated) {
        return NextResponse.json(
          { error: "Regatta not found" },
          { status: 404 }
        );
      }

      revalidatePublicRankings(`admin:regatta:promote:${regattaId}`);
      void logAdminChange({
        actorUserId: auth.userId,
        actorEmail: auth.email,
        action: "regatta.promote",
        entityType: "regatta",
        entityId: regattaId,
        entityLabel: updated.name,
        summary: `Promoted regatta ${updated.name} to ranking series`,
        details: { division, geography, totalFleetSize },
        source: "/api/admin/regatta-suggestions",
      });

      return NextResponse.json({ ok: true, regatta: updated });
    }

    return NextResponse.json({ error: "Invalid action" }, { status: 400 });
  } catch (e) {
    return jsonError(e);
  }
}
