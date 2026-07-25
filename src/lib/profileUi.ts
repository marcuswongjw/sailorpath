/**
 * Display helpers for sailor profile (results cards, career timeline).
 */

export type PlaceBadge = {
  label: string;
  className: string;
};

/** Medal / place chips inspired by modern athlete profiles */
export function placeBadge(
  rank: number | null | undefined,
  opts?: { isDns?: boolean; isOverseas?: boolean }
): PlaceBadge | null {
  if (opts?.isDns) {
    return {
      label: "DNS",
      className: "bg-rose-500/15 text-rose-300 border border-rose-500/30",
    };
  }
  if (opts?.isOverseas) {
    return {
      label: "Overseas",
      className: "bg-sky-500/15 text-sky-300 border border-sky-500/30",
    };
  }
  if (rank == null || !Number.isFinite(Number(rank))) return null;
  const r = Number(rank);
  if (r === 1) {
    return {
      label: "Gold",
      className:
        "bg-amber-500/15 text-amber-300 border border-amber-500/35",
    };
  }
  if (r === 2) {
    return {
      label: "Silver",
      className: "bg-slate-300/15 text-slate-200 border border-slate-300/30",
    };
  }
  if (r === 3) {
    return {
      label: "Bronze",
      className:
        "bg-orange-700/20 text-orange-300 border border-orange-600/35",
    };
  }
  if (r <= 10) {
    return {
      label: "Top 10",
      className: "bg-blue-500/15 text-blue-300 border border-blue-500/30",
    };
  }
  if (r <= 25) {
    return {
      label: "Top 25",
      className: "bg-violet-500/10 text-violet-300 border border-violet-500/25",
    };
  }
  return null;
}

export type TimelineItem = {
  id: string;
  sortKey: string; // YYYY-MM for ordering
  when: string; // display e.g. Jun 2026
  title: string;
  detail: string;
};

