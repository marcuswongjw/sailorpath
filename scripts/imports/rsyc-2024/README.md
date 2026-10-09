# RSYC Optimist knockout final rankings, 2024

Supplied official PDFs visually reviewed on all six rendered pages before using text extraction as secondary validation. Silver: 8–9 June, 60 final rankings. Gold: 6–7 July, 90 final rankings. Always use the Final Rank column, not within-stage Rank. All source names matched existing names/aliases; Silver rank 53 corrected from Tan Herng Yee to Yee Xuen Tan (source Tan Yee Xuen).

Import updates existing results and preserves IDs, existing scores, profile data, and race counts. Finals-only Gold race cells and bibs are retained as evidence notes; no whole-event race counts, net totals, penalty point values, or sail numbers are inferred. Silver historical gender/club retained in evidence, gender also on results.

`import.sql` passed a transactional rollback dry run before live execution. `reviewed-results.json` records source rows and reviewed identity matches. Pre-import result backup is in ignored local `artifacts/imports/rsyc-2024/before-results.json`.
