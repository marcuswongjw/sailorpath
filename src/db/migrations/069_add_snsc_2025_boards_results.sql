-- 069_add_snsc_2025_boards_results.sql
-- Import official race-by-race results for Singapore National Sailing Championships 2025 Board Classes
-- Fleets: Techno 293 (14 entries, 12 races), Wingfoil (5 entries, 14 races), iQFOiL (8 entries, 12 races)
-- Dates: 6–9 September 2025
-- Venue: National Sailing Centre, 1500 East Coast Parkway, Singapore 468963
-- Organiser: Singapore Sailing Federation
-- Source: Official Sailwave scoring sheets (media_1790262305222.pdf)

-- ============================================================================
-- Regatta: Singapore National Sailing Championships 2025 (Techno 293) (snsc-techno-293-sep-25-2025-09-06)
-- ============================================================================
DO $$
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'snsc-techno-293-sep-25-2025-09-06' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = 'Singapore National Sailing Championships 2025 (Techno 293)',
      date = '2025-09-06',
      end_date = '2025-09-09',
      boat_class = 'Techno 293',
      division = 'Open',
      total_fleet_size = 14,
      race_count = 12,
      geography = 'SG',
      counts_for_ranking = false,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/11799/event',
      registration_url = 'https://www.sailing.org.sg/events/298131',
      schedule_notes = 'Singapore National Sailing Championships 2025 Techno 293 Class: 14 entries, 12 races sailed (2 discards).',
      status = 'published',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_reg_id, 'Singapore National Sailing Championships 2025 (Techno 293)', 'snsc-techno-293-sep-25-2025-09-06', '2025-09-06', '2025-09-09', 'Techno 293', 'Open', 14, 12,
      'SG', false, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation', 'https://www.racingrulesofsailing.org/documents/11799/event', 'https://www.sailing.org.sg/events/298131', 'Singapore National Sailing Championships 2025 Techno 293 Class: 14 entries, 12 races sailed (2 discards).', 'published', now(), now()
    );
  END IF;

  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Trevor Ng (Rank 1)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Trevor Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Trevor Ng', 'trevor-ng-a1f782', '45', 'CWSS', 'VICTORIA SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '45'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'VICTORIA SCHOOL'),
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
    v_res_id, v_reg_id, v_sailor_id, 1, 24.0, 18.0, '17&U (7.8m)', '45',
    'CWSS', 'VICTORIA SCHOOL', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 3, 3.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 3, 3.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 3, 3.0, NULL, false, now(), now());

  -- Competitor: Axl Tan (Rank 2)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Axl Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Axl Tan', 'axl-tan-c20a8e', '82', 'CWSS', 'ANGLO-CHINESE SCHOOL (BARKER ROAD)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '82'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (BARKER ROAD)'),
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
    v_res_id, v_reg_id, v_sailor_id, 2, 28.0, 18.0, '17&U (7.8m)', '82',
    'CWSS', 'ANGLO-CHINESE SCHOOL (BARKER ROAD)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 5, 5.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, 5, 5.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 1, 1.0, NULL, false, now(), now());

  -- Competitor: Sai Patil (Rank 3)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sai Patil')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sai Patil', 'sai-patil-224014', '27', 'YAI', '', 'M', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '27'),
      club = COALESCE(club, 'YAI'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 3, 30.0, 20.0, '17&U (7.8m)', '27',
    'YAI', '', 'M', 'IND', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 5, 5.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 5, 5.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 2, 2.0, NULL, false, now(), now());

  -- Competitor: Udaiveer Singh Johal (Rank 4)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Udaiveer Singh Johal')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Udaiveer Singh Johal', 'udaiveer-singh-johal-5100de', '01', 'YAI', '', 'M', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '01'),
      club = COALESCE(club, 'YAI'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 4, 55.0, 41.0, '15&U (6.8m)', '01',
    'YAI', '', 'M', 'IND', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 6, 6.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 8, 8.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 6, 6.0, NULL, false, now(), now());

  -- Competitor: Mohit Mhatre (Rank 5)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mohit Mhatre')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mohit Mhatre', 'mohit-mhatre-10eb49', '16', 'YAI', '', 'M', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '16'),
      club = COALESCE(club, 'YAI'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 5, 62.0, 46.0, '15&U (6.8m)', '16',
    'YAI', '', 'M', 'IND', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 8, 8.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, 8, 8.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 4, 4.0, NULL, false, now(), now());

  -- Competitor: Priyanshi Patil (Rank 6)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Priyanshi Patil')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Priyanshi Patil', 'priyanshi-patil-f8c639', '1', 'YAI', '', 'F', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '1'),
      club = COALESCE(club, 'YAI'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 6, 84.0, 61.0, '15&U (6.8m)', '1',
    'YAI', '', 'F', 'IND', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, 8, 8.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, NULL, 15.0, 'DNF', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 8, 8.0, NULL, false, now(), now());

  -- Competitor: Prathana Bhoi (Rank 7)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Prathana Bhoi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Prathana Bhoi', 'prathana-bhoi-894a36', '49', 'YAI', '', 'F', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '49'),
      club = COALESCE(club, 'YAI'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 7, 95.0, 65.0, '17&U (7.8m)', '49',
    'YAI', '', 'F', 'IND', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 9, 9.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 15.0, 'DNF', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 10, 10.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, NULL, 15.0, 'DNF', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 8, 8.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 5, 5.0, NULL, false, now(), now());

  -- Competitor: Vaishnavi V Kajale (Rank 8)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Vaishnavi V Kajale')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Vaishnavi V Kajale', 'vaishnavi-v-kajale-a86b17', '02', 'YAI', '', 'F', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '02'),
      club = COALESCE(club, 'YAI'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 8, 107.0, 81.0, '15&U (6.8m)', '02',
    'YAI', '', 'F', 'IND', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 9, 9.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 10, 10.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, 11, 11.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, NULL, 15.0, 'DNF', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 9, 9.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 8, 8.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 9, 9.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, 10, 10.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 7, 7.0, NULL, false, now(), now());

  -- Competitor: Michael Shi Jun Lim (Rank 9)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Michael Shi Jun Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Michael Shi Jun Lim', 'michael-shi-jun-lim-10c12f', '0', 'CWSS', '', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '0'),
      club = COALESCE(club, 'CWSS'),
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
    v_res_id, v_reg_id, v_sailor_id, 9, 111.0, 81.0, '17&U (7.8m)', '0',
    'CWSS', '', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 10, 10.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 9, 9.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 9, 9.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 8, 8.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 8, 8.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, 9, 9.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, NULL, 15.0, 'RET', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 9, 9.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, NULL, 15.0, 'DNC', true, now(), now());

  -- Competitor: Rashmita Thimiti (Rank 10)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rashmita Thimiti')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rashmita Thimiti', 'rashmita-thimiti-9d185d', '18', 'YAI', '', 'F', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '18'),
      club = COALESCE(club, 'YAI'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 10, 125.0, 98.0, '15&U (6.8m)', '18',
    'YAI', '', 'F', 'IND', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 12, 12.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 8, 8.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 11, 11.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 10, 10.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 11, 11.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, 10, 10.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, NULL, 15.0, 'DNF', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 10, 10.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 10, 10.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 10, 10.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, 9, 9.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 9, 9.0, NULL, false, now(), now());

  -- Competitor: Addy Armand Anuar (Rank 11)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Addy Armand Anuar')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Addy Armand Anuar', 'addy-armand-anuar-421f16', '143', 'CWSS', '', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '143'),
      club = COALESCE(club, 'CWSS'),
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
    v_res_id, v_reg_id, v_sailor_id, 11, 131.0, 101.0, '15&U (6.8m)', '143',
    'CWSS', '', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 8, 8.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 10, 10.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 11, 11.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 9, 9.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, NULL, 15.0, 'DNF', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, NULL, 15.0, 'DNF', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, NULL, 15.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, NULL, 15.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, NULL, 15.0, 'DNC', false, now(), now());

  -- Competitor: Ansley Inessa Suganda-Chin (Rank 12)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ansley Inessa Suganda-Chin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ansley Inessa Suganda-Chin', 'ansley-inessa-suganda-chin-e6f705', '0', 'WAS', 'RAFFLES GIRLS'' SCHOOL (SECONDARY)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '0'),
      club = COALESCE(club, 'WAS'),
      school = COALESCE(school, 'RAFFLES GIRLS'' SCHOOL (SECONDARY)'),
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
    v_res_id, v_reg_id, v_sailor_id, 12, 172.0, 142.0, '17&U (7.8m)', '0',
    'WAS', 'RAFFLES GIRLS'' SCHOOL (SECONDARY)', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 11, 11.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 11, 11.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 15.0, 'DNF', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, NULL, 15.0, 'DNF', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, NULL, 15.0, 'DNC', false, now(), now());

  -- Competitor: Evan Teo (Rank 13)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Evan Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Evan Teo', 'evan-teo-b088b4', '86', 'CWSS', '', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '86'),
      club = COALESCE(club, 'CWSS'),
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
    v_res_id, v_reg_id, v_sailor_id, 13, 180.0, 150.0, '15&U (6.8m)', '86',
    'CWSS', '', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 15.0, 'DNS', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 15.0, 'DNF', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, NULL, 15.0, 'DNC', false, now(), now());

  -- Competitor: Kai Ting Hannah Tan (Rank 13)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kai Ting Hannah Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kai Ting Hannah Tan', 'kai-ting-hannah-tan-011df7', '777', 'CSC', 'KONG HWA SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '777'),
      club = COALESCE(club, 'CSC'),
      school = COALESCE(school, 'KONG HWA SCHOOL'),
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
    v_res_id, v_reg_id, v_sailor_id, 13, 180.0, 150.0, '15&U (6.8m)', '777',
    'CSC', 'KONG HWA SCHOOL', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 15.0, 'DNC', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 15.0, 'DNC', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, NULL, 15.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, NULL, 15.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, NULL, 15.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, NULL, 15.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, NULL, 15.0, 'DNC', false, now(), now());

