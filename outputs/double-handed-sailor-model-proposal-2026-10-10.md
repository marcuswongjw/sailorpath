# Double-Handed Sailor Model Proposal

**Prepared:** 10 October 2026
**Status:** Design recommendation only — no database or application records changed

## Decision

> Keep **every sailor as an individual profile**. Model a double-handed boat as a **regatta entry** with two (or more) individual participants.

Do **not** create or retain permanent profiles such as `Seth Low / Amos Tham` or `Cheryl Yong / Febe Wong`. Those are boat-entry labels, not people. A sailor may race with a different partner at the next regatta, so a global one-to-one `partner_id` on `sailors` would be incorrect.

The partnership should be **scoped to the result entry**. A profile can then show:

- the shared result on *both* sailors’ histories;
- the teammate(s) and, where known, helm/crew role;
- the event-specific boat/sail number; and
- a derived history of partners without treating a partner as permanent identity data.

## Why the existing model fails

The current model has one required `regatta_results.sailor_id` and a uniqueness constraint on `(sailor_id, regatta_id)`. It therefore represents an **individual sailor result**, even when an official result row represents a boat crew.

The live database currently has **23 29er result rows across seven class sheets**. Each has exactly one `sailor_id`; many point to profiles named with both sailors, for example:

- `Seth Low / Amos Tham`
- `Nicole Ng Hui Hong / Ezann Sephira Tan`
- `Cheryl Yong / Febe Wong`
- `Sean Kum / Nigel Tan`

Other 29er source rows list only one person, so the partner is not always recoverable from existing data. This is why the model must preserve the official entry label and permit an unresolved participant during historical cleanup.

This representation causes three problems:

1. A crew result belongs to a synthetic team profile instead of the two athletes’ profiles.
2. A crew change produces a new synthetic profile, which looks like a duplicate sailor.
3. The importer matches the complete team string as one name, so aliases and individual identity resolution cannot work correctly.

## Recommended data model

### Core principle: one score, many participants

Keep `regatta_results` as the stored score/race-record entity in the first implementation phase, but treat it logically as a **regatta entry result**. Add a participant join table.

```text
sailors (individual people)
     │ 1..*                         *..1
     └──── regatta_result_participants ──── regatta_results (boat entry / score)
                                                   │ 1..*
                                                   └──── regatta_race_results
```

### 1. Add entry metadata to `regatta_results`

These values describe the boat entry at that event and must not overwrite a sailor’s current equipment profile.

| Field | Purpose |
|---|---|
| `entry_label` | Exact official result-row text, e.g. `Seth Low / Amos Tham`. |
| `entry_sail_number` | Sail/boat number used at this regatta entry. |
| `entry_board_number` | Board number when the class uses boards. |
| `entry_type` | `individual` or `crew`; allows an event-specific override. |
| Existing `sailor_id` (transition only) | Retain it temporarily for legacy code, pointing to the first/primary participant rather than the whole crew. Rename or remove it after all readers use participants. |

`entry_label` is important for evidence fidelity. The public result can display the organiser’s exact label even after the individual profiles are matched and names are corrected.

### 2. Add `regatta_result_participants`

This table is the source of truth for who sailed an entry.

| Field | Purpose |
|---|---|
| `id` | Primary key. |
| `regatta_result_id` | Parent boat-entry result; cascade delete with the result. |
| `sailor_id` | Linked individual profile; nullable only while a historical/import match awaits review. |
| `source_name` | Raw person name exactly as it appeared in the source. |
| `display_order` | Source order, beginning at 1; never assume it means helm/crew. |
| `role` | `solo`, `helm`, `crew`, `member`, or `unknown`. |
| `match_status` | `matched`, `needs_review`, or `unresolved`. |
| `ranking_credit` | Explicit per-sailor ranking policy switch; see below. |
| `created_at`, `updated_at` | Audit fields. |

Recommended constraints and indexes:

```sql
UNIQUE (regatta_result_id, sailor_id) WHERE sailor_id IS NOT NULL;
UNIQUE (regatta_result_id, display_order);
INDEX  (sailor_id, regatta_result_id);
INDEX  (regatta_result_id, display_order);
```

