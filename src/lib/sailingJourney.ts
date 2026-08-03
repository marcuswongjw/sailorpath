/**
 * Parse / serialize owner sailing journey highlights.
 * System milestones (gold entry, first silver) are derived and merged for display.
 */

export type JourneyHighlight = {
  id: string;
  when: string;
  title: string;
  detail: string;
  /** System-derived milestones cannot be removed by the owner */
  system?: boolean;
};

export function parseSailingJourney(raw: unknown): JourneyHighlight[] {
  if (raw == null || raw === "") return [];
  try {
    const v = typeof raw === "string" ? JSON.parse(raw) : raw;
    if (!Array.isArray(v)) return [];
    return v
      .map((item, i) => {
        if (!item || typeof item !== "object") return null;
        const o = item as Record<string, unknown>;
        const title = String(o.title || "").trim();
        if (!title) return null;
        return {
          id: String(o.id || `j-${i}-${Date.now()}`).slice(0, 64),
          when: String(o.when || "").trim().slice(0, 40),
          title: title.slice(0, 120),
          detail: String(o.detail || "").trim().slice(0, 500),
        } as JourneyHighlight;
      })
      .filter(Boolean) as JourneyHighlight[];
  } catch {
    return [];
  }
}

export function serializeSailingJourney(
  items: JourneyHighlight[]
): string | null {
  // Never persist live system milestones; keep owner notes + dismissals
  const owner = items.filter((it) => !it.system);
  if (!owner.length) return null;
  return JSON.stringify(
    owner.slice(0, 40).map((it) => ({
      id: it.id.slice(0, 64),
      when: it.when.slice(0, 40),
      title: it.title.slice(0, 120),
      detail: it.detail.slice(0, 500),
    }))
  );
}

export function newJourneyId(): string {
  return `j-${Date.now().toString(36)}-${Math.random().toString(36).slice(2, 8)}`;
}

function ymd(v: unknown): string {
  return String(v || "").slice(0, 10);
}

function isValidYmd(d: string): boolean {
  return /^\d{4}-\d{2}-\d{2}$/.test(d);
}

function formatJourneyWhen(d: string): string {
  if (!isValidYmd(d)) return d;
  const [y, m] = d.split("-");
  const months = [
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
  const mi = Number(m) - 1;
  if (mi >= 0 && mi < 12) return `${months[mi]} ${y}`;
  return y;
}

export type JourneyResultHint = {
  regattaDate?: string | null;
  division?: string | null;
  boatClass?: string | null;
  regattaName?: string | null;
  countsForRanking?: boolean | null;
};

/**
 * System milestones: first Optimist silver regatta (if any) + gold fleet entry.
 */
export function buildSystemJourneyMilestones(
  sailor: {
    goldEntryDate?: string | null;
    silverEntryDate?: string | null;
  },
  results: JourneyResultHint[] = []
): JourneyHighlight[] {
  const out: JourneyHighlight[] = [];

  // First silver: prefer earliest silver ranking result; fall back to silverEntryDate
  let firstSilverDate: string | null = null;
  let firstSilverName: string | null = null;
  for (const r of results) {
    const bc = String(r.boatClass || "Optimist")
      .trim()
      .toLowerCase();
    if (bc && bc.includes("ilca")) continue;
    const div = String(r.division || "").toLowerCase();
    if (!div.includes("silver")) continue;
    const d = ymd(r.regattaDate);
    if (!isValidYmd(d)) continue;
    if (!firstSilverDate || d < firstSilverDate) {
      firstSilverDate = d;
      firstSilverName = String(r.regattaName || "").trim() || null;
    }
  }
  const silverFallback = ymd(sailor.silverEntryDate);
  if (!firstSilverDate && isValidYmd(silverFallback)) {
    firstSilverDate = silverFallback;
  }
  if (firstSilverDate) {
    out.push({
      id: "sys-first-silver",
      when: formatJourneyWhen(firstSilverDate),
      title: "First silver fleet regatta",
      detail: firstSilverName
        ? `Debuted in silver at ${firstSilverName}.`
        : "Entered Optimist silver fleet.",
      system: true,
    });
  }

  const gold = ymd(sailor.goldEntryDate);
  if (isValidYmd(gold)) {
    out.push({
      id: "sys-gold-entry",
      when: formatJourneyWhen(gold),
      title: "Broke into gold fleet",
      detail: `Promoted to Optimist gold fleet (${gold.slice(0, 4)}).`,
      system: true,
    });
  }

  return out;
}

/** Owner record that hides a system milestone permanently. */
export const DISMISSED_SYSTEM_TITLE = "__dismissed_system__";

export function isDismissedSystemRecord(it: JourneyHighlight): boolean {
  return it.title === DISMISSED_SYSTEM_TITLE;
}

/** System milestone ids the sailor has removed. */
export function dismissedSystemIds(owner: JourneyHighlight[]): Set<string> {
  const out = new Set<string>();
  for (const o of owner) {
    if (!isDismissedSystemRecord(o)) continue;
    const id = String(o.detail || "").trim();
    if (id) out.add(id);
  }
  return out;
}

/** Persist a dismissal so the system milestone stays hidden. */
export function dismissSystemMilestone(
  owner: JourneyHighlight[],
  systemId: string
): JourneyHighlight[] {
  const id = String(systemId || "").trim();
  if (!id) return owner;
  if (dismissedSystemIds(owner).has(id)) return owner;
  return [
    {
      id: `dismissed-${id}`.slice(0, 64),
      when: "",
      title: DISMISSED_SYSTEM_TITLE,
      detail: id.slice(0, 500),
    },
    ...owner,
  ];
}

/**
 * Merge system milestones with owner highlights.
 * Dedupes owner items that match system titles; sorts by `when` (year/month text).
 * Honours dismissed system milestones.
 */
export function mergeJourneyDisplay(
  owner: JourneyHighlight[],
  system: JourneyHighlight[]
): JourneyHighlight[] {
  const dismissed = dismissedSystemIds(owner);
  const systemVisible = system.filter((s) => !dismissed.has(s.id));
  const systemTitles = new Set(
    systemVisible.map((s) => s.title.trim().toLowerCase())
  );
  const ownerFiltered = owner.filter(
    (o) =>
      !isDismissedSystemRecord(o) &&
      !systemTitles.has(o.title.trim().toLowerCase())
  );
  const all = [...systemVisible, ...ownerFiltered];
  // Sort by when string when it looks like "Mon YYYY" or "YYYY-MM-DD" or year
  const sortKey = (w: string): string => {
    const t = w.trim();
    if (/^\d{4}-\d{2}-\d{2}$/.test(t)) return t;
    const mon = t.match(
      /^(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+(\d{4})$/i
    );
    if (mon) {
      const map: Record<string, string> = {
        jan: "01",
        feb: "02",
        mar: "03",
        apr: "04",
        may: "05",
        jun: "06",
        jul: "07",
        aug: "08",
        sep: "09",
        oct: "10",
        nov: "11",
        dec: "12",
      };
      const m = map[mon[1].toLowerCase()] || "01";
      return `${mon[2]}-${m}-01`;
    }
    if (/^\d{4}$/.test(t)) return `${t}-01-01`;
    return t || "9999-99-99";
  };
  return all.sort((a, b) => sortKey(a.when).localeCompare(sortKey(b.when)));
}
