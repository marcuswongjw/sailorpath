import { NextResponse } from "next/server";
import { and, eq, ilike, inArray, isNotNull, sql } from "drizzle-orm";
import { db, ensureCoreSchema, withSequentialDatabaseReads } from "@/db";
import { regattaResults, regattas, sailors } from "@/db/schema";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { todayYmdSg } from "@/lib/datesSg";
import {
  buildGoldFormIndex,
  type GoldFormIndexSummary,
} from "@/lib/admin/goldFormIndex";

export const dynamic = "force-dynamic";
export const runtime = "nodejs";
export const maxDuration = 30;

export type AdminGoldFormResponse = {
  sgRanking: GoldFormIndexSummary;
  allGold: GoldFormIndexSummary;
  generatedAt: string;
};

/**
 * Superadmin-only Gold fleet form & up-and-coming watchlist index.
 * Queries Optimist Gold sailors and published Optimist Gold regattas directly
 * so historical coverage is never truncated by general admin table caps.
 */
export async function GET(request: Request) {
  try {
    await requireSuperadmin(request.signal);
    if (typeof ensureCoreSchema === "function") {
      await ensureCoreSchema();
    }

    const [sailorRows, regattaRows] = await withSequentialDatabaseReads(
      [
        () =>
          db
            .select({
              id: sailors.id,
              name: sailors.name,
              handle: sailors.handle,
              sailNumber: sailors.sailNumber,
              club: sailors.club,
              school: sailors.school,
              gender: sailors.gender,
              nationality: sailors.nationality,
              dob: sql<string | null>`${sailors.dob}::text`,
              goldEntryDate: sql<string | null>`${sailors.goldEntryDate}::text`,
              silverEntryDate: sql<string | null>`${sailors.silverEntryDate}::text`,
              dropDate: sql<string | null>`${sailors.dropDate}::text`,
              currentFleet: sailors.currentFleet,
              nationalSquadStatus: sailors.nationalSquadStatus,
            })
            .from(sailors)
            .where(isNotNull(sailors.goldEntryDate)),
        () =>
          db
            .select({
              id: regattas.id,
              name: regattas.name,
              slug: regattas.slug,
              date: sql<string>`${regattas.date}::text`,
              division: regattas.division,
              boatClass: regattas.boatClass,
              geography: regattas.geography,
              countsForRanking: regattas.countsForRanking,
              status: regattas.status,
              totalFleetSize: regattas.totalFleetSize,
            })
            .from(regattas)
            .where(
              and(
                eq(regattas.status, "published"),
                inArray(regattas.division, ["Gold", "Both"]),
                ilike(regattas.boatClass, "%optimist%"),
              ),
            ),
      ],
      { label: "admin.goldForm.meta", signal: request.signal },
    );

    const regattaIds = regattaRows.map((r) => r.id);
    const resultRows =
      regattaIds.length > 0
        ? await withSequentialDatabaseReads(
            [
              () =>
                db
                  .select({
                    sailorId: regattaResults.sailorId,
                    regattaId: regattaResults.regattaId,
                    rank: regattaResults.rank,
                    nettScore: regattaResults.nettScore,
                    isDns: regattaResults.isDns,
                    isOverseasCommitment: regattaResults.isOverseasCommitment,
                  })
                  .from(regattaResults)
                  .where(inArray(regattaResults.regattaId, regattaIds)),
            ],
            { label: "admin.goldForm.results", signal: request.signal },
          ).then(([rows]) => rows)
        : [];

    const asOfYmd = todayYmdSg();
    const sgRanking = buildGoldFormIndex({
      sailors: sailorRows,
      regattas: regattaRows,
      results: resultRows,
      scope: "sg_ranking",
      asOfYmd,
    });
    const allGold = buildGoldFormIndex({
      sailors: sailorRows,
      regattas: regattaRows,
      results: resultRows,
      scope: "all_gold",
      asOfYmd,
    });

    return NextResponse.json(
      {
        sgRanking,
        allGold,
        generatedAt: new Date().toISOString(),
      } satisfies AdminGoldFormResponse,
      {
        headers: {
          "Cache-Control": "private, no-store",
        },
      },
    );
  } catch (error) {
    console.error("[admin/gold-form]", error);
    return jsonError(error);
  }
}
