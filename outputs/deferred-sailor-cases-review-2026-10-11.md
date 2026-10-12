# SailorPath Deferred Sailor Cases — Final Recommendations

**Review date:** 11 October 2026
**Scope:** Nine deferred duplicate/attribution/crew-identity cases synthesized from independent assessments. The conflict-free individual actions recorded below were executed after their live preflight.

## Decision summary

| Case | Confidence | Recommendation | Safe action now? |
| --- | --- | --- | --- |
| Edward Charles O’Shea / Edward Charles O Shea | High | Historical profile merged into retained Edward profile | **Completed** |
| Lo Jin Keith / Keith Lo Jin | High | Historical profile merged into Lo Jin Keith | **Completed** |
| Ker Wan Chew / Chew Ker Wan | High | Historical profile merged into retained Ker Wan Chew profile | **Completed** |
| Jun Ler Chuah / Chuah Jun Ler | Medium | Guarded merge into Jun Ler Chuah | **Completed** |
| Wanzhi Elva Li / Elva Li Wanzhi | High | Historical profile merged into retained Wanzhi Elva Li profile | **Completed** |
| John Tze Xiang Wong / John Wong Tze Xiang | High | Historical profile merged into retained John Tze Xiang Wong profile | **Completed** |
| Ryan Lo profiles | High identity evidence | 2024 target results and their event-only placeholders removed; 2025 Ryan profile retained | **Completed** |
| Zixi Lu / Lu Zixi | User-confirmed | Zixi Lu merged into Lu Zixi; nationality set to CHN | **Completed** |
| Legacy 29er composite profiles | User-confirmed | Four composites replaced with separate individual participant profiles | **Completed** |

> **Data-preservation rule for every approved merge:** retain original entry labels, result rows, race scores, source names, and event-specific sail/board identifiers. Historical equipment numbers are provenance, not canonical identity fields; do not overwrite a survivor’s current equipment field merely because an older result used another number.

## Execution outcome

On 11 October 2026, the six conflict-free individual actions were completed in a guarded, atomic transaction:

- **Profiles removed:** 6

- **Result rows reassigned:** 10

- **Participant links reassigned:** 10

- **Result entries without a participant after the transaction:** 0

- **Participant links to a missing sailor after the transaction:** 0

The six historical source profiles are absent.

### Subsequent removal of the 2024 SG Foil WingFoil results

At the user's request, all results from `sg-foil-grand-prix-wingfoil-2024` were removed. After confirming that the event then had no results, race results, participant links, observations, or equipment dependencies, the event record itself was also deleted.

- **Result rows removed:** 12
- **Race-result rows removed by cascade:** 432
- **Participant links removed by cascade:** 12
- **Event-only sailor profiles removed:** 4 — Calvin Ng, Fam Mei Ling, and the two 2024 Ryan Lo placeholders (boards 12 and 55)
- **Empty event record removed:** 1

The retained 2025 Ryan Lo profile, `ryan-lo-ae5d31`, remains with its three 2025 results. No Ryan reconciliation is now needed because both ambiguous 2024 entries were intentionally removed with their source event.

### Final empty-profile cleanup

Jayden Ting Wong was confirmed to have **zero** primary results and **zero** participant links. The profile, its sole alias, and its sole follower link were deleted as instructed. The final post-cleanup scan found no sailor profile without results or participation.

### Confirmed Lu Zixi identity and 29er participant conversion

The user confirmed that **Zixi Lu** and **Lu Zixi** are the same sailor and instructed that **Lu Zixi** be retained with nationality **CHN**. The duplicate profile was removed after three results, three participant links, and one follower link were transferred to Lu Zixi.

The user also confirmed that each 29er entry should use its two individual sailors rather than a composite boat profile. One minimal individual **Seth Low Yu Herng** profile was created. Four composite profiles were deleted after four results were relinked and their four legacy participant rows were replaced by **eight** individual participant rows. Original entry labels and result/race-score records remain unchanged; all participant roles remain `unknown` and ranking credit remains `false`. The one legacy Cheryl/Seth follower link was preserved by following both Cheryl and Seth individually.

