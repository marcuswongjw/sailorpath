import type { MetadataRoute } from "next";
import { db, getDatabaseUrlMeta, withDatabaseRetry } from "@/db";
import { sailors } from "@/db/schema";
import { getCachedPublicRegattas } from "@/lib/queries";
import {
  hubSitemapEntries,
  isIndexablePublicSailor,
  publicResultSheetPaths,
  resultSitemapEntries,
  sailorSitemapEntries,
} from "@/lib/publicSeo";

/**
 * The parts are /sitemap/hubs.xml, /sitemap/sailors.xml, and /sitemap/results.xml.
 * /sitemap.xml is the index served by src/app/sitemap.xml/route.ts, because
 * generateSitemaps does not replace that URL. robots.ts points at the index.
 *
 * Sailor profiles and result sheets used to be left out so generating the sitemap
 * would not scan the database. That was an operational limit. There is no
 * hide-profile, noindex, or family "restrict from Google" flag on sailors.
 * Search, rankings, and result sheets already link the same public profile URLs.
 *
 * Sailor entries are handles only. Reserved handles and a future hiddenFromSearch
 * flag stay out. Birth year and other personal fields are not selected. Personal
 * logbook regattas (slug prefix log-) and unpublished regattas stay out. When the
 * database is not configured, the sailor query is skipped and result sheets fall
 * back to the in-code event list.
 */
export const revalidate = 3600;

export async function generateSitemaps() {
  return [{ id: "hubs" }, { id: "sailors" }, { id: "results" }];
}

async function loadIndexableSailors(): Promise<Array<{ handle: string }>> {
  if (!getDatabaseUrlMeta()) return [];
  // A failed read must throw. An empty list would replace a previously
  // generated sailor sitemap during revalidation.
  const rows = await withDatabaseRetry(
    () => db.select({ handle: sailors.handle }).from(sailors),
    { label: "sitemap.sailors" }
  );
  return rows.filter((row) => isIndexablePublicSailor(row));
}

async function loadPublicResultSheetPaths(): Promise<string[]> {
  const staticPaths = publicResultSheetPaths();
  if (!getDatabaseUrlMeta()) return staticPaths;
  try {
    return publicResultSheetPaths(await getCachedPublicRegattas());
  } catch {
    return staticPaths;
  }
}

export default async function sitemap({
  id,
}: {
  id: Promise<string>;
}): Promise<MetadataRoute.Sitemap> {
  const key = await id;
  if (key === "sailors") return sailorSitemapEntries(await loadIndexableSailors());
  if (key === "results") return resultSitemapEntries(await loadPublicResultSheetPaths());
  return hubSitemapEntries();
}
