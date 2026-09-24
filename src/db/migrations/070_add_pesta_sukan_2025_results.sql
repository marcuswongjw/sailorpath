-- 070_add_pesta_sukan_2025_results.sql
-- Import official race-by-race results for Pesta Sukan Regatta 2025
-- Fleets: Optimist Gold (83 entries, 3 races), Optimist Silver (70 entries, 3 races), ILCA 4 (53 entries, 3 races), ILCA 6 (32 entries, 3 races)
-- Dates: 2–3 August 2025
-- Venue: National Sailing Centre, 1500 East Coast Parkway, Singapore 468963
-- Organiser: Singapore Sailing Federation
-- Source: Official Sailwave scoring sheets

-- ============================================================================
-- Regatta: Pesta Sukan Regatta 2025 (Optimist Gold) (pesta-sukan-gold-aug-25-2025-08-02)
-- ============================================================================
DO $$
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'pesta-sukan-gold-aug-25-2025-08-02' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = 'Pesta Sukan Regatta 2025 (Optimist Gold)',
      date = '2025-08-02',
      end_date = '2025-08-04',
      boat_class = 'Optimist',
      division = 'Gold',
      total_fleet_size = 83,
      race_count = 3,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/11535/event?name=Pesta%2520Sukan%25202025',
      official_notice_board_url = 'https://www.racingrulesofsailing.org/documents/11535/event?name=Pesta%2520Sukan%25202025',
      registration_url = 'https://www.sailing.org.sg/events/293985',
      schedule_notes = 'Pesta Sukan Regatta 2025 Optimist Gold fleet: 83 entries, 3 races sailed (0 discards).',
      status = 'published',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, official_notice_board_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_reg_id, 'Pesta Sukan Regatta 2025 (Optimist Gold)', 'pesta-sukan-gold-aug-25-2025-08-02', '2025-08-02', '2025-08-04', 'Optimist', 'Gold', 83, 3,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation', 'https://www.racingrulesofsailing.org/documents/11535/event?name=Pesta%2520Sukan%25202025', 'https://www.racingrulesofsailing.org/documents/11535/event?name=Pesta%2520Sukan%25202025', 'https://www.sailing.org.sg/events/293985', 'Pesta Sukan Regatta 2025 Optimist Gold fleet: 83 entries, 3 races sailed (0 discards).', 'published', now(), now()
    );
  END IF;

  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Lucas Zhihong Cao (Rank 1)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lucas Zhihong Cao')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lucas Zhihong Cao', 'lucas-zhihong-cao-fe30ea', '149', 'SAFYC', 'Raffles Institution (Secondary)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '149'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Raffles Institution (Secondary)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 1, 10.0, 10.0, NULL, '149',
    'SAFYC', 'Raffles Institution (Secondary)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 7, 7.0, NULL, false, now(), now());

  -- Competitor: Sean Kok Wei Kum (Rank 2)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sean Kok Wei Kum')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sean Kok Wei Kum', 'sean-kok-wei-kum-bc88c9', '142', 'SAFYC', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '142'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 2, 10.0, 10.0, NULL, '142',
    'SAFYC', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 1, 1.0, NULL, false, now(), now());

  -- Competitor: Anya Alessia Zahedi (Rank 3)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Anya Alessia Zahedi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Anya Alessia Zahedi', 'anya-alessia-zahedi-ae097d', '159', 'PA', 'Tao Nan School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '159'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Tao Nan School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 3, 19.0, 19.0, '12&U', '159',
    'PA', 'Tao Nan School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 14, 14.0, NULL, false, now(), now());

  -- Competitor: Lyric Yuxuan Li (Rank 4)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lyric Yuxuan Li')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lyric Yuxuan Li', 'lyric-yuxuan-li-ab4af2', '728', 'CSC', 'Raffles Girls'' School (Secondary)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '728'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'Raffles Girls'' School (Secondary)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 4, 20.0, 20.0, NULL, '728',
    'CSC', 'Raffles Girls'' School (Secondary)', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 17, 17.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 2, 2.0, NULL, false, now(), now());

  -- Competitor: Mikaela Rae Ng (Rank 5)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mikaela Rae Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mikaela Rae Ng', 'mikaela-rae-ng-cdb1d2', '151', 'PA', 'Raffles Girls'' School (Secondary)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '151'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Raffles Girls'' School (Secondary)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 5, 27.0, 27.0, NULL, '151',
    'PA', 'Raffles Girls'' School (Secondary)', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 18, 18.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 5, 5.0, NULL, false, now(), now());

  -- Competitor: Zeph Wan (Rank 6)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zeph Wan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zeph Wan', 'zeph-wan-d5b087', '122', 'SAFYC', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '122'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 6, 28.0, 28.0, NULL, '122',
    'SAFYC', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 12, 12.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 13, 13.0, NULL, false, now(), now());

  -- Competitor: Desiree Yuet Chi Lee (Rank 7)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Desiree Yuet Chi Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Desiree Yuet Chi Lee', 'desiree-yuet-chi-lee-cc0655', '165', 'RVYC', 'Tanjong Katong Girls'' School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '165'),
      club = COALESCE(club, 'RVYC'),
      school = COALESCE(school, 'Tanjong Katong Girls'' School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 7, 28.0, 28.0, NULL, '165',
    'RVYC', 'Tanjong Katong Girls'' School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 15, 15.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 6, 6.0, NULL, false, now(), now());

  -- Competitor: Ashlyn Tham (Rank 8)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ashlyn Tham')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ashlyn Tham', 'ashlyn-tham-bf0752', '4452', 'RM', 'St. Hilda''s Secondary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '4452'),
      club = COALESCE(club, 'RM'),
      school = COALESCE(school, 'St. Hilda''s Secondary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 8, 32.0, 32.0, NULL, '4452',
    'RM', 'St. Hilda''s Secondary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 9, 9.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 8, 8.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 15, 15.0, NULL, false, now(), now());

  -- Competitor: Teck Woon Pee (Rank 9)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Teck Woon Pee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Teck Woon Pee', 'teck-woon-pee-23b040', '164', 'SAFYC', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '164'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 9, 34.0, 34.0, NULL, '164',
    'SAFYC', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 20, 20.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 8, 8.0, NULL, false, now(), now());

  -- Competitor: Ethan Han Wei Chia (Rank 10)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ethan Han Wei Chia')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ethan Han Wei Chia', 'ethan-han-wei-chia-2d98d4', '121', 'SAFYC', 'Raffles Institution (Secondary)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '121'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Raffles Institution (Secondary)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 10, 37.0, 37.0, NULL, '121',
    'SAFYC', 'Raffles Institution (Secondary)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 24, 24.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 10, 10.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 3, 3.0, NULL, false, now(), now());

  -- Competitor: Julien Christian Petracco (Rank 11)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Julien Christian Petracco')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Julien Christian Petracco', 'julien-christian-petracco-57b745', '3102', 'SAFYC', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3102'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 11, 38.0, 38.0, NULL, '3102',
    'SAFYC', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 11, 11.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 11, 11.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 16, 16.0, NULL, false, now(), now());

  -- Competitor: Nathaniel Kaiden Ng (Rank 12)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nathaniel Kaiden Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nathaniel Kaiden Ng', 'nathaniel-kaiden-ng-7678ef', '3344', 'PA', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3344'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 12, 46.0, 46.0, NULL, '3344',
    'PA', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 14, 14.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 26, 26.0, NULL, false, now(), now());

  -- Competitor: Rahul Rajakanth (Rank 13)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rahul Rajakanth')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rahul Rajakanth', 'rahul-rajakanth-99c268', '2006', 'CWSS', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2006'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 13, 54.0, 54.0, NULL, '2006',
    'CWSS', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 27, 27.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 17, 17.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 10, 10.0, NULL, false, now(), now());

  -- Competitor: Ethan Zhi Ren Low (Rank 14)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ethan Zhi Ren Low')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ethan Zhi Ren Low', 'ethan-zhi-ren-low-8d996e', '3855', 'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3855'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Hilda''s Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 14, 57.0, 57.0, '12&U', '3855',
    'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 38, 38.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 12, 12.0, NULL, false, now(), now());

  -- Competitor: Ashlea Tham (Rank 15)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ashlea Tham')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ashlea Tham', 'ashlea-tham-0cc4cc', '175', 'RM', 'Tanjong Katong Girls'' School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '175'),
      club = COALESCE(club, 'RM'),
      school = COALESCE(school, 'Tanjong Katong Girls'' School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 15, 59.0, 59.0, NULL, '175',
    'RM', 'Tanjong Katong Girls'' School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 42, 42.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 13, 13.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 4, 4.0, NULL, false, now(), now());

  -- Competitor: Jairus Xin Jie Teo (Rank 16)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jairus Xin Jie Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jairus Xin Jie Teo', 'jairus-xin-jie-teo-21b9cd', '4073', 'PA', 'St. Andrew''s Secondary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '4073'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'St. Andrew''s Secondary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 16, 65.0, 65.0, NULL, '4073',
    'PA', 'St. Andrew''s Secondary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 25, 25.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 16, 16.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 24, 24.0, NULL, false, now(), now());

  -- Competitor: Alyssa Li Lin Wong (Rank 17)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Alyssa Li Lin Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Alyssa Li Lin Wong', 'alyssa-li-lin-wong-b49aac', '150', 'SAFYC', 'Haig Girls'' School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '150'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Haig Girls'' School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 17, 69.0, 69.0, '12&U', '150',
    'SAFYC', 'Haig Girls'' School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 16, 16.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 21, 21.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 32, 32.0, NULL, false, now(), now());

  -- Competitor: Kirsten En Ting Tan (Rank 18)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kirsten En Ting Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kirsten En Ting Tan', 'kirsten-en-ting-tan-0f33f4', '3663', 'SAFYC', 'St. Hilda''s Primary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3663'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Hilda''s Primary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 18, 84.0, 84.0, '12&U', '3663',
    'SAFYC', 'St. Hilda''s Primary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 13, 13.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 9, 9.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 62, 62.0, NULL, false, now(), now());

  -- Competitor: Dylan Yue Teng Goh (Rank 19)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Dylan Yue Teng Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Dylan Yue Teng Goh', 'dylan-yue-teng-goh-7c204b', '3800', 'SAFYC', 'Victoria School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3800'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Victoria School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 19, 90.0, 90.0, NULL, '3800',
    'SAFYC', 'Victoria School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 55, 55.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 18, 18.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 17, 17.0, NULL, false, now(), now());

  -- Competitor: Shin Chen Rui Lin (Rank 20)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Shin Chen Rui Lin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Shin Chen Rui Lin', 'shin-chen-rui-lin-2cc7e1', '3333', 'SAFYC', 'Horizon Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3333'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Horizon Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 20, 104.0, 104.0, '12&U', '3333',
    'SAFYC', 'Horizon Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 44, 44.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 19, 19.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 41, 41.0, NULL, false, now(), now());

  -- Competitor: Germaine Sim (Rank 21)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Germaine Sim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Germaine Sim', 'germaine-sim-4d8ea0', '3177', 'RVYC', 'Tanjong Katong Girls'' School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3177'),
      club = COALESCE(club, 'RVYC'),
      school = COALESCE(school, 'Tanjong Katong Girls'' School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 21, 111.0, 111.0, NULL, '3177',
    'RVYC', 'Tanjong Katong Girls'' School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 8, 8.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 20, 20.0, NULL, false, now(), now());

  -- Competitor: Darian Huang (Rank 22)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Darian Huang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Darian Huang', 'darian-huang-25371f', '3700', 'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3700'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Hilda''s Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 22, 112.0, 112.0, '12&U', '3700',
    'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 10, 10.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 19, 19.0, NULL, false, now(), now());

  -- Competitor: Kevin Jun Yi Ho (Rank 23)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kevin Jun Yi Ho')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kevin Jun Yi Ho', 'kevin-jun-yi-ho-05b838', '3118', 'SAFYC', 'Raffles Institution (Secondary)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3118'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Raffles Institution (Secondary)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 23, 117.0, 117.0, NULL, '3118',
    'SAFYC', 'Raffles Institution (Secondary)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 23, 23.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 11, 11.0, NULL, false, now(), now());

  -- Competitor: Zhi Tong Wai (Rank 24)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zhi Tong Wai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zhi Tong Wai', 'zhi-tong-wai-2f448c', '157', 'SAFYC', 'CHIJ Secondary (Toa Payoh)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '157'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'CHIJ Secondary (Toa Payoh)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 24, 118.0, 118.0, NULL, '157',
    'SAFYC', 'CHIJ Secondary (Toa Payoh)', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 30, 30.0, NULL, false, now(), now());

  -- Competitor: Joel Zhuo Le Khoo (Rank 25)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joel Zhuo Le Khoo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joel Zhuo Le Khoo', 'joel-zhuo-le-khoo-356162', '4730', 'SAFYC', 'Nanyang Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '4730'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Nanyang Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 25, 127.0, 127.0, '12&U', '4730',
    'SAFYC', 'Nanyang Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 59, 59.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 20, 20.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 48, 48.0, NULL, false, now(), now());

  -- Competitor: Jaye Xi En Low (Rank 26)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jaye Xi En Low')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jaye Xi En Low', 'jaye-xi-en-low-005622', '3179', 'PA', 'Endeavour Primary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3179'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Endeavour Primary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 26, 129.0, 129.0, '12&U', '3179',
    'PA', 'Endeavour Primary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 19, 19.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 27, 27.0, NULL, false, now(), now());

  -- Competitor: Damien Huang (Rank 27)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Damien Huang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Damien Huang', 'damien-huang-9a6df0', '3300', 'SAFYC', 'Raffles Institution (Secondary)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3300'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Raffles Institution (Secondary)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 27, 130.0, 130.0, NULL, '3300',
    'SAFYC', 'Raffles Institution (Secondary)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 12, 12.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 35, 35.0, NULL, false, now(), now());

  -- Competitor: Elliot Goh (Rank 28)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elliot Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elliot Goh', 'elliot-goh-f98e4f', '3103', 'SAFYC', 'Henry Park Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3103'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Henry Park Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 28, 130.0, 130.0, '12&U', '3103',
    'SAFYC', 'Henry Park Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 22, 22.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 25, 25.0, NULL, false, now(), now());

  -- Competitor: Kaelyn Dayna Soh Zhi Yi (Rank 29)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kaelyn Dayna Soh Zhi Yi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kaelyn Dayna Soh Zhi Yi', 'kaelyn-dayna-soh-zhi-yi-6755cf', '3113', 'SAFYC', 'Raffles Girls'' School (Secondary)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3113'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Raffles Girls'' School (Secondary)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 29, 133.0, 133.0, NULL, '3113',
    'SAFYC', 'Raffles Girls'' School (Secondary)', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 41, 41.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 9, 9.0, NULL, false, now(), now());

  -- Competitor: Jeremiah Rui Feng Ong (Rank 30)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jeremiah Rui Feng Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jeremiah Rui Feng Ong', 'jeremiah-rui-feng-ong-01090b', '3373', 'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3373'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Hilda''s Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 30, 134.0, 134.0, '12&U', '3373',
    'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 29, 29.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 22.0, 'SCP', false, now(), now());

  -- Competitor: Elijah Ong (Rank 31)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elijah Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elijah Ong', 'elijah-ong-5c52e8', '140', 'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '140'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Hilda''s Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 31, 138.0, 138.0, '12&U', '140',
    'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 26, 26.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 29, 29.0, NULL, false, now(), now());

  -- Competitor: Nicole Jing Chen Wong (Rank 32)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nicole Jing Chen Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nicole Jing Chen Wong', 'nicole-jing-chen-wong-79b5c8', '3006', 'SAFYC', 'CHIJ Our Lady Queen of Peace', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3006'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'CHIJ Our Lady Queen of Peace'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 32, 141.0, 141.0, '12&U', '3006',
    'SAFYC', 'CHIJ Our Lady Queen of Peace', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 35, 35.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 23, 23.0, NULL, false, now(), now());

  -- Competitor: Siti Ra'idah Binte Mohd Airudin (Rank 33)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Siti Ra''idah Binte Mohd Airudin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Siti Ra''idah Binte Mohd Airudin', 'siti-ra-idah-binte-mohd-airudin-0b2b30', '112', 'PA', 'Northland Primary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '112'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Northland Primary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 33, 145.0, 145.0, '12&U', '112',
    'PA', 'Northland Primary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 15, 15.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 47, 47.0, NULL, false, now(), now());

  -- Competitor: Ethan Lee (Rank 34)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ethan Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ethan Lee', 'ethan-lee-b23306', '83', 'PA', 'Victoria School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '83'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Victoria School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 34, 145.0, 145.0, NULL, '83',
    'PA', 'Victoria School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 40, 40.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 22, 22.0, NULL, false, now(), now());

  -- Competitor: Edrei En Xu Ong (Rank 35)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Edrei En Xu Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Edrei En Xu Ong', 'edrei-en-xu-ong-81f5d4', '3957', 'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3957'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Hilda''s Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 35, 149.0, 149.0, '12&U', '3957',
    'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 45, 45.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 21, 21.0, NULL, false, now(), now());

  -- Competitor: Zachary Zhi En Low (Rank 36)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zachary Zhi En Low')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zachary Zhi En Low', 'zachary-zhi-en-low-b977e2', '3369', 'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3369'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Hilda''s Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 36, 150.0, 150.0, '12&U', '3369',
    'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 39, 39.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 28, 28.0, NULL, false, now(), now());

  -- Competitor: Padmaeja Rajakanth (Rank 37)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Padmaeja Rajakanth')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Padmaeja Rajakanth', 'padmaeja-rajakanth-dacf7c', '2022', 'CWSS', 'Raffles Girls'' Primary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2022'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Raffles Girls'' Primary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 37, 150.0, 150.0, '12&U', '2022',
    'CWSS', 'Raffles Girls'' Primary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 30, 30.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 37, 37.0, NULL, false, now(), now());

  -- Competitor: Jedd Zhi Hao Lam (Rank 38)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jedd Zhi Hao Lam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jedd Zhi Hao Lam', 'jedd-zhi-hao-lam-ff3c76', '2000', 'CWSS', 'Henry Park Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2000'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Henry Park Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 38, 150.0, 150.0, '12&U', '2000',
    'CWSS', 'Henry Park Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 31, 31.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 36, 36.0, NULL, false, now(), now());

  -- Competitor: Olivia Ting Jia Cheong (Rank 39)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Olivia Ting Jia Cheong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Olivia Ting Jia Cheong', 'olivia-ting-jia-cheong-86597a', '3002', 'SAFYC', 'Nan Hua Primary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3002'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Nan Hua Primary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 39, 151.0, 151.0, '12&U', '3002',
    'SAFYC', 'Nan Hua Primary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 28, 28.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 40, 40.0, NULL, false, now(), now());

  -- Competitor: Herng Yee Tan (Rank 40)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Herng Yee Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Herng Yee Tan', 'herng-yee-tan-a53487', '3000', 'SAFYC', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3000'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 40, 153.0, 153.0, NULL, '3000',
    'SAFYC', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 14, 14.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 56, 56.0, NULL, false, now(), now());

  -- Competitor: Luke Yi Jie Loh (Rank 41)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Luke Yi Jie Loh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Luke Yi Jie Loh', 'luke-yi-jie-loh-761d65', '3322', 'SAFYC', 'Tao Nan School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3322'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Tao Nan School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 41, 153.0, 153.0, '12&U', '3322',
    'SAFYC', 'Tao Nan School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 37, 37.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 33, 33.0, NULL, false, now(), now());

  -- Competitor: Lavene Rui Xuan Lim (Rank 42)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lavene Rui Xuan Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lavene Rui Xuan Lim', 'lavene-rui-xuan-lim-512d85', '3553', 'SAFYC', 'Pasir Ris Primary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3553'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Pasir Ris Primary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 42, 163.0, 163.0, '12&U', '3553',
    'SAFYC', 'Pasir Ris Primary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 49, 49.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 31, 31.0, NULL, false, now(), now());

  -- Competitor: Charlene Heng Ning Yong (Rank 43)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Charlene Heng Ning Yong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Charlene Heng Ning Yong', 'charlene-heng-ning-yong-c1e673', '766', 'CSC', 'Pasir Ris Primary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '766'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'Pasir Ris Primary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 43, 164.0, 164.0, '12&U', '766',
    'CSC', 'Pasir Ris Primary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 36, 36.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 45, 45.0, NULL, false, now(), now());

  -- Competitor: Joseph Kia Guan Tan (Rank 44)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joseph Kia Guan Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joseph Kia Guan Tan', 'joseph-kia-guan-tan-fd72d8', '3688', 'SAFYC', 'St. Joseph''s Institution Junior', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3688'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Joseph''s Institution Junior'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 44, 166.0, 166.0, '12&U', '3688',
    'SAFYC', 'St. Joseph''s Institution Junior', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 33, 33.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 50, 50.0, NULL, false, now(), now());

  -- Competitor: Jared Soon Kit Liew (Rank 45)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jared Soon Kit Liew')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jared Soon Kit Liew', 'jared-soon-kit-liew-b7e134', '2002', 'PA', 'Ngee Ann Secondary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2002'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Ngee Ann Secondary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 45, 172.0, 172.0, NULL, '2002',
    'PA', 'Ngee Ann Secondary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 34, 34.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 55, 55.0, NULL, false, now(), now());

  -- Competitor: Rui Ling Teo (Rank 46)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rui Ling Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rui Ling Teo', 'rui-ling-teo-ce86f2', '3820', 'SAFYC', 'CHIJ (Katong) Primary', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3820'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'CHIJ (Katong) Primary'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 46, 173.0, 173.0, '12&U', '3820',
    'SAFYC', 'CHIJ (Katong) Primary', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 48, 48.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 42, 42.0, NULL, false, now(), now());

  -- Competitor: Joash Kok Jit Yin (Rank 47)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joash Kok Jit Yin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joash Kok Jit Yin', 'joash-kok-jit-yin-7adce9', '3057', 'SAFYC', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3057'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 47, 175.0, 175.0, NULL, '3057',
    'SAFYC', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 21, 21.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 71, 71.0, NULL, false, now(), now());

  -- Competitor: Aaron Zhiyi Chiang (Rank 48)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aaron Zhiyi Chiang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aaron Zhiyi Chiang', 'aaron-zhiyi-chiang-a405ec', '3128', 'SAFYC', 'Tao Nan School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3128'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Tao Nan School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 48, 175.0, 175.0, '12&U', '3128',
    'SAFYC', 'Tao Nan School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 32, 32.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 60, 60.0, NULL, false, now(), now());

  -- Competitor: Timothy Kai Zhe Ng (Rank 49)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Timothy Kai Zhe Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Timothy Kai Zhe Ng', 'timothy-kai-zhe-ng-a52e47', '2023', 'CWSS', 'Tao Nan School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2023'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Tao Nan School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 49, 175.0, 175.0, '12&U', '2023',
    'CWSS', 'Tao Nan School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 54, 54.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 38.0, 'SCP', false, now(), now());

  -- Competitor: Yuk Pin Lim (Rank 50)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuk Pin Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuk Pin Lim', 'yuk-pin-lim-7cb081', '3880', 'SAFYC', 'Ai Tong School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3880'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Ai Tong School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 50, 177.0, 177.0, '12&U', '3880',
    'SAFYC', 'Ai Tong School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 43, 43.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 51, 51.0, NULL, false, now(), now());

  -- Competitor: Gerome Sim (Rank 51)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gerome Sim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gerome Sim', 'gerome-sim-2a8ad7', '3188', 'RVYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3188'),
      club = COALESCE(club, 'RVYC'),
      school = COALESCE(school, 'St. Hilda''s Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 51, 178.0, 178.0, '12&U', '3188',
    'RVYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 57, 57.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 38, 38.0, NULL, false, now(), now());

  -- Competitor: Kyle Jeremy Zhi Jun Soh (Rank 52)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kyle Jeremy Zhi Jun Soh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kyle Jeremy Zhi Jun Soh', 'kyle-jeremy-zhi-jun-soh-19d086', '3183', 'SAFYC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3183'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Junior)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 52, 181.0, 181.0, '12&U', '3183',
    'SAFYC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 52, 52.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 46, 46.0, NULL, false, now(), now());

  -- Competitor: Lucas Rui Kai Lim (Rank 53)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lucas Rui Kai Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lucas Rui Kai Lim', 'lucas-rui-kai-lim-f82310', '3355', 'SAFYC', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3355'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 53, 191.0, 191.0, NULL, '3355',
    'SAFYC', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 64, 64.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 44, 44.0, NULL, false, now(), now());

  -- Competitor: Gloria Yen Rui Kwok (Rank 54)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gloria Yen Rui Kwok')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gloria Yen Rui Kwok', 'gloria-yen-rui-kwok-21afa5', '2004', 'CWSS', 'CHIJ (Katong) Primary', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2004'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'CHIJ (Katong) Primary'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 54, 193.0, 193.0, '12&U', '2004',
    'CWSS', 'CHIJ (Katong) Primary', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 58, 58.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 52, 52.0, NULL, false, now(), now());

  -- Competitor: Yvette Yi Min Chow (Rank 55)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yvette Yi Min Chow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yvette Yi Min Chow', 'yvette-yi-min-chow-143df2', '3151', 'SAFYC', 'Pei Hwa Presbyterian Primary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3151'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Pei Hwa Presbyterian Primary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 55, 194.0, 194.0, '12&U, N', '3151',
    'SAFYC', 'Pei Hwa Presbyterian Primary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 68, 68.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 43, 43.0, NULL, false, now(), now());

  -- Competitor: Joel Han Sheng Ong (Rank 56)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joel Han Sheng Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joel Han Sheng Ong', 'joel-han-sheng-ong-fc5c58', '2014', 'CWSS', 'Tao Nan School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2014'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Tao Nan School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 56, 196.0, 196.0, '12&U', '2014',
    'CWSS', 'Tao Nan School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 74, 74.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 39, 39.0, NULL, false, now(), now());

  -- Competitor: Gemma Huan Heng Chen (Rank 57)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gemma Huan Heng Chen')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gemma Huan Heng Chen', 'gemma-huan-heng-chen-e4079a', '4729', 'PA', 'Raffles Girls'' School (Secondary)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '4729'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Raffles Girls'' School (Secondary)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 57, 196.0, 196.0, NULL, '4729',
    'PA', 'Raffles Girls'' School (Secondary)', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 50, 50.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 63, 63.0, NULL, false, now(), now());

  -- Competitor: Quintan Rupert Low (Rank 58)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Quintan Rupert Low')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Quintan Rupert Low', 'quintan-rupert-low-a71ef0', '4681', 'SAFYC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '4681'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Junior)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 58, 197.0, 197.0, '12&U, N', '4681',
    'SAFYC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 65, 65.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 49, 49.0, NULL, false, now(), now());

  -- Competitor: Rupert Chang (Rank 59)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rupert Chang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rupert Chang', 'rupert-chang-62df66', '4722', 'PA', 'Anglo-Chinese School (Primary)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '4722'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Anglo-Chinese School (Primary)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 59, 198.0, 198.0, '12&U', '4722',
    'PA', 'Anglo-Chinese School (Primary)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 51, 51.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 64, 64.0, NULL, false, now(), now());

  -- Competitor: Matthew Qin Hao Chiam (Rank 60)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Matthew Qin Hao Chiam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Matthew Qin Hao Chiam', 'matthew-qin-hao-chiam-c9d267', '3606', 'SAFYC', 'Ai Tong School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3606'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Ai Tong School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 60, 198.0, 198.0, '12&U, N', '3606',
    'SAFYC', 'Ai Tong School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 61, 61.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 54, 54.0, NULL, false, now(), now());

  -- Competitor: Kenji Huan Zhe Tan (Rank 61)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kenji Huan Zhe Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kenji Huan Zhe Tan', 'kenji-huan-zhe-tan-366045', '3999', 'SAFYC', 'Anderson Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3999'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Anderson Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 61, 199.0, 199.0, '12&U', '3999',
    'SAFYC', 'Anderson Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 63, 63.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 53, 53.0, NULL, false, now(), now());

  -- Competitor: Jude Nathan Wong (Rank 62)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jude Nathan Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jude Nathan Wong', 'jude-nathan-wong-3b3271', '3495', 'SAFYC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3495'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Junior)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 62, 201.0, 201.0, '12&U', '3495',
    'SAFYC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 60, 60.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 58, 58.0, NULL, false, now(), now());

  -- Competitor: Joshua Zhuo Xi Khoo (Rank 63)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joshua Zhuo Xi Khoo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joshua Zhuo Xi Khoo', 'joshua-zhuo-xi-khoo-a6cfde', '4728', 'SAFYC', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '4728'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 63, 202.0, 202.0, NULL, '4728',
    'SAFYC', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 62, 62.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 57, 57.0, NULL, false, now(), now());

  -- Competitor: Meera Srihari (Rank 64)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Meera Srihari')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Meera Srihari', 'meera-srihari-ef8935', '3889', 'SAFYC', 'Raffles Girls'' Primary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3889'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Raffles Girls'' Primary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 64, 203.0, 203.0, '12&U, N', '3889',
    'SAFYC', 'Raffles Girls'' Primary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 53, 53.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 67, 67.0, NULL, false, now(), now());

  -- Competitor: Aidan Armand Anuar (Rank 65)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aidan Armand Anuar')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aidan Armand Anuar', 'aidan-armand-anuar-260c6f', '3143', 'SAFYC', 'Tanjong Katong Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3143'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Tanjong Katong Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 65, 204.0, 204.0, '12&U, N', '3143',
    'SAFYC', 'Tanjong Katong Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 56, 56.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 65, 65.0, NULL, false, now(), now());

  -- Competitor: Gentaro Noah Lee (Rank 66)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gentaro Noah Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gentaro Noah Lee', 'gentaro-noah-lee-6fa55f', '4471', 'PA', 'Anglo-Chinese School (Primary)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '4471'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Anglo-Chinese School (Primary)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 66, 207.0, 207.0, '12&U, N', '4471',
    'PA', 'Anglo-Chinese School (Primary)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 46, 46.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 78, 78.0, NULL, false, now(), now());

  -- Competitor: Hagen Goh (Rank 67)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hagen Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hagen Goh', 'hagen-goh-4aff21', '3600', 'SAFYC', 'Dover Court International School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3600'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Dover Court International School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 67, 211.0, 211.0, '12&U, N', '3600',
    'SAFYC', 'Dover Court International School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 47, 47.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 81, 81.0, NULL, false, now(), now());

  -- Competitor: Dan Guan You Toh (Rank 68)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Dan Guan You Toh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Dan Guan You Toh', 'dan-guan-you-toh-9d5e75', '3811', 'SAFYC', 'Maris Stella High School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3811'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Maris Stella High School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 68, 213.0, 213.0, '12&U', '3811',
    'SAFYC', 'Maris Stella High School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 71, 71.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 59, 59.0, NULL, false, now(), now());

  -- Competitor: Rachel Qian Hui Lim (Rank 69)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rachel Qian Hui Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rachel Qian Hui Lim', 'rachel-qian-hui-lim-753183', '3197', 'SAFYC', 'Haig Girls'' School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3197'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Haig Girls'' School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 69, 216.0, 216.0, '12&U', '3197',
    'SAFYC', 'Haig Girls'' School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 67, 67.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 66, 66.0, NULL, false, now(), now());

  -- Competitor: Sage Yeh (Rank 70)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sage Yeh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sage Yeh', 'sage-yeh-474951', '796', 'CSC', 'Punggol Cove Primary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '796'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'Punggol Cove Primary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 70, 219.0, 219.0, '12&U, N', '796',
    'CSC', 'Punggol Cove Primary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 66, 66.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 70, 70.0, NULL, false, now(), now());

  -- Competitor: Charles Shing Chak Kong (Rank 71)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Charles Shing Chak Kong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Charles Shing Chak Kong', 'charles-shing-chak-kong-6c4226', '716', 'CSC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '716'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'Anglo-Chinese School (Junior)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 71, 221.0, 221.0, '12&U', '716',
    'CSC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 69, 69.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 69, 69.0, NULL, false, now(), now());

  -- Competitor: Mohamed Mikail Bin Mohd Shahrom (Rank 72)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mohamed Mikail Bin Mohd Shahrom')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mohamed Mikail Bin Mohd Shahrom', 'mohamed-mikail-bin-mohd-shahrom-f45299', '704', 'CSC', 'NA', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '704'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'NA'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 72, 222.0, 222.0, NULL, '704',
    'CSC', 'NA', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 78, 78.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 61, 61.0, NULL, false, now(), now());

  -- Competitor: Estelle Rui En Yeo (Rank 73)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Estelle Rui En Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Estelle Rui En Yeo', 'estelle-rui-en-yeo-65c255', '773', 'CSC', 'St. Hilda''s Primary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '773'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'St. Hilda''s Primary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 73, 230.0, 230.0, '12&U', '773',
    'CSC', 'St. Hilda''s Primary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 70, 70.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 77, 77.0, NULL, false, now(), now());

  -- Competitor: Denzel Seah (Rank 74)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Denzel Seah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Denzel Seah', 'denzel-seah-03ba84', '3925', 'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3925'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Hilda''s Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 74, 230.0, 230.0, '12&U, N', '3925',
    'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 73, 73.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 74, 74.0, NULL, false, now(), now());

  -- Competitor: Luke Tin Fong (Rank 75)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Luke Tin Fong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Luke Tin Fong', 'luke-tin-fong-d328d0', '2019', 'CWSS', 'Tao Nan School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2019'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Tao Nan School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 75, 231.0, 231.0, '12&U, N', '2019',
    'CWSS', 'Tao Nan School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 80, 80.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 68, 68.0, NULL, false, now(), now());

  -- Competitor: Xavier Yang Zheng Puah (Rank 76)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Xavier Yang Zheng Puah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Xavier Yang Zheng Puah', 'xavier-yang-zheng-puah-b7205b', '2037', 'CWSS', 'St. Joseph''s Institution Junior', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2037'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'St. Joseph''s Institution Junior'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 76, 234.0, 234.0, '12&U', '2037',
    'CWSS', 'St. Joseph''s Institution Junior', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 72, 72.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 79, 79.0, NULL, false, now(), now());

  -- Competitor: Yen-Yu Kai (Rank 77)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yen-Yu Kai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yen-Yu Kai', 'yen-yu-kai-681d1a', '758', 'CSC', 'Raffles Girls'' Primary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '758'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'Raffles Girls'' Primary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 77, 234.0, 234.0, '12&U', '758',
    'CSC', 'Raffles Girls'' Primary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 76, 76.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 75, 75.0, NULL, false, now(), now());

  -- Competitor: Euan Hao Xuan Poh (Rank 78)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Euan Hao Xuan Poh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Euan Hao Xuan Poh', 'euan-hao-xuan-poh-50a59b', '2030', 'CWSS', 'St. Stephen''s School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2030'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'St. Stephen''s School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 78, 234.0, 234.0, '12&U, N', '2030',
    'CWSS', 'St. Stephen''s School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 75, 75.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 76.0, 'SCP', false, now(), now());

  -- Competitor: Jamiroquai Kai Nuo Tay (Rank 79)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jamiroquai Kai Nuo Tay')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jamiroquai Kai Nuo Tay', 'jamiroquai-kai-nuo-tay-2e062e', '2013', 'SAFYC', 'Tao Nan School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2013'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Tao Nan School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 79, 235.0, 235.0, '12&U', '2013',
    'SAFYC', 'Tao Nan School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 79, 79.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 73, 73.0, NULL, false, now(), now());

  -- Competitor: Aiden Kang Jun Wong (Rank 80)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aiden Kang Jun Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aiden Kang Jun Wong', 'aiden-kang-jun-wong-015839', '2018', 'CWSS', 'Pei Chun Public School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2018'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Pei Chun Public School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 80, 241.0, 241.0, '12&U, N', '2018',
    'CWSS', 'Pei Chun Public School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 82, 82.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 76, 76.0, NULL, false, now(), now());

  -- Competitor: Tianyi Huang (Rank 81)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tianyi Huang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tianyi Huang', 'tianyi-huang-9f9e66', '3438', 'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3438'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Hilda''s Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 81, 242.0, 242.0, '12&U, N', '3438',
    'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 77, 77.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 82, 82.0, NULL, false, now(), now());

  -- Competitor: Kyan Chun Hong Tan (Rank 82)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kyan Chun Hong Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kyan Chun Hong Tan', 'kyan-chun-hong-tan-7a218a', '4712', 'SAFYC', 'Tao Nan School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '4712'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Tao Nan School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 82, 244.0, 244.0, '12&U', '4712',
    'SAFYC', 'Tao Nan School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 81, 81.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 83.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 80, 80.0, NULL, false, now(), now());

  -- Competitor: Worawit Jutahkiti (Rank 83)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Worawit Jutahkiti')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Worawit Jutahkiti', 'worawit-jutahkiti-5a5193', '2025', 'CWSS', 'Catholic High School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2025'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Catholic High School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 83, 252.0, 252.0, '12&U, N', '2025',
    'CWSS', 'Catholic High School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 84.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 84.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 84.0, 'DNC', false, now(), now());

