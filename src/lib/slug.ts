/** URL-safe slug from a display name */
export function slugify(name: string): string {
  return String(name || "")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "");
}

/** Regatta slug: name + optional event date */
export function slugifyWithDate(name: string, date?: string): string {
  const base = slugify(name);
  return date ? `${base}-${date}` : base;
}

/**
 * Guest handle for auto-created sailors (unique suffix).
 * Prefer validateHandle for user-chosen public URLs.
 */
export function makeGuestHandle(name: string): string {
  const base = slugify(name) || "sailor";
  return `${base}-${Date.now().toString(36).slice(-4)}${Math.random()
    .toString(36)
    .slice(2, 5)}`;
}
