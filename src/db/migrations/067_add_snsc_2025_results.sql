-- 067_add_snsc_2025_results.sql
-- Import official race-by-race results for Singapore National Sailing Championships 2025
-- Fleets: Optimist Gold (100 entries, 11 races), Optimist Silver (60 entries, 10 races), ILCA 4 (56 entries, 12 races), ILCA 6 (22 entries, 12 races)
-- Dates: 6–9 September 2025
-- Venue: National Sailing Centre, 1500 East Coast Parkway, Singapore 468963
-- Organiser: Singapore Sailing Federation
-- Source: Official Sailwave scoring sheets

-- ============================================================================
-- Regatta: Singapore National Sailing Championships 2025 (Optimist Gold) (snsc-gold-sep-25-2025-09-06)
-- ============================================================================
DO 71520
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'snsc-gold-sep-25-2025-09-06' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = 'Singapore National Sailing Championships 2025 (Optimist Gold)',
      date = '2025-09-06',
      end_date = '2025-09-09',
      boat_class = 'Optimist',
      division = 'Gold',
      total_fleet_size = 100,
      race_count = 11,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/11799/event',
      registration_url = 'https://www.sailing.org.sg/events/298131',
      schedule_notes = 'Singapore National Sailing Championships 2025 Optimist Gold fleet: 100 entries, 11 races sailed (2 discards).',
      status = 'published',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_reg_id, 'Singapore National Sailing Championships 2025 (Optimist Gold)', 'snsc-gold-sep-25-2025-09-06', '2025-09-06', '2025-09-09', 'Optimist', 'Gold', 100, 11,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation', 'https://www.racingrulesofsailing.org/documents/11799/event', 'https://www.sailing.org.sg/events/298131', 'Singapore National Sailing Championships 2025 Optimist Gold fleet: 100 entries, 11 races sailed (2 discards).', 'published', now(), now()
    );
  END IF;

  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Pailin Jaroenpon (Rank 1)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Pailin Jaroenpon')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Pailin Jaroenpon', 'pailin-jaroenpon-a245fb', '1253', 'Yacht Racing Association of Thailand', 'PLU TQ LUNG', 'F', 'THA', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '1253'),
        club = COALESCE(sailors.club, 'Yacht Racing Association of Thailand'),
        school = COALESCE(sailors.school, 'PLU TQ LUNG'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'THA'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 1, 72.0, 39.0, false, false,
    'F', 'THA', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 13.0, '(13)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 20.0, '(20)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 1.0, '1', false, NULL, now(), now());

  -- Competitor: Sean Kok Wei Kum (Rank 2)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sean Kok Wei Kum')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sean Kok Wei Kum', 'sean-kok-wei-kum-b7929c', '142', 'SAF Yacht Club', 'ANGLO- CHINESE SCHOOL (INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '142'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ANGLO- CHINESE SCHOOL (INDEPENDENT)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 2, 123.0, 50.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 16.0, '(16)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 57.0, '(57)', true, NULL, now(), now());

  -- Competitor: Lucas Zhihong Cao (Rank 3)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lucas Zhihong Cao')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lucas Zhihong Cao', 'lucas-zhihong-cao-cba056', '149', 'SAF Yacht Club', 'RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '149'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'RAFFLES INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 3, 161.0, 53.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 42.0, '(42)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 66.0, '(66)', true, NULL, now(), now());

  -- Competitor: Ethan Han Wei Chia (Rank 4)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ethan Han Wei Chia')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ethan Han Wei Chia', 'ethan-han-wei-chia-9af3a5', '121', 'SAF Yacht Club', 'RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '121'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'RAFFLES INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 4, 176.0, 59.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 16.0, '(16)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 101.0, '(101 DNF)', true, 'DNF', now(), now());

  -- Competitor: Zeph Wan (Rank 5)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zeph Wan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zeph Wan', 'zeph-wan-0ee170', '122', 'SAF Yacht Club', 'ANGLO- CHINESE SCHOOL (INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '122'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ANGLO- CHINESE SCHOOL (INDEPENDENT)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 5, 148.0, 74.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 46.0, '(46)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 28.0, '(28)', true, NULL, now(), now());

  -- Competitor: Anya Alessia Zahedi (Rank 6)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Anya Alessia Zahedi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Anya Alessia Zahedi', 'anya-alessia-zahedi-36d18a', '159', 'PAssion Wave', 'TAO NAN SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '159'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'TAO NAN SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 6, 137.0, 82.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 30.0, '(30)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 25.0, '(25)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 16.0, '16', false, NULL, now(), now());

  -- Competitor: Adison Ein (Rank 7)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Adison Ein')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Adison Ein', 'adison-ein-563aeb', '1945', 'Yacht Racing Association of Thailand', 'SATIT KASET', 'M', 'THA', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '1945'),
        club = COALESCE(sailors.club, 'Yacht Racing Association of Thailand'),
        school = COALESCE(sailors.school, 'SATIT KASET'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'THA'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 7, 145.0, 94.0, false, false,
    'M', 'THA', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 33.0, '(33)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 18.0, '(18)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 3.0, '3', false, NULL, now(), now());

  -- Competitor: Desiree Yuet Chi Lee (Rank 8)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Desiree Yuet Chi Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Desiree Yuet Chi Lee', 'desiree-yuet-chi-lee-760667', '14', 'Royal Varuna Yacht Club', 'TANJONG KATONG GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '14'),
        club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
        school = COALESCE(sailors.school, 'TANJONG KATONG GIRLS'' SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 8, 179.0, 105.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 29.0, '(29)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 45.0, '(45)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 24.0, '24', false, NULL, now(), now());

  -- Competitor: Lyric Yuxuan Li (Rank 9)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lyric Yuxuan Li')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lyric Yuxuan Li', 'lyric-yuxuan-li-340454', '728', 'Changi Sailing Club', 'RAFFLES GIRLS'' SCHOOL (SECONDARY)', 'F', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '728'),
        club = COALESCE(sailors.club, 'Changi Sailing Club'),
        school = COALESCE(sailors.school, 'RAFFLES GIRLS'' SCHOOL (SECONDARY)'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'CHN'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 9, 214.0, 107.0, false, false,
    'F', 'CHN', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 46.0, '(46)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 61.0, '(61)', true, NULL, now(), now());

  -- Competitor: Mikaela Rae Ng (Rank 10)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mikaela Rae Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mikaela Rae Ng', 'mikaela-rae-ng-462483', '151', 'PAssion Wave', 'RAFFLES GIRLS'' SCHOOL (SECONDARY)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '151'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'RAFFLES GIRLS'' SCHOOL (SECONDARY)'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 10, 213.0, 116.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 71.0, '(71)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 26.0, '(26)', true, NULL, now(), now());

  -- Competitor: Cheuk Hymn Decimus Chan (Rank 11)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cheuk Hymn Decimus Chan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cheuk Hymn Decimus Chan', 'cheuk-hymn-decimus-chan-2836c6', '192', 'Hebe Haven Yacht Club', 'HKIS', 'M', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '192'),
        club = COALESCE(sailors.club, 'Hebe Haven Yacht Club'),
        school = COALESCE(sailors.school, 'HKIS'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'HKG'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 11, 184.0, 122.0, false, false,
    'M', 'HKG', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 32.0, '(32)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 30.0, '(30)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 2.0, '2', false, NULL, now(), now());

  -- Competitor: Kevin Jun Yi Ho (Rank 12)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kevin Jun Yi Ho')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kevin Jun Yi Ho', 'kevin-jun-yi-ho-9417d0', '3118', 'SAF Yacht Club', 'RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3118'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'RAFFLES INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 12, 236.0, 123.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 46.0, '(46)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 67.0, '(67)', true, NULL, now(), now());

  -- Competitor: Zhi Tong Wai (Rank 13)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zhi Tong Wai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zhi Tong Wai', 'zhi-tong-wai-9debc5', '157', 'SAF Yacht Club', 'CHIJ SECONDARY (TOA PAYOH)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '157'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'CHIJ SECONDARY (TOA PAYOH)'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 13, 238.0, 134.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 32.0, '(32)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 72.0, '(72)', true, NULL, now(), now());

  -- Competitor: Kento Kahara (Rank 14)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kento Kahara')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kento Kahara', 'kento-kahara-5c2c1b', '3378', 'Esperance Yacht Club', NULL, 'M', 'JPN', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3378'),
        club = COALESCE(sailors.club, 'Esperance Yacht Club'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'JPN'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 14, 233.0, 136.0, false, false,
    'M', 'JPN', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 62.0, '(62)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 12.0, '12 SCP', false, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 35.0, '(35)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 6.0, '6', false, NULL, now(), now());

  -- Competitor: Alyssa Li Lin Wong (Rank 15)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Alyssa Li Lin Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Alyssa Li Lin Wong', 'alyssa-li-lin-wong-c063db', '150', 'SAF Yacht Club', 'HAIG GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '150'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'HAIG GIRLS'' SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 15, 220.0, 148.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 39.0, '(39)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 33.0, '(33)', true, NULL, now(), now());

  -- Competitor: Ethan Lee (Rank 16)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ethan Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ethan Lee', 'ethan-lee-6efc56', '83', 'PAssion Wave', 'VICTORIA SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '83'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'VICTORIA SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 16, 284.0, 150.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 33.0, '(33)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 101.0, '(101 DNF)', true, 'DNF', now(), now());

  -- Competitor: Teck Woon Pee (Rank 17)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Teck Woon Pee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Teck Woon Pee', 'teck-woon-pee-fde722', '164', 'SAF Yacht Club', 'ANGLO- CHINESE SCHOOL (INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '164'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ANGLO- CHINESE SCHOOL (INDEPENDENT)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 17, 266.0, 153.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 60.0, '(60)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 53.0, '(53)', true, NULL, now(), now());

  -- Competitor: Ethan Zhi Ren Low (Rank 18)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ethan Zhi Ren Low')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ethan Zhi Ren Low', 'ethan-zhi-ren-low-7045d7', '3855', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3855'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. HILDA''S PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 18, 210.0, 155.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 27.0, '(27)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 28.0, '(28)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 23.0, '23', false, NULL, now(), now());

  -- Competitor: Wenyu Cheng (Rank 19)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Wenyu Cheng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Wenyu Cheng', 'wenyu-cheng-55bb38', '0804', 'HHFLCSC', NULL, 'F', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '0804'),
        club = COALESCE(sailors.club, 'HHFLCSC'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'CHN'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 19, 305.0, 159.0, false, false,
    'F', 'CHN', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 45.0, '(45)', true, NULL, now(), now());

  -- Competitor: Ashlea Tham (Rank 20)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ashlea Tham')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ashlea Tham', 'ashlea-tham-f2a2cc', '175', 'Raffles Marina', 'TANJONG KATONG GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '175'),
        club = COALESCE(sailors.club, 'Raffles Marina'),
        school = COALESCE(sailors.school, 'TANJONG KATONG GIRLS'' SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 20, 308.0, 179.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 68.0, '(68)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 61.0, '(61)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 39.0, '39', false, NULL, now(), now());

  -- Competitor: Ashlyn Tham (Rank 21)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ashlyn Tham')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ashlyn Tham', 'ashlyn-tham-eb2687', '4452', 'Raffles Marina', 'ST. HILDA''S SECONDARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '4452'),
        club = COALESCE(sailors.club, 'Raffles Marina'),
        school = COALESCE(sailors.school, 'ST. HILDA''S SECONDARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 21, 393.0, 191.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 101.0, '(101 DNF)', true, 'DNF', now(), now());

  -- Competitor: Shreya Krishna Lakshminarayanan (Rank 22)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Shreya Krishna Lakshminarayanan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Shreya Krishna Lakshminarayanan', 'shreya-krishna-lakshminarayanan-18c9b4', '1632', 'Yachting Association of India', NULL, 'F', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '1632'),
        club = COALESCE(sailors.club, 'Yachting Association of India'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'IND'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 22, 369.0, 193.0, false, false,
    'F', 'IND', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 14.0, '14 SCP', false, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 66.0, '66', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 75.0, '(75)', true, NULL, now(), now());

  -- Competitor: Damien Huang (Rank 23)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Damien Huang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Damien Huang', 'damien-huang-3aa9d0', '3300', 'SAF Yacht Club', 'RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3300'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'RAFFLES INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 23, 321.0, 221.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 53.0, '(53)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 47.0, '(47)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 32.0, '32', false, NULL, now(), now());

  -- Competitor: Dylan Yue Teng Goh (Rank 24)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Dylan Yue Teng Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Dylan Yue Teng Goh', 'dylan-yue-teng-goh-3fc1a5', '3800', 'SAF Yacht Club', 'VICTORIA SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3800'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'VICTORIA SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 24, 349.0, 228.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 53.0, '(53)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 68.0, '(68)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 43.0, '43', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 5.0, '5', false, NULL, now(), now());

  -- Competitor: Rahul Rajakanth (Rank 25)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rahul Rajakanth')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rahul Rajakanth', 'rahul-rajakanth-2d35d5', '2006', 'Constant Wind SeaSports', 'ANGLO- CHINESE SCHOOL (INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2006'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'ANGLO- CHINESE SCHOOL (INDEPENDENT)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 25, 344.0, 229.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 43.0, '(43)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 72.0, '(72)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 43.0, '43', false, NULL, now(), now());

  -- Competitor: Julien Christian Petracco (Rank 26)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Julien Christian Petracco')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Julien Christian Petracco', 'julien-christian-petracco-ef44e4', '3102', 'SAF Yacht Club', 'ST. JOSEPH''S INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3102'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. JOSEPH''S INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 26, 382.0, 231.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 80.0, '(80 SCP)', true, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 71.0, '(71)', true, NULL, now(), now());

  -- Competitor: Kaelyn Dayna Soh Zhi Yi (Rank 27)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kaelyn Dayna Soh Zhi Yi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kaelyn Dayna Soh Zhi Yi', 'kaelyn-dayna-soh-zhi-yi-8163d9', '3113', 'SAF Yacht Club', 'RAFFLES GIRLS'' SCHOOL (SECONDARY)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3113'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'RAFFLES GIRLS'' SCHOOL (SECONDARY)'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 27, 385.0, 244.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 67.0, '(67)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 74.0, '(74)', true, NULL, now(), now());

  -- Competitor: Jeremiah Rui Feng Ong (Rank 28)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jeremiah Rui Feng Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jeremiah Rui Feng Ong', 'jeremiah-rui-feng-ong-535938', '3373', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3373'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. HILDA''S PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 28, 391.0, 247.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 57.0, '(57)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 23.0, '23 SCP', false, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 87.0, '(87)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 50.0, '50', false, NULL, now(), now());

  -- Competitor: Nathaniel Kaiden Ng (Rank 29)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nathaniel Kaiden Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nathaniel Kaiden Ng', 'nathaniel-kaiden-ng-1db883', '3344', 'PAssion Wave', 'ANGLO- CHINESE SCHOOL (INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3344'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'ANGLO- CHINESE SCHOOL (INDEPENDENT)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 29, 382.0, 249.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 47.0, '47', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 64.0, '(64)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 69.0, '(69)', true, NULL, now(), now());

  -- Competitor: Darian Huang (Rank 30)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Darian Huang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Darian Huang', 'darian-huang-9904a9', '3700', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3700'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. HILDA''S PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 30, 356.0, 250.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 48.0, '(48)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 58.0, '(58)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 40.0, '40', false, NULL, now(), now());

  -- Competitor: Germaine Sim (Rank 31)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Germaine Sim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Germaine Sim', 'germaine-sim-7b3ac9', '3177', 'Royal Varuna Yacht Club', 'TANJONG KATONG GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3177'),
        club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
        school = COALESCE(sailors.school, 'TANJONG KATONG GIRLS'' SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 31, 433.0, 252.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 48.0, '48', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 80.0, '(80)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 101.0, '(101 DNF)', true, 'DNF', now(), now());

  -- Competitor: Elijah En Ze Ong (Rank 32)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elijah En Ze Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elijah En Ze Ong', 'elijah-en-ze-ong-8c0f3e', '140', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '140'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. HILDA''S PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 32, 361.0, 258.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 61.0, '(61)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 42.0, '(42)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 17.0, '17', false, NULL, now(), now());

  -- Competitor: Wangsun Chen (Rank 33)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Wangsun Chen')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Wangsun Chen', 'wangsun-chen-8807e5', '3454', 'SAF Yacht Club', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3454'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 33, 430.0, 261.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 68.0, '(68)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 4.0, '4', false, NULL, now(), now());

  -- Competitor: Xingxun Wang (Rank 34)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Xingxun Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Xingxun Wang', 'xingxun-wang-f23e04', '1297', 'Sea Legs Holland', 'UWC SEA', 'F', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '1297'),
        club = COALESCE(sailors.club, 'Sea Legs Holland'),
        school = COALESCE(sailors.school, 'UWC SEA'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'CHN'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 34, 426.0, 267.0, false, false,
    'F', 'CHN', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 58.0, '(58)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 54.0, '54', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 43.0, '43', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 49.0, '49', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 14.0, '14', false, NULL, now(), now());

  -- Competitor: Jedd Zhi Hao Lam (Rank 35)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jedd Zhi Hao Lam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jedd Zhi Hao Lam', 'jedd-zhi-hao-lam-60d557', '2000', 'Constant Wind SeaSports', 'HENRY PARK PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2000'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'HENRY PARK PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 35, 372.0, 274.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 47.0, '(47)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 51.0, '(51)', true, NULL, now(), now());

  -- Competitor: Lahari Kommaravelly (Rank 36)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lahari Kommaravelly')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lahari Kommaravelly', 'lahari-kommaravelly-665a01', '1716', 'Yachting Association of India', NULL, 'F', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '1716'),
        club = COALESCE(sailors.club, 'Yachting Association of India'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'IND'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 36, 426.0, 296.0, false, false,
    'F', 'IND', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 77.0, '(77)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 53.0, '(53)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 15.0, '15', false, NULL, now(), now());

  -- Competitor: Jairus Xin Jie Teo (Rank 37)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jairus Xin Jie Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jairus Xin Jie Teo', 'jairus-xin-jie-teo-b34134', '4073', 'PAssion Wave', 'ST. ANDREW''S SECONDARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '4073'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'ST. ANDREW''S SECONDARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 37, 450.0, 301.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 73.0, '(73)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 76.0, '(76)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 68.0, '68', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 43.0, '43', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 9.0, '9', false, NULL, now(), now());

  -- Competitor: Krishna Venkitachalam (Rank 38)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Krishna Venkitachalam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Krishna Venkitachalam', 'krishna-venkitachalam-bdf3ef', '1639', 'Yachting Association of India', NULL, 'M', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '1639'),
        club = COALESCE(sailors.club, 'Yachting Association of India'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'IND'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 38, 447.0, 320.0, false, false,
    'M', 'IND', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 37.0, '37 SCP', false, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 68.0, '(68)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 58.0, '58', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 55.0, '55', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 59.0, '(59)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 8.0, '8', false, NULL, now(), now());

  -- Competitor: Edrei En Xu Ong (Rank 39)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Edrei En Xu Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Edrei En Xu Ong', 'edrei-en-xu-ong-254b73', '3957', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3957'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. HILDA''S PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 39, 471.0, 335.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 73.0, '(73)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 62.0, '62', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 48.0, '48', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 63.0, '(63)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 49.0, '49', false, NULL, now(), now());

  -- Competitor: Joel Zhuo Le Khoo (Rank 40)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joel Zhuo Le Khoo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joel Zhuo Le Khoo', 'joel-zhuo-le-khoo-a61825', '4730', 'SAF Yacht Club', 'NANYANG PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '4730'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'NANYANG PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 40, 490.0, 343.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 54.0, '(54)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 93.0, '(93)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 43.0, '43', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 43.0, '43', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 48.0, '48', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 7.0, '7', false, NULL, now(), now());

  -- Competitor: Siti Ra'idah Binte Mohd Airudin (Rank 41)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Siti Ra''idah Binte Mohd Airudin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Siti Ra''idah Binte Mohd Airudin', 'siti-ra-idah-binte-mohd-airudin-75f025', '112', 'PAssion Wave', 'NORTHLAND PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '112'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'NORTHLAND PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 41, 486.0, 347.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 59.0, '59', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 75.0, '(75)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 64.0, '(64)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 64.0, '64', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 19.0, '19', false, NULL, now(), now());

  -- Competitor: Nicole Jing Chen Wong (Rank 42)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nicole Jing Chen Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nicole Jing Chen Wong', 'nicole-jing-chen-wong-1aab5c', '3006', 'SAF Yacht Club', 'CHIJ OUR LADY QUEEN OF PEACE', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3006'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'CHIJ OUR LADY QUEEN OF PEACE'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 42, 488.0, 349.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 60.0, '60', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 49.0, '49', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 66.0, '(66)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 73.0, '(73)', true, NULL, now(), now());

  -- Competitor: Nathan, Nande LI (Rank 43)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nathan, Nande LI')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nathan, Nande LI', 'nathan-nande-li-9aa124', '139', 'Hebe Haven Yacht Club', 'CLEAR WATER BAY SCHOOL', 'M', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '139'),
        club = COALESCE(sailors.club, 'Hebe Haven Yacht Club'),
        school = COALESCE(sailors.school, 'CLEAR WATER BAY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'HKG'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 43, 510.0, 358.0, false, false,
    'M', 'HKG', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 70.0, '(70)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 53.0, '53', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 48.0, '48', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 82.0, '(82)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 35.0, '35', false, NULL, now(), now());

  -- Competitor: Mohd Rizwan (Rank 44)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mohd Rizwan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mohd Rizwan', 'mohd-rizwan-6f216b', '2506', 'Yachting Association of India', NULL, 'M', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2506'),
        club = COALESCE(sailors.club, 'Yachting Association of India'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'IND'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 44, 553.0, 365.0, false, false,
    'M', 'IND', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 63.0, '63', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 48.0, '48', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 87.0, '(87)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 59.0, '59', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 47.0, '47', false, NULL, now(), now());

  -- Competitor: Elliot Goh (Rank 45)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elliot Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elliot Goh', 'elliot-goh-c08f54', '3103', 'SAF Yacht Club', 'HENRY PARK PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3103'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'HENRY PARK PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 45, 527.0, 371.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 78.0, '(78)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 75.0, '75', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 54.0, '54', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 43.0, '43', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 57.0, '57', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 78.0, '(78)', true, NULL, now(), now());

  -- Competitor: Lucas Rui Kai Lim (Rank 46)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lucas Rui Kai Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lucas Rui Kai Lim', 'lucas-rui-kai-lim-476ff6', '3355', 'SAF Yacht Club', 'ST. JOSEPH''S INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3355'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. JOSEPH''S INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 46, 513.0, 379.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 56.0, '56', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 49.0, '49', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 64.0, '(64)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 70.0, '(70)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 60.0, '60', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 47.0, '47', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 49.0, '49', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 30.0, '30', false, NULL, now(), now());

  -- Competitor: Olivia Ting Jia Cheong (Rank 47)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Olivia Ting Jia Cheong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Olivia Ting Jia Cheong', 'olivia-ting-jia-cheong-6eddaf', '3002', 'SAF Yacht Club', 'NAN HUA PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3002'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'NAN HUA PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 47, 563.0, 386.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 47.0, '47', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 51.0, '51', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 61.0, '61', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 58.0, '58', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 51.0, '51', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 76.0, '(76)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 101.0, '(101 DNF)', true, 'DNF', now(), now());

  -- Competitor: Cameron Underwood (Rank 48)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cameron Underwood')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cameron Underwood', 'cameron-underwood-55bf68', '1001', 'Royal Yacht Club of Tasmania', 'THE FRIEND''S SCHOOL', 'M', 'AUS', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '1001'),
        club = COALESCE(sailors.club, 'Royal Yacht Club of Tasmania'),
        school = COALESCE(sailors.school, 'THE FRIEND''S SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'AUS'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 48, 524.0, 387.0, false, false,
    'M', 'AUS', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 72.0, '(72)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 63.0, '63', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 60.0, '60', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 64.0, '64', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 65.0, '(65)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 18.0, '18', false, NULL, now(), now());

  -- Competitor: Charlie Purt (Rank 49)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Charlie Purt')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Charlie Purt', 'charlie-purt-a0ee78', '1203', 'South of Perth Yacht Club', 'WESLEY COLLEGE', 'M', 'AUS', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '1203'),
        club = COALESCE(sailors.club, 'South of Perth Yacht Club'),
        school = COALESCE(sailors.school, 'WESLEY COLLEGE'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'AUS'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 49, 549.0, 413.0, false, false,
    'M', 'AUS', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 71.0, '(71)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 64.0, '64', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 57.0, '57', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 47.0, '47', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 49.0, '49', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 51.0, '51', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 65.0, '(65)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 56.0, '56', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 12.0, '12', false, NULL, now(), now());

  -- Competitor: Shin Chen Rui Lin (Rank 50)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Shin Chen Rui Lin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Shin Chen Rui Lin', 'shin-chen-rui-lin-8c1dc9', '3333', 'SAF Yacht Club', 'HORIZON PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3333'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'HORIZON PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 50, 564.0, 424.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 49.0, '49', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 58.0, '58', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 72.0, '(72)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 67.0, '67', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 68.0, '(68)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 65.0, '65', false, NULL, now(), now());

  -- Competitor: Charles Shing Chak Kong (Rank 51)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Charles Shing Chak Kong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Charles Shing Chak Kong', 'charles-shing-chak-kong-c5fa7d', '716', 'Changi Sailing Club', 'ANGLO- CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '716'),
        club = COALESCE(sailors.club, 'Changi Sailing Club'),
        school = COALESCE(sailors.school, 'ANGLO- CHINESE SCHOOL (JUNIOR)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 51, 581.0, 428.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 51.0, '51', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 72.0, '(72)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 65.0, '65', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 54.0, '54', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 81.0, '(81)', true, NULL, now(), now());

  -- Competitor: Kirsten En Ting Tan (Rank 52)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kirsten En Ting Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kirsten En Ting Tan', 'kirsten-en-ting-tan-b47571', '3663', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3663'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. HILDA''S PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 52, 609.0, 452.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 63.0, '63', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 81.0, '(81)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 64.0, '64', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 74.0, '74', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 76.0, '(76)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 73.0, '73', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 29.0, '29', false, NULL, now(), now());

  -- Competitor: Matthew Qin Hao Chiam (Rank 53)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Matthew Qin Hao Chiam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Matthew Qin Hao Chiam', 'matthew-qin-hao-chiam-0a48aa', '3606', 'SAF Yacht Club', 'AI TONG SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3606'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'AI TONG SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 53, 655.0, 453.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 55.0, '55', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 53.0, '53', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 61.0, '61', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 60.0, '60', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 54.0, '54', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 101.0, '(101 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 101.0, '(101 DNC)', true, 'DNC', now(), now());

  -- Competitor: Rachel Qian Hui Lim (Rank 54)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rachel Qian Hui Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rachel Qian Hui Lim', 'rachel-qian-hui-lim-5aa193', '3197', 'SAF Yacht Club', 'HAIG GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3197'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'HAIG GIRLS'' SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 54, 635.0, 454.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 75.0, '75', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 57.0, '57', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 63.0, '63', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 80.0, '(80)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 69.0, '69', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 22.0, '22', false, NULL, now(), now());

  -- Competitor: Scarlett Tao (Rank 55)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Scarlett Tao')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Scarlett Tao', 'scarlett-tao-42928a', '259', 'Royal Hong Kong Yacht Club', 'INDEPENTS SCHOOL OF FOUNDATION', 'F', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '259'),
        club = COALESCE(sailors.club, 'Royal Hong Kong Yacht Club'),
        school = COALESCE(sailors.school, 'INDEPENTS SCHOOL OF FOUNDATION'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'HKG'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 55, 628.0, 461.0, false, false,
    'F', 'HKG', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 60.0, '60', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 71.0, '71', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 89.0, '(89)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 78.0, '(78)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 64.0, '64', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 60.0, '60', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 60.0, '60', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 66.0, '66', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 10.0, '10', false, NULL, now(), now());

  -- Competitor: Aidon Xiong (Rank 56)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aidon Xiong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aidon Xiong', 'aidon-xiong-711339', '157', 'Hebe Haven Yacht Club', 'WEN YUAN', 'M', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '157'),
        club = COALESCE(sailors.club, 'Hebe Haven Yacht Club'),
        school = COALESCE(sailors.school, 'WEN YUAN'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'HKG'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 56, 678.0, 476.0, false, false,
    'M', 'HKG', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 62.0, '62', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 70.0, '70', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 75.0, '75', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 62.0, '62', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 68.0, '68', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 101.0, '(101 RET)', true, 'RET', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 77.0, '77', false, NULL, now(), now());

  -- Competitor: Jude Nathan Wong (Rank 57)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jude Nathan Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jude Nathan Wong', 'jude-nathan-wong-8736da', '3495', 'SAF Yacht Club', 'ANGLO- CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3495'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ANGLO- CHINESE SCHOOL (JUNIOR)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 57, 646.0, 478.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 67.0, '67', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 43.0, '43', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 80.0, '(80)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 74.0, '74', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 55.0, '55', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 63.0, '63', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 62.0, '62', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 51.0, '51', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 88.0, '(88)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 36.0, '36', false, NULL, now(), now());

  -- Competitor: Kyle Jeremy Zhi Jun Soh (Rank 58)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kyle Jeremy Zhi Jun Soh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kyle Jeremy Zhi Jun Soh', 'kyle-jeremy-zhi-jun-soh-9c88dd', '3183', 'SAF Yacht Club', 'ANGLO- CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3183'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ANGLO- CHINESE SCHOOL (JUNIOR)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 58, 631.0, 479.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 68.0, '68', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 67.0, '67', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 76.0, '(76)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 57.0, '57', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 59.0, '59', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 66.0, '66', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 76.0, '(76)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 63.0, '63', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 43.0, '43', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 20.0, '20', false, NULL, now(), now());

  -- Competitor: Pornyamol Sawaengkhun (Rank 59)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Pornyamol Sawaengkhun')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Pornyamol Sawaengkhun', 'pornyamol-sawaengkhun-b8be0f', '1900', 'Yacht Racing Association of Thailand', 'SINGSAMUT SCHOOL', 'F', 'THA', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '1900'),
        club = COALESCE(sailors.club, 'Yacht Racing Association of Thailand'),
        school = COALESCE(sailors.school, 'SINGSAMUT SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'THA'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 59, 664.0, 479.0, false, false,
    'F', 'THA', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 69.0, '69', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 48.0, '48', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 65.0, '65', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 56.0, '56', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 51.0, '51', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 96.0, '(96)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 71.0, '71', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 89.0, '(89)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 46.0, '46', false, NULL, now(), now());

  -- Competitor: Jaye Xi En Low (Rank 60)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jaye Xi En Low')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jaye Xi En Low', 'jaye-xi-en-low-b72a6b', '3179', 'PAssion Wave', 'ENDEAVOUR PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3179'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'ENDEAVOUR PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 60, 660.0, 482.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 66.0, '66', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 65.0, '65', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 77.0, '(77)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 69.0, '69', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 61.0, '61', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 70.0, '70', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 101.0, '(101 DNF)', true, 'DNF', now(), now());

  -- Competitor: Luke Yi Jie Loh (Rank 61)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Luke Yi Jie Loh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Luke Yi Jie Loh', 'luke-yi-jie-loh-c243ab', '3322', 'SAF Yacht Club', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3322'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'TAO NAN SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 61, 658.0, 482.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 60.0, '60', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 51.0, '51', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 69.0, '69', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 101.0, '101 DNE', false, 'DNE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 56.0, '56', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 69.0, '69', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 75.0, '(75)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 13.0, '13', false, NULL, now(), now());

  -- Competitor: Joel Han Sheng Ong (Rank 62)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joel Han Sheng Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joel Han Sheng Ong', 'joel-han-sheng-ong-96d8c3', '2014', 'Constant Wind SeaSports', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2014'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'TAO NAN SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 62, 678.0, 487.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 43.0, '43', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 78.0, '78', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 56.0, '56', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 82.0, '82', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 57.0, '57', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 101.0, '(101 DNF)', true, 'DNF', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 54.0, '54', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 90.0, '(90)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 31.0, '31', false, NULL, now(), now());

  -- Competitor: Herng Yee Tan (Rank 63)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Herng Yee Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Herng Yee Tan', 'herng-yee-tan-08d0f6', '3000', 'SAF Yacht Club', 'ANGLO- CHINESE SCHOOL (INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3000'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ANGLO- CHINESE SCHOOL (INDEPENDENT)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 63, 693.0, 491.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 69.0, '69', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 85.0, '85', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 67.0, '67', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 61.0, '61', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 67.0, '67', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 101.0, '(101 DNF)', true, 'DNF', now(), now());

  -- Competitor: Lavene Rui Xuan Lim (Rank 64)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lavene Rui Xuan Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lavene Rui Xuan Lim', 'lavene-rui-xuan-lim-08847a', '3553', 'SAF Yacht Club', 'PASIR RIS PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3553'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'PASIR RIS PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 64, 655.0, 491.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 74.0, '74', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 49.0, '49', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 59.0, '59', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 70.0, '70', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 55.0, '55', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 79.0, '(79)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 85.0, '(85)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 57.0, '57', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 48.0, '48', false, NULL, now(), now());

  -- Competitor: Tom Griffiths (Rank 65)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tom Griffiths')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tom Griffiths', 'tom-griffiths-dbf525', '1744', 'Hunters Hill Sailing Club', 'ROZZELE PUPLIC SCHOOL', 'M', 'AUS', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '1744'),
        club = COALESCE(sailors.club, 'Hunters Hill Sailing Club'),
        school = COALESCE(sailors.school, 'ROZZELE PUPLIC SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'AUS'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 65, 690.0, 500.0, false, false,
    'M', 'AUS', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 65.0, '65', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 53.0, '53', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 63.0, '63', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 73.0, '73', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 89.0, '(89)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 67.0, '67', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 87.0, '87', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 62.0, '62', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 11.0, '11', false, NULL, now(), now());

  -- Competitor: Timothy Kai Zhe Ng (Rank 66)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Timothy Kai Zhe Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Timothy Kai Zhe Ng', 'timothy-kai-zhe-ng-894679', '2023', 'Constant Wind SeaSports', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2023'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'TAO NAN SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 66, 675.0, 500.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 78.0, '78', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 74.0, '74', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 48.0, '48', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 89.0, '(89)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 56.0, '56', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 68.0, '68', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 86.0, '(86)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 84.0, '84', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 27.0, '27', false, NULL, now(), now());

  -- Competitor: Valentina Trevino (Rank 67)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Valentina Trevino')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Valentina Trevino', 'valentina-trevino-b88558', '262', 'Royal Hong Kong Yacht Club', 'FRENCH INTERNATIONAL SCHOOL', 'F', 'MEX', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '262'),
        club = COALESCE(sailors.club, 'Royal Hong Kong Yacht Club'),
        school = COALESCE(sailors.school, 'FRENCH INTERNATIONAL SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'MEX'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 67, 673.0, 504.0, false, false,
    'F', 'MEX', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 77.0, '77', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 58.0, '58', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 55.0, '55', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 68.0, '68', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 88.0, '(88)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 81.0, '(81)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 79.0, '79', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 37.0, '37', false, NULL, now(), now());

  -- Competitor: Rui Ling Teo (Rank 68)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rui Ling Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rui Ling Teo', 'rui-ling-teo-64f76f', '3820', 'SAF Yacht Club', 'CHIJ (KATONG) PRIMARY', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3820'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'CHIJ (KATONG) PRIMARY'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 68, 685.0, 504.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 64.0, '64', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 55.0, '55', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 67.0, '67', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 80.0, '(80)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 69.0, '69', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 54.0, '54', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 61.0, '61', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 53.0, '53', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 42.0, '42', false, NULL, now(), now());

  -- Competitor: Cleo Badenach (Rank 69)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cleo Badenach')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cleo Badenach', 'cleo-badenach-aab467', '172', 'Royal Hong Kong Yacht Club', 'KELLETT SCHOOL', 'F', 'AUS', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '172'),
        club = COALESCE(sailors.club, 'Royal Hong Kong Yacht Club'),
        school = COALESCE(sailors.school, 'KELLETT SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'AUS'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 69, 707.0, 515.0, false, false,
    'F', 'AUS', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 99.0, '(99)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 83.0, '83', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 90.0, '90', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 93.0, '(93)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 83.0, '83', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 55.0, '55', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 47.0, '47', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 25.0, '25', false, NULL, now(), now());

  -- Competitor: Ravi Kumar Bennellou (Rank 70)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ravi Kumar Bennellou')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ravi Kumar Bennellou', 'ravi-kumar-bennellou-47dd77', '4008', 'Yachting Association of India', NULL, 'M', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '4008'),
        club = COALESCE(sailors.club, 'Yachting Association of India'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'IND'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 70, 710.0, 516.0, false, false,
    'M', 'IND', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 89.0, '89', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 74.0, '74', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 59.0, '59', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 93.0, '(93)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 47.0, '47', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 71.0, '71', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 59.0, '59', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 101.0, '(101 DNF)', true, 'DNF', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 52.0, '52', false, NULL, now(), now());

  -- Competitor: Chandralekha Tattari (Rank 71)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Chandralekha Tattari')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Chandralekha Tattari', 'chandralekha-tattari-ab5fb3', '1711', 'Yachting Association of India', NULL, 'F', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '1711'),
        club = COALESCE(sailors.club, 'Yachting Association of India'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'IND'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 71, 725.0, 528.0, false, false,
    'F', 'IND', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 54.0, '54', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 77.0, '77', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 96.0, '(96)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 66.0, '66', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 75.0, '75', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 71.0, '71', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 51.0, '51', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 44.0, '44', false, NULL, now(), now());

  -- Competitor: Henry Zub (Rank 72)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Henry Zub')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Henry Zub', 'henry-zub-5486cc', '1522', 'Brighton & Seacliff Yacht Club', 'BRIGHTOON SEACLITT', 'M', 'AUS', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '1522'),
        club = COALESCE(sailors.club, 'Brighton & Seacliff Yacht Club'),
        school = COALESCE(sailors.school, 'BRIGHTOON SEACLITT'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'AUS'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 72, 701.0, 535.0, false, false,
    'M', 'AUS', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 81.0, '81', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 84.0, '(84)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 54.0, '54', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 81.0, '81', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 74.0, '74', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 54.0, '54', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 53.0, '53', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 49.0, '49', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 82.0, '(82)', true, NULL, now(), now());

  -- Competitor: Raya Mithi Samson (Rank 73)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Raya Mithi Samson')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Raya Mithi Samson', 'raya-mithi-samson-cdcbde', '130', 'Philippine Sailing Association', 'RUERTO GALERA NATIONAL HIGH SCHOOL', 'F', 'PHI', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '130'),
        club = COALESCE(sailors.club, 'Philippine Sailing Association'),
        school = COALESCE(sailors.school, 'RUERTO GALERA NATIONAL HIGH SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'PHI'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 73, 708.0, 537.0, false, false,
    'F', 'PHI', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 80.0, '80', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 82.0, '82', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 69.0, '69', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 87.0, '(87)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 53.0, '53', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 84.0, '(84)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 56.0, '56', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 58.0, '58', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 64.0, '64', false, NULL, now(), now());

  -- Competitor: Padmaeja Rajakanth (Rank 74)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Padmaeja Rajakanth')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Padmaeja Rajakanth', 'padmaeja-rajakanth-4d5566', '2022', 'Constant Wind SeaSports', 'RAFFLES GIRLS'' PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2022'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'RAFFLES GIRLS'' PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 74, 718.0, 543.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 56.0, '56', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 80.0, '(80)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 66.0, '66', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 72.0, '72', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 47.0, '47', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 76.0, '76', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 65.0, '65', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 58.0, '58', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 62.0, '62', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 95.0, '(95)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 41.0, '41', false, NULL, now(), now());

  -- Competitor: Meera Srihari (Rank 75)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Meera Srihari')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Meera Srihari', 'meera-srihari-7766b6', '3889', 'SAF Yacht Club', 'RAFFLES GIRLS'' PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3889'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'RAFFLES GIRLS'' PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 75, 740.0, 555.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 91.0, '(91)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 51.0, '51', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 47.0, '47', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 82.0, '82', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 94.0, '(94)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 62.0, '62', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 72.0, '72', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 75.0, '75', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 86.0, '86', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 34.0, '34', false, NULL, now(), now());

  -- Competitor: Joshua Zhuo Xi Khoo (Rank 76)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joshua Zhuo Xi Khoo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joshua Zhuo Xi Khoo', 'joshua-zhuo-xi-khoo-36826f', '4728', 'SAF Yacht Club', 'ANGLO- CHINESE SCHOOL (INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '4728'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ANGLO- CHINESE SCHOOL (INDEPENDENT)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 76, 754.0, 556.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 93.0, '93', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 53.0, '53', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 97.0, '(97)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 58.0, '58', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 85.0, '85', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 85.0, '85', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 80.0, '80', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 101.0, '(101 DNF)', true, 'DNF', now(), now());

  -- Competitor: Jared Soon Kit Liew (Rank 77)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jared Soon Kit Liew')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jared Soon Kit Liew', 'jared-soon-kit-liew-aa578e', '2002', 'PAssion Wave', 'NGEE ANN SECONDARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2002'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'NGEE ANN SECONDARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 77, 731.0, 566.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 62.0, '62', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 81.0, '(81)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 78.0, '78', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 79.0, '79', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 49.0, '49', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 80.0, '80', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 62.0, '62', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 74.0, '74', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 84.0, '(84)', true, NULL, now(), now());

  -- Competitor: Samuel Darbyshire (Rank 78)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Samuel Darbyshire')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Samuel Darbyshire', 'samuel-darbyshire-69d2e2', '1620', 'Royal Queensland Yacht Squadron', 'ST ANDREW ANCLICAN COLLAGE', 'M', 'AUS', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '1620'),
        club = COALESCE(sailors.club, 'Royal Queensland Yacht Squadron'),
        school = COALESCE(sailors.school, 'ST ANDREW ANCLICAN COLLAGE'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'AUS'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 78, 758.0, 568.0, false, false,
    'M', 'AUS', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 65.0, '65', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 79.0, '79', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 55.0, '55', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 94.0, '(94)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 59.0, '59', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 85.0, '85', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 70.0, '70', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 56.0, '56', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 96.0, '(96)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 59.0, '59', false, NULL, now(), now());

  -- Competitor: Quintan Rupert Low (Rank 79)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Quintan Rupert Low')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Quintan Rupert Low', 'quintan-rupert-low-87501e', '4681', 'SAF Yacht Club', 'ANGLO- CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '4681'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ANGLO- CHINESE SCHOOL (JUNIOR)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 79, 747.0, 570.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 87.0, '(87)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 90.0, '(90)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 66.0, '66', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 87.0, '87', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 84.0, '84', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 59.0, '59', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 79.0, '79', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 63.0, '63', false, NULL, now(), now());

  -- Competitor: Aidan Armand Anuar (Rank 80)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aidan Armand Anuar')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aidan Armand Anuar', 'aidan-armand-anuar-a6820f', '3143', 'SAF Yacht Club', 'TANJONG KATONG PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3143'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'TANJONG KATONG PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 80, 779.0, 590.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 82.0, '82', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 56.0, '56', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 73.0, '73', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 61.0, '61', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 91.0, '(91)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 91.0, '91', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 55.0, '55', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 60.0, '60', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 98.0, '(98)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 76.0, '76', false, NULL, now(), now());

  -- Competitor: Dan Guan You Toh (Rank 81)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Dan Guan You Toh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Dan Guan You Toh', 'dan-guan-you-toh-c4ac6b', '3811', 'SAF Yacht Club', 'Maris Stella High School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3811'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'Maris Stella High School'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 81, 790.0, 602.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 76.0, '76', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 61.0, '61', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 86.0, '86', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 51.0, '51', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 65.0, '65', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 92.0, '(92)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 96.0, '(96)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 89.0, '89', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 72.0, '72', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 81.0, '81', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 21.0, '21', false, NULL, now(), now());

  -- Competitor: Yuk Pin Lim (Rank 82)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuk Pin Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuk Pin Lim', 'yuk-pin-lim-1f87d6', '3880', 'SAF Yacht Club', 'AI TONG SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3880'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'AI TONG SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 82, 824.0, 622.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 59.0, '59', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 69.0, '69', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 101.0, '(101 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 101.0, '(101 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 101.0, '101 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 101.0, '101 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 101.0, '101 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 101.0, '101 DNC', false, 'DNC', now(), now());

  -- Competitor: Xavier Yang Zheng Puah (Rank 83)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Xavier Yang Zheng Puah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Xavier Yang Zheng Puah', 'xavier-yang-zheng-puah-2fc9a2', '2037', 'Constant Wind SeaSports', 'ST. JOSEPH''S INSTITUTION JUNIOR', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2037'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'ST. JOSEPH''S INSTITUTION JUNIOR'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 83, 835.0, 648.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 86.0, '(86)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 86.0, '86', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 70.0, '70', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 57.0, '57', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 67.0, '67', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 80.0, '80', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 82.0, '82', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 81.0, '81', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 76.0, '76', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 49.0, '49', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 101.0, '(101 DNF)', true, 'DNF', now(), now());

  -- Competitor: Wenbo Yan (Rank 84)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Wenbo Yan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Wenbo Yan', 'wenbo-yan-367195', '311', 'Hebe Haven Yacht Club', 'YEW CHUNG INTERNATIONAL SCHOOL', 'M', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '311'),
        club = COALESCE(sailors.club, 'Hebe Haven Yacht Club'),
        school = COALESCE(sailors.school, 'YEW CHUNG INTERNATIONAL SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'HKG'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 84, 854.0, 652.0, false, false,
    'M', 'HKG', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 58.0, '58', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 83.0, '83', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 86.0, '86', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 78.0, '78', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 92.0, '92', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 48.0, '48', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 74.0, '74', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 83.0, '83', false, NULL, now(), now());

  -- Competitor: Charlene Heng Ning Yong (Rank 85)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Charlene Heng Ning Yong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Charlene Heng Ning Yong', 'charlene-heng-ning-yong-9c7661', '766', 'Changi Sailing Club', 'PASIR RIS PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '766'),
        club = COALESCE(sailors.club, 'Changi Sailing Club'),
        school = COALESCE(sailors.school, 'PASIR RIS PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 85, 850.0, 667.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 89.0, '89', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 90.0, '(90)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 87.0, '87', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 79.0, '79', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 84.0, '84', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 75.0, '75', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 90.0, '90', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 93.0, '(93)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 86.0, '86', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 38.0, '38', false, NULL, now(), now());

  -- Competitor: Qiheng Liu (Rank 86)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Qiheng Liu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Qiheng Liu', 'qiheng-liu-7cdac9', '236', 'Royal Hong Kong Yacht Club', 'INDEPENTS SCHOOL OF FOUNDATION', 'M', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '236'),
        club = COALESCE(sailors.club, 'Royal Hong Kong Yacht Club'),
        school = COALESCE(sailors.school, 'INDEPENTS SCHOOL OF FOUNDATION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'HKG'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 86, 868.0, 676.0, false, false,
    'M', 'HKG', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 70.0, '70', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 88.0, '88', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 83.0, '83', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 91.0, '(91)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 72.0, '72', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 79.0, '79', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 73.0, '73', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 74.0, '74', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 69.0, '69', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 68.0, '68', false, NULL, now(), now());

  -- Competitor: Aaron Zhiyi Chiang (Rank 87)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aaron Zhiyi Chiang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aaron Zhiyi Chiang', 'aaron-zhiyi-chiang-d84168', '3128', 'SAF Yacht Club', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3128'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'TAO NAN SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 87, 864.0, 682.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 92.0, '(92)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 83.0, '83', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 63.0, '63', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 86.0, '86', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 90.0, '(90)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 89.0, '89', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 88.0, '88', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 78.0, '78', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 78.0, '78', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 55.0, '55', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 62.0, '62', false, NULL, now(), now());

  -- Competitor: Euan Hao Xuan Poh (Rank 88)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Euan Hao Xuan Poh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Euan Hao Xuan Poh', 'euan-hao-xuan-poh-59e758', '2030', 'Constant Wind SeaSports', 'ST. STEPHEN''S SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2030'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'ST. STEPHEN''S SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 88, 879.0, 683.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 88.0, '88', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 79.0, '79', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 88.0, '88', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 91.0, '91', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 95.0, '(95)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 77.0, '77', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 57.0, '57', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 84.0, '84', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 63.0, '63', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 56.0, '56', false, NULL, now(), now());

  -- Competitor: Yvette Yi Min Chow (Rank 89)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yvette Yi Min Chow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yvette Yi Min Chow', 'yvette-yi-min-chow-45eecd', '3151', 'SAF Yacht Club', 'PEI HWA PRESBYTERIAN PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3151'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'PEI HWA PRESBYTERIAN PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 89, 877.0, 686.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 84.0, '84', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 77.0, '77', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 77.0, '77', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 76.0, '76', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 66.0, '66', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 94.0, '(94)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 97.0, '(97)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 64.0, '64', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 81.0, '81', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 91.0, '91', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 70.0, '70', false, NULL, now(), now());

  -- Competitor: Amy Luo (Rank 90)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Amy Luo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Amy Luo', 'amy-luo-e42c1f', '343', 'Hebe Haven Yacht Club', 'DISCOVERY COLLEGE', 'F', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '343'),
        club = COALESCE(sailors.club, 'Hebe Haven Yacht Club'),
        school = COALESCE(sailors.school, 'DISCOVERY COLLEGE'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'HKG'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 90, 893.0, 691.0, false, false,
    'F', 'HKG', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 73.0, '73', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 80.0, '80', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 76.0, '76', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 96.0, '96', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 79.0, '79', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 77.0, '77', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 83.0, '83', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 73.0, '73', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 54.0, '54', false, NULL, now(), now());

  -- Competitor: Luke Tin Fong (Rank 91)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Luke Tin Fong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Luke Tin Fong', 'luke-tin-fong-b7cdfb', '2019', 'Constant Wind SeaSports', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2019'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'TAO NAN SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 91, 890.0, 698.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 61.0, '61', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 72.0, '72', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 67.0, '67', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 71.0, '71', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 73.0, '73', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 91.0, '(91 SCP)', true, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 87.0, '87', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 90.0, '90', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 89.0, '89', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 88.0, '88', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 101.0, '(101 DNF)', true, 'DNF', now(), now());

  -- Competitor: Hagen Goh (Rank 92)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hagen Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hagen Goh', 'hagen-goh-bf94a3', '3600', 'SAF Yacht Club', 'Dover Court International School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3600'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'Dover Court International School'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 92, 891.0, 703.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 90.0, '90', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 71.0, '71', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 91.0, '(91)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 97.0, '(97)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 81.0, '81', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 65.0, '65', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 84.0, '84', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 70.0, '70', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 77.0, '77', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 85.0, '85', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 80.0, '80', false, NULL, now(), now());

  -- Competitor: Denzel Seah (Rank 93)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Denzel Seah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Denzel Seah', 'denzel-seah-4528a7', '3925', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3925'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. HILDA''S PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 93, 900.0, 705.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 83.0, '83', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 75.0, '75', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 72.0, '72', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 98.0, '(98)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 85.0, '85', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 71.0, '71', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 94.0, '94', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 97.0, '(97)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 82.0, '82', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 83.0, '83', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 60.0, '60', false, NULL, now(), now());

  -- Competitor: Gentaro Noah Lee (Rank 94)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gentaro Noah Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gentaro Noah Lee', 'gentaro-noah-lee-77d06e', '4471', 'PAssion Wave', 'ANGLO- CHINESE SCHOOL (PRIMARY)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '4471'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'ANGLO- CHINESE SCHOOL (PRIMARY)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 94, 914.0, 718.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 48.0, '48', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 66.0, '66', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 88.0, '88', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 90.0, '90', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 71.0, '71', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 78.0, '78', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 95.0, '(95)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 91.0, '91', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 93.0, '93', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 93.0, '93', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 101.0, '(101 DNS)', true, 'DNS', now(), now());

  -- Competitor: Gloria Yen Rui Kwok (Rank 95)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gloria Yen Rui Kwok')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gloria Yen Rui Kwok', 'gloria-yen-rui-kwok-c8258b', '2004', 'Constant Wind SeaSports', 'CHIJ (KATONG) PRIMARY', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2004'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'CHIJ (KATONG) PRIMARY'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 95, 945.0, 749.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 85.0, '85', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 91.0, '91', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 89.0, '89', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 92.0, '92', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 95.0, '(95)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 83.0, '83', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 86.0, '86', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 94.0, '94', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 77.0, '77', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 101.0, '(101 DNF)', true, 'DNF', now(), now());

  -- Competitor: Darryl Fok (Rank 96)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Darryl Fok')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Darryl Fok', 'darryl-fok-172850', '21', 'Royal Hong Kong Yacht Club', 'CHINESE INTERNATIONAL SCHOOL', 'M', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '21'),
        club = COALESCE(sailors.club, 'Royal Hong Kong Yacht Club'),
        school = COALESCE(sailors.school, 'CHINESE INTERNATIONAL SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'HKG'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 96, 961.0, 759.0, false, false,
    'M', 'HKG', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 96.0, '96', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 92.0, '92', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 95.0, '95 SCP', false, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 84.0, '84', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 88.0, '88', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 82.0, '82', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 74.0, '74', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 73.0, '73', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 75.0, '75', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 101.0, '(101 DNS)', true, 'DNS', now(), now());

  -- Competitor: Tianyi Huang (Rank 97)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tianyi Huang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tianyi Huang', 'tianyi-huang-95d9f8', '3438', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3438'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. HILDA''S PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 97, 958.0, 764.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 79.0, '79', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 85.0, '85', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 82.0, '82', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 93.0, '93', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 92.0, '92', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 93.0, '93', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 99.0, '(99)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 95.0, '(95)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 90.0, '90', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 92.0, '92', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 58.0, '58', false, NULL, now(), now());

  -- Competitor: Kyan Chun Hong Tan (Rank 98)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kyan Chun Hong Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kyan Chun Hong Tan', 'kyan-chun-hong-tan-31b43c', '4712', 'SAF Yacht Club', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '4712'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'TAO NAN SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 98, 967.0, 765.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 87.0, '87', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 57.0, '57', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 95.0, '95', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 86.0, '86', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 87.0, '87', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 92.0, '92', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 88.0, '88', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 94.0, '94', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 79.0, '79', false, NULL, now(), now());

  -- Competitor: Estelle Rui En Yeo (Rank 99)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Estelle Rui En Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Estelle Rui En Yeo', 'estelle-rui-en-yeo-4b3c6c', '773', 'Changi Sailing Club', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '773'),
        club = COALESCE(sailors.club, 'Changi Sailing Club'),
        school = COALESCE(sailors.school, 'ST. HILDA''S PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 99, 1000.0, 800.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 94.0, '94', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 92.0, '92', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 96.0, '96', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 99.0, '(99)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 98.0, '98', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 98.0, '98', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 98.0, '98', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 91.0, '91', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 78.0, '78', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 55.0, '55', false, NULL, now(), now());

  -- Competitor: Sage Yeh (Rank 100)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sage Yeh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sage Yeh', 'sage-yeh-dfe2f3', '796', 'Changi Sailing Club', 'PUNGGOL COVE PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '796'),
        club = COALESCE(sailors.club, 'Changi Sailing Club'),
        school = COALESCE(sailors.school, 'PUNGGOL COVE PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 100, 1030.0, 828.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 95.0, '95', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 101.0, '(101 BFD)', true, 'BFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 84.0, '84', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 100.0, '100', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 98.0, '98', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 97.0, '97', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 83.0, '83', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 82.0, '82', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 92.0, '92', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 97.0, '97', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 101.0, '(101 DNS)', true, 'DNS', now(), now());

