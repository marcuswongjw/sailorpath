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
    const auth = await requireSuperadmin();
    const body = await req.json();
    const { logAdminChange } = await import("@/lib/adminChangeLog");

    /**
     * Apply ILCA display-name corrections (idempotent).
     * Renames known profiles and keeps old names as aliases.
     */
    if (body.action === "applyIlcaNameCorrections") {
      const { ILCA_NAME_CORRECTIONS } = await import(
        "@/lib/ilcaNameCorrections"
      );
      const { logAdminChange } = await import("@/lib/adminChangeLog");
      const { sailorAliases } = await import("@/db/schema");
      let updated = 0;
      const details: string[] = [];
      for (const { from, to } of ILCA_NAME_CORRECTIONS) {
        const matches = await db
          .select({ id: sailors.id, name: sailors.name })
          .from(sailors)
          .where(eq(sailors.name, from));
        for (const row of matches) {
          await db
            .update(sailors)
            .set({ name: to, updatedAt: new Date() })
            .where(eq(sailors.id, row.id));
          try {
            await db.insert(sailorAliases).values({
              sailorId: row.id,
              aliasName: from,
            });
          } catch {
            /* alias may already exist */
          }
          updated++;
          details.push(`${from} → ${to}`);
          void logAdminChange({
            actorUserId: auth.userId,
            actorEmail: auth.email,
            action: "sailor.rename",
            entityType: "sailor",
            entityId: row.id,
            entityLabel: to,
            summary: `Renamed “${from}” → “${to}”`,
            details: { from, to },
            source: "/api/admin/sailors",
          });
        }
      }
      return NextResponse.json({
        ok: true,
        updated,
        details,
        message:
          updated > 0
            ? `Renamed ${updated} sailor(s): ${details.join("; ")}`
            : "No matching sailors to rename (already applied or names differ).",
      });
    }

    /**
     * Named ILCA merges + sail fixes (e.g. Jonas Tan Kia Jeng / Yi Jun, sail 197840).
     * Calls the merge route logic inline by name.
     */
    if (body.action === "applyIlcaSailorFixes") {
      const {
        ILCA_NAMED_MERGES,
        JONAS_TAN_KEEP_NAME,
        JONAS_TAN_ILCA4_SAIL,
      } = await import("@/lib/ilcaSailorFixes");
      const { logAdminChange } = await import("@/lib/adminChangeLog");
      const { sailorAliases, regattaResults } = await import("@/db/schema");
      const { and } = await import("drizzle-orm");
      const details: string[] = [];
      let merges = 0;
      let sailUpdates = 0;

      for (const fix of ILCA_NAMED_MERGES) {
        const keepRows = await db
          .select()
          .from(sailors)
          .where(eq(sailors.name, fix.keepName));
        const mergeRows = await db
          .select()
          .from(sailors)
          .where(eq(sailors.name, fix.mergeName));

        let keepId = keepRows[0]?.id as string | undefined;
        const mergeId = mergeRows[0]?.id as string | undefined;

        // If only merge name exists, rename it to keep name
        if (!keepId && mergeId) {
          await db
            .update(sailors)
            .set({ name: fix.keepName, updatedAt: new Date() })
            .where(eq(sailors.id, mergeId));
          try {
            await db.insert(sailorAliases).values({
              sailorId: mergeId,
              aliasName: fix.mergeName,
            });
          } catch {
            /* exists */
          }
          keepId = mergeId;
          details.push(`Renamed “${fix.mergeName}” → “${fix.keepName}”`);
          merges++;
        } else if (keepId && mergeId && keepId !== mergeId) {
          // Move results from merge → keep
          const mergeResults = await db
            .select()
            .from(regattaResults)
            .where(eq(regattaResults.sailorId, mergeId));
          for (const row of mergeResults) {
            const existing = await db
              .select()
              .from(regattaResults)
              .where(
                and(
                  eq(regattaResults.sailorId, keepId),
                  eq(regattaResults.regattaId, row.regattaId)
                )
              )
              .limit(1);
            if (!existing[0]) {
              await db
                .update(regattaResults)
                .set({ sailorId: keepId, updatedAt: new Date() })
                .where(eq(regattaResults.id, row.id));
            } else {
              await db
                .delete(regattaResults)
                .where(eq(regattaResults.id, row.id));
            }
          }
          // Aliases
          const mergeAliases = await db
            .select()
            .from(sailorAliases)
            .where(eq(sailorAliases.sailorId, mergeId));
          for (const a of mergeAliases) {
            try {
              await db
                .update(sailorAliases)
                .set({ sailorId: keepId })
                .where(eq(sailorAliases.id, a.id));
            } catch {
              await db
                .delete(sailorAliases)
                .where(eq(sailorAliases.id, a.id));
            }
          }
          try {
            await db.insert(sailorAliases).values({
              sailorId: keepId,
              aliasName: fix.mergeName,
            });
          } catch {
            /* exists */
          }
          // Fill blank fields from merge before delete
          const keepSailor = keepRows[0];
          const mergeSailor = mergeRows[0];
          const fill: Record<string, unknown> = { updatedAt: new Date() };
          if (
            !String(keepSailor.sailNumberIlca4 || "").trim() &&
            String(mergeSailor.sailNumberIlca4 || "").trim()
          ) {
            fill.sailNumberIlca4 = mergeSailor.sailNumberIlca4;
          }
          for (const f of [
            "goldEntryDate",
            "silverEntryDate",
            "dropDate",
            "dob",
            "club",
            "school",
            "gender",
          ] as const) {
            if (!keepSailor[f] && mergeSailor[f]) fill[f] = mergeSailor[f];
          }
          if (Object.keys(fill).length > 1) {
            await db.update(sailors).set(fill).where(eq(sailors.id, keepId));
          }
          await db.delete(sailors).where(eq(sailors.id, mergeId));
          details.push(
            `Merged “${fix.mergeName}” into “${fix.keepName}”`
          );
          merges++;
          void logAdminChange({
            actorUserId: auth.userId,
            actorEmail: auth.email,
            action: "sailor.merge",
            entityType: "sailor",
            entityId: keepId,
            entityLabel: fix.keepName,
            summary: `Merged “${fix.mergeName}” → “${fix.keepName}”`,
            source: "/api/admin/sailors",
          });
        }

        // Ensure sail number on keep
        if (fix.sailNumberIlca4 && keepId) {
          const [row] = await db
            .select({
              id: sailors.id,
              sail: sailors.sailNumberIlca4,
            })
            .from(sailors)
            .where(eq(sailors.id, keepId))
            .limit(1);
          if (
            row &&
            String(row.sail || "").trim() !== fix.sailNumberIlca4
          ) {
            await db
              .update(sailors)
              .set({
                sailNumberIlca4: fix.sailNumberIlca4,
                updatedAt: new Date(),
              })
              .where(eq(sailors.id, keepId));
            sailUpdates++;
            details.push(
              `Set ILCA 4 sail ${fix.sailNumberIlca4} on “${fix.keepName}”`
            );
          }
        } else if (fix.sailNumberIlca4 && !keepId) {
          // Try set by keep name only (no merge needed)
          const byName = await db
            .select({ id: sailors.id, sail: sailors.sailNumberIlca4 })
            .from(sailors)
            .where(eq(sailors.name, fix.keepName));
          for (const row of byName) {
            if (String(row.sail || "").trim() === fix.sailNumberIlca4)
              continue;
            await db
              .update(sailors)
              .set({
                sailNumberIlca4: fix.sailNumberIlca4,
                updatedAt: new Date(),
              })
              .where(eq(sailors.id, row.id));
            sailUpdates++;
            details.push(
              `Set ILCA 4 sail ${fix.sailNumberIlca4} on “${fix.keepName}”`
            );
          }
        }
      }

      // Always ensure Jonas sail even if already merged under keep name
      const jonas = await db
        .select({ id: sailors.id, sail: sailors.sailNumberIlca4 })
        .from(sailors)
        .where(eq(sailors.name, JONAS_TAN_KEEP_NAME));
      for (const row of jonas) {
        if (String(row.sail || "").trim() === JONAS_TAN_ILCA4_SAIL) continue;
        await db
          .update(sailors)
          .set({
            sailNumberIlca4: JONAS_TAN_ILCA4_SAIL,
            updatedAt: new Date(),
          })
          .where(eq(sailors.id, row.id));
        sailUpdates++;
        details.push(
          `Set ILCA 4 sail ${JONAS_TAN_ILCA4_SAIL} on “${JONAS_TAN_KEEP_NAME}”`
        );
      }

      return NextResponse.json({
        ok: true,
        merges,
        sailUpdates,
        details,
        message:
          details.length > 0
            ? details.join("; ")
            : "No ILCA sailor fixes needed (already applied).",
      });
    }

    /**
     * Goh Siak Yiak Ian is ILCA 4 only — clear bad Optimist silver entry
     * and delete Optimist silver regatta results.
     */
    if (body.action === "fixGohSiakYiakIanIlcaOnly") {
      const { isGohSiakYiakIanName, GOH_SIAK_YIAK_IAN_NAME } = await import(
        "@/lib/ilcaSailorFixes"
      );
      const { logAdminChange } = await import("@/lib/adminChangeLog");
      const { regattaResults, regattas } = await import("@/db/schema");
      const { eq, inArray } = await import("drizzle-orm");

      const all = await db
        .select({
          id: sailors.id,
          name: sailors.name,
          silverEntryDate: sailors.silverEntryDate,
          goldEntryDate: sailors.goldEntryDate,
          dropDate: sailors.dropDate,
          currentFleet: sailors.currentFleet,
        })
        .from(sailors);
      const targets = all.filter((s) => isGohSiakYiakIanName(s.name));
      if (!targets.length) {
        return NextResponse.json({
          ok: true,
          updated: 0,
          deletedResults: 0,
          message: `No sailor matching “${GOH_SIAK_YIAK_IAN_NAME}” found.`,
        });
      }

      const targetIds = targets.map((t) => t.id);
      let deletedResults = 0;

      // Optimist silver results only
      const linked = await db
        .select({
          resultId: regattaResults.id,
          boatClass: regattas.boatClass,
          division: regattas.division,
        })
        .from(regattaResults)
        .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id))
        .where(inArray(regattaResults.sailorId, targetIds));

      const toDelete = linked.filter((row) => {
        const bc = String(row.boatClass || "Optimist")
          .trim()
          .toLowerCase();
        const isOpti = !bc || bc === "optimist" || bc === "opti";
        const div = String(row.division || "")
          .trim()
          .toLowerCase();
        return isOpti && div.includes("silver");
      });

      for (const row of toDelete) {
        await db
          .delete(regattaResults)
          .where(eq(regattaResults.id, row.resultId));
        deletedResults++;
      }

      let updated = 0;
      for (const t of targets) {
        await db
          .update(sailors)
          .set({
            silverEntryDate: null,
            goldEntryDate: null,
            dropDate: null,
            currentFleet: "Guest",
            updatedAt: new Date(),
          })
          .where(eq(sailors.id, t.id));
        updated++;
        void logAdminChange({
          actorUserId: auth.userId,
          actorEmail: auth.email,
          action: "sailor.fix_ilca_only",
          entityType: "sailor",
          entityId: t.id,
          entityLabel: t.name,
          summary: `Cleared Optimist silver entry/results for ILCA-only sailor “${t.name}”`,
          details: {
            previousSilver: t.silverEntryDate,
            previousGold: t.goldEntryDate,
            previousFleet: t.currentFleet,
            deletedResults,
          },
          source: "/api/admin/sailors",
        });
      }

      return NextResponse.json({
        ok: true,
        updated,
        deletedResults,
        sailors: targets.map((t) => ({ id: t.id, name: t.name })),
        message: `Fixed ${updated} profile(s) for “${GOH_SIAK_YIAK_IAN_NAME}”: cleared silver/gold entry, set Guest, deleted ${deletedResults} Optimist silver result(s).`,
      });
    }

    /**
     * Auto-drop gold sailors who sailed &lt;2 ranking gold regattas in a
     * completed half-year. Sets drop_date to the next half boundary.
     */
    if (body.action === "applyGoldParticipationDrops") {
      const { findGoldParticipationDrops } = await import(
        "@/lib/goldFleetDrop"
      );
      const { logAdminChange } = await import("@/lib/adminChangeLog");
      const { regattas, regattaResults } = await import("@/db/schema");
      const { todayYmdSg } = await import("@/lib/datesSg");
      const asOf = String(body.asOf || todayYmdSg()).slice(0, 10);

      const sailorRows = await db.select().from(sailors);
      const regattaRows = await db.select().from(regattas);
      const resultRows = await db.select().from(regattaResults);

      const sailorRecs = sailorRows.map((s) => ({
        id: s.id,
        name: s.name,
        handle: s.handle,
        sailNumber: s.sailNumber,
        sailNumberIlca4: s.sailNumberIlca4,
        club: s.club,
        school: s.school,
        nationality: s.nationality,
        avatarUrl: s.avatarUrl,
        goldEntryDate: s.goldEntryDate
          ? String(s.goldEntryDate).slice(0, 10)
          : null,
        silverEntryDate: s.silverEntryDate
          ? String(s.silverEntryDate).slice(0, 10)
          : null,
        dropDate: s.dropDate ? String(s.dropDate).slice(0, 10) : null,
        currentFleet: s.currentFleet,
        dob: s.dob ? String(s.dob).slice(0, 10) : null,
        gender: s.gender,
        nationalSquadStatus: s.nationalSquadStatus,
      }));
      const regattaRecs = regattaRows.map((r) => ({
        id: r.id,
        name: r.name,
        slug: r.slug,
        date: String(r.date).slice(0, 10),
        totalFleetSize: r.totalFleetSize,
        division: r.division ?? undefined,
        raceCount: r.raceCount ?? undefined,
        geography: r.geography ?? "SG",
        boatClass: r.boatClass ?? "Optimist",
        countsForRanking: r.countsForRanking !== false,
      }));
      const resultRecs = resultRows.map((r) => ({
        sailorId: r.sailorId,
        regattaId: r.regattaId,
        rank: r.rank,
        nettScore: r.nettScore,
        totalScore: r.totalScore,
        isDns: Boolean(r.isDns),
        isOverseasCommitment: Boolean(r.isOverseasCommitment),
      }));

      const dryRun = Boolean(body.dryRun);
      let candidates = findGoldParticipationDrops(
        sailorRecs,
        regattaRecs,
        resultRecs,
        asOf
      );
      // Optional subset — admin review selects who to drop
      const onlyIds = Array.isArray(body.sailorIds)
        ? new Set(
            (body.sailorIds as unknown[])
              .map((x) => String(x).trim())
              .filter(Boolean)
          )
        : null;
      if (onlyIds && onlyIds.size > 0) {
        candidates = candidates.filter((c) => onlyIds.has(c.sailorId));
      }

      if (dryRun) {
        return NextResponse.json({
          ok: true,
          dryRun: true,
          asOf,
          candidates,
          message: `Found ${candidates.length} gold participation drop candidate(s).`,
        });
      }

      let updated = 0;
      for (const c of candidates) {
        await db
          .update(sailors)
          .set({ dropDate: c.dropDate, updatedAt: new Date() })
          .where(eq(sailors.id, c.sailorId));
        updated++;
        void logAdminChange({
          actorUserId: auth.userId,
          actorEmail: auth.email,
          action: "sailor.gold_participation_drop",
          entityType: "sailor",
          entityId: c.sailorId,
          entityLabel: c.name,
          summary: `Gold drop ${c.dropDate} (<2 ranking gold regattas in ${c.failedPeriod.half} ${c.failedPeriod.year}; sailed ${c.participationCount})`,
          details: c,
          source: "/api/admin/sailors",
        });
      }

      return NextResponse.json({
        ok: true,
        asOf,
        updated,
        candidates,
        message:
          updated > 0
            ? `Set drop date on ${updated} gold sailor(s) for low participation.`
            : "No gold participation drops needed.",
      });
    }

    /**
     * Seed ILCA 4 national list flags from the official authority name list
     * (name-token match). Only turns flags ON — never clears existing true.
     */
    if (body.action === "seedIlca4NationalList") {
      const { isOnIlca4NationalListByName, ILCA4_NATIONAL_RANKING_NAMES } =
        await import("@/lib/ilca4NationalList");
      const { logAdminChange } = await import("@/lib/adminChangeLog");
      const rows = await db.select().from(sailors);
      let updated = 0;
      const matched: string[] = [];
      for (const s of rows) {
        if (s.ilca4NationalList) continue;
        if (!isOnIlca4NationalListByName(s.name)) continue;
        await db
          .update(sailors)
          .set({ ilca4NationalList: true, updatedAt: new Date() })
          .where(eq(sailors.id, s.id));
        updated++;
        if (matched.length < 40) matched.push(s.name);
        void logAdminChange({
          actorUserId: auth.userId,
          actorEmail: auth.email,
          action: "ilca4.national_list.seed",
          entityType: "sailor",
          entityId: s.id,
          entityLabel: s.name,
          summary: `Seeded ILCA 4 national list from name match`,
          source: "/api/admin/sailors",
        });
      }
      return NextResponse.json({
        ok: true,
        updated,
        seedListSize: ILCA4_NATIONAL_RANKING_NAMES.length,
        matchedSample: matched,
        message: `Set ILCA 4 national list on ${updated} sailor(s) matching the ${ILCA4_NATIONAL_RANKING_NAMES.length}-name seed list.`,
      });
    }

    /** Bulk set/clear ILCA 4 national list flag */
    if (body.action === "setIlca4NationalList") {
      const { logAdminChange } = await import("@/lib/adminChangeLog");
      const ids = Array.isArray(body.sailorIds)
        ? (body.sailorIds as unknown[]).map((x) => String(x)).filter(Boolean)
        : body.sailorId
          ? [String(body.sailorId)]
          : [];
      const value = Boolean(body.value);
      if (!ids.length) {
        return NextResponse.json(
          { error: "sailorIds required" },
          { status: 400 }
        );
      }
      let updated = 0;
      for (const id of ids) {
        const [row] = await db
          .update(sailors)
          .set({ ilca4NationalList: value, updatedAt: new Date() })
          .where(eq(sailors.id, id))
          .returning({ id: sailors.id, name: sailors.name });
        if (!row) continue;
        updated++;
        void logAdminChange({
          actorUserId: auth.userId,
          actorEmail: auth.email,
          action: value
            ? "ilca4.national_list.add"
            : "ilca4.national_list.remove",
          entityType: "sailor",
          entityId: row.id,
          entityLabel: row.name,
          summary: value
            ? `Added ${row.name} to ILCA 4 national list`
            : `Removed ${row.name} from ILCA 4 national list`,
          source: "/api/admin/sailors",
        });
      }
      return NextResponse.json({
        ok: true,
        updated,
        value,
        message: value
          ? `Added ${updated} sailor(s) to ILCA 4 national list`
          : `Removed ${updated} sailor(s) from ILCA 4 national list`,
      });
    }

    /**
     * Stamp silver entry (SG today) for In SG Fleet sailors with no gold/silver
     * entry dates so they can appear on Silver rankings.
     */
    if (
      body.action === "stampEmptySeriesSilver" ||
      body.action === "cleanupEmptySeries"
    ) {
      const { todayYmdSg } = await import("@/lib/datesSg");
      const stamp = todayYmdSg();
      const rows = await db.select().from(sailors);
      let updated = 0;
      const names: string[] = [];
      for (const s of rows) {
        const cf = String(s.currentFleet || "")
          .trim()
          .toLowerCase();
        const isSeriesTag =
          cf === "series" ||
          cf === "gold" ||
          cf === "silver" ||
          cf === "in sg fleet" ||
          cf === "member";
        if (!isSeriesTag) continue;
        if (s.goldEntryDate || s.silverEntryDate) continue;
        await db
          .update(sailors)
          .set({
            silverEntryDate: stamp,
            currentFleet: "Series",
            updatedAt: new Date(),
          })
          .where(eq(sailors.id, s.id));
        updated++;
        if (names.length < 20) names.push(s.name);
        void logAdminChange({
          actorUserId: auth.userId,
          actorEmail: auth.email,
          action: "silver.stamp_empty",
          entityType: "sailor",
          entityId: s.id,
          entityLabel: s.name,
          summary: `Stamped silver entry ${stamp} (empty Series)`,
          source: "/api/admin/sailors",
        });
      }
      return NextResponse.json({
        ok: true,
        updated,
        silverEntryDate: stamp,
        names,
        message: `Stamped silver entry ${stamp} on ${updated} Series sailor(s) with no entry dates.`,
      });
    }

    /**
     * Fill missing nationality from sail number country prefixes
     * (e.g. "SGP 115" → SGP) on Optimist and ILCA 4 sail fields.
     */
    if (body.action === "backfillNationalityFromSail") {
      const { nationalityFromAnySailNumber } = await import("@/lib/countries");
      const { normalizeNationality } = await import("@/lib/seriesMembership");
      const rows = await db.select().from(sailors);
      let updated = 0;
      const samples: string[] = [];
      for (const s of rows) {
        const cur = normalizeNationality(s.nationality);
        if (cur) continue;
        const fromSail = nationalityFromAnySailNumber(
          s.sailNumber,
          s.sailNumberIlca4
        );
        if (!fromSail) continue;
        await db
          .update(sailors)
          .set({
            nationality: fromSail,
            nationalityFromSail: true,
            updatedAt: new Date(),
          })
          .where(eq(sailors.id, s.id));
        updated++;
        if (samples.length < 25) {
          samples.push(
            `${s.name}: ${s.sailNumber || s.sailNumberIlca4 || "—"} → ${fromSail}`
          );
        }
        void logAdminChange({
          actorUserId: auth.userId,
          actorEmail: auth.email,
          action: "sailor.nationality_from_sail",
          entityType: "sailor",
          entityId: s.id,
          entityLabel: s.name,
          summary: `Set nationality ${fromSail} from sail number (flagged)`,
          details: {
            sailNumber: s.sailNumber,
            sailNumberIlca4: s.sailNumberIlca4,
            nationality: fromSail,
            nationalityFromSail: true,
          },
          source: "/api/admin/sailors",
        });
      }
      return NextResponse.json({
        ok: true,
        updated,
        samples,
        message:
          updated > 0
            ? `Set nationality from sail number on ${updated} sailor(s).`
            : "No sailors needed nationality from sail number (already set or no country prefix).",
      });
    }

    /** Recompute silver_entry_date = earliest Silver ranking regatta date */
    if (body.action === "recomputeSilverEntryDates") {
      const { deriveAllSilverEntryDates } = await import(
        "@/lib/deriveFleetEntryDates"
      );
      const { regattaResults, regattas } = await import("@/db/schema");
      const links = await db
        .select({
          sailorId: regattaResults.sailorId,
          regattaDate: regattas.date,
          division: regattas.division,
          countsForRanking: regattas.countsForRanking,
          boatClass: regattas.boatClass,
        })
        .from(regattaResults)
        .innerJoin(regattas, eq(regattaResults.regattaId, regattas.id));
      const derived = deriveAllSilverEntryDates(
        links.map((l) => ({
          sailorId: l.sailorId,
          regattaDate: l.regattaDate,
          division: l.division,
          countsForRanking: l.countsForRanking,
          boatClass: l.boatClass,
        }))
      );
      const rows = await db.select().from(sailors);
      let updated = 0;
      for (const s of rows) {
        const next = derived.get(s.id);
        if (!next) continue;
        const prev = s.silverEntryDate
          ? String(s.silverEntryDate).slice(0, 10)
          : null;
        if (prev === next) continue;
        await db
          .update(sailors)
          .set({ silverEntryDate: next, updatedAt: new Date() })
          .where(eq(sailors.id, s.id));
        updated++;
        void logAdminChange({
          actorUserId: auth.userId,
          actorEmail: auth.email,
          action: "silver.recompute",
          entityType: "sailor",
          entityId: s.id,
          entityLabel: s.name,
          summary: `Silver entry ${prev || "—"} → ${next}`,
          details: { old: prev, new: next },
          source: "/api/admin/sailors",
        });
      }
      return NextResponse.json({
        ok: true,
        updated,
        message: `Recomputed silver entry for ${updated} sailor(s) from first Silver ranking regatta.`,
      });
    }

    const handle =
      (body.handle as string)?.trim() ||
      String(body.name || "")
        .toLowerCase()
        .replace(/[^a-z0-9]+/g, "-")
        .replace(/^-|-$/g, "");

    let silverEntryDate = toDateOnly(body.silverEntryDate);
    const goldEntryDate = toDateOnly(body.goldEntryDate);
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
      natSquadStatusJan27: body.natSquadStatusJan27 || null,
      natSquadStatusJul27: body.natSquadStatusJul27 || null,
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
    const auth = await requireSuperadmin();
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
      "sailNumberIlca4",
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
      "natSquadStatusJan27",
      "natSquadStatusJul27",
    ] as const) {
      if (body[f] !== undefined) patch[f] = body[f] === "" ? null : body[f];
    }
    if (body.ilca4NationalList !== undefined) {
      patch.ilca4NationalList = Boolean(body.ilca4NationalList);
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
      // Manual/admin nationality input clears sail-derived flag
      patch.nationalityFromSail = false;
    }
    if (body.nationalityFromSail !== undefined) {
      patch.nationalityFromSail = Boolean(body.nationalityFromSail);
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
        patch[f] = num(body[f]);
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

      // Stamp gender, birth year, nationality onto all of this sailor's results
      if (
        body.gender !== undefined ||
        body.dob !== undefined ||
        body.nationality !== undefined
      ) {
        try {
          const { regattaResults } = await import("@/db/schema");
          const { birthYear } = await import("@/lib/age");
          const gRaw = String(row.gender || "")
            .trim()
            .toUpperCase()
            .slice(0, 1);
          const g = gRaw === "M" || gRaw === "F" ? gRaw : null;
          const by = birthYear(row.dob);
          const nat = row.nationality
            ? normalizeNationality(row.nationality)
            : null;
          await db
            .update(regattaResults)
            .set({
              ...(body.gender !== undefined ? { gender: g } : {}),
              ...(body.dob !== undefined ? { birthYear: by } : {}),
              ...(body.nationality !== undefined
                ? { nationality: nat }
                : {}),
              updatedAt: new Date(),
            })
            .where(eq(regattaResults.sailorId, body.id));
        } catch (stampErr) {
          console.warn("result demographics stamp after sailor PATCH", stampErr);
        }
      }

      const { logAdminChange } = await import("@/lib/adminChangeLog");
      void logAdminChange({
        actorUserId: auth.userId,
        actorEmail: auth.email,
        action: "sailor.patch",
        entityType: "sailor",
        entityId: row.id,
        entityLabel: row.name,
        summary: `Updated sailor ${row.name}`,
        details: { fields: Object.keys(patch).filter((k) => k !== "updatedAt") },
        source: "/api/admin/sailors",
      });
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
