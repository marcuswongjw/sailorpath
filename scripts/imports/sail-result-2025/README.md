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
- Transaction script: `resolve_sea_games_2025.sql`. Archived resolved entries in `resolved-sea-games-2025.json`.

## 37th Phuket King’s Cup Regatta 2025 — Resolution of held entries (12 November 2026)

On explicit user instruction:
- Corroborated and resolved all 9 held entries across ILCA 7, ILCA 6, and Optimist fleets:
  - ILCA 7: `CHRISTIAN WIEDMANN` (sail THA 49, rank 6, gross 55, nett 43) corroborated as `Apiwat Christian Wiedmann` (`3b468b8a-579d-5429-8d3f-27db5e17aed2`); aliases registered, sheet updated to 5 of 5 class entries (100% complete).
  - ILCA 6: Created source-faithful profile for `Marcus Yau` (`07d9bca1-925a-5282-bdae-40fa1878b1d9`, HKG, UWC, sail HKG 195004, rank 10, gross 92, nett 80); sheet updated to 3 of 3 class entries (100% complete).
  - Optimist: Resolved all 7 held entries:
    - `Surapha Muangngam` (`3b9072c4-2980-4557-b1f1-b9993c803824`, sail 1941, rank 1, Regatta Champion).
    - `Thawaree Raksapun` (`efc33f0d-a581-4dd3-99ee-2c245bb1c9cd`, sail 1789, rank 5).
    - `Amarin Juntajon` (`aa2952d1-ba70-464e-8666-096ff9fef554`, sail THA 1395, rank 9).
    - `Nirada Sasiwattanaporn` (`fd3c4362-b9e5-4fce-bac2-01232f20d014`, sail 1373, rank 15).
    - `Nopadol Tokpo` (`d5453895-83cb-4b63-b701-804ce42ce4b2`, sail THA 8884, rank 26).
    - Created source-faithful profile for `Tanyatip` (`1bfa6741-cb12-58e1-95be-286a073deba3`, F, THA, NAC3.SC., sail 723, rank 28).
    - `Kanyapat Pisoottiwong` (`6b42e276-4836-4f99-bb40-0542ee7b5dde`, sail THA 1556, rank 31).
    - Optimist sheet updated to 41 of 41 entries (100% complete).
- All 9 results have 100% exact arithmetic and source-faithful race scores. All 4 fleets now 100% complete (ILCA 4: 14/14, ILCA 6: 3/3, ILCA 7: 5/5, Optimist: 41/41; total 63 results, 512 race scores). All sheets have `counts_for_ranking = false`.
- Transaction script: `resolve_phuket_kings_cup_2025.sql`. Archived resolved entries in `resolved-phuket-kings-cup-2025.json`.

## ACDC Cup & Trat Regatta 2025 — Resolution of held entries (12 November 2026)

