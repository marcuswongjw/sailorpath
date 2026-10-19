# Admin dashboard loading review — 19 October 2026

Reviewed the shared dashboard data loader, navigation, event checks, sailor directory and result history, inbox panels, Insights and audit reads. Changes are local and have not been deployed. Existing unrelated workspace edits were preserved.

## Findings and changes

- **Duplicate scanning blocked rendering and made the overview count expensive.** The directory now scans only in duplicate review. Matching now prepares names once per roster and skips edit-distance work that cannot meet the configured threshold. A synthetic 1,500-sailor benchmark fell from 9,188 ms to 1,511 ms on this machine. These are algorithm timings, not production page-load measurements. Independent reference tests preserve suggestions, scores, containment rules, rounding and ordering.
- **Opening Inbox mounted hidden panels.** Only the selected inbox panel now mounts. Claimed-profile update history loads when its tab opens. Removed unused sailor-table ranking summary reads from ranking/analysis screens.
- **Compact event-check views still downloaded the full regatta list.** Missing-results, ready-for-review and data-health queues now use their compact overview request alone. Opening readiness no longer downloads sailors and detailed results. The results editor fetches its selected sheet when opened.
- **Errors from inactive tabs leaked across the dashboard.** Loading/error state and Retry workspace now cover only the active workspace. Initial list screens wait for required data; cached screens stay visible during refreshes and failures. Selecting another sheet keeps the event form mounted while the editor loads.
- **Some reads could hang or continue after leaving a panel.** Inbox, history, suggestions, calendar-card and readiness reads now use the shared request timeout; query/effect cancellation is forwarded where available. Gateway responses containing HTML retain their HTTP error status.
- **Explicit result refresh could return fresh cache or silently fail.** Explicit refresh now fetches from the server and propagates failures. The sailor-history modal shows a retry action, suppresses unverified empty-history claims and ignores stale completion state from an earlier open request.
- **Board class cards displayed unverified zero result counts on a fresh visit.** They now reuse grouped counts already computed by the compact overview API, with loading/unavailable/retry states rather than downloading all result rows.

## Validation

- Admin component/API, database-client, request-policy and matching regression suite: **48 files, 265 tests passed**. A final focused check passed five tests, including the added failed-history regression (266 distinct tests across the checks).
- TypeScript and production build checks passed. Build-time database-backed public-page fallbacks were exercised because this workspace has no valid local database connection configured; a passing build does not validate live database latency.
- Lint and whitespace checks passed for the changed implementation and tests.
- Read-only checks of the currently deployed site loaded Events, Claims, Insights and audit history. The overview loaded event checks and recent activity, but duplicate candidates became unavailable. These checks observed the existing deployment, not the local fixes.

## Release boundary

Authenticated end-to-end verification of the changed code against a database remains a deployment/preview check. No production records, roles or published content were changed during this review. After deployment, verify overview duplicate counting, direct bookmarked class links, first-load and cached tab navigation, retry after a failed read, and refreshing sailor history.
