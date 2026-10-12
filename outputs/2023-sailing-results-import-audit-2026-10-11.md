# 2023 Singapore regatta results — import and identity audit

**Audit date:** 11 October 2026
**Official archive:** https://www.sailing.org.sg/results
**Scope:** Score-complete 2023 Optimist and ILCA 4 result sheets that were visually checked from rendered official result pages. All individual race scores are staged in migration `112_import_verified_singapore_2023_results.sql`.

## Import coverage

| Event | Fleet | Result status | Entries | Races each | Individual race scores | Official result |
| --- | --- | --- | --- | --- | --- | --- |
| NSC Cup 2023 | Optimist Gold | Final | 81 | 7 | 567 | [source](https://drive.google.com/file/d/1imEIoMEol3yPAJXzdmp77sZjFurZpNEF/view) |
| NSC Cup 2023 | Optimist Silver | Final | 91 | 7 | 637 | [source](https://drive.google.com/file/d/192qrjlHpchpJqymUT0Oibr9KtnkNbllz/view) |
| Singapore National Sailing Championships 2023 | Optimist Silver | Final | 102 | 9 | 918 | [source](https://drive.google.com/file/d/1K-QP4BJfvrtbWUVmVVR6XFmc9paNIj3y/view) |
| CSC Optimist Championships 2023 | Optimist Gold | Provisional | 73 | 8 | 584 | [source](https://drive.google.com/file/d/1bNMFW-OrHR33va4SHl7cFWN1MyrpjcJY/view) |
| CSC Optimist Championships 2023 | Optimist Silver | Provisional | 87 | 8 | 696 | [source](https://drive.google.com/file/d/16oTirfFnipCO2ivoXE0Ldd3bMJvBiD05/view) |
| 46th Singapore ILCA Open 2023 | ILCA 4 | Final | 43 | 3 | 129 | [source](https://drive.google.com/file/d/1oG17FY1L327oDJuRBGs4EzMJRliAdNpt/view) |

**Total staged:** 477 finishing rows and 3,531 race-score rows.

### Result integrity

- Each selected source sheet was rendered to images and visually checked before transcription.
- Every source row has the published count of individual races; race score totals and nett scores were independently recomputed before staging.
- The two CSC PowerScore sheets are marked *Provisional*. Their `Best N of 8` nett totals reconcile exactly; the source does not mark discarded cells, so discard assignment is inferred from the highest score(s). **11 Gold** and **7 Silver** rows have a tied cutoff and are explicitly marked for review in the migration.
- 2023 WingFoil results are excluded by instruction. Other scanned/partial sheets are not staged unless all individual races can be verified.

## Current SailorPath profile reconciliation

Database profile matching could not run because the local environment intentionally stores redacted connection values. **No sailor profile was created or merged.** The generated migration itself runs the exact normalized name/alias preflight and aborts before writes if a source row has zero or multiple candidates. On a successful match, it updates the current profile sail number from the latest staged result in the appropriate class, as approved by the owner.

The migration deliberately aborts without writing results when a source row has zero or more than one exact current-profile candidate. It does not use sail numbers for identity matching. It preserves every historical `entry_sail_number`, then updates `sailors.sail_number` from the latest staged Optimist result and `sailors.sail_number_ilca4` from the latest staged ILCA 4 result; one class never overwrites the other.

### Owner-resolved sail-number observations

#### One observed sail number assigned to different source names in the same event — resolved

Owner decision: these are valid because the number is used in different Optimist classes. No profile merge is required or performed.

| Event | Observed sail number | Rows |
| --- | --- | --- |
| NSC Cup 2023 | SGP 4712 | Optimist Gold rank 48: Reyes Tan Jit Eng; Optimist Silver rank 82: Kyan Tan Chun Hong |
| CSC Optimist Championships 2023 | 4556 | Optimist Gold rank 50: Travis Yeo Jia Le; Optimist Silver rank 60: Liao Zhi Ting |
| CSC Optimist Championships 2023 | 4712 | Optimist Gold rank 70: Reyes Tan Jit Eng; Optimist Silver rank 75: Kyan Tan chun Hong |


### Same source name with a different observed entry sail number — resolved

**22** source-name groups raced in more than one selected sheet with differing boat/sail numbers. Owner decision: retain every value on its individual regatta result; after identity matching, update the current profile only with the latest staged number for that class. This is **not** treated as a duplicate sailor or a profile merge.

| Source name | Observed event/fleet entries |
| --- | --- |
| Ethan Chia Han Wei | NSC Cup 2023 / Optimist Gold: SGP 4508; CSC Optimist Championships 2023 / Optimist Gold: 121; 46th Singapore ILCA Open 2023 / ILCA 4: 214789 |
| Zeph Wan | NSC Cup 2023 / Optimist Gold: SGP 3407; CSC Optimist Championships 2023 / Optimist Gold: 122 |
| Ashlea Tham | NSC Cup 2023 / Optimist Gold: SGP 4453; CSC Optimist Championships 2023 / Optimist Gold: 175 |
| Lucas Cao Zhihong | NSC Cup 2023 / Optimist Gold: SGP 3913; CSC Optimist Championships 2023 / Optimist Gold: 149 |
| Nicole Ashley Quek | NSC Cup 2023 / Optimist Gold: SGP 3281; CSC Optimist Championships 2023 / Optimist Gold: 108 |
| Travis Yeo Jia Le | NSC Cup 2023 / Optimist Gold: SGP 4556; CSC Optimist Championships 2023 / Optimist Gold: 4556; 46th Singapore ILCA Open 2023 / ILCA 4: 22106 |
| Reyes Tan Jit Eng | NSC Cup 2023 / Optimist Gold: SGP 4712; CSC Optimist Championships 2023 / Optimist Gold: 4712; 46th Singapore ILCA Open 2023 / ILCA 4: 214251 |
| Sun Weichen | NSC Cup 2023 / Optimist Gold: SGP 4661; 46th Singapore ILCA Open 2023 / ILCA 4: 21915 |
| Janelle Tan Yi Han | NSC Cup 2023 / Optimist Silver: 5117; Singapore National Sailing Championships 2023 / Optimist Silver: SGP 5117; CSC Optimist Championships 2023 / Optimist Silver: 3517 |
| Kate En Rui Bateman | NSC Cup 2023 / Optimist Silver: SIN 4562; Singapore National Sailing Championships 2023 / Optimist Silver: SGP 117 |
| Ryo En Hua Bateman | NSC Cup 2023 / Optimist Silver: SGP 919; Singapore National Sailing Championships 2023 / Optimist Silver: SGP 119 |
| Aidan Yeo see hett | NSC Cup 2023 / Optimist Silver: SGP 3749; Singapore National Sailing Championships 2023 / Optimist Silver: SGP 112 |
| Yeo Shixi | NSC Cup 2023 / Optimist Silver: SIN 3283; CSC Optimist Championships 2023 / Optimist Silver: 508 |
| Shin Lin Chen Rui | NSC Cup 2023 / Optimist Silver: SIN 3485; Singapore National Sailing Championships 2023 / Optimist Silver: SGP 3333; CSC Optimist Championships 2023 / Optimist Silver: 3333 |
| Auwin Leow Zhao Hong | NSC Cup 2023 / Optimist Silver: SGP 340; Singapore National Sailing Championships 2023 / Optimist Silver: SGP 340; CSC Optimist Championships 2023 / Optimist Silver: 3408 |
| Asher Low | NSC Cup 2023 / Optimist Silver: SGP 4643; Singapore National Sailing Championships 2023 / Optimist Silver: SGP 4666 |
| Jamiroquai Tay Kai Nuo | NSC Cup 2023 / Optimist Silver: 99; Singapore National Sailing Championships 2023 / Optimist Silver: SGP 2013; CSC Optimist Championships 2023 / Optimist Silver: 2013 |
| Isla Lee Zhi Xi | NSC Cup 2023 / Optimist Silver: 457; Singapore National Sailing Championships 2023 / Optimist Silver: SGP 457; CSC Optimist Championships 2023 / Optimist Silver: 3303 |
| Kang Jie Long Emrys | NSC Cup 2023 / Optimist Silver: SGP 733; Singapore National Sailing Championships 2023 / Optimist Silver: SGP 737 |
| Hannah Tan Kai Ting | Singapore National Sailing Championships 2023 / Optimist Silver: SGP 700; CSC Optimist Championships 2023 / Optimist Silver: 777 |
| Febe Wong Qi Ke | CSC Optimist Championships 2023 / Optimist Gold: 3003; 46th Singapore ILCA Open 2023 / ILCA 4: 13 |
| Aaron Abraham Say | CSC Optimist Championships 2023 / Optimist Gold: 4669; 46th Singapore ILCA Open 2023 / ILCA 4: 203846 |

## Files prepared

- `src/db/migrations/112_import_verified_singapore_2023_results.sql` — idempotent, identity-safe import. It stages all source rows, writes every race score, leaves regattas/results in review states, and runs post-insert count checks.
- `.work/2023-results-parsed/csc-optimist-power-score.json` — checked extraction data for the CSC provisional PowerScore exports.
- `.work/2023-results-parsed/ocr-46th-singapore-ilca-open-ilca4-strips.json` — grid-aligned local OCR checked against each published total/nett value.
- `.work/research/2023-sailing-source-findings.md` — source and visual-verification evidence log.

## Not staged

- **CSC ILCA Topper Monsoon Regatta — ILCA 4:** official source screenshots clip later race columns and total/nett values, so it cannot support a complete individual-race import.
- Other 2023 archive sheets that could not yet be reconciled race-by-race.
