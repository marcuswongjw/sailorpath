export const EDITORIAL_KINDS = [
  "result_report",
  "correction",
  "class_announcement",
  "product_update",
  "partner_update",
] as const;

export const EDITORIAL_STATUSES = [
  "draft",
  "in_review",
  "published",
  "archived",
] as const;

export const EDITORIAL_ACTIONS = [
  "save_draft",
  "submit_review",
  "publish",
  "archive",
] as const;

export type EditorialKind = (typeof EDITORIAL_KINDS)[number];
export type EditorialStatus = (typeof EDITORIAL_STATUSES)[number];
export type EditorialAction = (typeof EDITORIAL_ACTIONS)[number];

export type EditorialFields = {
  slug: string;
  kind: EditorialKind;
  title: string;
  summary: string;
  body: string;
  authorDisplayName: string;
  relatedClass: string | null;
  relatedRegion: string | null;
  sourceUrl: string | null;
  sourceLabel: string | null;
  tags: string[];
};

export type SeededEditorialDraft = EditorialFields & {
  id: string;
  status: EditorialStatus;
  createdAt: Date;
};

export const ASIAN_OPTIMIST_INDEX_DRAFT_BODY = `Youth sailors across Asia and Oceania compete in an active calendar of national championships, regional international opens, and IODA championships—yet following form across borders between major events has historically been difficult.

Ahead of the 2026 IODA Asian & Oceanian Championship in Colombo (12–19 December 2026), we are publishing the methodology for the SailorPath Asian and Oceania Optimist Index (V1 Beta) along with our initial Grade 75 and Grade 40 Event Register, and opening a community consultation window to nominate and confirm qualifying regattas across Asia and Oceania.

Independence & Governance Note: The SailorPath Asian and Oceania Optimist Index is an independent, source-backed analytical index published by SailorPath. It is not an official IODA or national federation ranking, and it must not be used as a team-selection tool. Event organisers, juries, and national authorities remain the sole authority for official regatta results.

## Who Is Ranked

A sailor appears in the current Index when:
• Their current verified sporting representation is an eligible Asian or Oceanian Member National Authority (MNA), including regional competitors from Australia, New Zealand, and across East, South, Southeast, Central, and West Asia.
• They meet the calendar-year age rule: eligible through 31 December of the calendar year in which they turn 15, leaving the current Index on 1 January of the following year.
• They have at least one verified, positive-point result within the rolling 12-month window.

To preserve the historical record of senior sailors before they age out, SailorPath publishes an official permanent year-end snapshot on 31 December each season.

## Event Grades and Host Rules

The Index groups competitions into four distinct tiers:

• Grade 150 — Championship Anchors (Max 2 results counted, at most 1 World Championship): The IODA World Championship and official IODA continental championships, wherever held. Requires an official final individual classification with at least 5 completed races. Equalizing both championships at Grade 150 gives full credit to standout World Championship performances while maintaining continental championships as core regional benchmarks.

• Grade 75 — Designated Major International Opens (Max 2 results, at most 1 per host country): Pre-designated major international Optimist regattas in Asia and Oceania. Requires published advance evidence of at least 50 registered sailors from at least 4 verified MNAs, confirmed post-race by at least 40 valid starters from at least 4 MNAs and 4 completed races. A limited number of premier non-regional opens (such as Lake Garda) may be designated by published exception.

• Grade 40 — Designated National Championships (Max 2 results, at most 1 per host country per calendar year): Pre-designated premier national championships hosted in Asia and Oceania by the relevant national class association or sailing authority. Requires an open final classification with at least 30 valid starters and 4 completed races.

• Grade 0 — Verified Competition History (Unscored): Club regattas, clinics, team racing, development fleets, non-regional national championships, and events failing minimum gates remain visible on sailor profiles as verified competition history without scoring Index points.

## The Six Selection Limits

A sailor’s Index score is the optimal combination of their best eligible results subject to six strict rules:
1. At most five results overall.
2. At most two Grade 150 results.
3. At most one World Championship result.
4. At most four Grade 150 and Grade 75 results combined.
5. At most one Grade 75 result per host country.
6. At most one Grade 40 result per host country per calendar year.

There are no mandatory grade quotas. Unused higher-grade slots can be filled by lower-grade results. A sailor without access to Worlds can count up to four Grade 75 results and one Grade 40 result (or five Grade 40 results from distinct countries).

## Scoring Formula & Audit Trail

Points are calculated directly from official final finishing places:

Points = E × (N − P + 1) / N

Here, E is the Event Grade (150, 75, or 40), N is the number of valid starters in the scored classification, and P is the sailor’s Index place among valid starters. First place earns E points, and last place earns E / N. Unresolved official ties receive the average of their occupied positions. Every result expires 12 months after its final race day, with no 24-month carryover.

Every scored result links directly to a public ledger showing the source URL, publication timestamp, starter count (N), completed races, official place, Index place, and points contribution. Results are matched to athletes using verified sporting identities, never sail numbers alone.

## Initial 2026–27 Event Register (Beta)

### Grade 150 — Championship Anchors
• 2025 IODA Asian & Oceanian Championship (Mussanah, Oman · N = 170 · 7 races — Baseline cohort)
• 2026 IODA World Championship (Tangier, Morocco · N = 284 · 12 races — Verified)
• 2026 IODA Asian & Oceanian Championship (Colombo, Sri Lanka · 12–19 December 2026 — Becomes active once official final classification is confirmed)

### Grade 75 & Grade 40 — Regional Slate
• Malaysia (MAS): Grade 75 candidates include the 22nd LIRP 2026 (Gold, N = 59, 12 races) and 5th LIYSC 2026 (Gold, N = 50, 10 races). Only a sailor's better Malaysian Grade 75 result counts. Grade 40 candidate: MSA–NSC–MILO National Open (Overall/U16).
• Thailand (THA): Grade 75 candidates include the Thailand International Sailing Championships (Sattahip, N = 65, 12 races) and scheduled candidates Eastern Seaboard Regatta and Phuket King's Cup. Grade 40 candidate: Thailand National Sailing Championship.
• Singapore (SGP): Grade 75 candidate: Singapore Youth Sailing Championships (SYSC Gold, N = 106, 11 races). Grade 40 candidate: Singapore National Sailing Championships (SNSC Gold, N = 83, 9 races).
• Hong Kong (HKG): Grade 75 candidate: Hong Kong Race Week (Optimist Main, N = 77, 9 races). Grade 40: HKG Optimist National Championship (open for nomination).
• West Asia / GCC (OMA / UAE): Grade 75 candidate: Mussanah Race Week (open for nomination). Grade 40: UAE and Oman National Championships (open for nomination).
• Australia & New Zealand (AUS / NZL): Grade 40: Australian and New Zealand National Championships (open for nomination).

## Open Call: Nominate or Confirm Regattas for 2026–27

To maintain fairness and transparency, all regattas must be designated in advance of racing—grades are never assigned retroactively based on who won.

We invite national class associations, sailing federations, host clubs, coaches, and parents across Asia and Oceania to help finalize the 2026–27 Event Register:
• Confirm nominations for initial hubs: feedback on open slots in Singapore, Thailand, Malaysia, Hong Kong, Australia, New Zealand, and the Gulf.
• Nominate additional hubs: we welcome nominations for premier national championships and international opens from India, Japan, China, Chinese Taipei, Sri Lanka, Myanmar, Indonesia, the Philippines, and Korea.

Please review the full technical specification at /optimist/asian-index/methodology and explore the live standings at /optimist/asian-index.`;