A DB trigger or publish-time validation should enforce that a `crew` entry has two resolved participants before it can be published. `unknown` role is valid: official result sheets often list two names but do not identify helm and crew.

### 3. Add crew metadata to the regatta sheet

Add the following to `regattas` so the admin interface knows what to collect:

| Field | Default | Meaning |
|---|---:|---|
| `entry_type` | `individual` | `individual` or `crew` |
| `min_participants` | 1 | Minimum people required on a published entry |
| `max_participants` | 1 | Maximum people allowed on an entry |

For a 29er sheet, set `entry_type = 'crew'`, `min_participants = 2`, and `max_participants = 2`. This avoids hard-coding every future class in UI or importer logic and also supports 420, 470, 49er/49erFX, Nacra 17, Hobie 16, and other crewed classes.

## What not to model

### Do not add `partner_id` to `sailors`

A sailor can have different partners by class, season, event, or even event division. A single profile-level partner field would become stale and cannot preserve history.

### Do not make a global pair record the source of results

A `sailor_partnerships` table is optional later as a convenience feature for a “current partner” card. It must be derived from, or explicitly linked to, the actual entry memberships. It must not own the score or replace individual participant records.

### Do not duplicate the score/races once per sailor

There must be **one** entry result and one set of race scores for the boat. Duplicating the same result twice makes corrections diverge and double-counts race data.

## Expected behaviour

### Admin result creation/editing

1. Admin selects a regatta sheet.
2. If the sheet is `individual`, the form stays as it is today: one sailor.
3. If it is `crew`, the form shows a **Crew members** section:
   - Add sailor profile search / create individual sailor.
   - Select two members.
   - Optional roles: helm and crew; default is `unknown`.
   - Preserve the official entry label and entry sail number.
4. One result record and one race-score set are saved.
5. The same result becomes visible on every matched participant’s profile.

A crew can change between events without changing either sailor’s identity or profile. A team can also race in multiple classes only when each entry explicitly records its members.

### Import flow

For a regatta configured as `crew`:

1. Keep the full source row as `entry_label`.
2. Parse member names from the reviewed source into separate candidate names. Support `/`, `&`, and other source-specific separators only after the importer has identified the row as a crew entry.
3. Run the existing name/alias matching logic **for each individual name**, not for the complete team label.
4. Present ambiguous matches in the review screen. Never silently create a combined team sailor profile.
5. If a sailor cannot be matched, create or select an **individual** profile, or retain an unresolved participant until an admin resolves it.
6. Store roles as `unknown` unless the source actually identifies helm and crew.

Suggested import payload shape:

```ts
{
  entry: {
    sourceLabel: "Seth Low / Amos Tham",
    sailNumber: "SGP",
    type: "crew",
    participants: [
      { sourceName: "Seth Low", sailorId: "…", role: "unknown", displayOrder: 1 },
      { sourceName: "Amos Tham", sailorId: "…", role: "unknown", displayOrder: 2 },
    ],
  },
  result: { rank: 1, total: 9, nett: 7, races: [...] },
}
```

### Public profile and regatta views

On a sailor profile, label a shared result clearly:

> **CSC ILCA & 29er Championships 2024 — 1st of 4**
> 29er · **With Amos Tham** · Role not recorded · Sail SGP

On the public regatta table, render one boat-entry row with both linked people:

> 1. **Seth Low** / **Amos Tham** — SGP — 7 net points

Do not render two identical rows, one for each participant.

### Partner history

A profile can derive a team-racing history by joining its participant rows to the other rows in the same entry:

| Partner | Class | Entries together | First / latest event | Roles |
|---|---|---:|---|---|
| Amos Tham | 29er | 3 | Jan 2024 / Sep 2024 | unknown |

This gives users the useful “paired with” experience while keeping the relationship accurate and historical.

## Ranking and statistics policy

A crew result should appear in **each participant’s result history**, but ranking credit needs an explicit rule.

