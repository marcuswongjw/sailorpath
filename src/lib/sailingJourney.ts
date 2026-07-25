/**
 * Parse / serialize owner sailing journey highlights.
 */

export type JourneyHighlight = {
  id: string;
  when: string;
  title: string;
  detail: string;
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
  if (!items.length) return null;
  return JSON.stringify(
    items.slice(0, 40).map((it) => ({
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
