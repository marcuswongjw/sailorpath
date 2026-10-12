# SailorPath — Remaining 29er Composite Identity Map

**Assessment date:** 2026-10-11; **execution update:** 2026-10-12
**Scope:** Seven remaining synthetic/composite 29er profiles assessed from independent evidence and then reconciled using user-confirmed identity mappings. This report preserves both the read-only identity map and the completed production-data outcome.

## Decision summary

| Composite (handle) | Individual candidates and profile direction | Confidence and concise source evidence | Follower / dependency handling | Clear recommendation |
|---|---|---|---|---|
| **Cheryl Yong / Febe Wong** (`cheryl-yong-febe-wong-2b94f6`) | **Existing:** Cheryl Yong Heng Xi (`b887d7b9-e768-4024-b4bd-16455e87835b`; `cheryl-yong-heng-xi-csc25`) and Febe Wong Qi Ke (`97297f2f-45a3-4a42-bb8b-7de07d9a5cde`; `febe-wong-qi-ke-06fwa1t`). All four results now have **1. Cheryl Yong Heng Xi; 2. Febe Wong Qi Ke** participant links. | **High.** Live data confirms four 29er results with the unchanged label `Cheryl Yong / Febe Wong`; Team Singapore, HHYC/Sailwave, rendered SYSC 2024 results, Pulau Ujong results, and Sail-World corroborate the pairing and names. Source order establishes membership only, not helm/crew. | The pair-level follower already followed **both** individual profiles, so the redundant team follow and legacy composite could be removed without changing their individual follows. | **COMPLETED** — the four legacy primary links now resolve to Cheryl Yong Heng Xi; all participant links, labels, results, scores, verification, and event metadata are unchanged. |
| **Cheryl Ho / Gemma Chen** (`cheryl-ho-gemma-chen-81e35e`) | **Existing:** Cheryl Ho Hai Yan (`61b1d74c-edcd-4730-b606-d3ae3264d658`; confirmed by user as **Cheryl Ho**) and Gemma Chen Huang Heng (`688cc8ae-873e-40a3-9bc4-7d05a496994a`; `gemma-chen-huang-heng`). All three results now use **1. Cheryl Ho; 2. Gemma Chen**. | **High.** Three verified 29er entries preserve `Cheryl Ho / Gemma Chen`; Hong Kong Race Week / Asian Championship entry and Day-1 results place the pair on 2869, and Singapore Sailing confirms the Pulau Ujong placement. | The composite follower already followed both individual profiles, so no new follow was created. The composite follow was removed with the retired composite. | **COMPLETED** — a `Cheryl Ho` alias was added to Cheryl Ho Hai Yan; legacy results were converted atomically and the composite was removed. |
| **Sean Kum / Nigel Tan** (`sean-kum-nigel-tan-04a977`) | **Existing:** Sean Kum Kok Wei (`sean-kum-kok-wei`) and Nigel Tan Xu Yuan (`nigel-tan-xu-yuan`). All three results now use **1. Sean Kum Kok Wei; 2. Nigel Tan Xu Yuan**. | **High.** Local name mappings resolve source variants, Nigel's live aliases include `Nigel Tan`, and Pulau Ujong/Cincapura official results retain the same ordered label. International 29er Class independently describes them as the two-person 29er team. | The composite follower already followed both individual targets; no duplicate follows were created. | **COMPLETED** — participant links were replaced atomically and the synthetic composite was removed. |
| **Nicole Ng / Ezann Sephira Tan** (`nicole-ng-ezann-sephira-tan`) | **User-confirmed:** Nicole Ng → new individual **Nicole Ng Hui Hong** (`nicole-ng-hui-hong`), with `Nicole Ng` added as an alias. **Existing:** Ezann Sephira Tan (`af3b51f0-60c2-4690-83fb-5e40af186579`; `ezann-sephira-tan-safyc23`). Both results now use the original source order. | **User-confirmed.** SYSC 2024 reviewed record and official SNSC entry list preserve the ordered pair and SGP 2467 as event equipment; the user resolved the Nicole identity uncertainty. | The guarded production preflight found no follower or coaching dependency requiring migration. | **COMPLETED** — the two results were converted without changing labels, event equipment, result rows, or score sets. |
| **Cheryl Ho & Hayley Fang** (`cheryl-ho-hayley-fang-sysc24`) | **Existing:** Cheryl Ho Hai Yan (`61b1d74c-edcd-4730-b606-d3ae3264d658`; `cheryl-ho-hai-yan-0mjmr1q`) and Hayley Fang (`61cd2cae-f8ba-48bc-9b3f-ace4c5d4878a`; `hayley-fang-safyc24`). The SYSC 2024 result now uses both profiles in source order. | **High.** One composite-linked SYSC 2024 result retains `Cheryl Ho & Hayley Fang`; reviewed/matched local records preserve it and the public 2024 notice board expands Cheryl to Cheryl Ho Hai Yan in the same ordered entry. | The preflight found no follower or coaching dependencies. | **COMPLETED** — two individual participant links replace the legacy row; the composite was removed. |
| **Cheryl Yong Heng Xi / Annika Chui** (`historical-2024-csc-29er-jan-2024-43686572796c20596f`) | **Existing:** Cheryl Yong Heng Xi (`cheryl-yong-heng-xi-csc25`) and Annika Chui (`annika-chui-safyc24`). The CSC 2024 result now uses both profiles in source order. | **High.** Rendered/visually inspected official CSC provisional results show the exact row, sail no. 8, ordered names, seven race scores, best-six 16, and overall 3. | The preflight found no follower or coaching dependencies. | **COMPLETED** — two individual participant links replace the legacy row; historic sail and all score data remain unchanged. |
| **Nicole Ng Hui Hong / Ezann Sephira Tan** (`historical-2024-csc-29er-jan-2024-4e69636f6c65204e67`) | **New individual created:** Nicole Ng Hui Hong (`nicole-ng-hui-hong`); **existing:** Ezann Sephira Tan (`ezann-sephira-tan-safyc23`). The CSC 2024 result now uses both profiles in source order. | **High.** Rendered/visually inspected official CSC provisional results identify the exact rank-2 row, ordered names, SAFYC/female 29er context, and total 17/net 12. | The guarded preflight found no follower or coaching dependencies. | **COMPLETED** — the result and all scores/labels were preserved; the composite was removed. |

