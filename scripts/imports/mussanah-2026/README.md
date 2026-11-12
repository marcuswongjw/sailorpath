# Mussanah Race Week 2026 import status

Source: [Oman Sail's event result tables](https://www.omansail.om/events/mussanah-race-week-2026#results), day 4, updated 21 October 2026. The event ran 15–22 October; racing ran 18–21 October. The organiser's event notice board and searches for final results PDFs were checked on 12 November; no separate official final results PDF was found. The import is based on the supplied official online table, not PDF corroboration.

`extract.cjs` extracts the four day-4 tables from the saved official HTML, including each displayed race's score, scoring code and discarded flag. The four manifest files pass the official-results manifest validator: Optimist 46 entries / 552 scores, ILCA 4 15 / 180, ILCA 6 11 / 132, and ILCA 7 9 / 108. All individual gross and nett sums reconcile with the online tables. The local source snapshot is `.work/mussanah-2026/official-page.html`.

## Applied to production

- One parent event: `mussanah-race-week-2026`.
- One published sheet: `mussanah-race-week-2026-ilca-7`; 9 verified results, 108 race scores, zero arithmetic reconciliation exceptions. Source finality is displayed as unconfirmed. The idempotent transactional import is `ilca-7.sql`.

## Not yet applied

Optimist, ILCA 4 and ILCA 6 are **not imported**. The race-score manifests are prepared but several names resemble existing profiles with differing historical sail numbers. For example, `Hamad Almasour` and `Hamad Almasoud`; `Ali Enki` with ILCA 6 sail 211811 and an existing Optimist sailor; and multiple Omani sailors with similar Mohammed Al Balushi names. Some same-nation sail numbers are reused by unrelated sailors. Further corroboration is needed before linking existing profiles or deciding that a new profile is appropriate. Avoid importing a partial sheet while showing the full fleet count as complete.

The organiser's closing report describes the ILCA 4 and ILCA 6 male standings as overall even though its mixed result tables rank Karma Waleed and Ines Gmati first. The user explicitly supplied the result tables as the import source. Keep prize categories separate from the mixed table and do not infer a prize breakdown from the conflicting prose.
