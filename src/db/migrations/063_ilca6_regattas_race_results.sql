-- 063_ilca6_regattas_race_results.sql
-- Import official race-by-race results for Cincapura Regatta 2026, Pesta Sukan 2026, and SNSC 2026 (ILCA 6 Class)
-- Source: Official Sailwave scoring sheets, Singapore Sailing Federation

-- ============================================================================
-- Regatta: Cincapura Regatta 2026 (ILCA 6) (cincapura-regatta-2026-ilca-6)
-- ============================================================================

DO $$
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'cincapura-regatta-2026-ilca-6' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = 'Cincapura Regatta 2026 (ILCA 6)',
      date = '2026-07-20',
      end_date = '2026-07-21',
      boat_class = 'ILCA 6',
      division = 'Open',
      total_fleet_size = 16,
      race_count = 3,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/14587/event',
      registration_url = 'https://www.sailing.org.sg/events/356060',
      schedule_notes = 'Cincapura Regatta 2026 ILCA 6 fleet: 16 entries, 3 races sailed (no discards).',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, created_at, updated_at
    ) VALUES (
      v_reg_id, 'Cincapura Regatta 2026 (ILCA 6)', 'cincapura-regatta-2026-ilca-6', '2026-07-20', '2026-07-21', 'ILCA 6', 'Open', 16, 3,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation', 'https://www.racingrulesofsailing.org/documents/14587/event', 'https://www.sailing.org.sg/events/356060', 'Cincapura Regatta 2026 ILCA 6 fleet: 16 entries, 3 races sailed (no discards).', now(), now()
    );
  END IF;

  -- Remove prior results for clean idempotent re-import
  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Sarah Rui-En Yong
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sarah Rui-En Yong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sarah Rui-En Yong', 'sarah-rui-en-yong-8oyt', '221689', 'Royal Varuna Yacht Club', 'Nanyang Polytechnic', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '221689'),
      club = COALESCE(club, 'Royal Varuna Yacht Club'),
      school = COALESCE(school, 'Nanyang Polytechnic'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 1, 6, 6, false, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 2, NULL, false, '2', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 2, NULL, false, '2', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 2, NULL, false, '2', now(), now()
  );
  -- Competitor: Keira Carlyle
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Keira Carlyle')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Keira Carlyle', 'keira-carlyle-xca8', '225225', 'SAF Yacht Club', 'Nanyang Polytechnic', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '225225'),
      club = COALESCE(club, 'SAF Yacht Club'),
      school = COALESCE(school, 'Nanyang Polytechnic'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 2, 7, 7, false, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 3, NULL, false, '3', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 1, NULL, false, '1', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 3, NULL, false, '3', now(), now()
  );
  -- Competitor: Kenan Kee Zen Tan
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kenan Kee Zen Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kenan Kee Zen Tan', 'kenan-kee-zen-tan-ma16', '1', 'Royal Varuna Yacht Club', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '1'),
      club = COALESCE(club, 'Royal Varuna Yacht Club'),
      school = COALESCE(school, NULL),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 3, 9, 9, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 5, NULL, false, '5', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 3, NULL, false, '3', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 1, NULL, false, '1', now(), now()
  );
  -- Competitor: Nia Zahedi
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nia Zahedi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nia Zahedi', 'nia-zahedi-56mn', '224245', 'PAssion Wave', 'Raffles Institution', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '224245'),
      club = COALESCE(club, 'PAssion Wave'),
      school = COALESCE(school, 'Raffles Institution'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 4, 12, 12, false, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 1, NULL, false, '1', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 6, NULL, false, '6', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 5, NULL, false, '5', now(), now()
  );
  -- Competitor: Gabi Oh
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gabi Oh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gabi Oh', 'gabi-oh-vgy9', '224717', 'SAF Yacht Club', 'Raffles Institution', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '224717'),
      club = COALESCE(club, 'SAF Yacht Club'),
      school = COALESCE(school, 'Raffles Institution'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 5, 19, 19, false, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 6, NULL, false, '6', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 7, NULL, false, '7', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 6, NULL, false, '6', now(), now()
  );
  -- Competitor: Kai Lun Wong
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kai Lun Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kai Lun Wong', 'kai-lun-wong-arbn', '227462', 'PAssion Wave', 'Bowen Secondary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '227462'),
      club = COALESCE(club, 'PAssion Wave'),
      school = COALESCE(school, 'Bowen Secondary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 6, 21, 21, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 7, NULL, false, '7', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 5, NULL, false, '5', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 9, NULL, false, '9', now(), now()
  );
  -- Competitor: Jayden Teo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jayden Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jayden Teo', 'jayden-teo-31ym', '228158', 'PAssion Wave', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '228158'),
      club = COALESCE(club, 'PAssion Wave'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 7, 23, 23, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 9, NULL, false, '9', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 4, NULL, false, '4', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 10, NULL, false, '10', now(), now()
  );
  -- Competitor: Gordon Alexander Allan
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gordon Alexander Allan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gordon Alexander Allan', 'gordon-alexander-allan-8jph', '221058', 'Royal Varuna Yacht Club', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '221058'),
      club = COALESCE(club, 'Royal Varuna Yacht Club'),
      school = COALESCE(school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 8, 25, 25, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 10, NULL, false, '10', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 8, NULL, false, '8', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 7, NULL, false, '7', now(), now()
  );
  -- Competitor: Cleo En Rui Seah
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cleo En Rui Seah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cleo En Rui Seah', 'cleo-en-rui-seah-9zmf', '224379', 'SAF Yacht Club', 'Ngee Ann Polytechnic', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '224379'),
      club = COALESCE(club, 'SAF Yacht Club'),
      school = COALESCE(school, 'Ngee Ann Polytechnic'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 9, 26, 26, false, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 4, NULL, false, '4', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 11, NULL, false, '11', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 11, NULL, false, '11', now(), now()
  );
  -- Competitor: Justiin Ang
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Justiin Ang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Justiin Ang', 'justiin-ang-eb2e', '158031', 'Constant Wind SeaSports', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '158031'),
      club = COALESCE(club, 'Constant Wind SeaSports'),
      school = COALESCE(school, NULL),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 10, 27, 27, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 11, NULL, false, '11', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 12, NULL, false, '12', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 4, NULL, false, '4', now(), now()
  );
  -- Competitor: Yuei Jit Foo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuei Jit Foo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuei Jit Foo', 'yuei-jit-foo-xj1m', '221686', 'PAssion Wave', 'Anderson Serangoon Junior College', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '221686'),
      club = COALESCE(club, 'PAssion Wave'),
      school = COALESCE(school, 'Anderson Serangoon Junior College'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 11, 30, 30, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 13, NULL, false, '13', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 9, NULL, false, '9', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 8, NULL, false, '8', now(), now()
  );
  -- Competitor: Travis Jia Le Yeo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Travis Jia Le Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Travis Jia Le Yeo', 'travis-jia-le-yeo-99ly', '222727', 'SAF Yacht Club', 'Raffles Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '222727'),
      club = COALESCE(club, 'SAF Yacht Club'),
      school = COALESCE(school, 'Raffles Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 12, 30, 30, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 8, NULL, false, '8', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 10, NULL, false, '10', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 12, NULL, false, '12', now(), now()
  );
  -- Competitor: Sarfraz Ahmad Khan
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sarfraz Ahmad Khan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sarfraz Ahmad Khan', 'sarfraz-ahmad-khan-iing', '223871', 'Constant Wind SeaSports', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '223871'),
      club = COALESCE(club, 'Constant Wind SeaSports'),
      school = COALESCE(school, NULL),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 13, 40, 40, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 12, NULL, false, '12', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 14, NULL, false, '14', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 14, NULL, false, '14', now(), now()
  );
  -- Competitor: Darren Lai
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Darren Lai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Darren Lai', 'darren-lai-4mpm', '222257', 'Royal Varuna Yacht Club', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '222257'),
      club = COALESCE(club, 'Royal Varuna Yacht Club'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 14, 40, 40, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 14, NULL, false, '14', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 13, NULL, false, '13', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 13, NULL, false, '13', now(), now()
  );
  -- Competitor: Rohit Behl
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rohit Behl')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rohit Behl', 'rohit-behl-ca7z', '221931', 'Changi Sailing Club', NULL, 'M', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '221931'),
      club = COALESCE(club, 'Changi Sailing Club'),
      school = COALESCE(school, NULL),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 15, 47, 47, false, false, 'M', 'IND', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 15, NULL, false, '15', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 17, 'NSC', false, '17 NSC', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 15, NULL, false, '15', now(), now()
  );
  -- Competitor: Elizabeth Victoria Say
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elizabeth Victoria Say')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elizabeth Victoria Say', 'elizabeth-victoria-say-r5rw', '214873', 'PAssion Wave', 'Dunman High School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '214873'),
      club = COALESCE(club, 'PAssion Wave'),
      school = COALESCE(school, 'Dunman High School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 16, 51, 51, false, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 17, 'SCP', false, '17 SCP', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 17, 'RET', false, '17 RET', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 17, 'RET', false, '17 RET', now(), now()
  );
