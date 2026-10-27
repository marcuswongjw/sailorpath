import { cache } from "react";
import { getDatabaseUrlMeta } from "@/db";
import { isAnyIlcaClass } from "@/lib/ilcaRanking";
import {
  getCachedPublicRegattas,
  getCachedSailorByHandle,
  getRegattaBySlug,
  getResultsForRegatta,
  getCachedResultsForSailor,
} from "@/lib/queries";
import type { RegattaRecord } from "@/lib/ranking";
import {
  groupedHubForSlug,
  hubHrefForClassSlug,
  savedEventHubForSlug,
  withPublishedEventSlices,
} from "@/lib/regattaEventGroups";
import {
  getRegattaEvent,
  sliceMatchesRegattaSlug,
  resolveEventSlices,
  type RegattaEventDef,
} from "@/lib/regattaEvents";
import {
  canonicalPathFromHubHref,
  isPersonalLogSlug,
  resultSheetFromEventSlice,
  resultSheetFromRegatta,
  topFinishers,
  type PodiumFinish,
  type ResultSheetShare,
} from "@/lib/publicSeo";

export const loadShareSailor = cache((handle: string) => getCachedSailorByHandle(handle));

export const loadShareSailorResults = cache((sailorId: string) => getCachedResultsForSailor(sailorId));

export const loadPublishedRegattaBySlug = cache((slug: string) => getRegattaBySlug(slug));

export const loadPublishedResults = cache((regattaId: string) => getResultsForRegatta(regattaId));

export const resolveFleetResultSheet = cache(
  async (
    regattaSlug: string,
    fleet: string
  ): Promise<{ event: RegattaEventDef; sheet: ResultSheetShare } | null> => {
    const direct = getRegattaEvent(regattaSlug);
    let published: RegattaRecord[] = [];
    if (getDatabaseUrlMeta()) {
      published = await getCachedPublicRegattas().catch(() => []);
    }
    const grouped = direct
      ? null
      : savedEventHubForSlug(regattaSlug, published) || groupedHubForSlug(regattaSlug, published);
    const event = direct ? withPublishedEventSlices(direct, published) : grouped?.event || null;
    if (!event) return null;
    let slice = event.slices.find((item) => item.key === fleet);
    // Old Class A/B hubs shared the classless Optimist URL. Preserve the
    // sheet that URL previously selected while giving each fleet its own URL.
    if (!slice && fleet === "optimist") {
      const legacy = resolveEventSlices(event, published)
        .filter((item) => ["optimist-class-a", "optimist-class-b"].includes(item.def.key) && item.regatta)
        .sort((a, b) => ((b.regatta!.raceCount || 0) - (a.regatta!.raceCount || 0))
          || b.regatta!.totalFleetSize - a.regatta!.totalFleetSize)[0];
      slice = legacy?.def;
    }
    if (!slice) return null;

    let top3: PodiumFinish[] = [];
    if (getDatabaseUrlMeta()) {
      try {
        const regattas = published.length ? published : await getCachedPublicRegattas();
        const match = regattas.find(
          (regatta) =>
            !isPersonalLogSlug(regatta.slug) && sliceMatchesRegattaSlug(slice, regatta.slug)
        );
        if (match) top3 = topFinishers(await loadPublishedResults(match.id));
      } catch {
        top3 = [];
      }
    }
    return { event, sheet: resultSheetFromEventSlice(event, slice, top3) };
  }
);

export type ScorecardLoad =
  | { status: "ready"; sheet: ResultSheetShare }
  | { status: "missing" }
  | { status: "unavailable" };

export const resolveClassScorecard = cache(
  async (slug: string, family: "optimist" | "ilca"): Promise<ScorecardLoad> => {
    const published = getDatabaseUrlMeta()
      ? await getCachedPublicRegattas().catch(() => [])
      : [];
    const hubHref = hubHrefForClassSlug(slug, published);
    const canonical = hubHref ? canonicalPathFromHubHref(hubHref) : null;
    const fleetMatch = canonical?.match(/^\/regattas\/([^/]+)\/results\/([^/]+)$/);
    if (fleetMatch) {
      const resolved = await resolveFleetResultSheet(
        decodeURIComponent(fleetMatch[1]),
        decodeURIComponent(fleetMatch[2])
      );
      if (resolved) return { status: "ready", sheet: resolved.sheet };
    }
    if (!getDatabaseUrlMeta()) return { status: "unavailable" };
    try {
      const regatta = await loadPublishedRegattaBySlug(slug);
      if (!regatta) return { status: "missing" };
      if (family === "ilca" && !isAnyIlcaClass(regatta.boatClass)) return { status: "missing" };
      const results = await loadPublishedResults(regatta.id).catch(() => []);
      return {
        status: "ready",
        sheet: resultSheetFromRegatta({
          name: regatta.name,
          boatClass: regatta.boatClass,
          division: regatta.division,
          date: regatta.date,
          endDate: regatta.endDate,
          venue: regatta.venue,
          organizer: regatta.organizer,
          canonicalPath:
            family === "ilca"
              ? `/sg/ilca/regattas/${encodeURIComponent(regatta.slug)}`
              : `/sg/optimist/regattas/${encodeURIComponent(regatta.slug)}`,
          top3: topFinishers(results),
        }),
      };
    } catch {
      return { status: "unavailable" };
    }
  }
);
