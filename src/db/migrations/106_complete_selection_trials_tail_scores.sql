-- 106_complete_selection_trials_tail_scores.sql
-- Complete the final seven scorecards visible in the official 2026 Selection
-- Trials result table, and normalise the verified NSC Cup I 2024 ILCA 7 R1 label.
-- Selection Trials source: user-supplied excerpt of official final table (30 Aug 2026).
-- NSC Cup I ILCA 4/6/7 source:
-- https://drive.google.com/file/d/1NbB8_efuTWbgaizk5vCyo_NSbeX8tm1j/view

BEGIN;

-- Target by immutable sheet rank plus sail number, not generated UUIDs or the
-- source-dependent sailor-name ordering.
DO $validate_targets$
DECLARE
  selection_target_count integer;
  justiin_target_count integer;
BEGIN
  WITH targets(rank, sail_number) AS (
    VALUES
      (45, '4681'),
      (46, '757'),
      (47, '2037'),
      (48, '2030'),
      (49, '3712'),
      (50, '3369'),
      (51, '3168')
  )
  SELECT count(*) INTO selection_target_count
  FROM targets t
  JOIN public.regattas r ON r.slug = 'selection-trials-aug-26-2026-08-22'
  JOIN public.regatta_results rr ON rr.regatta_id = r.id AND rr.rank = t.rank
  JOIN public.sailors s ON s.id = rr.sailor_id AND s.sail_number = t.sail_number;

  SELECT count(*) INTO justiin_target_count
  FROM public.regattas r
  JOIN public.regatta_results rr ON rr.regatta_id = r.id AND rr.rank = 1
  JOIN public.sailors s ON s.id = rr.sailor_id
  WHERE r.slug = 'nsc-1-ilca7-dec-24-2024-11-30'
    AND s.sail_number = '158031';

  IF selection_target_count <> 7 THEN
    RAISE EXCEPTION 'Expected seven Selection Trials scorecard targets; found %', selection_target_count;
  END IF;

  IF justiin_target_count <> 1 THEN
    RAISE EXCEPTION 'Expected one Justiin Ang NSC Cup target; found %', justiin_target_count;
  END IF;
END
$validate_targets$;

-- The official NSC Cup I table shows Justiin Ang's R1 as a counted 1, while R2
-- is the sole parenthesised discard. The numeric result was already correct.
UPDATE public.regatta_race_results race
SET raw_value = '1',
    scoring_code = NULL,
    discarded = false,
    updated_at = now()
FROM public.regattas r
JOIN public.regatta_results rr ON rr.regatta_id = r.id AND rr.rank = 1
JOIN public.sailors s ON s.id = rr.sailor_id AND s.sail_number = '158031'
WHERE r.slug = 'nsc-1-ilca7-dec-24-2024-11-30'
  AND race.regatta_result_id = rr.id
  AND race.race_number = 1
  AND (
    race.score IS DISTINCT FROM 1::real
    OR race.raw_value IS DISTINCT FROM '1'
    OR race.scoring_code IS DISTINCT FROM NULL::text
    OR race.discarded IS DISTINCT FROM false
  );