END $$;

-- ============================================================================
-- Regatta: Pesta Sukan Regatta 2025 (Optimist Silver) (pesta-sukan-silver-aug-25-2025-08-02)
-- ============================================================================
DO $$
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'pesta-sukan-silver-aug-25-2025-08-02' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = 'Pesta Sukan Regatta 2025 (Optimist Silver)',
      date = '2025-08-02',
      end_date = '2025-08-04',
      boat_class = 'Optimist',
      division = 'Silver',
      total_fleet_size = 70,
      race_count = 3,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/11535/event?name=Pesta%2520Sukan%25202025',
      official_notice_board_url = 'https://www.racingrulesofsailing.org/documents/11535/event?name=Pesta%2520Sukan%25202025',
      registration_url = 'https://www.sailing.org.sg/events/293985',
      schedule_notes = 'Pesta Sukan Regatta 2025 Optimist Silver fleet: 70 entries, 3 races sailed (0 discards).',
      status = 'published',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, official_notice_board_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_reg_id, 'Pesta Sukan Regatta 2025 (Optimist Silver)', 'pesta-sukan-silver-aug-25-2025-08-02', '2025-08-02', '2025-08-04', 'Optimist', 'Silver', 70, 3,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation', 'https://www.racingrulesofsailing.org/documents/11535/event?name=Pesta%2520Sukan%25202025', 'https://www.racingrulesofsailing.org/documents/11535/event?name=Pesta%2520Sukan%25202025', 'https://www.sailing.org.sg/events/293985', 'Pesta Sukan Regatta 2025 Optimist Silver fleet: 70 entries, 3 races sailed (0 discards).', 'published', now(), now()
    );
  END IF;

  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Mikaela Hui Ting Wong (Rank 1)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mikaela Hui Ting Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mikaela Hui Ting Wong', 'mikaela-hui-ting-wong-ab4615', '3029', 'SAFYC', 'St. Hilda''s Primary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3029'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Hilda''s Primary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 1, 12.0, 12.0, '10&U', '3029',
    'SAFYC', 'St. Hilda''s Primary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 2, 2.0, NULL, false, now(), now());

  -- Competitor: Nigel Jiang Long Ng (Rank 2)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nigel Jiang Long Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nigel Jiang Long Ng', 'nigel-jiang-long-ng-4166ef', '3363', 'SAFYC', 'Endeavour Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3363'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Endeavour Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 2, 17.0, 17.0, '10&U', '3363',
    'SAFYC', 'Endeavour Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 9, 9.0, NULL, false, now(), now());

  -- Competitor: Joshua Zhi Kai Tan (Rank 3)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joshua Zhi Kai Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joshua Zhi Kai Tan', 'joshua-zhi-kai-tan-20cffc', '3036', 'SAFYC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3036'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Junior)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 3, 19.0, 19.0, NULL, '3036',
    'SAFYC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 12, 12.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 3, 3.0, NULL, false, now(), now());

  -- Competitor: William Poon (Rank 4)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('William Poon')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'William Poon', 'william-poon-89acee', '3005', 'SAFYC', 'Singapore American School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3005'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Singapore American School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 4, 19.0, 19.0, '10&U, N', '3005',
    'SAFYC', 'Singapore American School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 4, 4.0, NULL, false, now(), now());

  -- Competitor: Weihan Mao (Rank 5)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Weihan Mao')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Weihan Mao', 'weihan-mao-aca855', '3619', 'SAFYC', 'St. Hilda''s Primary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3619'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Hilda''s Primary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 5, 20.0, 20.0, NULL, '3619',
    'SAFYC', 'St. Hilda''s Primary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 16, 16.0, NULL, false, now(), now());

  -- Competitor: Abby Yan Ying Chen (Rank 6)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Abby Yan Ying Chen')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Abby Yan Ying Chen', 'abby-yan-ying-chen-584bbb', '4729', 'PA', 'CHIJ St. Nicholas Girls'' School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '4729'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'CHIJ St. Nicholas Girls'' School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 6, 23.0, 23.0, '10&U', '4729',
    'PA', 'CHIJ St. Nicholas Girls'' School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 9, 9.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 5, 5.0, NULL, false, now(), now());

  -- Competitor: Katelynn Kai En Lee (Rank 7)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Katelynn Kai En Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Katelynn Kai En Lee', 'katelynn-kai-en-lee-902fce', '3383', 'SAFYC', 'St. Anthony''s Canossian Primary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3383'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Anthony''s Canossian Primary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 7, 23.0, 23.0, 'N', '3383',
    'SAFYC', 'St. Anthony''s Canossian Primary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 8, 8.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 6, 6.0, NULL, false, now(), now());

  -- Competitor: Boren Wang (Rank 8)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Boren Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Boren Wang', 'boren-wang-9ae568', '2039', 'PA', 'Alexandra Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2039'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Alexandra Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 8, 24.0, 24.0, 'N', '2039',
    'PA', 'Alexandra Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 10, 10.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 13, 13.0, NULL, false, now(), now());

  -- Competitor: Lucas Jun Sheng Seow (Rank 9)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lucas Jun Sheng Seow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lucas Jun Sheng Seow', 'lucas-jun-sheng-seow-39f72a', '2047', 'CWSS', 'Tao Nan School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2047'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Tao Nan School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 9, 28.0, 28.0, 'N', '2047',
    'CWSS', 'Tao Nan School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 14, 14.0, NULL, false, now(), now());

  -- Competitor: Auwin Zhao Hong Leow (Rank 10)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Auwin Zhao Hong Leow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Auwin Zhao Hong Leow', 'auwin-zhao-hong-leow-17a492', '3405', 'SAFYC', 'Anglo-Chinese School (Primary)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3405'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Primary)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 10, 30.0, 30.0, '10&U', '3405',
    'SAFYC', 'Anglo-Chinese School (Primary)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 11, 11.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 10, 10.0, NULL, false, now(), now());

  -- Competitor: Tan Qi (Rank 11)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tan Qi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tan Qi', 'tan-qi-83b3b7', '3026', 'CWSS', 'Tao Nan School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3026'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Tao Nan School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 11, 34.0, 34.0, '10&U, N', '3026',
    'CWSS', 'Tao Nan School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 17, 17.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 8, 8.0, NULL, false, now(), now());

  -- Competitor: Breyven Zhi Long Chan (Rank 12)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Breyven Zhi Long Chan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Breyven Zhi Long Chan', 'breyven-zhi-long-chan-f10903', '3338', 'SAFYC', 'Endeavour Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3338'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Endeavour Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 12, 34.0, 34.0, NULL, '3338',
    'SAFYC', 'Endeavour Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 13, 13.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 12, 12.0, NULL, false, now(), now());

  -- Competitor: Hanyue Ouyang (Rank 13)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hanyue Ouyang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hanyue Ouyang', 'hanyue-ouyang-2356f6', '5003', 'ONE°15', 'Nanyang Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '5003'),
      club = COALESCE(club, 'ONE°15'),
      school = COALESCE(school, 'Nanyang Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 13, 35.0, 35.0, '10&U', '5003',
    'ONE°15', 'Nanyang Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 19, 19.0, NULL, false, now(), now());

  -- Competitor: Isabelle Xinyi Zhang (Rank 14)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isabelle Xinyi Zhang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isabelle Xinyi Zhang', 'isabelle-xinyi-zhang-5bd202', '2035', 'CWSS', 'Methodist Girls'' School (Primary)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2035'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Methodist Girls'' School (Primary)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 14, 35.0, 35.0, '10&U', '2035',
    'CWSS', 'Methodist Girls'' School (Primary)', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 15, 15.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 11, 11.0, NULL, false, now(), now());

  -- Competitor: George Kai Whittington (Rank 15)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('George Kai Whittington')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'George Kai Whittington', 'george-kai-whittington-0e11eb', '799', 'CSC', 'St. Stephen''s School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '799'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'St. Stephen''s School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 15, 40.0, 40.0, '10&U', '799',
    'CSC', 'St. Stephen''s School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 26, 26.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 7, 7.0, NULL, false, now(), now());

  -- Competitor: Ryan Yong Jie Choo (Rank 16)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ryan Yong Jie Choo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ryan Yong Jie Choo', 'ryan-yong-jie-choo-2e464b', '789', 'CSC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '789'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'Anglo-Chinese School (Junior)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 16, 46.0, 46.0, 'N', '789',
    'CSC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 36, 36.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 1, 1.0, NULL, false, now(), now());

  -- Competitor: Yasin Yusuf Yusfianshah (Rank 17)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yasin Yusuf Yusfianshah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yasin Yusuf Yusfianshah', 'yasin-yusuf-yusfianshah-87027c', '3575', 'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3575'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Hilda''s Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 17, 47.0, 47.0, '10&U, N', '3575',
    'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 21, 21.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 20, 20.0, NULL, false, now(), now());

  -- Competitor: Matthias Kai Lun Lee (Rank 18)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Matthias Kai Lun Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Matthias Kai Lun Lee', 'matthias-kai-lun-lee-c7dc02', '3385', 'SAFYC', 'Maris Stella High School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3385'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Maris Stella High School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 18, 47.0, 47.0, '8&U, 10&U, N', '3385',
    'SAFYC', 'Maris Stella High School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 23, 23.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 15, 15.0, NULL, false, now(), now());

  -- Competitor: Spencer Quek (Rank 19)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Spencer Quek')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Spencer Quek', 'spencer-quek-836b1f', '3108', 'SAFYC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3108'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Junior)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 19, 48.0, 48.0, NULL, '3108',
    'SAFYC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 14, 14.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 25, 25.0, NULL, false, now(), now());

  -- Competitor: Ashleigh Li Ying Teh (Rank 20)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ashleigh Li Ying Teh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ashleigh Li Ying Teh', 'ashleigh-li-ying-teh-121d62', '788', 'SAFYC', 'Tao Nan School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '788'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Tao Nan School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 20, 49.0, 49.0, '10&U, N', '788',
    'SAFYC', 'Tao Nan School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 18, 18.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 22, 22.0, NULL, false, now(), now());

  -- Competitor: Hayley Kai En Tan (Rank 21)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hayley Kai En Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hayley Kai En Tan', 'hayley-kai-en-tan-6f8c75', '700', 'CSC', 'Kong Hwa School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '700'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'Kong Hwa School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 21, 51.0, 51.0, '10&U', '700',
    'CSC', 'Kong Hwa School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 24, 24.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 18, 18.0, NULL, false, now(), now());

  -- Competitor: Tyler Koo (Rank 22)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tyler Koo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tyler Koo', 'tyler-koo-27d3bd', '996', 'RSYC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '996'),
      club = COALESCE(club, 'RSYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Junior)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 22, 51.0, 51.0, 'N', '996',
    'RSYC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 19, 19.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 23, 23.0, NULL, false, now(), now());

  -- Competitor: Jan Welzl (Rank 23)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jan Welzl')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jan Welzl', 'jan-welzl-05e288', '2033', 'CWSS', 'Tao Nan School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2033'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Tao Nan School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 23, 61.0, 61.0, '10&U', '2033',
    'CWSS', 'Tao Nan School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 28, 28.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 24, 24.0, NULL, false, now(), now());

  -- Competitor: Aidan See Hett Yeo (Rank 24)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aidan See Hett Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aidan See Hett Yeo', 'aidan-see-hett-yeo-72145a', '3112', 'SAFYC', 'Kuo Chuan Presbyterian Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3112'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Kuo Chuan Presbyterian Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 24, 63.0, 63.0, NULL, '3112',
    'SAFYC', 'Kuo Chuan Presbyterian Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 16, 16.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 38, 38.0, NULL, false, now(), now());

  -- Competitor: Evan En Kai Ong (Rank 25)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Evan En Kai Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Evan En Kai Ong', 'evan-en-kai-ong-595758', '3955', 'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3955'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Hilda''s Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 25, 63.0, 63.0, '8&U, 10&U', '3955',
    'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 20, 20.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 34, 34.0, NULL, false, now(), now());

  -- Competitor: Iver Zhe Xi Lee (Rank 26)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Iver Zhe Xi Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Iver Zhe Xi Lee', 'iver-zhe-xi-lee-118ddc', '3309', 'SAFYC', 'Endeavour Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3309'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Endeavour Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 26, 69.0, 69.0, '10&U', '3309',
    'SAFYC', 'Endeavour Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 43, 43.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 17, 17.0, NULL, false, now(), now());

  -- Competitor: Mitchell Shi Kai Lim (Rank 27)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mitchell Shi Kai Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mitchell Shi Kai Lim', 'mitchell-shi-kai-lim-36bd8f', '3323', 'SAFYC', 'Anglo-Chinese School (Primary)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3323'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Primary)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 27, 69.0, 69.0, '10&U', '3323',
    'SAFYC', 'Anglo-Chinese School (Primary)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 34, 34.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 26, 26.0, NULL, false, now(), now());

  -- Competitor: Clara Siew Ning Ng (Rank 28)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Clara Siew Ning Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Clara Siew Ning Ng', 'clara-siew-ning-ng-2163a1', '3739', 'SAFYC', 'St. Hilda''s Primary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3739'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Hilda''s Primary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 28, 69.0, 69.0, '10&U, N', '3739',
    'SAFYC', 'St. Hilda''s Primary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 33, 33.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 27, 27.0, NULL, false, now(), now());

  -- Competitor: Hayden Zi Xuan Soh (Rank 29)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hayden Zi Xuan Soh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hayden Zi Xuan Soh', 'hayden-zi-xuan-soh-1f3be8', '3838', 'SAFYC', 'White Sands Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3838'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'White Sands Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 29, 69.0, 69.0, 'N', '3838',
    'SAFYC', 'White Sands Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 30, 30.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 30, 30.0, NULL, false, now(), now());

  -- Competitor: Seraphina Kang (Rank 30)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Seraphina Kang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Seraphina Kang', 'seraphina-kang-897adb', '2040', 'CWSS', 'CHIJ Our Lady Queen of Peace', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2040'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'CHIJ Our Lady Queen of Peace'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 30, 72.0, 72.0, '10&U, N', '2040',
    'CWSS', 'CHIJ Our Lady Queen of Peace', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 35, 35.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 28, 28.0, NULL, false, now(), now());

  -- Competitor: Kai Jie Teo (Rank 31)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kai Jie Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kai Jie Teo', 'kai-jie-teo-a89e33', '3550', 'SAFYC', 'Tanjong Katong Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3550'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Tanjong Katong Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 31, 73.0, 73.0, '10&U, N', '3550',
    'SAFYC', 'Tanjong Katong Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 29, 29.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 35, 35.0, NULL, false, now(), now());

  -- Competitor: Christopher Soh (Rank 32)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Christopher Soh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Christopher Soh', 'christopher-soh-81c070', '3168', 'SAFYC', 'Tao Nan School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3168'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Tao Nan School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 32, 76.0, 76.0, '10&U', '3168',
    'SAFYC', 'Tao Nan School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 69.0, 'UFD', false, now(), now());

  -- Competitor: Zachary Yi Jie Koh (Rank 33)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zachary Yi Jie Koh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zachary Yi Jie Koh', 'zachary-yi-jie-koh-a83a6a', '4731', 'PA', 'Tao Nan School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '4731'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Tao Nan School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 33, 76.0, 76.0, NULL, '4731',
    'PA', 'Tao Nan School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 27, 27.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 40, 40.0, NULL, false, now(), now());

  -- Competitor: Kiyansh Kanishk Singh (Rank 34)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kiyansh Kanishk Singh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kiyansh Kanishk Singh', 'kiyansh-kanishk-singh-fdcec0', '2046', 'CWSS', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2046'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Anglo-Chinese School (Junior)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 34, 77.0, 77.0, '10&U, N', '2046',
    'CWSS', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 32, 32.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 36, 36.0, NULL, false, now(), now());

  -- Competitor: Su Yuan (Rank 35)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Su Yuan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Su Yuan', 'su-yuan-c9c765', '3043', 'SAFYC', 'CHIJ (Katong) Primary', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3043'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'CHIJ (Katong) Primary'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 35, 82.0, 82.0, 'N', '3043',
    'SAFYC', 'CHIJ (Katong) Primary', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 52, 52.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 21, 21.0, NULL, false, now(), now());

  -- Competitor: Yahe Wang (Rank 36)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yahe Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yahe Wang', 'yahe-wang-46807a', '3020', 'SAFYC', 'Pei Tong Primary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3020'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Pei Tong Primary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 36, 82.0, 82.0, NULL, '3020',
    'SAFYC', 'Pei Tong Primary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 41, 41.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 32, 32.0, NULL, false, now(), now());

  -- Competitor: Hao Li (Rank 37)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hao Li')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hao Li', 'hao-li-8d1610', '3303', 'CYA', 'NA', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3303'),
      club = COALESCE(club, 'CYA'),
      school = COALESCE(school, 'NA'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 37, 83.0, 83.0, NULL, '3303',
    'CYA', 'NA', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 37, 37.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 15.0, 'SCP', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 31, 31.0, NULL, false, now(), now());

  -- Competitor: Ryan Feiran Zheng (Rank 38)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ryan Feiran Zheng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ryan Feiran Zheng', 'ryan-feiran-zheng-a35df4', '2045', 'CWSS', 'St. Stephen''s School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2045'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'St. Stephen''s School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 38, 88.0, 88.0, '10&U, N', '2045',
    'CWSS', 'St. Stephen''s School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 31, 31.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 48, 48.0, NULL, false, now(), now());

  -- Competitor: Yong Le Wai (Rank 39)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yong Le Wai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yong Le Wai', 'yong-le-wai-bb2ed8', '3488', 'SAFYC', 'First Toa Payoh Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3488'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'First Toa Payoh Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 39, 89.0, 89.0, '10&U', '3488',
    'SAFYC', 'First Toa Payoh Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 25, 25.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 55, 55.0, NULL, false, now(), now());

  -- Competitor: Moyan Han (Rank 40)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Moyan Han')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Moyan Han', 'moyan-han-1bd671', '2042', 'CWSS', 'Nan Hua Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2042'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Nan Hua Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 40, 89.0, 89.0, '10&U, N', '2042',
    'CWSS', 'Nan Hua Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 47, 47.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 33, 33.0, NULL, false, now(), now());

  -- Competitor: Scott Goh (Rank 41)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Scott Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Scott Goh', 'scott-goh-ca093a', '729', 'CSC', 'St. Joseph''s Institution Junior', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '729'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'St. Joseph''s Institution Junior'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 41, 92.0, 92.0, 'N', '729',
    'CSC', 'St. Joseph''s Institution Junior', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 40, 40.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 43, 43.0, NULL, false, now(), now());

  -- Competitor: Xuanye Chen (Rank 42)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Xuanye Chen')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Xuanye Chen', 'xuanye-chen-d427e1', '3305', 'CYA', 'NA', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3305'),
      club = COALESCE(club, 'CYA'),
      school = COALESCE(school, 'NA'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 42, 93.0, 93.0, NULL, '3305',
    'CYA', 'NA', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 39, 39.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 15.0, 'SCP', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 39, 39.0, NULL, false, now(), now());

  -- Competitor: Skyler Kang (Rank 43)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Skyler Kang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Skyler Kang', 'skyler-kang-2e4f8f', '2041', 'CWSS', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2041'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Anglo-Chinese School (Junior)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 43, 95.0, 95.0, '8&U, 10&U, N', '2041',
    'CWSS', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 42, 42.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 44, 44.0, NULL, false, now(), now());

  -- Competitor: Damien Seah (Rank 44)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Damien Seah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Damien Seah', 'damien-seah-33e770', '3825', 'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3825'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Hilda''s Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 44, 96.0, 96.0, '10&U', '3825',
    'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 38, 38.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 49, 49.0, NULL, false, now(), now());

  -- Competitor: Chen-Yi Kai (Rank 45)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Chen-Yi Kai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Chen-Yi Kai', 'chen-yi-kai-f7cf2e', '757', 'CSC', 'Fairfield Methodist School (Primary)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '757'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'Fairfield Methodist School (Primary)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 45, 97.0, 97.0, '10&U', '757',
    'CSC', 'Fairfield Methodist School (Primary)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 59.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 29, 29.0, NULL, false, now(), now());

  -- Competitor: Enzo Kengsin Teo (Rank 46)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Enzo Kengsin Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Enzo Kengsin Teo', 'enzo-kengsin-teo-4b1cba', '2044', 'CWSS', 'St. Stephen''s School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2044'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'St. Stephen''s School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 46, 99.0, 99.0, '10&U, N', '2044',
    'CWSS', 'St. Stephen''s School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 53, 53.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 37, 37.0, NULL, false, now(), now());

  -- Competitor: Gwenyth Sze En Chia (Rank 47)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gwenyth Sze En Chia')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gwenyth Sze En Chia', 'gwenyth-sze-en-chia-e44bb4', '2048', 'CWSS', 'Tao Nan School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2048'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Tao Nan School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 47, 99.0, 99.0, '10&U, N', '2048',
    'CWSS', 'Tao Nan School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 48, 48.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 42, 42.0, NULL, false, now(), now());

  -- Competitor: Zachary Hoo (Rank 48)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zachary Hoo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zachary Hoo', 'zachary-hoo-acd870', '2051', 'CWSS', 'Red Swastika School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2051'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Red Swastika School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 48, 100.0, 100.0, 'N', '2051',
    'CWSS', 'Red Swastika School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 50, 50.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 41, 41.0, NULL, false, now(), now());

  -- Competitor: Jade Tan (Rank 49)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jade Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jade Tan', 'jade-tan-6970c3', '3131', 'SAFYC', 'Ai Tong School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3131'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Ai Tong School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 49, 102.0, 102.0, '10&U', '3131',
    'SAFYC', 'Ai Tong School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 22, 22.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 71.0, 'DNC', false, now(), now());

  -- Competitor: Jiayi Du (Rank 50)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jiayi Du')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jiayi Du', 'jiayi-du-7e48dd', '3141', 'SAFYC', 'St. Gabriel''s Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3141'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Gabriel''s Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 50, 102.0, 102.0, '10&U, N', '3141',
    'SAFYC', 'St. Gabriel''s Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 46, 46.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 47, 47.0, NULL, false, now(), now());

  -- Competitor: Raphael Garbourg (Rank 51)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Raphael Garbourg')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Raphael Garbourg', 'raphael-garbourg-2c841a', '780', 'CSC', 'Opera Estate Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '780'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'Opera Estate Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 51, 106.0, 106.0, NULL, '780',
    'CSC', 'Opera Estate Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 45, 45.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 52, 52.0, NULL, false, now(), now());

  -- Competitor: Ezra Yi Yang Mak (Rank 52)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ezra Yi Yang Mak')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ezra Yi Yang Mak', 'ezra-yi-yang-mak-170a80', '3535', 'SAFYC', 'St. Andrew''s Junior School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3535'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Andrew''s Junior School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 52, 106.0, 106.0, '10&U', '3535',
    'SAFYC', 'St. Andrew''s Junior School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 51, 51.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 46, 46.0, NULL, false, now(), now());

  -- Competitor: You Yu Tan (Rank 53)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('You Yu Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'You Yu Tan', 'you-yu-tan-d5e911', '3137', 'PA', 'Meridian Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3137'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Meridian Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 53, 109.0, 109.0, NULL, '3137',
    'PA', 'Meridian Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 55, 55.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 45, 45.0, NULL, false, now(), now());

  -- Competitor: Yuki Youqi Wang (Rank 54)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuki Youqi Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuki Youqi Wang', 'yuki-youqi-wang-f5880c', '3523', 'SAFYC', 'St. Hilda''s Primary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3523'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Hilda''s Primary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 54, 110.0, 110.0, '10&U, N', '3523',
    'SAFYC', 'St. Hilda''s Primary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 44, 44.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 57, 57.0, NULL, false, now(), now());

  -- Competitor: Emil Lam (Rank 55)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Emil Lam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Emil Lam', 'emil-lam-1bbfb3', '2049', 'CWSS', 'Tao Nan School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2049'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Tao Nan School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 55, 114.0, 114.0, '10&U, N', '2049',
    'CWSS', 'Tao Nan School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 54, 54.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 51, 51.0, NULL, false, now(), now());

  -- Competitor: Yan Cheng Loh (Rank 56)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yan Cheng Loh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yan Cheng Loh', 'yan-cheng-loh-9c3c1c', '3717', 'SAFYC', 'Nan Chiau Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3717'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Nan Chiau Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 56, 116.0, 116.0, '8&U, 10&U', '3717',
    'SAFYC', 'Nan Chiau Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 49, 49.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 58, 58.0, NULL, false, now(), now());

  -- Competitor: An Hu (Rank 57)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('An Hu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'An Hu', 'an-hu-0308c1', '2050', 'CWSS', 'Singapore American School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2050'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Singapore American School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 57, 121.0, 121.0, '10&U', '2050',
    'CWSS', 'Singapore American School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 59.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 53, 53.0, NULL, false, now(), now());

  -- Competitor: Asher Goh (Rank 58)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Asher Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Asher Goh', 'asher-goh-0ec0cf', '735', 'CSC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '735'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'Anglo-Chinese School (Junior)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 58, 122.0, 122.0, 'N', '735',
    'CSC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 59.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 54, 54.0, NULL, false, now(), now());

  -- Competitor: Llewellyn Ding Zhe Tay (Rank 59)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Llewellyn Ding Zhe Tay')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Llewellyn Ding Zhe Tay', 'llewellyn-ding-zhe-tay-b7a33f', '3013', 'SAFYC', 'Tao Nan School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3013'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Tao Nan School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 59, 124.0, 124.0, '8&U, 10&U, N', '3013',
    'SAFYC', 'Tao Nan School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 59.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 56, 56.0, NULL, false, now(), now());

  -- Competitor: Ziyi Adele Chiang (Rank 60)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ziyi Adele Chiang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ziyi Adele Chiang', 'ziyi-adele-chiang-3c5d6e', '3228', 'SAFYC', 'Tao Nan School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3228'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Tao Nan School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 60, 126.0, 126.0, '8&U, 10&U N', '3228',
    'SAFYC', 'Tao Nan School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 56, 56.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 61.0, 'TLE', false, now(), now());

  -- Competitor: Jae Guan Yu Toh (Rank 61)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jae Guan Yu Toh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jae Guan Yu Toh', 'jae-guan-yu-toh-701df3', '3311', 'SAFYC', 'Maris Stella High School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3311'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Maris Stella High School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 61, 127.0, 127.0, '8&U, 10&U', '3311',
    'SAFYC', 'Maris Stella High School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 57, 57.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 61.0, 'TLE', false, now(), now());

  -- Competitor: Cadee Jia Xing See (Rank 62)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cadee Jia Xing See')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cadee Jia Xing See', 'cadee-jia-xing-see-715872', '3628', 'CWSS', 'St. Hilda''s Primary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3628'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'St. Hilda''s Primary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 62, 128.0, 128.0, '10&U, N', '3628',
    'CWSS', 'St. Hilda''s Primary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 59.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 60.0, 'TLE', false, now(), now());

  -- Competitor: Efrem Mak (Rank 63)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Efrem Mak')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Efrem Mak', 'efrem-mak-ff2cea', '3222', 'SAFYC', 'St. Andrew''s Junior School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3222'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Andrew''s Junior School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 63, 129.0, 129.0, '8&U, 10&U N', '3222',
    'SAFYC', 'St. Andrew''s Junior School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 59.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 61.0, 'TLE', false, now(), now());

  -- Competitor: Jacob Jit Yeung Kok (Rank 63)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jacob Jit Yeung Kok')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jacob Jit Yeung Kok', 'jacob-jit-yeung-kok-179647', '3087', 'SAFYC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3087'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Junior)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 63, 129.0, 129.0, '8&U, 10&U', '3087',
    'SAFYC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 59.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 61.0, 'TLE', false, now(), now());

  -- Competitor: Nadia Zahedi (Rank 63)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nadia Zahedi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nadia Zahedi', 'nadia-zahedi-afcde7', '4724', 'PA', 'Tao Nan School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '4724'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Tao Nan School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 63, 129.0, 129.0, '8&U, 10&U, N', '4724',
    'PA', 'Tao Nan School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 59.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 61.0, 'TLE', false, now(), now());

  -- Competitor: Ivor Zhuo Xi Lee (Rank 66)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ivor Zhuo Xi Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ivor Zhuo Xi Lee', 'ivor-zhuo-xi-lee-15ec4e', '3306', 'SAFYC', 'Endeavour Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3306'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Endeavour Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 66, 137.0, 137.0, '10&U', '3306',
    'SAFYC', 'Endeavour Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 59.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 69.0, 'UFD', false, now(), now());

  -- Competitor: Isaac Qin Ran Chiam (Rank 67)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isaac Qin Ran Chiam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isaac Qin Ran Chiam', 'isaac-qin-ran-chiam-9a9eca', '3606', 'SAFYC', 'Ai Tong School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3606'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Ai Tong School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 67, 139.0, 139.0, '10&U', '3606',
    'SAFYC', 'Ai Tong School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 69.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'TLE', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 61.0, 'TLE', false, now(), now());

  -- Competitor: Samuel Zhang (Rank 68)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Samuel Zhang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Samuel Zhang', 'samuel-zhang-29eebf', '3301', 'CYA', 'NA', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3301'),
      club = COALESCE(club, 'CYA'),
      school = COALESCE(school, 'NA'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 68, 145.0, 145.0, NULL, '3301',
    'CYA', 'NA', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 69.0, 'UFD', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 15.0, 'SCP', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 61.0, 'TLE', false, now(), now());

  -- Competitor: Tyler Jun Feng Tan (Rank 69)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tyler Jun Feng Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tyler Jun Feng Tan', 'tyler-jun-feng-tan-1b5878', '3787', 'SAFYC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '3787'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Junior)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 69, 192.0, 192.0, '10&U', '3787',
    'SAFYC', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 71.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 71.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 50, 50.0, NULL, false, now(), now());

  -- Competitor: Henry Shayan Mittelhauser (Rank 70)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Henry Shayan Mittelhauser')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Henry Shayan Mittelhauser', 'henry-shayan-mittelhauser-a2fec4', '2052', 'CWSS', 'Tanjong Katong Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2052'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Tanjong Katong Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 70, 213.0, 213.0, '10&U, N', '2052',
    'CWSS', 'Tanjong Katong Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 71.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 71.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 71.0, 'DNC', false, now(), now());

