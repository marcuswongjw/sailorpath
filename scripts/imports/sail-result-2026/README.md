# Sail-Result 2026

See [import report](../../../outputs/sail-result-2026/report.md).

Run the retained manifest validator before applying any SQL. Every sheet SQL is a standalone transaction, guarded against source/identity/count changes and conflicting existing sheets. Pending rows are intentionally excluded. Completing pending rows requires a new guarded follow-up transaction; replaying an unchanged transaction only verifies the existing import.

Raw downloaded sources and rendered pages: `.work/sail-result-2026/`. Source discovery, normalization, comparison and explicit identity decisions are retained here.
