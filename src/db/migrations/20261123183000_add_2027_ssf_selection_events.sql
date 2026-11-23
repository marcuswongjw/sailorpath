-- Migration: 20261123183000_add_2027_ssf_selection_events.sql
-- Description: Add 2027 Singapore Sailing Federation (SSF) selection events and
--              update existing 2027 championship fixtures per Selection Policies
--              for ILCA 4 (issued 12 Nov 2026), ILCA 6 (issued 12 Nov 2026),
--              and Optimist (issued 13 Nov 2026).

BEGIN;

-- 1. Mark existing CSC Optimist Championship 2027 (Gold Fleet) as a selection trial
UPDATE public.regatta_events
SET
  is_selection_trial = true,
  schedule_summary = '23–24 January 2027, as published by Changi Sailing Club and the Singapore Sailing Federation. Gold Fleet ranking event and official 2027 SSF Optimist selection event (15th Bodrum International Optimist Regatta / Europe Training Camp, IODA Worlds Part A, IODA Europeans, and ROC Kosmos 2027).',
  updated_at = clock_timestamp()
WHERE slug = 'csc-optimist-championship-2027-gold';

-- 2. Upsert 6 dated 2027 selection trial and target regatta fixtures
INSERT INTO public.regatta_events (
  id, name, slug, start_date, end_date, venue, organizer, classes,
  nor_url, registration_url, counts_for_ranking, is_selection_trial, schedule_summary,
  created_at, updated_at
) VALUES
(
  gen_random_uuid(),
  '23rd SAFYC Regatta 2027',
  '23rd-safyc-regatta-2027',
  '2027-01-30',
  '2027-02-14',
  'NSRCC Seasports Centre, 11 Changi Coast Walk, Singapore 499740',
  'SAF Yacht Club',
  '["Optimist", "ILCA 4", "ILCA 6"]'::jsonb,
  null,
  'https://www.safyc.org.sg',
  true,
  true,
  'Official 2027 SSF selection event across two weekends: ILCA 4 & ILCA 6 race 30–31 January 2027 (23rd Langkawi International Regatta selection); Optimist Gold Fleet races 13–14 February 2027 (15th Bodrum International Optimist Regatta / Europe Training Camp selection).',
  clock_timestamp(),
  clock_timestamp()
),
(
  gen_random_uuid(),
  '7th CSC ILCA Open 2027',
  '7th-csc-ilca-open-2027',
  '2027-02-13',
  '2027-02-14',
  'Changi Sailing Club, 32 Netheravon Road, Singapore 508508',
  'Changi Sailing Club',
  '["ILCA 4", "ILCA 6"]'::jsonb,
  null,
  'https://www.csc.org.sg',
  true,
  true,
  '13–14 February 2027. Official 2027 SSF selection event for ILCA 4 (23rd Langkawi International Regatta, China Training Camp, ILCA 4 Youth World Championships Part A) and ILCA 6 (23rd Langkawi International Regatta, Kieler Woche).',
  clock_timestamp(),
  clock_timestamp()
),
(
  gen_random_uuid(),
  'Pulau Ujong Regatta 2027',
  'pulau-ujong-regatta-2027',
  '2027-02-20',
  '2027-02-21',
  'National Sailing Centre, Singapore',
  'Singapore Sailing Federation',
  '["Optimist", "ILCA 4", "ILCA 6"]'::jsonb,
  null,
  'https://www.sailing.org.sg',
  true,
  true,
  '20–21 February 2027. Official 2027 SSF selection event for Optimist Gold Fleet (IODA Worlds Part A, IODA Europeans, ROC Kosmos), ILCA 4 (China Training Camp, ILCA 4 Youth World Championships Part A), and ILCA 6 (Kieler Woche).',
  clock_timestamp(),
  clock_timestamp()
),
(
  gen_random_uuid(),
  'Singapore Youth Sailing Championships 2027',
  'sysc-2027',
  '2027-03-13',
  '2027-03-15',
  'National Sailing Centre, Singapore',
  'Singapore Sailing Federation',
  '["Optimist", "ILCA 4", "ILCA 6"]'::jsonb,
  null,
  'https://www.sailing.org.sg',
  true,
  true,
  '13–15 March 2027. Official 2027 SSF selection event for Optimist Gold Fleet (IODA Worlds Part A, IODA Europeans, ROC Kosmos), ILCA 4 (China Training Camp, ILCA 4 Youth World Championships Part A), and ILCA 6 (Kieler Woche).',
  clock_timestamp(),
  clock_timestamp()
),
(
  gen_random_uuid(),
  '23rd Langkawi International Regatta 2027',
  '23rd-langkawi-international-regatta-2027',
  '2027-03-18',
  '2027-03-21',
  'Langkawi, Malaysia',
  'Langkawi International Regatta Organising Authority',
  '["Optimist", "ILCA 4", "ILCA 6"]'::jsonb,
  null,
  null,
  false,
  true,
  '18–21 March 2027 in Langkawi, Malaysia (SSF intended travel: 16–22 March 2027). Target international regatta for Singapore Optimist Gold (NTS A Jan 2027 intake), ILCA 4, and ILCA 6 squads; also serves as Part B selection event for ILCA 4 Youth World Championships 2027.',
  clock_timestamp(),
  clock_timestamp()
),
(
  gen_random_uuid(),
  'Kieler Woche 2027',
  'kieler-woche-2027',
  '2027-06-19',
  '2027-06-23',
  'Kiel, Germany',
  'Kieler Woche Organising Authority',
  '["ILCA 6"]'::jsonb,
  null,
  null,
  false,
  true,
  '19–23 June 2027 in Kiel, Germany (SSF intended travel: 12–24 June 2027). Target international regatta for Singapore ILCA 6 squad and official selection event for ILCA 6 Youth World Championships 2027 (ranked by final overall position).',
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
  nor_url = COALESCE(EXCLUDED.nor_url, public.regatta_events.nor_url),
  registration_url = COALESCE(EXCLUDED.registration_url, public.regatta_events.registration_url),
  counts_for_ranking = EXCLUDED.counts_for_ranking,
  is_selection_trial = EXCLUDED.is_selection_trial,
  schedule_summary = EXCLUDED.schedule_summary,
  updated_at = clock_timestamp();

-- 3. Update schedule_summary on the 4 existing 2027 championship fixtures
UPDATE public.regatta_events
SET
  schedule_summary = 'Official dates: 22–30 June 2027 confirmed on the ILCA World Championship calendar. SSF Key Competition (intended travel: 16–30 June 2027). Part A selection (top 2M + 2F born 2010+): 7th CSC ILCA Open, Pulau Ujong Regatta, SYSC 2027. Part B selection (top 1M + 1F born 2010+): 23rd Langkawi International Regatta 2027 (fallback: National ILCA 4 Ranking as of 30 March 2027).',
  updated_at = clock_timestamp()
WHERE slug = '2027-ilca4-youth-world-championship-qinhuangdao';

UPDATE public.regatta_events
SET
  schedule_summary = 'Official event dates: 24 June – 4 July 2027. Official Notice of Race published by IODA. SSF Key Competition (intended travel: 19 June – 5 July 2027). Part A selection (top 1M + 1F): CSC Optimist Championships, Pulau Ujong Regatta, SYSC 2027. Part B selection (top 3 ranked sailors): 15th Bodrum International Optimist Regatta 2027 (fallback: National Optimist Gold Ranking as of 30 March 2027).',
  updated_at = clock_timestamp()
WHERE slug = '2027-optimist-world-championship';

UPDATE public.regatta_events
SET
  schedule_summary = 'Official dates: 21–28 August 2027 confirmed on IODA international championship calendar. SSF self-funded campaign (intended travel: 18–29 August 2027; top 1M + 1F open and top 1M + 1F born 2014+). Selection events: CSC Optimist Championships, Pulau Ujong Regatta, SYSC 2027.',
  updated_at = clock_timestamp()
WHERE slug = '2027-optimist-european-championship';

UPDATE public.regatta_events
SET
  schedule_summary = 'Official dates: 21–29 August 2027 confirmed on the ILCA World Championship calendar. SSF Key Competition (intended travel: 16–30 August 2027; top 2M + 2F born 2009+). Selected by final overall position at Kieler Woche 2027 (19–23 June 2027).',
  updated_at = clock_timestamp()
WHERE slug = '2027-ilca6-youth-world-championship-volos';

-- 4. Audit log entry
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'calendar.events_insert',
  'calendar_event',
  '00000000-0000-0000-0000-000000000000',
  '2027 SSF Selection Events & Championship Updates',
  'Added 6 dated 2027 SSF selection/target regattas, flagged CSC Optimist Gold 2027 as a selection trial, and updated 4 existing 2027 championship summaries.',
  '{"upserted_count": 6, "updated_count": 5, "year": 2027}'::jsonb,
  'migration_20261123183000',
  clock_timestamp()
);

COMMIT;
