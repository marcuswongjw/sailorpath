-- 107_rebuild_ne_monsoon_2025_wingfoil_combined.sql
--
-- Rebuild the published 2025 Northeast Monsoon Grand Prix Wingfoil result from
-- the visually reviewed official GP1, GP2, and GP3 score tables supplied by the
-- administrator. The official Notice of Race is:
-- https://www.racingrulesofsailing.org/documents/128729
--
-- Clause 12.3 makes every race count equally. Clauses 12.5–12.7 prescribe the
-- per-round DNC penalties and a total-score calculation across all rounds.
-- With 37 completed races, clause 12.11 requires seven *global* discards.

BEGIN;

-- GP2 and GP3 are the existing normalized source sheets. Their race rows must
-- still be complete and reconciled before they are used to rebuild the series.
DO $validate_sources$
DECLARE
  gp2_results integer;
  gp2_races integer;
  gp2_unreconciled integer;
  gp3_results integer;
  gp3_races integer;
  gp3_unreconciled integer;
  combined_results integer;
BEGIN
  SELECT count(*), coalesce(sum(race_rows), 0), coalesce(sum(unreconciled_rows), 0)
  INTO gp2_results, gp2_races, gp2_unreconciled
  FROM (
    SELECT rr.id,
           count(race.id)::integer AS race_rows,
           CASE WHEN bool_or(
             rr.total_score IS DISTINCT FROM totals.gross
             OR rr.nett_score IS DISTINCT FROM totals.nett
           ) THEN 1 ELSE 0 END AS unreconciled_rows
    FROM public.regattas r
    JOIN public.regatta_results rr ON rr.regatta_id = r.id
    JOIN LATERAL (
      SELECT sum(score)::real AS gross,
             sum(score) FILTER (WHERE NOT discarded)::real AS nett
      FROM public.regatta_race_results
      WHERE regatta_result_id = rr.id
    ) totals ON true
    LEFT JOIN public.regatta_race_results race ON race.regatta_result_id = rr.id
    WHERE r.slug = 'ne-monsoon-grand-prix-2025-series-2-wingfoil'
    GROUP BY rr.id, rr.total_score, rr.nett_score, totals.gross, totals.nett
  ) sheets;

  SELECT count(*), coalesce(sum(race_rows), 0), coalesce(sum(unreconciled_rows), 0)
  INTO gp3_results, gp3_races, gp3_unreconciled
  FROM (
    SELECT rr.id,
           count(race.id)::integer AS race_rows,
           CASE WHEN bool_or(
             rr.total_score IS DISTINCT FROM totals.gross
             OR rr.nett_score IS DISTINCT FROM totals.nett
           ) THEN 1 ELSE 0 END AS unreconciled_rows
    FROM public.regattas r
    JOIN public.regatta_results rr ON rr.regatta_id = r.id
    JOIN LATERAL (
      SELECT sum(score)::real AS gross,
             sum(score) FILTER (WHERE NOT discarded)::real AS nett
      FROM public.regatta_race_results
      WHERE regatta_result_id = rr.id
    ) totals ON true
    LEFT JOIN public.regatta_race_results race ON race.regatta_result_id = rr.id
    WHERE r.slug = 'ne-monsoon-grand-prix-2025-gps-speed-challenge-wingfoil'
    GROUP BY rr.id, rr.total_score, rr.nett_score, totals.gross, totals.nett
  ) sheets;

  SELECT count(*) INTO combined_results
  FROM public.regattas r
  JOIN public.regatta_results rr ON rr.regatta_id = r.id
  WHERE r.slug = 'ne-monsoon-grand-prix-2025-combined-wingfoil';

  IF gp2_results <> 17 OR gp2_races <> 340 OR gp3_results <> 17 OR gp3_races <> 153 THEN
    RAISE EXCEPTION
      'Expected reviewed GP2/GP3 Wingfoil sheets (17/340 and 17/153); found %/% and %/%',
      gp2_results, gp2_races, gp3_results, gp3_races;
  END IF;

  IF gp2_unreconciled <> 0 OR gp3_unreconciled <> 0 THEN
    RAISE EXCEPTION
      'A reviewed GP2/GP3 Wingfoil source row no longer reconciles (% GP2, % GP3)',
      gp2_unreconciled, gp3_unreconciled;
  END IF;

  IF combined_results <> 17 THEN
    RAISE EXCEPTION 'Expected 17 existing combined Wingfoil result rows; found %', combined_results;
  END IF;
