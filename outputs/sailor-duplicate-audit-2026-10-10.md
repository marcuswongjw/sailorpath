# Live Sailor Duplicate Audit

**Run:** 10 October 2026, 18:03 SGT
**Scope:** live SailorPath Supabase data, read-only
**No records were changed.**

## Summary

| Measure | Count |
|---|---:|
| Sailor profiles scanned | 958 |
| Aliases scanned | 1,758 |
| Regatta results considered for survivor selection | 7,882 |
| Exact-name identity groups | 17 |
| Profiles in exact-name groups | 35 |
| Potential duplicate profiles from exact-name groups | 18 |
| Additional spelling-variant groups | 3 |
| Additional likely duplicate profiles | 4 |

> **Finding:** There are **20 duplicate-candidate groups**, representing **up to 22 profiles that may be consolidated**. Fourteen groups have a strong survivor recommendation. Six exact-name groups need a quick check against the source result sheets because their sail/board identifiers conflict or are absent.

## Detection method

I compared every live profile using:

1. **Normalized, token-order-insensitive names** — casing, punctuation, hyphens, spacing, and surname/given-name order do not affect a match.
2. **Alias collisions** — an alias on one profile resolving to another profile’s canonical name.
3. **High-similarity spelling variants** supported by matching primary/ILCA sail identifiers or club/class context.
4. **Profile history** — result-count and creation time were used only to suggest a survivor.

Sail, ILCA, and board numbers were **not treated as unique identity keys on their own**, because the live roster contains legitimate equipment-number reuse across people and classes.

## High-confidence consolidation candidates

These rows have a full normalized-name match, an alias conflict, or a strong typo-plus-identifier match. The recommended survivor is the established/non-historical profile with the fuller result history.

| # | Keep | Merge candidate(s) | Evidence | Recommended action |
|---:|---|---|---|---|
| 1 | **Abigail Jia En Ling** (`abigail-jia-en-ling-7e546c7319`, 12 results) | Abigail Ling Jia En (`historical-2024-raffles-marina-ilca6-mar-2024-d4701d9556b0`, 2) | Same name tokens; Abigail’s ILCA 4 number and the historical profile’s primary number are both **2179**. | Merge into Abigail Jia En Ling. |
| 2 | **Amos Tham / Seth Low** (`amos-tham-seth-low`, 1) | Seth Low / Amos Tham (`historical-2024-csc-29er-jan-2024-53657468204c6f7720`, 1) | Same two-person 29er crew, reversed order. | Merge the crew profiles, retaining the non-historical profile. |
| 3 | **Edward Charles O’Shea** (`edward-charles-o-shea-safyc23`, 3) | Edward Charles O Shea (`historical-2024-csc-ilca4-jan-2024-67c192c88685`, 1) | Exact normalized name; the established profile already stores the equivalent spelling as an alias. | Merge into Edward Charles O’Shea. |
| 4 | **Charlotte Wee Shuen Lee** (`charlotte-wee-shuen-lee-0e1eef7796`, 7) | Charlotte Lee Wee Shuen (`historical-2024-csc-ilca6-jan-2024-4d7533c815a8`, 1) | Same name tokens and primary sail **214235**. | Merge into Charlotte Wee Shuen Lee. |
| 5 | **Mathias Yu Da Wong** (`mathias-yu-da-wong-445c0f0f75`, 15) | Mathias Wong Yu Da (`historical-2024-csc-ilca4-jan-2024-8522724bcc56`, 1) | Same name tokens; both primary and ILCA 4 identifiers are **222255**. | Merge into Mathias Yu Da Wong. |
| 6 | **Elisha Lim Yu Ting** (`elisha-lim-yu-ting-csc25`, 9) | Lim Yu Ting Elisha (`historical-2024-csc-ilca6-jan-2024-2b5965c8e360`, 1) | Same name tokens and primary sail **214808**. | Merge into Elisha Lim Yu Ting. |
| 7 | **Jun Hao Lo** (`jun-hao-lo-ee545a`, 3) | Lo Jun Hao (`historical-2024-national-slalom-windsurfing-2024-a6349b6d1a19`, 4) | Same name tokens; the established profile’s sail **21** aligns with the historical board identifier **SGP 21**. | Merge into Jun Hao Lo. |
| 8 | **Samuel Tan-Hardy** (`samuel-tan-hardy`, 6) | Samuel Tan Hardy (`historical-2024-csc-ilca4-jan-2024-ce28e2eddee3`, 1) | Exact normalized name; hyphen-only variation and an existing canonical alias. | Merge into Samuel Tan-Hardy. |
| 9 | **Isaac Poon Weng-Yew** (`isaac-poon-weng-yew`, 4) | Isaac Poon Weng Yew (`historical-2024-csc-ilca4-jan-2024-2aaa8d10b22f`, 2) | Exact normalized name; primary sail **214841**. | Merge into Isaac Poon Weng-Yew. |
| 10 | **Lo Jin Keith** (`lo-jin-keith-safyc24`, 3) | Keith Lo Jin (`historical-2024-csc-ilca4-jan-2024-dbb879f1175b`, 1) | Same three name tokens, reordered. | Review briefly, then merge into Lo Jin Keith if the CSC ILCA 4 source confirms the identity. |
| 11 | **Lo Tian Walker John** (`lo-tian-walker-john`, 2) | John Lo Tian Walker (`historical-2024-csc-ilca6-jan-2024-f98cf849048d`, 1) | Same name tokens and primary sail **214849**. | Merge into Lo Tian Walker John. |
| 12 | **Danielle Lai** (`danielle-lai-j28wya2`, 15) | Daniellle Lai (`historical-2024-csc-ilca4-jan-2024-235c5f5e2f7a`, 1) | One-character spelling error; same ILCA 4 identifier **222257**. | Merge into Danielle Lai. |
| 13 | **Tiago Cheng De Villemor Salgado** (`tiago-cheng-de-villemor-salgado-20ctrxe`, 13) | Tiago Chen g De Villemor Salgado (`historical-2024-csc-ilca4-jan-2024-34781f21a793`, 1); Tiago De Villemor Salgado (`historical-2024-47th-singapore-ilca-open-ilca4-2024-4fd4322f963b`, 1) | One token was split in one import; another omits “Cheng”; all point to ILCA identifier **HKG 222437 / 222437**. | Merge both historical profiles into Tiago Cheng De Villemor Salgado. |
| 14 | **Lukas Kiesselbach** (`lukas-kiesselbach-fylbfoc`, 14) | Lukas Kiasselbach (`historical-2024-csc-ilca4-jan-2024-2e236182d582`, 1) | Clear vowel typo; matching primary and ILCA 4 number **221597**. | Merge into Lukas Kiesselbach. |