END 71520;

-- ============================================================================
-- Regatta: Singapore National Sailing Championships 2025 (Optimist Silver) (snsc-silver-sep-25-2025-09-06)
-- ============================================================================
DO 71520
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'snsc-silver-sep-25-2025-09-06' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = 'Singapore National Sailing Championships 2025 (Optimist Silver)',
      date = '2025-09-06',
      end_date = '2025-09-09',
      boat_class = 'Optimist',
      division = 'Silver',
      total_fleet_size = 60,
      race_count = 10,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/11799/event',
      registration_url = 'https://www.sailing.org.sg/events/298131',
      schedule_notes = 'Singapore National Sailing Championships 2025 Optimist Silver fleet: 60 entries, 10 races sailed (2 discards).',
      status = 'published',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_reg_id, 'Singapore National Sailing Championships 2025 (Optimist Silver)', 'snsc-silver-sep-25-2025-09-06', '2025-09-06', '2025-09-09', 'Optimist', 'Silver', 60, 10,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation', 'https://www.racingrulesofsailing.org/documents/11799/event', 'https://www.sailing.org.sg/events/298131', 'Singapore National Sailing Championships 2025 Optimist Silver fleet: 60 entries, 10 races sailed (2 discards).', 'published', now(), now()
    );
  END IF;

  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Katelynn Kai En Lee (Rank 1)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Katelynn Kai En Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Katelynn Kai En Lee', 'katelynn-kai-en-lee-d21524', '3383', 'SAF Yacht Club', 'ST. ANTHONY''S CANOSSIAN PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3383'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. ANTHONY''S CANOSSIAN PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 1, 38.0, 21.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 7.0, '(7)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 10.0, '(10)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 1.0, '1', false, NULL, now(), now());

  -- Competitor: Weihan Mao (Rank 2)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Weihan Mao')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Weihan Mao', 'weihan-mao-a18bf2', '3619', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3619'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. HILDA''S PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 2, 47.0, 26.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 12.0, '(12)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 9.0, '(9)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 8.0, '8', false, NULL, now(), now());

  -- Competitor: Mikaela Hui Ting Wong (Rank 3)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mikaela Hui Ting Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mikaela Hui Ting Wong', 'mikaela-hui-ting-wong-abbcba', '3029', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3029'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. HILDA''S PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 3, 59.0, 29.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 11.0, '(11)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 19.0, '(19)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 6.0, '6', false, NULL, now(), now());

  -- Competitor: Joshua Zhi Kai Tan (Rank 4)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joshua Zhi Kai Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joshua Zhi Kai Tan', 'joshua-zhi-kai-tan-ed3ae4', '3036', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3036'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 4, 49.0, 29.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 9.0, '(9)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 11.0, '(11)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 4.0, '4', false, NULL, now(), now());

  -- Competitor: Boren Wang (Rank 5)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Boren Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Boren Wang', 'boren-wang-7bc535', '2039', 'PAssion Wave', 'ALEXANDRA PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2039'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'ALEXANDRA PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 5, 113.0, 39.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 61.0, '(61 DSQ)', true, 'DSQ', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 13.0, '(13)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 3.0, '3', false, NULL, now(), now());

  -- Competitor: Abby Yan Ying Chen (Rank 6)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Abby Yan Ying Chen')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Abby Yan Ying Chen', 'abby-yan-ying-chen-3d3c55', '4729', 'PAssion Wave', 'CHIJ St. Nicholas Girls'' School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '4729'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'CHIJ St. Nicholas Girls'' School'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 6, 86.0, 44.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 27.0, '(27)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 15.0, '(15)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 2.0, '2', false, NULL, now(), now());

  -- Competitor: William Poon (Rank 7)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('William Poon')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'William Poon', 'william-poon-7bfe54', '3005', 'SAF Yacht Club', 'Singapore American School', 'M', 'INA', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3005'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'Singapore American School'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'INA'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 7, 138.0, 57.0, false, false,
    'M', 'INA', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 20.0, '(20)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 61.0, '(61 RET)', true, 'RET', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 7.0, '7', false, NULL, now(), now());

  -- Competitor: Ashleigh Li Ying Teh (Rank 8)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ashleigh Li Ying Teh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ashleigh Li Ying Teh', 'ashleigh-li-ying-teh-514dd7', '788', 'SAF Yacht Club', 'TAO NAN SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '788'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'TAO NAN SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 8, 120.0, 73.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 21.0, '(21)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 26.0, '(26)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Tan Qi (Rank 9)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tan Qi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tan Qi', 'tan-qi-fb14de', '3026', 'Constant Wind SeaSports', 'TAO NAN SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3026'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'TAO NAN SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 9, 154.0, 74.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 19.0, '(19)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 61.0, '(61 UFD)', true, 'UFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Matthias Kai Lun Lee (Rank 10)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Matthias Kai Lun Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Matthias Kai Lun Lee', 'matthias-kai-lun-lee-a1b968', '3385', 'SAF Yacht Club', 'Maris Stella High School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3385'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'Maris Stella High School'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 10, 111.0, 79.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 15.0, '(15)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 17.0, '(17)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 9.0, '9', false, NULL, now(), now());

  -- Competitor: Christopher Soh (Rank 11)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Christopher Soh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Christopher Soh', 'christopher-soh-e9ded6', '3168', 'SAF Yacht Club', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3168'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'TAO NAN SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 11, 135.0, 87.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 27.0, '(27)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 12.0, '12 SCP', false, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 21.0, '(21)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Breyven Zhi Long Chan (Rank 12)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Breyven Zhi Long Chan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Breyven Zhi Long Chan', 'breyven-zhi-long-chan-3f19aa', '3338', 'SAF Yacht Club', 'ENDEAVOUR PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3338'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ENDEAVOUR PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 12, 135.0, 98.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 18.0, '(18)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 19.0, '(19)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Nigel Jiang Long Ng (Rank 13)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nigel Jiang Long Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nigel Jiang Long Ng', 'nigel-jiang-long-ng-eb721a', '3363', 'SAF Yacht Club', 'ENDEAVOUR PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3363'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ENDEAVOUR PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 13, 191.0, 102.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 28.0, '(28)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 61.0, '(61 RET)', true, 'RET', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Ivor Zhuo Xi Lee (Rank 14)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ivor Zhuo Xi Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ivor Zhuo Xi Lee', 'ivor-zhuo-xi-lee-15c902', '3306', 'SAF Yacht Club', 'ENDEAVOUR PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3306'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ENDEAVOUR PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 14, 182.0, 117.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 27.0, '(27)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 38.0, '(38)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Lucas Jun Sheng Seow (Rank 15)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lucas Jun Sheng Seow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lucas Jun Sheng Seow', 'lucas-jun-sheng-seow-717877', '2047', 'Constant Wind SeaSports', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2047'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'TAO NAN SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 15, 168.0, 118.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 25.0, '(25)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 25.0, '(25)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 10.0, '10', false, NULL, now(), now());

  -- Competitor: Hayley Kai En Tan (Rank 16)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hayley Kai En Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hayley Kai En Tan', 'hayley-kai-en-tan-9ae485', '700', 'Changi Sailing Club', 'KONG HWA SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '700'),
        club = COALESCE(sailors.club, 'Changi Sailing Club'),
        school = COALESCE(sailors.school, 'KONG HWA SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 16, 182.0, 118.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 31.0, '(31)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 33.0, '(33)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Su Yuan (Rank 17)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Su Yuan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Su Yuan', 'su-yuan-4573e4', '3043', 'SAF Yacht Club', 'CHIJ (KATONG) PRIMARY', 'F', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3043'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'CHIJ (KATONG) PRIMARY'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'CHN'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 17, 197.0, 121.0, false, false,
    'F', 'CHN', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 34.0, '(34)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 42.0, '(42)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Chloe Ariane Pitsilis (Rank 18)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Chloe Ariane Pitsilis')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Chloe Ariane Pitsilis', 'chloe-ariane-pitsilis-8d491a', '708', 'Changi Sailing Club', 'International French School (Singapore)', 'F', 'FRA', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '708'),
        club = COALESCE(sailors.club, 'Changi Sailing Club'),
        school = COALESCE(sailors.school, 'International French School (Singapore)'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'FRA'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 18, 227.0, 133.0, false, false,
    'F', 'FRA', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 33.0, '(33)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 61.0, '(61 UFD)', true, 'UFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 5.0, '5', false, NULL, now(), now());

  -- Competitor: Jan Welzl (Rank 19)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jan Welzl')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jan Welzl', 'jan-welzl-fe7790', '2033', 'Constant Wind SeaSports', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2033'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'TAO NAN SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 19, 195.0, 136.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 26.0, '(26)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 33.0, '(33)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Yan Cheng Loh (Rank 20)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yan Cheng Loh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yan Cheng Loh', 'yan-cheng-loh-b8f619', '3717', 'SAF Yacht Club', 'NAN CHIAU PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3717'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'NAN CHIAU PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 20, 209.0, 136.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 43.0, '(43)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 30.0, '(30)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Yasin Yusuf Yusfianshah (Rank 21)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yasin Yusuf Yusfianshah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yasin Yusuf Yusfianshah', 'yasin-yusuf-yusfianshah-4a7e5d', '3575', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3575'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. HILDA''S PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 21, 201.0, 136.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 34.0, '(34)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 31.0, '(31)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Tyler Koo (Rank 22)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tyler Koo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tyler Koo', 'tyler-koo-9fe93d', '996', 'Republic of Singapore Yacht Club', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '996'),
        club = COALESCE(sailors.club, 'Republic of Singapore Yacht Club'),
        school = COALESCE(sailors.school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 22, 199.0, 141.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 27.0, '(27)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 31.0, '(31)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 11.0, '11', false, NULL, now(), now());

  -- Competitor: Auwin Zhao Hong Leow (Rank 23)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Auwin Zhao Hong Leow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Auwin Zhao Hong Leow', 'auwin-zhao-hong-leow-73792d', '3405', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL (PRIMARY)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3405'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ANGLO-CHINESE SCHOOL (PRIMARY)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 23, 224.0, 144.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 40.0, '(40)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 40.0, '(40)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Hayden Zi Xuan Soh (Rank 24)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hayden Zi Xuan Soh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hayden Zi Xuan Soh', 'hayden-zi-xuan-soh-b2390b', '3838', 'SAF Yacht Club', 'WHITE SANDS PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3838'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'WHITE SANDS PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 24, 221.0, 147.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 34.0, '(34 SCP)', true, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 40.0, '(40)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Raymon Li (Rank 25)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Raymon Li')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Raymon Li', 'raymon-li-2d49d7', '3737', 'SAF Yacht Club', 'United World College of SEA', 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3737'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'United World College of SEA'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'CHN'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 25, 231.0, 149.0, false, false,
    'M', 'CHN', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 47.0, '(47)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 35.0, '(35)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Isabelle Xinyi Zhang (Rank 26)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isabelle Xinyi Zhang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isabelle Xinyi Zhang', 'isabelle-xinyi-zhang-261286', '2035', 'Constant Wind SeaSports', 'METHODIST GIRLS'' SCHOOL (PRIMARY)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2035'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'METHODIST GIRLS'' SCHOOL (PRIMARY)'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 26, 234.0, 170.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 35.0, '(35)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 29.0, '(29)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Chen-Yi Kai (Rank 27)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Chen-Yi Kai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Chen-Yi Kai', 'chen-yi-kai-84a183', '757', 'SAF Yacht Club', 'FAIRFIELD METHODIST SCHOOL (PRIMARY)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '757'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'FAIRFIELD METHODIST SCHOOL (PRIMARY)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 27, 269.0, 172.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 44.0, '(44)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 53.0, '(53 SCP)', true, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Evan En Kai Ong (Rank 28)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Evan En Kai Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Evan En Kai Ong', 'evan-en-kai-ong-45d3a5', '3955', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3955'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. HILDA''S PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 28, 266.0, 182.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 41.0, '(41 TLE)', true, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 43.0, '(43)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Aidan See Hett Yeo (Rank 29)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aidan See Hett Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aidan See Hett Yeo', 'aidan-see-hett-yeo-58713d', '3112', 'SAF Yacht Club', 'KUO CHUAN PRESBYTERIAN PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3112'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'KUO CHUAN PRESBYTERIAN PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 29, 270.0, 189.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 43.0, '(43)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 38.0, '(38)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Spencer Quek (Rank 30)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Spencer Quek')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Spencer Quek', 'spencer-quek-cb57a1', '3108', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3108'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 30, 290.0, 208.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 41.0, '(41)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 41.0, '(41)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Clara Siew Ning Ng (Rank 31)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Clara Siew Ning Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Clara Siew Ning Ng', 'clara-siew-ning-ng-6b56b9', '3739', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3739'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. HILDA''S PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 31, 288.0, 208.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 42.0, '(42)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 38.0, '(38)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Damien Seah (Rank 32)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Damien Seah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Damien Seah', 'damien-seah-d115ee', '3825', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3825'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. HILDA''S PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 32, 311.0, 209.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 55.0, '(55)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 47.0, '(47)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Ryan Feiran Zheng (Rank 33)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ryan Feiran Zheng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ryan Feiran Zheng', 'ryan-feiran-zheng-d9560a', '2045', 'Constant Wind SeaSports', 'ST. STEPHEN''S SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2045'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'ST. STEPHEN''S SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 33, 303.0, 214.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 47.0, '(47)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 42.0, '(42)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Yuki Youqi Wang (Rank 34)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuki Youqi Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuki Youqi Wang', 'yuki-youqi-wang-3c46f9', '3523', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3523'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. HILDA''S PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 34, 325.0, 226.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 56.0, '(56)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 43.0, '(43)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Moyan Han (Rank 35)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Moyan Han')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Moyan Han', 'moyan-han-fb4f57', '2042', 'Constant Wind SeaSports', 'NAN HUA PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2042'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'NAN HUA PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 35, 308.0, 231.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 41.0, '(41 TLE)', true, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 36.0, '(36)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Jade Tan (Rank 36)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jade Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jade Tan', 'jade-tan-d4e0f7', '3131', 'SAF Yacht Club', 'AI TONG SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3131'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'AI TONG SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 36, 336.0, 234.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 45.0, '(45)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 57.0, '(57 SCP)', true, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 40.0, '40 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 38.0, '38 SCP', false, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Iver Zhe Xi Lee (Rank 37)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Iver Zhe Xi Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Iver Zhe Xi Lee', 'iver-zhe-xi-lee-9d958d', '3309', 'SAF Yacht Club', 'ENDEAVOUR PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3309'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ENDEAVOUR PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 37, 346.0, 236.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 49.0, '(49)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 61.0, '(61 UFD)', true, 'UFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Ilysha Wong (Rank 38)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ilysha Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ilysha Wong', 'ilysha-wong-d6f3af', '2053', 'Constant Wind SeaSports', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2053'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 38, 340.0, 236.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 58.0, '(58 TLE)', true, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 46.0, '(46 TLE)', true, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Kai Jie Teo (Rank 39)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kai Jie Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kai Jie Teo', 'kai-jie-teo-90c9a4', '3550', 'SAF Yacht Club', 'TANJONG KATONG PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3550'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'TANJONG KATONG PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 39, 357.0, 245.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 51.0, '(51)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 61.0, '(61 DNS)', true, 'DNS', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Zachary Hoo (Rank 40)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zachary Hoo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zachary Hoo', 'zachary-hoo-2b1747', '2051', 'Constant Wind SeaSports', 'RED SWASTIKA SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2051'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'RED SWASTIKA SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 40, 333.0, 247.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 44.0, '(44)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 41.0, '41 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 42.0, '(42)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Mitchell Shi Kai Lim (Rank 41)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mitchell Shi Kai Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mitchell Shi Kai Lim', 'mitchell-shi-kai-lim-e0ca0f', '3323', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL (PRIMARY)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3323'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ANGLO-CHINESE SCHOOL (PRIMARY)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 41, 349.0, 254.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 43.0, '43', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 46.0, '(46)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 49.0, '(49)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Jiayi Du (Rank 42)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jiayi Du')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jiayi Du', 'jiayi-du-017134', '3141', 'SAF Yacht Club', 'ST. GABRIEL''S PRIMARY SCHOOL', 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3141'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. GABRIEL''S PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'CHN'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 42, 365.0, 264.0, false, false,
    'M', 'CHN', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 50.0, '(50)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 41.0, '41 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 51.0, '(51)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Yong Le Wai (Rank 43)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yong Le Wai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yong Le Wai', 'yong-le-wai-20c5a4', '3488', 'SAF Yacht Club', 'FIRST TOA PAYOH PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3488'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'FIRST TOA PAYOH PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 43, 369.0, 265.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 56.0, '(56)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 48.0, '(48)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 41.0, '41 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Kiyansh Kanishk Singh (Rank 44)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kiyansh Kanishk Singh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kiyansh Kanishk Singh', 'kiyansh-kanishk-singh-8b2494', '2046', 'Constant Wind SeaSports', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2046'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 44, 390.0, 289.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 55.0, '(55)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 43.0, '43', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 41.0, '41 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 46.0, '(46)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 18.0, '18 SCP', false, 'SCP', now(), now());

  -- Competitor: Jae Guan Yu Toh (Rank 45)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jae Guan Yu Toh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jae Guan Yu Toh', 'jae-guan-yu-toh-0c8d33', '3311', 'SAF Yacht Club', 'Maris Stella High School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3311'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'Maris Stella High School'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 45, 402.0, 297.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 53.0, '(53)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 41.0, '41 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 43.0, '43', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 46.0, '46 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 52.0, '(52)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Skyler Kang (Rank 46)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Skyler Kang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Skyler Kang', 'skyler-kang-524b74', '2041', 'Constant Wind SeaSports', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2041'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 46, 402.0, 298.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 56.0, '(56)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 41.0, '41 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 46.0, '46 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 48.0, '(48)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Enzo Kengsin Teo (Rank 47)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Enzo Kengsin Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Enzo Kengsin Teo', 'enzo-kengsin-teo-87cce7', '2044', 'Constant Wind SeaSports', 'ST. STEPHEN''S SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2044'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'ST. STEPHEN''S SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 47, 413.0, 303.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 47.0, '47', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 51.0, '(51)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 48.0, '48', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 46.0, '46 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 59.0, '(59 TLE)', true, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Asher Goh (Rank 48)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Asher Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Asher Goh', 'asher-goh-3c5037', '722', 'Changi Sailing Club', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '722'),
        club = COALESCE(sailors.club, 'Changi Sailing Club'),
        school = COALESCE(sailors.school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 48, 431.0, 317.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 47.0, '47', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 61.0, '(61 NSC)', true, 'NSC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 46.0, '46 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 48.0, '48', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 53.0, '(53)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Yahe Wang (Rank 49)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yahe Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yahe Wang', 'yahe-wang-d61fe9', '3020', 'SAF Yacht Club', 'PEI TONG PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3020'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'PEI TONG PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 49, 442.0, 320.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 61.0, '(61 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 61.0, '(61 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 61.0, '61 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Ethan Mathew (Rank 50)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ethan Mathew')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ethan Mathew', 'ethan-mathew-64c78a', '3841', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3841'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. HILDA''S PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 50, 428.0, 322.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 54.0, '(54)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 43.0, '43', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 41.0, '41 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 52.0, '(52)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 46.0, '46 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 49.0, '49', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Seraphina Kang (Rank 51)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Seraphina Kang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Seraphina Kang', 'seraphina-kang-ed7224', '2040', 'Constant Wind SeaSports', 'CHIJ OUR LADY QUEEN OF PEACE', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2040'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'CHIJ OUR LADY QUEEN OF PEACE'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 51, 444.0, 326.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 57.0, '(57)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 61.0, '(61 UFD)', true, 'UFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 47.0, '47', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 41.0, '41 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 46.0, '46 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 56.0, '56', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Ziyi Adele Chiang (Rank 52)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ziyi Adele Chiang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ziyi Adele Chiang', 'ziyi-adele-chiang-658b57', '3120', 'SAF Yacht Club', 'TAO NAN SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3120'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'TAO NAN SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 52, 448.0, 333.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 49.0, '49', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 53.0, '53', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 61.0, '(61 UFD)', true, 'UFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 46.0, '46 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 54.0, '(54)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Emil Lam (Rank 53)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Emil Lam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Emil Lam', 'emil-lam-286a00', '2049', 'Constant Wind SeaSports', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2049'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'TAO NAN SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 53, 445.0, 334.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 54.0, '(54)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 41.0, '41 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 53.0, '53', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 46.0, '46 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 57.0, '(57)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Henry Shayan Mittelhauser (Rank 54)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Henry Shayan Mittelhauser')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Henry Shayan Mittelhauser', 'henry-shayan-mittelhauser-9de34e', '2052', 'Constant Wind SeaSports', 'TANJONG KATONG PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2052'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'TANJONG KATONG PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 54, 451.0, 335.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 51.0, '51', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 49.0, '49', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 61.0, '(61 UFD)', true, 'UFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 41.0, '41 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 54.0, '54', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 46.0, '46 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 55.0, '(55)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 18.0, '18 SCP', false, 'SCP', now(), now());

  -- Competitor: You Yu Tan (Rank 55)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('You Yu Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'You Yu Tan', 'you-yu-tan-c23c5e', '3137', 'PAssion Wave', 'MERIDIAN PRIMARY SCHOOL', 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3137'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'MERIDIAN PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'CHN'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 55, 454.0, 344.0, false, false,
    'M', 'CHN', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 56.0, '(56)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 48.0, '48', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 54.0, '(54)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 41.0, '41 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 48.0, '48', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 46.0, '46 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 53.0, '53', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 49.0, '49', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 18.0, '18 SCP', false, 'SCP', now(), now());

  -- Competitor: Cadee Jia Xing See (Rank 56)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cadee Jia Xing See')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cadee Jia Xing See', 'cadee-jia-xing-see-00fae1', '3628', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3628'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. HILDA''S PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 56, 474.0, 356.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 61.0, '(61 UFD)', true, 'UFD', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 55.0, '55', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 46.0, '46 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 57.0, '(57)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 56.0, '56', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: Nadia Zahedi (Rank 57)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nadia Zahedi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nadia Zahedi', 'nadia-zahedi-6da6c0', '4724', 'PAssion Wave', 'TAO NAN SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '4724'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'TAO NAN SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 57, 477.0, 367.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 53.0, '53', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 55.0, '(55)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 54.0, '54', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 55.0, '(55)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 41.0, '41 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 46.0, '46 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 51.0, '51', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 54.0, '54', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 18.0, '18 SCP', false, 'SCP', now(), now());

  -- Competitor: Dylan Teo (Rank 58)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Dylan Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Dylan Teo', 'dylan-teo-0132a3', '3107', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3107'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. HILDA''S PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 58, 490.0, 371.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 58.0, '(58)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 57.0, '57', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 57.0, '57', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 61.0, '(61 DNS)', true, 'DNS', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 41.0, '41 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 49.0, '49', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 46.0, '46 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 58.0, '58', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13 TLE', false, 'TLE', now(), now());

  -- Competitor: An Hu (Rank 59)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('An Hu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'An Hu', 'an-hu-82658a', '2050', 'Constant Wind SeaSports', 'Singapore American School', 'F', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '2050'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'Singapore American School'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'CHN'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 59, 517.0, 395.0, false, false,
    'F', 'CHN', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 48.0, '48', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 53.0, '53', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 58.0, '58 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 41.0, '41 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 51.0, '51', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 46.0, '46 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 61.0, '(61 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 61.0, '(61 DNC)', true, 'DNC', now(), now());

  -- Competitor: Isaac Qin Ran Chiam (Rank 60)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isaac Qin Ran Chiam')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isaac Qin Ran Chiam', 'isaac-qin-ran-chiam-785c46', '3699', 'SAF Yacht Club', 'AI TONG SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '3699'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'AI TONG SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 60, 564.0, 442.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 61.0, '(61 NSC)', true, 'NSC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 61.0, '(61 NSC)', true, 'NSC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 61.0, '61 NSC', false, 'NSC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 57.0, '57 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 41.0, '41 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 61.0, '61 DNS', false, 'DNS', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 46.0, '46 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 60.0, '60 TLE', false, 'TLE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 55.0, '55', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 61.0, '61 RET', false, 'RET', now(), now());

END 71520;

-- ============================================================================
-- Regatta: Singapore National Sailing Championships 2025 (ILCA 4) (snsc-ilca-4-sep-25-2025-09-06)
-- ============================================================================
DO 71520
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'snsc-ilca-4-sep-25-2025-09-06' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = 'Singapore National Sailing Championships 2025 (ILCA 4)',
      date = '2025-09-06',
      end_date = '2025-09-09',
      boat_class = 'ILCA 4',
      division = 'Open',
      total_fleet_size = 56,
      race_count = 12,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/11799/event',
      registration_url = 'https://www.sailing.org.sg/events/298131',
      schedule_notes = 'Singapore National Sailing Championships 2025 ILCA 4 fleet: 56 entries, 12 races sailed (2 discards).',
      status = 'published',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_reg_id, 'Singapore National Sailing Championships 2025 (ILCA 4)', 'snsc-ilca-4-sep-25-2025-09-06', '2025-09-06', '2025-09-09', 'ILCA 4', 'Open', 56, 12,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation', 'https://www.racingrulesofsailing.org/documents/11799/event', 'https://www.sailing.org.sg/events/298131', 'Singapore National Sailing Championships 2025 ILCA 4 fleet: 56 entries, 12 races sailed (2 discards).', 'published', now(), now()
    );
  END IF;

  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Ian Goh (Rank 1)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ian Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ian Goh', 'ian-goh-f7d194', '222713', '222713', 'Constant Wind SeaSports', 'RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '222713'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'RAFFLES INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 1, 92.0, 37.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 31.0, '(31)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 24.0, '(24)', true, NULL, now(), now());

  -- Competitor: Nigel Xu Yuan Tan (Rank 2)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nigel Xu Yuan Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nigel Xu Yuan Tan', 'nigel-xu-yuan-tan-f2d292', '225176', '225176', 'Constant Wind SeaSports', 'ST. JOSEPH''S INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '225176'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'ST. JOSEPH''S INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 2, 130.0, 39.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 34.0, '(34)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 57.0, '(57 RET)', true, 'RET', now(), now());

  -- Competitor: Nia Zahedi (Rank 3)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nia Zahedi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nia Zahedi', 'nia-zahedi-fbcbd1', '224245', '224245', 'PAssion Wave', 'RAFFLES GIRLS'' SCHOOL (SECONDARY)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '224245'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'RAFFLES GIRLS'' SCHOOL (SECONDARY)'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 3, 90.0, 43.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 14.0, '(14)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 33.0, '(33)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 1.0, '1', false, NULL, now(), now());

  -- Competitor: Prin Subying (Rank 4)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Prin Subying')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Prin Subying', 'prin-subying-f58abc', '222687', '222687', 'Yacht Racing Association of Thailand', 'AMNUAY SILPA SCHOOL', 'F', 'THA', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '222687'),
        club = COALESCE(sailors.club, 'Yacht Racing Association of Thailand'),
        school = COALESCE(sailors.school, 'AMNUAY SILPA SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'THA'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 4, 84.0, 46.0, false, false,
    'F', 'THA', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 16.0, '(16)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 22.0, '(22)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 6.0, '6', false, NULL, now(), now());

  -- Competitor: Darwin Hsu (Rank 5)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Darwin Hsu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Darwin Hsu', 'darwin-hsu-d36edd', '225985', '225985', 'Yacht Racing Association of Thailand', NULL, 'M', 'THA', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '225985'),
        club = COALESCE(sailors.club, 'Yacht Racing Association of Thailand'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'THA'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 5, 88.0, 55.0, false, false,
    'M', 'THA', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 22.0, '(22)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 11.0, '(11)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 7.0, '7', false, NULL, now(), now());

  -- Competitor: Zachary Weikai Wong (Rank 6)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zachary Weikai Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zachary Weikai Wong', 'zachary-weikai-wong-c499d9', '221061', '221061', 'Royal Varuna Yacht Club', 'ANGLO-CHINESE SCHOOL (INTERNATIONAL)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '221061'),
        club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
        school = COALESCE(sailors.school, 'ANGLO-CHINESE SCHOOL (INTERNATIONAL)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 6, 153.0, 72.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 46.0, '(46)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 35.0, '(35)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 22.0, '22', false, NULL, now(), now());

  -- Competitor: Austin Jia Yu Yeo (Rank 7)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Austin Jia Yu Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Austin Jia Yu Yeo', 'austin-jia-yu-yeo-a86756', '221062', '221062', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL (INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '221062'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ANGLO-CHINESE SCHOOL (INDEPENDENT)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 7, 114.0, 75.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 12.0, '(12)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 27.0, '(27)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 3.0, '3', false, NULL, now(), now());

  -- Competitor: Hussaluk Srinakorn (Rank 8)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hussaluk Srinakorn')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hussaluk Srinakorn', 'hussaluk-srinakorn-d1dc93', '217453', '217453', 'Yacht Racing Association of Thailand', NULL, 'M', 'THA', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '217453'),
        club = COALESCE(sailors.club, 'Yacht Racing Association of Thailand'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'THA'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 8, 112.0, 76.0, false, false,
    'M', 'THA', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 15.0, '(15)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 21.0, '(21)', true, NULL, now(), now());

  -- Competitor: Ikuto Mori (Rank 9)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ikuto Mori')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ikuto Mori', 'ikuto-mori-7e1c13', '221687', '221687', 'Changi Sailing Club', 'VICTORIA SCHOOL', 'M', 'JPN', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '221687'),
        club = COALESCE(sailors.club, 'Changi Sailing Club'),
        school = COALESCE(sailors.school, 'VICTORIA SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'JPN'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 9, 126.0, 93.0, false, false,
    'M', 'JPN', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 17.0, '(17)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 16.0, '(16)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 5.0, '5', false, NULL, now(), now());

  -- Competitor: Sharanya Yuvaraj Jadhav (Rank 10)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sharanya Yuvaraj Jadhav')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sharanya Yuvaraj Jadhav', 'sharanya-yuvaraj-jadhav-dc7df0', '222622', '222622', 'Yachting Association of India', NULL, 'M', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '222622'),
        club = COALESCE(sailors.club, 'Yachting Association of India'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'IND'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 10, 161.0, 97.0, false, false,
    'M', 'IND', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 27.0, '(27)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 37.0, '(37)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 10.0, '10', false, NULL, now(), now());

  -- Competitor: Pinchanok Klaysomboon (Rank 11)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Pinchanok Klaysomboon')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Pinchanok Klaysomboon', 'pinchanok-klaysomboon-c0dc48', '217386', '217386', 'Yacht Racing Association of Thailand', 'GSIS', 'F', 'THA', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '217386'),
        club = COALESCE(sailors.club, 'Yacht Racing Association of Thailand'),
        school = COALESCE(sailors.school, 'GSIS'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'THA'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 11, 168.0, 112.0, false, false,
    'F', 'THA', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 26.0, '(26)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 30.0, '(30)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 13.0, '13', false, NULL, now(), now());

  -- Competitor: Caleb Peck (Rank 12)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Caleb Peck')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Caleb Peck', 'caleb-peck-b1e2c4', '225221', '225221', 'PAssion Wave', 'RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '225221'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'RAFFLES INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 12, 153.0, 112.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 18.0, '(18)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 23.0, '(23)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 18.0, '18', false, NULL, now(), now());

  -- Competitor: Mika Tew (Rank 13)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mika Tew')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mika Tew', 'mika-tew-3f7a05', '219762', '219762', 'PAssion Wave', 'RAFFLES GIRLS'' SCHOOL (SECONDARY)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '219762'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'RAFFLES GIRLS'' SCHOOL (SECONDARY)'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 13, 200.0, 135.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 37.0, '(37)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 28.0, '(28)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 25.0, '25', false, NULL, now(), now());

  -- Competitor: Yuk Jun Lim (Rank 14)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuk Jun Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuk Jun Lim', 'yuk-jun-lim-9256a5', '225182', '225182', 'SAF Yacht Club', 'ST. JOSEPH''S INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '225182'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. JOSEPH''S INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 14, 212.0, 139.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 39.0, '(39)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 34.0, '(34)', true, NULL, now(), now());

  -- Competitor: Zildjan Martin Samson (Rank 15)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zildjan Martin Samson')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zildjan Martin Samson', 'zildjan-martin-samson-115bb8', '225460', '225460', 'Philippine Sailing Association', 'PUERTO GALERA', 'M', 'PHI', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '225460'),
        club = COALESCE(sailors.club, 'Philippine Sailing Association'),
        school = COALESCE(sailors.school, 'PUERTO GALERA'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'PHI'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 15, 207.0, 151.0, false, false,
    'M', 'PHI', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 17.0, '17 SCP', false, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 27.0, '(27)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 29.0, '(29)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 2.0, '2', false, NULL, now(), now());

  -- Competitor: Ramakant Ramakant (Rank 16)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ramakant Ramakant')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ramakant Ramakant', 'ramakant-ramakant-255d81', '211783', '211783', 'Yachting Association of India', NULL, 'M', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '211783'),
        club = COALESCE(sailors.club, 'Yachting Association of India'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'IND'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 16, 241.0, 171.0, false, false,
    'M', 'IND', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 29.0, '(29)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 41.0, '(41)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 4.0, '4', false, NULL, now(), now());

  -- Competitor: Jonathan Jian Yi Ho (Rank 17)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jonathan Jian Yi Ho')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jonathan Jian Yi Ho', 'jonathan-jian-yi-ho-b94bdc', '214848', '214848', 'PAssion Wave', 'ANGLO-CHINESE SCHOOL (INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '214848'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'ANGLO-CHINESE SCHOOL (INDEPENDENT)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 17, 282.0, 188.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 57.0, '(57 RET)', true, 'RET', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 35.0, '35 SCP', false, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 37.0, '(37)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 17.0, '17', false, NULL, now(), now());

  -- Competitor: Febe Qi Ke Wong (Rank 18)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Febe Qi Ke Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Febe Qi Ke Wong', 'febe-qi-ke-wong-e4ddd4', '225224', '225224', 'SAF Yacht Club', 'CHIJ ST. THERESA''S CONVENT', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '225224'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'CHIJ ST. THERESA''S CONVENT'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 18, 264.0, 194.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 30.0, '(30)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 40.0, '(40)', true, NULL, now(), now());

  -- Competitor: Aastha Pandey (Rank 19)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aastha Pandey')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aastha Pandey', 'aastha-pandey-5f05a8', '210431', '210431', 'Yachting Association of India', NULL, 'F', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '210431'),
        club = COALESCE(sailors.club, 'Yachting Association of India'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'IND'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 19, 268.0, 197.0, false, false,
    'F', 'IND', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 31.0, '(31)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 40.0, '(40)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 9.0, '9', false, NULL, now(), now());

  -- Competitor: Man Chak Cheung (Rank 20)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Man Chak Cheung')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Man Chak Cheung', 'man-chak-cheung-476047', '190912', '190912', 'Hebe Haven Yacht Club', NULL, 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '190912'),
        club = COALESCE(sailors.club, 'Hebe Haven Yacht Club'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'CHN'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 20, 310.0, 202.0, false, false,
    'M', 'CHN', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 54.0, '(54)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 54.0, '(54)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 11.0, '11', false, NULL, now(), now());

  -- Competitor: Mildred Li Xuan Wong (Rank 21)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mildred Li Xuan Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mildred Li Xuan Wong', 'mildred-li-xuan-wong-6b37f5', '223200', '223200', 'Constant Wind SeaSports', 'RAFFLES GIRLS'' SCHOOL (SECONDARY)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '223200'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'RAFFLES GIRLS'' SCHOOL (SECONDARY)'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 21, 283.0, 202.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 43.0, '(43)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 38.0, '(38)', true, NULL, now(), now());

  -- Competitor: Kayden Yi Kai Tan (Rank 22)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kayden Yi Kai Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kayden Yi Kai Tan', 'kayden-yi-kai-tan-7781d7', '197424', '197424', 'SAF Yacht Club', 'ST. ANDREW''S SECONDARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '197424'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ST. ANDREW''S SECONDARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 22, 280.0, 206.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 35.0, '(35)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 39.0, '(39)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 57.0, '57 DNE', false, 'DNE', now(), now());

  -- Competitor: Isaiah Chor Hong Yap (Rank 23)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isaiah Chor Hong Yap')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isaiah Chor Hong Yap', 'isaiah-chor-hong-yap-c4b980', '227463', '227463', 'Changi Sailing Club', 'XINMIN SECONDARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '227463'),
        club = COALESCE(sailors.club, 'Changi Sailing Club'),
        school = COALESCE(sailors.school, 'XINMIN SECONDARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 23, 315.0, 227.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 45.0, '(45)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 43.0, '(43)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 29.0, '29', false, NULL, now(), now());

  -- Competitor: Kate Zi Ning Yeh (Rank 24)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kate Zi Ning Yeh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kate Zi Ning Yeh', 'kate-zi-ning-yeh-421a81', '222437', '222437', 'Changi Sailing Club', 'NORTH VISTA SECONDARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '222437'),
        club = COALESCE(sailors.club, 'Changi Sailing Club'),
        school = COALESCE(sailors.school, 'NORTH VISTA SECONDARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 24, 310.0, 227.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 42.0, '(42)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 41.0, '(41)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 14.0, '14', false, NULL, now(), now());

  -- Competitor: Eunice Yi Ning Tan (Rank 25)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Eunice Yi Ning Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Eunice Yi Ning Tan', 'eunice-yi-ning-tan-da78dd', '224664', '224664', 'SAF Yacht Club', 'DUNMAN HIGH SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '224664'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'DUNMAN HIGH SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 25, 326.0, 231.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 38.0, '(38)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 57.0, '(57 RET)', true, 'RET', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 30.0, '30', false, NULL, now(), now());

  -- Competitor: Joash Jing En Tan (Rank 26)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joash Jing En Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joash Jing En Tan', 'joash-jing-en-tan-80d551', '209051', '209051', 'ONE°15 Marina Club', 'VICTORIA SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '209051'),
        club = COALESCE(sailors.club, 'ONE°15 Marina Club'),
        school = COALESCE(sailors.school, 'VICTORIA SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 26, 330.0, 242.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 20.0, '20 SCP', false, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 36.0, '(36)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 52.0, '(52)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 27.0, '27', false, NULL, now(), now());

  -- Competitor: Cory Zhi Hang Loh (Rank 27)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cory Zhi Hang Loh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cory Zhi Hang Loh', 'cory-zhi-hang-loh-02c08b', '226899', '226899', 'SAF Yacht Club', 'ADMIRALTY PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '226899'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ADMIRALTY PRIMARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 27, 350.0, 244.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 57.0, '(57 DSQ)', true, 'DSQ', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 49.0, '(49)', true, NULL, now(), now());

  -- Competitor: Nina Wang (Rank 28)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nina Wang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nina Wang', 'nina-wang-086be9', '221551', '221551', 'Queensland Sea Scouts', NULL, 'F', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '221551'),
        club = COALESCE(sailors.club, 'Queensland Sea Scouts'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'CHN'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 28, 340.0, 248.0, false, false,
    'F', 'CHN', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 44.0, '(44)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 48.0, '(48)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 12.0, '12', false, NULL, now(), now());

  -- Competitor: Kai Lun Wong (Rank 29)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kai Lun Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kai Lun Wong', 'kai-lun-wong-75993d', '214779', '214779', 'PAssion Wave', 'BOWEN SECONDARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '214779'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'BOWEN SECONDARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 29, 349.0, 253.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 48.0, '(48)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 48.0, '(48)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 8.0, '8', false, NULL, now(), now());

  -- Competitor: Huanran Zheng (Rank 30)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Huanran Zheng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Huanran Zheng', 'huanran-zheng-6e2247', '209319', '209319', 'Royal Hong Kong Yacht Club', NULL, 'F', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '209319'),
        club = COALESCE(sailors.club, 'Royal Hong Kong Yacht Club'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'HKG'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 30, 351.0, 262.0, false, false,
    'F', 'HKG', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 42.0, '(42)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 47.0, '(47)', true, NULL, now(), now());

  -- Competitor: Reyes Jit Eng Tan (Rank 31)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Reyes Jit Eng Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Reyes Jit Eng Tan', 'reyes-jit-eng-tan-280de2', '214251', '214251', 'Changi Sailing Club', 'DUNMAN HIGH SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '214251'),
        club = COALESCE(sailors.club, 'Changi Sailing Club'),
        school = COALESCE(sailors.school, 'DUNMAN HIGH SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 31, 359.0, 272.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 47.0, '(47)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 40.0, '(40)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 20.0, '20', false, NULL, now(), now());

  -- Competitor: Jayden Zi Xi Bai (Rank 32)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jayden Zi Xi Bai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jayden Zi Xi Bai', 'jayden-zi-xi-bai-129b41', '225261', '225261', 'PAssion Wave', 'ST. JOSEPH''S INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '225261'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'ST. JOSEPH''S INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 32, 388.0, 285.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 57.0, '(57 DSQ)', true, 'DSQ', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 43.0, '43', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 46.0, '(46)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 33.0, '33', false, NULL, now(), now());

  -- Competitor: Heng Yi Yong (Rank 33)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Heng Yi Yong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Heng Yi Yong', 'heng-yi-yong-bb6725', '225259', '225259', 'Changi Sailing Club', 'LOYANG VIEW SECONDARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '225259'),
        club = COALESCE(sailors.club, 'Changi Sailing Club'),
        school = COALESCE(sailors.school, 'LOYANG VIEW SECONDARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 33, 394.0, 295.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 51.0, '(51)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 48.0, '(48)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 32.0, '32', false, NULL, now(), now());

  -- Competitor: Amandine Zoe Pitsilis (Rank 34)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Amandine Zoe Pitsilis')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Amandine Zoe Pitsilis', 'amandine-zoe-pitsilis-aea915', '219725', '219725', 'Changi Sailing Club', 'INTERNATIONAL FRENCH SCHOOL', 'F', 'FRA', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '219725'),
        club = COALESCE(sailors.club, 'Changi Sailing Club'),
        school = COALESCE(sailors.school, 'INTERNATIONAL FRENCH SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'FRA'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 34, 390.0, 296.0, false, false,
    'F', 'FRA', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 43.0, '(43)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 51.0, '(51)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 42.0, '42', false, NULL, now(), now());

  -- Competitor: Josiah Zhi En Tan (Rank 35)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Josiah Zhi En Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Josiah Zhi En Tan', 'josiah-zhi-en-tan-3493aa', '21248', '21248', 'ONE°15 Marina Club', 'VICTORIA SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '21248'),
        club = COALESCE(sailors.club, 'ONE°15 Marina Club'),
        school = COALESCE(sailors.school, 'VICTORIA SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 35, 406.0, 301.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 48.0, '(48)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 57.0, '(57 RET)', true, 'RET', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 41.0, '41', false, NULL, now(), now());

  -- Competitor: Katyayani Kaushik (Rank 36)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Katyayani Kaushik')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Katyayani Kaushik', 'katyayani-kaushik-292ace', '211801', '211801', 'Yachting Association of India', 'NAVY CHILDREN SCHOOL', 'F', 'IND', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '211801'),
        club = COALESCE(sailors.club, 'Yachting Association of India'),
        school = COALESCE(sailors.school, 'NAVY CHILDREN SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'IND'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 36, 443.0, 341.0, false, false,
    'F', 'IND', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 53.0, '(53)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 49.0, '(49)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 43.0, '43', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 31.0, '31', false, NULL, now(), now());

  -- Competitor: Josh Ong Yong Jun (Rank 37)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Josh Ong Yong Jun')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Josh Ong Yong Jun', 'josh-ong-yong-jun-62a7f4', '217034', '217034', 'SAF Yacht Club', 'VICTORIA SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '217034'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'VICTORIA SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 37, 447.0, 344.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 51.0, '(51)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 52.0, '(52)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 48.0, '48', false, NULL, now(), now());

  -- Competitor: Jade Zi Yu Yeh (Rank 38)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jade Zi Yu Yeh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jade Zi Yu Yeh', 'jade-zi-yu-yeh-81f981', '227609', '227609', 'Changi Sailing Club', 'NORTH VISTA SECONDARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '227609'),
        club = COALESCE(sailors.club, 'Changi Sailing Club'),
        school = COALESCE(sailors.school, 'NORTH VISTA SECONDARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 38, 454.0, 353.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 47.0, '47', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 52.0, '(52)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 49.0, '(49)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 47.0, '47', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 37.0, '37', false, NULL, now(), now());

  -- Competitor: Travis Jia Le Yeo (Rank 39)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Travis Jia Le Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Travis Jia Le Yeo', 'travis-jia-le-yeo-ad0c9e', '223728', '223728', 'SAF Yacht Club', 'RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '223728'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'RAFFLES INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 39, 451.0, 354.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 50.0, '(50)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 47.0, '(47)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 36.0, '36', false, NULL, now(), now());

  -- Competitor: John Raphael Lim (Rank 40)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('John Raphael Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'John Raphael Lim', 'john-raphael-lim-da21e4', '206799', '206799', 'Changi Sailing Club', 'ST. PATRICK''S SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '206799'),
        club = COALESCE(sailors.club, 'Changi Sailing Club'),
        school = COALESCE(sailors.school, 'ST. PATRICK''S SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 40, 457.0, 355.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 43.0, '43', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 43.0, '43', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 50.0, '(50)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 47.0, '47', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 52.0, '(52)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 26.0, '26', false, NULL, now(), now());

  -- Competitor: James Kong (Rank 41)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('James Kong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'James Kong', 'james-kong-d415e7', '212216', '212216', 'PAssion Wave', 'DUNMAN HIGH SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '212216'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'DUNMAN HIGH SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 41, 463.0, 366.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 49.0, '(49)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 48.0, '(48)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 15.0, '15', false, NULL, now(), now());

  -- Competitor: Callum Joon Thang Wong (Rank 42)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Callum Joon Thang Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Callum Joon Thang Wong', 'callum-joon-thang-wong-00e494', '214748', '214748', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL (INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '214748'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ANGLO-CHINESE SCHOOL (INDEPENDENT)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 42, 480.0, 366.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 57.0, '(57 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 57.0, '(57 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 57.0, '57 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 57.0, '57 RET', false, 'RET', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 24.0, '24', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 39.0, '39', false, NULL, now(), now());

  -- Competitor: Charlie Cheung (Rank 43)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Charlie Cheung')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Charlie Cheung', 'charlie-cheung-a0f464', '213350', '213350', 'Royal Hong Kong Yacht Club', 'ISLAND SCHOOL', 'F', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '213350'),
        club = COALESCE(sailors.club, 'Royal Hong Kong Yacht Club'),
        school = COALESCE(sailors.school, 'ISLAND SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'HKG'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 43, 463.0, 367.0, false, false,
    'F', 'HKG', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 47.0, '(47)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 49.0, '(49 SCP)', true, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 47.0, '47', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 47.0, '47', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 19.0, '19', false, NULL, now(), now());

  -- Competitor: Tony Ma (Rank 44)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tony Ma')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tony Ma', 'tony-ma-86795c', '228895', '228895', 'Chinese Yachting Association', NULL, 'M', 'CHN', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '228895'),
        club = COALESCE(sailors.club, 'Chinese Yachting Association'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'CHN'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 44, 467.0, 368.0, false, false,
    'M', 'CHN', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 35.0, '35 SCP', false, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 22.0, '22', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 57.0, '57 DNE', false, 'DNE', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 50.0, '(50)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 49.0, '(49)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 16.0, '16', false, NULL, now(), now());

  -- Competitor: Lyora Wallier (Rank 45)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lyora Wallier')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lyora Wallier', 'lyora-wallier-8976d0', '213316', '213316', 'Royal Hong Kong Yacht Club', 'ELSA CARMEL HIGH SCHOOL', 'F', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '213316'),
        club = COALESCE(sailors.club, 'Royal Hong Kong Yacht Club'),
        school = COALESCE(sailors.school, 'ELSA CARMEL HIGH SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'HKG'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 45, 466.0, 370.0, false, false,
    'F', 'HKG', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 45.0, '45 SCP', false, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 47.0, '(47)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 49.0, '(49)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 43.0, '43', false, NULL, now(), now());

  -- Competitor: Isla Zhi Xi Lee (Rank 46)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isla Zhi Xi Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isla Zhi Xi Lee', 'isla-zhi-xi-lee-1fb1c0', '203535', '203535', 'SAF Yacht Club', 'CHUNG CHENG HIGH SCHOOL (YISHUN)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '203535'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'CHUNG CHENG HIGH SCHOOL (YISHUN)'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 46, 474.0, 373.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 48.0, '48', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 51.0, '(51)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 21.0, '21', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 50.0, '(50)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 23.0, '23', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 44.0, '44', false, NULL, now(), now());

  -- Competitor: Nicholas Jiang En Ng (Rank 47)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nicholas Jiang En Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nicholas Jiang En Ng', 'nicholas-jiang-en-ng-68400b', '209042', '209042', 'SAF Yacht Club', 'YISHUN TOWN SECONDARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '209042'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'YISHUN TOWN SECONDARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 47, 484.0, 382.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 32.0, '32', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 25.0, '25', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 48.0, '(48)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 43.0, '43', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 54.0, '(54)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 46.0, '46', false, NULL, now(), now());

  -- Competitor: Lauren Lim (Rank 48)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lauren Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lauren Lim', 'lauren-lim-c5d326', '216431', '216431', 'SAF Yacht Club', 'WHITLEY SECONDARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '216431'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'WHITLEY SECONDARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 48, 494.0, 390.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 33.0, '33', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 48.0, '48', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 54.0, '(54)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 43.0, '43', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 26.0, '26', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 30.0, '30', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 50.0, '(50)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 45.0, '45', false, NULL, now(), now());

  -- Competitor: Cecilia Sze Sen Kong (Rank 49)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cecilia Sze Sen Kong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cecilia Sze Sen Kong', 'cecilia-sze-sen-kong-3ae5f5', '221688', '221688', 'Changi Sailing Club', 'NATIONAL JUNIOR COLLEGE', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '221688'),
        club = COALESCE(sailors.club, 'Changi Sailing Club'),
        school = COALESCE(sailors.school, 'NATIONAL JUNIOR COLLEGE'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 49, 505.0, 398.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 34.0, '34', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 53.0, '(53)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 51.0, '51', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 51.0, '51', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 54.0, '(54)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 23.0, '23', false, NULL, now(), now());

  -- Competitor: Mathias Cheow (Rank 50)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mathias Cheow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mathias Cheow', 'mathias-cheow-8f3785', '225167', '225167', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL (BARKER ROAD)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '225167'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ANGLO-CHINESE SCHOOL (BARKER ROAD)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 50, 551.0, 441.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 37.0, '37', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 55.0, '(55 SCP)', true, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 45.0, '45', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 39.0, '39', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 28.0, '28', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 55.0, '(55)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 55.0, '55', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 55.0, '55', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 51.0, '51', false, NULL, now(), now());

  -- Competitor: Kye Tang (Rank 51)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kye Tang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kye Tang', 'kye-tang-3b97fc', '226900', '226900', 'Constant Wind SeaSports', 'RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '226900'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'RAFFLES INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 51, 560.0, 450.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 35.0, '35', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 55.0, '(55)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 55.0, '(55)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 51.0, '51', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 44.0, '44', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 31.0, '31', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 49.0, '49', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 50.0, '50', false, NULL, now(), now());

  -- Competitor: Jonathan Kum Loong Kwok (Rank 52)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jonathan Kum Loong Kwok')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jonathan Kum Loong Kwok', 'jonathan-kum-loong-kwok-ce8d79', '214808', '214808', 'Constant Wind SeaSports', 'ST. JOSEPH''S INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '214808'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'ST. JOSEPH''S INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 52, 563.0, 458.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 49.0, '49', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 38.0, '38', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 46.0, '46', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 51.0, '51', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 53.0, '(53)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 49.0, '49', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 48.0, '48', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 36.0, '36', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 52.0, '(52)', true, NULL, now(), now());

  -- Competitor: Angela Fei'er Huang (Rank 53)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Angela Fei''er Huang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Angela Fei''er Huang', 'angela-fei-er-huang-c7d688', '213191', '213191', 'SAF Yacht Club', 'ROSYTH SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '213191'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ROSYTH SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 53, 582.0, 468.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 57.0, '(57 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 57.0, '(57 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 57.0, '57 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 29.0, '29', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 51.0, '51', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 57.0, '57 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 57.0, '57 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 57.0, '57 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 57.0, '57 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 27.0, '27', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 35.0, '35', false, NULL, now(), now());

  -- Competitor: Alaric Shenthil Naidu (Rank 54)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Alaric Shenthil Naidu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Alaric Shenthil Naidu', 'alaric-shenthil-naidu-9f8bd6', '170299', '170299', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL (BARKER ROAD)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '170299'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'ANGLO-CHINESE SCHOOL (BARKER ROAD)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 54, 588.0, 474.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 40.0, '40', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 43.0, '43', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 42.0, '42', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 49.0, '49', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 54.0, '54', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 53.0, '53', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 57.0, '(57 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 57.0, '(57 DNC)', true, 'DNC', now(), now());

  -- Competitor: Noel Jiang Wen Ng (Rank 55)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Noel Jiang Wen Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Noel Jiang Wen Ng', 'noel-jiang-wen-ng-685769', '193911', '193911', 'SAF Yacht Club', 'CHUNG CHENG HIGH SCHOOL (YISHUN)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '193911'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'CHUNG CHENG HIGH SCHOOL (YISHUN)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 55, 605.0, 497.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 53.0, '(53)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 51.0, '51', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 49.0, '49', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 53.0, '53', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 55.0, '(55)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 41.0, '41', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 48.0, '48', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 51.0, '51', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 47.0, '47', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 53.0, '53', false, NULL, now(), now());

  -- Competitor: Roahnne Roy Santos (Rank 56)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Roahnne Roy Santos')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Roahnne Roy Santos', 'roahnne-roy-santos-e4224f', '225543', '225543', 'Philippine Sailing Association', NULL, 'M', 'PHI', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '225543'),
        club = COALESCE(sailors.club, 'Philippine Sailing Association'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'PHI'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 56, 610.0, 498.0, false, false,
    'M', 'PHI', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 54.0, '54', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 52.0, '52', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 53.0, '53', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 56.0, '(56)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 56.0, '(56)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 54.0, '54', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 54.0, '54', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 47.0, '47', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 53.0, '53', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 50.0, '50', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 53.0, '53', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 28.0, '28', false, NULL, now(), now());

