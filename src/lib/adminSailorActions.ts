import { NextResponse } from "next/server";
import { eq, inArray } from "drizzle-orm";
import type { AuthContext } from "@/lib/auth";
import { db } from "@/db";
import {
  regattaResults,
  regattas,
  sailorAliases,
  sailors,
} from "@/db/schema";
import { logAdminChange } from "@/lib/adminChangeLog";
import { ILCA_NAME_CORRECTIONS } from "@/lib/ilcaNameCorrections";
import {
  ILCA_NAMED_MERGES,
  JONAS_TAN_KEEP_NAME,
  JONAS_TAN_ILCA4_SAIL,
  isGohSiakYiakIanName,
  GOH_SIAK_YIAK_IAN_NAME,
} from "@/lib/ilcaSailorFixes";
import { findGoldParticipationDrops } from "@/lib/goldFleetDrop";
import { findSilverInactivityDrops } from "@/lib/silverSeriesDrop";
import { normalizeGender } from "@/lib/gender";
import {
  isOnIlca4NationalListByName,
  ILCA4_NATIONAL_RANKING_NAMES,
} from "@/lib/ilca4NationalList";
import {
  nationalityFromAnySailNumber,
  extractNationalityFromSailNumber,
} from "@/lib/countries";
import { normalizeNationality } from "@/lib/seriesMembership";
import { deriveAllSilverEntryDates } from "@/lib/deriveFleetEntryDates";
import { todayYmdSg } from "@/lib/datesSg";
import { mergeSailors } from "@/lib/mergeSailors";
import {
  OPTIMIST_SAILOR_SAIL_NUMBERS,
  cleanOptimistSailorName,
} from "@/lib/optimistSailNumberMap";
import { cleanOptimistSailNumber } from "@/lib/normalize";
import { revalidatePublicRankings } from "@/lib/revalidatePublic";

/**
 * Named admin actions for /api/admin/sailors POST.
 *
 * Each handler is self-contained so it can be read, audited, and tested
 * independently. runSailorAction() dispatches on body.action and returns
 * null when no action matches so the route falls through to sailor create.
 */

