-- Migration 140: Import 2026 ILCA Asian Cup (Penghu) ILCA 4 Class Results
-- Corroboration Source: Chinese Taipei Sailing Association (CTSA) Official Final Results PDF
-- Event: March 19-24, 2026, Guanyinting Sailing Center, Magong City, Penghu, Chinese Taipei.
-- Class: ILCA 4 (37 competitors, 10 completed races, 1 discard).

BEGIN;

-- 1. Regatta Event
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    '0f127871-ef7b-522b-8e73-7a2c960e7e69',
    '2026 ILCA Asian Cup (Penghu)',
    '2026-ilca-asian-cup-penghu',
    '2026-03-19',
    '2026-03-24',
    'Guanyinting Sailing Center, Magong City, Penghu, Chinese Taipei',
    'Chinese Taipei Sailing Association & ILCA Asia',
    '["ILCA 4"]'::jsonb,
    false,
    false,
    '10 completed races over 4 racing days (March 19–24, 2026).',
    'Low Point System with 1 discard after 10 races (Appendix A).'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer,
    schedule_summary = EXCLUDED.schedule_summary;

-- 2. Regatta Class Sheet (ILCA 4)
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name
) VALUES (
    '9d4142bd-4fe9-5cc8-89ae-012d3bc10541',
    '0f127871-ef7b-522b-8e73-7a2c960e7e69',
    '2026 ILCA Asian Cup (ILCA 4)',
    '2026-ilca-asian-cup-ilca4',
    '2026-03-19',
    '2026-03-24',
    37,
    'Open',
    10,
    'TPE',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'Guanyinting Sailing Center, Magong City, Penghu, Chinese Taipei',
    'Chinese Taipei Sailing Association & ILCA Asia',
    'published',
    'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf',
    'Chinese Taipei Sailing Association (CTSA) Official Final Results PDF'
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count;

-- 3. Import Results and Resolve Sailors via PL/pgSQL block
DO $$
DECLARE
  v_sailor_id uuid;
  v_res_id uuid;
  v_part_id uuid;
BEGIN

  -- Competitor Rank 1: Ethan Chia (228368, SGP)
  v_sailor_id := '156283b1-fac6-48ba-a530-bd5a78d77114';

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Ethan CHIA')
  ON CONFLICT DO NOTHING;

  v_res_id := '92f122bb-4ede-507b-ace3-d4a9edeea4ec';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Ethan Chia', '228368', 'individual',
    1, 24.0, 19.0, 'SGP', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '67af5ea2-e1b2-5202-bbf2-69af4e2d6d96';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Ethan Chia', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 2.0, NULL, false, '2');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 5.0, NULL, true, '(5.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 2.0, NULL, false, '2');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 1.0, NULL, false, '1');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 2.0, NULL, false, '2');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 2.0, NULL, false, '2');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 2.0, NULL, false, '2');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 1.0, NULL, false, '1');

  -- Competitor Rank 2: Pinchanok Klaysomboon (222687, THA)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Pinchanok Klaysomboon')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Pinchanok Klaysomboon')), lower(trim('Pinchanok KLAYSOMBOON'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Pinchanok Klaysomboon', 'ilca4-tha-pinchanok-klaysomboon-222687', 'N/A', '222687', '222687', 'THA', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '222687') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Pinchanok KLAYSOMBOON')
  ON CONFLICT DO NOTHING;

  v_res_id := '7b00c90d-3526-574e-98e8-8de9791e72fc';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Pinchanok Klaysomboon', '222687', 'individual',
    2, 25.0, 21.0, 'THA', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'eb3e1209-92d3-5f42-8b88-b67db81201a2';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Pinchanok Klaysomboon', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 4.0, NULL, true, '(4.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 2.0, NULL, false, '2');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 2.0, NULL, false, '2');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 2.0, NULL, false, '2');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 2.0, NULL, false, '2');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 1.0, NULL, false, '1');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 3.0, NULL, false, '3');

  -- Competitor Rank 3: Ji Un Choi (223205, KOR)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ji Un Choi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Ji Un Choi')), lower(trim('Ji Un CHOI'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ji Un Choi', 'ilca4-kor-ji-un-choi-223205', 'N/A', '223205', '223205', 'KOR', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '223205') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Ji Un CHOI')
  ON CONFLICT DO NOTHING;

  v_res_id := '8dd00469-f07c-55c3-848a-084ac79060b4';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Ji Un Choi', '223205', 'individual',
    3, 42.0, 22.0, 'KOR', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '57467ca9-be0c-590b-a035-b04dbc653b4d';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Ji Un Choi', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 1.0, NULL, false, '1');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 1.0, NULL, false, '1');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 1.0, NULL, false, '1');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 1.0, NULL, false, '1');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 1.0, NULL, false, '1');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 20.0, 'UFD', true, '(20.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 4.0, NULL, false, '4');

  -- Competitor Rank 4: Yu-Kai Chen (222236, TPE)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yu-Kai Chen')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Yu-Kai Chen')), lower(trim('Yu-Kai CHEN'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yu-Kai Chen', 'ilca4-tpe-yu-kai-chen-222236', 'N/A', '222236', '222236', 'TPE', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '222236') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Yu-Kai CHEN')
  ON CONFLICT DO NOTHING;

  v_res_id := 'a0e88a7d-d2b6-56e4-9399-f37d4d3f6989';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Yu-Kai Chen', '222236', 'individual',
    4, 34.0, 28.0, 'TPE', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'd9809025-bd06-5836-a1b8-fe3a2b43701f';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Yu-Kai Chen', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 2.0, NULL, false, '2');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 6.0, NULL, true, '(6.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 1.0, NULL, false, '1');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 5.0, NULL, false, '5');

  -- Competitor Rank 5: Songha Lee (223204, KOR)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Songha Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Songha Lee')), lower(trim('Songha LEE'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Songha Lee', 'ilca4-kor-songha-lee-223204', 'N/A', '223204', '223204', 'KOR', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '223204') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Songha LEE')
  ON CONFLICT DO NOTHING;

  v_res_id := '9f51ac1b-2c11-5344-9c28-7a99e5e8a1e0';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Songha Lee', '223204', 'individual',
    5, 44.0, 36.0, 'KOR', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'a6fad988-6a14-5ad1-884e-995e3de50159';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Songha Lee', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 2.0, NULL, false, '2');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 2.0, NULL, false, '2');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 6.0, NULL, false, '6');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 8.0, NULL, true, '(8.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 6.0, NULL, false, '6');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 7.0, NULL, false, '7');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 6.0, NULL, false, '6');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 1.0, NULL, false, '1');

  -- Competitor Rank 6: Zeph Wan (226650, SGP)
  v_sailor_id := 'e178e8d4-02b8-470f-9235-4a451f5eb31a';

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Zeph WAN')
  ON CONFLICT DO NOTHING;

  v_res_id := 'd80e0117-bbe2-5518-b39a-05ec8b3752d4';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Zeph Wan', '226650', 'individual',
    6, 46.0, 36.0, 'SGP', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'b14e5dd3-1136-5e2c-b5e9-a4090c97987e';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Zeph Wan', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 10.0, NULL, true, '(10.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 8.0, NULL, false, '8');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 8.0, NULL, false, '8');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 1.0, NULL, false, '1');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 2.0, NULL, false, '2');

  -- Competitor Rank 7: Mika Tew (227461, SGP)
  v_sailor_id := 'bf1de4cb-9dd4-426d-a9e1-a669f7e091d9';

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Mika TEW')
  ON CONFLICT DO NOTHING;

  v_res_id := 'ddeacd13-efb6-5841-9426-08039a76d0be';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Mika Tew', '227461', 'individual',
    7, 45.0, 38.0, 'SGP', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '93462ad8-f8e1-5b0b-902b-5a4299b61275';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Mika Tew', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 6.0, NULL, false, '6');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 7.0, NULL, true, '(7.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 4.0, NULL, false, '4');

  -- Competitor Rank 8: Nicholette Lee (224620, SGP)
  v_sailor_id := '37d98dd9-3749-45ce-8195-c1b9cce74f60';

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Nicholette Wee Wen LEE')
  ON CONFLICT DO NOTHING;

  v_res_id := 'ad1d5c60-08d4-5043-92a1-8a49fa6a3dac';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Nicholette Lee', '224620', 'individual',
    8, 48.0, 39.0, 'SGP', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '55ab9402-8a46-5478-a0d2-07c2507a6f17';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Nicholette Lee', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 6.0, NULL, false, '6');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 9.0, NULL, true, '(9.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 1.0, NULL, false, '1');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 1.0, NULL, false, '1');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 1.0, NULL, false, '1');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 8.0, NULL, false, '8');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 7.0, NULL, false, '7');

  -- Competitor Rank 9: Desiree Lee (226897, SGP)
  v_sailor_id := '7a1b19c2-78a8-414c-8acf-a6dc6f7fb617';

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Desiree LEE')
  ON CONFLICT DO NOTHING;

  v_res_id := 'cf4aeec0-9d61-5251-9467-aa738e6625ae';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Desiree Lee', '226897', 'individual',
    9, 49.0, 39.0, 'SGP', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'e2f2fa21-50d8-5ebd-894c-ed26b6676d88';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Desiree Lee', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 8.0, NULL, false, '8');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 6.0, NULL, false, '6');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 10.0, NULL, true, '(10.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 1.0, NULL, false, '1');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 1.0, NULL, false, '1');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 5.0, NULL, false, '5');

  -- Competitor Rank 10: Ashlea Tham (228468, SGP)
  v_sailor_id := '90b36217-ca95-4a90-b8f3-a502537842ab';

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Ashlea THAM')
  ON CONFLICT DO NOTHING;

  v_res_id := '6999c39d-7592-5cfe-b200-59372d02ee39';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Ashlea Tham', '228468', 'individual',
    10, 51.0, 40.0, 'SGP', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '334fd5e8-d462-5fbb-a256-de0d3c622576';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Ashlea Tham', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 11.0, NULL, true, '(11.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 7.0, NULL, false, '7');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 9.0, NULL, false, '9');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 2.0, NULL, false, '2');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 6.0, NULL, false, '6');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 2.0, NULL, false, '2');

  -- Competitor Rank 11: Hussaluk Srinakorn (225982, THA)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hussaluk Srinakorn')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Hussaluk Srinakorn')), lower(trim('Hussaluk SRINAKORN'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hussaluk Srinakorn', 'ilca4-tha-hussaluk-srinakorn-225982', 'N/A', '225982', '225982', 'THA', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '225982') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Hussaluk SRINAKORN')
  ON CONFLICT DO NOTHING;

  v_res_id := 'f8a0a098-7d08-5a3c-89a9-9566a26ff9d3';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Hussaluk Srinakorn', '225982', 'individual',
    11, 56.0, 46.0, 'THA', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '8d5776d2-cd7a-57ad-aef3-f555b3da2196';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Hussaluk Srinakorn', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 2.0, NULL, false, '2');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 2.0, NULL, false, '2');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 10.0, NULL, true, '(10.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 6.0, NULL, false, '6');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 9.0, NULL, false, '9');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 8.0, NULL, false, '8');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 6.0, NULL, false, '6');

  -- Competitor Rank 12: Zachary Wong (221061, SGP)
  v_sailor_id := 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a';

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Weikai Zachary Wong')
  ON CONFLICT DO NOTHING;

  v_res_id := 'e8a09a1c-bf89-5a8b-bf9b-4941e5e8311a';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Zachary Wong', '221061', 'individual',
    12, 53.0, 46.0, 'SGP', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '3e7d254d-076b-5315-ad2a-c97655c0e253';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Zachary Wong', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 6.0, NULL, false, '6');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 7.0, NULL, true, '(7.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 7.0, NULL, false, '7');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 2.0, NULL, false, '2');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 7.0, NULL, false, '7');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 7.0, NULL, false, '7');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 3.0, NULL, false, '3');

  -- Competitor Rank 13: Jemima Chang (227464, SGP)
  v_sailor_id := '1ba65410-fa86-472d-ad75-bc510bffd07b';

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Jemima CHANG')
  ON CONFLICT DO NOTHING;

  v_res_id := '0d728d85-61ac-57d9-bea3-69f4fa26bab4';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Jemima Chang', '227464', 'individual',
    13, 55.0, 47.0, 'SGP', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '24829565-540f-514f-9e07-b97a021f4097';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Jemima Chang', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 1.0, NULL, false, '1');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 2.0, NULL, false, '2');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 7.0, NULL, false, '7');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 7.0, NULL, false, '7');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 6.0, NULL, false, '6');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 7.0, NULL, false, '7');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 8.0, NULL, true, '(8.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 6.0, NULL, false, '6');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 6.0, NULL, false, '6');

  -- Competitor Rank 14: Teng-Hsi Yeh (225163, TPE)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Teng-Hsi Yeh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Teng-Hsi Yeh')), lower(trim('Teng-Hsi YEH'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Teng-Hsi Yeh', 'ilca4-tpe-teng-hsi-yeh-225163', 'N/A', '225163', '225163', 'TPE', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '225163') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Teng-Hsi YEH')
  ON CONFLICT DO NOTHING;

  v_res_id := '4436a2b3-d716-5d30-a085-dd5f5448df66';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Teng-Hsi Yeh', '225163', 'individual',
    14, 62.0, 53.0, 'TPE', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '2c66520d-6e99-5641-a655-b954756d0a49';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Teng-Hsi Yeh', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 1.0, NULL, false, '1');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 6.0, NULL, false, '6');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 9.0, NULL, true, '(9.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 8.0, NULL, false, '8');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 6.0, NULL, false, '6');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 9.0, NULL, false, '9');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 7.0, NULL, false, '7');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 7.0, NULL, false, '7');

  -- Competitor Rank 15: Yong-Fen Yang (225799, TPE)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yong-Fen Yang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Yong-Fen Yang')), lower(trim('Yong-Fen YANG'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yong-Fen Yang', 'ilca4-tpe-yong-fen-yang-225799', 'N/A', '225799', '225799', 'TPE', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '225799') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Yong-Fen YANG')
  ON CONFLICT DO NOTHING;

  v_res_id := '10ef3ce1-06b3-5505-ac5a-38d407721b05';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Yong-Fen Yang', '225799', 'individual',
    15, 76.0, 57.0, 'TPE', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'ba6c15b9-7b83-53d6-b48a-9407b842a16a';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Yong-Fen Yang', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 1.0, NULL, false, '1');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 1.0, NULL, false, '1');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 12.0, NULL, false, '12');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 8.0, NULL, false, '8');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 9.0, NULL, false, '9');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 8.0, NULL, false, '8');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 19.0, 'UFD', true, '(19.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 2.0, NULL, false, '2');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 11.0, NULL, false, '11');

  -- Competitor Rank 16: Zildjan Martin Samson (225455, PHI)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zildjan Martin Samson')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Zildjan Martin Samson')), lower(trim('Zildjan Martin SAMSON'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zildjan Martin Samson', 'ilca4-phi-zildjan-martin-samson-225455', 'N/A', '225455', '225455', 'PHI', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '225455') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Zildjan Martin SAMSON')
  ON CONFLICT DO NOTHING;

  v_res_id := '0b4ab2ee-849c-5f17-b1ce-e981e45e91e2';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Zildjan Martin Samson', '225455', 'individual',
    16, 93.0, 80.0, 'PHI', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '1814fab5-d4ff-50b5-a181-04c1502c6b54';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Zildjan Martin Samson', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 7.0, NULL, false, '7');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 6.0, NULL, false, '6');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 9.0, NULL, false, '9');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 13.0, NULL, true, '(13.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 11.0, NULL, false, '11');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 12.0, NULL, false, '12');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 9.0, NULL, false, '9');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 11.0, NULL, false, '11');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 10.0, NULL, false, '10');

  -- Competitor Rank 17: Yuk Jun Lim (225182, SGP)
  v_sailor_id := '26414c39-ffe4-417d-aabc-a577d6355fd5';

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Yuk Jun LIM')
  ON CONFLICT DO NOTHING;

  v_res_id := 'a5c87465-065f-585c-b83c-177d0d7d44f5';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Yuk Jun Lim', '225182', 'individual',
    17, 92.0, 80.0, 'SGP', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '87921439-fb2d-5de3-9313-9ec5f1f6fc85';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Yuk Jun Lim', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 9.0, NULL, false, '9');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 11.0, NULL, false, '11');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 12.0, NULL, true, '(12.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 7.0, NULL, false, '7');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 10.0, NULL, false, '10');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 7.0, NULL, false, '7');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 6.0, NULL, false, '6');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 11.0, NULL, false, '11');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 8.0, NULL, false, '8');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 11.0, NULL, false, '11');

  -- Competitor Rank 18: Austin Lee (217710, TPE)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Austin Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Austin Lee')), lower(trim('Austin LEE'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Austin Lee', 'ilca4-tpe-austin-lee-217710', 'N/A', '217710', '217710', 'TPE', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '217710') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Austin LEE')
  ON CONFLICT DO NOTHING;

  v_res_id := '19c31d10-7631-5501-8b20-9190eeb25d0b';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Austin Lee', '217710', 'individual',
    18, 93.0, 81.0, 'TPE', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'faaccb25-9644-5d28-addb-2ed29ec8e413';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Austin Lee', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 11.0, NULL, false, '11');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 12.0, NULL, true, '(12.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 11.0, NULL, false, '11');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 8.0, NULL, false, '8');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 8.0, NULL, false, '8');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 12.0, NULL, false, '12');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 8.0, NULL, false, '8');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 6.0, NULL, false, '6');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 12.0, NULL, false, '12');

  -- Competitor Rank 19: Yen-Chen Wang (163120, TPE)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yen-Chen Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Yen-Chen Wang')), lower(trim('Yen-Chen WANG'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yen-Chen Wang', 'ilca4-tpe-yen-chen-wang-163120', 'N/A', '163120', '163120', 'TPE', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '163120') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Yen-Chen WANG')
  ON CONFLICT DO NOTHING;

  v_res_id := '21e1ba3c-a519-5df5-be9e-5d75a4080b3e';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Yen-Chen Wang', '163120', 'individual',
    19, 94.0, 81.0, 'TPE', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '81cb27ac-6553-5943-9084-a442a9cb8d74';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Yen-Chen Wang', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 7.0, NULL, false, '7');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 8.0, NULL, false, '8');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 8.0, NULL, false, '8');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 13.0, NULL, true, '(13.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 9.0, NULL, false, '9');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 11.0, NULL, false, '11');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 12.0, NULL, false, '12');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 9.0, NULL, false, '9');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 9.0, NULL, false, '9');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 8.0, NULL, false, '8');

  -- Competitor Rank 20: Caleb Peck (225221, SGP)
  v_sailor_id := '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f';

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Caleb Rui-Kai PECK')
  ON CONFLICT DO NOTHING;

  v_res_id := 'affebbcf-b3e9-59c6-943e-550d5d063bd4';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Caleb Peck', '225221', 'individual',
    20, 100.0, 86.0, 'SGP', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'c9ee2c93-d103-5a8a-995b-a1466f55ff20';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Caleb Peck', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 13.0, NULL, false, '13');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 10.0, NULL, false, '10');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 10.0, NULL, false, '10');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 6.0, NULL, false, '6');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 9.0, NULL, false, '9');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 14.0, NULL, true, '(14.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 10.0, NULL, false, '10');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 10.0, NULL, false, '10');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 10.0, NULL, false, '10');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 8.0, NULL, false, '8');

  -- Competitor Rank 21: Lyora Hong-yi Wallier (213316, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lyora Hong-yi Wallier')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Lyora Hong-yi Wallier')), lower(trim('Lyora Hong-yi WALLIER'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lyora Hong-yi Wallier', 'ilca4-hkg-lyora-hong-yi-wallier-213316', 'N/A', '213316', '213316', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '213316') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Lyora Hong-yi WALLIER')
  ON CONFLICT DO NOTHING;

  v_res_id := '58ca2485-57b9-5de8-935c-2ee0ce391e8e';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Lyora Hong-yi Wallier', '213316', 'individual',
    21, 109.0, 93.0, 'HKG', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'c4b8f4d5-9816-552f-8b3a-c6a560eef5b7';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Lyora Hong-yi Wallier', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 9.0, NULL, false, '9');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 10.0, NULL, false, '10');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 7.0, NULL, false, '7');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 16.0, NULL, true, '(16.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 15.0, NULL, false, '15');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 12.0, NULL, false, '12');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 9.0, NULL, false, '9');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 7.0, NULL, false, '7');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 15.0, NULL, false, '15');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 9.0, NULL, false, '9');

  -- Competitor Rank 22: Thomas Yong Jin Ko (211709, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Thomas Yong Jin Ko')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Thomas Yong Jin Ko')), lower(trim('Thomas Yong Jin KO'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Thomas Yong Jin Ko', 'ilca4-hkg-thomas-yong-jin-ko-211709', 'N/A', '211709', '211709', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '211709') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Thomas Yong Jin KO')
  ON CONFLICT DO NOTHING;

  v_res_id := 'd5879e57-8dc9-567f-a8ee-7f09abbdcc9b';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Thomas Yong Jin Ko', '211709', 'individual',
    22, 118.0, 98.0, 'HKG', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '85b1416a-e4c5-55c5-b173-e6eb49a724f6';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Thomas Yong Jin Ko', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 8.0, NULL, false, '8');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 9.0, NULL, false, '9');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 7.0, NULL, false, '7');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 11.0, NULL, false, '11');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 13.0, NULL, false, '13');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 15.0, NULL, false, '15');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 11.0, NULL, false, '11');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 15.0, NULL, false, '15');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 20.0, 'UFD', true, '(20.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 9.0, NULL, false, '9');

  -- Competitor Rank 23: Chi-Fang Huang (220975, TPE)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Chi-Fang Huang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Chi-Fang Huang')), lower(trim('Chi fang HUANG'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Chi-Fang Huang', 'ilca4-tpe-chi-fang-huang-220975', 'N/A', '220975', '220975', 'TPE', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '220975') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Chi fang HUANG')
  ON CONFLICT DO NOTHING;

  v_res_id := '67ce058e-773a-5858-aedf-0872e2dcc325';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Chi-Fang Huang', '220975', 'individual',
    23, 119.0, 100.0, 'TPE', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'c03568e6-4f6e-5fcf-89eb-8707afdc7310';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Chi-Fang Huang', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 13.0, NULL, false, '13');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 11.0, NULL, false, '11');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 14.0, NULL, false, '14');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 9.0, NULL, false, '9');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 10.0, NULL, false, '10');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 10.0, NULL, false, '10');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 10.0, NULL, false, '10');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 19.0, 'UFD', true, '(19.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 11.0, NULL, false, '11');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 12.0, NULL, false, '12');

  -- Competitor Rank 24: Kate Lee (214516, TPE)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kate Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Kate Lee')), lower(trim('Kate LEE'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kate Lee', 'ilca4-tpe-kate-lee-214516', 'N/A', '214516', '214516', 'TPE', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '214516') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Kate LEE')
  ON CONFLICT DO NOTHING;

  v_res_id := 'a057a4be-73ed-5ac0-bc62-3ee3f256f66b';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Kate Lee', '214516', 'individual',
    24, 120.0, 101.0, 'TPE', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '7e1d0513-8f98-5a63-8e15-7853f73b625f';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Kate Lee', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 14.0, NULL, false, '14');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 19.0, 'NSC', true, '(19.0 NSC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 11.0, NULL, false, '11');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 10.0, NULL, false, '10');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 13.0, NULL, false, '13');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 8.0, NULL, false, '8');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 13.0, NULL, false, '13');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 12.0, NULL, false, '12');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 10.0, NULL, false, '10');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 10.0, NULL, false, '10');

  -- Competitor Rank 25: En-Rui Hsu (208532, TPE)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('En-Rui Hsu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('En-Rui Hsu')), lower(trim('En-Rui HSU'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'En-Rui Hsu', 'ilca4-tpe-en-rui-hsu-208532', 'N/A', '208532', '208532', 'TPE', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '208532') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'En-Rui HSU')
  ON CONFLICT DO NOTHING;

  v_res_id := '7a25f785-e16e-53e7-9562-6656d9097fdd';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'En-Rui Hsu', '208532', 'individual',
    25, 131.0, 114.0, 'TPE', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'ec7a2ff3-3b19-531f-a2d6-aff05462c894';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'En-Rui Hsu', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 12.0, NULL, false, '12');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 12.0, NULL, false, '12');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 12.0, NULL, false, '12');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 15.0, NULL, false, '15');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 12.0, NULL, false, '12');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 13.0, NULL, false, '13');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 14.0, NULL, false, '14');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 10.0, NULL, false, '10');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 17.0, NULL, true, '(17.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 14.0, NULL, false, '14');

  -- Competitor Rank 26: Carine Leung (215131, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Carine Leung')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Carine Leung')), lower(trim('Carine LEUNG'))) LIMIT 1;
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

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Carine LEUNG')
  ON CONFLICT DO NOTHING;

  v_res_id := 'e312a6e1-e420-5983-8889-40413a323b30';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Carine Leung', '215131', 'individual',
    26, 137.0, 118.0, 'HKG', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '9db10caf-cea5-57f1-9c9e-a8211dfe6447';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Carine Leung', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 15.0, NULL, false, '15');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 14.0, NULL, false, '14');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 13.0, NULL, false, '13');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 11.0, NULL, false, '11');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 15.0, NULL, false, '15');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 16.0, NULL, false, '16');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 19.0, 'UFD', true, '(19.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 14.0, NULL, false, '14');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 16.0, NULL, false, '16');

  -- Competitor Rank 27: Tzu-Ho Liu (217714, TPE)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tzu-Ho Liu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Tzu-Ho Liu')), lower(trim('Tzu-Ho LIU'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tzu-Ho Liu', 'ilca4-tpe-tzu-ho-liu-217714', 'N/A', '217714', '217714', 'TPE', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '217714') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Tzu-Ho LIU')
  ON CONFLICT DO NOTHING;

  v_res_id := 'fd162657-b324-55e6-8248-08d18095c463';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Tzu-Ho Liu', '217714', 'individual',
    27, 140.0, 122.0, 'TPE', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '9f4b223b-eb83-56a6-81c0-83e467c8c2a4';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Tzu-Ho Liu', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 16.0, NULL, false, '16');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 14.0, NULL, false, '14');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 14.0, NULL, false, '14');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 14.0, NULL, false, '14');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 15.0, NULL, false, '15');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 10.0, NULL, false, '10');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 14.0, NULL, false, '14');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 16.0, NULL, false, '16');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 9.0, NULL, false, '9');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 18.0, NULL, true, '(18.0)');

  -- Competitor Rank 28: Cyun-Yan Tai (210623, TPE)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cyun-Yan Tai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Cyun-Yan Tai')), lower(trim('Cyun-Yan TAI'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cyun-Yan Tai', 'ilca4-tpe-cyun-yan-tai-210623', 'N/A', '210623', '210623', 'TPE', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '210623') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Cyun-Yan TAI')
  ON CONFLICT DO NOTHING;

  v_res_id := '6fc33295-1c42-52b4-b639-50eef5d9b668';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Cyun-Yan Tai', '210623', 'individual',
    28, 144.0, 124.0, 'TPE', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '50b84147-6085-5075-a3e6-6d01f412fba9';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Cyun-Yan Tai', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 12.0, NULL, false, '12');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 13.0, NULL, false, '13');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 17.0, NULL, false, '17');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 18.0, NULL, false, '18');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 12.0, NULL, false, '12');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 11.0, NULL, false, '11');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 16.0, NULL, false, '16');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 12.0, NULL, false, '12');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 20.0, 'UFD', true, '(20.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 13.0, NULL, false, '13');

  -- Competitor Rank 29: Chen-Yang Yeh (214553, TPE)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Chen-Yang Yeh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Chen-Yang Yeh')), lower(trim('ChenYang YEH'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Chen-Yang Yeh', 'ilca4-tpe-chen-yang-yeh-214553', 'N/A', '214553', '214553', 'TPE', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '214553') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'ChenYang YEH')
  ON CONFLICT DO NOTHING;

  v_res_id := '96eab9c8-9a5c-5474-b322-bd25ad3fa38d';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Chen-Yang Yeh', '214553', 'individual',
    29, 142.0, 124.0, 'TPE', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'ba61179e-2196-5d30-8a31-d79daa0b2084';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Chen-Yang Yeh', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 14.0, NULL, false, '14');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 17.0, NULL, false, '17');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 18.0, NULL, true, '(18.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 12.0, NULL, false, '12');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 14.0, NULL, false, '14');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 13.0, NULL, false, '13');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 13.0, NULL, false, '13');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 14.0, NULL, false, '14');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 12.0, NULL, false, '12');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 15.0, NULL, false, '15');

  -- Competitor Rank 30: Yan-Yun Wang (221514, TPE)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yan-Yun Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Yan-Yun Wang')), lower(trim('Yanyun WANG'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yan-Yun Wang', 'ilca4-tpe-yan-yun-wang-221514', 'N/A', '221514', '221514', 'TPE', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '221514') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Yanyun WANG')
  ON CONFLICT DO NOTHING;

  v_res_id := '0e1ba661-ee0e-52d7-bfbc-f070c7240ef2';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Yan-Yun Wang', '221514', 'individual',
    30, 144.0, 125.0, 'TPE', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '0df42487-8f52-5761-ad45-105725d59be0';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Yan-Yun Wang', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 10.0, NULL, false, '10');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 13.0, NULL, false, '13');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 15.0, NULL, false, '15');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 11.0, NULL, false, '11');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 17.0, NULL, false, '17');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 14.0, NULL, false, '14');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 17.0, 'SCP', false, '17.0 SCP30');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 19.0, 'UFD', true, '(19.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 13.0, NULL, false, '13');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 15.0, NULL, false, '15');

  -- Competitor Rank 31: Raya Mithi Samson (225452, PHI)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Raya Mithi Samson')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Raya Mithi Samson')), lower(trim('Raya Mithi SAMSON'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Raya Mithi Samson', 'ilca4-phi-raya-mithi-samson-225452', 'N/A', '225452', '225452', 'PHI', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '225452') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Raya Mithi SAMSON')
  ON CONFLICT DO NOTHING;

  v_res_id := '04a05577-00c5-574b-8cf0-3abea0de89d0';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Raya Mithi Samson', '225452', 'individual',
    31, 154.0, 135.0, 'PHI', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'a1344513-ac89-5c47-8c40-6663527f6629';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Raya Mithi Samson', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 19.0, 'DNF', true, '(19.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 19.0, 'DNF', false, '19.0 DNF');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 19.0, 'DNF', false, '19.0 DNF');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 14.0, NULL, false, '14');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 14.0, NULL, false, '14');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 16.0, NULL, false, '16');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 17.0, NULL, false, '17');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 11.0, NULL, false, '11');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 12.0, NULL, false, '12');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 13.0, NULL, false, '13');

  -- Competitor Rank 32: Yu-Hsiang Huang (225165, TPE)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yu-Hsiang Huang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Yu-Hsiang Huang')), lower(trim('Yu Hsiang HUANG'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yu-Hsiang Huang', 'ilca4-tpe-yu-hsiang-huang-225165', 'N/A', '225165', '225165', 'TPE', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '225165') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Yu Hsiang HUANG')
  ON CONFLICT DO NOTHING;

  v_res_id := '35601639-6d06-5939-8a55-0befcafe4c4a';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Yu-Hsiang Huang', '225165', 'individual',
    32, 158.0, 138.0, 'TPE', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '0507deec-7e7d-5957-8abc-7e2d891a2cd9';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Yu-Hsiang Huang', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 20.0, 'DNS', true, '(20.0 DNS)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 15.0, NULL, false, '15');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 15.0, NULL, false, '15');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 19.0, NULL, false, '19');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 16.0, NULL, false, '16');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 17.0, NULL, false, '17');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 15.0, NULL, false, '15');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 13.0, NULL, false, '13');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 14.0, NULL, false, '14');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 14.0, NULL, false, '14');

  -- Competitor Rank 33: Chi-Hsi Lin (203017, TPE)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Chi-Hsi Lin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Chi-Hsi Lin')), lower(trim('Chi-Hsi LIN'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Chi-Hsi Lin', 'ilca4-tpe-chi-hsi-lin-203017', 'N/A', '203017', '203017', 'TPE', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '203017') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Chi-Hsi LIN')
  ON CONFLICT DO NOTHING;

  v_res_id := '3c631aa1-3256-579e-bdea-664f06b3aed3';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Chi-Hsi Lin', '203017', 'individual',
    33, 165.0, 146.0, 'TPE', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'ba1cc0ed-4ff1-5efe-a65f-8bc5b6c89e07';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Chi-Hsi Lin', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 15.0, NULL, false, '15');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 16.0, NULL, false, '16');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 16.0, NULL, false, '16');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 16.0, NULL, false, '16');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 19.0, NULL, true, '(19.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 18.0, NULL, false, '18');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 19.0, NULL, false, '19');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 17.0, NULL, false, '17');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 13.0, NULL, false, '13');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 16.0, NULL, false, '16');

  -- Competitor Rank 34: Ai-Mei Lien (224990, TPE)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ai-Mei Lien')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Ai-Mei Lien')), lower(trim('Ai-Mei LIEN'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ai-Mei Lien', 'ilca4-tpe-ai-mei-lien-224990', 'N/A', '224990', '224990', 'TPE', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '224990') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Ai-Mei LIEN')
  ON CONFLICT DO NOTHING;

  v_res_id := '60115042-ad43-567e-bb25-2dc271555610';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Ai-Mei Lien', '224990', 'individual',
    34, 170.0, 151.0, 'TPE', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '60194705-bc64-558a-9b1a-b886a5ee0823';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Ai-Mei Lien', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 19.0, 'RET', true, '(19.0 RET)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 19.0, 'RET', false, '19.0 RET');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 19.0, 'RET', false, '19.0 RET');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 19.0, 'RET', false, '19.0 RET');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 16.0, NULL, false, '16');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 17.0, NULL, false, '17');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 15.0, NULL, false, '15');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 13.0, NULL, false, '13');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 16.0, NULL, false, '16');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 17.0, NULL, false, '17');

  -- Competitor Rank 35: Hao-Ran Hsu (211323, TPE)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hao-Ran Hsu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Hao-Ran Hsu')), lower(trim('Hao-Ran HSU'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hao-Ran Hsu', 'ilca4-tpe-hao-ran-hsu-211323', 'N/A', '211323', '211323', 'TPE', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '211323') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Hao-Ran HSU')
  ON CONFLICT DO NOTHING;

  v_res_id := '26c0c2c7-f712-5332-b830-2815107f75c0';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Hao-Ran Hsu', '211323', 'individual',
    35, 174.0, 154.0, 'TPE', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := 'c30f7752-9471-5dca-92c1-876667fc00ad';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Hao-Ran Hsu', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 17.0, NULL, false, '17');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 18.0, NULL, false, '18');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 19.0, NULL, false, '19');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 15.0, NULL, false, '15');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 17.0, NULL, false, '17');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 16.0, NULL, false, '16');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 17.0, NULL, false, '17');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 18.0, NULL, false, '18');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 20.0, 'UFD', true, '(20.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 17.0, NULL, false, '17');

  -- Competitor Rank 36: Ming-Shuo Chang (203012, TPE)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ming-Shuo Chang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Ming-Shuo Chang')), lower(trim('Ming Shuo CHANG'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ming-Shuo Chang', 'ilca4-tpe-ming-shuo-chang-203012', 'N/A', '203012', '203012', 'TPE', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '203012') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Ming Shuo CHANG')
  ON CONFLICT DO NOTHING;

  v_res_id := '682279ac-2469-5a9e-ae9e-acc9cb32ec94';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Ming-Shuo Chang', '203012', 'individual',
    36, 183.0, 163.0, 'TPE', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '28719c6b-23fb-5c16-b8d2-c2d31b8887dc';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Ming-Shuo Chang', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 20.0, 'DNC', true, '(20.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 20.0, 'DNF', false, '20.0 DNF');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 13.0, NULL, false, '13');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 17.0, NULL, false, '17');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 18.0, NULL, false, '18');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 19.0, NULL, false, '19');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 18.0, NULL, false, '18');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 19.0, NULL, false, '19');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 20.0, 'UFD', false, '20.0 UFD');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 19.0, NULL, false, '19');

  -- Competitor Rank 37: Huanran Zheng (209319, HKG)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Huanran Zheng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower(trim('Huanran Zheng')), lower(trim('Huanran ZHENG'))) LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, club, sail_number, sail_number_ilca4, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Huanran Zheng', 'ilca4-hkg-huanran-zheng-209319', 'N/A', '209319', '209319', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '209319') WHERE id = v_sailor_id;
  END IF;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES (v_sailor_id, 'Huanran ZHENG')
  ON CONFLICT DO NOTHING;

  v_res_id := 'c1559a20-0d72-51b7-8e9e-dc712ac555c8';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, '9d4142bd-4fe9-5cc8-89ae-012d3bc10541', 'Huanran Zheng', '209319', 'individual',
    37, 190.0, 171.0, 'HKG', false, false,
    'verified', 'https://www.ct-sailing.org.tw/media/k2/attachments/2026_ILCA%E4%BA%9E%E6%B4%B2%E7%9B%83%E6%88%90%E7%B8%BE-%E5%85%AC%E5%91%8A.pdf', '2026 ILCA Asian Cup (Penghu) Official Final Results PDF', 'pdf',
    'Official final results PDF published by Chinese Taipei Sailing Association (CTSA) and ILCA Asia Region.', now()
  ) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

  v_part_id := '07ae052a-3591-50fb-ba1e-4875484b30d1';
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    v_part_id, v_res_id, v_sailor_id, 'Huanran Zheng', 1, 'solo', 'matched', false
  ) ON CONFLICT (id) DO NOTHING;

  DELETE FROM public.regatta_race_results WHERE regatta_result_id = v_res_id;

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 1, 19.0, 'DNC', true, '(19.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 2, 19.0, 'DNC', false, '19.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 3, 19.0, 'DNC', false, '19.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 4, 19.0, 'DNC', false, '19.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 5, 19.0, 'DNC', false, '19.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 6, 19.0, 'DNC', false, '19.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 7, 19.0, 'DNC', false, '19.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 8, 19.0, 'DNC', false, '19.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 9, 19.0, 'DNC', false, '19.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES (v_res_id, 10, 19.0, 'DNC', false, '19.0 DNC');

END $$;

COMMIT;