-- 072_backfill_migration_064_race_results.sql
-- Backfill official race-by-race results into regatta_race_results for Pulau Ujong 2026 (ILCA 6), SYSC 2026 (ILCA 6), Temasek 2026 (ILCA 6), and Temasek 2026 (ILCA 7)
-- Fixes table name target to public.regatta_race_results
-- Source: Official Sailwave scoring sheets, Singapore Sailing Federation

-- ============================================================================
-- Regatta: Pulau Ujong Regatta 2026 (ILCA 6) (pulau-ujong-2026-ilca-6)
-- ============================================================================
DO $$
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'pulau-ujong-2026-ilca-6' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = 'Pulau Ujong Regatta 2026 (ILCA 6)',
      date = '2026-02-21',
      end_date = '2026-02-22',
      boat_class = 'ILCA 6',
      division = 'Open',
      total_fleet_size = 16,
      race_count = 6,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/13180/event',
      schedule_notes = 'Pulau Ujong Regatta 2026 ILCA 6 fleet: 16 entries, 6 races sailed (1 discard).',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, schedule_notes, created_at, updated_at
    ) VALUES (
      v_reg_id, 'Pulau Ujong Regatta 2026 (ILCA 6)', 'pulau-ujong-2026-ilca-6', '2026-02-21', '2026-02-22', 'ILCA 6', 'Open', 16, 6,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation', 'https://www.racingrulesofsailing.org/documents/13180/event', 'Pulau Ujong Regatta 2026 ILCA 6 fleet: 16 entries, 6 races sailed (1 discard).', now(), now()
    );
  END IF;

  -- Remove prior results for clean idempotent re-import
  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Kenan Kee Zen Tan
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kenan Kee Zen Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kenan Kee Zen Tan', 'kenan-kee-zen-tan', '1', 'Royal Varuna Yacht Club', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
      school = COALESCE(sailors.school, NULL),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 1, 7, 5, false, false,
    '1', 'M', NULL, 'Royal Varuna Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 2, '2', NULL, true, now(), now()
  );

  -- Competitor: Gordon Alexander Allan
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gordon Alexander Allan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gordon Alexander Allan', 'gordon-alexander-allan', '221058', 'Royal Varuna Yacht Club', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
      school = COALESCE(sailors.school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 2, 27, 17, false, false,
    '221058', 'M', 'Anglo-Chinese School (Independent)', 'Royal Varuna Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 5, '5', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 5, '5', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 10, '10', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 3, '3', NULL, false, now(), now()
  );

  -- Competitor: Eitan Oh
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Eitan Oh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Eitan Oh', 'eitan-oh', '224717', 'SAF Yacht Club', 'Raffles Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      school = COALESCE(sailors.school, 'Raffles Institution'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 3, 23, 17, false, false,
    '224717', 'M', 'Raffles Institution', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 5, '5', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 6, '6', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 5, '5', NULL, false, now(), now()
  );

  -- Competitor: Justiin Ang
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Justiin Ang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Justiin Ang', 'justiin-ang', '158031', 'Constant Wind SeaSports', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
      school = COALESCE(sailors.school, NULL),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 4, 39, 22, false, false,
    '158031', 'M', NULL, 'Constant Wind SeaSports', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 7, '7', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 5, '5', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 17, '17 RET', 'RET', true, now(), now()
  );

  -- Competitor: Sarah Rui-En Yong
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sarah Rui-En Yong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sarah Rui-En Yong', 'sarah-rui-en-yong', '221689', 'Royal Varuna Yacht Club', 'Nanyang Polytechnic', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
      school = COALESCE(sailors.school, 'Nanyang Polytechnic'),
      gender = COALESCE(sailors.gender, 'F'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 5, 42, 30, false, false,
    '221689', 'F', 'Nanyang Polytechnic', 'Royal Varuna Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 6, '6', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 7, '7', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 10, '10', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 12, '12', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 4, '4', NULL, false, now(), now()
  );

  -- Competitor: Keira Carlyle
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Keira Carlyle')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Keira Carlyle', 'keira-carlyle', '25', 'SAF Yacht Club', 'Nanyang Polytechnic', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      school = COALESCE(sailors.school, 'Nanyang Polytechnic'),
      gender = COALESCE(sailors.gender, 'F'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 6, 44, 31, false, false,
    '25', 'F', 'Nanyang Polytechnic', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 13, '13', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 8, '8', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 9, '9', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 6, '6', NULL, false, now(), now()
  );

  -- Competitor: Austin Jia Yu Yeo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Austin Jia Yu Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Austin Jia Yu Yeo', 'austin-jia-yu-yeo', '2', 'SAF Yacht Club', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      school = COALESCE(sailors.school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 7, 49, 32, false, false,
    '2', 'M', 'Anglo-Chinese School (Independent)', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 7, '7', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 17, '17 DNF', 'DNF', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 5, '5', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 17, '17 DNF', 'DNF', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 1, '1', NULL, false, now(), now()
  );

  -- Competitor: Josiah Zhi En Tan
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Josiah Zhi En Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Josiah Zhi En Tan', 'josiah-zhi-en-tan', '1978', 'ONE°15 Marina', 'Victoria School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'ONE°15 Marina'),
      school = COALESCE(sailors.school, 'Victoria School'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 8, 50, 38, false, false,
    '1978', 'M', 'Victoria School', 'ONE°15 Marina', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 12, '12', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 12, '12', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 7, '7', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 9, '9', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 7, '7', NULL, false, now(), now()
  );

  -- Competitor: Yuei Jit Foo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuei Jit Foo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuei Jit Foo', 'yuei-jit-foo', '221686', 'PAssion Wave', 'Anderson Serangoon Junior College', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'PAssion Wave'),
      school = COALESCE(sailors.school, 'Anderson Serangoon Junior College'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 9, 50, 38, false, false,
    '221686', 'M', 'Anderson Serangoon Junior College', 'PAssion Wave', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 11, '11', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 6, '6', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 6, '6', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 12, '12', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 11, '11', NULL, false, now(), now()
  );

  -- Competitor: Darren Lai
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Darren Lai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Darren Lai', 'darren-lai', '222257', 'Royal Varuna Yacht Club', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
      school = COALESCE(sailors.school, 'St. Joseph''s Institution'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 10, 48, 38, false, false,
    '222257', 'M', 'St. Joseph''s Institution', 'Royal Varuna Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 8, '8', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 9, '9', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 8, '8', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 6, '6', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 7, '7', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 10, '10', NULL, true, now(), now()
  );

  -- Competitor: Zachary Khoo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zachary Khoo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zachary Khoo', 'zachary-khoo', '51', 'PAssion Wave', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'PAssion Wave'),
      school = COALESCE(sailors.school, NULL),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 11, 57, 43, false, false,
    '51', 'M', NULL, 'PAssion Wave', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 9, '9', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 9, '9', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 10, '10', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 11, '11', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 14, '14', NULL, true, now(), now()
  );

  -- Competitor: Jayden Teo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jayden Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jayden Teo', 'jayden-teo', '214813', 'PAssion Wave', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'PAssion Wave'),
      school = COALESCE(sailors.school, 'St. Joseph''s Institution'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 12, 64, 50, false, false,
    '214813', 'M', 'St. Joseph''s Institution', 'PAssion Wave', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 12, '12', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 10, '10', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 14, '14', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 11, '11', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 8, '8', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 9, '9', NULL, false, now(), now()
  );

  -- Competitor: Rohit Behl
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rohit Behl')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rohit Behl', 'rohit-behl', '221931', 'Changi Sailing Club', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Changi Sailing Club'),
      school = COALESCE(sailors.school, NULL),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 13, 70, 55, false, false,
    '221931', 'M', NULL, 'Changi Sailing Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 10, '10', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 13, '13', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 11, '11', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 8, '8', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 15, '15', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 13, '13', NULL, false, now(), now()
  );

  -- Competitor: Jonathan Jian Yi Ho
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jonathan Jian Yi Ho')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jonathan Jian Yi Ho', 'jonathan-jian-yi-ho', '214848', 'PAssion Wave', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'PAssion Wave'),
      school = COALESCE(sailors.school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 14, 78, 63, false, false,
    '214848', 'M', 'Anglo-Chinese School (Independent)', 'PAssion Wave', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 15, '15', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 14, '14', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 15, '15', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 13, '13', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 13, '13', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 8, '8', NULL, false, now(), now()
  );

  -- Competitor: Cleo En Rui Seah
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cleo En Rui Seah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cleo En Rui Seah', 'cleo-en-rui-seah', '224379', 'SAF Yacht Club', 'Ngee Ann Polytechnic', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      school = COALESCE(sailors.school, 'Ngee Ann Polytechnic'),
      gender = COALESCE(sailors.gender, 'F'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 15, 78, 64, false, false,
    '224379', 'F', 'Ngee Ann Polytechnic', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 14, '14', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 11, '11', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 13, '13', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 14, '14', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 14, '14', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 12, '12', NULL, false, now(), now()
  );

  -- Competitor: Aurick You Shun Leow
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aurick You Shun Leow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aurick You Shun Leow', 'aurick-you-shun-leow', '67', 'SAF Yacht Club', 'Raffles Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      school = COALESCE(sailors.school, 'Raffles Institution'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 16, 102, 85, true, false,
    '67', 'M', 'Raffles Institution', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 17, '17 DNC', 'DNC', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 17, '17 DNC', 'DNC', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 17, '17 DNC', 'DNC', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 17, '17 DNC', 'DNC', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 17, '17 DNC', 'DNC', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 17, '17 DNC', 'DNC', false, now(), now()
  );