function monthLabel(ymd: string): string {
  const m = Number(ymd.slice(5, 7));
  const y = ymd.slice(0, 4);
  const names = [
    "",
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  return `${names[m] || ymd.slice(5, 7)} ${y}`;
}

/** Build career timeline from sailor fields + top regatta results */
export function buildCareerTimeline(
  sailor: {
    worlds?: string | number | null;
    european?: string | number | null;
    asian?: string | number | null;
    seaGames?: string | number | null;
    goldEntryDate?: string | null;
    silverEntryDate?: string | null;
    natSquadStatusJan25?: string | null;
    natSquadStatusJul25?: string | null;
    natSquadStatusJan26?: string | null;
    natSquadStatusJul26?: string | null;
    histRankingJun24?: number | null;
    histRankingDec24?: number | null;
    histRankingJun25?: number | null;
    histRankingDec25?: number | null;
    histRankingJun26?: number | null;
  },
  results: {
    id?: string;
    regattaId?: string;
    regattaName?: string;
    regattaDate?: string;
    rank?: number;
    isDns?: boolean;
    isDNS?: boolean;
  }[] = []
): TimelineItem[] {
  const items: TimelineItem[] = [];

  const addYears = (
    raw: string | number | null | undefined,
    title: string,
    detail: string
  ) => {
    if (raw == null || raw === "") return;
    const years = String(raw).match(/\b(19|20)\d{2}\b/g) || [];
    for (const y of years) {
      items.push({
        id: `${title}-${y}`,
        sortKey: `${y}-07`,
        when: y,
        title,
        detail: detail.replace("{y}", y),
      });
    }
  };

  addYears(
    sailor.worlds,
    "World Optimist Championships",
    "Represented at World Optimist Championships ({y})."
  );
  addYears(
    sailor.european,
    "European Optimist Championships",
    "Represented at European Optimist Championships ({y})."
  );
  addYears(
    sailor.asian,
    "Asian Optimist Championships",
    "Represented at Asian Optimist Championships ({y})."
  );
  addYears(
    sailor.seaGames,
    "SEA Games",
    "SEA Games representation ({y})."
  );

  if (sailor.goldEntryDate) {
    const d = String(sailor.goldEntryDate).slice(0, 10);
    items.push({
      id: "gold-entry",
      sortKey: d.slice(0, 7),
      when: monthLabel(d),
      title: "Gold fleet entry",
      detail: "Entered SG Optimist Gold ranking fleet.",
    });
  }
  if (sailor.silverEntryDate) {
    const d = String(sailor.silverEntryDate).slice(0, 10);
    items.push({
      id: "silver-entry",
      sortKey: d.slice(0, 7),
      when: monthLabel(d),
      title: "Silver fleet entry",
      detail: "Entered SG Optimist Silver ranking fleet.",
    });
  }

  const squadSlots: { key: keyof typeof sailor; label: string; sort: string }[] =
    [
      { key: "natSquadStatusJan25", label: "Jan – Jun 2025", sort: "2025-01" },
      { key: "natSquadStatusJul25", label: "Jul – Dec 2025", sort: "2025-07" },
      { key: "natSquadStatusJan26", label: "Jan – Jun 2026", sort: "2026-01" },
      { key: "natSquadStatusJul26", label: "Jul – Dec 2026", sort: "2026-07" },
    ];
  for (const s of squadSlots) {
    const v = sailor[s.key];
    if (v != null && String(v).trim()) {
      items.push({
        id: `squad-${s.sort}`,
        sortKey: s.sort,
        when: s.label,
        title: `National squad · ${v}`,
        detail: `Squad status for ${s.label}.`,
      });
    }
  }

  const hist: { key: keyof typeof sailor; label: string; sort: string }[] = [
    { key: "histRankingJun24", label: "Jun 2024 ranking", sort: "2024-06" },
    { key: "histRankingDec24", label: "Dec 2024 ranking", sort: "2024-12" },
    { key: "histRankingJun25", label: "Jun 2025 ranking", sort: "2025-06" },
    { key: "histRankingDec25", label: "Dec 2025 ranking", sort: "2025-12" },
    { key: "histRankingJun26", label: "Jun 2026 ranking", sort: "2026-06" },
  ];
  for (const h of hist) {
    const v = sailor[h.key];
    if (v != null && Number.isFinite(Number(v))) {
      items.push({
        id: `hist-${h.sort}`,
        sortKey: h.sort,
        when: h.label.replace(" ranking", ""),
        title: `#${v} overall`,
        detail: h.label,
      });
    }
  }

  // Highlight podium / top-10 finishes
  for (const res of results) {
    const rank = res.rank;
    const dns = Boolean(res.isDns || res.isDNS);
    if (dns || rank == null || rank > 10) continue;
    const d = String(res.regattaDate || "").slice(0, 10);
    if (!/^\d{4}-\d{2}-\d{2}$/.test(d)) continue;
    items.push({
      id: `res-${res.regattaId || res.id || d}-${rank}`,
      sortKey: d.slice(0, 7),
      when: monthLabel(d),
      title:
        rank <= 3
          ? `${res.regattaName || "Regatta"} — ${rank === 1 ? "1st" : rank === 2 ? "2nd" : "3rd"}`
          : `${res.regattaName || "Regatta"} — ${rank}th`,
      detail: `Finished ${rank}${rank === 1 ? "st" : rank === 2 ? "nd" : rank === 3 ? "rd" : "th"} at ${res.regattaName || "the event"}.`,
    });
  }

  // newest first
  items.sort((a, b) => b.sortKey.localeCompare(a.sortKey));
  // de-dupe by id
  const seen = new Set<string>();
  return items.filter((it) => {
    if (seen.has(it.id)) return false;
    seen.add(it.id);
    return true;
  });
}

export function formatEventWhen(date: string | null | undefined): string {
  const d = String(date || "").slice(0, 10);
  if (!/^\d{4}-\d{2}-\d{2}$/.test(d)) return d || "—";
  return monthLabel(d);
}
