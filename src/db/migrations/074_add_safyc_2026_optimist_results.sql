-- 074_add_safyc_2026_optimist_results.sql
-- Import official race-by-race results for 2nd SAFYC Optimist Championships 2026 (Optimist Gold & Silver)
-- Dates: 4–5 July 2026
-- Venue: NSRCC Seasports Centre, 11 Changi Coast Walk, Singapore 499740
-- Organiser: SAF Yacht Club
-- Source: Official Notice of Race and Sailwave scoring sheets (91 Gold entries, 7 races; 58 Silver entries, 5 races)

DO $$
DECLARE
  v_event_id uuid;
  v_gold_id uuid;
  v_silver_id uuid;
  v_sailor_id uuid;
  v_res_id uuid;
BEGIN
  -- 1. Ensure weekend event exists in public.regatta_events
  SELECT id INTO v_event_id FROM public.regatta_events WHERE slug = '2nd-safyc-optimist-championships-2026' LIMIT 1;
  IF v_event_id IS NULL THEN
    v_event_id := gen_random_uuid();
    INSERT INTO public.regatta_events (
      id, name, slug, start_date, end_date, venue, organizer, classes, nor_url, registration_url, counts_for_ranking, is_selection_trial, created_at, updated_at
    ) VALUES (
      v_event_id, '2nd SAFYC Optimist Championships 2026', '2nd-safyc-optimist-championships-2026', '2026-07-04', '2026-07-05',
      'NSRCC Seasports Centre, Singapore', 'SAF Yacht Club',
      '["Optimist (Gold)", "Optimist (Silver)"]'::jsonb,
      'https://www.racingrulesofsailing.org/documents/14691/event', 'https://www.safyc.org.sg',
      true, false, now(), now()
    );
  END IF;

  -- 2. Ensure Optimist Gold regatta exists
  SELECT id INTO v_gold_id FROM public.regattas WHERE slug = 'safyc-gold-jul-26-2026-07-04' OR slug = '2nd-safyc-optimist-championships-2026-gold' LIMIT 1;
  IF v_gold_id IS NOT NULL THEN
    UPDATE public.regattas SET
      event_id = v_event_id,
      name = '2nd SAFYC Optimist Championships 2026 (Optimist Gold)',
      slug = 'safyc-gold-jul-26-2026-07-04',
      date = '2026-07-04',
      end_date = '2026-07-05',
      boat_class = 'Optimist',
      division = 'Gold',
      total_fleet_size = 91,
      race_count = 7,
      geography = 'SG',
      counts_for_ranking = true,
      is_selection_trial = false,
      venue = 'NSRCC Seasports Centre, Singapore',
      organizer = 'SAF Yacht Club',
      nor_url = 'https://www.racingrulesofsailing.org/documents/14691/event',
      registration_url = 'https://www.safyc.org.sg',
      schedule_notes = '2nd SAFYC Optimist Championships 2026 Optimist Gold fleet: 91 entries, 7 races sailed (R1-R7, 1 discard). Final results official as of 6 July 2026.',
      status = 'published',
      updated_at = now()
    WHERE id = v_gold_id;
  ELSE
    v_gold_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, is_selection_trial, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_gold_id, v_event_id, '2nd SAFYC Optimist Championships 2026 (Optimist Gold)', 'safyc-gold-jul-26-2026-07-04', '2026-07-04', '2026-07-05',
      'Optimist', 'Gold', 91, 7, 'SG', true, false, 'NSRCC Seasports Centre, Singapore', 'SAF Yacht Club',
      'https://www.racingrulesofsailing.org/documents/14691/event', 'https://www.safyc.org.sg',
      '2nd SAFYC Optimist Championships 2026 Optimist Gold fleet: 91 entries, 7 races sailed (R1-R7, 1 discard). Final results official as of 6 July 2026.', 'published', now(), now()
    );
  END IF;

  -- 3. Ensure Optimist Silver regatta exists
  SELECT id INTO v_silver_id FROM public.regattas WHERE slug = 'safyc-silver-jul-26-2026-07-04' OR slug = '2nd-safyc-optimist-championships-2026-silver' LIMIT 1;
  IF v_silver_id IS NOT NULL THEN
    UPDATE public.regattas SET
      event_id = v_event_id,
      name = '2nd SAFYC Optimist Championships 2026 (Optimist Silver)',
      slug = 'safyc-silver-jul-26-2026-07-04',
      date = '2026-07-04',
      end_date = '2026-07-05',
      boat_class = 'Optimist',
      division = 'Silver',
      total_fleet_size = 58,
      race_count = 5,
      geography = 'SG',
      counts_for_ranking = true,
      is_selection_trial = false,
      venue = 'NSRCC Seasports Centre, Singapore',
      organizer = 'SAF Yacht Club',
      nor_url = 'https://www.racingrulesofsailing.org/documents/14691/event',
      registration_url = 'https://www.safyc.org.sg',
      schedule_notes = '2nd SAFYC Optimist Championships 2026 Optimist Silver fleet: 58 entries, 5 races sailed (R1-R5, 1 discard). Final results official as of 6 July 2026.',
      status = 'published',
      updated_at = now()
    WHERE id = v_silver_id;
  ELSE
    v_silver_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, is_selection_trial, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_silver_id, v_event_id, '2nd SAFYC Optimist Championships 2026 (Optimist Silver)', 'safyc-silver-jul-26-2026-07-04', '2026-07-04', '2026-07-05',
      'Optimist', 'Silver', 58, 5, 'SG', true, false, 'NSRCC Seasports Centre, Singapore', 'SAF Yacht Club',
      'https://www.racingrulesofsailing.org/documents/14691/event', 'https://www.safyc.org.sg',
      '2nd SAFYC Optimist Championships 2026 Optimist Silver fleet: 58 entries, 5 races sailed (R1-R5, 1 discard). Final results official as of 6 July 2026.', 'published', now(), now()
    );
  END IF;

  -- Clean prior results for Gold & Silver
  DELETE FROM public.regatta_results WHERE regatta_id = v_gold_id;
  DELETE FROM public.regatta_results WHERE regatta_id = v_silver_id;

  -- ==========================================================================
  -- OPTIMIST GOLD FLEET (91 competitors)
  -- ==========================================================================

  -- [Gold] Rank 1: Alyssa Wong Li Lin (SGP 150)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Alyssa Wong Li Lin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Alyssa Wong Li Lin', 'alyssa-wong-li-lin-e42fef', '150', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '150' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 1, 33.8, 18.8, false, 'F', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 2.0, NULL, false, '2.0', now()),
    (gen_random_uuid(), v_res_id, 2, 15.0, NULL, true, '15.0', now()),
    (gen_random_uuid(), v_res_id, 3, 2.0, NULL, false, '2.0', now()),
    (gen_random_uuid(), v_res_id, 4, 2.0, NULL, false, '2.0', now()),
    (gen_random_uuid(), v_res_id, 5, 2.0, NULL, false, '2.0', now()),
    (gen_random_uuid(), v_res_id, 6, 4.8, 'RDG', false, '4.8 RDG', now()),
    (gen_random_uuid(), v_res_id, 7, 6.0, NULL, false, '6.0', now());

  -- [Gold] Rank 2: Kevin Ho (SGP 171)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kevin Ho')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kevin Ho', 'kevin-ho-bb3284', '171', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '171' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 2, 30.3, 23.3, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 1.0, NULL, false, '1.0', now()),
    (gen_random_uuid(), v_res_id, 2, 7.0, NULL, true, '7.0', now()),
    (gen_random_uuid(), v_res_id, 3, 1.0, NULL, false, '1.0', now()),
    (gen_random_uuid(), v_res_id, 4, 6.0, NULL, false, '6.0', now()),
    (gen_random_uuid(), v_res_id, 5, 6.0, NULL, false, '6.0', now()),
    (gen_random_uuid(), v_res_id, 6, 4.3, 'RDG', false, '4.3 RDG', now()),
    (gen_random_uuid(), v_res_id, 7, 5.0, NULL, false, '5.0', now());

  -- [Gold] Rank 3: Low Ethan Zhi Ren (SGP 78)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Low Ethan Zhi Ren')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Low Ethan Zhi Ren', 'low-ethan-zhi-ren-55f837', '78', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '78' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 3, 44.0, 28.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 3.0, NULL, false, '3.0', now()),
    (gen_random_uuid(), v_res_id, 2, 16.0, NULL, true, '16.0', now()),
    (gen_random_uuid(), v_res_id, 3, 6.0, NULL, false, '6.0', now()),
    (gen_random_uuid(), v_res_id, 4, 10.0, NULL, false, '10.0', now()),
    (gen_random_uuid(), v_res_id, 5, 7.0, NULL, false, '7.0', now()),
    (gen_random_uuid(), v_res_id, 6, 1.0, NULL, false, '1.0', now()),
    (gen_random_uuid(), v_res_id, 7, 1.0, NULL, false, '1.0', now());

  -- [Gold] Rank 4: Ethan Lee (SGP 83)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ethan Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ethan Lee', 'ethan-lee-6efc56', '83', 'Others', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '83' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Others'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 4, 137.0, 45.0, false, 'M', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 92.0, 'BFD', true, '92.0 BFD', now()),
    (gen_random_uuid(), v_res_id, 2, 4.0, NULL, false, '4.0', now()),
    (gen_random_uuid(), v_res_id, 3, 10.0, NULL, false, '10.0', now()),
    (gen_random_uuid(), v_res_id, 4, 4.0, NULL, false, '4.0', now()),
    (gen_random_uuid(), v_res_id, 5, 12.0, NULL, false, '12.0', now()),
    (gen_random_uuid(), v_res_id, 6, 11.0, NULL, false, '11.0', now()),
    (gen_random_uuid(), v_res_id, 7, 4.0, NULL, false, '4.0', now());

  -- [Gold] Rank 5: Teo Jairus (SGP 4073)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Teo Jairus')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Teo Jairus', 'teo-jairus-572b44', '4073', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4073' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 5, 68.0, 46.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 5.0, NULL, false, '5.0', now()),
    (gen_random_uuid(), v_res_id, 2, 12.0, NULL, false, '12.0', now()),
    (gen_random_uuid(), v_res_id, 3, 3.0, NULL, false, '3.0', now()),
    (gen_random_uuid(), v_res_id, 4, 13.0, NULL, false, '13.0', now()),
    (gen_random_uuid(), v_res_id, 5, 3.0, NULL, false, '3.0', now()),
    (gen_random_uuid(), v_res_id, 6, 10.0, NULL, false, '10.0', now()),
    (gen_random_uuid(), v_res_id, 7, 22.0, NULL, true, '22.0', now());

  -- [Gold] Rank 6: Anya Zahedi (SGP 159)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Anya Zahedi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Anya Zahedi', 'anya-zahedi-f93e2e', '159', 'Others', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '159' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Others'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 6, 85.0, 50.0, false, 'F', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 10.0, NULL, false, '10.0', now()),
    (gen_random_uuid(), v_res_id, 2, 5.0, NULL, false, '5.0', now()),
    (gen_random_uuid(), v_res_id, 3, 15.0, NULL, false, '15.0', now()),
    (gen_random_uuid(), v_res_id, 4, 7.0, NULL, false, '7.0', now()),
    (gen_random_uuid(), v_res_id, 5, 10.0, NULL, false, '10.0', now()),
    (gen_random_uuid(), v_res_id, 6, 35.0, NULL, true, '35.0', now()),
    (gen_random_uuid(), v_res_id, 7, 3.0, NULL, false, '3.0', now());

  -- [Gold] Rank 7: Elliot Goh (SGP 3103)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elliot Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elliot Goh', 'elliot-goh-c08f54', '3103', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3103' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 7, 148.0, 56.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 6.0, NULL, false, '6.0', now()),
    (gen_random_uuid(), v_res_id, 2, 24.0, NULL, false, '24.0', now()),
    (gen_random_uuid(), v_res_id, 3, 4.0, NULL, false, '4.0', now()),
    (gen_random_uuid(), v_res_id, 4, 92.0, 'BFD', true, '92.0 BFD', now()),
    (gen_random_uuid(), v_res_id, 5, 1.0, NULL, false, '1.0', now()),
    (gen_random_uuid(), v_res_id, 6, 13.0, NULL, false, '13.0', now()),
    (gen_random_uuid(), v_res_id, 7, 8.0, NULL, false, '8.0', now());

  -- [Gold] Rank 8: Nathaniel Kaiden Ng (SGP 3344)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nathaniel Kaiden Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nathaniel Kaiden Ng', 'nathaniel-kaiden-ng-1db883', '3344', 'Others', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3344' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Others'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 8, 78.2, 58.2, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 14.0, NULL, false, '14.0', now()),
    (gen_random_uuid(), v_res_id, 2, 2.0, NULL, false, '2.0', now()),
    (gen_random_uuid(), v_res_id, 3, 5.0, NULL, false, '5.0', now()),
    (gen_random_uuid(), v_res_id, 4, 16.0, NULL, false, '16.0', now()),
    (gen_random_uuid(), v_res_id, 5, 20.0, NULL, true, '20.0', now()),
    (gen_random_uuid(), v_res_id, 6, 11.2, 'RDG', false, '11.2 RDG', now()),
    (gen_random_uuid(), v_res_id, 7, 10.0, NULL, false, '10.0', now());

  -- [Gold] Rank 9: Darian Huang (SGP 3700)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Darian Huang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Darian Huang', 'darian-huang-9904a9', '3700', 'Others', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3700' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Others'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 9, 93.0, 64.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 11.0, NULL, false, '11.0', now()),
    (gen_random_uuid(), v_res_id, 2, 29.0, NULL, true, '29.0', now()),
    (gen_random_uuid(), v_res_id, 3, 9.0, NULL, false, '9.0', now()),
    (gen_random_uuid(), v_res_id, 4, 1.0, NULL, false, '1.0', now()),
    (gen_random_uuid(), v_res_id, 5, 21.0, NULL, false, '21.0', now()),
    (gen_random_uuid(), v_res_id, 6, 8.0, NULL, false, '8.0', now()),
    (gen_random_uuid(), v_res_id, 7, 14.0, NULL, false, '14.0', now());

  -- [Gold] Rank 10: Tong Xuan Ya (KSA 107)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tong Xuan Ya')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tong Xuan Ya', 'tong-xuan-ya-c4a6ad', '107', 'Constant Wind', 'M', 'KSA', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '107' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'KSA'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 10, 163.0, 71.0, false, 'M', 2012, 'KSA', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 9.0, NULL, false, '9.0', now()),
    (gen_random_uuid(), v_res_id, 2, 3.0, NULL, false, '3.0', now()),
    (gen_random_uuid(), v_res_id, 3, 92.0, 'BFD', true, '92.0 BFD', now()),
    (gen_random_uuid(), v_res_id, 4, 5.0, NULL, false, '5.0', now()),
    (gen_random_uuid(), v_res_id, 5, 28.0, NULL, false, '28.0', now()),
    (gen_random_uuid(), v_res_id, 6, 5.0, NULL, false, '5.0', now()),
    (gen_random_uuid(), v_res_id, 7, 21.0, NULL, false, '21.0', now());

  -- [Gold] Rank 11: Lyric Li (SGP 728)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lyric Li')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lyric Li', 'lyric-li-a3035d', '728', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '728' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 11, 169.0, 77.0, false, 'F', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 92.0, 'BFD', true, '92.0 BFD', now()),
    (gen_random_uuid(), v_res_id, 2, 13.0, NULL, false, '13.0', now()),
    (gen_random_uuid(), v_res_id, 3, 8.0, NULL, false, '8.0', now()),
    (gen_random_uuid(), v_res_id, 4, 3.0, NULL, false, '3.0', now()),
    (gen_random_uuid(), v_res_id, 5, 19.0, NULL, false, '19.0', now()),
    (gen_random_uuid(), v_res_id, 6, 23.0, NULL, false, '23.0', now()),
    (gen_random_uuid(), v_res_id, 7, 11.0, NULL, false, '11.0', now());

  -- [Gold] Rank 12: Jedd Lam (SGP 2000)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jedd Lam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jedd Lam', 'jedd-lam-f3c809', '2000', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2000' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 12, 109.0, 78.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 31.0, NULL, true, '31.0', now()),
    (gen_random_uuid(), v_res_id, 2, 11.0, NULL, false, '11.0', now()),
    (gen_random_uuid(), v_res_id, 3, 27.0, NULL, false, '27.0', now()),
    (gen_random_uuid(), v_res_id, 4, 18.0, NULL, false, '18.0', now()),
    (gen_random_uuid(), v_res_id, 5, 5.0, NULL, false, '5.0', now()),
    (gen_random_uuid(), v_res_id, 6, 2.0, NULL, false, '2.0', now()),
    (gen_random_uuid(), v_res_id, 7, 15.0, NULL, false, '15.0', now());

  -- [Gold] Rank 13: Kyle Jeremy Soh Zhi Jun (SGP 3183)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kyle Jeremy Soh Zhi Jun')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kyle Jeremy Soh Zhi Jun', 'kyle-jeremy-soh-zhi-jun-ed9286', '3183', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3183' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 13, 114.0, 81.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 24.0, NULL, false, '24.0', now()),
    (gen_random_uuid(), v_res_id, 2, 1.0, NULL, false, '1.0', now()),
    (gen_random_uuid(), v_res_id, 3, 11.0, NULL, false, '11.0', now()),
    (gen_random_uuid(), v_res_id, 4, 33.0, NULL, true, '33.0', now()),
    (gen_random_uuid(), v_res_id, 5, 11.0, NULL, false, '11.0', now()),
    (gen_random_uuid(), v_res_id, 6, 6.0, NULL, false, '6.0', now()),
    (gen_random_uuid(), v_res_id, 7, 28.0, NULL, false, '28.0', now());

  -- [Gold] Rank 14: Ashlyn Tham (SGP 100)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ashlyn Tham')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ashlyn Tham', 'ashlyn-tham-eb2687', '100', 'Others', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '100' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Others'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 14, 133.0, 90.0, false, 'F', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 4.0, NULL, false, '4.0', now()),
    (gen_random_uuid(), v_res_id, 2, 8.0, NULL, false, '8.0', now()),
    (gen_random_uuid(), v_res_id, 3, 31.0, NULL, false, '31.0', now()),
    (gen_random_uuid(), v_res_id, 4, 24.0, NULL, false, '24.0', now()),
    (gen_random_uuid(), v_res_id, 5, 4.0, NULL, false, '4.0', now()),
    (gen_random_uuid(), v_res_id, 6, 43.0, NULL, true, '43.0', now()),
    (gen_random_uuid(), v_res_id, 7, 19.0, NULL, false, '19.0', now());

  -- [Gold] Rank 15: Low Xi En Jaye (SGP 3279)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Low Xi En Jaye')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Low Xi En Jaye', 'low-xi-en-jaye-1d6cf9', '3279', 'Others', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3279' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Others'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 15, 129.0, 98.0, false, 'F', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 25.0, NULL, false, '25.0', now()),
    (gen_random_uuid(), v_res_id, 2, 6.0, NULL, false, '6.0', now()),
    (gen_random_uuid(), v_res_id, 3, 16.0, NULL, false, '16.0', now()),
    (gen_random_uuid(), v_res_id, 4, 9.0, NULL, false, '9.0', now()),
    (gen_random_uuid(), v_res_id, 5, 15.0, NULL, false, '15.0', now()),
    (gen_random_uuid(), v_res_id, 6, 27.0, NULL, false, '27.0', now()),
    (gen_random_uuid(), v_res_id, 7, 31.0, NULL, true, '31.0', now());

  -- [Gold] Rank 16: Huang Damien (SGP 3300)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Huang Damien')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Huang Damien', 'huang-damien-1a348e', '3300', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3300' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 16, 197.0, 105.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 92.0, 'BFD', true, '92.0 BFD', now()),
    (gen_random_uuid(), v_res_id, 2, 36.0, NULL, false, '36.0', now()),
    (gen_random_uuid(), v_res_id, 3, 7.0, NULL, false, '7.0', now()),
    (gen_random_uuid(), v_res_id, 4, 26.0, NULL, false, '26.0', now()),
    (gen_random_uuid(), v_res_id, 5, 14.0, NULL, false, '14.0', now()),
    (gen_random_uuid(), v_res_id, 6, 15.0, NULL, false, '15.0', now()),
    (gen_random_uuid(), v_res_id, 7, 7.0, NULL, false, '7.0', now());

  -- [Gold] Rank 17: Rahul Rajakanth (SGP 2006)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rahul Rajakanth')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rahul Rajakanth', 'rahul-rajakanth-2d35d5', '2006', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2006' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 17, 147.0, 108.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 7.0, NULL, false, '7.0', now()),
    (gen_random_uuid(), v_res_id, 2, 19.0, NULL, false, '19.0', now()),
    (gen_random_uuid(), v_res_id, 3, 12.0, NULL, false, '12.0', now()),
    (gen_random_uuid(), v_res_id, 4, 39.0, NULL, true, '39.0', now()),
    (gen_random_uuid(), v_res_id, 5, 31.0, NULL, false, '31.0', now()),
    (gen_random_uuid(), v_res_id, 6, 21.0, 'RDG', false, '21.0 RDG', now()),
    (gen_random_uuid(), v_res_id, 7, 18.0, NULL, false, '18.0', now());

  -- [Gold] Rank 18: Joshua Tan Zhi Kai (SGP 3036)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joshua Tan Zhi Kai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joshua Tan Zhi Kai', 'joshua-tan-zhi-kai-915506', '3036', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3036' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 18, 155.0, 112.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 20.0, NULL, false, '20.0', now()),
    (gen_random_uuid(), v_res_id, 2, 14.0, NULL, false, '14.0', now()),
    (gen_random_uuid(), v_res_id, 3, 26.0, NULL, false, '26.0', now()),
    (gen_random_uuid(), v_res_id, 4, 20.0, NULL, false, '20.0', now()),
    (gen_random_uuid(), v_res_id, 5, 25.0, NULL, false, '25.0', now()),
    (gen_random_uuid(), v_res_id, 6, 7.0, NULL, false, '7.0', now()),
    (gen_random_uuid(), v_res_id, 7, 43.0, NULL, true, '43.0', now());

  -- [Gold] Rank 19: Ong En Ze Elijah (SGP 140)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ong En Ze Elijah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ong En Ze Elijah', 'ong-en-ze-elijah-7b17ab', '140', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '140' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 19, 154.0, 115.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 22.0, NULL, false, '22.0', now()),
    (gen_random_uuid(), v_res_id, 2, 10.0, NULL, false, '10.0', now()),
    (gen_random_uuid(), v_res_id, 3, 39.0, NULL, true, '39.0', now()),
    (gen_random_uuid(), v_res_id, 4, 21.0, NULL, false, '21.0', now()),
    (gen_random_uuid(), v_res_id, 5, 27.0, NULL, false, '27.0', now()),
    (gen_random_uuid(), v_res_id, 6, 22.0, 'RDG', false, '22.0 RDG', now()),
    (gen_random_uuid(), v_res_id, 7, 13.0, NULL, false, '13.0', now());

  -- [Gold] Rank 20: Wong Jing Chen Nicole (SGP 3006)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Wong Jing Chen Nicole')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Wong Jing Chen Nicole', 'wong-jing-chen-nicole-6addf9', '3006', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3006' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 20, 156.0, 116.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 12.0, NULL, false, '12.0', now()),
    (gen_random_uuid(), v_res_id, 2, 22.0, NULL, false, '22.0', now()),
    (gen_random_uuid(), v_res_id, 3, 21.0, NULL, false, '21.0', now()),
    (gen_random_uuid(), v_res_id, 4, 40.0, NULL, true, '40.0', now()),
    (gen_random_uuid(), v_res_id, 5, 9.0, NULL, false, '9.0', now()),
    (gen_random_uuid(), v_res_id, 6, 36.0, NULL, false, '36.0', now()),
    (gen_random_uuid(), v_res_id, 7, 16.0, NULL, false, '16.0', now());

  -- [Gold] Rank 21: Ng Kai Zhe Timothy (SGP 2023)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ng Kai Zhe Timothy')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ng Kai Zhe Timothy', 'ng-kai-zhe-timothy-05db56', '2023', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2023' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 21, 153.0, 119.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 28.0, NULL, false, '28.0', now()),
    (gen_random_uuid(), v_res_id, 2, 26.0, NULL, false, '26.0', now()),
    (gen_random_uuid(), v_res_id, 3, 34.0, NULL, true, '34.0', now()),
    (gen_random_uuid(), v_res_id, 4, 22.0, NULL, false, '22.0', now()),
    (gen_random_uuid(), v_res_id, 5, 8.0, NULL, false, '8.0', now()),
    (gen_random_uuid(), v_res_id, 6, 3.0, NULL, false, '3.0', now()),
    (gen_random_uuid(), v_res_id, 7, 32.0, NULL, false, '32.0', now());

  -- [Gold] Rank 22: Rajakanth Padmaeja (SGP 2022)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rajakanth Padmaeja')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rajakanth Padmaeja', 'rajakanth-padmaeja-df3938', '2022', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2022' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 22, 163.0, 119.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 26.0, NULL, false, '26.0', now()),
    (gen_random_uuid(), v_res_id, 2, 9.0, NULL, false, '9.0', now()),
    (gen_random_uuid(), v_res_id, 3, 19.0, NULL, false, '19.0', now()),
    (gen_random_uuid(), v_res_id, 4, 44.0, NULL, true, '44.0', now()),
    (gen_random_uuid(), v_res_id, 5, 17.0, NULL, false, '17.0', now()),
    (gen_random_uuid(), v_res_id, 6, 18.0, NULL, false, '18.0', now()),
    (gen_random_uuid(), v_res_id, 7, 30.0, NULL, false, '30.0', now());

  -- [Gold] Rank 23: Jeremiah Ong (SGP 3373)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jeremiah Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jeremiah Ong', 'jeremiah-ong-cf7bf2', '3373', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3373' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 23, 162.2, 125.2, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 19.0, NULL, false, '19.0', now()),
    (gen_random_uuid(), v_res_id, 2, 37.0, NULL, true, '37.0', now()),
    (gen_random_uuid(), v_res_id, 3, 13.0, NULL, false, '13.0', now()),
    (gen_random_uuid(), v_res_id, 4, 31.0, NULL, false, '31.0', now()),
    (gen_random_uuid(), v_res_id, 5, 13.0, NULL, false, '13.0', now()),
    (gen_random_uuid(), v_res_id, 6, 23.2, 'RDG', false, '23.2 RDG', now()),
    (gen_random_uuid(), v_res_id, 7, 26.0, NULL, false, '26.0', now());

  -- [Gold] Rank 24: Joseph Tan (SGP 3688)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joseph Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joseph Tan', 'joseph-tan-79b6f0', '3688', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3688' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 24, 181.0, 128.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 35.0, NULL, false, '35.0', now()),
    (gen_random_uuid(), v_res_id, 2, 53.0, NULL, true, '53.0', now()),
    (gen_random_uuid(), v_res_id, 3, 22.0, NULL, false, '22.0', now()),
    (gen_random_uuid(), v_res_id, 4, 27.0, NULL, false, '27.0', now()),
    (gen_random_uuid(), v_res_id, 5, 18.0, NULL, false, '18.0', now()),
    (gen_random_uuid(), v_res_id, 6, 14.0, NULL, false, '14.0', now()),
    (gen_random_uuid(), v_res_id, 7, 12.0, NULL, false, '12.0', now());

  -- [Gold] Rank 25: Siti Ra'idah Binte Mohd Airudin (SGP 1141)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Siti Ra''idah Binte Mohd Airudin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Siti Ra''idah Binte Mohd Airudin', 'siti-ra-idah-binte-mohd-airudin-75f025', '1141', 'Others', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '1141' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Others'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 25, 176.0, 131.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 33.0, NULL, false, '33.0', now()),
    (gen_random_uuid(), v_res_id, 2, 44.0, NULL, false, '44.0', now()),
    (gen_random_uuid(), v_res_id, 3, 14.0, NULL, false, '14.0', now()),
    (gen_random_uuid(), v_res_id, 4, 8.0, NULL, false, '8.0', now()),
    (gen_random_uuid(), v_res_id, 5, 30.0, NULL, false, '30.0', now()),
    (gen_random_uuid(), v_res_id, 6, 45.0, NULL, true, '45.0', now()),
    (gen_random_uuid(), v_res_id, 7, 2.0, NULL, false, '2.0', now());

  -- [Gold] Rank 26: Dylan Goh Yue Teng (SGP 3800)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Dylan Goh Yue Teng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Dylan Goh Yue Teng', 'dylan-goh-yue-teng-53319a', '3800', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3800' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 26, 194.0, 141.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 32.0, NULL, false, '32.0', now()),
    (gen_random_uuid(), v_res_id, 2, 31.0, NULL, false, '31.0', now()),
    (gen_random_uuid(), v_res_id, 3, 29.0, NULL, false, '29.0', now()),
    (gen_random_uuid(), v_res_id, 4, 11.0, NULL, false, '11.0', now()),
    (gen_random_uuid(), v_res_id, 5, 26.0, NULL, false, '26.0', now()),
    (gen_random_uuid(), v_res_id, 6, 12.0, NULL, false, '12.0', now()),
    (gen_random_uuid(), v_res_id, 7, 53.0, NULL, true, '53.0', now());

  -- [Gold] Rank 27: Teo Rui Ling (SGP 3820)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Teo Rui Ling')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Teo Rui Ling', 'teo-rui-ling-0b45d1', '3820', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3820' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 27, 188.0, 145.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 21.0, NULL, false, '21.0', now()),
    (gen_random_uuid(), v_res_id, 2, 20.0, NULL, false, '20.0', now()),
    (gen_random_uuid(), v_res_id, 3, 43.0, NULL, true, '43.0', now()),
    (gen_random_uuid(), v_res_id, 4, 29.0, NULL, false, '29.0', now()),
    (gen_random_uuid(), v_res_id, 5, 36.0, NULL, false, '36.0', now()),
    (gen_random_uuid(), v_res_id, 6, 19.0, NULL, false, '19.0', now()),
    (gen_random_uuid(), v_res_id, 7, 20.0, NULL, false, '20.0', now());

  -- [Gold] Rank 28: Tan Herng Yee (SGP 3000)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tan Herng Yee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tan Herng Yee', 'tan-herng-yee-905a15', '3000', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3000' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 28, 239.0, 147.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 13.0, NULL, false, '13.0', now()),
    (gen_random_uuid(), v_res_id, 2, 17.0, NULL, false, '17.0', now()),
    (gen_random_uuid(), v_res_id, 3, 92.0, 'BFD', true, '92.0 BFD', now()),
    (gen_random_uuid(), v_res_id, 4, 34.0, NULL, false, '34.0', now()),
    (gen_random_uuid(), v_res_id, 5, 22.0, NULL, false, '22.0', now()),
    (gen_random_uuid(), v_res_id, 6, 22.0, NULL, false, '22.0', now()),
    (gen_random_uuid(), v_res_id, 7, 39.0, NULL, false, '39.0', now());

  -- [Gold] Rank 29: Shin Lin Chen Rui (SGP 3333)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Shin Lin Chen Rui')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Shin Lin Chen Rui', 'shin-lin-chen-rui-4e5a43', '3333', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3333' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 29, 251.0, 159.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 8.0, NULL, false, '8.0', now()),
    (gen_random_uuid(), v_res_id, 2, 23.0, NULL, false, '23.0', now()),
    (gen_random_uuid(), v_res_id, 3, 92.0, 'BFD', true, '92.0 BFD', now()),
    (gen_random_uuid(), v_res_id, 4, 49.0, NULL, false, '49.0', now()),
    (gen_random_uuid(), v_res_id, 5, 16.0, NULL, false, '16.0', now()),
    (gen_random_uuid(), v_res_id, 6, 38.0, NULL, false, '38.0', now()),
    (gen_random_uuid(), v_res_id, 7, 25.0, NULL, false, '25.0', now());

  -- [Gold] Rank 30: Ong En Xu Edrei (SGP 3957)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ong En Xu Edrei')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ong En Xu Edrei', 'ong-en-xu-edrei-5a0a67', '3957', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3957' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 30, 227.5, 166.5, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 61.0, NULL, true, '61.0', now()),
    (gen_random_uuid(), v_res_id, 2, 35.0, NULL, false, '35.0', now()),
    (gen_random_uuid(), v_res_id, 3, 28.0, NULL, false, '28.0', now()),
    (gen_random_uuid(), v_res_id, 4, 15.0, NULL, false, '15.0', now()),
    (gen_random_uuid(), v_res_id, 5, 33.0, NULL, false, '33.0', now()),
    (gen_random_uuid(), v_res_id, 6, 32.5, 'RDG', false, '32.5 RDG', now()),
    (gen_random_uuid(), v_res_id, 7, 23.0, NULL, false, '23.0', now());

  -- [Gold] Rank 31: Lee Kai En Katelynn (SGP 3383)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lee Kai En Katelynn')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lee Kai En Katelynn', 'lee-kai-en-katelynn-375d3f', '3383', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3383' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 31, 234.0, 169.0, false, 'F', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 17.0, NULL, false, '17.0', now()),
    (gen_random_uuid(), v_res_id, 2, 65.0, NULL, true, '65.0', now()),
    (gen_random_uuid(), v_res_id, 3, 35.0, NULL, false, '35.0', now()),
    (gen_random_uuid(), v_res_id, 4, 19.0, NULL, false, '19.0', now()),
    (gen_random_uuid(), v_res_id, 5, 52.0, NULL, false, '52.0', now()),
    (gen_random_uuid(), v_res_id, 6, 17.0, NULL, false, '17.0', now()),
    (gen_random_uuid(), v_res_id, 7, 29.0, NULL, false, '29.0', now());

  -- [Gold] Rank 32: George Chen Wangsun (MAC 20)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('George Chen Wangsun')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'George Chen Wangsun', 'george-chen-wangsun-86c7bc', '20', 'SAF Yacht Club', 'M', 'MAC', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '20' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'MAC'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 32, 266.0, 174.0, false, 'M', 2013, 'MAC', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 92.0, 'BFD', true, '92.0 BFD', now()),
    (gen_random_uuid(), v_res_id, 2, 18.0, NULL, false, '18.0', now()),
    (gen_random_uuid(), v_res_id, 3, 20.0, NULL, false, '20.0', now()),
    (gen_random_uuid(), v_res_id, 4, 92.0, 'BFD', false, '92.0 BFD', now()),
    (gen_random_uuid(), v_res_id, 5, 23.0, NULL, false, '23.0', now()),
    (gen_random_uuid(), v_res_id, 6, 4.0, NULL, false, '4.0', now()),
    (gen_random_uuid(), v_res_id, 7, 17.0, NULL, false, '17.0', now());

  -- [Gold] Rank 33: Tan En Ting Kirsten (SGP 3663)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tan En Ting Kirsten')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tan En Ting Kirsten', 'tan-en-ting-kirsten-261cde', '3663', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3663' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 33, 232.0, 175.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 15.0, NULL, false, '15.0', now()),
    (gen_random_uuid(), v_res_id, 2, 25.0, NULL, false, '25.0', now()),
    (gen_random_uuid(), v_res_id, 3, 49.0, NULL, false, '49.0', now()),
    (gen_random_uuid(), v_res_id, 4, 42.0, NULL, false, '42.0', now()),
    (gen_random_uuid(), v_res_id, 5, 35.0, NULL, false, '35.0', now()),
    (gen_random_uuid(), v_res_id, 6, 57.0, NULL, true, '57.0', now()),
    (gen_random_uuid(), v_res_id, 7, 9.0, NULL, false, '9.0', now());

  -- [Gold] Rank 34: Rachel Lim Qian Hui (SGP 3197)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rachel Lim Qian Hui')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rachel Lim Qian Hui', 'rachel-lim-qian-hui-2f835d', '3197', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3197' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 34, 267.0, 175.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 18.0, NULL, false, '18.0', now()),
    (gen_random_uuid(), v_res_id, 2, 30.0, NULL, false, '30.0', now()),
    (gen_random_uuid(), v_res_id, 3, 32.0, NULL, false, '32.0', now()),
    (gen_random_uuid(), v_res_id, 4, 32.0, NULL, false, '32.0', now()),
    (gen_random_uuid(), v_res_id, 5, 38.0, NULL, false, '38.0', now()),
    (gen_random_uuid(), v_res_id, 6, 25.0, NULL, false, '25.0', now()),
    (gen_random_uuid(), v_res_id, 7, 92.0, 'DSQ', true, '92.0 DSQ', now());

  -- [Gold] Rank 35: Kaelyn Dayna Soh Zhi Yi (SGP 3113)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kaelyn Dayna Soh Zhi Yi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kaelyn Dayna Soh Zhi Yi', 'kaelyn-dayna-soh-zhi-yi-8163d9', '3113', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3113' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 35, 224.0, 178.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 16.0, NULL, false, '16.0', now()),
    (gen_random_uuid(), v_res_id, 2, 27.0, NULL, false, '27.0', now()),
    (gen_random_uuid(), v_res_id, 3, 46.0, NULL, true, '46.0', now()),
    (gen_random_uuid(), v_res_id, 4, 23.0, NULL, false, '23.0', now()),
    (gen_random_uuid(), v_res_id, 5, 45.0, NULL, false, '45.0', now()),
    (gen_random_uuid(), v_res_id, 6, 33.0, NULL, false, '33.0', now()),
    (gen_random_uuid(), v_res_id, 7, 34.0, NULL, false, '34.0', now());

  -- [Gold] Rank 36: Joel Khoo (SGP 4730)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joel Khoo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joel Khoo', 'joel-khoo-b7924a', '4730', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4730' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 36, 270.0, 192.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 23.0, NULL, false, '23.0', now()),
    (gen_random_uuid(), v_res_id, 2, 28.0, NULL, false, '28.0', now()),
    (gen_random_uuid(), v_res_id, 3, 78.0, NULL, true, '78.0', now()),
    (gen_random_uuid(), v_res_id, 4, 56.0, NULL, false, '56.0', now()),
    (gen_random_uuid(), v_res_id, 5, 29.0, NULL, false, '29.0', now()),
    (gen_random_uuid(), v_res_id, 6, 9.0, NULL, false, '9.0', now()),
    (gen_random_uuid(), v_res_id, 7, 47.0, NULL, false, '47.0', now());

  -- [Gold] Rank 37: Lim Yuk Pin (SGP 3880)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lim Yuk Pin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lim Yuk Pin', 'lim-yuk-pin-423229', '3880', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3880' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 37, 258.0, 204.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 39.0, NULL, false, '39.0', now()),
    (gen_random_uuid(), v_res_id, 2, 34.0, NULL, false, '34.0', now()),
    (gen_random_uuid(), v_res_id, 3, 33.0, NULL, false, '33.0', now()),
    (gen_random_uuid(), v_res_id, 4, 41.0, NULL, false, '41.0', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, NULL, true, '54.0', now()),
    (gen_random_uuid(), v_res_id, 6, 16.0, NULL, false, '16.0', now()),
    (gen_random_uuid(), v_res_id, 7, 41.0, NULL, false, '41.0', now());

  -- [Gold] Rank 38: Chiang Zhiyi Aaron (SGP 3128)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Chiang Zhiyi Aaron')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Chiang Zhiyi Aaron', 'chiang-zhiyi-aaron-6f28a5', '3128', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3128' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 38, 302.0, 210.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 92.0, 'BFD', true, '92.0 BFD', now()),
    (gen_random_uuid(), v_res_id, 2, 32.0, NULL, false, '32.0', now()),
    (gen_random_uuid(), v_res_id, 3, 40.0, NULL, false, '40.0', now()),
    (gen_random_uuid(), v_res_id, 4, 14.0, NULL, false, '14.0', now()),
    (gen_random_uuid(), v_res_id, 5, 49.0, NULL, false, '49.0', now()),
    (gen_random_uuid(), v_res_id, 6, 51.0, NULL, false, '51.0', now()),
    (gen_random_uuid(), v_res_id, 7, 24.0, NULL, false, '24.0', now());

  -- [Gold] Rank 39: Rui Xuan Lavene Lim (SGP 3553)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rui Xuan Lavene Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rui Xuan Lavene Lim', 'rui-xuan-lavene-lim-6d8113', '3553', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3553' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 39, 262.0, 210.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 36.0, NULL, false, '36.0', now()),
    (gen_random_uuid(), v_res_id, 2, 52.0, NULL, true, '52.0', now()),
    (gen_random_uuid(), v_res_id, 3, 36.0, NULL, false, '36.0', now()),
    (gen_random_uuid(), v_res_id, 4, 30.0, NULL, false, '30.0', now()),
    (gen_random_uuid(), v_res_id, 5, 44.0, NULL, false, '44.0', now()),
    (gen_random_uuid(), v_res_id, 6, 20.0, NULL, false, '20.0', now()),
    (gen_random_uuid(), v_res_id, 7, 44.0, NULL, false, '44.0', now());

  -- [Gold] Rank 40: Olivia Cheong Ting Jia (SGP 3002)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Olivia Cheong Ting Jia')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Olivia Cheong Ting Jia', 'olivia-cheong-ting-jia-33c456', '3002', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3002' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 40, 281.0, 212.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 38.0, NULL, false, '38.0', now()),
    (gen_random_uuid(), v_res_id, 2, 21.0, NULL, false, '21.0', now()),
    (gen_random_uuid(), v_res_id, 3, 69.0, NULL, true, '69.0', now()),
    (gen_random_uuid(), v_res_id, 4, 17.0, NULL, false, '17.0', now()),
    (gen_random_uuid(), v_res_id, 5, 40.0, NULL, false, '40.0', now()),
    (gen_random_uuid(), v_res_id, 6, 54.0, NULL, false, '54.0', now()),
    (gen_random_uuid(), v_res_id, 7, 42.0, NULL, false, '42.0', now());

  -- [Gold] Rank 41: Qi Tan (SGP 3026)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Qi Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Qi Tan', 'qi-tan-efeb14', '3026', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3026' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 41, 265.0, 213.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 37.0, NULL, false, '37.0', now()),
    (gen_random_uuid(), v_res_id, 2, 42.0, NULL, false, '42.0', now()),
    (gen_random_uuid(), v_res_id, 3, 18.0, NULL, false, '18.0', now()),
    (gen_random_uuid(), v_res_id, 4, 36.0, NULL, false, '36.0', now()),
    (gen_random_uuid(), v_res_id, 5, 43.0, NULL, false, '43.0', now()),
    (gen_random_uuid(), v_res_id, 6, 52.0, NULL, true, '52.0', now()),
    (gen_random_uuid(), v_res_id, 7, 37.0, NULL, false, '37.0', now());

  -- [Gold] Rank 42: Yvette Chow Yi Min (SGP 3151)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yvette Chow Yi Min')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yvette Chow Yi Min', 'yvette-chow-yi-min-87c512', '3151', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3151' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 42, 276.0, 217.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 30.0, NULL, false, '30.0', now()),
    (gen_random_uuid(), v_res_id, 2, 45.0, NULL, false, '45.0', now()),
    (gen_random_uuid(), v_res_id, 3, 17.0, NULL, false, '17.0', now()),
    (gen_random_uuid(), v_res_id, 4, 59.0, NULL, true, '59.0', now()),
    (gen_random_uuid(), v_res_id, 5, 48.0, NULL, false, '48.0', now()),
    (gen_random_uuid(), v_res_id, 6, 29.0, NULL, false, '29.0', now()),
    (gen_random_uuid(), v_res_id, 7, 48.0, NULL, false, '48.0', now());

  -- [Gold] Rank 43: Dan Toh (SGP 3811)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Dan Toh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Dan Toh', 'dan-toh-2abcde', '3811', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3811' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 43, 289.0, 229.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 40.0, NULL, false, '40.0', now()),
    (gen_random_uuid(), v_res_id, 2, 41.0, NULL, false, '41.0', now()),
    (gen_random_uuid(), v_res_id, 3, 42.0, NULL, false, '42.0', now()),
    (gen_random_uuid(), v_res_id, 4, 12.0, NULL, false, '12.0', now()),
    (gen_random_uuid(), v_res_id, 5, 39.0, NULL, false, '39.0', now()),
    (gen_random_uuid(), v_res_id, 6, 60.0, NULL, true, '60.0', now()),
    (gen_random_uuid(), v_res_id, 7, 55.0, NULL, false, '55.0', now());

  -- [Gold] Rank 44: Chen Yan Ying (Abby) (SGP 4729)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Chen Yan Ying (Abby)')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Chen Yan Ying (Abby)', 'chen-yan-ying-abby-fdc201', '4729', 'Others', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4729' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Others'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 44, 324.0, 232.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 60.0, NULL, false, '60.0', now()),
    (gen_random_uuid(), v_res_id, 2, 43.0, NULL, false, '43.0', now()),
    (gen_random_uuid(), v_res_id, 3, 24.0, NULL, false, '24.0', now()),
    (gen_random_uuid(), v_res_id, 4, 25.0, NULL, false, '25.0', now()),
    (gen_random_uuid(), v_res_id, 5, 50.0, NULL, false, '50.0', now()),
    (gen_random_uuid(), v_res_id, 6, 30.0, NULL, false, '30.0', now()),
    (gen_random_uuid(), v_res_id, 7, 92.0, 'DNF', true, '92.0 DNF', now());

  -- [Gold] Rank 45: Low Quintan Rupert (SGP 4681)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Low Quintan Rupert')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Low Quintan Rupert', 'low-quintan-rupert-5fcd8e', '4681', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4681' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 45, 307.0, 248.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 59.0, NULL, true, '59.0', now()),
    (gen_random_uuid(), v_res_id, 2, 49.0, NULL, false, '49.0', now()),
    (gen_random_uuid(), v_res_id, 3, 54.0, NULL, false, '54.0', now()),
    (gen_random_uuid(), v_res_id, 4, 38.0, NULL, false, '38.0', now()),
    (gen_random_uuid(), v_res_id, 5, 32.0, NULL, false, '32.0', now()),
    (gen_random_uuid(), v_res_id, 6, 48.0, NULL, false, '48.0', now()),
    (gen_random_uuid(), v_res_id, 7, 27.0, NULL, false, '27.0', now());

  -- [Gold] Rank 46: Loh Yi Jie Luke (SGP 3322)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Loh Yi Jie Luke')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Loh Yi Jie Luke', 'loh-yi-jie-luke-92d6be', '3322', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3322' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 46, 309.0, 250.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 29.0, NULL, false, '29.0', now()),
    (gen_random_uuid(), v_res_id, 2, 56.0, NULL, false, '56.0', now()),
    (gen_random_uuid(), v_res_id, 3, 47.0, NULL, false, '47.0', now()),
    (gen_random_uuid(), v_res_id, 4, 28.0, NULL, false, '28.0', now()),
    (gen_random_uuid(), v_res_id, 5, 34.0, NULL, false, '34.0', now()),
    (gen_random_uuid(), v_res_id, 6, 56.0, NULL, false, '56.0', now()),
    (gen_random_uuid(), v_res_id, 7, 59.0, NULL, true, '59.0', now());

  -- [Gold] Rank 47: Jayden Zhang (CHN 5705)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jayden Zhang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jayden Zhang', 'jayden-zhang-d0e9c7', '5705', 'Wuxi Schonst Sailing Club', 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '5705' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Wuxi Schonst Sailing Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 47, 310.0, 250.0, false, 'M', 2015, 'CHN', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 43.0, NULL, false, '43.0', now()),
    (gen_random_uuid(), v_res_id, 2, 60.0, NULL, true, '60.0', now()),
    (gen_random_uuid(), v_res_id, 3, 44.0, NULL, false, '44.0', now()),
    (gen_random_uuid(), v_res_id, 4, 47.0, NULL, false, '47.0', now()),
    (gen_random_uuid(), v_res_id, 5, 46.0, NULL, false, '46.0', now()),
    (gen_random_uuid(), v_res_id, 6, 37.0, NULL, false, '37.0', now()),
    (gen_random_uuid(), v_res_id, 7, 33.0, NULL, false, '33.0', now());

  -- [Gold] Rank 48: Mikaela Hui Ting Wong (SGP 3029)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mikaela Hui Ting Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mikaela Hui Ting Wong', 'mikaela-hui-ting-wong-abbcba', '3029', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3029' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 48, 327.0, 251.0, false, 'F', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 27.0, NULL, false, '27.0', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, NULL, false, '59.0', now()),
    (gen_random_uuid(), v_res_id, 3, 30.0, NULL, false, '30.0', now()),
    (gen_random_uuid(), v_res_id, 4, 76.0, NULL, true, '76.0', now()),
    (gen_random_uuid(), v_res_id, 5, 41.0, NULL, false, '41.0', now()),
    (gen_random_uuid(), v_res_id, 6, 40.0, NULL, false, '40.0', now()),
    (gen_random_uuid(), v_res_id, 7, 54.0, NULL, false, '54.0', now());

  -- [Gold] Rank 49: Aidan Armand Anuar (SGP 3143)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aidan Armand Anuar')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aidan Armand Anuar', 'aidan-armand-anuar-a6820f', '3143', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3143' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 49, 320.0, 260.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 48.0, NULL, false, '48.0', now()),
    (gen_random_uuid(), v_res_id, 2, 40.0, NULL, false, '40.0', now()),
    (gen_random_uuid(), v_res_id, 3, 52.0, NULL, false, '52.0', now()),
    (gen_random_uuid(), v_res_id, 4, 37.0, NULL, false, '37.0', now()),
    (gen_random_uuid(), v_res_id, 5, 55.0, NULL, false, '55.0', now()),
    (gen_random_uuid(), v_res_id, 6, 28.0, NULL, false, '28.0', now()),
    (gen_random_uuid(), v_res_id, 7, 60.0, NULL, true, '60.0', now());

  -- [Gold] Rank 50: Charlene Yong Heng Ning (SGP 766)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Charlene Yong Heng Ning')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Charlene Yong Heng Ning', 'charlene-yong-heng-ning-9289a6', '766', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '766' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 50, 330.0, 266.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 50.0, NULL, false, '50.0', now()),
    (gen_random_uuid(), v_res_id, 2, 64.0, NULL, true, '64.0', now()),
    (gen_random_uuid(), v_res_id, 3, 53.0, NULL, false, '53.0', now()),
    (gen_random_uuid(), v_res_id, 4, 57.0, NULL, false, '57.0', now()),
    (gen_random_uuid(), v_res_id, 5, 24.0, NULL, false, '24.0', now()),
    (gen_random_uuid(), v_res_id, 6, 21.0, NULL, false, '21.0', now()),
    (gen_random_uuid(), v_res_id, 7, 61.0, NULL, false, '61.0', now());

  -- [Gold] Rank 51: Meera Srihari (SGP 3889)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Meera Srihari')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Meera Srihari', 'meera-srihari-7766b6', '3889', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3889' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 51, 332.0, 274.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 34.0, NULL, false, '34.0', now()),
    (gen_random_uuid(), v_res_id, 2, 54.0, NULL, false, '54.0', now()),
    (gen_random_uuid(), v_res_id, 3, 45.0, NULL, false, '45.0', now()),
    (gen_random_uuid(), v_res_id, 4, 48.0, NULL, false, '48.0', now()),
    (gen_random_uuid(), v_res_id, 5, 58.0, NULL, true, '58.0', now()),
    (gen_random_uuid(), v_res_id, 6, 58.0, NULL, false, '58.0', now()),
    (gen_random_uuid(), v_res_id, 7, 35.0, NULL, false, '35.0', now());

  -- [Gold] Rank 52: Soh Christopher (SGP 3168)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Soh Christopher')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Soh Christopher', 'soh-christopher-1f9ac2', '3168', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3168' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 52, 349.0, 283.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 41.0, NULL, false, '41.0', now()),
    (gen_random_uuid(), v_res_id, 2, 47.0, NULL, false, '47.0', now()),
    (gen_random_uuid(), v_res_id, 3, 37.0, NULL, false, '37.0', now()),
    (gen_random_uuid(), v_res_id, 4, 50.0, NULL, false, '50.0', now()),
    (gen_random_uuid(), v_res_id, 5, 61.0, NULL, false, '61.0', now()),
    (gen_random_uuid(), v_res_id, 6, 47.0, NULL, false, '47.0', now()),
    (gen_random_uuid(), v_res_id, 7, 66.0, NULL, true, '66.0', now());

  -- [Gold] Rank 53: Tan Kyan Chun Hong (SGP 3712)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tan Kyan Chun Hong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tan Kyan Chun Hong', 'tan-kyan-chun-hong-bfc753', '3712', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3712' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 53, 377.0, 285.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 47.0, NULL, false, '47.0', now()),
    (gen_random_uuid(), v_res_id, 2, 48.0, NULL, false, '48.0', now()),
    (gen_random_uuid(), v_res_id, 3, 23.0, NULL, false, '23.0', now()),
    (gen_random_uuid(), v_res_id, 4, 51.0, NULL, false, '51.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 64.0, NULL, false, '64.0', now()),
    (gen_random_uuid(), v_res_id, 7, 52.0, NULL, false, '52.0', now());

  -- [Gold] Rank 54: Ouyang Hanyue (SGP 5003)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ouyang Hanyue')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ouyang Hanyue', 'ouyang-hanyue-9fee8e', '5003', 'One Degree 15', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '5003' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'One Degree 15'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 54, 404.0, 312.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 54.0, NULL, false, '54.0', now()),
    (gen_random_uuid(), v_res_id, 2, 39.0, NULL, false, '39.0', now()),
    (gen_random_uuid(), v_res_id, 3, 38.0, NULL, false, '38.0', now()),
    (gen_random_uuid(), v_res_id, 4, 71.0, NULL, false, '71.0', now()),
    (gen_random_uuid(), v_res_id, 5, 42.0, NULL, false, '42.0', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 7, 68.0, NULL, false, '68.0', now());

  -- [Gold] Rank 55: Jude Nathan Wong (SGP 3495)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jude Nathan Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jude Nathan Wong', 'jude-nathan-wong-8736da', '3495', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3495' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 55, 392.0, 320.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 49.0, NULL, false, '49.0', now()),
    (gen_random_uuid(), v_res_id, 2, 55.0, NULL, false, '55.0', now()),
    (gen_random_uuid(), v_res_id, 3, 51.0, NULL, false, '51.0', now()),
    (gen_random_uuid(), v_res_id, 4, 54.0, NULL, false, '54.0', now()),
    (gen_random_uuid(), v_res_id, 5, 56.0, NULL, false, '56.0', now()),
    (gen_random_uuid(), v_res_id, 6, 55.0, NULL, false, '55.0', now()),
    (gen_random_uuid(), v_res_id, 7, 72.0, NULL, true, '72.0', now());

  -- [Gold] Rank 56: Mao Wei Han (SGP 3619)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mao Wei Han')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mao Wei Han', 'mao-wei-han-d57ff6', '3619', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3619' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 56, 391.0, 325.0, false, 'F', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 52.0, NULL, false, '52.0', now()),
    (gen_random_uuid(), v_res_id, 2, 63.0, NULL, false, '63.0', now()),
    (gen_random_uuid(), v_res_id, 3, 56.0, NULL, false, '56.0', now()),
    (gen_random_uuid(), v_res_id, 4, 66.0, NULL, true, '66.0', now()),
    (gen_random_uuid(), v_res_id, 5, 51.0, NULL, false, '51.0', now()),
    (gen_random_uuid(), v_res_id, 6, 41.0, NULL, false, '41.0', now()),
    (gen_random_uuid(), v_res_id, 7, 62.0, NULL, false, '62.0', now());

  -- [Gold] Rank 57: Isabelle Zhang (SGP 2035)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isabelle Zhang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isabelle Zhang', 'isabelle-zhang-f782cc', '2035', 'Constant Wind', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2035' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 57, 419.0, 327.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 45.0, NULL, false, '45.0', now()),
    (gen_random_uuid(), v_res_id, 2, 51.0, NULL, false, '51.0', now()),
    (gen_random_uuid(), v_res_id, 3, 60.0, NULL, false, '60.0', now()),
    (gen_random_uuid(), v_res_id, 4, 45.0, NULL, false, '45.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 34.0, NULL, false, '34.0', now()),
    (gen_random_uuid(), v_res_id, 7, 92.0, 'DNF', false, '92.0 DNF', now());

  -- [Gold] Rank 58: Teh Ashleigh Li Ying (SGP 788)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Teh Ashleigh Li Ying')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Teh Ashleigh Li Ying', 'teh-ashleigh-li-ying-86872e', '788', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '788' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 58, 402.0, 328.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 56.0, NULL, false, '56.0', now()),
    (gen_random_uuid(), v_res_id, 2, 62.0, NULL, false, '62.0', now()),
    (gen_random_uuid(), v_res_id, 3, 62.0, NULL, false, '62.0', now()),
    (gen_random_uuid(), v_res_id, 4, 74.0, NULL, true, '74.0', now()),
    (gen_random_uuid(), v_res_id, 5, 37.0, NULL, false, '37.0', now()),
    (gen_random_uuid(), v_res_id, 6, 65.0, NULL, false, '65.0', now()),
    (gen_random_uuid(), v_res_id, 7, 46.0, NULL, false, '46.0', now());

  -- [Gold] Rank 59: Lee Kai Lun Matthias (SGP 3385)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lee Kai Lun Matthias')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lee Kai Lun Matthias', 'lee-kai-lun-matthias-102ca5', '3385', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3385' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 59, 423.0, 331.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 65.0, NULL, false, '65.0', now()),
    (gen_random_uuid(), v_res_id, 2, 57.0, NULL, false, '57.0', now()),
    (gen_random_uuid(), v_res_id, 3, 57.0, NULL, false, '57.0', now()),
    (gen_random_uuid(), v_res_id, 4, 46.0, NULL, false, '46.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 49.0, NULL, false, '49.0', now()),
    (gen_random_uuid(), v_res_id, 7, 57.0, NULL, false, '57.0', now());

  -- [Gold] Rank 60: Tan Huan Zhe Kenji (SGP 3999)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tan Huan Zhe Kenji')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tan Huan Zhe Kenji', 'tan-huan-zhe-kenji-6f90ab', '3999', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3999' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 60, 429.0, 337.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 46.0, NULL, false, '46.0', now()),
    (gen_random_uuid(), v_res_id, 2, 66.0, NULL, false, '66.0', now()),
    (gen_random_uuid(), v_res_id, 3, 61.0, NULL, false, '61.0', now()),
    (gen_random_uuid(), v_res_id, 4, 62.0, NULL, false, '62.0', now()),
    (gen_random_uuid(), v_res_id, 5, 62.0, NULL, false, '62.0', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 7, 40.0, NULL, false, '40.0', now());

  -- [Gold] Rank 61: Seow Jun Sheng Lucas (SGP 2047)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Seow Jun Sheng Lucas')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Seow Jun Sheng Lucas', 'seow-jun-sheng-lucas-6aa0a9', '2047', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2047' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 61, 405.0, 338.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 62.0, NULL, false, '62.0', now()),
    (gen_random_uuid(), v_res_id, 2, 67.0, NULL, true, '67.0', now()),
    (gen_random_uuid(), v_res_id, 3, 50.0, NULL, false, '50.0', now()),
    (gen_random_uuid(), v_res_id, 4, 61.0, NULL, false, '61.0', now()),
    (gen_random_uuid(), v_res_id, 5, 57.0, NULL, false, '57.0', now()),
    (gen_random_uuid(), v_res_id, 6, 50.0, NULL, false, '50.0', now()),
    (gen_random_uuid(), v_res_id, 7, 58.0, NULL, false, '58.0', now());

  -- [Gold] Rank 62: Tan Kai En Hayley (SGP 700)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tan Kai En Hayley')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tan Kai En Hayley', 'tan-kai-en-hayley-41af41', '700', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '700' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 62, 431.0, 339.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 44.0, NULL, false, '44.0', now()),
    (gen_random_uuid(), v_res_id, 2, 68.0, NULL, false, '68.0', now()),
    (gen_random_uuid(), v_res_id, 3, 71.0, NULL, false, '71.0', now()),
    (gen_random_uuid(), v_res_id, 4, 55.0, NULL, false, '55.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 63.0, NULL, false, '63.0', now()),
    (gen_random_uuid(), v_res_id, 7, 38.0, NULL, false, '38.0', now());

  -- [Gold] Rank 63: Tyler Koo (SGP 996)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tyler Koo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tyler Koo', 'tyler-koo-9fe93d', '996', 'Republic of Singapore Yacht Cub', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '996' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Republic of Singapore Yacht Cub'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 63, 434.0, 342.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 53.0, NULL, false, '53.0', now()),
    (gen_random_uuid(), v_res_id, 2, 33.0, NULL, false, '33.0', now()),
    (gen_random_uuid(), v_res_id, 3, 58.0, NULL, false, '58.0', now()),
    (gen_random_uuid(), v_res_id, 4, 43.0, NULL, false, '43.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'DNF', false, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 7, 63.0, NULL, false, '63.0', now());

  -- [Gold] Rank 64: Poh Hao Xuan Euan (SGP 2030)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Poh Hao Xuan Euan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Poh Hao Xuan Euan', 'poh-hao-xuan-euan-fd642b', '2030', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2030' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 64, 436.0, 344.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 63.0, NULL, false, '63.0', now()),
    (gen_random_uuid(), v_res_id, 2, 58.0, NULL, false, '58.0', now()),
    (gen_random_uuid(), v_res_id, 3, 67.0, NULL, false, '67.0', now()),
    (gen_random_uuid(), v_res_id, 4, 58.0, NULL, false, '58.0', now()),
    (gen_random_uuid(), v_res_id, 5, 53.0, NULL, false, '53.0', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 7, 45.0, NULL, false, '45.0', now());

  -- [Gold] Rank 65: Xavier Puah Yang Zheng (SGP 2037)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Xavier Puah Yang Zheng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Xavier Puah Yang Zheng', 'xavier-puah-yang-zheng-32c010', '2037', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2037' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 65, 443.0, 351.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 51.0, NULL, false, '51.0', now()),
    (gen_random_uuid(), v_res_id, 2, 72.0, NULL, false, '72.0', now()),
    (gen_random_uuid(), v_res_id, 3, 59.0, NULL, false, '59.0', now()),
    (gen_random_uuid(), v_res_id, 4, 60.0, NULL, false, '60.0', now()),
    (gen_random_uuid(), v_res_id, 5, 59.0, NULL, false, '59.0', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 7, 50.0, NULL, false, '50.0', now());

  -- [Gold] Rank 66: Kai Chen-Yi (SGP 757)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kai Chen-Yi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kai Chen-Yi', 'kai-chen-yi-e55cf4', '757', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '757' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 66, 451.0, 359.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 57.0, NULL, false, '57.0', now()),
    (gen_random_uuid(), v_res_id, 2, 77.0, NULL, false, '77.0', now()),
    (gen_random_uuid(), v_res_id, 3, 25.0, NULL, false, '25.0', now()),
    (gen_random_uuid(), v_res_id, 4, 69.0, NULL, false, '69.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 39.0, NULL, false, '39.0', now()),
    (gen_random_uuid(), v_res_id, 7, 92.0, 'DNF', false, '92.0 DNF', now());

  -- [Gold] Rank 67: Tan Ethan Jing Zhou (SGP 3772)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tan Ethan Jing Zhou')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tan Ethan Jing Zhou', 'tan-ethan-jing-zhou-24ec8f', '3772', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3772' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 67, 438.0, 364.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 74.0, NULL, true, '74.0', now()),
    (gen_random_uuid(), v_res_id, 2, 71.0, NULL, false, '71.0', now()),
    (gen_random_uuid(), v_res_id, 3, 55.0, NULL, false, '55.0', now()),
    (gen_random_uuid(), v_res_id, 4, 72.0, NULL, false, '72.0', now()),
    (gen_random_uuid(), v_res_id, 5, 60.0, NULL, false, '60.0', now()),
    (gen_random_uuid(), v_res_id, 6, 42.0, NULL, false, '42.0', now()),
    (gen_random_uuid(), v_res_id, 7, 64.0, NULL, false, '64.0', now());

  -- [Gold] Rank 68: Kai Yen-Yu (SGP 758)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kai Yen-Yu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kai Yen-Yu', 'kai-yen-yu-06849f', '758', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '758' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 68, 461.0, 369.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 64.0, NULL, false, '64.0', now()),
    (gen_random_uuid(), v_res_id, 2, 38.0, NULL, false, '38.0', now()),
    (gen_random_uuid(), v_res_id, 3, 48.0, NULL, false, '48.0', now()),
    (gen_random_uuid(), v_res_id, 4, 35.0, NULL, false, '35.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'DNF', false, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 7, 92.0, 'DNF', false, '92.0 DNF', now());

  -- [Gold] Rank 69: Iver Lee (SGP 3309)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Iver Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Iver Lee', 'iver-lee-11d7ea', '3309', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3309' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 69, 473.0, 381.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 58.0, NULL, false, '58.0', now()),
    (gen_random_uuid(), v_res_id, 2, 50.0, NULL, false, '50.0', now()),
    (gen_random_uuid(), v_res_id, 3, 77.0, NULL, false, '77.0', now()),
    (gen_random_uuid(), v_res_id, 4, 64.0, NULL, false, '64.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 61.0, NULL, false, '61.0', now()),
    (gen_random_uuid(), v_res_id, 7, 71.0, NULL, false, '71.0', now());

  -- [Gold] Rank 70: Low Zachary Zhi En (SGP 3369)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Low Zachary Zhi En')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Low Zachary Zhi En', 'low-zachary-zhi-en-1c48a5', '3369', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3369' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 70, 488.0, 396.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 80.0, NULL, false, '80.0', now()),
    (gen_random_uuid(), v_res_id, 2, 82.0, NULL, false, '82.0', now()),
    (gen_random_uuid(), v_res_id, 3, 80.0, NULL, false, '80.0', now()),
    (gen_random_uuid(), v_res_id, 4, 52.0, NULL, false, '52.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'RET', true, '92.0 RET', now()),
    (gen_random_uuid(), v_res_id, 6, 66.0, NULL, false, '66.0', now()),
    (gen_random_uuid(), v_res_id, 7, 36.0, NULL, false, '36.0', now());

  -- [Gold] Rank 71: Nigel Ng Jiang Long (SGP 3363)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nigel Ng Jiang Long')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nigel Ng Jiang Long', 'nigel-ng-jiang-long-25737b', '3363', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3363' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 71, 490.0, 398.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 55.0, NULL, false, '55.0', now()),
    (gen_random_uuid(), v_res_id, 2, 61.0, NULL, false, '61.0', now()),
    (gen_random_uuid(), v_res_id, 3, 41.0, NULL, false, '41.0', now()),
    (gen_random_uuid(), v_res_id, 4, 75.0, NULL, false, '75.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'DNF', false, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 7, 74.0, NULL, false, '74.0', now());

  -- [Gold] Rank 72: Chiam Matthew Qin Hao (SGP 3606)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Chiam Matthew Qin Hao')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Chiam Matthew Qin Hao', 'chiam-matthew-qin-hao-80d684', '3606', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3606' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 72, 530.0, 438.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 92.0, 'DNC', true, '92.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 2, 92.0, 'DNC', false, '92.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 3, 92.0, 'DNC', false, '92.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 4, 92.0, 'DNC', false, '92.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 5, 47.0, NULL, false, '47.0', now()),
    (gen_random_uuid(), v_res_id, 6, 59.0, NULL, false, '59.0', now()),
    (gen_random_uuid(), v_res_id, 7, 56.0, NULL, false, '56.0', now());

  -- [Gold] Rank 73: Gloria Kwok Yen Rui (SGP 2004)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gloria Kwok Yen Rui')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gloria Kwok Yen Rui', 'gloria-kwok-yen-rui-7d8a8c', '2004', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2004' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 73, 533.0, 441.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 71.0, NULL, false, '71.0', now()),
    (gen_random_uuid(), v_res_id, 2, 78.0, NULL, false, '78.0', now()),
    (gen_random_uuid(), v_res_id, 3, 65.0, NULL, false, '65.0', now()),
    (gen_random_uuid(), v_res_id, 4, 73.0, NULL, false, '73.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 62.0, NULL, false, '62.0', now()),
    (gen_random_uuid(), v_res_id, 7, 92.0, 'DNF', false, '92.0 DNF', now());

  -- [Gold] Rank 74: Teo Kai Jie (SGP 3550)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Teo Kai Jie')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Teo Kai Jie', 'teo-kai-jie-b954d9', '3550', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3550' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 74, 543.0, 451.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 70.0, NULL, false, '70.0', now()),
    (gen_random_uuid(), v_res_id, 2, 46.0, NULL, false, '46.0', now()),
    (gen_random_uuid(), v_res_id, 3, 85.0, NULL, false, '85.0', now()),
    (gen_random_uuid(), v_res_id, 4, 85.0, NULL, false, '85.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'DNF', false, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 7, 73.0, NULL, false, '73.0', now());

  -- [Gold] Rank 75: Ryan Choo Yong Jie (SGP 789)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ryan Choo Yong Jie')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ryan Choo Yong Jie', 'ryan-choo-yong-jie-9e19d9', '789', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '789' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 75, 545.0, 453.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 73.0, NULL, false, '73.0', now()),
    (gen_random_uuid(), v_res_id, 2, 73.0, NULL, false, '73.0', now()),
    (gen_random_uuid(), v_res_id, 3, 70.0, NULL, false, '70.0', now()),
    (gen_random_uuid(), v_res_id, 4, 53.0, NULL, false, '53.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'NSC', false, '92.0 NSC', now()),
    (gen_random_uuid(), v_res_id, 7, 92.0, 'DNF', false, '92.0 DNF', now());

  -- [Gold] Rank 76: Yasin Yusuf Yusfianshah (SGP 3575)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yasin Yusuf Yusfianshah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yasin Yusuf Yusfianshah', 'yasin-yusuf-yusfianshah-4a7e5d', '3575', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3575' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 76, 550.0, 458.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 42.0, NULL, false, '42.0', now()),
    (gen_random_uuid(), v_res_id, 2, 86.0, NULL, false, '86.0', now()),
    (gen_random_uuid(), v_res_id, 3, 66.0, NULL, false, '66.0', now()),
    (gen_random_uuid(), v_res_id, 4, 80.0, NULL, false, '80.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'NSC', false, '92.0 NSC', now()),
    (gen_random_uuid(), v_res_id, 7, 92.0, 'DNF', false, '92.0 DNF', now());

  -- [Gold] Rank 77: Sage Yeh (SGP 796)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sage Yeh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sage Yeh', 'sage-yeh-dfe2f3', '796', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '796' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 77, 555.0, 463.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 69.0, NULL, false, '69.0', now()),
    (gen_random_uuid(), v_res_id, 2, 70.0, NULL, false, '70.0', now()),
    (gen_random_uuid(), v_res_id, 3, 72.0, NULL, false, '72.0', now()),
    (gen_random_uuid(), v_res_id, 4, 68.0, NULL, false, '68.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'DNF', false, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 7, 92.0, 'DNF', false, '92.0 DNF', now());

  -- [Gold] Rank 78: Arun John Behl (SGP 88)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Arun John Behl')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Arun John Behl', 'arun-john-behl-c655ce', '88', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '88' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 78, 556.0, 464.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 78.0, NULL, false, '78.0', now()),
    (gen_random_uuid(), v_res_id, 2, 87.0, NULL, false, '87.0', now()),
    (gen_random_uuid(), v_res_id, 3, 73.0, NULL, false, '73.0', now()),
    (gen_random_uuid(), v_res_id, 4, 65.0, NULL, false, '65.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'NSC', false, '92.0 NSC', now()),
    (gen_random_uuid(), v_res_id, 7, 69.0, NULL, false, '69.0', now());

  -- [Gold] Rank 79: Leow Zhao Hong Auwin (SGP 3405)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Leow Zhao Hong Auwin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Leow Zhao Hong Auwin', 'leow-zhao-hong-auwin-ac3e8b', '3405', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3405' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 79, 562.0, 470.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 79.0, NULL, false, '79.0', now()),
    (gen_random_uuid(), v_res_id, 2, 69.0, NULL, false, '69.0', now()),
    (gen_random_uuid(), v_res_id, 3, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 4, 87.0, NULL, false, '87.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', false, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'DNF', false, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 7, 51.0, NULL, false, '51.0', now());

  -- [Gold] Rank 80: Loh Yan Cheng (SGP 3717)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Loh Yan Cheng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Loh Yan Cheng', 'loh-yan-cheng-5f5fa6', '3717', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3717' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 80, 563.0, 471.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 77.0, NULL, false, '77.0', now()),
    (gen_random_uuid(), v_res_id, 2, 79.0, NULL, false, '79.0', now()),
    (gen_random_uuid(), v_res_id, 3, 68.0, NULL, false, '68.0', now()),
    (gen_random_uuid(), v_res_id, 4, 63.0, NULL, false, '63.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'DNF', false, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 7, 92.0, 'DNF', false, '92.0 DNF', now());

  -- [Gold] Rank 81: Aidan Yeo See Hett (SGP 3112)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aidan Yeo See Hett')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aidan Yeo See Hett', 'aidan-yeo-see-hett-a41a07', '3112', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3112' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 81, 564.0, 472.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 66.0, NULL, false, '66.0', now()),
    (gen_random_uuid(), v_res_id, 2, 81.0, NULL, false, '81.0', now()),
    (gen_random_uuid(), v_res_id, 3, 64.0, NULL, false, '64.0', now()),
    (gen_random_uuid(), v_res_id, 4, 77.0, NULL, false, '77.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'DNF', false, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 7, 92.0, 'DNF', false, '92.0 DNF', now());

  -- [Gold] Rank 82: Chan Zhi Long Breyven (SGP 3338)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Chan Zhi Long Breyven')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Chan Zhi Long Breyven', 'chan-zhi-long-breyven-ae14f3', '3338', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3338' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 82, 566.0, 474.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 92.0, 'DNC', true, '92.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 2, 74.0, NULL, false, '74.0', now()),
    (gen_random_uuid(), v_res_id, 3, 76.0, NULL, false, '76.0', now()),
    (gen_random_uuid(), v_res_id, 4, 70.0, NULL, false, '70.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', false, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'DNF', false, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 7, 70.0, NULL, false, '70.0', now());

  -- [Gold] Rank 83: Ong En Kai Evan (SGP 3955)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ong En Kai Evan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ong En Kai Evan', 'ong-en-kai-evan-00be88', '3955', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3955' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 83, 575.0, 483.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 83.0, NULL, false, '83.0', now()),
    (gen_random_uuid(), v_res_id, 2, 85.0, NULL, false, '85.0', now()),
    (gen_random_uuid(), v_res_id, 3, 86.0, NULL, false, '86.0', now()),
    (gen_random_uuid(), v_res_id, 4, 88.0, NULL, false, '88.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'DNF', false, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 7, 49.0, NULL, false, '49.0', now());

  -- [Gold] Rank 84: Hagen Yong Chang Goh (SGP 3600)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hagen Yong Chang Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hagen Yong Chang Goh', 'hagen-yong-chang-goh-df8dc5', '3600', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3600' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 84, 576.0, 484.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 84.0, NULL, false, '84.0', now()),
    (gen_random_uuid(), v_res_id, 2, 83.0, NULL, false, '83.0', now()),
    (gen_random_uuid(), v_res_id, 3, 74.0, NULL, false, '74.0', now()),
    (gen_random_uuid(), v_res_id, 4, 86.0, NULL, false, '86.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'DNF', false, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 7, 65.0, NULL, false, '65.0', now());

  -- [Gold] Rank 85: George Kai Whittington (SGP 799)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('George Kai Whittington')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'George Kai Whittington', 'george-kai-whittington-30adac', '799', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '799' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 85, 578.0, 486.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 68.0, NULL, false, '68.0', now()),
    (gen_random_uuid(), v_res_id, 2, 76.0, NULL, false, '76.0', now()),
    (gen_random_uuid(), v_res_id, 3, 75.0, NULL, false, '75.0', now()),
    (gen_random_uuid(), v_res_id, 4, 83.0, NULL, false, '83.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'DNF', false, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 7, 92.0, 'DNF', false, '92.0 DNF', now());

  -- [Gold] Rank 86: PITSILIS Chloe Ariane (SGP 708)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('PITSILIS Chloe Ariane')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'PITSILIS Chloe Ariane', 'pitsilis-chloe-ariane-25c499', '708', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '708' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 86, 579.0, 487.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 76.0, NULL, false, '76.0', now()),
    (gen_random_uuid(), v_res_id, 2, 80.0, NULL, false, '80.0', now()),
    (gen_random_uuid(), v_res_id, 3, 63.0, NULL, false, '63.0', now()),
    (gen_random_uuid(), v_res_id, 4, 84.0, NULL, false, '84.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'DNF', false, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 7, 92.0, 'DNF', false, '92.0 DNF', now());

  -- [Gold] Rank 87: Ivor Lee (SGP 3306)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ivor Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ivor Lee', 'ivor-lee-45b378', '3306', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3306' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 87, 580.0, 488.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 81.0, NULL, false, '81.0', now()),
    (gen_random_uuid(), v_res_id, 2, 88.0, NULL, false, '88.0', now()),
    (gen_random_uuid(), v_res_id, 3, 81.0, NULL, false, '81.0', now()),
    (gen_random_uuid(), v_res_id, 4, 79.0, NULL, false, '79.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'NSC', false, '92.0 NSC', now()),
    (gen_random_uuid(), v_res_id, 7, 67.0, NULL, false, '67.0', now());

  -- [Gold] Rank 88: Seah Denzel (SGP 3925)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Seah Denzel')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Seah Denzel', 'seah-denzel-0e7959', '3925', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3925' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 88, 580.0, 488.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 75.0, NULL, false, '75.0', now()),
    (gen_random_uuid(), v_res_id, 2, 89.0, NULL, false, '89.0', now()),
    (gen_random_uuid(), v_res_id, 3, 79.0, NULL, false, '79.0', now()),
    (gen_random_uuid(), v_res_id, 4, 78.0, NULL, false, '78.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'NSC', false, '92.0 NSC', now()),
    (gen_random_uuid(), v_res_id, 7, 75.0, NULL, false, '75.0', now());

  -- [Gold] Rank 89: Ng Clara Siew Ning (SGP 3739)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ng Clara Siew Ning')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ng Clara Siew Ning', 'ng-clara-siew-ning-fe4e39', '3739', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3739' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 89, 582.0, 490.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 72.0, NULL, false, '72.0', now()),
    (gen_random_uuid(), v_res_id, 2, 84.0, NULL, false, '84.0', now()),
    (gen_random_uuid(), v_res_id, 3, 83.0, NULL, false, '83.0', now()),
    (gen_random_uuid(), v_res_id, 4, 67.0, NULL, false, '67.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'DNF', false, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 7, 92.0, 'DNF', false, '92.0 DNF', now());

  -- [Gold] Rank 90: Zachary Hoo (SGP 2051)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zachary Hoo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zachary Hoo', 'zachary-hoo-2b1747', '2051', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2051' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 90, 597.0, 505.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 67.0, NULL, false, '67.0', now()),
    (gen_random_uuid(), v_res_id, 2, 90.0, NULL, false, '90.0', now()),
    (gen_random_uuid(), v_res_id, 3, 82.0, NULL, false, '82.0', now()),
    (gen_random_uuid(), v_res_id, 4, 82.0, NULL, false, '82.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'NSC', false, '92.0 NSC', now()),
    (gen_random_uuid(), v_res_id, 7, 92.0, 'DNF', false, '92.0 DNF', now());

  -- [Gold] Rank 91: Teo Shen Jie (SGP 3870)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Teo Shen Jie')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Teo Shen Jie', 'teo-shen-jie-53f0c3', '3870', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3870' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 91, 598.0, 506.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 82.0, NULL, false, '82.0', now()),
    (gen_random_uuid(), v_res_id, 2, 75.0, NULL, false, '75.0', now()),
    (gen_random_uuid(), v_res_id, 3, 84.0, NULL, false, '84.0', now()),
    (gen_random_uuid(), v_res_id, 4, 81.0, NULL, false, '81.0', now()),
    (gen_random_uuid(), v_res_id, 5, 92.0, 'DNF', true, '92.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 6, 92.0, 'NSC', false, '92.0 NSC', now()),
    (gen_random_uuid(), v_res_id, 7, 92.0, 'BFD', false, '92.0 BFD', now());

  -- ==========================================================================
  -- OPTIMIST SILVER FLEET (58 competitors)
  -- ==========================================================================

  -- [Silver] Rank 1: Lee Thian Tsek Bryan (SGP 3508)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lee Thian Tsek Bryan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lee Thian Tsek Bryan', 'lee-thian-tsek-bryan-616bc5', '3508', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3508' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 1, 23.0, 11.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 5.0, NULL, false, '5.0', now()),
    (gen_random_uuid(), v_res_id, 2, 1.0, NULL, false, '1.0', now()),
    (gen_random_uuid(), v_res_id, 3, 1.0, NULL, false, '1.0', now()),
    (gen_random_uuid(), v_res_id, 4, 12.0, NULL, true, '12.0', now()),
    (gen_random_uuid(), v_res_id, 5, 4.0, NULL, false, '4.0', now());

  -- [Silver] Rank 2: Han Moyan (SGP 2042)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Han Moyan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Han Moyan', 'han-moyan-d001d8', '2042', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2042' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 2, 39.5, 14.5, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 8.0, NULL, false, '8.0', now()),
    (gen_random_uuid(), v_res_id, 2, 2.0, NULL, false, '2.0', now()),
    (gen_random_uuid(), v_res_id, 3, 3.0, NULL, false, '3.0', now()),
    (gen_random_uuid(), v_res_id, 4, 25.0, NULL, true, '25.0', now()),
    (gen_random_uuid(), v_res_id, 5, 1.5, NULL, false, '1.5', now());

  -- [Silver] Rank 3: Changqi Tao (CHN 5721)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Changqi Tao')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Changqi Tao', 'changqi-tao-8e9894', '5721', 'Wuxi Schonst Sailing Club', 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '5721' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Wuxi Schonst Sailing Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 3, 29.5, 17.5, false, 'M', 2015, 'CHN', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 12.0, NULL, true, '12.0', now()),
    (gen_random_uuid(), v_res_id, 2, 4.0, NULL, false, '4.0', now()),
    (gen_random_uuid(), v_res_id, 3, 4.0, NULL, false, '4.0', now()),
    (gen_random_uuid(), v_res_id, 4, 8.0, NULL, false, '8.0', now()),
    (gen_random_uuid(), v_res_id, 5, 1.5, NULL, false, '1.5', now());

  -- [Silver] Rank 4: Jerome Puah Yang Yi (SGP 2037)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jerome Puah Yang Yi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jerome Puah Yang Yi', 'jerome-puah-yang-yi-f942ec', '2037', 'Others', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2037' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Others'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 4, 44.0, 19.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 2.0, NULL, false, '2.0', now()),
    (gen_random_uuid(), v_res_id, 2, 25.0, NULL, true, '25.0', now()),
    (gen_random_uuid(), v_res_id, 3, 8.0, NULL, false, '8.0', now()),
    (gen_random_uuid(), v_res_id, 4, 2.0, NULL, false, '2.0', now()),
    (gen_random_uuid(), v_res_id, 5, 7.0, NULL, false, '7.0', now());

  -- [Silver] Rank 5: Wu Jiaqian (SGP 3424)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Wu Jiaqian')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Wu Jiaqian', 'wu-jiaqian-0e05dc', '3424', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3424' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 5, 53.0, 27.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 1.0, NULL, false, '1.0', now()),
    (gen_random_uuid(), v_res_id, 2, 8.0, NULL, false, '8.0', now()),
    (gen_random_uuid(), v_res_id, 3, 26.0, NULL, true, '26.0', now()),
    (gen_random_uuid(), v_res_id, 4, 6.0, NULL, false, '6.0', now()),
    (gen_random_uuid(), v_res_id, 5, 12.0, NULL, false, '12.0', now());

  -- [Silver] Rank 6: Jade Tan (SGP 3555)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jade Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jade Tan', 'jade-tan-d4e0f7', '3555', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3555' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 6, 56.0, 30.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 11.0, NULL, false, '11.0', now()),
    (gen_random_uuid(), v_res_id, 2, 26.0, NULL, true, '26.0', now()),
    (gen_random_uuid(), v_res_id, 3, 12.0, NULL, false, '12.0', now()),
    (gen_random_uuid(), v_res_id, 4, 1.0, NULL, false, '1.0', now()),
    (gen_random_uuid(), v_res_id, 5, 6.0, NULL, false, '6.0', now());

  -- [Silver] Rank 7: Chiang Ziyi Adele (SGP 3120)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Chiang Ziyi Adele')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Chiang Ziyi Adele', 'chiang-ziyi-adele-81a648', '3120', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3120' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 7, 71.3, 31.3, false, 'F', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 6.0, NULL, false, '6.0', now()),
    (gen_random_uuid(), v_res_id, 2, 6.0, NULL, false, '6.0', now()),
    (gen_random_uuid(), v_res_id, 3, 5.0, NULL, false, '5.0', now()),
    (gen_random_uuid(), v_res_id, 4, 14.3, 'RDG', false, '14.3 RDG', now()),
    (gen_random_uuid(), v_res_id, 5, 40.0, NULL, true, '40.0', now());

  -- [Silver] Rank 8: Henry Mittelhauser (SGP 2052)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Henry Mittelhauser')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Henry Mittelhauser', 'henry-mittelhauser-2f45ef', '2052', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2052' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 8, 77.0, 35.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 4.0, NULL, false, '4.0', now()),
    (gen_random_uuid(), v_res_id, 2, 15.0, NULL, false, '15.0', now()),
    (gen_random_uuid(), v_res_id, 3, 42.0, NULL, true, '42.0', now()),
    (gen_random_uuid(), v_res_id, 4, 3.0, NULL, false, '3.0', now()),
    (gen_random_uuid(), v_res_id, 5, 13.0, NULL, false, '13.0', now());

  -- [Silver] Rank 9: Muhammad Rehan Bin Mohamed Salim (SGP 2059)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Muhammad Rehan Bin Mohamed Salim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Muhammad Rehan Bin Mohamed Salim', 'muhammad-rehan-bin-mohamed-salim-398aad', '2059', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2059' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 9, 60.0, 39.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 15.0, NULL, false, '15.0', now()),
    (gen_random_uuid(), v_res_id, 2, 3.0, NULL, false, '3.0', now()),
    (gen_random_uuid(), v_res_id, 3, 9.0, NULL, false, '9.0', now()),
    (gen_random_uuid(), v_res_id, 4, 12.0, 'RDG', false, '12.0 RDG', now()),
    (gen_random_uuid(), v_res_id, 5, 21.0, NULL, true, '21.0', now());

  -- [Silver] Rank 10: Zheng Ryan Feiran (SGP 2045)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zheng Ryan Feiran')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zheng Ryan Feiran', 'zheng-ryan-feiran-5a7323', '2045', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2045' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 10, 65.0, 43.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 7.0, NULL, false, '7.0', now()),
    (gen_random_uuid(), v_res_id, 2, 22.0, NULL, true, '22.0', now()),
    (gen_random_uuid(), v_res_id, 3, 13.0, NULL, false, '13.0', now()),
    (gen_random_uuid(), v_res_id, 4, 13.0, NULL, false, '13.0', now()),
    (gen_random_uuid(), v_res_id, 5, 10.0, NULL, false, '10.0', now());

  -- [Silver] Rank 11: Yiyi Wu (CHN 5766)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yiyi Wu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yiyi Wu', 'yiyi-wu-6a9ecd', '5766', 'Wuxi Schonst Sailing Club', 'F', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '5766' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Wuxi Schonst Sailing Club'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 11, 69.0, 45.0, false, 'F', 2016, 'CHN', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 10.0, NULL, false, '10.0', now()),
    (gen_random_uuid(), v_res_id, 2, 7.0, NULL, false, '7.0', now()),
    (gen_random_uuid(), v_res_id, 3, 24.0, NULL, true, '24.0', now()),
    (gen_random_uuid(), v_res_id, 4, 19.0, NULL, false, '19.0', now()),
    (gen_random_uuid(), v_res_id, 5, 9.0, NULL, false, '9.0', now());

  -- [Silver] Rank 12: Du Jiayi (CHN 3141)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Du Jiayi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Du Jiayi', 'du-jiayi-27d750', '3141', 'SAF Yacht Club', 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3141' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 12, 73.0, 48.0, false, 'M', 2016, 'CHN', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 19.0, NULL, false, '19.0', now()),
    (gen_random_uuid(), v_res_id, 2, 5.0, NULL, false, '5.0', now()),
    (gen_random_uuid(), v_res_id, 3, 6.0, NULL, false, '6.0', now()),
    (gen_random_uuid(), v_res_id, 4, 18.0, NULL, false, '18.0', now()),
    (gen_random_uuid(), v_res_id, 5, 25.0, NULL, true, '25.0', now());

  -- [Silver] Rank 13: Hongren Wang (SGP 2039)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hongren Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hongren Wang', 'hongren-wang-587b2d', '2039', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2039' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 13, 99.0, 53.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 9.0, NULL, false, '9.0', now()),
    (gen_random_uuid(), v_res_id, 2, 21.0, NULL, false, '21.0', now()),
    (gen_random_uuid(), v_res_id, 3, 7.0, NULL, false, '7.0', now()),
    (gen_random_uuid(), v_res_id, 4, 46.0, NULL, true, '46.0', now()),
    (gen_random_uuid(), v_res_id, 5, 16.0, NULL, false, '16.0', now());

  -- [Silver] Rank 14: Kiyansh Kanishk Singh (SGP 2046)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kiyansh Kanishk Singh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kiyansh Kanishk Singh', 'kiyansh-kanishk-singh-8b2494', '2046', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2046' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 14, 82.5, 53.5, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 24.0, NULL, false, '24.0', now()),
    (gen_random_uuid(), v_res_id, 2, 29.0, NULL, true, '29.0', now()),
    (gen_random_uuid(), v_res_id, 3, 10.0, NULL, false, '10.0', now()),
    (gen_random_uuid(), v_res_id, 4, 16.5, 'RDG', false, '16.5 RDG', now()),
    (gen_random_uuid(), v_res_id, 5, 3.0, NULL, false, '3.0', now());

  -- [Silver] Rank 15: Skyler Kang (SGP 2041)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Skyler Kang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Skyler Kang', 'skyler-kang-524b74', '2041', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2041' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 15, 78.8, 57.8, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 21.0, NULL, true, '21.0', now()),
    (gen_random_uuid(), v_res_id, 2, 20.0, NULL, false, '20.0', now()),
    (gen_random_uuid(), v_res_id, 3, 11.0, NULL, false, '11.0', now()),
    (gen_random_uuid(), v_res_id, 4, 15.8, 'RDG', false, '15.8 RDG', now()),
    (gen_random_uuid(), v_res_id, 5, 11.0, NULL, false, '11.0', now());

  -- [Silver] Rank 16: Vincent Ni (CHN 7)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Vincent Ni')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Vincent Ni', 'vincent-ni-07858a', '7', 'Wuxi Schonst Sailing Club', 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '7' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Wuxi Schonst Sailing Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 16, 119.0, 60.0, false, 'M', 2016, 'CHN', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 20.0, NULL, false, '20.0', now()),
    (gen_random_uuid(), v_res_id, 2, 19.0, NULL, false, '19.0', now()),
    (gen_random_uuid(), v_res_id, 3, 2.0, NULL, false, '2.0', now()),
    (gen_random_uuid(), v_res_id, 4, 59.0, 'RET', true, '59.0 RET', now()),
    (gen_random_uuid(), v_res_id, 5, 19.0, NULL, false, '19.0', now());

  -- [Silver] Rank 17: Isaac Tan (SGP 2055)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isaac Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isaac Tan', 'isaac-tan-a6cefe', '2055', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2055' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 17, 97.0, 62.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 26.0, NULL, false, '26.0', now()),
    (gen_random_uuid(), v_res_id, 2, 17.0, NULL, false, '17.0', now()),
    (gen_random_uuid(), v_res_id, 3, 35.0, NULL, true, '35.0', now()),
    (gen_random_uuid(), v_res_id, 4, 5.0, NULL, false, '5.0', now()),
    (gen_random_uuid(), v_res_id, 5, 14.0, NULL, false, '14.0', now());

  -- [Silver] Rank 18: Enzo Kengsin Teo (SGP 2044)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Enzo Kengsin Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Enzo Kengsin Teo', 'enzo-kengsin-teo-87cce7', '2044', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2044' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 18, 103.0, 66.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 14.0, NULL, false, '14.0', now()),
    (gen_random_uuid(), v_res_id, 2, 23.0, NULL, false, '23.0', now()),
    (gen_random_uuid(), v_res_id, 3, 14.0, NULL, false, '14.0', now()),
    (gen_random_uuid(), v_res_id, 4, 15.0, NULL, false, '15.0', now()),
    (gen_random_uuid(), v_res_id, 5, 37.0, NULL, true, '37.0', now());

  -- [Silver] Rank 19: Seah Damien (SGP 3825)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Seah Damien')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Seah Damien', 'seah-damien-2685ee', '3825', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3825' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 19, 97.0, 69.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 18.0, NULL, false, '18.0', now()),
    (gen_random_uuid(), v_res_id, 2, 28.0, NULL, true, '28.0', now()),
    (gen_random_uuid(), v_res_id, 3, 17.0, NULL, false, '17.0', now()),
    (gen_random_uuid(), v_res_id, 4, 10.0, NULL, false, '10.0', now()),
    (gen_random_uuid(), v_res_id, 5, 24.0, NULL, false, '24.0', now());

  -- [Silver] Rank 20: Thaddaeus Renz (SGP 2058)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Thaddaeus Renz')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Thaddaeus Renz', 'thaddaeus-renz-6abed1', '2058', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2058' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 20, 115.0, 71.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 44.0, NULL, true, '44.0', now()),
    (gen_random_uuid(), v_res_id, 2, 12.0, NULL, false, '12.0', now()),
    (gen_random_uuid(), v_res_id, 3, 25.0, NULL, false, '25.0', now()),
    (gen_random_uuid(), v_res_id, 4, 4.0, NULL, false, '4.0', now()),
    (gen_random_uuid(), v_res_id, 5, 30.0, NULL, false, '30.0', now());

  -- [Silver] Rank 21: Lim Xin Chen Sven (SGP 3893)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lim Xin Chen Sven')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lim Xin Chen Sven', 'lim-xin-chen-sven-3575d6', '3893', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3893' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 21, 132.0, 73.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 3.0, NULL, false, '3.0', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'DNS', true, '59.0 DNS', now()),
    (gen_random_uuid(), v_res_id, 3, 23.0, NULL, false, '23.0', now()),
    (gen_random_uuid(), v_res_id, 4, 16.0, NULL, false, '16.0', now()),
    (gen_random_uuid(), v_res_id, 5, 31.0, NULL, false, '31.0', now());

  -- [Silver] Rank 22: Isaias Cheow (SGP 3307)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isaias Cheow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isaias Cheow', 'isaias-cheow-67a387', '3307', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3307' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 22, 100.0, 74.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 25.0, NULL, false, '25.0', now()),
    (gen_random_uuid(), v_res_id, 2, 10.0, NULL, false, '10.0', now()),
    (gen_random_uuid(), v_res_id, 3, 22.0, NULL, false, '22.0', now()),
    (gen_random_uuid(), v_res_id, 4, 26.0, NULL, true, '26.0', now()),
    (gen_random_uuid(), v_res_id, 5, 17.0, NULL, false, '17.0', now());

  -- [Silver] Rank 23: Jae Toh (SGP 3311)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jae Toh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jae Toh', 'jae-toh-7d6f6a', '3311', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3311' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 23, 107.0, 77.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 17.0, NULL, false, '17.0', now()),
    (gen_random_uuid(), v_res_id, 2, 11.0, NULL, false, '11.0', now()),
    (gen_random_uuid(), v_res_id, 3, 30.0, NULL, true, '30.0', now()),
    (gen_random_uuid(), v_res_id, 4, 20.0, NULL, false, '20.0', now()),
    (gen_random_uuid(), v_res_id, 5, 29.0, NULL, false, '29.0', now());

  -- [Silver] Rank 24: Seraphina Kang (SGP 2040)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Seraphina Kang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Seraphina Kang', 'seraphina-kang-ed7224', '2040', 'Constant Wind', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2040' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 24, 119.0, 81.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 38.0, NULL, true, '38.0', now()),
    (gen_random_uuid(), v_res_id, 2, 13.0, NULL, false, '13.0', now()),
    (gen_random_uuid(), v_res_id, 3, 27.0, NULL, false, '27.0', now()),
    (gen_random_uuid(), v_res_id, 4, 14.0, NULL, false, '14.0', now()),
    (gen_random_uuid(), v_res_id, 5, 27.0, NULL, false, '27.0', now());

  -- [Silver] Rank 25: Goh Siak Yiak Ian (SGP 3818)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Goh Siak Yiak Ian')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Goh Siak Yiak Ian', 'goh-siak-yiak-ian-0cc5f0', '3818', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3818' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 25, 119.0, 84.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 27.0, NULL, false, '27.0', now()),
    (gen_random_uuid(), v_res_id, 2, 35.0, NULL, true, '35.0', now()),
    (gen_random_uuid(), v_res_id, 3, 31.0, NULL, false, '31.0', now()),
    (gen_random_uuid(), v_res_id, 4, 21.0, NULL, false, '21.0', now()),
    (gen_random_uuid(), v_res_id, 5, 5.0, NULL, false, '5.0', now());

  -- [Silver] Rank 26: Henry Ji (CHN 8)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Henry Ji')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Henry Ji', 'henry-ji-51b3df', '8', 'Wuxi Schonst Sailing Club', 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '8' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Wuxi Schonst Sailing Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 26, 132.0, 86.0, false, 'M', 2016, 'CHN', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 46.0, NULL, true, '46.0', now()),
    (gen_random_uuid(), v_res_id, 2, 16.0, NULL, false, '16.0', now()),
    (gen_random_uuid(), v_res_id, 3, 19.0, NULL, false, '19.0', now()),
    (gen_random_uuid(), v_res_id, 4, 29.0, NULL, false, '29.0', now()),
    (gen_random_uuid(), v_res_id, 5, 22.0, NULL, false, '22.0', now());

  -- [Silver] Rank 27: Wang Yahe (SGP 3020)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Wang Yahe')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Wang Yahe', 'wang-yahe-b1d6ee', '3020', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3020' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 27, 131.0, 89.0, false, 'F', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 39.0, NULL, false, '39.0', now()),
    (gen_random_uuid(), v_res_id, 2, 18.0, NULL, false, '18.0', now()),
    (gen_random_uuid(), v_res_id, 3, 21.0, NULL, false, '21.0', now()),
    (gen_random_uuid(), v_res_id, 4, 11.0, NULL, false, '11.0', now()),
    (gen_random_uuid(), v_res_id, 5, 42.0, NULL, true, '42.0', now());

  -- [Silver] Rank 28: Youqi Yuki Wang (SGP 3523)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Youqi Yuki Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Youqi Yuki Wang', 'youqi-yuki-wang-096772', '3523', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3523' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 28, 123.8, 94.8, false, 'F', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 29.0, NULL, true, '29.0', now()),
    (gen_random_uuid(), v_res_id, 2, 24.0, NULL, false, '24.0', now()),
    (gen_random_uuid(), v_res_id, 3, 28.0, NULL, false, '28.0', now()),
    (gen_random_uuid(), v_res_id, 4, 24.8, 'RDG', false, '24.8 RDG', now()),
    (gen_random_uuid(), v_res_id, 5, 18.0, NULL, false, '18.0', now());

  -- [Silver] Rank 29: Khairul Adam Bin Khairulnizam (MAS 9123)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Khairul Adam Bin Khairulnizam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Khairul Adam Bin Khairulnizam', 'khairul-adam-bin-khairulnizam-8df868', '9123', 'KSA', 'M', 'MAS', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '9123' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'KSA'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'MAS'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 29, 134.0, 95.0, false, 'M', 2015, 'MAS', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 16.0, NULL, false, '16.0', now()),
    (gen_random_uuid(), v_res_id, 2, 30.0, NULL, false, '30.0', now()),
    (gen_random_uuid(), v_res_id, 3, 34.0, NULL, false, '34.0', now()),
    (gen_random_uuid(), v_res_id, 4, 39.0, NULL, true, '39.0', now()),
    (gen_random_uuid(), v_res_id, 5, 15.0, NULL, false, '15.0', now());

  -- [Silver] Rank 30: Wai Yong Le (SGP 3488)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Wai Yong Le')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Wai Yong Le', 'wai-yong-le-13383a', '3488', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3488' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 30, 160.0, 101.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 23.0, NULL, false, '23.0', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'DNF', true, '59.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 3, 46.0, NULL, false, '46.0', now()),
    (gen_random_uuid(), v_res_id, 4, 24.0, NULL, false, '24.0', now()),
    (gen_random_uuid(), v_res_id, 5, 8.0, NULL, false, '8.0', now());

  -- [Silver] Rank 31: Tay Llewellyn Ding Zhe (SGP 3013)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tay Llewellyn Ding Zhe')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tay Llewellyn Ding Zhe', 'tay-llewellyn-ding-zhe-4b8fa7', '3013', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3013' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 31, 162.0, 103.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 13.0, NULL, false, '13.0', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'DNS', true, '59.0 DNS', now()),
    (gen_random_uuid(), v_res_id, 3, 15.0, NULL, false, '15.0', now()),
    (gen_random_uuid(), v_res_id, 4, 37.0, NULL, false, '37.0', now()),
    (gen_random_uuid(), v_res_id, 5, 38.0, NULL, false, '38.0', now());

  -- [Silver] Rank 32: Axel Lin (SGP 720)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Axel Lin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Axel Lin', 'axel-lin-00c7c6', '720', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '720' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 32, 170.0, 111.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 41.0, NULL, false, '41.0', now()),
    (gen_random_uuid(), v_res_id, 2, 14.0, NULL, false, '14.0', now()),
    (gen_random_uuid(), v_res_id, 3, 36.0, NULL, false, '36.0', now()),
    (gen_random_uuid(), v_res_id, 4, 59.0, 'DNS', true, '59.0 DNS', now()),
    (gen_random_uuid(), v_res_id, 5, 20.0, NULL, false, '20.0', now());

  -- [Silver] Rank 33: Nadia Zahedi (SGP 4724)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nadia Zahedi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nadia Zahedi', 'nadia-zahedi-6da6c0', '4724', 'Others', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4724' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Others'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 33, 164.0, 114.0, false, 'F', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 50.0, NULL, true, '50.0', now()),
    (gen_random_uuid(), v_res_id, 2, 33.0, NULL, false, '33.0', now()),
    (gen_random_uuid(), v_res_id, 3, 32.0, NULL, false, '32.0', now()),
    (gen_random_uuid(), v_res_id, 4, 17.0, NULL, false, '17.0', now()),
    (gen_random_uuid(), v_res_id, 5, 32.0, NULL, false, '32.0', now());

  -- [Silver] Rank 34: Neel Paul Behl (USA 734)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Neel Paul Behl')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Neel Paul Behl', 'neel-paul-behl-8fb320', '734', 'Changi Sailing Club', 'M', 'USA', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '734' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'USA'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 34, 176.0, 117.0, false, 'M', 2016, 'USA', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 31.0, NULL, false, '31.0', now()),
    (gen_random_uuid(), v_res_id, 2, 9.0, NULL, false, '9.0', now()),
    (gen_random_uuid(), v_res_id, 3, 18.0, NULL, false, '18.0', now()),
    (gen_random_uuid(), v_res_id, 4, 59.0, 'DNC', true, '59.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 5, 59.0, 'DNC', false, '59.0 DNC', now());

  -- [Silver] Rank 35: Luca Yang Kexing (SGP 707)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Luca Yang Kexing')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Luca Yang Kexing', 'luca-yang-kexing-e9184a', '707', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '707' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 35, 158.0, 117.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 30.0, NULL, false, '30.0', now()),
    (gen_random_uuid(), v_res_id, 2, 31.0, NULL, false, '31.0', now()),
    (gen_random_uuid(), v_res_id, 3, 33.0, NULL, false, '33.0', now()),
    (gen_random_uuid(), v_res_id, 4, 23.0, NULL, false, '23.0', now()),
    (gen_random_uuid(), v_res_id, 5, 41.0, NULL, true, '41.0', now());

  -- [Silver] Rank 36: Ilysha Wong (SGP 2053)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ilysha Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ilysha Wong', 'ilysha-wong-d6f3af', '2053', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2053' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 36, 182.0, 123.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 32.0, NULL, false, '32.0', now()),
    (gen_random_uuid(), v_res_id, 2, 34.0, NULL, false, '34.0', now()),
    (gen_random_uuid(), v_res_id, 3, 29.0, NULL, false, '29.0', now()),
    (gen_random_uuid(), v_res_id, 4, 28.0, NULL, false, '28.0', now()),
    (gen_random_uuid(), v_res_id, 5, 59.0, 'DNF', true, '59.0 DNF', now());

  -- [Silver] Rank 37: LI YU'AN (SGP 2056)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('LI YU''AN')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'LI YU''AN', 'li-yu-an-5e6feb', '2056', 'Constant Wind', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2056' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 37, 186.0, 127.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 28.0, NULL, false, '28.0', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'DNS', true, '59.0 DNS', now()),
    (gen_random_uuid(), v_res_id, 3, 49.0, NULL, false, '49.0', now()),
    (gen_random_uuid(), v_res_id, 4, 7.0, NULL, false, '7.0', now()),
    (gen_random_uuid(), v_res_id, 5, 43.0, NULL, false, '43.0', now());

  -- [Silver] Rank 38: Teo Dylan (SGP 3107)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Teo Dylan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Teo Dylan', 'teo-dylan-258091', '3107', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3107' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 38, 186.5, 127.5, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 34.0, NULL, false, '34.0', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'DNF', true, '59.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 3, 51.5, NULL, false, '51.5', now()),
    (gen_random_uuid(), v_res_id, 4, 9.0, NULL, false, '9.0', now()),
    (gen_random_uuid(), v_res_id, 5, 33.0, NULL, false, '33.0', now());

  -- [Silver] Rank 39: Sumire Sayawaki- Kogut (SGP 710)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sumire Sayawaki- Kogut')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sumire Sayawaki- Kogut', 'sumire-sayawaki-kogut-e15155', '710', 'Changi Sailing Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '710' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 39, 187.0, 128.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 22.0, NULL, false, '22.0', now()),
    (gen_random_uuid(), v_res_id, 2, 27.0, NULL, false, '27.0', now()),
    (gen_random_uuid(), v_res_id, 3, 20.0, NULL, false, '20.0', now()),
    (gen_random_uuid(), v_res_id, 4, 59.0, 'DNF', true, '59.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 5, 59.0, 'DNF', false, '59.0 DNF', now());

  -- [Silver] Rank 40: Kok Jacob (SGP 3087)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kok Jacob')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kok Jacob', 'kok-jacob-89759e', '3087', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3087' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 40, 188.0, 129.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 47.0, NULL, false, '47.0', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'NSC', true, '59.0 NSC', now()),
    (gen_random_uuid(), v_res_id, 3, 16.0, NULL, false, '16.0', now()),
    (gen_random_uuid(), v_res_id, 4, 40.0, NULL, false, '40.0', now()),
    (gen_random_uuid(), v_res_id, 5, 26.0, NULL, false, '26.0', now());

  -- [Silver] Rank 41: Tan Kai Hui Hillary (SGP 777)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tan Kai Hui Hillary')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tan Kai Hui Hillary', 'tan-kai-hui-hillary-6c16a2', '777', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '777' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 41, 184.0, 130.0, false, 'F', 2018, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 33.0, NULL, false, '33.0', now()),
    (gen_random_uuid(), v_res_id, 2, 38.0, NULL, false, '38.0', now()),
    (gen_random_uuid(), v_res_id, 3, 54.0, NULL, true, '54.0', now()),
    (gen_random_uuid(), v_res_id, 4, 36.0, NULL, false, '36.0', now()),
    (gen_random_uuid(), v_res_id, 5, 23.0, NULL, false, '23.0', now());

  -- [Silver] Rank 42: Kwan Andrea (SGP 3745)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kwan Andrea')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kwan Andrea', 'kwan-andrea-1a4832', '3745', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3745' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 42, 190.0, 142.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 48.0, NULL, true, '48.0', now()),
    (gen_random_uuid(), v_res_id, 2, 32.0, NULL, false, '32.0', now()),
    (gen_random_uuid(), v_res_id, 3, 44.0, NULL, false, '44.0', now()),
    (gen_random_uuid(), v_res_id, 4, 22.0, NULL, false, '22.0', now()),
    (gen_random_uuid(), v_res_id, 5, 44.0, NULL, false, '44.0', now());

  -- [Silver] Rank 43: Lam Ze Emil (SGP 2049)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lam Ze Emil')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lam Ze Emil', 'lam-ze-emil-3992bd', '2049', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2049' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 43, 205.0, 146.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 40.0, NULL, false, '40.0', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'DNF', true, '59.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 3, 40.0, NULL, false, '40.0', now()),
    (gen_random_uuid(), v_res_id, 4, 30.0, NULL, false, '30.0', now()),
    (gen_random_uuid(), v_res_id, 5, 36.0, NULL, false, '36.0', now());

  -- [Silver] Rank 44: PITSILIS Amelie Camille (FRA 702)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('PITSILIS Amelie Camille')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'PITSILIS Amelie Camille', 'pitsilis-amelie-camille-927175', '702', 'Changi Sailing Club', 'F', 'FRA', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '702' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'FRA'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 44, 208.5, 149.5, false, 'F', 2017, 'FRA', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 36.0, NULL, false, '36.0', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'DNS', true, '59.0 DNS', now()),
    (gen_random_uuid(), v_res_id, 3, 51.5, NULL, false, '51.5', now()),
    (gen_random_uuid(), v_res_id, 4, 34.0, NULL, false, '34.0', now()),
    (gen_random_uuid(), v_res_id, 5, 28.0, NULL, false, '28.0', now());

  -- [Silver] Rank 45: Ian Teng Shao Feng (SGP 718)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ian Teng Shao Feng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ian Teng Shao Feng', 'ian-teng-shao-feng-1117e2', '718', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '718' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 45, 213.0, 154.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 37.0, NULL, false, '37.0', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'DNS', true, '59.0 DNS', now()),
    (gen_random_uuid(), v_res_id, 3, 45.0, NULL, false, '45.0', now()),
    (gen_random_uuid(), v_res_id, 4, 38.0, NULL, false, '38.0', now()),
    (gen_random_uuid(), v_res_id, 5, 34.0, NULL, false, '34.0', now());

  -- [Silver] Rank 46: Oliver Cheong Rui Heng (SGP 3515)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Oliver Cheong Rui Heng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Oliver Cheong Rui Heng', 'oliver-cheong-rui-heng-158320', '3515', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3515' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 46, 218.0, 159.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 35.0, NULL, false, '35.0', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'DNS', true, '59.0 DNS', now()),
    (gen_random_uuid(), v_res_id, 3, 43.0, NULL, false, '43.0', now()),
    (gen_random_uuid(), v_res_id, 4, 33.0, NULL, false, '33.0', now()),
    (gen_random_uuid(), v_res_id, 5, 48.0, NULL, false, '48.0', now());

  -- [Silver] Rank 47: Du Xiangyu (SGP 3761)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Du Xiangyu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Du Xiangyu', 'du-xiangyu-7b46a1', '3761', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3761' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 47, 213.0, 159.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 54.0, NULL, true, '54.0', now()),
    (gen_random_uuid(), v_res_id, 2, 36.0, NULL, false, '36.0', now()),
    (gen_random_uuid(), v_res_id, 3, 37.0, NULL, false, '37.0', now()),
    (gen_random_uuid(), v_res_id, 4, 41.0, NULL, false, '41.0', now()),
    (gen_random_uuid(), v_res_id, 5, 45.0, NULL, false, '45.0', now());

  -- [Silver] Rank 48: Ezra Mak Yi Yang (SGP 3535)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ezra Mak Yi Yang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ezra Mak Yi Yang', 'ezra-mak-yi-yang-d91bf8', '3535', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3535' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 48, 219.0, 160.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 43.0, NULL, false, '43.0', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'NSC', true, '59.0 NSC', now()),
    (gen_random_uuid(), v_res_id, 3, 39.0, NULL, false, '39.0', now()),
    (gen_random_uuid(), v_res_id, 4, 43.0, NULL, false, '43.0', now()),
    (gen_random_uuid(), v_res_id, 5, 35.0, NULL, false, '35.0', now());

  -- [Silver] Rank 49: Ng Teng Yu Tobias (SGP 3469)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ng Teng Yu Tobias')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ng Teng Yu Tobias', 'ng-teng-yu-tobias-6af269', '3469', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3469' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 49, 247.0, 188.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 52.0, NULL, false, '52.0', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'DNS', true, '59.0 DNS', now()),
    (gen_random_uuid(), v_res_id, 3, 41.0, NULL, false, '41.0', now()),
    (gen_random_uuid(), v_res_id, 4, 49.0, NULL, false, '49.0', now()),
    (gen_random_uuid(), v_res_id, 5, 46.0, NULL, false, '46.0', now());

  -- [Silver] Rank 50: Efrem Mak Yi En (SGP 3222)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Efrem Mak Yi En')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Efrem Mak Yi En', 'efrem-mak-yi-en-35113c', '3222', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3222' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 50, 253.5, 194.5, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 59.0, 'DNF', true, '59.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'DNS', false, '59.0 DNS', now()),
    (gen_random_uuid(), v_res_id, 3, 51.5, NULL, false, '51.5', now()),
    (gen_random_uuid(), v_res_id, 4, 45.0, NULL, false, '45.0', now()),
    (gen_random_uuid(), v_res_id, 5, 39.0, NULL, false, '39.0', now());

  -- [Silver] Rank 51: Adam Leow (SGP 2063)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Adam Leow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Adam Leow', 'adam-leow-f11839', '2063', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2063' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 51, 254.0, 195.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 42.0, NULL, false, '42.0', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'DNS', true, '59.0 DNS', now()),
    (gen_random_uuid(), v_res_id, 3, 59.0, 'DNF', false, '59.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 4, 47.0, NULL, false, '47.0', now()),
    (gen_random_uuid(), v_res_id, 5, 47.0, NULL, false, '47.0', now());

  -- [Silver] Rank 52: Foo Jun Zhe Laurence (SGP 3712)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Foo Jun Zhe Laurence')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Foo Jun Zhe Laurence', 'foo-jun-zhe-laurence-db85bb', '3712', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3712' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 52, 255.5, 196.5, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 49.0, NULL, false, '49.0', now()),
    (gen_random_uuid(), v_res_id, 2, 37.0, NULL, false, '37.0', now()),
    (gen_random_uuid(), v_res_id, 3, 51.5, NULL, false, '51.5', now()),
    (gen_random_uuid(), v_res_id, 4, 59.0, 'RET', true, '59.0 RET', now()),
    (gen_random_uuid(), v_res_id, 5, 59.0, 'DNC', false, '59.0 DNC', now());

  -- [Silver] Rank 53: Nurul 'Afiya Binte Mohamed Shahrom (SGP 703)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nurul ''Afiya Binte Mohamed Shahrom')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nurul ''Afiya Binte Mohamed Shahrom', 'nurul-afiya-binte-mohamed-shahrom-b855f0', '703', 'Changi Sailing Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '703' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 53, 260.0, 201.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 45.0, NULL, false, '45.0', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'DNS', true, '59.0 DNS', now()),
    (gen_random_uuid(), v_res_id, 3, 38.0, NULL, false, '38.0', now()),
    (gen_random_uuid(), v_res_id, 4, 59.0, 'DNC', false, '59.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 5, 59.0, 'DNC', false, '59.0 DNC', now());

  -- [Silver] Rank 54: SUN YIXIA (SGP 2061)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('SUN YIXIA')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'SUN YIXIA', 'sun-yixia-e536fc', '2061', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2061' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 54, 263.0, 204.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 53.0, NULL, false, '53.0', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'DNS', true, '59.0 DNS', now()),
    (gen_random_uuid(), v_res_id, 3, 53.0, 'SCP', false, '53.0 SCP', now()),
    (gen_random_uuid(), v_res_id, 4, 48.0, NULL, false, '48.0', now()),
    (gen_random_uuid(), v_res_id, 5, 50.0, NULL, false, '50.0', now());

  -- [Silver] Rank 55: Chiam Isaac Qin Ran (SGP 3699)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Chiam Isaac Qin Ran')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Chiam Isaac Qin Ran', 'chiam-isaac-qin-ran-be5361', '3699', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3699' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 55, 268.0, 209.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 59.0, 'DNF', true, '59.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'DNS', false, '59.0 DNS', now()),
    (gen_random_uuid(), v_res_id, 3, 59.0, 'DNS', false, '59.0 DNS', now()),
    (gen_random_uuid(), v_res_id, 4, 42.0, NULL, false, '42.0', now()),
    (gen_random_uuid(), v_res_id, 5, 49.0, NULL, false, '49.0', now());

  -- [Silver] Rank 56: Ryan Jonathan Soh Zhi Jie (SGP 3110)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ryan Jonathan Soh Zhi Jie')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ryan Jonathan Soh Zhi Jie', 'ryan-jonathan-soh-zhi-jie-e391cc', '3110', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3110' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 56, 276.0, 217.0, false, 'M', 2018, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 51.0, NULL, false, '51.0', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'DNS', true, '59.0 DNS', now()),
    (gen_random_uuid(), v_res_id, 3, 48.0, NULL, false, '48.0', now()),
    (gen_random_uuid(), v_res_id, 4, 59.0, 'DNS', false, '59.0 DNS', now()),
    (gen_random_uuid(), v_res_id, 5, 59.0, 'DNF', false, '59.0 DNF', now());

  -- [Silver] Rank 57: Elouan Gay (SGP 793)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elouan Gay')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elouan Gay', 'elouan-gay-66ae26', '793', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '793' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 57, 295.0, 236.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 59.0, 'DNC', true, '59.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'DNC', false, '59.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 3, 59.0, 'DNC', false, '59.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 4, 59.0, 'DNC', false, '59.0 DNC', now()),
    (gen_random_uuid(), v_res_id, 5, 59.0, 'DNC', false, '59.0 DNC', now());

  -- [Silver] Rank 57: Wu Youxun (SGP 3070)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Wu Youxun')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Wu Youxun', 'wu-youxun-6a3f48', '3070', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3070' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 57, 295.0, 236.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 59.0, 'DNF', true, '59.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'DNS', false, '59.0 DNS', now()),
    (gen_random_uuid(), v_res_id, 3, 59.0, 'DNF', false, '59.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 4, 59.0, 'DNF', false, '59.0 DNF', now()),
    (gen_random_uuid(), v_res_id, 5, 59.0, 'DNF', false, '59.0 DNF', now());

END $$;
