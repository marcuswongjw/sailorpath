-- Migration 139: Import Hong Kong Race Week 2026 & 2025 (ILCA 4)
-- Source: Official Sailwave results tables hosted by Royal Hong Kong Yacht Club (RHKYC)
-- 2026: 49 competitors, 8 races (2 discards)
-- 2025: 50 competitors, 9 races (2 discards)

BEGIN;

-- 1. Regatta Events (Update existing event hubs to include ILCA 4)
UPDATE public.regatta_events
SET classes = CASE
    WHEN classes ? 'ILCA 4' THEN classes
    ELSE classes || '["ILCA 4"]'::jsonb
END
WHERE slug IN ('hong-kong-race-week-2026', 'hong-kong-race-week-2025');

-- 2. Regatta Class Sheets
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name
) VALUES (
    '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca',
    '8b2aa46e-12e7-55ee-afd4-2b927edd02cf',
    'Hong Kong Race Week 2026 (ILCA 4)',
    'hong-kong-race-week-2026-ilca4',
    '2026-01-27',
    '2026-02-01',
    49,
    'Open',
    8,
    'HKG',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'Middle Island, Royal Hong Kong Yacht Club, Hong Kong',
    'Royal Hong Kong Yacht Club & Sailing Federation of Hong Kong, China',
    'published',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm',
    'RHKYC Sailwave - Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results'
) ON CONFLICT (id) DO UPDATE SET
    event_id = EXCLUDED.event_id,
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count;

INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name
) VALUES (
    'f1c10dce-da8d-5517-a662-3806d02b929e',
    '3132b110-9295-5303-8b3f-435037f90941',
    'Hong Kong Race Week 2025 (ILCA 4)',
    'hong-kong-race-week-2025-ilca4',
    '2025-02-11',
    '2025-02-16',
    50,
    'Open',
    9,
    'HKG',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'Middle Island, Royal Hong Kong Yacht Club, Hong Kong',
    'Royal Hong Kong Yacht Club & Sailing Federation of Hong Kong, China',
    'published',
    'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm',
    'RHKYC Sailwave - Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results'
) ON CONFLICT (id) DO UPDATE SET
    event_id = EXCLUDED.event_id,
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count;

-- 3. Import Results and Resolve Sailors via PL/pgSQL block
DO $$
DECLARE
  v_sailor_id uuid;
  v_res_id uuid;
  v_part_id uuid;