END
$validate_sources$;

-- Add the independently reviewed GP1 Wingfoil sheet. The canonical profile
-- names follow the existing GP2/GP3 identity matches; entry labels preserve the
-- organiser’s spelling in the supplied GP1 result table.
INSERT INTO public.regatta_events (
  name, slug, start_date, end_date, venue, organizer, classes, nor_url,
  counts_for_ranking, schedule_summary, scoring_rules, created_at, updated_at
)
VALUES (
  '2025 Northeast Monsoon Grand Prix Series 1',
  'ne-monsoon-grand-prix-2025-series-1',
  DATE '2025-01-25',
  DATE '2025-01-26',
  'Changi Park CP 1',
  'Singapore Sailing Federation',
  '["Wingfoil"]'::jsonb,
  'https://www.racingrulesofsailing.org/documents/128729',
  false,
  'Wingfoil Grand Prix Series 1: eight races completed on 25–26 January 2025.',
  'Low Points System: one discard after eight races.',
  now(),
  now()
)
ON CONFLICT (slug) DO UPDATE
SET name = EXCLUDED.name,
    start_date = EXCLUDED.start_date,
    end_date = EXCLUDED.end_date,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer,
    classes = EXCLUDED.classes,
    nor_url = EXCLUDED.nor_url,
    counts_for_ranking = EXCLUDED.counts_for_ranking,
    schedule_summary = EXCLUDED.schedule_summary,
    scoring_rules = EXCLUDED.scoring_rules,
    updated_at = now();

WITH gp1_event AS (
  SELECT id
  FROM public.regatta_events
  WHERE slug = 'ne-monsoon-grand-prix-2025-series-1'
)
INSERT INTO public.regattas (
  name, slug, event_id, date, end_date, total_fleet_size, division, race_count,
  geography, boat_class, counts_for_ranking, venue, organizer, schedule_notes,
  status, reviewed_at, created_at, updated_at
)
SELECT
  '2025 Northeast Monsoon Grand Prix Series 1 — Wingfoil',
  'ne-monsoon-grand-prix-2025-series-1-wingfoil',
  id,
  DATE '2025-01-25',
  DATE '2025-01-26',
  6,
  'Open',
  8,
  'SGP',
  'Wingfoil',
  false,
  'Changi Park CP 1',
  'Singapore Sailing Federation',
  'Official provisional Wingfoil results: 8 races, one discard, six entries. Visually reviewed from the administrator-supplied NE Monsoon GP1 Day2 PDF (26 January 2025).',
  'published',
  now(),
  now(),
  now()
FROM gp1_event
ON CONFLICT (slug) DO UPDATE
SET event_id = EXCLUDED.event_id,
    name = EXCLUDED.name,
    date = EXCLUDED.date,
    end_date = EXCLUDED.end_date,
    total_fleet_size = EXCLUDED.total_fleet_size,
    division = EXCLUDED.division,
    race_count = EXCLUDED.race_count,
    geography = EXCLUDED.geography,
    boat_class = EXCLUDED.boat_class,
    counts_for_ranking = EXCLUDED.counts_for_ranking,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer,
    schedule_notes = EXCLUDED.schedule_notes,
    status = EXCLUDED.status,
    reviewed_at = EXCLUDED.reviewed_at,
    updated_at = now();

-- The combined sheet contains the 17 sailors represented in GP2 and GP3, not
-- the old synthetic 19-sailor fallback field used by the prior merge.
UPDATE public.regattas
SET total_fleet_size = 17,
    race_count = 37,
    counts_for_ranking = false,
    schedule_notes = 'Combined from 2025 Northeast Monsoon Grand Prix Wingfoil GP1 (8 races), GP2 (20 races), and GP3 GPS Speed Challenge (9 races). Seven global discards apply under the official Notice of Race.',
    status = 'published',
    reviewed_at = now(),
    updated_at = now()
WHERE slug = 'ne-monsoon-grand-prix-2025-combined-wingfoil';