/** Apply ILCA display-name corrections (idempotent). Renames known profiles and keeps old names as aliases. */
async function applyIlcaNameCorrections(
  auth: AuthContext
): Promise<NextResponse> {
  let updated = 0;
  const details: string[] = [];
  const aliasInserts: { sailorId: string; aliasName: string }[] = [];

  for (const { from, to } of ILCA_NAME_CORRECTIONS) {
    const matches = await db
      .select({ id: sailors.id, name: sailors.name })
      .from(sailors)
      .where(eq(sailors.name, from));

    if (matches.length === 0) continue;

    const ids = matches.map((m) => m.id);
    await db
      .update(sailors)
      .set({ name: to, updatedAt: new Date() })
      .where(inArray(sailors.id, ids));

    for (const row of matches) {
      aliasInserts.push({ sailorId: row.id, aliasName: from });
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

  if (aliasInserts.length > 0) {
    // Use onConflictDoNothing because aliases might already exist
    await db
      .insert(sailorAliases)
      .values(aliasInserts)
      .onConflictDoNothing({ target: sailorAliases.aliasName });
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

/** Named ILCA merges + sail fixes (e.g. Jonas Tan Kia Jeng / Yi Jun, sail 197840). */
async function applyIlcaSailorFixes(
  auth: AuthContext
): Promise<NextResponse> {
  const details: string[] = [];
  let merges = 0;
  let sailUpdates = 0;
  const sailNumberUpdates: { id: string; sail: string }[] = [];

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
      await mergeSailors({ keepId, mergeId, forceOwnershipConflict: true });
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
        sailNumberUpdates.push({ id: keepId, sail: fix.sailNumberIlca4 });
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
        sailNumberUpdates.push({ id: row.id, sail: fix.sailNumberIlca4 });
        details.push(
          `Set ILCA 4 sail ${fix.sailNumberIlca4} on “${fix.keepName}”`
        );
      }
    }
  }

  // Batch apply sail number updates
  for (const update of sailNumberUpdates) {
    await db
      .update(sailors)
      .set({
        sailNumberIlca4: update.sail,
        updatedAt: new Date(),
      })
      .where(eq(sailors.id, update.id));
    sailUpdates++;
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
async function fixGohSiakYiakIanIlcaOnly(
  auth: AuthContext
): Promise<NextResponse> {
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
 * Auto-drop gold sailors who sailed <2 ranking gold regattas in a
 * completed half-year. Sets drop_date to the next half boundary.
 */
async function applyGoldParticipationDrops(
  body: Record<string, unknown>,
  auth: AuthContext
): Promise<NextResponse> {
  const asOf = String(
    body.asOf == null ? todayYmdSg() : body.asOf
  ).slice(0, 10);

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
  const targetIds = candidates.map((c) => c.sailorId);

  if (targetIds.length > 0) {
    // Since dropDate varies per candidate, we can't use a single update.
    // But we can use a transaction for better performance.
    await db.transaction(async (tx) => {
      for (const c of candidates) {
        await tx
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
 * Bulk set sailor genders from admin gender audit.
 * Body: { updates: [{ sailorId, gender: "M"|"F"|null }] }
 */
async function setSailorGenders(
  body: Record<string, unknown>,
  auth: AuthContext
): Promise<NextResponse> {
  const raw = Array.isArray(body.updates) ? body.updates : [];
  const updates: { sailorId: string; gender: "M" | "F" | null }[] = [];
  for (const u of raw) {
    if (!u || typeof u !== "object") continue;
    const row = u as Record<string, unknown>;
    const sailorId = String(row.sailorId || "").trim();
    if (!sailorId) continue;
    const gender =
      row.gender === null || row.gender === ""
        ? null
        : normalizeGender(row.gender);
    // Allow explicit null clear; reject junk non-null
    if (row.gender != null && row.gender !== "" && gender == null) {
      continue;
    }
    updates.push({ sailorId, gender });
  }
  if (updates.length === 0) {
    return NextResponse.json(
      { error: "No valid gender updates" },
      { status: 400 }
    );
  }

  let updated = 0;
  for (const u of updates) {
    await db
      .update(sailors)
      .set({ gender: u.gender, updatedAt: new Date() })
      .where(eq(sailors.id, u.sailorId));
    updated++;
    void logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: "sailor.set_gender",
      entityType: "sailor",
      entityId: u.sailorId,
      summary: `Set gender → ${u.gender || "null"}`,
      details: u,
      source: "/api/admin/sailors",
    });
  }

  return NextResponse.json({
    ok: true,
    updated,
    message: `Updated gender on ${updated} sailor(s).`,
  });
}

/**
 * Normalize sailor.gender to M | F | null (e.g. "Male" → "M", junk → null).
 * Does not invent gender or flip M↔F.
 */
async function normalizeSailorGenders(
  auth: AuthContext
): Promise<NextResponse> {
  const rows = await db
    .select({
      id: sailors.id,
      name: sailors.name,
      gender: sailors.gender,
    })
    .from(sailors);

  let updated = 0;
  let cleared = 0;
  const samples: string[] = [];
  const updates: { id: string; gender: string | null }[] = [];

  for (const s of rows) {
    const prev = s.gender == null ? null : String(s.gender).trim();
    if (!prev) continue;
    const next = normalizeGender(prev);
    // Already canonical single-letter code
    if (next && prev === next) continue;

    updates.push({ id: s.id, gender: next });
    updated++;
    if (!next) cleared++;
    if (samples.length < 30) {
      samples.push(`${s.name}: ${prev} → ${next || "null"}`);
    }
    void logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: "sailor.normalize_gender",
      entityType: "sailor",
      entityId: s.id,
      entityLabel: s.name,
      summary: `Normalize gender ${prev} → ${next || "null"}`,
      details: { from: prev, to: next },
      source: "/api/admin/sailors",
    });
  }

  if (updates.length > 0) {
    // We must update individually if we want the audit log to stay as is,
    // but we can at least use a transaction or a more efficient method.
    // Since we already called logAdminChange per sailor, we'll just perform the updates.
    for (const u of updates) {
      await db
        .update(sailors)
        .set({ gender: u.gender, updatedAt: new Date() })
        .where(eq(sailors.id, u.id));
    }
  }

  return NextResponse.json({
    ok: true,
    updated,
    cleared,
    samples,
    message:
      updated > 0
        ? `Normalized gender on ${updated} sailor(s) (${cleared} cleared as unknown).`
        : "All sailor genders already canonical (M/F/null).",
  });
}

/**
 * Auto-drop Silver-track sailors who took part in zero Optimist ranking
 * regattas in a completed half. Sets drop_date to the next half boundary.
 */
async function applySilverInactivityDrops(
  body: Record<string, unknown>,
  auth: AuthContext
): Promise<NextResponse> {
  const asOf = String(
    body.asOf == null ? todayYmdSg() : body.asOf
  ).slice(0, 10);

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
  let candidates = findSilverInactivityDrops(
    sailorRecs,
    regattaRecs,
    resultRecs,
    asOf
  );
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
      message: `Found ${candidates.length} silver inactivity drop candidate(s).`,
    });
  }

  let updated = 0;
  const targetIds = candidates.map((c) => c.sailorId);

  if (targetIds.length > 0) {
    await db.transaction(async (tx) => {
      for (const c of candidates) {
        await tx
          .update(sailors)
          .set({ dropDate: c.dropDate, updatedAt: new Date() })
          .where(eq(sailors.id, c.sailorId));
        updated++;
        void logAdminChange({
          actorUserId: auth.userId,
          actorEmail: auth.email,
          action: "sailor.silver_inactivity_drop",
          entityType: "sailor",
          entityId: c.sailorId,
          entityLabel: c.name,
          summary: `Silver/series drop ${c.dropDate} (no ranking starts in ${c.failedPeriod.half} ${c.failedPeriod.year})`,
          details: c,
          source: "/api/admin/sailors",
        });
      }
    });
  }

  return NextResponse.json({
    ok: true,
    asOf,
    updated,
    candidates,
    message:
      updated > 0
        ? `Set Optimist drop date on ${updated} silver sailor(s) for inactivity.`
        : "No silver inactivity drops needed.",
  });
}

/**
 * Seed ILCA 4 national list flags from the official authority name list
 * (name-token match). Only turns flags ON — never clears existing true.
 */
async function seedIlca4NationalList(
  auth: AuthContext
): Promise<NextResponse> {
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
async function setIlca4NationalList(
  body: Record<string, unknown>,
  auth: AuthContext
): Promise<NextResponse> {
  const ids = Array.isArray(body.sailorIds)
    ? (body.sailorIds as unknown[]).map((x) => String(x)).filter(Boolean)
    : body.sailorId != null && body.sailorId !== ""
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
async function stampEmptySeriesSilver(
  auth: AuthContext
): Promise<NextResponse> {
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
async function backfillNationalityFromSail(
  auth: AuthContext
): Promise<NextResponse> {
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
async function recomputeSilverEntryDates(
  auth: AuthContext
): Promise<NextResponse> {
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
    const nextFleet =
      s.currentFleet && s.currentFleet.toLowerCase() === "guest"
        ? s.currentFleet
        : s.currentFleet || "Series";
    await db
      .update(sailors)
      .set({
        silverEntryDate: next,
        currentFleet: nextFleet,
        updatedAt: new Date(),
      })
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
  await revalidatePublicRankings();
  return NextResponse.json({
    ok: true,
    updated,
    message: `Recomputed silver entry for ${updated} sailor(s) from first Silver ranking regatta.`,
  });
}

/** Merge duplicate Yu An profiles into canonical Yu An Li */
async function mergeYuAnProfiles(
  auth: AuthContext
): Promise<NextResponse> {
  const allSailors = await db.select().from(sailors);
  const yuAnRows = allSailors.filter((s) => {
    const clean = s.name.toLowerCase().replace(/[^a-z]/g, "");
    return (
      clean === "yuanli" ||
      clean === "liyuan" ||
      ["yu an li", "yu an", "li yu'an", "li yu an", "yu an, li", "li, yu an"].includes(s.name.trim().toLowerCase())
    );
  });

  if (yuAnRows.length <= 1) {
    return NextResponse.json({
      ok: true,
      message:
        yuAnRows.length === 1
          ? "Only 1 Yu An record found, no merge needed."
          : "No Yu An records found.",
      count: yuAnRows.length,
    });
  }

  // Select canonical survivor: prefer sail_number '2056', then exact name 'Yu An Li' / 'Yu an Li'
  yuAnRows.sort((a, b) => {
    const scoreA =
      (a.sailNumber === "2056" ? 50 : 0) +
      (a.name.toLowerCase() === "yu an li" ? 100 : 0);
    const scoreB =
      (b.sailNumber === "2056" ? 50 : 0) +
      (b.name.toLowerCase() === "yu an li" ? 100 : 0);
    return scoreB - scoreA;
  });

  const keep = yuAnRows[0];
  const duplicates = yuAnRows.slice(1);
  let mergedCount = 0;
  const mergedNames: string[] = [];

  for (const dup of duplicates) {
    await mergeSailors({
      keepId: keep.id,
      mergeId: dup.id,
      forceOwnershipConflict: true,
    });
    mergedCount++;
    mergedNames.push(dup.name);
  }

  await db
    .update(sailors)
    .set({
      name: "Yu An Li",
      gender: "F",
      sailNumber: "2056",
      club: keep.club && keep.club !== "N/A" ? keep.club : "Constant Wind",
      school: keep.school || "TAO NAN SCHOOL",
      nationality: "SGP",
      currentFleet: "Series",
      updatedAt: new Date(),
    })
    .where(eq(sailors.id, keep.id));

  await db
    .insert(sailorAliases)
    .values([
      { sailorId: keep.id, aliasName: "Yu an Li" },
      { sailorId: keep.id, aliasName: "LI YU'AN" },
      { sailorId: keep.id, aliasName: "Li Yu'An" },
      { sailorId: keep.id, aliasName: "Li Yu An" },
      { sailorId: keep.id, aliasName: "Yu An Li" },
    ])
    .onConflictDoNothing({ target: sailorAliases.aliasName });

  void logAdminChange({
    actorUserId: auth.userId,
    actorEmail: auth.email,
    action: "sailors.dedup_results",
    entityType: "sailor",
    entityId: keep.id,
    entityLabel: "Yu An Li",
    summary: `Merged ${mergedCount} duplicate profile(s) (${mergedNames.join(", ")}) into Yu An Li`,
    details: { keepId: keep.id, duplicates: mergedNames },
    source: "/api/admin/sailors",
  });

  await revalidatePublicRankings();

  return NextResponse.json({
    ok: true,
    mergedCount,
    survivorId: keep.id,
    mergedNames,
    message: `Merged ${mergedCount} duplicate profile(s) into canonical profile Yu An Li.`,
  });
}

/**
 * Update missing or outdated Optimist sail numbers and nationalities
 * based on the official rankings master list.
 */
async function applyOptimistSailNumberUpdates(
  auth: AuthContext
): Promise<NextResponse> {
  const allSailors = await db
    .select({
      id: sailors.id,
      name: sailors.name,
      sailNumber: sailors.sailNumber,
      nationality: sailors.nationality,
    })
    .from(sailors);

  const sailorLookup = new Map<string, (typeof allSailors)[0]>();
  for (const s of allSailors) {
    sailorLookup.set(cleanOptimistSailorName(s.name), s);
  }

  const details: string[] = [];
  let updatedCount = 0;
  let alreadyCorrect = 0;
  let notFound = 0;

  for (const item of OPTIMIST_SAILOR_SAIL_NUMBERS) {
    const cleanTarget = cleanOptimistSailorName(item.name);
    let match = sailorLookup.get(cleanTarget);
    if (!match && item.name.endsWith(".")) {
      match = sailorLookup.get(cleanOptimistSailorName(item.name.slice(0, -1)));
    }

    if (!match) {
      notFound++;
      continue;
    }

    const currentSail = (match.sailNumber || "").trim();
    const currentNat = (match.nationality || "").trim();
    const isMissingOrPlaceholderSail =
      !currentSail ||
      currentSail === "0" ||
      /^SGP\s*0+$/i.test(currentSail);

    const isDifferentSail = currentSail !== item.sailNumber;
    const needsNat = !currentNat && !!item.nationality;

    if (isMissingOrPlaceholderSail || isDifferentSail || needsNat) {
      await db
        .update(sailors)
        .set({
          sailNumber: item.sailNumber,
          ...(needsNat ? { nationality: item.nationality } : {}),
          updatedAt: new Date(),
        })
        .where(eq(sailors.id, match.id));

      updatedCount++;
      details.push(
        `${match.name}: sail ${currentSail || "none"} → ${item.sailNumber}${
          needsNat ? ` (nat: ${item.nationality})` : ""
        }`
      );

      void logAdminChange({
        actorUserId: auth.userId,
        actorEmail: auth.email,
        action: "sailor.update",
        entityType: "sailor",
        entityId: match.id,
        entityLabel: match.name,
        summary: `Updated Optimist sail number to ${item.sailNumber}${
          needsNat ? ` (nat: ${item.nationality})` : ""
        }`,
        details: {
          previousSail: currentSail,
          newSail: item.sailNumber,
          previousNat: currentNat,
          newNat: item.nationality,
        },
        source: "/api/admin/sailors",
      });
    } else {
      alreadyCorrect++;
    }
  }

  void revalidatePublicRankings();

  return NextResponse.json({
    ok: true,
    updatedCount,
    alreadyCorrect,
    notFound,
    details: details.slice(0, 50),
    message: `Updated ${updatedCount} Optimist sailor(s) with official sail numbers (${alreadyCorrect} already up-to-date, ${notFound} not yet in database).`,
  });
}

/**
 * Scan ALL sailors in the database and ensure Optimist sail_number only contains numbers (digits).
 * E.g. "SGP3029" -> "3029", "SGP 3029" -> "3029", "SGP-115" -> "115".
 * Also extracts nationality from letter prefixes/tokens if the sailor has no nationality.
 */
async function cleanOptimistSailNumbers(
  auth: AuthContext
): Promise<NextResponse> {
  const allSailors = await db
    .select({
      id: sailors.id,
      name: sailors.name,
      sailNumber: sailors.sailNumber,
      nationality: sailors.nationality,
    })
    .from(sailors);

  let updatedCount = 0;
  let alreadyCleanCount = 0;
  const details: string[] = [];

  for (const s of allSailors) {
    const rawSail = s.sailNumber || "";
    const cleanSail = cleanOptimistSailNumber(rawSail);
    const isSailDirty = cleanSail !== rawSail;

    const currentNat = normalizeNationality(s.nationality);
    const extractedNat = extractNationalityFromSailNumber(rawSail);
    const needsNat = !currentNat && !!extractedNat;

    if (isSailDirty || needsNat) {
      const finalNat = needsNat ? extractedNat : currentNat;
      await db
        .update(sailors)
        .set({
          sailNumber: cleanSail,
          ...(needsNat ? { nationality: finalNat, nationalityFromSail: true } : {}),
          updatedAt: new Date(),
        })
        .where(eq(sailors.id, s.id));

      updatedCount++;
      if (details.length < 50) {
        details.push(
          `${s.name}: sail "${rawSail}" → "${cleanSail}"${
            needsNat ? ` (nationality: ${finalNat})` : ""
          }`
        );
      }

      void logAdminChange({
        actorUserId: auth.userId,
        actorEmail: auth.email,
        action: "sailor.clean_optimist_sail",
        entityType: "sailor",
        entityId: s.id,
        entityLabel: s.name,
        summary: `Cleaned Optimist sail number to "${cleanSail}" (numeric only)${
          needsNat ? ` and set nationality ${finalNat}` : ""
        }`,
        details: {
          previousSail: rawSail,
          newSail: cleanSail,
          previousNat: currentNat,
          newNat: finalNat,
        },
        source: "/api/admin/sailors",
      });
    } else {
      alreadyCleanCount++;
    }
  }

  void revalidatePublicRankings();

  return NextResponse.json({
    ok: true,
    updatedCount,
    alreadyCleanCount,
    details,
    message: `Checked ${allSailors.length} sailor(s): cleaned ${updatedCount} Optimist sail number(s) to digits only (${alreadyCleanCount} were already clean).`,
  });
}

/**
 * Dispatch a named action from POST body.
 * Returns the action's response, or null when body.action is absent/unknown
 * (the route then continues to its default create-sailor behavior).
 */
export async function runSailorAction(
  body: Record<string, unknown>,
  auth: AuthContext
): Promise<NextResponse | null> {
  switch (String(body.action == null ? "" : body.action)) {
    case "applyIlcaNameCorrections":
      return applyIlcaNameCorrections(auth);
    case "applyIlcaSailorFixes":
      return applyIlcaSailorFixes(auth);
    case "fixGohSiakYiakIanIlcaOnly":
      return fixGohSiakYiakIanIlcaOnly(auth);
    case "applyGoldParticipationDrops":
      return applyGoldParticipationDrops(body, auth);
    case "applySilverInactivityDrops":
      return applySilverInactivityDrops(body, auth);
    case "normalizeSailorGenders":
      return normalizeSailorGenders(auth);
    case "setSailorGenders":
      return setSailorGenders(body, auth);
    case "seedIlca4NationalList":
      return seedIlca4NationalList(auth);
    case "setIlca4NationalList":
      return setIlca4NationalList(body, auth);
    case "stampEmptySeriesSilver":
    case "cleanupEmptySeries":
      return stampEmptySeriesSilver(auth);
    case "backfillNationalityFromSail":
      return backfillNationalityFromSail(auth);
    case "recomputeSilverEntryDates":
      return recomputeSilverEntryDates(auth);
    case "mergeYuAnProfiles":
      return mergeYuAnProfiles(auth);
    case "applyOptimistSailNumberUpdates":
      return applyOptimistSailNumberUpdates(auth);
    case "cleanOptimistSailNumbers":
      return cleanOptimistSailNumbers(auth);
    default:
      return null;
  }
}