Recommended defaults:

1. **Do not let team results leak into Optimist or ILCA individual rankings.** Existing boat-class filtering already helps, but the participant link should be respected by every ranking query.
2. For a future 29er ranking, decide whether both sailors receive the entry’s score, only the helm does, or the entry is team-ranked only. Record the decision per participant through `ranking_credit`.
3. Until that policy is approved, import crew results with `ranking_credit = false` and still display them in profile history.
4. Count one event appearance per sailor per entry. Never double-count an entry because it has two participants.

The existing live data has some 29er sheets marked `counts_for_ranking = true`; that flag alone should not decide individual crew credit.

## Safe migration plan

### Phase 0 — agree policy and inventory source data

- Confirm crew classes and the ranking-credit rule.
- Review the existing 29er team-name profiles and map each source name to individual profiles.
- Identify source rows that list only one person; leave the missing partner unresolved rather than guessing.

### Phase 1 — additive schema and backfill

1. Add the entry metadata and `regatta_result_participants` table.
2. Backfill every existing result as exactly one participant:
   - `role = 'solo'`
   - `match_status = 'matched'`
   - `display_order = 1`
3. Keep `regatta_results.sailor_id` temporarily as a legacy primary participant link, so current routes remain operable during the rollout.
4. Update reads to return `participants` and to locate profile results through the participant table.

### Phase 2 — change admin and import writes

1. Update the result editor and API to accept `participants[]`.
2. Update imports and review UI to resolve each crew member individually.
3. Preserve backward compatibility: a legacy `sailorId` request produces a one-member `solo` participant list.
4. Update duplicate detection so `sourceLabel` and composite names are never candidates for `sailor_aliases`.

### Phase 3 — migrate historical 29er records

For each composite historical profile:

1. Verify the two individual identities from official evidence.
2. Add their participant rows to the existing result; do **not** create a second score or duplicate race results.
3. Put the original combined source string in `entry_label`.
4. Reassign the legacy primary link to a selected participant only for transition compatibility.
5. After every dependent link has moved and the individual mapping is reviewed, remove the synthetic team profile.

The combined profile should be removed only after it has no result, claim, alias, follow, note, or audit dependency. It must not be merged into one of the two people because that would misattribute the other sailor’s result.

### Phase 4 — complete query and UI migration

Update these current integration points to use participant membership instead of only `regattaResults.sailorId`:

- `getResultsForSailor` and the public sailor profile page;
- admin result CRUD (`/api/admin/results`);
- admin import and its authoritative-replace/reconciliation paths;
- result suggestions and readiness views;
- profile-follow notifications; and
- all ranking/statistics queries.

When all readers/writers use participants, rename the legacy field to `primary_participant_id` or remove it in a later planned migration.

## Acceptance tests

Before publishing the capability, cover at least the following:

| Scenario | Expected result |
|---|---|
| Add a 29er result for two existing sailors | One entry/result, two participant rows, one race-score set. |
| View either sailor profile | Both show the same result and linked teammate. |
| Crew changes at the next regatta | Each sailor keeps their profile; new entry shows the new pair. |
| Official row has no stated helm/crew | Both roles remain `unknown`; no inference from name order. |
| One member is unmatched | Import stops for review or stores a clearly unresolved participant; no team profile is created. |
| Edit a result score | Score/race change is reflected for both profiles exactly once. |
| Merge two duplicate sailor profiles | Participant FKs move to the canonical individual profile without creating duplicate results. |
| Authoritative re-import | Reconciles entries by entry identity and does not delete a teammate’s membership. |
| Ranking calculation | Crew result appears in history but receives only the approved participant-level ranking credit. |

## Implementation recommendation

Implement the **additive participant-table design** first. It preserves every existing result and race score, avoids a disruptive full table rename, and lets SailorPath progressively replace team profiles with individual identities. A later cleanup can rename `regatta_results` to `regatta_entries` once all APIs and imports operate on the new model.

The critical product rule is simple: **people have profiles; boats have entries; results belong to entries; entries have people.**