WITH gp1_results(canonical_name, entry_label, entry_sail_number, rank, total_score, nett_score) AS (
  VALUES
    ('Jackson Ho', 'Jackson Ho', '11', 1, 8::real, 7::real),
    ('Felix Knick', 'Felix Knick', '50', 2, 26::real, 19::real),
    ('Ker Wan Chew', 'Chew Ker Wan', '15', 3, 27::real, 20::real),
    ('Jun Hao Lo', 'Lo Jun Hao', '21', 4, 56::real, 49::real),
    ('James Feathers', 'James Feathers', '19', 4, 56::real, 49::real),
    ('Sven Welak', 'Sven Welack', '25', 4, 56::real, 49::real)
), gp2_roster AS (
  SELECT rr.sailor_id, s.name AS canonical_name
  FROM public.regattas r
  JOIN public.regatta_results rr ON rr.regatta_id = r.id
  JOIN public.sailors s ON s.id = rr.sailor_id
  WHERE r.slug = 'ne-monsoon-grand-prix-2025-series-2-wingfoil'
)
INSERT INTO public.regatta_results (
  id, sailor_id, entry_label, entry_sail_number, entry_type, regatta_id, rank,
  nett_score, total_score, gender, official_url, evidence_notes,
  verification_status, verified_at, created_at, updated_at
)
SELECT
  gen_random_uuid(), roster.sailor_id, source.entry_label, source.entry_sail_number,
  'individual', gp1.id, source.rank, source.nett_score, source.total_score, 'M',
  'https://www.racingrulesofsailing.org/documents/128729',
  'Official GP1 result values visually transcribed from the administrator-supplied NE Monsoon GP1 Day2 PDF.',
  'verified', now(), now(), now()
FROM gp1_results source
JOIN gp2_roster roster ON roster.canonical_name = source.canonical_name
JOIN public.regattas gp1 ON gp1.slug = 'ne-monsoon-grand-prix-2025-series-1-wingfoil'
ON CONFLICT (sailor_id, regatta_id) DO UPDATE
SET entry_label = EXCLUDED.entry_label,
    entry_sail_number = EXCLUDED.entry_sail_number,
    entry_type = EXCLUDED.entry_type,
    rank = EXCLUDED.rank,
    nett_score = EXCLUDED.nett_score,
    total_score = EXCLUDED.total_score,
    gender = EXCLUDED.gender,
    official_url = EXCLUDED.official_url,
    evidence_notes = EXCLUDED.evidence_notes,
    verification_status = EXCLUDED.verification_status,
    verified_at = EXCLUDED.verified_at,
    updated_at = now();

