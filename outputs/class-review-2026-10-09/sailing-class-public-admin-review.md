# SailorPath sailing-class public/admin architecture review

**Review date:** 2026-10-09
**Scope:** Optimist, ILCA 4, ILCA 6, ILCA 7, WingFoil, Techno 293, and iQFOiL; public presentation, admin/import flow, storage, publication, ranking, profiles, and event linkage.
**Nature of work:** Architecture review only. **No source, migrations, production data, deployment, or existing audit report was changed.** Existing working-tree changes—including the **findings-3 local claim changes**—were intentionally left untouched.

## Executive diagnosis

SailorPath currently has **two materially different result architectures**:

1. **Normalized event/class/result data** for Optimist and ILCA classes (and already usable for iQFOiL): a weekend/event shell, one or more class sheets, sailor standings, and individual race scores. This is the correct foundation for a unified calendar, generic event hub, sailor profiles, imports, publication lifecycle, and—where policy exists—rankings.
2. **Special JSONB scoreboards** for WingFoil and Techno 293, supplemented by static seed files and browser `localStorage`. These provide class-specific scorecard/series UX but are not automatically linked to normalized sailors, result histories, race-result rows, or generic event pages.

> **Core diagnosis:** the reported “missing” WingFoil/Techno regattas are often a **catalog/registry and source-of-truth problem**, not proof that a public result has been deleted or is unpublished. The default public Regattas tabs are driven by static `REGATTA_EVENTS` class slices, while special scoreboards use published special-table/seed data. Those are distinct selectors over distinct stores.

### Decisive product direction

Adopt **one canonical event/class/results model** for all disciplines:

- `regatta_events` owns the event/weekend identity and public event metadata;
- `regattas` owns a single class/fleet sheet, with class, fleet/division, lifecycle and event linkage;
- `regatta_results` and `regatta_race_results` own sailor-linked standings and official race values;
- dedicated WingFoil/Techno scoreboards become **renderer/import/series adapters** over canonical data when their class-specific scoring display is genuinely needed—not new, parallel primary data silos.

This does **not** require immediately deleting special scoreboards. A low-risk path is to stabilize IDs, expose provenance, and bridge special records to canonical event/class sheets first; migrate/derive only after inventory and reconciliation. iQFOiL should start directly on the normalized path and **must not receive another JSONB silo by default**.

### Current facts vs. recommendations vs. unverified assumptions

| Category | What this review establishes |
|---|---|
| **Current facts** | The repository implements normalized sheets/results/races for generic classes and separate JSONB scoreboards for WingFoil/Techno. Admin navigation exposes specialist panels only for WingFoil and Techno. The calendar/event catalog and special scoreboards have separate public selectors. |
| **Recommendations** | Make normalized event/class/results canonical; retain specialized renderers/adapters where UX/scoring needs warrant them; explicit lifecycle and source provenance; close class-registry gaps; implement iQFOiL on the normalized route first. |
| **Not verified** | No authenticated production database, admin endpoint, RLS-effective server role, or full production inventory was accessed. Anonymous pages/APIs and repository code do **not** establish DB row counts, exact omissions, or deployment behavior for all lifecycle states. |

---

## 1. Current public/admin comparison by class