## Conversion controls common to all approved cases

1. **Preserve source facts.** Do not change the existing result row, source `entry_label`, race scores, ranks, totals/nett values, verification state, or event equipment/sail provenance.
2. **Model membership, not roles.** Source display order is the participant order only. Unless independently established, set both rows to `role=unknown`, `match_status=matched`, and `ranking_credit=false`.
3. **One entry, one score set.** Add matched participant links; never duplicate results or race scores, and never merge a composite profile into a named sailor.
4. **Use an atomic conversion.** Create required individual profiles, replace participant links, handle follows, change any transitional legacy primary link, recheck dependencies, and only then delete/retire a composite when the case recommendation permits it.
5. **Respect composite follows.** A follow of a pair does not imply a preference for either sailor. Only follow the explicit per-case instructions; do not expose follower identity in public conversion records.

## Execution outcome — 12 October 2026

- **Individual profile created:** Nicole Ng Hui Hong, with **Nicole Ng** retained as a searchable alias.
- **Alias added:** **Cheryl Ho** now resolves to the existing Cheryl Ho Hai Yan profile, as confirmed by the user.
- **Results reconciled:** 15 existing 29er result rows retained their IDs, labels, ranks, totals/nett, verification state, event equipment, and race scores.
- **Participant conversion:** 15 legacy composite participant rows were replaced by **30** matched individual participant links. All retain `role=unknown` and `ranking_credit=false`.
- **Composites removed:** 7, after dependency/follower guards passed. Cheryl Yong / Febe Wong was retired after confirming its former pair-level follower already followed both individual sailors.
- **Integrity checks:** every reconciled result has exactly two individual participant links; no composite-name sailor profiles remain; there are no results without a participant and no participant links to a missing sailor.

## References

### Cheryl Yong / Febe Wong

- Live SailorPath search: <https://sailorpath.com/api/search?q=Cheryl%20Yong>; <https://sailorpath.com/api/search?q=Febe%20Wong>
- Team Singapore athlete page: <https://www.teamsingapore.sg/athletes/cheryl-yong-heng-xi>
- HHYC/Sailwave 2024 29er results: <https://sailwave.com/results/HHYC/ODR2024_D1_C4.htm>
- Pulau Ujong results: <https://www.racingrulesofsailing.org/documents/176520>
- Sail-World pairing coverage: <https://www.sail-world.com/photo/478092>
- Local evidence: `/Users/marcus/Documents/GitHub/sailorpath/artifacts/imports/sysc-2024/classes.pdf`; `/Users/marcus/Documents/GitHub/sailorpath/.work/identity-cheryl-yong-febe-wong/sysc-2024-classes-page-1.png`

### Cheryl Ho / Gemma Chen

