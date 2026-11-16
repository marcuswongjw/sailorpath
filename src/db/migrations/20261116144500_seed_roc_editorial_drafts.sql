-- Seed editorial draft updates for Regatta of Champions (2022–2026) & R.O.C. Kosmos
-- and the Asian & Oceania Optimist Index V1.1 (Beta) 4-tier methodology update.

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
VALUES
(
  'c4a7d200-2026-4b11-9e10-726f63000001'::uuid,
  'regatta-of-champions-2022-2026-and-kosmos-results-live',
  'draft',
  'product_update',
  'Regatta of Champions (2022–2026) and R.O.C. Kosmos Results Now Live on SailorPath',
  'SailorPath has imported 14 official result sheets across five editions of the Chesva Regatta of Champions (The R.O.C.) in Limassol and three editions of R.O.C. Kosmos in Athens—covering 779 entries and 14,202 individual race scores.',
  $body$All five editions of the invite-only **Regatta of Champions (The R.O.C.)** in Limassol, Cyprus (2022–2026) and three editions of **R.O.C. Kosmos** in Athens, Greece (2024–2026) are now live on SailorPath—complete with race-by-race scores, discards, and verified sailor profile links.

## What Was Imported

Across **14 published sheets** (**779 entries**, **14,202 race scores**), coverage includes:

• **2026 Chesva Regatta of Champions — The R.O.C. (11–14 Nov 2026, Limassol):** 45 invited champions from 22 MNAs across 14 races, won by **Guilherme M. Costa** (`POR`, 102.0 pts) ahead of **Briggs Kossmann** (`USA`, 102.0 pts) and **Lucas Garrido** (`ESP`, 110.0 pts).
• **2026 Asian & Oceanian R.O.C. Performers:** **Jean-Luc Herve** (`UAE`, 8th), **Anya Zahedi** (`SGP`, 17th), **Margaux Nguyen-Minh** (`HKG`, 19th), **Khalifa Alromaithi** (`UAE`, 31st), **Kotaro Matsunaga** (`JPN`, 32nd), and **Lyric Yuxuan Li** (`SGP`, 37th).
• **2026 The R.O.C. Kosmos — Optimist & ILCA 4 (Jun–Jul 2026, Athens):** 122 Optimist entries split across Gold (61) and Silver (61) after the qualifying series, plus 24 ILCA 4 entries highlighted by a Hong Kong 1–2–3 sweep from **Tiago Salgado**, **Zixi Huang**, and **Cyrus Yung**.
• **2022–2025 Historical Editions:** Full official final results for 2022, 2023, 2024, and 2025 R.O.C. in Limassol and 2024–2025 R.O.C. Kosmos (Gold, Silver, and Bronze fleets) in Athens.

All R.O.C. and Kosmos sheets are published as external international competition records (`counts_for_ranking = false` for Singapore national rankings), while 2026 R.O.C. and 2026 R.O.C. Kosmos Optimist also feed the updated Asian & Oceania Optimist Index.$body$,
  'SailorPath Editorial',
  'Optimist',
  'International',
  'https://www.regattaofchampions.com/',
  'Official Regatta of Champions Results',
  '["Regatta of Champions", "The R.O.C.", "R.O.C. Kosmos", "Optimist", "ILCA 4"]'::jsonb,
  now()
),
(
  'c4a7d200-2026-4b11-9e10-726f63000002'::uuid,
  'asian-optimist-index-v1-1-worlds-200-roc-150-live',
  'draft',
  'class_announcement',
  'Asian & Oceania Optimist Index V1.1 (Beta): Grade 200 Worlds, Grade 150 R.O.C., and Live Standings',
  'SailorPath updates the Asian & Oceania Optimist Index to live database calculation with 4-tier event grading (200 / 150 / 75 / 40), promoting the IODA World Championship to Grade 200 and designating the 2026 Regatta of Champions (Grade 150) and 2026 R.O.C. Kosmos Gold+Silver (Grade 75).',
  $body$The **SailorPath Asian and Oceania Optimist Index** has been upgraded to **V1.1 (Beta)**—transitioning from a static snapshot to live database calculation and refining the event grade structure to **200 / 150 / 75 / 40**.

## Key Methodology Updates

• **Grade 200 — World Championship (Max 1):** The IODA Optimist World Championship now sits in its own top tier (`E = 200`), separating World Championship performance from continental championships.
• **Grade 150 — Continental & Invitational Championships (Max 2):** Official IODA continental fleet-racing championships (`2025/2026 Asians`, `2026 Europeans`) and the invite-only **2026 Regatta of Champions** (`45` starters across `22` MNAs) share Grade 150. Separating Worlds into Grade 200 ensures sailors who compete at Worlds, Asians, and R.O.C. can count all three.
• **Grade 75 — Major International Opens (Max 1 per host MNA):** **2026 R.O.C. Kosmos** is designated as a combined **122-boat** Gold + Silver qualifying-split classification (`GRE`), joining regional opens including Eastern Seaboard, ASAF Cup, HKODA, Mussanah Race Week, Hong Kong Race Week, SYSC, LYSC, LIRP, and Thailand International.
• **Live Standings:** Standings, qualifier columns, and event registers on `/optimist/asian-index` now compute dynamically from SailorPath's verified regatta tables under the six optimal-subset selection limits.$body$,
  'SailorPath Editorial',
  'Optimist',
  'Asia & Oceania',
  'https://sailorpath.com/optimist/asian-index/methodology',
  'Asian & Oceania Optimist Index Methodology V1.1',
  '["Asian Optimist Index", "Optimist", "Methodology", "Regatta of Champions"]'::jsonb,
  now()
)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  summary = EXCLUDED.summary,
  body = EXCLUDED.body,
  source_url = EXCLUDED.source_url,
  source_label = EXCLUDED.source_label,
  tags = EXCLUDED.tags,
  updated_at = now();

COMMIT;