| Class | Public entry points and display | Admin/import path | Current primary storage/query path | National-ranking status | Principal architecture concern |
|---|---|---|---|---|---|
| **Optimist** | [`/sg/optimist/regattas`](https://sailorpath.com/sg/optimist/regattas) redirects to `/calendar?class=optimist&view=past`; Gold/Silver pages and `/api/rankings?fleet=Gold|Silver` are public. Event/result details resolve through shared routes. | Generic Events/Regattas, Results, and Import; no Optimist-specialist scoreboard. | Normalized `regatta_events → regattas → regatta_results → regatta_race_results`. | **Supported.** Published eligible Optimist/legacy sheets; best 3 of up to 5, lower total wins. | Mislinked/mislabeled sheets can be detached from their event tab or hidden by calendar filters; do not mistake that for missing data. |
| **ILCA 4** | [`/sg/ilca4`](https://sailorpath.com/sg/ilca4), shared calendar and shared detail route; public ranking API. | Generic class-sheet workflow plus independent ILCA national-list membership controls. | Normalized tables; ILCA ranking joins published sheets/results and membership. | **Supported.** High points; best 3 of last 5; roster restricted by national-list logic. | Calendar matcher does not fully align with ranking aliases: `Laser 4.7` can be ranking-recognized yet fail the ILCA4 calendar filter. |
| **ILCA 6** | [`/sg/ilca6`](https://sailorpath.com/sg/ilca6), shared calendar/detail and public ranking API. | Generic class-sheet import/edit plus ILCA 6 national-list membership controls. | Normalized tables; static ILCA 6 supplementation exists in ranking output. | **Supported.** High points; best 3 of up to 5; national-list eligibility. | Do not interpret static supplementation or public API rows as an authoritative DB census. |
| **ILCA 7** | [`/sg/ilca7`](https://sailorpath.com/sg/ilca7), generic calendar/detail and an ILCA7 standings UI/API response. | Generic normalized workflow and ILCA panel. | Normalized tables plus ILCA7 static seed behavior. | **Not to be represented as a confirmed national-ranking policy in this review.** | Alias/detail/profile inconsistencies: `Laser Standard`/`Standard` handling, generic detail selection, and analytics grouping can conflate or misroute ILCA family results. |
| **WingFoil** | [`/sg/wingfoil`](https://sailorpath.com/sg/wingfoil), [`/api/wingfoil`](https://sailorpath.com/api/wingfoil), event hub `/regattas/{slug}`, calendar and rankings discovery. Default Regattas and Results/Standings use different data selectors. | Dedicated `AdminWingfoilPanel`: special event/entry editing, Excel import, score recalculation, local storage, then special API sync. | `wingfoil_regattas(id,status,data JSONB)` plus bundled seed data and `sailorpath_wingfoil_regattas_v1`; separate from normalized results. | **No rolling national ranking.** It has event scorecards and configured series aggregation. | Published scoreboards can be omitted from the default Regattas list when no matching static `REGATTA_EVENTS` WingFoil slice/static ID exists. No automatic sailor-profile or normalized event linkage. |
| **Techno 293** | [`/sg/techno293`](https://sailorpath.com/sg/techno293), [`/api/techno293`](https://sailorpath.com/api/techno293), generic event details. Dedicated page has Regattas, Overall Championship, Regatta Standings and Class Specs. | Dedicated `AdminTechno293Panel`; event/entry/race editing and Excel import reusing special parser; API/localStorage sync. Generic class-sheet import is a second independent path. | `techno293_regattas(id,status,data JSONB)` plus seeds and `sailorpath_techno293_regattas_v1`; normalized rows may coexist without automatic connection. | **No national ranking.** Custom monsoon series and Low Point/discard logic are class-specific. | The generic class list and special scoreboards are different catalogs; the same event may be absent from one while present in the other, or duplicated across both. |
| **iQFOiL** | No dedicated inspected `/sg/iqfoil` page or `/api/iqfoil`; generic event-level `/regattas/[slug]` can display linked normalized sheets. Calendar supports an iQFOiL filter, but home/class-list/hub support is incomplete. | Generic class-sheet import/results workflow; no dedicated specialist panel. | Existing normalized sheets/results/races in migrations; generic profile support and shared `board_number`. | **No ranking or selection policy established.** | Import defaults can silently imply `Gold` and `countsForRanking=true`; public grouping/list support and route/navigation are incomplete. Unsupported `/api/rankings?fleet=iqfoil` currently risks Optimist-Gold fallback. |

### Evidence anchors for the comparison

- The normalized schema is defined in [`src/db/schema.ts:358-541`](../../src/db/schema.ts) for event, class-sheet, result and race-result data; sailor identity fields appear at [`src/db/schema.ts:87-115`](../../src/db/schema.ts).
- Generic calendar assembly and class-sheet attachment are in [`src/app/calendar/page.tsx:35-207`](../../src/app/calendar/page.tsx), with client filters in [`src/components/calendar/RegattaCalendarClient.tsx:182-266,396-427`](../../src/components/calendar/RegattaCalendarClient.tsx) and event grouping in [`src/lib/admin/groupRegattaEvents.ts:74-104,195-298`](../../src/lib/admin/groupRegattaEvents.ts).
- Generic admin path: [`src/components/admin/AdminDashboard.tsx:919-966,1256-1278`](../../src/components/admin/AdminDashboard.tsx), [`src/components/admin/AdminRegattasPanel.tsx:28-62,202-234`](../../src/components/admin/AdminRegattasPanel.tsx), [`src/components/admin/AdminResultsPanel.tsx:119-183`](../../src/components/admin/AdminResultsPanel.tsx), and import transaction [`src/app/api/admin/import/route.ts:1537-1718`](../../src/app/api/admin/import/route.ts).
- The specialist storage contrast is explicit in [`src/db/schema.ts:789-823`](../../src/db/schema.ts), migration [`src/db/migrations/057_techno293_class.sql:1-57`](../../src/db/migrations/057_techno293_class.sql), WingFoil API [`src/app/api/wingfoil/route.ts:14-232`](../../src/app/api/wingfoil/route.ts), and Techno API [`src/app/api/techno293/route.ts:14-240`](../../src/app/api/techno293/route.ts).

---

## 2. The two current storage/data-flow architectures

### A. Normalized event/class-sheet architecture (the reusable common path)

```text
regatta_events
  event/weekend identity, dates, venue, classes JSONB, public metadata
       │ event_id / event slug aliases
       ├─────────────────────────────┐
       ▼                             ▼
regattas (one class/fleet sheet)   calendar/event hubs
  boat_class, division, status,    grouped event card + class tabs/links
  race_count, counts_for_ranking
       │
       ├─────────────► regatta_results
       │                 sailor-linked standing, place, totals/flags
       │
       └─────────────► regatta_race_results
                         official individual race score/code/discard

Consumers: generic admin/import/edit, generic result/detail pages,
calendar, event hub, sailor profile result history, ranking engines
where an explicit class policy exists.
```

**Current behavior:**

- Admin creates/links an event and a per-class sheet, imports/edits results and race scores, then publishes through the ordinary lifecycle. The import route normalizes the sheet and upserts overall and per-race values ([`src/app/api/admin/import/route.ts:1592-1717`](../../src/app/api/admin/import/route.ts)).
- Calendar grouping prefers `event_id`, then event/slug aliases; unassigned sheets may appear separately ([`src/lib/admin/groupRegattaEvents.ts:195-298`](../../src/lib/admin/groupRegattaEvents.ts)). A card can therefore exist without a matching result sheet, and a valid sheet can be visually separated if linkage/class aliases fail.
- Generic profile views consume normalized result joins; they are not inherently aware of special JSONB scorecards ([`src/lib/queries.ts:484-555`](../../src/lib/queries.ts), [`src/lib/profileFromRegatta.ts:17-28,55-79`](../../src/lib/profileFromRegatta.ts)).
- Generic application query code excludes `archived`, but does not always explicitly require `published`; the migration/RLS model declares published-only public reads. Runtime behavior depends on the deployed database role and was **not verified** ([`src/lib/queries.ts:278-357`](../../src/lib/queries.ts), [`src/db/migrations/053_regatta_lifecycle_and_rls.sql:60-81`](../../src/db/migrations/053_regatta_lifecycle_and_rls.sql)).

**Strengths:** supports sailor identity, history, per-race detail, shared event discovery, consistent admin/import, and disciplined visibility/ranking checks.

**Weaknesses to correct:** free-text/alias class divergence, incomplete event links, inconsistent public lifecycle predicates, and insufficient source/provenance signals during diagnosis.

### B. Special JSONB scoreboard architecture (WingFoil and Techno 293)

```text
wingfoil_regattas / techno293_regattas
  id + lifecycle status + whole data JSONB scorecard
       │
       ├─ public special API (published or legacy null status)
       ├─ superadmin ?all=1 / admin mutation path
       ├─ bundled static seed overlay / fallback
       ├─ browser localStorage cache/override
       └─ specialist renderer + series logic

Separate static REGATTA_EVENTS class slices
       │
       └─ default public Regattas list built from matching,
          non-draft/non-archived event slices

These are **parallel source selectors**; neither establishes a relational
result/sailor link to the other.
```

**Current behavior:**

- The special APIs expose published rows (and legacy nullable lifecycle rows); privileged `?all=1`/admin calls can access broader status sets. The public payload may overlay DB rows on static defaults or fall back to seeds ([`src/app/api/wingfoil/route.ts:14-85,87-185`](../../src/app/api/wingfoil/route.ts), [`src/app/api/techno293/route.ts:14-83,85-181`](../../src/app/api/techno293/route.ts)).
- Admin panels hydrate bundled data and localStorage, fetch the specialist all-status endpoint as superadmin, recalculate scorecards, then save/sync their JSONB record ([`src/components/admin/AdminWingfoilPanel.tsx:83-146,273-525`](../../src/components/admin/AdminWingfoilPanel.tsx), [`src/components/admin/AdminTechno293Panel.tsx:77-139,197-346`](../../src/components/admin/AdminTechno293Panel.tsx)).
- The **first/default Regattas tab** is instead a class-slice catalog generated by `getClassRegattas`: it requires a matching static event slice, screens draft/archived event definitions, and excludes combined-series sheets. It is not a direct query over every published special-table record ([`src/lib/publicDataLoader.ts:79-91,240-324`](../../src/lib/publicDataLoader.ts), [`src/components/wingfoil/WingfoilView.tsx:150-167`](../../src/components/wingfoil/WingfoilView.tsx), [`src/components/techno293/Techno293View.tsx:130-223`](../../src/components/techno293/Techno293View.tsx)).
- No FK/automatic bridge causes special JSONB results to create `regatta_results`/`regatta_race_results`; generic profile queries therefore do not automatically show those results. Migration 069 demonstrates both forms can exist for the same historical board event ([`src/db/migrations/069_add_snsc_2025_boards_results.sql:1134-1175,1606-1614`](../../src/db/migrations/069_add_snsc_2025_boards_results.sql)).

**Strengths:** purpose-built race cards, specialist imports, class-specific scoring/discard rendering, and series aggregation can be shipped quickly without reshaping the generic model.

**Structural cost:** source duplication, inconsistent public lists, local-only state, static/DB drift, missing sailor histories, and difficult publication diagnostics.

---

## 3. WingFoil: precise selected-regatta/root-cause diagnosis

### What is currently happening

The WingFoil page has different views with different selectors. That is the most important explanation for a “regatta exists in the results data/API but is not among the selected/default public Regattas” report.

| Observed selector/path | What it selects | Consequence |
|---|---|---|
| **WingFoil public API / special scorecard data** | Published (or legacy null-status) `wingfoil_regattas` rows, with static-data overlay/fallback; the client also screens embedded `lifecycleStatus`. | A published special scorecard can be selectable in Results/Standings even if no generic event catalog entry exists. |
| **Default WingFoil Regattas tab** | `getClassRegattas('wingfoil')`, which walks static `REGATTA_EVENTS` class slices, requires a matching WingFoil slice/static ID, removes draft/archived event definitions and combined-series sheets, then applies view/year/search controls. | The default tab is a curated registry-derived list, **not** all published `wingfoil_regattas`. |
| **Canonical generic event hub** | Board slices are resolved using a static ID against bundled lists rather than a relational join to `wingfoil_regattas`. | A valid special scorecard can fail to appear as the expected tab/link on an event hub if registry/slug/static ID alignment is absent. |
| **Admin special panel** | Static defaults + localStorage + superadmin `?all=1` server response. | Admin can see local-only, seed, draft/review, or unregistered records that visitors cannot. The comparison must specify source and lifecycle. |

### Root causes, ordered by likelihood

1. **Missing or mismatched `REGATTA_EVENTS` WingFoil slice/static ID.** A published custom special-table row need not have a matching registry slice. The public default list consequently omits it even though the public special API can retain it. This is a **registry/join gap**, not by itself a publication failure. Evidence: [`src/lib/publicDataLoader.ts:240-324`](../../src/lib/publicDataLoader.ts), [`src/lib/regattaEvents.ts:1295-1345`](../../src/lib/regattaEvents.ts), and [`src/components/wingfoil/WingfoilView.tsx:150-167`](../../src/components/wingfoil/WingfoilView.tsx).
2. **Intentional combined-series exclusion.** A series aggregate/combined standing can be valid scoreboard data but deliberately excluded from a per-regatta catalog. Preserve that distinction or label it clearly; do not merely add every series object to the default regatta list.
3. **Distinct lifecycle gates.** Special table status (published/null allowed), JSON payload `lifecycleStatus` (client visibility), static event `publicationStatus`, and client-side year/search/view controls are separate gates. An ID can survive one and fail another.
4. **Static seed, DB and localStorage divergence.** A visible response can be seeded/fallback data; admin local state can contain data not synced to the server. Conversely, a DB object may be absent from static navigation. Neither visual state proves the other store is complete.
5. **No normalized-event/sailor bridge.** A special scorecard is not automatically an event-hub class tab or a profile result. This manifests as apparently missing results from generic discovery even when the specialist scorecard exists.

### Public observations—useful but deliberately bounded

- On **2026-10-09**, anonymous extraction of [`/sg/wingfoil`](https://sailorpath.com/sg/wingfoil) returned a loading shell, so it did **not** validate hydrated tab behavior.
- An anonymous request to [`/api/wingfoil`](https://sailorpath.com/api/wingfoil) returned a large, truncated response with visible records including `sw-monsoon-series-gp3-2026`, `snsc-2026-wingfoil`, `sw-monsoon-series-gp2-2026`, `sw-monsoon-series-gp1-2026`, and `ne-monsoon-series-gp3-2026`. The extracted 24,014-character excerpt came from 105,436 source characters; it did **not** establish full count, source marker, table inventory, or admin visibility.
- Anonymous calendar extraction showed a private-preview/in-development presentation and class pills, but interaction/hydrated filters were not validated.

### Immediate WingFoil product decision

**Choose one of two explicit contracts for the first tab; do not leave it implicit.**

1. **“Regatta catalog” contract (minimal change):** retain the registry-driven list, label it as a curated event catalog, show provenance/status, and add a visible “All published scorecards” link/tab sourced from the special API. Maintain one registry slice/static ID for every scorecard intended to be discoverable as a standard event.
2. **“All published scorecards” contract (recommended user-facing behavior):** make the first-tab data source directly enumerate published canonical/special scorecard records, applying an explicit combined-series flag rather than accidental registry absence. Continue to offer a curated schedule/event catalog separately.

The review recommends option **2** once a stable ID bridge exists. Option **1** is the safest short-term correction because it changes only labeling, list composition, and missing registry entries—not score computation or stored results.

---

## 4. Techno 293: symmetry, differences, and what not to copy

### Symmetry with WingFoil

Techno 293 has the same architectural split:

- dedicated JSONB scoreboard table, specialist API, static seed merge/fallback, and browser localStorage;
- a dedicated admin panel and special import/edit/race-score UI;
- a default generic class Regattas list built from static `REGATTA_EVENTS` slices rather than every special-table record;
- no automatic relational bridge from special scorecard entries to normalized profile/event/race-result data.

The dedicated page itself exposes distinct **Regattas**, **Overall Championship**, and **Regatta Standings** functions. They should not be interpreted as one data inventory. Evidence: [`src/app/sg/techno293/page.tsx:20-64`](../../src/app/sg/techno293/page.tsx), [`src/components/techno293/Techno293View.tsx:77-223`](../../src/components/techno293/Techno293View.tsx), [`src/app/api/techno293/route.ts:14-240`](../../src/app/api/techno293/route.ts).

### Meaningful differences

| Topic | WingFoil | Techno 293 | Design implication |
|---|---|---|---|
| Score/series model | Event race scorecards and configured series aggregator; class specification says no rolling national ranking. | Northeast/Southwest Monsoon GP cumulative series plus class-specific Low Point/discard rules. | Preserve per-discipline renderer/scoring configuration; do **not** assume a common generic scoreboard layout covers all UX. |
| Admin import | Dedicated WingFoil parser/import and score recalculation. | Uses the WingFoil parser pattern in its own specialist panel. | Extract a shared adapter interface, not a shared JSONB source of truth. |
| Demonstrated visibility mismatch | API excerpt visibly contains multiple 2026 rounds; live page hydration could not be validated. | Anonymous public page listed seven Regattas while special API excerpt visibly included 2026 monsoon GP objects absent from that seven-row list. | Techno provides direct evidence that registry list and special scoreboards are different catalogs. |
| Canonical historical overlap | Special JSONB and normalized data are both possible. | Migration 069 explicitly has both dedicated Techno JSONB seed and normalized SNSC 2025 results. | Inventory/reconcile before either source is made authoritative or removed. |

### Techno public observation

On **2026-10-09**, anonymous extraction of [`/sg/techno293`](https://sailorpath.com/sg/techno293) rendered four tabs and **seven rows in its Regattas list**: 2025 NE Monsoon GP Series 2, NSC Cup 2 2025, SNSC 2026, SNSC 2025, Cincapura 2026, SYSC 2026, and 2025 NE Monsoon GPS Speed Challenge. In contrast, the truncated [`/api/techno293`](https://sailorpath.com/api/techno293) response visibly included 2026 SW GP1/2/3 and NE GP1/2/3 objects marked published. This supports the selector mismatch; it **does not** establish database totals or prove which backing source served every object.

### Techno decision

Do **not** copy the Techno/WingFoil JSONB pattern for iQFOiL. Retain Techno’s class-specific series/discard presentation as an adapter, but make it increasingly consume a canonical class-sheet/race-result representation or a stable one-to-one bridge. The generic and special paths must never independently accept the same operational result without reconciliation controls.

---

## 5. Generic event hub and sailor-profile impact

### Event hub impact

A generic event hub needs a reliable path from event identity to class sheet(s). The current grouping has useful fallback behavior—`event_id`, then aliases/slugs—but it is necessarily brittle when labels are free-text or static record IDs are missing. A public card can advertise a class from `regatta_events.classes` without a corresponding result sheet; similarly a real sheet can become unassigned or display elsewhere if linkage fails.

- Event/class-sheet grouping: [`src/lib/admin/groupRegattaEvents.ts:74-115,195-298`](../../src/lib/admin/groupRegattaEvents.ts).
- Event-hub class route/link behavior: [`src/components/RegattaEventHub.tsx:35-45,265-352`](../../src/components/RegattaEventHub.tsx).
- Calendar links and class matching: [`src/lib/calendar/calendarResultLinks.ts:92-123`](../../src/lib/calendar/calendarResultLinks.ts), [`src/lib/calendar/publicRegattas.ts:3-20`](../../src/lib/calendar/publicRegattas.ts).

**Consequence:** a missing event-hub tab should be diagnosed in this order: sheet existence and lifecycle, canonical class/fleet, `event_id`, event class array, slug/alias resolution, then client filters. Do not start from an assumption that the underlying results were lost.

### Profile impact

Generic profiles use normalized joins. Results stored only in `wingfoil_regattas.data` or `techno293_regattas.data` will not automatically contribute to a sailor’s history, analytics, win/finish counts, or per-race presentation. That is a product-quality issue rather than merely an admin-data issue: visitors can see a separate scorecard yet not see the same performance on the sailor profile.

- Normalized profile handling and class classification: [`src/lib/profileFromRegatta.ts:1-28,50-79,92-127`](../../src/lib/profileFromRegatta.ts), [`src/lib/boardProfile.ts:3-12,48-102`](../../src/lib/boardProfile.ts), [`src/components/sailor-profile/useSailorProfileState.ts:668-804`](../../src/components/sailor-profile/useSailorProfileState.ts).
- Existing classification needs care: profile analytics currently folds ILCA4/6/7 into an `ilca4` group ([`src/lib/profileAnalytics.ts:669-697`](../../src/lib/profileAnalytics.ts)); preserve raw class identity before presenting rollups.

### Required source provenance in public/admin UI

Every diagnostic/admin list should be able to disclose a small source badge, for example:

- **Canonical normalized result** (`event_id`, class sheet ID, published status)
- **Special scoreboard bridge** (special record ID, linked canonical event/class-sheet ID)
- **Static schedule/seed only** (no verified result sheet)
- **Local unsynced draft** (admin-only; never presented as public data)
- **Published scorecard, no event-catalog slice** (action needed: create/reconcile event mapping)

This removes the ambiguity currently caused by comparing unlike sets.

---

## 6. Ranking and scoring: strict supported-class boundary

### Current established ranking scope

Only the following are to be treated as **currently supported national-ranking classes** in this review:

| Class | Confirmed implementation boundary |
|---|---|
| **Optimist** | Published Optimist/legacy blank-class sheets; explicit non-ranking and known `<3` race sheets excluded; up to five period/division events, best three scores, lower total first ([`src/lib/ranking.ts:138-175,354-430,761-772,938-997`](../../src/lib/ranking.ts)). |
| **ILCA 4** | Published eligible normalized ILCA sheets; high points by fleet size, last-five/best-three logic; roster requires ILCA4 national-list eligibility ([`src/lib/ilcaRanking.ts:132-240,271-291`](../../src/lib/ilcaRanking.ts)). |
| **ILCA 6** | Same shared ILCA high-points/best-three implementation, constrained by ILCA6 national-list membership/seed fallback ([`src/lib/ilca6NationalList.ts:9-65`](../../src/lib/ilca6NationalList.ts), [`src/db/migrations/091_ilca6_national_list.sql:1-14`](../../src/db/migrations/091_ilca6_national_list.sql)). |

ILCA 7 has a standings computation/UI, but this review does **not** label it an approved national-ranking policy. WingFoil has a series aggregator, and Techno has monsoon series/Low Point logic; neither is a national ranking. **iQFOiL has no established ranking or selection policy**.

### Guardrails

- Never infer ranking eligibility from import defaults, a class appearing in calendar filters, a migrated sheet, or a generic `countsForRanking` field.
- Do not inherit Optimist division policy or Techno discards for iQFOiL.
- Reject unknown `fleet` values at the rankings API rather than silently mapping `iqfoil` (or any unsupported label) to Optimist Gold. The current branch behavior is a correctness and trust risk ([`src/app/api/rankings/route.ts:12-84`](../../src/app/api/rankings/route.ts)).
- Keep **Windfoil**, **Windsurfing**, **WingFoil**, **Techno 293**, and **iQFOiL** as distinct canonical identities unless an explicit, tested, event-specific alias is approved. Name similarity is not identity equivalence.

---

## 7. iQFOiL inclusion plan: normalized first, no guessed policy

### Current facts

iQFOiL is already partly supported by the reusable architecture:

- It appears in generic class taxonomy/import options and admin result/class filters ([`src/lib/admin/regattaClass.ts:3-52,66-80`](../../src/lib/admin/regattaClass.ts), [`src/components/admin/AdminResultsPanel.tsx:120-126,286-297`](../../src/components/admin/AdminResultsPanel.tsx)).
- Generic import writes normalized sheet, standing and race-result records ([`src/app/api/admin/import/route.ts:1592-1717`](../../src/app/api/admin/import/route.ts)).
- Historical migrations demonstrate normalized iQFOiL sheets/results for SNSC 2025 and SYSC 2026, marked published/non-ranking in those migration payloads—not as proof of current production state ([`src/db/migrations/069_add_snsc_2025_boards_results.sql:1134-1174`](../../src/db/migrations/069_add_snsc_2025_boards_results.sql), [`src/db/migrations/084_import_ilca_board_and_skiff_results.sql:1734-1805`](../../src/db/migrations/084_import_ilca_board_and_skiff_results.sql)).
- Board profile support and the shared `board_number` field exist. Older `sail_number` values were deliberately not backfilled, so historical completeness is unknown ([`src/db/migrations/098_board_number.sql:1-15`](../../src/db/migrations/098_board_number.sql)).
- Event definitions contain iQFOiL slices, but generic public fleet auto-grouping and `getClassRegattas` support are incomplete ([`src/lib/regattaEvents.ts:87-200,475-502`](../../src/lib/regattaEvents.ts), [`src/lib/regattaEventGroups.ts:34-100,373-401`](../../src/lib/regattaEventGroups.ts)).

### Product choices

| Decision | Recommendation | Rationale |
|---|---|---|
| Primary data model | **Normalized class sheet + results + race results.** | It already exists, works with generic imports/profiles/event hubs, and prevents a third special-board silo. |
| Public page | Add `/sg/iqfoil` only if a class landing page is a product requirement. Otherwise ensure generic `/calendar?class=iqfoil` and event result links work first. | A route is a discovery/UX decision, not a storage prerequisite. |
| Scorecard UI | Use generic result detail initially; add a renderer adapter only if official iQFOiL scorecard/series needs cannot be met declaratively. | Avoid prematurely duplicating data and formulas. |
| Ranking/selection | **Disabled/unconfigured until federation policy is supplied.** | No source supports a national ranking, division, formula, selection criteria, or series policy. |
| Import metadata | Require explicit source-derived class, fleet/division, race count, lifecycle, and `countsForRanking=false` default for unsupported classes. | Prevent dangerous inheritance of current generic `Gold`/ranking defaults. |
| Canonical naming | Standardize `iQFOiL` display plus a deliberately tested accepted-input map; never treat it as WingFoil/Windfoil/Windsurfing. | Prevent cross-discipline leakage. |

### Minimal iQFOiL delivery sequence

1. **Harden generic import defaults:** unsupported class imports must require an explicit division (often `Open`, not assumed) and explicit ranking eligibility; reject implicit Gold/ranking defaults.
2. **Complete class registry plumbing:** canonical key/label/aliases across admin selector, calendar filter, public event grouping, generic result links, profile grouping, and tests.
3. **Establish reliable discoverability:** ensure each iQFOiL normalized sheet has an event link, canonical `boat_class`, and class metadata; show it through calendar/event hub. Add a compact class page/navigation only after this is correct.
4. **Do not create `/api/iqfoil` or a JSONB table** unless a concrete specialist scorecard/series product requirement is approved.
5. **Only after policy is supplied:** design ranking/selection input, published eligibility, formula, eligibility roster, period/series dates, tie-breaks, audit trail, and governance approval; then add it as an explicit separate module.

---

## 8. Recommended target model and data contract

### Canonical entities and invariants

| Entity | Canonical responsibility | Required invariant |
|---|---|---|
| `regatta_events` | Real-world event/weekend identity, venue/date, advertised disciplines/classes, lifecycle. | One stable event ID; class metadata does not claim results exist by itself. |
| `regattas` | A published/imported **class/fleet result sheet** for an event. | Stable sheet ID; `event_id` mandatory after migration; canonical `boat_class` and explicit division; declared source/provenance. |
| `regatta_results` | Sailor-linked overall result. | Referential integrity to sailor + sheet; preserved raw/source placement and normalized outcome fields. |
| `regatta_race_results` | Official individual race scores. | Preserve raw value/code, score, discard flag, race sequence, and enough source evidence to reproduce totals. |
| `scoreboard_adapter` (new concept, not necessarily new table immediately) | Discipline-specific presentation/series derivation/import translation. | References canonical event/sheet IDs; may cache/render config but cannot become an untracked second result truth. |
| `class_registry` (new shared module/config) | Canonical ID, label, input aliases, calendar/detail/profile/ranking capabilities. | One reviewed source used by every resolver; aliases explicitly scoped and regression tested. |

### Metadata that must be preserved during convergence

Do not flatten class-specific operational facts while moving away from siloed scoreboards:

- **race rules:** race sequence, low-point/high-point method where approved, individual codes (`DNS`, `DNF`, etc.), discard timing/flag, gross/net/total source values;
- **discipline configuration:** board/sail number semantics, gender/fleet/division, age/weight/category if officially published, class-specific series inclusion and combined-series flag;
- **provenance:** source document/import run, static seed ID, special record ID, imported-at/by, reconciliation status, and canonical bridge ID;
- **sailor identity:** stable sailor ID where confidently resolved, raw entered name/sail/board number retained, and an explicit unresolved/ambiguous state—never guessed merges;
- **publication:** event lifecycle, sheet lifecycle, scorecard lifecycle, public-at timestamp, review state, and explicit source visibility; do not rely on generic application code merely excluding `archived`.

### Import and renderer adapter boundary

A specialist import may parse class-specific Excel/PDF layouts and a specialist renderer may show boards, heat scores, a series, gender segmentation, or discards. Both should output/consume a normalized internal contract:

```text
validated source → discipline import adapter → canonical event/sheet/results/races
                                                ↓
                              generic calendar, event hub, sailor profile
                                                ↓
                       optional WingFoil/Techno/iQFOiL renderer/series adapter
```

For future PDF imports, follow repository guidance: render supplied PDF pages to screenshots, visually transcribe, then cross-check visible race scores, discards, totals and net scores before any migration/import. Do not rely on text extraction alone.

---

## 9. Delivery plan: minimally invasive correction first, staged convergence second

### Phase 0 — read-only inventory and decision record (mandatory before migration)

**Do not migrate or deduplicate from public page/API snippets.** An authorized, read-only inventory should reconcile for each WingFoil/Techno/iQFOiL/normalized record:

| Verify | Read-only evidence needed | Why it matters |
|---|---|---|
| Record identity | Special ID, static ID, event ID, event slug, class-sheet ID, dates/venue/title aliases. | Detect same event represented multiple times or unlinked. |
| Source and lifecycle | DB table status, embedded JSON `lifecycleStatus`, static event publication status, client filter state, import/source marker. | Identify why an item is public, hidden, or admin-only. |
| Result content | Entrants, raw names, sail/board numbers, places, all races, codes, discards, gross/net/totals. | Confirm canonical conversion can reproduce the official scorecard. |
| Sailor resolution | Existing sailor ID, confidence, unmatched/ambiguous candidates, board-number history. | Prevent false profile attribution and cross-discipline collisions. |
| Ranking/series metadata | `countsForRanking`, race count, formula/configuration, series inclusion, combined flag. | Avoid accidentally giving a class a national-ranking semantics. |
| Public routes | Direct special API result, canonical event hub, calendar with filters cleared, direct class-sheet URL, profile view. | Separate publication, registry, grouping, and UI-filter defects. |

**Exit criterion:** a signed-off mapping sheet categorizes every active special record as `bridged`, `special-only (intentional)`, `duplicate to reconcile`, `static-only`, `local-only`, `unpublished`, or `unresolved`. Only then choose the migration/backfill order.

### Phase 1 — visibility and diagnostics (low risk, no data migration)

1. Make all public-list contracts explicit: label catalog-driven first tabs, surface an all-published-scorecards view where intended, and expose source/lifecycle badges to admins.
2. Reconcile/complete static event slices and stable IDs for intended event-hub/default-list visibility; retain explicit combined-series exclusions.
3. Make public read predicates intentionally `published` (or document and test a deliberate alternative) in the generic list/detail paths; verify effective RLS with authorized test accounts/roles.
4. Centralize/reuse class registry logic for display label, input aliases, event grouping, calendar filters, result links, profile taxonomy, and capability flags.
5. Reject unknown ranking fleet IDs. Default unsupported imported classes to non-ranking and require explicit class/fleet metadata.

**Phase 1 acceptance tests**

- A published WingFoil/Techno special record with no catalog slice is either in **All published scorecards** or visibly marked/reported as unregistered—never silently absent.
- A catalog event with no result sheet says “results unavailable” rather than producing a broken or misleading link.
- Draft, in-review, published, and archived examples have expected behavior in direct detail URL, event hub, calendar, special API, ranking engine, and anonymous client.
- ILCA 4 / `ILCA4` / `Laser 4.7`, ILCA 7 aliases, `iQFOiL`, `WingFoil`, `Windfoil`, `Windsurfing`, and `Techno 293` have explicit regression cases; no unrelated alias matches.
- `/api/rankings?fleet=iqfoil` returns a clear unsupported-fleet response, not Optimist Gold data.

### Phase 2 — stable bridge and canonical write model (controlled migration)

1. Add/establish a stable bridge for every special scorecard: `special_record_id ↔ event_id ↔ regatta class-sheet ID`, with source/provenance and reconciliation state.
2. Route new operational imports through the canonical normalized write path first; special import adapters create/update their special presentation payload only through an idempotent projection/reconciled bridge.
3. Backfill existing special results in small, reviewable batches after score reproduction and sailor-identity checks. Preserve original JSON/raw artifact for audit and rollback; do not overwrite unknown identity matches.
4. Put conflict detection on both paths: same event/class/race source hash with divergent entrants, score, discard, lifecycle, or aggregate totals blocks publication pending review.

**Phase 2 acceptance tests**

- Every bridged special scorecard has exactly one canonical event/class-sheet mapping (or a documented explicit multi-fleet exception).
- A canonical event page shows its expected class tab; a sailor’s resolved profile shows the same official placing/races as the specialist card.
- Imported rows reproduce original place, race score, code, discard, gross/net/total and series inclusion at the approved precision.
- Repeating an import is idempotent: it neither duplicates sailors/results/races nor changes a published result without an auditable revision.
- Admin can see provenance, bridge state, conflicts, and unresolved sailors; anonymous users cannot see drafts/review data through any route or API.

### Phase 3 — renderer/series derivation and selective retirement

1. Make WingFoil and Techno specialist views render from canonical data plus a versioned class configuration where practical; keep an adapter/cache only for presentation/performance or formally distinct aggregated series.
2. Retire localStorage as an authority: it may be an offline edit cache, but it must carry a user-visible unsynced indicator and cannot outrank server canonical data.
3. Retire static seed data only after each item has canonical/bridge coverage; retain fixtures for tests, clearly marked non-production.
4. Preserve a documented special-only exception path if a future class genuinely requires it, including event link, sailor identity mapping, public lifecycle, result export, and provenance—never an unregistered JSONB store.

**Phase 3 acceptance tests**

- No public class page derives availability from an unlabelled mixture of static, local, special and canonical data.
- A fresh browser with empty localStorage matches the published server/canonical results.
- Series standings are reproducible from recorded canonical race data/configuration and show source/status/version.
- Removing a special-table cache does not remove a canonical result, profile record, or event-hub link.

---

## 10. Risks, constraints, and caveats

1. **No production inventory claim.** This review used supplied repository findings and anonymous public observations. It did not authenticate to admin APIs or a production database. Static seed files, localStorage, truncated APIs, hydration shells, and migration payloads are not live DB counts.
2. **RLS/runtime uncertainty.** Migration 053 states published-only public access, but generic server code may use a role for which application predicates matter; effective runtime permissions must be tested, not inferred ([`src/db/migrations/053_regatta_lifecycle_and_rls.sql:23-81`](../../src/db/migrations/053_regatta_lifecycle_and_rls.sql), [`src/db/client.ts:1-3,59-77`](../../src/db/client.ts)).
3. **Event advertised vs. result present.** An event class label/schedule entry establishes neither a result sheet nor published standings. Conversely, an unlinked normalized sheet can be real but sit outside its expected hub/card.
4. **Identity is a data-governance decision.** Sail number/board number/name collisions must not be automatically resolved across board disciplines. Migration 098 explicitly avoided historical board-number backfill.
5. **Do not generalize ranking.** Existing class implementations/flags are not federation policy. iQFOiL and the special board classes remain non-ranking unless an authoritative policy is supplied and implemented separately.
6. **ILCA details need their own cleanup.** ILCA 7’s public standings UI should not be promoted to confirmed national status; ILCA aliases and profile grouping should be standardized without changing historic records until reviewed.
7. **This report is advisory.** It makes no code, migration, or deployment changes and does not supersede product/federation decisions.

---

## Appendix A — public observations cited in this review

All are anonymous observations dated **2026-10-09** and have the limitations described above.

| URL | Observation | What it does *not* prove |
|---|---|---|
| [`/sg/optimist/regattas`](https://sailorpath.com/sg/optimist/regattas) | Shared calendar showed 7 upcoming/57 past overall cards and recent Optimist Gold/Silver links. | Optimist DB inventory/counts or admin state. |
| [`/api/rankings?fleet=Gold`](https://sailorpath.com/api/rankings?fleet=Gold) | Public Gold Jul–Dec 2026 payload contained score slots and `bestThreeScores`. | Full admin audit or complete records. |
| [`/sg/ilca4`](https://sailorpath.com/sg/ilca4), [`/sg/ilca6`](https://sailorpath.com/sg/ilca6), [`/sg/ilca7`](https://sailorpath.com/sg/ilca7) | Text extraction showed client loading shells; APIs returned ranking payloads, some truncated/static-merged. | Broken hydrated pages, full rosters, or DB counts. |
| [`/sg/wingfoil`](https://sailorpath.com/sg/wingfoil) | Text extraction returned a loading shell. | Fully hydrated list/scorecard selection. |
| [`/api/wingfoil`](https://sailorpath.com/api/wingfoil) | Large truncated public JSON with visible 2026 records. | Complete list, record origin, statuses beyond visible excerpts, or admin rows. |
| [`/sg/techno293`](https://sailorpath.com/sg/techno293) and [`/api/techno293`](https://sailorpath.com/api/techno293) | Seven visible catalog rows vs. API excerpt containing additional 2026 monsoon objects. | Production table totals or a defect in any one specific record without ID-by-ID inspection. |
| [`/sg/iqfoil`](https://sailorpath.com/sg/iqfoil) | No extractable content in the anonymous fetch. | HTTP 404 or absence of all iQFOiL data. |

## Appendix B — concise decision register

| Decision | Status | Owner input needed |
|---|---|---|
| Canonical model is normalized event/class/results/races for all new work. | **Recommended** | Product/engineering approval. |
| WingFoil/Techno specialist UI remains as renderer/import/series adapter during transition. | **Recommended** | Class/product confirmation of display and scoring requirements. |
| First-tab contract becomes explicit; preferred future behavior is all published scorecards with separate catalog. | **Recommended** | Product choice on information architecture. |
| iQFOiL uses generic normalized path; no dedicated JSONB scoreboard initially. | **Recommended** | Confirm desired public route/navigation. |
| iQFOiL ranking/selection stays disabled; unsupported ranking API fleets rejected. | **Recommended** | Federation policy before any exception. |
| Migration/backfill occurs only after authorized read-only inventory/reconciliation. | **Required guardrail** | Data owner/access authorization. |
| Existing findings-3 local claim edits and other worktree changes remain untouched. | **Completed constraint** | None. |
