BEGIN;
DO $$ BEGIN IF (SELECT count(*) FROM public.news_articles WHERE status='published' AND updated_at='2026-11-13 01:28:13.488835+00' AND slug IN ('parent-workspace-gear-coach-notes','sailor-profiles-and-logbooks','more-ways-to-join-sailorpath','connected-records-for-helm-and-crew')) <> 4 THEN RAISE EXCEPTION 'Feature articles changed since review'; END IF; END $$;
UPDATE public.news_articles SET body='The parent workspace brings a linked sailor’s competition information and preparation tools together in one place. The desktop layout groups the workspace into Overview, Gear & Prep, and Coach & Notes.

## Start with the overview

Select a linked sailor to see recent results and relevant standings. Families with more than one linked sailor can switch between sailors or open the family summary. The overview also highlights equipment alerts that need attention.

## Prepare for race day

Gear & Prep brings the equipment locker and race-day checklist together. Check off preparation items, add your own checklist items and review equipment information before heading to the venue.

## Follow coaching and notes

Coach & Notes brings together family notes and coach observations available for the selected sailor. The information shown depends on the account’s access and what has been shared.

The parent demo uses sample data and is a useful way to explore the layout before linking a sailor’s profile.', updated_at=now() WHERE slug='parent-workspace-gear-coach-notes' AND status='published';
UPDATE public.news_articles SET body='SailorPath’s updated profile and Logbook help sailors keep their competition history and personal reflections organised.

## A clearer profile

The profile brings together recorded results, awards and class information. Authorised profile managers can open the profile editor to update available details and sharing choices, then preview the public profile.

For sailors competing in more than one class, the class controls make it easier to explore the relevant part of their record.

## Results and reflections in the Logbook

The Logbook brings regatta results and reflections together. Sailors can add notes about an event or an individual race, revisit what they learned and choose the available privacy setting for a reflection. Equipment and documents have separate sections within the workspace.

Explore the sample profile to see the layout. The demonstration uses sample data; sign in and complete the profile-claim process to manage an eligible sailor record.', updated_at=now() WHERE slug='sailor-profiles-and-logbooks' AND status='published';
UPDATE public.news_articles SET body='SailorPath brings login and account creation together on one page. You can use an email address and password, or choose Google or Telegram.

## Choose how to sign in

Select Continue with Google or Log in with Telegram and follow the prompts from your chosen provider. New users can create an account through those options; an email registration option is also available on the page.

Google uses the email address on that account. Telegram uses your public name and username, and the sign-in page says a phone number is not requested.

## Connect a sailor profile

After signing in, sailors and families can use the profile-claim process to request a connection to a sailor’s record. Access to a workspace follows the applicable review and approval process.

The option to receive SailorPath messages on Telegram is separate and optional. You can sign in without opting in to messages.', updated_at=now() WHERE slug='more-ways-to-join-sailorpath' AND status='published';
UPDATE public.news_articles SET body='A double-handed result belongs to a team of sailors. SailorPath connects recorded crew members to their shared entry so readers can follow both the boat’s result and the people who sailed it.

## See the sailors behind an entry

Where the source information and reviewed participant records are available, a regatta result can show both sailors together. Helm and crew labels appear when those roles have been recorded. Select a linked name to open the corresponding sailor profile.

## Follow the result across profiles

The shared regatta result can also appear in each linked sailor’s competition history. This makes it easier to move from an individual profile to the event and back to the other sailor’s record.

Coverage depends on the information supplied by the organiser and the identities that have been reviewed. Some older or incomplete entries may not yet have both sailors linked.', updated_at=now() WHERE slug='connected-records-for-helm-and-crew' AND status='published';
COMMIT;
SELECT slug,updated_at FROM public.news_articles WHERE slug IN ('parent-workspace-gear-coach-notes','sailor-profiles-and-logbooks','more-ways-to-join-sailorpath','connected-records-for-helm-and-crew');
