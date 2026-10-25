# Public regatta award coverage audit — 25 October 2026

## Inventory and findings

Read-only audit of all 304 published database result sheets with a nonzero fleet. 136 have an official-results URL and 144 have a notice-board URL. No database records, scoring, ranks, nationality, birth years or identity records were changed.

Existing prize definitions matched 57 sheets. Explicit imported-slug aliases, actual class/division selection and the two sourced CSC additions bring coverage to 69 sheets. This is coverage of verified category definitions, not a claim that every category has a confirmed winner. Novice or other unsupported eligibility is not guessed.

The event pages already calculated some empty NoR categories from published full-fleet results. Profiles only scanned static winner lists, so those calculated awards disappeared on profiles. The profile now loads the same definitions and cached full-fleet results for events in the sailor's own published history, resolves that exact participant, and passes only their awards to the client. Fully populated schedules need no extra fleet reads. Gold/Silver awards have separate IDs; generic duplicate podiums are suppressed when a named/category award already covers that event and fleet.

Missing official prize definitions do not justify inventing awards. Such database-backed result pages now show a separately labelled **Fleet podium**, explicitly saying that prize categories have not been verified. DNS and overseas-commitment placeholders are excluded. This displays the recorded leaders and their existing participant profile links without claiming medals were awarded.

## Added source-confirmed records

### CSC Optimist Gold 2026 — 24–25 January

- Organiser report: https://www.csc.org.sg/2026/01/26/csc-optimist-championship-gold-fleet-2026/
- Linked score PDF: https://www.csc.org.sg/wp-content/uploads/2026/01/Summary-Race-7-1.pdf
- Reviewed the first PDF page visually. Lucas Cao Zhihong (149) is first, 6 nett; Lyric Le Yuxuan (728) is third overall and first female, 27 nett; Charles Kong (716) is first in 12-and-under, 93 nett. Report independently confirms all three champions and Lucas's challenge trophy.
- Stored Lyric under the existing canonical sailor name, Lyric Li Yuxuan, and existing profile handle. Did not change the organiser's result scores or profile identity data.
- Only those three explicit named awards were added. Other open/female/age prize cutoffs were not inferred from category ranking columns.
- PDF heading remains **provisional**, despite being linked by the post-event report. This caveat is visible alongside the awards; no final-results claim is made.

### CSC Optimist Silver 2026 — 17–18 January

- Organiser report: https://www.csc.org.sg/2026/01/19/csc-optimist-championships-silver-fleet-2026-day-2/
- Linked PDF: https://www.csc.org.sg/wp-content/uploads/2026/01/Summary-Race-7.pdf
- Visually reviewed both PDF pages. Report and PDF agree on Chloe Ariane Pitsilis (708), Clara Ng Siew Ning (3739), and Cyra Cama (29), with 20, 27 and 30 nett respectively. Each has seven recorded races and one discard. These match the existing SailorPath result rows and profile handles.
- Added the report-confirmed overall podium. Did not infer all female, novice or age-group awards from rankings alone.
- The PDF is labelled provisional and contains a stale end-year typo (2023). The report establishes the January 2026 event; neither source nor scores were rewritten.

## Other searches and limits

Official SSF news and RRS boards were searched for missing 2025 SYSC and NSC Cup awards:

- https://www.racingrulesofsailing.org/documents/10710/event (SYSC 2025)
- https://www.racingrulesofsailing.org/documents/10780/event (NSC Cup 2025)
- https://www.racingrulesofsailing.org/documents/10790/event (NSC Cup II 2025)
- https://www.sailing.org.sg/news/here-are-your-2025-nsc-cup-champions
- https://www.sailing.org.sg/news/congratulations-to-all-of-our-sysc-champions

RRS listed the relevant amended NoRs and final-result files, but several PDF fetches/screenshots returned 403; SSF news pages also returned 403. These searches do not count as visually PDF-verified winners. No new SYSC/NSC Cup I category winners were asserted from incomplete evidence. Existing NSC Cup II category definitions remain usable with the site's published fleet results.

## Identity and profile boundary

Winner links use unique event-local identity matches, explicit existing handles, or matching name tokens plus the event sail number. A sail number alone cannot identify a sailor. Ambiguous or unresolved winners stay as text; no profile is created or merged. Matched crew members link individually. Static board-class winners use the cached public directory and only unique matches. Newly calculated profile awards do not expose current school or other competitors' birth-year/DOB eligibility fields.

## Validation

Regression coverage exercises imported aliases, two CSC records, ambiguous/reused-sail identity cases, both crew members, profile category propagation, duplicate suppression, school-field stripping and unverified podium labels. Full suite, lint, production build and client bundle budget are required before release. Production checks must verify an added CSC record, a calculated RSYC Gold award, and a linked sailor profile.
