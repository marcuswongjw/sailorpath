import { NextResponse } from "next/server";
import { and, desc, eq, isNull } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattaResults, regattas, sailors } from "@/db/schema";

/**
 * GET /api/admin/regatta-suggestions
 * Non-ranking regattas not yet reviewed (owner-submitted queue for promote/dismiss).
 */
export async function GET() {
  try {
    await requireSuperadmin();

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
      .where(
        and(eq(regattas.countsForRanking, false), isNull(regattas.reviewedAt))
      )
      .orderBy(desc(regattas.createdAt));

    const withSailors = await Promise.all(
      rows.map(async (r) => {
        const results = await db
          .select({
            resultId: regattaResults.id,
            rank: regattaResults.rank,
            nettScore: regattaResults.nettScore,
            sailorId: sailors.id,
            sailorName: sailors.name,
            sailorHandle: sailors.handle,
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
