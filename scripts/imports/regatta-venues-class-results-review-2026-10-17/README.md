# Venue repairs and supplied class-results review — 17 October 2026

The two user-confirmed event venues and all 27 currently blank class-sheet venues with an available parent location have been updated in production. The three supplied PDFs were reviewed on all six rendered pages to confirm missing results. Result imports were not requested in this turn and have not been applied.

## Completed venue changes

- Singapore Youth Sailing Championships 2023: **National Sailing Centre**, on the event and both Gold/Silver sheets.
- Raffles Marina Optimist Regatta 2023: **Raffles Marina**, on the event and both Gold/Silver sheets.
- Another 23 class sheets now use their existing parent venues, making **27 class-sheet updates in total**.
- The draft Qingdao 2025 personal entry remains the only main class sheet with a blank venue; it has no confirmed parent venue. No venue was inferred from its city/event name.
- All 27 class venues match their parents. No parent-event venue is now blank.

The transaction kept private before-state audit records, checked all planned IDs/parent relationships/old venues, and preserved unrelated concurrent class-slug edits. Hash comparisons confirmed that result rows, individual race rows and participant links did not change. Replay and a concurrent-venue-edit rejection were tested locally. Existing nonblank class venues and lifecycle/ranking settings were preserved. This is a production metadata update; it needs no application deployment.

## Confirmed supplied result gaps

| Official event/class | Source entries | Races per entry | Required race rows | SailorPath now | Finding |
| --- | ---: | ---: | ---: | --- | --- |
| SYSC **2026**, ILCA 4 | 70 | 12 | 840 | 70 summary entries; 0 individual race rows | Individual races, discards, scoring codes, entry sail numbers and official source links are missing. |
| SYSC **2025**, ILCA 6 | 19 | 10 | 190 | No class sheet | Entire class is missing. |
| SYSC **2025**, Techno 293 | 5 | 10 | 50 | No class sheet | Entire class is missing. |
| SYSC **2025**, iQFOiL Youth | 2 | 10 | 20 | No class sheet | Entire class is missing. |

The three missing 2025 sheets contain **26 competitors and 260 race-score rows**. The existing 2026 ILCA 4 sheet needs **840 race-score rows**, for **1,100 missing individual race rows across the supplied documents**. The first five 2026 ILCA 4 saved rank/gross/net summaries were spot-checked against the visible PDF and agree; this review does not claim a complete per-sailor identity reconciliation for future importing.

The first link is explicitly a **2026** result sheet. The second and third are **2025** sheets. The 2025 ILCA 4 sheet cannot be completed using the 2026 PDF.

The ILCA 4 and ILCA 6 PDFs print **final**. The combined Techno/iQFOiL PDF prints **provisional** even though its filename contains “Final Result.” Its scoring status must be retained or explicitly confirmed before presenting it as final. The source final/provisional timestamps do not establish the event start/end dates.

## Sources

- [ILCA 4 Results.pdf](https://drive.google.com/file/d/1I33FveFTEeKyfXbCSbgZQAEG7JIGUbW8/view): Singapore Youth Sailing Championships 2026, printed final, 3 visually reviewed pages.
- [ILCA 6 Final Result.SYSC2025.pdf](https://drive.google.com/file/d/1wzeEhn66Xll6nQIF7SfPsS2QRugX2IEf/view): Singapore Youth Sailing Championships 2025, printed final, 2 visually reviewed pages.
- [Techno293 & iQFoil Final Result.SYSC2025.pdf](https://drive.google.com/file/d/19_QN-jMbB6vMwLcY-3T_BXvEG9ZwGlqY/view): Singapore Youth Sailing Championships 2025, printed provisional, 1 visually reviewed pages.

## Additional gaps noticed while comparing

SYSC 2025 ILCA 4 has **75 saved entries against a stored fleet size of 76**, and no individual race rows. Its 2025 official sheet is needed to establish the omitted entrant and race data. The existing SYSC 2025 Optimist Gold and Silver sheets also store summaries without individual race rows or source links; the three new PDFs do not cover those fleets.

The 2025 parent event advertises additional classes (including ILCA 7, 29er and WingFoil), and the 2026 parent advertises ILCA 7 and 420. Those classes have no linked sheets in the current inventory, but the supplied PDFs do not establish whether they actually raced. Treat them as source-verification questions rather than confirmed omissions.

The dashboard's current readiness check uses a declared race count and the presence of result entries. It does not reconcile individual race rows or verify every advertised class against official sheets. That is why a summary-only sheet can still pass its current completeness check.

## Retained evidence and verification

- [Reviewed source inventory, printed status and checksums](class-results-review.json)
- [Existing SYSC event/class inventory](existing-sysc-inventory.json)
- [Production venue verification](venue-repair-verification.json)

Standalone venue SQL, the explicit plan and local validation are retained under `scripts/imports/regatta-venues-class-results-review-2026-10-17/` in the audit branch. Raw PDFs, rendered screenshots and streamed download credentials are not committed.

Both confirmed event venues were verified in the live public page facts after refreshing the shared event cache. [Live venue verification](live-venue-proof.json).