export const ASIAN_OPTIMIST_INDEX_HOW_IT_SCORES_DRAFT_BODY = `Rankings in youth sailing often face a difficult trade-off: either they only count a single annual championship, or they reward the families with the budget to travel to ten regattas a year.

The SailorPath Asian and Oceania Optimist Index (V1 Beta) is designed around a different principle: measure finishing quality in deep, verified fleets while putting strict structural caps on the advantage of excessive travel.

Here is a transparent breakdown of how the scoring mechanics, country caps, and result selection work under the hood.

## The Formula: Rewarding Every Verified Finish

For every eligible competition, points are calculated using a linear fleet scale:

Points = E × (N − P + 1) / N

• E is the Event Grade: 150 for IODA Championships, 75 for designated Major International Opens, and 40 for recognized National Championships.
• N is the number of valid starters in the designated primary competition—sailors who crossed the starting line in at least one race.
• P is the sailor’s finish position among valid starters.

Why valid starters instead of entry lists? If an event has 100 entries but 15 sailors never attend or start a race, inflating the denominator with phantom boats distorts the real competitive depth. SailorPath compresses finish positions after removing non-starters so every place is earned on the water.

What about ties? When an official final classification leaves an unresolved tie between competitors, SailorPath averages their occupied positions (for example, two sailors tied across 10th and 11th each receive P = 10.5) rather than relying on arbitrary alphabetical tie-breakers.

Last place still counts: even the final classified starter earns a small positive fraction (E / N). A difficult week at a World Championship (Grade 150) or deep International Open (Grade 75) remains a positive credit on a sailor's record.

## The Six Caps: Why Travel Alone Does Not Buy Rank

Each sailor's Index score is calculated from their best five eligible results in the preceding 12 months, governed by six limits:

1. At most five results overall.
2. At most two Grade 150 results (and at most one World Championship result).
3. At most four Grade 150 and Grade 75 results combined.
4. At most one Grade 75 result per host country.
5. At most one Grade 40 result per host country per calendar year.
6. Mathematical optimal selection: SailorPath evaluates complete combinations to find the highest total points, rather than forcing higher grades first.

The host-country cap is essential. If Malaysia hosts both LIRP and LIYSC at Grade 75, a sailor who competes in both can only count their single best finish toward their Index score. This prevents sailors from stacking multiple top scores solely by sailing on their home waters or attending repeated opens in one country.

## Lower Grades Can Beat Weak Higher Grades

Because SailorPath tests complete combinations, a higher-grade result never traps a sailor in an artificially low score.

Consider a sailor who scores:
• Grade 150 Worlds: 120.00 points
• Grade 150 Europeans: 10.00 points (difficult regatta or equipment damage)
• Grade 75 Open A: 70.00 points
• Grade 75 Open B: 60.00 points
• Grade 40 Nationals A: 40.00 points
• Grade 40 Nationals B: 35.00 points

Rather than forcing the weak 10-point Grade 150 result into the score, the system selects: 120.00 + 70.00 + 60.00 + 40.00 + 35.00 = 325.00 points.

Similarly, a sailor who does not attend the World Championship is never penalized with a zero. A sailor counting four Grade 75 opens and one Grade 40 national championship can achieve over 288 points—a strong, competitive regional total.

## Two-Stage Designation: Advance Criteria vs. Post-Race Gates

To keep the Index completely objective, event grading is divided into two strict stages:

1. Advance Designation: Before racing starts, an event must be pre-designated with its grade and primary classification. For Grade 75, the Notice of Race and entry statistics must show at least 50 registered sailors representing at least 4 verified MNAs. We never designate or upgrade an event after seeing who won.
2. Post-Race Confirmation: Once racing concludes, official result sheets are verified against minimum gates (Grade 150: 5 races; Grade 75: 40 starters, 4 MNAs, 4 races; Grade 40: 30 starters, 4 races). If an event fails its gates, it is not downgraded on the fly; it remains unscored with the failure reason publicly documented.

## Expiry and the Year-End Cohort

Every result expires exactly 12 calendar months after the final race day. There are no 24-month legacy carryovers, reflecting the fast development curve of Optimist sailors.

On 31 December each year, SailorPath archives a permanent final year-end Index snapshot. On 1 January, sailors who turned 15 during the preceding year age out of the active Index, keeping their complete competition history and year-end rank permanently intact.

For full details, read our complete technical specification at /optimist/asian-index/methodology and explore the live standings at /optimist/asian-index.`;

