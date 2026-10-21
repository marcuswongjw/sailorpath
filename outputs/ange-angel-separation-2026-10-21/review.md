# Ange Chew / Angel Chew historical identity correction

Administrator requested separation on 21 October 2026.

- Ange: 9ee77695-4c61-407a-a395-bd60e8b98204, /sailors/ange-chew-safyc23.
- Angel: d8f05612-be68-4e4d-af1d-e1cadbfb7669, /sailors/angel-chew-42-nsc25.
- Angyal Chew is a third existing profile, deliberately left separate and unchanged.

Reviewed both profiles, all 11 linked general results and participant records, aliases, retained import evidence, WingFoil specialist scorecards and the prior SAFYC 2023 identity review. The latter already confirmed Ange / Angel are separate, but no durable keep-separate decision had been saved.

## Official corroboration

Official Singapore National Sailing Championships 2025 notice board:
https://www.racingrulesofsailing.org/documents/11799/event

Final Techno293 / Wingfoil / iQFOiL results, final as of 16:45, 12 September 2025:
https://www.racingrulesofsailing.org/documents/158594

Downloaded the official PDF and rendered page 2. Visually read the Wingfoil table (5 entrants): rank 4, Ange Chew, SGP, male, sail 123, 18&U, ASSC. Every stored race matches: (4), 3, 3, 3, 3, (4), 3, 4, 3, 3, 4, 1, 3, 4. Discards are R1 and R6; total 45, nett 37. The same page separately names Angyal Chew in iQFOiL. Copies of the PDF and rendered page accompany this review.

## Applied production correction

- Reassigned result e90a346e-d1f2-4ef5-859c-53ba282223e3 and its participant from Angel to Ange; corrected source/display name and recorded event sail 123 and PDF evidence.
- Corrected Ange's profile and SAFYC 2023 result gender to M. The 2022 CSC result already recorded M.
- Corrected Ange's male gender in stored NE Monsoon GP2 / GP3 2026 specialist scorecards.
- Corrected two bundled SW Monsoon GP1 / GP2 scorecards to M, so fallback data does not reintroduce the error.
- Saved a durable sailors.duplicates.keep_separate decision for Ange / Angel. Existing merge preflight blocks merging either reviewed identity until the decision is explicitly reopened.
- Angel retains her other eight general results. Ange now has three general results. Specialist scorecards remain separate records, without importing duplicate results.

The repair transaction compared every race row and all ranks/totals across both profiles before and after. All were identical. Preserved row IDs, scores, scoring codes and discards. Audit entries include the correction, official PDF comparison and prior state.

## Validation

- 37 targeted WingFoil, name-matching and merge API checks passed.
- 10 merge transaction tests passed, including saved separate-identity decisions.
- Changed files passed lint; full production build passed.
- Public profiles visibly show Ange's SNSC 2025 WingFoil fourth place and Angel's separate iQFOiL history.
- Source correction release commit: da299e4ceac95bfe7904a2b30c31fdd065195f14.
- Production deployment dpl_2iU2vgA2kMvBZRycpo8jkCBDr2tW reached READY and is assigned to sailorpath.com and admin.sailorpath.com.