- Live SailorPath searches: <https://sailorpath.com/api/search?q=Cheryl%20Ho&type=sailors&limit=30>; <https://sailorpath.com/api/search?q=Gemma%20Chen&type=sailors&limit=30>
- Authoritative event coverage: <https://www.rrs.sh/competitors/12853/event?page=5>; <https://www.sail-world.com/news/293311/29er-Asian-Championship-2026-day-1>; <https://www.facebook.com/SingaporeSailing/posts/1361525406007780/>
- Local migration/source evidence: `/Users/marcus/Documents/GitHub/sailorpath/src/db/migrations/076_add_pulau_ujong_2026_results.sql`; `/Users/marcus/Documents/GitHub/sailorpath/src/db/migrations/084_import_ilca_board_and_skiff_results.sql`; `/Users/marcus/Documents/GitHub/sailorpath/src/db/migrations/093_csc_optimist_championship_2025_results.sql`; `/Users/marcus/Documents/GitHub/sailorpath/src/db/migrations/095_csc_ilca_29er_open_2025_results.sql`

### Sean Kum / Nigel Tan

- SailorPath searches: <https://sailorpath.com/search?query=Sean%20Kum%20Kok%20Wei&type=sailors>; <https://sailorpath.com/search?query=Nigel%20Tan%20Xu%20Yuan&type=sailors>
- Official result pages: <https://www.racingrulesofsailing.org/documents/176520>; <https://www.racingrulesofsailing.org/documents/199363>
- International 29er Class coverage: <https://www.29er.org/news/2026-asian-championships-day-2/>
- Local identity/import evidence: `/Users/marcus/Documents/GitHub/sailorpath/.work/double-handed-entries/scripts/imports/rsyc-2024/reviewed-results.json`; `/Users/marcus/Documents/GitHub/sailorpath/.work/double-handed-entries/scripts/imports/safyc-2023/reviewed-results.json`; `/Users/marcus/Documents/GitHub/sailorpath/src/db/migrations/105_add_regatta_result_participants.sql`

### Nicole Ng / Ezann Sephira Tan

- Live SailorPath search: <https://sailorpath.com/api/search?q=Nicole%20Ng%20Ezann%20Sephira%20Tan&type=sailors&limit=20>; <https://sailorpath.com/api/search?q=Nicole%20Ng&type=sailors&limit=50>; <https://sailorpath.com/api/search?q=Ezann%20Sephira%20Tan&type=sailors&limit=50>
- Official SNSC entry source: <https://www.racingrulesofsailing.org/competitors/9423/event?page=4>
- Local reviewed sources: `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/sysc-2024/reviewed-results.json`; `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/sysc-2024/matched-results.json`; `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/sysc-2024/name-review.md`; `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/safyc-2023/name-review.md`; `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/official-2024-missing/sql/csc-29er.sql`; `/Users/marcus/Documents/GitHub/sailorpath/src/db/migrations/105_add_regatta_result_participants.sql`

### Cheryl Ho & Hayley Fang

- SailorPath references: <https://sailorpath.com/api/health>; <https://sailorpath.com/api/search?q=cheryl-ho-hayley-fang-sysc24&type=sailors&limit=20>; <https://sailorpath.com/api/search?q=Cheryl%20Ho&type=sailors&limit=50>; <https://sailorpath.com/api/search?q=Hayley%20Fang&type=sailors&limit=50>
- Public corroboration: <https://www.racingrulesofsailing.org/competitors/7928/event?page=4>; <https://www.facebook.com/SingaporeSailing/posts/our-29er-sailors-amos-tham-seth-low-ezann-tan-nicole-ng-cheryl-yong-febe-wong-ha/914367224056936/>
- Local reviewed records: `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/sysc-2024/reviewed-results.json`; `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/sysc-2024/matched-results.json`

### Cheryl Yong Heng Xi / Annika Chui

- Official/archived sources: <https://drive.google.com/file/d/1LVa-q0PXnBVRqWELr2xVeMVr34A1NUyN/view?usp=drive_link>; <https://www.csc.org.sg/2024/01/15/csc-ilca-29er-open-day-2/>
- Local visual/source evidence: `/Users/marcus/Documents/GitHub/sailorpath/.work/2024-missing-import/pdfs/csc-29er.pdf`; `/Users/marcus/Documents/GitHub/sailorpath/tmp/identity-assessment-cheryl-yong-annika-chui/official-csc-29er-pdfjs-page-1.png`; `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/official-2024-missing/sql/csc-29er.sql`

### Nicole Ng Hui Hong / Ezann Sephira Tan

- Official CSC provisional-results PDF: <https://www.csc.org.sg/wp-content/uploads/2021/10/29er-Result-Summary-3.pdf>
- SailorPath evidence: <https://sailorpath.com/api/search?q=Nicole%20Ng%20Hui%20Hong>; <https://sailorpath.com/api/search?q=Ezann%20Sephira%20Tan>
- National School Games corroboration: <https://www.racingrulesofsailing.org/documents/185038>
- Local visual/source evidence: `/Users/marcus/Documents/GitHub/sailorpath/tmp/identity-map-nicole-ezann/csc-29er-page-01-white.png`; `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/official-2024-missing/sql/csc-29er.sql`
