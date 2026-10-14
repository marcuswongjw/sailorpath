-- 115_publish_asian_index_profiles_and_regattas.sql
--
-- Turns the verified Asian Optimist Index identities into SailorPath sailor
-- profiles, while preserving existing exact name + NOC matches. It also copies
-- the two externally reviewed 2026 qualifier sheets into SailorPath's primary
-- published regatta/results model so that their calendar cards and result pages
-- are available outside the Index.
--
-- Safety:
-- - Profiles are matched only on exact normalized name + normalized NOC.
-- - Existing profiles and handles are never overwritten.
-- - Newly created handles are deterministic, valid (<= 30 chars), and match
--   src/lib/asianOptimistIndexProfileManifest.ts.
-- - Only organiser-published, visually reviewed source rows already verified in
--   the Index ledger are copied into public regatta results.

BEGIN;

-- Repeat the conservative matcher from migration 114 so any profile added after
-- its first import can be linked before a new imported profile is created.
WITH profile_candidates AS (
  SELECT
    s.id,
    regexp_replace(lower(s.name), '[^a-z0-9]', '', 'g') AS name_key,
    CASE lower(trim(coalesce(s.nationality, '')))
      WHEN 'singapore' THEN 'SGP'
      WHEN 'sgp' THEN 'SGP'
      WHEN 'malaysia' THEN 'MAS'
      WHEN 'mas' THEN 'MAS'
      WHEN 'thailand' THEN 'THA'
      WHEN 'tha' THEN 'THA'
      WHEN 'hong kong' THEN 'HKG'
      WHEN 'hkg' THEN 'HKG'
      WHEN 'china' THEN 'CHN'
      WHEN 'chn' THEN 'CHN'
      WHEN 'india' THEN 'IND'
      WHEN 'ind' THEN 'IND'
      WHEN 'japan' THEN 'JPN'
      WHEN 'jpn' THEN 'JPN'
      WHEN 'south korea' THEN 'KOR'
      WHEN 'korea' THEN 'KOR'
      WHEN 'kor' THEN 'KOR'
      WHEN 'azerbaijan' THEN 'AZE'
      WHEN 'aze' THEN 'AZE'
      WHEN 'kuwait' THEN 'KUW'
      WHEN 'kuw' THEN 'KUW'
      WHEN 'macau' THEN 'MAC'
      WHEN 'mac' THEN 'MAC'
      WHEN 'myanmar' THEN 'MYA'
      WHEN 'mya' THEN 'MYA'
      WHEN 'oman' THEN 'OMA'
      WHEN 'oma' THEN 'OMA'
      WHEN 'qatar' THEN 'QAT'
      WHEN 'qat' THEN 'QAT'
      WHEN 'saudi arabia' THEN 'KSA'
      WHEN 'ksa' THEN 'KSA'
      WHEN 'sri lanka' THEN 'SRI'
      WHEN 'sri' THEN 'SRI'
      WHEN 'united arab emirates' THEN 'UAE'
      WHEN 'uae' THEN 'UAE'
      ELSE upper(trim(coalesce(s.nationality, '')))
    END AS nationality
  FROM public.sailors s
),
unique_profile_candidates AS (
  SELECT
    id,
    name_key,
    nationality,
    count(*) OVER (PARTITION BY name_key, nationality) AS match_count
  FROM profile_candidates
)
UPDATE public.asian_optimist_index_sailors a
SET sailor_id = p.id,
    match_status = 'matched',
    updated_at = now()
FROM unique_profile_candidates p
WHERE a.sailor_id IS NULL
  AND p.match_count = 1
  AND regexp_replace(lower(a.canonical_name), '[^a-z0-9]', '', 'g') = p.name_key
  AND upper(coalesce(a.nationality, '')) = p.nationality;

-- Create a minimal, claimable SailorPath profile for each remaining verified
-- Index identity. Do not infer or expose a date of birth from a birth year.
INSERT INTO public.sailors (
  id,
  name,
  handle,
  sail_number,
  club,
  nationality,
  gender,
  created_at,
  updated_at
)
SELECT
  gen_random_uuid(),
  a.canonical_name,
  'asian-' || lower(coalesce(nullif(a.nationality, ''), 'unk')) || '-' ||
    coalesce(
      nullif(
        left(
          trim(both '-' from regexp_replace(lower(a.canonical_name), '[^a-z0-9]+', '-', 'g')),
          10
        ),
        ''
      ),
      'sailor'
    ) || '-' || substr(md5(a.identity_key), 1, 6),
  coalesce(
    nullif(regexp_replace(coalesce(a.latest_sail_number, ''), '^[A-Za-z]{3}[[:space:]]*', ''), ''),
    'N/A'
  ),
  'Imported official result',
  nullif(a.nationality, ''),
  CASE upper(coalesce(a.gender, ''))
    WHEN 'W' THEN 'F'
    WHEN 'F' THEN 'F'
    WHEN 'M' THEN 'M'
    ELSE NULL
  END,
  now(),
  now()
