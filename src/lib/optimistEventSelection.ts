/**
 * Optimist Gold Fleet — multi-event selection (combined race scores).
 *
 * Used for:
 * - 2026 Asian & Oceania Championship (Colombo): top 10 with min 3 opposite gender
 * - 2026 Perth Training Camp: birth-year buckets
 *
 * Selection events (competing in Optimist Gold Fleet):
 *  1. SSF Selection Trials (22,23,29,30 August 2026)
 *  2. Singapore National Sailing Championships (11–13 Sep 2026)
 *
 * Score = sum of finishing places (rank) across matched selection events.
 * Missing an event → treated as DNF with penalty (fleet size + 1 if known, else 999).
 * Lower combined score is better.
 */

import { birthYear } from "@/lib/age";
import type { RegattaRecord, RegattaResultRecord, SailorRecord } from "@/lib/ranking";
import { normalizeSeriesBoatClass } from "@/lib/ranking";

export type SelectionEventDef = {
  id: string;
  label: string;
  /** Inclusive date range YYYY-MM-DD for matching */
  dateFrom: string;
  dateTo: string;
  /** Name must match any of these (case-insensitive substring) */
  nameIncludes: string[];
};

export type CampaignDef = {
  id: string;
  title: string;
  subtitle: string;
  location?: string;
  when?: string;
  events: SelectionEventDef[];
  notes: string;
};

/** Shared 2026 selection trials (SSF + SNSC). */
export const OPTIMIST_2026_SELECTION_EVENTS: SelectionEventDef[] = [
  {
    id: "ssf-trials-2026",
    label: "SSF Selection Trials",
    dateFrom: "2026-08-22",
    dateTo: "2026-08-30",
    nameIncludes: [
      "ssf selection",
      "selection trial",
      "selection trials",
      "ssf trial",
    ],
  },
  {
    id: "snsc-2026",
    label: "Singapore National Sailing Championships",
    dateFrom: "2026-09-11",
    dateTo: "2026-09-13",
    nameIncludes: [
      "national sailing championship",
      "singapore national",
      "snsc",
      "national championship",
    ],
  },
];

export const ASIAN_OCEANIA_2026: CampaignDef = {
  id: "asian-oceania-2026",
  title: "2026 Optimist Asian & Oceania Championship",
  subtitle: "Colombo, Sri Lanka · 12–19 December 2026",
  location: "Colombo, Sri Lanka",
  when: "12–19 December 2026",
  events: OPTIMIST_2026_SELECTION_EVENTS,
  notes:
    "Top 10 sailors by lowest combined race scores (places) across selection events, with a minimum of 3 of the opposite gender. Competing in Optimist Gold Fleet.",
};

export const PERTH_CAMP_2026: CampaignDef = {
  id: "perth-camp-2026",
  title: "Optimist Perth Training Camp 2026",
  subtitle: "Perth, Australia · November 2026",
  location: "Perth, Australia",
  when: "November 2026",
  events: OPTIMIST_2026_SELECTION_EVENTS,
  notes:
    "By birth year (calendar year on DOB): Top boy & top girl born 2013; top 3 boys & top 3 girls born 2014; top 2 boys & top 2 girls born 2015. Lowest combined race scores across the same selection events (Optimist Gold Fleet).",
};

export type MatchedSelectionEvent = {
  def: SelectionEventDef;
  regatta: RegattaRecord | null;
  matched: boolean;
};

export type SailorEventScore = {
  regattaId: string;
  regattaName: string;
  rank: number | null;
  isDns: boolean;
  /** Contribution to combined score */
  score: number;
  missing: boolean;
};

export type CombinedSelectionRow = {
  sailorId: string;
  name: string;
  handle?: string | null;
  gender: "M" | "F" | null;
  birthYear: number | null;
  nationality?: string | null;
  eventScores: SailorEventScore[];
  combinedScore: number;
  eventsSailed: number;
};

function ymd(d: string | Date | null | undefined): string {
  return String(d || "").slice(0, 10);
}

function isOptimistGoldRegatta(r: RegattaRecord): boolean {
  const cls = normalizeSeriesBoatClass(r.boatClass);
  if (cls !== "optimist") return false;
  const div = String(r.division || "").toLowerCase();
  // Prefer Gold; allow open/unknown if name matches selection event
  if (div.includes("silver")) return false;
  return true;
}

