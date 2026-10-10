# SailorPath Production Class Result System Sanity Check

**Run:** 9 October 2026, 15:36–15:39 SGT
**Target:** SailorPath Supabase production project (`ap-southeast-1`) and public `sailorpath.com` endpoints
**Access:** Read-only production SQL and anonymous public HTTP requests. No data, schema, policy, cache, or deployment changes were made.

## Verdict

> **Public class-result behavior and the Optimist Gold fallback are working correctly.**
>
> Production is **not fully clean**: legacy board-class ranking metadata, five score-reconciliation exceptions, and publication-schema drift remain. These do not currently send board results to Optimist Gold or expose a board ranking, but they should be remediated in a separately reviewed data/schema maintenance change.

## Passing checks

### Public result-system matrix

| Area | Production result |
|---|---|
| WingFoil public API | `200`, database-backed, 11 merged public regattas, no non-published lifecycle payloads |
| Techno 293 public API | `200`, database-backed, 11 merged public regattas, no non-published lifecycle payloads |
| iQFOiL landing page | `200`; page identifies as Singapore iQFOiL |
| iQFOiL normalized detail | `200` for `/regattas/nsc-cup-1-2025-iqfoil?fleet=iqfoil`; remains on the iQFOiL URL and does not redirect to Optimist |
| Optimist Gold rankings | `200`; returns `fleet: Gold` and 100 ranked entries |
| ILCA 4 / 6 / 7 public endpoints | `200`; return the requested ILCA class and 81 / 34 / 20 entries respectively |
| Unsupported board ranking requests | iQFOiL, WingFoil, Techno 293, and Windsurfing each return `400 Unsupported ranking fleet` |
| Optimist public regatta directory | `200` |

### Optimist Gold fallback safety

The deployed fallback behavior is correct:

- **0** published non-Optimist sheets have a `Gold` or `Silver` division.
- **35** published Optimist Gold sheets exist, so the real Gold ranking path has valid source data.
- The generic iQFOiL result detail remains in `/regattas/<slug>?fleet=iqfoil`, not the Optimist results route.
- Board ranking requests are explicitly rejected instead of defaulting to Gold.

This confirms the relevant logic in [`src/lib/calendar/calendarResultLinks.ts`](../../src/lib/calendar/calendarResultLinks.ts) is working in production: board classes retain their own class path rather than silently falling through to Optimist.

### Normalized published result coverage

| Class | Published sheets | Published results | Published race scores | Published sheets without results | Published sheets without event link |
|---|---:|---:|---:|---:|---:|
| Optimist | 72 | 5,581 | 24,641 | 0 | 9 |
| ILCA 4 | 25 | 1,236 | 6,421 | 0 | 0 |
| ILCA 6 | 23 | 461 | 2,844 | 0 | 0 |
| ILCA 7 | 9 | 68 | 360 | 0 | 0 |
| iQFOiL | 6 | 30 | 278 | 0 | 0 |
| Techno 293 | 13 | 77 | 771 | 0 | 0 |
| WingFoil | 4 | 56 | 1,192 | 0 | 0 |
| Windsurfing | 6 | 38 | 543 | 0 | 0 |

All six iQFOiL sheets are event-linked and have results plus race-level data:

| iQFOiL sheet | Results | Race scores |
|---|---:|---:|
| `nsc-cup-1-2025-iqfoil` | 7 | 56 |
| `nsc-cup-2-2025-iqfoil` | 4 | 8 |
| `pulau-ujong-2026-iqfoil` | 3 | 12 |
| `snsc-iqfoil-sep-25-2025-09-06` | 8 | 96 |
| `sysc-2024-iqfoil` | 6 | 96 |
| `sysc-2026-iqfoil` | 2 | 10 |

### Specialist scorecard lifecycle integrity

| Specialist system | Published scorecards | Entrants in JSON payloads | Malformed result payloads | Table/payload lifecycle mismatches |
|---|---:|---:|---:|---:|
| WingFoil | 7 | 124 | 0 | 0 |
| Techno 293 | 3 | 15 | 0 | 0 |