END $$;

-- ============================================================================
-- Regatta: Singapore National Sailing Championships 2025 (WingFoil) (snsc-wingfoil-sep-25-2025-09-06)
-- ============================================================================
DO $$
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'snsc-wingfoil-sep-25-2025-09-06' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = 'Singapore National Sailing Championships 2025 (WingFoil)',
      date = '2025-09-06',
      end_date = '2025-09-09',
      boat_class = 'WingFoil',
      division = 'Open',
      total_fleet_size = 5,
      race_count = 14,
      geography = 'SG',
      counts_for_ranking = false,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/11799/event',
      registration_url = 'https://www.sailing.org.sg/events/298131',
      schedule_notes = 'Singapore National Sailing Championships 2025 Wingfoil Class: 5 entries, 14 races sailed (2 discards).',
      status = 'published',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_reg_id, 'Singapore National Sailing Championships 2025 (WingFoil)', 'snsc-wingfoil-sep-25-2025-09-06', '2025-09-06', '2025-09-09', 'WingFoil', 'Open', 5, 14,
      'SG', false, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation', 'https://www.racingrulesofsailing.org/documents/11799/event', 'https://www.sailing.org.sg/events/298131', 'Singapore National Sailing Championships 2025 Wingfoil Class: 5 entries, 14 races sailed (2 discards).', 'published', now(), now()
    );
  END IF;

  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Malo Pichoir (Rank 1)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Malo Pichoir')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Malo Pichoir', 'malo-pichoir-221a40', '123', 'ASSC', 'TANGLIN TRUST SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '123'),
      club = COALESCE(club, 'ASSC'),
      school = COALESCE(school, 'TANGLIN TRUST SCHOOL'),
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
    v_res_id, v_reg_id, v_sailor_id, 1, 30.0, 21.0, '18&U', '123',
    'ASSC', 'TANGLIN TRUST SCHOOL', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 4, 4.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 5, 5.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 13, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 14, 2, 2.0, NULL, false, now(), now());

  -- Competitor: Ker Wan Chew (Rank 2)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ker Wan Chew')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ker Wan Chew', 'ker-wan-chew-622112', '14', 'PA', '', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '14'),
      club = COALESCE(club, 'PA'),
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
    v_res_id, v_reg_id, v_sailor_id, 2, 36.0, 26.0, NULL, '14',
    'PA', '', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 5, 5.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 5, 5.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 13, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 14, 1, 1.0, NULL, false, now(), now());

  -- Competitor: Mason Qifeng Lau (Rank 3)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mason Qifeng Lau')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mason Qifeng Lau', 'mason-qifeng-lau-500929', '13', 'CWSS', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '13'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
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
    v_res_id, v_reg_id, v_sailor_id, 3, 33.0, 26.0, '18&U', '13',
    'CWSS', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 3, 3.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 4, 4.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 13, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 14, 3, 3.0, NULL, false, now(), now());

  -- Competitor: Ange Chew (Rank 4)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ange Chew')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ange Chew', 'ange-chew-87fe62', '123', 'ASSC', '', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '123'),
      club = COALESCE(club, 'ASSC'),
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
    v_res_id, v_reg_id, v_sailor_id, 4, 45.0, 37.0, '18&U', '123',
    'ASSC', '', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 4, 4.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, 4, 4.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 13, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 14, 4, 4.0, NULL, false, now(), now());

  -- Competitor: Victoria Natasha Chew (Rank 5)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Victoria Natasha Chew')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Victoria Natasha Chew', 'victoria-natasha-chew-c5d929', '12', 'ASSC', 'METHODIST GIRLS'' SCHOOL (SECONDARY)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '12'),
      club = COALESCE(club, 'ASSC'),
      school = COALESCE(school, 'METHODIST GIRLS'' SCHOOL (SECONDARY)'),
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
    v_res_id, v_reg_id, v_sailor_id, 5, 66.0, 56.0, '18&U', '12',
    'ASSC', 'METHODIST GIRLS'' SCHOOL (SECONDARY)', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 5, 5.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 5, 5.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 13, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 14, 5, 5.0, NULL, false, now(), now());

