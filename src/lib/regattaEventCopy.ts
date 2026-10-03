import type { RegattaEventDef } from "@/lib/regattaEvents";

/** Admin-saved paragraphs for the public event page. */
export type RegattaEventCopy = {
  scheduleSummary?: string | null;
  scoringRules?: string | null;
};

/**
 * Saved text replaces the built-in paragraph.
 * A blank saved value keeps the built-in wording.
 */
export function applyRegattaEventCopy(
  event: RegattaEventDef,
  saved: RegattaEventCopy | null | undefined
): RegattaEventDef {
  if (!saved) return event;
  const scheduleSummary = saved.scheduleSummary?.trim();
  const scoringRules = saved.scoringRules?.trim();
  return {
    ...event,
    scheduleSummary: scheduleSummary || event.scheduleSummary,
    scoringRules: scoringRules || event.scoringRules,
  };
}
