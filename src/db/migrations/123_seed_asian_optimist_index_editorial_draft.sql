-- 123_seed_asian_optimist_index_editorial_draft.sql
-- Seed the SailorPath Asian Optimist Index (Beta) methodology and 2026-27
-- event register announcement as an editorial draft in public.news_articles.

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
  related_class,
  related_region,
  source_url,
  source_label,
  tags,
  updated_at
)
VALUES (
  'b6e8c910-4f2a-4d3b-9c1e-202611010001'::uuid,
  'asian-optimist-index-beta-methodology-and-event-register',
  'draft',
  'class_announcement',
  'Introducing the SailorPath Asian Optimist Index (Beta): Methodology & 2026–27 Event Register',
  'Proposed Grade 150, Grade 75 and Grade 40 methodology for the SailorPath Asian Optimist Index (Beta), initial regional and national event register for Malaysia, Thailand, Singapore, Hong Kong and West Asia/GCC, and open call for 2026–27 regatta nominations.',
  $body$Youth sailors across Asia compete in an active calendar of national championships, regional international opens, and IODA championships—yet following form across borders between major events has historically been difficult.

Ahead of the 2026 IODA Asian & Oceanian Championship in Colombo (12–19 December 2026), we are publishing the methodology for the SailorPath Asian Optimist Index (Beta) along with our initial Grade 75 and Grade 40 Event Register, and opening a community window to nominate and confirm qualifying regattas across Asia.

Independence & Governance Note: The SailorPath Asian Optimist Index is an independent, source-backed analytical index published by SailorPath. It is not an official IODA or national federation ranking, and it must not be used as a team-selection tool. Event organisers, juries, and national authorities remain the sole authority for official regatta results.

## How the Index Works

The Index is designed around one core principle: reward strong finishes in deep, verified fleets without turning the standings into a measure of who traveled to the most regattas.

Each sailor’s Index score is the sum of their best five eligible results over a rolling 12-month window, governed by four event grades and strict country caps:

• Grade 150 — IODA Championship Anchors (Max 2 results total): The IODA Asian & Oceanian Championship and the IODA World Championship (count at most 1 World result and 1 Continental result, or up to 2 IODA Continental results if a sailor did not attend Worlds). Requires an official published final individual classification with at least 5 completed races. Equalizing both championships at Grade 150 keeps the Asian & Oceanian Championship as the primary regional benchmark while giving full credit to standout World Championship performances.

• Grade 75 — Designated Major International Opens (Max 2 results, at most 1 per host country): Pre-designated major international Optimist regattas in Asia. Requires a published final classification, at least 40 valid starters in the premier/Gold fleet, sailors from at least 4 national authorities (NOCs), and at least 4 completed races. Even where a country hosts two eligible international opens, a sailor may count at most one Grade 75 result per host country.

• Grade 40 — Designated National Championships (Max 2 results, at most 1 per country per calendar year): Pre-designated national championships recognized by the relevant national class association or sailing authority. Requires a published final classification, at least 30 valid starters in the premier/Gold division, and at least 4 completed races.

• Grade 0 — Verified Competition History (Unscored): Club regattas, clinics, team racing, Silver/Intermediate/Green development fleets, and events below the minimum gates remain visible on SailorPath athlete profiles as verified competition history, but do not contribute Index points.

Unused higher-grade slots can be filled by lower-grade eligible results—meaning a sailor who was not selected for Worlds is never penalized with an empty zero slot.

## The Scoring Formula

For every eligible regatta, points are calculated from the sailor’s official final overall place (or the premier Gold/Main division where entry divisions are separate):

Points = E × (N − P + 1) / N

Here, E is the Event Grade (150, 75, or 40), N is the number of valid starters in the scored final classification, and P is the sailor’s official final place (1 to N). First place earns the full event grade (E), scaling linearly down the fleet. Every result expires 12 months after the final race day, with no 24-month exception—reflecting how rapidly Optimist sailors develop and age through the class.

## Source Verification & Identity Rules

Every scored result on SailorPath is linked to a public audit ledger showing the official result URL, publication timestamp, starter count (N), completed race count, finishing place (P), points contribution, and 12-month expiry date. Because Optimist sailors frequently charter hulls and sails at overseas regattas, SailorPath never links results across events by sail number alone. Cross-event results are matched using verified athlete identity, nationality representation, and manual duplicate review.

## Initial 2026–27 Event Register (Beta)

### Grade 150 — Championship Anchors

• 2025 IODA Asian & Oceanian Championship (Mussanah, Oman · N = 170 · 7 races — Baseline cohort)
• 2026 IODA World Championship (Tangier, Morocco · N = 284 · 12 races — Verified)
• 2026 IODA Asian & Oceanian Championship (Colombo, Sri Lanka · 12–19 December 2026 — Becomes active once official final classification is confirmed)

### Grade 75 & Grade 40 — Regional & National Slate

| Country / Hub | Grade 75 (International Open — max 1 counted per host country) | Grade 40 (National Championship — max 1 counted per country/year) |
| --- | --- | --- |
| Malaysia (MAS) | • 22nd LIRP 2026 (Gold, N = 59, 12 races) / • 5th LIYSC 2026 (Gold, N = 50, 10 races) | • MSA–NSC–MILO National Open (Overall/U16) |
| Thailand (THA) | • Thailand International Sailing Championships (Sattahip, N = 65, 12 races) / • Optional Winter Open: Phuket King's Cup | • Thailand National Sailing Championship |
| Singapore (SGP) | • Singapore Youth Sailing Championships (SYSC Gold, N = 106, 11 races — if designated as SGP’s International Open) | • Singapore National Sailing Championships (SNSC Gold, N = 83, 9 races — plus SYSC Gold if both kept at Grade 40) |
| Hong Kong (HKG) | • Hong Kong Race Week (Optimist Main, N = 77, 9 races) | • HKG Optimist National Championship (open for nomination) |
| West Asia / GCC (OMA / UAE) | • Mussanah Race Week (open for nomination) | • UAE / Oman National Championships (open for nomination) |

## Open Call: Nominate or Confirm Regattas for 2026–27

To keep the Index fair and transparent, regattas must be pre-designated before results are scored—we never assign a grade retroactively based on who won.

We invite national class associations, sailing federations, host clubs, coaches, and parents across Asia to help finalize the 2026–27 Event Register:

• Confirm Open Slots in the Initial Hubs: Feedback on designating SYSC (Optimist Gold) as Singapore’s Grade 75 International Open alongside SNSC (Optimist Gold) as Grade 40 National Championship; confirmation of Phuket King’s Cup or Eastern Seaboard Regatta against Grade 75 gates; and official Notice of Race and final result links for the HKG Optimist National Championship, Mussanah Race Week, and UAE/Oman National Championships.

• Nominate Additional Asian Hubs (IND, JPN, CHN, TPE, SRI, MYA, INA, PHI, KOR): Nominate your country’s single premier Grade 40 National Championship (at least 30 premier-fleet starters and 4 completed races) and any recurring Grade 75 International Open (at least 40 starters, 4 NOCs, and 4 completed races).

When nominating an event or submitting an official result sheet, please include the event name, host club/authority, dates, proposed tier (Grade 75 or Grade 40), fleet structure (combined overall classification vs. separate Gold/Main entry divisions), and a link to the official public Notice of Race and final result sheets.$body$,
  'SailorPath',
  'Optimist',
  'Asia',
  'https://sailorpath.com/sg/optimist/asian-index',
  'SailorPath Asian Optimist Index',
  '["optimist", "asian-index", "methodology", "event-register"]'::jsonb,
  '2026-10-18 12:00:00+08'
)
ON CONFLICT DO NOTHING;

COMMIT;
