-- 066_add_csc_2026_ilca6_and_29er_results.sql
-- Import official race-by-race results for 6th CSC ILCA & 29er Open 2026
-- (CSC ILCA 29er Championships 2026)
-- Dates: 28 February & 1 March 2026
-- Venue: Changi Sailing Club, 32 Netheravon Road, Singapore 508508
-- Organiser: Changi Sailing Club in partnership with Singapore Sailing Federation
-- Source: Official PowerScore scoring sheets (Ver 6.3.2)

-- ============================================================================
-- 1. Regatta: 6th CSC ILCA & 29er Open 2026 (ILCA 6) (csc-2026-ilca-6)
-- ============================================================================
DO 69517
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'csc-2026-ilca-6' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = '6th CSC ILCA & 29er Open 2026 (ILCA 6)',
      date = '2026-02-28',
      end_date = '2026-03-01',
      boat_class = 'ILCA 6',
      division = 'Open',
      total_fleet_size = 16,
      race_count = 6,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'Changi Sailing Club, Singapore',
      organizer = 'Changi Sailing Club',
      nor_url = 'https://www.csc.org.sg',
      registration_url = 'https://www.csc.org.sg/csc-ilca-29er-championships-entry-form/',
      schedule_notes = '6th CSC ILCA & 29er Open 2026 ILCA 6 fleet: 16 entries, 6 races sailed (1 discard).',
      status = 'published',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_reg_id, '6th CSC ILCA & 29er Open 2026 (ILCA 6)', 'csc-2026-ilca-6', '2026-02-28', '2026-03-01', 'ILCA 6', 'Open', 16, 6,
      'SG', true, 'Changi Sailing Club, Singapore', 'Changi Sailing Club', 'https://www.csc.org.sg', 'https://www.csc.org.sg/csc-ilca-29er-championships-entry-form/', '6th CSC ILCA & 29er Open 2026 ILCA 6 fleet: 16 entries, 6 races sailed (1 discard).', 'published', now(), now()
    );
  END IF;

  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Ikuto Mori (Rank 1)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ikuto Mori')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ikuto Mori', 'ikuto-mori', '219178', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sail_number, '219178'),
        club = COALESCE(club, 'Changi Sailing Club'),
        gender = COALESCE(gender, 'M'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 1, 19.0, 11.0, false, false, 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 8.0, '8', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 2.0, '2', false, NULL, now(), now());

  -- Competitor: Austin Yeo (Rank 2)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Austin Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Austin Yeo', 'austin-yeo', '2', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sail_number, '2'),
        club = COALESCE(club, 'SAF Yacht Club'),
        gender = COALESCE(gender, 'M'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 2, 18.0, 14.0, false, false, 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 4.0, '4', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 3.0, '3', false, NULL, now(), now());

  -- Competitor: Eitan Oh (Rank 3)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Eitan Oh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Eitan Oh', 'eitan-oh', '224717', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sail_number, '224717'),
        club = COALESCE(club, 'SAF Yacht Club'),
        gender = COALESCE(gender, 'M'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 3, 22.0, 15.0, false, false, 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 7.0, '7', true, NULL, now(), now());

  -- Competitor: Aurick You Shun Leow (Rank 4)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aurick You Shun Leow')) OR lower(trim(name)) = lower(trim('Aurick Leow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aurick You Shun Leow', 'leow-you-shun-aurick', '67', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sail_number, '67'),
        club = COALESCE(club, 'SAF Yacht Club'),
        gender = COALESCE(gender, 'M'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 4, 26.0, 18.0, false, false, 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 8.0, '8', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 1.0, '1', false, NULL, now(), now());

  -- Competitor: Maia Lim Laurie (Rank 5)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Maia Lim Laurie')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Maia Lim Laurie', 'maia-lim-laurie-6vmk', '223201', 'Changi Sailing Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sail_number, '223201'),
        club = COALESCE(club, 'Changi Sailing Club'),
        gender = COALESCE(gender, 'F'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 5, 29.0, 22.0, false, false, 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 6.0, '6', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 7.0, '7', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 6.0, '6', false, NULL, now(), now());

  -- Competitor: Sarah Yong (Rank 6)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sarah Yong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sarah Yong', 'sarah-yong', '221689', 'Royal Varuna Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sail_number, '221689'),
        club = COALESCE(club, 'Royal Varuna Yacht Club'),
        gender = COALESCE(gender, 'F'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 6, 32.0, 24.0, false, false, 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 8.0, '8', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 4.0, '4', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 4.0, '4', false, NULL, now(), now());

  -- Competitor: Gordon Alexander Allan (Rank 7)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gordon Alexander Allan')) OR lower(trim(name)) = lower(trim('Gordan Allan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gordon Alexander Allan', 'gordon-alexander-allan', '221058', 'Royal Varuna Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sail_number, '221058'),
        club = COALESCE(club, 'Royal Varuna Yacht Club'),
        gender = COALESCE(gender, 'M'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 7, 35.0, 25.0, false, false, 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 10.0, '10', true, NULL, now(), now());

  -- Competitor: Asher-James Nair (Rank 8)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Asher-James Nair')) OR lower(trim(name)) = lower(trim('Asher James Nair')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Asher-James Nair', 'asher-james-nair', '185201', 'PAssion Wave', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sail_number, '185201'),
        club = COALESCE(club, 'PAssion Wave'),
        gender = COALESCE(gender, 'M'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 8, 42.0, 30.0, false, false, 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 12.0, '12', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 8.0, '8', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 5.0, '5', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 5.0, '5', false, NULL, now(), now());

  -- Competitor: Jayden Teo (Rank 9)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jayden Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jayden Teo', 'jayden-teo-31ym', '214813', 'PAssion Wave', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sail_number, '214813'),
        club = COALESCE(club, 'PAssion Wave'),
        gender = COALESCE(gender, 'M'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 9, 59.0, 47.0, false, false, 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 7.0, '7', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 12.0, '12', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 12.0, '12', false, NULL, now(), now());

  -- Competitor: Yuei Jit Foo (Rank 10)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuei Jit Foo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuei Jit Foo', 'yuei-jit-foo-xj1m', '221686', 'PAssion Wave', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sail_number, '221686'),
        club = COALESCE(club, 'PAssion Wave'),
        gender = COALESCE(gender, 'M'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 10, 62.0, 50.0, false, false, 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 12.0, '12', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 8.0, '8', false, NULL, now(), now());

  -- Competitor: Cleo En Rui Seah (Rank 11)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cleo En Rui Seah')) OR lower(trim(name)) = lower(trim('Cleo Seah En Rui')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cleo En Rui Seah', 'cleo-en-rui-seah', '224379', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sail_number, '224379'),
        club = COALESCE(club, 'SAF Yacht Club'),
        gender = COALESCE(gender, 'F'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 11, 65.0, 51.0, false, false, 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 12.0, '12', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 14.0, '14', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 9.0, '9', false, NULL, now(), now());

  -- Competitor: John Gabriel Lim (Rank 12)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('John Gabriel Lim')) OR lower(trim(name)) = lower(trim('John Gabriel Lm')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'John Gabriel Lim', 'john-gabriel-lim', '206799', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sail_number, '206799'),
        club = COALESCE(club, 'Changi Sailing Club'),
        gender = COALESCE(gender, 'M'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 12, 69.0, 56.0, false, false, 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 13.0, '13', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 9.0, '9', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 11.0, '11', false, NULL, now(), now());

  -- Competitor: Darren Lai (Rank 13)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Darren Lai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Darren Lai', 'darren-lai-4mpm', '222257', 'Royal Varuna Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sail_number, '222257'),
        club = COALESCE(club, 'Royal Varuna Yacht Club'),
        gender = COALESCE(gender, 'M'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 13, 79.0, 64.0, false, false, 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 15.0, '15', true, NULL, now(), now());

  -- Competitor: Elizabeth Victoria Say (Rank 14)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elizabeth Victoria Say')) OR lower(trim(name)) = lower(trim('Elzabeth Victoria Say')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elizabeth Victoria Say', 'elizabeth-victoria-say-r5rw', '214873', 'PAssion Wave', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sail_number, '214873'),
        club = COALESCE(club, 'PAssion Wave'),
        gender = COALESCE(gender, 'F'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 14, 82.0, 66.0, false, false, 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 16.0, '16', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 10.0, '10', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 13.0, '13', false, NULL, now(), now());

  -- Competitor: Rohit Behl (Rank 15)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rohit Behl')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rohit Behl', 'rohit-behl-ca7z', '193871', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sail_number, '193871'),
        club = COALESCE(club, 'Changi Sailing Club'),
        gender = COALESCE(gender, 'M'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 15, 82.0, 67.0, false, false, 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 11.0, '11', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 13.0, '13', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 15.0, '15', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 14.0, '14', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 14.0, '14', false, NULL, now(), now());

  -- Competitor: Angela Sabbatino (Rank 16)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Angela Sabbatino')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Angela Sabbatino', 'angela-sabbatino', '209145', 'Changi Sailing Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sail_number, '209145'),
        club = COALESCE(club, 'Changi Sailing Club'),
        gender = COALESCE(gender, 'F'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 16, 95.0, 79.0, false, false, 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 16.0, '16', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 15.0, '15', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 16.0, '16', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 16.0, '16', false, NULL, now(), now());