END $$;

-- ============================================================================
-- Regatta: Pesta Sukan 2026 (ILCA 6) (pesta-sukan-2026-ilca-6)
-- ============================================================================

DO $$
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'pesta-sukan-2026-ilca-6' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = 'Pesta Sukan 2026 (ILCA 6)',
      date = '2026-08-01',
      end_date = '2026-08-03',
      boat_class = 'ILCA 6',
      division = 'Open',
      total_fleet_size = 21,
      race_count = 5,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/14397/event?name=pesta-sukan-2026',
      registration_url = 'https://www.sailing.org.sg/events/351968',
      schedule_notes = 'Pesta Sukan Regatta 2026 ILCA 6 fleet: 21 entries, 5 races sailed (1 discard).',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, created_at, updated_at
    ) VALUES (
      v_reg_id, 'Pesta Sukan 2026 (ILCA 6)', 'pesta-sukan-2026-ilca-6', '2026-08-01', '2026-08-03', 'ILCA 6', 'Open', 21, 5,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation', 'https://www.racingrulesofsailing.org/documents/14397/event?name=pesta-sukan-2026', 'https://www.sailing.org.sg/events/351968', 'Pesta Sukan Regatta 2026 ILCA 6 fleet: 21 entries, 5 races sailed (1 discard).', now(), now()
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
      v_sailor_id, 'Kenan Kee Zen Tan', 'kenan-kee-zen-tan-vml8', '1', 'Royal Varuna Yacht Club', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '1'),
      club = COALESCE(club, 'Royal Varuna Yacht Club'),
      school = COALESCE(school, NULL),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 1, 7, 11, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 1, NULL, false, '1', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 4, NULL, true, '(4)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 1, NULL, false, '1', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 1, NULL, false, '1', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 4, NULL, false, '4', now(), now()
  );
  -- Competitor: Austin Jia Yu Yeo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Austin Jia Yu Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Austin Jia Yu Yeo', 'austin-jia-yu-yeo-g1y6', '221062', 'SAF Yacht Club', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '221062'),
      club = COALESCE(club, 'SAF Yacht Club'),
      school = COALESCE(school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 2, 7, 12, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 2, NULL, false, '2', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 1, NULL, false, '1', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 2, NULL, false, '2', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 2, NULL, false, '2', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 5, NULL, true, '(5)', now(), now()
  );
  -- Competitor: Keira Carlyle
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Keira Carlyle')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Keira Carlyle', 'keira-carlyle-me7b', '225225', 'SAF Yacht Club', NULL, 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '225225'),
      club = COALESCE(club, 'SAF Yacht Club'),
      school = COALESCE(school, NULL),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 3, 11, 15, false, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 3, NULL, false, '3', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 2, NULL, false, '2', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 4, NULL, true, '(4)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 4, NULL, false, '4', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 2, NULL, false, '2', now(), now()
  );
  -- Competitor: Nia Zahedi
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nia Zahedi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nia Zahedi', 'nia-zahedi-b07f', '224245', 'PAssion Wave', 'Raffles Institution', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '224245'),
      club = COALESCE(club, 'PAssion Wave'),
      school = COALESCE(school, 'Raffles Institution'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 4, 15, 23, false, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 4, NULL, false, '4', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 5, NULL, false, '5', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 3, NULL, false, '3', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 8, NULL, true, '(8)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 3, NULL, false, '3', now(), now()
  );
  -- Competitor: Gordon Alexander Allan
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gordon Alexander Allan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gordon Alexander Allan', 'gordon-alexander-allan-x50x', '221058', 'Royal Varuna Yacht Club', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '221058'),
      club = COALESCE(club, 'Royal Varuna Yacht Club'),
      school = COALESCE(school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 5, 22, 34, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 11, NULL, false, '11', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 3, NULL, false, '3', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 5, NULL, false, '5', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 3, NULL, false, '3', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 12, NULL, true, '(12)', now(), now()
  );
  -- Competitor: Gabi Oh
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gabi Oh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gabi Oh', 'gabi-oh-phr8', '224717', 'SAF Yacht Club', 'Raffles Institution', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '224717'),
      club = COALESCE(club, 'SAF Yacht Club'),
      school = COALESCE(school, 'Raffles Institution'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 6, 25, 35, false, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 6, NULL, false, '6', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 8, NULL, false, '8', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 6, NULL, false, '6', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 5, NULL, false, '5', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 10, NULL, true, '(10)', now(), now()
  );
  -- Competitor: Sarah Rui-En Yong
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sarah Rui-En Yong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sarah Rui-En Yong', 'sarah-rui-en-yong-d2o6', '222743', 'Royal Varuna Yacht Club', 'Nanyang Polytechnic', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '222743'),
      club = COALESCE(club, 'Royal Varuna Yacht Club'),
      school = COALESCE(school, 'Nanyang Polytechnic'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 7, 25, 32, false, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 5, NULL, false, '5', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 6, NULL, false, '6', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 7, NULL, true, '(7)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 7, NULL, false, '7', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 7, NULL, false, '7', now(), now()
  );
  -- Competitor: Kai Lun Wong
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kai Lun Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kai Lun Wong', 'kai-lun-wong-w4ex', '227462', 'PAssion Wave', 'Bowen Secondary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '227462'),
      club = COALESCE(club, 'PAssion Wave'),
      school = COALESCE(school, 'Bowen Secondary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 8, 29, 38, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 9, NULL, true, '(9)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 9, NULL, false, '9', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 8, NULL, false, '8', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 6, NULL, false, '6', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 6, NULL, false, '6', now(), now()
  );
  -- Competitor: Charlotte Wee Shuen Lee
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Charlotte Wee Shuen Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Charlotte Wee Shuen Lee', 'charlotte-wee-shuen-lee-mgoh', '214235', 'Royal Varuna Yacht Club', NULL, 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '214235'),
      club = COALESCE(club, 'Royal Varuna Yacht Club'),
      school = COALESCE(school, NULL),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 9, 31, 43, false, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 8, NULL, false, '8', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 11, NULL, false, '11', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 12, NULL, true, '(12)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 11, NULL, false, '11', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 1, NULL, false, '1', now(), now()
  );
  -- Competitor: Jayden Teo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jayden Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jayden Teo', 'jayden-teo-zdlb', '228158', 'PAssion Wave', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '228158'),
      club = COALESCE(club, 'PAssion Wave'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 10, 34, 44, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 7, NULL, false, '7', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 10, NULL, true, '(10)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 9, NULL, false, '9', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 10, NULL, false, '10', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 8, NULL, false, '8', now(), now()
  );
  -- Competitor: Yuei Jit Foo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuei Jit Foo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuei Jit Foo', 'yuei-jit-foo-556b', '221686', 'PAssion Wave', 'Anderson Serangoon Junior College', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '221686'),
      club = COALESCE(club, 'PAssion Wave'),
      school = COALESCE(school, 'Anderson Serangoon Junior College'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 11, 37, 50, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 10, NULL, false, '10', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 7, NULL, false, '7', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 11, NULL, false, '11', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 9, NULL, false, '9', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 13, NULL, true, '(13)', now(), now()
  );
  -- Competitor: Darren Lai
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Darren Lai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Darren Lai', 'darren-lai-4s1c', '222257', 'Royal Varuna Yacht Club', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '222257'),
      club = COALESCE(club, 'Royal Varuna Yacht Club'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 12, 47, 63, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 13, NULL, false, '13', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 12, NULL, false, '12', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 10, NULL, false, '10', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 12, NULL, false, '12', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 16, NULL, true, '(16)', now(), now()
  );
  -- Competitor: Darius Xian Rui Low
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Darius Xian Rui Low')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Darius Xian Rui Low', 'darius-xian-rui-low-1icn', '8', 'PAssion Wave', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '8'),
      club = COALESCE(club, 'PAssion Wave'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 13, 52, 67, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 15, NULL, true, '(15)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 15, NULL, false, '15', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 14, NULL, false, '14', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 14, NULL, false, '14', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 9, NULL, false, '9', now(), now()
  );
  -- Competitor: Cleo En Rui Seah
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cleo En Rui Seah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cleo En Rui Seah', 'cleo-en-rui-seah-qxfb', '224379', 'SAF Yacht Club', 'Ngee Ann Polytechnic', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '224379'),
      club = COALESCE(club, 'SAF Yacht Club'),
      school = COALESCE(school, 'Ngee Ann Polytechnic'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 14, 52, 68, false, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 12, NULL, false, '12', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 14, NULL, false, '14', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 16, NULL, true, '(16)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 15, NULL, false, '15', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 11, NULL, false, '11', now(), now()
  );
  -- Competitor: Rohit Behl
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rohit Behl')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rohit Behl', 'rohit-behl-ztyq', '221931', 'Changi Sailing Club', NULL, 'M', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '221931'),
      club = COALESCE(club, 'Changi Sailing Club'),
      school = COALESCE(school, NULL),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 15, 56, 74, false, false, 'M', 'IND', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 14, NULL, false, '14', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 13, NULL, false, '13', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 13, NULL, false, '13', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 16, NULL, false, '16', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 18, NULL, true, '(18)', now(), now()
  );
  -- Competitor: Elizabeth Victoria Say
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elizabeth Victoria Say')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elizabeth Victoria Say', 'elizabeth-victoria-say-t35w', '214873', 'PAssion Wave', 'Dunman High School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '214873'),
      club = COALESCE(club, 'PAssion Wave'),
      school = COALESCE(school, 'Dunman High School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 16, 59, 75, false, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 16, NULL, true, '(16)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 16, NULL, false, '16', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 15, NULL, false, '15', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 13, NULL, false, '13', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 15, NULL, false, '15', now(), now()
  );
  -- Competitor: Tiffany Teo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tiffany Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tiffany Teo', 'tiffany-teo-92zm', '214813', 'PAssion Wave', 'Bedok South Secondary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '214813'),
      club = COALESCE(club, 'PAssion Wave'),
      school = COALESCE(school, 'Bedok South Secondary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 17, 66, 85, false, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 19, NULL, true, '(19)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 17, NULL, false, '17', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 18, NULL, false, '18', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 17, NULL, false, '17', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 14, NULL, false, '14', now(), now()
  );
  -- Competitor: Travis Jia Le Yeo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Travis Jia Le Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Travis Jia Le Yeo', 'travis-jia-le-yeo-nspq', '222727', 'SAF Yacht Club', 'Raffles Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '222727'),
      club = COALESCE(club, 'SAF Yacht Club'),
      school = COALESCE(school, 'Raffles Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 18, 71, 93, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 17, NULL, false, '17', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 19, NULL, false, '19', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 17, NULL, false, '17', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 18, NULL, false, '18', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 22, 'DNC', true, '(22 DNC)', now(), now()
  );
  -- Competitor: Sarfraz Ahmad Khan
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sarfraz Ahmad Khan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sarfraz Ahmad Khan', 'sarfraz-ahmad-khan-1ffp', '193871', 'Constant Wind SeaSports', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '193871'),
      club = COALESCE(club, 'Constant Wind SeaSports'),
      school = COALESCE(school, NULL),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 19, 72, 91, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 18, NULL, false, '18', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 18, NULL, false, '18', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 19, NULL, true, '(19)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 19, NULL, false, '19', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 17, NULL, false, '17', now(), now()
  );
  -- Competitor: Justiin Ang
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Justiin Ang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Justiin Ang', 'justiin-ang-x4k2', '158031', 'Constant Wind SeaSports', 'Rosyth School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '158031'),
      club = COALESCE(club, 'Constant Wind SeaSports'),
      school = COALESCE(school, 'Rosyth School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 20, 88, 110, true, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 22, 'DNC', true, '(22 DNC)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 22, 'DNC', false, '22 DNC', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 22, 'DNC', false, '22 DNC', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 22, 'DNC', false, '22 DNC', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 22, 'DNC', false, '22 DNC', now(), now()
  );
  -- Competitor: Bryan Chan
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Bryan Chan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Bryan Chan', 'bryan-chan-x6i2', '197850', 'SAF Yacht Club', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '197850'),
      club = COALESCE(club, 'SAF Yacht Club'),
      school = COALESCE(school, NULL),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 20, 88, 110, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 22, 'DNF', true, '(22 DNF)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 22, 'RET', false, '22 RET', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 22, 'DNF', false, '22 DNF', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 22, 'RET', false, '22 RET', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 22, 'DNF', false, '22 DNF', now(), now()
  );
