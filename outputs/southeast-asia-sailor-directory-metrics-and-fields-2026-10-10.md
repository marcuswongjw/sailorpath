# Southeast Asia sailor directory — key metrics and profile fields

**Prepared:** 10 October 2026
**Status:** Product specification draft — no personal data, database schema, or public profile is changed by this document.

## Product rule

The directory should be a **verified sporting record**, not a social network and not a regional ranking by default.

A profile answers four simple questions:

1. **Who is this sailor in published results?**
2. **Which country and club do they currently represent, where known?**
3. **What verified events have they raced, and how did they finish?**
4. **Where do they appear in an explicitly published country leaderboard or declared international circuit?**

Because Optimist sailors are usually minors, profile data must be minimal, source-backed, and easy to correct. The platform should never create a public profile from unverified personal information merely to make the directory look complete.

## Public profile: MVP fields

These are the fields that should appear on a public sailor profile from the initial regional launch.

| Profile area | Field | Public display rule | Purpose |
|---|---|---|---|
| Identity | Display name | Use the verified canonical display name. Preserve alternate official spellings in the result evidence, not the public header. | Lets users find the same sailor across result sheets. |
| Identity | Country representation | Show the most recently verified representation, labelled with its source or season where it could be ambiguous. | Allows country browsing without inferring nationality from an event location. |
| Identity | Current club | Show only if supplied in an official result or confirmed through a claim/partner review. Include “Not listed” rather than guessing. | Makes the directory useful to clubs and coaches. |
| Identity | Class | Show **Optimist** while the sailor has verified Optimist participation. | Prevents a broader class history from becoming an identity claim. |
| Identity | Recent sail number | Optional; label it with the relevant event/class and date. Do not treat it as a permanent unique identifier. | Helps result recognition without creating false matches when numbers change or are reused. |
| Trust | Profile status | Use a concise badge: **Verified results**, **Claimed profile**, or **Partner reviewed**. | Explains what SailorPath has actually verified. |
| Trust | Last verified update | Show a date such as “Results verified through 12 Sep 2026.” | Makes data freshness clear. |
| Optional media | Profile photo | Display only after an explicit parent/guardian or authorised-club approval. | Keeps the profile human without making images a default requirement. |

The profile header should remain deliberately short. Do **not** put age, birth date, school, home area, parent names, phone number, email, social links, or a live location on a public junior-sailor profile.

## Public profile: results and metrics

The first release should favour facts that are both understandable and defensible. Every headline metric must link to the events and results behind it.

| Metric | Definition | Display condition | Why it matters |
|---|---|---|---|
| Verified regatta appearances | Count of published event results where the sailor has a final overall position. | Always, when at least one result exists. | Gives a simple participation record. |
| Seasons raced | Distinct calendar seasons with a verified Optimist result. | Always, once results span more than one season. | Provides context without rewarding an older sailor merely for racing longer. |
| Latest verified result | Event name, date, overall place, and eligible fleet size. | Always. | Provides the most useful current fact. |
| Best verified finish | Best overall place, shown with event and fleet size. | Only with the underlying event link. | Highlights an achievement without creating a synthetic rank. |
| Top-10 finishes | Count of top-10 overall finishes in verified fleets of 20 or more sailors. | Display only when non-zero. | Meaningful achievement metric that avoids tiny-fleet inflation. |
| Podium finishes | Count of first, second, or third overall finishes in verified fleets of 20 or more sailors. | Display only when non-zero. | Clear and familiar result summary. |
| 12-month event count | Verified regatta appearances in the most recent 365 days. | Only after the directory has reliable date coverage. | Shows activity without requiring travel. |
| Median finish percentile | Median of each eligible event’s final-place percentile over the last 12 months. | At least three compatible events, each with 10 or more starters. | Lets users compare results across different fleet sizes without calling it a ranking. |
| Top-quarter rate | Share of eligible results finished in the top 25% of the field over the last 12 months. | At least four compatible events, each with 10 or more starters. | A stable form indicator that is easier to interpret than average finishing place. |
| Race starts / finishes | Count from verified race-level result data. | Only when every race in the included event is imported and reconciled. | Useful for performance context, but never estimate it from an overall table. |
| Country leaderboard position | Position in a named, published SailorPath country season. | Only for an approved country leaderboard with a visible policy and calculation date. | Gives local comparison where participation is genuinely comparable. |
| International-circuit position | Position in a separately declared cross-border circuit. | Only when the sailor meets that circuit’s explicit participation rules. | Keeps a travel-based table distinct from normal country standings. |

### How to calculate the percentile metrics

For an overall final place `P` in a verified fleet of `N` sailors:

```text
Finish percentile = 100 × (N − P) ÷ (N − 1)
```

First is 100; last is 0. Exclude cohorts with fewer than 10 sailors from the profile percentile metrics. Use the event’s published final overall cohort, not a guessed fleet size and not a combined set of incompatible age divisions.

For example, fifth of 20 is a 78.95 finish percentile; fifth of 60 is 93.22. This expresses the sailor’s position within the actual field. It is a descriptive statistic, not a claim that one event’s fleet was stronger than another.

## Results history: the most important profile section

The results table is the core of every profile. It should appear before badges, charts, or social features.

