# Public copy, update imagery and regatta class order — 3 November 2026

## Scope

Reviewed 61 public route checks: static public pages, public demos, class hubs and standings, the Index and methodology, seven update articles, and representative regatta/result/profile templates. Private account and administrator workspaces were excluded. Shared class presentation changes apply to other regattas using these templates; this was not a race-results re-import or a verification of every sailor's record.

The initial HTTP check rendered 58 routes and identified three expected legacy redirects: `/demo/sailor` to `/sample?view=sailor`, and the Optimist/ILCA regatta directories to their filtered calendar routes. Client-only forms and demos were also reviewed in source; their initial HTTP shells do not show every interactive state.

## Changes

- Class badges, calendar result links, event fleet tabs, prize fleet selectors and event sharing descriptions use the same English alphabetical order, with natural number comparison. Existing result matching, fleet links and selected-fleet context are preserved.
- Eastern Seaboard's visible class order is ILCA 4, ILCA 6, Optimist Gold, Optimist Silver.
- Seven published update posts have local images with useful alternative text, captions and credits. Retained the three existing event photographs; added four original editorial illustrations, clearly identified as illustrations, for regional coverage, profile privacy, public records and X-15. Original SVG sources are retained alongside the content tools.
- Updated About, ranking guidance, Index publication-checklist wording, Search and iQFOiL copy. Removed internal data-model terminology from board-class scorecards.
- Synchronized four existing published database articles with reviewed copy. Publication dates, article status, official source links and editorial drafts are preserved. Production title/summary/body hashes match the source definitions.
- Australian coverage: 52 sheets, 7,780 race scores: five ILCA sheets / 2,292 scores; nine Optimist sheets / 1,470; 36 Zhik Youth Sail sheets / 3,554; two 29er/420 National sheets / 464. Corrected 29er venue to Sandy Bay Sailing Club; 420 to Lake Hume, 17 entries and 10 races.
- Regional update: removed unsupported aggregate counts and dates, corrected Philippine venue to Manila Bay and Optimist divisions to Class A/B, restored Indonesia's 420 coverage and PDF provenance, and mentioned the available Taiwan 2026 and historical Indian 2023 records.
- Privacy post now distinguishes optional full-date-of-birth sharing from public birth years, and explains current awards sorting/filtering. It no longer promises that every award has a division-specific source link.

## Separate data observation

The existing published `langkawi-international-regatta-perdana-2026-29er` row reports fleet size 6 while a database count finds 31 result rows and 347 race rows. This needs a separate source/results reconciliation. No regatta, sailor, scoring, eligibility or ranking records were changed during this copy update. The regional editorial copy avoids presenting a disputed total as verified.

## Validation

Focused tests cover alphabetical display, stable event links and active fleets, calendar links, alias handling, event overview, news media on both database and fallback paths, and existing event/calendar/homepage behavior. TypeScript and lint checks pass. Before/after route snapshots and the exact copy-only SQL are stored in this folder. Live release checks are recorded after deployment.

## Live verification

- Production deployment `dpl_9AUxQkVWr4GAqmEoXQRPaAcpXs1H` is READY on sailorpath.com at commit `31af226ca37344e0800b3bd2b4d5497aa1ea5af4`.
- 135 focused tests across 17 files pass after incorporating the latest main-branch imports.
- Final 61-route snapshot: no HTTP page errors and no remaining flagged stale copy. The three legacy redirects remain intentional.
- All seven update images return HTTP 200 with image content types.
- Visually confirmed Eastern Seaboard's alphabetical badges/tabs and that ILCA 6 opens its own 11-competitor result sheet.
- Visually confirmed the refreshed regional article and its original illustration, descriptive alt text, caption and credit.
- Refreshed only the `public-wingfoil` and `public-techno293` production cache tags to remove two cached copies of the old board-scorecard label, then verified both pages again.
- Screenshots saved as `/tmp/sailorpath-alphabetical-classes.png` and `/tmp/sailorpath-update-imagery.png`.
- Deployment-scoped error/fatal runtime-log count for the post-release window returned no entries.
