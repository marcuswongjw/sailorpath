-- Migration 152: Insert Confirmed 2026/2027 Championship Calendar Events
--
-- Adds confirmed international and national youth championship fixtures:
--   1. 20th Asian Games 2026 (Sailing — Kaiyoh Yacht Harbor, Japan)
--   2. CSC Optimist Championship 2027 (Silver Fleet — Singapore)
--   3. CSC Optimist Championship 2027 (Gold Fleet — Singapore)
--   4. 2027 ILCA 4 Youth World Championship (Qinhuangdao, China)
--   5. 2027 Optimist World Championship (Lanzarote, Spain)
--   6. 2027 Optimist European Championship (Weymouth, Great Britain)
--   7. 2027 ILCA 6 Youth World Championship (Volos, Greece)
--
-- All operations executed in a single atomic transaction.

BEGIN;

INSERT INTO public.regatta_events (
  id, name, slug, start_date, end_date, venue, organizer, classes,
  nor_url, registration_url, counts_for_ranking, is_selection_trial, schedule_summary,
  created_at, updated_at
) VALUES
(
  gen_random_uuid(),
  '20th Asian Games 2026 (Sailing)',
  '20th-asian-games-2026-sailing-aichi',
  '2026-09-26',
  '2026-10-03',
  'Kaiyoh Yacht Harbor, Gamagori City, Aichi Prefecture, Japan',
  'Olympic Council of Asia / Asian Sailing Federation (ASAF)',
  '["ILCA 4", "ILCA 6", "ILCA 7", "29er", "iQFOiL"]'::jsonb,
  'https://www.aichi-nagoya2026.org',
  'https://www.aichi-nagoya2026.org',
  false,
  false,
  'Official sailing competition dates: 26 September – 3 October 2026 at Kaiyoh Yacht Harbor. Featuring youth & Olympic classes.',
  clock_timestamp(),
  clock_timestamp()
),
(
  gen_random_uuid(),
  'CSC Optimist Championship 2027 (Silver Fleet)',
  'csc-optimist-championship-2027-silver',
  '2027-01-16',
  '2027-01-17',
  'Changi Sailing Club, 32 Netheravon Road, Singapore 508508',
  'Changi Sailing Club',
  '["Optimist"]'::jsonb,
  null,
  'https://www.csc.org.sg',
  false,
  false,
  '16–17 January 2027, as shown on the organiser’s 2027 Silver Fleet poster and recurring event page.',
  clock_timestamp(),
  clock_timestamp()
),
(
  gen_random_uuid(),
  'CSC Optimist Championship 2027 (Gold Fleet)',
  'csc-optimist-championship-2027-gold',
  '2027-01-23',
  '2027-01-24',
  'Changi Sailing Club, 32 Netheravon Road, Singapore 508508',
  'Changi Sailing Club',
  '["Optimist"]'::jsonb,
  null,
  'https://www.csc.org.sg',
  true,
  false,
  '23–24 January 2027, as published by Changi Sailing Club and the Singapore Sailing Federation. Gold Fleet ranking event.',
  clock_timestamp(),
  clock_timestamp()
),
(
  gen_random_uuid(),
  '2027 ILCA 4 Youth World Championship',
  '2027-ilca4-youth-world-championship-qinhuangdao',
  '2027-06-22',
  '2027-06-30',
  'Qinhuangdao Sports Bureau Sailing Center, Qinhuangdao, Hebei, China',
  'International Laser Class Association (ILCA) & Chinese Yachting Association',
  '["ILCA 4"]'::jsonb,
  'https://ilcasailing.org',
  'https://ilcasailing.org',
  false,
  false,
  'Official dates: 22–30 June 2027 confirmed on the ILCA World Championship calendar.',
  clock_timestamp(),
  clock_timestamp()
),
(
  gen_random_uuid(),
  '2027 Optimist World Championship',
  '2027-optimist-world-championship',
  '2027-06-24',
  '2027-07-04',
  'Marina Rubicón, Playa Blanca, Lanzarote, Spain',
  'International Optimist Dinghy Association (IODA) / Marina Rubicón',
  '["Optimist"]'::jsonb,
  'https://optiworld.org',
  'https://optiworld.org',
  false,
  false,
  'Official event dates: 24 June – 4 July 2027. Official Notice of Race published by IODA.',
  clock_timestamp(),
  clock_timestamp()
),
(
  gen_random_uuid(),
  '2027 Optimist European Championship',
  '2027-optimist-european-championship',
  '2027-08-21',
  '2027-08-28',
  'Weymouth and Portland National Sailing Academy, Portland, Dorset, Great Britain',
  'International Optimist Dinghy Association (IODA) & WPNSA',
  '["Optimist"]'::jsonb,
  'https://optiworld.org',
  'https://optiworld.org',
  false,
  false,
  'Official dates: 21–28 August 2027 confirmed on IODA international championship calendar.',
  clock_timestamp(),
  clock_timestamp()
),
(
  gen_random_uuid(),
  '2027 ILCA 6 Youth World Championship',
  '2027-ilca6-youth-world-championship-volos',
  '2027-08-21',
  '2027-08-29',
  'Nautical Club of Volos & Argonauts, Volos, Greece',
  'International Laser Class Association (ILCA) & Nautical Club of Volos & Argonauts (NOBA)',
  '["ILCA 6"]'::jsonb,
  'https://ilcasailing.org',
  'https://ilcasailing.org',
  false,
  false,
  'Official dates: 21–29 August 2027 confirmed on the ILCA World Championship calendar.',
  clock_timestamp(),
  clock_timestamp()
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  start_date = EXCLUDED.start_date,
  end_date = EXCLUDED.end_date,
  venue = EXCLUDED.venue,
  organizer = EXCLUDED.organizer,
  classes = EXCLUDED.classes,
  nor_url = EXCLUDED.nor_url,
  registration_url = EXCLUDED.registration_url,
  counts_for_ranking = EXCLUDED.counts_for_ranking,
  is_selection_trial = EXCLUDED.is_selection_trial,
  schedule_summary = EXCLUDED.schedule_summary,
  updated_at = clock_timestamp();

-- Audit log entry
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'calendar.events_insert',
  'calendar_event',
  '00000000-0000-0000-0000-000000000000',
  '2026/2027 Championship Calendar Fixtures',
  'Inserted 7 confirmed 2026/2027 championship fixtures across IODA, ILCA, ASAF, and Singapore clubs.',
  '{"events_count": 7, "year_span": "2026-2027"}'::jsonb,
  'migration_152',
  clock_timestamp()
);

COMMIT;
