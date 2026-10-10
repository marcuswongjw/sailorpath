-- 104_remediate_confirmed_score_exceptions.sql
-- Correct race-level values visually confirmed from official result sheets or by
-- explicit administrator confirmation. The 2026-08-30 Selection Trials source:
-- https://www.racingrulesofsailing.org/documents/204023

BEGIN;

-- Guard stable source identities before changing any published result rows.
DO $validate_targets$
DECLARE
  target_count integer;
BEGIN
  WITH targets(slug, sailor_name) AS (
    VALUES
      ('sysc-2026-silver', 'Teo Shen Jie'),
      ('sysc-2026-silver', 'Clara Ng Siew Ning'),
      ('pesta-sukan-2026-silver', 'Ilysha Wong'),
      ('selection-trials-aug-26-2026-08-22', 'Kai Yen-Yu'),
      ('singapore-national-sailing-championships-2026-gold', 'Yumeng Li'),
      ('singapore-national-sailing-championships-2026-gold', 'Evan En Kai Ong')
  )
  SELECT count(*) INTO target_count
  FROM targets t
  JOIN public.regattas r ON r.slug = t.slug
  JOIN public.regatta_results rr ON rr.regatta_id = r.id
  JOIN public.sailors s ON s.id = rr.sailor_id AND s.name = t.sailor_name;

  IF target_count <> 6 THEN
    RAISE EXCEPTION 'Expected six unique remediation targets; found %', target_count;
  END IF;
END
$validate_targets$;

-- Official SYSC 2026 Silver parenthesised scorecards: mark the correct discards.
WITH targets(slug, sailor_name, race_number) AS (
  VALUES
    ('sysc-2026-silver', 'Teo Shen Jie', 1),
    ('sysc-2026-silver', 'Clara Ng Siew Ning', 2)
)
UPDATE public.regatta_race_results race
SET discarded = true,
    updated_at = now()
FROM targets t
JOIN public.regattas r ON r.slug = t.slug
JOIN public.regatta_results rr ON rr.regatta_id = r.id
JOIN public.sailors s ON s.id = rr.sailor_id AND s.name = t.sailor_name
WHERE race.regatta_result_id = rr.id
  AND race.race_number = t.race_number
  AND race.discarded IS DISTINCT FROM true;

-- Confirmed Pesta Sukan Silver Race 4 scorecard entry.
INSERT INTO public.regatta_race_results (
  id, regatta_result_id, race_number, score, raw_value, scoring_code,
  discarded, created_at, updated_at
)
SELECT gen_random_uuid(), rr.id, 4, 55, '55 DNC', 'DNC', false, now(), now()
FROM public.regattas r
JOIN public.regatta_results rr ON rr.regatta_id = r.id
JOIN public.sailors s ON s.id = rr.sailor_id
WHERE r.slug = 'pesta-sukan-2026-silver'
  AND s.name = 'Ilysha Wong'
ON CONFLICT (regatta_result_id, race_number) DO UPDATE
SET score = EXCLUDED.score,
    raw_value = EXCLUDED.raw_value,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = now();

-- Official final Selection Trials scorecard, page 2, rank 44: Kai Yen-Yu.
INSERT INTO public.regatta_race_results (
  id, regatta_result_id, race_number, score, raw_value, scoring_code,
  discarded, created_at, updated_at
)
SELECT gen_random_uuid(), rr.id, expected.race_number, expected.score,
       expected.raw_value, NULL, false, now(), now()
FROM (
  VALUES
    (10, 44::real, '44.0'::text),
    (11, 33::real, '33.0'::text),
    (12, 38::real, '38.0'::text)
) AS expected(race_number, score, raw_value)
JOIN public.regattas r ON r.slug = 'selection-trials-aug-26-2026-08-22'
JOIN public.regatta_results rr ON rr.regatta_id = r.id
JOIN public.sailors s ON s.id = rr.sailor_id AND s.name = 'Kai Yen-Yu'
ON CONFLICT (regatta_result_id, race_number) DO UPDATE
SET score = EXCLUDED.score,
    raw_value = EXCLUDED.raw_value,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = now();

-- Confirmed SNSC Gold Race 6 transposition: correct both competitor rows together.
WITH expected(slug, sailor_name, race_number, score, raw_value, scoring_code) AS (
  VALUES
    ('singapore-national-sailing-championships-2026-gold', 'Yumeng Li', 6, 48::real, '48'::text, NULL::text),
    ('singapore-national-sailing-championships-2026-gold', 'Evan En Kai Ong', 6, 84::real, '84 BFD'::text, 'BFD'::text)
)
UPDATE public.regatta_race_results race
SET score = expected.score,
    raw_value = expected.raw_value,
    scoring_code = expected.scoring_code,
    discarded = false,
    updated_at = now()
FROM expected
JOIN public.regattas r ON r.slug = expected.slug
JOIN public.regatta_results rr ON rr.regatta_id = r.id
JOIN public.sailors s ON s.id = rr.sailor_id AND s.name = expected.sailor_name
WHERE race.regatta_result_id = rr.id
  AND race.race_number = expected.race_number
  AND (
    race.score IS DISTINCT FROM expected.score
    OR race.raw_value IS DISTINCT FROM expected.raw_value
    OR race.scoring_code IS DISTINCT FROM expected.scoring_code
    OR race.discarded IS DISTINCT FROM false
  );

-- Verify every confirmed race cell after the idempotent updates.
DO $verify_remediation$
DECLARE
  verified_count integer;
BEGIN
  WITH expected(slug, sailor_name, race_number, score, raw_value, scoring_code, discarded) AS (
    VALUES
      ('sysc-2026-silver', 'Teo Shen Jie', 1, 20::real, '(20)'::text, NULL::text, true),
      ('sysc-2026-silver', 'Clara Ng Siew Ning', 2, 20::real, '(20)'::text, NULL::text, true),
      ('pesta-sukan-2026-silver', 'Ilysha Wong', 4, 55::real, '55 DNC'::text, 'DNC'::text, false),
      ('selection-trials-aug-26-2026-08-22', 'Kai Yen-Yu', 10, 44::real, '44.0'::text, NULL::text, false),
      ('selection-trials-aug-26-2026-08-22', 'Kai Yen-Yu', 11, 33::real, '33.0'::text, NULL::text, false),
      ('selection-trials-aug-26-2026-08-22', 'Kai Yen-Yu', 12, 38::real, '38.0'::text, NULL::text, false),
      ('singapore-national-sailing-championships-2026-gold', 'Yumeng Li', 6, 48::real, '48'::text, NULL::text, false),
      ('singapore-national-sailing-championships-2026-gold', 'Evan En Kai Ong', 6, 84::real, '84 BFD'::text, 'BFD'::text, false)
  )
  SELECT count(*) INTO verified_count
  FROM expected e
  JOIN public.regattas r ON r.slug = e.slug
  JOIN public.regatta_results rr ON rr.regatta_id = r.id
  JOIN public.sailors s ON s.id = rr.sailor_id AND s.name = e.sailor_name
  JOIN public.regatta_race_results race
    ON race.regatta_result_id = rr.id
   AND race.race_number = e.race_number
   AND race.score IS NOT DISTINCT FROM e.score
   AND race.raw_value IS NOT DISTINCT FROM e.raw_value
   AND race.scoring_code IS NOT DISTINCT FROM e.scoring_code
   AND race.discarded IS NOT DISTINCT FROM e.discarded;

  IF verified_count <> 8 THEN
    RAISE EXCEPTION 'Expected eight verified remediation race cells; found %', verified_count;
  END IF;
END
$verify_remediation$;

COMMIT;
