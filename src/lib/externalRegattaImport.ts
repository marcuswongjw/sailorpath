import { normalizeGeography } from "@/lib/countries";

/** Geography code used for the Singapore national-ranking series. */
export const SINGAPORE_GEOGRAPHY = "SGP";

export type ExternalRegattaImportPolicy = {
  geography: string;
  isExternal: boolean;
  requiresOfficialResultsSource: boolean;
  forcesNonRanking: boolean;
  importLifecycle: "draft" | "in_review";
};

/**
 * Keep host-country imports in the shared regatta pipeline without allowing an
 * overseas result to accidentally enter a Singapore national-ranking board.
 */
export function externalRegattaImportPolicy(
  geography: unknown
): ExternalRegattaImportPolicy {
  const raw = String(geography ?? "").trim();
  const normalized = normalizeGeography(raw) || raw.toUpperCase() || SINGAPORE_GEOGRAPHY;
  const isExternal = normalized !== SINGAPORE_GEOGRAPHY;

  return {
    geography: normalized,
    isExternal,
    requiresOfficialResultsSource: isExternal,
    forcesNonRanking: isExternal,
    importLifecycle: "in_review",
  };
}

/**
 * Accept an official web or Drive source while rejecting non-web protocols.
 * The result is stored exactly once on the class sheet and shown publicly.
 */
export function normalizeOfficialResultsUrl(value: unknown): string | null {
  const raw = String(value ?? "").trim();
  if (!raw) return null;
  try {
    const url = new URL(raw);
    if (url.protocol !== "https:" && url.protocol !== "http:") return null;
    return url.toString();
  } catch {
    return null;
  }
}

export function normalizeOfficialResultsSourceName(value: unknown): string | null {
  const text = String(value ?? "").trim().replace(/\s+/g, " ");
  return text ? text.slice(0, 240) : null;
}