## Completed individual merges and target-result removal

### 1. Edward Charles O’Shea / Edward Charles O Shea — **MERGE**

**Completed.** `historical-2024-csc-ilca4-jan-2024-67c192c88685` was merged into `edward-charles-o-shea-safyc23`. The CSC entry label and sail **92** remain on the historical result; the survivor’s current ILCA 4/sail fields were not overwritten.

**Why.** The retained profile already includes the punctuation variant **Edward Charles O'shea**, male Changi/CSC affiliation, and verified 2023–2024 ILCA participation. The visually reviewed CSC sheet records **Edward Charles O Shea**, male, CSC, ILCA 4/L47, sail 92, rank 45, with scores matching the historical import. The different sail number is a documented temporal equipment change: the retained 2023 evidence uses sail 53. A later official NSC registration independently corroborates Edward O'Shea as a 2010-born male Changi sailor.

### 2. Ker Wan Chew / Chew Ker Wan — **MERGE**

**Completed.** `historical-2024-national-slalom-wingfoil-2024-f3cb0684b906` was merged into `ker-wan-chew-443f2ea9f0`. The historical board numbers remain in event history; board 14 was not overwritten.

**Why.** Three visually reviewed 2024 Wingfoil tables identify Chew Ker Wan across boards 17, 39, and 47, proving that board variation is not a separation signal. The 2025 import maps source name Chew Ker Wan to canonical **Ker Wan Chew** for the same male PAssion Wave competitor. Most decisively, a Singapore Sailing federation article names **Ker Wan Chew** as Wingfoil overall winner and refers to that same winner as **Chew Ker Wan** in its prose.

### 3. Jun Ler Chuah / Chuah Jun Ler — **MERGE (guarded)**

**Completed.** `historical-2024-sg-foil-grand-prix-wingfoil-2024-f242d90cd951` was merged into `jun-ler-chuah-16-nsc25`. Number **26** remains in the 2024 Wingfoil result provenance; the board-16 profile field was not overwritten.

**Why.** This is an exact three-token reversal, with male sex in both records. The official 2024 Wingfoil source visibly records Chuah Jun Ler, male, Fun division, number 26, rank 12; the retained profile is Jun Ler Chuah, male, on board 16 in Windsurfing LT/Techno 293 evidence. The numbers occur in different disciplines, not as a same-fleet collision. Confidence remains medium because the 2024 entry is all-DNC and has no club or durable public identity bridge, so use the guarded merge workflow and preserve all source facts.

### 4. Wanzhi Elva Li / Elva Li Wanzhi — **MERGE**

**Completed.** `historical-2024-csc-ilca4-jan-2024-3cfd2346bbff` was merged into `wanzhi-elva-li-sysc24`. Sail **220895** and the SYSC HKG **220859** identifier/nationality context remain event-specific source evidence.

**Why.** The historical CSC row is visibly Elva Li Wanzhi, female ILCA 4, sail 220895; the SYSC result and public entry list identify **Wanzhi Elva Li**, female ILCA 4, HKG 220859. Independent 2024 Hong Kong and ILCA Asian Open entry material ties Wanzhi Elva Li to 220895. Thus, the names are a reversal of the same three tokens and the two sail identifiers are corroborated event registrations for the same unusually specific sailor.

### 5. John Tze Xiang Wong / John Wong Tze Xiang — **MERGE**

**Completed.** The historical **John Wong Tze Xiang** / SGP36 record was merged into the retained **John Tze Xiang Wong** / board-2 profile. SGP36 remains in the 2024 result evidence.

**Why.** The 2024 National Slalom and NE Monsoon sheets repeatedly show the historical token order on SGP36 in Youth Windfoil/Slalom. The decisive bridge is the official 44th Singapore Open 2025 entry: it uses **John Wong Tze Xiang** with **SGP2** in iQFOiL U19 for Aloha. Local and public 2025–2026 records continue John Tze Xiang Wong on board 2, while Team Singapore uses the historical name order for the same Men’s iQFOiL U19 athlete. SGP36 is historical equipment, not contradictory identity evidence.

