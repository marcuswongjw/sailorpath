import type { MetadataRoute } from "next";

/**
 * Keep crawlers on public HTML. Admin, account, and API routes are dynamic
 * and would otherwise open database connections for bots.
 */
export default function robots(): MetadataRoute.Robots {
  return {
    rules: {
      userAgent: "*",
      allow: "/",
      disallow: [
        "/admin",
        "/api/",
        "/account",
        "/parent",
        "/coach-tools",
        "/following",
        "/claim-profile",
      ],
    },
    sitemap: "https://sailorpath.com/sitemap.xml",
  };
}