The public APIs use the database rather than their static-only fallback, and every stored specialist scorecard is published with a valid results-array payload.

## Findings requiring follow-up

### 1. High-priority data hygiene: 15 board sheets still have ranking flags

The public API prevents leakage, but legacy normalized sheets still have `counts_for_ranking = true`:

| Class | Published sheets still marked ranking-eligible |
|---|---:|
| iQFOiL | 4 |
| Techno 293 | 7 |
| Windsurfing | 3 |
| WingFoil | 1 |
| **Total** | **15** |

The current public ranking route rejects all of these classes, so this is **not an Optimist Gold fallback failure**. It is still inconsistent with the new registry rule that unsupported board classes are non-ranking and can mislead admin-only status labels or future consumers of this database flag.

**Recommended remediation:** review the 15 historical rows and update `counts_for_ranking` to `false` in one audited, reversible data migration. Do not perform a blanket update without preserving an administrative change log and confirming there is no class-specific federation exception.

### 2. Score-reconciliation exceptions in published data

For results that have race-level scores, every ILCA, iQFOiL, Techno 293, and Windsurfing result reconciles. Five published sheets do not:

| Class | Sheet | Gross mismatch rows | Largest gross delta | Net mismatch rows | Largest net delta |
|---|---|---:|---:|---:|---:|
| Optimist | `pesta-sukan-2026-silver` | 1 | 55 | 1 | 55 |
| Optimist | `selection-trials-aug-26-2026-08-22` | 1 | 115 | 1 | 115 |
| Optimist | `singapore-national-sailing-championships-2026-gold` | 2 | 36 | 2 | 36 |
| Optimist | `sysc-2026-silver` | 0 | — | 2 | 20 |
| WingFoil | `ne-monsoon-grand-prix-2025-combined-wingfoil` | 1 | 4.5 | 1 | 7 |

These are published source-data/reconciliation issues, not routing failures. The audit did not modify standings. Each discrepancy should be compared to its original official document before changing stored totals, nett scores, or race rows.

There are also older historical results without normalized race-level rows: **1,573 Optimist** and **145 ILCA 4** result entries. They are outside the new iQFOiL/board import path and cannot be score-reconciled until their source race tables are backfilled.

### 3. Publication schema drift remains in production

| Production object | Observed state | Impact |
|---|---|---|
| `public.published_regattas` view | Missing | The application’s explicit `status = 'published'` server predicates currently preserve correct public behavior, but the migration-declared database view is absent. |
| `public.regattas` RLS | Enabled, **0 policies** | Direct Supabase REST is deny-by-default rather than using the repository’s intended public-published policy. The server-side application path remains functional. |
| `public.wingfoil_regattas` RLS | Enabled, 3 policies | Specialist publication policies exist. |
| `public.techno293_regattas` RLS | Enabled, 2 policies | Specialist publication policies exist. |

This is configuration drift, not a public-result routing failure. Reconcile it intentionally rather than blindly reapplying policies: decide whether direct Supabase REST access should be part of the public architecture, then create the view/policies in a reviewed migration.

### 4. ILCA 7 policy needs an explicit decision

The public ranking endpoint currently accepts `fleet=ILCA7` and returns 20 entries, while the central class registry marks ILCA 7 as not national-ranking eligible. This does not affect Optimist or board fallback behavior, but the two contracts should be aligned by an explicit federation/product decision:

- If ILCA 7 should be a supported public standings board, update the registry/policy description.
- If it should not be a national ranking, remove or change the ranking-endpoint treatment deliberately.

## Scope and evidence

- Supabase project: SailorPath (`fdziuyexczkngvugvsbu`), status `ACTIVE_HEALTHY`.
- All SQL was read-only and aggregation-focused; no racer identities, credentials, or source payloads are recorded here.
- Public verification used the live `sailorpath.com` endpoints after the deployment at commit `20ce389`.
- This check validates database integrity and public behavior at the stated time. It does not replace visual verification of original PDF score tables before data corrections.
