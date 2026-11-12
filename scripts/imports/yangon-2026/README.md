# Yangon 2026 results import

Completed 30 October 2026. **62 results and 682 race scores imported into production and published live as provisional results.**

| Event | Dates (assumed at user instruction) | Fleet | Imported / source entries | Held |
| --- | --- | --- | ---: | ---: |
| Yangon Sailing Club Combined Fleet Championships 2026 | 19–20 September 2026 | Optimist | 28 / 31 | 3 |
| Olympic Day Movement Regatta 2026 | 20–21 June 2026 | ILCA 4 | 5 / 7 | 2 |
| Olympic Day Movement Regatta 2026 | 20–21 June 2026 | Optimist | 29 / 31 | 2 |

Both source sheets explicitly say provisional. No official final PDF was located; search evidence remains in evidence.json. Dates were explicitly supplied as assumptions by the user, not independently verified. No Singapore ranking credit. Results remain pending_review for verification labeling; all three sheets are published.

The user explicitly instructed us to follow the Olympic Day results sheet despite scoring discrepancies. All imported published ranks, race values, codes, discards, totals and net scores are preserved. Eighteen source rows have arithmetic discrepancies; seventeen are imported and one (Myat Toe Khant) remains held for identity only. Code-only race cells do not specify numeric points: fleet size + 1 is retained as an explicit assumption, with original raw cell text unchanged. No source correction was inferred.

Seven entries remain held for identities: Thurain Lin (CFC), Thuyein Lin (Olympic Day Optimist), Myat Toe Khant (both Optimist sheets), Lucas (CFC), Thein Thuyein Myint and Suu Labb Lin Tun (ILCA 4). Their full results are retained locally and in private database audit details. No uncertain link or duplicate profile was created for these entries.

Eight new source profiles created; existing profiles unchanged. Historic event sail numbers are stored on results instead of replacing current profile numbers.

Reproduce manifests with `python3 scripts/imports/yangon-2026/prepare.py`. The generated import-batch.sql transaction verifies exact result and race values, guards existing sheets against overwrite, confirms existing profiles are unchanged, and is idempotent. A rollback dry run, production inventory check and idempotent replay passed.

## Olympic Day Optimist discrepancies

| Rank | Name | Published total | Sum of race scores | Published net | Sum after discards |
| ---: | --- | ---: | ---: | ---: | ---: |
| 6 | Eaint CHue Zay Yar | 91 | 92 | 61 | 61 |
| 9 | Lin Thant Naung | 101 | 102 | 69 | 69 |
| 12 | Kaung Khant Ko | 174 | 143 | 110 | 96 |
| 13 | Min Thiha Nyo | 146 | 148 | 112 | 114 |
| 14 | Nay Min Htet | 154 | 156 | 118 | 119 |
| 15 | Min Myat Ponnya | 157 | 159 | 119 | 121 |
| 16 | Shine Khant | 166 | 168 | 127 | 129 |
| 17 | Hnin Wai Lwin | 165 | 168 | 128 | 131 |
| 18 | Aye Nandar Moe | 179 | 182 | 141 | 144 |
| 19 | Eaint Po Mo Chit | 201 | 202 | 149 | 150 |
| 20 | Shoon Lae Khin | 240 | 241 | 176 | 177 |
| 21 | Myat Toe Khant | 256 | 257 | 192 | 193 |
| 22 | Phyu Cin Thadar | 263 | 265 | 199 | 201 |
| 23 | Thwin Min Sett | 267 | 269 | 203 | 205 |
| 24 | Hein Thant Saw | 284 | 286 | 220 | 222 |
| 25 | Zwel La Yaung | 301 | 303 | 237 | 239 |
| 26 | Sherman Aye | 304 | 305 | 240 | 241 |
| 27 | May Moe Sett | 327 | 328 | 263 | 264 |

Code-only DNS/DNF/DNC/OCS/DSQ values use tentative Appendix A fleet size + 1. Multiple failures involve only numeric scores and therefore do not depend on penalty assumptions (e.g. rank 13: 148/114 calculated versus 146/112 published).

## Identity resolution and complete import — 12 November 2026

All seven previously held entries were resolved and imported live on explicit user approval via `resolution.sql`:
- **Thurain Lin (CFC Rank 5, sail MYA2)** and **Thuyein Lin (Olympic Day Rank 7, sail MYA2)**: Phonetic Burmese transliterations (သူရိန်) mapped to canonical profile `Thurein Lin` (`293148bf-0533-5e0f-934a-6567b089996a`), with registered aliases `Thurain Lin` and `Thuyein Lin`.
- **Myat Toe Khant (CFC Rank 26, sail MYA400)** and **Myat Toe Khant (Olympic Day Rank 21, sail MYA2(400))**: Linked to existing profile `Myat Toe Khant` (`a98245bb-cdc1-5316-b2fb-a3a3b6abe97a`, Yangon Sailing Club). Following user instruction, the 1-point arithmetic discrepancy on Olympic Day (published gross 256 / nett 192) was preserved verbatim.
- **Lucas (CFC Rank 22, sail MYA354)**: Created source-faithful profile `Lucas` (`93ad80e2-dd33-5f0d-8f66-f2bf251aaff0`, nationality MYA, club Yangon Sailing Club, sail MYA354).
- **Thein Thuyein Myint (Olympic Day ILCA 4 Rank 4)**: Linked to existing profile `Thein Thurain Myint` (`5d1cab86-4cd9-41da-875e-ffe63608a3dd`), updated nationality to MYA and registered alias `Thein Thuyein Myint`.
- **Suu Labb Lin Tun (Olympic Day ILCA 4 Rank 5)**: Linked to existing profile `Su Latt Lin Tun` (`ba1644c5-63ee-5037-bed9-a6621cdf326a`), registering alias `Suu Labb Lin Tun`.

All three sheets are now 100% complete:
- CFC Optimist: 31 of 31 entries (0 held)
- Olympic Day ILCA 4: 7 of 7 entries (0 held)
- Olympic Day Optimist: 31 of 31 entries (0 held)
Aggregate Yangon inventory: 69 results / 759 race scores.

## Live publication review

Published 30 October 2026 with publish.sql after an exact manifest/database review and rollback publication dry run. Result, race and participant checksums were unchanged by publication. Both source HTML snapshots still match the current official pages. Refreshed the public-regattas production cache tag. Both event hubs and all three fleet routes return HTTP 200. Checked all 62 rendered ranks, 682 rendered race cells and 62 total/net pairs against the manifests; no differences. See live-review.json. Seven identity holds remain excluded and are disclosed on each affected sheet.
