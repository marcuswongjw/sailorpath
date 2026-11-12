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
- Transaction script: `resolve_yrat_series5.sql`. Archived resolved entries in `resolved-yrat-series5.json`.

## SEA Games & Pre-SEA Games 2025 — Resolution of held entries (12 November 2026)

On explicit user instruction:
- Resolved and imported all 15 held entries across 7 sheets (Pre-SEA Games: ILCA 4 Girls [1], Optimist Boys [3], Optimist Girls [4]; SEA Games: ILCA 4 Boys [2], ILCA 4 Girls [1], Optimist Boys [2], Optimist Girls [2]).
- Linked Singapore national squad sailors to existing verified profiles:
  - `NIA ZAHADI` (SGP 224245, SSF) $\rightarrow$ `Nia Mehry Zahedi` (`20af3d01-7d86-4111-bad1-0c2be026e039`).
  - `EHAN LEE` (SGP 83, SSF, source spelling typo) $\rightarrow$ `Ethan Lee` (`c4e262cc-1d16-4e95-90a0-c168b25c2de1`).
  - `DANIAN HUANG` (SGP 3300, SSF, source spelling typo) $\rightarrow$ `Damien Huang` (`644b1498-1f04-4e1e-b7a0-f2bd29f874d7`).
- Linked regional competitors to existing profiles:
  - Malaysia: `Muhammad Yaasin Bin Syahrizan` (`3a2198bc-fe35-49c3-a5ba-2a32a35c81c6`), `Lydia Hannah Jasmine Binti Lukman` (`d4115422-92eb-49c1-b0fe-92da82fd4957`), `Iqbal Nazham Bin Musmuliadi` (`ffa6f01a-8891-4c9a-a169-33a1008ecd31`), `Nur Zafrina Syuhada Binti Mohd Zailan` (`b33f7ace-2a40-5394-8858-007b26ae3163`).
  - Philippines: `Daniela Mayor` (`7b927e81-db43-6629-1296-8e09329a33d5`), `Mark Amadeo` (`a6963324-b0a4-56dc-94f5-f78816b28b6b`).
  - Myanmar: `Aung Sitt Maung` (`3d2fede9-5b4d-444d-9eb1-49d05991d128`).
  - Thailand: `Napabhat Buasuang` (`e4c77476-aeef-45b2-b905-495b594b1353`), `Surapha Muangngam` (`3b9072c4-2980-4557-b1f1-b9993c803824`), `Dhammaporn Aruno` (`b6cda8c3-5a90-4a1d-88d6-b0f52996cab7`), `Suratsayapron Kaewrakum` (`6d6d7dd3-8b95-4230-af00-01321a224c3e`), `Aranya Klangmueang` (`9122c3b5-7b7d-43c1-ab7b-c5d2d2f2fb96`).
- All 15 results have 100% exact arithmetic and source-faithful race scores. All 7 sheets now 100% complete (Pre-SEA Games: ILCA 4 Girls 8/8, Opti Boys 38/38, Opti Girls 27/27; SEA Games: ILCA 4 Boys 6/6, ILCA 4 Girls 5/5, Opti Boys 7/7, Opti Girls 6/6). Total results imported: 15 results, 140 race scores. All sheets have `counts_for_ranking = false`.
- Transaction script: `resolve_sea_games_2025.sql`. Archived resolved entries in `resolved-sea-games-2025.json`. Remaining held entries in `pending-identities.json`: 60.
