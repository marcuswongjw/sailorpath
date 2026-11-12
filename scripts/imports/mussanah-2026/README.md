# Mussanah Race Week 2026 import status

Identity updates and the mixed-fleet versus women's classification explanation are recorded in [identity-review-2026-11-12.md](identity-review-2026-11-12.md). The candidate list below predates that review; eight variants have since been resolved.

Source: [Oman Sail's event result tables](https://www.omansail.om/events/mussanah-race-week-2026#results), day 4, updated 21 October 2026. The event ran 15–22 October; racing ran 18–21 October. The organiser's event notice board and searches for final results PDFs were checked on 12 November; no separate official final results PDF was found. The import is based on the supplied official online table, not PDF corroboration.

`extract.cjs` extracts the four day-4 tables from the saved official HTML, including each displayed race's score, scoring code and discarded flag. The four manifest files pass the official-results manifest validator: Optimist 46 entries / 552 scores, ILCA 4 15 / 180, ILCA 6 11 / 132, and ILCA 7 9 / 108. All individual gross and nett sums reconcile with the online tables. The local source snapshot is `.work/mussanah-2026/official-page.html`.

## Applied to production

- One parent event: `mussanah-race-week-2026`.
- Four published class sheets (all `status = 'published'`, `counts_for_ranking = false`):
  - `mussanah-race-week-2026-ilca-7`: 9 verified results, 108 race scores (`ilca-7.sql`).
  - `mussanah-race-week-2026-ilca-4`: 15 verified results, 180 race scores (`ilca-4.sql`).
  - `mussanah-race-week-2026-ilca-6`: 11 verified results, 132 race scores (`ilca-6.sql`).
  - `mussanah-race-week-2026-optimist`: 46 verified results, 552 race scores (`optimist.sql`).
- Official results source name set concisely to `"Official results on website"`.
- Identity review and resolutions:
  - Canonical merge of `Mohammed bin Ziyad al Qasmi` (`7ca68e3c-0e44-4b3b-93f1-e94394e4fe24`), absorbing `Mohammed Al Qasmi` / `Mohammed Ziyad al Gasim` with DOB and Oman Sail club metadata.
  - Added verified aliases for `Theyab Almehairi` (`Theyab Almheiri`) and `Rashed Alneyadi` (`Rashed Al Neyadi`).
  - Distinct profiles maintained for Kuwaiti `Hamad Almasour` (ILCA 4) and Bahraini `Ali Enki` (ILCA 6).
  - Mixed-fleet official tables imported as canonical standings (1st Karma Waleed in ILCA 4, 1st Ines Gmati in ILCA 6), noting the concurrent Arab Women's Championship in event notes.

The organiser's closing report describes the ILCA 4 and ILCA 6 male standings as overall even though its mixed result tables rank Karma Waleed and Ines Gmati first. The user explicitly supplied the result tables as the import source. Keep prize categories separate from the mixed table and do not infer a prize breakdown from the conflicting prose.
