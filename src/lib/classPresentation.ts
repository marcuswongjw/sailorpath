import { canonicalBoatClass, matchesSailingClass, normalizeSailingClassToken, resolveSailingClass } from "./classRegistry";

/** Public class labels follow the registry; an unspecified ILCA rig stays unspecified. */
export function classFilterLabel(value: string | null | undefined): string {
  const raw = String(value || "").trim();
  if (raw.toLowerCase() === "all") return "all";
  if (normalizeSailingClassToken(raw) === "ilca") return "ILCA";
  return canonicalBoatClass(raw);
}

export function classFilterKey(value: string | null | undefined): string {
  const raw = String(value || "").trim();
  if (!raw || raw.toLowerCase() === "all") return "all";
  if (normalizeSailingClassToken(raw) === "ilca") return "ilca";
  return resolveSailingClass(raw)?.key || raw;
}

/** Normalize the class prefix without dropping an organiser's fleet/category suffix. */
export function sailingClassDisplayLabel(value: string | null | undefined): string {
  const raw = String(value || "").trim();
  if (normalizeSailingClassToken(raw) === "ilca") return "ILCA";
  const definition = resolveSailingClass(raw);
  if (!definition) return raw;
  const token = normalizeSailingClassToken(raw);
  const alias = [...definition.aliases].sort((a, b) => b.length - a.length).find((item) => token.startsWith(item));
  if (!alias) return raw;
  let prefix = "";
  let end = 0;
  while (end < raw.length && prefix.length < alias.length) {
    prefix += raw[end].toLowerCase().replace(/[^a-z0-9]/g, "");
    end++;
  }
  const suffix = raw.slice(end);
  return definition.label + (suffix && /^[a-z0-9]/i.test(suffix) ? ` ${suffix}` : suffix);
}

export function classFilterOptions(values: readonly (string | null | undefined)[]): string[] {
  const unique = new Map<string, string>();
  for (const value of values) {
    const label = classFilterLabel(value);
    if (label && label !== "all" && !unique.has(label.toLowerCase())) unique.set(label.toLowerCase(), label);
  }
  return [...unique.values()].sort((a, b) => a.localeCompare(b));
}

export function classDisplayLabels(values: readonly (string | null | undefined)[]): string[] {
  return [...new Set(values.map(sailingClassDisplayLabel).filter(Boolean))];
}

/** Accept existing URL keys, canonical labels, and historical spellings. */
export function classFilterMatches(value: string | null | undefined, requested: string): boolean {
  const filter = requested.trim();
  if (!filter) return false;
  if (filter.toLowerCase() === "all") return true;
  if (normalizeSailingClassToken(filter) === "ilca") return matchesSailingClass(value, "ilca");
  const definition = resolveSailingClass(filter);
  return definition ? matchesSailingClass(value, definition.key)
    : String(value || "").trim().toLowerCase() === filter.toLowerCase();
}
