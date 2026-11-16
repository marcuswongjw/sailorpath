-- Upgrade asian_optimist_index_events to serve as the live event designation table
-- for /optimist/asian-index dynamic scoring from public.regattas & public.regatta_results.

BEGIN;

ALTER TABLE public.asian_optimist_index_events
  DROP CONSTRAINT IF EXISTS asian_optimist_index_events_index_role_check;

ALTER TABLE public.asian_optimist_index_events
  ADD CONSTRAINT asian_optimist_index_events_index_role_check
    CHECK (index_role IN ('championship_anchor', 'championship', 'regional_qualifier', 'national_championship'));

ALTER TABLE public.asian_optimist_index_events
  DROP CONSTRAINT IF EXISTS asian_optimist_index_events_result_status_check;

ALTER TABLE public.asian_optimist_index_events
  ADD CONSTRAINT asian_optimist_index_events_result_status_check
    CHECK (result_status IN ('verified', 'awaiting_final', 'scheduled'));

ALTER TABLE public.asian_optimist_index_events
  ADD COLUMN IF NOT EXISTS grade integer CHECK (grade IN (150, 75, 40)),
  ADD COLUMN IF NOT EXISTS short_name text,
  ADD COLUMN IF NOT EXISTS is_worlds boolean NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS regatta_slugs text[] NOT NULL DEFAULT '{}'::text[],
  ADD COLUMN IF NOT EXISTS verified_mnas integer,
  ADD COLUMN IF NOT EXISTS notes text;

-- Update existing 6 rows with grading and live regatta_slugs
UPDATE public.asian_optimist_index_events
SET
  grade = 150,
  short_name = '2025 Asians',
  is_worlds = false,
  regatta_slugs = ARRAY['2025-optimist-asian-oceanian-championship-overall'],
  sailorpath_regatta_slug = '2025-optimist-asian-oceanian-championship-overall',
  verified_mnas = 25,
  notes = 'Baseline 2025/26 cycle anchor; retained pending the December 2026 Colombo championship.'
WHERE id = '2025-asian-oceanian';

UPDATE public.asian_optimist_index_events
SET
  grade = 75,
  short_name = '2026 SYSC',
  is_worlds = false,
  regatta_slugs = ARRAY['sysc-2026-gold'],
  verified_mnas = 6
WHERE id = 'sysc-2026-gold';

UPDATE public.asian_optimist_index_events
SET
  grade = 40,
  short_name = '2026 SNSC',
  is_worlds = false,
  regatta_slugs = ARRAY['singapore-national-sailing-championships-2026-gold'],
  verified_mnas = 7
WHERE id = 'snsc-gold-sep-26-2026-09-11';

UPDATE public.asian_optimist_index_events
SET
  grade = 75,
  short_name = '2026 LIRP',
  is_worlds = false,
  regatta_slugs = ARRAY['langkawi-international-regatta-perdana-2026-optimist-gold'],
  verified_mnas = 4
WHERE id = 'langkawi-international-regatta-perdana-2026';

UPDATE public.asian_optimist_index_events
SET
  grade = 75,
  short_name = '2026 Thai Intl',
  is_worlds = false,
  regatta_slugs = ARRAY['thailand-international-sailing-championships-2026-optimist'],
  verified_mnas = 4
WHERE id = 'thailand-international-sailing-championships-2026';

UPDATE public.asian_optimist_index_events
SET
  grade = 75,
  short_name = '2026 HKODA',
  is_worlds = false,
  regatta_slugs = ARRAY['hkoda-open-and-national-championships-2026-optimist-main'],
  verified_mnas = 8
WHERE id = 'hkoda-open-and-national-championships-2026-optimist-main';

