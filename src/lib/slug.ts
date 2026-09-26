/** URL-safe slug from a display name or regatta title */
export function slugify(name: string): string {
  return String(name || "")
    // Normalize sailing classes where the number is joined (e.g. "ILCA 4" -> "ilca4", "Techno 293" -> "techno293")
    .replace(/\bilca[-\s]*([467])\b/gi, "ilca$1")
    .replace(/\btechno[-\s]*(293(?:\+)?)\b/gi, "techno293")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/-+/g, "-")
    .replace(/^-+|-+$/g, "");
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
