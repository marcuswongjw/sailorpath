# Thai Optimist results import — 20 October 2026

Production data import completed through the configured Supabase connector. No application deployment or Git commit was required.

| Event | Dates used | Results | Race scores | Action |
| --- | --- | ---: | ---: | --- |
| Admiral's Cup 2026 | 20–24 February | 70 | 840 | Created parent event and published Optimist sheet |
| ACDC Sailing Cup 2026 | 30–31 May | 52 | 208 | Created parent event and published Optimist sheet |
| ACDC Cup International Sailing Championship 2026 | 29 July–1 August | 75 | 900 | Created parent event and published Optimist sheet |
| Thailand International Sailing Championships 2026 | Existing Optimist dates 15–18 April retained | 65 | 780 | Audited existing published sheet; no duplicate or score changes |

Main/overall Optimist fleets only. Newborn and other boat classes excluded. Three new parent events, three newly published class sheets, 197 new verified results, 1,948 new race-score rows, and 28 new sailor profiles. Across all four audited sheets: 262 results and 2,728 race scores; zero arithmetic or race-count reconciliation exceptions.

## Sources and PDF review

- Admiral's Cup: https://rvycresults.com/Results/2026/admiralcup26.htm, linked by Royal Varuna's 2026 page and official notice board https://www.racingrulesofsailing.org/documents/13369/event. Searched those sources and web results for an official results PDF; none found. The user was informed before import. Used the organiser-hosted HTML; provisional as of 27 February 2026. No PDF-verification claim.
- ACDC Sailing Cup: official final PDF https://www.racingrulesofsailing.org/documents/191515, notice board https://www.racingrulesofsailing.org/documents/13697/event. Rendered all four pages; overall fleet is on pages 2–3. Official first-day results are dated 30 May and final-day results 31 May; the comparison site's 7–8 May heading is inconsistent with its own 31 May result date.
- ACDC International: official final-day PDF https://www.racingrulesofsailing.org/documents/200618, notice board https://www.racingrulesofsailing.org/documents/15111/event. Rendered and visually reviewed all three pages. The PDF says provisional as of 14:33 on 1 August 2026; preserved in row evidence and public event summary. Official English NoR 193957 and SI 200190 specify 29 July–1 August, rather than the comparison site's 28 July start.
- Thailand International: official final PDF https://www.racingrulesofsailing.org/documents/184140, notice board https://www.racingrulesofsailing.org/documents/13235/event. Rendered and visually reviewed both pages. Existing 65 result rows and all 780 scores, discards and codes match; no re-import. The combined event's dates include registration and a separate long-distance race, so the existing Optimist class dates are retained.

Downloaded PDFs, page renders and original browser table snapshots are retained under `.work/thai-optimist-2026/`. The normalized source data and identity decisions are retained here in JSON.

## Source comparison

`source-comparison.json` records every score/code/nationality/name discrepancy found against sail-result.com. In particular, that site omits some scoring codes on discarded races and rounds two Thailand International totals/nets. The imports use the organiser's explicit codes and exact decimal totals; SailorPath already held the correct Thailand International decimals.

Existing sailor profiles, DOBs, privacy settings and aliases were preserved. Historical sail numbers are stored on each result and in its evidence, without changing profile equipment. Source birth years are retained in evidence; no date of birth was invented. Result birth-year fields derive from current database DOBs. New profiles without DOBs therefore have no derived birth year.

The user confirmed both identity pairs on 20 October 2026: Duangdeuen Wichai / Duangduean Wichat are one new profile; Admiral's Cup Napaphat Buasuang is the existing Napabhat Buasuang. Other reviewed spelling variants and their match evidence are recorded in `identity-review.json`. Distinct unconfirmed official names are not merged.

All three new sheets and participant rows have Singapore national-ranking credit disabled, consistent with overseas result imports. No Asian Index grades, qualifying-event configuration or scoring code was changed.

## SQL inventory and validation

- `admirals-cup.sql`
- `acdc-sailing-cup.sql`
- `acdc-international.sql`
- `audit.sql` (read-only inventory and score reconciliation across all four)

Each import is transactional with an event lock, identity preflight, existing-profile preservation guard, per-result exact score/code/discard checks and final inventory/evidence checks. Conflicts roll back the sheet. Each passed a rolled-back trial, committed successfully, and passed a rolled-back replay proving that reruns do not duplicate records.

All four manifests passed the SailorPath manifest validator. Preparation sequence for reproducibility: `prepare.py`, `resolve.py`, `build_sql.py`; these depend on the retained local source/preflight files and must be reviewed against refreshed production identities before future use. Use the standalone SQL files for this completed batch's guarded replay.

Vercel's production `public-regattas` cache tag was invalidated after the import. All three public event pages return HTTP 200 and are discoverable in the Results directory. Public HTML was checked against all 197 imported rows and 1,948 scores: zero name, score, code, discard or gross/net differences. The source's provisional status is displayed in public event summaries where applicable.

## Live pages

- https://sailorpath.com/regattas/admirals-cup-2026
- https://sailorpath.com/regattas/acdc-sailing-cup-2026
- https://sailorpath.com/regattas/acdc-cup-international-sailing-championship-2026
- https://sailorpath.com/regattas/thailand-international-sailing-championships-2026

Production and public verification files, plus the browser proof screenshot, are in `outputs/thai-optimist-2026/`.
