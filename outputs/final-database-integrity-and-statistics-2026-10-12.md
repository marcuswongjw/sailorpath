# SailorPath — Production Database Integrity & Statistics Report

**Audit refresh:** 12 October 2026 (SGT), after the verified 2023 Singapore results import.
**Scope:** Live SailorPath production database following duplicate-sailor, double-handed-entry, empty-profile, SG Foil, and verified 2023-result work.
**Method:** Read-only SQL audit. No data was changed by this audit.

## Executive conclusion

> **Structural integrity: PASS.** Current result ownership, result/participant linkage, participant ordering, normalized sailor-name uniqueness, regatta completeness, and race-score structure checks are clean.

The live database contains **931 sailor profiles**, **192 regattas**, **8,353 result entries**, **44,877 race-score rows**, and **8,372 participant links**.

Two non-blocking data-quality items remain:

1. **One score-field reconciliation exception** requires official-source review: Tiffany Teo Yuan Qi at SYSC Gold (Mar 2023) has `total_score = 1.048`, `nett_score = 854`, and no linked race-score rows.
2. **Boat-class capitalization is inconsistent** for `Wingfoil` / `WingFoil` and `Windfoil` / `WindFoil`. This does not break referential integrity, but it fragments class-level reporting.

No sailor profile lacks result participation, no duplicate normalized sailor names exist, and no regatta is empty.

## Current audit coverage

| Area | Current check | Result |
| --- | --- | ---: |
| Result ownership | Every primary result sailor exists | **0 orphan results** |
| Participant integrity | Every result has one or more participant snapshots | **0 exceptions** |
| Participant ordering | Duplicate sailor links or duplicate display orders | **0 exceptions** |
| Identity duplication | Duplicate whitespace-normalized sailor names | **0 groups** |
| Profile participation | Sailors with neither primary results nor participant links | **0 profiles** |
| Event completeness | Regattas with no result entries | **0 events** |
| Race scores | Invalid race number, negative score, duplicate race number, null discard, or blank raw value | **0 exceptions** |

The broader foreign-key baseline remains the 10 October read-only audit of all 38 public relationships, which found no orphans. The current refresh rechecked the ownership and participant relationships affected by the 2023 import.

## Current database population

| Entity | Count |
| --- | ---: |
| Sailor profiles | 931 |
| Regattas | 192 |
| Result entries | 8,353 |
| Race-score rows | 44,877 |
| Result participant links | 8,372 |
| Sailor aliases | 1,784 |

### Entry composition

| Participants per result entry | Result entries | Share |
| ---: | ---: | ---: |
| 1 | 8,334 | 99.77% |
| 2 | 19 | 0.23% |
| **Total** | **8,353** | **100.00%** |

The 19 two-sailor entries cover correctly modeled double-handed results. Each has two matched participant links while retaining one result and race-score set.

## Seasonal coverage

**Date range:** 11 March 2023 through 3 October 2026.

| Year | Regattas | Result entries | Race-score rows |
| ---: | ---: | ---: | ---: |
| 2023 | 21 | 1,585 | 4,566 |
| 2024 | 60 | 2,224 | 14,981 |
| 2025 | 57 | 2,353 | 12,897 |
| 2026 | 54 | 2,191 | 12,433 |
| **Total** | **192** | **8,353** | **44,877** |

## Class-level statistics

| Boat class as stored | Regattas | Result entries | Race-score rows | Participant links | Distinct participating sailors |
| --- | ---: | ---: | ---: | ---: | ---: |
| 29er | 7 | 23 | 208 | 42 | 14 |
| ILCA 4 | 30 | 1,422 | 7,486 | 1,422 | 247 |
| ILCA 6 | 27 | 513 | 3,218 | 513 | 105 |
| ILCA 7 | 11 | 78 | 443 | 78 | 32 |
| iQFOiL | 6 | 30 | 278 | 30 | 15 |
| Optimist | 79 | 6,029 | 28,183 | 6,029 | 630 |
| Techno 293 | 16 | 96 | 1,335 | 96 | 29 |
| Windfoil | 4 | 25 | 439 | 25 | 10 |
| WindFoil | 2 | 26 | 1,079 | 26 | 20 |
| Windsurfing | 1 | 12 | 192 | 12 | 12 |
| Windsurfing LT | 2 | 13 | 104 | 13 | 8 |
| Wingfoil | 4 | 57 | 1,170 | 57 | 17 |
| WingFoil | 3 | 29 | 742 | 29 | 22 |
| **Total** | **192** | **8,353** | **44,877** | **8,372** | — |

## Verification and provenance coverage

| Verification status | Result entries | With source URL | With verified timestamp |
| --- | ---: | ---: | ---: |
| verified | 7,802 | 2,670 | 7,482 |
| pending_review | 546 | 477 | 0 |
| self_reported | 4 | 0 | 0 |
| rejected | 1 | 0 | 1 |
| **Total** | **8,353** | **3,147** | **7,483** |

The 477 new pending-review entries are the verified 2023 Singapore import. Their public organiser result URLs are stored, while publication review remains deliberately outstanding. Source URL coverage counts `evidence_url` or `official_url`; verification may also be supported by archived source material and audit metadata.

## Profile attribute completeness

These are completeness indicators, not integrity failures. Blank or placeholder values can be appropriate when an official source did not provide the attribute.

| Attribute condition | Profiles | Share of 931 profiles |
| --- | ---: | ---: |
| No specific club (`NULL`, blank, `N/A`, or `Others`) | 197 | 21.16% |
| No nationality | 146 | 15.68% |
| Placeholder or absent Optimist sail number (`0`, blank, or `NULL`) | 220 | 23.63% |
| No current fleet | 595 | 63.91% |
| No gender | 148 | 15.90% |

## Follow-up data-quality register

### 1. Score-field reconciliation exception — official-source review required

| Field | Value |
| --- | --- |
| Regatta | `20230311-sysc-gold-2023-03-11` — SYSC Gold (Mar 2023) |
| Entry | Tiffany Teo Yuan Qi |
| Rank | 93 |
| Stored total score | `1.048` |
| Stored nett score | `854` |
| Linked race-score rows | 0 |
| Verification status | verified |

The condition `nett_score ≤ total_score` is violated once. The database cannot resolve it without individual race rows. A visual review of the official source should determine whether the total needs correction; a formatting interpretation such as a thousands separator is plausible but not established by this audit.

### 2. Boat-class label normalization — backlog item

| Canonical grouping | Stored labels | Affected regattas | Affected result entries |
| --- | --- | ---: | ---: |
| Wingfoil | `Wingfoil`, `WingFoil` | 7 | 86 |
| Windfoil | `Windfoil`, `WindFoil` | 6 | 51 |

Normalize label variants only after selecting the preferred public label and validating class-specific filters, imports, and routes that depend on them.

## Current state

- **No current result-ownership or participant-linkage defects.**
- **No duplicate normalized sailor-name groups.**
- **No empty sailor profiles or empty regattas.**
- **No current race-score structural defects.**
- **Six verified 2023 class sheets are present in pending review with complete individual race records and source URLs.**

The database is ready for normal operations. The two documented data-quality follow-ups remain isolated for targeted source review and class-label normalization.