END $$;

-- ============================================================================
-- Regatta: Singapore Youth Sailing Championships 2026 (ILCA 6) (sysc-2026-ilca-6)
-- ============================================================================
DO $$
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'sysc-2026-ilca-6' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = 'Singapore Youth Sailing Championships 2026 (ILCA 6)',
      date = '2026-03-14',
      end_date = '2026-03-17',
      boat_class = 'ILCA 6',
      division = 'Open',
      total_fleet_size = 16,
      race_count = 12,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/13601/event',
      schedule_notes = 'Singapore Youth Sailing Championships 2026 ILCA 6 fleet: 16 entries, 12 races sailed (2 discards).',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, schedule_notes, created_at, updated_at
    ) VALUES (
      v_reg_id, 'Singapore Youth Sailing Championships 2026 (ILCA 6)', 'sysc-2026-ilca-6', '2026-03-14', '2026-03-17', 'ILCA 6', 'Open', 16, 12,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation', 'https://www.racingrulesofsailing.org/documents/13601/event', 'Singapore Youth Sailing Championships 2026 ILCA 6 fleet: 16 entries, 12 races sailed (2 discards).', now(), now()
    );
  END IF;

  -- Remove prior results for clean idempotent re-import
  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Austin Jia Yu Yeo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Austin Jia Yu Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Austin Jia Yu Yeo', 'austin-jia-yu-yeo', '221062', 'SAF Yacht Club', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      school = COALESCE(sailors.school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 1, 37, 19, false, false,
    '221062', 'M', 'Anglo-Chinese School (Independent)', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 10, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 11, 12, '12', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 12, 6, '6', NULL, true, now(), now()
  );

  -- Competitor: Aurick You Shun Leow
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aurick You Shun Leow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aurick You Shun Leow', 'aurick-you-shun-leow', '214737', 'SAF Yacht Club', 'Raffles Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      school = COALESCE(sailors.school, 'Raffles Institution'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 2, 45, 22, false, false,
    '214737', 'M', 'Raffles Institution', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 17, 'DNF 17', 'DNF', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 6, '6', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 10, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 11, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 12, 2, '2', NULL, false, now(), now()
  );

  -- Competitor: Eitan Oh
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Eitan Oh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Eitan Oh', 'eitan-oh', '224717', 'SAF Yacht Club', 'Raffles Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      school = COALESCE(sailors.school, 'Raffles Institution'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 3, 39, 26, false, false,
    '224717', 'M', 'Raffles Institution', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 8, '8', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 5, '5', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 10, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 11, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 12, 1, '1', NULL, false, now(), now()
  );

  -- Competitor: Gordon Alexander Allan
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gordon Alexander Allan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gordon Alexander Allan', 'gordon-alexander-allan', '221058', 'Royal Varuna Yacht Club', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
      school = COALESCE(sailors.school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 4, 46, 34, false, false,
    '221058', 'M', 'Anglo-Chinese School (Independent)', 'Royal Varuna Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 6, '6', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 5, '5', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 5, '5', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 10, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 11, 6, '6', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 12, 4, '4', NULL, false, now(), now()
  );

  -- Competitor: Sarah Rui-En Yong
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sarah Rui-En Yong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sarah Rui-En Yong', 'sarah-rui-en-yong', '18', 'Royal Varuna Yacht Club', 'Nanyang Polytechnic', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
      school = COALESCE(sailors.school, 'Nanyang Polytechnic'),
      gender = COALESCE(sailors.gender, 'F'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 5, 67, 47, false, false,
    '18', 'F', 'Nanyang Polytechnic', 'Royal Varuna Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 5, '5', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 7, '7', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 11, '11', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 9, '9', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 7, '7', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 10, 7, '7', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 11, 5, '5', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 12, 5, '5', NULL, false, now(), now()
  );

  -- Competitor: Keira Carlyle
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Keira Carlyle')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Keira Carlyle', 'keira-carlyle', '25', 'SAF Yacht Club', NULL, 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      school = COALESCE(sailors.school, NULL),
      gender = COALESCE(sailors.gender, 'F'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 6, 65, 49, false, false,
    '25', 'F', NULL, 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 8, '8', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 8, '8', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 7, '7', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 6, '6', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 6, '6', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 5, '5', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 6, '6', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 10, 6, '6', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 11, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 12, 3, '3', NULL, false, now(), now()
  );

  -- Competitor: Zixi Lu
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zixi Lu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zixi Lu', 'zixi-lu', '214664', 'Changi Sailing Club', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Changi Sailing Club'),
      school = COALESCE(sailors.school, NULL),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 7, 110, 80, false, false,
    '214664', 'M', NULL, 'Changi Sailing Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 6, '6', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 8, '8', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 5, '5', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 5, '5', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 13, '13', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 8, '8', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 9, '9', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 11, '11', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 12, '12', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 10, 17, 'DNC 17', 'DNC', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 11, 8, '8', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 12, 8, '8', NULL, false, now(), now()
  );

  -- Competitor: Asher-James Nair
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Asher-James Nair')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Asher-James Nair', 'asher-james-nair', '185201', 'PAssion Wave', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'PAssion Wave'),
      school = COALESCE(sailors.school, 'St. Joseph''s Institution'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 8, 117, 87, false, false,
    '185201', 'M', 'St. Joseph''s Institution', 'PAssion Wave', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 14, '14', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 12, '12', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 15, '15', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 15, '15', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 8, '8', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 7, '7', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 10, '10', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 8, '8', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 9, '9', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 10, 5, '5', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 11, 7, '7', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 12, 7, '7', NULL, false, now(), now()
  );

  -- Competitor: Darren Lai
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Darren Lai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Darren Lai', 'darren-lai', '222257', 'Royal Varuna Yacht Club', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
      school = COALESCE(sailors.school, 'St. Joseph''s Institution'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 9, 119, 91, false, false,
    '222257', 'M', 'St. Joseph''s Institution', 'Royal Varuna Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 10, '10', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 11, '11', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 6, '6', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 7, '7', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 11, '11', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 14, '14', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 14, '14', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 10, '10', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 10, 9, '9', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 11, 13, '13', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 12, 10, '10', NULL, false, now(), now()
  );

  -- Competitor: Jonathan Jian Yi Ho
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jonathan Jian Yi Ho')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jonathan Jian Yi Ho', 'jonathan-jian-yi-ho', '214848', 'PAssion Wave', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'PAssion Wave'),
      school = COALESCE(sailors.school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 10, 118, 94, false, false,
    '214848', 'M', 'Anglo-Chinese School (Independent)', 'PAssion Wave', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 11, '11', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 7, '7', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 12, '12', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 9, '9', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 12, '12', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 12, '12', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 11, '11', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 6, '6', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 8, '8', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 10, 11, '11', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 11, 10, '10', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 12, 9, '9', NULL, false, now(), now()
  );

  -- Competitor: Jayden Teo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jayden Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jayden Teo', 'jayden-teo', '214813', 'PAssion Wave', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'PAssion Wave'),
      school = COALESCE(sailors.school, 'St. Joseph''s Institution'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 11, 125, 98, false, false,
    '214813', 'M', 'St. Joseph''s Institution', 'PAssion Wave', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 13, '13', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 13, '13', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 10, '10', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 10, '10', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 9, '9', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 14, '14', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 7, '7', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 12, '12', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 7, '7', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 10, 8, '8', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 11, 11, '11', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 12, 11, '11', NULL, false, now(), now()
  );

  -- Competitor: Cleo En Rui Seah
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cleo En Rui Seah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cleo En Rui Seah', 'cleo-en-rui-seah', '224379', 'SAF Yacht Club', 'Ngee Ann Polytechnic', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      school = COALESCE(sailors.school, 'Ngee Ann Polytechnic'),
      gender = COALESCE(sailors.gender, 'F'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 12, 131, 100, false, false,
    '224379', 'F', 'Ngee Ann Polytechnic', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 16, '16', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 10, '10', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 14, '14', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 13, '13', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 11, '11', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 5, '5', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 12, '12', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 9, '9', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 15, '15', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 10, 13, '13', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 11, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 12, 12, '12', NULL, false, now(), now()
  );

  -- Competitor: Josiah Zhi En Tan
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Josiah Zhi En Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Josiah Zhi En Tan', 'josiah-zhi-en-tan', '1978', 'ONE°15 Marina', 'Victoria School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'ONE°15 Marina'),
      school = COALESCE(sailors.school, 'Victoria School'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 13, 133, 105, false, false,
    '1978', 'M', 'Victoria School', 'ONE°15 Marina', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 12, '12', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 5, '5', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 13, '13', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 12, '12', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 14, '14', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 10, '10', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 6, '6', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 13, '13', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 11, '11', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 10, 10, '10', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 11, 14, '14', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 12, 13, '13', NULL, false, now(), now()
  );

  -- Competitor: Elizabeth Victoria Say
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elizabeth Victoria Say')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elizabeth Victoria Say', 'elizabeth-victoria-say', '214873', 'Royal Varuna Yacht Club', 'Dunman High School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
      school = COALESCE(sailors.school, 'Dunman High School'),
      gender = COALESCE(sailors.gender, 'F'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 14, 146, 115, false, false,
    '214873', 'F', 'Dunman High School', 'Royal Varuna Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 9, '9', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 15, '15', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 11, '11', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 16, '16', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 10, '10', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 13, '13', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 13, '13', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 10, '10', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 14, '14', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 10, 12, '12', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 11, 9, '9', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 12, 14, '14', NULL, false, now(), now()
  );

  -- Competitor: Yuei Jit Foo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuei Jit Foo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuei Jit Foo', 'yuei-jit-foo', '221686', 'PAssion Wave', 'Anderson Serangoon Junior College', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'PAssion Wave'),
      school = COALESCE(sailors.school, 'Anderson Serangoon Junior College'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 15, 169, 135, false, false,
    '221686', 'M', 'Anderson Serangoon Junior College', 'PAssion Wave', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 7, '7', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 9, '9', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 9, '9', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 8, '8', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 17, 'DNC 17', 'DNC', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 17, 'DNC 17', 'DNC', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 17, 'DNC 17', 'DNC', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 17, 'DNC 17', 'DNC', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 17, 'DNC 17', 'DNC', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 10, 17, 'DNC 17', 'DNC', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 11, 17, 'DNC 17', 'DNC', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 12, 17, 'DNC 17', 'DNC', false, now(), now()
  );

  -- Competitor: Arabelle En Xi Tan
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Arabelle En Xi Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Arabelle En Xi Tan', 'arabelle-en-xi-tan', '221690', 'PAssion Wave', 'Tanjong Katong Girls'' School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'PAssion Wave'),
      school = COALESCE(sailors.school, 'Tanjong Katong Girls'' School'),
      gender = COALESCE(sailors.gender, 'F'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 16, 177, 145, false, false,
    '221690', 'F', 'Tanjong Katong Girls'' School', 'PAssion Wave', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 15, '15', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 14, '14', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 16, '16', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 14, '14', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 15, '15', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 16, 'DNF 16', 'DNF', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 15, '15', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 15, '15', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 13, '13', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 10, 14, '14', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 11, 15, '15', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 12, 15, '15', NULL, false, now(), now()
  );

