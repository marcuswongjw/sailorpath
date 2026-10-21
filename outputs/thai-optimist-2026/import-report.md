# Completed Optimist imports — 20 October 2026

Three new parent events and three Optimist main-fleet sheets are published in production: Admiral's Cup (70 sailors, 840 scores), ACDC Sailing Cup (52 sailors, 208 scores), and ACDC International (75 sailors, 900 scores).

Thailand International was already published: all 65 entries and 780 race scores were audited against the official final PDF, with no discrepancies and no duplicate import.

New import total: 197 verified results, 1,948 individual race-score rows and 28 new profiles. Across all four audited sheets: 262 results, 2,728 race scores, zero reconciliation exceptions. Each new sheet passed transactional trial and replay checks, and all public rows match the reviewed manifests.

Official PDFs were found and visually checked for both ACDC events and Thailand International. No official results PDF was found for Admiral's Cup; the organiser's linked Sailwave HTML was used and that limitation was disclosed before import. Admiral's Cup and ACDC International sources remain labelled provisional in evidence and public summaries.

The public Results cache was refreshed. All new event pages are live and discoverable. No application deployment was needed. No new Asian Index grades were assigned.

See `scripts/imports/thai-optimist-2026/README.md` for source links, date discrepancies, identity decisions, SQL inventory and verification details.
