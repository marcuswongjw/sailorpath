-- 076_add_pulau_ujong_2026_results.sql
-- Import official race-by-race results for Pulau Ujong Regatta 2026
-- Fleets: Optimist Gold (90), Optimist Silver (68), ILCA 4 (54), 29er (3), Techno 293 (5), iQFOiL (3)
-- Dates: 21–22 February 2026
-- Venue: National Sailing Centre, Singapore
-- Organiser: Singapore Sailing Federation

DO $$
DECLARE
  v_event_id uuid;
  v_gold_id uuid;
  v_silver_id uuid;
  v_ilca4_id uuid;
  v_29er_id uuid;
  v_techno_id uuid;
  v_iqfoil_id uuid;
  v_sailor_id uuid;
  v_res_id uuid;
BEGIN
  -- 1. Ensure weekend event exists in public.regatta_events
  SELECT id INTO v_event_id FROM public.regatta_events WHERE slug = 'pulau-ujong-regatta-2026' LIMIT 1;
  IF v_event_id IS NULL THEN
    v_event_id := gen_random_uuid();
    INSERT INTO public.regatta_events (
      id, name, slug, start_date, end_date, venue, organizer, classes, nor_url, registration_url, counts_for_ranking, is_selection_trial, created_at, updated_at
    ) VALUES (
      v_event_id, 'Pulau Ujong Regatta 2026', 'pulau-ujong-regatta-2026', '2026-02-21', '2026-02-22',
      'National Sailing Centre, Singapore', 'Singapore Sailing Federation',
      '["Optimist (Gold)", "Optimist (Silver)", "ILCA 4", "ILCA 6", "29er", "Techno 293", "iQFOiL"]'::jsonb,
      'https://www.racingrulesofsailing.org/documents/13180/event', 'https://www.sailing.org.sg',
      true, false, now(), now()
    );
  ELSE
    UPDATE public.regatta_events SET
      classes = '["Optimist (Gold)", "Optimist (Silver)", "ILCA 4", "ILCA 6", "29er", "Techno 293", "iQFOiL"]'::jsonb,
      updated_at = now()
    WHERE id = v_event_id;
  END IF;

  -- Link ILCA 6 to weekend event
  UPDATE public.regattas SET event_id = v_event_id WHERE slug = 'pulau-ujong-2026-ilca-6';

  -- Regatta: Pulau Ujong Regatta 2026 (Optimist Gold) (pulau-ujong-gold-feb-26-2026-02-21)
  SELECT id INTO v_gold_id FROM public.regattas WHERE slug = 'pulau-ujong-gold-feb-26-2026-02-21' LIMIT 1;
  IF v_gold_id IS NOT NULL THEN
    UPDATE public.regattas SET
      event_id = v_event_id,
      name = 'Pulau Ujong Regatta 2026 (Optimist Gold)',
      slug = 'pulau-ujong-gold-feb-26-2026-02-21',
      date = '2026-02-21',
      end_date = '2026-02-22',
      boat_class = 'Optimist',
      division = 'Gold',
      total_fleet_size = 90,
      race_count = 6,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/13180/event',
      registration_url = 'https://www.sailing.org.sg',
      schedule_notes = 'Pulau Ujong Regatta 2026 Optimist Gold fleet: 90 entries, 6 races sailed (1 discard).',
      status = 'published',
      updated_at = now()
    WHERE id = v_gold_id;
  ELSE
    v_gold_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_gold_id, v_event_id, 'Pulau Ujong Regatta 2026 (Optimist Gold)', 'pulau-ujong-gold-feb-26-2026-02-21', '2026-02-21', '2026-02-22',
      'Optimist', 'Gold', 90, 6,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation',
      'https://www.racingrulesofsailing.org/documents/13180/event', 'https://www.sailing.org.sg',
      'Pulau Ujong Regatta 2026 Optimist Gold fleet: 90 entries, 6 races sailed (1 discard).', 'published', now(), now()
    );
  END IF;
  DELETE FROM public.regatta_results WHERE regatta_id = v_gold_id;

  -- Regatta: Pulau Ujong Regatta 2026 (Optimist Silver) (pulau-ujong-silver-feb-26-2026-02-21)
  SELECT id INTO v_silver_id FROM public.regattas WHERE slug = 'pulau-ujong-silver-feb-26-2026-02-21' LIMIT 1;
  IF v_silver_id IS NOT NULL THEN
    UPDATE public.regattas SET
      event_id = v_event_id,
      name = 'Pulau Ujong Regatta 2026 (Optimist Silver)',
      slug = 'pulau-ujong-silver-feb-26-2026-02-21',
      date = '2026-02-21',
      end_date = '2026-02-22',
      boat_class = 'Optimist',
      division = 'Silver',
      total_fleet_size = 68,
      race_count = 5,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/13180/event',
      registration_url = 'https://www.sailing.org.sg',
      schedule_notes = 'Pulau Ujong Regatta 2026 Optimist Silver fleet: 68 entries, 5 races sailed (1 discard).',
      status = 'published',
      updated_at = now()
    WHERE id = v_silver_id;
  ELSE
    v_silver_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_silver_id, v_event_id, 'Pulau Ujong Regatta 2026 (Optimist Silver)', 'pulau-ujong-silver-feb-26-2026-02-21', '2026-02-21', '2026-02-22',
      'Optimist', 'Silver', 68, 5,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation',
      'https://www.racingrulesofsailing.org/documents/13180/event', 'https://www.sailing.org.sg',
      'Pulau Ujong Regatta 2026 Optimist Silver fleet: 68 entries, 5 races sailed (1 discard).', 'published', now(), now()
    );
  END IF;
  DELETE FROM public.regatta_results WHERE regatta_id = v_silver_id;

  -- Regatta: Pulau Ujong Regatta 2026 (ILCA 4) (pulau-ujong-ilca-feb-26-2026-02-21)
  SELECT id INTO v_ilca4_id FROM public.regattas WHERE slug = 'pulau-ujong-ilca-feb-26-2026-02-21' LIMIT 1;
  IF v_ilca4_id IS NOT NULL THEN
    UPDATE public.regattas SET
      event_id = v_event_id,
      name = 'Pulau Ujong Regatta 2026 (ILCA 4)',
      slug = 'pulau-ujong-ilca-feb-26-2026-02-21',
      date = '2026-02-21',
      end_date = '2026-02-22',
      boat_class = 'ILCA 4',
      division = 'Open',
      total_fleet_size = 54,
      race_count = 6,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/13180/event',
      registration_url = 'https://www.sailing.org.sg',
      schedule_notes = 'Pulau Ujong Regatta 2026 ILCA 4 class: 54 entries, 6 races sailed (1 discard).',
      status = 'published',
      updated_at = now()
    WHERE id = v_ilca4_id;
  ELSE
    v_ilca4_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_ilca4_id, v_event_id, 'Pulau Ujong Regatta 2026 (ILCA 4)', 'pulau-ujong-ilca-feb-26-2026-02-21', '2026-02-21', '2026-02-22',
      'ILCA 4', 'Open', 54, 6,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation',
      'https://www.racingrulesofsailing.org/documents/13180/event', 'https://www.sailing.org.sg',
      'Pulau Ujong Regatta 2026 ILCA 4 class: 54 entries, 6 races sailed (1 discard).', 'published', now(), now()
    );
  END IF;
  DELETE FROM public.regatta_results WHERE regatta_id = v_ilca4_id;

  -- Regatta: Pulau Ujong Regatta 2026 (29er) (pulau-ujong-2026-29er)
  SELECT id INTO v_29er_id FROM public.regattas WHERE slug = 'pulau-ujong-2026-29er' LIMIT 1;
  IF v_29er_id IS NOT NULL THEN
    UPDATE public.regattas SET
      event_id = v_event_id,
      name = 'Pulau Ujong Regatta 2026 (29er)',
      slug = 'pulau-ujong-2026-29er',
      date = '2026-02-21',
      end_date = '2026-02-22',
      boat_class = '29er',
      division = 'Open',
      total_fleet_size = 3,
      race_count = 8,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/13180/event',
      registration_url = 'https://www.sailing.org.sg',
      schedule_notes = 'Pulau Ujong Regatta 2026 29er class: 3 entries, 8 races sailed (1 discard).',
      status = 'published',
      updated_at = now()
    WHERE id = v_29er_id;
  ELSE
    v_29er_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_29er_id, v_event_id, 'Pulau Ujong Regatta 2026 (29er)', 'pulau-ujong-2026-29er', '2026-02-21', '2026-02-22',
      '29er', 'Open', 3, 8,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation',
      'https://www.racingrulesofsailing.org/documents/13180/event', 'https://www.sailing.org.sg',
      'Pulau Ujong Regatta 2026 29er class: 3 entries, 8 races sailed (1 discard).', 'published', now(), now()
    );
  END IF;
  DELETE FROM public.regatta_results WHERE regatta_id = v_29er_id;

  -- Regatta: Pulau Ujong Regatta 2026 (Techno 293) (pulau-ujong-2026-techno293)
  SELECT id INTO v_techno_id FROM public.regattas WHERE slug = 'pulau-ujong-2026-techno293' LIMIT 1;
  IF v_techno_id IS NOT NULL THEN
    UPDATE public.regattas SET
      event_id = v_event_id,
      name = 'Pulau Ujong Regatta 2026 (Techno 293)',
      slug = 'pulau-ujong-2026-techno293',
      date = '2026-02-21',
      end_date = '2026-02-22',
      boat_class = 'Techno 293',
      division = 'Open',
      total_fleet_size = 5,
      race_count = 7,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/13180/event',
      registration_url = 'https://www.sailing.org.sg',
      schedule_notes = 'Pulau Ujong Regatta 2026 Techno 293 class: 5 entries, 7 races sailed (1 discard).',
      status = 'published',
      updated_at = now()
    WHERE id = v_techno_id;
  ELSE
    v_techno_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_techno_id, v_event_id, 'Pulau Ujong Regatta 2026 (Techno 293)', 'pulau-ujong-2026-techno293', '2026-02-21', '2026-02-22',
      'Techno 293', 'Open', 5, 7,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation',
      'https://www.racingrulesofsailing.org/documents/13180/event', 'https://www.sailing.org.sg',
      'Pulau Ujong Regatta 2026 Techno 293 class: 5 entries, 7 races sailed (1 discard).', 'published', now(), now()
    );
  END IF;
  DELETE FROM public.regatta_results WHERE regatta_id = v_techno_id;

  -- Regatta: Pulau Ujong Regatta 2026 (iQFOiL) (pulau-ujong-2026-iqfoil)
  SELECT id INTO v_iqfoil_id FROM public.regattas WHERE slug = 'pulau-ujong-2026-iqfoil' LIMIT 1;
  IF v_iqfoil_id IS NOT NULL THEN
    UPDATE public.regattas SET
      event_id = v_event_id,
      name = 'Pulau Ujong Regatta 2026 (iQFOiL)',
      slug = 'pulau-ujong-2026-iqfoil',
      date = '2026-02-21',
      end_date = '2026-02-22',
      boat_class = 'iQFOiL',
      division = 'Open',
      total_fleet_size = 3,
      race_count = 4,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/13180/event',
      registration_url = 'https://www.sailing.org.sg',
      schedule_notes = 'Pulau Ujong Regatta 2026 iQFOiL class: 3 entries, 4 races sailed (1 discard).',
      status = 'published',
      updated_at = now()
    WHERE id = v_iqfoil_id;
  ELSE
    v_iqfoil_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_iqfoil_id, v_event_id, 'Pulau Ujong Regatta 2026 (iQFOiL)', 'pulau-ujong-2026-iqfoil', '2026-02-21', '2026-02-22',
      'iQFOiL', 'Open', 3, 4,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation',
      'https://www.racingrulesofsailing.org/documents/13180/event', 'https://www.sailing.org.sg',
      'Pulau Ujong Regatta 2026 iQFOiL class: 3 entries, 4 races sailed (1 discard).', 'published', now(), now()
    );
  END IF;
  DELETE FROM public.regatta_results WHERE regatta_id = v_iqfoil_id;

  -- ==========================================================================
  -- OPTIMIST GOLD FLEET (90 competitors)
  -- ==========================================================================

  -- [Gold] Rank 1: Lucas Zhihong Cao (149)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lucas Zhihong Cao')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lucas Zhihong Cao', 'lucas-zhihong-cao-cba056', '149', 'SAF Yacht Club', 'RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '149' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
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
    v_res_id, v_gold_id, v_sailor_id, 1, 21.0, 12.0, false, 'M', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 2, 9.0, NULL, true, '(9)', now()),
    (gen_random_uuid(), v_res_id, 3, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 4, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 5, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 6, 1.0, NULL, false, '1', now());

  -- [Gold] Rank 2: Kevin Jun Yi Ho (171)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kevin Jun Yi Ho')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kevin Jun Yi Ho', 'kevin-jun-yi-ho-9417d0', '171', 'SAF Yacht Club', 'RAFFLES INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '171' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
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
    v_res_id, v_gold_id, v_sailor_id, 2, 47.0, 18.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 2, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 3, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 4, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 5, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 6, 29.0, NULL, true, '(29)', now());

  -- [Gold] Rank 3: Lyric Yuxuan Li (728)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lyric Yuxuan Li')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lyric Yuxuan Li', 'lyric-yuxuan-li-340454', '728', 'Changi Sailing Club', 'RAFFLES GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '728' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'RAFFLES GIRLS'' SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 3, 39.0, 22.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 2, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 3, 17.0, NULL, true, '(17)', now()),
    (gen_random_uuid(), v_res_id, 4, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 5, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 6, 13.0, NULL, false, '13', now());

  -- [Gold] Rank 4: Anya Alessia Zahedi (159)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Anya Alessia Zahedi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Anya Alessia Zahedi', 'anya-alessia-zahedi-36d18a', '159', 'PAssion Wave', 'RAFFLES GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '159' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'RAFFLES GIRLS'' SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 4, 78.0, 39.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 2, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 3, 39.0, NULL, true, '(39)', now()),
    (gen_random_uuid(), v_res_id, 4, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 5, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 6, 7.0, NULL, false, '7', now());

  -- [Gold] Rank 5: Ethan Lee (83)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ethan Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ethan Lee', 'ethan-lee-6efc56', '83', 'PAssion Wave', 'VICTORIA SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '83' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'VICTORIA SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 5, 63.0, 40.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 2, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 3, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 4, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 5, 23.0, NULL, true, '(23)', now()),
    (gen_random_uuid(), v_res_id, 6, 4.0, NULL, false, '4', now());

  -- [Gold] Rank 6: Ashlyn Tham (4452)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ashlyn Tham')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ashlyn Tham', 'ashlyn-tham-eb2687', '4452', 'PAssion Wave', 'ST. HILDA''S SECONDARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4452' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'ST. HILDA''S SECONDARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 6, 56.0, 42.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 14.0, NULL, true, '(14)', now()),
    (gen_random_uuid(), v_res_id, 2, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 3, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 4, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 5, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 6, 11.0, NULL, false, '11', now());

  -- [Gold] Rank 7: Elijah Ong (140)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elijah Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elijah Ong', 'elijah-ong-237c06', '140', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '140' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
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
    v_res_id, v_gold_id, v_sailor_id, 7, 82.0, 47.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 2, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 3, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 4, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 5, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 6, 35.0, NULL, true, '(35)', now());

  -- [Gold] Rank 8: Xuan Ya Tong (154)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Xuan Ya Tong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Xuan Ya Tong', 'xuan-ya-tong-663e27', '154', 'Constant Wind', NULL, 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '154' ELSE sail_number END,
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
    v_res_id, v_gold_id, v_sailor_id, 8, 71.0, 47.0, false, 'F', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 2, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 3, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 4, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 5, 24.0, NULL, true, '(24)', now()),
    (gen_random_uuid(), v_res_id, 6, 14.0, NULL, false, '14', now());

  -- [Gold] Rank 9: Alyssa Li Lin Wong (150)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Alyssa Li Lin Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Alyssa Li Lin Wong', 'alyssa-li-lin-wong-c063db', '150', 'SAF Yacht Club', 'RAFFLES GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '150' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'RAFFLES GIRLS'' SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 9, 79.0, 52.0, false, 'F', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 2, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 3, 27.0, NULL, true, '(27)', now()),
    (gen_random_uuid(), v_res_id, 4, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 5, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 6, 25.0, NULL, false, '25', now());

  -- [Gold] Rank 10: Rahul Rajakanth (2006)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Rahul Rajakanth')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Rahul Rajakanth', 'rahul-rajakanth-2d35d5', '2006', 'Constant Wind', 'ANGLO-CHINESE SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2006' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
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
    v_res_id, v_gold_id, v_sailor_id, 10, 78.0, 53.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 2, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 3, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 4, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 5, 25.0, NULL, true, '(25)', now()),
    (gen_random_uuid(), v_res_id, 6, 15.0, NULL, false, '15', now());

  -- [Gold] Rank 11: Elliot Goh (3103)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Elliot Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Elliot Goh', 'elliot-goh-c08f54', '3103', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3103' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
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
    v_res_id, v_gold_id, v_sailor_id, 11, 75.0, 55.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 2, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 3, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 4, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 5, 20.0, NULL, true, '(20)', now()),
    (gen_random_uuid(), v_res_id, 6, 8.0, NULL, false, '8', now());

  -- [Gold] Rank 12: Nathaniel Kaiden Ng (3344)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nathaniel Kaiden Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nathaniel Kaiden Ng', 'nathaniel-kaiden-ng-1db883', '3344', 'PAssion Wave', 'ANGLO-CHINESE SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3344' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
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
    v_res_id, v_gold_id, v_sailor_id, 12, 94.0, 58.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 2, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 3, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 4, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 5, 36.0, NULL, true, '(36)', now()),
    (gen_random_uuid(), v_res_id, 6, 2.0, NULL, false, '2', now());

  -- [Gold] Rank 13: Zhi Tong Wai (157)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zhi Tong Wai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zhi Tong Wai', 'zhi-tong-wai-9debc5', '157', 'SAF Yacht Club', NULL, 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '157' ELSE sail_number END,
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
    v_res_id, v_gold_id, v_sailor_id, 13, 79.0, 60.0, false, 'F', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 19.0, NULL, true, '(19)', now()),
    (gen_random_uuid(), v_res_id, 2, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 3, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 4, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 5, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 6, 18.0, NULL, false, '18', now());

  -- [Gold] Rank 14: Jedd Zhi Hao Lam (2000)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 14, 95.0, 67.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 2, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 3, 28.0, NULL, true, '(28)', now()),
    (gen_random_uuid(), v_res_id, 4, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 5, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 6, 6.0, NULL, false, '6', now());

  -- [Gold] Rank 15: Ethan Zhi Ren Low (78)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 15, 88.0, 69.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 2, 19.0, NULL, true, '(19)', now()),
    (gen_random_uuid(), v_res_id, 3, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 4, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 5, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 6, 10.0, NULL, false, '10', now());

  -- [Gold] Rank 16: Kirsten En Ting Tan (3663)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 16, 143.0, 77.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 2, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 3, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 4, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 5, 66.0, NULL, true, '(66)', now()),
    (gen_random_uuid(), v_res_id, 6, 9.0, NULL, false, '9', now());

  -- [Gold] Rank 17: Olivia Ting Jia Cheong (3002)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Olivia Ting Jia Cheong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Olivia Ting Jia Cheong', 'olivia-ting-jia-cheong-6eddaf', '3002', 'SAF Yacht Club', 'RAFFLES GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3002' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'RAFFLES GIRLS'' SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 17, 120.0, 77.0, false, 'F', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 2, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 3, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 4, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 5, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 6, 43.0, NULL, true, '(43)', now());

  -- [Gold] Rank 18: Dylan Yue Teng Goh (3800)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 18, 143.0, 84.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 2, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 3, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 4, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 5, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 6, 59.0, NULL, true, '(59)', now());

  -- [Gold] Rank 19: Kaelyn Dayna Zhi Yi (3113)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kaelyn Dayna Zhi Yi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kaelyn Dayna Zhi Yi', 'kaelyn-dayna-zhi-yi-27345c', '3113', 'SAF Yacht Club', 'RAFFLES GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3113' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'RAFFLES GIRLS'' SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 19, 114.0, 86.0, false, 'F', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 2, 28.0, NULL, true, '(28)', now()),
    (gen_random_uuid(), v_res_id, 3, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 4, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 5, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 6, 17.0, NULL, false, '17', now());

  -- [Gold] Rank 20: Damien Huang (3300)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 20, 131.0, 88.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 43.0, NULL, true, '(43)', now()),
    (gen_random_uuid(), v_res_id, 2, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 3, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 4, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 5, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 6, 12.0, NULL, false, '12', now());

  -- [Gold] Rank 21: Jairus Xin Jie Teo (4073)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jairus Xin Jie Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jairus Xin Jie Teo', 'jairus-xin-jie-teo-b34134', '4073', 'SAF Yacht Club', NULL, 'M', 'SGP', now(), now()
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
    v_res_id, v_gold_id, v_sailor_id, 21, 126.0, 95.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 2, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 3, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 4, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 5, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 6, 31.0, NULL, true, '(31)', now());

  -- [Gold] Rank 22: Siti Ra'idah Binte Mohd 1141 (F)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Siti Ra''idah Binte Mohd 1141')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Siti Ra''idah Binte Mohd 1141', 'siti-ra-idah-binte-mohd-1141-61c180', 'F', 'PAssion Wave', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN 'F' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 22, 129.0, 96.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 2, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 3, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 4, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 5, 33.0, NULL, true, '(33)', now()),
    (gen_random_uuid(), v_res_id, 6, 32.0, NULL, false, '32', now());

  -- [Gold] Rank 23: Charles Shing Chak (716)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Charles Shing Chak')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Charles Shing Chak', 'charles-shing-chak-81d180', '716', 'Changi Sailing Club', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '716' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
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
    v_res_id, v_gold_id, v_sailor_id, 23, 186.0, 111.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 2, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 3, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 4, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 5, 75.0, NULL, true, '(75)', now()),
    (gen_random_uuid(), v_res_id, 6, 22.0, NULL, false, '22', now());

  -- [Gold] Rank 24: Jaye Xi En Low (3179)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jaye Xi En Low')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jaye Xi En Low', 'jaye-xi-en-low-b72a6b', '3179', 'PAssion Wave', 'DUNMAN HIGH SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3179' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'DUNMAN HIGH SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 24, 174.0, 125.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 2, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 3, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 4, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 5, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 6, 49.0, NULL, true, '(49)', now());

  -- [Gold] Rank 25: Shin Chen Rui Lin (3333)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 25, 199.0, 138.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 2, 61.0, NULL, true, '(61)', now()),
    (gen_random_uuid(), v_res_id, 3, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 4, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 5, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 6, 38.0, NULL, false, '38', now());

  -- [Gold] Rank 26: Edrei En Xu Ong (3957)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 26, 200.0, 142.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 58.0, NULL, true, '(58)', now()),
    (gen_random_uuid(), v_res_id, 2, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 3, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 4, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 5, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 6, 16.0, NULL, false, '16', now());

  -- [Gold] Rank 27: Darian Huang (3700)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 27, 194.0, 142.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 2, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 3, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 4, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 5, 52.0, NULL, true, '(52)', now()),
    (gen_random_uuid(), v_res_id, 6, 24.0, NULL, false, '24', now());

  -- [Gold] Rank 28: Joel Han Sheng Ong (2014)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 28, 222.0, 158.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 64.0, NULL, true, '(64)', now()),
    (gen_random_uuid(), v_res_id, 2, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 3, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 4, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 5, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 6, 23.0, NULL, false, '23', now());

  -- [Gold] Rank 29: Jeremiah Rui Feng Ong (3373)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 29, 206.0, 161.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 45.0, NULL, true, '(45)', now()),
    (gen_random_uuid(), v_res_id, 2, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 3, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 4, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 5, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 6, 19.0, NULL, false, '19', now());

  -- [Gold] Rank 30: Luke Yi Jie Loh (3322)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 30, 203.0, 162.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 41.0, NULL, true, '(41)', now()),
    (gen_random_uuid(), v_res_id, 2, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 3, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 4, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 5, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 6, 33.0, NULL, false, '33', now());

  -- [Gold] Rank 31: Nicole Jing Chen Wong (3006)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 31, 219.0, 166.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 2, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 3, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 4, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 5, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 6, 53.0, NULL, true, '(53)', now());

  -- [Gold] Rank 32: Lavene Rui Xuan Lim (3553)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lavene Rui Xuan Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lavene Rui Xuan Lim', 'lavene-rui-xuan-lim-08847a', '3553', 'SAF Yacht Club', NULL, 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3553' ELSE sail_number END,
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
    v_res_id, v_gold_id, v_sailor_id, 32, 231.0, 167.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 2, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 3, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 4, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 5, 64.0, NULL, true, '(64)', now()),
    (gen_random_uuid(), v_res_id, 6, 46.0, NULL, false, '46', now());

  -- [Gold] Rank 33: Tan Herng Yee (3000)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tan Herng Yee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tan Herng Yee', 'tan-herng-yee-905a15', '3000', 'SAF Yacht Club', 'ANGLO-CHINESE SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3000' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
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
    v_res_id, v_gold_id, v_sailor_id, 33, 239.0, 171.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 68.0, NULL, true, '(68)', now()),
    (gen_random_uuid(), v_res_id, 2, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 3, 52.0, NULL, false, '52', now()),
    (gen_random_uuid(), v_res_id, 4, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 5, 61.0, NULL, false, '61', now()),
    (gen_random_uuid(), v_res_id, 6, 3.0, NULL, false, '3', now());

  -- [Gold] Rank 34: Timothy Kai Zhe Ng (2023)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 34, 231.0, 171.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 60.0, NULL, true, '(60)', now()),
    (gen_random_uuid(), v_res_id, 2, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 3, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 4, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 5, 56.0, NULL, false, '56', now()),
    (gen_random_uuid(), v_res_id, 6, 21.0, NULL, false, '21', now());

  -- [Gold] Rank 35: Joel Zhuo Le Khoo (4730)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 35, 233.0, 175.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 2, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 3, 58.0, NULL, true, '(58)', now()),
    (gen_random_uuid(), v_res_id, 4, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 5, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 6, 36.0, NULL, false, '36', now());

  -- [Gold] Rank 36: Rui Ling Teo (3820)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 36, 230.0, 176.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 2, 54.0, NULL, true, '(54)', now()),
    (gen_random_uuid(), v_res_id, 3, 51.0, NULL, false, '51', now()),
    (gen_random_uuid(), v_res_id, 4, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 5, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 6, 51.0, NULL, false, '51', now());

  -- [Gold] Rank 37: Joseph Kia Guan Tan (3688)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 37, 229.0, 179.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 2, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 3, 50.0, NULL, true, '(50)', now()),
    (gen_random_uuid(), v_res_id, 4, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 5, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 6, 44.0, NULL, false, '44', now());

  -- [Gold] Rank 38: Joshua Zhi Kai Tan (3036)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 38, 245.0, 180.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 56.0, NULL, false, '56', now()),
    (gen_random_uuid(), v_res_id, 2, 57.0, NULL, false, '57', now()),
    (gen_random_uuid(), v_res_id, 3, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 4, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 5, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 6, 65.0, NULL, true, '(65)', now());

  -- [Gold] Rank 39: Lucas Rui Kai Lim (3355)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lucas Rui Kai Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lucas Rui Kai Lim', 'lucas-rui-kai-lim-476ff6', '3355', 'SAF Yacht Club', 'ST. JOSEPH''S INSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3355' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. JOSEPH''S INSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 39, 243.0, 180.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 2, 63.0, NULL, true, '(63)', now()),
    (gen_random_uuid(), v_res_id, 3, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 4, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 5, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 6, 45.0, NULL, false, '45', now());

  -- [Gold] Rank 40: Rachel Qian Hui Lim (3197)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 40, 250.0, 185.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 2, 58.0, NULL, false, '58', now()),
    (gen_random_uuid(), v_res_id, 3, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 4, 65.0, NULL, true, '(65)', now()),
    (gen_random_uuid(), v_res_id, 5, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 6, 26.0, NULL, false, '26', now());

  -- [Gold] Rank 41: Katelynn Kai En Lee (3383)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Katelynn Kai En Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Katelynn Kai En Lee', 'katelynn-kai-en-lee-d21524', '3383', 'SAF Yacht Club', 'ST. ANTHONY''S CANOSSIAN', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3383' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. ANTHONY''S CANOSSIAN'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 41, 250.0, 186.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 51.0, NULL, false, '51', now()),
    (gen_random_uuid(), v_res_id, 2, 64.0, NULL, true, '(64)', now()),
    (gen_random_uuid(), v_res_id, 3, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 4, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 5, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 6, 5.0, NULL, false, '5', now());

  -- [Gold] Rank 42: Yvette Yi Min Chow (3151)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yvette Yi Min Chow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yvette Yi Min Chow', 'yvette-yi-min-chow-45eecd', '3151', 'SAF Yacht Club', 'PEI HWA PRESBYTERIAN PRIMARY', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3151' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'PEI HWA PRESBYTERIAN PRIMARY'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 42, 260.0, 188.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, NULL, false, '59', now()),
    (gen_random_uuid(), v_res_id, 3, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 4, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 5, 72.0, NULL, true, '(72)', now()),
    (gen_random_uuid(), v_res_id, 6, 39.0, NULL, false, '39', now());

  -- [Gold] Rank 43: Yuk Pin Lim (3880)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 43, 267.0, 189.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 2, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 3, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 4, 63.0, NULL, false, '63', now()),
    (gen_random_uuid(), v_res_id, 5, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 6, 78.0, NULL, true, '(78)', now());

  -- [Gold] Rank 44: Padmaeja Rajakanth (2022)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 44, 243.0, 190.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 2, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 3, 53.0, NULL, true, '(53)', now()),
    (gen_random_uuid(), v_res_id, 4, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 5, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 6, 28.0, NULL, false, '28', now());

  -- [Gold] Rank 45: Dan Guan You Toh (3811)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 45, 263.0, 194.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 69.0, NULL, true, '(69)', now()),
    (gen_random_uuid(), v_res_id, 2, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 3, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 4, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 5, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 6, 41.0, NULL, false, '41', now());

  -- [Gold] Rank 46: Joash Jit Yin Kok (3057)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joash Jit Yin Kok')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joash Jit Yin Kok', 'joash-jit-yin-kok-0d3f29', '3057', 'PAssion Wave', 'ANGLO-CHINESE SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3057' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
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
    v_res_id, v_gold_id, v_sailor_id, 46, 273.0, 199.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 70.0, NULL, false, '70', now()),
    (gen_random_uuid(), v_res_id, 2, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 3, 65.0, NULL, false, '65', now()),
    (gen_random_uuid(), v_res_id, 4, 74.0, NULL, true, '(74)', now()),
    (gen_random_uuid(), v_res_id, 5, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 6, 20.0, NULL, false, '20', now());

  -- [Gold] Rank 47: Jude Nathan Wong (3495)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jude Nathan Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jude Nathan Wong', 'jude-nathan-wong-8736da', '3495', 'SAF Yacht Club', NULL, 'M', 'SGP', now(), now()
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
    v_res_id, v_gold_id, v_sailor_id, 47, 268.0, 208.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 2, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 3, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 4, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 5, 60.0, NULL, true, '(60)', now()),
    (gen_random_uuid(), v_res_id, 6, 60.0, NULL, false, '60', now());

  -- [Gold] Rank 48: Kyle Jeremy Zhi Jun (3183)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kyle Jeremy Zhi Jun')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kyle Jeremy Zhi Jun', 'kyle-jeremy-zhi-jun-da70ec', '3183', 'SAF Yacht Club', NULL, 'M', 'SGP', now(), now()
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
    v_res_id, v_gold_id, v_sailor_id, 48, 282.0, 210.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 2, 56.0, NULL, false, '56', now()),
    (gen_random_uuid(), v_res_id, 3, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 4, 72.0, NULL, true, '(72)', now()),
    (gen_random_uuid(), v_res_id, 5, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 6, 37.0, NULL, false, '37', now());

  -- [Gold] Rank 49: Meera Srihari (3889)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Meera Srihari')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Meera Srihari', 'meera-srihari-7766b6', '3889', 'SAF Yacht Club', NULL, 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3889' ELSE sail_number END,
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
    v_res_id, v_gold_id, v_sailor_id, 49, 297.0, 224.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 2, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 3, 73.0, NULL, true, '(73)', now()),
    (gen_random_uuid(), v_res_id, 4, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 5, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 6, 55.0, NULL, false, '55', now());

  -- [Gold] Rank 50: Mikaela Hui Ting Wong (3029)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 50, 300.0, 230.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 2, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 3, 63.0, NULL, false, '63', now()),
    (gen_random_uuid(), v_res_id, 4, 62.0, NULL, false, '62', now()),
    (gen_random_uuid(), v_res_id, 5, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 6, 70.0, NULL, true, '(70)', now());

  -- [Gold] Rank 51: 2030 (12&U)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('2030')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, '2030', '2030-2d579d', '12&U', 'Constant Wind', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '12&U' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
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
    v_res_id, v_gold_id, v_sailor_id, 51, 303.0, 246.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 2, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 3, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 4, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 5, 57.0, NULL, true, '(57)', now()),
    (gen_random_uuid(), v_res_id, 6, 57.0, NULL, false, '57', now());

  -- [Gold] Rank 52: Aidan Armand Anuar (3143)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aidan Armand Anuar')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aidan Armand Anuar', 'aidan-armand-anuar-a6820f', '3143', 'SAF Yacht Club', 'TANJONG KATONG PRIMARY', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3143' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'TANJONG KATONG PRIMARY'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 52, 314.0, 248.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 61.0, NULL, false, '61', now()),
    (gen_random_uuid(), v_res_id, 2, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 3, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 4, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 5, 63.0, NULL, false, '63', now()),
    (gen_random_uuid(), v_res_id, 6, 66.0, NULL, true, '(66)', now());

  -- [Gold] Rank 53: Aaron Zhiyi Chiang (3128)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 53, 337.0, 251.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 2, 52.0, NULL, false, '52', now()),
    (gen_random_uuid(), v_res_id, 3, 59.0, NULL, false, '59', now()),
    (gen_random_uuid(), v_res_id, 4, 64.0, NULL, false, '64', now()),
    (gen_random_uuid(), v_res_id, 5, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 6, 86.0, NULL, true, '(86)', now());

  -- [Gold] Rank 54: Weihan Mao (3619)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Weihan Mao')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Weihan Mao', 'weihan-mao-a18bf2', '3619', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3619' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
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
    v_res_id, v_gold_id, v_sailor_id, 54, 334.0, 257.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 2, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 3, 71.0, NULL, false, '71', now()),
    (gen_random_uuid(), v_res_id, 4, 68.0, NULL, false, '68', now()),
    (gen_random_uuid(), v_res_id, 5, 77.0, NULL, true, '(77)', now()),
    (gen_random_uuid(), v_res_id, 6, 52.0, NULL, false, '52', now());

  -- [Gold] Rank 55: Yen Yu Kai (758)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yen Yu Kai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yen Yu Kai', 'yen-yu-kai-22dee6', '758', 'Changi Sailing Club', 'RAFFLES GIRLS'' SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '758' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'RAFFLES GIRLS'' SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 55, 334.0, 258.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 2, 74.0, NULL, false, '74', now()),
    (gen_random_uuid(), v_res_id, 3, 60.0, NULL, false, '60', now()),
    (gen_random_uuid(), v_res_id, 4, 53.0, NULL, false, '53', now()),
    (gen_random_uuid(), v_res_id, 5, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 6, 76.0, NULL, true, '(76)', now());

  -- [Gold] Rank 56: Gentaro Noah Lee (4471)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gentaro Noah Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gentaro Noah Lee', 'gentaro-noah-lee-77d06e', '4471', 'PAssion Wave', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4471' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 56, 339.0, 258.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 2, 76.0, NULL, false, '76', now()),
    (gen_random_uuid(), v_res_id, 3, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 4, 56.0, NULL, false, '56', now()),
    (gen_random_uuid(), v_res_id, 5, 81.0, NULL, true, '(81)', now()),
    (gen_random_uuid(), v_res_id, 6, 42.0, NULL, false, '42', now());

  -- [Gold] Rank 57: Jared Soon Kit Liew (2002)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 57, 350.0, 259.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 81.0, NULL, false, '81', now()),
    (gen_random_uuid(), v_res_id, 2, 51.0, NULL, false, '51', now()),
    (gen_random_uuid(), v_res_id, 3, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 4, 91.0, 'RET', true, '(91 RET)', now()),
    (gen_random_uuid(), v_res_id, 5, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 6, 63.0, NULL, false, '63', now());

  -- [Gold] Rank 58: Ethan Jing Zhou Tan (3772)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 58, 328.0, 260.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 2, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 3, 64.0, NULL, false, '64', now()),
    (gen_random_uuid(), v_res_id, 4, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 5, 68.0, NULL, true, '(68)', now()),
    (gen_random_uuid(), v_res_id, 6, 54.0, NULL, false, '54', now());

  -- [Gold] Rank 59: Quintan Rupert Low (4681)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 59, 334.0, 265.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 55.0, NULL, false, '55', now()),
    (gen_random_uuid(), v_res_id, 2, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 3, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 4, 67.0, NULL, false, '67', now()),
    (gen_random_uuid(), v_res_id, 5, 53.0, NULL, false, '53', now()),
    (gen_random_uuid(), v_res_id, 6, 69.0, NULL, true, '(69)', now());

  -- [Gold] Rank 60: Lucas Jun Sheng Seow (2047)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 60, 360.0, 279.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 57.0, NULL, false, '57', now()),
    (gen_random_uuid(), v_res_id, 2, 81.0, NULL, true, '(81)', now()),
    (gen_random_uuid(), v_res_id, 3, 78.0, NULL, false, '78', now()),
    (gen_random_uuid(), v_res_id, 4, 79.0, NULL, false, '79', now()),
    (gen_random_uuid(), v_res_id, 5, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 6, 27.0, NULL, false, '27', now());

  -- [Gold] Rank 61: Christopher Soh (3168)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 61, 369.0, 284.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 53.0, NULL, false, '53', now()),
    (gen_random_uuid(), v_res_id, 2, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 3, 57.0, NULL, false, '57', now()),
    (gen_random_uuid(), v_res_id, 4, 51.0, NULL, false, '51', now()),
    (gen_random_uuid(), v_res_id, 5, 83.0, NULL, false, '83', now()),
    (gen_random_uuid(), v_res_id, 6, 85.0, NULL, true, '(85)', now());

  -- [Gold] Rank 62: Zachary Zhi En Low (3369)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zachary Zhi En Low')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zachary Zhi En Low', 'zachary-zhi-en-low-c7588c', '3369', 'SAF Yacht Club', 'ST. JOSEPH''S INSTITUTION', 'M', 'SGP', now(), now()
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 62, 375.0, 290.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 65.0, NULL, false, '65', now()),
    (gen_random_uuid(), v_res_id, 2, 85.0, NULL, true, '(85)', now()),
    (gen_random_uuid(), v_res_id, 3, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 4, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 5, 55.0, NULL, false, '55', now()),
    (gen_random_uuid(), v_res_id, 6, 80.0, NULL, false, '80', now());

  -- [Gold] Rank 63: Kyan Chun Hong Tan (4712)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kyan Chun Hong Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kyan Chun Hong Tan', 'kyan-chun-hong-tan-31b43c', '4712', 'SAF Yacht Club', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4712' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
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
    v_res_id, v_gold_id, v_sailor_id, 63, 374.0, 293.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 2, 77.0, NULL, false, '77', now()),
    (gen_random_uuid(), v_res_id, 3, 81.0, NULL, true, '(81)', now()),
    (gen_random_uuid(), v_res_id, 4, 69.0, NULL, false, '69', now()),
    (gen_random_uuid(), v_res_id, 5, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 6, 73.0, NULL, false, '73', now());

  -- [Gold] Rank 64: Estelle Rui En Yeo (SGP)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Estelle Rui En Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Estelle Rui En Yeo', 'estelle-rui-en-yeo-4b3c6c', 'SGP', 'Changi Sailing Club', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN 'SGP' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
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
    v_res_id, v_gold_id, v_sailor_id, 64, 384.0, 296.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 85.0, NULL, false, '85', now()),
    (gen_random_uuid(), v_res_id, 2, 88.0, NULL, true, '(88)', now()),
    (gen_random_uuid(), v_res_id, 3, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 4, 57.0, NULL, false, '57', now()),
    (gen_random_uuid(), v_res_id, 5, 59.0, NULL, false, '59', now()),
    (gen_random_uuid(), v_res_id, 6, 50.0, NULL, false, '50', now());

  -- [Gold] Rank 65: Nigel Jiang Long Ng (3363)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 65, 386.0, 301.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 63.0, NULL, false, '63', now()),
    (gen_random_uuid(), v_res_id, 2, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 3, 76.0, NULL, false, '76', now()),
    (gen_random_uuid(), v_res_id, 4, 70.0, NULL, false, '70', now()),
    (gen_random_uuid(), v_res_id, 5, 85.0, NULL, true, '(85)', now()),
    (gen_random_uuid(), v_res_id, 6, 67.0, NULL, false, '67', now());

  -- [Gold] Rank 66: Hagen Goh (3600)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hagen Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hagen Goh', 'hagen-goh-bf94a3', '3600', 'SAF Yacht Club', 'DOVER COURT INTERNATIONAL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3600' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'DOVER COURT INTERNATIONAL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 66, 384.0, 301.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 73.0, NULL, false, '73', now()),
    (gen_random_uuid(), v_res_id, 2, 62.0, NULL, false, '62', now()),
    (gen_random_uuid(), v_res_id, 3, 69.0, NULL, false, '69', now()),
    (gen_random_uuid(), v_res_id, 4, 55.0, NULL, false, '55', now()),
    (gen_random_uuid(), v_res_id, 5, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 6, 83.0, NULL, true, '(83)', now());

  -- [Gold] Rank 67: Gloria Yen Rui Kwok (2003)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gloria Yen Rui Kwok')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gloria Yen Rui Kwok', 'gloria-yen-rui-kwok-c8258b', '2003', 'Constant Wind', 'CHIJ (KATONG) PRIMARY', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2003' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'CHIJ (KATONG) PRIMARY'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 67, 391.0, 304.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 87.0, NULL, true, '(87)', now()),
    (gen_random_uuid(), v_res_id, 2, 66.0, NULL, false, '66', now()),
    (gen_random_uuid(), v_res_id, 3, 80.0, NULL, false, '80', now()),
    (gen_random_uuid(), v_res_id, 4, 59.0, NULL, false, '59', now()),
    (gen_random_uuid(), v_res_id, 5, 69.0, NULL, false, '69', now()),
    (gen_random_uuid(), v_res_id, 6, 30.0, NULL, false, '30', now());

  -- [Gold] Rank 68: Luke Tin Fong (2019)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Luke Tin Fong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Luke Tin Fong', 'luke-tin-fong-b7cdfb', '2019', 'Constant Wind', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2019' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
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
    v_res_id, v_gold_id, v_sailor_id, 68, 378.0, 304.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 74.0, NULL, true, '(74)', now()),
    (gen_random_uuid(), v_res_id, 2, 71.0, NULL, false, '71', now()),
    (gen_random_uuid(), v_res_id, 3, 55.0, NULL, false, '55', now()),
    (gen_random_uuid(), v_res_id, 4, 60.0, NULL, false, '60', now()),
    (gen_random_uuid(), v_res_id, 5, 71.0, NULL, false, '71', now()),
    (gen_random_uuid(), v_res_id, 6, 47.0, NULL, false, '47', now());

  -- [Gold] Rank 69: Tyler Koo (996)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 69, 376.0, 304.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 2, 53.0, NULL, false, '53', now()),
    (gen_random_uuid(), v_res_id, 3, 72.0, NULL, true, '(72)', now()),
    (gen_random_uuid(), v_res_id, 4, 66.0, NULL, false, '66', now()),
    (gen_random_uuid(), v_res_id, 5, 65.0, NULL, false, '65', now()),
    (gen_random_uuid(), v_res_id, 6, 71.0, NULL, false, '71', now());

  -- [Gold] Rank 70: Sage Yeh (796)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sage Yeh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sage Yeh', 'sage-yeh-dfe2f3', '796', 'Changi Sailing Club', 'PUNGGOL COVE PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '796' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'PUNGGOL COVE PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 70, 396.0, 305.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 75.0, NULL, false, '75', now()),
    (gen_random_uuid(), v_res_id, 2, 67.0, NULL, false, '67', now()),
    (gen_random_uuid(), v_res_id, 3, 77.0, NULL, false, '77', now()),
    (gen_random_uuid(), v_res_id, 4, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 5, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 6, 91.0, 'UFD', true, '(91 UFD)', now());

  -- [Gold] Rank 71: Isabelle Xinyi Zhang (2035)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 71, 392.0, 305.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 62.0, NULL, false, '62', now()),
    (gen_random_uuid(), v_res_id, 2, 79.0, NULL, false, '79', now()),
    (gen_random_uuid(), v_res_id, 3, 87.0, NULL, true, '(87)', now()),
    (gen_random_uuid(), v_res_id, 4, 71.0, NULL, false, '71', now()),
    (gen_random_uuid(), v_res_id, 5, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 6, 48.0, NULL, false, '48', now());

  -- [Gold] Rank 72: 700 (12&U)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('700')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, '700', '700-e5841d', '12&U', 'Changi Sailing Club', 'KONG HWA SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '12&U' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
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
    v_res_id, v_gold_id, v_sailor_id, 72, 387.0, 305.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 71.0, NULL, false, '71', now()),
    (gen_random_uuid(), v_res_id, 2, 82.0, NULL, true, '(82)', now()),
    (gen_random_uuid(), v_res_id, 3, 66.0, NULL, false, '66', now()),
    (gen_random_uuid(), v_res_id, 4, 61.0, NULL, false, '61', now()),
    (gen_random_uuid(), v_res_id, 5, 51.0, NULL, false, '51', now()),
    (gen_random_uuid(), v_res_id, 6, 56.0, NULL, false, '56', now());

  -- [Gold] Rank 73: Charlene Heng Ning (766)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Charlene Heng Ning')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Charlene Heng Ning', 'charlene-heng-ning-460149', '766', 'Changi Sailing Club', NULL, 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '766' ELSE sail_number END,
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
    v_res_id, v_gold_id, v_sailor_id, 73, 389.0, 306.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 2, 75.0, NULL, false, '75', now()),
    (gen_random_uuid(), v_res_id, 3, 83.0, NULL, true, '(83)', now()),
    (gen_random_uuid(), v_res_id, 4, 52.0, NULL, false, '52', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 6, 75.0, NULL, false, '75', now());

  -- [Gold] Rank 74: Tan Qi (3026)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 74, 393.0, 308.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 59.0, NULL, false, '59', now()),
    (gen_random_uuid(), v_res_id, 2, 69.0, NULL, false, '69', now()),
    (gen_random_uuid(), v_res_id, 3, 70.0, NULL, false, '70', now()),
    (gen_random_uuid(), v_res_id, 4, 85.0, NULL, true, '(85)', now()),
    (gen_random_uuid(), v_res_id, 5, 76.0, NULL, false, '76', now()),
    (gen_random_uuid(), v_res_id, 6, 34.0, NULL, false, '34', now());

  -- [Gold] Rank 75: Breyven Zhi Long Chan (3338)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 75, 397.0, 313.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 84.0, NULL, true, '(84)', now()),
    (gen_random_uuid(), v_res_id, 2, 73.0, NULL, false, '73', now()),
    (gen_random_uuid(), v_res_id, 3, 67.0, NULL, false, '67', now()),
    (gen_random_uuid(), v_res_id, 4, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 5, 58.0, NULL, false, '58', now()),
    (gen_random_uuid(), v_res_id, 6, 79.0, NULL, false, '79', now());

  -- [Gold] Rank 76: Boren Wang (2039)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 76, 407.0, 321.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 77.0, NULL, false, '77', now()),
    (gen_random_uuid(), v_res_id, 2, 68.0, NULL, false, '68', now()),
    (gen_random_uuid(), v_res_id, 3, 61.0, NULL, false, '61', now()),
    (gen_random_uuid(), v_res_id, 4, 75.0, NULL, false, '75', now()),
    (gen_random_uuid(), v_res_id, 5, 86.0, NULL, true, '(86)', now()),
    (gen_random_uuid(), v_res_id, 6, 40.0, NULL, false, '40', now());

  -- [Gold] Rank 77: Chen-Yi Kai (757)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 77, 408.0, 326.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 67.0, NULL, false, '67', now()),
    (gen_random_uuid(), v_res_id, 2, 55.0, NULL, false, '55', now()),
    (gen_random_uuid(), v_res_id, 3, 62.0, NULL, false, '62', now()),
    (gen_random_uuid(), v_res_id, 4, 82.0, NULL, true, '(82)', now()),
    (gen_random_uuid(), v_res_id, 5, 78.0, NULL, false, '78', now()),
    (gen_random_uuid(), v_res_id, 6, 64.0, NULL, false, '64', now());

  -- [Gold] Rank 78: Ryan Yong Jie Choo (3549)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ryan Yong Jie Choo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ryan Yong Jie Choo', 'ryan-yong-jie-choo-187724', '3549', 'Changi Sailing Club', 'ANGLO-CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3549' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
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
    v_res_id, v_gold_id, v_sailor_id, 78, 425.0, 334.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 52.0, NULL, false, '52', now()),
    (gen_random_uuid(), v_res_id, 2, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 3, 91.0, 'RET', true, '(91 RET)', now()),
    (gen_random_uuid(), v_res_id, 4, 91.0, 'DNF', false, '91 DNF', now()),
    (gen_random_uuid(), v_res_id, 5, 67.0, NULL, false, '67', now()),
    (gen_random_uuid(), v_res_id, 6, 82.0, NULL, false, '82', now());

  -- [Gold] Rank 79: Matthias Kai Lun Lee (3385)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 79, 414.0, 334.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 76.0, NULL, false, '76', now()),
    (gen_random_uuid(), v_res_id, 2, 65.0, NULL, false, '65', now()),
    (gen_random_uuid(), v_res_id, 3, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 4, 78.0, NULL, false, '78', now()),
    (gen_random_uuid(), v_res_id, 5, 80.0, NULL, true, '(80)', now()),
    (gen_random_uuid(), v_res_id, 6, 61.0, NULL, false, '61', now());

  -- [Gold] Rank 80: George Kai Whittington (799)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('George Kai Whittington')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'George Kai Whittington', 'george-kai-whittington-30adac', '799', 'Changi Sailing Club', 'ST. STEPHEN''S SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '799' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
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
    v_res_id, v_gold_id, v_sailor_id, 80, 420.0, 340.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 80.0, NULL, true, '(80)', now()),
    (gen_random_uuid(), v_res_id, 2, 60.0, NULL, false, '60', now()),
    (gen_random_uuid(), v_res_id, 3, 68.0, NULL, false, '68', now()),
    (gen_random_uuid(), v_res_id, 4, 80.0, NULL, false, '80', now()),
    (gen_random_uuid(), v_res_id, 5, 70.0, NULL, false, '70', now()),
    (gen_random_uuid(), v_res_id, 6, 62.0, NULL, false, '62', now());

  -- [Gold] Rank 81: Kenji Huan Zhe Tan (3999)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kenji Huan Zhe Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kenji Huan Zhe Tan', 'kenji-huan-zhe-tan-42be0d', '3999', 'SAF Yacht Club', NULL, 'M', 'SGP', now(), now()
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
    v_res_id, v_gold_id, v_sailor_id, 81, 416.0, 342.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 72.0, NULL, false, '72', now()),
    (gen_random_uuid(), v_res_id, 2, 70.0, NULL, false, '70', now()),
    (gen_random_uuid(), v_res_id, 3, 74.0, NULL, true, '(74)', now()),
    (gen_random_uuid(), v_res_id, 4, 58.0, NULL, false, '58', now()),
    (gen_random_uuid(), v_res_id, 5, 74.0, NULL, false, '74', now()),
    (gen_random_uuid(), v_res_id, 6, 68.0, NULL, false, '68', now());

  -- [Gold] Rank 82: 4729 (12&U)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('4729')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, '4729', '4729-a42517', '12&U', 'PAssion Wave', NULL, 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '12&U' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 82, 430.0, 351.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 79.0, NULL, true, '(79)', now()),
    (gen_random_uuid(), v_res_id, 2, 72.0, NULL, false, '72', now()),
    (gen_random_uuid(), v_res_id, 3, 75.0, NULL, false, '75', now()),
    (gen_random_uuid(), v_res_id, 4, 73.0, NULL, false, '73', now()),
    (gen_random_uuid(), v_res_id, 5, 73.0, NULL, false, '73', now()),
    (gen_random_uuid(), v_res_id, 6, 58.0, NULL, false, '58', now());

  -- [Gold] Rank 83: Denzel Seah (3925)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Denzel Seah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Denzel Seah', 'denzel-seah-4528a7', '3925', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3925' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
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
    v_res_id, v_gold_id, v_sailor_id, 83, 433.0, 354.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 66.0, NULL, false, '66', now()),
    (gen_random_uuid(), v_res_id, 2, 78.0, NULL, false, '78', now()),
    (gen_random_uuid(), v_res_id, 3, 79.0, NULL, true, '(79)', now()),
    (gen_random_uuid(), v_res_id, 4, 76.0, NULL, false, '76', now()),
    (gen_random_uuid(), v_res_id, 5, 62.0, NULL, false, '62', now()),
    (gen_random_uuid(), v_res_id, 6, 72.0, NULL, false, '72', now());

  -- [Gold] Rank 84: Aiden Kang Jun Wong (2018)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aiden Kang Jun Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aiden Kang Jun Wong', 'aiden-kang-jun-wong-2ea874', '2018', 'Constant Wind', 'MARIS STELLA HIGH SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2018' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'MARIS STELLA HIGH SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 84, 455.0, 372.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 83.0, NULL, true, '(83)', now()),
    (gen_random_uuid(), v_res_id, 2, 83.0, NULL, false, '83', now()),
    (gen_random_uuid(), v_res_id, 3, 56.0, NULL, false, '56', now()),
    (gen_random_uuid(), v_res_id, 4, 77.0, NULL, false, '77', now()),
    (gen_random_uuid(), v_res_id, 5, 79.0, NULL, false, '79', now()),
    (gen_random_uuid(), v_res_id, 6, 77.0, NULL, false, '77', now());

  -- [Gold] Rank 85: Xavier Yang Zheng (2037)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Xavier Yang Zheng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Xavier Yang Zheng', 'xavier-yang-zheng-324009', '2037', 'Constant Wind', 'ST. JOSEPH''S INSTITUTION JUNIOR', 'M', 'SGP', now(), now()
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 85, 492.0, 406.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 86.0, NULL, true, '(86)', now()),
    (gen_random_uuid(), v_res_id, 2, 84.0, NULL, false, '84', now()),
    (gen_random_uuid(), v_res_id, 3, 82.0, NULL, false, '82', now()),
    (gen_random_uuid(), v_res_id, 4, 84.0, NULL, false, '84', now()),
    (gen_random_uuid(), v_res_id, 5, 82.0, NULL, false, '82', now()),
    (gen_random_uuid(), v_res_id, 6, 74.0, NULL, false, '74', now());

  -- [Gold] Rank 86: Ashleigh Li Ying Teh (788)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 86, 497.0, 410.0, false, 'F', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 78.0, NULL, false, '78', now()),
    (gen_random_uuid(), v_res_id, 2, 87.0, NULL, true, '(87)', now()),
    (gen_random_uuid(), v_res_id, 3, 84.0, NULL, false, '84', now()),
    (gen_random_uuid(), v_res_id, 4, 83.0, NULL, false, '83', now()),
    (gen_random_uuid(), v_res_id, 5, 84.0, NULL, false, '84', now()),
    (gen_random_uuid(), v_res_id, 6, 81.0, NULL, false, '81', now());

  -- [Gold] Rank 87: Aidan See Hett Yeo (3112)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Aidan See Hett Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Aidan See Hett Yeo', 'aidan-see-hett-yeo-58713d', '3112', 'SAF Yacht Club', 'KUO CHUAN PRESBYTERIAN', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3112' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'KUO CHUAN PRESBYTERIAN'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 87, 507.0, 419.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 88.0, NULL, true, '(88)', now()),
    (gen_random_uuid(), v_res_id, 2, 80.0, NULL, false, '80', now()),
    (gen_random_uuid(), v_res_id, 3, 86.0, NULL, false, '86', now()),
    (gen_random_uuid(), v_res_id, 4, 81.0, NULL, false, '81', now()),
    (gen_random_uuid(), v_res_id, 5, 88.0, NULL, false, '88', now()),
    (gen_random_uuid(), v_res_id, 6, 84.0, NULL, false, '84', now());

  -- [Gold] Rank 88: Auwin Zhao Hong Leow 3405 (12&U)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Auwin Zhao Hong Leow 3405')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Auwin Zhao Hong Leow 3405', 'auwin-zhao-hong-leow-3405-d21f69', '12&U', 'SAF Yacht Club', NULL, 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '12&U' ELSE sail_number END,
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
    v_res_id, v_gold_id, v_sailor_id, 88, 513.0, 426.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 82.0, NULL, false, '82', now()),
    (gen_random_uuid(), v_res_id, 2, 86.0, NULL, false, '86', now()),
    (gen_random_uuid(), v_res_id, 3, 85.0, NULL, false, '85', now()),
    (gen_random_uuid(), v_res_id, 4, 86.0, NULL, false, '86', now()),
    (gen_random_uuid(), v_res_id, 5, 87.0, NULL, true, '(87)', now()),
    (gen_random_uuid(), v_res_id, 6, 87.0, NULL, false, '87', now());

  -- [Gold] Rank 89: Worawit Jutahkiti (2025)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Worawit Jutahkiti')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Worawit Jutahkiti', 'worawit-jutahkiti-3d0d11', '2025', 'Constant Wind', 'Catholic High School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2025' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'Catholic High School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 89, 546.0, 455.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 91.0, 'DNC', true, '(91 DNC)', now()),
    (gen_random_uuid(), v_res_id, 2, 91.0, 'DNC', false, '91 DNC', now()),
    (gen_random_uuid(), v_res_id, 3, 91.0, 'DNC', false, '91 DNC', now()),
    (gen_random_uuid(), v_res_id, 4, 91.0, 'DNC', false, '91 DNC', now()),
    (gen_random_uuid(), v_res_id, 5, 91.0, 'DNC', false, '91 DNC', now()),
    (gen_random_uuid(), v_res_id, 6, 91.0, 'DNC', false, '91 DNC', now());

  -- [Gold] Rank 89: Hanyue Ouyang (5003)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hanyue Ouyang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Hanyue Ouyang', 'hanyue-ouyang-cf51fd', '5003', 'ONE 15 Marina', 'Nanyang Primary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '5003' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'ONE 15 Marina'),
      school = COALESCE(school, 'Nanyang Primary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_gold_id, v_sailor_id, 89, 546.0, 455.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 91.0, 'DNC', true, '(91 DNC)', now()),
    (gen_random_uuid(), v_res_id, 2, 91.0, 'DNC', false, '91 DNC', now()),
    (gen_random_uuid(), v_res_id, 3, 91.0, 'DNC', false, '91 DNC', now()),
    (gen_random_uuid(), v_res_id, 4, 91.0, 'DNC', false, '91 DNC', now()),
    (gen_random_uuid(), v_res_id, 5, 91.0, 'DNC', false, '91 DNC', now()),
    (gen_random_uuid(), v_res_id, 6, 91.0, 'DNC', false, '91 DNC', now());

  -- ==========================================================================
  -- OPTIMIST SILVER FLEET (68 competitors)
  -- ==========================================================================

  -- [Silver] Rank 1: Shen Jie Teo (3870)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Shen Jie Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Shen Jie Teo', 'shen-jie-teo-cf1c78', '3870', 'SAF Yacht Club', 'Raffles Institution', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3870' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'Raffles Institution'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 1, 24.0, 9.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 2, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 3, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 4, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 5, 15.0, NULL, true, '(15)', now());

  -- [Silver] Rank 2: Cyra Cama (29)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cyra Cama')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cyra Cama', 'cyra-cama-185a43', '29', 'ONE 15 Marina', 'International French School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '29' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'ONE 15 Marina'),
      school = COALESCE(school, 'International French School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 2, 30.0, 16.0, false, 'F', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 2, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 3, 14.0, NULL, true, '(14)', now()),
    (gen_random_uuid(), v_res_id, 4, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 5, 1.0, NULL, false, '1', now());

  -- [Silver] Rank 3: Yasin Yusuf Yusfianshah (3575)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 3, 31.0, 19.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 2, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 3, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 4, 12.0, NULL, true, '(12)', now()),
    (gen_random_uuid(), v_res_id, 5, 3.0, NULL, false, '3', now());

  -- [Silver] Rank 4: Clara Siew Ning Ng (3739)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 4, 35.0, 21.0, false, 'F', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 2, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 3, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 4, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 5, 14.0, NULL, true, '(14)', now());

  -- [Silver] Rank 5: Hayden Zi Xuan Soh (3838)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 5, 48.0, 24.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 2, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 3, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 4, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 5, 24.0, NULL, true, '(24)', now());

  -- [Silver] Rank 6: Ivor Zhuo Xi Lee (3306)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 6, 57.0, 28.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 2, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 3, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 4, 29.0, NULL, true, '(29)', now()),
    (gen_random_uuid(), v_res_id, 5, 2.0, NULL, false, '2', now());

  -- [Silver] Rank 7: Arun John Behl (4494)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Arun John Behl')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Arun John Behl', 'arun-john-behl-c655ce', '4494', 'Changi Sailing Club', 'Bukit Merah Secondary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4494' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'Bukit Merah Secondary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 7, 60.0, 34.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 2, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 3, 26.0, NULL, true, '(26)', now()),
    (gen_random_uuid(), v_res_id, 4, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 5, 23.0, NULL, false, '23', now());

  -- [Silver] Rank 8: Zachary Hoo (2051)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zachary Hoo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zachary Hoo', 'zachary-hoo-2b1747', '2051', 'Constant Wind', 'RED SWASTIKA SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2051' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
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
    v_res_id, v_silver_id, v_sailor_id, 8, 56.0, 39.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 2, 17.0, NULL, true, '(17)', now()),
    (gen_random_uuid(), v_res_id, 3, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 4, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 5, 9.0, NULL, false, '9', now());

  -- [Silver] Rank 9: Chloe Ariane Pitsilis (708)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 9, 79.0, 45.0, false, 'F', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 2, 34.0, NULL, true, '(34)', now()),
    (gen_random_uuid(), v_res_id, 3, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 4, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 5, 12.0, NULL, false, '12', now());

  -- [Silver] Rank 10: Kiyansh Kanishk Singh (2046)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kiyansh Kanishk Singh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kiyansh Kanishk Singh', 'kiyansh-kanishk-singh-8b2494', '2046', 'Constant Wind', 'ANGLO- CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2046' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'ANGLO- CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 10, 75.0, 45.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 2, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 3, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 4, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 5, 30.0, NULL, true, '(30)', now());

  -- [Silver] Rank 11: Yan Cheng Loh (3717)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 11, 76.0, 45.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 2, 31.0, NULL, true, '(31)', now()),
    (gen_random_uuid(), v_res_id, 3, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 4, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 5, 8.0, NULL, false, '8', now());

  -- [Silver] Rank 12: Su Yuan (3043)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 12, 77.0, 54.0, false, 'F', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 23.0, NULL, true, '(23)', now()),
    (gen_random_uuid(), v_res_id, 2, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 3, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 4, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 5, 13.0, NULL, false, '13', now());

  -- [Silver] Rank 13: Skyler Kang (2041)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Skyler Kang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Skyler Kang', 'skyler-kang-524b74', '2041', 'Constant Wind', 'ANGLO- CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2041' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'ANGLO- CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 13, 79.0, 55.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 24.0, NULL, true, '(24)', now()),
    (gen_random_uuid(), v_res_id, 2, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 3, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 4, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 5, 6.0, NULL, false, '6', now());

  -- [Silver] Rank 14: Moyan Han (2042)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Moyan Han')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Moyan Han', 'moyan-han-fb4f57', '2042', 'Constant Wind', 'HUAMIN PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2042' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'HUAMIN PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 14, 87.0, 55.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 2, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 3, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 4, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 5, 32.0, NULL, true, '(32)', now());

  -- [Silver] Rank 15: Cyrus Gustafson (3342)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cyrus Gustafson')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cyrus Gustafson', 'cyrus-gustafson-22a75c', '3342', 'SAF Yacht Club', 'SINGAPORE AMERICAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3342' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'SINGAPORE AMERICAN SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 15, 96.0, 57.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 39.0, NULL, true, '(39)', now()),
    (gen_random_uuid(), v_res_id, 2, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 3, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 4, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 5, 5.0, NULL, false, '5', now());

  -- [Silver] Rank 16: Kai Jie Teo (3550)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 16, 83.0, 57.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 2, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 3, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 4, 26.0, NULL, true, '(26)', now()),
    (gen_random_uuid(), v_res_id, 5, 25.0, NULL, false, '25', now());

  -- [Silver] Rank 17: Ryan Feiran Zheng (2045)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 17, 126.0, 57.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 69.0, 'RET', true, '(69 RET)', now()),
    (gen_random_uuid(), v_res_id, 2, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 3, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 4, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 5, 18.0, NULL, false, '18', now());

  -- [Silver] Rank 18: Isaac Tan (2055)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isaac Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isaac Tan', 'isaac-tan-a6cefe', '2055', 'Constant Wind', 'Anglican High School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2055' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'Anglican High School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 18, 95.0, 58.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 2, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 3, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 4, 37.0, NULL, true, '(37)', now()),
    (gen_random_uuid(), v_res_id, 5, 16.0, NULL, false, '16', now());

  -- [Silver] Rank 19: Iver Zhe Xi Lee (3309)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 19, 94.0, 59.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 2, 35.0, NULL, true, '(35)', now()),
    (gen_random_uuid(), v_res_id, 3, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 4, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 5, 10.0, NULL, false, '10', now());

  -- [Silver] Rank 20: Jade Tan (3555)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 20, 82.0, 60.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 22.0, NULL, true, '(22)', now()),
    (gen_random_uuid(), v_res_id, 2, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 3, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 4, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 5, 19.0, NULL, false, '19', now());

  -- [Silver] Rank 21: Damien Seah (3825)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 21, 89.0, 60.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 2, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 3, 29.0, NULL, true, '(29)', now()),
    (gen_random_uuid(), v_res_id, 4, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 5, 7.0, NULL, false, '7', now());

  -- [Silver] Rank 22: Asher Goh (722)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Asher Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Asher Goh', 'asher-goh-3c5037', '722', 'Changi Sailing Club', 'ANGLO- CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '722' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'ANGLO- CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 22, 103.0, 63.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 2, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 3, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 4, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 5, 40.0, NULL, true, '(40)', now());

  -- [Silver] Rank 23: Yong Le Wai (3488)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yong Le Wai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yong Le Wai', 'yong-le-wai-20c5a4', '3488', 'SAF Yacht Club', 'FIRST TOA PAYOH PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3488' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
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
    v_res_id, v_silver_id, v_sailor_id, 23, 101.0, 71.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 2, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 3, 30.0, NULL, true, '(30)', now()),
    (gen_random_uuid(), v_res_id, 4, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 5, 4.0, NULL, false, '4', now());

  -- [Silver] Rank 24: Seraphina Kang (2040)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 24, 113.0, 76.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 2, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 3, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 4, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 5, 37.0, NULL, true, '(37)', now());

  -- [Silver] Rank 25: Evan En Kai Ong (3955)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 25, 138.0, 81.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 2, 52.0, NULL, false, '52', now()),
    (gen_random_uuid(), v_res_id, 3, 57.0, 'TLE', true, '(57 TLE)', now()),
    (gen_random_uuid(), v_res_id, 4, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 5, 11.0, NULL, false, '11', now());

  -- [Silver] Rank 26: Ezra Yi Yang Mak (3535)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 26, 139.0, 98.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 2, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 3, 41.0, NULL, true, '(41)', now()),
    (gen_random_uuid(), v_res_id, 4, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 5, 22.0, NULL, false, '22', now());

  -- [Silver] Rank 27: Yahe Wang (3020)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 27, 151.0, 103.0, false, 'F', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 2, 48.0, NULL, true, '(48)', now()),
    (gen_random_uuid(), v_res_id, 3, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 4, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 5, 36.0, NULL, false, '36', now());

  -- [Silver] Rank 28: Yuki Youqi Wang (3523)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 28, 144.0, 103.0, false, 'F', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 2, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 3, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 4, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 5, 41.0, NULL, true, '(41)', now());

  -- [Silver] Rank 29: Henry Shayan Mittelhauser (2052)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Henry Shayan Mittelhauser')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Henry Shayan Mittelhauser', 'henry-shayan-mittelhauser-9de34e', '2052', 'Constant Wind', 'TANJONG KATONG PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2052' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
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
    v_res_id, v_silver_id, v_sailor_id, 29, 174.0, 105.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 69.0, 'UFD', true, '(69 UFD)', now()),
    (gen_random_uuid(), v_res_id, 2, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 3, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 4, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 5, 21.0, NULL, false, '21', now());

  -- [Silver] Rank 30: Scott Goh (729)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 30, 144.0, 106.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 2, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 3, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 4, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 5, 38.0, NULL, true, '(38)', now());

  -- [Silver] Rank 31: Ziyi Adele Chiang (3120)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ziyi Adele Chiang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ziyi Adele Chiang', 'ziyi-adele-chiang-658b57', '3120', 'SAF Yacht Club', 'TAO NAN SCHOOL', 'F', 'SGP', now(), now()
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 31, 160.0, 110.0, false, 'F', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 2, 50.0, NULL, true, '(50)', now()),
    (gen_random_uuid(), v_res_id, 3, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 4, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 5, 49.0, NULL, false, '49', now());

  -- [Silver] Rank 32: An Hu (2050)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 32, 158.0, 115.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 2, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 3, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 4, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 5, 43.0, NULL, true, '(43)', now());

  -- [Silver] Rank 33: Ilysha Wong (2053)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ilysha Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ilysha Wong', 'ilysha-wong-d6f3af', '2053', 'Constant Wind', 'ANGLO- CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2053' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'ANGLO- CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 33, 164.0, 116.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 2, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 3, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 4, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 5, 48.0, NULL, true, '(48)', now());

  -- [Silver] Rank 34: Althea Chin (7188)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Althea Chin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Althea Chin', 'althea-chin-d52227', '7188', 'Changi Sailing Club', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '7188' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
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
    v_res_id, v_silver_id, v_sailor_id, 34, 161.0, 117.0, false, 'F', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 2, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 3, 44.0, NULL, true, '(44)', now()),
    (gen_random_uuid(), v_res_id, 4, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 5, 26.0, NULL, false, '26', now());

  -- [Silver] Rank 35: Jiaqian Wu (3424)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 35, 172.0, 125.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 2, 47.0, NULL, true, '(47)', now()),
    (gen_random_uuid(), v_res_id, 3, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 4, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 5, 17.0, NULL, false, '17', now());

  -- [Silver] Rank 36: Jiayi Du (3141)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 36, 172.0, 130.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 2, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 3, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 4, 42.0, NULL, true, '(42)', now()),
    (gen_random_uuid(), v_res_id, 5, 39.0, NULL, false, '39', now());

  -- [Silver] Rank 37: Mitchell Shi Kai Lim (3323)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mitchell Shi Kai Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mitchell Shi Kai Lim', 'mitchell-shi-kai-lim-e0ca0f', '3323', 'SAF Yacht Club', 'ANGLO- CHINESE SCHOOL (PRIMARY)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3323' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO- CHINESE SCHOOL (PRIMARY)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 37, 175.0, 131.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 2, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 3, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 4, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 5, 44.0, NULL, true, '(44)', now());

  -- [Silver] Rank 38: Yu an Li (2056)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yu an Li')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yu an Li', 'yu-an-li-617cfe', '2056', 'Constant Wind', 'TAO NAN SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2056' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
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
    v_res_id, v_silver_id, v_sailor_id, 38, 190.0, 133.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 2, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 3, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 4, 57.0, NULL, true, '(57)', now()),
    (gen_random_uuid(), v_res_id, 5, 28.0, NULL, false, '28', now());

  -- [Silver] Rank 39: Oliver Rui Heng Cheong (3515)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Oliver Rui Heng Cheong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Oliver Rui Heng Cheong', 'oliver-rui-heng-cheong-53b1bd', '3515', 'Republic of Singapore Yacht Club', 'ST. STEPHEN''S SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3515' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Republic of Singapore Yacht Club'),
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
    v_res_id, v_silver_id, v_sailor_id, 39, 181.0, 141.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 40.0, NULL, true, '(40)', now()),
    (gen_random_uuid(), v_res_id, 2, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 3, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 4, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 5, 31.0, NULL, false, '31', now());

  -- [Silver] Rank 40: Nurul 'Afiya Binte Mohamed Shahrom (704)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nurul ''Afiya Binte Mohamed Shahrom')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nurul ''Afiya Binte Mohamed Shahrom', 'nurul-afiya-binte-mohamed-shahrom-b855f0', '704', 'Changi Sailing Club', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '704' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
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
    v_res_id, v_silver_id, v_sailor_id, 40, 209.0, 151.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 2, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 3, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 4, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 5, 58.0, 'TLE', true, '(58 TLE)', now());

  -- [Silver] Rank 41: Emil Lam (2049)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 41, 220.0, 151.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 2, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 3, 69.0, 'UFD', true, '(69 UFD)', now()),
    (gen_random_uuid(), v_res_id, 4, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 5, 34.0, NULL, false, '34', now());

  -- [Silver] Rank 42: Sumire Sayawaki- Kogut (710)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sumire Sayawaki- Kogut')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sumire Sayawaki- Kogut', 'sumire-sayawaki-kogut-e15155', '710', 'Changi Sailing Club', 'UNITED WORLD COLLEGE (SEA)', 'F', 'SGP', now(), now()
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 42, 212.0, 157.0, false, 'F', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 2, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 3, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 4, 55.0, NULL, true, '(55)', now()),
    (gen_random_uuid(), v_res_id, 5, 33.0, NULL, false, '33', now());

  -- [Silver] Rank 43: Nadia Zahedi (4724)
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
    v_res_id, v_silver_id, v_sailor_id, 43, 219.0, 163.0, false, 'F', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 2, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 3, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 4, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 5, 56.0, NULL, true, '(56)', now());

  -- [Silver] Rank 44: Bryan Thian Tsek Lee (3508)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Bryan Thian Tsek Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Bryan Thian Tsek Lee', 'bryan-thian-tsek-lee-ef534b', '3508', 'SAF Yacht Club', 'ANGLO- CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3508' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO- CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 44, 225.0, 166.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 57.0, 'TLE', false, '57 TLE', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'TLE', true, '(59 TLE)', now()),
    (gen_random_uuid(), v_res_id, 3, 58.0, 'SCP', false, '58 SCP', now()),
    (gen_random_uuid(), v_res_id, 4, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 5, 20.0, NULL, false, '20', now());

  -- [Silver] Rank 45: Sven Xin Chen Lim (4424)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sven Xin Chen Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sven Xin Chen Lim', 'sven-xin-chen-lim-9671b5', '4424', 'SAF Yacht Club', 'TAO NAN SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4424' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
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
    v_res_id, v_silver_id, v_sailor_id, 45, 220.0, 166.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 54.0, NULL, true, '(54)', now()),
    (gen_random_uuid(), v_res_id, 2, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 3, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 4, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 5, 54.0, NULL, false, '54', now());

  -- [Silver] Rank 46: Muhammad Rehan Bin Mohamed Salim (2059)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 46, 223.0, 173.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 2, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 3, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 4, 50.0, NULL, true, '(50)', now()),
    (gen_random_uuid(), v_res_id, 5, 42.0, NULL, false, '42', now());

  -- [Silver] Rank 47: Jerome Puah Yang Yi (2037)
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
    v_res_id, v_silver_id, v_sailor_id, 47, 244.0, 175.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 2, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 3, 69.0, 'RET', true, '(69 RET)', now()),
    (gen_random_uuid(), v_res_id, 4, 53.0, NULL, false, '53', now()),
    (gen_random_uuid(), v_res_id, 5, 46.0, NULL, false, '46', now());

  -- [Silver] Rank 48: Dylan Yao Rui Teo (3107)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 48, 235.0, 178.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 57.0, 'TLE', true, '(57 TLE)', now()),
    (gen_random_uuid(), v_res_id, 2, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 3, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 4, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 5, 52.0, NULL, false, '52', now());

  -- [Silver] Rank 49: Amelie Camille Pitsilis (702)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 49, 229.0, 179.0, false, 'F', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 2, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 3, 43.0, 'SCP', false, '43 SCP', now()),
    (gen_random_uuid(), v_res_id, 4, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 5, 50.0, NULL, true, '(50)', now());

  -- [Silver] Rank 50: Jae Guan Yu Toh (3311)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 50, 239.0, 183.0, false, 'M', 2018, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 2, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 3, 52.0, NULL, false, '52', now()),
    (gen_random_uuid(), v_res_id, 4, 56.0, NULL, true, '(56)', now()),
    (gen_random_uuid(), v_res_id, 5, 51.0, NULL, false, '51', now());

  -- [Silver] Rank 51: Llewellyn Ding Zhe Tay (3013)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 51, 244.0, 187.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 57.0, 'TLE', true, '(57 TLE)', now()),
    (gen_random_uuid(), v_res_id, 2, 57.0, NULL, false, '57', now()),
    (gen_random_uuid(), v_res_id, 3, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 4, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 5, 35.0, NULL, false, '35', now());

  -- [Silver] Rank 52: Hillary Kai Hui Tan (777)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 52, 253.0, 192.0, false, 'F', 2018, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 2, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 3, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 4, 61.0, NULL, true, '(61)', now()),
    (gen_random_uuid(), v_res_id, 5, 58.0, 'TLE', false, '58 TLE', now());

  -- [Silver] Rank 53: Jacob Jit Yeung Kok (3087)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jacob Jit Yeung Kok')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jacob Jit Yeung Kok', 'jacob-jit-yeung-kok-d369ed', '3087', 'SAF Yacht Club', 'ANGLO- CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3087' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO- CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 53, 263.0, 194.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 2, 69.0, 'DNS', true, '(69 DNS)', now()),
    (gen_random_uuid(), v_res_id, 3, 57.0, 'TLE', false, '57 TLE', now()),
    (gen_random_uuid(), v_res_id, 4, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 5, 53.0, NULL, false, '53', now());

  -- [Silver] Rank 54: Andrea Kwan (3745)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Andrea Kwan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Andrea Kwan', 'andrea-kwan-e40c2d', '3745', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3745' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
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
    v_res_id, v_silver_id, v_sailor_id, 54, 253.0, 198.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 2, 55.0, NULL, true, '(55)', now()),
    (gen_random_uuid(), v_res_id, 3, 53.0, NULL, false, '53', now()),
    (gen_random_uuid(), v_res_id, 4, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 5, 45.0, NULL, false, '45', now());

  -- [Silver] Rank 55: You Yu Tan (3137)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('You Yu Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'You Yu Tan', 'you-yu-tan-c23c5e', '3137', 'PAssion Wave', 'MERIDIAN PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3137' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'MERIDIAN PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 55, 258.0, 199.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 51.0, NULL, false, '51', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'TLE', true, '(59 TLE)', now()),
    (gen_random_uuid(), v_res_id, 3, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 4, 59.0, NULL, false, '59', now()),
    (gen_random_uuid(), v_res_id, 5, 47.0, NULL, false, '47', now());

  -- [Silver] Rank 56: Jan Welzl (2033)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 56, 270.0, 201.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 69.0, 'DNC', true, '(69 DNC)', now()),
    (gen_random_uuid(), v_res_id, 2, 69.0, 'DNC', false, '69 DNC', now()),
    (gen_random_uuid(), v_res_id, 3, 69.0, 'DNC', false, '69 DNC', now()),
    (gen_random_uuid(), v_res_id, 4, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 5, 27.0, NULL, false, '27', now());

  -- [Silver] Rank 57: Hongren Wang (2039)
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
    v_res_id, v_silver_id, v_sailor_id, 57, 261.0, 203.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 2, 51.0, NULL, false, '51', now()),
    (gen_random_uuid(), v_res_id, 3, 57.0, 'TLE', false, '57 TLE', now()),
    (gen_random_uuid(), v_res_id, 4, 51.0, NULL, false, '51', now()),
    (gen_random_uuid(), v_res_id, 5, 58.0, 'TLE', true, '(58 TLE)', now());

  -- [Silver] Rank 58: Cadee Jia Xing See (3628)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cadee Jia Xing See')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cadee Jia Xing See', 'cadee-jia-xing-see-00fae1', '3628', 'SAF Yacht Club', 'ST. HILDA''S PRIMARY SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3628' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
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
    v_res_id, v_silver_id, v_sailor_id, 58, 267.0, 204.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 52.0, NULL, false, '52', now()),
    (gen_random_uuid(), v_res_id, 2, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 3, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 4, 63.0, NULL, true, '(63)', now()),
    (gen_random_uuid(), v_res_id, 5, 58.0, 'TLE', false, '58 TLE', now());

  -- [Silver] Rank 59: Isaias Cheow (3307)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isaias Cheow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isaias Cheow', 'isaias-cheow-67a387', '3307', 'SAF Yacht Club', 'ANGLO- CHINESE SCHOOL (PRIMARY)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3307' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO- CHINESE SCHOOL (PRIMARY)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 59, 269.0, 211.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 53.0, NULL, false, '53', now()),
    (gen_random_uuid(), v_res_id, 2, 56.0, NULL, false, '56', now()),
    (gen_random_uuid(), v_res_id, 3, 57.0, 'TLE', false, '57 TLE', now()),
    (gen_random_uuid(), v_res_id, 4, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 5, 58.0, 'TLE', true, '(58 TLE)', now());

  -- [Silver] Rank 60: Christopher Tan (2057)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Christopher Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Christopher Tan', 'christopher-tan-3869de', '2057', 'SAF Yacht Club', 'ANGLO- CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2057' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO- CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 60, 280.0, 218.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 55.0, NULL, false, '55', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'TLE', false, '59 TLE', now()),
    (gen_random_uuid(), v_res_id, 3, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 4, 62.0, NULL, true, '(62)', now()),
    (gen_random_uuid(), v_res_id, 5, 55.0, NULL, false, '55', now());

  -- [Silver] Rank 61: Enzo Kengsin Teo (2044)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 61, 288.0, 219.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 69.0, 'DNC', true, '(69 DNC)', now()),
    (gen_random_uuid(), v_res_id, 2, 69.0, 'DNC', false, '69 DNC', now()),
    (gen_random_uuid(), v_res_id, 3, 69.0, 'DNC', false, '69 DNC', now()),
    (gen_random_uuid(), v_res_id, 4, 52.0, NULL, false, '52', now()),
    (gen_random_uuid(), v_res_id, 5, 29.0, NULL, false, '29', now());

  -- [Silver] Rank 62: Thaddaeus Renz (2058)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Thaddaeus Renz')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Thaddaeus Renz', 'thaddaeus-renz-6abed1', '2058', 'Constant Wind', 'ANGLO- CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2058' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'ANGLO- CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 62, 284.0, 221.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 2, 53.0, NULL, false, '53', now()),
    (gen_random_uuid(), v_res_id, 3, 63.0, 'SCP', true, '(63 SCP)', now()),
    (gen_random_uuid(), v_res_id, 4, 60.0, NULL, false, '60', now()),
    (gen_random_uuid(), v_res_id, 5, 58.0, 'TLE', false, '58 TLE', now());

  -- [Silver] Rank 63: Yixia Sun (2061)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 63, 290.0, 224.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 57.0, 'TLE', false, '57 TLE', now()),
    (gen_random_uuid(), v_res_id, 2, 54.0, NULL, false, '54', now()),
    (gen_random_uuid(), v_res_id, 3, 55.0, NULL, false, '55', now()),
    (gen_random_uuid(), v_res_id, 4, 66.0, 'TLE', true, '(66 TLE)', now()),
    (gen_random_uuid(), v_res_id, 5, 58.0, 'TLE', false, '58 TLE', now());

  -- [Silver] Rank 64: Ian Siak Yiak Goh (3818)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ian Siak Yiak Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ian Siak Yiak Goh', 'ian-siak-yiak-goh-d63fdf', '3818', 'SAF Yacht Club', 'ANGLO- CHINESE SCHOOL (JUNIOR)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3818' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO- CHINESE SCHOOL (JUNIOR)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 64, 295.0, 231.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 57.0, 'TLE', false, '57 TLE', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'TLE', false, '59 TLE', now()),
    (gen_random_uuid(), v_res_id, 3, 57.0, 'TLE', false, '57 TLE', now()),
    (gen_random_uuid(), v_res_id, 4, 64.0, NULL, true, '(64)', now()),
    (gen_random_uuid(), v_res_id, 5, 58.0, 'TLE', false, '58 TLE', now());

  -- [Silver] Rank 65: Mikayla Zi Yue Wong (74)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mikayla Zi Yue Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mikayla Zi Yue Wong', 'mikayla-zi-yue-wong-64563b', '74', 'Changi Sailing Club', 'CHIJ (KATONG) PRIMARY', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '74' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
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
    v_res_id, v_silver_id, v_sailor_id, 65, 293.0, 232.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 57.0, 'TLE', false, '57 TLE', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'TLE', false, '59 TLE', now()),
    (gen_random_uuid(), v_res_id, 3, 61.0, 'SCP', true, '(61 SCP)', now()),
    (gen_random_uuid(), v_res_id, 4, 58.0, NULL, false, '58', now()),
    (gen_random_uuid(), v_res_id, 5, 58.0, 'TLE', false, '58 TLE', now());

  -- [Silver] Rank 66: Ryan Jonathan Zhi Jie Soh (3110)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ryan Jonathan Zhi Jie Soh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ryan Jonathan Zhi Jie Soh', 'ryan-jonathan-zhi-jie-soh-5579e8', '3110', 'SAF Yacht Club', 'Anglo-Chinese School (Junior)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3110' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'Anglo-Chinese School (Junior)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 66, 314.0, 245.0, false, 'M', 2018, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 57.0, 'TLE', false, '57 TLE', now()),
    (gen_random_uuid(), v_res_id, 2, 59.0, 'TLE', false, '59 TLE', now()),
    (gen_random_uuid(), v_res_id, 3, 63.0, 'SCP', false, '63 SCP', now()),
    (gen_random_uuid(), v_res_id, 4, 66.0, 'TLE', false, '66 TLE', now()),
    (gen_random_uuid(), v_res_id, 5, 69.0, 'DNS', true, '(69 DNS)', now());

  -- [Silver] Rank 67: Efrem Mak (3222)
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
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 67, 319.0, 250.0, false, 'M', 2018, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 57.0, 'TLE', false, '57 TLE', now()),
    (gen_random_uuid(), v_res_id, 2, 69.0, 'RET', true, '(69 RET)', now()),
    (gen_random_uuid(), v_res_id, 3, 69.0, 'RET', false, '69 RET', now()),
    (gen_random_uuid(), v_res_id, 4, 66.0, 'TLE', false, '66 TLE', now()),
    (gen_random_uuid(), v_res_id, 5, 58.0, 'TLE', false, '58 TLE', now());

  -- [Silver] Rank 68: Raphael Garbourg (780)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Raphael Garbourg')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Raphael Garbourg', 'raphael-garbourg-ddb1c9', '780', 'Changi Sailing Club', 'OPERA ESTATE PRIMARY SCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '780' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'OPERA ESTATE PRIMARY SCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_silver_id, v_sailor_id, 68, 345.0, 276.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 69.0, 'DNC', true, '(69 DNC)', now()),
    (gen_random_uuid(), v_res_id, 2, 69.0, 'DNC', false, '69 DNC', now()),
    (gen_random_uuid(), v_res_id, 3, 69.0, 'DNC', false, '69 DNC', now()),
    (gen_random_uuid(), v_res_id, 4, 69.0, 'DNC', false, '69 DNC', now()),
    (gen_random_uuid(), v_res_id, 5, 69.0, 'DNC', false, '69 DNC', now());

  -- ==========================================================================
  -- ILCA 4 CLASS (54 competitors)
  -- ==========================================================================

  -- [ILCA 4] Rank 1: Ethan Han Wei Chia (228368)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ethan Han Wei Chia')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ethan Han Wei Chia', 'ethan-han-wei-chia-9af3a5', '228368', 'SAF Yacht Club', 'RAFFLESINSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '228368' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'RAFFLESINSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 1, 30.0, 15.0, false, 'M', 2010, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 2, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 3, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 4, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 5, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 6, 15.0, NULL, true, '(15)', now());

  -- [ILCA 4] Rank 2: Ian Goh (222713)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ian Goh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ian Goh', 'ian-goh-f7d194', '222713', 'Constant Wind', 'RAFFLESINSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '222713' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'RAFFLESINSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 2, 25.0, 17.0, false, 'M', 2009, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 2, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 3, 8.0, NULL, true, '(8)', now()),
    (gen_random_uuid(), v_res_id, 4, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 5, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 6, 8.0, NULL, false, '8', now());

  -- [ILCA 4] Rank 3: Zeph Wan (226650)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zeph Wan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zeph Wan', 'zeph-wan-0ee170', '226650', 'SAF Yacht Club', 'ANGLO-CHINESESCHOOL(INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '226650' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO-CHINESESCHOOL(INDEPENDENT)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 3, 26.0, 18.0, false, 'M', 2010, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 2, 8.0, NULL, true, '(8)', now()),
    (gen_random_uuid(), v_res_id, 3, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 4, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 5, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 6, 1.0, NULL, false, '1', now());

  -- [ILCA 4] Rank 4: Nia Zahedi (224245)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nia Zahedi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nia Zahedi', 'nia-zahedi-fbcbd1', '224245', 'PAssion Wave', 'RAFFLESINSTITUTION', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '224245' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'RAFFLESINSTITUTION'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 4, 28.0, 19.0, false, 'F', 2009, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 2, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 3, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 4, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 5, 9.0, NULL, true, '(9)', now()),
    (gen_random_uuid(), v_res_id, 6, 2.0, NULL, false, '2', now());

  -- [ILCA 4] Rank 5: Nicholette Wee Wen Lee (224620)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nicholette Wee Wen Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nicholette Wee Wen Lee', 'nicholette-wee-wen-lee-e9d2da', '224620', 'Royal Varuna Yacht Club', 'TANJONGKATONG GIRLS''SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '224620' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Royal Varuna Yacht Club'),
      school = COALESCE(school, 'TANJONGKATONG GIRLS''SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 5, 39.0, 28.0, false, 'F', 2009, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 2, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 3, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 4, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 5, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 6, 11.0, NULL, true, '(11)', now());

  -- [ILCA 4] Rank 6: Mika Tew (227461)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mika Tew')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mika Tew', 'mika-tew-3f7a05', '227461', 'PAssion Wave', 'RAFFLES GIRLS''SCHOOL(SECONDARY)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '227461' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'RAFFLES GIRLS''SCHOOL(SECONDARY)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 6, 46.0, 30.0, false, 'F', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 2, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 3, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 4, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 5, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 6, 16.0, NULL, true, '(16)', now());

  -- [ILCA 4] Rank 7: Zachary Weikai Wong (221061)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zachary Weikai Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zachary Weikai Wong', 'zachary-weikai-wong-c499d9', '221061', 'Royal Varuna Yacht Club', 'ANGLO-CHINESESCHOOL(INTERNATIONAL)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '221061' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Royal Varuna Yacht Club'),
      school = COALESCE(school, 'ANGLO-CHINESESCHOOL(INTERNATIONAL)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 7, 48.0, 34.0, false, 'M', 2010, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 2, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 3, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 4, 8.0, NULL, false, '8', now()),
    (gen_random_uuid(), v_res_id, 5, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 6, 14.0, NULL, true, '(14)', now());

  -- [ILCA 4] Rank 8: Jemima Chang (214636)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jemima Chang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jemima Chang', 'jemima-chang-948b53', '214636', 'PAssion Wave', 'DUNMAN HIGHSCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '214636' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'DUNMAN HIGHSCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 8, 59.0, 41.0, false, 'F', 2010, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 2, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 3, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 4, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 5, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 6, 18.0, NULL, true, '(18)', now());

  -- [ILCA 4] Rank 9: Desiree Yuet Chi Lee (226897)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Desiree Yuet Chi Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Desiree Yuet Chi Lee', 'desiree-yuet-chi-lee-760667', '226897', 'Royal Varuna Yacht Club', 'TANJONGKATONG GIRLS''SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '226897' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Royal Varuna Yacht Club'),
      school = COALESCE(school, 'TANJONGKATONG GIRLS''SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 9, 55.0, 42.0, false, 'F', 2010, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 2, 13.0, NULL, true, '(13)', now()),
    (gen_random_uuid(), v_res_id, 3, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 4, 7.0, NULL, false, '7', now()),
    (gen_random_uuid(), v_res_id, 5, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 6, 6.0, NULL, false, '6', now());

  -- [ILCA 4] Rank 10: Gabi Oh (222743)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gabi Oh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gabi Oh', 'gabi-oh-342590', '222743', 'SAF Yacht Club', 'RAFFLESINSTITUTION', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '222743' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'RAFFLESINSTITUTION'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 10, 73.0, 47.0, false, 'F', 2009, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 2, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 3, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 4, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 5, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 6, 26.0, NULL, true, '(26)', now());

  -- [ILCA 4] Rank 11: Ashlea Tham (3)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ashlea Tham')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ashlea Tham', 'ashlea-tham-f2a2cc', '3', 'PAssion Wave', 'TANJONGKATONG GIRLS''SCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '3' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'TANJONGKATONG GIRLS''SCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 11, 82.0, 57.0, false, 'F', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 2, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 3, 25.0, NULL, true, '(25)', now()),
    (gen_random_uuid(), v_res_id, 4, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 5, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 6, 3.0, NULL, false, '3', now());

  -- [ILCA 4] Rank 12: Caleb Peck (225221)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Caleb Peck')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Caleb Peck', 'caleb-peck-b1e2c4', '225221', 'PAssion Wave', 'RAFFLESINSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '225221' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'RAFFLESINSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 12, 82.0, 65.0, false, 'M', 2010, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 2, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 3, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 4, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 5, 17.0, NULL, true, '(17)', now()),
    (gen_random_uuid(), v_res_id, 6, 12.0, NULL, false, '12', now());

  -- [ILCA 4] Rank 13: Mildred Li Xuan Wong (223200)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mildred Li Xuan Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mildred Li Xuan Wong', 'mildred-li-xuan-wong-6b37f5', '223200', 'Constant Wind', 'RAFFLES GIRLS''SCHOOL(SECONDARY)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '223200' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'RAFFLES GIRLS''SCHOOL(SECONDARY)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 13, 103.0, 66.0, false, 'F', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 37.0, NULL, true, '(37)', now()),
    (gen_random_uuid(), v_res_id, 2, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 3, 9.0, NULL, false, '9', now()),
    (gen_random_uuid(), v_res_id, 4, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 5, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 6, 20.0, NULL, false, '20', now());

  -- [ILCA 4] Rank 14: Yuk Jun Lim (225182)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yuk Jun Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yuk Jun Lim', 'yuk-jun-lim-9256a5', '225182', 'SAF Yacht Club', 'ST. JOSEPH''SINSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '225182' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. JOSEPH''SINSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 14, 90.0, 67.0, false, 'M', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 23.0, NULL, true, '(23)', now()),
    (gen_random_uuid(), v_res_id, 2, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 3, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 4, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 5, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 6, 4.0, NULL, false, '4', now());

  -- [ILCA 4] Rank 15: Heng Yi Yong (225259)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Heng Yi Yong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Heng Yi Yong', 'heng-yi-yong-bb6725', '225259', 'Changi Sailing Club', 'LOYANG VIEWSECONDARYSCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '225259' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'LOYANG VIEWSECONDARYSCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 15, 96.0, 73.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 10.0, NULL, false, '10', now()),
    (gen_random_uuid(), v_res_id, 2, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 3, 23.0, NULL, true, '(23)', now()),
    (gen_random_uuid(), v_res_id, 4, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 5, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 6, 21.0, NULL, false, '21', now());

  -- [ILCA 4] Rank 16: Amandine Zoe Pitsilis (219725)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Amandine Zoe Pitsilis')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Amandine Zoe Pitsilis', 'amandine-zoe-pitsilis-aea915', '219725', 'Changi Sailing Club', 'INTERNATIONALFRENCHSCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '219725' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'INTERNATIONALFRENCHSCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 16, 113.0, 76.0, false, 'F', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 2, 6.0, NULL, false, '6', now()),
    (gen_random_uuid(), v_res_id, 3, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 4, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 5, 37.0, NULL, true, '(37)', now()),
    (gen_random_uuid(), v_res_id, 6, 19.0, NULL, false, '19', now());

  -- [ILCA 4] Rank 17: Kai Lun Wong (227462)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kai Lun Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kai Lun Wong', 'kai-lun-wong-75993d', '227462', 'PAssion Wave', 'BOWENSECONDARYSCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '227462' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'BOWENSECONDARYSCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 17, 101.0, 76.0, false, 'M', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 2, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 3, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 4, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 5, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 6, 25.0, NULL, true, '(25)', now());

  -- [ILCA 4] Rank 18: James Kong (212216)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('James Kong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'James Kong', 'james-kong-d415e7', '212216', 'PAssion Wave', 'DUNMAN HIGHSCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '212216' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'DUNMAN HIGHSCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 18, 109.0, 82.0, false, 'M', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 2, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 3, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 4, 27.0, NULL, true, '(27)', now()),
    (gen_random_uuid(), v_res_id, 5, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 6, 13.0, NULL, false, '13', now());

  -- [ILCA 4] Rank 19: Joash Jing En Tan (209051)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joash Jing En Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joash Jing En Tan', 'joash-jing-en-tan-80d551', '209051', 'ONE 15 Marina', 'Victoria School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '209051' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'ONE 15 Marina'),
      school = COALESCE(school, 'Victoria School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 19, 126.0, 90.0, false, 'M', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 2, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 3, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 4, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 5, 36.0, NULL, true, '(36)', now()),
    (gen_random_uuid(), v_res_id, 6, 10.0, NULL, false, '10', now());

  -- [ILCA 4] Rank 20: Reyes Jit Eng Tan (214251)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Reyes Jit Eng Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Reyes Jit Eng Tan', 'reyes-jit-eng-tan-280de2', '214251', 'Changi Sailing Club', 'DUNMAN HIGHSCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '214251' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'DUNMAN HIGHSCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 20, 120.0, 90.0, false, 'M', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 2, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 3, 19.0, NULL, false, '19', now()),
    (gen_random_uuid(), v_res_id, 4, 12.0, NULL, false, '12', now()),
    (gen_random_uuid(), v_res_id, 5, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 6, 30.0, NULL, true, '(30)', now());

  -- [ILCA 4] Rank 21: Kye Tang (226900)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kye Tang')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kye Tang', 'kye-tang-3b97fc', '226900', 'Constant Wind', 'RAFFLESINSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '226900' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'RAFFLESINSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 21, 135.0, 94.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 41.0, NULL, true, '(41)', now()),
    (gen_random_uuid(), v_res_id, 2, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 3, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 4, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 5, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 6, 7.0, NULL, false, '7', now());

  -- [ILCA 4] Rank 22: Jayden Zi Xi Bai (225261)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jayden Zi Xi Bai')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jayden Zi Xi Bai', 'jayden-zi-xi-bai-129b41', '225261', 'PAssion Wave', 'ST. JOSEPH''SINSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '225261' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'ST. JOSEPH''SINSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 22, 121.0, 97.0, false, 'M', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 2, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 3, 13.0, NULL, false, '13', now()),
    (gen_random_uuid(), v_res_id, 4, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 5, 24.0, NULL, true, '(24)', now()),
    (gen_random_uuid(), v_res_id, 6, 22.0, NULL, false, '22', now());

  -- [ILCA 4] Rank 23: Julien Christian Petracco (221687)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Julien Christian Petracco')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Julien Christian Petracco', 'julien-christian-petracco-ef44e4', '221687', 'SAF Yacht Club', 'ST. JOSEPH''SINSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '221687' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. JOSEPH''SINSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 23, 129.0, 100.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 14.0, NULL, false, '14', now()),
    (gen_random_uuid(), v_res_id, 2, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 3, 17.0, NULL, false, '17', now()),
    (gen_random_uuid(), v_res_id, 4, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 5, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 6, 29.0, NULL, true, '(29)', now());

  -- [ILCA 4] Rank 24: Kayden Yi Kai Tan (197424)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kayden Yi Kai Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kayden Yi Kai Tan', 'kayden-yi-kai-tan-7781d7', '197424', 'SAF Yacht Club', 'ST. ANDREW''SSECONDARYSCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '197424' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. ANDREW''SSECONDARYSCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 24, 145.0, 102.0, false, 'M', 2010, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 22.0, NULL, false, '22', now()),
    (gen_random_uuid(), v_res_id, 2, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 3, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 4, 43.0, NULL, true, '(43)', now()),
    (gen_random_uuid(), v_res_id, 5, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 6, 5.0, NULL, false, '5', now());

  -- [ILCA 4] Rank 25: Isaiah Chor Hong Yap (227463)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isaiah Chor Hong Yap')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isaiah Chor Hong Yap', 'isaiah-chor-hong-yap-c4b980', '227463', 'Changi Sailing Club', 'XINMINSECONDARYSCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '227463' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'XINMINSECONDARYSCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 25, 146.0, 110.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 18.0, NULL, false, '18', now()),
    (gen_random_uuid(), v_res_id, 2, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 3, 36.0, NULL, true, '(36)', now()),
    (gen_random_uuid(), v_res_id, 4, 16.0, NULL, false, '16', now()),
    (gen_random_uuid(), v_res_id, 5, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 6, 9.0, NULL, false, '9', now());

  -- [ILCA 4] Rank 26: Josh Yong Jun Ong (217034)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Josh Yong Jun Ong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Josh Yong Jun Ong', 'josh-yong-jun-ong-2b6e95', '217034', 'SAF Yacht Club', 'VICTORIASCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '217034' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'VICTORIASCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 26, 150.0, 116.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 11.0, NULL, false, '11', now()),
    (gen_random_uuid(), v_res_id, 2, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 3, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 4, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 5, 34.0, NULL, true, '(34)', now()),
    (gen_random_uuid(), v_res_id, 6, 28.0, NULL, false, '28', now());

  -- [ILCA 4] Rank 27: Cory Zhi Hang Loh (226899)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cory Zhi Hang Loh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cory Zhi Hang Loh', 'cory-zhi-hang-loh-02c08b', '226899', 'SAF Yacht Club', 'ADMIRALTYPRIMARYSCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '226899' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ADMIRALTYPRIMARYSCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 27, 164.0, 131.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 2, 33.0, NULL, true, '(33)', now()),
    (gen_random_uuid(), v_res_id, 3, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 4, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 5, 23.0, NULL, false, '23', now()),
    (gen_random_uuid(), v_res_id, 6, 32.0, NULL, false, '32', now());

  -- [ILCA 4] Rank 28: Lauren Lim (216431)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lauren Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lauren Lim', 'lauren-lim-c5d326', '216431', 'SAF Yacht Club', 'WHITLEYSECONDARYSCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '216431' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'WHITLEYSECONDARYSCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 28, 180.0, 141.0, false, 'F', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 39.0, NULL, true, '(39)', now()),
    (gen_random_uuid(), v_res_id, 2, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 3, 20.0, NULL, false, '20', now()),
    (gen_random_uuid(), v_res_id, 4, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 5, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 6, 37.0, NULL, false, '37', now());

  -- [ILCA 4] Rank 29: Travis Jia Le Yeo (223728)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Travis Jia Le Yeo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Travis Jia Le Yeo', 'travis-jia-le-yeo-ad0c9e', '223728', 'SAF Yacht Club', 'RAFFLESINSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '223728' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'RAFFLESINSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 29, 178.0, 145.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 2, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 3, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 4, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 5, 28.0, NULL, false, '28', now()),
    (gen_random_uuid(), v_res_id, 6, 33.0, NULL, true, '(33)', now());

  -- [ILCA 4] Rank 30: Nicholas Jiang En Ng (209042)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Nicholas Jiang En Ng')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Nicholas Jiang En Ng', 'nicholas-jiang-en-ng-68400b', '209042', 'SAF Yacht Club', 'YISHUN TOWNSECONDARYSCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '209042' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'YISHUN TOWNSECONDARYSCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 30, 190.0, 148.0, false, 'M', 2010, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 2, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 3, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 4, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 5, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 6, 42.0, NULL, true, '(42)', now());

  -- [ILCA 4] Rank 31: Callum Joon Thang Wong (214748)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Callum Joon Thang Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Callum Joon Thang Wong', 'callum-joon-thang-wong-00e494', '214748', 'SAF Yacht Club', 'ANGLO-CHINESESCHOOL(INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '214748' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO-CHINESESCHOOL(INDEPENDENT)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 31, 197.0, 150.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 2, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 3, 21.0, NULL, false, '21', now()),
    (gen_random_uuid(), v_res_id, 4, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 5, 47.0, NULL, true, '(47)', now()),
    (gen_random_uuid(), v_res_id, 6, 35.0, NULL, false, '35', now());

  -- [ILCA 4] Rank 32: Yunosuke Ogawa (214779)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Yunosuke Ogawa')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Yunosuke Ogawa', 'yunosuke-ogawa-0affe1', '214779', 'Constant Wind', 'Overseas FamilySchool', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '214779' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'Overseas FamilySchool'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 32, 188.0, 151.0, false, 'M', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 2, 37.0, NULL, true, '(37)', now()),
    (gen_random_uuid(), v_res_id, 3, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 4, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 5, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 6, 31.0, NULL, false, '31', now());

  -- [ILCA 4] Rank 33: Alaric Shenthil Naidu (170299)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Alaric Shenthil Naidu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Alaric Shenthil Naidu', 'alaric-shenthil-naidu-9f8bd6', '170299', 'SAF Yacht Club', 'ANGLO-CHINESESCHOOL(BARKER ROAD)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '170299' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO-CHINESESCHOOL(BARKER ROAD)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 33, 191.0, 153.0, false, 'M', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 26.0, NULL, false, '26', now()),
    (gen_random_uuid(), v_res_id, 2, 34.0, NULL, false, '34', now()),
    (gen_random_uuid(), v_res_id, 3, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 4, 38.0, NULL, true, '(38)', now()),
    (gen_random_uuid(), v_res_id, 5, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 6, 27.0, NULL, false, '27', now());

  -- [ILCA 4] Rank 34: Kate Zi Ning Yeh (222437)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kate Zi Ning Yeh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kate Zi Ning Yeh', 'kate-zi-ning-yeh-421a81', '222437', 'Changi Sailing Club', 'NORTH VISTASECONDARYSCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '222437' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'NORTH VISTASECONDARYSCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 34, 202.0, 161.0, false, 'F', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 2, 41.0, NULL, true, '(41)', now()),
    (gen_random_uuid(), v_res_id, 3, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 4, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 5, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 6, 24.0, NULL, false, '24', now());

  -- [ILCA 4] Rank 35: Zhi Ting Liao (227460)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zhi Ting Liao')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Zhi Ting Liao', 'zhi-ting-liao-889f6f', '227460', 'SAF Yacht Club', 'RAFFLESINSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '227460' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'RAFFLESINSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 35, 217.0, 172.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 2, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 3, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 4, 45.0, NULL, true, '(45)', now()),
    (gen_random_uuid(), v_res_id, 5, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 6, 34.0, NULL, false, '34', now());

  -- [ILCA 4] Rank 36: Isla Zhi Xi Lee (8)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Isla Zhi Xi Lee')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Isla Zhi Xi Lee', 'isla-zhi-xi-lee-1fb1c0', '8', 'SAF Yacht Club', 'CHUNG CHENGHIGH SCHOOL(YISHUN)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '8' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'CHUNG CHENGHIGH SCHOOL(YISHUN)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 36, 220.0, 174.0, false, 'F', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 25.0, NULL, false, '25', now()),
    (gen_random_uuid(), v_res_id, 2, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 3, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 4, 46.0, 'SCP', true, '(46 SCP)', now()),
    (gen_random_uuid(), v_res_id, 5, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 6, 43.0, NULL, false, '43', now());

  -- [ILCA 4] Rank 37: Jonathan Kum Loong Kwok (214808)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jonathan Kum Loong Kwok')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jonathan Kum Loong Kwok', 'jonathan-kum-loong-kwok-ce8d79', '214808', 'Changi Sailing Club', 'ST. JOSEPH''SINSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '214808' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'ST. JOSEPH''SINSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 37, 216.0, 176.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 2, 40.0, NULL, true, '(40)', now()),
    (gen_random_uuid(), v_res_id, 3, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 4, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 5, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 6, 36.0, NULL, false, '36', now());

  -- [ILCA 4] Rank 38: Caleb Zhixuan Cao (225207)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Caleb Zhixuan Cao')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Caleb Zhixuan Cao', 'caleb-zhixuan-cao-ca2c53', '225207', 'SAF Yacht Club', 'ANGLO-CHINESESCHOOL(INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '225207' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO-CHINESESCHOOL(INDEPENDENT)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 38, 226.0, 178.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 2, 27.0, NULL, false, '27', now()),
    (gen_random_uuid(), v_res_id, 3, 33.0, NULL, false, '33', now()),
    (gen_random_uuid(), v_res_id, 4, 32.0, NULL, false, '32', now()),
    (gen_random_uuid(), v_res_id, 5, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 6, 48.0, NULL, true, '(48)', now());

  -- [ILCA 4] Rank 39: Gerome Sim (4)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Gerome Sim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Gerome Sim', 'gerome-sim-e9009a', '4', 'SAF Yacht Club', 'RAFFLESINSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '4' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'RAFFLESINSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 39, 225.0, 179.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 2, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 3, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 4, 35.0, NULL, false, '35', now()),
    (gen_random_uuid(), v_res_id, 5, 46.0, NULL, true, '(46)', now()),
    (gen_random_uuid(), v_res_id, 6, 45.0, NULL, false, '45', now());

  -- [ILCA 4] Rank 40: Jiayan Xu (224656)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jiayan Xu')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jiayan Xu', 'jiayan-xu-e9e6be', '224656', 'SAF Yacht Club', 'RAFFLESINSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '224656' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'RAFFLESINSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 40, 220.0, 180.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 2, 36.0, NULL, false, '36', now()),
    (gen_random_uuid(), v_res_id, 3, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 4, 31.0, NULL, false, '31', now()),
    (gen_random_uuid(), v_res_id, 5, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 6, 40.0, NULL, true, '(40)', now());

  -- [ILCA 4] Rank 41: Jonas Kia Jeng Tan (197840)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jonas Kia Jeng Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jonas Kia Jeng Tan', 'jonas-kia-jeng-tan-77cc2f', '197840', 'SAF Yacht Club', 'ST. JOSEPH''SINSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '197840' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ST. JOSEPH''SINSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 41, 233.0, 182.0, false, 'M', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 24.0, NULL, false, '24', now()),
    (gen_random_uuid(), v_res_id, 2, 30.0, NULL, false, '30', now()),
    (gen_random_uuid(), v_res_id, 3, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 4, 41.0, NULL, false, '41', now()),
    (gen_random_uuid(), v_res_id, 5, 51.0, NULL, true, '(51)', now()),
    (gen_random_uuid(), v_res_id, 6, 46.0, NULL, false, '46', now());

  -- [ILCA 4] Rank 42: Cecilia Sze Sen Kong (227678)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cecilia Sze Sen Kong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cecilia Sze Sen Kong', 'cecilia-sze-sen-kong-3ae5f5', '227678', 'Changi Sailing Club', 'NATIONALJUNIORCOLLEGE', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '227678' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'NATIONALJUNIORCOLLEGE'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 42, 239.0, 193.0, false, 'F', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 2, 46.0, NULL, true, '(46)', now()),
    (gen_random_uuid(), v_res_id, 3, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 4, 39.0, NULL, false, '39', now()),
    (gen_random_uuid(), v_res_id, 5, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 6, 23.0, NULL, false, '23', now());

  -- [ILCA 4] Rank 43: Joel Kai En Tan (214849)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joel Kai En Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joel Kai En Tan', 'joel-kai-en-tan-ebb7f1', '214849', 'Changi Sailing Club', 'ST. JOSEPH''SINSTITUTION', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '214849' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'ST. JOSEPH''SINSTITUTION'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 43, 242.0, 196.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 2, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 3, 46.0, NULL, true, '(46)', now()),
    (gen_random_uuid(), v_res_id, 4, 44.0, NULL, false, '44', now()),
    (gen_random_uuid(), v_res_id, 5, 29.0, NULL, false, '29', now()),
    (gen_random_uuid(), v_res_id, 6, 39.0, NULL, false, '39', now());

  -- [ILCA 4] Rank 44: Joshua Zhuo Xi Khoo (227677)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Joshua Zhuo Xi Khoo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Joshua Zhuo Xi Khoo', 'joshua-zhuo-xi-khoo-36826f', '227677', 'SAF Yacht Club', 'ANGLO-CHINESESCHOOL(INDEPENDENT)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '227677' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO-CHINESESCHOOL(INDEPENDENT)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 44, 244.0, 196.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 48.0, NULL, true, '(48)', now()),
    (gen_random_uuid(), v_res_id, 2, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 3, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 4, 37.0, NULL, false, '37', now()),
    (gen_random_uuid(), v_res_id, 5, 38.0, NULL, false, '38', now()),
    (gen_random_uuid(), v_res_id, 6, 38.0, NULL, false, '38', now());

  -- [ILCA 4] Rank 45: Lukas Kiesselbach (221597)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Lukas Kiesselbach')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Lukas Kiesselbach', 'lukas-kiesselbach-86f8a0', '221597', 'Changi Sailing Club', 'United World College (SEA)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '221597' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'United World College (SEA)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 45, 252.0, 197.0, false, 'M', 2009, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 55.0, 'DNC', true, '(55 DNC)', now()),
    (gen_random_uuid(), v_res_id, 2, 55.0, 'DNC', false, '55 DNC', now()),
    (gen_random_uuid(), v_res_id, 3, 55.0, 'DNC', false, '55 DNC', now()),
    (gen_random_uuid(), v_res_id, 4, 55.0, 'DNC', false, '55 DNC', now()),
    (gen_random_uuid(), v_res_id, 5, 15.0, NULL, false, '15', now()),
    (gen_random_uuid(), v_res_id, 6, 17.0, NULL, false, '17', now());

  -- [ILCA 4] Rank 46: Mikail Shahrom (14)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mikail Shahrom')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mikail Shahrom', 'mikail-shahrom-c26191', '14', 'Changi Sailing Club', 'Home School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '14' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'Home School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 46, 264.0, 217.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 2, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 3, 47.0, NULL, true, '(47)', now()),
    (gen_random_uuid(), v_res_id, 4, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 5, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 6, 41.0, NULL, false, '41', now());

  -- [ILCA 4] Rank 47: Mathias Cheow (225167)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Mathias Cheow')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Mathias Cheow', 'mathias-cheow-8f3785', '225167', 'SAF Yacht Club', 'ANGLO-CHINESESCHOOL(BARKER ROAD)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '225167' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ANGLO-CHINESESCHOOL(BARKER ROAD)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 47, 275.0, 224.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 2, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 3, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 4, 46.0, NULL, false, '46', now()),
    (gen_random_uuid(), v_res_id, 5, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 6, 51.0, NULL, true, '(51)', now());

  -- [ILCA 4] Rank 48: Tiffany Teo (214813)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tiffany Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tiffany Teo', 'tiffany-teo-16817a', '214813', 'PAssion Wave', 'BEDOK SOUTHSECONDARYSCHOOL', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '214813' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'BEDOK SOUTHSECONDARYSCHOOL'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 48, 278.0, 228.0, false, 'F', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 2, 43.0, NULL, false, '43', now()),
    (gen_random_uuid(), v_res_id, 3, 42.0, NULL, false, '42', now()),
    (gen_random_uuid(), v_res_id, 4, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 5, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 6, 50.0, NULL, true, '(50)', now());

  -- [ILCA 4] Rank 49: Jamiroquai Kai Nuo Tay (10)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jamiroquai Kai Nuo Tay')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jamiroquai Kai Nuo Tay', 'jamiroquai-kai-nuo-tay-0fb04d', '10', 'SAF Yacht Club', 'Geylang MethodistSchool(Secondary)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '10' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'Geylang MethodistSchool(Secondary)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 49, 291.0, 236.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 40.0, NULL, false, '40', now()),
    (gen_random_uuid(), v_res_id, 2, 47.0, NULL, false, '47', now()),
    (gen_random_uuid(), v_res_id, 3, 55.0, 'DNF', true, '(55 DNF)', now()),
    (gen_random_uuid(), v_res_id, 4, 55.0, 'RET', false, '55 RET', now()),
    (gen_random_uuid(), v_res_id, 5, 45.0, NULL, false, '45', now()),
    (gen_random_uuid(), v_res_id, 6, 49.0, NULL, false, '49', now());

  -- [ILCA 4] Rank 50: Jun Jie Chen (43)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jun Jie Chen')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jun Jie Chen', 'jun-jie-chen-520e7e', '43', 'PAssion Wave', 'ST. PATRICK''SSCHOOL', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '43' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'ST. PATRICK''SSCHOOL'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 50, 299.0, 246.0, false, 'M', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 2, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 3, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 4, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 5, 53.0, NULL, true, '(53)', now()),
    (gen_random_uuid(), v_res_id, 6, 52.0, NULL, false, '52', now());

  -- [ILCA 4] Rank 51: Tomas Agea (221062)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Tomas Agea')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Tomas Agea', 'tomas-agea-c0fd8f', '221062', 'Constant Wind', 'DULWICHCOLLEGE', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '221062' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'DULWICHCOLLEGE'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 51, 303.0, 248.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 2, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 3, 55.0, 'DNF', true, '(55 DNF)', now()),
    (gen_random_uuid(), v_res_id, 4, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 5, 52.0, NULL, false, '52', now()),
    (gen_random_uuid(), v_res_id, 6, 47.0, NULL, false, '47', now());

  -- [ILCA 4] Rank 52: Maximilian Ha (13)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Maximilian Ha')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Maximilian Ha', 'maximilian-ha-072c3e', '13', 'PAssion Wave', 'Anglo-Chinese School (Independent)', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '13' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'Anglo-Chinese School (Independent)'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 52, 310.0, 255.0, false, 'M', 2012, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 55.0, 'DNF', true, '(55 DNF)', now()),
    (gen_random_uuid(), v_res_id, 2, 51.0, NULL, false, '51', now()),
    (gen_random_uuid(), v_res_id, 3, 49.0, NULL, false, '49', now()),
    (gen_random_uuid(), v_res_id, 4, 54.0, 'SCP', false, '54 SCP', now()),
    (gen_random_uuid(), v_res_id, 5, 48.0, NULL, false, '48', now()),
    (gen_random_uuid(), v_res_id, 6, 53.0, NULL, false, '53', now());

  -- [ILCA 4] Rank 53: Ethan Goy (21248)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Ethan Goy')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Ethan Goy', 'ethan-goy-a88cba', '21248', 'PAssion Wave', 'Victoria School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '21248' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
      school = COALESCE(school, 'Victoria School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 53, 314.0, 259.0, false, 'M', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 55.0, 'DNC', true, '(55 DNC)', now()),
    (gen_random_uuid(), v_res_id, 2, 55.0, 'DNC', false, '55 DNC', now()),
    (gen_random_uuid(), v_res_id, 3, 55.0, 'DNC', false, '55 DNC', now()),
    (gen_random_uuid(), v_res_id, 4, 55.0, 'DNC', false, '55 DNC', now()),
    (gen_random_uuid(), v_res_id, 5, 50.0, NULL, false, '50', now()),
    (gen_random_uuid(), v_res_id, 6, 44.0, NULL, false, '44', now());

  -- [ILCA 4] Rank 54: Jade Zi Yu Yeh (227609)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jade Zi Yu Yeh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jade Zi Yu Yeh', 'jade-zi-yu-yeh-81f981', '227609', 'Changi Sailing Club', 'North Vista Secondary School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '227609' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'North Vista Secondary School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_ilca4_id, v_sailor_id, 54, 330.0, 275.0, false, 'F', 2010, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 55.0, 'DNC', true, '(55 DNC)', now()),
    (gen_random_uuid(), v_res_id, 2, 55.0, 'DNC', false, '55 DNC', now()),
    (gen_random_uuid(), v_res_id, 3, 55.0, 'DNC', false, '55 DNC', now()),
    (gen_random_uuid(), v_res_id, 4, 55.0, 'DNC', false, '55 DNC', now()),
    (gen_random_uuid(), v_res_id, 5, 55.0, 'DNC', false, '55 DNC', now()),
    (gen_random_uuid(), v_res_id, 6, 55.0, 'DNC', false, '55 DNC', now());

  -- ==========================================================================
  -- 29er CLASS (3 competitors)
  -- ==========================================================================

  -- [29er] Rank 1: Sean Kum / Nigel Tan (2472)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Sean Kum / Nigel Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Sean Kum / Nigel Tan', 'sean-kum-nigel-tan-04a977', '2472', 'SAF Yacht Club', 'ACS(I) and SJI', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2472' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'ACS(I) and SJI'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_29er_id, v_sailor_id, 1, 10.0, 8.0, false, 'M', 2010, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 2, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 3, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 4, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 5, 2.0, NULL, true, '(2)', now()),
    (gen_random_uuid(), v_res_id, 6, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 7, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 8, 1.0, NULL, false, '1', now());

  -- [29er] Rank 2: Cheryl Yong / Febe Wong (2466)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cheryl Yong / Febe Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cheryl Yong / Febe Wong', 'cheryl-yong-febe-wong-2b94f6', '2466', 'Changi Sailing Club', 'CHIJ St. Theresa''s Convent', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2466' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
      school = COALESCE(school, 'CHIJ St. Theresa''s Convent'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_29er_id, v_sailor_id, 2, 15.0, 12.0, false, 'F', 2009, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 2, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 3, 3.0, NULL, true, '(3)', now()),
    (gen_random_uuid(), v_res_id, 4, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 5, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 6, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 7, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 8, 2.0, NULL, false, '2', now());

  -- [29er] Rank 3: Cheryl Ho / Gemma Chen (2869)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Cheryl Ho / Gemma Chen')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Cheryl Ho / Gemma Chen', 'cheryl-ho-gemma-chen-81e35e', '2869', 'SAF Yacht Club', 'Raffles Girls'' School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2869' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'Raffles Girls'' School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_29er_id, v_sailor_id, 3, 27.0, 23.0, false, 'F', 2010, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 2, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 3, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 4, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 5, 4.0, 'DNC', true, '(4 DNC)', now()),
    (gen_random_uuid(), v_res_id, 6, 4.0, 'DNC', false, '4 DNC', now()),
    (gen_random_uuid(), v_res_id, 7, 4.0, 'DNC', false, '4 DNC', now()),
    (gen_random_uuid(), v_res_id, 8, 4.0, 'DNC', false, '4 DNC', now());

  -- ==========================================================================
  -- TECHNO 293 CLASS (5 competitors)
  -- ==========================================================================

  -- [Techno 293] Rank 1: Addy Armand Anuar (143)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Addy Armand Anuar')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Addy Armand Anuar', 'addy-armand-anuar-23b3ea', '143', 'Constant Wind', 'Bedok Green Secondary School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '143' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'Bedok Green Secondary School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_techno_id, v_sailor_id, 1, 11.0, 6.0, false, 'M', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 2, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 3, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 4, 5.0, NULL, true, '(5)', now()),
    (gen_random_uuid(), v_res_id, 5, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 6, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 7, 1.0, NULL, false, '1', now());

  -- [Techno 293] Rank 2: Shan Qi (26)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Shan Qi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Shan Qi', 'shan-qi-983de5', '26', 'SAF Yacht Club', NULL, 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '26' ELSE sail_number END,
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
    v_res_id, v_techno_id, v_sailor_id, 2, 22.0, 17.0, false, 'F', 2013, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 2, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 3, 5.0, NULL, true, '(5)', now()),
    (gen_random_uuid(), v_res_id, 4, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 5, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 6, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 7, 2.0, NULL, false, '2', now());

  -- [Techno 293] Rank 3: Eunice Yi Ning Tan (679)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Eunice Yi Ning Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Eunice Yi Ning Tan', 'eunice-yi-ning-tan-da78dd', '679', 'SAF Yacht Club', 'Dunman High School', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '679' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
      school = COALESCE(school, 'Dunman High School'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_techno_id, v_sailor_id, 3, 21.0, 17.0, false, 'F', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 2, 4.0, NULL, true, '(4)', now()),
    (gen_random_uuid(), v_res_id, 3, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 4, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 5, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 6, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 7, 3.0, NULL, false, '3', now());

  -- [Techno 293] Rank 4: Michael Shi Jun Lim (38)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Michael Shi Jun Lim')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Michael Shi Jun Lim', 'michael-shi-jun-lim-550be2', '38', 'Constant Wind', 'St. Joseph''s Institution International', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '38' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'St. Joseph''s Institution International'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_techno_id, v_sailor_id, 4, 22.0, 18.0, false, 'M', 2010, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 4.0, NULL, true, '(4)', now()),
    (gen_random_uuid(), v_res_id, 2, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 3, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 4, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 5, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 6, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 7, 4.0, NULL, false, '4', now());

  -- [Techno 293] Rank 5: Kate Teo (235)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kate Teo')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Kate Teo', 'kate-teo-08d851', '235', 'Constant Wind', 'Paya Lebar Methodist Girls'' School (Secondary)', 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '235' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind'),
      school = COALESCE(school, 'Paya Lebar Methodist Girls'' School (Secondary)'),
      gender = COALESCE(gender, 'F'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_techno_id, v_sailor_id, 5, 29.0, 24.0, false, 'F', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 5.0, NULL, true, '(5)', now()),
    (gen_random_uuid(), v_res_id, 2, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 3, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 4, 4.0, NULL, false, '4', now()),
    (gen_random_uuid(), v_res_id, 5, 5.0, NULL, false, '5', now()),
    (gen_random_uuid(), v_res_id, 6, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 7, 5.0, NULL, false, '5', now());

  -- ==========================================================================
  -- iQFOiL CLASS (3 competitors)
  -- ==========================================================================

  -- [iQFOiL] Rank 1: John Tze Xiang Wong (2)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('John Tze Xiang Wong')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'John Tze Xiang Wong', 'john-tze-xiang-wong-451120', '2', 'ASSC', 'Singapore Sports School', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '2' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'ASSC'),
      school = COALESCE(school, 'Singapore Sports School'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_iqfoil_id, v_sailor_id, 1, 4.0, 3.0, false, 'M', 2008, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 1.0, NULL, true, '(1)', now()),
    (gen_random_uuid(), v_res_id, 2, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 3, 1.0, NULL, false, '1', now()),
    (gen_random_uuid(), v_res_id, 4, 1.0, NULL, false, '1', now());

  -- [iQFOiL] Rank 2: Jonas Knick (39)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jonas Knick')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Jonas Knick', 'jonas-knick-7e43ab', '39', 'WAS', 'School of Science and Technology', 'M', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '39' ELSE sail_number END,
      club = COALESCE(NULLIF(trim(club), ''), 'WAS'),
      school = COALESCE(school, 'School of Science and Technology'),
      gender = COALESCE(gender, 'M'),
      nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
      updated_at = now()
    WHERE id = v_sailor_id;
  END IF;

  v_res_id := gen_random_uuid();
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    v_res_id, v_iqfoil_id, v_sailor_id, 2, 9.0, 6.0, false, 'M', 2011, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 2, 3.0, NULL, true, '(3)', now()),
    (gen_random_uuid(), v_res_id, 3, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 4, 2.0, NULL, false, '2', now());

  -- [iQFOiL] Rank 3: Angyal Chew (711)
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Angyal Chew')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (
      id, name, handle, sail_number, club, school, gender, nationality, created_at, updated_at
    ) VALUES (
      v_sailor_id, 'Angyal Chew', 'angyal-chew-3fd768', '711', 'Changi Sailing Club', NULL, 'F', 'SGP', now(), now()
    );
  ELSE
    UPDATE public.sailors SET
      sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number = '0' THEN '711' ELSE sail_number END,
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
    v_res_id, v_iqfoil_id, v_sailor_id, 3, 11.0, 8.0, false, 'F', 2008, 'SGP', 'verified', now(), now(), now()
  );

  INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at) VALUES
    (gen_random_uuid(), v_res_id, 1, 3.0, NULL, true, '(3)', now()),
    (gen_random_uuid(), v_res_id, 2, 2.0, NULL, false, '2', now()),
    (gen_random_uuid(), v_res_id, 3, 3.0, NULL, false, '3', now()),
    (gen_random_uuid(), v_res_id, 4, 3.0, NULL, false, '3', now());

END $$;
