# SailorPath Score-Reconciliation Exception Register

**Production audit run:** 10 October 2026 (SGT)

**Scope:** Published result sheets with (a) declared race counts, (b) stored final and nett totals, and (c) at least one individual race-score row.

**Comparison:** Gross total against the sum of all race rows; nett total against the sum of non-discarded race rows; stored race-row count against the declared race count. Differences of **≤ 0.01** are treated as floating-point storage noise, not data errors.

> This register enumerates all **seven** live row-level reconciliation exceptions previously reported: seven competitor rows across five published result sheets. No database values were changed by this audit. Every source-dependent repair must be visually checked against the official result PDF before it is applied.

## Exact correction queue

| Priority | Regatta / competitor | Current data | Exact issue | Required correction | Source confirmation |
|---|---|---|---|---|---|
| 1 | **Singapore Youth Sailing Championships 2026 — Optimist Silver** (14 Mar 2026), rank 3 **Teo Shen Jie** | 10/10 race rows. Gross `129` matches. Nett stored from rows is `65`; recorded nett is `45`. | Race 1 is raw `(20)` but `discarded = false`. Race 9 (`BFD 64`) is already discarded. | Change **Race 1** only to `discarded = true`. Gross remains `129`; nett becomes `45`. | Confirm the parenthesised Race 1 value in the official sheet; the arithmetic and stored final nett already agree with this change. |
| 2 | **Singapore Youth Sailing Championships 2026 — Optimist Silver** (14 Mar 2026), rank 5 **Clara Ng Siew Ning** | 10/10 race rows. Gross `139` matches. Nett stored from rows is `75`; recorded nett is `55`. | Race 2 is raw `(20)` but `discarded = false`. Race 9 (`BFD 64`) is already discarded. | Change **Race 2** only to `discarded = true`. Gross remains `139`; nett becomes `55`. | Confirm the parenthesised Race 2 value in the official sheet; the arithmetic and stored final nett already agree with this change. |
| 3 | **Pesta Sukan 2026 — Optimist Silver** (25 Jul 2026), rank 52 **Ilysha Wong** | Declared 4 races; only races 1–3 exist. Race rows total `165`, nett `110`; recorded totals are `220` / `165`. | **Race 4 is missing.** Both gross and nett are short by exactly `55`. | After visual confirmation, insert **Race 4** as `55 DNC`, `score = 55`, `scoring_code = DNC`, `discarded = false`. This produces the recorded gross `220` and nett `165`. | The source PDF must confirm both the Race 4 value and whether it is DNC. The stored totals make this the only arithmetic completion, but totals alone are not sufficient evidence. |
| 4 | **Selection Trials (Aug 26)** (22 Aug 2026), rank 44 **Kai Yen-Yu** | Declared 12 races; only races 1–9 exist. Race rows total `372`, nett `319`; recorded totals are `487` / `434`. | **Races 10–12 are missing.** Their combined score must be `115`; no further discard is implied because both gross and nett are short by `115`. | Visually transcribe and insert the exact **Race 10, Race 11, and Race 12** score/code/raw-value rows. Leave existing Race 3 `(53 DSQ)` discarded. | Exact three scores cannot be inferred safely from the totals. |
| 5 | **Singapore National Sailing Championships 2026 — Optimist Gold** (11 Sep 2026), rank 78 **Yumeng Li** | 6/6 race rows. Stored gross/nett `476` / `392`; recorded `440` / `356`. | Race 6 is stored as `84 BFD`, creating a **+36** error in both totals. | Verify and change **Yumeng Race 6** from `84 BFD` to `48` (`score = 48`, no code, not discarded). This produces `440` / `356`. | Must be confirmed with the official Gold result table. |
| 6 | **Singapore National Sailing Championships 2026 — Optimist Gold** (11 Sep 2026), rank 79 **Evan En Kai Ong** | 6/6 race rows. Stored gross/nett `422` / `338`; recorded `458` / `374`. | Race 6 is stored as `48`, creating a **−36** error in both totals. Together with Yumeng Li’s complementary +36, this strongly indicates the Race 6 cells were transposed during import. | Verify and change **Evan Race 6** from `48` to `84 BFD` (`score = 84`, `scoring_code = BFD`, not discarded). This produces `458` / `374`. | Must be confirmed with the official Gold result table. Apply together with Yumeng’s row only after visual confirmation. |
| 7 | **2025 Northeast Monsoon Grand Prix Combined Series — Wingfoil** (25 Jan 2025), rank 1 **Jackson Ho** | 37/37 race rows. Stored gross/nett `62` / `30`; published totals are `66.5` / `37`. | The row-level series arithmetic is inconsistent with the published combined-series totals: gross is short by `4.5`, nett by `7`. | Re-review the official combined-series table and its series-scoring rule before editing. Determine whether the source contains a special score, a fractional adjustment, or a series total that is not the direct sum of the stored race columns. | Do **not** manufacture a race row or alter totals from arithmetic alone. The sheet’s stored notes already describe it as provisional combined standings. |

