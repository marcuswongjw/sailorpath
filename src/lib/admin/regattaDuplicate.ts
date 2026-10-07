import { normalizeName } from "@/lib/nameMatch";
import { getRegattaEvent, REGATTA_EVENTS } from "@/lib/regattaEvents";
import { slugify } from "@/lib/slug";

/**
 * A saved weekend or class the admin might be about to overwrite.
 * Single-digit tokens stay in the comparison so Cup 1 and Cup 2, and
 * ILCA 4 and ILCA 6, are different regattas.
 */
export type RegattaIdentity = {
  id?: string | null;
  slug: string;
  name: string;
  startDate?: string | null;
  whenLabel?: string | null;
  classes?: string[] | null;
  countsForRanking?: boolean | null;
};

export type RegattaDuplicateReason = "slug" | "alias" | "name";

export type RegattaDuplicate = {
  existing: RegattaIdentity;
  reason: RegattaDuplicateReason;
  similarity: number;
};

export type RegattaDuplicateDecision = "separate" | "update";

const NAME_JACCARD_MIN = 0.85;
const SUBSET_MIN_TOKENS = 4;
const EDIT_MIN = 0.94;

function regattaTokens(name: string): string[] {
  return normalizeName(name)
    .split(/[\s'-]+/)
    .filter((token) => token.length > 0);
}

function numberKey(tokens: string[]): string {
  return tokens
    .filter((token) => /^\d+$/.test(token))
    .sort()
    .join(" ");
}

function editSimilarity(a: string, b: string): number {
  const s = a.slice(0, 180);
  const t = b.slice(0, 180);
  if (s === t) return 1;
  if (!s.length || !t.length) return 0;
  const row = new Array<number>(t.length + 1);
  for (let j = 0; j <= t.length; j += 1) row[j] = j;
  for (let i = 1; i <= s.length; i += 1) {
    let prev = row[0];
    row[0] = i;
    for (let j = 1; j <= t.length; j += 1) {
      const tmp = row[j];
      const cost = s[i - 1] === t[j - 1] ? 0 : 1;
      row[j] = Math.min(row[j] + 1, row[j - 1] + 1, prev + cost);
      prev = tmp;
    }
  }
  return 1 - row[t.length] / Math.max(s.length, t.length);
}

/** 0 when the names are distinct. A long contained name scores 0.9. */
export function regattaNameSimilarity(a: string, b: string): number {
  const left = regattaTokens(a);
  const right = regattaTokens(b);
  if (left.length < 2 || right.length < 2) return 0;
  const key = (tokens: string[]) => [...tokens].sort().join(" ");
  if (key(left) === key(right)) return 1;

  const setA = new Set(left);
  const setB = new Set(right);
  let shared = 0;
  for (const token of setA) if (setB.has(token)) shared += 1;
  const union = setA.size + setB.size - shared;
  const jaccard = union === 0 ? 0 : shared / union;
  const [shorter, longer] = setA.size <= setB.size ? [setA, setB] : [setB, setA];
  let hits = 0;
  for (const token of shorter) if (longer.has(token)) hits += 1;
  const containment = shorter.size === 0 ? 0 : hits / shorter.size;
  if (
    containment === 1 &&
    setA.size !== setB.size &&
    shorter.size >= SUBSET_MIN_TOKENS
  ) {
    return 0.9;
  }

  const sameNumbers = numberKey(left) === numberKey(right);
  const edit = sameNumbers
    ? editSimilarity(normalizeName(a), normalizeName(b))
    : 0;
  if (edit >= EDIT_MIN) return Math.round(edit * 1000) / 1000;
  if (jaccard >= NAME_JACCARD_MIN) return Math.round(jaccard * 1000) / 1000;
  return 0;
}

export function canonicalRegattaSlug(slug: string): string {
  const raw = String(slug || "").trim().toLowerCase();
  if (!raw) return "";
  return getRegattaEvent(raw)?.slug ?? raw;
}

function slugConflicts(
  candidate: string,
  taken: Set<string>,
  avoidAliases: boolean
): boolean {
  const slug = candidate.trim().toLowerCase();
  if (!slug || taken.has(slug)) return true;
  if (!avoidAliases) return false;
  const canonical = canonicalRegattaSlug(slug);
  if (taken.has(canonical)) return true;
  for (const existing of taken) {
    if (canonicalRegattaSlug(existing) === canonical) return true;
  }
  return false;
}

/**
 * A slug that does not overwrite a taken regatta.
 * Events pass avoidAliases so a known short name stays off the canonical weekend.
 */
export function availableRegattaSlug(
  name: string,
  taken: Iterable<string>,
  options?: { startDate?: string; extra?: string; avoidAliases?: boolean }
): string {
  const base = slugify(name) || "regatta";
  const takenSet = new Set(
    [...taken].map((slug) => slug.trim().toLowerCase()).filter(Boolean)
  );
  const avoidAliases = options?.avoidAliases === true;
  const extra = slugify(options?.extra || "");
  const date = String(options?.startDate || "").trim().slice(0, 10);
  const withExtra = extra ? slugify(`${base}-${extra}`) : "";
  const candidates = [
    base,
    withExtra,
    date ? `${base}-${date}` : "",
    withExtra && date ? `${withExtra}-${date}` : "",
  ].filter(Boolean);
  for (const candidate of candidates) {
    if (!slugConflicts(candidate, takenSet, avoidAliases)) return candidate;
  }
  for (let n = 2; n < 50; n += 1) {
    const candidate = `${base}-${n}`;
    if (!slugConflicts(candidate, takenSet, avoidAliases)) return candidate;
  }
  return `${base}-${takenSet.size + 2}`;
}

function matchOne(
  incomingSlug: string,
  incomingName: string,
  existing: RegattaIdentity
): RegattaDuplicate | null {
  const slug = existing.slug.trim().toLowerCase();
  if (incomingSlug && slug && incomingSlug === slug) {
    return { existing, reason: "slug", similarity: 1 };
  }
  if (
    incomingSlug &&
    slug &&
    incomingSlug !== slug &&
    canonicalRegattaSlug(incomingSlug) === canonicalRegattaSlug(slug)
  ) {
    return { existing, reason: "alias", similarity: 1 };
  }
  const similarity = regattaNameSimilarity(incomingName, existing.name);
  if (similarity <= 0) return null;
  return { existing, reason: "name", similarity };
}

function matchRank(match: RegattaDuplicate): number {
  if (match.reason === "slug") return 3;
  if (match.reason === "alias") return 2;
  return match.similarity;
}

/** The closest existing regatta, or null when the new name can be saved on its own. */
export function findRegattaDuplicate(
  input: { name: string; slug?: string | null; id?: string | null },
  existing: RegattaIdentity[]
): RegattaDuplicate | null {
  const name = input.name.trim();
  const incomingSlug = slugify(input.slug || name);
  if (!name && !incomingSlug) return null;
  let best: RegattaDuplicate | null = null;
  for (const item of existing) {
    if (!item.name?.trim() && !item.slug?.trim()) continue;
    if (input.id && item.id && input.id === item.id) continue;
    const found = matchOne(incomingSlug, name, item);
    if (!found) continue;
    if (!best || matchRank(found) > matchRank(best)) best = found;
  }
  return best;
}

export type RegattaEventSaveBody = {
  create?: boolean;
  keepUnspecified?: boolean;
  slug: string;
  name: string;
  startDate: string;
  endDate: string;
  venue: string;
  classes: string;
  countsForRanking: boolean;
};

export function planNewRegattaSave(
  input: { name: string; startDate: string; endDate?: string; venue?: string },
  existing: RegattaIdentity[],
  decision: RegattaDuplicateDecision | null
):
  | { action: "needs-decision"; duplicate: RegattaDuplicate }
  | { action: "save"; body: RegattaEventSaveBody } {
  const name = input.name.trim();
  const duplicate = findRegattaDuplicate({ name }, existing);
  if (duplicate && decision == null) {
    return { action: "needs-decision", duplicate };
  }
  if (duplicate && decision === "update") {
    return {
      action: "save",
      body: {
        create: false,
        keepUnspecified: true,
        slug: duplicate.existing.slug,
        name,
        startDate: input.startDate.trim(),
        endDate: String(input.endDate || "").trim(),
        venue: String(input.venue || "").trim(),
        classes: (duplicate.existing.classes || []).join(", "),
        countsForRanking: duplicate.existing.countsForRanking !== false,
      },
    };
  }
  return {
    action: "save",
    body: {
      create: true,
      slug: availableRegattaSlug(
        name,
        existing.map((item) => item.slug),
        { startDate: input.startDate, avoidAliases: true }
      ),
      name,
      startDate: input.startDate.trim(),
      endDate: String(input.endDate || "").trim(),
      venue: String(input.venue || "").trim(),
      classes: "",
      countsForRanking: true,
    },
  };
}

export function planNewClassSave(
  input: { name: string; date?: string; boatClass?: string; division?: string },
  existing: RegattaIdentity[],
  decision: RegattaDuplicateDecision | null
):
  | { action: "needs-decision"; duplicate: RegattaDuplicate }
  | { action: "create"; slug: string }
  | { action: "update"; id: string } {
  const duplicate = findRegattaDuplicate({ name: input.name }, existing);
  if (duplicate && decision == null) {
    return { action: "needs-decision", duplicate };
  }
  if (duplicate && decision === "update" && duplicate.existing.id) {
    return { action: "update", id: duplicate.existing.id };
  }
  const extra = [input.boatClass, input.division].filter(Boolean).join(" ");
  return {
    action: "create",
    slug: availableRegattaSlug(
      input.name,
      existing.map((item) => item.slug),
      { startDate: input.date, extra, avoidAliases: false }
    ),
  };
}

export function mergeRegattaIdentities(groups: RegattaIdentity[][]): RegattaIdentity[] {
  const bySlug = new Map<string, RegattaIdentity>();
  for (const group of groups) {
    for (const item of group) {
      const slug = item.slug.trim().toLowerCase();
      if (!slug || slug === "__unassigned__") continue;
      const current = bySlug.get(slug);
      if (!current) {
        bySlug.set(slug, { ...item, slug });
        continue;
      }
      bySlug.set(slug, {
        ...current,
        ...item,
        slug,
        id: item.id || current.id,
        name: item.name?.trim() ? item.name : current.name,
        startDate: item.startDate || current.startDate,
        whenLabel: item.whenLabel || current.whenLabel,
        classes: item.classes?.length ? item.classes : current.classes,
        countsForRanking: item.countsForRanking ?? current.countsForRanking,
      });
    }
  }
  return [...bySlug.values()];
}

export function registryRegattaIdentities(): RegattaIdentity[] {
  return REGATTA_EVENTS.map((event) => ({
    slug: event.slug,
    name: event.name,
    whenLabel: event.datesText,
    classes: event.slices.map((slice) => slice.label),
  }));
}

export function regattaIdentityFromApi(value: unknown): RegattaIdentity | null {
  if (!value || typeof value !== "object") return null;
  const row = value as Record<string, unknown>;
  const slug = String(row.slug || "").trim();
  const name = String(row.name || "").trim();
  if (!slug || !name) return null;
  const classes = Array.isArray(row.classes)
    ? row.classes.map((item) => String(item)).filter(Boolean)
    : undefined;
  return {
    id: row.id ? String(row.id) : null,
    slug,
    name,
    startDate: row.startDate
      ? String(row.startDate)
      : row.date
        ? String(row.date)
        : null,
    classes,
    countsForRanking:
      typeof row.countsForRanking === "boolean" ? row.countsForRanking : undefined,
  };
}

export function duplicateWhen(existing: RegattaIdentity): string {
  const label = existing.whenLabel?.trim();
  if (label) return label;
  const date = String(existing.startDate || "").slice(0, 10);
  return date || "no date saved";
}

export function duplicateRegattaChoice(input: {
  enteredName: string;
  existing: RegattaIdentity;
  noun?: "regatta" | "class";
}): {
  title: string;
  message: string;
  cancelLabel: string;
  choices: { value: RegattaDuplicateDecision; label: string; tone?: "primary" }[];
} {
  const noun = input.noun ?? "regatta";
  const when = duplicateWhen(input.existing);
  const keep =
    noun === "class"
      ? "Update the existing class writes this name, dates, venue, boat, and division onto it. Its results, race count, and fleet size stay."
      : "Update the existing regatta writes this name, dates, and venue onto it. Its classes and results stay.";
  return {
    title: `This ${noun} matches an existing one`,
    message:
      `"${input.enteredName.trim()}" matches "${input.existing.name}" (${when}).\n\n` +
      `Saving now would replace that ${noun}'s details.\n\n` +
      `Create as a separate ${noun} keeps both. ${keep}`,
    cancelLabel: "Cancel",
    choices: [
      {
        value: "separate",
        label: `Create as a separate ${noun}`,
        tone: "primary",
      },
      { value: "update", label: `Update the existing ${noun}` },
    ],
  };
}