END 69517;

-- ============================================================================
-- 2. Regatta: 6th CSC ILCA & 29er Open 2026 (29er) (csc-2026-29er)
-- ============================================================================
DO 69517
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'csc-2026-29er' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = '6th CSC ILCA & 29er Open 2026 (29er)',
      date = '2026-02-28',
      end_date = '2026-03-01',
      boat_class = '29er',
      division = 'Youth',
      total_fleet_size = 3,
      race_count = 7,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'Changi Sailing Club, Singapore',
      organizer = 'Changi Sailing Club',
      nor_url = 'https://www.csc.org.sg',
      registration_url = 'https://www.csc.org.sg/csc-ilca-29er-championships-entry-form/',
      schedule_notes = '6th CSC ILCA & 29er Open 2026 29er fleet: 3 entries, 7 races sailed (1 discard).',
      status = 'published',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_reg_id, '6th CSC ILCA & 29er Open 2026 (29er)', 'csc-2026-29er', '2026-02-28', '2026-03-01', '29er', 'Youth', 3, 7,
      'SG', true, 'Changi Sailing Club, Singapore', 'Changi Sailing Club', 'https://www.csc.org.sg', 'https://www.csc.org.sg/csc-ilca-29er-championships-entry-form/', '6th CSC ILCA & 29er Open 2026 29er fleet: 3 entries, 7 races sailed (1 discard).', 'published', now(), now()
    );
  END IF;

  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Cheryl Yong Heng Xi (Rank 1)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cheryl Yong Heng Xi')) OR lower(trim(name)) = lower(trim('Cheryl Yong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cheryl Yong Heng Xi', 'cheryl-yong-heng-xi', '2466', 'Changi Sailing Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sail_number, '2466'),
        club = COALESCE(club, 'Changi Sailing Club'),
        gender = COALESCE(gender, 'F'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 1, 12.0, 9.0, false, false, 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 3.0, '3', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 1.0, '1', false, NULL, now(), now());

  -- Competitor: Sean Kum (Rank 2)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sean Kum')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sean Kum', 'sean-kum', '2472', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sail_number, '2472'),
        club = COALESCE(club, 'SAF Yacht Club'),
        gender = COALESCE(gender, 'M'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 2, 13.0, 10.0, false, false, 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 3.0, '3', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 2.0, '2', false, NULL, now(), now());

  -- Competitor: Cheryl Ho (Rank 3)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cheryl Ho')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cheryl Ho', 'cheryl-ho', '2869', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET sail_number = COALESCE(sail_number, '2869'),
        club = COALESCE(club, 'SAF Yacht Club'),
        gender = COALESCE(gender, 'F'),
        updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, total_score, nett_score, is_dns, is_overseas_commitment, verification_status, created_at, updated_at
  ) VALUES (
    v_res_id, v_sailor_id, v_reg_id, 3, 17.0, 14.0, false, false, 'verified', now(), now()
  );

  -- Race Results
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 1, 1.0, '1', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 2, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 3, 3.0, '3', true, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 4, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 5, 3.0, '3', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 6, 2.0, '2', false, NULL, now(), now());
  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, raw_value, discarded, scoring_code, created_at, updated_at) VALUES (gen_random_uuid(), v_res_id, 7, 3.0, '3', false, NULL, now(), now());

END 69517;