END $$;

-- ============================================================================
-- Regatta: Singapore National Sailing Championships 2025 (iQFOiL) (snsc-iqfoil-sep-25-2025-09-06)
-- ============================================================================
DO $$
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'snsc-iqfoil-sep-25-2025-09-06' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = 'Singapore National Sailing Championships 2025 (iQFOiL)',
      date = '2025-09-06',
      end_date = '2025-09-09',
      boat_class = 'iQFOiL',
      division = 'Open',
      total_fleet_size = 8,
      race_count = 12,
      geography = 'SG',
      counts_for_ranking = false,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/11799/event',
      registration_url = 'https://www.sailing.org.sg/events/298131',
      schedule_notes = 'Singapore National Sailing Championships 2025 iQFOiL Class: 8 entries, 12 races sailed (2 discards).',
      status = 'published',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_reg_id, 'Singapore National Sailing Championships 2025 (iQFOiL)', 'snsc-iqfoil-sep-25-2025-09-06', '2025-09-06', '2025-09-09', 'iQFOiL', 'Open', 8, 12,
      'SG', false, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation', 'https://www.racingrulesofsailing.org/documents/11799/event', 'https://www.sailing.org.sg/events/298131', 'Singapore National Sailing Championships 2025 iQFOiL Class: 8 entries, 12 races sailed (2 discards).', 'published', now(), now()
    );
  END IF;

  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Jonas Knick (Rank 1)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jonas Knick')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jonas Knick', 'jonas-knick-6183ae', '39', 'CWSS', 'SCHOOL OF SCIENCE AND TECHNOLOGY', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '39'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'SCHOOL OF SCIENCE AND TECHNOLOGY'),
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
    v_res_id, v_reg_id, v_sailor_id, 1, 26.0, 16.0, '18&U', '39',
    'CWSS', 'SCHOOL OF SCIENCE AND TECHNOLOGY', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 4, 4.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 6, 6.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 1, 1.0, NULL, false, now(), now());

  -- Competitor: Angyal Chew (Rank 2)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Angyal Chew')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Angyal Chew', 'angyal-chew-cbb6f9', '711', 'CSC', '', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '711'),
      club = COALESCE(club, 'CSC'),
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
    v_res_id, v_reg_id, v_sailor_id, 2, 28.0, 16.0, '18&U', '711',
    'CSC', '', 'F', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 3, 3.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, NULL, 9.0, 'OCS', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 2, 2.0, NULL, false, now(), now());

  -- Competitor: Vinay Vishwanath Kulabkar (Rank 3)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Vinay Vishwanath Kulabkar')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Vinay Vishwanath Kulabkar', 'vinay-vishwanath-kulabkar-6487aa', '10', 'YAI', '', 'M', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '10'),
      club = COALESCE(club, 'YAI'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 3, 46.0, 34.0, '18&U', '10',
    'YAI', '', 'M', 'IND', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 6, 6.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 6, 6.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 5, 5.0, NULL, false, now(), now());

  -- Competitor: Ovie Nair Shaffi (Rank 4)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ovie Nair Shaffi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ovie Nair Shaffi', 'ovie-nair-shaffi-70928e', '7', 'YAI', '', 'F', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '7'),
      club = COALESCE(club, 'YAI'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 4, 50.0, 39.0, '18&U', '7',
    'YAI', '', 'F', 'IND', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 5, 5.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, 6, 6.0, NULL, true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 3, 3.0, NULL, false, now(), now());

  -- Competitor: Razaa Ahmed Khan (Rank 5)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Razaa Ahmed Khan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Razaa Ahmed Khan', 'razaa-ahmed-khan-b9a58f', '786', 'YAI', '', 'M', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '786'),
      club = COALESCE(club, 'YAI'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(nationality, 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 5, 68.0, 50.0, '18&U', '786',
    'YAI', '', 'M', 'IND', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 9.0, 'DNC', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, NULL, 9.0, 'DNC', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 6, 6.0, NULL, false, now(), now());

  -- Competitor: Mark Wong (Rank 6)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mark Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mark Wong', 'mark-wong-f9622f', '95', 'CWSS', 'ANGLO-CHINESE SCHOOL (INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '95'),
      club = COALESCE(club, 'CWSS'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (INDEPENDENT)'),
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
    v_res_id, v_reg_id, v_sailor_id, 6, 70.0, 52.0, '18&U', '95',
    'CWSS', 'ANGLO-CHINESE SCHOOL (INDEPENDENT)', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, 2, 2.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, 4, 4.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, NULL, 9.0, 'DNC', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, NULL, 9.0, 'DNC', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, NULL, 9.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, NULL, 9.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, NULL, 9.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, 3, 3.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 4, 4.0, NULL, false, now(), now());

  -- Competitor: John Tze Xiang Wong (Rank 7)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('John Tze Xiang Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'John Tze Xiang Wong', 'john-tze-xiang-wong-acb2ce', '2', 'ASSC', 'SINGAPORE SPORT SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '2'),
      club = COALESCE(club, 'ASSC'),
      school = COALESCE(school, 'SINGAPORE SPORT SCHOOL'),
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
    v_res_id, v_reg_id, v_sailor_id, 7, 90.0, 72.0, '18&U', '2',
    'ASSC', 'SINGAPORE SPORT SCHOOL', 'M', 'SGP', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 9.0, 'DNC', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'DNC', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 9.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, NULL, 9.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, NULL, 9.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, NULL, 9.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, NULL, 9.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 1, 1.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, NULL, 9.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, NULL, 9.0, 'DNC', false, now(), now());

  -- Competitor: Naavya Kaku (Rank 8)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Naavya Kaku')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Naavya Kaku', 'naavya-kaku-ab600a', '9', 'YAI', '', 'F', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = COALESCE(sail_number, '9'),
      club = COALESCE(club, 'YAI'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(nationality, 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, position, points, nett, division, sail_number,
    club, school, gender, nationality, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 8, 95.0, 77.0, '18&U', '9',
    'YAI', '', 'F', 'IND', now(), now()
  );

  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 1, NULL, 9.0, 'DNC', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 2, NULL, 9.0, 'DNC', true, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 3, NULL, 9.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 4, NULL, 9.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 5, NULL, 9.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 6, NULL, 9.0, 'DNC', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 7, 5, 5.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 8, 6, 6.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 9, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 10, 7, 7.0, NULL, false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 11, NULL, 9.0, 'DNF', false, now(), now());
  INSERT INTO public.regatta_race_results (id, result_id, race_number, place, score, scoring_code, is_discard, created_at, updated_at)
  VALUES (gen_random_uuid(), v_res_id, 12, 7, 7.0, NULL, false, now(), now());