export const SEEDED_EDITORIAL_DRAFTS: readonly SeededEditorialDraft[] = [
  {
    id: "b6e8c910-4f2a-4d3b-9c1e-202611010001",
    slug: "asian-optimist-index-beta-methodology-and-event-register",
    status: "draft",
    kind: "class_announcement",
    title:
      "Introducing the SailorPath Asian and Oceania Optimist Index (V1 Beta): Methodology & 2026–27 Event Register",
    summary:
      "SailorPath introduces the Asian and Oceania Optimist Index (V1 Beta) for youth sailors representing eligible Asian and Oceanian MNAs: balanced Grade 150/75/40 event tiers, published criteria for major opens, strict country caps, a rolling 12-month window, and the initial 2026–27 event register.",
    body: ASIAN_OPTIMIST_INDEX_DRAFT_BODY,
    authorDisplayName: "SailorPath",
    relatedClass: "Optimist",
    relatedRegion: "Asia",
    sourceUrl: "https://sailorpath.com/optimist/asian-index",
    sourceLabel: "SailorPath Asian and Oceania Optimist Index",
    tags: ["optimist", "asian-index", "oceania", "methodology", "event-register"],
    createdAt: new Date("2026-10-18T04:00:00.000Z"),
  },
  {
    id: "c7f9d021-5a3b-4e4c-8d2f-202611010002",
    slug: "how-the-asian-optimist-index-scores-regattas",
    status: "draft",
    kind: "product_update",
    title:
      "How the SailorPath Asian and Oceania Optimist Index Scores Regattas: Grades, Country Caps, and Fair Selection",
    summary:
      "A deep dive into the scoring mechanics of the SailorPath Asian and Oceania Optimist Index (V1 Beta): why attendance alone does not buy rank, how the six caps ensure regional balance, how starter adjustments and ties are handled, and how optimal combination selection works.",
    body: ASIAN_OPTIMIST_INDEX_HOW_IT_SCORES_DRAFT_BODY,
    authorDisplayName: "SailorPath",
    relatedClass: "Optimist",
    relatedRegion: "Asia",
    sourceUrl: "https://sailorpath.com/optimist/asian-index/methodology",
    sourceLabel: "Asian & Oceania Optimist Index Methodology",
    tags: ["optimist", "asian-index", "oceania", "scoring", "methodology", "analysis"],
    createdAt: new Date("2026-10-18T05:00:00.000Z"),
  },
  {
    id: "d8a0e132-6b4c-4f5d-9e3a-202610220003",
    slug: "2026-asian-games-and-youth-worlds-coverage",
    status: "published",
    kind: "result_report",
    title:
      "20th Asian Games 2026 Sailing Standings and Youth World Championship Results Added",
    summary:
      "SailorPath adds verified overall standings from the 20th Asian Games in Gamagori across five classes, alongside race-by-race scorecards from the 2026 ILCA 4 Youth World Championships and regional Asian Cup regattas.",
    body: `SailorPath has expanded its international championship archive with official standings from the 20th Asian Games 2026 in Gamagori, Japan, alongside full race-by-race scorecards from recent youth world and regional championships.

## 20th Asian Games 2026 (Kaiyoh Yacht Harbor, Japan)

Overall standings, final ranks, net scores, and medal outcomes from racing at Kaiyoh Yacht Harbor (26 September – 3 October 2026) are now live across five classes:

• ILCA 4 (Men's and Women's divisions)
• ILCA 6
• ILCA 7
• 29er (including full helm and crew participant attribution)
• iQFOiL

Source and verification note: Overall standings, final ranks, and net totals have been corroborated across official Asian Games Organising Committee (AINAGOC), Asian Sailing Federation (ASAF), World Sailing, and national federation releases. Individual race-by-race scores for the Asian Games sheets remain deferred pending release of the consolidated official final race-by-race PDF and are not marked as PDF-verified.

## 2026 ILCA 4 Youth Worlds and Regional ILCA Coverage

Alongside the Asian Games standings, we have published complete race-by-race scorecards and updated demographic records across key international and regional youth fleets:

• 2026 ILCA 4 Youth World Championships
• 2026 ILCA Asian Cup (Penghu)
• East and West Japan Optimist Championships and JODA National Team Final Selection Trials

Each imported scorecard links directly to its source attribution and updates the career histories and international prize records of participating sailors.`,
    authorDisplayName: "SailorPath",
    relatedClass: "ILCA 4",
    relatedRegion: "Asia",
    sourceUrl: "https://sailorpath.com/results",
    sourceLabel: "Browse published championship scorecards",
    tags: ["asian-games", "ilca-4", "ilca-6", "ilca-7", "29er", "iqfoil", "results"],
    createdAt: new Date("2026-10-22T01:00:00.000Z"),
  },
  {
    id: "e9b1f243-7c5d-4a6e-8f4b-202610270004",
    slug: "privacy-first-profiles-guardian-consent-and-evidence-protections",
    status: "published",
    kind: "product_update",
    title:
      "Strengthening Youth Sailor Privacy: Consent-Gated Photos, Private Evidence, and Claim Protections",
    summary:
      "How SailorPath protects youth athletes by keeping public profiles strictly focused on verified competition records while gating photos, personal notes, and uploaded evidence behind approved claims and guardian consent.",
    body: `Because youth sailing records involve minor athletes, SailorPath is built around a strict separation between the public competition record and private athlete or family data. Over the past week, we shipped a series of security and privacy upgrades across public profiles, file storage, and claim workflows.

## Verified Results by Default, Optional Sharing by Choice

Unclaimed sailor profiles on SailorPath display only verified competition history—regatta finishes, sail numbers used at each event, class standings, and official championship awards.

• Profile photos and avatars are stored in private buckets and are never publicly served unless an authorised profile owner or verified parent/guardian has explicitly enabled public sharing.
• Date-of-birth records used to verify age-group eligibility and youth index cutoffs remain protected and are never exposed on public profile pages.
• Personal race notes, equipment locker items, and coach debriefs live exclusively inside authenticated Sailor, Parent, and Coach workspaces.

## Hardened Evidence Storage and Claim Quotas

When sailors or parents submit supporting documentation or result evidence, those uploads are now governed by stricter storage policies:

• Supporting evidence files are restricted to accounts with an approved sailor or guardian claim and are served only through short-lived, authorised access checks.
• Per-user upload quotas and file validation checks protect the platform against automated abuse while keeping legitimate result verification fast.

## International Championship Awards on Public Profiles

We also refined how official division awards—such as Girls' overall podiums, U16/U12 prizes, and double-handed 29er helm and crew medals—are displayed on public profiles. Every award badge links back to the specific division scorecard where it was won.`,
    authorDisplayName: "SailorPath",
    relatedClass: null,
    relatedRegion: "International",
    sourceUrl: "https://sailorpath.com/privacy",
    sourceLabel: "SailorPath Privacy Policy",
    tags: ["privacy", "profiles", "guardian-consent", "security", "product"],
    createdAt: new Date("2026-10-27T02:00:00.000Z"),
  },
  {
    id: "f0c2a354-8d6e-4b7f-9a5c-202610300005",
    slug: "australian-2026-ilca-optimist-and-zhik-youth-sail-results",
    status: "published",
    kind: "result_report",
    title:
      "Australian 2026 Championship Coverage: ILCA Oceania & Australian Championships, Optimist States, and Zhik Youth Sail",
    summary:
      "SailorPath publishes 50 verified Australian championship fleet sheets across the 2026 ILCA Oceania & Australian Championships in Hobart, Musto Australian and State Optimist Championships, and the nationwide Zhik Youth Sail series.",
    body: `To support cross-border benchmarking across Asia and Oceania, SailorPath has completed a major expansion of 2026 Australian youth and open championship records across 50 fleet sheets and more than 5,000 individual race scores.

## 2026 ILCA Oceania & Australian Championships (Hobart, Tasmania)

All five championship fleets raced on the River Derwent in Hobart are now published with full race-by-race scores and discards:

• ILCA 4 Gold and Silver fleets (12 races, 2 discards)
• ILCA 6 Gold and Silver fleets
• ILCA 7 Open fleet

Source and verification note: All five ILCA Oceania & Australian Championship sheets have been visually verified and reconciled against both the official SailingResults.net portal and the 8-page organiser-hosted final results PDF.

## 2026 Australian National & State Optimist Championships

Nine completed Open and Intermediate fleet scorecards (260 entries, 1,470 race scores) are now live from the 2026 Australian domestic calendar:

• 2026 Musto Australian Optimist Championship (Intermediate Fleet, Royal Yacht Club of Tasmania)
• 2026 VIODA International Optimist Victorian & Open Championship (Open and Intermediate fleets)
• 2026 NSW, ACT, and Tasmanian Optimist State Championships (Open and Intermediate fleets)

## 2026 Zhik Youth Sail State Championships (36 Fleet Sheets)

We have also imported 36 completed class sheets (478 entries, 3,554 race scores) across seven 2026 Zhik Youth Sail state championships—Tasmania, Northern Territory, Queensland, South Australia, Western Australia, New South Wales, and the ACT:

• Optimist (Open and Intermediate fleets across TAS, QLD, SA, WA, and NSW; 213 entries)
• ILCA 4, ILCA 6, and ILCA 7
• 29er and 420 double-handed youth fleets
• iQFOiL and Techno 293 windsurfing fleets

Source and verification note: Where official organiser PDFs were not published for the Australian Optimist state championships and Zhik Youth Sail portals, scorecards were verified directly against the official digital scoring systems (SailingResults.net, Sailwave, TopYacht, Sportspage, and SailSys) and are transparently marked as digital-source verified rather than PDF-verified. Zhik Youth Sail Victoria 2026 is recorded as un-sailed (0 races completed due to severe weather).`,
    authorDisplayName: "SailorPath",
    relatedClass: "Optimist",
    relatedRegion: "Oceania",
    sourceUrl: "https://sailorpath.com/results",
    sourceLabel: "Explore published Australian regatta scorecards",
    tags: ["australia", "oceania", "optimist", "ilca-4", "ilca-6", "ilca-7", "29er", "420", "results"],
    createdAt: new Date("2026-10-30T03:00:00.000Z"),
  },
  {
    id: "a1d3b465-9e7f-4c8a-8b6d-202611020006",
    slug: "18th-eastern-seaboard-regatta-2026-results-published",
    status: "published",
    kind: "result_report",
    title:
      "18th Eastern Seaboard Regatta 2026: Optimist Gold, Silver, ILCA 4 & ILCA 6 Scorecards Published",
    summary:
      "Complete race-by-race scorecards for all 209 competitors (1,672 race scores) at the 2026 18th Eastern Seaboard Regatta at Royal Varuna Yacht Club in Pattaya, Thailand, visually verified against the official notice-board PDFs.",
    body: `Complete race-by-race scorecards from the 2026 18th Eastern Seaboard Regatta, hosted by Royal Varuna Yacht Club in Pattaya, Thailand (28 October – 1 November 2026), are now live on SailorPath.

## Four Fleets, 209 Competitors, 1,672 Race Scores

All 13 pages of the official result PDFs posted on Racing Rules of Sailing Event Notice Board 15166 were visually inspected and reconciled row-by-row before publication:

• Optimist Gold Fleet — 68 competitors, 8 races (Q1–Q5 and F1–F3), 2 discards (544 race scores)
• Optimist Silver Fleet — 67 competitors, 8 races (Q1–Q5 and F1–F3), 2 discards (536 race scores)
• ILCA 4 — 63 competitors, 8 races, 1 discard (504 race scores)
• ILCA 6 Youth U19 — 11 competitors, 8 races, 1 discard (88 race scores)

Across the four sheets, 176 entries matched existing verified sailor profiles and 33 new sailor profiles were created, with zero arithmetic or scoring reconciliation discrepancies between the official PDFs and the published tables.

## Source Transparency & Identity Notes

In keeping with SailorPath's data-integrity rules, several nuances from the official notice board documents are preserved directly in the scorecard metadata:

• Final vs. Provisional status: Although the official notice board titles and filenames label both documents as Final (Result Optimist Final and Result ILCA4 & ILCA6 Final, dated 1 November 2026), the document headers inside the PDFs still read Provisional. SailorPath displays the status as Provisional until the organiser issues a header-updated revision, while recording the full PDF reconciliation in each entry's evidence trail.
• Official Silver Fleet penalty points: Optimist Silver has 67 entries but applies 69-point scoring penalties in the official table; those exact published numeric values are preserved without synthetic recalculation.
• Cross-border identity protection: Where two distinct sailors share a sail number across seasons or fleets (such as Yong Ai Chuang and Yong Ray Chuang on sail 323), verified birth-year and gender records keep their career profiles strictly separate.

Explore all four fleet scorecards at /regattas/eastern-seaboard-regatta-2026.`,
    authorDisplayName: "SailorPath",
    relatedClass: "Optimist",
    relatedRegion: "Asia",
    sourceUrl: "https://sailorpath.com/regattas/eastern-seaboard-regatta-2026",
    sourceLabel: "Open 18th Eastern Seaboard Regatta 2026 scorecards",
    tags: ["thailand", "eastern-seaboard", "optimist", "ilca-4", "ilca-6", "results", "pdf-verified"],
    createdAt: new Date("2026-11-02T01:00:00.000Z"),
  },
];

