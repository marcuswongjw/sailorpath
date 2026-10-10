# 2025 Northeast Monsoon Grand Prix — Wingfoil Combination

The 2025 Northeast Monsoon Grand Prix Wingfoil combined result has been rebuilt in the SailorPath production database from the three supplied official round score tables. GP1 is also available as a standalone, published result sheet.

## Applied series scoring

The official Notice of Race says that every completed race counts equally, Series 3 contributes nine races, and the Grand Prix score is the sum of all races less the prescribed race discards. With 37 completed races, the series has **seven global discards**. A sailor absent from a round receives two more points than the entrants in that round; for GP1, that is **8 DNC** for every missed race because six sailors entered GP1.

The combined sheet therefore uses:

- **GP1:** 8 races, 6 entrants.
- **GP2:** 20 races, 17 entrants.
- **GP3:** 9 races, 17 entrants.
- **Combined:** 37 races, 17 entrants, 7 global discards.

The prior combined record used a synthetic 20-point score for missed GP1 races and retained round-level discard treatment. That produced inconsistent aggregate fields for Jackson Ho and incorrectly inflated several other competitors’ totals. The rebuilt scorecards reconcile every stored race, total, nett, and discard count.

## Final combined Wingfoil standings

| Rank | Sailor | Total | Nett |
| ---: | --- | ---: | ---: |
| 1 | Jackson Ho | 60 | 30 |
| 2 | Guillaume Pichoir | 152 | 92 |
| 3 | Ker Wan Chew | 166 | 92 |
| 4 | Sven Welak | 223 | 158 |
| 5 | Ryusai Hatano | 295 | 169 |
| 6 | Felix Knick | 298 | 172 |
| 7 | Arthur Phan | 385 | 259 |
| 8 | Malo Pichoir | 433 | 307 |
| 9 | Xavier Lau | 464 | 338 |
| 10 | Mikhail McEntyre | 487 | 361 |
| 11 | Greg McEntyre | 505 | 379 |
| 12 | Bill Hickling | 551 | 425 |
| 13 | Ryan Lo | 554 | 428 |
| 14 | Andrew Lees | 556 | 430 |
| 15 | Mason Lau Qifeng | 558 | 432 |
| 16 | James Feathers | 578 | 452 |
| 16 | Jun Hao Lo | 578 | 452 |

## Published results

- [GP1 Wingfoil results](https://sailorpath.com/regattas/ne-monsoon-grand-prix-2025-series-1?fleet=wingfoil) are published as a separate event hub. The sheet contains all 6 competitors and all 48 race-score cells from the supplied GP1 table.
- [Combined Wingfoil results](https://sailorpath.com/regattas/ne-monsoon-grand-prix-2025-combined?fleet=wingfoil) contain 629 race-score cells: 17 sailors × 37 races. Every sailor has exactly seven discarded results.
- Neither GP1 nor the combined series contributes to a national ranking (`counts_for_ranking = false`).

## Production verification

The following checks were run after the production migrations:

- GP1 has 6 result rows, 48 individual race scores, and reconciled published totals.
- The combined series has 17 result rows, 629 individual race scores, and each row’s stored total and nett equal the sum of its score cells.
- The two production migrations are registered as `107_rebuild_ne_monsoon_2025_wingfoil_combined` and `108_separate_ne_monsoon_gp1_event`.
- GP1 has its own event hub and is no longer presented as a class sheet of the Combined Series event.

## Sources

- Administrator-supplied official PDFs: *NE Monsoon GP1 Day2*, *NE Monsoon GP2 Results 2*, and *NE Monsoon GP3 Final results*.
- [2025 Northeast Monsoon Grand Prix Notice of Race](https://www.racingrulesofsailing.org/documents/128729), clauses 12.3–12.7 and 12.11.
