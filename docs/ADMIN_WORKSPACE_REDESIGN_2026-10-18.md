# Admin workspace redesign

Implemented on `codex/admin-workspace-redesign`, based on `ee2cfd7`.

## Delivered

- A single admin shell: Today, Events & results, Sailors, Inbox, Editorial,
  Insights, and Settings & audit. Removed the legacy navigation switch and
  redundant public navigation/footer in admin routes.
- Today loads event checks, duplicate candidates, Inbox queues, and recent
  changes independently. Loading, unavailable, and cached-after-error states
  are explicit. A failed check never produces an all-clear.
- Separate event and identity summary requests prevent duplicate scanning
  from delaying event queues. Existing combined API consumers remain supported.
- Derived summary caches refresh after core sailor/results/event mutations,
  identity decisions, claims, coach decisions, suggestions, and support changes.
- Compact event index with Recent, Upcoming, and All history. Explicitly selected
  historical events remain visible. Event selection is retained in the URL.
- Future and ongoing class sheets are excluded from overdue review queues.
  Upcoming events say results are not due; publication counts are not audit scores.
- Metadata readiness is labelled “Ready for review,” not an assurance that scores
  or identities were verified. Event deletion sits under More actions with its
  existing confirmation flow. Legacy repair is collapsed in Maintenance.
- Insights separates recorded usage from sign-ins and auth-session records,
  shows adoption numerators/denominators, links to corrective workflows, and
  collapses diagnostics. Missing tracking is unavailable, not zero. The UI-import
  timestamp is explicitly not a complete import ledger.

## Verification

Story: an administrator opens Today, follows an actionable queue or event,
reviews/edit records, and returns to summaries that reflect completed changes
without interpreting failed requests as empty work.

| Boundary | Evidence |
| --- | --- |
| UI and navigation | Browser checked actual dashboard components at desktop and 390px iframe viewport, using isolated HTTP fixtures |
| Client → API | Preview server recorded separate overview events/duplicates, Inbox, activity, regatta and calendar requests |
| API → data | Route regression tests cover superadmin gating, original combined response and independently selected read paths; database transport tests pass locally |
| Response → UI | Browser simulated a 503 event-check response: Inbox and duplicates remained visible, event cards said Unavailable; Retry restored event checks |
| Event context | Selecting another event updated the URL; Upcoming said “Scheduled · results not due”; mobile navigation closed after selection |
| Mutations and caches | Cache invalidation tests and shared identity-decision tests verify derived summary refresh keys; production writes were not used for testing |
| Regression suite | 235 files, 1,262 tests passed |
| Static checks | ESLint, production build with TypeScript, and bundle budget passed |

The browser preview used sample data and a test-only adapter outside application
source. Its write endpoints were disabled; it did not bypass production auth,
copy production cookies, or connect to production data. Local builds used the
application's existing no-database fallbacks. This is not a claim that every live
editorial action, import, or database mutation was exercised end-to-end.

## Remaining measurement work

A complete import ledger spanning scripts and UI, historical queue turnaround,
and comparable-period trend charts need complete underlying instrumentation.
This change does not manufacture those metrics or migrate the database.

## Release status

Prepared for review, not a production deployment. Existing admin URLs and
specialist workflows are retained. No production records or permissions changed.
