-- 065_add_safyc_2026_ilca_results.sql
-- Import official race-by-race results for 22nd SAFYC Regatta 2026 (ILCA 4, ILCA 6, and ILCA 7 Fleets)
-- Dates: 14–15 February 2026
-- Venue: NSRCC Seasports Centre, 11 Changi Coast Walk, Singapore 499740
-- Organiser: SAF Yacht Club
-- Source: Official Sailwave scoring sheets, Singapore Sailing Federation

-- ============================================================================
-- 1. Regatta: 22nd SAFYC Regatta 2026 (ILCA 4) (safyc-2026-ilca-4)
-- ============================================================================
DO $$
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'safyc-2026-ilca-4' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = '22nd SAFYC Regatta 2026 (ILCA 4)',
      date = '2026-02-14',
      end_date = '2026-02-15',
      boat_class = 'ILCA 4',
      division = 'Open',
      total_fleet_size = 49,
      race_count = 7,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'NSRCC Seasports Centre, Singapore',
      organizer = 'SAF Yacht Club',
      nor_url = 'https://www.racingrulesofsailing.org/documents/13551/event',
      registration_url = 'https://www.safyc.org.sg',
      schedule_notes = '22nd SAFYC Regatta 2026 ILCA 4 fleet: 49 entries, 7 races sailed (1 discard).',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, created_at, updated_at
    ) VALUES (
      v_reg_id, '22nd SAFYC Regatta 2026 (ILCA 4)', 'safyc-2026-ilca-4', '2026-02-14', '2026-02-15', 'ILCA 4', 'Open', 49, 7,
      'SG', true, 'NSRCC Seasports Centre, Singapore', 'SAF Yacht Club', 'https://www.racingrulesofsailing.org/documents/13551/event', 'https://www.safyc.org.sg', '22nd SAFYC Regatta 2026 ILCA 4 fleet: 49 entries, 7 races sailed (1 discard).', now(), now()
    );
  END IF;

  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Ethan Han Wei Chia (Rank 1)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ethan Han Wei Chia')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ethan Han Wei Chia', 'ethan-chia-han-wei', '228368', '228368', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '228368'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 1, 63.0, 13.0, false, false,
    '228368', 'M', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 3.0, '3.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 3.0, '3.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 1.0, '1.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 3.0, '3.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 1.0, '1.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 2.0, '2.0', NULL, false, now(), now()
  );

  -- Competitor: Ian Goh (Rank 2)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ian Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ian Goh', 'goh-siak-yiak-ian', '222713', '222713', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '222713'),
      club = COALESCE(sailors.club, 'Constant Wind'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 2, 23.0, 15.0, false, false,
    '222713', 'M', 'Constant Wind', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 1.0, '1.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 1.0, '1.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 5.0, '5.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 8.0, '8.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 2.0, '2.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 2.0, '2.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 4.0, '4.0', NULL, false, now(), now()
  );

  -- Competitor: Desiree Lee (Rank 3)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Desiree Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Desiree Lee', 'desiree-lee-yuet-chi', '226897', '226897', 'Others', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '226897'),
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'F'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 3, 48.0, 26.0, false, false,
    '226897', 'F', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 8.0, '8.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 2.0, '2.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 4.0, '4.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 6.0, '6.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 5.0, '5.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 22.0, '22.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 1.0, '1.0', NULL, false, now(), now()
  );

  -- Competitor: Zeph Wan (Rank 4)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zeph Wan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zeph Wan', 'zeph-wan', '226650', '226650', 'Others', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '226650'),
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 4, 39.0, 27.0, false, false,
    '226650', 'M', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 4.0, '4.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 7.0, '7.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 1.0, '1.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 12.0, '12.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 1.0, '1.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 4.0, '4.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 10.0, '10.0', NULL, false, now(), now()
  );

  -- Competitor: Nicholette Lee (Rank 5)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nicholette Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nicholette Lee', 'lee-wee-wen-nicholette-w5z5h1u', '224620', '224620', 'Others', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '224620'),
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'F'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 5, 62.0, 42.0, false, false,
    '224620', 'F', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 20.0, '20.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 5.0, '5.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 6.0, '6.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 10.0, '10.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 6.0, '6.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 8.0, '8.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 7.0, '7.0', NULL, false, now(), now()
  );

  -- Competitor: Zachary Weikai Wong (Rank 6)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zachary Weikai Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zachary Weikai Wong', 'wong-weikai-zachary-ft0rnv9', '221061', '221061', 'Others', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '221061'),
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 6, 96.0, 46.0, false, false,
    '221061', 'M', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 5.0, '5.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 9.0, '9.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 2.0, '2.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 13.0, '13.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 3.0, '3.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 14.0, '14.0', NULL, false, now(), now()
  );

  -- Competitor: Zhi Tong Wai (Rank 7)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zhi Tong Wai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zhi Tong Wai', 'wai-zhi-tong', '225226', '225226', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '225226'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'F'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 7, 65.0, 47.0, false, false,
    '225226', 'F', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 15.0, '15.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 9.0, '9.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 2.0, '2.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 18.0, '18.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 11.0, '11.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 7.0, '7.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 3.0, '3.0', NULL, false, now(), now()
  );

  -- Competitor: Nia Zahedi (Rank 8)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nia Zahedi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nia Zahedi', 'nia-mehry-zahedi-04ev2zf', '224245', '224245', 'Others', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '224245'),
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'F'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 8, 65.0, 50.0, false, false,
    '224245', 'F', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 13.0, '13.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 8.0, '8.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 14.0, '14.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 4.0, '4.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 15.0, '15.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 6.0, '6.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 5.0, '5.0', NULL, false, now(), now()
  );

  -- Competitor: Mildred Li Xuan Wong (Rank 9)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mildred Li Xuan Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mildred Li Xuan Wong', 'wong-li-xuan-mildred-fueslz1', '223200', '223200', 'Others', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '223200'),
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'F'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 9, 71.0, 50.0, false, false,
    '223200', 'F', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 6.0, '6.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 21.0, '21.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 8.0, '8.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 5.0, '5.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 10.0, '10.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 12.0, '12.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 9.0, '9.0', NULL, false, now(), now()
  );

  -- Competitor: Gabi Oh (Rank 10)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gabi Oh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gabi Oh', 'gabi-oh-fv3x3cs', '222743', '222743', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '222743'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'F'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 10, 106.0, 56.0, false, false,
    '222743', 'F', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 12.0, '12.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 7.0, '7.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 7.0, '7.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 17.0, '17.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 5.0, '5.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 8.0, '8.0', NULL, false, now(), now()
  );

  -- Competitor: Kai Lun Wong (Rank 11)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kai Lun Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kai Lun Wong', 'regis-wong-xuan-kai-07sd94a', '214636', '214636', 'Others', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '214636'),
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 11, 97.0, 69.0, false, false,
    '214636', 'M', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 11.0, '11.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 19.0, '19.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 13.0, '13.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 28.0, '28.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 4.0, '4.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 10.0, '10.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 12.0, '12.0', NULL, false, now(), now()
  );

  -- Competitor: Mika Tew (Rank 12)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mika Tew')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mika Tew', 'mika-tew-0741h6l', '227461', '227461', 'Others', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '227461'),
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'F'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 12, 120.0, 70.0, false, false,
    '227461', 'F', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 19.0, '19.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 11.0, '11.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 3.0, '3.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 20.0, '20.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 11.0, '11.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 6.0, '6.0', NULL, false, now(), now()
  );

  -- Competitor: Charles Kong (Rank 13)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Charles Kong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Charles Kong', 'charles-kong-shing-chak-oivt05a', '227676', '227676', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '227676'),
      club = COALESCE(sailors.club, 'Changi Sailing Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 13, 121.0, 84.0, false, false,
    '227676', 'M', 'Changi Sailing Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 25.0, '25.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 3.0, '3.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 17.0, '17.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 9.0, '9.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 8.0, '8.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 37.0, '37.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 22.0, '22.0', NULL, false, now(), now()
  );

  -- Competitor: Jemima Chang (Rank 14)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jemima Chang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jemima Chang', 'jemima-chang-fwumhtx', '227464', '227464', 'Others', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '227464'),
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'F'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 14, 137.0, 87.0, false, false,
    '227464', 'F', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 7.0, '7.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 18.0, '18.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 16.0, '16.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 14.0, '14.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 16.0, '16.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 16.0, '16.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );

  -- Competitor: Jayden Bai (Rank 15)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jayden Bai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jayden Bai', 'jayden-zi-xi-bai-4x7u96r', '225261', '225261', 'Others', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '225261'),
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 15, 148.0, 98.0, false, false,
    '225261', 'M', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 14.0, '14.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 22.0, '22.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 11.0, '11.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 19.0, '19.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 17.0, '17.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 15.0, '15.0', NULL, false, now(), now()
  );

  -- Competitor: Ashlea Tham (Rank 16)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ashlea Tham')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ashlea Tham', 'tham-ashlea-98k0z5x', '3', '3', 'Others', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '3'),
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'F'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 16, 149.0, 99.0, false, false,
    '3', 'F', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 16.0, '16.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 15.0, '15.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 10.0, '10.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 17.0, '17.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 21.0, '21.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 20.0, '20.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );

  -- Competitor: Lukas Kiesselbach (Rank 17)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lukas Kiesselbach')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lukas Kiesselbach', 'lukas-kiesselbach-fylbfoc', '221597', '221597', 'Changi Sailing Club', 'M', 'GER', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '221597'),
      club = COALESCE(sailors.club, 'Changi Sailing Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'GER'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 17, 150.0, 100.0, false, false,
    '221597', 'M', 'Changi Sailing Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 2.0, '2.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 10.0, '10.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 18.0, '18.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 42.0, '42.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 9.0, '9.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 19.0, '19.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );

  -- Competitor: Reyes Jit Eng Tan (Rank 18)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Reyes Jit Eng Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Reyes Jit Eng Tan', 'tan-reyes-jit-eng-fzahuzd', '214251', '214251', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '214251'),
      club = COALESCE(sailors.club, 'Changi Sailing Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 18, 155.0, 105.0, false, false,
    '214251', 'M', 'Changi Sailing Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 17.0, '17.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 13.0, '13.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 19.0, '19.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 13.0, '13.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 22.0, '22.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 21.0, '21.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );

  -- Competitor: Yuk Jun Lim (Rank 19)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuk Jun Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuk Jun Lim', 'lim-yuk-jun', '225182', '225182', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '225182'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 19, 156.0, 106.0, false, false,
    '225182', 'M', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 23.0, '23.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 20.0, '20.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 25.0, '25.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 12.0, '12.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 13.0, '13.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 13.0, '13.0', NULL, false, now(), now()
  );

  -- Competitor: Heng Yi Yong (Rank 20)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Heng Yi Yong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Heng Yi Yong', 'yong-heng-yi', '225259', '225259', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '225259'),
      club = COALESCE(sailors.club, 'Changi Sailing Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 20, 158.0, 108.0, false, false,
    '225259', 'M', 'Changi Sailing Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 28.0, '28.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 4.0, '4.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 12.0, '12.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 16.0, '16.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 30.0, '30.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 18.0, '18.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );

  -- Competitor: Isaiah Chor Hong Yap (Rank 21)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isaiah Chor Hong Yap')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isaiah Chor Hong Yap', 'isaiah-yap-chor-hong', '227463', '227463', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '227463'),
      club = COALESCE(sailors.club, 'Changi Sailing Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 21, 148.0, 113.0, false, false,
    '227463', 'M', 'Changi Sailing Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 10.0, '10.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 24.0, '24.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 35.0, '35.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 21.0, '21.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 7.0, '7.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 24.0, '24.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 27.0, '27.0', NULL, false, now(), now()
  );

  -- Competitor: Travis Yeo (Rank 22)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Travis Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Travis Yeo', 'travis-yeo-jia-le-2b36t41', '223728', '223728', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '223728'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 22, 165.0, 120.0, false, false,
    '223728', 'M', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 32.0, '32.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 6.0, '6.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 15.0, '15.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 20.0, '20.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 45.0, '45.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 27.0, '27.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 20.0, '20.0', NULL, false, now(), now()
  );

  -- Competitor: Isla Lee (Rank 23)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isla Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isla Lee', 'lee-isla-zhi-xi-9p2t704', '8', '8', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '8'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'F'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 23, 186.0, 136.0, false, false,
    '8', 'F', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 9.0, '9.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 11.0, '11.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 24.0, '24.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 32.0, '32.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 24.0, '24.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 36.0, '36.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );

  -- Competitor: Callum Wong (Rank 24)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Callum Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Callum Wong', 'wong-callum-joon-thang-3r8g52y', '214748', '214748', 'Others', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '214748'),
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 24, 185.0, 149.0, false, false,
    '214748', 'M', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 24.0, '24.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 17.0, '17.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 36.0, '36.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 19.0, '19.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 28.0, '28.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 26.0, '26.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 35.0, '35.0', NULL, false, now(), now()
  );

  -- Competitor: Amandine Zoe Pitsilis (Rank 25)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Amandine Zoe Pitsilis')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Amandine Zoe Pitsilis', 'amandine-zoe-pitsilis', '219725', '219725', 'Changi Sailing Club', 'F', 'FRA', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '219725'),
      club = COALESCE(sailors.club, 'Changi Sailing Club'),
      gender = COALESCE(sailors.gender, 'F'),
      nationality = COALESCE(sailors.nationality, 'FRA'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 25, 203.0, 153.0, false, false,
    '219725', 'F', 'Changi Sailing Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 41.0, '41.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 30.0, '30.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 15.0, '15.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 25.0, '25.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 9.0, '9.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 33.0, '33.0', NULL, false, now(), now()
  );

  -- Competitor: Gerome Sim (Rank 26)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gerome Sim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gerome Sim', 'gerome-sim', '4', '4', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '4'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 26, 200.0, 156.0, false, false,
    '4', 'M', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 21.0, '21.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 30.0, '30.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 26.0, '26.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 26.0, '26.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 37.0, '37.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 44.0, '44.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 16.0, '16.0', NULL, false, now(), now()
  );

  -- Competitor: Lauren Lim (Rank 27)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lauren Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lauren Lim', 'lauren-lim-ommq6jo', '216431', '216431', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '216431'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'F'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 27, 201.0, 157.0, false, false,
    '216431', 'F', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 26.0, '26.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 29.0, '29.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 27.0, '27.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 22.0, '22.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 44.0, '44.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 15.0, '15.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 38.0, '38.0', NULL, false, now(), now()
  );

  -- Competitor: Nicholas Jiang En Ng (Rank 28)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nicholas Jiang En Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nicholas Jiang En Ng', 'nicholas-jiang-en-ng-g33qucq', '209042', '209042', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '209042'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 28, 197.0, 160.0, false, false,
    '209042', 'M', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 31.0, '31.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 16.0, '16.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 33.0, '33.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 37.0, '37.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 32.0, '32.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 23.0, '23.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 25.0, '25.0', NULL, false, now(), now()
  );

  -- Competitor: James Kong (Rank 29)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('James Kong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'James Kong', 'james-kong-0lvis00', '212216', '212216', 'Others', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '212216'),
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 29, 201.0, 163.0, false, false,
    '212216', 'M', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 30.0, '30.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 14.0, '14.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 25.0, '25.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 27.0, '27.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 31.0, '31.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 38.0, '38.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 36.0, '36.0', NULL, false, now(), now()
  );

  -- Competitor: Kye Tang (Rank 30)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kye Tang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kye Tang', 'kye-tang-ojcorzh', '226900', '226900', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '226900'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 30, 210.0, 171.0, false, false,
    '226900', 'M', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 37.0, '37.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 20.0, '20.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 34.0, '34.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 38.0, '38.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 39.0, '39.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 25.0, '25.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 17.0, '17.0', NULL, false, now(), now()
  );

  -- Competitor: Jonathan Kum Loong Kwok (Rank 31)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jonathan Kum Loong Kwok')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jonathan Kum Loong Kwok', 'jonathan-kwok-kum-loong-0iin67q', '214808', '214808', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '214808'),
      club = COALESCE(sailors.club, 'Changi Sailing Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 31, 221.0, 171.0, false, false,
    '214808', 'M', 'Changi Sailing Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 42.0, '42.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 21.0, '21.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 24.0, '24.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 23.0, '23.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 29.0, '29.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 32.0, '32.0', NULL, false, now(), now()
  );

  -- Competitor: Caleb Zhixuan Cao (Rank 32)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Caleb Zhixuan Cao')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Caleb Zhixuan Cao', 'caleb-cao-zhixuan', '225207', '225207', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '225207'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 32, 222.0, 172.0, false, false,
    '225207', 'M', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 29.0, '29.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 39.0, '39.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 30.0, '30.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 29.0, '29.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 14.0, '14.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 31.0, '31.0', NULL, false, now(), now()
  );

  -- Competitor: Cecilia Kong (Rank 33)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cecilia Kong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cecilia Kong', 'cecilia-sze-sen-kong-9p6v32a', '227678', '227678', 'Changi Sailing Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '227678'),
      club = COALESCE(sailors.club, 'Changi Sailing Club'),
      gender = COALESCE(sailors.gender, 'F'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 33, 219.0, 176.0, false, false,
    '227678', 'F', 'Changi Sailing Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 33.0, '33.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 12.0, '12.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 28.0, '28.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 43.0, '43.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 43.0, '43.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 39.0, '39.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 21.0, '21.0', NULL, false, now(), now()
  );

  -- Competitor: Joel Kai En Tan (Rank 34)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joel Kai En Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joel Kai En Tan', 'tan-kai-en-joel', '214849', '214849', 'Others', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '214849'),
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 34, 210.0, 176.0, false, false,
    '214849', 'M', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 34.0, '34.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 26.0, '26.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 32.0, '32.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 33.0, '33.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 27.0, '27.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 28.0, '28.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 30.0, '30.0', NULL, false, now(), now()
  );

  -- Competitor: Cory Zhi Hang Loh (Rank 35)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cory Zhi Hang Loh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cory Zhi Hang Loh', 'cory-loh-zhi-hang', '226899', '226899', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '226899'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 35, 227.0, 177.0, false, false,
    '226899', 'M', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 18.0, '18.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 23.0, '23.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 39.0, '39.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 26.0, '26.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 47.0, '47.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 24.0, '24.0', NULL, false, now(), now()
  );

  -- Competitor: Joshua Khoo (Rank 36)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joshua Khoo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joshua Khoo', 'joshua-zhuo-xi-khoo-2q4f81s', '227677', '227677', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '227677'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 36, 229.0, 179.0, false, false,
    '227677', 'M', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 22.0, '22.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 37.0, '37.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 45.0, '45.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 33.0, '33.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 31.0, '31.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 11.0, '11.0', NULL, false, now(), now()
  );

  -- Competitor: Rayson Yin Yi Lee (Rank 37)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rayson Yin Yi Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rayson Yin Yi Lee', 'rayson-lee-yin-yi-oi1kvmm', '217060', '217060', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '217060'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 37, 231.0, 181.0, false, false,
    '217060', 'M', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 36.0, '36.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 38.0, '38.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 35.0, '35.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 18.0, '18.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 35.0, '35.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 19.0, '19.0', NULL, false, now(), now()
  );

  -- Competitor: Liao ZhiTing (Rank 38)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Liao ZhiTing')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Liao ZhiTing', 'liao-zhiting-5g8w12x', '227460', '227460', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '227460'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'F'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 38, 236.0, 186.0, false, false,
    '227460', 'F', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 27.0, '27.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 50.0, '50.0 DNF', 'DNF', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 40.0, '40.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 19.0, '19.0 SCP', 'SCP', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 32.0, '32.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 18.0, '18.0', NULL, false, now(), now()
  );

  -- Competitor: Lucas Rui Kai Lim (Rank 39)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lucas Rui Kai Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lucas Rui Kai Lim', 'lim-rui-kai-lucas', '223355', '223355', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '223355'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 39, 246.0, 196.0, false, false,
    '223355', 'M', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 50.0, '50.0 RET', 'RET', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 28.0, '28.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 29.0, '29.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 34.0, '34.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 41.0, '41.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 30.0, '30.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 34.0, '34.0', NULL, false, now(), now()
  );

  -- Competitor: Alaric Shenthil Naidu (Rank 40)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Alaric Shenthil Naidu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Alaric Shenthil Naidu', 'alaric-shenthil-naidu', '170299', '170299', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '170299'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 40, 241.0, 201.0, false, false,
    '170299', 'M', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 40.0, '40.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 27.0, '27.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 31.0, '31.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 36.0, '36.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 38.0, '38.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 40.0, '40.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 29.0, '29.0', NULL, false, now(), now()
  );

  -- Competitor: Jonas Tan (Rank 41)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jonas Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jonas Tan', 'jonas-kia-jeng-tan-1p4q92x', '197840', '197840', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '197840'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 41, 253.0, 203.0, false, false,
    '197840', 'M', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 39.0, '39.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 43.0, '43.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 31.0, '31.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 34.0, '34.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 33.0, '33.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 23.0, '23.0', NULL, false, now(), now()
  );

  -- Competitor: Yunosuke Ogawa (Rank 42)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yunosuke Ogawa')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yunosuke Ogawa', 'yunosuke-ogawa-g8agugu', '214779', '214779', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '214779'),
      club = COALESCE(sailors.club, 'Constant Wind'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 42, 248.0, 207.0, false, false,
    '214779', 'M', 'Constant Wind', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 35.0, '35.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 23.0, '23.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 40.0, '40.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 23.0, '23.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 36.0, '36.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 41.0, '41.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 50.0, '50.0 DNE', 'DNE', false, now(), now()
  );

  -- Competitor: Mathias Cheow (Rank 43)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mathias Cheow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mathias Cheow', 'mathias-cheow-og2sfe8', '225167', '225167', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '225167'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 43, 271.0, 221.0, false, false,
    '225167', 'M', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 45.0, '45.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 41.0, '41.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 29.0, '29.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 35.0, '35.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 43.0, '43.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 28.0, '28.0', NULL, false, now(), now()
  );

  -- Competitor: Mohamed Mikail Bin Mohamed Shahrom (Rank 44)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mohamed Mikail Bin Mohamed Shahrom')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mohamed Mikail Bin Mohamed Shahrom', 'mohamed-mikail-bin-mohd-shahrom-2v4p89x', '14', '14', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '14'),
      club = COALESCE(sailors.club, 'Changi Sailing Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 44, 279.0, 233.0, false, false,
    '14', 'M', 'Changi Sailing Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 43.0, '43.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 25.0, '25.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 46.0, '46.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 41.0, '41.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 42.0, '42.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 42.0, '42.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 40.0, '40.0', NULL, false, now(), now()
  );

  -- Competitor: Jiayan Xu (Rank 45)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jiayan Xu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jiayan Xu', 'xu-jiayan-outlig4', '224656', '224656', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '224656'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 45, 292.0, 242.0, false, false,
    '224656', 'M', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 38.0, '38.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 31.0, '31.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 50.0, '50.0 DNF', 'DNF', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 46.0, '46.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 40.0, '40.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 50.0, '50.0 DNF', 'DNF', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 37.0, '37.0', NULL, false, now(), now()
  );

  -- Competitor: Tiffany Teo (Rank 46)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tiffany Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tiffany Teo', 'tiffany-teo-yuan-qi-ga16itq', '214813', '214813', 'Others', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '214813'),
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'F'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 46, 305.0, 255.0, false, false,
    '214813', 'F', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 44.0, '44.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 45.0, '45.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 44.0, '44.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 47.0, '47.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 34.0, '34.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 41.0, '41.0', NULL, false, now(), now()
  );

  -- Competitor: Jamiroquai Kai Nuo Tay (Rank 47)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jamiroquai Kai Nuo Tay')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jamiroquai Kai Nuo Tay', 'jamiroquai-tay-kai-nuo', '10', '10', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '10'),
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 47, 306.0, 256.0, false, false,
    '10', 'M', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 50.0, '50.0 DNF', 'DNF', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 22.0, '22.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 47.0, '47.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 50.0, '50.0 DNF', 'DNF', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 48.0, '48.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 50.0, '50.0 RET', 'RET', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 39.0, '39.0', NULL, false, now(), now()
  );

  -- Competitor: Max Ha (Rank 48)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Max Ha')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Max Ha', 'maximilian-ha-4t2v87p', '13', '13', 'Others', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '13'),
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 48, 306.0, 256.0, false, false,
    '13', 'M', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 50.0, '50.0 DNF', 'DNF', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 50.0, '50.0 BFD', 'BFD', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 42.0, '42.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 47.0, '47.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 46.0, '46.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 45.0, '45.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 26.0, '26.0', NULL, false, now(), now()
  );

  -- Competitor: Tomas Agea (Rank 49)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tomas Agea')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, sail_number_ilca4, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tomas Agea', 'tomas-agea-dzxv2wz', '221062', '221062', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, '221062'),
      club = COALESCE(sailors.club, 'Constant Wind'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 49, 333.0, 283.0, false, false,
    '221062', 'M', 'Constant Wind', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 46.0, '46.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 50.0, '50.0 BFD', 'BFD', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 44.0, '44.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 48.0, '48.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 49.0, '49.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 46.0, '46.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 50.0, '50.0 BFD', 'BFD', false, now(), now()
  );

