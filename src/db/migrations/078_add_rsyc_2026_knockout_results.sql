-- 078_add_rsyc_2026_knockout_results.sql
-- Import official results for RSYC Optimist Silver Fleet Knockout Championship 2026
-- Dates: 26–27 September 2026
-- Venue: Republic of Singapore Yacht Club, 52 West Coast Ferry Road, Singapore 126887
-- Organiser: Republic of Singapore Yacht Club (RSYC)
-- Fleet: Optimist Silver Fleet (Knockout Championship: Qualifying Rounds, Repechage, Final & Petite Final Rounds)

DO $$
DECLARE
  v_event_id uuid;
  v_regatta_id uuid;
  v_sailor_id uuid;
BEGIN
  -- 1. Ensure weekend event exists in public.regatta_events
  SELECT id INTO v_event_id FROM public.regatta_events WHERE slug = 'rsyc-optimist-silver-fleet-knockout-championship-2026' LIMIT 1;
  IF v_event_id IS NULL THEN
    v_event_id := gen_random_uuid();
    INSERT INTO public.regatta_events (
      id, name, slug, start_date, end_date, venue, organizer, classes, nor_url, registration_url, counts_for_ranking, is_selection_trial, created_at, updated_at
    ) VALUES (
      v_event_id,
      'RSYC Optimist Silver Fleet Knockout Championship 2026',
      'rsyc-optimist-silver-fleet-knockout-championship-2026',
      '2026-09-26',
      '2026-09-27',
      'Republic of Singapore Yacht Club, Singapore',
      'Republic of Singapore Yacht Club',
      '["Optimist (Silver)"]'::jsonb,
      'https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2026/',
      'https://tinyurl.com/RSYCSilverFleetOKC2026',
      true,
      false,
      now(),
      now()
    );
  END IF;

  -- 2. Ensure Optimist Silver regatta exists in public.regattas
  SELECT id INTO v_regatta_id FROM public.regattas WHERE slug = 'rsyc-optimist-silver-fleet-knockout-championship-2026' LIMIT 1;
  IF v_regatta_id IS NOT NULL THEN
    UPDATE public.regattas SET
      event_id = v_event_id,
      name = 'RSYC Optimist Silver Fleet Knockout Championship 2026',
      slug = 'rsyc-optimist-silver-fleet-knockout-championship-2026',
      date = '2026-09-26',
      end_date = '2026-09-27',
      boat_class = 'Optimist',
      division = 'Silver',
      total_fleet_size = 13,
      race_count = 8,
      geography = 'SG',
      counts_for_ranking = true,
      is_selection_trial = false,
      venue = 'Republic of Singapore Yacht Club, 52 West Coast Ferry Road, Singapore 126887',
      organizer = 'Republic of Singapore Yacht Club',
      nor_url = 'https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2026/',
      registration_url = 'https://tinyurl.com/RSYCSilverFleetOKC2026',
      schedule_notes = 'RSYC Optimist Silver Fleet Knockout Championship 2026 (26–27 September 2026) at RSYC. Knockout series format: Qualifying Rounds, Repechage Round, Final Rounds, and Petite Final Rounds.',
      status = 'published',
      updated_at = now()
    WHERE id = v_regatta_id;
  ELSE
    v_regatta_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, is_selection_trial, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_regatta_id,
      v_event_id,
      'RSYC Optimist Silver Fleet Knockout Championship 2026',
      'rsyc-optimist-silver-fleet-knockout-championship-2026',
      '2026-09-26',
      '2026-09-27',
      'Optimist',
      'Silver',
      13,
      8,
      'SG',
      true,
      false,
      'Republic of Singapore Yacht Club, 52 West Coast Ferry Road, Singapore 126887',
      'Republic of Singapore Yacht Club',
      'https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2026/',
      'https://tinyurl.com/RSYCSilverFleetOKC2026',
      'RSYC Optimist Silver Fleet Knockout Championship 2026 (26–27 September 2026) at RSYC. Knockout series format: Qualifying Rounds, Repechage Round, Final Rounds, and Petite Final Rounds.',
      'published',
      now(),
      now()
    );
  END IF;

  -- 3. Clear existing results for this regatta
  DELETE FROM public.regatta_results WHERE regatta_id = v_regatta_id;

  -- 4. Insert / Match Sailors and Add Results

  -- Rank 1: Jade Tan (SGP 3555) - Overall 1st, Female 1st
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jade Tan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Jade Tan', 'jade-tan-d4e0f7', '3555', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 1, 1.0, 1.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Rank 2: Wai Yong Le (SGP 3488) - Overall 2nd
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Wai Yong Le')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Wai Yong Le', 'wai-yong-le-13383a', '3488', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 2, 2.0, 2.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Rank 3: Wu Jiaqian (SGP 3424) - Overall 3rd
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Wu Jiaqian')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Wu Jiaqian', 'wu-jiaqian-0e05dc', '3424', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 3, 3.0, 3.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Rank 4: Axel Lin (SGP 720) - Overall 4th, Under 10 1st
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Axel Lin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Axel Lin', 'axel-lin-00c7c6', '720', 'Changi Sailing Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 4, 4.0, 4.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Rank 5: Kiyansh Kanishk Singh (SGP 2046) - Overall 5th
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Kiyansh Kanishk Singh')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Kiyansh Kanishk Singh', 'kiyansh-kanishk-singh-8b2494', '2046', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 5, 5.0, 5.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Rank 6: Wang Hongren / Hongren Wang (SGP 2039) - Overall 6th, Under 10 2nd
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Hongren Wang')) OR lower(trim(name)) = lower(trim('Wang Hongren')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Hongren Wang', 'hongren-wang-587b2d', '2039', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Wang Hongren') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 6, 6.0, 6.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Rank 7: Han Moyan (SGP 2042) - Overall 7th
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Han Moyan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Han Moyan', 'han-moyan-d001d8', '2042', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 7, 7.0, 7.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Rank 8: Damien Seah (SGP 3825) - Overall 8th
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Damien Seah')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Damien Seah', 'damien-seah-d115ee', '3825', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 8, 8.0, 8.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Rank 9: Jerome Puah Yang Yi (SGP 2037) - Overall 9th, Under 10 3rd
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Jerome Puah Yang Yi')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Jerome Puah Yang Yi', 'jerome-puah-yang-yi-f942ec', '2037', 'PAssion Wave', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 9, 9.0, 9.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Rank 10: Zheng Ryan Feiran (SGP 2045) - Overall 10th
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Zheng Ryan Feiran')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Zheng Ryan Feiran', 'zheng-ryan-feiran-5a7323', '2045', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 10, 10.0, 10.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Rank 11: Chiang Ziyi Adele (SGP 3120) - Female 2nd
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Chiang Ziyi Adele')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Chiang Ziyi Adele', 'chiang-ziyi-adele-81a648', '3120', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 11, 11.0, 11.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Rank 12: Andrea Kwan (SGP 3745) - Female 3rd
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Andrea Kwan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Andrea Kwan', 'andrea-kwan-e40c2d', '3745', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 12, 12.0, 12.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Rank 13: Allison Teh Li Xin / Allison Li Xin Teh (SGP 787) - Under 8 1st
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower(trim('Allison Li Xin Teh')) OR lower(trim(name)) = lower(trim('Allison Teh Li Xin')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Allison Li Xin Teh', 'allison-li-xin-teh-3503', '787', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Allison Teh Li Xin') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 13, 13.0, 13.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  RAISE NOTICE 'Successfully imported RSYC Optimist Silver Fleet Knockout Championship 2026 results.';
END $$;
