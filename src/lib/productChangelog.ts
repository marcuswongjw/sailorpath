/**
 * Curated product changelog (deploy-time).
 * Newest first. Used by Admin → Change log.
 */

export type ProductChangeArea =
  | "Homepage"
  | "Profile"
  | "Rankings"
  | "Admin"
  | "Search"
  | "UX"
  | "Privacy"
  | "Platform";

export type ProductAudience =
  | "public"
  | "sailor"
  | "parent"
  | "coach"
  | "admin";

export type ProductSeverity = "info" | "improvement" | "breaking";

export type ProductChangelogEntry = {
  /** Stable id — do not renumber; used for keys and unread identity */
  id: string;
  /** Stable anchor slug in Admin → Change log */
  slug: string;
  /** ISO date YYYY-MM-DD */
  date: string;
  title: string;
  summary: string;
  area: ProductChangeArea;
  audience: ProductAudience[];
  severity?: ProductSeverity;
  /** In-app path to verify the change */
  href?: string;
  ctaLabel?: string;
  commit?: string;
};

export const PRODUCT_CHANGELOG: ProductChangelogEntry[] = [
  {
    id: "2026-08-19-changelog-system",
    slug: "changelog-system",
    date: "2026-08-19",
    title: "Admin product and audit change logs",
    summary:
      "Admin Change log for product ships, Ops → Audit for mutation history, and an unread badge for admins.",
    area: "Platform",
    audience: ["admin"],
    severity: "improvement",
  },
  {
    id: "2026-08-18-audience-cards",
    slug: "audience-cards-restored",
    date: "2026-08-18",
    title: "Homepage audience cards restored; founding only at end",
    summary:
      "For Sailors / Parents / Coaches returns after the demo. Mid-page Founding block removed; full Founding Supporter card stays at the bottom.",
    area: "Homepage",
    audience: ["public", "sailor", "parent", "coach"],
    severity: "improvement",
    href: "/",
    ctaLabel: "Open homepage",
    commit: "efbf260",
  },
  {
    id: "2026-08-18-social-proof-pills",
    slug: "social-proof-pills-removed",
    date: "2026-08-18",
    title: "Removed social-proof pill strip",
    summary:
      "Dropped the pill strip above How SailorPath works to reduce noise on the conversion spine.",
    area: "Homepage",
    audience: ["public", "admin"],
    severity: "info",
    href: "/",
    ctaLabel: "Open homepage",
    commit: "4cd8a76",
  },
  {
    id: "2026-08-18-demo-sample",
    slug: "demo-sample-consistency",
    date: "2026-08-18",
    title: "Demo sailor sample consistency",
    summary:
      "Kimberly demo Best 3/5 math, series results, school name, and standing strip aligned with the results list.",
    area: "Profile",
    audience: ["public", "sailor", "parent", "coach"],
    severity: "improvement",
    href: "/sample",
    ctaLabel: "Open demo profile",
    commit: "97c69fb",
  },
  {
    id: "2026-08-18-ux-14-16",
    slug: "homepage-regatta-admin-polish",
    date: "2026-08-18",
    title: "Homepage, regatta headers, admin empty states",
    summary:
      "Public UX polish for homepage CTA/roadmap, shared RegattaEventHeader, and clearer admin empty states (#14–16).",
    area: "UX",
    audience: ["public", "sailor", "parent", "admin"],
    severity: "improvement",
    href: "/",
    ctaLabel: "Open homepage",
    commit: "be41a2b",
  },
  {
    id: "2026-08-18-rankings-ssr",
    slug: "faster-rankings-ssr",
    date: "2026-08-18",
    title: "Faster rankings SSR + loading skeletons",
    summary:
      "Async Optimist drop stamps and page-shaped loading skeletons so rankings boards feel snappier.",
    area: "Rankings",
    audience: ["public", "sailor", "parent", "coach"],
    severity: "improvement",
    href: "/sg/optimist/gold",
    ctaLabel: "Open Gold standings",
    commit: "03ba450",
  },
  {
    id: "2026-08-18-nationality-search",
    slug: "nationality-shortlist",
    date: "2026-08-18",
    title: "Nationality shortlist + denser mobile rankings",
    summary:
      "Search nationality combobox with shortlist; tighter mobile rankings layout.",
    area: "Search",
    audience: ["public", "sailor", "parent", "coach"],
    severity: "improvement",
    href: "/sg/optimist/gold",
    ctaLabel: "Open rankings",
    commit: "951c53e",
  },
  {
    id: "2026-08-18-profile-empty",
    slug: "profile-empty-states",
    date: "2026-08-18",
    title: "Profile empty states and privacy note",
    summary:
      "Single claim CTA, trend placeholder, and equipment privacy note when sections are empty.",
    area: "Profile",
    audience: ["sailor", "parent", "public"],
    severity: "improvement",
    href: "/sample",
    ctaLabel: "Open demo profile",
    commit: "eb60b28",
  },
  {
    id: "2026-08-18-journey-cfdns",
    slug: "journey-badge-cf-dns",
    date: "2026-08-18",
    title: "Journey milestone badge; CF/DNS under hero rank",
    summary:
      "Space journey milestone on profile; clearer carry-forward / DNS explanation under the hero rank.",
    area: "Profile",
    audience: ["sailor", "parent", "public"],
    severity: "improvement",
    href: "/sample",
    ctaLabel: "Open demo profile",
    commit: "62997da",
  },
  {
    id: "2026-08-18-gender-audit",
    slug: "admin-gender-audit",
    date: "2026-08-18",
    title: "Admin gender audit; no blank→M default",
    summary:
      "Ops gender audit panel for data quality. Blank gender no longer defaults to Male on admin save.",
    area: "Admin",
    audience: ["admin"],
    severity: "breaking",
    href: "/admin?tab=edit&sub=sailors",
    ctaLabel: "Open Sailors",
    commit: "c445182",
  },
  {
    id: "2026-08-18-gender-mf",
    slug: "strict-gender-codes",
    date: "2026-08-18",
    title: "Strict M/F gender codes on rankings",
    summary:
      "Gender normalize to exact M|F only — fixes rankings filter and display for edge values.",
    area: "Rankings",
    audience: ["public", "sailor", "parent", "coach", "admin"],
    severity: "breaking",
    href: "/sg/optimist/gold",
    ctaLabel: "Open rankings",
    commit: "eb6b36d",
  },
  {
    id: "2026-08-18-silver-drop",
    slug: "silver-inactivity-eligibility",
    date: "2026-08-18",
    title: "Silver inactivity dropDate + half eligibility",
    summary:
      "Stamp Optimist dropDate when Silver sailors miss a full half; eligibility uses previous or current half starts; Silver-only drop if no Optimist start in the last year.",
    area: "Rankings",
    audience: ["public", "sailor", "parent", "coach", "admin"],
    severity: "breaking",
    href: "/sg/optimist/silver",
    ctaLabel: "Open Silver standings",
    commit: "7940b66",
  },
  {
    id: "2026-08-18-series-dns",
    slug: "series-dns-on-profile",
    date: "2026-08-18",
    title: "Series DNS on profile Results and trend",
    summary:
      "List series DNS in Results, clarify standing strip, include DNS on position trend; Silver-only key stats.",
    area: "Profile",
    audience: ["sailor", "parent", "public"],
    severity: "improvement",
    href: "/sample",
    ctaLabel: "Open demo profile",
    commit: "6b8d689",
  },
  {
    id: "2026-08-17-profile-p0-p1",
    slug: "profile-p0-p1",
    date: "2026-08-17",
    title: "Profile P0/P1 polish",
    summary:
      "Hero pulse, Best 3/5 legend, Gold/All filter, compact passport, tenure, and public preview improvements.",
    area: "Profile",
    audience: ["sailor", "parent", "public"],
    severity: "improvement",
    href: "/sample",
    ctaLabel: "Open demo profile",
    commit: "11a93fb",
  },
  {
    id: "2026-08-17-ux-sprints",
    slug: "ux-sprints-a-e",
    date: "2026-08-17",
    title: "UX sprints A–E + homepage conversion spine",
    summary:
      "Nav Claim/Rankings, click menus, equipment a11y and lock polish, DOB/equipment privacy copy, homepage conversion spine.",
    area: "UX",
    audience: ["public", "sailor", "parent", "coach"],
    severity: "improvement",
    href: "/",
    ctaLabel: "Open homepage",
    commit: "9c76f04",
  },
  {
    id: "2026-08-17-admin-ux",
    slug: "admin-ux-u1-u8",
    date: "2026-08-17",
    title: "Admin UX U1–U8",
    summary:
      "Ops split from Database with URL sync, searchable Results picker, richer destructive confirms, Selection under Database, guest sign-in gate, shared BrandMark.",
    area: "Admin",
    audience: ["admin"],
    severity: "improvement",
    href: "/admin?tab=ops&sub=claims",
    ctaLabel: "Open Ops",
    commit: "fb86508",
  },
  {
    id: "2026-08-16-admin-stats",
    slug: "lean-admin-stats",
    date: "2026-08-16",
    title: "Lean admin Stats tab",
    summary:
      "Live COUNT cards via GET /api/admin/stats; Metrics guide remains the definitions playbook.",
    area: "Admin",
    audience: ["admin"],
    severity: "info",
    href: "/admin?tab=stats",
    ctaLabel: "Open Stats",
    commit: "9f04934",
  },
];

/** Newest product entry date as Date (noon UTC). */
export function getLatestProductChangelogAt(): Date {
  let latest = "1970-01-01";
  for (const e of PRODUCT_CHANGELOG) {
    if (e.date > latest) latest = e.date;
  }
  return new Date(`${latest}T12:00:00.000Z`);
}

export function isProductChangelogUnread(
  lastSeen: Date | string | null | undefined
): boolean {
  if (!lastSeen) return PRODUCT_CHANGELOG.length > 0;
  const seen =
    lastSeen instanceof Date ? lastSeen : new Date(lastSeen);
  if (Number.isNaN(seen.getTime())) return true;
  return getLatestProductChangelogAt().getTime() > seen.getTime();
}
