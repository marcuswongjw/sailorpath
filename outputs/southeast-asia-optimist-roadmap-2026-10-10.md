# Southeast Asia Optimist roadmap

**Prepared:** 10 October 2026
**Status:** Strategy draft — no product, policy, or data changes are made by this document.
**Starting point:** SailorPath already operates Singapore Optimist rankings, sailor profiles, regatta results, an admin import flow, and a pure ranking engine.

## The decision

Build SailorPath into the **trusted regional record for Optimist sailing**, beginning with official results and individual sailor histories. Do **not** launch a broad “best sailor in Southeast Asia” ranking at the outset.

The first public regional product should be:

> **Southeast Asia Optimist Results** — verified regatta results and sailor histories, filterable by country, club, event, and season.

A cross-border points table should follow only when SailorPath has a published event schedule, enough verified results, durable sailor identities, and named local data partners. The public product can then be called the **Southeast Asia Optimist Series** or **SEA Optimist Index**, with a visible policy and a clear status such as *Provisional*.

This sequence protects credibility. A regional directory and results record are useful immediately; a league table is only useful when its inputs are fair, complete, and explainable.

## What success looks like after 18 months

SailorPath has a reliable, searchable record of the leading Optimist regattas in five launch markets: Singapore, Malaysia, Thailand, the Philippines, and Indonesia. Sailors can find their verified profile and history across borders. Organisers can submit results through a simple review flow. A published regional-season table exists only for a declared set of eligible events, and every standing can be traced to its source results and policy version.

The aim is not to replace national authorities, selection systems, or regatta organisers. SailorPath should become the neutral infrastructure that makes their published results easier to find, understand, and preserve.

## Market-entry order

| Wave | Markets | Why this is the right order | Entry condition | Initial public output |
|---|---|---|---|---|
| 1 | **Singapore** | Existing SailorPath base and easiest place to harden the operating model. | Maintain current coverage and resolve identity/data-quality debt. | Singapore results, profiles, and rankings remain the reference implementation. |
| 2 | **Malaysia** | Natural adjacent pilot market with practical travel and club connections. | One committed organiser or club plus at least two clean historical or current result sets. | Malaysia event pages and a country-filtered sailor directory. |
| 3 | **Thailand** | Important regional-regatta market; use a local partner rather than scraping opportunistically. | Named data steward and an agreed official-result handoff. | Verified Thai event records and cross-border sailor histories. |
| 4 | **Philippines** | Separate operational test of partner onboarding, naming conventions, and result formats. | At least one repeat organiser and a successful supervised import. | Verified event records, profiles, and country coverage. |
| 5 | **Indonesia** | High-upside expansion that should begin only after the operating playbook is repeatable. | Local steward, confirmed publication permissions, and two imports that pass review. | Selected verified event coverage; no completeness claim until coverage is proven. |

This is a **go-to-market sequence**, not a claim that one country’s sailors or events matter more than another’s. Markets can move forward only when the stated data and partnership conditions are met. If a later market has a ready organiser while an earlier one does not, bring the ready market forward without changing the quality bar.

## Roadmap

### Phase 0 — make Singapore the regional reference implementation

**Timing:** Weeks 0–6

Before adding a country, make the existing platform able to describe regional data without ambiguity.

- Create a regional taxonomy for `country`, `club`, `organiser`, `venue`, `class`, `event series`, and result-source URL or file.
- Keep a sailor as one person across all events. Treat name variants, changing sail numbers, and club changes as reviewable identity evidence rather than creating a new profile.
- Preserve the official source row and published result artefact for every import. A result must always show where it came from and whether it is **verified**, **awaiting review**, or **community-submitted**.
- Add a country and season filter to public event and sailor-history views. Do not change the existing Singapore ranking policy merely to make it regional.
- Define an internal import checklist: source retained, fleet/class confirmed, overall and race scores reconciled, sailor matches reviewed, and an accountable reviewer recorded.
- Write the public wording and privacy rules for minors before regional profiles are promoted. Show sporting information only; do not display contact details, exact dates of birth, school details, or unapproved photos.

**Exit gate:** 95% or more of published Singapore Optimist result rows have a resolved canonical sailor or an explicit `needs review` state; all newly published events have a retained source and reviewer; no unresolved import silently contributes to a ranking.

### Phase 1 — Malaysia pilot and cross-border sailor record

**Timing:** Months 2–4

Launch Malaysia as a controlled pilot, not a nationwide completeness promise.

- Recruit one club, organiser, or class representative as the first data partner. Their role is to supply official result files or URLs, answer only material identity questions, and review the final published sheet.
- Import two to four historical or live events with the partner. Validate the full path from source collection to public page, including variations in naming, sail-number formats, fleet divisions, and score-sheet layouts.
- Release a public **Southeast Asia Optimist Results** hub with Singapore and Malaysia filters, event links, sailor histories, and a country label on every profile.
- Add a lightweight “claim this profile” pathway. Because the athletes are often minors, profile claims and profile enrichment should be designed for parent/guardian, coach, or club mediation rather than unrestricted personal-data collection.
- Publish a country-coverage card that lists included events and last verified update. Never imply that all events in Malaysia or Singapore are included.