## Why each is a genuine reconciliation exception

| Regatta | Competitors affected | Race row count | Gross delta | Nett delta | Classification |
|---|---:|---:|---:|---:|---|
| 2025 Northeast Monsoon GP Combined — Wingfoil | 1 | 37 / 37 | `+4.5` | `+7` | Published series total and stored race rows disagree. |
| SYSC 2026 Optimist Silver | 2 | 10 / 10 each | `0` | `−20` each | Raw parenthesised score is not marked discarded. |
| Pesta Sukan 2026 Optimist Silver | 1 | 3 / 4 | `+55` | `+55` | One race row absent. |
| Selection Trials Aug 2026 | 1 | 9 / 12 | `+115` | `+115` | Three race rows absent. |
| Singapore National Sailing Championships 2026 Optimist Gold | 2 | 6 / 6 each | `−36`, `+36` | `−36`, `+36` | Complementary Race 6 transposition candidate. |

## Related data-quality findings (not counted in the seven)

### 1. Historical result sheets that lack every individual race row

These are **coverage gaps**, not total-vs-race-row reconciliation defects: there are no individual race rows to sum. They should be imported only after the official result PDFs are retrieved and visually transcribed.

| Sheet | Date | Class / division | Declared races | Result rows without individual scores |
|---|---|---|---:|---:|
| RSYC Optimist Knockout Championship 2023 (Gold) | Nov 23 | Optimist Gold | 6 | 69 |
| RSYC Optimist Knockout Championship 2023 (Silver) | Nov 23 | Optimist Silver | 6 | 78 |
| RSYC Optimist Knockout Championship 2024 (Silver) | Jun 24 | Optimist Silver | 6 | 60 |
| RSYC Optimist Knockout Championship 2024 (Gold) | Jul 24 | Optimist Gold | 6 | 90 |
| SYSC Gold (Mar 25) | Mar 25 | Optimist Gold | 10 | 100 |
| SYSC ILCA 4 (Mar 25) | Mar 25 | ILCA 4 Open | 10 | 75 |
| SYSC Silver (Mar 25) | Mar 25 | Optimist Silver | 8 | 75 |
| RSYC Optimist Knockout Championship 2025 (Silver) | Aug 25 | Optimist Silver | 5 | 62 |
| RSYC Optimist Knockout Championship 2025 (Gold) | Aug 25 | Optimist Gold | 7 | 72 |
| Singapore Youth Sailing Championships 2026 (ILCA 4) | Mar 26 | ILCA 4 Open | 12 | 70 |
| RSYC Optimist Knockout Championship 2026 (Silver) | Sep 26 | Optimist Silver | 8 | 53 |
| RSYC Optimist Knockout Championship 2026 (Gold) | Oct 26 | Optimist Gold | 6 | 78 |

There are also nine older published summary-only sheets with no declared race count and no individual race rows (**789** competitor summaries). Those are historical coverage work, not reconcilable score discrepancies.

### 2. One parenthesised raw value that is not currently an arithmetic issue

**NSC 1 ILCA 7 (Dec 24), Justiin Ang, Race 1** stores raw value `(1)` with `discarded = false`. Current totals are correct only if Race 1 counts: gross `9`, nett `7`, with Race 2 `(2)` as the actual discard. This looks like source notation that may not mean a discard, so it should be visually checked before changing it. It is **not** part of the seven reconciliation exceptions.

## Verification and repair protocol

1. Open the official source result sheet for the specified regatta and render it to an image.
2. Read the relevant competitor row visually, including parentheses, scoring codes, discards, gross and nett totals.
3. Apply a narrow, idempotent migration that changes only the confirmed race rows.
4. Re-run the tolerance-aware reconciliation check for the affected result sheet.
5. Never infer missing individual race values solely from aggregate totals.

## Official-source references

- [2025 Northeast Monsoon Grand Prix Combined Series — Wingfoil](https://www.racingrulesofsailing.org/documents/128729)
- [Singapore Youth Sailing Championships 2026](https://www.racingrulesofsailing.org/documents/13601/event)
- [Pesta Sukan 2026](https://www.racingrulesofsailing.org/documents/14397/event?name=pesta-sukan-2026)
- [Selection Trials (Aug 26)](https://www.racingrulesofsailing.org/documents/200930)
- [Singapore National Sailing Championships 2026](https://www.racingrulesofsailing.org/documents/14487/event)
