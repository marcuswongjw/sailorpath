import { NextResponse } from "next/server";

/**
 * generateSitemaps serves /sitemap/hubs.xml, /sitemap/sailors.xml, and
 * /sitemap/results.xml. It does not replace /sitemap.xml, which robots.txt
 * already advertises. This index keeps that address.
 */
const SITEMAPS = [
  "https://sailorpath.com/sitemap/hubs.xml",
  "https://sailorpath.com/sitemap/sailors.xml",
  "https://sailorpath.com/sitemap/results.xml",
];

export const dynamic = "force-static";

export function GET() {
  const body = `<?xml version="1.0" encoding="UTF-8"?>
<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${SITEMAPS.map((url) => `  <sitemap><loc>${url}</loc></sitemap>`).join("\n")}
</sitemapindex>
`;
  return new NextResponse(body, {
    headers: {
      "Content-Type": "application/xml; charset=utf-8",
      "Cache-Control": "public, max-age=3600, stale-while-revalidate=86400",
    },
  });
}
