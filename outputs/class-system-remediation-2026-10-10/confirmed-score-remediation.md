# Confirmed Score Remediation — 10 October 2026

## Outcome

The six user-approved reconciliation corrections have been applied to the **SailorPath production database** and recorded in migration `remediate_confirmed_score_exceptions` (ledger version `20261010095934`).

The post-migration published-race reconciliation scan now returns **one** row-level mismatch, down from seven.

## Applied corrections

| Regatta | Sailor | Corrected race data | Verified result after update |
|---|---|---|---|
| Singapore Youth Sailing Championships 2026 — Optimist Silver | Teo Shen Jie | R1 `(20)` marked as discarded. | 10/10 rows; gross `129`; nett `45`. |
| Singapore Youth Sailing Championships 2026 — Optimist Silver | Clara Ng Siew Ning | R2 `(20)` marked as discarded. | 10/10 rows; gross `139`; nett `55`. |
| Pesta Sukan 2026 — Optimist Silver | Ilysha Wong | Inserted R4 `55 DNC`, counted. | 4/4 rows; gross `220`; nett `165`. |
| Selection Trials (Aug 26) | Kai Yen-Yu | Inserted R10 `44.0`, R11 `33.0`, R12 `38.0`, all counted. | 12/12 rows; gross `487`; nett `434`. |
| Singapore National Sailing Championships 2026 — Optimist Gold | Yumeng Li | Changed R6 from `84 BFD` to `48`. | 6/6 rows; gross `440`; nett `356`. |
| Singapore National Sailing Championships 2026 — Optimist Gold | Evan En Kai Ong | Changed R6 from `48` to `84 BFD`. | 6/6 rows; gross `458`; nett `374`. |

### Selection Trials source verification

The official final **Optimist Selection Trials** score sheet was rendered and visually checked before the three missing Kai Yen-Yu scores were inserted. The rank-44 row states:

> R1–R12: `35.0`, `40.0`, `(53.0 DSQ)`, `44.0`, `53.0 DNE`, `39.0`, `28.0`, `44.0`, `36.0`, `44.0`, `33.0`, `38.0` — Total `487.0`, Nett `434.0`.

Official source: [Optimist Selection Trials final results, 30 August 2026](https://www.racingrulesofsailing.org/documents/204023)

### Follow-up: final Selection Trials rows and Justiin Ang

Migration `complete_selection_trials_tail_scores` (ledger version `20261010152644`) completed the seven scorecards after Kai Yen-Yu from the supplied final-result table. Each now has all 12 individual race rows and reconciles to its published totals.

| Rank | Sailor | Total / nett |
|---:|---|---:|
| 45 | Quintan Rupert Low | `492` / `439` |
| 46 | Chen-Yi Kai | `496` / `443` |
| 47 | Xavier Yang Zheng Puah | `498` / `445` |
| 48 | Euan Hao Xuan Poh | `500` / `450` |
| 49 | Kyan Chun Hong Tan | `500` / `450` |
| 50 | Zachary Zhi En Low | `541` / `488` |
| 51 | Christopher Soh | `542` / `489` |

The official [NSC Cup I 2024 ILCA 4/6/7 result sheet](https://drive.google.com/file/d/1NbB8_efuTWbgaizk5vCyo_NSbeX8tm1j/view) was rendered and visually checked for Justiin Ang. His ILCA 7 row is now recorded exactly as `1, (2), 1, 2, 1, 1, 1`, with R2 as the sole discard and totals `9` / `7`.

## Outstanding work

### 1. One live row-level reconciliation exception

| Regatta | Sailor | Stored score state | What must be resolved |
|---|---|---|---|
| 2025 Northeast Monsoon Grand Prix Combined Series — Wingfoil | Jackson Ho, rank 1 | All 37 race rows exist. Stored gross/nett totals are `62` / `30`; published totals are `66.5` / `37`. | Re-render and visually examine the official combined-series score sheet and its series-scoring rule. Establish whether a fractional score, carry-over adjustment, or non-additive series calculation is shown. Do not alter individual scores or totals from aggregate arithmetic alone. |

### 2. Published sheets with declared races but no individual race-score rows

There are **12 published sheets** with declared race counts but no individual score rows, representing **882** competitor summaries. These are coverage gaps, not arithmetic discrepancies. Each requires its official result PDF to be rendered and transcribed before race-level reconciliation is possible.

### 3. Summary-only historical archives

There are **9 older published sheets** without both race counts and individual score rows, representing **789** competitor summaries. Official source material is required before their individual results can be reconstructed.

## Scope safeguard

No result data was changed for the unresolved Wingfoil entry or the scoreless historical sheets.