END $$;

-- ============================================================================
-- Sync to techno293_regattas and wingfoil_regattas JSON tables
-- ============================================================================
INSERT INTO public.techno293_regattas (id, status, data, updated_at)
VALUES ('techno-snsc-2025', 'published', '{"id": "techno-snsc-2025", "name": "Singapore National Sailing Championships 2025", "shortName": "SNSC 2025", "dates": "6 - 9 September 2025", "venue": "National Sailing Centre, Singapore", "organizer": "Singapore Sailing Federation", "format": "One Design", "status": "Completed", "lifecycleStatus": "published", "scoringSystem": "World Sailing RRS Appendix A (Low Point)", "rulesNotes": "Techno 293 Class. 12 races completed, 2 discards applied per RRS Appendix A. 14 entries. Awards: Open 1st-3rd, Female 1st, 15&U (6.8m) 1st-3rd, 17&U (7.8m) 1st-3rd.", "websiteUrl": "https://www.sailing.org.sg/events/298131", "noticeBoardUrl": "https://www.racingrulesofsailing.org/documents/11799/event", "results": [{"rank": 1, "nationality": "SGP", "name": "Trevor Ng", "sailNumber": "45", "gender": "M", "ageCategory": "17&U (7.8m)", "schoolName": "VICTORIA SCHOOL", "club": "CWSS", "races": [{"raceNumber": 1, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 2, "score": 3.0, "isDiscarded": true, "code": null}, {"raceNumber": 3, "score": 3.0, "isDiscarded": true, "code": null}, {"raceNumber": 4, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 5, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 6, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 7, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 8, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 9, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 10, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 11, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 12, "score": 3.0, "isDiscarded": false, "code": null}], "grossScore": 24.0, "nettScore": 18.0}, {"rank": 2, "nationality": "SGP", "name": "Axl Tan", "sailNumber": "82", "gender": "M", "ageCategory": "17&U (7.8m)", "schoolName": "ANGLO-CHINESE SCHOOL (BARKER ROAD)", "club": "CWSS", "races": [{"raceNumber": 1, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 2, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 3, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 4, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 5, "score": 5.0, "isDiscarded": true, "code": null}, {"raceNumber": 6, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 7, "score": 5.0, "isDiscarded": true, "code": null}, {"raceNumber": 8, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 9, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 10, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 11, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 12, "score": 1.0, "isDiscarded": false, "code": null}], "grossScore": 28.0, "nettScore": 18.0}, {"rank": 3, "nationality": "IND", "name": "Sai Patil", "sailNumber": "27", "gender": "M", "ageCategory": "17&U (7.8m)", "schoolName": "", "club": "YAI", "races": [{"raceNumber": 1, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 2, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 3, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 4, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 5, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 6, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 7, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 8, "score": 4.0, "isDiscarded": false, "code": null}, {"raceNumber": 9, "score": 5.0, "isDiscarded": true, "code": null}, {"raceNumber": 10, "score": 5.0, "isDiscarded": true, "code": null}, {"raceNumber": 11, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 12, "score": 2.0, "isDiscarded": false, "code": null}], "grossScore": 30.0, "nettScore": 20.0}, {"rank": 4, "nationality": "IND", "name": "Udaiveer Singh Johal", "sailNumber": "01", "gender": "M", "ageCategory": "15&U (6.8m)", "schoolName": "", "club": "YAI", "races": [{"raceNumber": 1, "score": 6.0, "isDiscarded": true, "code": null}, {"raceNumber": 2, "score": 4.0, "isDiscarded": false, "code": null}, {"raceNumber": 3, "score": 4.0, "isDiscarded": false, "code": null}, {"raceNumber": 4, "score": 4.0, "isDiscarded": false, "code": null}, {"raceNumber": 5, "score": 4.0, "isDiscarded": false, "code": null}, {"raceNumber": 6, "score": 6.0, "isDiscarded": false, "code": null}, {"raceNumber": 7, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 8, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 9, "score": 4.0, "isDiscarded": false, "code": null}, {"raceNumber": 10, "score": 8.0, "isDiscarded": true, "code": null}, {"raceNumber": 11, "score": 4.0, "isDiscarded": false, "code": null}, {"raceNumber": 12, "score": 6.0, "isDiscarded": false, "code": null}], "grossScore": 55.0, "nettScore": 41.0}, {"rank": 5, "nationality": "IND", "name": "Mohit Mhatre", "sailNumber": "16", "gender": "M", "ageCategory": "15&U (6.8m)", "schoolName": "", "club": "YAI", "races": [{"raceNumber": 1, "score": 5.0, "isDiscarded": false, "code": null}, {"raceNumber": 2, "score": 5.0, "isDiscarded": false, "code": null}, {"raceNumber": 3, "score": 8.0, "isDiscarded": true, "code": null}, {"raceNumber": 4, "score": 6.0, "isDiscarded": false, "code": null}, {"raceNumber": 5, "score": 6.0, "isDiscarded": false, "code": null}, {"raceNumber": 6, "score": 4.0, "isDiscarded": false, "code": null}, {"raceNumber": 7, "score": 4.0, "isDiscarded": false, "code": null}, {"raceNumber": 8, "score": 5.0, "isDiscarded": false, "code": null}, {"raceNumber": 9, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 10, "score": 4.0, "isDiscarded": false, "code": null}, {"raceNumber": 11, "score": 8.0, "isDiscarded": true, "code": null}, {"raceNumber": 12, "score": 4.0, "isDiscarded": false, "code": null}], "grossScore": 62.0, "nettScore": 46.0}, {"rank": 6, "nationality": "IND", "name": "Priyanshi Patil", "sailNumber": "1", "gender": "F", "ageCategory": "15&U (6.8m)", "schoolName": "", "club": "YAI", "races": [{"raceNumber": 1, "score": 4.0, "isDiscarded": false, "code": null}, {"raceNumber": 2, "score": 6.0, "isDiscarded": false, "code": null}, {"raceNumber": 3, "score": 6.0, "isDiscarded": false, "code": null}, {"raceNumber": 4, "score": 5.0, "isDiscarded": false, "code": null}, {"raceNumber": 5, "score": 7.0, "isDiscarded": false, "code": null}, {"raceNumber": 6, "score": 8.0, "isDiscarded": true, "code": null}, {"raceNumber": 7, "score": 15.0, "isDiscarded": true, "code": "DNF"}, {"raceNumber": 8, "score": 7.0, "isDiscarded": false, "code": null}, {"raceNumber": 9, "score": 7.0, "isDiscarded": false, "code": null}, {"raceNumber": 10, "score": 6.0, "isDiscarded": false, "code": null}, {"raceNumber": 11, "score": 5.0, "isDiscarded": false, "code": null}, {"raceNumber": 12, "score": 8.0, "isDiscarded": false, "code": null}], "grossScore": 84.0, "nettScore": 61.0}, {"rank": 7, "nationality": "IND", "name": "Prathana Bhoi", "sailNumber": "49", "gender": "F", "ageCategory": "17&U (7.8m)", "schoolName": "", "club": "YAI", "races": [{"raceNumber": 1, "score": 9.0, "isDiscarded": false, "code": null}, {"raceNumber": 2, "score": 15.0, "isDiscarded": true, "code": "DNF"}, {"raceNumber": 3, "score": 10.0, "isDiscarded": false, "code": null}, {"raceNumber": 4, "score": 7.0, "isDiscarded": false, "code": null}, {"raceNumber": 5, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 6, "score": 7.0, "isDiscarded": false, "code": null}, {"raceNumber": 7, "score": 15.0, "isDiscarded": true, "code": "DNF"}, {"raceNumber": 8, "score": 8.0, "isDiscarded": false, "code": null}, {"raceNumber": 9, "score": 6.0, "isDiscarded": false, "code": null}, {"raceNumber": 10, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 11, "score": 7.0, "isDiscarded": false, "code": null}, {"raceNumber": 12, "score": 5.0, "isDiscarded": false, "code": null}], "grossScore": 95.0, "nettScore": 65.0}, {"rank": 8, "nationality": "IND", "name": "Vaishnavi V Kajale", "sailNumber": "02", "gender": "F", "ageCategory": "15&U (6.8m)", "schoolName": "", "club": "YAI", "races": [{"raceNumber": 1, "score": 7.0, "isDiscarded": false, "code": null}, {"raceNumber": 2, "score": 7.0, "isDiscarded": false, "code": null}, {"raceNumber": 3, "score": 5.0, "isDiscarded": false, "code": null}, {"raceNumber": 4, "score": 9.0, "isDiscarded": false, "code": null}, {"raceNumber": 5, "score": 10.0, "isDiscarded": false, "code": null}, {"raceNumber": 6, "score": 11.0, "isDiscarded": true, "code": null}, {"raceNumber": 7, "score": 15.0, "isDiscarded": true, "code": "DNF"}, {"raceNumber": 8, "score": 9.0, "isDiscarded": false, "code": null}, {"raceNumber": 9, "score": 8.0, "isDiscarded": false, "code": null}, {"raceNumber": 10, "score": 9.0, "isDiscarded": false, "code": null}, {"raceNumber": 11, "score": 10.0, "isDiscarded": false, "code": null}, {"raceNumber": 12, "score": 7.0, "isDiscarded": false, "code": null}], "grossScore": 107.0, "nettScore": 81.0}, {"rank": 9, "nationality": "SGP", "name": "Michael Shi Jun Lim", "sailNumber": "0", "gender": "M", "ageCategory": "17&U (7.8m)", "schoolName": "", "club": "CWSS", "races": [{"raceNumber": 1, "score": 10.0, "isDiscarded": false, "code": null}, {"raceNumber": 2, "score": 9.0, "isDiscarded": false, "code": null}, {"raceNumber": 3, "score": 9.0, "isDiscarded": false, "code": null}, {"raceNumber": 4, "score": 8.0, "isDiscarded": false, "code": null}, {"raceNumber": 5, "score": 8.0, "isDiscarded": false, "code": null}, {"raceNumber": 6, "score": 9.0, "isDiscarded": false, "code": null}, {"raceNumber": 7, "score": 15.0, "isDiscarded": true, "code": "RET"}, {"raceNumber": 8, "score": 6.0, "isDiscarded": false, "code": null}, {"raceNumber": 9, "score": 9.0, "isDiscarded": false, "code": null}, {"raceNumber": 10, "score": 7.0, "isDiscarded": false, "code": null}, {"raceNumber": 11, "score": 6.0, "isDiscarded": false, "code": null}, {"raceNumber": 12, "score": 15.0, "isDiscarded": true, "code": "DNC"}], "grossScore": 111.0, "nettScore": 81.0}, {"rank": 10, "nationality": "IND", "name": "Rashmita Thimiti", "sailNumber": "18", "gender": "F", "ageCategory": "15&U (6.8m)", "schoolName": "", "club": "YAI", "races": [{"raceNumber": 1, "score": 12.0, "isDiscarded": true, "code": null}, {"raceNumber": 2, "score": 8.0, "isDiscarded": false, "code": null}, {"raceNumber": 3, "score": 11.0, "isDiscarded": false, "code": null}, {"raceNumber": 4, "score": 10.0, "isDiscarded": false, "code": null}, {"raceNumber": 5, "score": 11.0, "isDiscarded": false, "code": null}, {"raceNumber": 6, "score": 10.0, "isDiscarded": false, "code": null}, {"raceNumber": 7, "score": 15.0, "isDiscarded": true, "code": "DNF"}, {"raceNumber": 8, "score": 10.0, "isDiscarded": false, "code": null}, {"raceNumber": 9, "score": 10.0, "isDiscarded": false, "code": null}, {"raceNumber": 10, "score": 10.0, "isDiscarded": false, "code": null}, {"raceNumber": 11, "score": 9.0, "isDiscarded": false, "code": null}, {"raceNumber": 12, "score": 9.0, "isDiscarded": false, "code": null}], "grossScore": 125.0, "nettScore": 98.0}, {"rank": 11, "nationality": "SGP", "name": "Addy Armand Anuar", "sailNumber": "143", "gender": "M", "ageCategory": "15&U (6.8m)", "schoolName": "", "club": "CWSS", "races": [{"raceNumber": 1, "score": 8.0, "isDiscarded": false, "code": null}, {"raceNumber": 2, "score": 10.0, "isDiscarded": false, "code": null}, {"raceNumber": 3, "score": 7.0, "isDiscarded": false, "code": null}, {"raceNumber": 4, "score": 11.0, "isDiscarded": false, "code": null}, {"raceNumber": 5, "score": 9.0, "isDiscarded": false, "code": null}, {"raceNumber": 6, "score": 5.0, "isDiscarded": false, "code": null}, {"raceNumber": 7, "score": 6.0, "isDiscarded": false, "code": null}, {"raceNumber": 8, "score": 15.0, "isDiscarded": true, "code": "DNF"}, {"raceNumber": 9, "score": 15.0, "isDiscarded": true, "code": "DNF"}, {"raceNumber": 10, "score": 15.0, "isDiscarded": false, "code": "DNF"}, {"raceNumber": 11, "score": 15.0, "isDiscarded": false, "code": "DNF"}, {"raceNumber": 12, "score": 15.0, "isDiscarded": false, "code": "DNC"}], "grossScore": 131.0, "nettScore": 101.0}, {"rank": 12, "nationality": "SGP", "name": "Ansley Inessa Suganda-Chin", "sailNumber": "0", "gender": "F", "ageCategory": "17&U (7.8m)", "schoolName": "RAFFLES GIRLS'' SCHOOL (SECONDARY)", "club": "WAS", "races": [{"raceNumber": 1, "score": 11.0, "isDiscarded": false, "code": null}, {"raceNumber": 2, "score": 11.0, "isDiscarded": false, "code": null}, {"raceNumber": 3, "score": 15.0, "isDiscarded": true, "code": "DNF"}, {"raceNumber": 4, "score": 15.0, "isDiscarded": true, "code": "DNF"}, {"raceNumber": 5, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 6, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 7, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 8, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 9, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 10, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 11, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 12, "score": 15.0, "isDiscarded": false, "code": "DNC"}], "grossScore": 172.0, "nettScore": 142.0}, {"rank": 13, "nationality": "SGP", "name": "Evan Teo", "sailNumber": "86", "gender": "M", "ageCategory": "15&U (6.8m)", "schoolName": "", "club": "CWSS", "races": [{"raceNumber": 1, "score": 15.0, "isDiscarded": true, "code": "DNS"}, {"raceNumber": 2, "score": 15.0, "isDiscarded": true, "code": "DNF"}, {"raceNumber": 3, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 4, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 5, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 6, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 7, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 8, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 9, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 10, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 11, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 12, "score": 15.0, "isDiscarded": false, "code": "DNC"}], "grossScore": 180.0, "nettScore": 150.0}, {"rank": 13, "nationality": "SGP", "name": "Kai Ting Hannah Tan", "sailNumber": "777", "gender": "F", "ageCategory": "15&U (6.8m)", "schoolName": "KONG HWA SCHOOL", "club": "CSC", "races": [{"raceNumber": 1, "score": 15.0, "isDiscarded": true, "code": "DNC"}, {"raceNumber": 2, "score": 15.0, "isDiscarded": true, "code": "DNC"}, {"raceNumber": 3, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 4, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 5, "score": 15.0, "isDiscarded": false, "code": "DNF"}, {"raceNumber": 6, "score": 15.0, "isDiscarded": false, "code": "DNF"}, {"raceNumber": 7, "score": 15.0, "isDiscarded": false, "code": "DNF"}, {"raceNumber": 8, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 9, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 10, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 11, "score": 15.0, "isDiscarded": false, "code": "DNC"}, {"raceNumber": 12, "score": 15.0, "isDiscarded": false, "code": "DNC"}], "grossScore": 180.0, "nettScore": 150.0}]}'::jsonb, now())
ON CONFLICT (id) DO UPDATE SET
  status = EXCLUDED.status,
  data = EXCLUDED.data,
  updated_at = now();