END $$;

-- ============================================================================
-- Regatta: Singapore National Sailing Championships 2026 (ILCA 6) (snsc-ilca-6-sep-26)
-- ============================================================================

DO $$
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'snsc-ilca-6-sep-26' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = 'Singapore National Sailing Championships 2026 (ILCA 6)',
      date = '2026-09-11',
      end_date = '2026-09-15',
      boat_class = 'ILCA 6',
      division = 'Open',
      total_fleet_size = 19,
      race_count = 9,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/14487/event',
      registration_url = 'https://www.sailing.org.sg/events/323705',
      schedule_notes = 'Singapore National Sailing Championships 2026 ILCA 6 fleet: 19 entries, 9 races sailed (1 discard).',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, created_at, updated_at
    ) VALUES (
      v_reg_id, 'Singapore National Sailing Championships 2026 (ILCA 6)', 'snsc-ilca-6-sep-26', '2026-09-11', '2026-09-15', 'ILCA 6', 'Open', 19, 9,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation', 'https://www.racingrulesofsailing.org/documents/14487/event', 'https://www.sailing.org.sg/events/323705', 'Singapore National Sailing Championships 2026 ILCA 6 fleet: 19 entries, 9 races sailed (1 discard).', now(), now()
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
      v_sailor_id, 'Kenan Kee Zen Tan', 'kenan-kee-zen-tan-l28l', '221060', 'Royal Varuna Yacht Club', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '221060'),
      club = COALESCE(club, 'Royal Varuna Yacht Club'),
      school = COALESCE(school, NULL),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 1, 15, 23, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 1, NULL, false, '1', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 1, NULL, false, '1', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 2, NULL, false, '2', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 8, NULL, true, '(8)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 1, NULL, false, '1', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 1, NULL, false, '1', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 1, NULL, false, '1', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 1, NULL, false, '1', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 7, NULL, false, '7', now(), now()
  );
  -- Competitor: Keira Carlyle
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Keira Carlyle')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Keira Carlyle', 'keira-carlyle-n98m', '225225', 'SAF Yacht Club', NULL, 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '225225'),
      club = COALESCE(club, 'SAF Yacht Club'),
      school = COALESCE(school, NULL),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 2, 23, 33, false, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 2, NULL, false, '2', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 3, NULL, false, '3', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 4, NULL, false, '4', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 1, NULL, false, '1', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 2, NULL, false, '2', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 3, NULL, false, '3', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 4, NULL, false, '4', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 10, NULL, true, '(10)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 4, NULL, false, '4', now(), now()
  );
  -- Competitor: Sarah Rui-En Yong
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sarah Rui-En Yong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sarah Rui-En Yong', 'sarah-rui-en-yong-cj8j', '221689', 'Royal Varuna Yacht Club', 'Nanyang Polytechnic', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '221689'),
      club = COALESCE(club, 'Royal Varuna Yacht Club'),
      school = COALESCE(school, 'Nanyang Polytechnic'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 3, 29, 40, false, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 4, NULL, false, '4', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 9, NULL, false, '9', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 1, NULL, false, '1', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 3, NULL, false, '3', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 3, NULL, false, '3', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 2, NULL, false, '2', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 6, NULL, false, '6', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 11, NULL, true, '(11)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 1, NULL, false, '1', now(), now()
  );
  -- Competitor: Austin Jia Yu Yeo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Austin Jia Yu Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Austin Jia Yu Yeo', 'austin-jia-yu-yeo-gftc', '221062', 'SAF Yacht Club', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '221062'),
      club = COALESCE(club, 'SAF Yacht Club'),
      school = COALESCE(school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 4, 37, 49, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 11, NULL, false, '11', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 2, NULL, false, '2', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 5, NULL, false, '5', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 6, NULL, false, '6', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 12, NULL, true, '(12)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 4, NULL, false, '4', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 2, NULL, false, '2', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 4, NULL, false, '4', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 3, NULL, false, '3', now(), now()
  );
  -- Competitor: Nia Zahedi
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nia Zahedi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nia Zahedi', 'nia-zahedi-qdbr', '224245', 'PAssion Wave', 'Raffles Institution', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '224245'),
      club = COALESCE(club, 'PAssion Wave'),
      school = COALESCE(school, 'Raffles Institution'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 5, 42, 62, false, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 3, NULL, false, '3', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 11, NULL, false, '11', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 6, NULL, false, '6', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 2, NULL, false, '2', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 8, NULL, false, '8', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 7, NULL, false, '7', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 3, NULL, false, '3', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 20, 'UFD', true, '(20 UFD)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 2, NULL, false, '2', now(), now()
  );
  -- Competitor: Misa Lim Laurie
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Misa Lim Laurie')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Misa Lim Laurie', 'misa-lim-laurie-d06k', '223202', 'Changi Sailing Club', 'Singapore American School', 'F', 'USA', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '223202'),
      club = COALESCE(club, 'Changi Sailing Club'),
      school = COALESCE(school, 'Singapore American School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'USA'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 6, 52, 63, false, false, 'F', 'USA', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 5, NULL, false, '5', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 6, NULL, false, '6', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 10, NULL, false, '10', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 4, NULL, false, '4', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 6, NULL, false, '6', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 6, NULL, false, '6', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 10, NULL, false, '10', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 5, NULL, false, '5', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 11, NULL, true, '(11)', now(), now()
  );
  -- Competitor: Gabi Oh
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gabi Oh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gabi Oh', 'gabi-oh-w2jc', '224717', 'SAF Yacht Club', 'Raffles Institution', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '224717'),
      club = COALESCE(club, 'SAF Yacht Club'),
      school = COALESCE(school, 'Raffles Institution'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 7, 57, 69, false, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 12, NULL, true, '(12)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 5, NULL, false, '5', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 7, NULL, false, '7', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 9, NULL, false, '9', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 4, NULL, false, '4', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 12, NULL, false, '12', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 8, NULL, false, '8', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 7, NULL, false, '7', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 5, NULL, false, '5', now(), now()
  );
  -- Competitor: Gordon Alexander Allan
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gordon Alexander Allan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gordon Alexander Allan', 'gordon-alexander-allan-06u4', '221058', 'Royal Varuna Yacht Club', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '221058'),
      club = COALESCE(club, 'Royal Varuna Yacht Club'),
      school = COALESCE(school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 8, 64, 79, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 9, NULL, false, '9', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 4, NULL, false, '4', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 9, NULL, false, '9', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 15, NULL, true, '(15)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 11, NULL, false, '11', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 11, NULL, false, '11', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 7, NULL, false, '7', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 3, NULL, false, '3', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 10, NULL, false, '10', now(), now()
  );
  -- Competitor: Jayden Teo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jayden Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jayden Teo', 'jayden-teo-fk9i', '228158', 'PAssion Wave', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '228158'),
      club = COALESCE(club, 'PAssion Wave'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 9, 71, 85, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 10, NULL, false, '10', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 13, NULL, false, '13', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 11, NULL, false, '11', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 13, NULL, false, '13', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 5, NULL, false, '5', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 8, NULL, false, '8', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 5, NULL, false, '5', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 6, NULL, false, '6', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 14, NULL, true, '(14)', now(), now()
  );
  -- Competitor: Justiin Ang
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Justiin Ang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Justiin Ang', 'justiin-ang-8t7p', '158031', 'Constant Wind SeaSports', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '158031'),
      club = COALESCE(club, 'Constant Wind SeaSports'),
      school = COALESCE(school, NULL),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 10, 71, 91, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 20, 'DNC', true, '(20 DNC)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 20, 'DNC', false, '20 DNC', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 8, NULL, false, '8', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 5, NULL, false, '5', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 7, NULL, false, '7', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 5, NULL, false, '5', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 9, NULL, false, '9', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 8, 'DPI', false, '8 DPI', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 9, NULL, false, '9', now(), now()
  );
  -- Competitor: Kai Lun Wong
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kai Lun Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kai Lun Wong', 'kai-lun-wong-tue3', '227462', 'PAssion Wave', 'Bowen Secondary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '227462'),
      club = COALESCE(club, 'PAssion Wave'),
      school = COALESCE(school, 'Bowen Secondary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 11, 72, 84, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 7, NULL, false, '7', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 7, NULL, false, '7', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 12, NULL, true, '(12)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 11, NULL, false, '11', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 10, NULL, false, '10', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 10, NULL, false, '10', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 11, NULL, false, '11', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 8, NULL, false, '8', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 8, NULL, false, '8', now(), now()
  );
  -- Competitor: Cleo En Rui Seah
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cleo En Rui Seah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cleo En Rui Seah', 'cleo-en-rui-seah-tnge', '224379', 'SAF Yacht Club', 'Ngee Ann Polytechnic', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '224379'),
      club = COALESCE(club, 'SAF Yacht Club'),
      school = COALESCE(school, 'Ngee Ann Polytechnic'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 12, 75, 88, false, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 6, NULL, false, '6', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 10, NULL, false, '10', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 13, NULL, true, '(13)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 10, NULL, false, '10', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 9, NULL, false, '9', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 9, NULL, false, '9', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 13, NULL, false, '13', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 12, NULL, false, '12', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 6, NULL, false, '6', now(), now()
  );
  -- Competitor: Darren Lai
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Darren Lai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Darren Lai', 'darren-lai-kwen', '222257', 'Royal Varuna Yacht Club', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '222257'),
      club = COALESCE(club, 'Royal Varuna Yacht Club'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 13, 97, 113, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 8, NULL, false, '8', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 8, NULL, false, '8', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 16, NULL, true, '(16)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 12, NULL, false, '12', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 14, NULL, false, '14', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 16, NULL, false, '16', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 15, NULL, false, '15', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 9, NULL, false, '9', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 15, NULL, false, '15', now(), now()
  );
  -- Competitor: Tiffany Teo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tiffany Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tiffany Teo', 'tiffany-teo-ijpd', '214813', 'PAssion Wave', 'Bedok South Secondary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '214813'),
      club = COALESCE(club, 'PAssion Wave'),
      school = COALESCE(school, 'Bedok South Secondary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 14, 112, 129, false, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 13, NULL, false, '13', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 15, NULL, false, '15', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 15, NULL, false, '15', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 17, NULL, true, '(17)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 13, NULL, false, '13', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 13, NULL, false, '13', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 16, NULL, false, '16', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 15, NULL, false, '15', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 12, NULL, false, '12', now(), now()
  );
  -- Competitor: Travis Jia Le Yeo
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Travis Jia Le Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Travis Jia Le Yeo', 'travis-jia-le-yeo-0bod', '222727', 'SAF Yacht Club', 'Raffles Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '222727'),
      club = COALESCE(club, 'SAF Yacht Club'),
      school = COALESCE(school, 'Raffles Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 15, 113, 130, false, false, 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 15, NULL, false, '15', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 12, NULL, false, '12', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 17, NULL, true, '(17)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 16, NULL, false, '16', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 16, NULL, false, '16', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 14, NULL, false, '14', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 14, NULL, false, '14', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 13, NULL, false, '13', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 13, NULL, false, '13', now(), now()
  );
  -- Competitor: Rohit Behl
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rohit Behl')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rohit Behl', 'rohit-behl-ak31', '221931', 'Changi Sailing Club', NULL, 'M', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '221931'),
      club = COALESCE(club, 'Changi Sailing Club'),
      school = COALESCE(school, NULL),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 16, 121, 141, false, false, 'M', 'IND', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 14, NULL, false, '14', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 14, NULL, false, '14', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 14, NULL, false, '14', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 14, NULL, false, '14', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 17, NULL, false, '17', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 20, 'RET', true, '(20 RET)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 12, NULL, false, '12', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 20, 'UFD', false, '20 UFD', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 16, NULL, false, '16', now(), now()
  );
  -- Competitor: Lucien Franciscus Henricus van Riel
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lucien Franciscus Henricus van Riel')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lucien Franciscus Henricus van Riel', 'lucien-franciscus-henricus-van-riel-2km7', '207763', 'Constant Wind SeaSports', NULL, 'M', 'NED', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '207763'),
      club = COALESCE(club, 'Constant Wind SeaSports'),
      school = COALESCE(school, NULL),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'NED'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 17, 128, 146, false, false, 'M', 'NED', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 16, NULL, false, '16', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 16, NULL, false, '16', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 18, NULL, true, '(18)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 18, NULL, false, '18', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 15, NULL, false, '15', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 15, NULL, false, '15', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 17, NULL, false, '17', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 14, NULL, false, '14', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 17, NULL, false, '17', now(), now()
  );
  -- Competitor: Maia Lim Laurie
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Maia Lim Laurie')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Maia Lim Laurie', 'maia-lim-laurie-6vmk', '223201', 'Changi Sailing Club', 'Singapore American School', 'F', 'USA', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '223201'),
      club = COALESCE(club, 'Changi Sailing Club'),
      school = COALESCE(school, 'Singapore American School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'USA'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 18, 130, 150, false, false, 'F', 'USA', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 20, 'DNC', true, '(20 DNC)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 20, 'DNC', false, '20 DNC', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 3, NULL, false, '3', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 7, NULL, false, '7', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 20, 'RET', false, '20 RET', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 20, 'DNS', false, '20 DNS', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 20, 'DNC', false, '20 DNC', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 20, 'DNC', false, '20 DNC', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 20, 'DNC', false, '20 DNC', now(), now()
  );
  -- Competitor: Elizabeth Victoria Say
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elizabeth Victoria Say')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elizabeth Victoria Say', 'elizabeth-victoria-say-0apy', '214873', 'PAssion Wave', 'Dunman High School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number = COALESCE(sail_number, '214873'),
      club = COALESCE(club, 'PAssion Wave'),
      school = COALESCE(school, 'Dunman High School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, nett_score, total_score, is_dns, is_overseas_commitment, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 19, 160, 180, true, false, 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 20, 'DNC', true, '(20 DNC)', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 20, 'DNC', false, '20 DNC', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 20, 'DNC', false, '20 DNC', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 20, 'DNC', false, '20 DNC', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 20, 'DNC', false, '20 DNC', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 20, 'DNC', false, '20 DNC', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 20, 'DNC', false, '20 DNC', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 8, 20, 'DNC', false, '20 DNC', now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 9, 20, 'DNC', false, '20 DNC', now(), now()
  );
END $$;