END 71520;

-- ============================================================================
-- Regatta: Singapore National Sailing Championships 2025 (ILCA 6) (snsc-ilca-6-sep-25-2025-09-06)
-- ============================================================================
DO 71520
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'snsc-ilca-6-sep-25-2025-09-06' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = 'Singapore National Sailing Championships 2025 (ILCA 6)',
      date = '2025-09-06',
      end_date = '2025-09-09',
      boat_class = 'ILCA 6',
      division = 'Open',
      total_fleet_size = 22,
      race_count = 12,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/11799/event',
      registration_url = 'https://www.sailing.org.sg/events/298131',
      schedule_notes = 'Singapore National Sailing Championships 2025 ILCA 6 fleet: 22 entries, 12 races sailed (2 discards).',
      status = 'published',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_reg_id, 'Singapore National Sailing Championships 2025 (ILCA 6)', 'snsc-ilca-6-sep-25-2025-09-06', '2025-09-06', '2025-09-09', 'ILCA 6', 'Open', 22, 12,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation', 'https://www.racingrulesofsailing.org/documents/11799/event', 'https://www.sailing.org.sg/events/298131', 'Singapore National Sailing Championships 2025 ILCA 6 fleet: 22 entries, 12 races sailed (2 discards).', 'published', now(), now()
    );
  END IF;

  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Kenan Kee Zen Tan (Rank 1)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kenan Kee Zen Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kenan Kee Zen Tan', 'kenan-kee-zen-tan-adcaca', '1', 'Royal Varuna Yacht Club', 'ST. JOSEPH''S INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '1'),
        club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
        school = COALESCE(sailors.school, 'ST. JOSEPH''S INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 1, 23.0, 15.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 4.0, '(4)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 4.0, '(4)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 1.0, '1', false, NULL, now(), now());

  -- Competitor: Jania Ang (Rank 2)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jania Ang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jania Ang', 'jania-ang-2df062', '222727', 'PAssion Wave', NULL, 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '222727'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 2, 57.0, 28.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 4.0, '4 SCP', false, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 6.0, '(6)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 23.0, '(23 DNF)', true, 'DNF', now(), now());

  -- Competitor: Noppassorn Khunboonjan (Rank 3)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Noppassorn Khunboonjan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Noppassorn Khunboonjan', 'noppassorn-khunboonjan-7c3c0b', '217427', 'Yacht Racing Association of Thailand', NULL, 'F', 'THA', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '217427'),
        club = COALESCE(sailors.club, 'Yacht Racing Association of Thailand'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'THA'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 3, 57.0, 38.0, false, false,
    'F', 'THA', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 12.0, '(12)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 7.0, '(7)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 5.0, '5', false, NULL, now(), now());

  -- Competitor: Keira Carlyle (Rank 4)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Keira Carlyle')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Keira Carlyle', 'keira-carlyle-af6543', '225225', 'SAF Yacht Club', 'NANYANG POLYTECHNIC', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '225225'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'NANYANG POLYTECHNIC'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 4, 67.0, 40.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 10.0, '(10)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 17.0, '(17)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 4.0, '4', false, NULL, now(), now());

  -- Competitor: Aurick You Shun Leow (Rank 5)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aurick You Shun Leow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aurick You Shun Leow', 'aurick-you-shun-leow-8d0df1', '67', 'SAF Yacht Club', 'RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '67'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'RAFFLES INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 5, 78.0, 46.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 23.0, '(23 DSQ)', true, 'DSQ', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 9.0, '(9)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 2.0, '2', false, NULL, now(), now());

  -- Competitor: Asher James Nair (Rank 6)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Asher James Nair')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Asher James Nair', 'asher-james-nair-39ed80', '185201', 'PAssion Wave', 'ST. JOSEPH''S INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '185201'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'ST. JOSEPH''S INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 6, 95.0, 69.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 13.0, '(13)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 7.0, '7 SCP', false, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 13.0, '(13)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 3.0, '3', false, NULL, now(), now());

  -- Competitor: Sarah Rui-En Yong (Rank 7)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sarah Rui-En Yong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sarah Rui-En Yong', 'sarah-rui-en-yong-8386b6', '18', 'Royal Varuna Yacht Club', NULL, 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '18'),
        club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 7, 99.0, 72.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 13.0, '(13)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 14.0, '(14)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 7.0, '7', false, NULL, now(), now());

  -- Competitor: Gordon Alexander Allan (Rank 8)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gordon Alexander Allan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gordon Alexander Allan', 'gordon-alexander-allan-de7475', '221058', 'Royal Varuna Yacht Club', 'ANGLO-CHINESE SCHOOL (INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '221058'),
        club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
        school = COALESCE(sailors.school, 'ANGLO-CHINESE SCHOOL (INDEPENDENT)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 8, 102.0, 77.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 13.0, '(13)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 12.0, '(12)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 6.0, '6', false, NULL, now(), now());

  -- Competitor: Danielle Lai (Rank 9)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Danielle Lai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Danielle Lai', 'danielle-lai-8e65ad', '222257', 'Royal Varuna Yacht Club', 'TANJONG KATONG GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '222257'),
        club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
        school = COALESCE(sailors.school, 'TANJONG KATONG GIRLS'' SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 9, 101.0, 80.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 10.0, '(10)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 11.0, '(11)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 8.0, '8', false, NULL, now(), now());

  -- Competitor: Yuei Jit Foo (Rank 10)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuei Jit Foo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuei Jit Foo', 'yuei-jit-foo-a93792', '221686', 'PAssion Wave', 'ST. JOSEPH''S INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '221686'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'ST. JOSEPH''S INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 10, 125.0, 92.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 19.0, '(19)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 14.0, '(14)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 11.0, '11', false, NULL, now(), now());

  -- Competitor: Avelino Shin (Rank 11)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Avelino Shin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Avelino Shin', 'avelino-shin-c45913', '209902', 'Hebe Haven Yacht Club', NULL, 'M', 'HKG', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '209902'),
        club = COALESCE(sailors.club, 'Hebe Haven Yacht Club'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'HKG'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 11, 139.0, 108.0, false, false,
    'M', 'HKG', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 15.0, '(15)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 16.0, '(16)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 9.0, '9', false, NULL, now(), now());

  -- Competitor: Isaac Goh (Rank 12)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isaac Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isaac Goh', 'isaac-goh-3d636d', '219158', 'Changi Sailing Club', 'RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '219158'),
        club = COALESCE(sailors.club, 'Changi Sailing Club'),
        school = COALESCE(sailors.school, 'RAFFLES INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 12, 161.0, 115.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 23.0, '(23 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 23.0, '(23 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 23.0, '23 DNC', false, 'DNC', now(), now());

  -- Competitor: Justiin Ang (Rank 13)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Justiin Ang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Justiin Ang', 'justiin-ang-676a06', '158031', 'Constant Wind SeaSports', 'ANGLO-CHINESE SCHOOL (INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '158031'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'ANGLO-CHINESE SCHOOL (INDEPENDENT)'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 13, 168.0, 122.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 23.0, '(23 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 23.0, '(23 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 23.0, '23 DNC', false, 'DNC', now(), now());

  -- Competitor: Cleo En Rui Seah (Rank 14)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cleo En Rui Seah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cleo En Rui Seah', 'cleo-en-rui-seah-bb43c6', '224379', 'SAF Yacht Club', 'CANBERRA SECONDARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '224379'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'CANBERRA SECONDARY SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 14, 164.0, 131.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 16.0, '(16)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 17.0, '(17)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 12.0, '12', false, NULL, now(), now());

  -- Competitor: Elizabeth Victoria Say (Rank 15)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elizabeth Victoria Say')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elizabeth Victoria Say', 'elizabeth-victoria-say-8b4e94', '214873', 'Royal Varuna Yacht Club', 'DUNMAN HIGH SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '214873'),
        club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
        school = COALESCE(sailors.school, 'DUNMAN HIGH SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 15, 167.0, 133.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 17.0, '(17)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 17.0, '(17)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 14.0, '14', false, NULL, now(), now());

  -- Competitor: Darren Lai (Rank 16)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Darren Lai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Darren Lai', 'darren-lai-a52b5c', '222256', 'Royal Varuna Yacht Club', 'ST. JOSEPH''S INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '222256'),
        club = COALESCE(sailors.club, 'Royal Varuna Yacht Club'),
        school = COALESCE(sailors.school, 'ST. JOSEPH''S INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 16, 169.0, 135.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 18.0, '(18)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 16.0, '(16 SCP)', true, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 13.0, '13', false, NULL, now(), now());

  -- Competitor: Arabelle En Xi Tan (Rank 17)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Arabelle En Xi Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Arabelle En Xi Tan', 'arabelle-en-xi-tan-8bf6b1', '221690', 'PAssion Wave', 'TANJONG KATONG GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '221690'),
        club = COALESCE(sailors.club, 'PAssion Wave'),
        school = COALESCE(sailors.school, 'TANJONG KATONG GIRLS'' SCHOOL'),
        gender = COALESCE(sailors.gender, 'F'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 17, 203.0, 161.0, false, false,
    'F', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 20.0, '(20)', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 22.0, '(22 SCP)', true, 'SCP', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 15.0, '15', false, NULL, now(), now());

  -- Competitor: Zachary Hong Yi Zhang (Rank 18)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zachary Hong Yi Zhang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zachary Hong Yi Zhang', 'zachary-hong-yi-zhang-3ba154', '223148', 'SAF Yacht Club', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '223148'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 18, 212.0, 166.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 23.0, '(23 RET)', true, 'RET', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 23.0, '(23 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 23.0, '23 DNC', false, 'DNC', now(), now());

  -- Competitor: John Gabriel Lim (Rank 19)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('John Gabriel Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'John Gabriel Lim', 'john-gabriel-lim-8f6b17', '206799', 'Changi Sailing Club', 'ST. JOSEPH''S INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '206799'),
        club = COALESCE(sailors.club, 'Changi Sailing Club'),
        school = COALESCE(sailors.school, 'ST. JOSEPH''S INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 19, 214.0, 168.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 23.0, '(23 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 23.0, '(23 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 23.0, '23 DNF', false, 'DNF', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 10.0, '10', false, NULL, now(), now());

  -- Competitor: Omar Agoes (Rank 20)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Omar Agoes')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Omar Agoes', 'omar-agoes-cb0165', '209145', 'Constant Wind SeaSports', NULL, 'M', 'INA', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '209145'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, NULL),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'INA'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 20, 250.0, 204.0, false, false,
    'M', 'INA', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 23.0, '(23 DNF)', true, 'DNF', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 20.0, '20', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 18.0, '18', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 23.0, '(23 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 23.0, '23 DNC', false, 'DNC', now(), now());

  -- Competitor: Mathias Yu Da Wong (Rank 21)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mathias Yu Da Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mathias Yu Da Wong', 'mathias-yu-da-wong-5526e7', '222255', 'Constant Wind SeaSports', 'RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '222255'),
        club = COALESCE(sailors.club, 'Constant Wind SeaSports'),
        school = COALESCE(sailors.school, 'RAFFLES INSTITUTION'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 21, 266.0, 220.0, false, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 17.0, '17', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 19.0, '19', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 23.0, '(23 RET)', true, 'RET', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 23.0, '(23 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 23.0, '23 DNC', false, 'DNC', now(), now());

  -- Competitor: Clive Wei Jun Seah (Rank 22)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Clive Wei Jun Seah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Clive Wei Jun Seah', 'clive-wei-jun-seah-5d97b2', '214240', 'SAF Yacht Club', 'CATHOLIC JUNIOR COLLEGE', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sailors.sail_number, '214240'),
        club = COALESCE(sailors.club, 'SAF Yacht Club'),
        school = COALESCE(sailors.school, 'CATHOLIC JUNIOR COLLEGE'),
        gender = COALESCE(sailors.gender, 'M'),
        nationality = COALESCE(sailors.nationality, 'SGP'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    gender, nationality, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 22, 276.0, 230.0, true, false,
    'M', 'SGP', 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 23.0, '(23 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 23.0, '(23 DNC)', true, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 8, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 9, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 10, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 11, 23.0, '23 DNC', false, 'DNC', now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 12, 23.0, '23 DNC', false, 'DNC', now(), now());

END 71520;
