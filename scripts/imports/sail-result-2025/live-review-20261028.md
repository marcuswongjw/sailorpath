# 2025 fleet publication review — 28 October 2026

Scope: all 46 Optimist and ILCA 4/6/7 sheets imported across ten 2025 events.

## Findings and corrections

- SQL imports and publication bypassed application cache invalidation. The `public-regattas` Data Cache retained an earlier directory snapshot: 15 published fleet URLs returned 404. Invalidating this production tag restored all 46 routes, without altering scores or profiles.
- Mixed identity/source holds used `awaiting identity or source review`; the old UI only recognised `awaiting identity review`. Fleet pages now render the recorded import notice directly, preserving the actual class count and review reason.
- Class subsets of combined PY fleets retain original official ranks and scores. The same notice area displays that context, without inventing a missing-identity count from the combined fleet size.

## Validation

- Live database: 46 published sheets, ten events, 841 entries, 5,195 race scores; zero race-count, gross or net reconciliation errors. Fifteen sheets retain provisional source labels.
- Before the code release, all 46 fleet URLs returned 200 after cache invalidation, with official-source links and final race columns. Mixed-review notices were absent, reproducing the display issue.
- 65 relevant component, fleet-routing and availability tests passed. Production compilation and TypeScript checks passed on the isolated release based on the currently live `84081ae` commit. The local build had no database credentials; live data was checked independently.
- Release commit: `e08a423af32dfd671425511d7891f667e15280ae`, branch `fix/2025-fleet-live-release`.
- The unrelated newer main commit `846a927` fails Next.js route-export type validation. It is excluded from this scoped release; its changes are preserved in the original workspace and main branch.

## Remaining holds

86 entries require identity review, and two Children's Day Optimist Gold rows have unreconciled source discard/net values. These remain excluded. No source scoring was invented or adjusted.

## Future direct SQL imports

After committing direct SQL result imports/publication, invalidate the production `public-regattas` tag through Vercel (and ranking tags only when ranking inputs change). Check the public event links and fleet pages afterward; published database status alone is not an end-to-end publication check.

## Completed production verification

Production deployment `dpl_D4FTfQxrAHFQeynVzp6PTDaimF9i` is READY and serves all 46 checked fleet pages on sailorpath.com. Every page returns 200 from that deployment, contains its official-source link and final race column. All 15 active provisional labels and all 32 partial-import notices are visible; all combined-PY subsets display their source context. All ten event hubs return 200 and link to every expected fleet. No runtime errors were found for the regatta routes in the post-release ten-minute scan. No scores, identities or held entries were changed by this release.
