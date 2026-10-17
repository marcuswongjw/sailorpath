# 2026 Optimist World Championship: live results import

[Live results](https://sailorpath.com/regattas/2026-optimist-world-championship/results/optimist) | [Official results](https://2026worlds.optiworld.org/en/default/races/race-resultsall) | [Official overall PDF](https://scoring.sailti.com/public/download/overall-datetime-pdf/10651/1/20260628140956)

## Completed data import

- One parent event and one published Optimist Overall/Open sheet, 18-28 June 2026, Royal Yacht Club de Tanger, Tangier, Morocco.
- **46 Asian entries, 46 participant links and 552 individual race scores**. All twelve races, the official discard, scoring codes, totals and net scores are preserved.
- **37 existing profiles reused, 9 Asian profiles created, 1 confirmed duplicate consolidated**. No non-Asian profile was created. Profile count changed from 1,161 to 1,169.
- Original overall world positions and the full **284-boat** fleet denominator are retained. Competitors are not re-ranked within the imported subset.
- The full official classification is linked from the results page.

## Scope and implications

The user selected [IODA's Asian continental scope](https://www.optiworld.org/default/classinfo/national-members?ini=1). Its directory classifies Azerbaijan, Cyprus, Israel and Turkey under Europe, so those 17 entries were excluded. Imported source NOCs are HKG, INA, IND, JPN, KSA, KUW, MAC, OMA, PHI, QAT, SGP, SRI, THA and UAE. Indonesia's existing profile was reused; no new profile was created for that entry.

The partial import does not change official positions, scores or fleet size. It cannot by itself represent the complete world podium, team standings or a global ranking; use the linked official sheet for the complete championship. This regatta is excluded from Singapore national rankings. The Asian Optimist Index source-result ledger was not extended or recalculated.

A public-route bug prevented saved event descriptions from appearing when opening a class-results URL directly. The release accompanying this import makes event and class-result routes load the same saved description, so the Asian-only scope is visible on both.

## Identity decisions

- **Nana Muranaka, JPN 3356, is different from Riko Muranaka.** Created a separate Nana profile and saved a durable keep-separate decision. Riko and her prior result remain intact.
- **Rameeza Bhanu SK, S K Rameeza Bhanu and Rameeza Bh Sk are the same sailor.** Kept the existing S K Rameeza Bhanu profile. Both prior results and participant links, all **18 historical race scores**, codes, discards, totals, net values and evidence URLs survived consolidation unchanged. The existing Asian Index identity now points to the survivor; its source result is unchanged. Including the Worlds, the survivor has **3 results and 30 race scores**. Historical IND 1716 and event-specific IND 1927 remain distinct; profile equipment was not replaced.
- Tong Xuan Ya keeps the user's previously confirmed SGP athlete nationality. Official source NOC KSA and the Worlds sail **KSA 155** are retained in evidence and the event entry; profile equipment KSA 107 was not replaced.
- Mohammed Nabil Al-Balushi, OMA 303, and Mohammed Al-Balushi, OMA 301, are separate official individual entries and use different profiles.
- Explicit per-entry plans preserve existing names, equipment and ownership. No weak match was propagated through a connected group.

## Verification

All twelve PDF pages were rendered and visually inspected. The initial broad geographic review independently transcribed 63 entries and 756 race scores; every imported row was reconciled with the official HTML table. A visual transcription error was caught and corrected before applying the data.

- Production readback: **zero entry, race, participant or arithmetic-reconciliation exceptions**.
- Public readback: all **46 rows and 552 visible race scores** match the manifest; official source link present.
- The database-wide historical race-score hash outside this new regatta is unchanged.
- The Asian Optimist Index source-result ledger hash is unchanged.
- Transaction tests passed for changed identity blocking, shared individual-owner blocking, event collisions, unresolved scope blocking, replay and profile preservation.
- Rameeza merge tests passed for shared-sheet rejection, replay and full historical score/evidence preservation.
- Eight route/copy regression tests, TypeScript and targeted lint passed for the description display fix.

## Durable import inventory

1. `01-import-worlds-asian-subset.sql`: 44 initially unambiguous entries, 528 race scores, 8 new profiles.
2. `02-merge-confirmed-rameeza.sql`: user-confirmed directed duplicate consolidation with preflight and preservation guards.
3. `03-complete-confirmed-identities.sql`: Nana and Rameeza, 24 scores, 1 new profile, the final scope note and a durable separate-sailor decision.

The initial manifest's pending fields describe its historical stage. `final-overall-2026.json` and this report describe the completed import. Every transaction fails safely on unexpected data. The initial stage can be replayed before completion; after completion, its 44-entry count guard prevents accidental reapplication to a changed inventory. Completion and merge replays were tested independently.

Private before-state snapshots remain outside version control. Source results and public identity plans, validators, SQL and verification summaries are retained in the import folder. The PDFs and rendered source images remain in the working output folder.

No unresolved identity questions remain for this import. Non-Asian entries can be added later; the current public result model requires a sailor profile for every entry.
