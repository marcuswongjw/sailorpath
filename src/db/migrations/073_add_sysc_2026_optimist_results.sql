-- 073_add_sysc_2026_optimist_results.sql
-- Import official race-by-race results for Singapore Youth Sailing Championships 2026 (Optimist Gold & Silver)
-- Dates: 14–17 March 2026
-- Venue: National Sailing Centre, 1500 East Coast Parkway, Singapore 468963
-- Organiser: Singapore Sailing Federation
-- Source: Official Sailwave scoring sheets (106 Gold entries, 11 races Q1-Q4/F1-F7; 68 Silver entries, 10 races R1-R10)

DO $$
DECLARE
  v_event_id uuid;
  v_gold_id uuid;
  v_silver_id uuid;
  v_sailor_id uuid;
  v_res_id uuid;
BEGIN
  -- 1. Ensure weekend event exists in public.regatta_events
  SELECT id INTO v_event_id FROM public.regatta_events WHERE slug = 'sysc-2026' LIMIT 1;
  IF v_event_id IS NULL THEN
    v_event_id := gen_random_uuid();
    INSERT INTO public.regatta_events (
      id, name, slug, start_date, end_date, venue, organizer, classes, nor_url, registration_url, counts_for_ranking, is_selection_trial, created_at, updated_at
    ) VALUES (
      v_event_id, 'Singapore Youth Sailing Championships 2026', 'sysc-2026', '2026-03-14', '2026-03-17',
      'National Sailing Centre, Singapore', 'Singapore Sailing Federation',
      '["Optimist", "ILCA 4", "ILCA 6", "ILCA 7", "29er", "420", "Techno 293", "iQFOiL"]'::jsonb,
      'https://www.racingrulesofsailing.org/documents/13601/event', 'https://www.sailing.org.sg/events/303339',
      true, true, now(), now()
    );
  END IF;

  -- 2. Ensure Optimist Gold regatta exists
  SELECT id INTO v_gold_id FROM public.regattas WHERE slug = 'sysc-2026-gold' OR slug = 'sysc-gold-mar-26-2026-03-14' OR (slug ILIKE '%sysc%' AND slug ILIKE '%gold%' AND slug ILIKE '%26%') LIMIT 1;
  IF v_gold_id IS NOT NULL THEN
    UPDATE public.regattas SET
      event_id = v_event_id,
      name = 'Singapore Youth Sailing Championships 2026 (Optimist Gold)',
      slug = 'sysc-2026-gold',
      date = '2026-03-14',
      end_date = '2026-03-17',
      boat_class = 'Optimist',
      division = 'Gold',
      total_fleet_size = 106,
      race_count = 11,
      geography = 'SG',
      counts_for_ranking = true,
      is_selection_trial = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/13601/event',
      registration_url = 'https://www.sailing.org.sg/events/303339',
      schedule_notes = 'Singapore Youth Sailing Championships 2026 Optimist Gold fleet: 106 entries, 11 races sailed (Q1-Q4, F1-F7, 2 discards). Selection Trial #1 for Optimist Asian Games & Perth Camp squad.',
      status = 'published',
      updated_at = now()
    WHERE id = v_gold_id;
  ELSE
    v_gold_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, is_selection_trial, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_gold_id, v_event_id, 'Singapore Youth Sailing Championships 2026 (Optimist Gold)', 'sysc-2026-gold', '2026-03-14', '2026-03-17',
      'Optimist', 'Gold', 106, 11, 'SG', true, true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation',
      'https://www.racingrulesofsailing.org/documents/13601/event', 'https://www.sailing.org.sg/events/303339',
      'Singapore Youth Sailing Championships 2026 Optimist Gold fleet: 106 entries, 11 races sailed (Q1-Q4, F1-F7, 2 discards). Selection Trial #1 for Optimist Asian Games & Perth Camp squad.', 'published', now(), now()
    );
  END IF;

  -- 3. Ensure Optimist Silver regatta exists
  SELECT id INTO v_silver_id FROM public.regattas WHERE slug = 'sysc-2026-silver' OR slug = 'sysc-silver-mar-26-2026-03-14' OR (slug ILIKE '%sysc%' AND slug ILIKE '%silver%' AND slug ILIKE '%26%') LIMIT 1;
  IF v_silver_id IS NOT NULL THEN
    UPDATE public.regattas SET
      event_id = v_event_id,
      name = 'Singapore Youth Sailing Championships 2026 (Optimist Silver)',
      slug = 'sysc-2026-silver',
      date = '2026-03-14',
      end_date = '2026-03-17',
      boat_class = 'Optimist',
      division = 'Silver',
      total_fleet_size = 68,
      race_count = 10,
      geography = 'SG',
      counts_for_ranking = true,
      is_selection_trial = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/13601/event',
      registration_url = 'https://www.sailing.org.sg/events/303339',
      schedule_notes = 'Singapore Youth Sailing Championships 2026 Optimist Silver fleet: 68 entries, 10 races sailed (R1-R10, 2 discards).',
      status = 'published',
      updated_at = now()
    WHERE id = v_silver_id;
  ELSE
    v_silver_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, is_selection_trial, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_silver_id, v_event_id, 'Singapore Youth Sailing Championships 2026 (Optimist Silver)', 'sysc-2026-silver', '2026-03-14', '2026-03-17',
      'Optimist', 'Silver', 68, 10, 'SG', true, true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation',
      'https://www.racingrulesofsailing.org/documents/13601/event', 'https://www.sailing.org.sg/events/303339',
      'Singapore Youth Sailing Championships 2026 Optimist Silver fleet: 68 entries, 10 races sailed (R1-R10, 2 discards).', 'published', now(), now()
    );
  END IF;

  -- Link ILCA 6 regatta to the event as well
  UPDATE public.regattas SET event_id = v_event_id WHERE slug = 'sysc-2026-ilca-6';

  -- Clean prior results for Gold & Silver
  DELETE FROM public.regatta_results WHERE regatta_id = v_gold_id;
  DELETE FROM public.regatta_results WHERE regatta_id = v_silver_id;

  -- ==========================================================================
  -- OPTIMIST GOLD FLEET (106 competitors)
  -- ==========================================================================
  -- [Gold] Rank 1: Wenyu Cheng (CHN 5051)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Wenyu Cheng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Wenyu Cheng', 'wenyu-cheng-55bb38', '5051', 'HHFLCSC', NULL, 'F', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '5051' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'HHFLCSC'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 1, 84.0, 49.0, false, 'F', 2012, 'CHN', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 2, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 3, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 4, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 5, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 6, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 7, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 8, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 9, 17.0, NULL, true, '17', now()),
    (gen_random_uuid(), v_res_id, 10, 18.0, NULL, true, '18', now()),
    (gen_random_uuid(), v_res_id, 11, 3.0, NULL, false, '3', now());

  -- [Gold] Rank 2: Ashlyn Tham (SGP 4452)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ashlyn Tham')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ashlyn Tham', 'ashlyn-tham-eb2687', '4452', 'PA', 'SEC ST. HILDA''S SECONDARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4452' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PA'),
      school = COALESCE(school, 'SEC ST. HILDA''S SECONDARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 2, 126.0, 51.0, false, 'F', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 2, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 3, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 4, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 5, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 6, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 7, 39.0, NULL, true, '39', now()),
    (gen_random_uuid(), v_res_id, 8, 36.0, NULL, true, '36', now()),
    (gen_random_uuid(), v_res_id, 9, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 10, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 11, 1.0, NULL, false, '1', now());

  -- [Gold] Rank 3: Anya Alessia Zahedi (SGP 159)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Anya Alessia Zahedi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Anya Alessia Zahedi', 'anya-alessia-zahedi-36d18a', '159', 'PA', 'SEC RAFFLES GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '159' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PA'),
      school = COALESCE(school, 'SEC RAFFLES GIRLS'' SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 3, 108.0, 69.0, false, 'F', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 2, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 3, 15.0, NULL, true, '15', now()),
    (gen_random_uuid(), v_res_id, 4, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 5, 24.0, NULL, true, '24', now()),
    (gen_random_uuid(), v_res_id, 6, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 7, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 8, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 9, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 10, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 11, 8.0, NULL, false, '8', now());

  -- [Gold] Rank 4: Youjia Xu (CHN 5016)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Youjia Xu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Youjia Xu', 'youjia-xu-ca6370', '5016', 'CYA', NULL, 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '5016' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CYA'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 4, 168.0, 77.0, false, 'M', 2011, 'CHN', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 2, 37.0, NULL, true, '37', now()),
    (gen_random_uuid(), v_res_id, 3, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 4, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 5, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 6, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 7, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 8, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 9, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 10, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 11, 7.0, NULL, false, '7', now());

  -- [Gold] Rank 5: Sorawit Naksuk (THA 1493)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sorawit Naksuk')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sorawit Naksuk', 'sorawit-naksuk-291a98', '1493', 'YRAT', NULL, 'M', 'THA', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '1493' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'YRAT'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'THA'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 5, 173.0, 78.0, false, 'M', 2012, 'THA', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 2, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 3, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 4, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 5, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 6, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 7, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 8, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 9, 41.0, NULL, true, '41', now()),
    (gen_random_uuid(), v_res_id, 10, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 11, 40.0, NULL, false, '40', now());

  -- [Gold] Rank 6: Rachata Sadtrakulwatanna (THA 1963)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rachata Sadtrakulwatanna')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rachata Sadtrakulwatanna', 'rachata-sadtrakulwatanna-5cf2e1', '1963', 'YRAT', NULL, 'M', 'THA', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '1963' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'YRAT'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'THA'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 6, 149.0, 89.0, false, 'M', 2011, 'THA', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 2, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 3, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 4, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 5, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 6, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 7, 37.0, NULL, true, '37', now()),
    (gen_random_uuid(), v_res_id, 8, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 9, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 10, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 11, 23.0, NULL, true, '23', now());

  -- [Gold] Rank 7: Kevin Jun Yi Ho (SGP 171)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kevin Jun Yi Ho')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kevin Jun Yi Ho', 'kevin-jun-yi-ho-9417d0', '171', 'SAFYC', 'SEC RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '171' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'SEC RAFFLES INSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 7, 163.0, 89.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 2, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 3, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 4, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 5, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 6, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 7, 40.0, NULL, true, '40', now()),
    (gen_random_uuid(), v_res_id, 8, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 9, 34.0, NULL, true, '34', now()),
    (gen_random_uuid(), v_res_id, 10, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 11, 28.0, NULL, false, '28', now());

  -- [Gold] Rank 8: Nathaniel Kaiden Ng (SGP 3344)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nathaniel Kaiden Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nathaniel Kaiden Ng', 'nathaniel-kaiden-ng-1db883', '3344', '(INDEPENDENT)PA', 'SEC ANGLO-CHINESE SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3344' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), '(INDEPENDENT)PA'),
      school = COALESCE(school, 'SEC ANGLO-CHINESE SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 8, 174.0, 91.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 2, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 3, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 4, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 5, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 6, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 7, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 8, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 9, 45.0, NULL, true, '45', now()),
    (gen_random_uuid(), v_res_id, 10, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 11, 38.0, NULL, true, '38', now());

  -- [Gold] Rank 9: Alyssa Li Lin Wong (SGP 150)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Alyssa Li Lin Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Alyssa Li Lin Wong', 'alyssa-li-lin-wong-c063db', '150', 'SAFYC', 'SEC RAFFLES GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '150' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'SEC RAFFLES GIRLS'' SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 9, 136.0, 91.0, false, 'F', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 2, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 3, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 4, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 5, 19.0, NULL, true, '19', now()),
    (gen_random_uuid(), v_res_id, 6, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 7, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 8, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 9, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 10, 26.0, NULL, true, '26', now()),
    (gen_random_uuid(), v_res_id, 11, 2.0, NULL, false, '2', now());

  -- [Gold] Rank 10: Xuan Ya Tong (SGP 175)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Xuan Ya Tong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Xuan Ya Tong', 'xuan-ya-tong-663e27', '175', 'CWSS', NULL, 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '175' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 10, 178.0, 94.0, false, 'F', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 2, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 3, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 4, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 5, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 6, 30.0, NULL, true, '30', now()),
    (gen_random_uuid(), v_res_id, 7, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 8, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 9, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 10, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 11, 24.0, NULL, false, '24', now());

  -- [Gold] Rank 11: Ethan Lee (SGP 83)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ethan Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ethan Lee', 'ethan-lee-6efc56', '83', 'PA', 'SEC VICTORIA SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '83' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PA'),
      school = COALESCE(school, 'SEC VICTORIA SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 11, 160.0, 97.0, false, 'M', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 2, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 3, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 4, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 5, 32.0, NULL, true, '32', now()),
    (gen_random_uuid(), v_res_id, 6, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 7, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 8, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 9, 31.0, NULL, true, '31', now()),
    (gen_random_uuid(), v_res_id, 10, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 11, 9.0, NULL, false, '9', now());

  -- [Gold] Rank 12: Pariyaporn Chantarawong (THA 1223)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Pariyaporn Chantarawong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Pariyaporn Chantarawong', 'pariyaporn-chantarawong-0f27a7', '1223', 'YRAT', NULL, 'F', 'THA', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '1223' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'YRAT'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'THA'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 12, 173.0, 101.0, false, 'F', 2011, 'THA', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 2, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 3, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 4, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 5, 36.0, NULL, true, '36', now()),
    (gen_random_uuid(), v_res_id, 6, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 7, 36.0, NULL, true, '36', now()),
    (gen_random_uuid(), v_res_id, 8, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 9, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 10, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 11, 20.0, NULL, false, '20', now());

  -- [Gold] Rank 13: Elijah Ong (SGP 140)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elijah Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elijah Ong', 'elijah-ong-237c06', '140', '(INDEPENDENT)SAFYC', 'SEC ANGLO-CHINESE SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '140' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), '(INDEPENDENT)SAFYC'),
      school = COALESCE(school, 'SEC ANGLO-CHINESE SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 13, 201.0, 103.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 2, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 3, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 4, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 5, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 6, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 7, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 8, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 9, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 10, 44.0, NULL, true, '44', now()),
    (gen_random_uuid(), v_res_id, 11, 54.0, NULL, true, '54', now());

  -- [Gold] Rank 14: Elliot Goh (SGP 3103)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elliot Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elliot Goh', 'elliot-goh-c08f54', '3103', '(INDEPENDENT)SAFYC', 'SEC ANGLO-CHINESE SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3103' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), '(INDEPENDENT)SAFYC'),
      school = COALESCE(school, 'SEC ANGLO-CHINESE SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 14, 213.0, 105.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 2, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 3, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 4, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 5, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 6, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 7, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 8, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 9, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 10, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 11, 54.0, NULL, true, '54', now());

  -- [Gold] Rank 15: Jaye Xi En Low (SGP 3279)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jaye Xi En Low')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jaye Xi En Low', 'jaye-xi-en-low-b72a6b', '3279', 'PA', 'SEC DUNMAN HIGH SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3279' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PA'),
      school = COALESCE(school, 'SEC DUNMAN HIGH SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 15, 203.0, 106.0, false, 'F', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 2, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 3, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 4, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 5, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 6, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 7, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 8, 46.0, NULL, true, '46', now()),
    (gen_random_uuid(), v_res_id, 9, 51.0, NULL, true, '51', now()),
    (gen_random_uuid(), v_res_id, 10, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 11, 4.0, NULL, false, '4', now());

  -- [Gold] Rank 16: Jedd Zhi Hao Lam (SGP 2000)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jedd Zhi Hao Lam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jedd Zhi Hao Lam', 'jedd-zhi-hao-lam-60d557', '2000', 'CWSS', 'SEC RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2000' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'SEC RAFFLES INSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 16, 173.0, 114.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 2, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 3, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 4, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 5, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 6, 32.0, NULL, true, '32', now()),
    (gen_random_uuid(), v_res_id, 7, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 8, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 9, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 10, 27.0, NULL, true, '27', now()),
    (gen_random_uuid(), v_res_id, 11, 14.0, NULL, false, '14', now());

  -- [Gold] Rank 17: Rahul Rajakanth (SGP 2006)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rahul Rajakanth')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rahul Rajakanth', 'rahul-rajakanth-2d35d5', '2006', '(INDEPENDENT)CWSS', 'SEC ANGLO-CHINESE SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2006' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), '(INDEPENDENT)CWSS'),
      school = COALESCE(school, 'SEC ANGLO-CHINESE SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 17, 205.0, 114.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 2, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 3, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 4, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 5, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 6, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 7, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 8, 43.0, NULL, true, '43', now()),
    (gen_random_uuid(), v_res_id, 9, 48.0, NULL, true, '48', now()),
    (gen_random_uuid(), v_res_id, 10, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 11, 18.0, NULL, false, '18', now());

  -- [Gold] Rank 18: Lucas Zhihong Cao (SGP 149)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lucas Zhihong Cao')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lucas Zhihong Cao', 'lucas-zhihong-cao-cba056', '149', 'SAFYC', 'SEC RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '149' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'SEC RAFFLES INSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 18, 209.0, 122.0, false, 'M', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 2, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 3, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 4, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 5, 33.0, NULL, true, '33', now()),
    (gen_random_uuid(), v_res_id, 6, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 7, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 8, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 9, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 10, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 11, 22.0, NULL, false, '22', now());

  -- [Gold] Rank 19: Cheuk Hymn Decimus Chan (HKG 192)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cheuk Hymn Decimus Chan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cheuk Hymn Decimus Chan', 'cheuk-hymn-decimus-chan-2836c6', '192', 'RHKYC', NULL, 'M', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '192' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'RHKYC'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'HKG'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 19, 231.0, 127.0, false, 'M', 2013, 'HKG', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 2, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 3, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 4, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 5, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 6, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 7, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 8, 50.0, NULL, true, '50', now()),
    (gen_random_uuid(), v_res_id, 9, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 10, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 11, 6.0, NULL, false, '6', now());

  -- [Gold] Rank 20: Ethan Zhi Ren Low (SGP 78)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ethan Zhi Ren Low')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ethan Zhi Ren Low', 'ethan-zhi-ren-low-7045d7', '78', 'SAFYC', '11-12yo PRI ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '78' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 20, 212.0, 130.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 2, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 3, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 4, 35.0, NULL, true, '35', now()),
    (gen_random_uuid(), v_res_id, 5, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 6, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 7, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 8, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 9, 47.0, NULL, true, '47', now()),
    (gen_random_uuid(), v_res_id, 10, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 11, 10.0, NULL, false, '10', now());

  -- [Gold] Rank 21: Zhichen Jiang (CHN 8101)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zhichen Jiang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zhichen Jiang', 'zhichen-jiang-05d128', '8101', 'SHSD', '11-12yo', 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '8101' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SHSD'),
      school = COALESCE(school, '11-12yo'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 21, 227.0, 132.0, false, 'M', 2015, 'CHN', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 2, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 3, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 4, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 5, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 6, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 7, 41.0, NULL, true, '41', now()),
    (gen_random_uuid(), v_res_id, 8, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 9, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 10, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 11, 17.0, NULL, false, '17', now());

  -- [Gold] Rank 22: Surapha Muangngam (THA 1941)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Surapha Muangngam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Surapha Muangngam', 'surapha-muangngam-c0d5c8', '1941', 'YRAT', NULL, 'F', 'THA', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '1941' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'YRAT'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'THA'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 22, 227.0, 134.0, false, 'F', 2011, 'THA', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 2, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 3, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 4, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 5, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 6, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 7, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 8, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 9, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 10, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 11, 39.0, NULL, true, '39', now());

  -- [Gold] Rank 23: Damien Huang (SGP 3300)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Damien Huang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Damien Huang', 'damien-huang-3aa9d0', '3300', 'PA', 'SEC RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3300' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PA'),
      school = COALESCE(school, 'SEC RAFFLES INSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 23, 217.0, 145.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 2, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 3, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 4, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 5, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 6, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 7, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 8, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 9, 26.0, NULL, true, '26', now()),
    (gen_random_uuid(), v_res_id, 10, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 11, 46.0, NULL, true, '46', now());

  -- [Gold] Rank 24: Rachel Qian Hui Lim (SGP 3197)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rachel Qian Hui Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rachel Qian Hui Lim', 'rachel-qian-hui-lim-5aa193', '3197', 'SAFYC', '11-12yo PRI HAIG GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3197' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI HAIG GIRLS'' SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 24, 237.0, 147.0, false, 'F', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 2, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 3, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 4, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 5, 39.0, NULL, true, '39', now()),
    (gen_random_uuid(), v_res_id, 6, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 7, 51.0, NULL, true, '51', now()),
    (gen_random_uuid(), v_res_id, 8, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 9, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 10, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 11, 27.0, NULL, false, '27', now());

  -- [Gold] Rank 25: Jeremiah Rui Feng Ong (SGP 3373)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jeremiah Rui Feng Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jeremiah Rui Feng Ong', 'jeremiah-rui-feng-ong-535938', '3373', 'SAFYC', '11-12yo PRI ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3373' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 25, 226.0, 160.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 34.0, NULL, true, '34', now()),
    (gen_random_uuid(), v_res_id, 2, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 3, 32.0, NULL, true, '32', now()),
    (gen_random_uuid(), v_res_id, 4, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 5, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 6, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 7, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 8, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 9, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 10, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 11, 15.0, NULL, false, '15', now());

  -- [Gold] Rank 26: Darian Huang (SGP 3700)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Darian Huang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Darian Huang', 'darian-huang-9904a9', '3700', 'PA', '11-12yo PRI ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3700' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PA'),
      school = COALESCE(school, '11-12yo PRI ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 26, 244.0, 164.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 2, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 3, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 4, 38.0, NULL, true, '38', now()),
    (gen_random_uuid(), v_res_id, 5, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 6, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 7, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 8, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 9, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 10, 42.0, NULL, true, '42', now()),
    (gen_random_uuid(), v_res_id, 11, 13.0, NULL, false, '13', now());

  -- [Gold] Rank 27: Siti Ra'idah Binte Mohd Airudin (SGP 1141)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Siti Ra''idah Binte Mohd Airudin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Siti Ra''idah Binte Mohd Airudin', 'siti-ra-idah-binte-mohd-airudin-75f025', '1141', 'PA', 'SEC ORCHID PARK SECONDARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '1141' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PA'),
      school = COALESCE(school, 'SEC ORCHID PARK SECONDARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 27, 261.0, 167.0, false, 'F', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 2, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 3, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 4, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 5, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 6, 49.0, NULL, true, '49', now()),
    (gen_random_uuid(), v_res_id, 7, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 8, 45.0, NULL, true, '45', now()),
    (gen_random_uuid(), v_res_id, 9, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 10, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 11, 30.0, NULL, false, '30', now());

  -- [Gold] Rank 28: Olivia Ting Jia Cheong (SGP 3002)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Olivia Ting Jia Cheong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Olivia Ting Jia Cheong', 'olivia-ting-jia-cheong-6eddaf', '3002', 'SAFYC', 'SEC RAFFLES GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3002' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'SEC RAFFLES GIRLS'' SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 28, 252.0, 169.0, false, 'F', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 2, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 3, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 4, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 5, 44.0, NULL, true, '44', now()),
    (gen_random_uuid(), v_res_id, 6, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 7, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 8, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 9, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 10, 39.0, NULL, true, '39', now()),
    (gen_random_uuid(), v_res_id, 11, 19.0, NULL, false, '19', now());

  -- [Gold] Rank 29: Wangsun Chen (MAC 20)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Wangsun Chen')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Wangsun Chen', 'wangsun-chen-8807e5', '20', 'CWSS', 'PRI YUMIN PRIMARY SCHOOL', 'M', 'MAC', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '20' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'PRI YUMIN PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'MAC'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 29, 260.0, 171.0, false, 'M', 2013, 'MAC', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 2, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 3, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 4, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 5, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 6, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 7, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 8, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 9, 35.0, NULL, true, '35', now()),
    (gen_random_uuid(), v_res_id, 10, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 11, 31.0, NULL, false, '31', now());

  -- [Gold] Rank 30: Rui Ling Teo (SGP 3820)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rui Ling Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rui Ling Teo', 'rui-ling-teo-64f76f', '3820', 'SAFYC', '11-12yo PRI CHIJ (KATONG) PRIMARY', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3820' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI CHIJ (KATONG) PRIMARY'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 30, 262.0, 178.0, false, 'F', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 2, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 3, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 4, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 5, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 6, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 7, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 8, 40.0, NULL, true, '40', now()),
    (gen_random_uuid(), v_res_id, 9, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 10, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 11, 44.0, NULL, true, '44', now());

  -- [Gold] Rank 31: Dylan Yue Teng Goh (SGP 3800)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Dylan Yue Teng Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Dylan Yue Teng Goh', 'dylan-yue-teng-goh-3fc1a5', '3800', 'SAFYC', 'SEC VICTORIA SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3800' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'SEC VICTORIA SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 31, 259.0, 187.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 2, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 3, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 4, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 5, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 6, 41.0, NULL, true, '41', now()),
    (gen_random_uuid(), v_res_id, 7, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 8, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 9, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 10, 31.0, NULL, true, '31', now()),
    (gen_random_uuid(), v_res_id, 11, 25.0, NULL, false, '25', now());

  -- [Gold] Rank 32: Edrei En Xu Ong (SGP 3957)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Edrei En Xu Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Edrei En Xu Ong', 'edrei-en-xu-ong-254b73', '3957', 'SAFYC', '11-12yo PRI ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3957' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 32, 282.0, 192.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 2, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 3, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 4, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 5, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 6, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 7, 46.0, NULL, true, '46', now()),
    (gen_random_uuid(), v_res_id, 8, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 9, 44.0, NULL, true, '44', now()),
    (gen_random_uuid(), v_res_id, 10, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 11, 11.0, NULL, false, '11', now());

  -- [Gold] Rank 33: Luke Yi Jie Loh (SGP 3322)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Luke Yi Jie Loh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Luke Yi Jie Loh', 'luke-yi-jie-loh-c243ab', '3322', 'SAFYC', '11-12yo PRI TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3322' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 33, 272.0, 196.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 2, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 3, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 4, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 5, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 6, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 7, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 8, 33.0, NULL, true, '33', now()),
    (gen_random_uuid(), v_res_id, 9, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 10, 43.0, NULL, true, '43', now()),
    (gen_random_uuid(), v_res_id, 11, 16.0, NULL, false, '16', now());

  -- [Gold] Rank 34: Xingxun Wang (CHN 1297)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Xingxun Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Xingxun Wang', 'xingxun-wang-f23e04', '1297', 'SHSD', '11-12yo', 'F', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '1297' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SHSD'),
      school = COALESCE(school, '11-12yo'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 34, 288.0, 198.0, false, 'F', 2014, 'CHN', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 2, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 3, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 4, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 5, 46.0, NULL, true, '46', now()),
    (gen_random_uuid(), v_res_id, 6, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 7, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 8, 44.0, NULL, true, '44', now()),
    (gen_random_uuid(), v_res_id, 9, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 10, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 11, 5.0, NULL, false, '5', now());

  -- [Gold] Rank 35: Kaelyn Dayna Zhi Yi Soh (SGP 3113)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kaelyn Dayna Zhi Yi Soh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kaelyn Dayna Zhi Yi Soh', 'kaelyn-dayna-zhi-yi-soh-e313e9', '3113', 'SAFYC', 'SEC RAFFLES GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3113' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'SEC RAFFLES GIRLS'' SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 35, 305.0, 203.0, false, 'F', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 2, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 3, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 4, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 5, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 6, 48.0, NULL, true, '48', now()),
    (gen_random_uuid(), v_res_id, 7, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 8, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 9, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 10, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 11, 34.0, NULL, false, '34', now());

  -- [Gold] Rank 36: Kyle Jeremy Zhi Jun Soh (SGP 3183)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kyle Jeremy Zhi Jun Soh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kyle Jeremy Zhi Jun Soh', 'kyle-jeremy-zhi-jun-soh-9c88dd', '3183', 'SAFYC', '11-12yo PRI ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3183' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 36, 296.0, 204.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 2, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 3, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 4, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 5, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 6, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 7, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 8, 38.0, NULL, true, '38', now()),
    (gen_random_uuid(), v_res_id, 9, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 10, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 11, 54.0, NULL, true, '54', now());

  -- [Gold] Rank 37: Shin Chen Rui Lin (SGP 3333)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Shin Chen Rui Lin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Shin Chen Rui Lin', 'shin-chen-rui-lin-8c1dc9', '3333', 'SAFYC', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3333' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 37, 306.0, 207.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 2, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 3, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 4, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 5, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 6, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 7, 49.0, NULL, true, '49', now()),
    (gen_random_uuid(), v_res_id, 8, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 9, 50.0, NULL, true, '50', now()),
    (gen_random_uuid(), v_res_id, 10, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 11, 21.0, NULL, false, '21', now());

  -- [Gold] Rank 38: Padmaeja Rajakanth (SGP 2022)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Padmaeja Rajakanth')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Padmaeja Rajakanth', 'padmaeja-rajakanth-4d5566', '2022', 'CWSS', '11-12yo PRI RAFFLES GIRLS'' PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2022' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, '11-12yo PRI RAFFLES GIRLS'' PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 38, 303.0, 215.0, false, 'F', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 2, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 3, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 4, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 5, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 6, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 7, 47.0, NULL, true, '47', now()),
    (gen_random_uuid(), v_res_id, 8, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 9, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 10, 41.0, NULL, true, '41', now()),
    (gen_random_uuid(), v_res_id, 11, 26.0, NULL, false, '26', now());

  -- [Gold] Rank 39: Jairus Xin Jie Teo (SGP 4073)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jairus Xin Jie Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jairus Xin Jie Teo', 'jairus-xin-jie-teo-b34134', '4073', 'SAFYC', 'SEC ST. ANDREW''S SECONDARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4073' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'SEC ST. ANDREW''S SECONDARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 39, 323.0, 215.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 2, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 3, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 4, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 5, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 6, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 7, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 8, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 9, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 10, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 11, 54.0, NULL, true, '54', now());

  -- [Gold] Rank 40: Lavene Rui Xuan Lim (SGP 3553)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lavene Rui Xuan Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lavene Rui Xuan Lim', 'lavene-rui-xuan-lim-08847a', '3553', 'SAFYC', '11-12yo PRI PASIR RIS PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3553' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI PASIR RIS PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 40, 324.0, 216.0, false, 'F', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 2, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 3, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 4, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 5, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 6, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 7, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 8, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 9, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 10, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 11, 54.0, NULL, true, '54', now());

  -- [Gold] Rank 41: Haojin Li (CHN 8133)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Haojin Li')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Haojin Li', 'haojin-li-7aa8f5', '8133', 'SHSD', NULL, 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '8133' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SHSD'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 41, 317.0, 216.0, false, 'M', 2012, 'CHN', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 2, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 3, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 4, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 5, 47.0, NULL, true, '47', now()),
    (gen_random_uuid(), v_res_id, 6, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 7, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 8, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 9, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 10, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 11, 32.0, NULL, false, '32', now());

  -- [Gold] Rank 42: Shringhari Roy (IND 1770)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Shringhari Roy')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Shringhari Roy', 'shringhari-roy-bbb537', '1770', 'YAI', NULL, 'F', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '1770' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'YAI'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 42, 307.0, 222.0, false, 'F', 2011, 'IND', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 2, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 3, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 4, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 5, 45.0, NULL, true, '45', now()),
    (gen_random_uuid(), v_res_id, 6, 40.0, NULL, true, '40', now()),
    (gen_random_uuid(), v_res_id, 7, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 8, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 9, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 10, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 11, 33.0, NULL, false, '33', now());

  -- [Gold] Rank 43: Nicole Jing Chen Wong (SGP 3006)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nicole Jing Chen Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nicole Jing Chen Wong', 'nicole-jing-chen-wong-1aab5c', '3006', 'SAFYC', '11-12yo SEC CHIJ ST. THERESA''S CONVENT', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3006' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo SEC CHIJ ST. THERESA''S CONVENT'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 43, 324.0, 222.0, false, 'F', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 2, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 3, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 4, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 5, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 6, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 7, 48.0, NULL, true, '48', now()),
    (gen_random_uuid(), v_res_id, 8, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 9, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 10, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 11, 54.0, NULL, true, '54', now());

  -- [Gold] Rank 44: Joseph Kia Guan Tan (SGP 3688)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joseph Kia Guan Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joseph Kia Guan Tan', 'joseph-kia-guan-tan-e070d6', '3688', 'SAFYC', 'SEC ST. JOSEPH''S INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3688' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'SEC ST. JOSEPH''S INSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 44, 306.0, 225.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 2, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 3, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 4, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 5, 35.0, NULL, true, '35', now()),
    (gen_random_uuid(), v_res_id, 6, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 7, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 8, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 9, 46.0, NULL, true, '46', now()),
    (gen_random_uuid(), v_res_id, 10, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 11, 35.0, NULL, false, '35', now());

  -- [Gold] Rank 45: Kirsten En Ting Tan (SGP 3663)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kirsten En Ting Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kirsten En Ting Tan', 'kirsten-en-ting-tan-b47571', '3663', 'SAFYC', '9-10yo PRI ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3663' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '9-10yo PRI ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 45, 336.0, 232.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 2, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 3, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 4, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 5, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 6, 50.0, NULL, true, '50', now()),
    (gen_random_uuid(), v_res_id, 7, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 8, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 9, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 10, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 11, 12.0, NULL, false, '12', now());

  -- [Gold] Rank 46: Ravi K Benneollu (IND 1644)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ravi K Benneollu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ravi K Benneollu', 'ravi-k-benneollu-282f91', '1644', 'YAI', NULL, 'M', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '1644' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'YAI'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 46, 336.0, 239.0, false, 'M', 2011, 'IND', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 2, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 3, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 4, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 6, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 7, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 8, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 9, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 10, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 11, 43.0, NULL, true, '43', now());

  -- [Gold] Rank 47: Krishna Venkitachalam Ramakrishnan (IND 1639)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Krishna Venkitachalam Ramakrishnan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Krishna Venkitachalam Ramakrishnan', 'krishna-venkitachalam-ramakrishnan-178f52', '1639', 'YAI', '13yo', 'M', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '1639' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'YAI'),
      school = COALESCE(school, '13yo'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 47, 348.0, 242.0, false, 'M', 2012, 'IND', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 2, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 3, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 4, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 5, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 6, 52.0, NULL, true, '52', now()),
    (gen_random_uuid(), v_res_id, 7, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 8, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 9, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 10, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 11, 41.0, NULL, false, '41', now());

  -- [Gold] Rank 48: S K Rameeza Bhanu (IND 1716)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('S K Rameeza Bhanu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'S K Rameeza Bhanu', 's-k-rameeza-bhanu-3788e8', '1716', 'YAI', NULL, 'F', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '1716' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'YAI'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 48, 339.0, 244.0, false, 'F', 2011, 'IND', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 2, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 3, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 4, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 5, 51.0, NULL, true, '51', now()),
    (gen_random_uuid(), v_res_id, 6, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 7, 44.0, NULL, true, '44', now()),
    (gen_random_uuid(), v_res_id, 8, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 9, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 10, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 11, 42.0, NULL, false, '42', now());

  -- [Gold] Rank 49: Tan Herng Yee (SGP 3000)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tan Herng Yee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tan Herng Yee', 'tan-herng-yee-905a15', '3000', '(INDEPENDENT)SAFYC', 'SEC ANGLO-CHINESE SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3000' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), '(INDEPENDENT)SAFYC'),
      school = COALESCE(school, 'SEC ANGLO-CHINESE SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 49, 375.0, 267.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 2, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 3, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 4, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 5, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 6, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 7, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 8, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 9, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 10, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 11, 29.0, NULL, false, '29', now());

  -- [Gold] Rank 50: Meera Srihari (SGP 3889)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Meera Srihari')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Meera Srihari', 'meera-srihari-7766b6', '3889', 'SAFYC', '9-10yo PRI RAFFLES GIRLS'' PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3889' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '9-10yo PRI RAFFLES GIRLS'' PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 50, 374.0, 278.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 2, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 3, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 4, 45.0, NULL, true, '45', now()),
    (gen_random_uuid(), v_res_id, 5, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 6, 51.0, NULL, true, '51', now()),
    (gen_random_uuid(), v_res_id, 7, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 8, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 9, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 10, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 11, 45.0, NULL, false, '45', now());

  -- [Gold] Rank 51: Dan Guan You Toh (SGP 3811)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Dan Guan You Toh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Dan Guan You Toh', 'dan-guan-you-toh-c4ac6b', '3811', 'SAFYC', '11-12yo MARIS STELLA HIGH SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3811' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo MARIS STELLA HIGH SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 51, 374.0, 279.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 2, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 3, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 4, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 5, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 6, 46.0, NULL, true, '46', now()),
    (gen_random_uuid(), v_res_id, 7, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 8, 49.0, NULL, true, '49', now()),
    (gen_random_uuid(), v_res_id, 9, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 10, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 11, 36.0, NULL, false, '36', now());

  -- [Gold] Rank 52: Yiyi Han (CHN 511)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yiyi Han')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yiyi Han', 'yiyi-han-493414', '511', 'School', '11-12yo Xiamen Sports', 'F', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '511' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'School'),
      school = COALESCE(school, '11-12yo Xiamen Sports'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 52, 425.0, 317.0, false, 'F', 2014, 'CHN', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 2, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 3, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 4, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 6, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 7, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 8, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 9, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 10, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 11, 37.0, NULL, false, '37', now());

  -- [Gold] Rank 53: Joel Han Sheng Ong (SGP 2014)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joel Han Sheng Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joel Han Sheng Ong', 'joel-han-sheng-ong-96d8c3', '2014', 'CWSS', '11-12yo PRI TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2014' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, '11-12yo PRI TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 53, 425.0, 320.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 2, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 3, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 4, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 5, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 6, 53.0, NULL, true, '53', now()),
    (gen_random_uuid(), v_res_id, 7, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 8, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 9, 52.0, NULL, true, '52', now()),
    (gen_random_uuid(), v_res_id, 10, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 11, 47.0, NULL, false, '47', now());

  -- [Gold] Rank 54: Yen Yu Kai (SGP 758)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yen Yu Kai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yen Yu Kai', 'yen-yu-kai-22dee6', '758', 'CSC', 'SEC RAFFLES GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '758' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CSC'),
      school = COALESCE(school, 'SEC RAFFLES GIRLS'' SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 54, 199.0, 116.0, false, 'F', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 29.0, NULL, true, '29', now()),
    (gen_random_uuid(), v_res_id, 2, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 3, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 4, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 5, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 6, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 7, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 8, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 9, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 10, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 11, 5.0, NULL, false, '5', now());

  -- [Gold] Rank 55: Yvette Yi Min Chow (SGP 3151)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yvette Yi Min Chow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yvette Yi Min Chow', 'yvette-yi-min-chow-45eecd', '3151', 'SCHOOLSAFYC', '11-12yo PRI PEI HWA PRESBYTERIAN PRIMARY', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3151' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SCHOOLSAFYC'),
      school = COALESCE(school, '11-12yo PRI PEI HWA PRESBYTERIAN PRIMARY'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 55, 202.0, 126.0, false, 'F', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 41.0, NULL, true, '41', now()),
    (gen_random_uuid(), v_res_id, 2, 35.0, NULL, true, '35', now()),
    (gen_random_uuid(), v_res_id, 3, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 4, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 5, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 6, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 7, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 8, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 9, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 10, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 11, 11.0, NULL, false, '11', now());

  -- [Gold] Rank 56: Aidan Armand Anuar (SGP 3143)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aidan Armand Anuar')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aidan Armand Anuar', 'aidan-armand-anuar-a6820f', '3143', 'SAFYC', '11-12yo PRI TANJONG KATONG PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3143' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI TANJONG KATONG PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 56, 205.0, 128.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 2, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 3, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 4, 47.0, NULL, true, '47', now()),
    (gen_random_uuid(), v_res_id, 5, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 6, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 7, 30.0, NULL, true, '30', now()),
    (gen_random_uuid(), v_res_id, 8, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 9, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 10, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 11, 7.0, NULL, false, '7', now());

  -- [Gold] Rank 57: Pornyamol Sawaengkhun (THA 1900)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Pornyamol Sawaengkhun')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Pornyamol Sawaengkhun', 'pornyamol-sawaengkhun-b8be0f', '1900', 'YRAT', NULL, 'F', 'THA', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '1900' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'YRAT'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'THA'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 57, 207.0, 129.0, false, 'F', 2013, 'THA', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 2, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 3, 36.0, NULL, true, '36', now()),
    (gen_random_uuid(), v_res_id, 4, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 5, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 6, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 7, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 8, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 9, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 10, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 11, 42.0, NULL, true, '42', now());

  -- [Gold] Rank 58: Joel Zhuo Le Khoo (SGP 4730)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joel Zhuo Le Khoo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joel Zhuo Le Khoo', 'joel-zhuo-le-khoo-a61825', '4730', 'SAFYC', '11-12yo PRI NANYANG PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4730' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI NANYANG PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 58, 214.0, 137.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 40.0, NULL, true, '40', now()),
    (gen_random_uuid(), v_res_id, 2, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 3, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 4, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 5, 37.0, NULL, true, '37', now()),
    (gen_random_uuid(), v_res_id, 6, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 7, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 8, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 9, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 10, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 11, 6.0, NULL, false, '6', now());

  -- [Gold] Rank 59: Timothy Kai Zhe Ng (SGP 2023)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Timothy Kai Zhe Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Timothy Kai Zhe Ng', 'timothy-kai-zhe-ng-894679', '2023', 'CWSS', '11-12yo PRI TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2023' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, '11-12yo PRI TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 59, 226.0, 138.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 2, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 3, 34.0, NULL, true, '34', now()),
    (gen_random_uuid(), v_res_id, 4, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 5, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 6, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 7, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 8, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 9, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 10, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 11, 2.0, NULL, false, '2', now());

  -- [Gold] Rank 60: Quintan Rupert Low (SGP 4681)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Quintan Rupert Low')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Quintan Rupert Low', 'quintan-rupert-low-87501e', '4681', 'SAFYC', '11-12yo PRI ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4681' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 60, 221.0, 143.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 33.0, NULL, true, '33', now()),
    (gen_random_uuid(), v_res_id, 2, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 3, 45.0, NULL, true, '45', now()),
    (gen_random_uuid(), v_res_id, 4, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 5, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 6, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 7, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 8, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 9, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 10, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 11, 22.0, NULL, false, '22', now());

  -- [Gold] Rank 61: Yuk Pin Lim (SGP 3880)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuk Pin Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuk Pin Lim', 'yuk-pin-lim-1f87d6', '3880', 'SAFYC', 'SEC ST. JOSEPH''S INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3880' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'SEC ST. JOSEPH''S INSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 61, 243.0, 152.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 51.0, NULL, true, '51', now()),
    (gen_random_uuid(), v_res_id, 2, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 3, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 4, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 5, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 6, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 7, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 8, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 9, 40.0, NULL, true, '40', now()),
    (gen_random_uuid(), v_res_id, 10, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 11, 1.0, NULL, false, '1', now());

  -- [Gold] Rank 62: Katelynn Kai En Lee (SGP 3383)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Katelynn Kai En Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Katelynn Kai En Lee', 'katelynn-kai-en-lee-d21524', '3383', 'SCHOOLSAFYC', '11-12yo PRI ST. ANTHONY''S CANOSSIAN PRIMARY', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3383' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SCHOOLSAFYC'),
      school = COALESCE(school, '11-12yo PRI ST. ANTHONY''S CANOSSIAN PRIMARY'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 62, 247.0, 159.0, false, 'F', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 44.0, NULL, true, '44', now()),
    (gen_random_uuid(), v_res_id, 2, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 3, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 4, 44.0, NULL, true, '44', now()),
    (gen_random_uuid(), v_res_id, 5, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 6, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 7, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 8, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 9, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 10, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 11, 32.0, NULL, false, '32', now());

  -- [Gold] Rank 63: Lucas Rui Kai Lim (SGP 3355)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lucas Rui Kai Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lucas Rui Kai Lim', 'lucas-rui-kai-lim-476ff6', '3355', 'SAFYC', 'SEC ST. JOSEPH''S INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3355' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'SEC ST. JOSEPH''S INSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 63, 244.0, 162.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 2, 42.0, NULL, true, '42', now()),
    (gen_random_uuid(), v_res_id, 3, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 4, 40.0, NULL, true, '40', now()),
    (gen_random_uuid(), v_res_id, 5, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 6, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 7, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 8, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 9, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 10, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 11, 23.0, NULL, false, '23', now());

  -- [Gold] Rank 64: Jared Soon Kit Liew (SGP 2002)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jared Soon Kit Liew')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jared Soon Kit Liew', 'jared-soon-kit-liew-aa578e', '2002', 'PA', 'SEC NGEE ANN SECONDARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2002' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PA'),
      school = COALESCE(school, 'SEC NGEE ANN SECONDARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 64, 242.0, 165.0, false, 'M', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 2, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 3, 46.0, NULL, true, '46', now()),
    (gen_random_uuid(), v_res_id, 4, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 5, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 6, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 7, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 8, 31.0, NULL, true, '31', now()),
    (gen_random_uuid(), v_res_id, 9, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 10, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 11, 26.0, NULL, false, '26', now());

  -- [Gold] Rank 65: Joshua Zhi Kai Tan (SGP 3036)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joshua Zhi Kai Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joshua Zhi Kai Tan', 'joshua-zhi-kai-tan-ed3ae4', '3036', 'SAFYC', '11-12yo PRI ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3036' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 65, 240.0, 172.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 2, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 3, 33.0, NULL, true, '33', now()),
    (gen_random_uuid(), v_res_id, 4, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 5, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 6, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 7, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 8, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 9, 35.0, NULL, true, '35', now()),
    (gen_random_uuid(), v_res_id, 10, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 11, 9.0, NULL, false, '9', now());

  -- [Gold] Rank 66: Abby Yan Ying Chen (SGP 4729)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Abby Yan Ying Chen')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Abby Yan Ying Chen', 'abby-yan-ying-chen-3d3c55', '4729', 'PA', '9-10yo PRI CHIJ ST. NICHOLAS GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4729' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PA'),
      school = COALESCE(school, '9-10yo PRI CHIJ ST. NICHOLAS GIRLS'' SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 66, 278.0, 185.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 48.0, NULL, true, '48', now()),
    (gen_random_uuid(), v_res_id, 2, 45.0, NULL, true, '45', now()),
    (gen_random_uuid(), v_res_id, 3, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 4, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 5, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 6, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 7, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 8, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 9, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 10, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 11, 4.0, NULL, false, '4', now());

  -- [Gold] Rank 67: Aaron Zhiyi Chiang (SGP 3128)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aaron Zhiyi Chiang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aaron Zhiyi Chiang', 'aaron-zhiyi-chiang-d84168', '3128', 'SAFYC', '11-12yo PRI TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3128' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 67, 277.0, 198.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 37.0, NULL, true, '37', now()),
    (gen_random_uuid(), v_res_id, 2, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 3, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 4, 42.0, NULL, true, '42', now()),
    (gen_random_uuid(), v_res_id, 5, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 6, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 7, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 8, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 9, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 10, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 11, 17.0, NULL, false, '17', now());

  -- [Gold] Rank 68: Gentaro Noah Lee (SGP 4471)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gentaro Noah Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gentaro Noah Lee', 'gentaro-noah-lee-77d06e', '4471', 'PA', '11-12yo PRI ANGLO-CHINESE SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4471' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PA'),
      school = COALESCE(school, '11-12yo PRI ANGLO-CHINESE SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 68, 294.0, 200.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 2, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 3, 50.0, NULL, true, '50', now()),
    (gen_random_uuid(), v_res_id, 4, 44.0, NULL, true, '44', now()),
    (gen_random_uuid(), v_res_id, 5, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 6, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 7, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 8, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 9, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 10, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 11, 13.0, NULL, false, '13', now());

  -- [Gold] Rank 69: Mikaela Hui Ting Wong (SGP 3029)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mikaela Hui Ting Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mikaela Hui Ting Wong', 'mikaela-hui-ting-wong-abbcba', '3029', 'SAFYC', '11-12yo PRI ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3029' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 69, 300.0, 200.0, false, 'F', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 2, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 3, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 4, 46.0, NULL, true, '46', now()),
    (gen_random_uuid(), v_res_id, 5, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 6, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 7, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 8, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 9, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 10, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 11, 10.0, NULL, false, '10', now());

  -- [Gold] Rank 70: Yuexuan Lin (CHN 506)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuexuan Lin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuexuan Lin', 'yuexuan-lin-e8914c', '506', 'School', '11-12yo Xiamen Sports', 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '506' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'School'),
      school = COALESCE(school, '11-12yo Xiamen Sports'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 70, 308.0, 206.0, false, 'M', 2015, 'CHN', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 2, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 3, 51.0, NULL, true, '51', now()),
    (gen_random_uuid(), v_res_id, 4, 51.0, NULL, true, '51', now()),
    (gen_random_uuid(), v_res_id, 5, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 6, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 7, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 8, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 9, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 10, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 11, 3.0, NULL, false, '3', now());

  -- [Gold] Rank 71: Ayush Dipak Nikam (IND 1001)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ayush Dipak Nikam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ayush Dipak Nikam', 'ayush-dipak-nikam-c434ef', '1001', 'YAI', NULL, 'M', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '1001' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'YAI'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 71, 322.0, 214.0, false, 'M', 2012, 'IND', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 2, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 3, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 4, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 5, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 6, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 7, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 8, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 9, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 10, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 11, 25.0, NULL, false, '25', now());

  -- [Gold] Rank 72: Jude Nathan Wong (SGP 3495)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jude Nathan Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jude Nathan Wong', 'jude-nathan-wong-8736da', '3495', 'SAFYC', '11-12yo PRI ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3495' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 72, 329.0, 221.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 2, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 3, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 4, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 5, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 6, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 7, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 8, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 9, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 10, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 11, 54.0, NULL, false, '54', now());

  -- [Gold] Rank 73: Narasimha Vutla (IND 1466)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Narasimha Vutla')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Narasimha Vutla', 'narasimha-vutla-8c51ac', '1466', 'YAI', NULL, 'M', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '1466' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'YAI'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 73, 307.0, 222.0, false, 'M', 2011, 'IND', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 46.0, NULL, true, '46', now()),
    (gen_random_uuid(), v_res_id, 2, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 3, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 4, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 5, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 6, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 7, 39.0, NULL, true, '39', now()),
    (gen_random_uuid(), v_res_id, 8, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 9, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 10, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 11, 15.0, NULL, false, '15', now());

  -- [Gold] Rank 74: Hayley Kai En Tan (SGP 700)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hayley Kai En Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hayley Kai En Tan', 'hayley-kai-en-tan-9ae485', '700', 'CSC', '9-10yo PRI Kong Hwa School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '700' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CSC'),
      school = COALESCE(school, '9-10yo PRI Kong Hwa School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 74, 325.0, 225.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 2, 50.0, NULL, true, '50', now()),
    (gen_random_uuid(), v_res_id, 3, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 4, 50.0, NULL, true, '50', now()),
    (gen_random_uuid(), v_res_id, 5, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 6, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 7, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 8, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 9, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 10, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 11, 28.0, NULL, false, '28', now());

  -- [Gold] Rank 75: Zachary Zhi En Low (SGP 3369)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zachary Zhi En Low')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zachary Zhi En Low', 'zachary-zhi-en-low-c7588c', '3369', 'SAFYC', 'SEC ST. JOSEPH''S INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3369' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'SEC ST. JOSEPH''S INSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 75, 324.0, 226.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 53.0, NULL, true, '53', now()),
    (gen_random_uuid(), v_res_id, 2, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 3, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 4, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 5, 45.0, NULL, true, '45', now()),
    (gen_random_uuid(), v_res_id, 6, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 7, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 8, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 9, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 10, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 11, 8.0, NULL, false, '8', now());

  -- [Gold] Rank 76: Euan Hao Xuan Poh (SGP 2030)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Euan Hao Xuan Poh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Euan Hao Xuan Poh', 'euan-hao-xuan-poh-59e758', '2030', 'CWSS', '9-10yo PRI TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2030' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, '9-10yo PRI TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 76, 322.0, 231.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 2, 42.0, NULL, true, '42', now()),
    (gen_random_uuid(), v_res_id, 3, 49.0, NULL, true, '49', now()),
    (gen_random_uuid(), v_res_id, 4, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 5, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 6, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 7, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 8, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 9, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 10, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 11, 38.0, NULL, false, '38', now());

  -- [Gold] Rank 77: Jiratiwat Peungchurn (THA 1220)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jiratiwat Peungchurn')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jiratiwat Peungchurn', 'jiratiwat-peungchurn-a305a9', '1220', 'YRAT', NULL, 'M', 'THA', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '1220' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'YRAT'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'THA'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 77, 336.0, 232.0, false, 'M', 2012, 'THA', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 2, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 3, 50.0, NULL, true, '50', now()),
    (gen_random_uuid(), v_res_id, 4, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 5, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 6, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 7, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 8, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 9, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 10, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 11, 29.0, NULL, false, '29', now());

  -- [Gold] Rank 78: Boren Wang (SGP 2039)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Boren Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Boren Wang', 'boren-wang-7bc535', '2039', 'PA', '11-12yo PRI ALEXANDRA PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2039' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PA'),
      school = COALESCE(school, '11-12yo PRI ALEXANDRA PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 78, 329.0, 237.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 2, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 3, 44.0, NULL, true, '44', now()),
    (gen_random_uuid(), v_res_id, 4, 48.0, NULL, true, '48', now()),
    (gen_random_uuid(), v_res_id, 5, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 6, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 7, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 8, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 9, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 10, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 11, 44.0, NULL, false, '44', now());

  -- [Gold] Rank 79: Lucas Jun Sheng Seow (SGP 2047)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lucas Jun Sheng Seow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lucas Jun Sheng Seow', 'lucas-jun-sheng-seow-717877', '2047', 'CWSS', '11-12yo PRI TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2047' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, '11-12yo PRI TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 79, 336.0, 244.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 2, 46.0, NULL, true, '46', now()),
    (gen_random_uuid(), v_res_id, 3, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 4, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 5, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 6, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 7, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 8, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 9, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 10, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 11, 46.0, NULL, true, '46', now());

  -- [Gold] Rank 80: Tan Qi (SGP 3026)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tan Qi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tan Qi', 'tan-qi-fb14de', '3026', 'CWSS', '11-12yo PRI TAO NAN SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3026' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, '11-12yo PRI TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 80, 352.0, 244.0, false, 'F', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 2, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 3, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 4, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 5, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 6, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 7, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 8, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 9, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 10, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 11, 18.0, NULL, false, '18', now());

  -- [Gold] Rank 81: Hanyue Ouyang (SGP 5003)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hanyue Ouyang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hanyue Ouyang', 'hanyue-ouyang-cf51fd', '5003', '15', '10-11yo PRI NANYANG PRIMARY SCHOOL One', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '5003' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), '15'),
      school = COALESCE(school, '10-11yo PRI NANYANG PRIMARY SCHOOL One'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 81, 364.0, 264.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 2, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 3, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 4, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 5, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 6, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 7, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 8, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 9, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 10, 46.0, NULL, true, '46', now()),
    (gen_random_uuid(), v_res_id, 11, 54.0, NULL, true, '54', now());

  -- [Gold] Rank 82: Kyan Chun Hong Tan (SGP 4712)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kyan Chun Hong Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kyan Chun Hong Tan', 'kyan-chun-hong-tan-31b43c', '4712', 'SAFYC', '11-12yo PRI TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4712' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 82, 366.0, 267.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 2, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 3, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 4, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 5, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 6, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 7, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 8, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 9, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 10, 45.0, NULL, true, '45', now()),
    (gen_random_uuid(), v_res_id, 11, 12.0, NULL, false, '12', now());

  -- [Gold] Rank 83: Matthew Qin Hao Chiam (SGP 3606)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Matthew Qin Hao Chiam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Matthew Qin Hao Chiam', 'matthew-qin-hao-chiam-0a48aa', '3606', 'SAFYC', '11-12yo PRI AI TONG SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3606' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI AI TONG SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 83, 352.0, 267.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 42.0, NULL, true, '42', now()),
    (gen_random_uuid(), v_res_id, 2, 43.0, NULL, true, '43', now()),
    (gen_random_uuid(), v_res_id, 3, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 4, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 5, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 6, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 7, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 8, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 9, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 10, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 11, 16.0, NULL, false, '16', now());

  -- [Gold] Rank 84: Christopher Soh (SGP 3168)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Christopher Soh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Christopher Soh', 'christopher-soh-e9ded6', '3168', 'SAFYC', '11-12yo PRI TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3168' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 84, 367.0, 272.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 52.0, NULL, true, '52', now()),
    (gen_random_uuid(), v_res_id, 2, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 3, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 4, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 5, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 6, 43.0, NULL, true, '43', now()),
    (gen_random_uuid(), v_res_id, 7, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 8, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 9, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 10, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 11, 31.0, NULL, false, '31', now());

  -- [Gold] Rank 85: Sage Yeh (SGP 797)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sage Yeh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sage Yeh', 'sage-yeh-dfe2f3', '797', 'CSC', '11-12yo PRI PUNGGOL COVE PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '797' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CSC'),
      school = COALESCE(school, '11-12yo PRI PUNGGOL COVE PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 85, 364.0, 274.0, false, 'F', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 47.0, NULL, true, '47', now()),
    (gen_random_uuid(), v_res_id, 2, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 3, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 4, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 5, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 6, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 7, 43.0, NULL, true, '43', now()),
    (gen_random_uuid(), v_res_id, 8, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 9, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 10, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 11, 36.0, NULL, false, '36', now());

  -- [Gold] Rank 86: Vantava Raguraman (IND 1148)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Vantava Raguraman')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Vantava Raguraman', 'vantava-raguraman-919776', '1148', 'YAI', NULL, 'F', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '1148' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'YAI'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 86, 368.0, 280.0, false, 'F', 2013, 'IND', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 2, 46.0, NULL, true, '46', now()),
    (gen_random_uuid(), v_res_id, 3, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 4, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 5, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 6, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 7, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 8, 42.0, NULL, true, '42', now()),
    (gen_random_uuid(), v_res_id, 9, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 10, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 11, 35.0, NULL, false, '35', now());

  -- [Gold] Rank 87: Tyler Koo (SGP 996)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tyler Koo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tyler Koo', 'tyler-koo-9fe93d', '996', 'RSYC', '11-12yo PRI ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '996' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'RSYC'),
      school = COALESCE(school, '11-12yo PRI ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 87, 361.0, 281.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 40.0, NULL, true, '40', now()),
    (gen_random_uuid(), v_res_id, 2, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 3, 40.0, NULL, true, '40', now()),
    (gen_random_uuid(), v_res_id, 4, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 5, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 6, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 7, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 8, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 9, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 10, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 11, 37.0, NULL, false, '37', now());

  -- [Gold] Rank 88: Matthias Kai Lun Lee (SGP 3385)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Matthias Kai Lun Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Matthias Kai Lun Lee', 'matthias-kai-lun-lee-a1b968', '3385', 'SAFYC', '9-10yo', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3385' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '9-10yo'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 88, 384.0, 283.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 50.0, NULL, true, '50', now()),
    (gen_random_uuid(), v_res_id, 2, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 3, 51.0, NULL, true, '51', now()),
    (gen_random_uuid(), v_res_id, 4, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 5, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 6, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 7, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 8, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 9, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 10, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 11, 21.0, NULL, false, '21', now());

  -- [Gold] Rank 89: Chen-Yi Kai (SGP 757)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Chen-Yi Kai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Chen-Yi Kai', 'chen-yi-kai-84a183', '757', 'SAFYC', '9-10yo PRI FAIRFIELD METHODIST SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '757' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '9-10yo PRI FAIRFIELD METHODIST SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 89, 375.0, 283.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 2, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 3, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 4, 46.0, NULL, true, '46', now()),
    (gen_random_uuid(), v_res_id, 5, 46.0, NULL, true, '46', now()),
    (gen_random_uuid(), v_res_id, 6, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 7, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 8, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 9, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 10, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 11, 19.0, NULL, false, '19', now());

  -- [Gold] Rank 90: Siddhi Tandon (IND 1681)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Siddhi Tandon')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Siddhi Tandon', 'siddhi-tandon-8f1ccb', '1681', 'YAI', NULL, 'F', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '1681' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'YAI'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'IND'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 90, 380.0, 284.0, false, 'F', 2013, 'IND', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 2, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 3, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 4, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 5, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 6, 42.0, NULL, true, '42', now()),
    (gen_random_uuid(), v_res_id, 7, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 8, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 9, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 10, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 11, 30.0, NULL, false, '30', now());

  -- [Gold] Rank 91: Nigel Jiang Long Ng (SGP 3363)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nigel Jiang Long Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nigel Jiang Long Ng', 'nigel-jiang-long-ng-eb721a', '3363', 'SAFYC', '11-12yo PRI ENDEAVOUR PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3363' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI ENDEAVOUR PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 91, 380.0, 287.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 2, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 3, 48.0, NULL, true, '48', now()),
    (gen_random_uuid(), v_res_id, 4, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 5, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 6, 45.0, NULL, true, '45', now()),
    (gen_random_uuid(), v_res_id, 7, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 8, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 9, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 10, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 11, 33.0, NULL, false, '33', now());

  -- [Gold] Rank 92: Xavier Yang Zheng Puah (SGP 2037)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Xavier Yang Zheng Puah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Xavier Yang Zheng Puah', 'xavier-yang-zheng-puah-2fc9a2', '2037', 'CWSS', '11-12yo PRI ST. JOSEPH''S INSTITUTION JUNIOR', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2037' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, '11-12yo PRI ST. JOSEPH''S INSTITUTION JUNIOR'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 92, 393.0, 290.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 2, 51.0, NULL, true, '51', now()),
    (gen_random_uuid(), v_res_id, 3, 52.0, NULL, true, '52', now()),
    (gen_random_uuid(), v_res_id, 4, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 5, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 6, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 7, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 8, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 9, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 10, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 11, 34.0, NULL, false, '34', now());

  -- [Gold] Rank 93: Luke Tin Fong (SGP 2019)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Luke Tin Fong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Luke Tin Fong', 'luke-tin-fong-b7cdfb', '2019', 'CWSS', '11-12yo PRI TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2019' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, '11-12yo PRI TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 93, 396.0, 304.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 2, 44.0, NULL, true, '44', now()),
    (gen_random_uuid(), v_res_id, 3, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 4, 48.0, NULL, true, '48', now()),
    (gen_random_uuid(), v_res_id, 5, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 6, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 7, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 8, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 9, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 10, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 11, 41.0, NULL, false, '41', now());

  -- [Gold] Rank 94: Ethan Jing Zhou Tan (SGP 3772)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ethan Jing Zhou Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ethan Jing Zhou Tan', 'ethan-jing-zhou-tan-b87228', '3772', 'SAFYC', 'SEC VICTORIA SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3772' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'SEC VICTORIA SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 94, 426.0, 318.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 2, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 3, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 4, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 6, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 7, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 8, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 9, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 10, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 11, 14.0, NULL, false, '14', now());

  -- [Gold] Rank 95: Kenji Huan Zhe Tan (SGP 3999)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kenji Huan Zhe Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kenji Huan Zhe Tan', 'kenji-huan-zhe-tan-42be0d', '3999', 'SAFYC', 'SEC MAYFLOWER SECONDARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3999' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'SEC MAYFLOWER SECONDARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 95, 426.0, 318.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 2, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 3, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 4, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 6, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 7, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 8, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 9, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 10, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 11, 20.0, NULL, false, '20', now());

  -- [Gold] Rank 96: Aiden Kang Jun Wong (SGP 2018)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aiden Kang Jun Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aiden Kang Jun Wong', 'aiden-kang-jun-wong-2ea874', '2018', 'CWSS', 'SEC MARIS STELLA HIGH SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2018' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'SEC MARIS STELLA HIGH SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 96, 424.0, 321.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 2, 49.0, NULL, true, '49', now()),
    (gen_random_uuid(), v_res_id, 3, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 4, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 5, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 6, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 7, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 8, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 9, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 10, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 11, 27.0, NULL, false, '27', now());

  -- [Gold] Rank 97: Isabelle Xinyi Zhang (SGP 2035)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isabelle Xinyi Zhang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isabelle Xinyi Zhang', 'isabelle-xinyi-zhang-261286', '2035', 'CWSS', '9-10yo PRI METHODIST GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2035' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, '9-10yo PRI METHODIST GIRLS'' SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 97, 424.0, 321.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 2, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 3, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 4, 49.0, NULL, true, '49', now()),
    (gen_random_uuid(), v_res_id, 5, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 6, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 7, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 8, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 9, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 10, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 11, 24.0, NULL, false, '24', now());

  -- [Gold] Rank 98: Ashleigh Li Ying Teh (SGP 788)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ashleigh Li Ying Teh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ashleigh Li Ying Teh', 'ashleigh-li-ying-teh-514dd7', '788', 'SAFYC', '9-10yo PRI TAO NAN SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '788' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '9-10yo PRI TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 98, 427.0, 326.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 52.0, NULL, true, '52', now()),
    (gen_random_uuid(), v_res_id, 2, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 3, 49.0, NULL, true, '49', now()),
    (gen_random_uuid(), v_res_id, 4, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 5, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 6, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 7, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 8, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 9, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 10, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 11, 45.0, NULL, false, '45', now());

  -- [Gold] Rank 99: Estelle Rui En Yeo (SGP 773)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Estelle Rui En Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Estelle Rui En Yeo', 'estelle-rui-en-yeo-4b3c6c', '773', 'CSC', '11-12yo PRI ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '773' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CSC'),
      school = COALESCE(school, '11-12yo PRI ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 99, 431.0, 334.0, false, 'F', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 2, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 3, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 4, 50.0, NULL, true, '50', now()),
    (gen_random_uuid(), v_res_id, 5, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 6, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 7, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 8, 47.0, NULL, true, '47', now()),
    (gen_random_uuid(), v_res_id, 9, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 10, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 11, 43.0, NULL, false, '43', now());

  -- [Gold] Rank 100: Auwin Zhao Hong Leow (SGP 3405)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Auwin Zhao Hong Leow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Auwin Zhao Hong Leow', 'auwin-zhao-hong-leow-73792d', '3405', 'SAFYC', '11-12yo PRI ANGLO-CHINESE SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3405' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI ANGLO-CHINESE SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 100, 449.0, 346.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 49.0, NULL, true, '49', now()),
    (gen_random_uuid(), v_res_id, 2, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 3, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 4, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 5, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 6, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 7, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 8, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 9, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 10, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 11, 48.0, NULL, false, '48', now());

  -- [Gold] Rank 101: Gloria Yen Rui Kwok (SGP 2003)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gloria Yen Rui Kwok')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gloria Yen Rui Kwok', 'gloria-yen-rui-kwok-c8258b', '2003', 'CWSS', '11-12yo PRI CHIJ (KATONG) PRIMARY', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2003' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, '11-12yo PRI CHIJ (KATONG) PRIMARY'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 101, 465.0, 357.0, false, 'F', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 2, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 3, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 4, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 5, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 6, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 7, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 8, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 9, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 10, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 11, 40.0, NULL, false, '40', now());

  -- [Gold] Rank 102: Aidan See Hett Yeo (SGP 3112)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aidan See Hett Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aidan See Hett Yeo', 'aidan-see-hett-yeo-58713d', '3112', 'SCHOOLSAFYC', '11-12yo PRI KUO CHUAN PRESBYTERIAN PRIMARY', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3112' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SCHOOLSAFYC'),
      school = COALESCE(school, '11-12yo PRI KUO CHUAN PRESBYTERIAN PRIMARY'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 102, 467.0, 359.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 2, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 3, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 4, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 5, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 6, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 7, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 8, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 9, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 10, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 11, 47.0, NULL, false, '47', now());

  -- [Gold] Rank 103: Worawit Jutahkiti (SGP 2025)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Worawit Jutahkiti')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Worawit Jutahkiti', 'worawit-jutahkiti-3d0d11', '2025', 'CWSS', 'SEC CATHOLIC HIGH SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2025' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'SEC CATHOLIC HIGH SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 103, 523.0, 415.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 51.0, NULL, false, '51', now()),
    (gen_random_uuid(), v_res_id, 2, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 3, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 4, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 6, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 7, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 8, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 9, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 10, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 11, 39.0, NULL, false, '39', now());

  -- [Gold] Rank 104: William Poon (INA 21)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('William Poon')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'William Poon', 'william-poon-7bfe54', '21', 'SAFYC', '11-12yo PRI SINGAPORE AMERICAN SCHOOL', 'M', 'INA', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '21' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, '11-12yo PRI SINGAPORE AMERICAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'INA'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 104, 526.0, 418.0, false, 'M', 2015, 'INA', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 2, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 3, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 4, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 6, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 7, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 8, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 9, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 10, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 11, 54.0, NULL, false, '54', now());

  -- [Gold] Rank 105: Charlene Heng Ning Yong (SGP 766)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Charlene Heng Ning Yong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Charlene Heng Ning Yong', 'charlene-heng-ning-yong-9c7661', '766', 'CSC', '11-12yo PRI PASIR RIS PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '766' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CSC'),
      school = COALESCE(school, '11-12yo PRI PASIR RIS PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 105, 526.0, 418.0, false, 'F', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 2, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 3, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 4, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 6, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 7, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 8, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 9, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 10, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 11, 54.0, NULL, false, '54', now());

  -- [Gold] Rank 106: Hagen Goh (SGP 3600)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hagen Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hagen Goh', 'hagen-goh-bf94a3', '3600', 'SCHOOLSAFYC', '11-12yo PRI DOVER COURT INTERNATIONAL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3600' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SCHOOLSAFYC'),
      school = COALESCE(school, '11-12yo PRI DOVER COURT INTERNATIONAL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 106, 594.0, 486.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 2, 54.0, NULL, true, '54', now()),
    (gen_random_uuid(), v_res_id, 3, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 4, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 6, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 7, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 8, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 9, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 10, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 11, 54.0, 'DSQ', false, '54', now());

  -- ==========================================================================
  -- OPTIMIST SILVER FLEET (68 competitors)
  -- ==========================================================================
  -- [Silver] Rank 1: Yasin Yusuf Yusfianshah (SGP 3575)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yasin Yusuf Yusfianshah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yasin Yusuf Yusfianshah', 'yasin-yusuf-yusfianshah-4a7e5d', '3575', 'SAFYC', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3575' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 1, 51.0, 25.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 2, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 3, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 4, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 5, 11.0, NULL, true, '(11)', now()),
    (gen_random_uuid(), v_res_id, 6, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 7, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 8, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 9, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 10, 15.0, NULL, true, '(15)', now());

  -- [Silver] Rank 2: Su Yuan (CHN 3043)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Su Yuan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Su Yuan', 'su-yuan-4573e4', '3043', 'SAFYC', 'CHIJ (KATONG) PRIMARY', 'F', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3043' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'CHIJ (KATONG) PRIMARY'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 2, 76.0, 44.0, false, 'F', 2013, 'CHN', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 13.0, NULL, true, '(13)', now()),
    (gen_random_uuid(), v_res_id, 2, 19.0, NULL, true, '(19)', now()),
    (gen_random_uuid(), v_res_id, 3, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 4, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 5, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 6, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 7, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 8, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 9, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 10, 11.0, NULL, false, '11', now());

  -- [Silver] Rank 3: Shen Jie Teo (SGP 3870)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Shen Jie Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Shen Jie Teo', 'shen-jie-teo-cf1c78', '3870', 'SAFYC', 'RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3870' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'RAFFLES INSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 3, 129.0, 45.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 20.0, NULL, false, '(20)', now()),
    (gen_random_uuid(), v_res_id, 2, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 3, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 4, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 5, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 6, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 7, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 8, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 9, 64.0, 'BFD', true, '(BFD 64)', now()),
    (gen_random_uuid(), v_res_id, 10, 6.0, NULL, false, '6', now());

  -- [Silver] Rank 4: Cyra Cama (SGP 29)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cyra Cama')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cyra Cama', 'cyra-cama-185a43', '29', 'ONE°15', 'INTERNATIONAL FRENCH SCHOOL (SINGAPORE)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '29' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'ONE°15'),
      school = COALESCE(school, 'INTERNATIONAL FRENCH SCHOOL (SINGAPORE)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 4, 132.0, 51.0, false, 'F', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 65.0, 'UFD', true, '(UFD 65)', now()),
    (gen_random_uuid(), v_res_id, 2, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 3, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 4, 16.0, NULL, true, '(16)', now()),
    (gen_random_uuid(), v_res_id, 5, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 6, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 7, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 8, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 9, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 10, 3.0, NULL, false, '3', now());

  -- [Silver] Rank 5: Clara Siew Ning Ng (SGP 3739)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Clara Siew Ning Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Clara Siew Ning Ng', 'clara-siew-ning-ng-6b56b9', '3739', 'SAFYC', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3739' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 5, 139.0, 55.0, false, 'F', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 2, 20.0, NULL, false, '(20)', now()),
    (gen_random_uuid(), v_res_id, 3, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 4, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 5, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 6, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 7, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 8, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 9, 64.0, 'BFD', true, '(BFD 64)', now()),
    (gen_random_uuid(), v_res_id, 10, 4.0, NULL, false, '4', now());

  -- [Silver] Rank 6: Ivor Zhuo Xi Lee (SGP 3306)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ivor Zhuo Xi Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ivor Zhuo Xi Lee', 'ivor-zhuo-xi-lee-15c902', '3306', 'SAFYC', 'ENDEAVOUR PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3306' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ENDEAVOUR PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 6, 144.0, 58.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 2, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 3, 22.0, NULL, true, '(22)', now()),
    (gen_random_uuid(), v_res_id, 4, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 5, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 6, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 7, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 8, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 9, 64.0, 'BFD', true, '(BFD 64)', now()),
    (gen_random_uuid(), v_res_id, 10, 9.0, NULL, false, '9', now());

  -- [Silver] Rank 7: Evan En Kai Ong (SGP 3955)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Evan En Kai Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Evan En Kai Ong', 'evan-en-kai-ong-45d3a5', '3955', 'SAFYC', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3955' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 7, 153.0, 67.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 2, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 3, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 4, 22.0, NULL, true, '(22)', now()),
    (gen_random_uuid(), v_res_id, 5, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 6, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 7, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 8, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 9, 64.0, 'BFD', true, '(BFD 64)', now()),
    (gen_random_uuid(), v_res_id, 10, 17.0, NULL, false, '17', now());

  -- [Silver] Rank 8: Kai Jie Teo (SGP 3550)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kai Jie Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kai Jie Teo', 'kai-jie-teo-90c9a4', '3550', 'SAFYC', 'TANJONG KATONG PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3550' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'TANJONG KATONG PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 8, 151.0, 68.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 2, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 3, 19.0, NULL, true, '(19)', now()),
    (gen_random_uuid(), v_res_id, 4, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 5, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 6, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 7, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 8, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 9, 64.0, 'BFD', true, '(BFD 64)', now()),
    (gen_random_uuid(), v_res_id, 10, 1.0, NULL, false, '1', now());

  -- [Silver] Rank 9: Hayden Zi Xuan Soh (SGP 3838)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hayden Zi Xuan Soh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hayden Zi Xuan Soh', 'hayden-zi-xuan-soh-b2390b', '3838', 'SAFYC', 'WHITE SANDS PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3838' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'WHITE SANDS PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 9, 114.0, 73.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 2, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 3, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 4, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 5, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 6, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 7, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 8, 20.0, NULL, true, '(20)', now()),
    (gen_random_uuid(), v_res_id, 9, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 10, 21.0, NULL, true, '(21)', now());

  -- [Silver] Rank 10: Yan Cheng Loh (SGP 3717)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yan Cheng Loh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yan Cheng Loh', 'yan-cheng-loh-b8f619', '3717', 'SAFYC', 'NAN CHIAU PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3717' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'NAN CHIAU PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 10, 162.0, 79.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 2, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 3, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 4, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 5, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 6, 19.0, NULL, true, '(19)', now()),
    (gen_random_uuid(), v_res_id, 7, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 8, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 9, 64.0, 'BFD', true, '(BFD 64)', now()),
    (gen_random_uuid(), v_res_id, 10, 18.0, NULL, false, '18', now());

  -- [Silver] Rank 11: Chloe Ariane Pitsilis (FRA 708)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Chloe Ariane Pitsilis')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Chloe Ariane Pitsilis', 'chloe-ariane-pitsilis-8d491a', '708', 'CSC', 'INTERNATIONAL FRENCH SCHOOL (SINGAPORE)', 'F', 'FRA', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '708' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CSC'),
      school = COALESCE(school, 'INTERNATIONAL FRENCH SCHOOL (SINGAPORE)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'FRA'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 11, 143.0, 82.0, false, 'F', 2015, 'FRA', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 2, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 3, 24.0, NULL, true, '(24)', now()),
    (gen_random_uuid(), v_res_id, 4, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 5, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 6, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 7, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 8, 37.0, NULL, true, '(37)', now()),
    (gen_random_uuid(), v_res_id, 9, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 10, 2.0, NULL, false, '2', now());

  -- [Silver] Rank 12: Jade Tan (SGP 3555)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jade Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jade Tan', 'jade-tan-d4e0f7', '3555', 'SAFYC', 'AI TONG SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3555' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'AI TONG SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 12, 171.0, 83.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 2, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 3, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 4, 24.0, NULL, true, '(24)', now()),
    (gen_random_uuid(), v_res_id, 5, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 6, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 7, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 8, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 9, 64.0, 'BFD', true, '(BFD 64)', now()),
    (gen_random_uuid(), v_res_id, 10, 8.0, NULL, false, '8', now());

  -- [Silver] Rank 13: Skyler Kang (SGP 2041)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Skyler Kang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Skyler Kang', 'skyler-kang-524b74', '2041', 'CWSS', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2041' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 13, 142.0, 90.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 25.0, NULL, true, '(25)', now()),
    (gen_random_uuid(), v_res_id, 2, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 3, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 4, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 5, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 6, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 7, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 8, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 9, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 10, 27.0, NULL, true, '(27)', now());

  -- [Silver] Rank 14: Iver Zhe Xi Lee (SGP 3309)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Iver Zhe Xi Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Iver Zhe Xi Lee', 'iver-zhe-xi-lee-9d958d', '3309', 'SAFYC', 'ENDEAVOUR PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3309' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ENDEAVOUR PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 14, 197.0, 102.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 2, 65.0, 'BFD', true, '(BFD 65)', now()),
    (gen_random_uuid(), v_res_id, 3, 30.0, NULL, true, '(30)', now()),
    (gen_random_uuid(), v_res_id, 4, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 5, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 6, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 7, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 8, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 9, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 10, 5.0, NULL, false, '5', now());

  -- [Silver] Rank 15: Zachary Hoo (SGP 2051)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zachary Hoo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zachary Hoo', 'zachary-hoo-2b1747', '2051', 'CWSS', 'RED SWASTIKA SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2051' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'RED SWASTIKA SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 15, 156.0, 103.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 2, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 3, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 4, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 5, 29.0, NULL, true, '(29)', now()),
    (gen_random_uuid(), v_res_id, 6, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 7, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 8, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 9, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 10, 24.0, NULL, true, '(24)', now());

  -- [Silver] Rank 16: Yong Le Wai (SGP 3488)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yong Le Wai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yong Le Wai', 'yong-le-wai-20c5a4', '3488', 'SAFYC', 'FIRST TOA PAYOH PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3488' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'FIRST TOA PAYOH PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 16, 208.0, 104.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 2, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 3, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 4, 40.0, NULL, true, '(40)', now()),
    (gen_random_uuid(), v_res_id, 5, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 6, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 7, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 8, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 9, 64.0, 'BFD', true, '(BFD 64)', now()),
    (gen_random_uuid(), v_res_id, 10, 10.0, NULL, false, '10', now());

  -- [Silver] Rank 17: Jan Welzl (SGP 2033)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jan Welzl')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jan Welzl', 'jan-welzl-fe7790', '2033', 'CWSS', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2033' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 17, 173.0, 112.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 2, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 3, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 4, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 5, 28.0, NULL, true, '(28)', now()),
    (gen_random_uuid(), v_res_id, 6, 33.0, NULL, true, '(33)', now()),
    (gen_random_uuid(), v_res_id, 7, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 8, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 9, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 10, 16.0, NULL, false, '16', now());

  -- [Silver] Rank 18: Moyan Han (SGP 2042)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Moyan Han')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Moyan Han', 'moyan-han-fb4f57', '2042', 'CWSS', 'NAN HUA PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2042' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'NAN HUA PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 18, 245.0, 118.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 2, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 3, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 4, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 5, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 6, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 7, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 8, 63.0, 'RET', true, '(RET 63)', now()),
    (gen_random_uuid(), v_res_id, 9, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 10, 64.0, 'DSQ', true, '(DSQ 64)', now());

  -- [Silver] Rank 19: Isaac Tan (SGP 2055)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isaac Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isaac Tan', 'isaac-tan-a6cefe', '2055', 'CWSS', 'ANGLICAN HIGH SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2055' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'ANGLICAN HIGH SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 19, 210.0, 120.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 26.0, NULL, true, '(26)', now()),
    (gen_random_uuid(), v_res_id, 2, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 3, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 4, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 5, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 6, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 7, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 8, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 9, 64.0, 'BFD', true, '(BFD 64)', now()),
    (gen_random_uuid(), v_res_id, 10, 13.0, NULL, false, '13', now());

  -- [Silver] Rank 20: Cyrus Gustafson (USA 3342)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cyrus Gustafson')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cyrus Gustafson', 'cyrus-gustafson-22a75c', '3342', 'SAFYC', 'SINGAPORE AMERICAN SCHOOL', 'M', 'USA', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3342' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'SINGAPORE AMERICAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'USA'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 20, 183.0, 129.0, false, 'M', 2014, 'USA', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 2, 25.0, NULL, true, '(25)', now()),
    (gen_random_uuid(), v_res_id, 3, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 4, 29.0, NULL, true, '(29)', now()),
    (gen_random_uuid(), v_res_id, 5, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 6, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 7, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 8, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 9, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 10, 7.0, NULL, false, '7', now());

  -- [Silver] Rank 21: Seraphina Kang (SGP 2040)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Seraphina Kang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Seraphina Kang', 'seraphina-kang-ed7224', '2040', 'CWSS', 'CHIJ OUR LADY QUEEN OF PEACE', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2040' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'CHIJ OUR LADY QUEEN OF PEACE'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 21, 200.0, 137.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 2, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 3, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 4, 34.0, NULL, true, '(34)', now()),
    (gen_random_uuid(), v_res_id, 5, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 6, 29.0, NULL, true, '(29)', now()),
    (gen_random_uuid(), v_res_id, 7, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 8, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 9, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 10, 23.0, NULL, false, '23', now());

  -- [Silver] Rank 22: Ilysha Wong (SGP 2053)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ilysha Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ilysha Wong', 'ilysha-wong-d6f3af', '2053', 'CWSS', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2053' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 22, 226.0, 156.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 35.0, NULL, true, '(35)', now()),
    (gen_random_uuid(), v_res_id, 2, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 3, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 4, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 5, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 6, 35.0, NULL, true, '(35)', now()),
    (gen_random_uuid(), v_res_id, 7, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 8, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 9, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 10, 28.0, NULL, false, '28', now());

  -- [Silver] Rank 23: Damien Seah (SGP 3825)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Damien Seah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Damien Seah', 'damien-seah-d115ee', '3825', 'SAFYC', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3825' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 23, 254.0, 157.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 2, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 3, 59.0, 'TLE', true, '(TLE 59)', now()),
    (gen_random_uuid(), v_res_id, 4, 38.0, NULL, true, '(38)', now()),
    (gen_random_uuid(), v_res_id, 5, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 6, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 7, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 8, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 9, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 10, 20.0, NULL, false, '20', now());

  -- [Silver] Rank 24: Arun John Behl (USA 734)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Arun John Behl')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Arun John Behl', 'arun-john-behl-c655ce', '734', 'CSC', 'BUKIT MERAH SECONDARY SCHOOL', 'M', 'USA', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '734' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CSC'),
      school = COALESCE(school, 'BUKIT MERAH SECONDARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'USA'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 24, 227.0, 161.0, false, 'M', 2013, 'USA', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 2, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 3, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 4, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 5, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 6, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 7, 36.0, NULL, true, '(36)', now()),
    (gen_random_uuid(), v_res_id, 8, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 9, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 10, 30.0, NULL, true, '(30)', now());

  -- [Silver] Rank 25: Adele Ziyi Chiang (SGP 3120)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Adele Ziyi Chiang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Adele Ziyi Chiang', 'adele-ziyi-chiang-1fbfb0', '3120', 'SAFYC', 'TAO NAN SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3120' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 25, 223.0, 163.0, false, 'F', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 2, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 3, 29.0, NULL, true, '(29)', now()),
    (gen_random_uuid(), v_res_id, 4, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 5, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 6, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 7, 31.0, NULL, true, '(31)', now()),
    (gen_random_uuid(), v_res_id, 8, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 9, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 10, 25.0, NULL, false, '25', now());

  -- [Silver] Rank 26: Kiyansh Kanishk Singh (SGP 2046)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kiyansh Kanishk Singh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kiyansh Kanishk Singh', 'kiyansh-kanishk-singh-8b2494', '2046', 'CWSS', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2046' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 26, 266.0, 166.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 2, 65.0, 'BFD', true, '(BFD 65)', now()),
    (gen_random_uuid(), v_res_id, 3, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 4, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 5, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 6, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 7, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 8, 35.0, NULL, true, '(35)', now()),
    (gen_random_uuid(), v_res_id, 9, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 10, 22.0, NULL, false, '22', now());

  -- [Silver] Rank 27: Ezra Yi Yang Mak (SGP 3535)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ezra Yi Yang Mak')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ezra Yi Yang Mak', 'ezra-yi-yang-mak-4ada61', '3535', 'SAFYC', 'ST. ANDREW''S JUNIOR SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3535' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ST. ANDREW''S JUNIOR SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 27, 310.0, 198.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 2, 65.0, 'BFD', true, '(BFD 65)', now()),
    (gen_random_uuid(), v_res_id, 3, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 4, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 5, 47.0, NULL, true, '(47)', now()),
    (gen_random_uuid(), v_res_id, 6, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 7, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 8, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 9, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 10, 42.0, NULL, false, '42', now());

  -- [Silver] Rank 28: Yuki Youqi Wang (SGP 3523)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuki Youqi Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuki Youqi Wang', 'yuki-youqi-wang-3c46f9', '3523', 'SAFYC', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3523' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 28, 291.0, 206.0, false, 'F', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 2, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 3, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 4, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 5, 44.0, NULL, true, '(44)', now()),
    (gen_random_uuid(), v_res_id, 6, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 7, 41.0, NULL, true, '(41)', now()),
    (gen_random_uuid(), v_res_id, 8, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 9, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 10, 14.0, NULL, false, '14', now());

  -- [Silver] Rank 29: Ethan Mathew (SGP 3841)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ethan Mathew')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ethan Mathew', 'ethan-mathew-64c78a', '3841', 'SAFYC', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3841' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 29, 280.0, 208.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 2, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 3, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 4, 37.0, NULL, true, '(37)', now()),
    (gen_random_uuid(), v_res_id, 5, 35.0, NULL, true, '(35)', now()),
    (gen_random_uuid(), v_res_id, 6, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 7, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 8, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 9, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 10, 29.0, NULL, false, '29', now());

  -- [Silver] Rank 30: Yahe Wang (SGP 3020)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yahe Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yahe Wang', 'yahe-wang-d61fe9', '3020', 'SAFYC', 'PEI TONG PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3020' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'PEI TONG PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 30, 297.0, 212.0, false, 'F', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 2, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 3, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 4, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 5, 37.0, NULL, true, '(37)', now()),
    (gen_random_uuid(), v_res_id, 6, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 7, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 8, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 9, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 10, 48.0, NULL, true, '(48)', now());

  -- [Silver] Rank 31: Bryan Thian Tsek Lee (SGP 3508)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Bryan Thian Tsek Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Bryan Thian Tsek Lee', 'bryan-thian-tsek-lee-ef534b', '3508', 'SAFYC', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3508' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 31, 312.0, 215.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 38.0, NULL, true, '(38)', now()),
    (gen_random_uuid(), v_res_id, 2, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 3, 59.0, 'TLE', true, '(TLE 59)', now()),
    (gen_random_uuid(), v_res_id, 4, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 5, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 6, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 7, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 8, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 9, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 10, 34.0, NULL, false, '34', now());

  -- [Silver] Rank 32: Althea Chin (SGP 7188)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Althea Chin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Althea Chin', 'althea-chin-d52227', '7188', 'CSC', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '7188' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CSC'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 32, 305.0, 216.0, false, 'F', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 2, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 3, 50.0, NULL, true, '(50)', now()),
    (gen_random_uuid(), v_res_id, 4, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 5, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 6, 39.0, NULL, true, '(39)', now()),
    (gen_random_uuid(), v_res_id, 7, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 8, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 9, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 10, 37.0, NULL, false, '37', now());

  -- [Silver] Rank 33: Enzo Kengsin Teo (SGP 2044)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Enzo Kengsin Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Enzo Kengsin Teo', 'enzo-kengsin-teo-87cce7', '2044', 'CWSS', 'ST. STEPHEN''S SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2044' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'ST. STEPHEN''S SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 33, 303.0, 223.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 2, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 3, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 4, 39.0, NULL, true, '(39)', now()),
    (gen_random_uuid(), v_res_id, 5, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 6, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 7, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 8, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 9, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 10, 41.0, NULL, true, '(41)', now());

  -- [Silver] Rank 34: Asher Goh (SGP 722)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Asher Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Asher Goh', 'asher-goh-3c5037', '722', 'CSC', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '722' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CSC'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 34, 369.0, 249.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 56.0, NULL, true, '(56)', now()),
    (gen_random_uuid(), v_res_id, 2, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 3, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 4, 51.0, NULL, false, '51', now()),
    (gen_random_uuid(), v_res_id, 5, 64.0, 'UFD', true, '(UFD 64)', now()),
    (gen_random_uuid(), v_res_id, 6, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 7, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 8, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 9, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 10, 26.0, NULL, false, '26', now());

  -- [Silver] Rank 35: Jiayi Du (CHN 3141)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jiayi Du')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jiayi Du', 'jiayi-du-017134', '3141', 'SAFYC', 'ST. GABRIEL''S PRIMARY SCHOOL', 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3141' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ST. GABRIEL''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 35, 340.0, 252.0, false, 'M', 2016, 'CHN', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 2, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 3, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 4, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 5, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 6, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 7, 44.0, NULL, true, '(44)', now()),
    (gen_random_uuid(), v_res_id, 8, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 9, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 10, 44.0, NULL, true, '(44)', now());

  -- [Silver] Rank 36: Jae Guan Yu Toh (SGP 3311)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jae Guan Yu Toh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jae Guan Yu Toh', 'jae-guan-yu-toh-0c8d33', '3311', 'SAFYC', 'Maris Stella High School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3311' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'Maris Stella High School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 36, 362.0, 255.0, false, 'M', 2018, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 32.0, 'TLE', false, 'TLE 32', now()),
    (gen_random_uuid(), v_res_id, 2, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 3, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 4, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 5, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 6, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 7, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 8, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 9, 64.0, 'BFD', true, '(BFD 64)', now()),
    (gen_random_uuid(), v_res_id, 10, 43.0, NULL, true, '(43)', now());

  -- [Silver] Rank 37: Jerome Puah Yang Yi (SGP 2037)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jerome Puah Yang Yi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jerome Puah Yang Yi', 'jerome-puah-yang-yi-f942ec', '2037', 'PAssion Wave', 'ST. JOSEPH''S INSTITUTION JUNIOR', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2037' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'ST. JOSEPH''S INSTITUTION JUNIOR'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 37, 370.0, 256.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 51.0, NULL, true, '(51)', now()),
    (gen_random_uuid(), v_res_id, 2, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 3, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 4, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 5, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 6, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 7, 63.0, 'RET', true, '(RET 63)', now()),
    (gen_random_uuid(), v_res_id, 8, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 9, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 10, 33.0, NULL, false, '33', now());

  -- [Silver] Rank 38: Ryan Feiran Zheng (SGP 2045)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ryan Feiran Zheng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ryan Feiran Zheng', 'ryan-feiran-zheng-d9560a', '2045', 'CWSS', 'ST. STEPHEN''S SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2045' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'ST. STEPHEN''S SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 38, 397.0, 259.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 69.0, 'DNC', true, '(DNC 69)', now()),
    (gen_random_uuid(), v_res_id, 2, 69.0, 'DNC', true, '(DNC 69)', now()),
    (gen_random_uuid(), v_res_id, 3, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 4, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 5, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 6, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 7, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 8, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 9, 64.0, 'BFD', false, 'BFD 64', now()),
    (gen_random_uuid(), v_res_id, 10, 12.0, NULL, false, '12', now());

  -- [Silver] Rank 39: Muhammad Rehan Bin Mohamed Salim (SGP 2059)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Muhammad Rehan Bin Mohamed Salim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Muhammad Rehan Bin Mohamed Salim', 'muhammad-rehan-bin-mohamed-salim-398aad', '2059', 'CWSS', 'WHITE SANDS PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2059' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'WHITE SANDS PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 39, 379.0, 265.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 2, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 3, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 4, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 5, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 6, 50.0, NULL, true, '(50)', now()),
    (gen_random_uuid(), v_res_id, 7, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 8, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 9, 64.0, 'BFD', true, '(BFD 64)', now()),
    (gen_random_uuid(), v_res_id, 10, 19.0, NULL, false, '19', now());

  -- [Silver] Rank 40: Nadia Zahedi (SGP 4724)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nadia Zahedi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nadia Zahedi', 'nadia-zahedi-6da6c0', '4724', 'PAssion Wave', 'TAO NAN SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4724' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 40, 359.0, 267.0, false, 'F', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 44.0, NULL, true, '(44)', now()),
    (gen_random_uuid(), v_res_id, 2, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 3, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 4, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 5, 48.0, NULL, true, '(48)', now()),
    (gen_random_uuid(), v_res_id, 6, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 7, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 8, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 9, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 10, 36.0, NULL, false, '36', now());

  -- [Silver] Rank 41: Hillary Kai Hui Tan (SGP 777)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hillary Kai Hui Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hillary Kai Hui Tan', 'hillary-kai-hui-tan-988e9a', '777', 'SAFYC', 'KONG HWA SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '777' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'KONG HWA SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 41, 413.0, 308.0, false, 'F', 2018, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 58.0, NULL, true, '(58)', now()),
    (gen_random_uuid(), v_res_id, 2, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 3, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 4, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 5, 29.0, 'SCP', false, 'SCP 29', now()),
    (gen_random_uuid(), v_res_id, 6, 47.0, NULL, true, '(47)', now()),
    (gen_random_uuid(), v_res_id, 7, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 8, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 9, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 10, 47.0, NULL, false, '47', now());

  -- [Silver] Rank 42: Emil Lam (SGP 2049)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Emil Lam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Emil Lam', 'emil-lam-286a00', '2049', 'CWSS', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2049' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 42, 428.0, 312.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 2, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 3, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 4, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 5, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 6, 52.0, NULL, true, '(52)', now()),
    (gen_random_uuid(), v_res_id, 7, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 8, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 9, 64.0, 'BFD', true, '(BFD 64)', now()),
    (gen_random_uuid(), v_res_id, 10, 52.0, NULL, false, '52', now());

  -- [Silver] Rank 43: Ian Siak Yiak Goh (SGP 3818)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ian Siak Yiak Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ian Siak Yiak Goh', 'ian-siak-yiak-goh-d63fdf', '3818', 'SAFYC', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3818' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 43, 420.0, 315.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 2, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 3, 46.0, 'SCP', false, 'SCP 46', now()),
    (gen_random_uuid(), v_res_id, 4, 50.0, NULL, true, '(50)', now()),
    (gen_random_uuid(), v_res_id, 5, 55.0, NULL, true, '(55)', now()),
    (gen_random_uuid(), v_res_id, 6, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 7, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 8, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 9, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 10, 35.0, NULL, false, '35', now());

  -- [Silver] Rank 44: Dylan Yao Rui Teo (SGP 3107)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Dylan Yao Rui Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Dylan Yao Rui Teo', 'dylan-yao-rui-teo-60e189', '3107', 'SAFYC', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3107' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 44, 448.0, 336.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 2, 53.0, NULL, true, '(53)', now()),
    (gen_random_uuid(), v_res_id, 3, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 4, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 5, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 6, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 7, 59.0, NULL, true, '(59)', now()),
    (gen_random_uuid(), v_res_id, 8, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 9, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 10, 32.0, NULL, false, '32', now());

  -- [Silver] Rank 45: Hongren Wang (SGP 2039)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hongren Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hongren Wang', 'hongren-wang-587b2d', '2039', 'PAssion Wave', 'ALEXANDRA PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2039' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'ALEXANDRA PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 45, 458.0, 342.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 2, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 3, 52.0, NULL, false, '52', now()),
    (gen_random_uuid(), v_res_id, 4, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 5, 59.0, 'TLE', true, '(TLE 59)', now()),
    (gen_random_uuid(), v_res_id, 6, 55.0, NULL, false, '55', now()),
    (gen_random_uuid(), v_res_id, 7, 57.0, NULL, true, '(57)', now()),
    (gen_random_uuid(), v_res_id, 8, 51.0, NULL, false, '51', now()),
    (gen_random_uuid(), v_res_id, 9, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 10, 39.0, NULL, false, '39', now());

  -- [Silver] Rank 46: Yu an Li (SGP 2056)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yu an Li')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yu an Li', 'yu-an-li-617cfe', '2056', 'CWSS', 'TAO NAN SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2056' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 46, 467.0, 343.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 2, 65.0, 'RET', true, '(RET 65)', now()),
    (gen_random_uuid(), v_res_id, 3, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 4, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 5, 59.0, 'TLE', true, '(TLE 59)', now()),
    (gen_random_uuid(), v_res_id, 6, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 7, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 8, 52.0, NULL, false, '52', now()),
    (gen_random_uuid(), v_res_id, 9, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 10, 38.0, NULL, false, '38', now());

  -- [Silver] Rank 47: Andrea Kwan (SGP 3745)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Andrea Kwan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Andrea Kwan', 'andrea-kwan-e40c2d', '3745', 'SAFYC', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3745' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 47, 459.0, 349.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 2, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 3, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 4, 47.0, 'SCP', false, 'SCP 47', now()),
    (gen_random_uuid(), v_res_id, 5, 53.0, NULL, true, '(53)', now()),
    (gen_random_uuid(), v_res_id, 6, 57.0, NULL, true, '(57)', now()),
    (gen_random_uuid(), v_res_id, 7, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 8, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 9, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 10, 53.0, NULL, false, '53', now());

  -- [Silver] Rank 48: Cadee Jia Xing See (SGP 3628)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cadee Jia Xing See')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cadee Jia Xing See', 'cadee-jia-xing-see-00fae1', '3628', 'SAFYC', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3628' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 48, 469.0, 353.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 60.0, NULL, true, '(60)', now()),
    (gen_random_uuid(), v_res_id, 2, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 3, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 4, 53.0, NULL, false, '53', now()),
    (gen_random_uuid(), v_res_id, 5, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 6, 56.0, NULL, true, '(56)', now()),
    (gen_random_uuid(), v_res_id, 7, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 8, 56.0, NULL, false, '56', now()),
    (gen_random_uuid(), v_res_id, 9, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 10, 49.0, NULL, false, '49', now());

  -- [Silver] Rank 49: Sven Xin Chen Lim (SGP 4424)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sven Xin Chen Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sven Xin Chen Lim', 'sven-xin-chen-lim-9671b5', '4424', 'SAFYC', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4424' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 49, 466.0, 358.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 2, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 3, 50.0, 'SCP', false, 'SCP 50', now()),
    (gen_random_uuid(), v_res_id, 4, 52.0, NULL, true, '(52)', now()),
    (gen_random_uuid(), v_res_id, 5, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 6, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 7, 56.0, NULL, true, '(56)', now()),
    (gen_random_uuid(), v_res_id, 8, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 9, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 10, 46.0, NULL, false, '46', now());

  -- [Silver] Rank 50: Oliver Rui Heng Cheong (SGP 3515)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Oliver Rui Heng Cheong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Oliver Rui Heng Cheong', 'oliver-rui-heng-cheong-53b1bd', '3515', 'SAFYC', 'ST. STEPHEN''S SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3515' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ST. STEPHEN''S SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 50, 478.0, 363.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 2, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 3, 56.0, NULL, true, '(56)', now()),
    (gen_random_uuid(), v_res_id, 4, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 5, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 6, 59.0, NULL, true, '(59)', now()),
    (gen_random_uuid(), v_res_id, 7, 53.0, NULL, false, '53', now()),
    (gen_random_uuid(), v_res_id, 8, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 9, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 10, 50.0, NULL, false, '50', now());

  -- [Silver] Rank 51: Mikayla Zi Yue Wong (SGP 8)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mikayla Zi Yue Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mikayla Zi Yue Wong', 'mikayla-zi-yue-wong-64563b', '8', 'CSC', 'CHIJ (KATONG) PRIMARY', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '8' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CSC'),
      school = COALESCE(school, 'CHIJ (KATONG) PRIMARY'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 51, 494.0, 366.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 2, 57.0, 'TLE', false, 'TLE 57', now()),
    (gen_random_uuid(), v_res_id, 3, 55.0, NULL, false, '55', now()),
    (gen_random_uuid(), v_res_id, 4, 63.0, 'TLE', false, 'TLE 63', now()),
    (gen_random_uuid(), v_res_id, 5, 64.0, 'UFD', true, '(UFD 64)', now()),
    (gen_random_uuid(), v_res_id, 6, 47.0, 'SCP', false, 'SCP 47', now()),
    (gen_random_uuid(), v_res_id, 7, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 8, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 9, 64.0, 'RET', true, '(RET 64)', now()),
    (gen_random_uuid(), v_res_id, 10, 31.0, NULL, false, '31', now());

  -- [Silver] Rank 52: Joshua Hon (MAS 1)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joshua Hon')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joshua Hon', 'joshua-hon-a9b480', '1', 'SYC', 'VICTORIA SCHOOL', 'M', 'MAS', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '1' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SYC'),
      school = COALESCE(school, 'VICTORIA SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'MAS'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 52, 490.0, 367.0, false, 'M', 2012, 'MAS', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 2, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 3, 54.0, 'SCP', false, 'SCP 54', now()),
    (gen_random_uuid(), v_res_id, 4, 62.0, 'TLE', true, '(TLE 62)', now()),
    (gen_random_uuid(), v_res_id, 5, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 6, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 7, 55.0, NULL, false, '55', now()),
    (gen_random_uuid(), v_res_id, 8, 61.0, 'TLE', true, '(TLE 61)', now()),
    (gen_random_uuid(), v_res_id, 9, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 10, 51.0, NULL, false, '51', now());

  -- [Silver] Rank 53: Mitchell Shi Kai Lim (SGP 3323)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mitchell Shi Kai Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mitchell Shi Kai Lim', 'mitchell-shi-kai-lim-e0ca0f', '3323', 'SAFYC', 'ANGLO-CHINESE SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3323' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 53, 493.0, 378.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 2, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 3, 59.0, 'TLE', true, '(TLE 59)', now()),
    (gen_random_uuid(), v_res_id, 4, 56.0, NULL, true, '(56)', now()),
    (gen_random_uuid(), v_res_id, 5, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 6, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 7, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 8, 53.0, NULL, false, '53', now()),
    (gen_random_uuid(), v_res_id, 9, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 10, 54.0, NULL, false, '54', now());

  -- [Silver] Rank 54: Yixia Sun (SGP 2061)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yixia Sun')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yixia Sun', 'yixia-sun-c04e54', '2061', 'CWSS', 'FENGSHAN PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2061' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'FENGSHAN PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 54, 515.0, 391.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 65.0, 'UFD', true, '(UFD 65)', now()),
    (gen_random_uuid(), v_res_id, 2, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 3, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 4, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 5, 59.0, 'TLE', true, '(TLE 59)', now()),
    (gen_random_uuid(), v_res_id, 6, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 7, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 8, 57.0, NULL, false, '57', now()),
    (gen_random_uuid(), v_res_id, 9, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 10, 56.0, NULL, false, '56', now());

  -- [Silver] Rank 55: Elouan Gay (SGP 793)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elouan Gay')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elouan Gay', 'elouan-gay-66ae26', '793', 'CSC', 'INTERNATIONAL FRENCH SCHOOL (SINGAPORE)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '793' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CSC'),
      school = COALESCE(school, 'INTERNATIONAL FRENCH SCHOOL (SINGAPORE)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 55, 542.0, 404.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 2, 51.0, NULL, false, '51', now()),
    (gen_random_uuid(), v_res_id, 3, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 4, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 5, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 6, 69.0, 'DNC', true, '(DNC 69)', now()),
    (gen_random_uuid(), v_res_id, 7, 69.0, 'DNC', true, '(DNC 69)', now()),
    (gen_random_uuid(), v_res_id, 8, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 9, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 10, 69.0, 'DNC', false, 'DNC 69', now());

  -- [Silver] Rank 56: Efrem Mak (SGP 3222)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Efrem Mak')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Efrem Mak', 'efrem-mak-8cd8f8', '3222', 'SAFYC', 'ST. ANDREW''S JUNIOR SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3222' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ST. ANDREW''S JUNIOR SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 56, 520.0, 406.0, false, 'M', 2018, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 2, 55.0, NULL, true, '(55)', now()),
    (gen_random_uuid(), v_res_id, 3, 50.0, 'TLE', false, 'TLE 50', now()),
    (gen_random_uuid(), v_res_id, 4, 59.0, NULL, true, '(59)', now()),
    (gen_random_uuid(), v_res_id, 5, 52.0, NULL, false, '52', now()),
    (gen_random_uuid(), v_res_id, 6, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 7, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 8, 55.0, NULL, false, '55', now()),
    (gen_random_uuid(), v_res_id, 9, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 10, 55.0, NULL, false, '55', now());

  -- [Silver] Rank 57: Thaddaeus Renz (SGP 2058)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Thaddaeus Renz')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Thaddaeus Renz', 'thaddaeus-renz-6abed1', '2058', 'CWSS', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2058' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 57, 523.0, 407.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 53.0, NULL, false, '53', now()),
    (gen_random_uuid(), v_res_id, 2, 57.0, 'TLE', true, '(TLE 57)', now()),
    (gen_random_uuid(), v_res_id, 3, 59.0, 'TLE', true, '(TLE 59)', now()),
    (gen_random_uuid(), v_res_id, 4, 57.0, NULL, false, '57', now()),
    (gen_random_uuid(), v_res_id, 5, 51.0, NULL, false, '51', now()),
    (gen_random_uuid(), v_res_id, 6, 51.0, NULL, false, '51', now()),
    (gen_random_uuid(), v_res_id, 7, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 8, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 9, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 10, 45.0, NULL, false, '45', now());

  -- [Silver] Rank 58: Isaias Cheow (SGP 3307)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isaias Cheow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isaias Cheow', 'isaias-cheow-67a387', '3307', 'SAFYC', 'ANGLO-CHINESE SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3307' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 58, 526.0, 408.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 57.0, NULL, false, '57', now()),
    (gen_random_uuid(), v_res_id, 2, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 3, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 4, 58.0, NULL, false, '58', now()),
    (gen_random_uuid(), v_res_id, 5, 59.0, 'TLE', true, '(TLE 59)', now()),
    (gen_random_uuid(), v_res_id, 6, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 7, 58.0, NULL, false, '58', now()),
    (gen_random_uuid(), v_res_id, 8, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 9, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 10, 59.0, NULL, true, '(59)', now());

  -- [Silver] Rank 59: Amelie Camille Pitsilis (FRA 702)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Amelie Camille Pitsilis')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Amelie Camille Pitsilis', 'amelie-camille-pitsilis-ae5372', '702', 'CSC', 'INTEGRATED INTERNATIONAL SCHOOL', 'F', 'FRA', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '702' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CSC'),
      school = COALESCE(school, 'INTEGRATED INTERNATIONAL SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'FRA'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 59, 536.0, 412.0, false, 'F', 2017, 'FRA', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 52.0, NULL, false, '52', now()),
    (gen_random_uuid(), v_res_id, 2, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 3, 57.0, NULL, false, '57', now()),
    (gen_random_uuid(), v_res_id, 4, 55.0, NULL, false, '55', now()),
    (gen_random_uuid(), v_res_id, 5, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 6, 60.0, NULL, true, '(60)', now()),
    (gen_random_uuid(), v_res_id, 7, 51.0, NULL, false, '51', now()),
    (gen_random_uuid(), v_res_id, 8, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 9, 64.0, 'BFD', true, '(BFD 64)', now()),
    (gen_random_uuid(), v_res_id, 10, 60.0, NULL, false, '60', now());

  -- [Silver] Rank 60: Christopher Tan (SGP 2057)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Christopher Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Christopher Tan', 'christopher-tan-3869de', '2057', 'CWSS', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2057' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 60, 537.0, 418.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 55.0, NULL, false, '55', now()),
    (gen_random_uuid(), v_res_id, 2, 52.0, NULL, false, '52', now()),
    (gen_random_uuid(), v_res_id, 3, 53.0, NULL, false, '53', now()),
    (gen_random_uuid(), v_res_id, 4, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 6, 58.0, NULL, true, '(58)', now()),
    (gen_random_uuid(), v_res_id, 7, 61.0, NULL, true, '(61)', now()),
    (gen_random_uuid(), v_res_id, 8, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 9, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 10, 58.0, NULL, false, '58', now());

  -- [Silver] Rank 61: Neel Paul Behl (USA 4494)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Neel Paul Behl')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Neel Paul Behl', 'neel-paul-behl-8fb320', '4494', 'CSC', 'ZHANGDE PRIMARY SCHOOL', 'M', 'USA', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4494' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CSC'),
      school = COALESCE(school, 'ZHANGDE PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'USA'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 61, 562.0, 424.0, false, 'M', 2016, 'USA', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 2, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 3, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 4, 69.0, 'DNC', true, '(DNC 69)', now()),
    (gen_random_uuid(), v_res_id, 5, 69.0, 'DNC', true, '(DNC 69)', now()),
    (gen_random_uuid(), v_res_id, 6, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 7, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 8, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 9, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 10, 40.0, NULL, false, '40', now());

  -- [Silver] Rank 62: An Hu (CHN 2050)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('An Hu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'An Hu', 'an-hu-82658a', '2050', 'CWSS', 'SINGAPORE AMERICAN SCHOOL', 'F', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2050' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CWSS'),
      school = COALESCE(school, 'SINGAPORE AMERICAN SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 62, 563.0, 425.0, false, 'F', 2016, 'CHN', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 2, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 3, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 4, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 5, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 6, 69.0, 'DNC', true, '(DNC 69)', now()),
    (gen_random_uuid(), v_res_id, 7, 69.0, 'DNC', true, '(DNC 69)', now()),
    (gen_random_uuid(), v_res_id, 8, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 9, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 10, 69.0, 'DNC', false, 'DNC 69', now());

  -- [Silver] Rank 63: Ryan Jonathan Zhi Jie Soh (SGP 3110)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ryan Jonathan Zhi Jie Soh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ryan Jonathan Zhi Jie Soh', 'ryan-jonathan-zhi-jie-soh-5579e8', '3110', 'SAFYC', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3110' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 63, 583.0, 445.0, false, 'M', 2018, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 65.0, 'RET', false, 'RET 65', now()),
    (gen_random_uuid(), v_res_id, 2, 57.0, 'TLE', false, 'TLE 57', now()),
    (gen_random_uuid(), v_res_id, 3, 59.0, 'TLE', false, 'TLE 59', now()),
    (gen_random_uuid(), v_res_id, 4, 69.0, 'DNC', true, '(DNC 69)', now()),
    (gen_random_uuid(), v_res_id, 5, 69.0, 'DNC', true, '(DNC 69)', now()),
    (gen_random_uuid(), v_res_id, 6, 53.0, NULL, false, '53', now()),
    (gen_random_uuid(), v_res_id, 7, 52.0, NULL, false, '52', now()),
    (gen_random_uuid(), v_res_id, 8, 58.0, NULL, false, '58', now()),
    (gen_random_uuid(), v_res_id, 9, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 10, 57.0, NULL, false, '57', now());

  -- [Silver] Rank 64: Jonathan Zi Kang Tan (SGP 2)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jonathan Zi Kang Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jonathan Zi Kang Tan', 'jonathan-zi-kang-tan-a95341', '2', 'PAssion Wave', 'QUEENSTOWN PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'QUEENSTOWN PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 64, 584.0, 451.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 64.0, 'SCP', true, '(SCP 64)', now()),
    (gen_random_uuid(), v_res_id, 2, 57.0, 'TLE', false, 'TLE 57', now()),
    (gen_random_uuid(), v_res_id, 3, 69.0, 'DNC', true, '(DNC 69)', now()),
    (gen_random_uuid(), v_res_id, 4, 63.0, NULL, false, '63', now()),
    (gen_random_uuid(), v_res_id, 5, 56.0, NULL, false, '56', now()),
    (gen_random_uuid(), v_res_id, 6, 62.0, NULL, false, '62', now()),
    (gen_random_uuid(), v_res_id, 7, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 8, 63.0, 'NSC', false, 'NSC 63', now()),
    (gen_random_uuid(), v_res_id, 9, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 10, 62.0, NULL, false, '62', now());

  -- [Silver] Rank 65: Isaac Qin Ran Chiam (SGP 3699)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isaac Qin Ran Chiam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isaac Qin Ran Chiam', 'isaac-qin-ran-chiam-785c46', '3699', 'SAFYC', 'AI TONG SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3699' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'AI TONG SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 65, 605.0, 477.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 59.0, NULL, false, '59', now()),
    (gen_random_uuid(), v_res_id, 2, 57.0, 'TLE', false, 'TLE 57', now()),
    (gen_random_uuid(), v_res_id, 3, 64.0, 'UFD', true, '(UFD 64)', now()),
    (gen_random_uuid(), v_res_id, 4, 60.0, NULL, false, '60', now()),
    (gen_random_uuid(), v_res_id, 5, 57.0, NULL, false, '57', now()),
    (gen_random_uuid(), v_res_id, 6, 61.0, NULL, false, '61', now()),
    (gen_random_uuid(), v_res_id, 7, 60.0, NULL, false, '60', now()),
    (gen_random_uuid(), v_res_id, 8, 59.0, NULL, false, '59', now()),
    (gen_random_uuid(), v_res_id, 9, 64.0, 'BFD', true, '(BFD 64)', now()),
    (gen_random_uuid(), v_res_id, 10, 64.0, 'SCP', false, 'SCP 64', now());

  -- [Silver] Rank 66: Jiaqian Wu (SGP 3424)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jiaqian Wu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jiaqian Wu', 'jiaqian-wu-5ea43a', '3424', 'SAFYC', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3424' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAFYC'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 66, 690.0, 552.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 69.0, 'DNC', true, '(DNC 69)', now()),
    (gen_random_uuid(), v_res_id, 2, 69.0, 'DNC', true, '(DNC 69)', now()),
    (gen_random_uuid(), v_res_id, 3, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 4, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 5, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 6, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 7, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 8, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 9, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 10, 69.0, 'DNC', false, 'DNC 69', now());

  -- [Silver] Rank 66: You Yu Tan (CHN 3137)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('You Yu Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'You Yu Tan', 'you-yu-tan-c23c5e', '3137', 'PAssion Wave', 'MERIDIAN PRIMARY SCHOOL', 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3137' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'MERIDIAN PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 66, 690.0, 552.0, false, 'M', 2014, 'CHN', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 69.0, 'DNC', true, '(DNC 69)', now()),
    (gen_random_uuid(), v_res_id, 2, 69.0, 'DNC', true, '(DNC 69)', now()),
    (gen_random_uuid(), v_res_id, 3, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 4, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 5, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 6, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 7, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 8, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 9, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 10, 69.0, 'DNC', false, 'DNC 69', now());

  -- [Silver] Rank 66: Hayley Kai En Tan (SGP 700)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hayley Kai En Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hayley Kai En Tan', 'hayley-kai-en-tan-9ae485', '700', 'CSC', 'KONG HWA SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '700' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'CSC'),
      school = COALESCE(school, 'KONG HWA SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 66, 690.0, 552.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 69.0, 'DNC', true, '(DNC 69)', now()),
    (gen_random_uuid(), v_res_id, 2, 69.0, 'DNC', true, '(DNC 69)', now()),
    (gen_random_uuid(), v_res_id, 3, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 4, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 5, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 6, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 7, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 8, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 9, 69.0, 'DNC', false, 'DNC 69', now()),
    (gen_random_uuid(), v_res_id, 10, 69.0, 'DNC', false, 'DNC 69', now());

END $$;