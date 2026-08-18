/**
 * Helpers for richer destructive-action confirm copy.
 */

/** First N names, then “+K more” if needed. */
export function summarizeNames(
  names: string[],
  limit = 5
): { listed: string; extra: number } {
  const clean = names.map((n) => n.trim()).filter(Boolean);
  if (clean.length === 0) return { listed: "(none)", extra: 0 };
  const shown = clean.slice(0, limit);
  const extra = Math.max(0, clean.length - shown.length);
  return {
    listed: shown.map((n) => `• ${n}`).join("\n"),
    extra,
  };
}

export function cascadeLine(
  label: string,
  count: number
): string {
  if (count <= 0) return `• ${label}: none`;
  return `• ${label}: ${count}`;
}
