# Eastern Seaboard 2026: NoR prizes and winners

Source: user-provided `NOR 18th EASTERN SEA-BOARD REGATTA 2026 V2.pdf`, section 13.1, page 3. Prize page rendered and visually read on 2 November 2026. SHA-256: `150d87370bd6b1e9d29bef2a48e4d14a89393e3700b50a9efc9b5fe89f8abf9c`.

The supplied copy differs from the previously retained official NoR in other wording; section 13.1 has the same prize categories. The unchanged supplied copy is retained at `scripts/imports/eastern-seaboard-2026/sources/notice-of-race-prizes-user-v2.pdf`. The [official NoR link](https://www.racingrulesofsailing.org/documents/198658) and [event notice board](https://www.racingrulesofsailing.org/documents/15166/event) remain attached to the categories.

**37 prize placings, 10 categories, 30 distinct sailors.** Winners are calculated from the organiser-published standings already imported, not a separate prize-giving report. Those result PDFs are labelled Final on the official notice board but retain provisional wording in the document; the prize display explicitly states this.

## Placings

| Class | NoR category | Winners in category order |
| --- | --- | --- |
| Optimist | Overall | 1. Rachata Sadtrakulwatanna; 2. Ashlyn Tham Yan Lin; 3. Suthinan Nakpasom; 4. Sorawit Naksuk; 5. Thun Pyae Zan; 6. Anantachai Tiathongchai; 7. Sitt May Chit Po; 8. Thawaree Raksapun; 9. Chananchai Tiathongchai; 10. Amy Luo |
| Optimist | Female | 1. Ashlyn Tham Yan Lin; 2. Sitt May Chit Po; 3. Thawaree Raksapun |
| Optimist | U12 Male (born 2015 or later) | 1. Anantachai Tiathongchai; 2. Chananchai Tiathongchai; 3. Harry Cooper |
| Optimist | U12 Female (born 2015 or later) | 1. Theerakan Klaysomboon; 2. Arunee Raksapun; 3. Mikaela Hui Ting Wong |
| Optimist | U10 (born 2017 or later) | 1. Matthias Kai Lun Lee; 2. Min Myat Ponnya; 3. Skyler Kang |
| ILCA 4 | Male | 1. Hussaluk Srinakorn; 2. Pee Teck Woon; 3. Ethan Lee |
| ILCA 4 | Female | 1. Pinchanok Klaysomboon; 2. Jolin Zheng; 3. Thanaporn Phokaew |
| ILCA 4 | U15 (born 2011 or later) | 1. Pee Teck Woon; 2. Ethan Lee; 3. Lucas Cao Zhihong |
| ILCA 6 | Male | 1. Ahmad Tsauban Bin Ramli; 2. Caleb Peck Rui Kai; 3. Teng-Hsi Yeh |
| ILCA 6 | Female | 1. Nur Zafrina Syuhada Binti Mohd Zailan; 2. Gabi Oh; 3. Nichawan Nithithongsakul |

## Interpretation and checks

- Optimist awards cover the class across Gold and Silver. Gold precedes Silver; net scores from the two final fleets are not sorted together. U10 third place is Skyler Kang (Silver rank 18), behind Matthias Kai Lun Lee and Min Myat Ponnya (Gold).
- Optimist: overall top 10; female top 3; U12 male top 3 and female top 3, born 2015 or later; U10 top 3, born 2017 or later.
- ILCA 4: male top 3, female top 3, U15 top 3 born 2011 or later. No separate overall prize was added.
- ILCA 6 Youth U19: male top 3 and female top 3. No separate overall or extra age prize was added.
- Named winners use the verified imported sailor IDs/handles and event-specific sail numbers. Source names, fleet ranks and net scores are retained in winner notes. No profile, race-score or standing changes were made.
- No Silver-only Optimist prizes were invented. This event uses only the NoR categories for profile awards and prize podiums, suppressing synthetic finishing-place honours.
- Sorawit Naksuk: source YOB 2014 versus existing 2012. Both are outside the Optimist U12/U10 cutoffs. His overall fourth prize uses no age eligibility; the conflicting year is not copied to award birth-year metadata.
- Setthawit Yodmanee: source YOB 2019 versus existing 2017. Both qualify by year for U12/U10, but his Silver rank 50 is below the winning cutoffs in either case. No affected award is assigned.
- Three incomplete/non-Gregorian ILCA source YOB fields are outside the U15 winning positions; no conversion was needed.
- The shared class-wide Optimist awards are available from both final-fleet sheets and each winning sailor's awards cabinet.
- Validation: 66 tests across seven prize/lookup/profile-award suites passed; TypeScript check passed. Lint and whitespace checks completed.