END $$;

-- ============================================================================
-- 2. Regatta: 22nd SAFYC Regatta 2026 (ILCA 6) (safyc-2026-ilca-6)
-- ============================================================================
DO $$
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'safyc-2026-ilca-6' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = '22nd SAFYC Regatta 2026 (ILCA 6)',
      date = '2026-02-14',
      end_date = '2026-02-15',
      boat_class = 'ILCA 6',
      division = 'Open',
      total_fleet_size = 16,
      race_count = 7,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'NSRCC Seasports Centre, Singapore',
      organizer = 'SAF Yacht Club',
      nor_url = 'https://www.racingrulesofsailing.org/documents/13551/event',
      registration_url = 'https://www.safyc.org.sg',
      schedule_notes = '22nd SAFYC Regatta 2026 ILCA 6 fleet: 16 entries, 7 races sailed (1 discard).',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, created_at, updated_at
    ) VALUES (
      v_reg_id, '22nd SAFYC Regatta 2026 (ILCA 6)', 'safyc-2026-ilca-6', '2026-02-14', '2026-02-15', 'ILCA 6', 'Open', 16, 7,
      'SG', true, 'NSRCC Seasports Centre, Singapore', 'SAF Yacht Club', 'https://www.racingrulesofsailing.org/documents/13551/event', 'https://www.safyc.org.sg', '22nd SAFYC Regatta 2026 ILCA 6 fleet: 16 entries, 7 races sailed (1 discard).', now(), now()
    );
  END IF;

  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Gordon Alexander Allan (Rank 1)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gordon Alexander Allan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gordon Alexander Allan', 'gordon-alexander-allan', '221058', 'Others', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 1, 29.0, 12.0, false, false,
    '221058', 'M', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 1.0, '1.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 1.0, '1.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 3.0, '3.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 1.0, '1.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 17.0, '17.0 DNC', 'DNC', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 3.0, '3.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 3.0, '3.0', NULL, false, now(), now()
  );

  -- Competitor: Leow You Shun Aurick (Rank 2)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Leow You Shun Aurick')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Leow You Shun Aurick', 'leow-you-shun-aurick', '67', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 2, 29.0, 12.0, false, false,
    '67', 'M', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 2.0, '2.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 2.0, '2.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 2.0, '2.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 4.0, '4.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 1.0, '1.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 1.0, '1.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 17.0, '17.0 RET', 'RET', true, now(), now()
  );

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
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 3, 21.0, 14.0, false, false,
    '224717', 'M', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 5.0, '5.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 7.0, '7.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 1.0, '1.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 2.0, '2.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 3.0, '3.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 2.0, '2.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 1.0, '1.0', NULL, false, now(), now()
  );

  -- Competitor: Austin Yeo (Rank 4)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Austin Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Austin Yeo', 'austin-yeo', '222727', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 4, 29.0, 21.0, false, false,
    '222727', 'M', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 4.0, '4.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 3.0, '3.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 8.0, '8.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 3.0, '3.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 2.0, '2.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 5.0, '5.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 4.0, '4.0', NULL, false, now(), now()
  );

  -- Competitor: Keira Marie Carlyle (Rank 5)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Keira Marie Carlyle')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Keira Marie Carlyle', 'keira-marie-carlyle', '225225', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'F'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 5, 33.0, 26.0, false, false,
    '225225', 'F', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 3.0, '3.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 5.0, '5.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 7.0, '7.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 6.0, '6.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 4.0, '4.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 6.0, '6.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 2.0, '2.0', NULL, false, now(), now()
  );

  -- Competitor: Sarah Yong (Rank 6)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sarah Yong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sarah Yong', 'sarah-yong', '18', 'Others', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'F'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 6, 54.0, 41.0, false, false,
    '18', 'F', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 9.0, '9.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 4.0, '4.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 6.0, '6.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 13.0, '13.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 6.0, '6.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 11.0, '11.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 5.0, '5.0', NULL, false, now(), now()
  );

  -- Competitor: Jayden Teo (Rank 7)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jayden Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jayden Teo', 'jayden-teo', '214813', 'Others', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 7, 58.0, 46.0, false, false,
    '214813', 'M', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 12.0, '12.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 8.0, '8.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 4.0, '4.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 10.0, '10.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 7.0, '7.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 8.0, '8.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 9.0, '9.0', NULL, false, now(), now()
  );

  -- Competitor: Asher-James Nair (Rank 8)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Asher-James Nair')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Asher-James Nair', 'asher-james-nair', '185201', 'Others', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 8, 63.0, 46.0, false, false,
    '185201', 'M', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 7.0, '7.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 12.0, '12.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 5.0, '5.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 11.0, '11.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 5.0, '5.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 17.0, '17.0 RET', 'RET', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 6.0, '6.0', NULL, false, now(), now()
  );

  -- Competitor: Foo Yuei Jit (Rank 9)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Foo Yuei Jit')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Foo Yuei Jit', 'foo-yuei-jit', '221686', 'Others', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 9, 62.0, 49.0, false, false,
    '221686', 'M', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 10.0, '10.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 13.0, '13.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 9.0, '9.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 5.0, '5.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 11.0, '11.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 7.0, '7.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 7.0, '7.0', NULL, false, now(), now()
  );

  -- Competitor: Darren Lai (Rank 10)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Darren Lai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Darren Lai', 'darren-lai', '222257', 'Others', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 10, 70.0, 55.0, false, false,
    '222257', 'M', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 13.0, '13.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 6.0, '6.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 15.0, '15.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 9.0, '9.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 12.0, '12.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 4.0, '4.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 11.0, '11.0', NULL, false, now(), now()
  );

  -- Competitor: Josiah Tan Zhi En (Rank 11)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Josiah Tan Zhi En')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Josiah Tan Zhi En', 'josiah-tan-zhi-en', '1978', 'Others', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 11, 73.0, 57.0, false, false,
    '1978', 'M', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 11.0, '11.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 16.0, '16.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 11.0, '11.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 8.0, '8.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 10.0, '10.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 9.0, '9.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 8.0, '8.0', NULL, false, now(), now()
  );

  -- Competitor: Elizabeth Victoria Say (Rank 12)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elizabeth Victoria Say')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elizabeth Victoria Say', 'elizabeth-victoria-say', '214873', 'Others', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'F'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 12, 74.0, 59.0, false, false,
    '214873', 'F', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 8.0, '8.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 15.0, '15.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 13.0, '13.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 7.0, '7.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 8.0, '8.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 10.0, '10.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 13.0, '13.0', NULL, false, now(), now()
  );

  -- Competitor: Seah En Rui Cleo (Rank 13)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Seah En Rui Cleo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Seah En Rui Cleo', 'seah-en-rui-cleo', '224379', 'SAF Yacht Club', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'F'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 13, 85.0, 70.0, false, false,
    '224379', 'F', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 14.0, '14.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 9.0, '9.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 12.0, '12.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 15.0, '15.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 13.0, '13.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 12.0, '12.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 10.0, '10.0', NULL, false, now(), now()
  );

  -- Competitor: Ho Jian Yi Jonathan (Rank 14)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ho Jian Yi Jonathan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ho Jian Yi Jonathan', 'ho-jian-yi-jonathan', '214848', 'Others', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 14, 86.0, 71.0, false, false,
    '214848', 'M', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 15.0, '15.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 11.0, '11.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 14.0, '14.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 12.0, '12.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 9.0, '9.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 13.0, '13.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 12.0, '12.0', NULL, false, now(), now()
  );

  -- Competitor: Tristan Joseph Low (Rank 15)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tristan Joseph Low')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tristan Joseph Low', 'tristan-joseph-low', '33', 'SAF Yacht Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'SAF Yacht Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 15, 91.0, 74.0, false, false,
    '33', 'M', 'SAF Yacht Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 6.0, '6.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 10.0, '10.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 10.0, '10.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 14.0, '14.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 17.0, '17.0 DNC', 'DNC', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 17.0, '17.0 DNC', 'DNC', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 17.0, '17.0 DNC', 'DNC', false, now(), now()
  );

  -- Competitor: Angela Sabbatino (Rank 16)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Angela Sabbatino')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Angela Sabbatino', 'angela-sabbatino', '209145', 'Others', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Others'),
      gender = COALESCE(sailors.gender, 'F'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 16, 107.0, 90.0, false, false,
    '209145', 'F', 'Others', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 16.0, '16.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 14.0, '14.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 16.0, '16.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 16.0, '16.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 14.0, '14.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 17.0, '17.0 RET', 'RET', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 7, 14.0, '14.0', NULL, false, now(), now()
  );

