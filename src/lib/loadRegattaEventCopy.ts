import { eq } from "drizzle-orm";
import { db } from "@/db";
import { regattaEvents } from "@/db/schema";
import { applyRegattaEventCopy } from "@/lib/regattaEventCopy";
import type { RegattaEventDef } from "@/lib/regattaEvents";

/** Load the same saved event description on event and class-result routes. */
export async function withSavedEventCopy(event: RegattaEventDef): Promise<RegattaEventDef> {
  try {
    const [saved] = await db
      .select({
        scheduleSummary: regattaEvents.scheduleSummary,
        scoringRules: regattaEvents.scoringRules,
      })
      .from(regattaEvents)
      .where(eq(regattaEvents.slug, event.slug))
      .limit(1);
    return applyRegattaEventCopy(event, saved);
  } catch {
    return event;
  }
}

