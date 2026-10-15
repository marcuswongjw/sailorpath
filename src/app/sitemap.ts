import type { MetadataRoute } from "next";

/**
 * Static hub list. Sailor profiles and regatta sheets are not enumerated here,
 * so generating the sitemap does not scan the database.
 */
const PATHS = [
  "/",
  "/results",
  "/rankings",
  "/calendar",
  "/sailors",
  "/classes/x-15",
  "/news",
  "/sg/optimist/gold",
  "/sg/optimist/silver",
  "/sg/optimist/selection",
  "/sg/ilca4",
  "/sg/ilca6",
  "/sg/ilca7",
  "/sg/wingfoil",
  "/sg/techno293",
  "/sg/iqfoil",
] as const;

export default function sitemap(): MetadataRoute.Sitemap {
  return PATHS.map((path) => ({
    url: `https://sailorpath.com${path}`,
    changeFrequency: "daily" as const,
  }));
}