INSERT INTO public.wingfoil_regattas (id, status, data, updated_at)
VALUES ('snsc-2025-wingfoil', 'published', '{"id": "snsc-2025-wingfoil", "name": "Singapore National Sailing Championships 2025 \u2014 WingFoil Sprint Slalom", "shortName": "SNSC 2025", "dates": "6\u20139 September 2025", "venue": "National Sailing Centre (NSC), Singapore", "organizer": "Singapore Sailing Federation (SSF)", "format": "Sprint Slalom", "status": "Completed", "scoringSystem": "14 races, 2 discards", "rulesNotes": "Delta Buoy Slalom course, 14 races completed, 2 discards. Awards: Open 1st-3rd, Female 1st-3rd, 18&U 1st-3rd. Per NoR 20.2: <6 entries, top boat presented.", "websiteUrl": "https://www.sailing.org.sg/events/298131", "noticeBoardUrl": "https://www.racingrulesofsailing.org/documents/11799/event", "results": [{"rank": 1, "nationality": "SGP", "name": "Malo Pichoir", "sailNumber": "123", "gender": "M", "ageCategory": "18&U", "schoolName": "TANGLIN TRUST SCHOOL", "club": "ASSC", "races": [{"raceNumber": 1, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 2, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 3, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 4, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 5, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 6, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 7, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 8, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 9, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 10, "score": 4.0, "isDiscarded": true, "code": null}, {"raceNumber": 11, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 12, "score": 5.0, "isDiscarded": true, "code": null}, {"raceNumber": 13, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 14, "score": 2.0, "isDiscarded": false, "code": null}], "grossScore": 30.0, "nettScore": 21.0}, {"rank": 2, "nationality": "SGP", "name": "Ker Wan Chew", "sailNumber": "14", "gender": "M", "ageCategory": "", "schoolName": "", "club": "PA", "races": [{"raceNumber": 1, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 2, "score": 4.0, "isDiscarded": false, "code": null}, {"raceNumber": 3, "score": 5.0, "isDiscarded": true, "code": null}, {"raceNumber": 4, "score": 4.0, "isDiscarded": false, "code": null}, {"raceNumber": 5, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 6, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 7, "score": 4.0, "isDiscarded": false, "code": null}, {"raceNumber": 8, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 9, "score": 5.0, "isDiscarded": true, "code": null}, {"raceNumber": 10, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 11, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 12, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 13, "score": 5.0, "isDiscarded": false, "code": null}, {"raceNumber": 14, "score": 1.0, "isDiscarded": false, "code": null}], "grossScore": 36.0, "nettScore": 26.0}, {"rank": 3, "nationality": "SGP", "name": "Mason Qifeng Lau", "sailNumber": "13", "gender": "M", "ageCategory": "18&U", "schoolName": "TAO NAN SCHOOL", "club": "CWSS", "races": [{"raceNumber": 1, "score": 3.0, "isDiscarded": true, "code": null}, {"raceNumber": 2, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 3, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 4, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 5, "score": 4.0, "isDiscarded": true, "code": null}, {"raceNumber": 6, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 7, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 8, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 9, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 10, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 11, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 12, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 13, "score": 2.0, "isDiscarded": false, "code": null}, {"raceNumber": 14, "score": 3.0, "isDiscarded": false, "code": null}], "grossScore": 33.0, "nettScore": 26.0}, {"rank": 4, "nationality": "SGP", "name": "Ange Chew", "sailNumber": "123", "gender": "M", "ageCategory": "18&U", "schoolName": "", "club": "ASSC", "races": [{"raceNumber": 1, "score": 4.0, "isDiscarded": true, "code": null}, {"raceNumber": 2, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 3, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 4, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 5, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 6, "score": 4.0, "isDiscarded": true, "code": null}, {"raceNumber": 7, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 8, "score": 4.0, "isDiscarded": false, "code": null}, {"raceNumber": 9, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 10, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 11, "score": 4.0, "isDiscarded": false, "code": null}, {"raceNumber": 12, "score": 1.0, "isDiscarded": false, "code": null}, {"raceNumber": 13, "score": 3.0, "isDiscarded": false, "code": null}, {"raceNumber": 14, "score": 4.0, "isDiscarded": false, "code": null}], "grossScore": 45.0, "nettScore": 37.0}, {"rank": 5, "nationality": "SGP", "name": "Victoria Natasha Chew", "sailNumber": "12", "gender": "F", "ageCategory": "18&U", "schoolName": "METHODIST GIRLS'' SCHOOL (SECONDARY)", "club": "ASSC", "races": [{"raceNumber": 1, "score": 5.0, "isDiscarded": true, "code": null}, {"raceNumber": 2, "score": 5.0, "isDiscarded": true, "code": null}, {"raceNumber": 3, "score": 4.0, "isDiscarded": false, "code": null}, {"raceNumber": 4, "score": 5.0, "isDiscarded": false, "code": null}, {"raceNumber": 5, "score": 5.0, "isDiscarded": false, "code": null}, {"raceNumber": 6, "score": 5.0, "isDiscarded": false, "code": null}, {"raceNumber": 7, "score": 5.0, "isDiscarded": false, "code": null}, {"raceNumber": 8, "score": 5.0, "isDiscarded": false, "code": null}, {"raceNumber": 9, "score": 4.0, "isDiscarded": false, "code": null}, {"raceNumber": 10, "score": 5.0, "isDiscarded": false, "code": null}, {"raceNumber": 11, "score": 5.0, "isDiscarded": false, "code": null}, {"raceNumber": 12, "score": 4.0, "isDiscarded": false, "code": null}, {"raceNumber": 13, "score": 4.0, "isDiscarded": false, "code": null}, {"raceNumber": 14, "score": 5.0, "isDiscarded": false, "code": null}], "grossScore": 66.0, "nettScore": 56.0}]}'::jsonb, now())
ON CONFLICT (id) DO UPDATE SET
  status = EXCLUDED.status,
  data = EXCLUDED.data,
  updated_at = now();