**Exit gate:** at least two participating organisations, four or more verified cross-border events, 80% or more of result rows matched to a stable sailor record after review, and a documented correction path used successfully at least once.

### Phase 2 — establish the regional data network

**Timing:** Months 4–8

Add Thailand, the Philippines, and Indonesia as partner-led markets. The goal is a repeatable data network, not a leaderboard.

- Give every partner a simple intake path: official PDF or result URL, event metadata, class/division structure, and the organiser contact who can resolve exceptions.
- Create a small partner dashboard or assisted admin workflow with three clear states: **draft**, **in review**, and **published**. An organiser should be able to see exactly what SailorPath has interpreted before it is public.
- Record the country of the event separately from a sailor’s country representation. Sailors can race abroad, change clubs, or have a different nationality/country representation; the system must not infer one from the other.
- Build exception queues for duplicate names, missing sail numbers, inconsistent divisions, team/crew entries, and contradictory totals. Ambiguous records remain out of any points calculation until reviewed.
- Publish a regional event calendar only for events whose organiser, date, location, and class details are confirmed. Separate calendar visibility from results eligibility.
- Start a quarterly partner check-in: coverage gaps, source formats, corrections, and prospective eligible events for the following season.

**Exit gate:** five active markets or equivalent proven event coverage, at least eight recurring organiser relationships, 20 verified Optimist events in the preceding 12 months, and 90% or more of published rows matched or explicitly held for review.

### Phase 3 — launch a declared regional season, not an all-results ranking

**Timing:** Months 8–12

Once coverage and governance pass the Phase 2 gate, create a pilot **Southeast Asia Optimist Series**. This is a scheduled, published set of eligible events. It is not a retrospective score created from every result that happens to be available.

- Publish the season calendar, the eligible event list, divisions, eligibility rules, scoring rule, tie-breaks, correction window, and policy version before the first eligible event.
- Use a dedicated season/event-membership layer rather than a broad `counts_for_ranking` switch. A published result can remain visible without being eligible for the regional season.
- Keep a visible audit trail for every standing: source event, fleet size, finish, points awarded, counted or discarded status, and any approved override with its reason.
- Publish standings as **Provisional** during the pilot. Make the last-calculated time and the deadline for organiser corrections visible.
- Run at least one complete calculation cycle internally before releasing it publicly. Test recalculation after a corrected race score, duplicated sailor merge, changed nationality/country field, event exclusion, and a late imported result.

**Recommended first-season policy constraints**

1. Only expressly admitted, verified Optimist class sheets can count.
2. Use one Open division first. Add age or gender divisions only when the source data is consistently collected and fleets are sufficiently constituted.
3. Count a limited number of best events rather than requiring attendance at every eligible event. This limits the advantage of proximity and travel budget.
4. Do not assign extra subjective “event strength” points in season one. Fleet-size or finish-normalisation must be simple, published, and reproducible if used at all.
5. Do not call the product a national ranking, selection ranking, championship, or federation-endorsed table without the explicit governing body agreement.
6. Every policy or result correction creates a new immutable calculation run; it does not silently rewrite a previous public standing.

**Exit gate:** one pilot season completed with no unresolved material dispute, all eligible-event results source-verified, calculation runs reproducible, and partner approval to continue or revise the policy.

### Phase 4 — deepen trust and participation

**Timing:** Months 12–18

Make the platform useful between regattas while retaining results as the core record.

- Add public profile achievements that are derived from verified results: first regional event, appearances by season, recent top finishes, and event participation. Keep achievements factual and opt-in where they create a social-profile feel.
- Add club and event organiser pages with their verified events, represented sailors, and transparent coverage boundaries.
- Introduce a correction and verification centre. It should accept a request, show its state, preserve the original result evidence, and record who approved the final change.
- Offer embeddable, read-only results or standings cards to participating organisers, subject to a clear attribution and source-link policy.
- Produce an annual regional results report: events covered, sailors represented, countries represented, corrections completed, and missing coverage. Avoid publishing personal-data-heavy rankings of minors simply to create engagement.
- Decide whether to expand to Vietnam, Brunei, Cambodia, Laos, Myanmar, or Timor-Leste based on an organiser relationship and official-result availability—not map completeness alone.

**Exit gate:** a repeatable partner playbook, a stable product operating cadence, and a decision backed by pilot evidence on whether the SEA Series becomes a recurring programme, remains provisional, or is replaced by country-specific leaderboards plus regional event histories.

## Product architecture that supports the roadmap

The regional launch should extend the current SailorPath model rather than fork it by country.