export function matchSelectionEvents(
  regattas: RegattaRecord[],
  defs: SelectionEventDef[]
): MatchedSelectionEvent[] {
  const optimist = regattas.filter(isOptimistGoldRegatta);
  return defs.map((def) => {
    const candidates = optimist.filter((r) => {
      const d = ymd(r.date);
      if (d < def.dateFrom || d > def.dateTo) return false;
      const name = String(r.name || "").toLowerCase();
      return def.nameIncludes.some((frag) => name.includes(frag.toLowerCase()));
    });
    // Prefer ranking events, then largest fleet, then name
    candidates.sort((a, b) => {
      const ar = a.countsForRanking === false ? 1 : 0;
      const br = b.countsForRanking === false ? 1 : 0;
      if (ar !== br) return ar - br;
      return (b.totalFleetSize || 0) - (a.totalFleetSize || 0);
    });
    const regatta = candidates[0] || null;
    return { def, regatta, matched: Boolean(regatta) };
  });
}

function normalizeGender(g: string | null | undefined): "M" | "F" | null {
  const s = String(g || "")
    .trim()
    .toLowerCase();
  if (s === "f" || s === "female" || s === "girl" || s === "w" || s === "woman")
    return "F";
  if (s === "m" || s === "male" || s === "boy" || s === "man") return "M";
  return null;
}

/**
 * Combined place scores across matched selection events for all sailors
 * who have at least one result in those events.
 */
export function computeCombinedSelectionScores(
  matched: MatchedSelectionEvent[],
  sailors: SailorRecord[],
  results: RegattaResultRecord[]
): CombinedSelectionRow[] {
  const regIds = matched
    .map((m) => m.regatta?.id)
    .filter(Boolean) as string[];
  if (!regIds.length) return [];

  const sailorIds = new Set<string>();
  for (const res of results) {
    if (regIds.includes(res.regattaId)) sailorIds.add(res.sailorId);
  }

  const sailorById = new Map(sailors.map((s) => [s.id, s]));
  const rows: CombinedSelectionRow[] = [];

  for (const sid of sailorIds) {
    const s = sailorById.get(sid);
    if (!s) continue;
    const eventScores: SailorEventScore[] = [];
    let combined = 0;
    let sailed = 0;

    for (const m of matched) {
      if (!m.regatta) {
        eventScores.push({
          regattaId: m.def.id,
          regattaName: m.def.label,
          rank: null,
          isDns: false,
          score: 999,
          missing: true,
        });
        combined += 999;
        continue;
      }
      const res = results.find(
        (x) => x.sailorId === sid && x.regattaId === m.regatta!.id
      );
      const fleet = Math.max(1, Number(m.regatta.totalFleetSize) || 1);
      const dns = Boolean(res?.isDns);
      if (!res) {
        const pen = fleet + 1;
        eventScores.push({
          regattaId: m.regatta.id,
          regattaName: m.regatta.name,
          rank: null,
          isDns: false,
          score: pen,
          missing: true,
        });
        combined += pen;
      } else {
        const rank = Number(res.rank);
        const score = dns || !Number.isFinite(rank) ? fleet + 1 : rank;
        eventScores.push({
          regattaId: m.regatta.id,
          regattaName: m.regatta.name,
          rank: Number.isFinite(rank) ? rank : null,
          isDns: dns,
          score,
          missing: false,
        });
        combined += score;
        if (!dns && Number.isFinite(rank)) sailed++;
      }
    }

    rows.push({
      sailorId: sid,
      name: s.name,
      handle: s.handle,
      gender: normalizeGender(s.gender),
      birthYear: birthYear(s.dob),
      nationality: s.nationality,
      eventScores,
      combinedScore: combined,
      eventsSailed: sailed,
    });
  }

  rows.sort((a, b) => {
    if (a.combinedScore !== b.combinedScore)
      return a.combinedScore - b.combinedScore;
    if (b.eventsSailed !== a.eventsSailed) return b.eventsSailed - a.eventsSailed;
    return a.name.localeCompare(b.name);
  });

  return rows;
}

/**
 * Asian & Oceania: top 10 by combined score with at least 3 of the minority gender
 * (min 3 opposite gender overall in the team of 10).
 *
 * Algorithm: take ranked list by combined score; greedily fill 10 ensuring
 * we never lock into a state where we cannot reach 3 of each gender if available.
 * Practical approach: select top 10 in order, then if fewer than 3 of one gender,
 * replace lowest-ranked majority gender with next available minority gender.
 */