WITH gp1_races(canonical_name, race_number, score, raw_value, scoring_code, discarded) AS (
  VALUES
    ('Jackson Ho', 1, 1::real, '(1.0)', NULL::text, true),
    ('Jackson Ho', 2, 1::real, '1.0', NULL::text, false),
    ('Jackson Ho', 3, 1::real, '1.0', NULL::text, false),
    ('Jackson Ho', 4, 1::real, '1.0', NULL::text, false),
    ('Jackson Ho', 5, 1::real, '1.0', NULL::text, false),
    ('Jackson Ho', 6, 1::real, '1.0', NULL::text, false),
    ('Jackson Ho', 7, 1::real, '1.0', NULL::text, false),
    ('Jackson Ho', 8, 1::real, '1.0', NULL::text, false),
    ('Felix Knick', 1, 3::real, '3.0', NULL::text, false),
    ('Felix Knick', 2, 3::real, '3.0', NULL::text, false),
    ('Felix Knick', 3, 2::real, '2.0', NULL::text, false),
    ('Felix Knick', 4, 3::real, '3.0', NULL::text, false),
    ('Felix Knick', 5, 3::real, '3.0', NULL::text, false),
    ('Felix Knick', 6, 3::real, '3.0', NULL::text, false),
    ('Felix Knick', 7, 7::real, '(RET 7.0)', 'RET', true),
    ('Felix Knick', 8, 2::real, '2.0', NULL::text, false),
    ('Ker Wan Chew', 1, 2::real, '2.0', NULL::text, false),
    ('Ker Wan Chew', 2, 2::real, '2.0', NULL::text, false),
    ('Ker Wan Chew', 3, 3::real, '3.0', NULL::text, false),
    ('Ker Wan Chew', 4, 2::real, '2.0', NULL::text, false),
    ('Ker Wan Chew', 5, 2::real, '2.0', NULL::text, false),
    ('Ker Wan Chew', 6, 2::real, '2.0', NULL::text, false),
    ('Ker Wan Chew', 7, 7::real, '(DNF 7.0)', 'DNF', true),
    ('Ker Wan Chew', 8, 7::real, 'DNC 7.0', 'DNC', false),
    ('Jun Hao Lo', 1, 7::real, '(DNC 7.0)', 'DNC', true),
    ('Jun Hao Lo', 2, 7::real, 'DNC 7.0', 'DNC', false),
    ('Jun Hao Lo', 3, 7::real, 'DNC 7.0', 'DNC', false),
    ('Jun Hao Lo', 4, 7::real, 'DNC 7.0', 'DNC', false),
    ('Jun Hao Lo', 5, 7::real, 'DNC 7.0', 'DNC', false),
    ('Jun Hao Lo', 6, 7::real, 'DNC 7.0', 'DNC', false),
    ('Jun Hao Lo', 7, 7::real, 'DNC 7.0', 'DNC', false),
    ('Jun Hao Lo', 8, 7::real, 'DNC 7.0', 'DNC', false),
    ('James Feathers', 1, 7::real, '(DNC 7.0)', 'DNC', true),
    ('James Feathers', 2, 7::real, 'DNC 7.0', 'DNC', false),
    ('James Feathers', 3, 7::real, 'DNC 7.0', 'DNC', false),
    ('James Feathers', 4, 7::real, 'DNC 7.0', 'DNC', false),
    ('James Feathers', 5, 7::real, 'DNC 7.0', 'DNC', false),
    ('James Feathers', 6, 7::real, 'DNC 7.0', 'DNC', false),
    ('James Feathers', 7, 7::real, 'DNC 7.0', 'DNC', false),
    ('James Feathers', 8, 7::real, 'DNC 7.0', 'DNC', false),
    ('Sven Welak', 1, 7::real, '(DNC 7.0)', 'DNC', true),
    ('Sven Welak', 2, 7::real, 'DNC 7.0', 'DNC', false),
    ('Sven Welak', 3, 7::real, 'DNC 7.0', 'DNC', false),
    ('Sven Welak', 4, 7::real, 'DNC 7.0', 'DNC', false),
    ('Sven Welak', 5, 7::real, 'DNC 7.0', 'DNC', false),
    ('Sven Welak', 6, 7::real, 'DNC 7.0', 'DNC', false),
    ('Sven Welak', 7, 7::real, 'DNC 7.0', 'DNC', false),
    ('Sven Welak', 8, 7::real, 'DNC 7.0', 'DNC', false)
), gp2_roster AS (
  SELECT rr.sailor_id, s.name AS canonical_name
  FROM public.regattas r
  JOIN public.regatta_results rr ON rr.regatta_id = r.id
  JOIN public.sailors s ON s.id = rr.sailor_id
  WHERE r.slug = 'ne-monsoon-grand-prix-2025-series-2-wingfoil'
)
INSERT INTO public.regatta_race_results (
  id, regatta_result_id, race_number, score, raw_value, scoring_code,
  discarded, created_at, updated_at
)
SELECT
  gen_random_uuid(), result.id, source.race_number, source.score,
  source.raw_value, source.scoring_code, source.discarded, now(), now()
FROM gp1_races source
JOIN gp2_roster roster ON roster.canonical_name = source.canonical_name
JOIN public.regattas gp1 ON gp1.slug = 'ne-monsoon-grand-prix-2025-series-1-wingfoil'
JOIN public.regatta_results result
  ON result.regatta_id = gp1.id
 AND result.sailor_id = roster.sailor_id
ON CONFLICT (regatta_result_id, race_number) DO UPDATE
SET score = EXCLUDED.score,
    raw_value = EXCLUDED.raw_value,
    scoring_code = EXCLUDED.scoring_code,
    discarded = EXCLUDED.discarded,
    updated_at = now();