-- Official final Selection Trials rows 45–51. Parentheses are preserved exactly
-- as shown in the supplied result-table excerpt and drive the discard flags.
WITH expected(rank, sail_number, race_number, score, raw_value, scoring_code, discarded) AS (
  VALUES
    -- 45th: Quintan Rupert Low, 4681 — total 492.0, nett 439.0
    (45, '4681', 1, 24::real, '24.0'::text, NULL::text, false),
    (45, '4681', 2, 39::real, '39.0'::text, NULL::text, false),
    (45, '4681', 3, 37::real, '37.0'::text, NULL::text, false),
    (45, '4681', 4, 26::real, '26.0'::text, NULL::text, false),
    (45, '4681', 5, 39::real, '39.0'::text, NULL::text, false),
    (45, '4681', 6, 28::real, '28.0'::text, NULL::text, false),
    (45, '4681', 7, 45::real, '45.0'::text, NULL::text, false),
    (45, '4681', 8, 42::real, '42.0'::text, NULL::text, false),
    (45, '4681', 9, 53::real, '(53.0 DNC)'::text, 'DNC'::text, true),
    (45, '4681', 10, 53::real, '53.0 DNC'::text, 'DNC'::text, false),
    (45, '4681', 11, 53::real, '53.0 DNC'::text, 'DNC'::text, false),
    (45, '4681', 12, 53::real, '53.0 DNC'::text, 'DNC'::text, false),

    -- 46th: Chen-Yi Kai, SGP757 — total 496.0, nett 443.0
    (46, '757', 1, 48::real, '48.0'::text, NULL::text, false),
    (46, '757', 2, 45::real, '45.0'::text, NULL::text, false),
    (46, '757', 3, 42::real, '42.0'::text, NULL::text, false),
    (46, '757', 4, 47::real, '47.0'::text, NULL::text, false),
    (46, '757', 5, 37::real, '37.0'::text, NULL::text, false),
    (46, '757', 6, 46::real, '46.0'::text, NULL::text, false),
    (46, '757', 7, 37::real, '37.0'::text, NULL::text, false),
    (46, '757', 8, 46::real, '46.0'::text, NULL::text, false),
    (46, '757', 9, 20::real, '20.0'::text, NULL::text, false),
    (46, '757', 10, 46::real, '46.0'::text, NULL::text, false),
    (46, '757', 11, 53::real, '(53.0 DSQ)'::text, 'DSQ'::text, true),
    (46, '757', 12, 29::real, '29.0'::text, NULL::text, false),

    -- 47th: Xavier Yang Zheng Puah, SGP2037 — total 498.0, nett 445.0
    (47, '2037', 1, 50::real, '50.0'::text, NULL::text, false),
    (47, '2037', 2, 24::real, '24.0'::text, NULL::text, false),
    (47, '2037', 3, 45::real, '45.0'::text, NULL::text, false),
    (47, '2037', 4, 49::real, '49.0'::text, NULL::text, false),
    (47, '2037', 5, 34::real, '34.0'::text, NULL::text, false),
    (47, '2037', 6, 43::real, '43.0'::text, NULL::text, false),
    (47, '2037', 7, 38::real, '38.0'::text, NULL::text, false),
    (47, '2037', 8, 32::real, '32.0'::text, NULL::text, false),
    (47, '2037', 9, 53::real, '(53.0 DSQ)'::text, 'DSQ'::text, true),
    (47, '2037', 10, 41::real, '41.0'::text, NULL::text, false),
    (47, '2037', 11, 44::real, '44.0'::text, NULL::text, false),
    (47, '2037', 12, 45::real, '45.0'::text, NULL::text, false),

    -- 48th: Euan Hao Xuan Poh, 2030 — total 500.0, nett 450.0
    (48, '2030', 1, 49::real, '49.0'::text, NULL::text, false),
    (48, '2030', 2, 38::real, '38.0'::text, NULL::text, false),
    (48, '2030', 3, 44::real, '44.0'::text, NULL::text, false),
    (48, '2030', 4, 36::real, '36.0'::text, NULL::text, false),
    (48, '2030', 5, 46::real, '46.0'::text, NULL::text, false),
    (48, '2030', 6, 50::real, '(50.0)'::text, NULL::text, true),
    (48, '2030', 7, 50::real, '50.0'::text, NULL::text, false),
    (48, '2030', 8, 33::real, '33.0'::text, NULL::text, false),
    (48, '2030', 9, 47::real, '47.0'::text, NULL::text, false),
    (48, '2030', 10, 25::real, '25.0'::text, NULL::text, false),
    (48, '2030', 11, 34::real, '34.0'::text, NULL::text, false),
    (48, '2030', 12, 48::real, '48.0'::text, NULL::text, false),

    -- 49th: Kyan Chun Hong Tan, SGP3712 — total 500.0, nett 450.0
    (49, '3712', 1, 31::real, '31.0'::text, NULL::text, false),
    (49, '3712', 2, 50::real, '(50.0)'::text, NULL::text, true),
    (49, '3712', 3, 39::real, '39.0'::text, NULL::text, false),
    (49, '3712', 4, 48::real, '48.0'::text, NULL::text, false),
    (49, '3712', 5, 38::real, '38.0'::text, NULL::text, false),
    (49, '3712', 6, 48::real, '48.0'::text, NULL::text, false),
    (49, '3712', 7, 49::real, '49.0'::text, NULL::text, false),
    (49, '3712', 8, 34::real, '34.0'::text, NULL::text, false),
    (49, '3712', 9, 43::real, '43.0'::text, NULL::text, false),
    (49, '3712', 10, 49::real, '49.0'::text, NULL::text, false),
    (49, '3712', 11, 36::real, '36.0'::text, NULL::text, false),
    (49, '3712', 12, 35::real, '35.0'::text, NULL::text, false),

    -- 50th: Zachary Zhi En Low, SGP3369 — total 541.0, nett 488.0
    (50, '3369', 1, 39::real, '39.0'::text, NULL::text, false),
    (50, '3369', 2, 47::real, '47.0'::text, NULL::text, false),
    (50, '3369', 3, 49::real, '49.0'::text, NULL::text, false),
    (50, '3369', 4, 45::real, '45.0'::text, NULL::text, false),
    (50, '3369', 5, 43::real, '43.0'::text, NULL::text, false),
    (50, '3369', 6, 36::real, '36.0'::text, NULL::text, false),
    (50, '3369', 7, 46::real, '46.0'::text, NULL::text, false),
    (50, '3369', 8, 48::real, '48.0'::text, NULL::text, false),
    (50, '3369', 9, 42::real, '42.0'::text, NULL::text, false),
    (50, '3369', 10, 48::real, '48.0'::text, NULL::text, false),
    (50, '3369', 11, 45::real, '45.0'::text, NULL::text, false),
    (50, '3369', 12, 53::real, '(53.0 DNC)'::text, 'DNC'::text, true),

    -- 51st: Christopher Soh, SGP3168 — total 542.0, nett 489.0
    (51, '3168', 1, 46::real, '46.0'::text, NULL::text, false),
    (51, '3168', 2, 36::real, '36.0'::text, NULL::text, false),
    (51, '3168', 3, 30::real, '30.0'::text, NULL::text, false),
    (51, '3168', 4, 53::real, '(53.0 RET)'::text, 'RET'::text, true),
    (51, '3168', 5, 35::real, '35.0'::text, NULL::text, false),
    (51, '3168', 6, 45::real, '45.0'::text, NULL::text, false),
    (51, '3168', 7, 42::real, '42.0'::text, NULL::text, false),
    (51, '3168', 8, 43::real, '43.0'::text, NULL::text, false),
    (51, '3168', 9, 53::real, '53.0 DNC'::text, 'DNC'::text, false),
    (51, '3168', 10, 53::real, '53.0 DNC'::text, 'DNC'::text, false),
    (51, '3168', 11, 53::real, '53.0 DNC'::text, 'DNC'::text, false),
    (51, '3168', 12, 53::real, '53.0 DNC'::text, 'DNC'::text, false)
)
INSERT INTO public.regatta_race_results (
  id, regatta_result_id, race_number, score, raw_value, scoring_code,
  discarded, created_at, updated_at
)
SELECT gen_random_uuid(), rr.id, expected.race_number, expected.score,
       expected.raw_value, expected.scoring_code, expected.discarded, now(), now()
