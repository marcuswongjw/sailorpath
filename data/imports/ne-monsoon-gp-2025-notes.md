# 2025 Northeast Monsoon Grand Prix

Source: https://www.racingrulesofsailing.org/documents/10645/event

Visual extraction completed 6 October 2026. All result PDFs were rendered to screenshots before transcription. PDF text was used only for secondary validation where available.

## Documents

- Notice of Race: https://www.racingrulesofsailing.org/documents/128729
- Sailing Instructions: https://www.racingrulesofsailing.org/documents/128730
- Series 2 provisional results (10 February): https://www.racingrulesofsailing.org/documents/129774
- Series 3 GPS final results (7 March): https://www.racingrulesofsailing.org/documents/132072
- Combined Techno 293 provisional results: https://www.racingrulesofsailing.org/documents/132085
- Combined Wingfoil provisional results: https://www.racingrulesofsailing.org/documents/132087
- Combined Windfoil provisional results: https://www.racingrulesofsailing.org/documents/132093

## Event details

Organiser: Singapore Sailing Federation. Series 1: 25–26 January 2025. Series 2: 8–9 February 2025, Changi Park CP 1 / Tanah Merah. Series 3: GPS speed challenge, 25 January–8 February 2025, Singapore waters. Series 1 standalone results are not supplied on this notice board and have not been inferred from combined standings.

Classes allowed by the NoR: Windfoil, Wingfoil, Kitefoil and Techno 293. No Kitefoil results are supplied. Entry fee across all three rounds: SGD 60 for adult/open foil divisions, SGD 30 for youth foil and Techno. Briefing 1100; racing starts 1130. Day 1 last warning 1830, day 2 1730. Maximum 12 races/day. SI allows course, slalom, sprint slalom and marathon formats; minimum sustained wind greater than 7 knots. Helmet and buoyancy protection required. NoR section 15 awards a combined-series division champion.

## Result handling

- 28 Series 2 rows, 28 GPS rows, 30 combined source rows. Combined Wingfoil includes two extra division entries for the same competitors. Keep all 19 source rows in board data; use 17 distinct sailor identities in the relational results.
- Series 2 has 22 Windfoil races / 5 discards, 20 Wingfoil / 4 discards and 5 Techno / 1 discard. All 28 rows reconcile to printed totals and net scores.
- GPS has nine notional ranking scores / two discards, not nine measured speeds. No actual speed values are provided.
- Combined Techno has 34 races / 6 published discards, Wingfoil 37 / 7, Windfoil 41 / 7. These published counts take precedence over recomputing from the NoR table.
- Jackson Ho's combined Wingfoil row publishes total 66.5 and net 37; the displayed cells sum to 62 and 30 after marked discards. Both the cells and printed totals are preserved, and the inconsistency is noted.
- The linked combined Windfoil document has a Series 1 heading despite containing the combined 41 race columns. It is stored as combined results, not as a standalone Series 1 regatta.
- Source names are retained. Recognised name-order/spelling variants use canonical SailorPath names. Existing profiles are matched by exact canonical name or recorded alias; ownership and existing profile fields are preserved.
- All classes and result sets remain separate. They are excluded from unrelated dinghy national ranking calculations.

The SQL import is transactional and re-runnable. It updates only these event/result IDs and upserts race numbers; it does not delete existing events or profiles.