On explicit user instruction:
- Resolved and imported all 24 held entries across 10 fleets in ACDC Cup International 2025 (17 entries) and Trat Regatta 2025 (7 entries).
- **ACDC Cup International 2025 (17 entries resolved):**
  - ILCA 7: `NITHATSANA RODNUN` (sail 180177, rank 1) $\rightarrow$ `Nithasn Rodhnun` (`0788d794-c84e-5242-9da9-3d51d26e4eb7`). Sheet complete at 3/3.
  - ILCA 4: `KITCHAKHUN SOMKHANNGONE` (sail 21738, rank 4) $\rightarrow$ `Kiitchakhun Somkhanngoen` (`90a471f5-bd58-400f-a995-e115951ee1ed`). Sheet complete at 16/16.
  - ILCA 6: `Aueaoangkun jadsanam` (sail 9, rank 1) $\rightarrow$ `Aueangkun Jadsanam` (`2b2f3955-49bf-5a67-8643-70307409f211`). Sheet complete at 3/3.
  - Optimist Gold:
    - `Khairul Ilzani Bin Mohd Afendy` (`ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7`, MAS, rank 13).
    - `Muaz Mujahid Bin Khamarul Azwan` (`2bda4fc0-b72c-4b0b-b21f-597107dc5ca8`, MAS, sail 28, rank 20).
    - `Chanyachart Ittivorakul` (`863b5d54-6357-50d0-b16e-75e44de37e41`, sail 1887, rank 21).
    - `Nirada Sasiwattanaporn` (`fd3c4362-b9e5-4fce-bac2-01232f20d014`, sail 1925, rank 36).
    - `Mia Azrania bt Mohd Azrald` (`796bc25b-e641-4630-8c8d-20241e73f843`, MAS, rank 43).
    - `Klaochanok Chatawattanasopakun` (`04f1c65e-eeb7-4c89-9f6e-16298c33be02`, sail 3935, rank 59).
    - Sheet complete at 67/67.
  - Optimist Silver:
    - Created source-faithful profile for `Ya Zhang` (`51a8b92d-74d1-52a1-bf87-4328eb92040c`, F, CHN, Qingdao, sail CHN122, rank 10).
    - `Kulpichet Phanchang` (`97050c23-371f-427e-a571-e20486cbb936`, RNSC, rank 11).
    - `Kaung Khant Khant Ko` (`611ef739-d28b-57c3-b6fe-183b006a2a38`, YSC, MYA, rank 21).
    - `Duangdeuen Wichai` (`dfefca66-a570-5f96-bec6-eb566501bdbb`, RNSC, rank 24).
    - `Navatawan Jeanjit` (`1c03e3e7-ea29-526f-88b3-fd77ce113868`, sail 1979, rank 25).
    - `Kanthee Khunmuang` (`8953feed-5a7e-4fe1-978c-7ddcb9ac3fbb`, SSA, sail 54, rank 30).
    - `Charlie Basnet` (`02f7450f-b247-49cf-ba12-2f33a7f0642e`, RNSC, rank 41).
    - Created source-faithful profile for `Nuttapat Arttapiyapun` (`729acda4-25b3-57df-b11c-2f31f9d45e52`, M, THA, ACDC.SC, sail THA187, rank 50).
    - Sheet complete at 51/51.
- **Trat Regatta 2025 (7 entries resolved):**
  - ILCA 6: `Aueangkun Jadsanam` (`2b2f3955-49bf-5a67-8643-70307409f211`, rank 4). Sheet complete at 9/9.
  - Optimist Silver:
    - `Navatawan Jeanjit` (`1c03e3e7-ea29-526f-88b3-fd77ce113868`, sail 1979, rank 3).
    - `Kittiphat Sachato` (`433063e8-3178-50b1-8b3e-68470a3e8cc6`, sail NZL4529, rank 9).
    - `Boontarik Bantichat` (`28ed0b2b-49b3-52ff-ad02-f1f260bfac0b`, MRS.SC, rank 19).
    - `Suthinan Nakpasom` (`f3e4cce1-2a81-4794-ba02-a570d43efb21`, sail 1987, rank 25 DNC).
    - Created source-faithful profile for unstarted entry `Klaochanok (Trat DNC)` (`f4c93ba2-66ab-5908-99cf-59e3bdc60f4e`, F, THA, YRAT, rank 25 DNC).
    - Created source-faithful profile for unstarted entry `T (Trat DNC)` (`c37db018-8ee6-5fb6-9f82-a0eb82fa9b61`, M, THA, YRAT, rank 25 DNC).
    - Sheet complete at 46/46.
- All 24 results have 100% exact arithmetic and source-faithful race scores. All 10 sheets across both regattas are now 100% complete (ACDC Cup: 140 results / 1,260 race scores; Trat Regatta: 99 results / 227 race scores). All sheets have `counts_for_ranking = false`.
- Transaction script: `resolve_acdc_trat_2025.sql`. Archived resolved entries in `resolved-acdc-trat-2025.json`. Remaining held entries in `pending-identities.json`: 27.