const SLUG_PATTERN = /^[a-z0-9]+(?:-[a-z0-9]+)*$/;

function requiredText(value: unknown, field: string, maxLength: number): string {
  const text = String(value ?? "").trim();
  if (!text) throw new Error(`${field} is required`);
  return text.slice(0, maxLength);
}

function optionalText(value: unknown, maxLength: number): string | null {
  const text = String(value ?? "").trim();
  return text ? text.slice(0, maxLength) : null;
}

function parseKind(value: unknown): EditorialKind {
  if (typeof value === "string" && EDITORIAL_KINDS.includes(value as EditorialKind)) {
    return value as EditorialKind;
  }
  return "product_update";
}

function parseTags(value: unknown): string[] {
  const raw = Array.isArray(value)
    ? value
    : typeof value === "string"
      ? value.split(",")
      : [];

  return [
    ...new Set(
      raw
        .map((tag) => String(tag).trim().toLowerCase())
        .filter(Boolean)
        .map((tag) => tag.slice(0, 48))
    ),
  ].slice(0, 12);
}

function parseSourceUrl(value: unknown): string | null {
  const sourceUrl = optionalText(value, 500);
  if (!sourceUrl) return null;

  try {
    const parsed = new URL(sourceUrl);
    if (parsed.protocol !== "https:" && parsed.protocol !== "http:") {
      throw new Error("unsupported protocol");
    }
  } catch {
    throw new Error("source URL must be a valid http(s) URL");
  }

  return sourceUrl;
}