-- Keep the participant snapshot for the new normalized GP1 sheet complete.
INSERT INTO public.regatta_result_participants (
  id, regatta_result_id, sailor_id, source_name, display_order, role,
  match_status, ranking_credit, created_at, updated_at
)
SELECT
  gen_random_uuid(), result.id, result.sailor_id, result.entry_label, 1, 'solo',
  'matched', false, now(), now()
FROM public.regattas gp1
JOIN public.regatta_results result ON result.regatta_id = gp1.id
WHERE gp1.slug = 'ne-monsoon-grand-prix-2025-series-1-wingfoil'
ON CONFLICT (regatta_result_id, display_order) DO UPDATE
SET sailor_id = EXCLUDED.sailor_id,
    source_name = EXCLUDED.source_name,
    role = EXCLUDED.role,
    match_status = EXCLUDED.match_status,
    ranking_credit = EXCLUDED.ranking_credit,
    updated_at = now();

-- Materialize the 17 × 37 combined score grid before touching the published
-- result. Scores are reconstructed from the three reviewed round sheets:
-- GP1 raw scores for its six entrants, then GP2/GP3 normalized source rows.
CREATE TEMP TABLE _ne_monsoon_2025_wingfoil_combined ON COMMIT DROP AS
WITH roster AS (
  SELECT result.sailor_id, sailor.name AS canonical_name
  FROM public.regattas gp2
  JOIN public.regatta_results result ON result.regatta_id = gp2.id
  JOIN public.sailors sailor ON sailor.id = result.sailor_id
  WHERE gp2.slug = 'ne-monsoon-grand-prix-2025-series-2-wingfoil'
), gp1 AS (
  SELECT
    roster.sailor_id,
    series_race.race_number,
    coalesce(source.score, 8::real) AS score,
    coalesce(
      CASE
        WHEN left(source.raw_value, 1) = '(' AND right(source.raw_value, 1) = ')'
          THEN substring(source.raw_value FROM 2 FOR char_length(source.raw_value) - 2)
        ELSE source.raw_value
      END,
      'DNC 8.0'::text
    ) AS raw_value,
    coalesce(source.scoring_code, 'DNC'::text) AS scoring_code
  FROM roster
  CROSS JOIN generate_series(1, 8) AS series_race(race_number)
  LEFT JOIN public.regattas source_regatta
    ON source_regatta.slug = 'ne-monsoon-grand-prix-2025-series-1-wingfoil'
  LEFT JOIN public.regatta_results source_result
    ON source_result.regatta_id = source_regatta.id
   AND source_result.sailor_id = roster.sailor_id
  LEFT JOIN public.regatta_race_results source
    ON source.regatta_result_id = source_result.id
   AND source.race_number = series_race.race_number
), gp2 AS (
  SELECT
    result.sailor_id,
    race.race_number + 8 AS race_number,
    race.score,
    CASE
      WHEN left(race.raw_value, 1) = '(' AND right(race.raw_value, 1) = ')'
        THEN substring(race.raw_value FROM 2 FOR char_length(race.raw_value) - 2)
      ELSE race.raw_value
    END AS raw_value,
    race.scoring_code
  FROM public.regattas source_regatta
  JOIN public.regatta_results result ON result.regatta_id = source_regatta.id
  JOIN public.regatta_race_results race ON race.regatta_result_id = result.id
  WHERE source_regatta.slug = 'ne-monsoon-grand-prix-2025-series-2-wingfoil'
), gp3 AS (
  SELECT
    result.sailor_id,
    race.race_number + 28 AS race_number,
    race.score,
    CASE
      WHEN left(race.raw_value, 1) = '(' AND right(race.raw_value, 1) = ')'
        THEN substring(race.raw_value FROM 2 FOR char_length(race.raw_value) - 2)
      ELSE race.raw_value
    END AS raw_value,
    race.scoring_code
  FROM public.regattas source_regatta
  JOIN public.regatta_results result ON result.regatta_id = source_regatta.id
  JOIN public.regatta_race_results race ON race.regatta_result_id = result.id
  WHERE source_regatta.slug = 'ne-monsoon-grand-prix-2025-gps-speed-challenge-wingfoil'
), all_races AS (
  SELECT * FROM gp1
  UNION ALL
  SELECT * FROM gp2
  UNION ALL
  SELECT * FROM gp3
), scored AS (
  SELECT
    all_races.*,
    row_number() OVER (
      PARTITION BY sailor_id
      ORDER BY score DESC, race_number
    ) AS discard_order
  FROM all_races
), totals AS (
  SELECT
    sailor_id,
    sum(score)::real AS total_score,
    sum(score) FILTER (WHERE discard_order > 7)::real AS nett_score,
    array_agg(score ORDER BY score) FILTER (WHERE discard_order > 7) AS counted_scores,
    array_agg(score ORDER BY score) AS all_scores
  FROM scored
  GROUP BY sailor_id
), rankings AS (
  SELECT
    totals.*,
    rank() OVER (
      ORDER BY nett_score, counted_scores, all_scores
    )::integer AS final_rank
  FROM totals
)
SELECT
  scored.sailor_id,
  scored.race_number,
  scored.score,
  CASE
    WHEN scored.discard_order <= 7 THEN '(' || scored.raw_value || ')'
    ELSE scored.raw_value
  END AS raw_value,
  scored.scoring_code,
  (scored.discard_order <= 7) AS discarded,
  rankings.total_score,
  rankings.nett_score,
  rankings.final_rank