export function selectAsianOceaniaTeam(
  ranked: CombinedSelectionRow[],
  teamSize = 10,
  minPerGender = 3
): {
  selected: (CombinedSelectionRow & { teamRank: number })[];
  reason: string;
} {
  if (!ranked.length) {
    return { selected: [], reason: "No selection-event results yet." };
  }

  const selected: CombinedSelectionRow[] = [];
  const used = new Set<string>();

  for (const row of ranked) {
    if (selected.length >= teamSize) break;
    selected.push(row);
    used.add(row.sailorId);
  }

  const countG = (list: CombinedSelectionRow[], g: "M" | "F") =>
    list.filter((s) => s.gender === g).length;

  const rebalance = (g: "M" | "F") => {
    while (countG(selected, g) < minPerGender) {
      const next = ranked.find(
        (r) => !used.has(r.sailorId) && r.gender === g
      );
      if (!next) break;
      // Drop worst majority gender (last selected of other gender)
      const other: "M" | "F" = g === "M" ? "F" : "M";
      let dropIdx = -1;
      for (let i = selected.length - 1; i >= 0; i--) {
        if (selected[i].gender === other) {
          dropIdx = i;
          break;
        }
      }
      if (dropIdx < 0) break;
      const dropped = selected[dropIdx];
      used.delete(dropped.sailorId);
      selected.splice(dropIdx, 1);
      selected.push(next);
      used.add(next.sailorId);
      // Keep selected ordered by combined score
      selected.sort((a, b) => a.combinedScore - b.combinedScore);
    }
  };

  rebalance("M");
  rebalance("F");

  const m = countG(selected, "M");
  const f = countG(selected, "F");
  return {
    selected: selected.map((s, i) => ({ ...s, teamRank: i + 1 })),
    reason:
      m < minPerGender || f < minPerGender
        ? `Team of ${selected.length}: ${m}M / ${f}F — could not fully meet min ${minPerGender} per gender (insufficient candidates).`
        : `Top ${selected.length} by lowest combined place scores · ${m}M / ${f}F (min ${minPerGender} per gender).`,
  };
}

export type PerthBucketId = "by2013" | "by2014" | "by2015";

export type PerthPick = CombinedSelectionRow & {
  bucket: PerthBucketId;
  bucketLabel: string;
  slot: string;
};

/**
 * Perth camp: birth-year buckets with gender slots.
 */
export function selectPerthCamp(
  ranked: CombinedSelectionRow[]
): { picks: PerthPick[]; notes: string[] } {
  const picks: PerthPick[] = [];
  const used = new Set<string>();
  const notes: string[] = [];

  const takeBucket = (
    by: number,
    nMale: number,
    nFemale: number,
    bucket: PerthBucketId,
    bucketLabel: string
  ) => {
    const pool = ranked.filter(
      (r) => r.birthYear === by && !used.has(r.sailorId)
    );
    const males = pool.filter((r) => r.gender === "M");
    const females = pool.filter((r) => r.gender === "F");
    let tm = 0;
    for (const r of males) {
      if (tm >= nMale) break;
      picks.push({
        ...r,
        bucket,
        bucketLabel,
        slot: `Boy · born ${by}`,
      });
      used.add(r.sailorId);
      tm++;
    }
    let tf = 0;
    for (const r of females) {
      if (tf >= nFemale) break;
      picks.push({
        ...r,
        bucket,
        bucketLabel,
        slot: `Girl · born ${by}`,
      });
      used.add(r.sailorId);
      tf++;
    }
    if (tm < nMale || tf < nFemale) {
      notes.push(
        `Born ${by}: filled ${tm}/${nMale} boys, ${tf}/${nFemale} girls`
      );
    }
  };

  // Top boy & top girl [born 2013]
  takeBucket(2013, 1, 1, "by2013", "Born 2013 · top boy & top girl");
  // Top 3 boys & top 3 girls [born 2014]
  takeBucket(2014, 3, 3, "by2014", "Born 2014 · top 3 boys & top 3 girls");
  // Top 2 boys & top 2 girls [born 2015]
  takeBucket(2015, 2, 2, "by2015", "Born 2015 · top 2 boys & top 2 girls");

  return { picks, notes };
}