END $$;

-- ============================================================================
-- Regatta: Pesta Sukan Regatta 2025 (ILCA 4) (pesta-sukan-ilca-4-aug-25-2025-08-02)
-- ============================================================================
DO $$
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'pesta-sukan-ilca-4-aug-25-2025-08-02' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = 'Pesta Sukan Regatta 2025 (ILCA 4)',
      date = '2025-08-02',
      end_date = '2025-08-04',
      boat_class = 'ILCA 4',
      division = 'Open',
      total_fleet_size = 53,
      race_count = 3,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/11535/event?name=Pesta%2520Sukan%25202025',
      official_notice_board_url = 'https://www.racingrulesofsailing.org/documents/11535/event?name=Pesta%2520Sukan%25202025',
      registration_url = 'https://www.sailing.org.sg/events/293985',
      schedule_notes = 'Pesta Sukan Regatta 2025 ILCA 4 fleet: 53 entries, 3 races sailed (0 discards).',
      status = 'published',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, official_notice_board_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_reg_id, 'Pesta Sukan Regatta 2025 (ILCA 4)', 'pesta-sukan-ilca-4-aug-25-2025-08-02', '2025-08-02', '2025-08-04', 'ILCA 4', 'Open', 53, 3,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation', 'https://www.racingrulesofsailing.org/documents/11535/event?name=Pesta%2520Sukan%25202025', 'https://www.racingrulesofsailing.org/documents/11535/event?name=Pesta%2520Sukan%25202025', 'https://www.sailing.org.sg/events/293985', 'Pesta Sukan Regatta 2025 ILCA 4 fleet: 53 entries, 3 races sailed (0 discards).', 'published', now(), now()
    );
  END IF;

  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Nigel Xu Yuan Tan (Rank 1)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nigel Xu Yuan Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nigel Xu Yuan Tan', 'nigel-xu-yuan-tan-109bdf', '225176', 'CWSS', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '225176'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 1, 6.0, 6.0, 'N', '225176',
    'CWSS', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 1, 1.0, NULL, false, now(), now());

  -- Competitor: Nicholette Wee Wen Lee (Rank 2)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nicholette Wee Wen Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nicholette Wee Wen Lee', 'nicholette-wee-wen-lee-daffa8', '224620', 'RVYC', 'Tanjong Katong Girls'' School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '224620'),
      club = COALESCE(club, 'RVYC'),
      school = COALESCE(school, 'Tanjong Katong Girls'' School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 2, 9.0, 9.0, NULL, '224620',
    'RVYC', 'Tanjong Katong Girls'' School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 2, 2.0, NULL, false, now(), now());

  -- Competitor: Nia Zahedi (Rank 3)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nia Zahedi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nia Zahedi', 'nia-zahedi-96ef5f', '224245', 'RM', 'Raffles Girls'' School (Secondary)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '224245'),
      club = COALESCE(club, 'RM'),
      school = COALESCE(school, 'Raffles Girls'' School (Secondary)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 3, 11.0, 11.0, NULL, '224245',
    'RM', 'Raffles Girls'' School (Secondary)', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 3, 3.0, NULL, false, now(), now());

  -- Competitor: Austin Yeo (Rank 4)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Austin Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Austin Yeo', 'austin-yeo-5fb6d8', '221062', 'RVYC', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '221062'),
      club = COALESCE(club, 'RVYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 4, 11.0, 11.0, NULL, '221062',
    'RVYC', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 4, 4.0, NULL, false, now(), now());

  -- Competitor: Caleb Peck (Rank 5)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Caleb Peck')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Caleb Peck', 'caleb-peck-d6ac25', '225221', 'PA', 'Raffles Institution (Secondary)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '225221'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Raffles Institution (Secondary)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 5, 16.0, 16.0, NULL, '225221',
    'PA', 'Raffles Institution (Secondary)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 8, 8.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 7, 7.0, NULL, false, now(), now());

  -- Competitor: Ikuto Mori (Rank 6)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ikuto Mori')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ikuto Mori', 'ikuto-mori-99c2ae', '221687', 'CSC', 'Victoria School', 'M', 'JPN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '221687'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'Victoria School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'JPN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 6, 23.0, 23.0, NULL, '221687',
    'CSC', 'Victoria School', 'M', 'JPN', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 11, 11.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 6, 6.0, NULL, false, now(), now());

  -- Competitor: Kayden Yi Kai Tan (Rank 7)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kayden Yi Kai Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kayden Yi Kai Tan', 'kayden-yi-kai-tan-0213b8', '197424', 'SAFYC', 'St. Andrew''s Secondary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '197424'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Andrew''s Secondary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 7, 26.0, 26.0, 'N', '197424',
    'SAFYC', 'St. Andrew''s Secondary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 8, 8.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 10, 10.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 8, 8.0, NULL, false, now(), now());

  -- Competitor: Jemima Chang (Rank 8)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jemima Chang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jemima Chang', 'jemima-chang-6852f5', '214636', 'PA', 'Dunman High School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '214636'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Dunman High School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 8, 35.0, 35.0, NULL, '214636',
    'PA', 'Dunman High School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 18, 18.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 10, 10.0, NULL, false, now(), now());

  -- Competitor: Zachary Weikai Wong (Rank 9)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zachary Weikai Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zachary Weikai Wong', 'zachary-weikai-wong-21444e', '221061', 'RVYC', 'Raffles Institution (Secondary)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '221061'),
      club = COALESCE(club, 'RVYC'),
      school = COALESCE(school, 'Raffles Institution (Secondary)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 9, 35.0, 35.0, NULL, '221061',
    'RVYC', 'Raffles Institution (Secondary)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 15, 15.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 13, 13.0, NULL, false, now(), now());

  -- Competitor: Joash Jing En Tan (Rank 10)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joash Jing En Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joash Jing En Tan', 'joash-jing-en-tan-efe39f', '209051', 'ONE°15', 'Victoria School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '209051'),
      club = COALESCE(club, 'ONE°15'),
      school = COALESCE(school, 'Victoria School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 10, 44.0, 44.0, 'N', '209051',
    'ONE°15', 'Victoria School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 27, 27.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 12, 12.0, NULL, false, now(), now());

  -- Competitor: Jonas Kia Jeng Tan (Rank 11)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jonas Kia Jeng Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jonas Kia Jeng Tan', 'jonas-kia-jeng-tan-ca056b', '197840', 'SAFYC', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '197840'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 11, 46.0, 46.0, 'N', '197840',
    'SAFYC', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 15, 15.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 9, 9.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 22, 22.0, NULL, false, now(), now());

  -- Competitor: Mildred Li Xuan Wong (Rank 12)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mildred Li Xuan Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mildred Li Xuan Wong', 'mildred-li-xuan-wong-786f47', '223200', 'CWSS', 'Raffles Girls'' School (Secondary)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '223200'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Raffles Girls'' School (Secondary)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 12, 47.0, 47.0, NULL, '223200',
    'CWSS', 'Raffles Girls'' School (Secondary)', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 10, 10.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 28, 28.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 9, 9.0, NULL, false, now(), now());

  -- Competitor: Mika Tew (Rank 13)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mika Tew')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mika Tew', 'mika-tew-e51061', '219762', 'PA', 'Raffles Girls'' School (Secondary)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '219762'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Raffles Girls'' School (Secondary)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 13, 47.0, 47.0, 'N', '219762',
    'PA', 'Raffles Girls'' School (Secondary)', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 19, 19.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 11, 11.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 17, 17.0, NULL, false, now(), now());

  -- Competitor: Kai Lun Wong (Rank 14)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kai Lun Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kai Lun Wong', 'kai-lun-wong-23b1f9', '214779', 'PA', 'Bowen Secondary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '214779'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Bowen Secondary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 14, 51.0, 51.0, NULL, '214779',
    'PA', 'Bowen Secondary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 24, 24.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 24, 24.0, NULL, false, now(), now());

  -- Competitor: Isaiah Chor Hong Yap (Rank 15)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isaiah Chor Hong Yap')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isaiah Chor Hong Yap', 'isaiah-chor-hong-yap-e47655', '227463', 'CSC', 'Xinmin Secondary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '227463'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'Xinmin Secondary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 15, 51.0, 51.0, '13&U,N', '227463',
    'CSC', 'Xinmin Secondary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 20, 20.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 17, 17.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 14, 14.0, NULL, false, now(), now());

  -- Competitor: Jayden Zi Xi Bai (Rank 16)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jayden Zi Xi Bai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jayden Zi Xi Bai', 'jayden-zi-xi-bai-c05216', '225261', 'PA', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '225261'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 16, 54.0, 54.0, NULL, '225261',
    'PA', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 13, 13.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 13, 13.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 28, 28.0, NULL, false, now(), now());

  -- Competitor: Caleb Zhixuan Cao (Rank 17)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Caleb Zhixuan Cao')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Caleb Zhixuan Cao', 'caleb-zhixuan-cao-aa2834', '225207', 'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '225207'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Hilda''s Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 17, 58.0, 58.0, '13&U', '225207',
    'SAFYC', 'St. Hilda''s Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 12, 12.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 12, 12.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 34, 34.0, NULL, false, now(), now());

  -- Competitor: Cory Zhi Hang Loh (Rank 18)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cory Zhi Hang Loh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cory Zhi Hang Loh', 'cory-zhi-hang-loh-400490', '226899', 'SAFYC', 'Admiralty Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '226899'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Admiralty Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 18, 63.0, 63.0, '13&U, N', '226899',
    'SAFYC', 'Admiralty Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 28, 28.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 16, 16.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 19, 19.0, NULL, false, now(), now());

  -- Competitor: Yuk Jun Lim (Rank 19)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuk Jun Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuk Jun Lim', 'yuk-jun-lim-3e29df', '225182', 'SAFYC', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '225182'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 19, 66.0, 66.0, 'N', '225182',
    'SAFYC', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 9, 9.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 20, 20.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 37, 37.0, NULL, false, now(), now());

  -- Competitor: John Raphael Lim (Rank 20)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('John Raphael Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'John Raphael Lim', 'john-raphael-lim-665f82', '206799', 'CSC', 'St. Patrick''s School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '206799'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'St. Patrick''s School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 20, 66.0, 66.0, '13&U, N', '206799',
    'CSC', 'St. Patrick''s School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 17, 17.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 14, 14.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 35, 35.0, NULL, false, now(), now());

  -- Competitor: Eunice Yi Ning Tan (Rank 21)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Eunice Yi Ning Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Eunice Yi Ning Tan', 'eunice-yi-ning-tan-29f54f', '224664', 'SAFYC', 'Dunman High School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '224664'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Dunman High School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 21, 68.0, 68.0, NULL, '224664',
    'SAFYC', 'Dunman High School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 33, 33.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 30, 30.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 5, 5.0, NULL, false, now(), now());

  -- Competitor: Liao Zhiting (Rank 22)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Liao Zhiting')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Liao Zhiting', 'liao-zhiting-5565ad', '214760', 'SAFYC', 'Raffles Institute Secondary', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '214760'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Raffles Institute Secondary'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 22, 70.0, 70.0, '13&U', '214760',
    'SAFYC', 'Raffles Institute Secondary', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 29, 29.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 26, 26.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 15, 15.0, NULL, false, now(), now());

  -- Competitor: Kate Zi Ning Yeh (Rank 23)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kate Zi Ning Yeh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kate Zi Ning Yeh', 'kate-zi-ning-yeh-965fcf', '797', 'CSC', 'North Vista Secondary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '797'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'North Vista Secondary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 23, 70.0, 70.0, '13&U', '797',
    'CSC', 'North Vista Secondary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 21, 21.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 31, 31.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 18, 18.0, NULL, false, now(), now());

  -- Competitor: Febe Qi Ke Wong (Rank 24)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Febe Qi Ke Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Febe Qi Ke Wong', 'febe-qi-ke-wong-4e4998', '225224', 'SAFYC', 'CHIJ St. Theresa''s Convent', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '225224'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'CHIJ St. Theresa''s Convent'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 24, 70.0, 70.0, NULL, '225224',
    'SAFYC', 'CHIJ St. Theresa''s Convent', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 25, 25.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 18, 18.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 27, 27.0, NULL, false, now(), now());

  -- Competitor: Reyes Jit Eng Tan (Rank 25)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Reyes Jit Eng Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Reyes Jit Eng Tan', 'reyes-jit-eng-tan-8ea9a1', '214251', 'CSC', 'Dunman High School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '214251'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'Dunman High School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 25, 71.0, 71.0, NULL, '214251',
    'CSC', 'Dunman High School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 23, 23.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 25, 25.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 23, 23.0, NULL, false, now(), now());

  -- Competitor: Josiah Tan (Rank 26)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Josiah Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Josiah Tan', 'josiah-tan-2ee69b', '1978', 'ONE°15', 'Victoria School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '1978'),
      club = COALESCE(club, 'ONE°15'),
      school = COALESCE(school, 'Victoria School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 26, 73.0, 73.0, NULL, '1978',
    'ONE°15', 'Victoria School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 14, 14.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 19, 19.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 40, 40.0, NULL, false, now(), now());

  -- Competitor: Rayson Yin Yi Lee (Rank 27)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rayson Yin Yi Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rayson Yin Yi Lee', 'rayson-yin-yi-lee-d8e878', '217060', 'SAFYC', 'Ai Tong School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '217060'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Ai Tong School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 27, 75.0, 75.0, '13&U, N', '217060',
    'SAFYC', 'Ai Tong School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 36, 36.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 23, 23.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 16, 16.0, NULL, false, now(), now());

  -- Competitor: Jade Zi Yu Yeh (Rank 28)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jade Zi Yu Yeh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jade Zi Yu Yeh', 'jade-zi-yu-yeh-8968fc', '227609', 'CSC', 'North Vista Secondary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '227609'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'North Vista Secondary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 28, 78.0, 78.0, 'N', '227609',
    'CSC', 'North Vista Secondary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 27, 27.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 21, 21.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 30, 30.0, NULL, false, now(), now());

  -- Competitor: Lauren Lim (Rank 29)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lauren Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lauren Lim', 'lauren-lim-dcd138', '216431', 'SAFYC', 'Whitley Secondary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '216431'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Whitley Secondary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 29, 84.0, 84.0, '13&U', '216431',
    'SAFYC', 'Whitley Secondary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 26, 26.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 22, 22.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 36, 36.0, NULL, false, now(), now());

  -- Competitor: James Kong (Rank 30)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('James Kong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'James Kong', 'james-kong-f670b8', '212216', 'PA', 'Dunman High School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '212216'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Dunman High School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 30, 88.0, 88.0, NULL, '212216',
    'PA', 'Dunman High School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 22, 22.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 40, 40.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 26, 26.0, NULL, false, now(), now());

  -- Competitor: Jiayan Xu (Rank 31)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jiayan Xu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jiayan Xu', 'jiayan-xu-7b2467', '224656', 'SAFYC', 'St. Gabriel''s Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '224656'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Gabriel''s Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 31, 89.0, 89.0, '13&U', '224656',
    'SAFYC', 'St. Gabriel''s Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 31, 31.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 29, 29.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 29, 29.0, NULL, false, now(), now());

  -- Competitor: Josh Ong Yong Jun (Rank 32)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Josh Ong Yong Jun')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Josh Ong Yong Jun', 'josh-ong-yong-jun-06c09f', '189662', 'SAFYC', 'Victoria School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '189662'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Victoria School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 32, 92.0, 92.0, '13&U', '189662',
    'SAFYC', 'Victoria School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 16, 16.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 33, 33.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 43, 43.0, NULL, false, now(), now());

  -- Competitor: Travis Jia Le Yeo (Rank 33)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Travis Jia Le Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Travis Jia Le Yeo', 'travis-jia-le-yeo-fcde6f', '223728', 'SAFYC', 'Raffles Institution (Secondary)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '223728'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Raffles Institution (Secondary)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 33, 93.0, 93.0, '13&U', '223728',
    'SAFYC', 'Raffles Institution (Secondary)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 41, 41.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 32, 32.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 20, 20.0, NULL, false, now(), now());

  -- Competitor: Mathias Cheow (Rank 34)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mathias Cheow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mathias Cheow', 'mathias-cheow-9420c4', '225167', 'SAFYC', 'Anglo-Chinese School (Barker Road)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '225167'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Barker Road)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 34, 94.0, 94.0, '13&U, N', '225167',
    'SAFYC', 'Anglo-Chinese School (Barker Road)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 30, 30.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 43, 43.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 21, 21.0, NULL, false, now(), now());

  -- Competitor: Jonathan Kum Loong Kwok (Rank 35)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jonathan Kum Loong Kwok')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jonathan Kum Loong Kwok', 'jonathan-kum-loong-kwok-a0f999', '214808', 'CWSS', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '214808'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 35, 100.0, 100.0, '13&U, N', '214808',
    'CWSS', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 32, 32.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 37, 37.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 31, 31.0, NULL, false, now(), now());

  -- Competitor: Angela Fei'er Huang (Rank 36)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Angela Fei''er Huang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Angela Fei''er Huang', 'angela-fei-er-huang-f6a630', '213191', 'SAFYC', 'Methodist Girls'' School (Secondary)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '213191'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Methodist Girls'' School (Secondary)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 36, 102.0, 102.0, NULL, '213191',
    'SAFYC', 'Methodist Girls'' School (Secondary)', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 53.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 24, 24.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 25, 25.0, NULL, false, now(), now());

  -- Competitor: Isla Zhi Xi Lee (Rank 37)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isla Zhi Xi Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isla Zhi Xi Lee', 'isla-zhi-xi-lee-d15faa', '203535', 'SAFYC', 'Chung Cheng High School (Yishun)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '203535'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Chung Cheng High School (Yishun)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 37, 102.0, 102.0, '13&U, N', '203535',
    'SAFYC', 'Chung Cheng High School (Yishun)', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 35, 35.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 34, 34.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 33, 33.0, NULL, false, now(), now());

  -- Competitor: Heng Yi Yong (Rank 38)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Heng Yi Yong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Heng Yi Yong', 'heng-yi-yong-0e4ff1', '225259', 'CSC', 'Pasir Ris Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '225259'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'Pasir Ris Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 38, 116.0, 116.0, '13&U', '225259',
    'CSC', 'Pasir Ris Primary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 53.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 52.0, 'UFD', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 11, 11.0, NULL, false, now(), now());

  -- Competitor: Eugene Yi Ze Tan (Rank 39)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Eugene Yi Ze Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Eugene Yi Ze Tan', 'eugene-yi-ze-tan-3c53d0', '217008', 'SAFYC', 'St. Joseph''s Institution Junior', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '217008'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Joseph''s Institution Junior'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 39, 117.0, 117.0, '13&U, N', '217008',
    'SAFYC', 'St. Joseph''s Institution Junior', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 37, 37.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 38, 38.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 42, 42.0, NULL, false, now(), now());

  -- Competitor: Kye Tang (Rank 40)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kye Tang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kye Tang', 'kye-tang-1e446d', '226900', 'CWSS', 'Raffles Institution (Secondary)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '226900'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Raffles Institution (Secondary)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 40, 118.0, 118.0, '13&U', '226900',
    'CWSS', 'Raffles Institution (Secondary)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 34, 34.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 52.0, 'RET', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 32, 32.0, NULL, false, now(), now());

  -- Competitor: Haoying He (Rank 41)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Haoying He')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Haoying He', 'haoying-he-f29005', '220078', 'CYA', 'NA', 'F', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '220078'),
      club = COALESCE(club, 'CYA'),
      school = COALESCE(school, 'NA'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 41, 120.0, 120.0, NULL, '220078',
    'CYA', 'NA', 'F', 'CHN', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 39, 39.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 36, 36.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 45, 45.0, NULL, false, now(), now());

  -- Competitor: Nicholas Jiang En Ng (Rank 42)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nicholas Jiang En Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nicholas Jiang En Ng', 'nicholas-jiang-en-ng-8d7e27', '209042', 'SAFYC', 'Yishun Town Secondary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '209042'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Yishun Town Secondary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 42, 127.0, 127.0, NULL, '209042',
    'SAFYC', 'Yishun Town Secondary School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 38, 38.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 39, 39.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 50, 50.0, NULL, false, now(), now());

  -- Competitor: Keyin Ren (Rank 43)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Keyin Ren')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Keyin Ren', 'keyin-ren-2f6537', '226328', 'CYA', 'NA', 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '226328'),
      club = COALESCE(club, 'CYA'),
      school = COALESCE(school, 'NA'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 43, 128.0, 128.0, NULL, '226328',
    'CYA', 'NA', 'M', 'CHN', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 40, 40.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 44, 44.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 44, 44.0, NULL, false, now(), now());

  -- Competitor: Callum Joon Thang Wong (Rank 44)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Callum Joon Thang Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Callum Joon Thang Wong', 'callum-joon-thang-wong-60b820', '214748', 'SAFYC', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '214748'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 44, 136.0, 136.0, '13&U, N', '214748',
    'SAFYC', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 53.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 42, 42.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 41, 41.0, NULL, false, now(), now());

  -- Competitor: Jiale Yang (Rank 45)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jiale Yang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jiale Yang', 'jiale-yang-2e374e', '220808', 'CYA', 'NA', 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '220808'),
      club = COALESCE(club, 'CYA'),
      school = COALESCE(school, 'NA'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 45, 139.0, 139.0, NULL, '220808',
    'CYA', 'NA', 'M', 'CHN', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 53.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 35, 35.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 51.0, 'SCP', false, now(), now());

  -- Competitor: Aaron Abraham Say (Rank 46)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aaron Abraham Say')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aaron Abraham Say', 'aaron-abraham-say-ac0b7a', '203846', 'RVYC', 'Victoria School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '203846'),
      club = COALESCE(club, 'RVYC'),
      school = COALESCE(school, 'Victoria School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 46, 143.0, 143.0, '13&U', '203846',
    'RVYC', 'Victoria School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 53.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 41, 41.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 49, 49.0, NULL, false, now(), now());

  -- Competitor: Cecilia Sze Sen Kong (Rank 47)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cecilia Sze Sen Kong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cecilia Sze Sen Kong', 'cecilia-sze-sen-kong-dd4a14', '221688', 'CSC', 'National Junior College', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '221688'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'National Junior College'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 47, 144.0, 144.0, 'N', '221688',
    'CSC', 'National Junior College', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 53.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 52.0, 'RET', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 39, 39.0, NULL, false, now(), now());

  -- Competitor: Yunosuke Ogawa (Rank 48)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yunosuke Ogawa')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yunosuke Ogawa', 'yunosuke-ogawa-bca5bd', '43', 'CWSS', 'Overseas Family School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '43'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Overseas Family School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 48, 145.0, 145.0, NULL, '43',
    'CWSS', 'Overseas Family School', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 53.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 45, 45.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 47, 47.0, NULL, false, now(), now());

  -- Competitor: Bingnan Li (Rank 49)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Bingnan Li')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Bingnan Li', 'bingnan-li-ea15a9', '220428', 'CYA', 'NA', 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '220428'),
      club = COALESCE(club, 'CYA'),
      school = COALESCE(school, 'NA'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 49, 146.0, 146.0, NULL, '220428',
    'CYA', 'NA', 'M', 'CHN', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 53.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 52.0, 'UFD', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 41.0, 'SCP', false, now(), now());

  -- Competitor: Noel Jiang Wen Ng (Rank 50)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Noel Jiang Wen Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Noel Jiang Wen Ng', 'noel-jiang-wen-ng-91e3de', '193911', 'SAFYC', 'Chung Cheng High School (Yishun)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '193911'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Chung Cheng High School (Yishun)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 50, 151.0, 151.0, NULL, '193911',
    'SAFYC', 'Chung Cheng High School (Yishun)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 53.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 52.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 46, 46.0, NULL, false, now(), now());

  -- Competitor: Yuan Feng (Rank 51)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuan Feng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuan Feng', 'yuan-feng-8fcc5e', '220505', 'CYA', 'NA', 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '220505'),
      club = COALESCE(club, 'CYA'),
      school = COALESCE(school, 'NA'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 51, 156.0, 156.0, NULL, '220505',
    'CYA', 'NA', 'M', 'CHN', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 53.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 52.0, 'RET', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 51, 51.0, NULL, false, now(), now());

  -- Competitor: Lixin Wei (Rank 52)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lixin Wei')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lixin Wei', 'lixin-wei-b7fca6', '220055', 'CYA', 'NA', 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '220055'),
      club = COALESCE(club, 'CYA'),
      school = COALESCE(school, 'NA'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 52, 161.0, 161.0, NULL, '220055',
    'CYA', 'NA', 'M', 'CHN', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 53.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 54.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 54.0, 'DNC', false, now(), now());

  -- Competitor: Tiago Cheng De Villemor Salgado (Rank 53)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tiago Cheng De Villemor Salgado')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tiago Cheng De Villemor Salgado', 'tiago-cheng-de-villemor-salgado-0233d0', '222437', 'CSC', 'United World College of South East Asia (Dover Campus)', 'M', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '222437'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'United World College of South East Asia (Dover Campus)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'HKG'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 53, 162.0, 162.0, NULL, '222437',
    'CSC', 'United World College of South East Asia (Dover Campus)', 'M', 'HKG', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 54.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 54.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 54.0, 'DNC', false, now(), now());

