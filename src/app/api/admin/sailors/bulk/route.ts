import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { sailors } from "@/db/schema";
import { eq, inArray } from "drizzle-orm";
import { nameTokenKey } from "@/lib/nameMatch";
import { normalizeYearsList } from "@/lib/seriesMembership";

type BulkSailorRow = {
  name: string;
  handle?: string | null;
  sailNumber?: string | null;
  club?: string | null;
  school?: string | null;
  nationality?: string | null;
  gender?: string | null;
  bio?: string | null;
  nationalSquadStatus?: string | null;
  currentFleet?: string | null;
  manuallyDropped?: boolean | string | null;
  goldEntryDate?: string | null;
  silverEntryDate?: string | null;
  dropDate?: string | null;
  dob?: string | null;
  weight?: number | string | null;
  instagram?: string | null;
  facebook?: string | null;
  natSquadStatusJan25?: string | null;
  natSquadStatusJul25?: string | null;
  natSquadStatusJan26?: string | null;
  natSquadStatusJul26?: string | null;
  histRankingJun24?: number | string | null;
  histRankingDec24?: number | string | null;
  histRankingJun25?: number | string | null;
  histRankingDec25?: number | string | null;
  histRankingJun26?: number | string | null;
  worlds?: number | string | null;
  european?: number | string | null;
  asian?: number | string | null;
  seaGames?: number | string | null;
};

function slugHandle(name: string, sailNumber?: string | null) {
  const base = name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "");
  const sn = (sailNumber || "").toLowerCase().replace(/[^a-z0-9]+/g, "");
  return sn ? `${base}-${sn}` : base || `sailor-${Date.now().toString(36)}`;
}

function num(v: unknown): number | null {
  if (v === "" || v == null) return null;
  const n = Number(v);
  return Number.isFinite(n) ? n : null;
}

function emptyToNull(v: unknown): string | null {
  if (v == null) return null;
  const s = String(v).trim();
  return s === "" ? null : s;
}

function parseFleet(v: unknown): string | null {
  const s = emptyToNull(v);
  if (!s) return null;
  const lower = s.toLowerCase();
  if (lower.startsWith("gold")) return "Gold";
  if (lower.startsWith("silver")) return "Silver";
  return s;
}

function parseYes(v: unknown): boolean {
  if (v === true || v === 1) return true;
  const s = String(v ?? "")
    .trim()
    .toLowerCase();
  return s === "y" || s === "yes" || s === "true" || s === "1";
}

/** One-time roster import */
export async function POST(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();
    const rows: BulkSailorRow[] = Array.isArray(body.rows) ? body.rows : [];
    if (!rows.length) {
      return NextResponse.json({ error: "No rows provided" }, { status: 400 });
    }

    let created = 0;
    let updated = 0;
    const errors: { row: number; name: string; error: string }[] = [];

    // Preload for jumbled-name duplicate detection
    let existingAll = await db
      .select({ id: sailors.id, name: sailors.name, handle: sailors.handle, sailNumber: sailors.sailNumber })
      .from(sailors);

    for (let i = 0; i < rows.length; i++) {
      const r = rows[i];
      const name = String(r.name || "").trim();
      if (!name) {
        errors.push({ row: i + 1, name: "", error: "Missing name" });
        continue;
      }

      const sailNumber = emptyToNull(r.sailNumber) || "SGP 000";
      const handle =
        emptyToNull(r.handle)?.toLowerCase().replace(/[^a-z0-9_-]/g, "") ||
        slugHandle(name, sailNumber === "SGP 000" ? null : sailNumber);

      const values = {
        name,
        handle,
        sailNumber,
        club: emptyToNull(r.club) || "N/A",
        school: emptyToNull(r.school),
        nationality: emptyToNull(r.nationality),
        gender: emptyToNull(r.gender),
        bio: emptyToNull(r.bio),
        nationalSquadStatus: emptyToNull(r.nationalSquadStatus),
        currentFleet: parseFleet(r.currentFleet),
        goldEntryDate: emptyToNull(r.goldEntryDate),
        silverEntryDate: emptyToNull(r.silverEntryDate),
        dropDate: emptyToNull(r.dropDate),
        // Prefer drop date for fleet exit; never keep both manual + drop date
        manuallyDropped: emptyToNull(r.dropDate)
          ? false
          : parseYes(r.manuallyDropped),
        dob: emptyToNull(r.dob),
        weight: num(r.weight),
        instagram: emptyToNull(r.instagram),
        natSquadStatusJan25: emptyToNull(r.natSquadStatusJan25),
        natSquadStatusJul25: emptyToNull(r.natSquadStatusJul25),
        natSquadStatusJan26: emptyToNull(r.natSquadStatusJan26),
        natSquadStatusJul26: emptyToNull(r.natSquadStatusJul26),
        histRankingJun24: num(r.histRankingJun24),
        histRankingDec24: num(r.histRankingDec24),
        histRankingJun25: num(r.histRankingJun25),
        histRankingDec25: num(r.histRankingDec25),
        histRankingJun26: num(r.histRankingJun26),
        worlds: normalizeYearsList(r.worlds),
        european: normalizeYearsList(r.european),
        asian: normalizeYearsList(r.asian),
        seaGames: normalizeYearsList(r.seaGames),
        updatedAt: new Date(),
      };

      try {
        let existingId: string | null = null;
        const byHandle = existingAll.find((s) => s.handle === handle);
        if (byHandle) existingId = byHandle.id;
        if (!existingId && sailNumber !== "SGP 000") {
          const bySail = existingAll.find((s) => s.sailNumber === sailNumber);
          if (bySail) existingId = bySail.id;
        }
        // Same person, jumbled name order
        if (!existingId) {
          const key = nameTokenKey(name);
          const byTokens = existingAll.find((s) => nameTokenKey(s.name) === key);
          if (byTokens) existingId = byTokens.id;
        }

        if (existingId) {
          // Keep existing handle; update fields (don't overwrite handle unless empty sail)
          const { handle: _h, ...rest } = values;
          await db
            .update(sailors)
            .set(rest)
            .where(eq(sailors.id, existingId));
          updated++;
        } else {
          const [ins] = await db.insert(sailors).values(values).returning({
            id: sailors.id,
            name: sailors.name,
            handle: sailors.handle,
            sailNumber: sailors.sailNumber,
          });
          existingAll = [...existingAll, ins];
          created++;
        }
      } catch (e) {
        errors.push({
          row: i + 1,
          name,
          error: e instanceof Error ? e.message.slice(0, 120) : "Insert failed",
        });
      }
    }

    return NextResponse.json({
      message: `Roster import: ${created} created, ${updated} updated, ${errors.length} errors.`,
      created,
      updated,
      errors: errors.slice(0, 50),
    });
  } catch (e) {
    console.error(e);
    return jsonError(e);
  }
}

/** Bulk delete sailors (and cascaded results) */
export async function DELETE(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();
    const sailorIds: string[] = Array.isArray(body.sailorIds)
      ? body.sailorIds
      : [];
    if (!sailorIds.length) {
      return NextResponse.json({ error: "No sailors selected" }, { status: 400 });
    }
    const deleted = await db
      .delete(sailors)
      .where(inArray(sailors.id, sailorIds))
      .returning({ id: sailors.id });
    return NextResponse.json({
      ok: true,
      message: `Deleted ${deleted.length} sailors (results cascaded).`,
      count: deleted.length,
    });
  } catch (e) {
    console.error(e);
    return jsonError(e);
  }
}
