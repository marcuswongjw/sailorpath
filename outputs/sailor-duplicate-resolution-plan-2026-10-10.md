# Sailor Duplicate Resolution Plan

**Refreshed:** 10 October 2026, 23:19 SGT
**Scope:** live SailorPath Supabase data, read-only verification
**Status:** approved batch completed on 11 October 2026, 06:48 SGT

## Recommended first batch — 11 confirmed individual identity groups

All source profiles below are **unclaimed** (`parent_id IS NULL`). Each source profile is a historical import and its result/participant history is unique to that profile. There are **no shared-regatta conflicts** between a source and its proposed survivor.

The approved batch was designed to:

- retain the listed **Keep** profile;
- move the source profile's result and participant links to the survivor;
- preserve aliases and supported dependent records;
- delete **12 superseded source profiles** after their dependencies are reconciled;
- move **17 results** and **17 participant links**; and
- leave all published result rows in place (no scoring conflict needs reconciliation in this batch).

## Execution outcome

The approved batch was executed as one guarded, atomic transaction after the administrator merge screen exceeded the browser's safe render limit. The transaction repeated the material safeguards of the merge service for this specifically preflighted dataset: it required all 12 sources to remain unclaimed, rejected any source/survivor regatta or participant conflict, and rejected any unplanned dependent record before making a change.

| Verified outcome | Result |
|---|---:|
| Historical source profiles deleted | 12 |
| Result rows reassigned | 17 |
| Participant links reassigned | 17 |
| Result entries without a participant | 0 |
| Participant links to a missing sailor | 0 |
| Live sailor profiles after cleanup | 946 |
| Live result rows after cleanup | 7,882 |
| Live participant links after cleanup | 7,882 |

All 12 approved sources are absent. The **20 currently existing deferred profiles** remain unchanged. `Keith Lo Jin`, referenced in the initial audit, was already absent from the live database before this batch and was not part of the operation.

| # | Keep profile | Historical source profile to merge and remove | Live evidence | Results / participant links moved |
|---:|---|---|---|---:|
| 1 | Abigail Jia En Ling (`abigail-jia-en-ling-7e546c7319`) | Abigail Ling Jia En (`historical-2024-raffles-marina-ilca6-mar-2024-d4701d9556b0`) | Same tokenised name; shared identifier `2179`. | 2 / 2 |
| 2 | Charlotte Wee Shuen Lee (`charlotte-wee-shuen-lee-0e1eef7796`) | Charlotte Lee Wee Shuen (`historical-2024-csc-ilca6-jan-2024-4d7533c815a8`) | Same tokenised name; shared sail `214235`. | 1 / 1 |
| 3 | Elisha Lim Yu Ting (`elisha-lim-yu-ting-csc25`) | Lim Yu Ting Elisha (`historical-2024-csc-ilca6-jan-2024-2b5965c8e360`) | Same tokenised name; shared sail `214808`. | 1 / 1 |
| 4 | Isaac Poon Weng-Yew (`isaac-poon-weng-yew`) | Isaac Poon Weng Yew (`historical-2024-csc-ilca4-jan-2024-2aaa8d10b22f`) | Hyphen-only name variation; shared sail `214841`. | 2 / 2 |
| 5 | Jun Hao Lo (`jun-hao-lo-ee545a`) | Lo Jun Hao (`historical-2024-national-slalom-windsurfing-2024-a6349b6d1a19`) | Same tokenised name; `21` / `SGP 21` equipment continuity. | 4 / 4 |
| 6 | Lo Tian Walker John (`lo-tian-walker-john`) | John Lo Tian Walker (`historical-2024-csc-ilca6-jan-2024-f98cf849048d`) | Same tokenised name; shared sail `214849`. | 1 / 1 |
| 7 | Mathias Yu Da Wong (`mathias-yu-da-wong-445c0f0f75`) | Mathias Wong Yu Da (`historical-2024-csc-ilca4-jan-2024-8522724bcc56`) | Same tokenised name; shared sail/ILCA number `222255`. | 1 / 1 |
| 8 | Samuel Tan-Hardy (`samuel-tan-hardy`) | Samuel Tan Hardy (`historical-2024-csc-ilca4-jan-2024-ce28e2eddee3`) | Hyphen-only name variation. | 1 / 1 |
| 9 | Danielle Lai (`danielle-lai-j28wya2`) | Daniellle Lai (`historical-2024-csc-ilca4-jan-2024-235c5f5e2f7a`) | One-character typo; shared ILCA number `222257`. | 1 / 1 |
| 10 | Tiago Cheng De Villemor Salgado (`tiago-cheng-de-villemor-salgado-20ctrxe`) | Tiago Chen g De Villemor Salgado (`historical-2024-csc-ilca4-jan-2024-34781f21a793`) **and** Tiago De Villemor Salgado (`historical-2024-47th-singapore-ilca-open-ilca4-2024-4fd4322f963b`) | One source splits “Cheng”; the other omits it. Both match `222437` / `HKG 222437`. | 2 / 2 |
| 11 | Lukas Kiesselbach (`lukas-kiesselbach-fylbfoc`) | Lukas Kiasselbach (`historical-2024-csc-ilca4-jan-2024-2e236182d582`) | Clear vowel typo; shared sail/ILCA number `221597`. | 1 / 1 |

## Deliberately deferred

These profiles are **not** in the recommended merge batch.

| Category | Profiles / action | Why deferred |
|---|---|---|
| Identifier conflict | Edward Charles O’Shea ↔ Edward Charles O Shea | Names align, but the historical record uses `92` while the retained profile records `53` / `59`. Confirm the CSC entry sheet before merging. |
| No corroborating identifier | Lo Jin Keith ↔ Keith Lo Jin | Token order aligns, but no matching sail, board, or current alias evidence was found. Review the source sheet. |
| Source-sheet review | Ker Wan Chew, Jun Ler Chuah, Wanzhi Elva Li, John Tze Xiang Wong, Zixi Lu | Exact/reordered names but incompatible board or sail identifiers. Do not infer an equipment change without source evidence. |
| Explicitly separate | Ryan Lo (three profiles) | The live records use conflicting identifiers and the short name is not sufficient evidence. Leave separate. |
| Legacy crew placeholders | Amos Tham / Seth Low; Seth Low / Amos Tham; Cheryl Yong / Seth Low; Seth Low Yu Herng & Amos Tham | These are composite 29er/team profile placeholders, not individual sailors. They must be converted into individual participant links, not merged into another composite profile. No individual Amos Tham or Seth Low profile currently exists. |

## Safeguards

1. Prefer the deployed sailor-merge service; use a guarded direct transaction only when its exact preflight proves that no additional dependent record needs reconciliation.
2. Revalidate the row counts and survivor profiles after the transaction batch.
3. Keep the deferred cases unchanged until their PDF source sheets have been rendered and visually reviewed, in line with the repository's regatta-import rules.
4. Handle legacy team placeholders in a dedicated crew-reconciliation pass after individual sailor profiles have been created or confidently resolved.
