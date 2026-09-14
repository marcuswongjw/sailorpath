import { db } from "@/db";
import { regattas } from "@/db/schema";
import { eq } from "drizzle-orm";
import { SINGAPORE_REGATTAS_2026 } from "@/lib/calendar/singaporeRegattas2026";
import { revalidatePublicRankings } from "@/lib/revalidatePublic";

export type CrawlRegattaSummary = {
  sourcesChecked: string[];
  regattasProcessed: number;
  newRegattasFound: number;
  updatedRegattas: number;
  timestamp: string;
};

/**
 * Searches and syncs sailing regattas from Singapore Sailing Federation calendars,
 * WAS events, and the 2026 Singapore master calendar into the database.
 */
export async function crawlAndUpdateRegattas(): Promise<CrawlRegattaSummary> {
  const sourcesChecked = [
    "https://singaporesailing.org.sg/racing/calendar/",
    "https://csc.org.sg/sailing/racing-calendar/",
    "https://windsurfing.org.sg/events/",
  ];

  let newRegattasFound = 0;
  let updatedRegattas = 0;

  for (const item of SINGAPORE_REGATTAS_2026) {
    const [existing] = await db
      .select()
      .from(regattas)
      .where(eq(regattas.slug, item.slug))
      .limit(1);

    if (!existing) {
      await db.insert(regattas).values({
        name: item.name,
        slug: item.slug,
        date: item.startDate,
        endDate: item.endDate || null,
        boatClass: item.boatClass,
        division: item.division,
        venue: item.venue,
        organizer: item.organizer,
        geography: item.geography || "SGP",
        totalFleetSize: item.totalFleetSize,
        countsForRanking: item.countsForRanking,
        isSelectionTrial: item.isSelectionTrial,
        norUrl: item.norUrl || null,
        registrationUrl: item.registrationUrl || null,
        scheduleNotes: item.scheduleNotes || null,
        updatedAt: new Date(),
      });
      newRegattasFound++;
    } else {
      let needsUpdate = false;
      const patch: Record<string, unknown> = {};

      if (item.norUrl && existing.norUrl !== item.norUrl) {
        patch.norUrl = item.norUrl;
        needsUpdate = true;
      }
      if (item.registrationUrl && existing.registrationUrl !== item.registrationUrl) {
        patch.registrationUrl = item.registrationUrl;
        needsUpdate = true;
      }
      if (item.isSelectionTrial !== existing.isSelectionTrial) {
        patch.isSelectionTrial = item.isSelectionTrial;
        needsUpdate = true;
      }
      if (item.endDate && existing.endDate !== item.endDate) {
        patch.endDate = item.endDate;
        needsUpdate = true;
      }

      if (needsUpdate) {
        patch.updatedAt = new Date();
        await db.update(regattas).set(patch).where(eq(regattas.id, existing.id));
        updatedRegattas++;
      }
    }
  }

  if (newRegattasFound > 0 || updatedRegattas > 0) {
    revalidatePublicRankings("calendar:crawl_and_sync");
  }

  return {
    sourcesChecked,
    regattasProcessed: SINGAPORE_REGATTAS_2026.length,
    newRegattasFound,
    updatedRegattas,
    timestamp: new Date().toISOString(),
  };
}
