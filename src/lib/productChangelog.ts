/**
 * Curated product / ops change log for the admin console.
 * Newest first. Keep entries concise — this is for admins, not marketing.
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

export type ProductChangelogEntry = {
  /** ISO date YYYY-MM-DD */
  date: string;
  title: string;
  summary: string;
  area: ProductChangeArea;
  /** Optional git short SHA when known */
  commit?: string;
};

export const PRODUCT_CHANGELOG: ProductChangelogEntry[] = [
  {
    date: "2026-08-18",
    title: "Homepage audience cards restored; founding only at end",
    summary:
      "For Sailors / Parents / Coaches returns after the demo. Mid-page Founding block removed; full Founding Supporter card stays at the bottom.",
    area: "Homepage",
    commit: "efbf260",
  },
  {
    date: "2026-08-18",
    title: "Removed social-proof pill strip",
    summary:
      "Dropped the pill strip above How SailorPath works to reduce noise on the conversion spine.",
    area: "Homepage",
    commit: "4cd8a76",
  },
  {
    date: "2026-08-18",
    title: "Demo sailor sample consistency",
    summary:
      "Kimberly demo Best 3/5 math, series results, school name, and standing strip aligned with the results list.",
    area: "Profile",
    commit: "97c69fb",
  },
  {
    date: "2026-08-18",
    title: "Homepage, regatta headers, admin empty states",
    summary:
      "Public UX polish for homepage CTA/roadmap, shared RegattaEventHeader, and clearer admin empty states (#14–16).",
    area: "UX",
    commit: "be41a2b",
  },
  {
    date: "2026-08-18",
    title: "Faster rankings SSR + loading skeletons",
    summary:
      "Async Optimist drop stamps and page-shaped loading skeletons so rankings boards feel snappier.",
    area: "Rankings",
    commit: "03ba450",
  },
  {
    date: "2026-08-18",
    title: "Nationality shortlist + denser mobile rankings",
    summary:
      "Search nationality combobox with shortlist; tighter mobile rankings layout.",
    area: "Search",
    commit: "951c53e",
  },
  {
    date: "2026-08-18",
    title: "Profile empty states and privacy note",
    summary:
      "Single claim CTA, trend placeholder, and equipment privacy note when sections are empty.",
    area: "Profile",
    commit: "eb60b28",
  },
  {
    date: "2026-08-18",
    title: "Journey milestone badge; CF/DNS under hero rank",
    summary:
      "Space journey milestone on profile; clearer carry-forward / DNS explanation under the hero rank.",
    area: "Profile",
    commit: "62997da",
  },
  {
    date: "2026-08-18",
    title: "Admin gender audit; no blank→M default",
    summary:
      "Ops gender audit panel for data quality. Blank gender no longer defaults to Male on admin save.",
    area: "Admin",
    commit: "c445182",
  },
  {
    date: "2026-08-18",
    title: "Strict M/F gender codes on rankings",
    summary:
      "Gender normalize to exact M|F only — fixes rankings filter and display for edge values.",
    area: "Rankings",
    commit: "eb6b36d",
  },
  {
    date: "2026-08-18",
    title: "Silver inactivity dropDate + half eligibility",
    summary:
      "Stamp Optimist dropDate when Silver sailors miss a full half; eligibility uses previous or current half starts; Silver-only drop if no Optimist start in the last year.",
    area: "Rankings",
    commit: "7940b66",
  },
  {
    date: "2026-08-18",
    title: "Series DNS on profile Results and trend",
    summary:
      "List series DNS in Results, clarify standing strip, include DNS on position trend; Silver-only key stats.",
    area: "Profile",
    commit: "6b8d689",
  },
  {
    date: "2026-08-17",
    title: "Profile P0/P1 polish",
    summary:
      "Hero pulse, Best 3/5 legend, Gold/All filter, compact passport, tenure, and public preview improvements.",
    area: "Profile",
    commit: "11a93fb",
  },
  {
    date: "2026-08-17",
    title: "UX sprints A–E + homepage conversion spine",
    summary:
      "Nav Claim/Rankings, click menus, equipment a11y and lock polish, DOB/equipment privacy copy, homepage conversion spine.",
    area: "UX",
    commit: "9c76f04",
  },
  {
    date: "2026-08-17",
    title: "Admin UX U1–U8",
    summary:
      "Ops split from Database with URL sync, searchable Results picker, richer destructive confirms, Selection under Database, guest sign-in gate, shared BrandMark.",
    area: "Admin",
    commit: "fb86508",
  },
  {
    date: "2026-08-16",
    title: "Lean admin Stats tab",
    summary:
      "Live COUNT cards via GET /api/admin/stats; Metrics guide remains the definitions playbook.",
    area: "Admin",
    commit: "9f04934",
  },
];