END $$;

-- ============================================================================
-- Regatta: Temasek Regatta 2026 (ILCA 6) (temasek-2026-ilca-6)
-- ============================================================================
DO $$
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'temasek-2026-ilca-6' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = 'Temasek Regatta 2026 (ILCA 6)',
      date = '2026-06-20',
      end_date = '2026-06-21',
      boat_class = 'ILCA 6',
      division = 'Open',
      total_fleet_size = 11,
      race_count = 5,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/13596/event',
      schedule_notes = 'Temasek Regatta 2026 ILCA 6 fleet: 11 entries, 5 races sailed (1 discard).',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, schedule_notes, created_at, updated_at
    ) VALUES (
      v_reg_id, 'Temasek Regatta 2026 (ILCA 6)', 'temasek-2026-ilca-6', '2026-06-20', '2026-06-21', 'ILCA 6', 'Open', 11, 5,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation', 'https://www.racingrulesofsailing.org/documents/13596/event', 'Temasek Regatta 2026 ILCA 6 fleet: 11 entries, 5 races sailed (1 discard).', now(), now()
    );
  END IF;

  -- Remove prior results for clean idempotent re-import
  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Keira Marie Carlyle
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Keira Marie Carlyle')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Keira Marie Carlyle', 'keira-marie-carlyle', '225225', 'SAF Yacht Club', NULL, 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      school = COALESCE(sailors.school, NULL),
      gender = COALESCE(sailors.gender, 'F'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 1, 8, 5, false, false,
    '225225', 'F', NULL, 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 3, '3', NULL, true, now(), now()
  );

  -- Competitor: Kenan Kee Zen Tan
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kenan Kee Zen Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kenan Kee Zen Tan', 'kenan-kee-zen-tan', '1', 'Royal Varuna Yacht Club', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
      school = COALESCE(sailors.school, NULL),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 2, 13, 8, false, false,
    '1', 'M', NULL, 'Royal Varuna Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 5, '5', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 1, '1', NULL, false, now(), now()
  );

  -- Competitor: Nia Zahedi
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nia Zahedi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nia Zahedi', 'nia-zahedi', '224245', 'PAssion Wave', 'Raffles Institution', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'PAssion Wave'),
      school = COALESCE(sailors.school, 'Raffles Institution'),
      gender = COALESCE(sailors.gender, 'F'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 3, 16, 11, false, false,
    '224245', 'F', 'Raffles Institution', 'PAssion Wave', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 5, '5', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 2, '2', NULL, false, now(), now()
  );

  -- Competitor: Sarah Rui-En Yong
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sarah Rui-En Yong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sarah Rui-En Yong', 'sarah-rui-en-yong', '221689', 'Royal Varuna Yacht Club', 'Nanyang Polytechnic', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
      school = COALESCE(sailors.school, 'Nanyang Polytechnic'),
      gender = COALESCE(sailors.gender, 'F'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 4, 24, 14, false, false,
    '221689', 'F', 'Nanyang Polytechnic', 'Royal Varuna Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 6, '6', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 10, '10', NULL, true, now(), now()
  );

  -- Competitor: Gabi Oh
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gabi Oh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gabi Oh', 'gabi-oh', '224717', 'SAF Yacht Club', 'Raffles Institution', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      school = COALESCE(sailors.school, 'Raffles Institution'),
      gender = COALESCE(sailors.gender, 'F'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 5, 26, 18, false, false,
    '224717', 'F', 'Raffles Institution', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 7, '7', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 8, '8', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 4, '4', NULL, false, now(), now()
  );

  -- Competitor: Austin Jia Yu Yeo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Austin Jia Yu Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Austin Jia Yu Yeo', 'austin-jia-yu-yeo', '221062', 'SAF Yacht Club', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      school = COALESCE(sailors.school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 6, 27, 20, false, false,
    '221062', 'M', 'Anglo-Chinese School (Independent)', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 5, '5', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 6, '6', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 5, '5', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 7, '7', NULL, true, now(), now()
  );

  -- Competitor: Gordon Alexander Allan
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gordon Alexander Allan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gordon Alexander Allan', 'gordon-alexander-allan', '221058', 'Royal Varuna Yacht Club', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
      school = COALESCE(sailors.school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 7, 36, 27, false, false,
    '221058', 'M', 'Anglo-Chinese School (Independent)', 'Royal Varuna Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 8, '8', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 6, '6', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 7, '7', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 6, '6', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 9, '9', NULL, true, now(), now()
  );

  -- Competitor: Cleo En Rui Seah
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cleo En Rui Seah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cleo En Rui Seah', 'cleo-en-rui-seah', '224379', 'SAF Yacht Club', 'Ngee Ann Polytechnic', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      school = COALESCE(sailors.school, 'Ngee Ann Polytechnic'),
      gender = COALESCE(sailors.gender, 'F'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 8, 41, 31, false, false,
    '224379', 'F', 'Ngee Ann Polytechnic', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 9, '9', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 8, '8', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 8, '8', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 10, '10', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 6, '6', NULL, false, now(), now()
  );

  -- Competitor: Jayden Teo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jayden Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jayden Teo', 'jayden-teo', '228158', 'PAssion Wave', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'PAssion Wave'),
      school = COALESCE(sailors.school, 'St. Joseph''s Institution'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 9, 43, 31, false, false,
    '228158', 'M', 'St. Joseph''s Institution', 'PAssion Wave', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 7, '7', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 9, '9', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 12, '12 DSQ', 'DSQ', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 7, '7', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 8, '8', NULL, false, now(), now()
  );

  -- Competitor: Darren Lai
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Darren Lai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Darren Lai', 'darren-lai', '222257', 'Royal Varuna Yacht Club', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
      school = COALESCE(sailors.school, 'St. Joseph''s Institution'),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 10, 48, 36, false, false,
    '222257', 'M', 'St. Joseph''s Institution', 'Royal Varuna Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 10, '10', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 12, '12 DSQ', 'DSQ', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 10, '10', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 11, '11', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 5, '5', NULL, false, now(), now()
  );

  -- Competitor: Elizabeth Victoria Say
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elizabeth Victoria Say')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elizabeth Victoria Say', 'elizabeth-victoria-say', '214873', 'PAssion Wave', 'Dunman High School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'PAssion Wave'),
      school = COALESCE(sailors.school, 'Dunman High School'),
      gender = COALESCE(sailors.gender, 'F'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 11, 50, 39, false, false,
    '214873', 'F', 'Dunman High School', 'PAssion Wave', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 11, '11', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 10, '10', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 9, '9', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 9, '9', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 11, '11', NULL, false, now(), now()
  );