FROM scored
JOIN rankings ON rankings.sailor_id = scored.sailor_id;

DO $validate_combined_grid$
DECLARE
  race_cells integer;
  competitors integer;
  invalid_discard_sets integer;
BEGIN
  SELECT count(*), count(DISTINCT sailor_id)
  INTO race_cells, competitors
  FROM _ne_monsoon_2025_wingfoil_combined;

  SELECT count(*) INTO invalid_discard_sets
  FROM (
    SELECT sailor_id
    FROM _ne_monsoon_2025_wingfoil_combined
    GROUP BY sailor_id
    HAVING count(*) <> 37 OR count(*) FILTER (WHERE discarded) <> 7
  ) invalid;

  IF race_cells <> 629 OR competitors <> 17 OR invalid_discard_sets <> 0 THEN
    RAISE EXCEPTION
      'Expected a complete 17 × 37 grid with seven discards per sailor; found cells %, sailors %, invalid discard sets %',
      race_cells, competitors, invalid_discard_sets;
  END IF;
END
$validate_combined_grid$;

-- Replace each published combined race cell from the fully validated grid.
DELETE FROM public.regatta_race_results race
USING public.regatta_results result, public.regattas combined
WHERE race.regatta_result_id = result.id
  AND result.regatta_id = combined.id
  AND combined.slug = 'ne-monsoon-grand-prix-2025-combined-wingfoil';

INSERT INTO public.regatta_race_results (
  id, regatta_result_id, race_number, score, raw_value, scoring_code,
  discarded, created_at, updated_at
)
SELECT
  gen_random_uuid(), result.id, grid.race_number, grid.score, grid.raw_value,
  grid.scoring_code, grid.discarded, now(), now()
FROM _ne_monsoon_2025_wingfoil_combined grid
JOIN public.regattas combined
  ON combined.slug = 'ne-monsoon-grand-prix-2025-combined-wingfoil'
JOIN public.regatta_results result
  ON result.regatta_id = combined.id
 AND result.sailor_id = grid.sailor_id;

UPDATE public.regatta_results result
SET rank = summary.final_rank,
    total_score = summary.total_score,
    nett_score = summary.nett_score,
    evidence_notes = 'Rebuilt from visually reviewed GP1, GP2, and GP3 official Wingfoil score tables using the 2025 Northeast Monsoon Grand Prix Notice of Race clauses 12.3–12.7 and 12.11.',
    official_url = 'https://www.racingrulesofsailing.org/documents/128729',
    verification_status = 'verified',
    verified_at = now(),
    updated_at = now()
FROM (
  SELECT DISTINCT sailor_id, final_rank, total_score, nett_score
  FROM _ne_monsoon_2025_wingfoil_combined
) summary
JOIN public.regattas combined
  ON combined.slug = 'ne-monsoon-grand-prix-2025-combined-wingfoil'
WHERE result.regatta_id = combined.id
  AND result.sailor_id = summary.sailor_id;

