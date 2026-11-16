-- Upgrade Asian Optimist Index to 4-tier grading (200 / 150 / 75 / 40)
-- and designate 2026 Regatta of Champions (Grade 150) & 2026 R.O.C. Kosmos Gold+Silver (Grade 75).

BEGIN;

ALTER TABLE public.asian_optimist_index_events
  DROP CONSTRAINT IF EXISTS asian_optimist_index_events_grade_check;

ALTER TABLE public.asian_optimist_index_events
  ADD CONSTRAINT asian_optimist_index_events_grade_check
    CHECK (grade IN (200, 150, 75, 40));

-- Promote World Championship to Grade 200
UPDATE public.asian_optimist_index_events
SET
  grade = 200,
  notes = 'Grade 200 World Championship; at most 1 Grade 200 result per sailor.',
  updated_at = now()
WHERE id = 'optimist-worlds-2026';

-- Add 2026 Regatta of Champions (Grade 150) and 2026 R.O.C. Kosmos Gold+Silver (Grade 75)
INSERT INTO public.asian_optimist_index_events (
  id, name, short_name, index_role, source_kind, host_country, host_noc,
  start_date, end_date, venue, official_results_url, official_results_source_name,
  sailorpath_regatta_slug, regatta_slugs, result_status, fleet_size, race_count,
  discard_count, is_eligible, grade, is_worlds, verified_mnas, notes
) VALUES
  (
    'regatta-of-champions-2026-optimist',
    '2026 Chesva Regatta of Champions — The R.O.C.',
    '2026 R.O.C.',
    'championship',
    'sailorpath_regatta',
    'Cyprus', 'CYP',
    '2026-11-11', '2026-11-14',
    'Famagusta Nautical Club, Limassol, Cyprus',
    'https://www.regattaofchampions.com/download/the-r-o-c-opti-2026-results/?ind=1794657524259&filename=2026%20R.O.C.%20Opti%20Results%20RACE%2014.pdf&wpdmdl=19814',
    '2026 R.O.C. Opti Results RACE 14.pdf',
    'regatta-of-champions-2026-optimist',
    ARRAY['regatta-of-champions-2026-optimist'],
    'verified', 45, 14, 2, true, 150, false, 22,
    'Invite-only championship of champions (45 starters across 22 MNAs, 14 races); designated Grade 150.'
  ),
  (
    'roc-kosmos-2026-optimist',
    '2026 The R.O.C. Kosmos — Optimist (Gold & Silver)',
    '2026 Kosmos',
    'regional_qualifier',
    'sailorpath_regatta',
    'Greece', 'GRE',
    '2026-07-08', '2026-07-15',
    'Athens, Greece',
    'https://www.regattaofchampions.com/r-o-c-kosmos/r-o-c-kosmos-opti/r-o-c-kosmos-2026/r-o-c-kosmos-results/',
    '2026 The R.O.C. Kosmos Optimist Gold & Silver Final Results',
    'roc-kosmos-2026-optimist-gold',
    ARRAY['roc-kosmos-2026-optimist-gold', 'roc-kosmos-2026-optimist-silver'],
    'verified', 122, 19, 3, true, 75, false, 12,
    'Combined 122-boat Gold (61) + Silver (61) classification following the qualifying series; designated Grade 75.'
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
