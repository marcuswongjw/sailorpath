import { NextResponse } from "next/server";
import { and, desc, eq, ilike, inArray, isNotNull, sql } from "drizzle-orm";
import { db, ensureCoreSchema, withSequentialDatabaseReads } from "@/db";
import {
  adminGoldPredictionSnapshots,
  regattaResults,
  regattas,
  sailors,
} from "@/db/schema";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { todayYmdSg } from "@/lib/datesSg";
import {
  buildGoldFormIndex,
  PROJECTION_TARGET_DATE,
  type GoldFormIndexSummary,
  type SnapshotEntrySummary,
} from "@/lib/admin/goldFormIndex";

export const dynamic = "force-dynamic";
export const runtime = "nodejs";
export const maxDuration = 30;

export type GoldFormSnapshotSummary = {
  activeGoldCount: number;
  eligible2027Count: number;
  regattaCount: number;
  typicalFleetSize: number;
  entries: SnapshotEntrySummary[];
};

export type GoldFormSnapshotRecord = {
  id: string;
  label: string;
  baselineDate: string;
  targetDate: string;
  scope: string;
  summary: GoldFormSnapshotSummary;
  createdAt: string;
};

export type AdminGoldFormResponse = {
  sgRanking: GoldFormIndexSummary;
  allGold: GoldFormIndexSummary;
  snapshots: GoldFormSnapshotRecord[];
  generatedAt: string;
};

async function loadGoldSourceRows(signal?: AbortSignal) {
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
    { label: "admin.goldForm.meta", signal },
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
          { label: "admin.goldForm.results", signal },
        ).then(([rows]) => rows)
      : [];

  return { sailorRows, regattaRows, resultRows };
}

async function loadSavedSnapshots(
  signal?: AbortSignal,
): Promise<GoldFormSnapshotRecord[]> {
  try {
    const [rows] = await withSequentialDatabaseReads(
      [
        () =>
          db
            .select({
              id: adminGoldPredictionSnapshots.id,
              label: adminGoldPredictionSnapshots.label,
              baselineDate: sql<string>`${adminGoldPredictionSnapshots.baselineDate}::text`,
              targetDate: sql<string>`${adminGoldPredictionSnapshots.targetDate}::text`,
              scope: adminGoldPredictionSnapshots.scope,
              summary: adminGoldPredictionSnapshots.summary,
              createdAt: sql<string>`${adminGoldPredictionSnapshots.createdAt}::text`,
            })
            .from(adminGoldPredictionSnapshots)
            .orderBy(desc(adminGoldPredictionSnapshots.createdAt))
            .limit(12),
      ],
      { label: "admin.goldForm.snapshots", signal },
    );
    return rows.map((row) => ({
      id: row.id,
      label: row.label,
      baselineDate: String(row.baselineDate).slice(0, 10),
      targetDate: String(row.targetDate).slice(0, 10),
      scope: row.scope,
      summary: row.summary as unknown as GoldFormSnapshotSummary,
      createdAt: row.createdAt,
    }));
  } catch {
    return [];
  }
}

/**
 * Superadmin-only Gold fleet form, national ranking projections (30 Jun 2027),
 * and up-and-coming watchlist index.
 */
export async function GET(request: Request) {
  try {
    await requireSuperadmin(request.signal);
    if (typeof ensureCoreSchema === "function") {
      await ensureCoreSchema();
    }

    const { sailorRows, regattaRows, resultRows } = await loadGoldSourceRows(
      request.signal,
    );
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
    const snapshots = await loadSavedSnapshots(request.signal);

    return NextResponse.json(
      {
        sgRanking,
        allGold,
        snapshots,
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

/**
 * Freeze a baseline prediction snapshot for future retrospective accuracy review
 * (e.g., comparing Nov 2026 predictions against actual 30 Jun 2027 rankings).
 */
export async function POST(request: Request) {
  try {
    const auth = await requireSuperadmin(request.signal);
    if (typeof ensureCoreSchema === "function") {
      await ensureCoreSchema();
    }

    const body = (await request.json().catch(() => ({}))) as {
      label?: unknown;
    };
    const asOfYmd = todayYmdSg();
    const rawLabel =
      typeof body.label === "string" ? body.label.trim().slice(0, 120) : "";
    const label =
      rawLabel || `Baseline ${asOfYmd} → ${PROJECTION_TARGET_DATE}`;

    const { sailorRows, regattaRows, resultRows } = await loadGoldSourceRows(
      request.signal,
    );
    const sgRanking = buildGoldFormIndex({
      sailors: sailorRows,
      regattas: regattaRows,
      results: resultRows,
      scope: "sg_ranking",
      asOfYmd,
    });

    const snapshotSummary: GoldFormSnapshotSummary = {
      activeGoldCount: sgRanking.activeGoldCount,
      eligible2027Count: sgRanking.eligible2027Count,
      regattaCount: sgRanking.regattaCount,
      typicalFleetSize: sgRanking.typicalFleetSize,
      entries: sgRanking.entries.map((entry) => ({
        sailorId: entry.sailorId,
        name: entry.name,
        birthYear: entry.birthYear,
        currentNationalRank: entry.currentNationalRank,
        projectedNationalRankJun2027: entry.projectedNationalRankJun2027,
        formIndex: entry.formIndex,
        watchlistIndex: entry.watchlistIndex,
        projectedPercentile: entry.projectedPercentile,
        agingOut2027: entry.agingOut2027,
      })),
    };

    const [inserted] = await db
      .insert(adminGoldPredictionSnapshots)
      .values({
        label,
        baselineDate: asOfYmd,
        targetDate: PROJECTION_TARGET_DATE,
        scope: "sg_ranking",
        summary:
          snapshotSummary as unknown as (typeof adminGoldPredictionSnapshots.$inferInsert)["summary"],
        createdBy: auth.userId ?? null,
      })
      .returning({
        id: adminGoldPredictionSnapshots.id,
        label: adminGoldPredictionSnapshots.label,
        baselineDate: sql<string>`${adminGoldPredictionSnapshots.baselineDate}::text`,
        targetDate: sql<string>`${adminGoldPredictionSnapshots.targetDate}::text`,
        scope: adminGoldPredictionSnapshots.scope,
        summary: adminGoldPredictionSnapshots.summary,
        createdAt: sql<string>`${adminGoldPredictionSnapshots.createdAt}::text`,
      });

    return NextResponse.json(
      {
        snapshot: {
          id: inserted.id,
          label: inserted.label,
          baselineDate: String(inserted.baselineDate).slice(0, 10),
          targetDate: String(inserted.targetDate).slice(0, 10),
          scope: inserted.scope,
          summary: inserted.summary as unknown as GoldFormSnapshotSummary,
          createdAt: inserted.createdAt,
        } satisfies GoldFormSnapshotRecord,
      },
      { status: 201 },
    );
  } catch (error) {
    console.error("[admin/gold-form POST]", error);
    return jsonError(error);
  }
}