END $$;

-- ============================================================================
-- 3. Regatta: 22nd SAFYC Regatta 2026 (ILCA 7) (safyc-2026-ilca-7)
-- ============================================================================
DO $$
DECLARE
  v_reg_id uuid;
  v_res_id uuid;
  v_sailor_id uuid;
BEGIN
  SELECT id INTO v_reg_id FROM public.regattas WHERE slug = 'safyc-2026-ilca-7' LIMIT 1;
  IF v_reg_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = '22nd SAFYC Regatta 2026 (ILCA 7)',
      date = '2026-02-14',
      end_date = '2026-02-15',
      boat_class = 'ILCA 7',
      division = 'Open',
      total_fleet_size = 3,
      race_count = 6,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'NSRCC Seasports Centre, Singapore',
      organizer = 'SAF Yacht Club',
      nor_url = 'https://www.racingrulesofsailing.org/documents/13551/event',
      registration_url = 'https://www.safyc.org.sg',
      schedule_notes = '22nd SAFYC Regatta 2026 ILCA 7 fleet: 3 entries, 6 races sailed (1 discard).',
      updated_at = now()
    WHERE id = v_reg_id;
  ELSE
    v_reg_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, created_at, updated_at
    ) VALUES (
      v_reg_id, '22nd SAFYC Regatta 2026 (ILCA 7)', 'safyc-2026-ilca-7', '2026-02-14', '2026-02-15', 'ILCA 7', 'Open', 3, 6,
      'SG', true, 'NSRCC Seasports Centre, Singapore', 'SAF Yacht Club', 'https://www.racingrulesofsailing.org/documents/13551/event', 'https://www.safyc.org.sg', '22nd SAFYC Regatta 2026 ILCA 7 fleet: 3 entries, 6 races sailed (1 discard).', now(), now()
    );
  END IF;

  DELETE FROM public.regatta_results WHERE regatta_id = v_reg_id;

  -- Competitor: Justiin Ang (Rank 1)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Justiin Ang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Justiin Ang', 'justiin-ang', '158031', 'Constant Wind', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Constant Wind'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 1, 6.0, 5.0, false, false,
    '158031', 'M', 'Constant Wind', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 1.0, '1.0', NULL, true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 1.0, '1.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 1.0, '1.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 1.0, '1.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 1.0, '1.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 1.0, '1.0', NULL, false, now(), now()
  );

  -- Competitor: Balazs Vincze (Rank 2)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Balazs Vincze')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Balazs Vincze', 'balazs-vincze', '213095', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Changi Sailing Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 2, 16.0, 12.0, false, false,
    '213095', 'M', 'Changi Sailing Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 2.0, '2.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 2.0, '2.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 2.0, '2.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 2.0, '2.0', NULL, false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 4.0, '4.0 DNC', 'DNC', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 4.0, '4.0 DNC', 'DNC', false, now(), now()
  );

  -- Competitor: Cameron Hunter (Rank 3)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cameron Hunter')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cameron Hunter', 'cameron-hunter', '197877', 'Changi Sailing Club', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors
    SET
      club = COALESCE(sailors.club, 'Changi Sailing Club'),
      gender = COALESCE(sailors.gender, 'M'),
      nationality = COALESCE(sailors.nationality, 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, is_overseas_commitment,
    sail_number, sailor_gender, club, created_at, updated_at
  ) VALUES (
    v_res_id, v_reg_id, v_sailor_id, 3, 24.0, 20.0, false, false,
    '197877', 'M', 'Changi Sailing Club', now(), now()
  );

  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 1, 4.0, '4.0 UFD', 'UFD', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 2, 4.0, '4.0 RET', 'RET', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 3, 4.0, '4.0 DNC', 'DNC', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 4, 4.0, '4.0 DNC', 'DNC', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 5, 4.0, '4.0 DNC', 'DNC', false, now(), now()
  );
  INSERT INTO public.regatta_race_results (
    id, regatta_result_id, race_number, score, raw_value, scoring_code, discarded, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), v_res_id, 6, 4.0, '4.0 DNC', 'DNC', false, now(), now()
  );

END $$;