### 6. Ryan Lo profiles — **2024 TARGET RESULTS REMOVED; EXCLUDE JUN HAO**

**Completed.** The user-directed removal of `sg-foil-grand-prix-wingfoil-2024` deleted both 2024 Ryan Lo result rows (boards **55** and **12**) and their event-only historical profiles. The retained 2025 profile, `ryan-lo-ae5d31` (sail **17**), remains unchanged with its three 2025 results. **Jun Hao Lo / Lo Jun Hao was not merged into Ryan Lo and remains separate.**

**Why.** The two 2024 Ryan rows were in the same regatta and would have collided under the normal merge service. Deleting the requested source event removes the need to infer a ranking treatment for those two ambiguous entries while preserving the independently supported 2025 Ryan profile.

## Cases requiring verification or source sheets before final action

### 7. Lo Jin Keith / Keith Lo Jin — **MERGE**

**Completed.** `historical-2024-csc-ilca4-jan-2024-dbb879f1175b` was merged into `lo-jin-keith-safyc24`. The CSC entry label and sail **214849** remain on the January 2024 result; the survivor’s placeholder `0` field was not treated as an identifier.

**Why.** The initial review omitted the final `b` in the historical handle, so its live attribution query falsely reported an absent profile. The corrected read-only query confirms that the historical profile exists, owns the CSC ILCA & 29er Championships 2024 rank-29 result, is unclaimed, has one result and participant link, and has **zero** regatta overlap with Lo Jin Keith. The official CSC row visibly reads **Keith Lo Jin**, male, CWSS, sail 214849. Existing 2023 SAFYC and 2024 SYSC records attribute **Lo Jin Keith**, male, Constant Wind/CWSS, sail 214849 to the retained profile, with public corroboration. This is a source-preserving duplicate-profile merge, not a reimport or profile recreation.

### 8. Zixi Lu / Lu Zixi — **MERGED; LU ZIXI RETAINED**

**Completed.** The user confirmed the two names identify the same sailor. `zixi-lu-bd75e0db5f` was merged into the retained `historical-2024-csc-ilca4-jan-2024-18d7373c7fd0` profile, **Lu Zixi**. The retained profile’s nationality is now **CHN**. Three results, three participant links, and one follower link were preserved and transferred; the duplicate profile was removed.

**Why.** The user’s identity confirmation resolves the earlier uncertainty around the reversed name order and changing event equipment/nationality context. Historic event evidence remains attached to its original result rows, while the canonical profile now uses the requested Lu Zixi name and CHN nationality.

### 9. Legacy 29er composite profiles — **RECONCILED AS INDIVIDUAL SAILORS**

**Completed.** One individual **Seth Low Yu Herng** profile was created and the following four composite profiles were removed: Amos Tham / Seth Low; Seth Low / Amos Tham; Seth Low Yu Herng & Amos Tham; and Cheryl Yong / Seth Low. Their result rows, entry labels, and race scores were retained.

| Result ID / source | Participant order and resolved profiles | Legacy primary sailor |
| --- | --- | --- |
| CSC `e0fb2282-e36b-4939-999f-5438fa049715` | 1. Seth Low → Seth Low Yu Herng; 2. Amos Tham → Tham Wan Yew Amos | Seth Low Yu Herng |
| SYSC `b394be00-f220-4f55-b411-407abbc2a859` | 1. Seth Low Yu Herng; 2. Amos Tham → Tham Wan Yew Amos | Seth Low Yu Herng |
| SNSC `b668bc41-ce09-455d-ba1b-1d16cb1db261` | 1. Amos Tham → Tham Wan Yew Amos; 2. Seth Low → Seth Low Yu Herng | Tham Wan Yew Amos |
| Cincapura `4f8ee967-9832-4ca9-8e25-e578a9e5b02b` | 1. Cheryl Yong → Cheryl Yong Heng Xi; 2. Seth Low → Seth Low Yu Herng | Cheryl Yong Heng Xi |

