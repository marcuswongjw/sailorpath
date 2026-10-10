# SailorPath Public Class Policy Remediation

**Run:** 10 October 2026, 16:27–16:35 SGT
**Target:** SailorPath production Supabase project (`ap-southeast-1`) and public ranking API
**Change record:** `remediate_public_class_policy` (production migration version `20261010083417`)

## Completed production repairs

### 1. Published board/foil results no longer count toward national rankings

The 9 October sanity report identified 15 legacy sheets. At the time this remediation ran, the live database contained **13** currently published board/foil sheets still marked `counts_for_ranking = true`; two had been corrected after the prior snapshot.

The production migration set every remaining published `iQFOiL`, `Techno 293`, `WingFoil`, `Windsurfing`, and `Windfoil` sheet to `counts_for_ranking = false`.

| Verification | Result |
|---|---:|
| Remaining published board/foil sheets marked ranking-eligible | **0** |
| Live requests for `iQFOiL`, `Techno293`, `WingFoil`, and `Windsurfing` rankings | `400 Unsupported ranking fleet` |

This keeps the underlying results public while enforcing the canonical class registry: these classes do not currently have an approved national-ranking policy.

### 3. Publication schema drift repaired

The production database had RLS enabled on `public.regattas`, but the `published_regattas` view and all three expected policies were absent. That was a deployment-state drift from migration `053_regatta_lifecycle_and_rls.sql`, not a public results-data defect.

The applied migration restored:

- `public.published_regattas`, restricted to rows with `status = 'published'`;
- `regattas_public_read` for anonymous/authenticated published-row reads;
- `regattas_superadmin_mutate` for authenticated superadmins; and
- `regattas_service_role` for server-side application access.

Post-change verification found the view present, RLS enabled, and exactly those three policies installed.

## 2. Score-reconciliation exceptions: what they mean

The integrity check compares stored final/nett totals with the individual race rows. It found **seven competitor rows across five result sheets**. This is imported-source fidelity work, not a ranking-algorithm error.

| Result sheet | Affected rows | Observed issue | Safe next action |
|---|---:|---|---|
| Pesta Sukan 2026 Silver | 1 | Three of four race rows are present. The stored totals are consistent with a fourth `55 DNC` score, but that score must be visually confirmed. | Re-render and review the official PDF before inserting the missing race row. |
| Selection Trials Aug 2026 | 1 | Nine of twelve race rows are stored; the three missing scores total 115. Exact race values cannot be inferred safely. | Re-render and transcribe the official PDF. |
| Singapore National Sailing Championships 2026 Gold | 2 | All six race rows exist, but each row's race-score sum differs from the stored totals by 36. | Re-render and reconcile the official table before changing totals or scores. |
| Singapore Youth Sailing Championships 2026 Silver | 2 | Parenthesised `20` scores are stored with `discarded = false`, while the stored nett totals already exclude them. | Visually confirm the source table, then mark the indicated race rows discarded. |
| 2025 Northeast Monsoon Grand Prix Combined Series — Wingfoil | 1 | 37 race rows exist, but their arithmetic does not reconcile to the stored gross/nett totals; the data likely contains a transcription or series-scoring detail not represented in the rows. | Re-render and reconcile against the official series result before editing. |

No score values were changed in this remediation. SailorPath's repository instructions require visual PDF validation before correcting imported race rows, so guessing from totals would be unsafe.

## 4. Why ILCA 7 regattas appear missing from the national ranking

They are being filtered by a mix of **explicit eligibility**, **minimum-race**, and **rolling-window** rules:

1. The current ILCA calculation retains only the **most recent five** eligible regattas before an intake cutoff.
2. A result sheet needs at least **three completed races**. NSC Cup 2 2025 (ILCA 7) has two races and is therefore excluded even though its metadata flag is true.
3. SAFYC 2023, SAFYC 2024, and the 47th Singapore ILCA Open 2024 are explicitly marked non-ranking.
4. The PSA National Elimination Series 2026 sheet is still draft and is excluded from public rankings.
5. Most importantly, the canonical class registry marks ILCA 7 as **not supporting an approved national-ranking policy**, while the generic ranking endpoint still accepts `ILCA7`. The endpoint currently behaves as a result-based rolling standings view because ILCA 7 has no configured national-list rule—not as an approved ILCA 7 national ranking.

There are 10 published ILCA 7 sheets in production, with six marked eligible before the race-count filter. The result data is not broadly absent; older eligible events also fall out of the five-event window.

> Recommended policy decision: either approve and document a federation ILCA 7 ranking rule (including eligibility and intake treatment), or relabel/remove the current ILCA 7 “national ranking” board and retain it as public class standings only. The latter matches the registry today.

## Source control

The durable, idempotent migration is [`103_remediate_public_class_policy.sql`](../../src/db/migrations/103_remediate_public_class_policy.sql). It is committed alongside this report so local schema history matches production.
