-- 075_add_temasek_2026_optimist_results.sql
-- Import official race-by-race results for Temasek Regatta 2026 (Optimist Gold & Silver)
-- Dates: 20–21 June 2026
-- Venue: National Sailing Centre, 1500 East Coast Parkway, Singapore 468963
-- Organiser: Singapore Sailing Federation
-- Source: Official Sailwave scoring sheets (77 Gold entries, 6 races; 61 Silver entries, 5 races)

DO $$
DECLARE
  v_event_id uuid;
  v_gold_id uuid;
  v_silver_id uuid;
  v_sailor_id uuid;
  v_res_id uuid;
BEGIN
  -- 1. Ensure weekend event exists in public.regatta_events
  SELECT id INTO v_event_id FROM public.regatta_events WHERE slug = 'temasek-regatta-2026' LIMIT 1;
  IF v_event_id IS NULL THEN
    v_event_id := gen_random_uuid();
    INSERT INTO public.regatta_events (
      id, name, slug, start_date, end_date, venue, organizer, classes, nor_url, registration_url, counts_for_ranking, is_selection_trial, created_at, updated_at
    ) VALUES (
      v_event_id, 'Temasek Regatta 2026', 'temasek-regatta-2026', '2026-06-20', '2026-06-21',
      'National Sailing Centre, Singapore', 'Singapore Sailing Federation',
      '["Optimist (Gold)", "Optimist (Silver)", "ILCA 6", "ILCA 7"]'::jsonb,
      'https://www.racingrulesofsailing.org/documents/13596/event', 'https://www.sailing.org.sg/events/335514',
      true, false, now(), now()
    );
  END IF;

  -- Link ILCA 6 and ILCA 7 to the weekend event
  UPDATE public.regattas SET event_id = v_event_id WHERE slug IN ('temasek-2026-ilca-6', 'temasek-2026-ilca-7');

  -- 2. Ensure Optimist Gold regatta exists
  SELECT id INTO v_gold_id FROM public.regattas WHERE slug = '202606-temasek-gold-2026-06-20' OR slug = 'temasek-regatta-2026-gold' LIMIT 1;
  IF v_gold_id IS NOT NULL THEN
    UPDATE public.regattas SET
      event_id = v_event_id,
      name = 'Temasek Regatta 2026 (Optimist Gold)',
      slug = '202606-temasek-gold-2026-06-20',
      date = '2026-06-20',
      end_date = '2026-06-21',
      boat_class = 'Optimist',
      division = 'Gold',
      total_fleet_size = 77,
      race_count = 6,
      geography = 'SG',
      counts_for_ranking = true,
      is_selection_trial = false,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/13596/event',
      registration_url = 'https://www.sailing.org.sg/events/335514',
      schedule_notes = 'Temasek Regatta 2026 Optimist Gold fleet: 77 entries, 6 races sailed (R1-R6, 1 discard). Final results official as of 24 June 2026.',
      status = 'published',
      updated_at = now()
    WHERE id = v_gold_id;
  ELSE
    v_gold_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, is_selection_trial, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_gold_id, v_event_id, 'Temasek Regatta 2026 (Optimist Gold)', '202606-temasek-gold-2026-06-20', '2026-06-20', '2026-06-21',
      'Optimist', 'Gold', 77, 6, 'SG', true, false, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation',
      'https://www.racingrulesofsailing.org/documents/13596/event', 'https://www.sailing.org.sg/events/335514',
      'Temasek Regatta 2026 Optimist Gold fleet: 77 entries, 6 races sailed (R1-R6, 1 discard). Final results official as of 24 June 2026.', 'published', now(), now()
    );
  END IF;

  -- 3. Ensure Optimist Silver regatta exists
  SELECT id INTO v_silver_id FROM public.regattas WHERE slug = 'temasek-silver-jun-26-2026-06-20' OR slug = 'temasek-regatta-2026-silver' LIMIT 1;
  IF v_silver_id IS NOT NULL THEN
    UPDATE public.regattas SET
      event_id = v_event_id,
      name = 'Temasek Regatta 2026 (Optimist Silver)',
      slug = 'temasek-silver-jun-26-2026-06-20',
      date = '2026-06-20',
      end_date = '2026-06-21',
      boat_class = 'Optimist',
      division = 'Silver',
      total_fleet_size = 61,
      race_count = 5,
      geography = 'SG',
      counts_for_ranking = true,
      is_selection_trial = false,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/13596/event',
      registration_url = 'https://www.sailing.org.sg/events/335514',
      schedule_notes = 'Temasek Regatta 2026 Optimist Silver fleet: 61 entries, 5 races sailed (R1-R5, 1 discard). Final results official as of 30 June 2026.',
      status = 'published',
      updated_at = now()
    WHERE id = v_silver_id;
  ELSE
    v_silver_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, is_selection_trial, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_silver_id, v_event_id, 'Temasek Regatta 2026 (Optimist Silver)', 'temasek-silver-jun-26-2026-06-20', '2026-06-20', '2026-06-21',
      'Optimist', 'Silver', 61, 5, 'SG', true, false, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation',
      'https://www.racingrulesofsailing.org/documents/13596/event', 'https://www.sailing.org.sg/events/335514',
      'Temasek Regatta 2026 Optimist Silver fleet: 61 entries, 5 races sailed (R1-R5, 1 discard). Final results official as of 30 June 2026.', 'published', now(), now()
    );
  END IF;

  -- Clean prior results for Gold & Silver
  DELETE FROM public.regatta_results WHERE regatta_id = v_gold_id;
  DELETE FROM public.regatta_results WHERE regatta_id = v_silver_id;

  -- ==========================================================================
  -- OPTIMIST GOLD FLEET (77 competitors)
  -- ==========================================================================

  -- [Gold] Rank 1: Elliot Goh (SGP 3103)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elliot Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elliot Goh', 'elliot-goh-c08f54', '3103', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL (INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3103' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (INDEPENDENT)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 1, 35.0, 15.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 20.0, NULL, true, '(20.0)', now()),
    (gen_random_uuid(), v_res_id, 2, 4.0, NULL, false, '4.0', now()),
    (gen_random_uuid(), v_res_id, 3, 2.0, NULL, false, '2.0', now()),
    (gen_random_uuid(), v_res_id, 4, 1.0, NULL, false, '1.0', now()),
    (gen_random_uuid(), v_res_id, 5, 2.0, NULL, false, '2.0', now()),
    (gen_random_uuid(), v_res_id, 6, 6.0, NULL, false, '6.0', now());

  -- [Gold] Rank 2: Jairus Xin Jie Teo (SGP 4073)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jairus Xin Jie Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jairus Xin Jie Teo', 'jairus-xin-jie-teo-b34134', '4073', 'SAF Yacht Club', 'ST. ANDREW''S SECONDARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4073' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. ANDREW''S SECONDARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 2, 30.0, 19.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 11.0, NULL, true, '(11.0)', now()),
    (gen_random_uuid(), v_res_id, 2, 6.0, NULL, false, '6.0', now()),
    (gen_random_uuid(), v_res_id, 3, 4.0, NULL, false, '4.0', now()),
    (gen_random_uuid(), v_res_id, 4, 5.0, NULL, false, '5.0', now()),
    (gen_random_uuid(), v_res_id, 5, 1.0, NULL, false, '1.0', now()),
    (gen_random_uuid(), v_res_id, 6, 3.0, NULL, false, '3.0', now());

  -- [Gold] Rank 3: Ethan Zhi Ren Low (SGP 78)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ethan Zhi Ren Low')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ethan Zhi Ren Low', 'ethan-zhi-ren-low-7045d7', '78', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '78' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 3, 32.0, 22.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 10.0, NULL, true, '(10.0)', now()),
    (gen_random_uuid(), v_res_id, 2, 2.0, NULL, false, '2.0', now()),
    (gen_random_uuid(), v_res_id, 3, 8.0, NULL, false, '8.0', now()),
    (gen_random_uuid(), v_res_id, 4, 4.0, NULL, false, '4.0', now()),
    (gen_random_uuid(), v_res_id, 5, 4.0, NULL, false, '4.0', now()),
    (gen_random_uuid(), v_res_id, 6, 4.0, NULL, false, '4.0', now());

  -- [Gold] Rank 4: Edrei En Xu Ong (SGP 3957)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Edrei En Xu Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Edrei En Xu Ong', 'edrei-en-xu-ong-254b73', '3957', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3957' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 4, 68.0, 41.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 27.0, NULL, true, '(27.0)', now()),
    (gen_random_uuid(), v_res_id, 2, 7.0, NULL, false, '7.0', now()),
    (gen_random_uuid(), v_res_id, 3, 5.0, NULL, false, '5.0', now()),
    (gen_random_uuid(), v_res_id, 4, 10.0, NULL, false, '10.0', now()),
    (gen_random_uuid(), v_res_id, 5, 10.0, NULL, false, '10.0', now()),
    (gen_random_uuid(), v_res_id, 6, 9.0, NULL, false, '9.0', now());

  -- [Gold] Rank 5: Elijah Ong (SGP 140)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elijah Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elijah Ong', 'elijah-ong-237c06', '140', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL (INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '140' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (INDEPENDENT)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 5, 117.0, 44.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 3.0, NULL, false, '3.0', now()),
    (gen_random_uuid(), v_res_id, 2, 14.0, NULL, false, '14.0', now()),
    (gen_random_uuid(), v_res_id, 3, 1.0, NULL, false, '1.0', now()),
    (gen_random_uuid(), v_res_id, 4, 2.0, NULL, false, '2.0', now()),
    (gen_random_uuid(), v_res_id, 5, 24.0, NULL, false, '24.0', now()),
    (gen_random_uuid(), v_res_id, 6, 73.0, 'BFD', true, '(73.0 BFD)', now());

  -- [Gold] Rank 6: Nathaniel Kaiden Ng (SGP 3344)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nathaniel Kaiden Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nathaniel Kaiden Ng', 'nathaniel-kaiden-ng-1db883', '3344', 'PAssion Wave', 'ANGLO-CHINESE SCHOOL (INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3344' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (INDEPENDENT)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 6, 69.0, 46.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 1.0, NULL, false, '1.0', now()),
    (gen_random_uuid(), v_res_id, 2, 5.0, NULL, false, '5.0', now()),
    (gen_random_uuid(), v_res_id, 3, 23.0, NULL, true, '(23.0)', now()),
    (gen_random_uuid(), v_res_id, 4, 20.0, NULL, false, '20.0', now()),
    (gen_random_uuid(), v_res_id, 5, 5.0, NULL, false, '5.0', now()),
    (gen_random_uuid(), v_res_id, 6, 15.0, NULL, false, '15.0', now());

  -- [Gold] Rank 7: Anya Alessia Zahedi (SGP 159)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Anya Alessia Zahedi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Anya Alessia Zahedi', 'anya-alessia-zahedi-36d18a', '159', 'PAssion Wave', 'RAFFLES GIRLS'' SCHOOL (SECONDARY)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '159' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'RAFFLES GIRLS'' SCHOOL (SECONDARY)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 7, 99.0, 46.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 15.0, NULL, false, '15.0', now()),
    (gen_random_uuid(), v_res_id, 2, 10.0, NULL, false, '10.0', now()),
    (gen_random_uuid(), v_res_id, 3, 53.0, NULL, true, '(53.0)', now()),
    (gen_random_uuid(), v_res_id, 4, 3.0, NULL, false, '3.0', now()),
    (gen_random_uuid(), v_res_id, 5, 16.0, NULL, false, '16.0', now()),
    (gen_random_uuid(), v_res_id, 6, 2.0, NULL, false, '2.0', now());

  -- [Gold] Rank 8: Damien Huang (SGP 3300)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Damien Huang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Damien Huang', 'damien-huang-3aa9d0', '3300', 'PAssion Wave', 'RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3300' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'RAFFLES INSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 8, 87.0, 55.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 5.0, NULL, false, '5.0', now()),
    (gen_random_uuid(), v_res_id, 2, 27.0, NULL, false, '27.0', now()),
    (gen_random_uuid(), v_res_id, 3, 12.0, NULL, false, '12.0', now()),
    (gen_random_uuid(), v_res_id, 4, 32.0, NULL, true, '(32.0)', now()),
    (gen_random_uuid(), v_res_id, 5, 3.0, NULL, false, '3.0', now()),
    (gen_random_uuid(), v_res_id, 6, 8.0, NULL, false, '8.0', now());

  -- [Gold] Rank 9: Alyssa Li Lin Wong (SGP 150)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Alyssa Li Lin Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Alyssa Li Lin Wong', 'alyssa-li-lin-wong-c063db', '150', 'SAF Yacht Club', 'RAFFLES GIRLS'' SCHOOL (SECONDARY)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '150' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'RAFFLES GIRLS'' SCHOOL (SECONDARY)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 9, 129.0, 56.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 17.0, NULL, false, '17.0', now()),
    (gen_random_uuid(), v_res_id, 2, 3.0, NULL, false, '3.0', now()),
    (gen_random_uuid(), v_res_id, 3, 73.0, 'RET', true, '(73.0 RET)', now()),
    (gen_random_uuid(), v_res_id, 4, 8.0, NULL, false, '8.0', now()),
    (gen_random_uuid(), v_res_id, 5, 18.0, NULL, false, '18.0', now()),
    (gen_random_uuid(), v_res_id, 6, 10.0, NULL, false, '10.0', now());

  -- [Gold] Rank 10: Nicole Jing Chen Wong (SGP 3006)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nicole Jing Chen Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nicole Jing Chen Wong', 'nicole-jing-chen-wong-1aab5c', '3006', 'SAF Yacht Club', 'CHIJ ST. THERESA''S CONVENT', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3006' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'CHIJ ST. THERESA''S CONVENT'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 10, 96.0, 66.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 30.0, NULL, true, '(30.0)', now()),
    (gen_random_uuid(), v_res_id, 2, 9.0, NULL, false, '9.0', now()),
    (gen_random_uuid(), v_res_id, 3, 6.0, NULL, false, '6.0', now()),
    (gen_random_uuid(), v_res_id, 4, 25.0, NULL, false, '25.0', now()),
    (gen_random_uuid(), v_res_id, 5, 19.0, NULL, false, '19.0', now()),
    (gen_random_uuid(), v_res_id, 6, 7.0, NULL, false, '7.0', now());

  -- [Gold] Rank 11: Siti Ra'idah Binte Mohd Airudin (SGP 1141)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Siti Ra''idah Binte Mohd Airudin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Siti Ra''idah Binte Mohd Airudin', 'siti-ra-idah-binte-mohd-airudin-75f025', '1141', 'PAssion Wave', 'ORCHID PARK SECONDARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '1141' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'ORCHID PARK SECONDARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 11, 92.0, 66.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 8.0, NULL, false, '8.0', now()),
    (gen_random_uuid(), v_res_id, 2, 13.0, NULL, false, '13.0', now()),
    (gen_random_uuid(), v_res_id, 3, 10.0, NULL, false, '10.0', now()),
    (gen_random_uuid(), v_res_id, 4, 21.0, NULL, false, '21.0', now()),
    (gen_random_uuid(), v_res_id, 5, 26.0, NULL, true, '(26.0)', now()),
    (gen_random_uuid(), v_res_id, 6, 14.0, NULL, false, '14.0', now());

  -- [Gold] Rank 12: Kyle Jeremy Zhi Jun Soh (SGP 3183)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kyle Jeremy Zhi Jun Soh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kyle Jeremy Zhi Jun Soh', 'kyle-jeremy-zhi-jun-soh-9c88dd', '3183', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3183' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 12, 114.0, 67.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 21.0, NULL, false, '21.0', now()),
    (gen_random_uuid(), v_res_id, 2, 11.0, NULL, false, '11.0', now()),
    (gen_random_uuid(), v_res_id, 3, 47.0, NULL, true, '(47.0)', now()),
    (gen_random_uuid(), v_res_id, 4, 6.0, NULL, false, '6.0', now()),
    (gen_random_uuid(), v_res_id, 5, 28.0, NULL, false, '28.0', now()),
    (gen_random_uuid(), v_res_id, 6, 1.0, NULL, false, '1.0', now());

  -- [Gold] Rank 13: Rahul Rajakanth (SGP 2006)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rahul Rajakanth')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rahul Rajakanth', 'rahul-rajakanth-2d35d5', '2006', 'Constant Wind', 'ANGLO-CHINESE SCHOOL (INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2006' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (INDEPENDENT)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 13, 115.0, 69.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 9.0, NULL, false, '9.0', now()),
    (gen_random_uuid(), v_res_id, 2, 18.0, NULL, false, '18.0', now()),
    (gen_random_uuid(), v_res_id, 3, 3.0, NULL, false, '3.0', now()),
    (gen_random_uuid(), v_res_id, 4, 12.0, NULL, false, '12.0', now()),
    (gen_random_uuid(), v_res_id, 5, 46.0, NULL, true, '(46.0)', now()),
    (gen_random_uuid(), v_res_id, 6, 27.0, NULL, false, '27.0', now());

  -- [Gold] Rank 14: Darian Huang (SGP 3700)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Darian Huang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Darian Huang', 'darian-huang-9904a9', '3700', 'PAssion Wave', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3700' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 14, 98.0, 72.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 26.0, NULL, true, '(26.0)', now()),
    (gen_random_uuid(), v_res_id, 2, 1.0, NULL, false, '1.0', now()),
    (gen_random_uuid(), v_res_id, 3, 9.0, NULL, false, '9.0', now()),
    (gen_random_uuid(), v_res_id, 4, 17.0, NULL, false, '17.0', now()),
    (gen_random_uuid(), v_res_id, 5, 25.0, NULL, false, '25.0', now()),
    (gen_random_uuid(), v_res_id, 6, 20.0, NULL, false, '20.0', now());

  -- [Gold] Rank 15: Jedd Zhi Hao Lam (SGP 2000)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jedd Zhi Hao Lam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jedd Zhi Hao Lam', 'jedd-zhi-hao-lam-60d557', '2000', 'Constant Wind', 'RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2000' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'RAFFLES INSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 15, 117.0, 73.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 4.0, NULL, false, '4.0', now()),
    (gen_random_uuid(), v_res_id, 2, 8.0, NULL, false, '8.0', now()),
    (gen_random_uuid(), v_res_id, 3, 44.0, NULL, true, '(44.0)', now()),
    (gen_random_uuid(), v_res_id, 4, 27.0, NULL, false, '27.0', now()),
    (gen_random_uuid(), v_res_id, 5, 22.0, NULL, false, '22.0', now()),
    (gen_random_uuid(), v_res_id, 6, 12.0, NULL, false, '12.0', now());

  -- [Gold] Rank 16: Padmaeja Rajakanth (SGP 2022)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Padmaeja Rajakanth')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Padmaeja Rajakanth', 'padmaeja-rajakanth-4d5566', '2022', 'Constant Wind', 'RAFFLES GIRLS'' PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2022' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'RAFFLES GIRLS'' PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 16, 130.0, 75.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 14.0, NULL, false, '14.0', now()),
    (gen_random_uuid(), v_res_id, 2, 21.0, NULL, false, '21.0', now()),
    (gen_random_uuid(), v_res_id, 3, 55.0, NULL, true, '(55.0)', now()),
    (gen_random_uuid(), v_res_id, 4, 28.0, NULL, false, '28.0', now()),
    (gen_random_uuid(), v_res_id, 5, 7.0, NULL, false, '7.0', now()),
    (gen_random_uuid(), v_res_id, 6, 5.0, NULL, false, '5.0', now());

  -- [Gold] Rank 17: Shin Chen Rui Lin (SGP 3333)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Shin Chen Rui Lin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Shin Chen Rui Lin', 'shin-chen-rui-lin-8c1dc9', '3333', 'SAF Yacht Club', 'MANJUSRI SECONDARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3333' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'MANJUSRI SECONDARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 17, 120.0, 77.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 12.0, NULL, false, '12.0', now()),
    (gen_random_uuid(), v_res_id, 2, 29.0, NULL, false, '29.0', now()),
    (gen_random_uuid(), v_res_id, 3, 15.0, NULL, false, '15.0', now()),
    (gen_random_uuid(), v_res_id, 4, 15.0, NULL, false, '15.0', now()),
    (gen_random_uuid(), v_res_id, 5, 6.0, NULL, false, '6.0', now()),
    (gen_random_uuid(), v_res_id, 6, 43.0, NULL, true, '(43.0)', now());

  -- [Gold] Rank 18: Kirsten En Ting Tan (SGP 3663)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kirsten En Ting Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kirsten En Ting Tan', 'kirsten-en-ting-tan-b47571', '3663', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3663' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 18, 117.0, 85.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 24.0, NULL, false, '24.0', now()),
    (gen_random_uuid(), v_res_id, 2, 12.0, NULL, false, '12.0', now()),
    (gen_random_uuid(), v_res_id, 3, 32.0, NULL, true, '(32.0)', now()),
    (gen_random_uuid(), v_res_id, 4, 24.0, NULL, false, '24.0', now()),
    (gen_random_uuid(), v_res_id, 5, 8.0, NULL, false, '8.0', now()),
    (gen_random_uuid(), v_res_id, 6, 17.0, NULL, false, '17.0', now());

  -- [Gold] Rank 19: Timothy Kai Zhe Ng (SGP 2023)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Timothy Kai Zhe Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Timothy Kai Zhe Ng', 'timothy-kai-zhe-ng-894679', '2023', 'Constant Wind', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2023' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 19, 151.0, 91.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 35.0, NULL, false, '35.0', now()),
    (gen_random_uuid(), v_res_id, 2, 60.0, NULL, true, '(60.0)', now()),
    (gen_random_uuid(), v_res_id, 3, 14.0, NULL, false, '14.0', now()),
    (gen_random_uuid(), v_res_id, 4, 13.0, NULL, false, '13.0', now()),
    (gen_random_uuid(), v_res_id, 5, 11.0, NULL, false, '11.0', now()),
    (gen_random_uuid(), v_res_id, 6, 18.0, NULL, false, '18.0', now());

  -- [Gold] Rank 20: Rui Ling Teo (SGP 3820)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rui Ling Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rui Ling Teo', 'rui-ling-teo-64f76f', '3820', 'SAF Yacht Club', 'CHIJ (KATONG) PRIMARY', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3820' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'CHIJ (KATONG) PRIMARY'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 20, 138.0, 93.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 7.0, NULL, false, '7.0', now()),
    (gen_random_uuid(), v_res_id, 2, 26.0, NULL, false, '26.0', now()),
    (gen_random_uuid(), v_res_id, 3, 13.0, NULL, false, '13.0', now()),
    (gen_random_uuid(), v_res_id, 4, 22.0, NULL, false, '22.0', now()),
    (gen_random_uuid(), v_res_id, 5, 45.0, NULL, true, '(45.0)', now()),
    (gen_random_uuid(), v_res_id, 6, 25.0, NULL, false, '25.0', now());

  -- [Gold] Rank 21: Luke Yi Jie Loh (SGP 3322)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Luke Yi Jie Loh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Luke Yi Jie Loh', 'luke-yi-jie-loh-c243ab', '3322', 'SAF Yacht Club', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3322' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 21, 128.0, 95.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 28.0, NULL, false, '28.0', now()),
    (gen_random_uuid(), v_res_id, 2, 33.0, NULL, true, '(33.0)', now()),
    (gen_random_uuid(), v_res_id, 3, 7.0, NULL, false, '7.0', now()),
    (gen_random_uuid(), v_res_id, 4, 23.0, NULL, false, '23.0', now()),
    (gen_random_uuid(), v_res_id, 5, 14.0, NULL, false, '14.0', now()),
    (gen_random_uuid(), v_res_id, 6, 23.0, NULL, false, '23.0', now());

  -- [Gold] Rank 22: Herng Yee Tan (SGP 3000)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Herng Yee Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Herng Yee Tan', 'herng-yee-tan-08d0f6', '3000', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL (INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3000' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (INDEPENDENT)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 22, 134.0, 98.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 22.0, NULL, false, '22.0', now()),
    (gen_random_uuid(), v_res_id, 2, 28.0, NULL, false, '28.0', now()),
    (gen_random_uuid(), v_res_id, 3, 11.0, NULL, false, '11.0', now()),
    (gen_random_uuid(), v_res_id, 4, 18.0, NULL, false, '18.0', now()),
    (gen_random_uuid(), v_res_id, 5, 36.0, NULL, true, '(36.0)', now()),
    (gen_random_uuid(), v_res_id, 6, 19.0, NULL, false, '19.0', now());

  -- [Gold] Rank 23: Olivia Ting Jia Cheong (SGP 3002)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Olivia Ting Jia Cheong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Olivia Ting Jia Cheong', 'olivia-ting-jia-cheong-6eddaf', '3002', 'SAF Yacht Club', 'RAFFLES GIRLS'' SCHOOL (SECONDARY)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3002' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'RAFFLES GIRLS'' SCHOOL (SECONDARY)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 23, 128.2, 99.2, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 23.0, NULL, false, '23.0', now()),
    (gen_random_uuid(), v_res_id, 2, 25.2, 'RDG', false, '25.2 RDG', now()),
    (gen_random_uuid(), v_res_id, 3, 28.0, NULL, false, '28.0', now()),
    (gen_random_uuid(), v_res_id, 4, 14.0, NULL, false, '14.0', now()),
    (gen_random_uuid(), v_res_id, 5, 9.0, NULL, false, '9.0', now()),
    (gen_random_uuid(), v_res_id, 6, 29.0, NULL, true, '(29.0)', now());

  -- [Gold] Rank 24: Joseph Kia Guan Tan (SGP 3688)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joseph Kia Guan Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joseph Kia Guan Tan', 'joseph-kia-guan-tan-e070d6', '3688', 'SAF Yacht Club', 'ST. JOSEPH''S INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3688' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. JOSEPH''S INSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 24, 138.0, 100.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 16.0, NULL, false, '16.0', now()),
    (gen_random_uuid(), v_res_id, 2, 16.0, NULL, false, '16.0', now()),
    (gen_random_uuid(), v_res_id, 3, 36.0, NULL, false, '36.0', now()),
    (gen_random_uuid(), v_res_id, 4, 19.0, NULL, false, '19.0', now()),
    (gen_random_uuid(), v_res_id, 5, 13.0, NULL, false, '13.0', now()),
    (gen_random_uuid(), v_res_id, 6, 38.0, NULL, true, '(38.0)', now());

  -- [Gold] Rank 25: Katelynn Kai En Lee (SGP 3383)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Katelynn Kai En Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Katelynn Kai En Lee', 'katelynn-kai-en-lee-d21524', '3383', 'SAF Yacht Club', 'ST. ANTHONY''S CANOSSIAN PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3383' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. ANTHONY''S CANOSSIAN PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 25, 142.0, 104.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 29.0, NULL, false, '29.0', now()),
    (gen_random_uuid(), v_res_id, 2, 19.0, NULL, false, '19.0', now()),
    (gen_random_uuid(), v_res_id, 3, 26.0, NULL, false, '26.0', now()),
    (gen_random_uuid(), v_res_id, 4, 9.0, NULL, false, '9.0', now()),
    (gen_random_uuid(), v_res_id, 5, 38.0, NULL, true, '(38.0)', now()),
    (gen_random_uuid(), v_res_id, 6, 21.0, NULL, false, '21.0', now());

  -- [Gold] Rank 26: Dylan Yue Teng Goh (SGP 3800)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Dylan Yue Teng Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Dylan Yue Teng Goh', 'dylan-yue-teng-goh-3fc1a5', '3800', 'SAF Yacht Club', 'VICTORIA SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3800' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'VICTORIA SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 26, 176.0, 112.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 64.0, NULL, true, '(64.0)', now()),
    (gen_random_uuid(), v_res_id, 2, 42.0, NULL, false, '42.0', now()),
    (gen_random_uuid(), v_res_id, 3, 16.0, NULL, false, '16.0', now()),
    (gen_random_uuid(), v_res_id, 4, 7.0, NULL, false, '7.0', now()),
    (gen_random_uuid(), v_res_id, 5, 15.0, NULL, false, '15.0', now()),
    (gen_random_uuid(), v_res_id, 6, 32.0, NULL, false, '32.0', now());

  -- [Gold] Rank 27: Kaelyn Dayna Zhi Yi Soh (SGP 3113)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kaelyn Dayna Zhi Yi Soh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kaelyn Dayna Zhi Yi Soh', 'kaelyn-dayna-zhi-yi-soh-e313e9', '3113', 'SAF Yacht Club', 'RAFFLES GIRLS'' SCHOOL (SECONDARY)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3113' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'RAFFLES GIRLS'' SCHOOL (SECONDARY)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 27, 156.0, 112.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 33.0, NULL, false, '33.0', now()),
    (gen_random_uuid(), v_res_id, 2, 15.0, NULL, false, '15.0', now()),
    (gen_random_uuid(), v_res_id, 3, 37.0, NULL, false, '37.0', now()),
    (gen_random_uuid(), v_res_id, 4, 16.0, NULL, false, '16.0', now()),
    (gen_random_uuid(), v_res_id, 5, 44.0, NULL, true, '(44.0)', now()),
    (gen_random_uuid(), v_res_id, 6, 11.0, NULL, false, '11.0', now());

  -- [Gold] Rank 28: Tan Qi (SGP 3026)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tan Qi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tan Qi', 'tan-qi-fb14de', '3026', 'Constant Wind', 'TAO NAN SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3026' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 28, 186.0, 136.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 50.0, NULL, true, '(50.0)', now()),
    (gen_random_uuid(), v_res_id, 2, 24.0, NULL, false, '24.0', now()),
    (gen_random_uuid(), v_res_id, 3, 20.0, NULL, false, '20.0', now()),
    (gen_random_uuid(), v_res_id, 4, 29.0, NULL, false, '29.0', now()),
    (gen_random_uuid(), v_res_id, 5, 50.0, NULL, false, '50.0', now()),
    (gen_random_uuid(), v_res_id, 6, 13.0, NULL, false, '13.0', now());

  -- [Gold] Rank 29: Hayley Kai En Tan (SGP 700)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hayley Kai En Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hayley Kai En Tan', 'hayley-kai-en-tan-9ae485', '700', 'Changi Sailing Club', 'KONG HWA SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '700' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'KONG HWA SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 29, 191.5, 136.5, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 2.0, NULL, false, '2.0', now()),
    (gen_random_uuid(), v_res_id, 2, 20.5, 'RDG', false, '20.5 RDG', now()),
    (gen_random_uuid(), v_res_id, 3, 39.0, NULL, false, '39.0', now()),
    (gen_random_uuid(), v_res_id, 4, 35.0, NULL, false, '35.0', now()),
    (gen_random_uuid(), v_res_id, 5, 40.0, NULL, false, '40.0', now()),
    (gen_random_uuid(), v_res_id, 6, 55.0, NULL, true, '(55.0)', now());

  -- [Gold] Rank 30: Lavene Rui Xuan Lim (SGP 3553)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lavene Rui Xuan Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lavene Rui Xuan Lim', 'lavene-rui-xuan-lim-08847a', '3553', 'SAF Yacht Club', 'PASIR RIS PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3553' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'PASIR RIS PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 30, 211.0, 138.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 73.0, 'DSQ', true, '(73.0 DSQ)', now()),
    (gen_random_uuid(), v_res_id, 2, 17.0, NULL, false, '17.0', now()),
    (gen_random_uuid(), v_res_id, 3, 42.0, NULL, false, '42.0', now()),
    (gen_random_uuid(), v_res_id, 4, 11.0, NULL, false, '11.0', now()),
    (gen_random_uuid(), v_res_id, 5, 31.0, NULL, false, '31.0', now()),
    (gen_random_uuid(), v_res_id, 6, 37.0, NULL, false, '37.0', now());

  -- [Gold] Rank 31: Jaye Xi En Low (SGP 3279)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jaye Xi En Low')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jaye Xi En Low', 'jaye-xi-en-low-b72a6b', '3279', 'PAssion Wave', 'DUNMAN HIGH SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3279' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'DUNMAN HIGH SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 31, 198.0, 138.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 60.0, NULL, true, '(60.0)', now()),
    (gen_random_uuid(), v_res_id, 2, 20.0, NULL, false, '20.0', now()),
    (gen_random_uuid(), v_res_id, 3, 24.0, NULL, false, '24.0', now()),
    (gen_random_uuid(), v_res_id, 4, 31.0, NULL, false, '31.0', now()),
    (gen_random_uuid(), v_res_id, 5, 37.0, NULL, false, '37.0', now()),
    (gen_random_uuid(), v_res_id, 6, 26.0, NULL, false, '26.0', now());

  -- [Gold] Rank 32: Dan Guan You Toh (SGP 3811)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Dan Guan You Toh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Dan Guan You Toh', 'dan-guan-you-toh-c4ac6b', '3811', 'SAF Yacht Club', 'MARIS STELLA HIGH SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3811' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'MARIS STELLA HIGH SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 32, 192.0, 140.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 37.0, NULL, false, '37.0', now()),
    (gen_random_uuid(), v_res_id, 2, 49.0, NULL, false, '49.0', now()),
    (gen_random_uuid(), v_res_id, 3, 18.0, NULL, false, '18.0', now()),
    (gen_random_uuid(), v_res_id, 4, 52.0, NULL, true, '(52.0)', now()),
    (gen_random_uuid(), v_res_id, 5, 12.0, NULL, false, '12.0', now()),
    (gen_random_uuid(), v_res_id, 6, 24.0, NULL, false, '24.0', now());

  -- [Gold] Rank 33: Aidan Armand Anuar (SGP 3143)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aidan Armand Anuar')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aidan Armand Anuar', 'aidan-armand-anuar-a6820f', '3143', 'SAF Yacht Club', 'TANJONG KATONG PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3143' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'TANJONG KATONG PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 33, 195.0, 142.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 6.0, NULL, false, '6.0', now()),
    (gen_random_uuid(), v_res_id, 2, 30.0, NULL, false, '30.0', now()),
    (gen_random_uuid(), v_res_id, 3, 38.0, NULL, false, '38.0', now()),
    (gen_random_uuid(), v_res_id, 4, 53.0, NULL, true, '(53.0)', now()),
    (gen_random_uuid(), v_res_id, 5, 34.0, NULL, false, '34.0', now()),
    (gen_random_uuid(), v_res_id, 6, 34.0, NULL, false, '34.0', now());

  -- [Gold] Rank 34: Mikaela Hui Ting Wong (SGP 3029)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mikaela Hui Ting Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mikaela Hui Ting Wong', 'mikaela-hui-ting-wong-abbcba', '3029', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3029' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 34, 193.0, 143.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 18.0, NULL, false, '18.0', now()),
    (gen_random_uuid(), v_res_id, 2, 40.0, NULL, false, '40.0', now()),
    (gen_random_uuid(), v_res_id, 3, 29.0, NULL, false, '29.0', now()),
    (gen_random_uuid(), v_res_id, 4, 39.0, NULL, false, '39.0', now()),
    (gen_random_uuid(), v_res_id, 5, 17.0, NULL, false, '17.0', now()),
    (gen_random_uuid(), v_res_id, 6, 50.0, NULL, true, '(50.0)', now());

  -- [Gold] Rank 35: Jeremiah Rui Feng Ong (SGP 3373)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jeremiah Rui Feng Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jeremiah Rui Feng Ong', 'jeremiah-rui-feng-ong-535938', '3373', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3373' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 35, 197.0, 150.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 25.0, NULL, false, '25.0', now()),
    (gen_random_uuid(), v_res_id, 2, 41.0, NULL, false, '41.0', now()),
    (gen_random_uuid(), v_res_id, 3, 33.0, NULL, false, '33.0', now()),
    (gen_random_uuid(), v_res_id, 4, 47.0, NULL, true, '(47.0)', now()),
    (gen_random_uuid(), v_res_id, 5, 21.0, NULL, false, '21.0', now()),
    (gen_random_uuid(), v_res_id, 6, 30.0, NULL, false, '30.0', now());

  -- [Gold] Rank 36: Meera Srihari (SGP 3889)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Meera Srihari')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Meera Srihari', 'meera-srihari-7766b6', '3889', 'SAF Yacht Club', 'RAFFLES GIRLS'' PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3889' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'RAFFLES GIRLS'' PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 36, 212.0, 163.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 49.0, NULL, true, '(49.0)', now()),
    (gen_random_uuid(), v_res_id, 2, 43.0, NULL, false, '43.0', now()),
    (gen_random_uuid(), v_res_id, 3, 17.0, NULL, false, '17.0', now()),
    (gen_random_uuid(), v_res_id, 4, 33.0, NULL, false, '33.0', now()),
    (gen_random_uuid(), v_res_id, 5, 30.0, NULL, false, '30.0', now()),
    (gen_random_uuid(), v_res_id, 6, 40.0, NULL, false, '40.0', now());

  -- [Gold] Rank 37: Aaron Zhiyi Chiang (SGP 3128)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aaron Zhiyi Chiang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aaron Zhiyi Chiang', 'aaron-zhiyi-chiang-d84168', '3128', 'SAF Yacht Club', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3128' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 37, 216.0, 167.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 32.0, NULL, false, '32.0', now()),
    (gen_random_uuid(), v_res_id, 2, 22.0, NULL, false, '22.0', now()),
    (gen_random_uuid(), v_res_id, 3, 35.0, NULL, false, '35.0', now()),
    (gen_random_uuid(), v_res_id, 4, 49.0, NULL, true, '(49.0)', now()),
    (gen_random_uuid(), v_res_id, 5, 29.0, NULL, false, '29.0', now()),
    (gen_random_uuid(), v_res_id, 6, 49.0, NULL, false, '49.0', now());

  -- [Gold] Rank 38: Rachel Qian Hui Lim (SGP 3197)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rachel Qian Hui Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rachel Qian Hui Lim', 'rachel-qian-hui-lim-5aa193', '3197', 'SAF Yacht Club', 'HAIG GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3197' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'HAIG GIRLS'' SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 38, 219.0, 173.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 31.0, NULL, false, '31.0', now()),
    (gen_random_uuid(), v_res_id, 2, 46.0, NULL, true, '(46.0)', now()),
    (gen_random_uuid(), v_res_id, 3, 43.0, NULL, false, '43.0', now()),
    (gen_random_uuid(), v_res_id, 4, 44.0, NULL, false, '44.0', now()),
    (gen_random_uuid(), v_res_id, 5, 27.0, NULL, false, '27.0', now()),
    (gen_random_uuid(), v_res_id, 6, 28.0, NULL, false, '28.0', now());

  -- [Gold] Rank 39: Joshua Zhi Kai Tan (SGP 3036)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joshua Zhi Kai Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joshua Zhi Kai Tan', 'joshua-zhi-kai-tan-ed3ae4', '3036', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3036' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 39, 235.0, 180.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 13.0, NULL, false, '13.0', now()),
    (gen_random_uuid(), v_res_id, 2, 44.0, NULL, false, '44.0', now()),
    (gen_random_uuid(), v_res_id, 3, 46.0, NULL, false, '46.0', now()),
    (gen_random_uuid(), v_res_id, 4, 44.0, 'SCP', false, '44.0 SCP', now()),
    (gen_random_uuid(), v_res_id, 5, 55.0, NULL, true, '(55.0)', now()),
    (gen_random_uuid(), v_res_id, 6, 33.0, NULL, false, '33.0', now());

  -- [Gold] Rank 40: Yvette Yi Min Chow (SGP 3151)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yvette Yi Min Chow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yvette Yi Min Chow', 'yvette-yi-min-chow-45eecd', '3151', 'SAF Yacht Club', 'PEI HWA PRESBYTERIAN PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3151' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'PEI HWA PRESBYTERIAN PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 40, 240.0, 184.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 47.0, NULL, false, '47.0', now()),
    (gen_random_uuid(), v_res_id, 2, 45.0, NULL, false, '45.0', now()),
    (gen_random_uuid(), v_res_id, 3, 56.0, NULL, true, '(56.0)', now()),
    (gen_random_uuid(), v_res_id, 4, 38.0, NULL, false, '38.0', now()),
    (gen_random_uuid(), v_res_id, 5, 23.0, NULL, false, '23.0', now()),
    (gen_random_uuid(), v_res_id, 6, 31.0, NULL, false, '31.0', now());

  -- [Gold] Rank 41: Quintan Rupert Low (SGP 4681)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Quintan Rupert Low')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Quintan Rupert Low', 'quintan-rupert-low-87501e', '4681', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4681' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 41, 242.0, 186.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 44.0, NULL, false, '44.0', now()),
    (gen_random_uuid(), v_res_id, 2, 56.0, NULL, true, '(56.0)', now()),
    (gen_random_uuid(), v_res_id, 3, 19.0, NULL, false, '19.0', now()),
    (gen_random_uuid(), v_res_id, 4, 46.0, NULL, false, '46.0', now()),
    (gen_random_uuid(), v_res_id, 5, 42.0, NULL, false, '42.0', now()),
    (gen_random_uuid(), v_res_id, 6, 35.0, NULL, false, '35.0', now());

  -- [Gold] Rank 42: Joel Zhuo Le Khoo (SGP 4730)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joel Zhuo Le Khoo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joel Zhuo Le Khoo', 'joel-zhuo-le-khoo-a61825', '4730', 'SAF Yacht Club', 'NANYANG PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4730' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'NANYANG PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 42, 257.0, 196.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 51.0, NULL, false, '51.0', now()),
    (gen_random_uuid(), v_res_id, 2, 34.0, NULL, false, '34.0', now()),
    (gen_random_uuid(), v_res_id, 3, 61.0, NULL, true, '(61.0)', now()),
    (gen_random_uuid(), v_res_id, 4, 26.0, NULL, false, '26.0', now()),
    (gen_random_uuid(), v_res_id, 5, 32.0, NULL, false, '32.0', now()),
    (gen_random_uuid(), v_res_id, 6, 53.0, NULL, false, '53.0', now());

  -- [Gold] Rank 43: Jared Soon Kit Liew (SGP 2002)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jared Soon Kit Liew')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jared Soon Kit Liew', 'jared-soon-kit-liew-aa578e', '2002', 'PAssion Wave', 'NGEE ANN SECONDARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2002' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'NGEE ANN SECONDARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 43, 255.0, 198.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 54.0, NULL, false, '54.0', now()),
    (gen_random_uuid(), v_res_id, 2, 32.0, NULL, false, '32.0', now()),
    (gen_random_uuid(), v_res_id, 3, 48.0, NULL, false, '48.0', now()),
    (gen_random_uuid(), v_res_id, 4, 57.0, NULL, true, '(57.0)', now()),
    (gen_random_uuid(), v_res_id, 5, 48.0, NULL, false, '48.0', now()),
    (gen_random_uuid(), v_res_id, 6, 16.0, NULL, false, '16.0', now());

  -- [Gold] Rank 44: Ashleigh Li Ying Teh (SGP 788)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ashleigh Li Ying Teh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ashleigh Li Ying Teh', 'ashleigh-li-ying-teh-514dd7', '788', 'SAF Yacht Club', 'TAO NAN SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '788' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 44, 261.0, 203.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 19.0, NULL, false, '19.0', now()),
    (gen_random_uuid(), v_res_id, 2, 48.0, NULL, false, '48.0', now()),
    (gen_random_uuid(), v_res_id, 3, 57.0, NULL, false, '57.0', now()),
    (gen_random_uuid(), v_res_id, 4, 43.0, NULL, false, '43.0', now()),
    (gen_random_uuid(), v_res_id, 5, 58.0, NULL, true, '(58.0)', now()),
    (gen_random_uuid(), v_res_id, 6, 36.0, NULL, false, '36.0', now());

  -- [Gold] Rank 45: Matthias Kai Lun Lee (SGP 3385)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Matthias Kai Lun Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Matthias Kai Lun Lee', 'matthias-kai-lun-lee-a1b968', '3385', 'SAF Yacht Club', 'MARIS STELLA HIGH SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3385' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'MARIS STELLA HIGH SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 45, 273.0, 205.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 68.0, NULL, true, '(68.0)', now()),
    (gen_random_uuid(), v_res_id, 2, 36.0, NULL, false, '36.0', now()),
    (gen_random_uuid(), v_res_id, 3, 25.0, NULL, false, '25.0', now()),
    (gen_random_uuid(), v_res_id, 4, 58.0, NULL, false, '58.0', now()),
    (gen_random_uuid(), v_res_id, 5, 47.0, NULL, false, '47.0', now()),
    (gen_random_uuid(), v_res_id, 6, 39.0, NULL, false, '39.0', now());

  -- [Gold] Rank 46: Jude Nathan Wong (SGP 3495)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jude Nathan Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jude Nathan Wong', 'jude-nathan-wong-8736da', '3495', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3495' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 46, 272.0, 213.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 55.0, NULL, false, '55.0', now()),
    (gen_random_uuid(), v_res_id, 2, 51.0, NULL, false, '51.0', now()),
    (gen_random_uuid(), v_res_id, 3, 31.0, NULL, false, '31.0', now()),
    (gen_random_uuid(), v_res_id, 4, 59.0, NULL, true, '(59.0)', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, NULL, false, '54.0', now()),
    (gen_random_uuid(), v_res_id, 6, 22.0, NULL, false, '22.0', now());

  -- [Gold] Rank 47: Gentaro Noah Lee (SGP 4471)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gentaro Noah Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gentaro Noah Lee', 'gentaro-noah-lee-77d06e', '4471', 'PAssion Wave', 'ANGLO-CHINESE SCHOOL (PRIMARY)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4471' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (PRIMARY)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 47, 279.0, 215.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 52.0, NULL, false, '52.0', now()),
    (gen_random_uuid(), v_res_id, 2, 64.0, NULL, true, '(64.0)', now()),
    (gen_random_uuid(), v_res_id, 3, 21.0, NULL, false, '21.0', now()),
    (gen_random_uuid(), v_res_id, 4, 41.0, NULL, false, '41.0', now()),
    (gen_random_uuid(), v_res_id, 5, 43.0, NULL, false, '43.0', now()),
    (gen_random_uuid(), v_res_id, 6, 58.0, NULL, false, '58.0', now());

  -- [Gold] Rank 48: Matthew Qin Hao Chiam (SGP 3606)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Matthew Qin Hao Chiam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Matthew Qin Hao Chiam', 'matthew-qin-hao-chiam-0a48aa', '3606', 'SAF Yacht Club', 'AI TONG SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3606' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'AI TONG SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 48, 284.0, 219.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 46.0, NULL, false, '46.0', now()),
    (gen_random_uuid(), v_res_id, 2, 65.0, NULL, true, '(65.0)', now()),
    (gen_random_uuid(), v_res_id, 3, 60.0, NULL, false, '60.0', now()),
    (gen_random_uuid(), v_res_id, 4, 45.0, NULL, false, '45.0', now()),
    (gen_random_uuid(), v_res_id, 5, 20.0, NULL, false, '20.0', now()),
    (gen_random_uuid(), v_res_id, 6, 48.0, NULL, false, '48.0', now());

  -- [Gold] Rank 49: Charlene Heng Ning Yong (SGP 766)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Charlene Heng Ning Yong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Charlene Heng Ning Yong', 'charlene-heng-ning-yong-9c7661', '766', 'Changi Sailing Club', 'PASIR RIS PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '766' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'PASIR RIS PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 49, 281.0, 224.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 34.0, NULL, false, '34.0', now()),
    (gen_random_uuid(), v_res_id, 2, 53.0, NULL, false, '53.0', now()),
    (gen_random_uuid(), v_res_id, 3, 30.0, NULL, false, '30.0', now()),
    (gen_random_uuid(), v_res_id, 4, 56.0, NULL, false, '56.0', now()),
    (gen_random_uuid(), v_res_id, 5, 51.0, NULL, false, '51.0', now()),
    (gen_random_uuid(), v_res_id, 6, 57.0, NULL, true, '(57.0)', now());

  -- [Gold] Rank 50: Euan Hao Xuan Poh (SGP 2030)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Euan Hao Xuan Poh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Euan Hao Xuan Poh', 'euan-hao-xuan-poh-59e758', '2030', 'Constant Wind', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2030' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 50, 298.0, 228.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 41.0, NULL, false, '41.0', now()),
    (gen_random_uuid(), v_res_id, 2, 39.0, NULL, false, '39.0', now()),
    (gen_random_uuid(), v_res_id, 3, 70.0, NULL, true, '(70.0)', now()),
    (gen_random_uuid(), v_res_id, 4, 63.0, NULL, false, '63.0', now()),
    (gen_random_uuid(), v_res_id, 5, 33.0, NULL, false, '33.0', now()),
    (gen_random_uuid(), v_res_id, 6, 52.0, NULL, false, '52.0', now());

  -- [Gold] Rank 51: Low Zhi En Zachary (SGP 3369)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Low Zhi En Zachary')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Low Zhi En Zachary', 'low-zhi-en-zachary-02ef73', '3369', 'SAF Yacht Club', 'ST. JOSEPH''S INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3369' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. JOSEPH''S INSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 51, 295.0, 230.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 53.0, NULL, false, '53.0', now()),
    (gen_random_uuid(), v_res_id, 2, 47.0, NULL, false, '47.0', now()),
    (gen_random_uuid(), v_res_id, 3, 27.0, NULL, false, '27.0', now()),
    (gen_random_uuid(), v_res_id, 4, 65.0, NULL, true, '(65.0)', now()),
    (gen_random_uuid(), v_res_id, 5, 62.0, NULL, false, '62.0', now()),
    (gen_random_uuid(), v_res_id, 6, 41.0, NULL, false, '41.0', now());

  -- [Gold] Rank 52: Abby Yan Ying Chen (SGP 4729)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Abby Yan Ying Chen')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Abby Yan Ying Chen', 'abby-yan-ying-chen-3d3c55', '4729', 'PAssion Wave', 'CHIJ ST. NICHOLAS GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4729' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'CHIJ ST. NICHOLAS GIRLS'' SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 52, 296.0, 232.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 56.0, NULL, false, '56.0', now()),
    (gen_random_uuid(), v_res_id, 2, 23.0, NULL, false, '23.0', now()),
    (gen_random_uuid(), v_res_id, 3, 51.0, NULL, false, '51.0', now()),
    (gen_random_uuid(), v_res_id, 4, 64.0, NULL, true, '(64.0)', now()),
    (gen_random_uuid(), v_res_id, 5, 57.0, NULL, false, '57.0', now()),
    (gen_random_uuid(), v_res_id, 6, 45.0, NULL, false, '45.0', now());

  -- [Gold] Rank 53: Hanyue Ouyang (SGP 5003)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hanyue Ouyang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hanyue Ouyang', 'hanyue-ouyang-cf51fd', '5003', 'ONE 15 Marina', 'NANYANG PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '5003' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'ONE 15 Marina'),
      school = COALESCE(school, 'NANYANG PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 53, 296.0, 233.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 45.0, NULL, false, '45.0', now()),
    (gen_random_uuid(), v_res_id, 2, 61.0, NULL, false, '61.0', now()),
    (gen_random_uuid(), v_res_id, 3, 58.0, NULL, false, '58.0', now()),
    (gen_random_uuid(), v_res_id, 4, 34.0, NULL, false, '34.0', now()),
    (gen_random_uuid(), v_res_id, 5, 35.0, NULL, false, '35.0', now()),
    (gen_random_uuid(), v_res_id, 6, 63.0, NULL, true, '(63.0)', now());

  -- [Gold] Rank 54: Yen Yu Kai (SGP 758)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yen Yu Kai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yen Yu Kai', 'yen-yu-kai-22dee6', '758', 'Changi Sailing Club', 'RAFFLES GIRLS'' SCHOOL (SECONDARY)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '758' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'RAFFLES GIRLS'' SCHOOL (SECONDARY)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 54, 303.0, 235.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 43.0, NULL, false, '43.0', now()),
    (gen_random_uuid(), v_res_id, 2, 57.0, NULL, false, '57.0', now()),
    (gen_random_uuid(), v_res_id, 3, 40.0, NULL, false, '40.0', now()),
    (gen_random_uuid(), v_res_id, 4, 68.0, NULL, true, '(68.0)', now()),
    (gen_random_uuid(), v_res_id, 5, 49.0, NULL, false, '49.0', now()),
    (gen_random_uuid(), v_res_id, 6, 46.0, NULL, false, '46.0', now());

  -- [Gold] Rank 55: Ethan Jing Zhou Tan (SGP 3772)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ethan Jing Zhou Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ethan Jing Zhou Tan', 'ethan-jing-zhou-tan-b87228', '3772', 'SAF Yacht Club', 'VICTORIA SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3772' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'VICTORIA SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 55, 304.0, 238.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 39.0, NULL, false, '39.0', now()),
    (gen_random_uuid(), v_res_id, 2, 25.0, NULL, false, '25.0', now()),
    (gen_random_uuid(), v_res_id, 3, 65.0, NULL, false, '65.0', now()),
    (gen_random_uuid(), v_res_id, 4, 48.0, NULL, false, '48.0', now()),
    (gen_random_uuid(), v_res_id, 5, 61.0, NULL, false, '61.0', now()),
    (gen_random_uuid(), v_res_id, 6, 66.0, NULL, true, '(66.0)', now());

  -- [Gold] Rank 56: Lucas Jun Sheng Seow (SGP 2047)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lucas Jun Sheng Seow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lucas Jun Sheng Seow', 'lucas-jun-sheng-seow-717877', '2047', 'Constant Wind', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2047' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 56, 310.0, 241.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 69.0, NULL, true, '(69.0)', now()),
    (gen_random_uuid(), v_res_id, 2, 37.0, NULL, false, '37.0', now()),
    (gen_random_uuid(), v_res_id, 3, 54.0, NULL, false, '54.0', now()),
    (gen_random_uuid(), v_res_id, 4, 30.0, NULL, false, '30.0', now()),
    (gen_random_uuid(), v_res_id, 5, 59.0, NULL, false, '59.0', now()),
    (gen_random_uuid(), v_res_id, 6, 61.0, NULL, false, '61.0', now());

  -- [Gold] Rank 57: Estelle Rui En Yeo (SGP 773)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Estelle Rui En Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Estelle Rui En Yeo', 'estelle-rui-en-yeo-4b3c6c', '773', 'Changi Sailing Club', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '773' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 57, 307.0, 242.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 59.0, NULL, false, '59.0', now()),
    (gen_random_uuid(), v_res_id, 2, 31.0, NULL, false, '31.0', now()),
    (gen_random_uuid(), v_res_id, 3, 45.0, NULL, false, '45.0', now()),
    (gen_random_uuid(), v_res_id, 4, 54.0, NULL, false, '54.0', now()),
    (gen_random_uuid(), v_res_id, 5, 53.0, NULL, false, '53.0', now()),
    (gen_random_uuid(), v_res_id, 6, 65.0, NULL, true, '(65.0)', now());

  -- [Gold] Rank 58: Christopher Soh (SGP 3168)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Christopher Soh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Christopher Soh', 'christopher-soh-e9ded6', '3168', 'SAF Yacht Club', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3168' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 58, 312.0, 244.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 61.0, NULL, false, '61.0', now()),
    (gen_random_uuid(), v_res_id, 2, 38.0, NULL, false, '38.0', now()),
    (gen_random_uuid(), v_res_id, 3, 68.0, NULL, true, '(68.0)', now()),
    (gen_random_uuid(), v_res_id, 4, 55.0, NULL, false, '55.0', now()),
    (gen_random_uuid(), v_res_id, 5, 39.0, NULL, false, '39.0', now()),
    (gen_random_uuid(), v_res_id, 6, 51.0, NULL, false, '51.0', now());

  -- [Gold] Rank 59: Yuk Pin Lim (SGP 3880)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuk Pin Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuk Pin Lim', 'yuk-pin-lim-1f87d6', '3880', 'SAF Yacht Club', 'ST. JOSEPH''S INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3880' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. JOSEPH''S INSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 59, 311.0, 248.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 40.0, NULL, false, '40.0', now()),
    (gen_random_uuid(), v_res_id, 2, 63.0, NULL, true, '(63.0)', now()),
    (gen_random_uuid(), v_res_id, 3, 62.0, NULL, false, '62.0', now()),
    (gen_random_uuid(), v_res_id, 4, 40.0, NULL, false, '40.0', now()),
    (gen_random_uuid(), v_res_id, 5, 52.0, NULL, false, '52.0', now()),
    (gen_random_uuid(), v_res_id, 6, 54.0, NULL, false, '54.0', now());

  -- [Gold] Rank 60: Kyan Chun Hong Tan (SGP 3712)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kyan Chun Hong Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kyan Chun Hong Tan', 'kyan-chun-hong-tan-31b43c', '3712', 'SAF Yacht Club', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3712' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 60, 315.5, 250.5, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 58.0, NULL, false, '58.0', now()),
    (gen_random_uuid(), v_res_id, 2, 49.5, 'RDG', false, '49.5 RDG', now()),
    (gen_random_uuid(), v_res_id, 3, 41.0, NULL, false, '41.0', now()),
    (gen_random_uuid(), v_res_id, 4, 42.0, NULL, false, '42.0', now()),
    (gen_random_uuid(), v_res_id, 5, 65.0, NULL, true, '(65.0)', now()),
    (gen_random_uuid(), v_res_id, 6, 60.0, NULL, false, '60.0', now());

  -- [Gold] Rank 61: Chen-Yi Kai (SGP 757)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Chen-Yi Kai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Chen-Yi Kai', 'chen-yi-kai-84a183', '757', 'SAF Yacht Club', 'FAIRFIELD METHODIST SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '757' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'FAIRFIELD METHODIST SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 61, 330.0, 261.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 63.0, NULL, false, '63.0', now()),
    (gen_random_uuid(), v_res_id, 2, 50.0, NULL, false, '50.0', now()),
    (gen_random_uuid(), v_res_id, 3, 52.0, NULL, false, '52.0', now()),
    (gen_random_uuid(), v_res_id, 4, 36.0, NULL, false, '36.0', now()),
    (gen_random_uuid(), v_res_id, 5, 60.0, NULL, false, '60.0', now()),
    (gen_random_uuid(), v_res_id, 6, 69.0, NULL, true, '(69.0)', now());

  -- [Gold] Rank 62: Ran Jiao (CHN 4418)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ran Jiao')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ran Jiao', 'ran-jiao-0f2b25', '4418', 'HHFLCSC', NULL, 'F', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4418' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'HHFLCSC'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 62, 336.0, 263.0, false, 'F', 'CHN', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 38.0, NULL, false, '38.0', now()),
    (gen_random_uuid(), v_res_id, 2, 69.0, NULL, false, '69.0', now()),
    (gen_random_uuid(), v_res_id, 3, 73.0, 'SCP', true, '(73.0 SCP)', now()),
    (gen_random_uuid(), v_res_id, 4, 73.0, 'SCP', false, '73.0 SCP', now()),
    (gen_random_uuid(), v_res_id, 5, 41.0, NULL, false, '41.0', now()),
    (gen_random_uuid(), v_res_id, 6, 42.0, NULL, false, '42.0', now());

  -- [Gold] Rank 63: Tyler Koo (SGP 996)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tyler Koo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tyler Koo', 'tyler-koo-9fe93d', '996', 'Republic of Singapore Yacht Club', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '996' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Republic of Singapore Yacht Club'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 63, 329.0, 264.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 65.0, NULL, true, '(65.0)', now()),
    (gen_random_uuid(), v_res_id, 2, 52.0, NULL, false, '52.0', now()),
    (gen_random_uuid(), v_res_id, 3, 50.0, NULL, false, '50.0', now()),
    (gen_random_uuid(), v_res_id, 4, 62.0, NULL, false, '62.0', now()),
    (gen_random_uuid(), v_res_id, 5, 56.0, NULL, false, '56.0', now()),
    (gen_random_uuid(), v_res_id, 6, 44.0, NULL, false, '44.0', now());

  -- [Gold] Rank 64: Nigel Jiang Long Ng (SGP 3363)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nigel Jiang Long Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nigel Jiang Long Ng', 'nigel-jiang-long-ng-eb721a', '3363', 'SAF Yacht Club', 'ENDEAVOUR PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3363' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ENDEAVOUR PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 64, 329.0, 265.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 48.0, NULL, false, '48.0', now()),
    (gen_random_uuid(), v_res_id, 2, 56.0, 'RDG', false, '56.0 RDG', now()),
    (gen_random_uuid(), v_res_id, 3, 64.0, NULL, true, '(64.0)', now()),
    (gen_random_uuid(), v_res_id, 4, 50.0, NULL, false, '50.0', now()),
    (gen_random_uuid(), v_res_id, 5, 64.0, NULL, false, '64.0', now()),
    (gen_random_uuid(), v_res_id, 6, 47.0, NULL, false, '47.0', now());

  -- [Gold] Rank 65: Breyven Zhi Long Chan (SGP 3338)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Breyven Zhi Long Chan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Breyven Zhi Long Chan', 'breyven-zhi-long-chan-3f19aa', '3338', 'SAF Yacht Club', 'ENDEAVOUR PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3338' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ENDEAVOUR PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 65, 338.0, 268.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 57.0, NULL, false, '57.0', now()),
    (gen_random_uuid(), v_res_id, 2, 58.0, NULL, false, '58.0', now()),
    (gen_random_uuid(), v_res_id, 3, 22.0, NULL, false, '22.0', now()),
    (gen_random_uuid(), v_res_id, 4, 70.0, NULL, true, '(70.0)', now()),
    (gen_random_uuid(), v_res_id, 5, 67.0, NULL, false, '67.0', now()),
    (gen_random_uuid(), v_res_id, 6, 64.0, NULL, false, '64.0', now());

  -- [Gold] Rank 66: Isabelle Xinyi Zhang (SGP 2035)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isabelle Xinyi Zhang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isabelle Xinyi Zhang', 'isabelle-xinyi-zhang-261286', '2035', 'Constant Wind', 'METHODIST GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2035' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'METHODIST GIRLS'' SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 66, 343.0, 273.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 36.0, NULL, false, '36.0', now()),
    (gen_random_uuid(), v_res_id, 2, 70.0, NULL, true, '(70.0)', now()),
    (gen_random_uuid(), v_res_id, 3, 49.0, NULL, false, '49.0', now()),
    (gen_random_uuid(), v_res_id, 4, 61.0, NULL, false, '61.0', now()),
    (gen_random_uuid(), v_res_id, 5, 68.0, NULL, false, '68.0', now()),
    (gen_random_uuid(), v_res_id, 6, 59.0, NULL, false, '59.0', now());

  -- [Gold] Rank 67: Auwin Zhao Hong Leow (SGP 3405)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Auwin Zhao Hong Leow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Auwin Zhao Hong Leow', 'auwin-zhao-hong-leow-73792d', '3405', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL (PRIMARY)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3405' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (PRIMARY)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 67, 352.0, 280.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 42.0, NULL, false, '42.0', now()),
    (gen_random_uuid(), v_res_id, 2, 35.0, NULL, false, '35.0', now()),
    (gen_random_uuid(), v_res_id, 3, 67.0, NULL, false, '67.0', now()),
    (gen_random_uuid(), v_res_id, 4, 72.0, NULL, true, '(72.0)', now()),
    (gen_random_uuid(), v_res_id, 5, 66.0, NULL, false, '66.0', now()),
    (gen_random_uuid(), v_res_id, 6, 70.0, NULL, false, '70.0', now());

  -- [Gold] Rank 68: Boren Wang (SGP 2039)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Boren Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Boren Wang', 'boren-wang-7bc535', '2039', 'PAssion Wave', 'ALEXANDRA PRIMARY SCHOOL', 'M', 'SGP', now(), now()
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 68, 362.0, 292.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 67.0, NULL, false, '67.0', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, NULL, false, '59.0', now()),
    (gen_random_uuid(), v_res_id, 3, 59.0, NULL, false, '59.0', now()),
    (gen_random_uuid(), v_res_id, 4, 51.0, NULL, false, '51.0', now()),
    (gen_random_uuid(), v_res_id, 5, 70.0, NULL, true, '(70.0)', now()),
    (gen_random_uuid(), v_res_id, 6, 56.0, NULL, false, '56.0', now());

  -- [Gold] Rank 69: Gloria Yen Rui Kwok (SGP 2004)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gloria Yen Rui Kwok')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gloria Yen Rui Kwok', 'gloria-yen-rui-kwok-c8258b', '2004', 'Constant Wind', 'CHIJ (KATONG) PRIMARY', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2004' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'CHIJ (KATONG) PRIMARY'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 69, 380.0, 309.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 71.0, NULL, true, '(71.0)', now()),
    (gen_random_uuid(), v_res_id, 2, 67.0, NULL, false, '67.0', now()),
    (gen_random_uuid(), v_res_id, 3, 34.0, NULL, false, '34.0', now()),
    (gen_random_uuid(), v_res_id, 4, 69.0, NULL, false, '69.0', now()),
    (gen_random_uuid(), v_res_id, 5, 71.0, NULL, false, '71.0', now()),
    (gen_random_uuid(), v_res_id, 6, 68.0, NULL, false, '68.0', now());

  -- [Gold] Rank 70: Xavier Yang Zheng Puah (SGP 2037)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Xavier Yang Zheng Puah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Xavier Yang Zheng Puah', 'xavier-yang-zheng-puah-2fc9a2', '2037', 'Constant Wind', 'ST. JOSEPH''S INSTITUTION JUNIOR', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2037' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'ST. JOSEPH''S INSTITUTION JUNIOR'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 70, 397.0, 324.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 62.0, NULL, false, '62.0', now()),
    (gen_random_uuid(), v_res_id, 2, 71.0, NULL, false, '71.0', now()),
    (gen_random_uuid(), v_res_id, 3, 73.0, 'RET', true, '(73.0 RET)', now()),
    (gen_random_uuid(), v_res_id, 4, 60.0, NULL, false, '60.0', now()),
    (gen_random_uuid(), v_res_id, 5, 69.0, NULL, false, '69.0', now()),
    (gen_random_uuid(), v_res_id, 6, 62.0, NULL, false, '62.0', now());

  -- [Gold] Rank 71: Hagen Goh (SGP 3600)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hagen Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hagen Goh', 'hagen-goh-bf94a3', '3600', 'SAF Yacht Club', 'DOVER COURT INTERNATIONAL SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3600' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'DOVER COURT INTERNATIONAL SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 71, 397.0, 327.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 70.0, NULL, true, '(70.0)', now()),
    (gen_random_uuid(), v_res_id, 2, 62.0, NULL, false, '62.0', now()),
    (gen_random_uuid(), v_res_id, 3, 69.0, NULL, false, '69.0', now()),
    (gen_random_uuid(), v_res_id, 4, 66.0, NULL, false, '66.0', now()),
    (gen_random_uuid(), v_res_id, 5, 63.0, NULL, false, '63.0', now()),
    (gen_random_uuid(), v_res_id, 6, 67.0, NULL, false, '67.0', now());

  -- [Gold] Rank 72: Aidan See Hett Yeo (SGP 3112)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aidan See Hett Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aidan See Hett Yeo', 'aidan-see-hett-yeo-58713d', '3112', 'SAF Yacht Club', 'KUO CHUAN PRESBYTERIAN PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3112' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'KUO CHUAN PRESBYTERIAN PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 72, 415.0, 343.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 66.0, NULL, false, '66.0', now()),
    (gen_random_uuid(), v_res_id, 2, 72.0, NULL, true, '(72.0)', now()),
    (gen_random_uuid(), v_res_id, 3, 63.0, NULL, false, '63.0', now()),
    (gen_random_uuid(), v_res_id, 4, 71.0, NULL, false, '71.0', now()),
    (gen_random_uuid(), v_res_id, 5, 72.0, NULL, false, '72.0', now()),
    (gen_random_uuid(), v_res_id, 6, 71.0, NULL, false, '71.0', now());

  -- [Gold] Rank 73: Joash Jit Yin Kok (SGP 3057)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joash Jit Yin Kok')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joash Jit Yin Kok', 'joash-jit-yin-kok-0d3f29', '3057', 'PAssion Wave', 'ANGLO-CHINESE SCHOOL (INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3057' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (INDEPENDENT)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 73, 468.0, 390.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 78.0, 'DNC', true, '(78.0 DNC)', now()),
    (gen_random_uuid(), v_res_id, 2, 78.0, 'DNC', false, '78.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 3, 78.0, 'DNC', false, '78.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 4, 78.0, 'DNC', false, '78.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 5, 78.0, 'DNC', false, '78.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 6, 78.0, 'DNC', false, '78.0 DNC', now());

  -- [Gold] Rank 73: Joel Han Sheng Ong (SGP 2014)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joel Han Sheng Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joel Han Sheng Ong', 'joel-han-sheng-ong-96d8c3', '2014', 'Constant Wind', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2014' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 73, 468.0, 390.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 78.0, 'DNC', true, '(78.0 DNC)', now()),
    (gen_random_uuid(), v_res_id, 2, 78.0, 'DNC', false, '78.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 3, 78.0, 'DNC', false, '78.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 4, 78.0, 'DNC', false, '78.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 5, 78.0, 'DNC', false, '78.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 6, 78.0, 'DNC', false, '78.0 DNC', now());

  -- [Gold] Rank 73: William Poon (SGP 21)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('William Poon')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'William Poon', 'william-poon-7bfe54', '21', 'SAF Yacht Club', 'SINGAPORE AMERICAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '21' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'SINGAPORE AMERICAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 73, 468.0, 390.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 78.0, 'DNC', true, '(78.0 DNC)', now()),
    (gen_random_uuid(), v_res_id, 2, 78.0, 'DNC', false, '78.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 3, 78.0, 'DNC', false, '78.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 4, 78.0, 'DNC', false, '78.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 5, 78.0, 'DNC', false, '78.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 6, 78.0, 'DNC', false, '78.0 DNC', now());

  -- [Gold] Rank 73: Sage Yeh (SGP 796)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sage Yeh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sage Yeh', 'sage-yeh-dfe2f3', '796', 'Changi Sailing Club', 'PUNGGOL PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '796' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'PUNGGOL PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 73, 468.0, 390.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 78.0, 'DNC', true, '(78.0 DNC)', now()),
    (gen_random_uuid(), v_res_id, 2, 78.0, 'DNC', false, '78.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 3, 78.0, 'DNC', false, '78.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 4, 78.0, 'DNC', false, '78.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 5, 78.0, 'DNC', false, '78.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 6, 78.0, 'DNC', false, '78.0 DNC', now());

  -- [Gold] Rank 73: Kevin Jun Yi Ho (SGP 3118)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kevin Jun Yi Ho')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kevin Jun Yi Ho', 'kevin-jun-yi-ho-9417d0', '3118', 'SAF Yacht Club', 'RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3118' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'RAFFLES INSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 73, 468.0, 390.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 78.0, 'DNC', true, '(78.0 DNC)', now()),
    (gen_random_uuid(), v_res_id, 2, 78.0, 'DNC', false, '78.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 3, 78.0, 'DNC', false, '78.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 4, 78.0, 'DNC', false, '78.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 5, 78.0, 'DNC', false, '78.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 6, 78.0, 'DNC', false, '78.0 DNC', now());

  -- ==========================================================================
  -- OPTIMIST SILVER FLEET (61 competitors)
  -- ==========================================================================

  -- [Silver] Rank 1: Cyra Cama (SGP 29)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cyra Cama')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cyra Cama', 'cyra-cama-185a43', '29', 'ONE 15 Marina', 'INTERNATIONAL FRENCH SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '29' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'ONE 15 Marina'),
      school = COALESCE(school, 'INTERNATIONAL FRENCH SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 1, 23.0, 13.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 10.0, NULL, true, '(10)', now()),
    (gen_random_uuid(), v_res_id, 2, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 3, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 4, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 5, 8.0, NULL, false, '8', now());

  -- [Silver] Rank 2: Arun John Behl (SGP 88)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Arun John Behl')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Arun John Behl', 'arun-john-behl-c655ce', '88', 'Changi Sailing Club', 'BUKIT MERAH SECONDARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '88' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'BUKIT MERAH SECONDARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 2, 33.0, 19.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 2, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 3, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 4, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 5, 14.0, NULL, true, '(14)', now());

  -- [Silver] Rank 3: Yan Cheng Loh (SGP 3717)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yan Cheng Loh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yan Cheng Loh', 'yan-cheng-loh-b8f619', '3717', 'SAF Yacht Club', 'NAN CHIAU PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3717' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'NAN CHIAU PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 3, 30.0, 19.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 2, 11.0, NULL, true, '(11)', now()),
    (gen_random_uuid(), v_res_id, 3, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 4, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 5, 3.0, NULL, false, '3', now());

  -- [Silver] Rank 4: Iver Zhe Xi Lee (SGP 3309)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Iver Zhe Xi Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Iver Zhe Xi Lee', 'iver-zhe-xi-lee-9d958d', '3309', 'SAF Yacht Club', 'ENDEAVOUR PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3309' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ENDEAVOUR PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 4, 45.0, 24.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 21.0, NULL, true, '(21)', now()),
    (gen_random_uuid(), v_res_id, 2, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 3, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 4, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 5, 9.0, NULL, false, '9', now());

  -- [Silver] Rank 5: Bryan Thian Tsek Lee (SGP 3508)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Bryan Thian Tsek Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Bryan Thian Tsek Lee', 'bryan-thian-tsek-lee-ef534b', '3508', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3508' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 5, 38.0, 25.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 2, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 3, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 4, 13.0, NULL, true, '(13)', now()),
    (gen_random_uuid(), v_res_id, 5, 2.0, NULL, false, '2', now());

  -- [Silver] Rank 6: Hongren Wang (SGP 2039)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 6, 75.0, 30.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 2, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 3, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 4, 45.0, NULL, true, '(45)', now()),
    (gen_random_uuid(), v_res_id, 5, 7.0, NULL, false, '7', now());

  -- [Silver] Rank 7: Jiaqian Wu (SGP 3424)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jiaqian Wu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jiaqian Wu', 'jiaqian-wu-5ea43a', '3424', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3424' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 7, 50.0, 30.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 2, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 3, 20.0, NULL, true, '(20)', now()),
    (gen_random_uuid(), v_res_id, 4, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 5, 4.0, NULL, false, '4', now());

  -- [Silver] Rank 8: Skyler Kang (SGP 2041)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Skyler Kang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Skyler Kang', 'skyler-kang-524b74', '2041', 'Constant Wind', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2041' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 8, 92.0, 47.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 2, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 3, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 4, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 5, 45.0, NULL, true, '(45)', now());

  -- [Silver] Rank 9: Jerome Puah Yang Yi (SGP 2037)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 9, 94.0, 51.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 43.0, NULL, true, '(43)', now()),
    (gen_random_uuid(), v_res_id, 2, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 3, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 4, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 5, 11.0, NULL, false, '11', now());

  -- [Silver] Rank 10: Moyan Han (SGP 2042)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Moyan Han')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Moyan Han', 'moyan-han-fb4f57', '2042', 'Constant Wind', 'NAN HUA PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2042' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'NAN HUA PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 10, 77.0, 53.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 24.0, NULL, true, '(24)', now()),
    (gen_random_uuid(), v_res_id, 2, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 3, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 4, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 5, 12.0, NULL, false, '12', now());

  -- [Silver] Rank 11: Yasin Yusuf Yusfianshah (SGP 3575)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yasin Yusuf Yusfianshah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yasin Yusuf Yusfianshah', 'yasin-yusuf-yusfianshah-4a7e5d', '3575', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3575' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 11, 86.0, 55.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 2, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 3, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 4, 31.0, NULL, true, '(31)', now()),
    (gen_random_uuid(), v_res_id, 5, 30.0, NULL, false, '30', now());

  -- [Silver] Rank 12: Ivor Zhuo Xi Lee (SGP 3306)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ivor Zhuo Xi Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ivor Zhuo Xi Lee', 'ivor-zhuo-xi-lee-15c902', '3306', 'SAF Yacht Club', 'ENDEAVOUR PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3306' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ENDEAVOUR PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 12, 80.0, 57.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 2, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 3, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 4, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 5, 23.0, NULL, true, '(23)', now());

  -- [Silver] Rank 13: Ryan Feiran Zheng (SGP 2045)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ryan Feiran Zheng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ryan Feiran Zheng', 'ryan-feiran-zheng-d9560a', '2045', 'Constant Wind', 'ST. STEPHEN''S SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2045' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'ST. STEPHEN''S SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 13, 82.0, 61.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 2, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 3, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 4, 21.0, NULL, true, '(21)', now()),
    (gen_random_uuid(), v_res_id, 5, 20.0, NULL, false, '20', now());

  -- [Silver] Rank 14: Kiyansh Kanishk Singh (SGP 2046)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kiyansh Kanishk Singh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kiyansh Kanishk Singh', 'kiyansh-kanishk-singh-8b2494', '2046', 'Constant Wind', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2046' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 14, 105.0, 62.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 2, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 3, 43.0, NULL, true, '(43)', now()),
    (gen_random_uuid(), v_res_id, 4, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 5, 1.0, NULL, false, '1', now());

  -- [Silver] Rank 15: Kai Jie Teo (SGP 3550)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kai Jie Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kai Jie Teo', 'kai-jie-teo-90c9a4', '3550', 'SAF Yacht Club', 'TANJONG KATONG PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3550' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'TANJONG KATONG PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 15, 92.0, 63.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 2, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 3, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 4, 29.0, NULL, true, '(29)', now()),
    (gen_random_uuid(), v_res_id, 5, 5.0, NULL, false, '5', now());

  -- [Silver] Rank 16: Hayden Zi Xuan Soh (SGP 3838)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hayden Zi Xuan Soh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hayden Zi Xuan Soh', 'hayden-zi-xuan-soh-b2390b', '3838', 'SAF Yacht Club', 'WHITE SANDS PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3838' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'WHITE SANDS PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 16, 85.0, 63.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 2, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 3, 22.0, NULL, true, '(22)', now()),
    (gen_random_uuid(), v_res_id, 4, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 5, 21.0, NULL, false, '21', now());

  -- [Silver] Rank 17: Clara Siew Ning Ng (SGP 3739)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Clara Siew Ning Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Clara Siew Ning Ng', 'clara-siew-ning-ng-6b56b9', '3739', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3739' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 17, 98.0, 65.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 2, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 3, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 4, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 5, 33.0, NULL, true, '(33)', now());

  -- [Silver] Rank 18: Scott Goh (SGP 729)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Scott Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Scott Goh', 'scott-goh-c1164b', '729', 'Changi Sailing Club', 'ST. JOSEPH''S INSTITUTION JUNIOR', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '729' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'ST. JOSEPH''S INSTITUTION JUNIOR'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 18, 98.0, 65.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 33.0, NULL, true, '(33)', now()),
    (gen_random_uuid(), v_res_id, 2, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 3, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 4, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 5, 22.0, NULL, false, '22', now());

  -- [Silver] Rank 19: Damien Seah (SGP 3825)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Damien Seah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Damien Seah', 'damien-seah-d115ee', '3825', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3825' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 19, 96.0, 65.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 2, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 3, 31.0, NULL, true, '(31)', now()),
    (gen_random_uuid(), v_res_id, 4, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 5, 10.0, NULL, false, '10', now());

  -- [Silver] Rank 20: Isaac Tan (SGP 2055)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isaac Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isaac Tan', 'isaac-tan-a6cefe', '2055', 'Constant Wind', 'ANGLICAN HIGH SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2055' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'ANGLICAN HIGH SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 20, 95.0, 66.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 29.0, NULL, true, '(29)', now()),
    (gen_random_uuid(), v_res_id, 2, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 3, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 4, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 5, 24.0, NULL, false, '24', now());

  -- [Silver] Rank 21: Adele Ziyi Chiang (SGP 3120)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Adele Ziyi Chiang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Adele Ziyi Chiang', 'adele-ziyi-chiang-1fbfb0', '3120', 'SAF Yacht Club', 'TAO NAN SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3120' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 21, 103.0, 69.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 2, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 3, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 4, 34.0, NULL, true, '(34)', now()),
    (gen_random_uuid(), v_res_id, 5, 13.0, NULL, false, '13', now());

  -- [Silver] Rank 22: Su Yuan (SGP 3043)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Su Yuan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Su Yuan', 'su-yuan-4573e4', '3043', 'SAF Yacht Club', 'CHIJ (KATONG) PRIMARY', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3043' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'CHIJ (KATONG) PRIMARY'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 22, 117.0, 71.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 2, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 3, 46.0, 'SCP', true, '(46 SCP)', now()),
    (gen_random_uuid(), v_res_id, 4, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 5, 18.0, NULL, false, '18', now());

  -- [Silver] Rank 23: Sven Xin Chen Lim (SGP 3893)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sven Xin Chen Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sven Xin Chen Lim', 'sven-xin-chen-lim-9671b5', '3893', 'SAF Yacht Club', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3893' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 23, 117.0, 76.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 2, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 3, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 4, 41.0, NULL, true, '(41)', now()),
    (gen_random_uuid(), v_res_id, 5, 6.0, NULL, false, '6', now());

  -- [Silver] Rank 24: Enzo Kengsin Teo (SGP 2044)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Enzo Kengsin Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Enzo Kengsin Teo', 'enzo-kengsin-teo-87cce7', '2044', 'Constant Wind', 'ST. STEPHEN''S SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2044' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'ST. STEPHEN''S SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 24, 111.0, 77.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 34.0, NULL, true, '(34)', now()),
    (gen_random_uuid(), v_res_id, 2, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 3, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 4, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 5, 28.0, NULL, false, '28', now());

  -- [Silver] Rank 25: Neel Paul Behl (SGP 734)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Neel Paul Behl')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Neel Paul Behl', 'neel-paul-behl-8fb320', '734', 'Changi Sailing Club', 'ZHANGDE PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '734' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'ZHANGDE PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 25, 134.0, 80.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 2, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 3, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 4, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, 'TLE', true, '(54 TLE)', now());

  -- [Silver] Rank 26: Muhammad Rehan Bin Mohamed Salim (SGP 2059)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Muhammad Rehan Bin Mohamed Salim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Muhammad Rehan Bin Mohamed Salim', 'muhammad-rehan-bin-mohamed-salim-398aad', '2059', 'Constant Wind', 'WHITE SANDS PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2059' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'WHITE SANDS PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 26, 159.0, 97.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 62.0, 'BFD', true, '(62 BFD)', now()),
    (gen_random_uuid(), v_res_id, 2, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 3, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 4, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 5, 19.0, NULL, false, '19', now());

  -- [Silver] Rank 27: Luca Kexing Yang (SGP 707)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Luca Kexing Yang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Luca Kexing Yang', 'luca-kexing-yang-f80de2', '707', 'Changi Sailing Club', 'UNITED WORLD COLLEGE (SEA)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '707' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'UNITED WORLD COLLEGE (SEA)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 27, 140.0, 100.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 2, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 3, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 4, 40.0, NULL, true, '(40)', now()),
    (gen_random_uuid(), v_res_id, 5, 17.0, NULL, false, '17', now());

  -- [Silver] Rank 28: Laurence Jun Zhe Foo (SGP 3712)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Laurence Jun Zhe Foo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Laurence Jun Zhe Foo', 'laurence-jun-zhe-foo-e36ece', '3712', 'SAF Yacht Club', 'PEI CHUN PUBLIC SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3712' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'PEI CHUN PUBLIC SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 28, 150.0, 103.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 2, 47.0, NULL, true, '(47)', now()),
    (gen_random_uuid(), v_res_id, 3, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 4, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 5, 29.0, NULL, false, '29', now());

  -- [Silver] Rank 29: Jan Welzl (SGP 2033)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jan Welzl')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jan Welzl', 'jan-welzl-fe7790', '2033', 'Constant Wind', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2033' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 29, 150.0, 106.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 2, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 3, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 4, 44.0, NULL, true, '(44)', now()),
    (gen_random_uuid(), v_res_id, 5, 16.0, NULL, false, '16', now());

  -- [Silver] Rank 30: Yahe Wang (SGP 3020)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yahe Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yahe Wang', 'yahe-wang-d61fe9', '3020', 'SAF Yacht Club', 'PEI TONG PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3020' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'PEI TONG PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 30, 152.0, 109.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 2, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 3, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 4, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 5, 43.0, NULL, true, '(43)', now());

  -- [Silver] Rank 31: Seraphina Kang (SGP 2040)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Seraphina Kang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Seraphina Kang', 'seraphina-kang-ed7224', '2040', 'Constant Wind', 'CHIJ OUR LADY QUEEN OF PEACE', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2040' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'CHIJ OUR LADY QUEEN OF PEACE'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 31, 151.0, 116.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 2, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 3, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 4, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 5, 35.0, NULL, true, '(35)', now());

  -- [Silver] Rank 32: Jae Guan Yu Toh (SGP 3311)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jae Guan Yu Toh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jae Guan Yu Toh', 'jae-guan-yu-toh-0c8d33', '3311', 'SAF Yacht Club', 'MARIS STELLA HIGH SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3311' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'MARIS STELLA HIGH SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 32, 166.0, 122.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 2, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 3, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 4, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 5, 44.0, NULL, true, '(44)', now());

  -- [Silver] Rank 33: Jiayi Du (SGP 3141)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jiayi Du')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jiayi Du', 'jiayi-du-017134', '3141', 'SAF Yacht Club', 'ST. GABRIEL''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3141' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. GABRIEL''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 33, 174.0, 124.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 2, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 3, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 4, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 5, 50.0, NULL, true, '(50)', now());

  -- [Silver] Rank 34: Jade Tan (SGP 3555)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jade Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jade Tan', 'jade-tan-d4e0f7', '3555', 'SAF Yacht Club', 'AI TONG SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3555' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'AI TONG SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 34, 186.0, 124.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 2, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 3, 62.0, 'RET', true, '(62 RET)', now()),
    (gen_random_uuid(), v_res_id, 4, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 5, 15.0, NULL, false, '15', now());

  -- [Silver] Rank 35: Yuki Youqi Wang (SGP 3523)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuki Youqi Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuki Youqi Wang', 'yuki-youqi-wang-3c46f9', '3523', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3523' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 35, 178.0, 126.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 2, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 3, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 4, 52.0, NULL, true, '(52)', now()),
    (gen_random_uuid(), v_res_id, 5, 40.0, NULL, false, '40', now());

  -- [Silver] Rank 36: An Hu (SGP 2050)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('An Hu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'An Hu', 'an-hu-82658a', '2050', 'Constant Wind', 'SINGAPORE AMERICAN SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2050' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'SINGAPORE AMERICAN SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 36, 187.0, 129.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 2, 58.0, NULL, true, '(58)', now()),
    (gen_random_uuid(), v_res_id, 3, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 4, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 5, 34.0, NULL, false, '34', now());

  -- [Silver] Rank 37: Thaddaeus Renz (SGP 2058)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Thaddaeus Renz')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Thaddaeus Renz', 'thaddaeus-renz-6abed1', '2058', 'Constant Wind', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2058' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 37, 177.0, 132.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 2, 45.0, NULL, true, '(45)', now()),
    (gen_random_uuid(), v_res_id, 3, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 4, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 5, 26.0, NULL, false, '26', now());

  -- [Silver] Rank 38: Isaias Cheow (SGP 3307)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isaias Cheow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isaias Cheow', 'isaias-cheow-67a387', '3307', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL (PRIMARY)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3307' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (PRIMARY)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 38, 173.0, 133.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 40.0, NULL, true, '(40)', now()),
    (gen_random_uuid(), v_res_id, 2, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 3, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 4, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 5, 31.0, NULL, false, '31', now());

  -- [Silver] Rank 39: Nadia Zahedi (SGP 4724)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 39, 188.0, 134.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 52.0, NULL, false, '52', now()),
    (gen_random_uuid(), v_res_id, 2, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 3, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 4, 54.0, NULL, true, '(54)', now()),
    (gen_random_uuid(), v_res_id, 5, 25.0, NULL, false, '25', now());

  -- [Silver] Rank 40: Elouan Gay (SGP 793)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elouan Gay')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elouan Gay', 'elouan-gay-66ae26', '793', 'Changi Sailing Club', 'INTERNATIONAL FRENCH SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '793' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'INTERNATIONAL FRENCH SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 40, 178.0, 136.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 2, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 3, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 4, 42.0, NULL, true, '(42)', now()),
    (gen_random_uuid(), v_res_id, 5, 41.0, NULL, false, '41', now());

  -- [Silver] Rank 41: Amelie Camille Pitsilis (SGP 702)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Amelie Camille Pitsilis')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Amelie Camille Pitsilis', 'amelie-camille-pitsilis-ae5372', '702', 'Changi Sailing Club', 'INTERNATIONAL FRENCH SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '702' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'INTERNATIONAL FRENCH SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 41, 192.0, 139.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 2, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 3, 53.0, NULL, true, '(53)', now()),
    (gen_random_uuid(), v_res_id, 4, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 5, 49.0, NULL, false, '49', now());

  -- [Silver] Rank 42: Hillary Kai Hui Tan (SGP 777)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hillary Kai Hui Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hillary Kai Hui Tan', 'hillary-kai-hui-tan-988e9a', '777', 'SAF Yacht Club', 'KONG HWA SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '777' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'KONG HWA SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 42, 203.0, 141.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 62.0, 'BFD', true, '(62 BFD)', now()),
    (gen_random_uuid(), v_res_id, 2, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 3, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 4, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 5, 46.0, NULL, false, '46', now());

  -- [Silver] Rank 43: Ilysha Wong (SGP 2053)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ilysha Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ilysha Wong', 'ilysha-wong-d6f3af', '2053', 'Constant Wind', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2053' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 43, 195.0, 141.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 2, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 3, 38.0, 'SCP', false, '38 SCP', now()),
    (gen_random_uuid(), v_res_id, 4, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, 'TLE', true, '(54 TLE)', now());

  -- [Silver] Rank 44: Sumire Sayawaki-Kogut (SGP 710)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sumire Sayawaki-Kogut')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sumire Sayawaki-Kogut', 'sumire-sayawaki-kogut-ec7d82', '710', 'Changi Sailing Club', 'UNITED WORLD COLLEGE (SEA)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '710' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'UNITED WORLD COLLEGE (SEA)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 44, 200.0, 145.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 55.0, NULL, true, '(55)', now()),
    (gen_random_uuid(), v_res_id, 2, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 3, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 4, 51.0, NULL, false, '51', now()),
    (gen_random_uuid(), v_res_id, 5, 47.0, NULL, false, '47', now());

  -- [Silver] Rank 45: Llewellyn Ding Zhe Tay (SGP 3013)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Llewellyn Ding Zhe Tay')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Llewellyn Ding Zhe Tay', 'llewellyn-ding-zhe-tay-52cda5', '3013', 'SAF Yacht Club', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3013' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 45, 208.0, 149.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 2, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 3, 59.0, 'TLE', true, '(59 TLE)', now()),
    (gen_random_uuid(), v_res_id, 4, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 5, 48.0, NULL, false, '48', now());

  -- [Silver] Rank 46: Axel Lin (SGP 720)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Axel Lin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Axel Lin', 'axel-lin-00c7c6', '720', 'Changi Sailing Club', 'NANYANG PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '720' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'NANYANG PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 46, 216.0, 154.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 2, 62.0, 'UFD', true, '(62 UFD)', now()),
    (gen_random_uuid(), v_res_id, 3, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 4, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 5, 36.0, NULL, false, '36', now());

  -- [Silver] Rank 47: Evan En Kai Ong (SGP 3955)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Evan En Kai Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Evan En Kai Ong', 'evan-en-kai-ong-45d3a5', '3955', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3955' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 47, 227.0, 165.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 62.0, 'BFD', true, '(62 BFD)', now()),
    (gen_random_uuid(), v_res_id, 2, 51.0, NULL, false, '51', now()),
    (gen_random_uuid(), v_res_id, 3, 52.0, NULL, false, '52', now()),
    (gen_random_uuid(), v_res_id, 4, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 5, 42.0, NULL, false, '42', now());

  -- [Silver] Rank 48: Ethan Mathew (SGP 3841)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ethan Mathew')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ethan Mathew', 'ethan-mathew-64c78a', '3841', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3841' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 48, 223.0, 166.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 2, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 3, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 4, 57.0, NULL, true, '(57)', now()),
    (gen_random_uuid(), v_res_id, 5, 27.0, NULL, false, '27', now());

  -- [Silver] Rank 49: Jacob Jit Yeung Kok (SGP 3087)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jacob Jit Yeung Kok')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jacob Jit Yeung Kok', 'jacob-jit-yeung-kok-d369ed', '3087', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3087' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 49, 226.0, 170.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 2, 56.0, NULL, true, '(56)', now()),
    (gen_random_uuid(), v_res_id, 3, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 4, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 5, 38.0, NULL, false, '38', now());

  -- [Silver] Rank 50: Yixia Sun (SGP 2061)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yixia Sun')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yixia Sun', 'yixia-sun-c04e54', '2061', 'Constant Wind', 'FENGSHAN PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2061' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'FENGSHAN PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 50, 228.0, 173.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 2, 55.0, NULL, true, '(55)', now()),
    (gen_random_uuid(), v_res_id, 3, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 4, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, 'TLE', false, '54 TLE', now());

  -- [Silver] Rank 51: Dylan Yao Rui Teo (SGP 3107)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Dylan Yao Rui Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Dylan Yao Rui Teo', 'dylan-yao-rui-teo-60e189', '3107', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3107' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 51, 232.0, 175.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 2, 57.0, NULL, true, '(57)', now()),
    (gen_random_uuid(), v_res_id, 3, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 4, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 5, 32.0, NULL, false, '32', now());

  -- [Silver] Rank 52: Emil Lam (SGP 2049)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Emil Lam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Emil Lam', 'emil-lam-286a00', '2049', 'Constant Wind', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2049' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 52, 233.0, 179.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 2, 54.0, NULL, true, '(54)', now()),
    (gen_random_uuid(), v_res_id, 3, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 4, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 5, 39.0, NULL, false, '39', now());

  -- [Silver] Rank 53: Chloe Ariane Pitsilis (SGP 708)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Chloe Ariane Pitsilis')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Chloe Ariane Pitsilis', 'chloe-ariane-pitsilis-8d491a', '708', 'Changi Sailing Club', 'INTERNATIONAL FRENCH SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '708' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'INTERNATIONAL FRENCH SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 53, 242.0, 180.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 53.0, NULL, false, '53', now()),
    (gen_random_uuid(), v_res_id, 2, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 3, 62.0, 'RET', true, '(62 RET)', now()),
    (gen_random_uuid(), v_res_id, 4, 62.0, 'RET', false, '62 RET', now()),
    (gen_random_uuid(), v_res_id, 5, 62.0, 'RET', false, '62 RET', now());

  -- [Silver] Rank 54: Ezra Yi Yang Mak (SGP 3535)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ezra Yi Yang Mak')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ezra Yi Yang Mak', 'ezra-yi-yang-mak-4ada61', '3535', 'SAF Yacht Club', 'ST. ANDREW''S JUNIOR SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3535' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. ANDREW''S JUNIOR SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 54, 239.0, 180.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 2, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 3, 59.0, 'TLE', true, '(59 TLE)', now()),
    (gen_random_uuid(), v_res_id, 4, 58.0, NULL, false, '58', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, 'TLE', false, '54 TLE', now());

  -- [Silver] Rank 55: Christopher Tan (SGP 2057)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Christopher Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Christopher Tan', 'christopher-tan-3869de', '2057', 'Constant Wind', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2057' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 55, 248.0, 189.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 2, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 3, 51.0, NULL, false, '51', now()),
    (gen_random_uuid(), v_res_id, 4, 59.0, NULL, true, '(59)', now()),
    (gen_random_uuid(), v_res_id, 5, 51.0, NULL, false, '51', now());

  -- [Silver] Rank 56: Nurul 'Afiya Binte Mohamed Shahrom (SGP 703)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nurul ''Afiya Binte Mohamed Shahrom')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nurul ''Afiya Binte Mohamed Shahrom', 'nurul-afiya-binte-mohamed-shahrom-b855f0', '703', 'Changi Sailing Club', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '703' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 56, 252.0, 190.0, false, 'F', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 62.0, 'BFD', true, '(62 BFD)', now()),
    (gen_random_uuid(), v_res_id, 2, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 3, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 4, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, 'TLE', false, '54 TLE', now());

  -- [Silver] Rank 57: Adam Leow (SGP 2063)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Adam Leow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Adam Leow', 'adam-leow-f11839', '2063', 'Constant Wind', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2063' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'TAO NAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 57, 253.0, 197.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 2, 53.0, NULL, false, '53', now()),
    (gen_random_uuid(), v_res_id, 3, 56.0, NULL, true, '(56)', now()),
    (gen_random_uuid(), v_res_id, 4, 53.0, NULL, false, '53', now()),
    (gen_random_uuid(), v_res_id, 5, 37.0, NULL, false, '37', now());

  -- [Silver] Rank 58: Isaac Qin Ran Chiam (SGP 3699)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isaac Qin Ran Chiam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isaac Qin Ran Chiam', 'isaac-qin-ran-chiam-785c46', '3699', 'SAF Yacht Club', 'AI TONG SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3699' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'AI TONG SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 58, 261.0, 205.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 51.0, NULL, false, '51', now()),
    (gen_random_uuid(), v_res_id, 2, 52.0, NULL, false, '52', now()),
    (gen_random_uuid(), v_res_id, 3, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 4, 56.0, NULL, true, '(56)', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, 'TLE', false, '54 TLE', now());

  -- [Silver] Rank 59: Efrem Mak (SGP 3222)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Efrem Mak')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Efrem Mak', 'efrem-mak-8cd8f8', '3222', 'SAF Yacht Club', 'ST. ANDREW''S JUNIOR SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3222' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. ANDREW''S JUNIOR SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 59, 265.0, 205.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 2, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 3, 55.0, NULL, false, '55', now()),
    (gen_random_uuid(), v_res_id, 4, 60.0, NULL, true, '(60)', now()),
    (gen_random_uuid(), v_res_id, 5, 52.0, NULL, false, '52', now());

  -- [Silver] Rank 60: Ryan Jonathan Zhi Jie Soh (SGP 3110)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ryan Jonathan Zhi Jie Soh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ryan Jonathan Zhi Jie Soh', 'ryan-jonathan-zhi-jie-soh-5579e8', '3110', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3110' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 60, 277.0, 215.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 57.0, 'TLE', false, '57 TLE', now()),
    (gen_random_uuid(), v_res_id, 2, 62.0, 'DNS', true, '(62 DNS)', now()),
    (gen_random_uuid(), v_res_id, 3, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 4, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, 'TLE', false, '54 TLE', now());

  -- [Silver] Rank 61: Tobias Ng (SGP 3469)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tobias Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tobias Ng', 'tobias-ng-5f6e22', '3469', 'SAF Yacht Club', 'RULANG PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3469' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'RULANG PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 61, 285.0, 223.0, false, 'M', 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 57.0, 'TLE', false, '57 TLE', now()),
    (gen_random_uuid(), v_res_id, 2, 62.0, 'SCP', true, '(62 SCP)', now()),
    (gen_random_uuid(), v_res_id, 3, 57.0, NULL, false, '57', now()),
    (gen_random_uuid(), v_res_id, 4, 55.0, NULL, false, '55', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, 'TLE', false, '54 TLE', now());

END $$;