| Layer | Required capability | Rule that preserves trust |
|---|---|---|
| Sailor identity | Stable individual sailor ID, aliases, historical sail numbers, country representation history, and club history. | Never create a new person merely because a spelling, club, or sail number changed. Never merge ambiguous people automatically. |
| Official event record | Regatta, host country, venue, organiser, class sheet, source artefact/URL, import reviewer, and publication status. | Preserve the original result evidence and the exact official display name. |
| Results | Canonical entry result plus race-level scores where supplied. | Reconcile ranks, discards, totals, and net scores before publication. |
| Country coverage | Included events, last verified date, partner relationship, and known gaps. | Describe actual coverage; never imply regional completeness. |
| Leaderboard season | Explicit eligible-event membership, divisions, policy snapshot, immutable calculation run, standings, and per-event calculation trail. | Results become ranking inputs only through a published season policy. |
| Corrections | Request, evidence, reviewer, decision, and replacement calculation run if needed. | A correction must be auditable and must not erase the original evidence. |

The existing seasonal-leaderboard design direction—configured seasons, admitted canonical events, immutable calculation runs, and audit rows—is the right pattern to generalise. The first regional Optimist season should use that dedicated configuration rather than altering the current Singapore ranking engine in place.

## Partnership model

SailorPath needs a small network of trusted local stewards, not a large sales organisation.

**The minimum partner offer** should be simple: SailorPath turns official results into permanent, shareable event pages and sailor histories; the organiser retains ownership of its event, can review the imported sheet, and receives a link or embed for its own channels.

**Ask of each partner:** provide official results or a stable official URL, confirm material corrections, designate one contact, and give notice when a new Optimist event is published. Do not ask them to manually maintain a complex database.

**Suggested relationship types:**

- **Founding event partner:** supplies results for a recurring regional or national-level event and reviews publication.
- **Country data steward:** acts as the local quality contact for two or more organisers; this is a trust role, not a claim of federation authority.
- **Club contributor:** submits individual event results that are reviewed before public release.
- **Parent/coach verifier:** can help claim or correct a sailor profile but cannot unilaterally alter official scores.

The initial commercial approach should be free participation for founding partners. The product needs coverage and trust more than it needs early leaderboard revenue. Later, SailorPath can test organiser tools, event embeds, and reporting as optional services without placing basic official results behind a paywall.

## Governance and child-safety rules

Optimist sailors are commonly minors, so regional expansion must be privacy-first.

- Public profiles should default to name, country/club representation where published or approved, event results, and non-sensitive sporting history.
- Do not publish contact information, exact birth dates, school names, family information, live location, or private images by default.
- Treat a profile claim as an account-linking and correction workflow, not permission to rewrite historical official results.
- Let a parent/guardian, club, or coach manage optional profile enrichment. Give SailorPath a clear report/remove route.
- Keep **official result**, **SailorPath-verified**, **partner-reviewed**, and **community-submitted** visibly distinct.
- Establish a published correction standard: preserve source evidence, state what changed, explain material ranking effects, and issue a replacement leaderboard run where applicable.

## Metrics and operating cadence

Measure trust and coverage before vanity traffic.

| Area | Leading measure | Quality threshold before scaling |
|---|---|---|
| Coverage | Verified Optimist events in the latest 12 months, by market. | Expand only when the previous market has recurring data, not one-off imports. |
| Identity | Share of result rows matched to a stable sailor record. | 80% in the Malaysia pilot; 90% before an SEA Series. |
| Source quality | Share of published events with retained official source and recorded reviewer. | 100%. |
| Corrections | Median time to acknowledge and resolve a material correction. | Publish the service target and improve it before adding major event volume. |
| Partner health | Active organisers who submitted or verified a result in the last six months. | At least one recurring source per launched market. |
| Ranking integrity | Eligible-event results with a reproducible audit trail. | 100%; otherwise standings remain unavailable. |
| Participation fairness | Distribution of counted events per ranked sailor and country. | Review after every calculation run; revise future policy if geography or travel clearly dominates. |

Run the operation on a simple cadence:

- **After each event:** import, reconcile, partner review, publish, and record exceptions.
- **Monthly:** publish coverage updates, merge identity evidence, and resolve the correction queue.
- **Quarterly:** partner check-in and prospective-season event review.
- **Before every season:** lock policy and eligibility; do not change them mid-season except through a documented, exceptional correction process.

## Decisions to make now

1. Approve the product order: **verified results first, declared regional series later**.
2. Choose the first Malaysian organiser or club to approach as a data partner.
3. Nominate one internal owner for result integrity and one for partner relationships; the same person can hold both roles at first.
4. Confirm the regional profile privacy policy and claim workflow before public cross-border discovery is promoted.
5. Use the next development cycle to build the country/source/reviewer fields and the regional coverage view—not a broad regional rank table.

The practical first milestone is modest but valuable: a Singapore–Malaysia results hub that makes it easy for a sailor’s verified history to follow them across the border. Once that works repeatedly, SailorPath will have the evidence and partner trust needed to decide what a credible Southeast Asia Optimist leaderboard should be.