-- Verify the imported GP1 sheet and the rebuilt combined standings, including
-- the corrected Jackson Ho 60/30 score and the seven-discard rule.
DO $verify_rebuild$
DECLARE
  gp1_results integer;
  gp1_races integer;
  combined_results integer;
  combined_races integer;
  unreconciled integer;
  expected_rows integer;
BEGIN
  SELECT count(DISTINCT result.id), count(race.id)
  INTO gp1_results, gp1_races
  FROM public.regattas gp1
  JOIN public.regatta_results result ON result.regatta_id = gp1.id
  JOIN public.regatta_race_results race ON race.regatta_result_id = result.id
  WHERE gp1.slug = 'ne-monsoon-grand-prix-2025-series-1-wingfoil';

  SELECT count(DISTINCT result.id), count(race.id)
  INTO combined_results, combined_races
  FROM public.regattas combined
  JOIN public.regatta_results result ON result.regatta_id = combined.id
  JOIN public.regatta_race_results race ON race.regatta_result_id = result.id
  WHERE combined.slug = 'ne-monsoon-grand-prix-2025-combined-wingfoil';

  SELECT count(*) INTO unreconciled
  FROM (
    SELECT result.id
    FROM public.regattas combined
    JOIN public.regatta_results result ON result.regatta_id = combined.id
    JOIN public.regatta_race_results race ON race.regatta_result_id = result.id
    WHERE combined.slug = 'ne-monsoon-grand-prix-2025-combined-wingfoil'
    GROUP BY result.id, result.total_score, result.nett_score
    HAVING sum(race.score)::real IS DISTINCT FROM result.total_score
       OR sum(race.score) FILTER (WHERE NOT race.discarded)::real IS DISTINCT FROM result.nett_score
       OR count(*) FILTER (WHERE race.discarded) <> 7
  ) invalid;

  WITH expected(canonical_name, rank, total_score, nett_score) AS (
    VALUES
      ('Jackson Ho', 1, 60::real, 30::real),
      ('Guillaume Pichoir', 2, 152::real, 92::real),
      ('Ker Wan Chew', 3, 166::real, 92::real),
      ('Sven Welak', 4, 223::real, 158::real),
      ('Ryusai Hatano', 5, 295::real, 169::real),
      ('Felix Knick', 6, 298::real, 172::real),
      ('Arthur Phan', 7, 385::real, 259::real),
      ('Malo Pichoir', 8, 433::real, 307::real),
      ('Xavier Lau', 9, 464::real, 338::real),
      ('Mikhail McEntyre', 10, 487::real, 361::real),
      ('Greg McEntyre', 11, 505::real, 379::real),
      ('Bill Hickling', 12, 551::real, 425::real),
      ('Ryan Lo', 13, 554::real, 428::real),
      ('Andrew Lees', 14, 556::real, 430::real),
      ('Mason Lau Qifeng', 15, 558::real, 432::real),
      ('James Feathers', 16, 578::real, 452::real),
      ('Jun Hao Lo', 16, 578::real, 452::real)
  )
  SELECT count(*) INTO expected_rows
  FROM expected
  JOIN public.sailors sailor ON sailor.name = expected.canonical_name
  JOIN public.regattas combined
    ON combined.slug = 'ne-monsoon-grand-prix-2025-combined-wingfoil'
  JOIN public.regatta_results result
    ON result.regatta_id = combined.id
   AND result.sailor_id = sailor.id
   AND result.rank = expected.rank
   AND result.total_score = expected.total_score
   AND result.nett_score = expected.nett_score;

  IF gp1_results <> 6 OR gp1_races <> 48 THEN
    RAISE EXCEPTION 'Expected 6 GP1 Wingfoil results and 48 race scores; found % and %', gp1_results, gp1_races;
  END IF;

  IF combined_results <> 17 OR combined_races <> 629 OR unreconciled <> 0 OR expected_rows <> 17 THEN
    RAISE EXCEPTION
      'Rebuilt combined Wingfoil verification failed: results %, races %, unreconciled %, expected rows %',
      combined_results, combined_races, unreconciled, expected_rows;
  END IF;
END
$verify_rebuild$;

COMMIT;
