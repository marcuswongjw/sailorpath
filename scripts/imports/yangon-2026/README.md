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

## Remaining work

Resolve the seven held identities before importing those entries. Publication review passed and all three sheets are live. Public notes retain provisional status, assumed dates, partial coverage and source discrepancies.

## Live publication review

Published 30 October 2026 with publish.sql after an exact manifest/database review and rollback publication dry run. Result, race and participant checksums were unchanged by publication. Both source HTML snapshots still match the current official pages. Refreshed the public-regattas production cache tag. Both event hubs and all three fleet routes return HTTP 200. Checked all 62 rendered ranks, 682 rendered race cells and 62 total/net pairs against the manifests; no differences. See live-review.json. Seven identity holds remain excluded and are disclosed on each affected sheet.