/** Validates the editable fields shared by create and workflow-transition requests. */
export function parseEditorialFields(value: unknown): EditorialFields {
  const input = value && typeof value === "object" ? value as Record<string, unknown> : {};
  const slug = requiredText(input.slug, "slug", 160).toLowerCase();
  if (!SLUG_PATTERN.test(slug)) {
    throw new Error("slug must use lowercase letters, numbers and single hyphens");
  }

  const sourceUrl = parseSourceUrl(input.sourceUrl);
  const sourceLabel = optionalText(input.sourceLabel, 180);
  if (sourceLabel && !sourceUrl) {
    throw new Error("a source label requires a source URL");
  }

  return {
    slug,
    kind: parseKind(input.kind),
    title: requiredText(input.title, "title", 180),
    summary: requiredText(input.summary, "summary", 600),
    body: requiredText(input.body, "body", 20_000),
    authorDisplayName: optionalText(input.authorDisplayName, 120) ?? "SailorPath",
    relatedClass: optionalText(input.relatedClass, 120),
    relatedRegion: optionalText(input.relatedRegion, 120),
    sourceUrl,
    sourceLabel,
    tags: parseTags(input.tags),
  };
}

export function parseEditorialAction(value: unknown): EditorialAction {
  if (typeof value === "string" && EDITORIAL_ACTIONS.includes(value as EditorialAction)) {
    return value as EditorialAction;
  }
  throw new Error("unsupported editorial action");
}

/**
 * Supports saving as draft or publishing from any editorial state, while
 * retaining optional review and archive states.
 */
export function transitionEditorialStatus(
  current: EditorialStatus,
  action: EditorialAction
): EditorialStatus {
  if (action === "save_draft") return "draft";
  if (action === "submit_review" && (current === "draft" || current === "in_review")) {
    return "in_review";
  }
  if (action === "publish") return "published";
  if (action === "archive" && current !== "archived") return "archived";

  throw new Error(`cannot ${action.replace(/_/g, " ")} an article in ${current} state`);
}