-- Upsert all additional designated 2025/2026 Asian & Oceania Optimist Index events
INSERT INTO public.asian_optimist_index_events (
  id, name, short_name, index_role, source_kind, host_country, host_noc,
  start_date, end_date, venue, official_results_url, official_results_source_name,
  sailorpath_regatta_slug, regatta_slugs, result_status, fleet_size, race_count,
  discard_count, is_eligible, grade, is_worlds, verified_mnas, notes
) VALUES
  (
    'optimist-worlds-2026',
    '2026 IODA World Championship',
    '2026 Worlds',
    'championship',
    'sailorpath_regatta',
    'Morocco', 'MAR',
    '2026-06-18', '2026-06-28',
    'Tangier, Morocco',
    'https://2026worlds.optiworld.org/en/default/races/race-resultsall',
    'Official World Championship overall classification',
    '2026-optimist-world-championship-overall',
    ARRAY['2026-optimist-world-championship-overall'],
    'verified', 284, 12, 2, true, 150, true, 69,
    'Grade 150 World Championship; at most 1 Worlds result per sailor.'
  ),
  (
    'optimist-europeans-2026-boys',
    '2026 Optimist European Championship — Boys',
    '2026 Euros (B)',
    'championship',
    'sailorpath_regatta',
    'Poland', 'POL',
    '2026-07-24', '2026-07-31',
    'Gdynia, Poland',
    'https://2026europeans.optiworld.org/en/default/races/race-resultsall',
    'Official European Championship Boys classification',
    '2026-optimist-european-championship-boys',
    ARRAY['2026-optimist-european-championship-boys'],
    'verified', 170, 8, 1, true, 150, false, 49,
    'Continental championship Grade 150 (Boys premier division).'
  ),
  (
    'optimist-europeans-2026-girls',
    '2026 Optimist European Championship — Girls',
    '2026 Euros (G)',
    'championship',
    'sailorpath_regatta',
    'Poland', 'POL',
    '2026-07-24', '2026-07-31',
    'Gdynia, Poland',
    'https://2026europeans.optiworld.org/en/default/races/race-resultsall',
    'Official European Championship Girls classification',
    '2026-optimist-european-championship-girls',
    ARRAY['2026-optimist-european-championship-girls'],
    'verified', 122, 8, 1, true, 150, false, 47,
    'Continental championship Grade 150 (Girls premier division).'
  ),
  (
    '2026-iod-asian-oceanian',
    '2026 IODA Asian & Oceanian Championship',
    '2026 Asians',
    'championship',
    'official_result',
    'Sri Lanka', 'SRI',
    '2026-12-12', '2026-12-19',
    'Colombo, Sri Lanka',
    'https://2026asianoceanians.optiworld.org/',
    'Scheduled IODA Asian & Oceanian Championship',
    NULL,
    ARRAY[]::text[],
    'scheduled', NULL, NULL, NULL, true, 150, false, NULL,
    'Scheduled for 12–19 Dec 2026 in Colombo; scores once official final results are imported.'
  ),
  (
    'hong-kong-race-week-2026-optimist-main',
    'Hong Kong Race Week 2026 — Optimist Main',
    '2026 HKRW',
    'regional_qualifier',
    'sailorpath_regatta',
    'Hong Kong', 'HKG',
    '2026-01-27', '2026-02-01',
    'Middle Island, Hong Kong',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/OptimistMain.htm',
    'Official Optimist Main final results',
    'hong-kong-race-week-2026-optimist-main',
    ARRAY['hong-kong-race-week-2026-optimist-main'],
    'verified', 77, 9, 1, true, 75, false, 7,
    'Grade 75 major international open (77 starters, 7 MNAs, 9 races).'
  ),
  (
    'lysc-2026-optimist-gold',
    '5th Langkawi International Youth Sailing Championship — Optimist Gold',
    '2026 LYSC',
    'regional_qualifier',
    'sailorpath_regatta',
    'Malaysia', 'MAS',
    '2026-06-24', '2026-06-28',
    'Langkawi, Kedah, Malaysia',
    'https://sailorpath.com/results/the-5th-lysc-2026-optimist-final.pdf',
    'THE 5TH LYSC 2026 _ Optimist.pdf — final results issued 28 June 2026',
    'langkawi-international-youth-sailing-championship-2026-optimist-gold',
    ARRAY['langkawi-international-youth-sailing-championship-2026-optimist-gold'],
    'verified', 50, 10, 1, true, 75, false, 6,
    'Grade 75 major international open (50 starters, 6 MNAs, 10 races).'
  ),
  (
    'asaf-cup-optimist-open-2026-boys',
    '2026 ASAF Cup Optimist Open Championships — Boys',
    '2026 ASAF (B)',
    'regional_qualifier',
    'sailorpath_regatta',
    'Chinese Taipei', 'TPE',
    '2026-08-05', '2026-08-10',
    'Guanyinting, Penghu',
    'https://www.racingrulesofsailing.org/documents/15171/event',
    'Racing Rules of Sailing Document 15171 — Boys Fleet',
    'asaf-cup-optimist-open-championships-2026-boys',
    ARRAY['asaf-cup-optimist-open-championships-2026-boys'],
    'verified', 34, 8, 1, true, 75, false, 6,
    'Sanctioned by ASAF and CTSA (34 Boys + 21 Girls = 55 starters across 6 MNAs).'
  ),
  (
    'asaf-cup-optimist-open-2026-girls',
    '2026 ASAF Cup Optimist Open Championships — Girls',
    '2026 ASAF (G)',
    'regional_qualifier',
    'sailorpath_regatta',
    'Chinese Taipei', 'TPE',
    '2026-08-05', '2026-08-10',
    'Guanyinting, Penghu',
    'https://www.racingrulesofsailing.org/documents/15171/event',
    'Racing Rules of Sailing Document 15171 — Girls Fleet',
    'asaf-cup-optimist-open-championships-2026-girls',
    ARRAY['asaf-cup-optimist-open-championships-2026-girls'],
    'verified', 21, 8, 1, true, 75, false, 6,
    'Sanctioned by ASAF and CTSA (34 Boys + 21 Girls = 55 starters across 6 MNAs).'
  ),
  (
    'mussanah-race-week-2026-optimist',
    'Mussanah Race Week 2026 (Optimist)',
    '2026 Mussanah',
    'regional_qualifier',
    'sailorpath_regatta',
    'Oman', 'OMA',
    '2026-10-15', '2026-10-22',
    'Mussanah, Oman',
    'https://oman.sailti.com/en/default/races/race-resultsall',
    'Mussanah Race Week 2026 — Optimist final results',
    'mussanah-race-week-2026-optimist',
    ARRAY['mussanah-race-week-2026-optimist'],
    'verified', 46, 12, 2, true, 75, false, 7,
    'Grade 75 major international open (46 starters across 7 MNAs, 12 races).'
  ),
  (
    'eastern-seaboard-regatta-2026',
    '18th Eastern Seaboard Regatta 2026 — Optimist Gold',
    '2026 Eastern',
    'regional_qualifier',
    'sailorpath_regatta',
    'Thailand', 'THA',
    '2026-10-28', '2026-11-01',
    'Royal Varuna Yacht Club, Pattaya, Thailand',
    'https://www.racingrulesofsailing.org/documents/15166/event',
    'Royal Varuna Yacht Club final results — Optimist Gold',
    'eastern-seaboard-regatta-2026-optimist-gold',
    ARRAY['eastern-seaboard-regatta-2026-optimist-gold'],
    'verified', 68, 8, 1, true, 75, false, 10,
    'Grade 75 major international open (68 Gold starters across 10 MNAs, 8 races).'
  ),
  (
    '57th-all-japan-optimist-2025',
    '57th All Japan Optimist Sailing Championship 2025',
    '2025 All Japan',
    'national_championship',
    'sailorpath_regatta',
    'Japan', 'JPN',
    '2025-11-20', '2025-11-24',
    'Japan',
    'https://www.joda.jp/',
    'JODA 57th All Japan Optimist Championship final results',
    '57th-all-japan-optimist-sailing-championship-2025',
    ARRAY['57th-all-japan-optimist-sailing-championship-2025'],
    'verified', 81, 7, 1, true, 40, false, 1,
    'Grade 40 Japanese National Championship (81 starters, 7 races).'
  ),
  (
    '2026-musto-australian-optimist-championship-optimist-gold',
    '2026 Musto Australian Optimist Championship — Optimist Gold',
    '2026 AUS Nats',
    'national_championship',
    'sailorpath_regatta',
    'Australia', 'AUS',
    '2026-01-08', '2026-01-15',
    'Hobart, Australia',
    'https://sailingresults.net/sa/results/overall.aspx?ID=82277.3',
    'Official Australian Optimist Championship Gold final results',
    '2026-musto-australian-optimist-championship-optimist-gold',
    ARRAY['2026-musto-australian-optimist-championship-optimist-gold'],
    'verified', 45, 11, 2, true, 40, false, 3,
    'Grade 40 Australian National Championship (45 Gold starters, 11 races).'
  ),
  (
    '2026-toyota-new-zealand-optimist-national-championship-optimist-gold',
    '2026 Toyota New Zealand Optimist National Championship — Optimist Gold',
    '2026 NZL Nats',
    'national_championship',
    'sailorpath_regatta',
    'New Zealand', 'NZL',
    '2026-04-03', '2026-04-07',
    'New Plymouth, New Zealand',
    'https://www.sailwave.com/results/NPYC/2026%20Toyota%20NZ%20Optimist%20National%20Championships%20-%20Open%20Fleet.htm',
    'Official Toyota NZ Optimist National Championship Gold final results',
    '2026-toyota-new-zealand-optimist-national-championship-optimist-gold',
    ARRAY['2026-toyota-new-zealand-optimist-national-championship-optimist-gold'],
    'verified', 43, 11, 2, true, 40, false, 3,
    'Grade 40 New Zealand National Championship (43 Gold starters, 11 races).'
  ),
  (
    'ksaf-presidents-cup-youth-nationals-2026-optimist',
    '2026 KSAF President''s Cup National Youth Sailing Championships — Optimist',
    '2026 KOR Nats',
    'national_championship',
    'sailorpath_regatta',
    'South Korea', 'KOR',
    '2026-05-08', '2026-05-11',
    'Seoul, South Korea',
    'https://www.ksaf.org/events/overview/overview/?mode=view&tourcd=20260202092105461&page=',
    'Korea Sailing Federation (KSAF) final results',
    'ksaf-presidents-cup-youth-nationals-2026-optimist',
    ARRAY['ksaf-presidents-cup-youth-nationals-2026-optimist'],
    'verified', 38, 8, 1, true, 40, false, 1,
    'Grade 40 Korean National Youth Championship (38 starters, 8 races).'
  ),
  (
    'taiwan-presidents-cup-2026-boys',
    '115th Academic Year National President''s Cup — Optimist Boys',
    '2026 TPE (B)',
    'national_championship',
    'sailorpath_regatta',
    'Chinese Taipei', 'TPE',
    '2026-08-14', '2026-08-16',
    'Penghu / Tainan',
    'https://www.sailwave.com/results/115PresidentCup.htm',
    'Chinese Taipei Sailing Association (CTSA) — Boys Fleet',
    'taiwan-presidents-cup-2026-optimist-b-d555a4',
    ARRAY['taiwan-presidents-cup-2026-optimist-b-d555a4'],
    'verified', 44, 6, 1, true, 40, false, 1,
    'Grade 40 CTSA National Championship (Boys fleet, 44 starters).'
  ),
  (
    'taiwan-presidents-cup-2026-girls',
    '115th Academic Year National President''s Cup — Optimist Girls',
    '2026 TPE (G)',
    'national_championship',
    'sailorpath_regatta',
    'Chinese Taipei', 'TPE',
    '2026-08-14', '2026-08-16',
    'Penghu / Tainan',
    'https://www.sailwave.com/results/115PresidentCup.htm',
    'Chinese Taipei Sailing Association (CTSA) — Girls Fleet',
    'taiwan-presidents-cup-2026-optimist-g-27a325',
    ARRAY['taiwan-presidents-cup-2026-optimist-g-27a325'],
    'verified', 28, 6, 1, true, 40, false, 1,
    'Grade 40 CTSA National Championship (Girls fleet, 28 starters).'
  ),
  (
    'youth-thailand-national-2026',
    'Youth Thailand National Sailing Championship 2026 (Optimist)',
    '2026 THA Nats',
    'national_championship',
    'sailorpath_regatta',
    'Thailand', 'THA',
    '2026-09-18', '2026-09-20',
    'Sattahip, Thailand',
    'https://sailingtech.in.th/preview/results/youth-thailand-2026/optimist-overall.html',
    'Official Youth Thailand National Sailing Championship 2026 final result sheet',
    'youth-thailand-national-sailing-championship-2026-optimist',
    ARRAY['youth-thailand-national-sailing-championship-2026-optimist'],
    'verified', 58, 3, 0, true, 40, false, 2,
    'Grade 40 Youth Thailand National Championship (58 starters).'
  )
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  short_name = EXCLUDED.short_name,
  index_role = EXCLUDED.index_role,
  source_kind = EXCLUDED.source_kind,
  host_country = EXCLUDED.host_country,
  host_noc = EXCLUDED.host_noc,
  start_date = EXCLUDED.start_date,
  end_date = EXCLUDED.end_date,
  venue = EXCLUDED.venue,
  official_results_url = EXCLUDED.official_results_url,
  official_results_source_name = EXCLUDED.official_results_source_name,
  sailorpath_regatta_slug = EXCLUDED.sailorpath_regatta_slug,
  regatta_slugs = EXCLUDED.regatta_slugs,
  result_status = EXCLUDED.result_status,
  fleet_size = EXCLUDED.fleet_size,
  race_count = EXCLUDED.race_count,
  discard_count = EXCLUDED.discard_count,
  is_eligible = EXCLUDED.is_eligible,
  grade = EXCLUDED.grade,
  is_worlds = EXCLUDED.is_worlds,
  verified_mnas = EXCLUDED.verified_mnas,
  notes = EXCLUDED.notes,
  updated_at = now();

COMMIT;