FROM expected
JOIN public.regattas r ON r.slug = 'selection-trials-aug-26-2026-08-22'
JOIN public.regatta_results rr ON rr.regatta_id = r.id AND rr.rank = expected.rank
JOIN public.sailors s ON s.id = rr.sailor_id AND s.sail_number = expected.sail_number
ON CONFLICT (regatta_result_id, race_number) DO UPDATE
SET score = EXCLUDED.score,
    raw_value = EXCLUDED.raw_value,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = now();

-- Validate all 84 Selection Trials cells plus the one repaired ILCA raw label.
DO $verify_results$
DECLARE
  selection_cells integer;
  reconciled_sheets integer;
  justiin_row integer;
BEGIN
  WITH expected(rank, sail_number, race_number, score, raw_value, scoring_code, discarded) AS (
    VALUES
      (45, '4681', 1, 24::real, '24.0'::text, NULL::text, false),
      (45, '4681', 2, 39::real, '39.0'::text, NULL::text, false),
      (45, '4681', 3, 37::real, '37.0'::text, NULL::text, false),
      (45, '4681', 4, 26::real, '26.0'::text, NULL::text, false),
      (45, '4681', 5, 39::real, '39.0'::text, NULL::text, false),
      (45, '4681', 6, 28::real, '28.0'::text, NULL::text, false),
      (45, '4681', 7, 45::real, '45.0'::text, NULL::text, false),
      (45, '4681', 8, 42::real, '42.0'::text, NULL::text, false),
      (45, '4681', 9, 53::real, '(53.0 DNC)'::text, 'DNC'::text, true),
      (45, '4681', 10, 53::real, '53.0 DNC'::text, 'DNC'::text, false),
      (45, '4681', 11, 53::real, '53.0 DNC'::text, 'DNC'::text, false),
      (45, '4681', 12, 53::real, '53.0 DNC'::text, 'DNC'::text, false),
      (46, '757', 1, 48::real, '48.0'::text, NULL::text, false),
      (46, '757', 2, 45::real, '45.0'::text, NULL::text, false),
      (46, '757', 3, 42::real, '42.0'::text, NULL::text, false),
      (46, '757', 4, 47::real, '47.0'::text, NULL::text, false),
      (46, '757', 5, 37::real, '37.0'::text, NULL::text, false),
      (46, '757', 6, 46::real, '46.0'::text, NULL::text, false),
      (46, '757', 7, 37::real, '37.0'::text, NULL::text, false),
      (46, '757', 8, 46::real, '46.0'::text, NULL::text, false),
      (46, '757', 9, 20::real, '20.0'::text, NULL::text, false),
      (46, '757', 10, 46::real, '46.0'::text, NULL::text, false),
      (46, '757', 11, 53::real, '(53.0 DSQ)'::text, 'DSQ'::text, true),
      (46, '757', 12, 29::real, '29.0'::text, NULL::text, false),
      (47, '2037', 1, 50::real, '50.0'::text, NULL::text, false),
      (47, '2037', 2, 24::real, '24.0'::text, NULL::text, false),
      (47, '2037', 3, 45::real, '45.0'::text, NULL::text, false),
      (47, '2037', 4, 49::real, '49.0'::text, NULL::text, false),
      (47, '2037', 5, 34::real, '34.0'::text, NULL::text, false),
      (47, '2037', 6, 43::real, '43.0'::text, NULL::text, false),
      (47, '2037', 7, 38::real, '38.0'::text, NULL::text, false),
      (47, '2037', 8, 32::real, '32.0'::text, NULL::text, false),
      (47, '2037', 9, 53::real, '(53.0 DSQ)'::text, 'DSQ'::text, true),
      (47, '2037', 10, 41::real, '41.0'::text, NULL::text, false),
      (47, '2037', 11, 44::real, '44.0'::text, NULL::text, false),
      (47, '2037', 12, 45::real, '45.0'::text, NULL::text, false),
      (48, '2030', 1, 49::real, '49.0'::text, NULL::text, false),
      (48, '2030', 2, 38::real, '38.0'::text, NULL::text, false),
      (48, '2030', 3, 44::real, '44.0'::text, NULL::text, false),
      (48, '2030', 4, 36::real, '36.0'::text, NULL::text, false),
      (48, '2030', 5, 46::real, '46.0'::text, NULL::text, false),
      (48, '2030', 6, 50::real, '(50.0)'::text, NULL::text, true),
      (48, '2030', 7, 50::real, '50.0'::text, NULL::text, false),
      (48, '2030', 8, 33::real, '33.0'::text, NULL::text, false),
      (48, '2030', 9, 47::real, '47.0'::text, NULL::text, false),
      (48, '2030', 10, 25::real, '25.0'::text, NULL::text, false),
      (48, '2030', 11, 34::real, '34.0'::text, NULL::text, false),
      (48, '2030', 12, 48::real, '48.0'::text, NULL::text, false),
      (49, '3712', 1, 31::real, '31.0'::text, NULL::text, false),
      (49, '3712', 2, 50::real, '(50.0)'::text, NULL::text, true),
      (49, '3712', 3, 39::real, '39.0'::text, NULL::text, false),
      (49, '3712', 4, 48::real, '48.0'::text, NULL::text, false),
      (49, '3712', 5, 38::real, '38.0'::text, NULL::text, false),
      (49, '3712', 6, 48::real, '48.0'::text, NULL::text, false),
      (49, '3712', 7, 49::real, '49.0'::text, NULL::text, false),
      (49, '3712', 8, 34::real, '34.0'::text, NULL::text, false),
      (49, '3712', 9, 43::real, '43.0'::text, NULL::text, false),
      (49, '3712', 10, 49::real, '49.0'::text, NULL::text, false),
      (49, '3712', 11, 36::real, '36.0'::text, NULL::text, false),
      (49, '3712', 12, 35::real, '35.0'::text, NULL::text, false),
      (50, '3369', 1, 39::real, '39.0'::text, NULL::text, false),
      (50, '3369', 2, 47::real, '47.0'::text, NULL::text, false),
      (50, '3369', 3, 49::real, '49.0'::text, NULL::text, false),
      (50, '3369', 4, 45::real, '45.0'::text, NULL::text, false),
      (50, '3369', 5, 43::real, '43.0'::text, NULL::text, false),
      (50, '3369', 6, 36::real, '36.0'::text, NULL::text, false),
      (50, '3369', 7, 46::real, '46.0'::text, NULL::text, false),
      (50, '3369', 8, 48::real, '48.0'::text, NULL::text, false),
      (50, '3369', 9, 42::real, '42.0'::text, NULL::text, false),
      (50, '3369', 10, 48::real, '48.0'::text, NULL::text, false),
      (50, '3369', 11, 45::real, '45.0'::text, NULL::text, false),
      (50, '3369', 12, 53::real, '(53.0 DNC)'::text, 'DNC'::text, true),
      (51, '3168', 1, 46::real, '46.0'::text, NULL::text, false),
      (51, '3168', 2, 36::real, '36.0'::text, NULL::text, false),
      (51, '3168', 3, 30::real, '30.0'::text, NULL::text, false),
      (51, '3168', 4, 53::real, '(53.0 RET)'::text, 'RET'::text, true),
      (51, '3168', 5, 35::real, '35.0'::text, NULL::text, false),
      (51, '3168', 6, 45::real, '45.0'::text, NULL::text, false),
      (51, '3168', 7, 42::real, '42.0'::text, NULL::text, false),
      (51, '3168', 8, 43::real, '43.0'::text, NULL::text, false),
      (51, '3168', 9, 53::real, '53.0 DNC'::text, 'DNC'::text, false),
      (51, '3168', 10, 53::real, '53.0 DNC'::text, 'DNC'::text, false),
      (51, '3168', 11, 53::real, '53.0 DNC'::text, 'DNC'::text, false),
      (51, '3168', 12, 53::real, '53.0 DNC'::text, 'DNC'::text, false)
  )
  SELECT count(*) INTO selection_cells
  FROM expected e
  JOIN public.regattas r ON r.slug = 'selection-trials-aug-26-2026-08-22'
  JOIN public.regatta_results rr ON rr.regatta_id = r.id AND rr.rank = e.rank
  JOIN public.sailors s ON s.id = rr.sailor_id AND s.sail_number = e.sail_number
  JOIN public.regatta_race_results race
    ON race.regatta_result_id = rr.id
   AND race.race_number = e.race_number
   AND race.score IS NOT DISTINCT FROM e.score
   AND race.raw_value IS NOT DISTINCT FROM e.raw_value
   AND race.scoring_code IS NOT DISTINCT FROM e.scoring_code
   AND race.discarded IS NOT DISTINCT FROM e.discarded;

  IF selection_cells <> 84 THEN
    RAISE EXCEPTION 'Expected 84 verified Selection Trials race cells; found %', selection_cells;
  END IF;

  WITH expected_totals(rank, sail_number, total_score, nett_score) AS (
    VALUES
      (45, '4681', 492::real, 439::real),
      (46, '757', 496::real, 443::real),
      (47, '2037', 498::real, 445::real),
      (48, '2030', 500::real, 450::real),
      (49, '3712', 500::real, 450::real),
      (50, '3369', 541::real, 488::real),
      (51, '3168', 542::real, 489::real)
  ), sheets AS (
    SELECT rr.id, rr.rank, s.sail_number, rr.total_score, rr.nett_score,
           sum(race.score) AS summed_total,
           sum(race.score) FILTER (WHERE NOT race.discarded) AS summed_nett,
           count(race.id)::integer AS race_rows
    FROM expected_totals e
    JOIN public.regattas r ON r.slug = 'selection-trials-aug-26-2026-08-22'
    JOIN public.regatta_results rr ON rr.regatta_id = r.id AND rr.rank = e.rank
    JOIN public.sailors s ON s.id = rr.sailor_id AND s.sail_number = e.sail_number
    JOIN public.regatta_race_results race ON race.regatta_result_id = rr.id
    GROUP BY rr.id, rr.rank, s.sail_number, rr.total_score, rr.nett_score
  )
  SELECT count(*) INTO reconciled_sheets
  FROM sheets
  WHERE race_rows = 12
    AND total_score IS NOT DISTINCT FROM summed_total
    AND nett_score IS NOT DISTINCT FROM summed_nett;

  IF reconciled_sheets <> 7 THEN
    RAISE EXCEPTION 'Expected seven reconciled Selection Trials scorecards; found %', reconciled_sheets;
  END IF;

  SELECT count(*) INTO justiin_row
  FROM public.regattas r
  JOIN public.regatta_results rr ON rr.regatta_id = r.id AND rr.rank = 1
  JOIN public.sailors s ON s.id = rr.sailor_id AND s.sail_number = '158031'
  JOIN public.regatta_race_results race ON race.regatta_result_id = rr.id
  WHERE r.slug = 'nsc-1-ilca7-dec-24-2024-11-30'
    AND race.race_number = 1
    AND race.score = 1
    AND race.raw_value = '1'
    AND race.scoring_code IS NULL
    AND race.discarded = false;

  IF justiin_row <> 1 THEN
    RAISE EXCEPTION 'Justiin Ang R1 notation did not verify';
  END IF;
END
$verify_results$;

COMMIT;