## Exact-name groups requiring source-sheet review

The names are equally strong matches, but the imported record carries a different or absent identifier. Do not merge blindly; verify the original result sheet or event entry first.

| # | Profiles | Reason to review | Suggested outcome after verification |
|---:|---|---|---|
| 15 | **Ker Wan Chew** (`ker-wan-chew-443f2ea9f0`, board 14, 4 results) ↔ Chew Ker Wan (`historical-2024-national-slalom-wingfoil-2024-f3cb0684b906`, board 39, 3) | Same full name in reversed order but different board numbers. | If one sailor changed board, merge into Ker Wan Chew; otherwise retain both. |
| 16 | **Jun Ler Chuah** (`jun-ler-chuah-16-nsc25`, board 16, 5) ↔ Chuah Jun Ler (`historical-2024-sg-foil-grand-prix-wingfoil-2024-f242d90cd951`, board 26, 1) | Exact name tokens but board 16 versus 26. | Confirm board/history, then merge into Jun Ler Chuah if the same athlete. |
| 17 | **Wanzhi Elva Li** (`wanzhi-elva-li-sysc24`, sail HKG 220859, 1) ↔ Elva Li Wanzhi (`historical-2024-csc-ilca4-jan-2024-3cfd2346bbff`, sail/ILCA 220895, 1) | Exact name tokens; two similar but non-matching Hong Kong sail numbers. | Check the source registration/sail number before selecting a survivor. |
| 18 | **John Tze Xiang Wong** (`john-tze-xiang-wong-dca52132f8`, board 2, 10) ↔ John Wong Tze Xiang (`historical-2024-national-slalom-windsurfing-2024-ed025f625253`, board SGP 36, 3) | Exact name tokens but different board numbers. | Check the 2024 slalom source; merge into John Tze Xiang Wong if confirmed. |
| 19 | **Ryan Lo** (`ryan-lo-ae5d31`, sail 17, 3) ↔ Ryan Lo (`historical-2024-sg-foil-grand-prix-wingfoil-2024-092776f5c45e`, board 12, 1) ↔ Ryan Lo (`historical-2024-sg-foil-grand-prix-wingfoil-2024-de7e26cb08ca`, board 55, 1) | Three profiles share a short, common name but have incompatible equipment identifiers. | **Do not merge automatically.** Compare event-entry details before any consolidation. |
| 20 | **Zixi Lu** (`zixi-lu-bd75e0db5f`, sail 214664, 3) ↔ Lu Zixi (`historical-2024-csc-ilca4-jan-2024-18d7373c7fd0`, sail/ILCA 93, 2) | Exact name tokens but distinct sail fields. | Confirm from the CSC ILCA 4 source before merging into Zixi Lu. |

## Previously adjudicated near-matches retained as separate

The current audit also surfaced `Ange Chew` / `Angel Chew` as a text-similar pair. The repository’s 2023 identity review explicitly records them as **separate sailors** (different gender and equipment), so they are intentionally excluded from the merge list.

## Recommended next step

Review the six source-sheet cases above, then merge the confirmed records through the existing **Admin → Possible duplicate sailors** workflow. For all confirmed merges, retain the profile named in the **Keep** column so the longer existing result history stays attached to the canonical record.
