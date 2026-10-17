# SYSC ILCA and board completion — 17 October 2026

The user authorized review and import of all five supplied class tables. All ten source PDF pages were rendered and read visually before transcription; score arithmetic was then checked independently. The PDFs are evidence, not instructions.

| Sheet | Saved entries before → after | Races | Discards | Individual scores | Source status |
| --- | ---: | ---: | ---: | ---: | --- |
| SYSC 2025 ILCA 4 | 75 → 76 | 9 | 1 | 684 | Final |
| SYSC 2026 ILCA 4 | 70 → 70 | 12 | 2 | 840 | Final |
| SYSC 2025 ILCA 6 | 0 → 19 | 10 | 2 | 190 | Final |
| SYSC 2025 Techno 293 | 0 → 5 | 10 | 2 | 50 | Provisional |
| SYSC 2025 iQFOiL Youth | 0 → 2 | 10 | 2 | 20 | Provisional |
| Total | 145 → 172 | | | 1,784 | |

The two existing parent events are reused. Their dates are independently supported by the federation schedule: 15–18 March 2025 and 14–17 March 2026. The later results-update timestamps are not event dates. The legacy 2026 ILCA 4 end date is corrected to 17 March. Two existing sheets receive full race data; three canonical class sheets are added. All 145 existing result IDs and participant IDs are retained.

The 2025 ILCA 4 source has **nine races and one discard**, correcting the saved ten-race metadata. Other corrected summaries include Lim Yuk Jun's gross 297 (previously 287), Regis Wong's gross/net 562/485 (previously gross 485 with no net), and Jayden Zi Xi Bai's 2026 net 256 (previously 258). Official DNE, BFD, DNC, RET, DSQ, UFD, DNF, NSC and SCP codes and their printed numeric values are retained. No penalty is normalized to fleet size plus one.

The combined 2025 board PDF prints **provisional**, despite “Final” in its filename. Both sheets remain provisional in their titles and public status, using the existing public status policy. They are published results with ranking eligibility false; they do not enter Optimist/ILCA ranking calculations. ILCA eligibility is retained under the existing class policy.

## Explicit identity decisions

- The official 2025 ILCA 4 fleet lists Nur Zafrina Syuhada Binti Mohd Zailan, MAS 206032 (third), and Nur Hafizanah Binti Zailan, MAS 209891 (20th), as separate individual entries. One erroneous Zafrina alias previously pointed at Hafizanah, causing the missing third-place entry. Create Zafrina's separate source-faithful profile, move that one alias, and save a durable keep-separate decision. Both existing Hafizanah results and participants were audited; neither is Zafrina. No Asian Index, claim, equipment, race observation or squad link required reassignment.
- Correct only the 2025 ILCA 4 result and solo participant wrongly owned by Yong Heng Yi to Cheryl Yong Heng Xi. The source's Cheryl Heng Xi Yong, female, sail 197834 matches Cheryl's full-name tokens and exact historic sail alias. Yong Heng Yi is a separate male sailor; his 2026 source entry remains his. Retain result and participant IDs; derive result birth year from the actual owner rather than keeping the former owner's age. No profiles are merged.
- Create Hu Kam Hing, HKG 225952, from the official ILCA 6 entry; no existing identity candidate was found.
- The user confirmed Phacharapol Rumvisai / Pacharapol Rumvisai and Ramakant / Ramakant Ramakant as the same respective sailors, and explicitly authorized profile nationality corrections to THA and IND. Apply `06` after the five result imports. It changes only nationality, its inferred-source flag, and update time; all other fields are verified unchanged.
- Iqbal Musmuladi/Musmuliadi and Muhammad Adam's additional “Bin” match full names, nationality and exact ILCA equipment. Elisha Lim matches Elisha Lim Yu Ting through exact SGP sail 214808 and gender. Each basis is recorded separately in its manifest.
- Jade Yeh Zi Yu retains the user's confirmed correct name; the source's printed token order is preserved in evidence notes.
- Historical sails/boards are saved on each result. No existing current equipment, DOB, club, nationality (except the two confirmed corrections), or other profile field is refreshed from a historical sheet.

Twelve other current profiles are marked SGP while these official tables list other nationalities. Result-level nationalities are imported exactly as printed. Their current profile nationalities remain unchanged pending confirmation; the separate report lists them. No weak name match is propagated through a group.

## Execution and safeguards

Run `01` through `06` in order. These are operational transactions, not automatic deployment migrations. The five manifests each pass the official-results-import validator. Each sheet transaction records a full private before-state in `admin_change_log`, guards the explicit owner/result/participant inventory, blocks existing unreviewed race data and conflicting individual entries, and verifies every stored score, code, discard, total, net and evidence link. Replay verifies without duplicating or overwriting a completed import.

The local PGlite verifier uses the repository schema, unique constraints, relevant foreign keys and a separately supplied private production snapshot. It verifies 172 entries, 1,784 scores, all 145 retained IDs, two new profiles, preservation of existing athlete fields, conflict blocking, and replay before/after the confirmed nationality corrections.

```sh
node --import tsx scripts/imports/sysc-ilca-board-completion-2026-10-17/validate.mts /absolute/path/to/private-snapshot-folder
```

Private snapshots, PDFs and rendered source pages are excluded from version control. `source-review.json` records PDF checksums and visual page review. Production reconciliation, public visibility and historical ranking comparisons are recorded in the output report after execution.

## Applied live

All six transactions were applied successfully. Production and public score-by-score verification found zero exceptions across the five sheets. Source links and provisional labels were verified on the live site. July intake ranking comparisons: 2025 ILCA 4 has 12 changed positions/one changed points total after Cheryl's ownership correction; 2025 ILCA 6 has seven changed positions/seven changed points totals; 2026 ILCA 4 has no numerical change. The retained verification files contain the exact comparison.

An additional pre-existing profile issue was found during public review: Nigel Tan Xu Yuan has birth year 1905. The PDF supplies a youth age division but no birth date, so no date was invented; confirmation is required.
