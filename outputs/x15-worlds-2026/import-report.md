# X-15 Worlds 2026 import audit

Reviewed and applied to production on 9 November 2026.

- Parent events: **1** (`x15-world-championships-2026`).
- Published X-15 result sheets: **5**.
- Verified rider results: **107**; new rider profiles: **107**; matched pre-existing profiles: **0**.
- Individual race scores: **310**; preserved printed discards: **53**.
- Participant links: **107**; results with a confirmed three-letter source nationality: **107**.
- Race-count, gross-total and nett-total reconciliation exceptions: **0**.
- Singapore ranking-eligible sheets: **0**.

| Fleet | Riders | Races | Score rows | Discards |
| --- | ---: | ---: | ---: | ---: |
| Senior Men | 38 | 2 | 76 | 0 |
| Senior Women | 16 | 2 | 32 | 0 |
| U15 and U13 | 15 | 4 | 60 | 15 |
| U19 and U17 Men | 28 | 4 | 112 | 28 |
| U19 and U17 Women | 10 | 3 | 30 | 10 |

## Verification

All five official HTML tables were visually inspected in full and compared with the normalized manifests before import. Original HTML, hashes, per-row evidence, exact raw scores and explicit source URLs are retained. Official Local SI pages 2–3 corroborate the Senior Men half-point format and discard rules. No final-results PDF was found after checking the notice board, class event and completion reports, scoring host and targeted searches. The import is digital-source verified, not PDF-verified.

Every sheet passed a draft trial on the production schema ending in rollback. The five published transactions then passed row-level arithmetic, participant and sheet-count guards. Production readback is in `production-audit.json`; the reusable query is `scripts/imports/x15-worlds-2026/audit.sql`.

Live QA caught and corrected missing nationality extraction from image title attributes, preserving the same imported rider IDs. A separate profile-display issue was fixed in source: X-15 now has its own board discipline and result history rather than defaulting to Optimist. Targeted unit, hook and rendered-profile tests, ESLint and TypeScript checks passed. These application changes use the normal Git/Vercel release; the data publication was already applied and audited independently.

## Source discrepancy still unresolved

The official structured U19/U17 Men scorecard ranks **Leo Zabell third, 15 nett**, and **Antoni Lutomski fourth, 16 nett**. The class prose recap names Lutomski third. It also describes Loire as second in every race, whereas his fourth in R4 is printed as discarded in the scoring table. SailorPath preserves the official scored table, with the discrepancy recorded in event/sheet notes and evidence. Named world-title/category awards were not inferred from the conflicting prose. Clarification of the recap's medal attribution remains outstanding.

## Public routes

- Event: https://sailorpath.com/regattas/x15-world-championships-2026
- Class hub: https://sailorpath.com/classes/x15
- Fleet routes: `/regattas/x15-world-championships-2026/results/x15-senior-men`, `x15-senior-women`, `x15-u15-and-u13`, `x15-u19-and-u17-men`, `x15-u19-and-u17-women`.
- Rider example: https://sailorpath.com/sailors/kamilmanowiecki-x15

## Retained source and SQL inventory

See `scripts/imports/x15-worlds-2026/README.md` for primary source URLs and the official PDF search record. Each of SeniorMen, SeniorWomen, U15, U19Men and U19Women has a reviewed JSON manifest, retained source HTML and an idempotent standalone SQL file. `build_sql.py` regenerates the SQL; `identity-audit.json` records profile decisions.