FROM public.asian_optimist_index_sailors a
WHERE a.sailor_id IS NULL
ON CONFLICT (handle) DO NOTHING;

-- Link every generated profile back to its Index identity. The generated handle
-- is the join key so this remains idempotent if the migration is re-applied.
UPDATE public.asian_optimist_index_sailors a
SET sailor_id = s.id,
    match_status = 'matched',
    updated_at = now()
FROM public.sailors s
WHERE a.sailor_id IS NULL
  AND s.handle = (
    'asian-' || lower(coalesce(nullif(a.nationality, ''), 'unk')) || '-' ||
      coalesce(
        nullif(
          left(
            trim(both '-' from regexp_replace(lower(a.canonical_name), '[^a-z0-9]+', '-', 'g')),
            10
          ),
          ''
        ),
        'sailor'
      ) || '-' || substr(md5(a.identity_key), 1, 6)
  );

DO $verify_index_profile_links$
DECLARE
  unlinked_count integer;
BEGIN
  SELECT count(*) INTO unlinked_count
  FROM public.asian_optimist_index_sailors
  WHERE sailor_id IS NULL;

  IF unlinked_count <> 0 THEN
    RAISE EXCEPTION 'Asian Optimist profile creation left % Index identities unlinked', unlinked_count;
  END IF;
END
$verify_index_profile_links$;

