/**
 * Sailor gender codes: store and compare as M | F only.
 */

/** Normalize any import/UI/DB value to M | F | null. */
export function normalizeGender(v: unknown): "M" | "F" | null {
  if (v == null || v === "") return null;
  const s = String(v).trim().toLowerCase();
  if (!s || /^n\/?a$/i.test(s) || s === "-" || s === "—" || s === "?") {
    return null;
  }
  // Exact tokens only — do not use startsWith("m") (matches "mixed", "miss", …)
  if (
    s === "m" ||
    s === "male" ||
    s === "boy" ||
    s === "man" ||
    s === "♂"
  ) {
    return "M";
  }
  if (
    s === "f" ||
    s === "female" ||
    s === "girl" ||
    s === "woman" ||
    s === "♀"
  ) {
    return "F";
  }
  return null;
}

/** @deprecated Prefer normalizeGender — kept for import call sites. */
export const normalizeImportGender = normalizeGender;

/** Short label for rankings / lists. */
export function formatGenderLabel(v: unknown): string {
  const g = normalizeGender(v);
  if (g === "M") return "M";
  if (g === "F") return "F";
  return "—";
}

/** Long label when space allows. */
export function formatGenderLong(v: unknown): string {
  const g = normalizeGender(v);
  if (g === "M") return "Male";
  if (g === "F") return "Female";
  return "—";
}
