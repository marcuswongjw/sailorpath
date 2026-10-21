# Event URL autofill release

- Live URL: https://admin.sailorpath.com/admin?area=events&view=card
- Target: production
- Status: READY
- Commit: 37c7ae18bf733818427fe9b90e6c8614150bfeb2
- Deployment: dpl_G7wjyTA1ogzQ88wZYNm3Gnr8NTJW
- Framework: Next.js 16.3.6; Node.js 24
- Build duration: approximately 67 seconds after leaving the deployment queue

The New event form now includes Paste event URL → Extract event details.
Extracted fields are editable and are saved only when Save event is selected.
A newly saved event retains the source URL for future results discovery.

Validation: 37 targeted tests across eight suites passed, including extraction,
form behaviour, save-payload preservation, duplicate behaviour, and calendar API
regressions. TypeScript, lint, and the production build passed. The final parser
changes were also retested in the isolated release checkout (14 feature tests).

Live browser verification: opened New event, pasted the existing official
Eastern Seaboard event URL, and ran Extract event details. The live form populated
the event name, 19–21 October 2019, Royal Varuna Yacht Club, and the official NOR
link. It correctly warned that the source was a past edition and left unconfirmed
classes/organiser fields blank. The unsaved draft was discarded; no calendar
entry or results row was created or updated.

The existing Eastern Seaboard Regatta 2026 calendar URL points to this 2019 page.
It should be replaced with an official URL for the upcoming edition when the
regatta list is reviewed; this release did not edit that calendar entry.

Post-deploy runtime error scan: no error/fatal logs for this deployment at the
time of verification. No database migrations or environment changes were needed.
Scheduled results discovery remains disabled as configured for the pilot.