**Why.** The user confirmed the desired individual-sailor model. Each result now has two participant links, preserving the original source order and labels without inferring helm/crew roles or allocating ranking credit. The legacy follower of the Cheryl/Seth team was copied to both Cheryl and Seth before the composite was removed, so the follow relationship was preserved rather than discarded.

## References

### Edward Charles O’Shea

- `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/official-2024-missing/sql/csc-ilca4.sql`

- `/Users/marcus/Documents/GitHub/sailorpath/.work/2024-missing-import/pdfs/csc-ilca4.pdf`

- `/Users/marcus/Documents/GitHub/sailorpath/.work/2024-missing-import/renders/csc-ilca4/page-02.png`

- [https://drive.google.com/file/d/1viZxFwXrdLyWWfYMQ3EGX_Tfpr0uBvhl/view?usp=drive_link](https://drive.google.com/file/d/1viZxFwXrdLyWWfYMQ3EGX_Tfpr0uBvhl/view?usp=drive_link)

- [https://www.racingrulesofsailing.org/documents/125347](https://www.racingrulesofsailing.org/documents/125347)

### Lo Jin Keith

- `/Users/marcus/Documents/GitHub/sailorpath/.work/2024-missing-import/extractions/csc-ilca4.json`

- `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/safyc-2023/reviewed-results.json`

- `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/sysc-2024/matched-results.json`

- `/Users/marcus/Documents/GitHub/sailorpath/outputs/sailor-duplicate-resolution-plan-2026-10-10.md`

- [https://www.racingrulesofsailing.org/documents/62698](https://www.racingrulesofsailing.org/documents/62698)

- [https://www.racingrulesofsailing.org/documents/64010](https://www.racingrulesofsailing.org/documents/64010)

### Ker Wan Chew

- `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/official-2024-missing/sql/ne-monsoon-wingfoil.sql`

- `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/official-2024-missing/sql/national-wingfoil.sql`

- `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/official-2024-missing/sql/sg-foil-wingfoil.sql`

- `/Users/marcus/Documents/GitHub/sailorpath/data/imports/ne-monsoon-gp-2025-combined.json`

- [https://www.sailing.org.sg/news/ne-monsoon-grand-prix-wingfoil-techno-iqfoil-speed-champs](https://www.sailing.org.sg/news/ne-monsoon-grand-prix-wingfoil-techno-iqfoil-speed-champs)

### Jun Ler Chuah and Ryan Lo

- `/Users/marcus/Documents/GitHub/sailorpath/.work/2024-missing-import/pdfs/sg-foil-wingfoil.pdf`

- `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/official-2024-missing/sql/sg-foil-wingfoil.sql`

- `/Users/marcus/Documents/GitHub/sailorpath/.work/2024-missing-import/extractions/sg-foil-wingfoil.json`

- `/Users/marcus/Documents/GitHub/sailorpath/data/imports/ne-monsoon-gp-2025-combined.json`

- [https://drive.google.com/file/d/1kJjMtno1S38zmt9rxw1lAgdeQ1hhR4Pz/view?usp=sharing](https://drive.google.com/file/d/1kJjMtno1S38zmt9rxw1lAgdeQ1hhR4Pz/view?usp=sharing)

- [https://www.straitstimes.com/sport/after-more-than-10-years-away-from-competitive-sailing-lo-jun-hao-returns-with-wingfoiling](https://www.straitstimes.com/sport/after-more-than-10-years-away-from-competitive-sailing-lo-jun-hao-returns-with-wingfoiling)

### Wanzhi Elva Li

- `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/official-2024-missing/sql/csc-ilca4.sql`

- `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/sysc-2024/reviewed-results.json`

- [https://www.racingrulesofsailing.org/competitors/7928/event](https://www.racingrulesofsailing.org/competitors/7928/event)

- [https://www.racingrulesofsailing.org/competitors/7758/event](https://www.racingrulesofsailing.org/competitors/7758/event)

- [https://sailing.laserinternational.org/public/site/event-site/178/entrylist](https://sailing.laserinternational.org/public/site/event-site/178/entrylist)

### John Tze Xiang Wong

- `/Users/marcus/Documents/GitHub/sailorpath/.work/2024-missing-import/pdfs/national-slalom.pdf`

- `/Users/marcus/Documents/GitHub/sailorpath/.work/2024-missing-import/pdfs/ne-monsoon-windfoil.pdf`

- `/Users/marcus/Documents/GitHub/sailorpath/src/db/migrations/069_add_snsc_2025_boards_results.sql`

- `/Users/marcus/Documents/GitHub/sailorpath/src/db/migrations/076_add_pulau_ujong_2026_results.sql`

- [https://www.racingrulesofsailing.org/documents/129858](https://www.racingrulesofsailing.org/documents/129858)

- [https://www.racingrulesofsailing.org/documents/176520](https://www.racingrulesofsailing.org/documents/176520)

- [https://www.teamsingapore.sg/athletes/john-wong-tze-xiang](https://www.teamsingapore.sg/athletes/john-wong-tze-xiang)

### Zixi Lu

- `/Users/marcus/Documents/GitHub/sailorpath/.work/2024-missing-import/pdfs/csc-ilca4.pdf`

- `/Users/marcus/Documents/GitHub/sailorpath/.work/2024-missing-import/pdfs/rm-ilca4.pdf`

- [https://www.csc.org.sg/wp-content/uploads/2024/03/2nd-Day-Overall-Results_Open-Division-3-March-2024.pdf](https://www.csc.org.sg/wp-content/uploads/2024/03/2nd-Day-Overall-Results_Open-Division-3-March-2024.pdf)

- [https://www.rafflesmarina.com.sg/images/events/2024/ILCA/Sailwave-results-2024-RMILCA-4-Results-AfterHearing-Final.pdf](https://www.rafflesmarina.com.sg/images/events/2024/ILCA/Sailwave-results-2024-RMILCA-4-Results-AfterHearing-Final.pdf)

- [https://www.racingrulesofsailing.org/competitors/12142/event?page=5](https://www.racingrulesofsailing.org/competitors/12142/event?page=5)

- [https://www.racingrulesofsailing.org/documents/179735](https://www.racingrulesofsailing.org/documents/179735)

### Legacy 29er composites

- `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/official-2024-missing/sql/csc-29er.sql`

- `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/sysc-2024/results.csv`

- `/Users/marcus/Documents/GitHub/sailorpath/scripts/imports/sysc-2024/reviewed-results.json`

- [https://drive.google.com/file/d/1LVa-q0PXnBVRqWELr2xVeMVr34A1NUyN/view?usp=drive_link](https://drive.google.com/file/d/1LVa-q0PXnBVRqWELr2xVeMVr34A1NUyN/view?usp=drive_link)

- [https://drive.google.com/file/d/1c9ztVlXte_jzuVWZA5pFVdmhQbDVLdxG/view](https://drive.google.com/file/d/1c9ztVlXte_jzuVWZA5pFVdmhQbDVLdxG/view)

- [https://drive.google.com/file/d/1Ev9dA_8oYN44zIi-XZAkThnYNhhCvHIW/view](https://drive.google.com/file/d/1Ev9dA_8oYN44zIi-XZAkThnYNhhCvHIW/view)

- [https://www.csc.org.sg/wp-content/uploads/2021/10/29er-Result-Summary-3.pdf](https://www.csc.org.sg/wp-content/uploads/2021/10/29er-Result-Summary-3.pdf)

- [https://www.racingrulesofsailing.org/competitors/7928/event?page=10](https://www.racingrulesofsailing.org/competitors/7928/event?page=10)

## Final conclusion

**Completed seven source-preserving profile merges:** Edward Charles O’Shea, Lo Jin Keith, Ker Wan Chew, Jun Ler Chuah, Wanzhi Elva Li, John Tze Xiang Wong, and Zixi Lu into Lu Zixi (nationality CHN). The 2024 SG Foil WingFoil target results and four event-only profiles, including the two historical Ryan Lo placeholders, were removed. Four legacy 29er composites were replaced by individual Amos, Seth, and Cheryl participant links without altering result or race-score history.