BEGIN

  -- ==========================================================================
  -- Hong Kong Race Week 2026 (ILCA 4) (49 competitors)
  -- ==========================================================================
  -- Competitor Rank 1: Ian Goh (222713, SGP)
  v_sailor_id := 'd52d284f-c0d7-4a72-b86d-45c57b963c6c';
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Ian Goh')) OR lower(trim(alias_name)) = lower(trim('Ian Goh')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ian Goh', 'ilca4-sgp-ian-goh-222713', 'N/A', '222713', '222713', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '222713') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '011ff256-c51b-5feb-80fa-ed7ec373c761';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Ian Goh', '222713', 'individual',
    1, 15.0, 8.0, 'SGP', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'dd2d4190-414d-5b05-afce-454ae3cb1aaf';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Ian Goh', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 2.0, NULL, true, '(2.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 5.0, NULL, true, '(5.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 2.0, NULL, false, '2.0');

  -- Competitor Rank 2: Tiago Cheng De Villemor Salgado (222437, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tiago Cheng De Villemor Salgado')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Tiago Cheng De Villemor Salgado')) OR lower(trim(alias_name)) = lower(trim('Tiago Cheng De Villemor Salgado')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tiago Cheng De Villemor Salgado', 'ilca4-hkg-tiago-cheng-de-villemor-salgado-222437', 'N/A', '222437', '222437', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '222437') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '50196111-74c0-5d32-b76e-dc7d80320b7a';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Tiago Cheng De Villemor Salgado', '222437', 'individual',
    2, 17.0, 10.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'e5faf441-7e52-5d3d-99d2-71ade794b92d';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Tiago Cheng De Villemor Salgado', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 3.0, NULL, true, '(3.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 4.0, NULL, true, '(4.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 1.0, NULL, false, '1.0');

  -- Competitor Rank 3: Ethan Chia (228368, SGP)
  v_sailor_id := '156283b1-fac6-48ba-a530-bd5a78d77114';
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Ethan Chia')) OR lower(trim(alias_name)) = lower(trim('Ethan Chia')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ethan Chia', 'ilca4-sgp-ethan-chia-228368', 'N/A', '228368', '228368', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '228368') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'b3fba67a-aa24-525e-90ac-97834fe926e6';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Ethan Chia', '228368', 'individual',
    3, 80.0, 21.0, 'SGP', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'f0057697-060a-535f-87cc-da8378641c15';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Ethan Chia', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 50.0, 'UFD', true, '(50.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 9.0, NULL, true, '(9.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 3.0, NULL, false, '3.0');

  -- Competitor Rank 4: Austin Yeo (221062, SGP)
  v_sailor_id := 'd7ce117b-5c64-40ea-86bd-79a7a73bb833';
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Austin Yeo')) OR lower(trim(alias_name)) = lower(trim('Austin Yeo')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Austin Yeo', 'ilca4-sgp-austin-yeo-221062', 'N/A', '221062', '221062', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '221062') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'ad3346dc-7055-5419-8ebf-fb6748ff76c2';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Austin Yeo', '221062', 'individual',
    4, 48.0, 24.0, 'SGP', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '7645b381-e2eb-5de6-8a1b-e6bfced19241';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Austin Yeo', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 16.0, NULL, true, '(16.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 8.0, NULL, true, '(8.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 5.0, NULL, false, '5.0');

  -- Competitor Rank 5: Zachary Wong (221061, SGP)
  v_sailor_id := 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a';
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Zachary Wong')) OR lower(trim(alias_name)) = lower(trim('Zachary Wong')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zachary Wong', 'ilca4-sgp-zachary-wong-221061', 'N/A', '221061', '221061', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '221061') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'cf798327-031a-5e95-ac49-e32ce4ad0d80';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Zachary Wong', '221061', 'individual',
    5, 48.0, 27.0, 'SGP', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'eb715a6a-b871-5793-acf5-03d1cb19bee6';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Zachary Wong', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 13.0, NULL, true, '(13.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 8.0, NULL, true, '(8.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 6.0, NULL, false, '6.0');

  -- Competitor Rank 6: Zixi Huang (221400, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zixi Huang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Zixi Huang')) OR lower(trim(alias_name)) = lower(trim('Zixi Huang')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zixi Huang', 'ilca4-hkg-zixi-huang-221400', 'N/A', '221400', '221400', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '221400') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'e4527c24-e42a-551d-ab87-f15c9268b1a1';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Zixi Huang', '221400', 'individual',
    6, 41.0, 29.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'ce4682a1-c37a-54cd-b232-55862f2c749c';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Zixi Huang', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 6.0, NULL, true, '(6.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 6.0, NULL, true, '(6.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 4.0, NULL, false, '4.0');

  -- Competitor Rank 7: Cyrus Yung (215277, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cyrus Yung')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Cyrus Yung')) OR lower(trim(alias_name)) = lower(trim('Cyrus Yung')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cyrus Yung', 'ilca4-hkg-cyrus-yung-215277', 'N/A', '215277', '215277', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '215277') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'd4c98ee4-e412-59b3-a728-a6efe0e09dda';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Cyrus Yung', '215277', 'individual',
    7, 61.0, 38.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '7a7bec84-86a8-59ee-a4f6-46369c3f8940';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Cyrus Yung', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 13.0, NULL, true, '(13.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 10.0, NULL, true, '(10.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 8.0, NULL, false, '8.0');

  -- Competitor Rank 8: Nia Zahedi (224245, SGP)
  v_sailor_id := '20af3d01-7d86-4111-bad1-0c2be026e039';
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Nia Zahedi')) OR lower(trim(alias_name)) = lower(trim('Nia Zahedi')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nia Zahedi', 'ilca4-sgp-nia-zahedi-224245', 'N/A', '224245', '224245', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '224245') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '1a203215-f782-5fa7-93e4-3f384caf4cd1';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Nia Zahedi', '224245', 'individual',
    8, 75.0, 49.0, 'SGP', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '485b5492-6517-543b-8c8a-f4dc26457735';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Nia Zahedi', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 11.0, NULL, true, '(11.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 15.0, NULL, true, '(15.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 9.0, NULL, false, '9.0');

  -- Competitor Rank 9: Gabi Oh (222743, SGP)
  v_sailor_id := 'ee4ffc51-2ad1-46fd-85d1-0d100676840f';
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Gabi Oh')) OR lower(trim(alias_name)) = lower(trim('Gabi Oh')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gabi Oh', 'ilca4-sgp-gabi-oh-222743', 'N/A', '222743', '222743', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '222743') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'd9cc5535-9a6e-5f3b-94c8-9753b2e17b53';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Gabi Oh', '222743', 'individual',
    9, 76.0, 50.0, 'SGP', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '86fcab29-f94f-54e6-8282-aa2c25c352b8';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Gabi Oh', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 12.0, NULL, true, '(12.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 14.0, NULL, true, '(14.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 7.0, NULL, false, '7.0');

  -- Competitor Rank 10: Mika Tew (227461, SGP)
  v_sailor_id := 'bf1de4cb-9dd4-426d-a9e1-a669f7e091d9';
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Mika Tew')) OR lower(trim(alias_name)) = lower(trim('Mika Tew')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mika Tew', 'ilca4-sgp-mika-tew-227461', 'N/A', '227461', '227461', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '227461') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '08559585-d92c-5cf8-b7fa-935adcab611d';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Mika Tew', '227461', 'individual',
    10, 88.0, 51.0, 'SGP', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '3f36712d-87a6-5c0c-a3a5-2cef8fb028b3';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Mika Tew', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 24.0, NULL, true, '(24.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 13.0, NULL, true, '(13.0)');

  -- Competitor Rank 11: Ivy So (209310, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ivy So')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Ivy So')) OR lower(trim(alias_name)) = lower(trim('Ivy So')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ivy So', 'ilca4-hkg-ivy-so-209310', 'N/A', '209310', '209310', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '209310') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '0ce1a3ee-123d-5245-a8ca-16f80ea88413';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Ivy So', '209310', 'individual',
    11, 88.0, 55.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'c60d7cea-07db-52da-89a0-387a33d4bdc4';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Ivy So', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 14.0, NULL, true, '(14.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 19.0, NULL, true, '(19.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 14.0, NULL, false, '14.0');

  -- Competitor Rank 12: Jonathan Zeppezauer (215308, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jonathan Zeppezauer')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jonathan  Zeppezauer')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Jonathan Zeppezauer')) OR lower(trim(alias_name)) = lower(trim('Jonathan  Zeppezauer')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jonathan Zeppezauer', 'ilca4-hkg-jonathan-zeppezauer-215308', 'N/A', '215308', '215308', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '215308') WHERE id = v_sailor_id;
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Jonathan  Zeppezauer')
  ON CONFLICT (alias_name) DO NOTHING;
  v_res_id := 'fd3a32ae-9273-52c5-81df-23f49d0f07b3';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Jonathan  Zeppezauer', '215308', 'individual',
    12, 106.0, 67.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '6d26ab38-815b-5ff5-9613-18caa2dc5d53';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Jonathan  Zeppezauer', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 18.0, NULL, true, '(18.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 18.0, NULL, false, '18.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 21.0, NULL, true, '(21.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 13.0, NULL, false, '13.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 12.0, NULL, false, '12.0');

  -- Competitor Rank 13: Howan Luo (210425, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Howan Luo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Howan Luo')) OR lower(trim(alias_name)) = lower(trim('Howan Luo')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Howan Luo', 'ilca4-hkg-howan-luo-210425', 'N/A', '210425', '210425', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '210425') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '56172c7f-80c6-56d2-a1c9-36e8b376f51c';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Howan Luo', '210425', 'individual',
    13, 158.0, 72.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'b6a54306-10c0-5aeb-97ee-da4281ab3eb7';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Howan Luo', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 13.0, NULL, false, '13.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 50.0, 'DNS', true, '(50.0 DNS)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 36.0, NULL, true, '(36.0)');

  -- Competitor Rank 14: Jolin Zheng (209319, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jolin Zheng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Jolin Zheng')) OR lower(trim(alias_name)) = lower(trim('Jolin Zheng')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jolin Zheng', 'ilca4-hkg-jolin-zheng-209319', 'N/A', '209319', '209319', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '209319') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '5aff8209-22a7-5668-8743-09786e4124c0';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Jolin Zheng', '209319', 'individual',
    14, 107.0, 72.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '72732d3b-e594-5ee1-bc54-0f23b9463fa3';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Jolin Zheng', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 13.0, NULL, false, '13.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 18.0, NULL, true, '(18.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 17.0, NULL, true, '(17.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 11.0, NULL, false, '11.0');

  -- Competitor Rank 15: Jorge Wong (215482, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jorge Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Jorge Wong')) OR lower(trim(alias_name)) = lower(trim('Jorge Wong')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jorge Wong', 'ilca4-hkg-jorge-wong-215482', 'N/A', '215482', '215482', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '215482') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '8b042763-973e-5d82-b4f9-0987554e661c';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Jorge Wong', '215482', 'individual',
    15, 145.0, 75.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'c0b07455-1454-5898-a52e-1bb515965837';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Jorge Wong', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 20.0, NULL, true, '(20.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 19.0, NULL, false, '19.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 13.0, NULL, false, '13.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 50.0, 'BFD', true, '(50.0 BFD)');

  -- Competitor Rank 16: Nicholette Lee (224620, SGP)
  v_sailor_id := '37d98dd9-3749-45ce-8195-c1b9cce74f60';
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Nicholette Lee')) OR lower(trim(alias_name)) = lower(trim('Nicholette Lee')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nicholette Lee', 'ilca4-sgp-nicholette-lee-224620', 'N/A', '224620', '224620', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '224620') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '1041d6ce-273b-5b36-a86f-de83de945b08';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Nicholette Lee', '224620', 'individual',
    16, 125.0, 85.0, 'SGP', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '37441a8b-fda4-5383-8693-e60ef6403d47';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Nicholette Lee', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 18.0, NULL, true, '(18.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 22.0, NULL, true, '(22.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 10.0, NULL, false, '10.0');

  -- Competitor Rank 17: Thomas Ko (211709, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Thomas Ko')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Thomas Ko')) OR lower(trim(alias_name)) = lower(trim('Thomas Ko')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Thomas Ko', 'ilca4-hkg-thomas-ko-211709', 'N/A', '211709', '211709', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '211709') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'c3113eca-5d4e-5f7b-89b7-c32ccca8427a';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Thomas Ko', '211709', 'individual',
    17, 124.0, 85.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '5b4bf5e9-c6e7-5210-b52e-0eb103d6a52b';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Thomas Ko', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 19.0, NULL, true, '(19.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 20.0, NULL, true, '(20.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 19.0, NULL, false, '19.0');

  -- Competitor Rank 18: Ela Murat (205828, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ela Murat')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Ela Murat')) OR lower(trim(alias_name)) = lower(trim('Ela Murat')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ela Murat', 'ilca4-hkg-ela-murat-205828', 'N/A', '205828', '205828', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '205828') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '9604ca87-a88b-5e9e-b09b-e18d3ac5b556';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Ela Murat', '205828', 'individual',
    18, 150.0, 102.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '08f0f0f7-7c4f-5a72-883a-0e416ccca6b6';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Ela Murat', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 19.0, NULL, false, '19.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 24.0, NULL, true, '(24.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 24.0, NULL, true, '(24.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 18.0, NULL, false, '18.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 15.0, NULL, false, '15.0');

  -- Competitor Rank 19: Desiree Lee (226897, SGP)
  v_sailor_id := '7a1b19c2-78a8-414c-8acf-a6dc6f7fb617';
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Desiree Lee')) OR lower(trim(alias_name)) = lower(trim('Desiree Lee')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Desiree Lee', 'ilca4-sgp-desiree-lee-226897', 'N/A', '226897', '226897', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '226897') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '7e956b8b-89c6-5131-b9c7-f90779ced3ec';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Desiree Lee', '226897', 'individual',
    19, 165.0, 110.0, 'SGP', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '4ceba196-514c-505f-9324-7fb7776351d8';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Desiree Lee', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 25.0, NULL, true, '(25.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 30.0, NULL, true, '(30.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 18.0, NULL, false, '18.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 17.0, NULL, false, '17.0');

  -- Competitor Rank 20: CongGuo Huang (225502, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('CongGuo Huang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('CongGuo Huang')) OR lower(trim(alias_name)) = lower(trim('CongGuo Huang')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'CongGuo Huang', 'ilca4-chn-congguo-huang-225502', 'N/A', '225502', '225502', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '225502') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '50c475d4-a7ce-5199-a67e-c6c9c7577363';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'CongGuo Huang', '225502', 'individual',
    20, 187.0, 110.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'be798aae-856a-5c6a-bff7-d3b9702e9e29';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'CongGuo Huang', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 50.0, 'UFD', true, '(50.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 27.0, NULL, true, '(27.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 22.0, NULL, false, '22.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 22.0, NULL, false, '22.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 18.0, NULL, false, '18.0');

  -- Competitor Rank 21: Lyora Wallier (213316, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lyora Wallier')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Lyora Wallier')) OR lower(trim(alias_name)) = lower(trim('Lyora Wallier')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lyora Wallier', 'ilca4-hkg-lyora-wallier-213316', 'N/A', '213316', '213316', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '213316') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '53d95186-9090-5dd0-b1ab-b3c58c7ce61f';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Lyora Wallier', '213316', 'individual',
    21, 185.0, 120.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '7eb7c97c-571c-52a5-b7f8-ccb58ab1b917';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Lyora Wallier', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 13.0, NULL, false, '13.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 35.0, NULL, true, '(35.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 22.0, NULL, false, '22.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 19.0, NULL, false, '19.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 25.0, NULL, false, '25.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 30.0, NULL, true, '(30.0)');

  -- Competitor Rank 22: Yuk Jun Lim (225182, SGP)
  v_sailor_id := '26414c39-ffe4-417d-aabc-a577d6355fd5';
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Yuk Jun Lim')) OR lower(trim(alias_name)) = lower(trim('Yuk Jun Lim')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuk Jun Lim', 'ilca4-sgp-yuk-jun-lim-225182', 'N/A', '225182', '225182', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '225182') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'fc577b09-14ea-5285-8cc4-f322f3a2f23e';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Yuk Jun Lim', '225182', 'individual',
    22, 169.0, 120.0, 'SGP', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'e6e10495-155b-5573-8ce4-4f91f7551398';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Yuk Jun Lim', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 24.0, NULL, true, '(24.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 22.0, NULL, false, '22.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 25.0, NULL, true, '(25.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 20.0, NULL, false, '20.0');

  -- Competitor Rank 23: Marcus Li (213348, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Marcus Li')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Marcus Li')) OR lower(trim(alias_name)) = lower(trim('Marcus Li')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Marcus Li', 'ilca4-hkg-marcus-li-213348', 'N/A', '213348', '213348', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '213348') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '4080a142-4c68-58b7-92f6-5bf53ea1439e';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Marcus Li', '213348', 'individual',
    23, 186.0, 123.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '874ed38a-1da5-51b9-8e3c-b558f2d7aeae';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Marcus Li', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 19.0, NULL, false, '19.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 24.0, NULL, false, '24.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 28.0, NULL, true, '(28.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 35.0, NULL, true, '(35.0)');

  -- Competitor Rank 24: Charles Kong (227676, SGP)
  v_sailor_id := 'aada8925-cb09-4adb-8bdc-c6b8c2d0a20d';
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Charles Kong')) OR lower(trim(alias_name)) = lower(trim('Charles Kong')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Charles Kong', 'ilca4-sgp-charles-kong-227676', 'N/A', '227676', '227676', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '227676') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '29f81e28-014d-5db7-ada7-c2a9f60c51c3';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Charles Kong', '227676', 'individual',
    24, 189.0, 125.0, 'SGP', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'bfdae0fe-0ca1-5f1f-9a2a-10c4dc95f72f';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Charles Kong', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 39.0, NULL, true, '(39.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 25.0, NULL, true, '(25.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 25.0, NULL, false, '25.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 24.0, NULL, false, '24.0');

  -- Competitor Rank 25: Chun Yin Yip (211740, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Chun Yin Yip')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Chun Yin Yip')) OR lower(trim(alias_name)) = lower(trim('Chun Yin Yip')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Chun Yin Yip', 'ilca4-hkg-chun-yin-yip-211740', 'N/A', '211740', '211740', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '211740') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '5c064438-4350-58b6-b1ab-9c938a4725ab';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Chun Yin Yip', '211740', 'individual',
    25, 205.0, 140.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '954522c9-b8de-51ea-b44b-33bd815600ea';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Chun Yin Yip', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 24.0, NULL, false, '24.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 22.0, NULL, false, '22.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 30.0, NULL, true, '(30.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 28.0, NULL, false, '28.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 28.0, NULL, false, '28.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 35.0, NULL, true, '(35.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 21.0, NULL, false, '21.0');

  -- Competitor Rank 26: Gianna Ho (215141, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gianna Ho')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Gianna Ho')) OR lower(trim(alias_name)) = lower(trim('Gianna Ho')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gianna Ho', 'ilca4-hkg-gianna-ho-215141', 'N/A', '215141', '215141', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '215141') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'af35f12d-b49e-52dd-87db-2932fdd75fba';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Gianna Ho', '215141', 'individual',
    26, 229.0, 146.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '3322d1ed-0344-5513-9e60-8cb389e15ca3';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Gianna Ho', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 25.0, NULL, false, '25.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 50.0, 'DNF', true, '(50.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 19.0, NULL, false, '19.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 33.0, NULL, true, '(33.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 28.0, NULL, false, '28.0');

  -- Competitor Rank 27: Sophie Shao (215314, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sophie Shao')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Sophie Shao')) OR lower(trim(alias_name)) = lower(trim('Sophie Shao')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sophie Shao', 'ilca4-hkg-sophie-shao-215314', 'N/A', '215314', '215314', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '215314') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '55463abb-95e4-5f8e-b046-04cc3309715e';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Sophie Shao', '215314', 'individual',
    27, 254.0, 154.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '355b77a9-b669-5adf-be1d-c54b16d20f68';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Sophie Shao', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 34.0, NULL, false, '34.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 28.0, NULL, false, '28.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 50.0, 'DNF', true, '(50.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 25.0, NULL, false, '25.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 18.0, NULL, false, '18.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 50.0, 'BFD', true, '(50.0 BFD)');

  -- Competitor Rank 28: Manchak Cheung (190912, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Manchak Cheung')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Manchak Cheung')) OR lower(trim(alias_name)) = lower(trim('Manchak Cheung')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Manchak Cheung', 'ilca4-hkg-manchak-cheung-190912', 'N/A', '190912', '190912', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '190912') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'e40010f3-a63e-561a-beb9-fea1375fec2a';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Manchak Cheung', '190912', 'individual',
    28, 265.0, 165.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '26de8922-b961-5c44-80c4-5ca79b64d9fd';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Manchak Cheung', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 50.0, 'UFD', true, '(50.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 24.0, NULL, false, '24.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 50.0, 'DNC', true, '(50.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 50.0, 'DNC', false, '50.0 DNC');

  -- Competitor Rank 29: Rheanne Faye Buitre (179862, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rheanne Faye Buitre')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Rheanne Faye Buitre')) OR lower(trim(alias_name)) = lower(trim('Rheanne Faye Buitre')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rheanne Faye Buitre', 'ilca4-hkg-rheanne-faye-buitre-179862', 'N/A', '179862', '179862', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '179862') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '4945b568-e140-52df-8654-f0dd8cde5bad';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Rheanne Faye Buitre', '179862', 'individual',
    29, 252.0, 166.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '837fb651-d2e1-5146-9e49-8c6d86973c4c';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Rheanne Faye Buitre', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 36.0, NULL, true, '(36.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 30.0, NULL, false, '30.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 28.0, NULL, false, '28.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 50.0, 'DSQ', true, '(50.0 DSQ)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 30.0, NULL, false, '30.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 26.0, NULL, false, '26.0');

  -- Competitor Rank 30: John Dwyer (184018, JPN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('John Dwyer')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('John Dwyer')) OR lower(trim(alias_name)) = lower(trim('John Dwyer')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'John Dwyer', 'ilca4-jpn-john-dwyer-184018', 'N/A', '184018', '184018', 'JPN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '184018') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'b7a8501b-9de0-554f-9c18-1cdea8b01a8f';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'John Dwyer', '184018', 'individual',
    30, 246.0, 174.0, 'JPN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '6704b027-7798-5ef7-a1c5-bdddb3d0f578';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'John Dwyer', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 33.0, NULL, false, '33.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 33.0, NULL, false, '33.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 29.0, NULL, false, '29.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 36.0, NULL, true, '(36.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 36.0, NULL, true, '(36.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 29.0, NULL, false, '29.0');

  -- Competitor Rank 31: Ariel Li (209947, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ariel Li')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Ariel Li')) OR lower(trim(alias_name)) = lower(trim('Ariel Li')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ariel Li', 'ilca4-hkg-ariel-li-209947', 'N/A', '209947', '209947', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '209947') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '29d1527d-f95f-58e1-9085-a8891427a9c9';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Ariel Li', '209947', 'individual',
    31, 275.0, 175.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'c98a8f5c-2c44-559a-a310-6f8f38e23e81';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Ariel Li', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 30.0, NULL, false, '30.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 32.0, NULL, false, '32.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 50.0, 'DNC', true, '(50.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 50.0, 'DNC', true, '(50.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 50.0, 'DNC', false, '50.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 16.0, NULL, false, '16.0');

  -- Competitor Rank 32: Alterf Kwong Ching Tse (211715, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Alterf Kwong Ching Tse')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Alterf Kwong Ching Tse')) OR lower(trim(alias_name)) = lower(trim('Alterf Kwong Ching Tse')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Alterf Kwong Ching Tse', 'ilca4-hkg-alterf-kwong-ching-tse-211715', 'N/A', '211715', '211715', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '211715') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'ba45373f-e313-5321-868e-bebe6ebb2fa4';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Alterf Kwong Ching Tse', '211715', 'individual',
    32, 242.0, 175.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'd2908647-1b56-58cc-92fd-8e37af388b52';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Alterf Kwong Ching Tse', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 31.0, NULL, false, '31.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 34.0, NULL, true, '(34.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 30.0, NULL, false, '30.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 31.0, NULL, false, '31.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 31.0, NULL, false, '31.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 33.0, NULL, true, '(33.0)');

  -- Competitor Rank 33: Christian Sallons (228287, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Christian Sallons')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Christian Sallons')) OR lower(trim(alias_name)) = lower(trim('Christian Sallons')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Christian Sallons', 'ilca4-hkg-christian-sallons-228287', 'N/A', '228287', '228287', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '228287') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '311791f7-fe28-526f-a716-c808b75a7978';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Christian Sallons', '228287', 'individual',
    33, 267.0, 187.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'f6d30744-a927-5d7d-9a98-8c2f7d755488';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Christian Sallons', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 29.0, NULL, false, '29.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 34.0, NULL, false, '34.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 37.0, NULL, false, '37.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 31.0, NULL, false, '31.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 34.0, NULL, false, '34.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 40.0, NULL, true, '(40.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 40.0, NULL, true, '(40.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 22.0, NULL, false, '22.0');

  -- Competitor Rank 34: Dani Van Olphen (213234, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Dani Van Olphen')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Dani Van Olphen')) OR lower(trim(alias_name)) = lower(trim('Dani Van Olphen')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Dani Van Olphen', 'ilca4-hkg-dani-van-olphen-213234', 'N/A', '213234', '213234', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '213234') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'd902b71e-6304-5ab4-83e3-d3a980d82272';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Dani Van Olphen', '213234', 'individual',
    34, 283.0, 191.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '66d77838-c3c2-50af-b9bc-10d7eedc2b86';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Dani Van Olphen', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 28.0, NULL, false, '28.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 35.0, NULL, false, '35.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 50.0, 'DNF', true, '(50.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 28.0, NULL, false, '28.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 39.0, NULL, false, '39.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 29.0, NULL, false, '29.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 42.0, NULL, true, '(42.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 32.0, NULL, false, '32.0');

  -- Competitor Rank 35: Charlie Cheung (213357, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Charlie Cheung')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Charlie Cheung')) OR lower(trim(alias_name)) = lower(trim('Charlie Cheung')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Charlie Cheung', 'ilca4-hkg-charlie-cheung-213357', 'N/A', '213357', '213357', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '213357') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'e3dae9aa-ecd8-50ee-bfd7-7204a25fbb52';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Charlie Cheung', '213357', 'individual',
    35, 300.0, 200.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '93497b8e-d599-5e3a-a9ac-8262a047615e';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Charlie Cheung', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 50.0, 'DSQ', true, '(50.0 DSQ)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 50.0, 'DNF', true, '(50.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 50.0, 'DNS', false, '50.0 DNS');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 38.0, NULL, false, '38.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 32.0, NULL, false, '32.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 29.0, NULL, false, '29.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 25.0, NULL, false, '25.0');

  -- Competitor Rank 36: Lap Him Cheung (211730, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lap Him Cheung')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Lap Him Cheung')) OR lower(trim(alias_name)) = lower(trim('Lap Him Cheung')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lap Him Cheung', 'ilca4-hkg-lap-him-cheung-211730', 'N/A', '211730', '211730', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '211730') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '2cf0138d-bf7a-5777-9852-39431bac7b97';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Lap Him Cheung', '211730', 'individual',
    36, 277.0, 200.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '4a731483-afa6-583e-8b3f-d6458000181f';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Lap Him Cheung', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 37.0, NULL, false, '37.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 38.0, NULL, true, '(38.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 38.0, NULL, false, '38.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 33.0, NULL, false, '33.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 31.0, NULL, false, '31.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 30.0, NULL, false, '30.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 39.0, NULL, true, '(39.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 31.0, NULL, false, '31.0');

  -- Competitor Rank 37: Stephen Donahue (215681, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Stephen Donahue')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Stephen Donahue')) OR lower(trim(alias_name)) = lower(trim('Stephen Donahue')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Stephen Donahue', 'ilca4-hkg-stephen-donahue-215681', 'N/A', '215681', '215681', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '215681') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '0a6f05c7-12e2-56c3-883f-19b66cc668c0';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Stephen Donahue', '215681', 'individual',
    37, 301.0, 201.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '767fc69f-e2c1-5f17-a9d7-95ac268e8219';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Stephen Donahue', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 50.0, 'UFD', true, '(50.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 31.0, NULL, false, '31.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 43.0, NULL, false, '43.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 29.0, NULL, false, '29.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 33.0, NULL, false, '33.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 38.0, NULL, false, '38.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 50.0, 'BFD', true, '(50.0 BFD)');

  -- Competitor Rank 38: Eldrad Lee (211691, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Eldrad Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Eldrad Lee')) OR lower(trim(alias_name)) = lower(trim('Eldrad Lee')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Eldrad Lee', 'ilca4-hkg-eldrad-lee-211691', 'N/A', '211691', '211691', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '211691') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'f521b8b3-c946-5f4c-9301-ced11dd1516d';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Eldrad Lee', '211691', 'individual',
    38, 294.0, 208.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'd6c22f57-acf7-5574-b0f8-e764350d2a3b';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Eldrad Lee', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 33.0, NULL, false, '33.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 40.0, NULL, false, '40.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 32.0, NULL, false, '32.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 42.0, NULL, true, '(42.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 41.0, NULL, false, '41.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 35.0, NULL, false, '35.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 44.0, NULL, true, '(44.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 27.0, NULL, false, '27.0');

  -- Competitor Rank 39: Tianmu Timothy Lin (209901, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tianmu Timothy Lin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Tianmu Timothy Lin')) OR lower(trim(alias_name)) = lower(trim('Tianmu Timothy Lin')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tianmu Timothy Lin', 'ilca4-hkg-tianmu-timothy-lin-209901', 'N/A', '209901', '209901', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '209901') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'a1fc77b5-2984-51fd-b6c0-5e8c8a561ec6';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Tianmu Timothy Lin', '209901', 'individual',
    39, 305.0, 210.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '0e192e0c-b3ef-56ad-a922-9e1ff55ac61c';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Tianmu Timothy Lin', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 31.0, NULL, false, '31.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 37.0, NULL, false, '37.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 36.0, NULL, false, '36.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 32.0, NULL, false, '32.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 50.0, 'UFD', true, '(50.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 34.0, NULL, false, '34.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 45.0, NULL, true, '(45.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 40.0, NULL, false, '40.0');

  -- Competitor Rank 40: Zirui Fan (224401, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zirui Fan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Zirui Fan')) OR lower(trim(alias_name)) = lower(trim('Zirui Fan')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zirui Fan', 'ilca4-chn-zirui-fan-224401', 'N/A', '224401', '224401', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '224401') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '90408cb9-bf1b-56b8-b6d7-095021428f95';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Zirui Fan', '224401', 'individual',
    40, 308.0, 215.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '463f2d55-5dfd-542c-bc14-409bb6725a5e';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Zirui Fan', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 22.0, NULL, false, '22.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 36.0, NULL, false, '36.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 50.0, 'DNC', true, '(50.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 35.0, NULL, false, '35.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 42.0, NULL, false, '42.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 39.0, NULL, false, '39.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 41.0, NULL, false, '41.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 43.0, NULL, true, '(43.0)');

  -- Competitor Rank 41: Dorian Olivares (224439, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Dorian Olivares')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Dorian Olivares')) OR lower(trim(alias_name)) = lower(trim('Dorian Olivares')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Dorian Olivares', 'ilca4-hkg-dorian-olivares-224439', 'N/A', '224439', '224439', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '224439') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'a988b554-db4e-5e55-bab5-e923b44a49ff';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Dorian Olivares', '224439', 'individual',
    41, 307.0, 216.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'b8ffa753-2fd0-586a-92b2-189a8b86dceb';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Dorian Olivares', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 40.0, NULL, false, '40.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 50.0, 'DNF', true, '(50.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 39.0, NULL, false, '39.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 41.0, NULL, true, '(41.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 35.0, NULL, false, '35.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 32.0, NULL, false, '32.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 32.0, NULL, false, '32.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 38.0, NULL, false, '38.0');

  -- Competitor Rank 42: Carine Leung (215131, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Carine Leung')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Carine Leung')) OR lower(trim(alias_name)) = lower(trim('Carine Leung')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Carine Leung', 'ilca4-hkg-carine-leung-215131', 'N/A', '215131', '215131', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '215131') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'f325027f-e55d-5b13-b15b-ebfb482f4f62';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Carine Leung', '215131', 'individual',
    42, 296.0, 216.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '1cbb849a-f2a7-5de4-85b1-0fe80e59f1a1';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Carine Leung', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 39.0, NULL, true, '(39.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 41.0, NULL, true, '(41.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 34.0, NULL, false, '34.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 37.0, NULL, false, '37.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 38.0, NULL, false, '38.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 37.0, NULL, false, '37.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 36.0, NULL, false, '36.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 34.0, NULL, false, '34.0');

  -- Competitor Rank 43: Ryley Man (213329, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ryley Man')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Ryley Man')) OR lower(trim(alias_name)) = lower(trim('Ryley Man')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ryley Man', 'ilca4-hkg-ryley-man-213329', 'N/A', '213329', '213329', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '213329') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '44dd1e2c-5efd-5746-b6f1-8fef5dd837b6';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Ryley Man', '213329', 'individual',
    43, 328.0, 228.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '0bf59bc0-bc7d-5011-9ffb-809abb8707a8';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Ryley Man', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 35.0, NULL, false, '35.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 42.0, NULL, false, '42.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 50.0, 'DNC', true, '(50.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 40.0, NULL, false, '40.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 50.0, 'RET', true, '(50.0 RET)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 38.0, NULL, false, '38.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 34.0, NULL, false, '34.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 39.0, NULL, false, '39.0');

  -- Competitor Rank 44: Jarvis Wong (215480, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jarvis Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Jarvis Wong')) OR lower(trim(alias_name)) = lower(trim('Jarvis Wong')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jarvis Wong', 'ilca4-hkg-jarvis-wong-215480', 'N/A', '215480', '215480', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '215480') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '31aab5c8-1220-57c4-9ba1-6b684eb7f973';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Jarvis Wong', '215480', 'individual',
    44, 337.0, 237.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'b8b504ce-2855-53f3-8e53-3140ae8b2b70';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Jarvis Wong', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 38.0, NULL, false, '38.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 29.0, NULL, false, '29.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 29.0, NULL, false, '29.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 50.0, 'DNC', true, '(50.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 50.0, 'DNC', true, '(50.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 50.0, 'DNC', false, '50.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 50.0, 'NSC', false, '50.0 NSC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 41.0, NULL, false, '41.0');

  -- Competitor Rank 45: Allan McDonald (213300, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Allan McDonald')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Allan McDonald')) OR lower(trim(alias_name)) = lower(trim('Allan McDonald')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Allan McDonald', 'ilca4-hkg-allan-mcdonald-213300', 'N/A', '213300', '213300', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '213300') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '39ebbdb0-e509-5860-b010-c30ec79d9fed';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Allan McDonald', '213300', 'individual',
    45, 346.0, 246.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '171b017a-052c-58bd-aeac-5fd810b16d53';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Allan McDonald', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 32.0, NULL, false, '32.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 50.0, 'DNF', true, '(50.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 50.0, 'RET', true, '(50.0 RET)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 36.0, NULL, false, '36.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 37.0, NULL, false, '37.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 41.0, NULL, false, '41.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 50.0, 'DNC', false, '50.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 50.0, 'DNC', false, '50.0 DNC');

  -- Competitor Rank 46: Pak Man Chan (205264, MAC)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Pak Man Chan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Pak Man Chan')) OR lower(trim(alias_name)) = lower(trim('Pak Man Chan')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Pak Man Chan', 'ilca4-mac-pak-man-chan-205264', 'N/A', '205264', '205264', 'MAC', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '205264') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '66355bd0-0295-523d-9f95-7cc6aaed5b97';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Pak Man Chan', '205264', 'individual',
    46, 357.0, 257.0, 'MAC', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '60ddeb7f-6f03-52be-8261-18372ea658b3';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Pak Man Chan', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 50.0, 'DNF', true, '(50.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 50.0, 'DNS', true, '(50.0 DNS)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 50.0, 'DNC', false, '50.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 39.0, NULL, false, '39.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 50.0, 'DNF', false, '50.0 DNF');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 43.0, NULL, false, '43.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 33.0, NULL, false, '33.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 42.0, NULL, false, '42.0');

  -- Competitor Rank 47: Elaine Dong (211688, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elaine Dong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Elaine Dong')) OR lower(trim(alias_name)) = lower(trim('Elaine Dong')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elaine Dong', 'ilca4-hkg-elaine-dong-211688', 'N/A', '211688', '211688', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '211688') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '3b6e77e3-eeef-576b-9e90-f8e48e45e516';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Elaine Dong', '211688', 'individual',
    47, 360.0, 260.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '75cf6378-6355-5e3b-ae63-8dcddd672214';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Elaine Dong', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 50.0, 'DNC', true, '(50.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 50.0, 'DNC', true, '(50.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 50.0, 'DNC', false, '50.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 50.0, 'DNC', false, '50.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 50.0, 'DNC', false, '50.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 50.0, 'DNC', false, '50.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 37.0, NULL, false, '37.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 23.0, NULL, false, '23.0');

  -- Competitor Rank 48: Jake Wang (209948, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jake Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Jake Wang')) OR lower(trim(alias_name)) = lower(trim('Jake Wang')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jake Wang', 'ilca4-hkg-jake-wang-209948', 'N/A', '209948', '209948', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '209948') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '7b194e86-464e-5318-a815-b73aaecfbd67';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Jake Wang', '209948', 'individual',
    48, 362.0, 262.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '5a79fd9f-5371-50c7-8fce-32d2d190a89f';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Jake Wang', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 50.0, 'DNC', true, '(50.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 50.0, 'DNC', true, '(50.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 50.0, 'DNC', false, '50.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 44.0, NULL, false, '44.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 43.0, NULL, false, '43.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 42.0, NULL, false, '42.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 46.0, NULL, false, '46.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 37.0, NULL, false, '37.0');

  -- Competitor Rank 49: Quentin Tran (213211, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Quentin Tran')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Quentin Tran')) OR lower(trim(alias_name)) = lower(trim('Quentin Tran')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Quentin Tran', 'ilca4-hkg-quentin-tran-213211', 'N/A', '213211', '213211', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '213211') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'a35c6014-623e-5406-ab58-0f99f7b7b71a';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca', 'Quentin Tran', '213211', 'individual',
    49, 366.0, 266.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2026/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2026 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '96f6dfe5-262e-547d-bdef-a6b4eebbdeda';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Quentin Tran', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 50.0, 'DNF', true, '(50.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 50.0, 'DNF', true, '(50.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 50.0, 'DNC', false, '50.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 45.0, NULL, false, '45.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 40.0, NULL, false, '40.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 44.0, NULL, false, '44.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 43.0, NULL, false, '43.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 44.0, NULL, false, '44.0');

  -- ==========================================================================
  -- Hong Kong Race Week 2025 (ILCA 4) (50 competitors)
  -- ==========================================================================
  -- Competitor Rank 1: Charalampos Velianitis (220790, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Charalampos Velianitis')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Charalampos VELIANITIS')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Charalampos Velianitis')) OR lower(trim(alias_name)) = lower(trim('Charalampos VELIANITIS')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Charalampos Velianitis', 'ilca4-hkg-charalampos-velianitis-220790', 'N/A', '220790', '220790', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '220790') WHERE id = v_sailor_id;
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Charalampos VELIANITIS')
  ON CONFLICT (alias_name) DO NOTHING;
  v_res_id := '6a1dbe45-31df-5de4-984f-9a8ff24533bb';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Charalampos VELIANITIS', '220790', 'individual',
    1, 18.0, 9.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '1c43b9e8-5f7d-5f38-8410-50de18865b98';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Charalampos VELIANITIS', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 3.0, NULL, true, '(3.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 6.0, NULL, true, '(6.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 1.0, NULL, false, '1.0');

  -- Competitor Rank 2: Torn Rattana (221947, THA)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Torn Rattana')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Torn RATTANA')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Torn Rattana')) OR lower(trim(alias_name)) = lower(trim('Torn RATTANA')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Torn Rattana', 'ilca4-tha-torn-rattana-221947', 'N/A', '221947', '221947', 'THA', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '221947') WHERE id = v_sailor_id;
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Torn RATTANA')
  ON CONFLICT (alias_name) DO NOTHING;
  v_res_id := '31d214ea-f890-598a-a9e0-8e3f9df61ded';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Torn RATTANA', '221947', 'individual',
    2, 78.0, 19.0, 'THA', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'b1c10e0b-b7ad-5bf9-92f3-91148dd8d459';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Torn RATTANA', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 51.0, 'DSQ', true, '(51.0 DSQ)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 8.0, NULL, true, '(8.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 2.0, NULL, false, '2.0');

  -- Competitor Rank 3: Zixi Huang (221400, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zixi Huang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Zixi Huang')) OR lower(trim(alias_name)) = lower(trim('Zixi Huang')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zixi Huang', 'ilca4-hkg-zixi-huang-221400', 'N/A', '221400', '221400', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '221400') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'e365c450-d373-5033-adc5-ef066c6df619';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Zixi Huang', '221400', 'individual',
    3, 38.0, 22.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '7a2821b2-4b80-50ff-a114-16d5e7613864';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Zixi Huang', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 6.0, NULL, true, '(6.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 10.0, NULL, true, '(10.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 5.0, NULL, false, '5.0');

  -- Competitor Rank 4: Cyrus Yung (215277, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cyrus Yung')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Cyrus Yung')) OR lower(trim(alias_name)) = lower(trim('Cyrus Yung')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cyrus Yung', 'ilca4-hkg-cyrus-yung-215277', 'N/A', '215277', '215277', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '215277') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '34ad594f-d5de-5843-a34d-9af235ec3bf7';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Cyrus Yung', '215277', 'individual',
    4, 45.0, 24.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'c4b65564-ce49-54a0-aa87-46da42bf6c1d';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Cyrus Yung', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 6.0, NULL, true, '(6.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 15.0, NULL, true, '(15.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 3.0, NULL, false, '3.0');

  -- Competitor Rank 5: Che Liu (216831, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Che Liu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Che LIU')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Che Liu')) OR lower(trim(alias_name)) = lower(trim('Che LIU')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Che Liu', 'ilca4-chn-che-liu-216831', 'N/A', '216831', '216831', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '216831') WHERE id = v_sailor_id;
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Che LIU')
  ON CONFLICT (alias_name) DO NOTHING;
  v_res_id := '43a1d116-f078-5376-b050-755b8229ab27';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Che LIU', '216831', 'individual',
    5, 45.0, 25.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'd2e00381-2b80-5028-9a93-4935d572a512';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Che LIU', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 10.0, NULL, true, '(10.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 10.0, NULL, true, '(10.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 4.0, NULL, false, '4.0');

  -- Competitor Rank 6: Jorge Wong (215482, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jorge Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Jorge Wong')) OR lower(trim(alias_name)) = lower(trim('Jorge Wong')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jorge Wong', 'ilca4-hkg-jorge-wong-215482', 'N/A', '215482', '215482', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '215482') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '3ca5848a-9c83-5504-9458-ed31e5bb4407';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Jorge Wong', '215482', 'individual',
    6, 87.0, 51.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '835553f2-f18d-5610-97d8-f2c03ffe40d2';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Jorge Wong', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 24.0, NULL, true, '(24.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 12.0, NULL, true, '(12.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 6.0, NULL, false, '6.0');

  -- Competitor Rank 7: Howan Luo (210425, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Howan Luo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Howan Luo')) OR lower(trim(alias_name)) = lower(trim('Howan Luo')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Howan Luo', 'ilca4-hkg-howan-luo-210425', 'N/A', '210425', '210425', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '210425') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '7cbcbb8f-c6c4-5949-8b7e-147eb848a9d8';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Howan Luo', '210425', 'individual',
    7, 92.0, 54.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '0f6e8ad0-1d51-50e0-a674-12c339d21149';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Howan Luo', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 14.0, 'RDG', true, '(14.0 RDG)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 24.0, NULL, true, '(24.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 8.0, NULL, false, '8.0');

  -- Competitor Rank 8: Jason Lin (210325, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jason Lin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Jason Lin')) OR lower(trim(alias_name)) = lower(trim('Jason Lin')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jason Lin', 'ilca4-chn-jason-lin-210325', 'N/A', '210325', '210325', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '210325') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '8cb6ad0c-a394-5761-99e8-76ebdf1dc478';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Jason Lin', '210325', 'individual',
    8, 93.0, 54.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'bcb64dc5-1ed8-532a-a7fb-b5c7208bf5be';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Jason Lin', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 18.0, NULL, true, '(18.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 21.0, NULL, true, '(21.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 10.0, NULL, false, '10.0');

  -- Competitor Rank 9: Yinran Chen (214494, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yinran Chen')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Yinran Chen')) OR lower(trim(alias_name)) = lower(trim('Yinran Chen')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yinran Chen', 'ilca4-chn-yinran-chen-214494', 'N/A', '214494', '214494', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '214494') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'a1f76192-aa6b-5da1-b5d4-133462f0dfbf';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Yinran Chen', '214494', 'individual',
    9, 88.0, 59.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'd977fd4d-7b70-5e10-9811-470217a1d196';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Yinran Chen', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 13.0, NULL, false, '13.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 15.0, NULL, true, '(15.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 13.0, NULL, false, '13.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 14.0, NULL, true, '(14.0)');

  -- Competitor Rank 10: Congguo Huang (225502, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Congguo Huang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('CONGGUO Huang')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Congguo Huang')) OR lower(trim(alias_name)) = lower(trim('CONGGUO Huang')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Congguo Huang', 'ilca4-chn-congguo-huang-225502', 'N/A', '225502', '225502', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '225502') WHERE id = v_sailor_id;
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'CONGGUO Huang')
  ON CONFLICT (alias_name) DO NOTHING;
  v_res_id := 'd9a0683d-a524-594a-bff6-47238432e10d';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'CONGGUO Huang', '225502', 'individual',
    10, 122.0, 70.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'd712ec38-1f58-535e-90c7-fd651c8a30d5';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'CONGGUO Huang', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 30.0, NULL, true, '(30.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 22.0, NULL, true, '(22.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 13.0, NULL, false, '13.0');

  -- Competitor Rank 11: Avelino Shin (209902, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Avelino Shin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Avelino SHIN')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Avelino Shin')) OR lower(trim(alias_name)) = lower(trim('Avelino SHIN')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Avelino Shin', 'ilca4-hkg-avelino-shin-209902', 'N/A', '209902', '209902', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '209902') WHERE id = v_sailor_id;
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Avelino SHIN')
  ON CONFLICT (alias_name) DO NOTHING;
  v_res_id := '72eb03fd-d42a-50d1-ba1a-bb331014fbfc';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Avelino SHIN', '209902', 'individual',
    11, 129.0, 71.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '33fb5536-af6c-5e66-8b1e-f8e2eb6a3e24';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Avelino SHIN', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 25.0, NULL, true, '(25.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 33.0, NULL, true, '(33.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 16.0, NULL, false, '16.0');

  -- Competitor Rank 12: Thomas Ko (211709, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Thomas Ko')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Thomas Ko')) OR lower(trim(alias_name)) = lower(trim('Thomas Ko')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Thomas Ko', 'ilca4-hkg-thomas-ko-211709', 'N/A', '211709', '211709', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '211709') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '4d316471-53bf-52b6-9b04-8b2b91927b5d';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Thomas Ko', '211709', 'individual',
    12, 110.0, 77.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '34143564-9438-5478-a912-eaa6e5075599';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Thomas Ko', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 13.0, NULL, false, '13.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 17.0, NULL, true, '(17.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 16.0, NULL, true, '(16.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 12.0, NULL, false, '12.0');

  -- Competitor Rank 13: Guo Chen (229200, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Guo Chen')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Guo Chen')) OR lower(trim(alias_name)) = lower(trim('Guo Chen')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Guo Chen', 'ilca4-chn-guo-chen-229200', 'N/A', '229200', '229200', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '229200') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'c1031aab-7d91-5afb-b2fe-400aa8b23e3a';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Guo Chen', '229200', 'individual',
    13, 125.0, 79.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '7b703922-af6d-5371-98e9-0a056f2cac29';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Guo Chen', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 20.0, NULL, true, '(20.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 26.0, NULL, true, '(26.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 13.0, NULL, false, '13.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 7.0, NULL, false, '7.0');

  -- Competitor Rank 14: Ivy So (209310, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ivy So')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Ivy So')) OR lower(trim(alias_name)) = lower(trim('Ivy So')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ivy So', 'ilca4-hkg-ivy-so-209310', 'N/A', '209310', '209310', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '209310') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'ac442195-9a57-5f8d-b590-335f973d31d2';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Ivy So', '209310', 'individual',
    14, 135.0, 93.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'ba92b753-7551-55cd-9854-a9987d9bd061';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Ivy So', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 21.0, NULL, true, '(21.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 21.0, NULL, true, '(21.0)');

  -- Competitor Rank 15: Yufei Chen (210816, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yufei Chen')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Yufei Chen')) OR lower(trim(alias_name)) = lower(trim('Yufei Chen')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yufei Chen', 'ilca4-chn-yufei-chen-210816', 'N/A', '210816', '210816', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '210816') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'b04f731a-6ff1-5c2e-bf1a-1e3331b81bd2';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Yufei Chen', '210816', 'individual',
    15, 170.0, 96.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'f5b80ec8-8e4d-5961-a1c3-72391721ebaa';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Yufei Chen', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 43.0, NULL, true, '(43.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 31.0, NULL, true, '(31.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 18.0, NULL, false, '18.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 19.0, NULL, false, '19.0');

  -- Competitor Rank 16: Joe Cai (214493, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joe Cai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Joe Cai')) OR lower(trim(alias_name)) = lower(trim('Joe Cai')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joe Cai', 'ilca4-chn-joe-cai-214493', 'N/A', '214493', '214493', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '214493') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '2452cb19-5935-55b9-bf49-192e31f1f0f1';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Joe Cai', '214493', 'individual',
    16, 143.0, 98.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '5ea7e04b-5f5d-596f-b62d-6c01302c3aca';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Joe Cai', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 21.0, NULL, true, '(21.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 18.0, NULL, false, '18.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 24.0, NULL, true, '(24.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 13.0, NULL, false, '13.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 18.0, NULL, false, '18.0');

  -- Competitor Rank 17: Marcus Li (213348, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Marcus Li')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Marcus LI')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Marcus Li')) OR lower(trim(alias_name)) = lower(trim('Marcus LI')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Marcus Li', 'ilca4-hkg-marcus-li-213348', 'N/A', '213348', '213348', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '213348') WHERE id = v_sailor_id;
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Marcus LI')
  ON CONFLICT (alias_name) DO NOTHING;
  v_res_id := '469c6159-5dcc-50a6-bd44-e447c16f10f5';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Marcus LI', '213348', 'individual',
    17, 163.0, 109.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '9f2bc04a-fd86-539a-af41-d40efd3de583';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Marcus LI', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 13.0, NULL, false, '13.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 13.0, NULL, false, '13.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 22.0, NULL, false, '22.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 29.0, NULL, true, '(29.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 25.0, NULL, true, '(25.0)');

  -- Competitor Rank 18: Boxuan Yu (223620, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Boxuan Yu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Boxuan Yu')) OR lower(trim(alias_name)) = lower(trim('Boxuan Yu')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Boxuan Yu', 'ilca4-chn-boxuan-yu-223620', 'N/A', '223620', '223620', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '223620') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '6658a91a-3e0a-5f49-b905-fa500e2968fc';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Boxuan Yu', '223620', 'individual',
    18, 166.0, 114.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '7bbd0f0d-1cb8-5b47-83cc-1d04331b7a9b';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Boxuan Yu', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 24.0, NULL, true, '(24.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 18.0, NULL, false, '18.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 18.0, NULL, false, '18.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 28.0, NULL, true, '(28.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 19.0, NULL, false, '19.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 9.0, NULL, false, '9.0');

  -- Competitor Rank 19: Reyes Jit Eng Tan (214251, SGP)
  v_sailor_id := 'f268697a-ceb4-483a-8a53-9c5241f3f0cc';
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Reyes Jit Eng Tan')) OR lower(trim(alias_name)) = lower(trim('Reyes Jit Eng Tan')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Reyes Jit Eng Tan', 'ilca4-sgp-reyes-jit-eng-tan-214251', 'N/A', '214251', '214251', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '214251') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '06182eea-f0d0-576c-a9db-124e04debd21';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Reyes Jit Eng Tan', '214251', 'individual',
    19, 174.0, 116.0, 'SGP', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '24ddcfc6-63dc-54a2-8f2d-2fd64993c2a1';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Reyes Jit Eng Tan', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 26.0, NULL, true, '(26.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 32.0, NULL, true, '(32.0)');

  -- Competitor Rank 20: Wang Nina (221551, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Wang Nina')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Wang Nina')) OR lower(trim(alias_name)) = lower(trim('Wang Nina')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Wang Nina', 'ilca4-chn-wang-nina-221551', 'N/A', '221551', '221551', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '221551') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '0fd1d701-d736-5618-9890-9abd625632ec';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Wang Nina', '221551', 'individual',
    20, 175.0, 117.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '3ba2cd4f-37b2-5814-8497-e5a47eb1c86b';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Wang Nina', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 22.0, NULL, false, '22.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 19.0, NULL, false, '19.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 31.0, NULL, true, '(31.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 27.0, NULL, true, '(27.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 15.0, NULL, false, '15.0');

  -- Competitor Rank 21: Ela Murat (205828, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ela Murat')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Ela Murat')) OR lower(trim(alias_name)) = lower(trim('Ela Murat')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ela Murat', 'ilca4-hkg-ela-murat-205828', 'N/A', '205828', '205828', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '205828') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '7d05a608-4ca5-5bd7-9fa6-49246e78e8d7';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Ela Murat', '205828', 'individual',
    21, 171.0, 122.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '3d920675-bd00-5c65-aaaf-f1b82e12240b';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Ela Murat', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 19.0, NULL, false, '19.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 25.0, NULL, true, '(25.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 19.0, NULL, false, '19.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 18.0, NULL, false, '18.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 24.0, NULL, true, '(24.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 19.0, NULL, false, '19.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 17.0, NULL, false, '17.0');

  -- Competitor Rank 22: Xu Xiaorong (221877, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Xu Xiaorong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Xu Xiaorong')) OR lower(trim(alias_name)) = lower(trim('Xu Xiaorong')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Xu Xiaorong', 'ilca4-chn-xu-xiaorong-221877', 'N/A', '221877', '221877', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '221877') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'd292b171-26e7-53ad-bb59-952abe957f2c';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Xu Xiaorong', '221877', 'individual',
    22, 238.0, 136.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'fd06f7fe-4e65-5255-91f9-f0dad139faf5';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Xu Xiaorong', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 25.0, NULL, false, '25.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 51.0, 'UFD', true, '(51.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 51.0, 'RET', true, '(51.0 RET)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 24.0, NULL, false, '24.0');

  -- Competitor Rank 23: Qinghua Hu (214467, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Qinghua Hu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Qinghua Hu')) OR lower(trim(alias_name)) = lower(trim('Qinghua Hu')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Qinghua Hu', 'ilca4-chn-qinghua-hu-214467', 'N/A', '214467', '214467', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '214467') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'a4ec1515-14af-51b9-a190-f12b3c86662a';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Qinghua Hu', '214467', 'individual',
    23, 219.0, 156.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'e67ab68d-d869-5e39-b6e3-21ca345e66da';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Qinghua Hu', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 22.0, NULL, false, '22.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 22.0, NULL, false, '22.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 29.0, NULL, true, '(29.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 29.0, NULL, false, '29.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 34.0, NULL, true, '(34.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 22.0, NULL, false, '22.0');

  -- Competitor Rank 24: Yifan Han (221313, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yifan Han')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Yifan Han')) OR lower(trim(alias_name)) = lower(trim('Yifan Han')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yifan Han', 'ilca4-chn-yifan-han-221313', 'N/A', '221313', '221313', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '221313') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'f4fac926-9157-577e-9268-e8fc6428123d';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Yifan Han', '221313', 'individual',
    24, 217.0, 157.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'fc28e7c4-5e41-5da4-ad37-30845de767b8';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Yifan Han', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 18.0, NULL, false, '18.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 28.0, NULL, true, '(28.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 32.0, NULL, true, '(32.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 18.0, NULL, false, '18.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 26.0, NULL, false, '26.0');

  -- Competitor Rank 25: Jin Song Zhang (223600, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jin Song Zhang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Jin Song Zhang')) OR lower(trim(alias_name)) = lower(trim('Jin Song Zhang')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jin Song Zhang', 'ilca4-chn-jin-song-zhang-223600', 'N/A', '223600', '223600', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '223600') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'dfaac630-a0e2-5f6a-b69c-ea44c097be1e';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Jin Song Zhang', '223600', 'individual',
    25, 225.0, 159.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'a5e4b973-80e5-589f-8d96-c6dfe698db5b';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Jin Song Zhang', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 19.0, NULL, false, '19.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 22.0, NULL, false, '22.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 28.0, NULL, true, '(28.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 25.0, NULL, false, '25.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 38.0, NULL, true, '(38.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 23.0, NULL, false, '23.0');

  -- Competitor Rank 26: Yilin Elaine Dong (211688, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yilin Elaine Dong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yilin Elaine  DONG')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Yilin Elaine Dong')) OR lower(trim(alias_name)) = lower(trim('Yilin Elaine  DONG')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yilin Elaine Dong', 'ilca4-hkg-yilin-elaine-dong-211688', 'N/A', '211688', '211688', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '211688') WHERE id = v_sailor_id;
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Yilin Elaine  DONG')
  ON CONFLICT (alias_name) DO NOTHING;
  v_res_id := '6dfcafce-0a96-5f87-9ee5-da1b5114eb3b';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Yilin Elaine  DONG', '211688', 'individual',
    26, 232.0, 165.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '03fef1dc-1c16-5180-9b28-ff416d2868c2';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Yilin Elaine  DONG', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 31.0, NULL, true, '(31.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 36.0, NULL, true, '(36.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 28.0, NULL, false, '28.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 22.0, NULL, false, '22.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 30.0, NULL, false, '30.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 20.0, NULL, false, '20.0');

  -- Competitor Rank 27: JiaLe Yang (220808, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('JiaLe Yang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('JiaLe Yang')) OR lower(trim(alias_name)) = lower(trim('JiaLe Yang')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'JiaLe Yang', 'ilca4-chn-jiale-yang-220808', 'N/A', '220808', '220808', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '220808') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '464f6d52-3929-5fb6-a97b-7c9182f5c840';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'JiaLe Yang', '220808', 'individual',
    27, 239.0, 170.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '2d0aa49f-923c-59c9-b40e-ab436146af0e';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'JiaLe Yang', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 25.0, NULL, false, '25.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 32.0, NULL, false, '32.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 19.0, NULL, false, '19.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 32.0, NULL, false, '32.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 36.0, NULL, true, '(36.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 33.0, NULL, true, '(33.0)');

  -- Competitor Rank 28: Cheryl Shen (214466, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cheryl Shen')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Cheryl Shen')) OR lower(trim(alias_name)) = lower(trim('Cheryl Shen')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cheryl Shen', 'ilca4-hkg-cheryl-shen-214466', 'N/A', '214466', '214466', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '214466') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '7e562e46-f27b-55c6-a2b5-3a45381945e8';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Cheryl Shen', '214466', 'individual',
    28, 245.0, 172.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '5cedcdcc-2679-579a-bc1b-3e64686b111b';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Cheryl Shen', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 29.0, NULL, false, '29.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 35.0, NULL, true, '(35.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 31.0, NULL, false, '31.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 32.0, NULL, false, '32.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 38.0, NULL, true, '(38.0)');

  -- Competitor Rank 29: Zhuowen Sophie Shao (191718, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zhuowen Sophie Shao')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Zhuowen Sophie Shao')) OR lower(trim(alias_name)) = lower(trim('Zhuowen Sophie Shao')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zhuowen Sophie Shao', 'ilca4-hkg-zhuowen-sophie-shao-191718', 'N/A', '191718', '191718', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '191718') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'e4097892-5528-5991-a286-4d02646f1d0e';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Zhuowen Sophie Shao', '191718', 'individual',
    29, 243.0, 177.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'dec2c861-4787-5abd-b13d-7939f2a757a5';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Zhuowen Sophie Shao', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 29.0, NULL, false, '29.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 31.0, NULL, true, '(31.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 25.0, NULL, false, '25.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 35.0, NULL, true, '(35.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 25.0, NULL, false, '25.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 24.0, NULL, false, '24.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 30.0, NULL, false, '30.0');

  -- Competitor Rank 30: Wong Tsz Lung (211703, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Wong Tsz Lung')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Wong Tsz Lung')) OR lower(trim(alias_name)) = lower(trim('Wong Tsz Lung')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Wong Tsz Lung', 'ilca4-hkg-wong-tsz-lung-211703', 'N/A', '211703', '211703', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '211703') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '2d6af361-ce6e-5759-9079-2eb28a9431dd';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Wong Tsz Lung', '211703', 'individual',
    30, 260.0, 178.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '1803719d-1b61-5c89-98a8-766cdefc8665';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Wong Tsz Lung', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 28.0, NULL, false, '28.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 24.0, NULL, false, '24.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 30.0, NULL, false, '30.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 24.0, NULL, false, '24.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 51.0, 'DSQ', true, '(51.0 DSQ)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 28.0, NULL, false, '28.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 31.0, NULL, true, '(31.0)');

  -- Competitor Rank 31: Charlie Cheung (213350, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Charlie Cheung')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Charlie Cheung')) OR lower(trim(alias_name)) = lower(trim('Charlie Cheung')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Charlie Cheung', 'ilca4-hkg-charlie-cheung-213350', 'N/A', '213350', '213350', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '213350') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '64a12690-6bdd-526a-a4f0-0e05247e0992';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Charlie Cheung', '213350', 'individual',
    31, 249.0, 181.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '90125371-cd8c-5129-ae9c-bf927a19ea35';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Charlie Cheung', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 32.0, NULL, false, '32.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 34.0, NULL, true, '(34.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 34.0, NULL, true, '(34.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 33.0, NULL, false, '33.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 19.0, NULL, false, '19.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 31.0, NULL, false, '31.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 28.0, NULL, false, '28.0');

  -- Competitor Rank 32: John Raphael Lim (206799, SGP)
  v_sailor_id := '6bc22d30-b06a-4e64-86a9-f4cb99535f33';
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('John Raphael Lim')) OR lower(trim(alias_name)) = lower(trim('John Raphael Lim')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'John Raphael Lim', 'ilca4-sgp-john-raphael-lim-206799', 'N/A', '206799', '206799', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '206799') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '4eebe3fa-1988-53f6-8b30-348945ec28c3';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'John Raphael Lim', '206799', 'individual',
    32, 255.0, 188.0, 'SGP', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'f477b5d9-777f-5a5d-9142-e622369e5ead';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'John Raphael Lim', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 33.0, NULL, true, '(33.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 32.0, NULL, false, '32.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 31.0, NULL, false, '31.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 30.0, NULL, false, '30.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 34.0, NULL, true, '(34.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 30.0, NULL, false, '30.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 13.0, NULL, false, '13.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 29.0, NULL, false, '29.0');

  -- Competitor Rank 33: Yong Liang Chuang (221094, TPE)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yong Liang Chuang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('YONG LIANG Chuang')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Yong Liang Chuang')) OR lower(trim(alias_name)) = lower(trim('YONG LIANG Chuang')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yong Liang Chuang', 'ilca4-tpe-yong-liang-chuang-221094', 'N/A', '221094', '221094', 'TPE', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '221094') WHERE id = v_sailor_id;
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'YONG LIANG Chuang')
  ON CONFLICT (alias_name) DO NOTHING;
  v_res_id := '81a5d285-dd17-54a4-ad5e-0f9c91e57778';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'YONG LIANG Chuang', '221094', 'individual',
    33, 300.0, 198.0, 'TPE', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'ea84fe5c-218f-5ab1-a563-f894e88d65a1';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'YONG LIANG Chuang', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 30.0, NULL, false, '30.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 33.0, NULL, false, '33.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 51.0, 'DNS', true, '(51.0 DNS)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 51.0, 'DNC', true, '(51.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 11.0, NULL, false, '11.0');

  -- Competitor Rank 34: ShaYue Wu (221204, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('ShaYue Wu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('ShaYue WU')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('ShaYue Wu')) OR lower(trim(alias_name)) = lower(trim('ShaYue WU')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'ShaYue Wu', 'ilca4-chn-shayue-wu-221204', 'N/A', '221204', '221204', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '221204') WHERE id = v_sailor_id;
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'ShaYue WU')
  ON CONFLICT (alias_name) DO NOTHING;
  v_res_id := '72bdbe2e-a2c5-5b66-b004-e087b2bced24';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'ShaYue WU', '221204', 'individual',
    34, 294.0, 214.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'c1b699f3-05de-5c74-aee9-c8dc907fdac0';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'ShaYue WU', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 39.0, NULL, true, '(39.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 29.0, NULL, false, '29.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 37.0, NULL, false, '37.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 28.0, NULL, false, '28.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 29.0, NULL, false, '29.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 36.0, NULL, false, '36.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 28.0, NULL, false, '28.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 41.0, NULL, true, '(41.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 27.0, NULL, false, '27.0');

  -- Competitor Rank 35: Sai Kit Tse (211740, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sai Kit Tse')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Sai Kit Tse')) OR lower(trim(alias_name)) = lower(trim('Sai Kit Tse')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sai Kit Tse', 'ilca4-hkg-sai-kit-tse-211740', 'N/A', '211740', '211740', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '211740') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '3be4be2a-3577-5d53-baae-8725ff304f6b';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Sai Kit Tse', '211740', 'individual',
    35, 293.0, 220.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '41abbb2b-6353-57f6-a6e7-eb08c15bf3c6';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Sai Kit Tse', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 36.0, NULL, true, '(36.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 37.0, NULL, true, '(37.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 35.0, NULL, false, '35.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 32.0, NULL, false, '32.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 33.0, NULL, false, '33.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 22.0, NULL, false, '22.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 33.0, NULL, false, '33.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 30.0, NULL, false, '30.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 35.0, NULL, false, '35.0');

  -- Competitor Rank 36: Cyrus Chan (213329, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cyrus Chan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Cyrus Chan')) OR lower(trim(alias_name)) = lower(trim('Cyrus Chan')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cyrus Chan', 'ilca4-hkg-cyrus-chan-213329', 'N/A', '213329', '213329', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '213329') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '4deea9b9-c70d-5cb6-9e1f-63ca26569629';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Cyrus Chan', '213329', 'individual',
    36, 298.0, 220.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '5bdfa93c-7ee4-5829-8013-946effdae632';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Cyrus Chan', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 34.0, NULL, false, '34.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 38.0, NULL, true, '(38.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 40.0, NULL, true, '(40.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 34.0, NULL, false, '34.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 34.0, NULL, false, '34.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 33.0, NULL, false, '33.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 25.0, NULL, false, '25.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 34.0, NULL, false, '34.0');

  -- Competitor Rank 37: Ryan Cheung (209318, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ryan Cheung')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Ryan Cheung')) OR lower(trim(alias_name)) = lower(trim('Ryan Cheung')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ryan Cheung', 'ilca4-hkg-ryan-cheung-209318', 'N/A', '209318', '209318', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '209318') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '2fbd86ad-5693-5727-9831-9c72a7c121ec';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Ryan Cheung', '209318', 'individual',
    37, 301.0, 227.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '60f50eb5-6764-5f18-9b35-912947d85901';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Ryan Cheung', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 35.0, NULL, false, '35.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 33.0, NULL, false, '33.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 32.0, NULL, false, '32.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 29.0, NULL, false, '29.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 37.0, NULL, true, '(37.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 36.0, NULL, false, '36.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 37.0, NULL, true, '(37.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 36.0, NULL, false, '36.0');

  -- Competitor Rank 38: ZhiRen Luo (220078, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('ZhiRen Luo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('ZhiRen LUO')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('ZhiRen Luo')) OR lower(trim(alias_name)) = lower(trim('ZhiRen LUO')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'ZhiRen Luo', 'ilca4-chn-zhiren-luo-220078', 'N/A', '220078', '220078', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '220078') WHERE id = v_sailor_id;
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'ZhiRen LUO')
  ON CONFLICT (alias_name) DO NOTHING;
  v_res_id := 'b24857f9-7e85-5362-bf2b-e3c10991a761';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'ZhiRen LUO', '220078', 'individual',
    38, 334.0, 232.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '98fff5fc-76c5-51b6-b583-1453d5740470';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'ZhiRen LUO', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 30.0, NULL, false, '30.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 35.0, NULL, false, '35.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 51.0, 'DNF', true, '(51.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 51.0, 'DNF', true, '(51.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 38.0, NULL, false, '38.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 34.0, NULL, false, '34.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 35.0, NULL, false, '35.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 37.0, NULL, false, '37.0');

  -- Competitor Rank 39: ShengXuan Cheng (220428, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('ShengXuan Cheng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('ShengXuan CHENG')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('ShengXuan Cheng')) OR lower(trim(alias_name)) = lower(trim('ShengXuan CHENG')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'ShengXuan Cheng', 'ilca4-chn-shengxuan-cheng-220428', 'N/A', '220428', '220428', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '220428') WHERE id = v_sailor_id;
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'ShengXuan CHENG')
  ON CONFLICT (alias_name) DO NOTHING;
  v_res_id := 'd9366446-38ba-5c12-a9a5-d81e579c2bed';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'ShengXuan CHENG', '220428', 'individual',
    39, 346.0, 263.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '25a2f0dd-821f-5270-873d-3419e9f5335c';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'ShengXuan CHENG', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 38.0, NULL, false, '38.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 39.0, NULL, false, '39.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 36.0, NULL, false, '36.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 37.0, NULL, false, '37.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 39.0, NULL, false, '39.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 37.0, NULL, false, '37.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 37.0, NULL, false, '37.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 43.0, NULL, true, '(43.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 40.0, NULL, true, '(40.0)');

  -- Competitor Rank 40: YaKun Xu (226328, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('YaKun Xu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('YaKun XU')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('YaKun Xu')) OR lower(trim(alias_name)) = lower(trim('YaKun XU')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'YaKun Xu', 'ilca4-chn-yakun-xu-226328', 'N/A', '226328', '226328', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '226328') WHERE id = v_sailor_id;
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'YaKun XU')
  ON CONFLICT (alias_name) DO NOTHING;
  v_res_id := '03ab53b9-f0bb-57f4-b07a-2cc6bb93f503';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'YaKun XU', '226328', 'individual',
    40, 359.0, 267.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '0c590593-d2c1-5aac-be49-27db0db87717';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'YaKun XU', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 37.0, NULL, false, '37.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 40.0, NULL, false, '40.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 41.0, NULL, true, '(41.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 36.0, NULL, false, '36.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 36.0, NULL, false, '36.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 51.0, 'DNF', true, '(51.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 39.0, NULL, false, '39.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 40.0, NULL, false, '40.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 39.0, NULL, false, '39.0');

  -- Competitor Rank 41: Yuxuan Liu (211722, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuxuan Liu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Yuxuan Liu')) OR lower(trim(alias_name)) = lower(trim('Yuxuan Liu')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuxuan Liu', 'ilca4-chn-yuxuan-liu-211722', 'N/A', '211722', '211722', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '211722') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '5b54fbf4-d4e3-596d-9e70-a08b82075a4a';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Yuxuan Liu', '211722', 'individual',
    41, 366.0, 273.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '11552251-09a0-56a1-a440-14dcadf487c3';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Yuxuan Liu', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 40.0, NULL, false, '40.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 51.0, 'RET', true, '(51.0 RET)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 38.0, NULL, false, '38.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 35.0, NULL, false, '35.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 41.0, NULL, false, '41.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 38.0, NULL, false, '38.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 40.0, NULL, false, '40.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 42.0, NULL, true, '(42.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 41.0, NULL, false, '41.0');

  -- Competitor Rank 42: YiFan Liu (220821, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('YiFan Liu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('YiFan LIU')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('YiFan Liu')) OR lower(trim(alias_name)) = lower(trim('YiFan LIU')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'YiFan Liu', 'ilca4-chn-yifan-liu-220821', 'N/A', '220821', '220821', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '220821') WHERE id = v_sailor_id;
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'YiFan LIU')
  ON CONFLICT (alias_name) DO NOTHING;
  v_res_id := '62f6a36b-cb1d-5f3c-8de4-860393344373';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'YiFan LIU', '220821', 'individual',
    42, 379.0, 277.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '43960c12-38af-5b9b-ab8a-f8bb8ea7bc33';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'YiFan LIU', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 41.0, NULL, false, '41.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 41.0, NULL, false, '41.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 39.0, NULL, false, '39.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 51.0, 'DNC', true, '(51.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 40.0, NULL, false, '40.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 39.0, NULL, false, '39.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 38.0, NULL, false, '38.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 39.0, NULL, false, '39.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 51.0, 'NSC', true, '(51.0 NSC)');

  -- Competitor Rank 43: Yeuk Tung Heather Fang (211727, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yeuk Tung Heather Fang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Yeuk Tung Heather Fang')) OR lower(trim(alias_name)) = lower(trim('Yeuk Tung Heather Fang')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yeuk Tung Heather Fang', 'ilca4-hkg-yeuk-tung-heather-fang-211727', 'N/A', '211727', '211727', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '211727') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'b13276ce-cd71-5dea-90a8-3709c8912d91';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Yeuk Tung Heather Fang', '211727', 'individual',
    43, 414.0, 312.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '26a1efff-2730-5ad6-b6d0-4b258d12f228';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Yeuk Tung Heather Fang', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 44.0, NULL, false, '44.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 51.0, 'DNF', true, '(51.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 42.0, NULL, false, '42.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 51.0, 'DNF', true, '(51.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 31.0, NULL, false, '31.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 42.0, NULL, false, '42.0');

  -- Competitor Rank 44: ZeAn Li (220819, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('ZeAn Li')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('ZeAn LI')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('ZeAn Li')) OR lower(trim(alias_name)) = lower(trim('ZeAn LI')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'ZeAn Li', 'ilca4-chn-zean-li-220819', 'N/A', '220819', '220819', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '220819') WHERE id = v_sailor_id;
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'ZeAn LI')
  ON CONFLICT (alias_name) DO NOTHING;
  v_res_id := '7d29eacc-3078-5373-993a-2c758ce89490';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'ZeAn LI', '220819', 'individual',
    44, 418.0, 316.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'fd559815-60a0-5d3d-8ef7-e26ff48945f1';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'ZeAn LI', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 42.0, NULL, false, '42.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 42.0, NULL, false, '42.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 51.0, 'DNF', true, '(51.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 51.0, 'DNS', true, '(51.0 DNS)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 42.0, NULL, false, '42.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 51.0, 'DNF', false, '51.0 DNF');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 51.0, 'DNF', false, '51.0 DNF');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 44.0, NULL, false, '44.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 44.0, NULL, false, '44.0');

  -- Competitor Rank 45: YuLe Shi (220409, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('YuLe Shi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('YuLe SHI')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('YuLe Shi')) OR lower(trim(alias_name)) = lower(trim('YuLe SHI')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'YuLe Shi', 'ilca4-chn-yule-shi-220409', 'N/A', '220409', '220409', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '220409') WHERE id = v_sailor_id;
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'YuLe SHI')
  ON CONFLICT (alias_name) DO NOTHING;
  v_res_id := '38449175-1ea8-5c48-ba93-e4a0c06c22ea';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'YuLe SHI', '220409', 'individual',
    45, 421.0, 319.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'dc63238c-27eb-555d-817a-33f598cfdcc9';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'YuLe SHI', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 51.0, 'DNF', true, '(51.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 43.0, NULL, false, '43.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 51.0, 'DNF', true, '(51.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 51.0, 'DNF', false, '51.0 DNF');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 51.0, 'DNF', false, '51.0 DNF');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 51.0, 'DNF', false, '51.0 DNF');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 35.0, NULL, false, '35.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 45.0, NULL, false, '45.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 43.0, NULL, false, '43.0');

  -- Competitor Rank 46: Kellen Quek (121111, SGP)
  v_sailor_id := 'c39047d0-14dc-457e-a861-992d2b31fb89';
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Kellen Quek')) OR lower(trim(alias_name)) = lower(trim('Kellen Quek')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kellen Quek', 'ilca4-sgp-kellen-quek-121111', 'N/A', '121111', '121111', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '121111') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '0efa6c9d-eb2e-5542-bb7f-8039eb1c8038';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Kellen Quek', '121111', 'individual',
    46, 459.0, 357.0, 'SGP', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '3bef5769-4fc8-5c49-b174-c55d99d5dfce';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Kellen Quek', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 51.0, 'DNC', true, '(51.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 51.0, 'DNC', true, '(51.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 51.0, 'DNC', false, '51.0 DNC');

  -- Competitor Rank 46: Kai Storey (187010, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kai Storey')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Kai Storey')) OR lower(trim(alias_name)) = lower(trim('Kai Storey')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kai Storey', 'ilca4-hkg-kai-storey-187010', 'N/A', '187010', '187010', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '187010') WHERE id = v_sailor_id;
  END IF;
  v_res_id := 'b99ecbb9-14d0-58f0-b07f-098d8099b102';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Kai Storey', '187010', 'individual',
    46, 459.0, 357.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'd6bfb635-48df-5c42-acf2-3ab7bc46f42b';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Kai Storey', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 51.0, 'DNC', true, '(51.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 51.0, 'DNC', true, '(51.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 51.0, 'DNC', false, '51.0 DNC');

  -- Competitor Rank 46: ZiRui Fan (TBD, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('ZiRui Fan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('ZiRui FAN')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('ZiRui Fan')) OR lower(trim(alias_name)) = lower(trim('ZiRui FAN')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'ZiRui Fan', 'ilca4-chn-zirui-fan-tbd', 'N/A', 'TBD', 'TBD', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, 'TBD') WHERE id = v_sailor_id;
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'ZiRui FAN')
  ON CONFLICT (alias_name) DO NOTHING;
  v_res_id := '19fc405a-2c1a-5e43-9a2a-6a36b0bc7a16';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'ZiRui FAN', 'TBD', 'individual',
    46, 459.0, 357.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '17981044-5c0c-5e63-b9de-9367c15f56f4';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'ZiRui FAN', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 51.0, 'DNC', true, '(51.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 51.0, 'DNC', true, '(51.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 51.0, 'DNC', false, '51.0 DNC');

  -- Competitor Rank 46: Xi Wei (TBD, CHN)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Xi Wei')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Xi WEI')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Xi Wei')) OR lower(trim(alias_name)) = lower(trim('Xi WEI')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Xi Wei', 'ilca4-chn-xi-wei-tbd', 'N/A', 'TBD', 'TBD', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, 'TBD') WHERE id = v_sailor_id;
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Xi WEI')
  ON CONFLICT (alias_name) DO NOTHING;
  v_res_id := 'cb3dfad3-6e8e-5846-830d-a4e3049d0dd7';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Xi WEI', 'TBD', 'individual',
    46, 459.0, 357.0, 'CHN', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'f0e75ffd-1cd9-5617-b1ac-5348b1478168';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Xi WEI', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 51.0, 'DNC', true, '(51.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 51.0, 'DNC', true, '(51.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 51.0, 'DNC', false, '51.0 DNC');

  -- Competitor Rank 46: Tiago Cheng De Villemor Salgado (222437, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tiago Cheng De Villemor Salgado')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) = lower(trim('Tiago Cheng De Villemor Salgado')) OR lower(trim(alias_name)) = lower(trim('Tiago Cheng De Villemor Salgado')) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tiago Cheng De Villemor Salgado', 'ilca4-hkg-tiago-cheng-de-villemor-salgado-222437', 'N/A', '222437', '222437', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '222437') WHERE id = v_sailor_id;
  END IF;
  v_res_id := '1f4f1b51-452e-54ce-8b46-e378a79cb11e';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, 'f1c10dce-da8d-5517-a662-3806d02b929e', 'Tiago Cheng De Villemor Salgado', '222437', 'individual',
    46, 459.0, 357.0, 'HKG', false, false,
    'verified', 'https://www.rhkyc.org.hk/storage/app/media/Sailing/result/HONG-KONG-RACE-WEEK/2025/ILCA4.htm', 'Sun Hung Kai & Co. Hong Kong Race Week 2025 ILCA 4 Class Results', 'html',
    'Official final Sailwave results table hosted by Royal Hong Kong Yacht Club (RHKYC).', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '19c36977-b8de-5df6-a7a4-503fd9a37402';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Tiago Cheng De Villemor Salgado', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 51.0, 'DNC', true, '(51.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 51.0, 'DNC', true, '(51.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 51.0, 'DNC', false, '51.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 51.0, 'DNC', false, '51.0 DNC');

END $$;

-- 4. Admin Change Log
INSERT INTO public.admin_change_log (
    actor_email, action, entity_type, entity_id, entity_label, summary, details, source
) VALUES (
    'admin@sailorpath.com',
    'results.import_official_hong_kong_race_week_2025_2026_ilca4',
    'regattas',
    '327ad30e-2bf2-57d3-8d8f-1e86ca2b2aca',
    'Hong Kong Race Week 2026 & 2025 (ILCA 4)',
    'Imported official final Sailwave results for Hong Kong Race Week 2026 (49 boats, 8 races) and 2025 (50 boats, 9 races) from RHKYC.',
    '{"2026_fleet": 49, "2026_races": 8, "2025_fleet": 50, "2025_races": 9, "source": "RHKYC Official Sailwave Results"}'::jsonb,
    'rhkyc-official-import'
);

COMMIT;
