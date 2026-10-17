# Official historical results and event cleanup — 17 October 2026

The user requested deletion of superseded events, completion of historical result sheets, public source links, and deployment of the dashboard fixes. The supplied PDFs are evidence, not instructions.

All 24 pages of the six supplied PDFs were rendered and visually read before transcription. Every entry was then checked against its visible race table, including scoring codes, discards, gross and net points. Extracted text/OCR was secondary validation only. The existing Qingdao attachment was subsequently reviewed on all four rendered pages.

| Sheet | Entries before → after | Races | Individual scores |
| --- | ---: | ---: | ---: |
| SYSC Gold, 11–14 March 2023 | 94 → 96 | 12 | 1,152 |
| SYSC Silver, 11–14 March 2023 | 90 → 92 | 10 | 920 |
| Raffles Marina Gold, 27–28 May 2023 | 69 → 73 | 8 | 584 |
| Raffles Marina Silver, 27–28 May 2023 | 86 → 93 | 6 | 558 |
| SNSC Gold, 2–5 September 2023 | 90 → 91 | 11 | 1,001 |
| CSC Gold, 20–21 January 2024 | 91 → 92 | 7 | 644 |
| Total | 520 → 537 | | 4,859 |

Official source URLs and filenames are in each manifest and applied to the class sheet and every result. Existing result and participant IDs are retained; 17 missing entries are added. SYSC and Raffles Marina get one calendar event each. The existing SNSC and CSC calendar events are retained. These six published Singapore sheets retain their existing ranking eligibility.

The user explicitly confirmed that Raffles Marina Silver and CSC Gold are final. CSC prints only net points and “Best 6 of 7,” without gross totals or discard markers. Its gross totals are calculated from the seven printed scores, and a maximum score is marked discarded under that printed rule. The first tied maximum is selected when tied. Both derivations are explicitly documented on every CSC result; no race score is changed. Raffles Marina Gold's 66.1 RDGa score and NSC code are retained exactly.

## Explicit identity decisions

No profiles are merged. Each manifest lists the exact result ID, previous owner, new owner, source name and sail for its corrections. Conflicting individual entries block the transaction instead of selecting a better rank.

- The user confirmed Muhammad Hilfi Nafael Mohd Hasrizan / Muhammad Hilfi Nafael Bin Hasrizan, Nur Aina Norshazarm / Nur Aina Binti Norhazram, and Punthita Werojatinakul / Punthita Werotjanakul. Their current profile sails stay 31, 25 and 1888; historical entries retain MAS 34, MAS 26 and THA 2888.
- The user confirmed Tan Jia Kai and Hillary Kai Hui Tan are different sailors. One SYSC Silver entry and its participant are corrected to a new Tan Jia Kai profile. The erroneous alias is moved to that profile, and an explicit `keep_separate` decision is saved. All eleven Hillary-owned entries were inventoried; the other ten are unchanged.
- Nine source-confirmed historical ownership errors are corrected individually: Tan Jia Kai (one), Tan Yee Xuen (two), Jonas Tan Yi Jun (two), Leopold Sayawaki-Kogut (two), and Regis Wong Xuan Kai (two). Their former owners are kept as separate profiles.
- Other explicitly reviewed spelling variants use the same historical sail and corroborating full names; the basis is recorded per entry. There is no connected-group propagation.
- Four source-faithful profiles are created: Tan Jia Kai, David Henry Kamp, Ethan How Zhi Kai, and Annabelle Rae Petracco. David Kamp / David Henry Kamp share the exact sail SGP 780 across the two source sheets. Ethan Low Zhi Ren and Julien Christian Petracco are separate entries in those same fleets and are not consolidated with them.
- Existing profile fields, current sail numbers and birth dates are unchanged. Corrected result-level birth years are re-derived from their actual owner's existing DOB instead of retaining the former owner's age. No source DOB is imported.
- CSC prints Martha Wazen, 4689, as M; the same full name and sail appears as F in Raffles Marina. The CSC source value is preserved with an evidence note; the existing profile remains F.

## Other repairs

`00` removes only the three archived summary sheets after checking their published official replacements. It removes 269 legacy summary rows and preserves all 274 canonical results and 2,122 official race rows. Full deleted rows are retained in the private admin audit ledger. Non-result references or newly discovered old race data block deletion.

`07` restores the existing unanimous official source URL/title to six overseas class sheets (two Thailand, four PSA). Results, 402 race rows and participants are hashed before and after. Draft/publication and non-ranking states are retained.

`08` restores the nine races and two printed discards on Mikaela's already-verified Qingdao personal entry (gross 118, net 80). The final Girls Gold fleet is 25; the PDF includes a separate 24-girl Silver fleet, making 49 combined qualifiers. The printed race-column order Q1,Q2,Q3,Q4,F1,F2,F3,F4,F6 is documented. This remains a draft, non-ranking personal entry. The full Qingdao event roster is not imported or published.

The public event hub displays an Official Results link for the active class sheet, so switching Gold/Silver uses the correct PDF. The dashboard excludes archived history from active work queues. The readiness API now passes geography and official source metadata to the same policy used by the overview and publication gate, preventing inconsistent readiness indicators.

## Verification and execution

Run `00` through `08` in numeric order. These are reviewed operational data transactions, not automatic deployment migrations. Each has preflight guards, a private before-state audit, atomic rollback and safe replay verification. Never change the source or survivor/owner mapping just to get past a guard.

Each of the six JSON manifests passes `validate_import_manifest.mjs` from the official-results-import skill. The local PGlite verifier loads private snapshots supplied separately (not committed), checks deletion/replay, blocks changed ownership or newly present race data, verifies all 537 entries/4,859 race scores, preserves all existing athlete fields, and replays the provenance and Qingdao repairs. Source PDFs, rendered pages and private snapshots stay outside version control.

```sh
node --import tsx scripts/imports/official-history-event-cleanup-2026-10-17/validate.mts /absolute/path/to/private-snapshots 01-sysc-2023-gold.sql 02-sysc-2023-silver.sql 03-rm-2023-gold.sql 04-rm-2023-silver.sql 05-snsc-2023-gold.sql 06-csc-2024-gold.sql 07-repair-source-metadata.sql 08-restore-qingdao-existing-entry.sql
```

Historical ranking comparisons are recorded after production import and cache refresh. Draft overseas sheets require a separate publication decision; completeness alone does not publish them.