END $$;

-- ============================================================================
-- Regatta: Temasek Regatta 2026 (ILCA 7) (temasek-2026-ilca-7)
-- ============================================================================
DO $$
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'temasek-2026-ilca-7' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = 'Temasek Regatta 2026 (ILCA 7)',
      date = '2026-06-20',
      end_date = '2026-06-21',
      boat_class = 'ILCA 7',
      division = 'Open',
      total_fleet_size = 7,
      race_count = 5,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/13596/event',
      schedule_notes = 'Temasek Regatta 2026 ILCA 7 fleet: 7 entries, 5 races sailed (1 discard).',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, schedule_notes, created_at, updated_at
    ) VALUES (
      v_reg_id, 'Temasek Regatta 2026 (ILCA 7)', 'temasek-2026-ilca-7', '2026-06-20', '2026-06-21', 'ILCA 7', 'Open', 7, 5,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation', 'https://www.racingrulesofsailing.org/documents/13596/event', 'Temasek Regatta 2026 ILCA 7 fleet: 7 entries, 5 races sailed (1 discard).', now(), now()
    );
  END IF;

  -- Remove prior results for clean idempotent re-import
  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Andrew Crombie
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Andrew Crombie')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Andrew Crombie', 'andrew-crombie', '224714', 'Changi Sailing Club', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Changi Sailing Club'),
      school = COALESCE(sailors.school, NULL),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 1, 9, 6, false, false,
    '224714', 'M', NULL, 'Changi Sailing Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 3, '3', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 2, '2', NULL, false, now(), now()
  );

  -- Competitor: Yeo Ngak Hoe
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yeo Ngak Hoe')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yeo Ngak Hoe', 'yeo-ngak-hoe', '193939', 'Constant Wind SeaSports', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
      school = COALESCE(sailors.school, NULL),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 2, 15, 10, false, false,
    '193939', 'M', NULL, 'Constant Wind SeaSports', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 5, '5', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 1, '1', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 4, '4', NULL, false, now(), now()
  );

  -- Competitor: Rohit Behl
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rohit Behl')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rohit Behl', 'rohit-behl', '224860', 'Changi Sailing Club', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Changi Sailing Club'),
      school = COALESCE(sailors.school, NULL),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 3, 14, 10, false, false,
    '224860', 'M', NULL, 'Changi Sailing Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 4, '4', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 1, '1', NULL, false, now(), now()
  );

  -- Competitor: Sarfraz Ahmad Khan
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sarfraz Ahmad Khan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sarfraz Ahmad Khan', 'sarfraz-ahmad-khan', '222436', 'Constant Wind SeaSports', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
      school = COALESCE(sailors.school, NULL),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 4, 18, 13, false, false,
    '222436', 'M', NULL, 'Constant Wind SeaSports', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 3, '3', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 5, '5', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 5, '5', NULL, false, now(), now()
  );

  -- Competitor: Lucien Franciscus Henricus van Riel
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lucien Franciscus Henricus van Riel')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lucien Franciscus Henricus van Riel', 'lucien-franciscus-henricus-van-riel', '193945', 'Constant Wind SeaSports', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
      school = COALESCE(sailors.school, NULL),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 5, 19, 14, false, false,
    '193945', 'M', NULL, 'Constant Wind SeaSports', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 5, '5', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 5, '5', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 4, '4', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 2, '2', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 3, '3', NULL, false, now(), now()
  );

  -- Competitor: Romzi Damiri
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Romzi Damiri')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Romzi Damiri', 'romzi-damiri', '218246', 'SAF Yacht Club', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      school = COALESCE(sailors.school, NULL),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 6, 32, 24, false, false,
    '218246', 'M', NULL, 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 6, '6', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 6, '6', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 6, '6', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 6, '6', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 8, '8 DNS', 'DNS', true, now(), now()
  );

  -- Competitor: Justiin Ang
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Justiin Ang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Justiin Ang', 'justiin-ang', '158031', 'Constant Wind SeaSports', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
      school = COALESCE(sailors.school, NULL),
      gender = COALESCE(sailors.gender, 'M'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, school, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 7, 40, 32, true, false,
    '158031', 'M', NULL, 'Constant Wind SeaSports', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 8, '8 DNC', 'DNC', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 8, '8 DNC', 'DNC', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 8, '8 DNC', 'DNC', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 8, '8 DNC', 'DNC', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 8, '8 DNC', 'DNC', false, now(), now()
  );

END $$;
