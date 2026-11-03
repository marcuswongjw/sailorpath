# Vercel usage optimisation — 3 November 2026

## Evidence and limits

Repeated anonymous GETs to the Eastern Seaboard ILCA 4 and ILCA 6 result sheets returned `x-vercel-cache: MISS` and `private, no-cache, no-store` on both requests. Responses were approximately 815 KB and 195 KB uncompressed. The public news index was already a cache HIT. Owner-aware sailor profiles correctly remained private/no-store.

Deployment runtime-log counts showed repeat traffic on canonical fleet-result routes, including Eastern Seaboard and international championships. These are log counts, not complete traffic totals.

The connected billing tool returned a bounded team-wide daily billing summary. It cannot attribute those charges to SailorPath from its sample, so no per-site cost or savings percentage is claimed. Build CPU was the largest billed service in that team window. The wider billing request exceeded the tool limit; the smaller daily window succeeded. The legacy observability-query endpoint rejected the metric query. No paid features, subscription or resource-size changes were made.

## Changes

- Canonical public fleet scorecards use on-demand ISR with a one-hour fallback refresh. Empty `generateStaticParams` prevents prebuilding every historical sheet. Existing public result/import cache tags refresh dependent pages.
- Database outages propagate rather than becoming cached missing-fleet responses. Temporary result/copy failures opt out of the route cache; personal profile/account pages retain request-time permission handling.
- Public regatta social-preview images use the framework's one-hour cache instead of being forced dynamic. Owner-aware profile images retain their existing behaviour.
- Dense fleet, crew, podium, prize, profile-result and award links do not automatically prefetch destinations. Actual client navigation and the main site navigation remain available.
- Documentation/import-evidence-only previews can skip the build using the last successful preview SHA. Runtime, dependency, build-script, unknown-file, missing-history and multi-commit changes build safely. Production and explicit redeployments always build.

- Sailor profiles receive only the awards matched on the server. The full historical prize catalogue stays out of the client bundle. The same award calculation powers the sample profile.

## Validation

51 focused tests across 14 files passed, including real temporary-Git fixtures for build decisions, outage handling, public links, scorecard lookup, privacy filtering, share images and invalidation. TypeScript and targeted lint checks passed. Production cache verification is recorded after release.