| Field in each result row | Requirement |
|---|---|
| Event name and event page link | Required. |
| Event date and host country | Required. |
| Organiser and venue, where supplied | Helpful context; omit if not verified. |
| Class and official division | Required. Never relabel an organiser’s category silently. |
| Overall finish and field size | Required for a comparable performance display. |
| Net points and race-by-race scores | Show only where the official sheet supplies them and they passed reconciliation. |
| Sail number used at that event | Optional event-level evidence; never overwrite the sailor’s current identity. |
| Result source and verification status | Required. Link to source artefact/official page where possible. |
| Partner / organiser correction state | Show a simple “Corrected on” note when materially relevant; preserve the result’s audit history internally. |

A good public result row looks like this:

> **Eastern Seaboard Youth Regatta** · Thailand · 22–26 Oct 2027
> Optimist Overall · **8th of 81** · 74.8 finish percentile · Verified official result

The row should not say “SEA rank #42” unless a separately published circuit genuinely supports that claim.

## Directory-page fields and filters

The directory should help users discover sailors without making unverified performance comparisons.

### Search and filters

- Name and official result-name alias
- Country representation
- Club
- Class and official division
- Season or date range
- Host country of event
- Specific regatta
- Result verification status
- Country leaderboard eligibility, only where a published leaderboard exists
- International-event appearance, as a factual filter rather than a rank

Do not include filters for exact age, school, gender, home city, parent/guardian identity, or private contact information.

### Directory result card

Each search result should show only:

1. Sailor name and optional approved photo.
2. Current verified country representation and club, if known.
3. Verified Optimist event count in the last 12 months.
4. Latest verified result in the form `Event — place / fleet`.
5. Current country leaderboard position, if a public policy applies.
6. A small status label, such as **Verified results**.

This is enough for discovery. The full history and calculations belong on the profile page.

## Data held privately or restricted to admins

These fields may be necessary for identity matching, safeguarding, account administration, or corrections. They should not be public.

| Restricted field | Reason for restriction |
|---|---|
| Legal name, date of birth, sex/gender, identity document information | Sensitive personal data; exact birth date is especially inappropriate for junior public profiles. |
| Parent/guardian and emergency contacts | Safeguarding and account operations only. |
| Email, phone, social handles, messaging accounts, and home address | Never public by default. |
| Result-source raw rows, OCR output, source PDF, screenshots, and matching notes | Essential audit evidence, but not a public personal-data surface. |
| Name aliases and possible-duplicate candidates | Required for reconciliation; do not expose uncertainty about a child’s identity. |
| Historical club/country changes that are unconfirmed | Retain for review but do not publish as fact. |
| Profile claim permissions, consent evidence, and removal requests | Private governance records. |
| Internal integrity flags, reviewer notes, and dispute history | Keep internal so a routine correction does not stigmatise a sailor publicly. |

## Metrics to avoid

Do not add the following in the first regional release:

- A universal **Southeast Asia overall rank**.
- “Most improved” badges based on incomplete cross-country data.
- Win percentage or average finish without a fleet-size context.
- Travel count, countries visited, or “most international sailor” as a public status marker.
- Algorithmic potential, talent, selection likelihood, coach rating, or predicted future results.
- Public head-to-head records unless the product has a clear rule for same-event comparisons and the community asks for it.
- Public negative indicators such as DNFs, protests, penalties, or correction/dispute counts as profile badges.

These either reward access rather than sailing, depend on uneven coverage, or create an unnecessary reputation system for young sailors.

## Data-quality rules behind every metric

A public metric should be generated only when its input data passes all relevant checks:

1. The sailor match is canonical or explicitly partner-reviewed.
2. The event is published and has a retained official source.
3. The final place, fleet size, net score, and discards reconcile with the visible official result table.
4. The source division matches the metric’s cohort rule.
5. The calculation version and data-through date are stored with the derived statistic.

If an import is incomplete, show the result row if it is safe to publish, but suppress downstream percentile, badge, and leaderboard calculations. “Not enough verified data yet” is more trustworthy than a precise-looking number built on weak evidence.

## Recommended profile layout

```text
[Photo, only if approved]  Sailor name
Country representation · Club · Optimist · Verified results
Results verified through: date

Latest result             Verified appearances     Country leaderboard
Event — place / fleet     12 in last 12 months     #4 — 2027 Singapore season

Recent verified results
[Event rows with source links and official result data]

Performance snapshot
[Best result] [Top-10 finishes] [Median finish percentile]

Country leaderboard / international circuit
[Only where a published policy applies; link to calculation detail]
```

The first screen should lead with **results and source confidence**, not gamified badges. A profile becomes more useful as coverage grows, but it should remain respectful and complete even for a sailor with one verified event.

## Implementation priority

Build these in order:

1. Canonical sailor identity, official-result evidence, country/club representation, and results history.
2. Search, country/club/event filters, profile status, and freshness label.
3. Latest result, event counts, best result, and country leaderboard position where already governed.
4. Percentile, top-quarter, top-10, and podium metrics once cohort sizes and event ingestion are reliable.
5. Opt-in photo and richer profile content after a parent/guardian or club-authorisation workflow exists.
6. International-circuit fields only after a real declared circuit exists.

The key principle is: **SailorPath should show what a sailor has actually done in verified competition, without turning uneven regional participation into an artificial measure of personal worth.**
