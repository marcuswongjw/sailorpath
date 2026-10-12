# SailorPath 2023 Singapore results — production deployment verification

**Deployment date:** 2026-10-12
**Production migration:** `112_import_verified_singapore_2023_results.sql`
**Scope:** Official Sailing Singapore 2023 result sheets verified from rendered source pages. WingFoil remains excluded.

## Deployment result

The migration was executed in production after the prerequisite source-provenance schema migration. It created or updated the six verified fleet sheets, their individual results, race scores, participant snapshots, approved aliases, and owner-approved new sailor profiles.

| Fleet sheet | Results | Races per result | Individual race scores | Solo participant snapshots |
|---|---:|---:|---:|---:|
| CSC Optimist Championships 2023 — Gold | 73 | 8 | 584 | 73 |
| CSC Optimist Championships 2023 — Silver | 87 | 8 | 696 | 87 |
| NSC Cup 2023 — Optimist Gold | 81 | 7 | 567 | 81 |
| NSC Cup 2023 — Optimist Silver | 91 | 7 | 637 | 91 |
| 46th Singapore ILCA Open 2023 — ILCA 4 | 43 | 3 | 129 | 43 |
| Singapore National Sailing Championships 2023 — Optimist Silver | 102 | 9 | 918 | 102 |
| **Total** | **477** | — | **3,531** | **477** |

## Identity decisions applied

- **27 owner-approved aliases** are present in production.
- **Jade Yen Zi Ning → Jade Yeh Zi Yu** is present as the approved alias mapping.
- **Six approved source-backed profiles** were created:
  - Jeanette Tan Wan Wen
  - Jiang Peiru
  - Li Xuanyi
  - Liu Sining
  - Lyu Zixuan
  - Ren Yinuo
- No sailor profiles were merged.

## Sail-number policy verification

Historical entry sail numbers remain stored on each individual regatta result. The latest official 2023 entry number for each affected sailor and class was applied to the current profile field:

- `sail_number` for Optimist
- `sail_number_ilca4` for ILCA 4

**260 profile/class combinations were checked; 0 mismatches were found.**

## Reconciliation checks

| Check | Result |
|---|---:|
| Imported fleet sheets present | 6 / 6 |
| Imported result rows present | 477 / 477 |
| Results with incomplete individual-race coverage | 0 |
| Results without exactly one solo participant snapshot | 0 |
| Gross-score mismatches against stored individual races | 0 |
| Net-score mismatches against stored non-discarded races | 0 |
| Approved aliases present | 27 / 27 |
| Approved profiles present | 6 / 6 |

## Related artifacts

- Migration: `src/db/migrations/112_import_verified_singapore_2023_results.sql`
- Source and duplicate/identity audit: `outputs/2023-sailing-results-import-audit-2026-10-11.md`
- Owner identity decisions: `outputs/2023-production-identity-resolution-2026-10-12.md`

> CSC PowerScore source sheets remain marked provisional and their tied discard-cutoff handling remains `pending_review`, exactly as encoded by the verified import.
