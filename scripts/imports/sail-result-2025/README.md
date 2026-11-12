# Sail-Result 2025 import scope

30 October 2026 user instruction: load Optimist, ILCA 4, ILCA 6 and ILCA 7; do not import Master.

The requested non-Masters sheets were already published. Live verification found 50 sheets with 1,076 results: Optimist 18/647, ILCA 4 13/246, ILCA 6 11/99, ILCA 7 8/84 (sheets/results). Existing import manifest entry counts match the corresponding live sheets. Ambiguous identities remain held for review.

## YRAT Cup Series 5 — Resolution of held entries (12 November 2026)

On explicit user instruction:
- Merged duplicate profile `Huanran Zheng` (`87cc8912-d304-407f-934f-5cadd7a4921e`) into canonical profile `Jolin Zheng` (`018b6ed4-9636-47e1-8d40-aa5e21a22f32`, RHKYC, DOB 2011-01-01, sail 209319).
- Resolved and imported 10 junior held entries across ILCA 4, Optimist Gold, and Optimist Silver:
  - ILCA 4: Zheng (Jolin Zheng), Kiitchakhun Somkhanngoen, Pumitus Mee-Iamsin $\rightarrow$ sheet complete at 19/19 entries.
  - Optimist Gold: Rachata Sadtrakulwatanna, Itthichai Tiathongchai, Yueyan Jin, Pattarakorn Poonpat, Santhat Suthamgosal $\rightarrow$ sheet complete at 41/41 entries.
  - Optimist Silver: Netchanok Chatawattanasopakun, Navatawan Jeanjit $\rightarrow$ sheet complete at 26/26 entries.
- Dropped entry for `Prayutt Jaibanjong` (ILCA 7 Master) to enforce the total deletion and permanent exclusion of Masters results.
- All non-Masters YRAT Cup Series 5 fleets are now 100% complete (92 results / 552 race scores).
- Transaction script: `resolve_yrat_series5.sql`. Archived resolved entries in `resolved-yrat-series5.json`. Remaining held entries in `pending-identities.json`: 75.
