# High-priority privacy fixes — 26 October 2026

## Changes

- Public scorecards use an explicit allow-list after the cached query, including static fallbacks. Exact DOB, school, owner IDs and unexpected nested fields are omitted. The public type excludes DOB/school; birth year, scores, discards and crew links remain. Result cache versions change.
- Public profile result queries accept only published events. Draft/review personal logbook results stay available through authorized athlete/account APIs and are excluded from public history, summaries and share-data queries.
- Guardian authority belongs to the actor's primary-parent relationship or approved parent claim for this sailor. Unknown age requires consent; the eighteenth-birthday boundary uses Singapore's date. A child cannot change DOB to bypass the guard.
- Evidence uploads return an authenticated reader URL. Legacy own-project storage URLs are converted on authorized account/admin reads. The reader checks uploader/admin identity and uses the user's storage session/RLS. It never uses a service-role key. All reader responses use private, no-store.
- Legacy-to-private URL conversion does not reset verified results.

## Rollout

Deploy the authenticated reader before applying src/db/migrations/20261026102457_private_regatta_evidence.sql. The migration makes only regatta-evidence private and removes its public read policy. Existing objects, uploader policies and superadmin review access remain. Application deployment alone does not close public storage URLs.

Verify the bucket setting and absence of public read policy after application. Previously downloaded copies cannot be recalled. The medium-priority avatar-publication issue is outside this release.

## Validation

The preceding local implementation passed 1,641 tests, TypeScript, lint, production build and the unchanged bundle budget. Workspace connectivity interruptions required restoring the same fix logic through GitHub; independent CI checks gate this release. Regression tests cover public projections, draft/crew result visibility, actor-specific guardian permissions, birthday/unknown-age handling, private evidence access and legacy link verification preservation. A PGlite test applies the storage migration and original evidence helper, checking anonymous/unrelated denial and uploader/admin access.
