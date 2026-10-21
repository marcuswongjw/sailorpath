# 2025 Admiral’s Cup and Eastern Seaboard import

Completed in the production database on 21 October 2026. The application update needed for the 420 event tab is also deployed live.

| Event | Dates | Published sheets | Scored entries | Individual race scores |
|---|---|---|---:|---:|
| [Admiral’s Cup 2025](https://sailorpath.com/regattas/admirals-cup-2025) | 6–10 February 2025 | Optimist Gold (51), Optimist Silver (51) | 102 | 1,122 |
| [17th Eastern Seaboard Regatta 2025](https://sailorpath.com/regattas/eastern-seaboard-regatta-2025) | 22–26 October 2025 | Optimist (78), ILCA 4 (48), ILCA 6 (12), 420 (5 boats / 10 sailors) | 143 | 1,573 |

**Total: two parent events, six published sheets, 245 verified result rows, 250 sailor-participant links and 2,695 individual race scores. Zero reconciliation exceptions.** All 245 discard markers and 230 scoring-code cells are retained, including fractional and percentage penalties. Every row has an official evidence link. Singapore national-ranking credit remains disabled for these overseas events.

## Source status

Both organisers’ published sources remain explicitly **provisional**, and all six live fleet badges show Provisional. No final classification is claimed.

- Admiral’s Cup: [official results PDF](https://www.racingrulesofsailing.org/documents/129767), provisional at 17:06 on 10 February 2025. All five pages were rendered and visually reviewed before secondary extraction; both 51-entry fleets, names, historic sails, 11 race values, discards, codes and totals were checked. [Amended NoR](https://www.racingrulesofsailing.org/documents/127292) verifies event dates; first racing day was 7 February.
- Eastern Seaboard: [organiser-linked HTML results](https://jpvm.org/results/2025/rvyc/Results.html), provisional at 16:29 on 26 October 2025; [Royal Varuna’s 2025 event page](https://www.varuna.org/2025) links to it. All four result tables were reviewed visually in the browser and every score was reconciled. No official result PDF or later final revision was located after checking the organiser, official notice board and web; user informed before import. This event is **not PDF-verified**. [Amended NoR](https://www.racingrulesofsailing.org/documents/152769) verifies dates; first racing day was 23 October.

## Identities

The user confirmed Jiratip/Jirathip Mutiphan and Natthapatr/Natthaphatr Poolklang are respectively the same sailor. Their two entries each are now linked to one profile, with both spellings as aliases and event-specific sail numbers preserved. The intermediate Jirathip profile created during this batch was consolidated with a recoverable before snapshot in the private audit; race-score rows did not change.

No pre-existing sailor profile, family relationship or DOB was overwritten. Concurrent capitalization edits were preserved. New profiles were created only for distinct official identities without a corroborated existing match. Crew members are linked individually to one scored boat entry; no synthetic team sailor was created and helm/crew roles were not guessed.

## Verification and retained records

- All six final manifests passed the import validator and race arithmetic checks.
- Transaction guards verified every stored result, participant, race score, code, discard and evidence field.
- Production audit: 2 events; 6 published/provisional sheets; 245 entries; 250 resolved participants; 2,695 scores; 0 exceptions.
- A completed ILCA 4 transaction was replayed after the confirmed identity consolidation, validating repeatability without duplicating rows.
- All six canonical public fleet pages returned HTTP 200 and show all 11 races, source links and provisional badges. The Eastern Seaboard hub shows Optimist, ILCA 4, ILCA 6 and 420 as separate tabs; the 420 page displays both sailors per entry.
- The event-tab change passed 57 tests and a production build. Release `2158cec7fa5af42cb77a4cfb0c857168b2f8926d`, deployment `dpl_GKCqtcorpBmEt6ZAVLHwvn84icGU`, READY on both public/admin domains. Concurrent homepage and X-15 visibility changes were preserved.

[SQL inventory and import notes](../../scripts/imports/thai-regattas-2025/README.md) · [Source comparison and hashes](../../scripts/imports/thai-regattas-2025/source-comparison.json) · [Final live-page checks](public-checks.json)

The production data import is complete independently of the source-code deployment. The SQL, manifests and audit report are retained locally; the four-file application change is committed and deployed.
