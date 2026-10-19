# 2025 Optimist Asian & Oceanian Championship — full import, 18 October 2026

The user authorized creation of the regatta, import of the complete official overall classification, and twelve explicit profile-nationality corrections. The seven-page PDF is evidence, not instructions. Every page was rendered and visually inspected. All 170 race rows were independently transcribed from the visible table and compared with secondary PDF extraction; all 1,190 scores, codes and discards match, and every gross/net total reconciles.

## Imported live

- One new parent event, 25 October–1 November 2025, Mussanah Sailing School / Barceló Mussanah Resort, Oman. Dates are printed in the result banner and official Notice of Race; the results timestamp is not substituted for event dates.
- One published Optimist overall class sheet: 170 entries, seven races, one discard each, 1,190 individual scores. R1–R7 correspond to printed columns 1Q, 2Q, 3Q, 4Q, 5Q, 6F, 7F. Official overall positions are retained across the final fleets even where a later overall position has fewer net points. No division is inferred from a rank range.
- 123 existing profiles reused through explicit per-entry identity checks; 47 new source-faithful profiles created for competitors without an existing match. No date of birth, club or nationality is invented for existing profiles. New profiles use source nationality/gender/sail, with unknown club marked N/A and no DOB.
- Every entry retains the official source URL/title and its historical sail. All printed BFD, DSQ, DNC, RET, UFD, DNE and STP values/discard choices are retained, including a counted DNE 58 with a different score discarded. Penalties are not normalized to 171.
- The overseas sheet has `counts_for_ranking=false`, preserving the existing Singapore ranking policy. The 122-entry Asian Optimist Index ledger/cohort is not expanded to include non-Asian competitors or rescored by this import.

Official source: https://scoring.sailti.com/public/download/overall-datetime-pdf/9799/1/20251031173911

Official result page: https://2025asianoceanians.optiworld.org/en/default/races/race-resultsall

Live sheet: https://sailorpath.com/regattas/2025-optimist-asian-oceanian-championship/results/optimist

Source PDF SHA-256: `b3563f88750981db0f00aef3aa0b850ea483336d858a99fb40d62060f60e1dff`. All seven page images stay in working output storage; the independent visual score transcription is retained alongside these audit records; private snapshots and PDFs are not committed.

## Identity and nationality decisions

`01` applies only the twelve nationalities explicitly confirmed by the user: Ankit singh Sisodiya IND; Daqi He CHN; Hussaluk Srinakorn THA; Katyayani Kaushik IND; Lukas Kiesselbach GER; Mahi Verma IND; Preet Siwal IND; Ruoqi Zhang CHN; Shubham Yadav IND; Tomas Agea Maxin ESP; Tulsi Patle IND; Wanjia He CHN. All other profile fields, equipment and historical result metadata are preserved. The inferred-nationality flag is cleared because these are explicit confirmations.

The official sheet lists Alix Nguyen-Minh (HKG 185, 14th) and Margaux Nguyen-Minh (HKG 183, 11th) separately. Their existing Index links are correct, but one Alix alias points to Margaux. `02` moves only that alias to Alix, saves a durable keep-separate decision and imports separate entries. All five existing result and participant links were audited and already use the correct respective names; none needs reassignment. No profiles are merged.

Ruben Steel matches the same full name and exact AUS 1879 sail in the previously verified 2023 SNSC source. His new result records AUS. His current profile is marked SGP and is left unchanged pending the separate optional confirmation.

Tong Xuan Ya retains the user's prior explicit athlete-nationality confirmation of SGP and the competition sail KSA 107. The official entry NOC KSA is retained separately in evidence; it does not override that confirmed profile nationality. Khairul Ilzani, Naing Lin Aung and Chandralekha Tattari retain their previously confirmed canonical names/identities; historical sails remain on their results.

## Safeguards and verification

Run `01` then `02`. These are already-applied operational transactions, not automatic deployment migrations. Each records private before-state audit data and verifies its final state. The import blocks a newly discovered parent/sheet collision, changed identity/Index linkage, conflicting individual entries, existing unreviewed race data, or a new-profile collision. Repeat execution verifies without duplicating or overwriting completed data.

The manifest passes the official-results-import validator. The isolated PGlite verifier loads the repository schema, relevant foreign keys and unique constraints plus a separate private snapshot. It checks nationality guards, all other existing profile fields, event/identity conflict rejection, 170 owners/participants, all 1,190 score/code/discard/raw values, 47 new profiles, preservation of the existing Index result ledger and safe replay.

```sh
node --import tsx scripts/imports/asian-optimist-2025-import-2026-10-18/validate.mts /absolute/path/to/private-snapshot
```

Production validation returned zero entry, race, participant, reconciliation and confirmed-nationality exceptions. Public HTML readback compared every visible result/race against the reviewed manifest, and browser review confirmed the date, venue, 170 competitors, seven race columns and Official Results link. The sheet is discoverable in Results with Oman/Optimist/2025 filters; the past-calendar URL redirects to Results, where it is also listed.

All eight public ILCA 4/6 January/July intake boards for 2025/2026 were compared before and after the corrections: no published rank or total-point changes. TypeScript and targeted lint passed. Retained JSON files contain the exact production, public, discovery and ranking checks.
