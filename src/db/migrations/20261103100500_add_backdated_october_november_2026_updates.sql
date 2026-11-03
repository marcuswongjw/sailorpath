-- 169_add_backdated_october_november_2026_updates.sql
-- Seed and publish backdated October–November 2026 Updates (/news) articles
-- covering the 20th Asian Games & Youth Worlds imports, youth privacy &
-- evidence protections, Australian 2026 championship & Zhik Youth Sail
-- coverage, and the 18th Eastern Seaboard Regatta 2026 scorecards.

BEGIN;

INSERT INTO public.news_articles (
  id,
  slug,
  status,
  kind,
  title,
  summary,
  body,
  author_display_name,
  reviewed_at,
  published_at,
  updated_at,
  related_class,
  related_region,
  source_url,
  source_label,
  tags
)
VALUES
(
  'd8a0e132-6b4c-4f5d-9e3a-202610220003'::uuid,
  '2026-asian-games-and-youth-worlds-coverage',
  'published',
  'result_report',
  '20th Asian Games 2026 Sailing Standings and Youth World Championship Results Added',
  'SailorPath adds verified overall standings from the 20th Asian Games in Gamagori across five classes, alongside race-by-race scorecards from the 2026 ILCA 4 Youth World Championships and regional Asian Cup regattas.',
  $body$SailorPath has expanded its international championship archive with official standings from the 20th Asian Games 2026 in Gamagori, Japan, alongside full race-by-race scorecards from recent youth world and regional championships.

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

Each imported scorecard links directly to its source attribution and updates the career histories and international prize records of participating sailors.$body$,
  'SailorPath',
  '2026-10-22 09:00:00+08',
  '2026-10-22 09:00:00+08',
  '2026-10-22 09:00:00+08',
  'ILCA 4',
  'Asia',
  'https://sailorpath.com/results',
  'Browse published championship scorecards',
  '["asian-games", "ilca-4", "ilca-6", "ilca-7", "29er", "iqfoil", "results"]'::jsonb
),
(
  'e9b1f243-7c5d-4a6e-8f4b-202610270004'::uuid,
  'privacy-first-profiles-guardian-consent-and-evidence-protections',
  'published',
  'product_update',
  'Strengthening Youth Sailor Privacy: Consent-Gated Photos, Private Evidence, and Claim Protections',
  'How SailorPath protects youth athletes by keeping public profiles strictly focused on verified competition records while gating photos, personal notes, and uploaded evidence behind approved claims and guardian consent.',
  $body$Because youth sailing records involve minor athletes, SailorPath is built around a strict separation between the public competition record and private athlete or family data. Over the past week, we shipped a series of security and privacy upgrades across public profiles, file storage, and claim workflows.

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

We also refined how official division awards—such as Girls' overall podiums, U16/U12 prizes, and double-handed 29er helm and crew medals—are displayed on public profiles. Every award badge links back to the specific division scorecard where it was won.$body$,
  'SailorPath',
  '2026-10-27 10:00:00+08',
  '2026-10-27 10:00:00+08',
  '2026-10-27 10:00:00+08',
  NULL,
  'International',
  'https://sailorpath.com/privacy',
  'SailorPath Privacy Policy',
  '["privacy", "profiles", "guardian-consent", "security", "product"]'::jsonb
),
(
  'f0c2a354-8d6e-4b7f-9a5c-202610300005'::uuid,
  'australian-2026-ilca-optimist-and-zhik-youth-sail-results',
  'published',
  'result_report',
  'Australian 2026 Championship Coverage: ILCA Oceania & Australian Championships, Optimist States, and Zhik Youth Sail',
  'SailorPath publishes 50 verified Australian championship fleet sheets across the 2026 ILCA Oceania & Australian Championships in Hobart, Musto Australian and State Optimist Championships, and the nationwide Zhik Youth Sail series.',
  $body$To support cross-border benchmarking across Asia and Oceania, SailorPath has completed a major expansion of 2026 Australian youth and open championship records across 50 fleet sheets and more than 5,000 individual race scores.

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

Source and verification note: Where official organiser PDFs were not published for the Australian Optimist state championships and Zhik Youth Sail portals, scorecards were verified directly against the official digital scoring systems (SailingResults.net, Sailwave, TopYacht, Sportspage, and SailSys) and are transparently marked as digital-source verified rather than PDF-verified. Zhik Youth Sail Victoria 2026 is recorded as un-sailed (0 races completed due to severe weather).$body$,
  'SailorPath',
  '2026-10-30 11:00:00+08',
  '2026-10-30 11:00:00+08',
  '2026-10-30 11:00:00+08',
  'Optimist',
  'Oceania',
  'https://sailorpath.com/results',
  'Explore published Australian regatta scorecards',
  '["australia", "oceania", "optimist", "ilca-4", "ilca-6", "ilca-7", "29er", "420", "results"]'::jsonb
),
(
  'a1d3b465-9e7f-4c8a-8b6d-202611020006'::uuid,
  '18th-eastern-seaboard-regatta-2026-results-published',
  'published',
  'result_report',
  '18th Eastern Seaboard Regatta 2026: Optimist Gold, Silver, ILCA 4 & ILCA 6 Scorecards Published',
  'Complete race-by-race scorecards for all 209 competitors (1,672 race scores) at the 2026 18th Eastern Seaboard Regatta at Royal Varuna Yacht Club in Pattaya, Thailand, visually verified against the official notice-board PDFs.',
  $body$Complete race-by-race scorecards from the 2026 18th Eastern Seaboard Regatta, hosted by Royal Varuna Yacht Club in Pattaya, Thailand (28 October – 1 November 2026), are now live on SailorPath.

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

Explore all four fleet scorecards at /regattas/eastern-seaboard-regatta-2026.$body$,
  'SailorPath',
  '2026-11-02 09:00:00+08',
  '2026-11-02 09:00:00+08',
  '2026-11-02 09:00:00+08',
  'Optimist',
  'Asia',
  'https://sailorpath.com/regattas/eastern-seaboard-regatta-2026',
  'Open 18th Eastern Seaboard Regatta 2026 scorecards',
  '["thailand", "eastern-seaboard", "optimist", "ilca-4", "ilca-6", "results", "pdf-verified"]'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  status = EXCLUDED.status,
  kind = EXCLUDED.kind,
  title = EXCLUDED.title,
  summary = EXCLUDED.summary,
  body = EXCLUDED.body,
  reviewed_at = COALESCE(public.news_articles.reviewed_at, EXCLUDED.reviewed_at),
  published_at = COALESCE(public.news_articles.published_at, EXCLUDED.published_at),
  updated_at = EXCLUDED.updated_at,
  related_class = EXCLUDED.related_class,
  related_region = EXCLUDED.related_region,
  source_url = EXCLUDED.source_url,
  source_label = EXCLUDED.source_label,
  tags = EXCLUDED.tags;

COMMIT;
