# X-15 page review and 2026 Worlds import preparation

Reviewed 27 October 2026. No production data has been created by this change.

## Page improvements

- Put championship dates, venue and official information ahead of the class history.
- Replace repeated ranking disclaimers with one clear explanation of event placings.
- Add a real published-results section, with separate empty and unavailable states.
- Correct Asian Championship training to 15–17 December; racing remains 18–20 December. Replace the old Instagram reference with the organiser's registration form and the Japan WingFoil Association notice.
- Keep historical recaps as source-linked background rather than representing their prose as imported scorecards.
- Register X-15 independently of generic WingFoil and iQFOiL; preserve source-defined scored divisions and their event links.

## Verified event information

Worlds: 4–8 November 2026, Port Nàutic Ibiza, Spain; Club Mare Nostrum. Registration on 4 November and racing scheduled that afternoon through 8 November.

Primary sources:

- https://x-15class.org/events/x-15-world-championships-2026/
- https://x-15class.org/blog/entries-open-for-the-first-x-15-world-championships/
- https://x-15class.org/events/

The class advertises five world titles: senior male/female, youth male/female U19 and junior U15. Masters and additional division awards are separate. **Award categories are not evidence of independently scored fleets.** Import the scored sheets actually published by the organiser.

Asian sources:

- https://wingfoil.or.jp/x-15-asian-championships-2026/
- https://docs.google.com/forms/d/e/1FAIpQLSeYowVodOh1-Au0k6MkYQvhzoq6gQbySHmdkgk8xrcjYwFEYA/viewform

## Current readiness

Worlds is still upcoming at review time. No official final results were available. The official event page, announcement and calendar were checked; no stable final-results link was established. An indexed July notice-of-race PDF is not final results. Portimão X-15, Formula Wing, Flying Fifteen and iQFOiL results must not be substituted.

The page now discovers real published X-15 sheets automatically. This is display and routing preparation, not a validated scoring importer. The final scoring format and award eligibility still require verification against official documents.

## Import checklist when results are published

1. Retrieve the current official notice board and final results from the organiser. Record stable source URLs, document title, publication/revision time and final/provisional status. Retain the source document; render and visually inspect each results page.
2. Confirm the scoring format from the sailing instructions and results: qualifying/final fleets, medal or elimination stages, penalties, discards, tie breaks and category awards. Do not apply a generic points recalculation to an unsupported format.
3. Create/link the saved parent event with slug `x15-world-championships-2026`, the verified dates and venue. Every child sheet must carry the same event ID/slug/name, including the first sheet; this enables the parent route even with one division.
4. Use boat class `X-15` and `countsForRanking: false`. Assign the exact official scored division to each sheet, with a unique sheet slug. Shared class registry requires explicit import metadata. Add one sheet per independently scored fleet, not one duplicate per award category.
5. Verify rider names, nation and published sail/board numbers. Review existing profile matches manually where identity is ambiguous. Never infer date of birth, gender or identity from name alone. Preserve public privacy projections: do not expose date of birth, school or private evidence.
6. Preview the import as draft. Check every participant, final place, race score/code, discard, net total, number of races and fleet size against the visually inspected original. Preserve raw scoring codes and official totals. Reconcile revisions before publishing.
7. Add regression fixtures for the real scoring format and division routing. Verify the class page, event hub, scorecard and matched rider profile history. Confirm no generic WingFoil/iQFOiL sheet is claimed by an X-15 slice and no result changes national rankings.
8. Publish only reviewed sheets. Verify category honours against official eligibility and awards; they may overlap within a scored fleet. Then inspect the live class page and each division link. The results badge means published sheets exist, not that all fleets or awards have been imported.

Do not pre-create winners, empty published scorecards, guessed divisions or results links to missing sheets.