END $$;

-- ============================================================================
-- Regatta: Pesta Sukan Regatta 2025 (ILCA 6) (pesta-sukan-ilca-6-aug-25-2025-08-02)
-- ============================================================================
DO $$
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'pesta-sukan-ilca-6-aug-25-2025-08-02' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = 'Pesta Sukan Regatta 2025 (ILCA 6)',
      date = '2025-08-02',
      end_date = '2025-08-04',
      boat_class = 'ILCA 6',
      division = 'Open',
      total_fleet_size = 32,
      race_count = 3,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/11535/event?name=Pesta%2520Sukan%25202025',
      official_notice_board_url = 'https://www.racingrulesofsailing.org/documents/11535/event?name=Pesta%2520Sukan%25202025',
      registration_url = 'https://www.sailing.org.sg/events/293985',
      schedule_notes = 'Pesta Sukan Regatta 2025 ILCA 6 fleet: 32 entries, 3 races sailed (0 discards).',
      status = 'published',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, official_notice_board_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_reg_id, 'Pesta Sukan Regatta 2025 (ILCA 6)', 'pesta-sukan-ilca-6-aug-25-2025-08-02', '2025-08-02', '2025-08-04', 'ILCA 6', 'Open', 32, 3,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation', 'https://www.racingrulesofsailing.org/documents/11535/event?name=Pesta%2520Sukan%25202025', 'https://www.racingrulesofsailing.org/documents/11535/event?name=Pesta%2520Sukan%25202025', 'https://www.sailing.org.sg/events/293985', 'Pesta Sukan Regatta 2025 ILCA 6 fleet: 32 entries, 3 races sailed (0 discards).', 'published', now(), now()
    );
  END IF;

  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Keira Carlyle (Rank 1)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Keira Carlyle')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Keira Carlyle', 'keira-carlyle-141b93', '225225', 'SAFYC', 'Nanyang Polytechnic', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '225225'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Nanyang Polytechnic'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 1, 9.0, 9.0, NULL, '225225',
    'SAFYC', 'Nanyang Polytechnic', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 4, 4.0, NULL, false, now(), now());

  -- Competitor: Isaac Goh (Rank 2)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isaac Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isaac Goh', 'isaac-goh-50653a', '219158', 'CSC', 'Raffles Institution (Junior College)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '219158'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'Raffles Institution (Junior College)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 2, 11.0, 11.0, NULL, '219158',
    'CSC', 'Raffles Institution (Junior College)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 7, 7.0, NULL, false, now(), now());

  -- Competitor: Kenan Kee Zen Tan (Rank 3)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kenan Kee Zen Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kenan Kee Zen Tan', 'kenan-kee-zen-tan-9e69b1', '1', 'RVYC', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '1'),
      club = COALESCE(club, 'RVYC'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 3, 13.0, 13.0, NULL, '1',
    'RVYC', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 10, 10.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 1, 1.0, NULL, false, now(), now());

  -- Competitor: Aurick You Shun Leow (Rank 4)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aurick You Shun Leow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aurick You Shun Leow', 'aurick-you-shun-leow-429da8', '5', 'SAFYC', 'Raffles Institution (Junior College)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '5'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Raffles Institution (Junior College)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 4, 16.0, 16.0, NULL, '5',
    'SAFYC', 'Raffles Institution (Junior College)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 11, 11.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 2, 2.0, NULL, false, now(), now());

  -- Competitor: Asher James Nair (Rank 5)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Asher James Nair')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Asher James Nair', 'asher-james-nair-b5a920', '185201', 'PA', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '185201'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 5, 21.0, 21.0, NULL, '185201',
    'PA', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 10, 10.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 9, 9.0, NULL, false, now(), now());

  -- Competitor: Danielle Lai (Rank 6)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Danielle Lai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Danielle Lai', 'danielle-lai-f91c97', '222257', 'RVYC', 'Tanjong Katong Girls'' School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '222257'),
      club = COALESCE(club, 'RVYC'),
      school = COALESCE(school, 'Tanjong Katong Girls'' School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 6, 21.0, 21.0, NULL, '222257',
    'RVYC', 'Tanjong Katong Girls'' School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 9, 9.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 8, 8.0, NULL, false, now(), now());

  -- Competitor: Sarah Rui-En Yong (Rank 7)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sarah Rui-En Yong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sarah Rui-En Yong', 'sarah-rui-en-yong-da52cd', '18', 'RVYC', 'Nanyang Polytechnic', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '18'),
      club = COALESCE(club, 'RVYC'),
      school = COALESCE(school, 'Nanyang Polytechnic'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 7, 24.0, 24.0, NULL, '18',
    'RVYC', 'Nanyang Polytechnic', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 14, 14.0, NULL, false, now(), now());

  -- Competitor: Gabi Oh (Rank 8)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gabi Oh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gabi Oh', 'gabi-oh-49a19a', '224717', 'SAFYC', 'St. Hilda''s Secondary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '224717'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'St. Hilda''s Secondary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 8, 25.0, 25.0, NULL, '224717',
    'SAFYC', 'St. Hilda''s Secondary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 13, 13.0, NULL, false, now(), now());

  -- Competitor: Avelino Shin (Rank 9)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Avelino Shin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Avelino Shin', 'avelino-shin-e19038', '209902', 'HHYC', 'N.A.', 'M', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '209902'),
      club = COALESCE(club, 'HHYC'),
      school = COALESCE(school, 'N.A.'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'HKG'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 9, 26.0, 26.0, NULL, '209902',
    'HHYC', 'N.A.', 'M', 'HKG', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 8, 8.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 13, 13.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 5, 5.0, NULL, false, now(), now());

  -- Competitor: Justiin Ang (Rank 10)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Justiin Ang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Justiin Ang', 'justiin-ang-217b13', '158031', 'CWSS', 'NA', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '158031'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'NA'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 10, 29.0, 29.0, NULL, '158031',
    'CWSS', 'NA', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 12, 12.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 10, 10.0, NULL, false, now(), now());

  -- Competitor: Jayden Teo (Rank 11)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jayden Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jayden Teo', 'jayden-teo-ed2d50', '214813', 'PA', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '214813'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 11, 35.0, 35.0, NULL, '214813',
    'PA', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 9, 9.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 8, 8.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 18, 18.0, NULL, false, now(), now());

  -- Competitor: Jarrod Toh (Rank 12)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jarrod Toh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jarrod Toh', 'jarrod-toh-0fcd43', '214748', 'RVYC', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '214748'),
      club = COALESCE(club, 'RVYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 12, 38.0, 38.0, NULL, '214748',
    'RVYC', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 14, 14.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 18, 18.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 6, 6.0, NULL, false, now(), now());

  -- Competitor: Eitan Oh (Rank 13)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Eitan Oh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Eitan Oh', 'eitan-oh-dae6cc', '222743', 'SAFYC', 'Raffles Institution (Junior College)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '222743'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Raffles Institution (Junior College)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 13, 39.0, 39.0, NULL, '222743',
    'SAFYC', 'Raffles Institution (Junior College)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 15, 15.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 21, 21.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 3, 3.0, NULL, false, now(), now());

  -- Competitor: Cleo En Rui Seah (Rank 14)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cleo En Rui Seah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cleo En Rui Seah', 'cleo-en-rui-seah-cd1e26', '224379', 'SAFYC', 'Canberra Secondary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '224379'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Canberra Secondary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 14, 40.0, 40.0, NULL, '224379',
    'SAFYC', 'Canberra Secondary School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 13, 13.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 12, 12.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 15, 15.0, NULL, false, now(), now());

  -- Competitor: Jonathan Jian Yi Ho (Rank 15)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jonathan Jian Yi Ho')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jonathan Jian Yi Ho', 'jonathan-jian-yi-ho-dfe8ce', '214848', 'PA', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '214848'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 15, 42.0, 42.0, '15&U', '214848',
    'PA', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 19, 19.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 16, 16.0, NULL, false, now(), now());

  -- Competitor: Yuei Jit Foo (Rank 16)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuei Jit Foo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuei Jit Foo', 'yuei-jit-foo-20389a', '221686', 'PA', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '221686'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 16, 45.0, 45.0, NULL, '221686',
    'PA', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 18, 18.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 16, 16.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 11, 11.0, NULL, false, now(), now());

  -- Competitor: Elizabeth Victoria Say (Rank 17)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elizabeth Victoria Say')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elizabeth Victoria Say', 'elizabeth-victoria-say-eabc27', '214873', 'RVYC', 'Dunman High School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '214873'),
      club = COALESCE(club, 'RVYC'),
      school = COALESCE(school, 'Dunman High School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 17, 49.0, 49.0, '15&U', '214873',
    'RVYC', 'Dunman High School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 22, 22.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 15, 15.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 12, 12.0, NULL, false, now(), now());

  -- Competitor: Jaydn Wilkins (Rank 18)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jaydn Wilkins')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jaydn Wilkins', 'jaydn-wilkins-26d9d1', '221703', 'CSC', 'Stamford American International School', 'M', 'TPE', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '221703'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'Stamford American International School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'TPE'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 18, 52.0, 52.0, NULL, '221703',
    'CSC', 'Stamford American International School', 'M', 'TPE', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 16, 16.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 14, 14.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 22, 22.0, NULL, false, now(), now());

  -- Competitor: Clive Wei Jun Seah (Rank 19)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Clive Wei Jun Seah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Clive Wei Jun Seah', 'clive-wei-jun-seah-74412c', '214240', 'SAFYC', 'Catholic Junior College', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '214240'),
      club = COALESCE(club, 'SAFYC'),
      school = COALESCE(school, 'Catholic Junior College'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 19, 53.0, 53.0, NULL, '214240',
    'SAFYC', 'Catholic Junior College', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 19, 19.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 17, 17.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 17, 17.0, NULL, false, now(), now());

  -- Competitor: John Gabriel Lim (Rank 20)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('John Gabriel Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'John Gabriel Lim', 'john-gabriel-lim-b9fafc', '206799', 'CSC', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '206799'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 20, 58.0, 58.0, '15&U', '206799',
    'CSC', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 17, 17.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 20, 20.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 21, 21.0, NULL, false, now(), now());

  -- Competitor: Gordon Alexander Allan (Rank 21)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gordon Alexander Allan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gordon Alexander Allan', 'gordon-alexander-allan-1508c0', '221058', 'RVYC', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '221058'),
      club = COALESCE(club, 'RVYC'),
      school = COALESCE(school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 21, 63.0, 63.0, '15&U', '221058',
    'RVYC', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 26, 26.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 11, 11.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 26, 26.0, NULL, false, now(), now());

  -- Competitor: Darren Lai (Rank 22)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Darren Lai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Darren Lai', 'darren-lai-e72a11', '222256', 'RVYC', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '222256'),
      club = COALESCE(club, 'RVYC'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 22, 71.0, 71.0, '15&U', '222256',
    'RVYC', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 25, 25.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 23, 23.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 23, 23.0, NULL, false, now(), now());

  -- Competitor: Mathias Yu Da Wong (Rank 23)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mathias Yu Da Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mathias Yu Da Wong', 'mathias-yu-da-wong-1bc0cc', '222255', 'CWSS', 'Raffles Institution (Secondary)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '222255'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Raffles Institution (Secondary)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 23, 73.0, 73.0, '15&U', '222255',
    'CWSS', 'Raffles Institution (Secondary)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 20, 20.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 29, 29.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 24, 24.0, NULL, false, now(), now());

  -- Competitor: Abigail Jia En Ling (Rank 24)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Abigail Jia En Ling')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Abigail Jia En Ling', 'abigail-jia-en-ling-e9c1fc', '204636', 'CWSS', 'Dunman High School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '204636'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'Dunman High School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 24, 77.0, 77.0, NULL, '204636',
    'CWSS', 'Dunman High School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 27, 27.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 22, 22.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 28, 28.0, NULL, false, now(), now());

  -- Competitor: Fion Yingyi Liang (Rank 25)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Fion Yingyi Liang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Fion Yingyi Liang', 'fion-yingyi-liang-238471', '39', 'CSC', 'NA', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '39'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'NA'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 25, 78.0, 78.0, NULL, '39',
    'CSC', 'NA', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 21, 21.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 24, 24.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 33.0, 'DNC', false, now(), now());

  -- Competitor: Daryl Goh (Rank 26)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Daryl Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Daryl Goh', 'daryl-goh-4ba8be', '203818', 'CSC', 'N.A.', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '203818'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'N.A.'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 26, 78.0, 78.0, NULL, '203818',
    'CSC', 'N.A.', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 23, 23.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 25, 25.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 30, 30.0, NULL, false, now(), now());

  -- Competitor: Leo Lee (Rank 27)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Leo Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Leo Lee', 'leo-lee-2be869', '213307', 'HHCY', 'N.A.', 'M', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '213307'),
      club = COALESCE(club, 'HHCY'),
      school = COALESCE(school, 'N.A.'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'HKG'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 27, 80.0, 80.0, NULL, '213307',
    'HHCY', 'N.A.', 'M', 'HKG', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 30, 30.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 30, 30.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 20, 20.0, NULL, false, now(), now());

  -- Competitor: Arabelle En Xi Tan (Rank 28)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Arabelle En Xi Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Arabelle En Xi Tan', 'arabelle-en-xi-tan-78fc22', '221690', 'PA', 'Tanjong Katong Girls'' School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '221690'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'Tanjong Katong Girls'' School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 28, 80.0, 80.0, '15&U', '221690',
    'PA', 'Tanjong Katong Girls'' School', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 29, 29.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 26, 26.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 25, 25.0, NULL, false, now(), now());

  -- Competitor: Omar Agoes (Rank 29)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Omar Agoes')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Omar Agoes', 'omar-agoes-c469f4', '209145', 'CWSS', 'NA', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '209145'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'NA'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 29, 83.0, 83.0, NULL, '209145',
    'CWSS', 'NA', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 28, 28.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 28, 28.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 27, 27.0, NULL, false, now(), now());

  -- Competitor: Samuel Tan (Rank 30)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Samuel Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Samuel Tan', 'samuel-tan-71b912', '223134', 'ONEÂ°15', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '223134'),
      club = COALESCE(club, 'ONEÂ°15'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 30, 85.0, 85.0, NULL, '223134',
    'ONEÂ°15', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 33.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 33.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 19, 19.0, NULL, false, now(), now());

  -- Competitor: Darius Xian Rui Low (Rank 31)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Darius Xian Rui Low')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Darius Xian Rui Low', 'darius-xian-rui-low-daa036', '8', 'PA', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '8'),
      club = COALESCE(club, 'PA'),
      school = COALESCE(school, 'St. Joseph''s Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 31, 87.0, 87.0, '15&U', '8',
    'PA', 'St. Joseph''s Institution', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 24, 24.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 32.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 31, 31.0, NULL, false, now(), now());

  -- Competitor: Ryan Cheung (Rank 32)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ryan Cheung')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ryan Cheung', 'ryan-cheung-ec21a4', '215313', 'HHCY', 'NA', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '215313'),
      club = COALESCE(club, 'HHCY'),
      school = COALESCE(school, 'NA'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 32, 87.0, 87.0, '15&U', '215313',
    'HHCY', 'NA', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 31, 31.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 27, 27.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 29, 29.0, NULL, false, now(), now());

END $$;