-- Publish source-backed weekend records in the primary SailorPath calendar.
INSERT INTO public.regatta_events (
  id, name, slug, start_date, end_date, venue, organizer, classes,
  nor_url, registration_url, counts_for_ranking, is_selection_trial,
  schedule_summary, scoring_rules, created_at, updated_at
) VALUES
  (
    gen_random_uuid(),
    '22nd Langkawi International Regatta Perdana 2026',
    'langkawi-international-regatta-perdana-2026',
    '2026-02-08',
    '2026-02-12',
    'National Sailing Centre, Langkawi, Kedah, Malaysia',
    'Langkawi International Regatta Perdana Organising Authority',
    '["Optimist"]'::jsonb,
    NULL,
    NULL,
    false,
    false,
    'Official Optimist Gold results are published on SailorPath from the final organiser-issued result sheet.',
    'Low-point system; 12 races sailed and 2 discards applied according to the final result sheet.',
    now(),
    now()
  ),
  (
    gen_random_uuid(),
    'Thailand International Sailing Championships 2026',
    'thailand-international-sailing-championships-2026',
    '2026-04-15',
    '2026-04-18',
    'Samudara Kila Yachting Center, Sattahip, Chonburi, Thailand',
    'Thailand International Sailing Championships Organising Authority',
    '["Optimist"]'::jsonb,
    NULL,
    NULL,
    false,
    false,
    'Official Optimist final results are published on SailorPath from the organiser-issued result sheet.',
    'Low-point system; 12 races sailed and 2 discards applied according to the final result sheet.',
    now(),
    now()
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  start_date = EXCLUDED.start_date,
  end_date = EXCLUDED.end_date,
  venue = EXCLUDED.venue,
  organizer = EXCLUDED.organizer,
  classes = EXCLUDED.classes,
  counts_for_ranking = EXCLUDED.counts_for_ranking,
  is_selection_trial = EXCLUDED.is_selection_trial,
  schedule_summary = EXCLUDED.schedule_summary,
  scoring_rules = EXCLUDED.scoring_rules,
  updated_at = now();

WITH source_regattas (
  event_slug,
  regatta_slug,
  name,
  event_id,
  start_date,
  end_date,
  fleet_size,
  race_count,
  geography,
  venue,
  organizer,
  official_results_url,
  official_results_source_name,
  schedule_notes
) AS (
  VALUES
    (
      'langkawi-international-regatta-perdana-2026',
      'langkawi-international-regatta-perdana-2026-optimist-gold',
      '22nd Langkawi International Regatta Perdana 2026 — Optimist Gold',
      'langkawi-international-regatta-perdana-2026',
      DATE '2026-02-08',
      DATE '2026-02-12',
      59,
      12,
      'MAS',
      'National Sailing Centre, Langkawi, Kedah, Malaysia',
      'Langkawi International Regatta Perdana Organising Authority',
      'https://drive.google.com/drive/folders/1jmJ5HWFMrOFPxcnMNhN_j-_lyzNJ-0Km?usp=sharing',
      'OPTIMIST.pdf — final results issued 13 February 2026',
      '59 entries · 12 races · 2 discards · official final result imported from organiser source.'
    ),
    (
      'thailand-international-sailing-championships-2026',
      'thailand-international-sailing-championships-2026-optimist',
      'Thailand International Sailing Championships 2026 — Optimist',
      'thailand-international-sailing-championships-2026',
      DATE '2026-04-15',
      DATE '2026-04-18',
      65,
      12,
      'THA',
      'Samudara Kila Yachting Center, Sattahip, Chonburi, Thailand',
      'Thailand International Sailing Championships Organising Authority',
      'https://www.racingrulesofsailing.org/documents/184140',
      'Optimist Result FinalDay — final results issued 19 April 2026',
      '65 entries · 12 races · 2 discards · official final result imported from organiser source.'
    )
)
INSERT INTO public.regattas (
  id, event_id, name, slug, date, end_date, total_fleet_size, division,
  race_count, geography, boat_class, counts_for_ranking, is_selection_trial,
  venue, organizer, official_results_url, official_results_source_name,
  schedule_notes, status, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  e.id,
  source.name,
  source.regatta_slug,
  source.start_date,
  source.end_date,
  source.fleet_size,
  'Gold',
  source.race_count,
  source.geography,
  'Optimist',
  false,
  false,
  source.venue,
  source.organizer,
  source.official_results_url,
  source.official_results_source_name,
  source.schedule_notes,
  'published',
  now(),
  now()
FROM source_regattas source
JOIN public.regatta_events e ON e.slug = source.event_slug
ON CONFLICT (slug) DO UPDATE SET
  event_id = EXCLUDED.event_id,
  name = EXCLUDED.name,
  date = EXCLUDED.date,
  end_date = EXCLUDED.end_date,
  total_fleet_size = EXCLUDED.total_fleet_size,
  division = EXCLUDED.division,
  race_count = EXCLUDED.race_count,
  geography = EXCLUDED.geography,
  boat_class = EXCLUDED.boat_class,
  counts_for_ranking = EXCLUDED.counts_for_ranking,
  is_selection_trial = EXCLUDED.is_selection_trial,
  venue = EXCLUDED.venue,
  organizer = EXCLUDED.organizer,
  official_results_url = EXCLUDED.official_results_url,
  official_results_source_name = EXCLUDED.official_results_source_name,
  schedule_notes = EXCLUDED.schedule_notes,
  status = 'published',
  updated_at = now();

-- The Index ledger keeps provenance as the official organiser result while now
-- pointing users to the corresponding SailorPath public result page as well.
UPDATE public.asian_optimist_index_events
SET sailorpath_regatta_slug = CASE id
  WHEN 'langkawi-international-regatta-perdana-2026'
    THEN 'langkawi-international-regatta-perdana-2026-optimist-gold'
  WHEN 'thailand-international-sailing-championships-2026'
    THEN 'thailand-international-sailing-championships-2026-optimist'
  ELSE sailorpath_regatta_slug
END,
updated_at = now()
WHERE id IN (
  'langkawi-international-regatta-perdana-2026',
  'thailand-international-sailing-championships-2026'
);

-- Rebuild the public rows from the verified Index-ledger source of truth.
-- Deleting the existing import is safe: these two primary sheets are owned by
-- this migration, and regatta race rows cascade with their parent result row.
DELETE FROM public.regatta_results
WHERE regatta_id IN (
  SELECT id
  FROM public.regattas
  WHERE slug IN (
    'langkawi-international-regatta-perdana-2026-optimist-gold',
    'thailand-international-sailing-championships-2026-optimist'
  )
);

DO $verify_index_result_profiles$
DECLARE
  missing_profile_results integer;
BEGIN
  SELECT count(*) INTO missing_profile_results
  FROM public.asian_optimist_index_results result
  JOIN public.asian_optimist_index_sailors sailor
    ON sailor.id = result.index_sailor_id
  WHERE result.event_id IN (
    'langkawi-international-regatta-perdana-2026',
    'thailand-international-sailing-championships-2026'
  )
    AND (result.verification_status <> 'verified' OR sailor.sailor_id IS NULL);

  IF missing_profile_results <> 0 THEN
    RAISE EXCEPTION 'External regatta import has % unverified or unlinked source rows', missing_profile_results;
  END IF;
END
$verify_index_result_profiles$;

INSERT INTO public.regatta_results (
  id, sailor_id, entry_label, entry_sail_number, entry_type, regatta_id, rank,
  nett_score, total_score, is_dns, is_overseas_commitment, gender, birth_year,
  nationality, evidence_url, evidence_name, evidence_type, official_url,
  evidence_notes, verification_status, verified_at, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  sailor.sailor_id,
  result.source_name,
  result.source_sail_number,
  'individual',
  regatta.id,
  result.source_rank,
  result.nett_score,
  result.total_score,
  false,
  false,
  CASE upper(coalesce(result.source_gender, ''))
    WHEN 'W' THEN 'F'
    WHEN 'F' THEN 'F'
    WHEN 'M' THEN 'M'
    ELSE NULL
  END,
  result.source_birth_year,
  nullif(result.source_nationality, ''),
  event.official_results_url,
  event.official_results_source_name,
  'link',
  event.official_results_url,
  'Imported from a visually reviewed organiser-published final result sheet for the Asian Optimist Index.',
  'verified',
  now(),
  now(),
  now()
FROM public.asian_optimist_index_results result
JOIN public.asian_optimist_index_sailors sailor
  ON sailor.id = result.index_sailor_id
JOIN public.asian_optimist_index_events event
  ON event.id = result.event_id
JOIN public.regattas regatta
  ON regatta.slug = CASE result.event_id
    WHEN 'langkawi-international-regatta-perdana-2026'
      THEN 'langkawi-international-regatta-perdana-2026-optimist-gold'
    WHEN 'thailand-international-sailing-championships-2026'
      THEN 'thailand-international-sailing-championships-2026-optimist'
  END
WHERE result.event_id IN (
  'langkawi-international-regatta-perdana-2026',
  'thailand-international-sailing-championships-2026'
)
  AND result.verification_status = 'verified';

-- Retain every official race token. Parentheses mark discards; a trailing code
-- (such as UFD) is kept separately while the numeric score remains sortable.
INSERT INTO public.regatta_race_results (
  id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value,
  created_at, updated_at
)
SELECT
  gen_random_uuid(),
  public_result.id,
  token.ordinality::integer,
  nullif(regexp_replace(token.raw_value, '[^0-9.]', '', 'g'), '')::real,
  nullif(
    (regexp_match(
      upper(regexp_replace(token.raw_value, '[()]', '', 'g')),
      '[0-9.]+[[:space:]]+([A-Z]+)'
    ))[1],
    ''
  ),
  token.raw_value LIKE '(%',
  token.raw_value,
  now(),
  now()
FROM public.regatta_results public_result
JOIN public.regattas regatta ON regatta.id = public_result.regatta_id
JOIN public.asian_optimist_index_results result
  ON result.event_id = CASE regatta.slug
    WHEN 'langkawi-international-regatta-perdana-2026-optimist-gold'
      THEN 'langkawi-international-regatta-perdana-2026'
    WHEN 'thailand-international-sailing-championships-2026-optimist'
      THEN 'thailand-international-sailing-championships-2026'
  END
  AND result.source_rank = public_result.rank
JOIN public.asian_optimist_index_sailors sailor
  ON sailor.id = result.index_sailor_id
  AND sailor.sailor_id = public_result.sailor_id
CROSS JOIN LATERAL jsonb_array_elements_text(result.race_scores)
  WITH ORDINALITY AS token(raw_value, ordinality)
WHERE regatta.slug IN (
  'langkawi-international-regatta-perdana-2026-optimist-gold',
  'thailand-international-sailing-championships-2026-optimist'
)
  AND token.raw_value ~ '[0-9]';

DO $verify_public_external_regattas$
DECLARE
  lirp_results integer;
  thailand_results integer;
  lirp_races integer;
  thailand_races integer;
BEGIN
  SELECT count(*) INTO lirp_results
  FROM public.regatta_results result
  JOIN public.regattas regatta ON regatta.id = result.regatta_id
  WHERE regatta.slug = 'langkawi-international-regatta-perdana-2026-optimist-gold';

  SELECT count(*) INTO thailand_results
  FROM public.regatta_results result
  JOIN public.regattas regatta ON regatta.id = result.regatta_id
  WHERE regatta.slug = 'thailand-international-sailing-championships-2026-optimist';

  SELECT count(*) INTO lirp_races
  FROM public.regatta_race_results race
  JOIN public.regatta_results result ON result.id = race.regatta_result_id
  JOIN public.regattas regatta ON regatta.id = result.regatta_id
  WHERE regatta.slug = 'langkawi-international-regatta-perdana-2026-optimist-gold';

  SELECT count(*) INTO thailand_races
  FROM public.regatta_race_results race
  JOIN public.regatta_results result ON result.id = race.regatta_result_id
  JOIN public.regattas regatta ON regatta.id = result.regatta_id
  WHERE regatta.slug = 'thailand-international-sailing-championships-2026-optimist';

  IF lirp_results <> 59 OR thailand_results <> 65 OR lirp_races <> 708 OR thailand_races <> 780 THEN
    RAISE EXCEPTION 'External public regatta count mismatch: LIRP results/races %/%, Thailand results/races %/%',
      lirp_results, lirp_races, thailand_results, thailand_races;
  END IF;
END
$verify_public_external_regattas$;

COMMIT;
