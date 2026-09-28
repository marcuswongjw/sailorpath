-- 081_add_rsyc_2025_knockout_results.sql
-- Import official results for RSYC Optimist Knockout Championship 2025
-- Fleets:
-- 1) RSYC Optimist Silver Fleet Knockout Championship 2025 (23–24 August 2025, 62 competitors)
-- 2) RSYC Optimist Knockout Race 2025 / Gold Fleet (30–31 August 2025, 72 competitors)
-- Venue: Republic of Singapore Yacht Club (52 West Coast Ferry Road, Singapore 126887)
-- Organiser: Republic of Singapore Yacht Club (RSYC)

DO $$
DECLARE
  v_event_id uuid;
  v_regatta_gold_id uuid;
  v_regatta_silver_id uuid;
  v_sailor_id uuid;
BEGIN
  -- 1. Ensure weekend event exists in public.regatta_events
  SELECT id INTO v_event_id FROM public.regatta_events WHERE slug = 'rsyc-optimist-knockout-championship-2025' LIMIT 1;
  IF v_event_id IS NULL THEN
    v_event_id := gen_random_uuid();
    INSERT INTO public.regatta_events (
      id, name, slug, start_date, end_date, venue, organizer, classes, nor_url, registration_url, counts_for_ranking, is_selection_trial, created_at, updated_at
    ) VALUES (
      v_event_id,
      'RSYC Optimist Knockout Championship 2025',
      'rsyc-optimist-knockout-championship-2025',
      '2025-08-23',
      '2025-08-31',
      'Republic of Singapore Yacht Club, Singapore',
      'Republic of Singapore Yacht Club',
      '["Optimist (Gold)", "Optimist (Silver)"]'::jsonb,
      'https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2025/',
      'https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2025/',
      true,
      false,
      now(),
      now()
    );
  END IF;

  -- 2. Ensure Optimist Silver regatta exists in public.regattas
  SELECT id INTO v_regatta_silver_id FROM public.regattas WHERE slug = 'rsyc-optimist-silver-fleet-knockout-championship-2025' LIMIT 1;
  IF v_regatta_silver_id IS NOT NULL THEN
    UPDATE public.regattas SET
      event_id = v_event_id,
      name = 'RSYC Optimist Silver Fleet Knockout Championship 2025',
      slug = 'rsyc-optimist-silver-fleet-knockout-championship-2025',
      date = '2025-08-23',
      end_date = '2025-08-24',
      boat_class = 'Optimist',
      division = 'Silver',
      total_fleet_size = 62,
      race_count = 8,
      geography = 'SG',
      counts_for_ranking = true,
      is_selection_trial = false,
      venue = 'Republic of Singapore Yacht Club, 52 West Coast Ferry Road, Singapore 126887',
      organizer = 'Republic of Singapore Yacht Club',
      nor_url = 'https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2025/',
      registration_url = 'https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2025/',
      schedule_notes = 'RSYC Optimist Silver Fleet Knockout Championship 2025 (23–24 August 2025) at RSYC. Knockout series format: Qualifying Rounds, Repechage Round, Final Rounds, and Petite Final Rounds. 62 competitors.',
      status = 'published',
      updated_at = now()
    WHERE id = v_regatta_silver_id;
  ELSE
    v_regatta_silver_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, is_selection_trial, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_regatta_silver_id,
      v_event_id,
      'RSYC Optimist Silver Fleet Knockout Championship 2025',
      'rsyc-optimist-silver-fleet-knockout-championship-2025',
      '2025-08-23',
      '2025-08-24',
      'Optimist',
      'Silver',
      62,
      8,
      'SG',
      true,
      false,
      'Republic of Singapore Yacht Club, 52 West Coast Ferry Road, Singapore 126887',
      'Republic of Singapore Yacht Club',
      'https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2025/',
      'https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2025/',
      'RSYC Optimist Silver Fleet Knockout Championship 2025 (23–24 August 2025) at RSYC. Knockout series format: Qualifying Rounds, Repechage Round, Final Rounds, and Petite Final Rounds. 62 competitors.',
      'published',
      now(),
      now()
    );
  END IF;

  DELETE FROM public.regatta_results WHERE regatta_id = v_regatta_silver_id;

  -- Silver #1: Lee Kai En, Katelynn (Rank: 1)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Lee Kai En, Katelynn') OR lower(trim(name)) = lower('Lee Kai En Katelynn') OR lower(trim(name)) = lower('Katelynn Lee Kai En')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Lee Kai En, Katelynn'), lower('Lee Kai En Katelynn'), lower('Katelynn Lee Kai En')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Lee Kai En, Katelynn', 'lee-kai-en-katelynn-f3ce9c', '3383', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Lee Kai En Katelynn') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Katelynn Lee Kai En') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailors
  SET dob = '2014-04-10'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 1, 1.0, 1.0, false, 'F', 2014, 'SGP', 'verified', now(), now(), now());

  -- Silver #2: Qi Tan (Rank: 2)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Qi Tan')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Qi Tan')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Qi Tan', 'qi-tan-82ef4b', '3026', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2015-11-03'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 2, 2.0, 2.0, false, 'F', 2015, 'SGP', 'verified', now(), now(), now());

  -- Silver #3: Joshua Tan Zhi Kai (Rank: 3)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Joshua Tan Zhi Kai')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Joshua Tan Zhi Kai')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Joshua Tan Zhi Kai', 'joshua-tan-zhi-kai-359c91', '3036', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2014-12-19'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 3, 3.0, 3.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now());

  -- Silver #4: Wang Boren (Rank: 4)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Wang Boren')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Wang Boren')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Wang Boren', 'wang-boren-55d49b', 'TBD', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2014-12-10'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 4, 4.0, 4.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now());

  -- Silver #5: Tyler Koo (Rank: 5)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Tyler Koo')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Tyler Koo')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Tyler Koo', 'tyler-koo-9b7377', '996', 'Republic of Singapore Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2014-07-12'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 5, 5.0, 5.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now());

  -- Silver #6: Chen Yan Ying (Abby) (Rank: 6)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Chen Yan Ying (Abby)') OR lower(trim(name)) = lower('Chen Yan Ying') OR lower(trim(name)) = lower('Abby Chen Yan Ying')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Chen Yan Ying (Abby)'), lower('Chen Yan Ying'), lower('Abby Chen Yan Ying')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Chen Yan Ying (Abby)', 'chen-yan-ying-abby-1f3b89', '4729', 'PAssion Wave', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Chen Yan Ying') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Abby Chen Yan Ying') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailors
  SET dob = '2016-08-31'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 6, 6.0, 6.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now());

  -- Silver #7: William Poon (Rank: 7)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('William Poon')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('William Poon')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'William Poon', 'william-poon-72e858', '21', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2015-05-30'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 7, 7.0, 7.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now());

  -- Silver #8: Nigel Ng Jiang Long (Rank: 8)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Nigel Ng Jiang Long')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Nigel Ng Jiang Long')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Nigel Ng Jiang Long', 'nigel-ng-jiang-long-0faf76', '3363', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2015-08-05'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 8, 8.0, 8.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now());

  -- Silver #9: Mao Weihan (Rank: 9)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Mao Weihan')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Mao Weihan')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Mao Weihan', 'mao-weihan-a71947', 'TBD', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2014-06-19'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 9, 9.0, 9.0, false, 'F', 2014, 'SGP', 'verified', now(), now(), now());

  -- Silver #10: Tan Kai En Hayley (Rank: 10)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Tan Kai En Hayley')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Tan Kai En Hayley')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Tan Kai En Hayley', 'tan-kai-en-hayley-9e7058', '700', 'Changi Sailing Club', 'F', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2016-12-08'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 10, 10.0, 10.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now());

  -- Silver #11: Ouyang Hanyue (Rank: 11)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Ouyang Hanyue')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Ouyang Hanyue')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Ouyang Hanyue', 'ouyang-hanyue-60996c', '5003', 'ONE°15 Marina', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2015-03-24'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 11, 11.0, 11.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now());

  -- Silver #12: Mikaela Wong Hui Ting (Rank: 12)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Mikaela Wong Hui Ting')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Mikaela Wong Hui Ting')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Mikaela Wong Hui Ting', 'mikaela-wong-hui-ting-747cef', '37', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2015-12-12'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 12, 12.0, 12.0, false, 'F', 2015, 'SGP', 'verified', now(), now(), now());

  -- Silver #13: Kai Chen-Yi (Rank: 13)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Kai Chen-Yi')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Kai Chen-Yi')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Kai Chen-Yi', 'kai-chen-yi-8adac3', '757', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2016-03-12'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 13, 13.0, 13.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now());

  -- Silver #14: Lee Kai Lun, Matthias (Rank: 14)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Lee Kai Lun, Matthias') OR lower(trim(name)) = lower('Lee Kai Lun Matthias') OR lower(trim(name)) = lower('Matthias Lee Kai Lun')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Lee Kai Lun, Matthias'), lower('Lee Kai Lun Matthias'), lower('Matthias Lee Kai Lun')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Lee Kai Lun, Matthias', 'lee-kai-lun-matthias-948cb5', '3385', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Lee Kai Lun Matthias') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Matthias Lee Kai Lun') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailors
  SET dob = '2017-03-09'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 14, 14.0, 14.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now());

  -- Silver #15: Jayden Zhang (Rank: 15)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Jayden Zhang')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Jayden Zhang')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Jayden Zhang', 'jayden-zhang-9cdc2b', '5705', 'Schonst Sailing Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2015-11-18'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 15, 15.0, 15.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now());

  -- Silver #16: Evan Ong En Kai (Rank: 16)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Evan Ong En Kai')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Evan Ong En Kai')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Evan Ong En Kai', 'evan-ong-en-kai-ba7a25', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2017-06-21'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 16, 16.0, 16.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now());

  -- Silver #17: Christopher Soh (Rank: 17)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Christopher Soh')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Christopher Soh')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Christopher Soh', 'christopher-soh-cc1034', '3168', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2015-07-10'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 17, 17.0, 17.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now());

  -- Silver #18: Isabelle Zhang Xinyi (Rank: 18)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Isabelle Zhang Xinyi')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Isabelle Zhang Xinyi')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Isabelle Zhang Xinyi', 'isabelle-zhang-xinyi-80cdae', '70', 'Constant Wind', 'F', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2016-01-10'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 18, 18.0, 18.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now());

  -- Silver #19: Chan Zhi Long Breyven (Rank: 19)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Chan Zhi Long Breyven')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Chan Zhi Long Breyven')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Chan Zhi Long Breyven', 'chan-zhi-long-breyven-16aa51', '3338', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2014-09-18'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 19, 19.0, 19.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now());

  -- Silver #20: Loh Yan Cheng (Rank: 20)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Loh Yan Cheng')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Loh Yan Cheng')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Loh Yan Cheng', 'loh-yan-cheng-7e74e9', '3717', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2017-01-31'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 20, 20.0, 20.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now());

  -- Silver #21: Wai Yong Le (Rank: 21)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Wai Yong Le')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Wai Yong Le')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Wai Yong Le', 'wai-yong-le-99378b', '3488', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2015-11-04'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 21, 21.0, 21.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now());

  -- Silver #22: Teo Kai Jie (Rank: 22)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Teo Kai Jie')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Teo Kai Jie')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Teo Kai Jie', 'teo-kai-jie-d45718', '3550', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2016-12-28'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 22, 22.0, 22.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now());

  -- Silver #23: Yuan Su (Rank: 23)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Yuan Su')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Yuan Su')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Yuan Su', 'yuan-su-dab5e4', 'TBD', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2013-10-31'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 23, 23.0, 23.0, false, 'F', 2013, 'SGP', 'verified', now(), now(), now());

  -- Silver #24: Ivor Lee (Rank: 24)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Ivor Lee')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Ivor Lee')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Ivor Lee', 'ivor-lee-143259', '3306', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2015-10-27'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 24, 24.0, 24.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now());

  -- Silver #25: Jade Tan (Rank: 25)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Jade Tan')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Jade Tan')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Jade Tan', 'jade-tan-c2cb48', '3425', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2016-02-04'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 25, 25.0, 25.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now());

  -- Silver #26: Ryan choo (Rank: 26)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Ryan choo')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Ryan choo')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Ryan choo', 'ryan-choo-602fee', 'TBD', 'Changi Sailing Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2014-02-14'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 26, 26.0, 26.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now());

  -- Silver #27: Seow Jun Sheng Lucas (Rank: 27)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Seow Jun Sheng Lucas')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Seow Jun Sheng Lucas')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Seow Jun Sheng Lucas', 'seow-jun-sheng-lucas-ede769', '2047', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2014-12-19'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 27, 27.0, 27.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now());

  -- Silver #28: Iver Lee (Rank: 28)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Iver Lee')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Iver Lee')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Iver Lee', 'iver-lee-d4e5bb', '3309', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2016-10-27'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 28, 28.0, 28.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now());

  -- Silver #29: Ashleigh Teh Li Ying (Rank: 29)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Ashleigh Teh Li Ying')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Ashleigh Teh Li Ying')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Ashleigh Teh Li Ying', 'ashleigh-teh-li-ying-ab930e', '64', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2016-12-03'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 29, 29.0, 29.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now());

  -- Silver #30: Koh Yi Jie Zachary (Rank: 30)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Koh Yi Jie Zachary')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Koh Yi Jie Zachary')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Koh Yi Jie Zachary', 'koh-yi-jie-zachary-1070cf', 'TBD', 'PAssion Wave', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2014-06-30'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 30, 30.0, 30.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now());

  -- Silver #31: Soh Zi Xuan Hayden (Rank: 31)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Soh Zi Xuan Hayden')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Soh Zi Xuan Hayden')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Soh Zi Xuan Hayden', 'soh-zi-xuan-hayden-0fed86', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2014-12-01'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 31, 31.0, 31.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now());

  -- Silver #32: Aidan Yeo See Hett (Rank: 32)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Aidan Yeo See Hett')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Aidan Yeo See Hett')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Aidan Yeo See Hett', 'aidan-yeo-see-hett-d2fbde', '3112', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 32, 32.0, 32.0, false, 'M', NULL, 'SGP', 'verified', now(), now(), now());

  -- Silver #33: Henry Shayan Mittelhauser (Rank: 33)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Henry Shayan Mittelhauser')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Henry Shayan Mittelhauser')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Henry Shayan Mittelhauser', 'henry-shayan-mittelhauser-85c4e8', '2052', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2015-11-09'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 33, 33.0, 33.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now());

  -- Silver #34: Ng, Clara Siew Ning (Rank: 34)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Ng, Clara Siew Ning') OR lower(trim(name)) = lower('Ng Clara Siew Ning') OR lower(trim(name)) = lower('Clara Siew Ning Ng')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Ng, Clara Siew Ning'), lower('Ng Clara Siew Ning'), lower('Clara Siew Ning Ng')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Ng, Clara Siew Ning', 'ng-clara-siew-ning-41c9bd', '3739', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Ng Clara Siew Ning') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Clara Siew Ning Ng') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailors
  SET dob = '2015-07-05'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 34, 34.0, 34.0, false, 'F', 2015, 'SGP', 'verified', now(), now(), now());

  -- Silver #35: Damien Seah (Rank: 35)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Damien Seah')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Damien Seah')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Damien Seah', 'damien-seah-6d4b62', '3825', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2016-05-08'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 35, 35.0, 35.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now());

  -- Silver #36: Yasin Yusuf Bin Yusfianshah (Rank: 36)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Yasin Yusuf Bin Yusfianshah')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Yasin Yusuf Bin Yusfianshah')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Yasin Yusuf Bin Yusfianshah', 'yasin-yusuf-bin-yusfianshah-328c06', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2015-04-02'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 36, 36.0, 36.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now());

  -- Silver #37: Han Moyan (Rank: 37)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Han Moyan')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Han Moyan')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Han Moyan', 'han-moyan-e25b7f', '2042', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2016-09-21'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 37, 37.0, 37.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now());

  -- Silver #38: Asher Goh Hao En (Rank: 38)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Asher Goh Hao En')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Asher Goh Hao En')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Asher Goh Hao En', 'asher-goh-hao-en-7d7ed9', 'TBD', 'Changi Sailing Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2014-02-24'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 38, 38.0, 38.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now());

  -- Silver #39: Ethan mathew (Rank: 39)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Ethan mathew')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Ethan mathew')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Ethan mathew', 'ethan-mathew-6cc0cc', '3841', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2015-01-27'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 39, 39.0, 39.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now());

  -- Silver #40: Ezra Mak Yi Yang (Rank: 40)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Ezra Mak Yi Yang')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Ezra Mak Yi Yang')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Ezra Mak Yi Yang', 'ezra-mak-yi-yang-8991d9', '3535', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2016-04-12'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 40, 40.0, 40.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now());

  -- Silver #41: Wang Youqi Yuki (Rank: 41)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Wang Youqi Yuki')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Wang Youqi Yuki')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Wang Youqi Yuki', 'wang-youqi-yuki-22485a', '3523', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2015-05-13'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 41, 41.0, 41.0, false, 'F', 2015, 'SGP', 'verified', now(), now(), now());

  -- Silver #42: Chiang Ziyi Adele (Rank: 41)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Chiang Ziyi Adele')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Chiang Ziyi Adele')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Chiang Ziyi Adele', 'chiang-ziyi-adele-5d8815', '3120', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2017-12-20'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 41, 41.0, 41.0, false, 'F', 2017, 'SGP', 'verified', now(), now(), now());

  -- Silver #43: Zachary Hoo (Rank: 41)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Zachary Hoo')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Zachary Hoo')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Zachary Hoo', 'zachary-hoo-2d1eb8', '2051', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2014-04-20'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 41, 41.0, 41.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now());

  -- Silver #44: Llewellyn Tay Ding Zhe (Rank: 41)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Llewellyn Tay Ding Zhe')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Llewellyn Tay Ding Zhe')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Llewellyn Tay Ding Zhe', 'llewellyn-tay-ding-zhe-116f61', '48', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2017-11-17'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 41, 41.0, 41.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now());

  -- Silver #45: Scott Goh (Rank: 41)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Scott Goh')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Scott Goh')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Scott Goh', 'scott-goh-2537a2', '729', 'Changi Sailing Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2014-11-29'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 41, 41.0, 41.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now());

  -- Silver #46: Auwin Leow Zhao Hong (Rank: 42)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Auwin Leow Zhao Hong')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Auwin Leow Zhao Hong')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Auwin Leow Zhao Hong', 'auwin-leow-zhao-hong-bc7a73', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2015-12-30'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 42, 42.0, 42.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now());

  -- Silver #47: Zheng Ryan Feiran (Rank: 42)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Zheng Ryan Feiran')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Zheng Ryan Feiran')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Zheng Ryan Feiran', 'zheng-ryan-feiran-1bd94a', '2045', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2015-01-07'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 42, 42.0, 42.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now());

  -- Silver #48: Jacob Kok Jit Yeung (Rank: 42)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Jacob Kok Jit Yeung')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Jacob Kok Jit Yeung')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Jacob Kok Jit Yeung', 'jacob-kok-jit-yeung-9a5f18', '3087', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2017-07-31'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 42, 42.0, 42.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now());

  -- Silver #49: Tan You Yu (Rank: 42)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Tan You Yu')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Tan You Yu')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Tan You Yu', 'tan-you-yu-74e04e', 'TBD', 'PAssion Wave', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2014-04-07'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 42, 42.0, 42.0, false, 'M', 2014, 'SGP', 'verified', now(), now(), now());

  -- Silver #50: Nadia Zahedi (Rank: 42)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Nadia Zahedi')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Nadia Zahedi')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Nadia Zahedi', 'nadia-zahedi-21139d', '4724', 'PAssion Wave', 'F', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2017-02-25'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 42, 42.0, 42.0, false, 'F', 2017, 'SGP', 'verified', now(), now(), now());

  -- Silver #51: Seraphina Kang (Rank: 43)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Seraphina Kang')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Seraphina Kang')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Seraphina Kang', 'seraphina-kang-538b68', '2040', 'Constant Wind', 'F', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2016-01-14'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 43, 43.0, 43.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now());

  -- Silver #52: Skyler Kang (Rank: 43)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Skyler Kang')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Skyler Kang')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Skyler Kang', 'skyler-kang-bdda4b', '2041', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2017-07-15'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 43, 43.0, 43.0, false, 'M', 2017, 'SGP', 'verified', now(), now(), now());

  -- Silver #53: Changqi Tao (Rank: 43)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Changqi Tao')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Changqi Tao')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Changqi Tao', 'changqi-tao-33c224', '5721', 'Schonst Sailing Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2013-09-21'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 43, 43.0, 43.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now());

  -- Silver #54: Mitchell Lim Shi Kai (Rank: 43)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Mitchell Lim Shi Kai')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Mitchell Lim Shi Kai')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Mitchell Lim Shi Kai', 'mitchell-lim-shi-kai-0f42ad', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2016-09-23'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 43, 43.0, 43.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now());

  -- Silver #55: Isaac Chiam Qin Ran (Rank: 43)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Isaac Chiam Qin Ran')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Isaac Chiam Qin Ran')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Isaac Chiam Qin Ran', 'isaac-chiam-qin-ran-d17544', '3699', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2016-03-21'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 43, 43.0, 43.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now());

  -- Silver #56: See Jia Xing, Cadee (Rank: 44)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('See Jia Xing, Cadee') OR lower(trim(name)) = lower('See Jia Xing Cadee') OR lower(trim(name)) = lower('Cadee See Jia Xing')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('See Jia Xing, Cadee'), lower('See Jia Xing Cadee'), lower('Cadee See Jia Xing')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'See Jia Xing, Cadee', 'see-jia-xing-cadee-b5548f', 'TBD', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'See Jia Xing Cadee') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Cadee See Jia Xing') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailors
  SET dob = '2016-10-09'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 44, 44.0, 44.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now());

  -- Silver #57: Tomas Agea (Rank: 44)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Tomas Agea')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Tomas Agea')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Tomas Agea', 'tomas-agea-68aece', '52', 'Singapore Sailing Federation', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2013-04-04'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 44, 44.0, 44.0, false, 'M', 2013, 'SGP', 'verified', now(), now(), now());

  -- Silver #58: Du jiayi (Rank: 44)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Du jiayi')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Du jiayi')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Du jiayi', 'du-jiayi-c087ff', '3141', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2016-10-29'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 44, 44.0, 44.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now());

  -- Silver #59: Jae Toh Guan Yu (Rank: 44)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Jae Toh Guan Yu')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Jae Toh Guan Yu')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Jae Toh Guan Yu', 'jae-toh-guan-yu-da206d', '45', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2018-02-27'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 44, 44.0, 44.0, false, 'M', 2018, 'SGP', 'verified', now(), now(), now());

  -- Silver #60: Kiyansh Kanishk Singh (Rank: 44)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Kiyansh Kanishk Singh')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Kiyansh Kanishk Singh')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Kiyansh Kanishk Singh', 'kiyansh-kanishk-singh-bfd973', '2046', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2015-11-15'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 44, 44.0, 44.0, false, 'M', 2015, 'SGP', 'verified', now(), now(), now());

  -- Silver #61: Hu An (Rank: 45)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Hu An')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Hu An')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Hu An', 'hu-an-dab2d1', '3450', 'Constant Wind', 'F', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2016-05-05'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 45, 45.0, 45.0, false, 'F', 2016, 'SGP', 'verified', now(), now(), now());

  -- Silver #62: Emil Lam (Rank: 45)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Emil Lam')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Emil Lam')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Emil Lam', 'emil-lam-2e5ae7', '2049', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  UPDATE public.sailors
  SET dob = '2016-08-04'::date
  WHERE id = v_sailor_id
    AND (parent_id IS NULL OR dob IS NULL);
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, birth_year, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_silver_id, v_sailor_id, 45, 45.0, 45.0, false, 'M', 2016, 'SGP', 'verified', now(), now(), now());

  -- 3. Ensure Optimist Gold regatta exists in public.regattas
  SELECT id INTO v_regatta_gold_id FROM public.regattas WHERE slug = 'rsyc-optimist-gold-fleet-knockout-championship-2025' LIMIT 1;
  IF v_regatta_gold_id IS NOT NULL THEN
    UPDATE public.regattas SET
      event_id = v_event_id,
      name = 'RSYC Optimist Knockout Race 2025 (Gold Fleet)',
      slug = 'rsyc-optimist-gold-fleet-knockout-championship-2025',
      date = '2025-08-30',
      end_date = '2025-08-31',
      boat_class = 'Optimist',
      division = 'Gold',
      total_fleet_size = 72,
      race_count = 8,
      geography = 'SG',
      counts_for_ranking = true,
      is_selection_trial = false,
      venue = 'Republic of Singapore Yacht Club, 52 West Coast Ferry Road, Singapore 126887',
      organizer = 'Republic of Singapore Yacht Club',
      nor_url = 'https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2025/',
      registration_url = 'https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2025/',
      schedule_notes = 'RSYC Optimist Knockout Race 2025 (Gold Fleet) (30–31 August 2025) at RSYC. Knockout series format: Qualifying Rounds, Repechage Round, Final Rounds, and Petite Final Rounds. 72 competitors.',
      status = 'published',
      updated_at = now()
    WHERE id = v_regatta_gold_id;
  ELSE
    v_regatta_gold_id := gen_random_uuid();
    INSERT INTO public.regattas (
      id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, is_selection_trial, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
    ) VALUES (
      v_regatta_gold_id,
      v_event_id,
      'RSYC Optimist Knockout Race 2025 (Gold Fleet)',
      'rsyc-optimist-gold-fleet-knockout-championship-2025',
      '2025-08-30',
      '2025-08-31',
      'Optimist',
      'Gold',
      72,
      8,
      'SG',
      true,
      false,
      'Republic of Singapore Yacht Club, 52 West Coast Ferry Road, Singapore 126887',
      'Republic of Singapore Yacht Club',
      'https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2025/',
      'https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2025/',
      'RSYC Optimist Knockout Race 2025 (Gold Fleet) (30–31 August 2025) at RSYC. Knockout series format: Qualifying Rounds, Repechage Round, Final Rounds, and Petite Final Rounds. 72 competitors.',
      'published',
      now(),
      now()
    );
  END IF;

  DELETE FROM public.regatta_results WHERE regatta_id = v_regatta_gold_id;

  -- Gold #1: Lucas Cao Zhihong (Rank: 1)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Lucas Cao Zhihong')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Lucas Cao Zhihong')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Lucas Cao Zhihong', 'lucas-cao-zhihong-7fb16b', '149', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 1, 1.0, 1.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #2: Ethan Low Zhi Ren (Rank: 2)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Ethan Low Zhi Ren')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Ethan Low Zhi Ren')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Ethan Low Zhi Ren', 'ethan-low-zhi-ren-37b409', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 2, 2.0, 2.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #3: Ashlea Tham (Rank: 3)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Ashlea Tham')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Ashlea Tham')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Ashlea Tham', 'ashlea-tham-5d97a5', '175', 'Raffles Marina', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 3, 3.0, 3.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #4: Ethan Lee (Rank: 4)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Ethan Lee')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Ethan Lee')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Ethan Lee', 'ethan-lee-d4905a', '83', 'PAssion Wave', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 4, 4.0, 4.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #5: Lyric Li Yuxuan (Rank: 5)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Lyric Li Yuxuan')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Lyric Li Yuxuan')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Lyric Li Yuxuan', 'lyric-li-yuxuan-9e6634', 'TBD', 'Changi Sailing Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 5, 5.0, 5.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #6: Alyssa Wong Li Lin (Rank: 6)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Alyssa Wong Li Lin')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Alyssa Wong Li Lin')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Alyssa Wong Li Lin', 'alyssa-wong-li-lin-46b965', '150', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 6, 6.0, 6.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #7: Ashlyn Tham (Rank: 7)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Ashlyn Tham')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Ashlyn Tham')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Ashlyn Tham', 'ashlyn-tham-e029eb', '100', 'Raffles Marina', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 7, 7.0, 7.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #8: Wai Zhi Tong (Rank: 8)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Wai Zhi Tong')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Wai Zhi Tong')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Wai Zhi Tong', 'wai-zhi-tong-4d34b2', '157', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 8, 8.0, 8.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #9: Elijah Ong (Rank: 9)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Elijah Ong')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Elijah Ong')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Elijah Ong', 'elijah-ong-7b65be', '140', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 9, 9.0, 9.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #10: Darian Huang (Rank: 10)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Darian Huang')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Darian Huang')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Darian Huang', 'darian-huang-b06c01', '131', 'PAssion Wave', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 10, 10.0, 10.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #11: Pee Teck Woon (Rank: 11)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Pee Teck Woon')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Pee Teck Woon')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Pee Teck Woon', 'pee-teck-woon-6f6ec7', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 11, 11.0, 11.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #12: Anya Zahedi (Rank: 12)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Anya Zahedi')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Anya Zahedi')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Anya Zahedi', 'anya-zahedi-07f2ff', '159', 'PAssion Wave', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 12, 12.0, 12.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #13: Jairus Teo Xin Jie (Rank: 13)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Jairus Teo Xin Jie')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Jairus Teo Xin Jie')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Jairus Teo Xin Jie', 'jairus-teo-xin-jie-22d49a', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 13, 13.0, 13.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #14: Nathaniel Kaiden Ng (Rank: 14)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Nathaniel Kaiden Ng')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Nathaniel Kaiden Ng')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Nathaniel Kaiden Ng', 'nathaniel-kaiden-ng-1232ad', '3344', 'PAssion Wave', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 14, 14.0, 14.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #15: Jedd Lam Zhi Hao (Rank: 15)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Jedd Lam Zhi Hao')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Jedd Lam Zhi Hao')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Jedd Lam Zhi Hao', 'jedd-lam-zhi-hao-a10345', '2000', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 15, 15.0, 15.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #16: Luke Loh Yi Jie (Rank: 16)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Luke Loh Yi Jie')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Luke Loh Yi Jie')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Luke Loh Yi Jie', 'luke-loh-yi-jie-1f5bbc', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 16, 16.0, 16.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #17: Elliot Goh (Rank: 17)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Elliot Goh')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Elliot Goh')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Elliot Goh', 'elliot-goh-385af3', '3103', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 17, 17.0, 17.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #18: Julien Christian Petracco (Rank: 18)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Julien Christian Petracco')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Julien Christian Petracco')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Julien Christian Petracco', 'julien-christian-petracco-900fe6', '3102', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 18, 18.0, 18.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #19: Kevin Ho Jun Yi (Rank: 19)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Kevin Ho Jun Yi')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Kevin Ho Jun Yi')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Kevin Ho Jun Yi', 'kevin-ho-jun-yi-3360a6', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 19, 19.0, 19.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #20: Joash Kok Jit Yin (Rank: 20)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Joash Kok Jit Yin')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Joash Kok Jit Yin')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Joash Kok Jit Yin', 'joash-kok-jit-yin-5f1bcd', '3057', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 20, 20.0, 20.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #21: Edrei Ong (Rank: 21)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Edrei Ong')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Edrei Ong')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Edrei Ong', 'edrei-ong-5571cc', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 21, 21.0, 21.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #22: Rahul Rajakanth (Rank: 22)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Rahul Rajakanth')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Rahul Rajakanth')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Rahul Rajakanth', 'rahul-rajakanth-01133a', '2006', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 22, 22.0, 22.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #23: Olivia Cheong (Rank: 23)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Olivia Cheong')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Olivia Cheong')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Olivia Cheong', 'olivia-cheong-2bd4d6', 'TBD', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 23, 23.0, 23.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #24: Damien Huang (Rank: 24)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Damien Huang')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Damien Huang')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Damien Huang', 'damien-huang-7dd343', '3300', 'PAssion Wave', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 24, 24.0, 24.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #25: Joel Ong Han Sheng (Rank: 25)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Joel Ong Han Sheng')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Joel Ong Han Sheng')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Joel Ong Han Sheng', 'joel-ong-han-sheng-e42c1f', 'TBD', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 25, 25.0, 25.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #26: Kaelyn Dayna Soh Zhi Yi (Rank: 26)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Kaelyn Dayna Soh Zhi Yi')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Kaelyn Dayna Soh Zhi Yi')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Kaelyn Dayna Soh Zhi Yi', 'kaelyn-dayna-soh-zhi-yi-42dbac', '3113', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 26, 26.0, 26.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #27: Chen Wangsun (Rank: 27)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Chen Wangsun')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Chen Wangsun')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Chen Wangsun', 'chen-wangsun-e8f44d', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 27, 27.0, 27.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #28: Lim Rui Kai, Lucas (Rank: 28)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Lim Rui Kai, Lucas') OR lower(trim(name)) = lower('Lim Rui Kai Lucas') OR lower(trim(name)) = lower('Lucas Lim Rui Kai')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Lim Rui Kai, Lucas'), lower('Lim Rui Kai Lucas'), lower('Lucas Lim Rui Kai')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Lim Rui Kai, Lucas', 'lim-rui-kai-lucas-459ccc', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Lim Rui Kai Lucas') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Lucas Lim Rui Kai') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 28, 28.0, 28.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #29: Jaye Low Xi En (Rank: 29)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Jaye Low Xi En')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Jaye Low Xi En')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Jaye Low Xi En', 'jaye-low-xi-en-63ead1', 'TBD', 'PAssion Wave', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 29, 29.0, 29.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #30: Padmaeja Rajakanth (Rank: 30)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Padmaeja Rajakanth')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Padmaeja Rajakanth')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Padmaeja Rajakanth', 'padmaeja-rajakanth-82874f', '2022', 'Constant Wind', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 30, 30.0, 30.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #31: Teo Rui Ling (Rank: 31)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Teo Rui Ling')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Teo Rui Ling')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Teo Rui Ling', 'teo-rui-ling-a1209a', '3820', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 31, 31.0, 31.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #32: Poh Hao Xuan Euan (Rank: 32)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Poh Hao Xuan Euan')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Poh Hao Xuan Euan')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Poh Hao Xuan Euan', 'poh-hao-xuan-euan-ae12b0', '2030', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 32, 32.0, 32.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #33: Kyle Jeremy Soh Zhi Jun (Rank: 33)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Kyle Jeremy Soh Zhi Jun')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Kyle Jeremy Soh Zhi Jun')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Kyle Jeremy Soh Zhi Jun', 'kyle-jeremy-soh-zhi-jun-412f39', '3183', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 33, 33.0, 33.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #34: Ng Kai Zhe Timothy (Rank: 34)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Ng Kai Zhe Timothy')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Ng Kai Zhe Timothy')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Ng Kai Zhe Timothy', 'ng-kai-zhe-timothy-e7adb6', '2023', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 34, 34.0, 34.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #35: Charles Kong Shing Chak (Rank: 35)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Charles Kong Shing Chak')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Charles Kong Shing Chak')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Charles Kong Shing Chak', 'charles-kong-shing-chak-200b1c', 'TBD', 'Changi Sailing Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 35, 35.0, 35.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #36: Siti Ra'idah Binte Mohd Airudin (Rank: 36)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Siti Ra''idah Binte Mohd Airudin')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Siti Ra''idah Binte Mohd Airudin')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Siti Ra''idah Binte Mohd Airudin', 'siti-ra-idah-binte-mohd-airudin-606ea8', 'TBD', 'PAssion Wave', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 36, 36.0, 36.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #37: Tan Herng Yee (Rank: 37)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Tan Herng Yee')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Tan Herng Yee')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Tan Herng Yee', 'tan-herng-yee-14bdde', '3000', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 37, 37.0, 37.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #38: Tan En Ting, Kirsten (Rank: 38)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Tan En Ting, Kirsten') OR lower(trim(name)) = lower('Tan En Ting Kirsten') OR lower(trim(name)) = lower('Kirsten Tan En Ting')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Tan En Ting, Kirsten'), lower('Tan En Ting Kirsten'), lower('Kirsten Tan En Ting')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Tan En Ting, Kirsten', 'tan-en-ting-kirsten-e1a206', '3663', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Tan En Ting Kirsten') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Kirsten Tan En Ting') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 38, 38.0, 38.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #39: Jude Nathan Wong (Rank: 39)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Jude Nathan Wong')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Jude Nathan Wong')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Jude Nathan Wong', 'jude-nathan-wong-f35490', '3495', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 39, 39.0, 39.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #40: LEE Gentaro Noah (Rank: 40)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('LEE Gentaro Noah')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('LEE Gentaro Noah')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'LEE Gentaro Noah', 'lee-gentaro-noah-910bbc', 'TBD', 'PAssion Wave', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 40, 40.0, 40.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #41: Nicole Wong Jing Chen (Rank: 41)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Nicole Wong Jing Chen')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Nicole Wong Jing Chen')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Nicole Wong Jing Chen', 'nicole-wong-jing-chen-6e8a50', 'TBD', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 41, 41.0, 41.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #42: Chiang Zhiyi Aaron (Rank: 42)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Chiang Zhiyi Aaron')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Chiang Zhiyi Aaron')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Chiang Zhiyi Aaron', 'chiang-zhiyi-aaron-eb4250', '3128', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 42, 42.0, 42.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #43: Dylan Goh Yue Teng (Rank: 43)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Dylan Goh Yue Teng')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Dylan Goh Yue Teng')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Dylan Goh Yue Teng', 'dylan-goh-yue-teng-45b981', '3800', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 43, 43.0, 43.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #44: Shin Lin Chen Rui (Rank: 44)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Shin Lin Chen Rui')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Shin Lin Chen Rui')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Shin Lin Chen Rui', 'shin-lin-chen-rui-83125d', '3333', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 44, 44.0, 44.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #45: Yeh Fang Yu Sage (Rank: 45)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Yeh Fang Yu Sage')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Yeh Fang Yu Sage')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Yeh Fang Yu Sage', 'yeh-fang-yu-sage-89dd4a', 'TBD', 'Changi Sailing Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 45, 45.0, 45.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #46: Jared Liew Soon Kit (Rank: 46)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Jared Liew Soon Kit')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Jared Liew Soon Kit')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Jared Liew Soon Kit', 'jared-liew-soon-kit-6dc3b5', 'TBD', 'PAssion Wave', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 46, 46.0, 46.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #47: Lim Yuk Pin (Rank: 47)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Lim Yuk Pin')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Lim Yuk Pin')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Lim Yuk Pin', 'lim-yuk-pin-862857', '3880', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 47, 47.0, 47.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #48: Jeremiah Ong Rui Feng (Rank: 48)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Jeremiah Ong Rui Feng')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Jeremiah Ong Rui Feng')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Jeremiah Ong Rui Feng', 'jeremiah-ong-rui-feng-cbfef4', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 48, 48.0, 48.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #49: Meera Srihari (Rank: 49)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Meera Srihari')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Meera Srihari')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Meera Srihari', 'meera-srihari-46f511', '3889', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 49, 49.0, 49.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #50: Gloria Kwok Yen Rui (Rank: 50)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Gloria Kwok Yen Rui')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Gloria Kwok Yen Rui')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Gloria Kwok Yen Rui', 'gloria-kwok-yen-rui-abbef8', '2004', 'Constant Wind', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 50, 50.0, 50.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #51: Matthew Chiam Qin Hao (Rank: 51)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Matthew Chiam Qin Hao')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Matthew Chiam Qin Hao')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Matthew Chiam Qin Hao', 'matthew-chiam-qin-hao-6627d5', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 51, 51.0, 51.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #52: Quintan Rupert Low (Rank: 52)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Quintan Rupert Low')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Quintan Rupert Low')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Quintan Rupert Low', 'quintan-rupert-low-eef6a9', '4681', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 52, 52.0, 52.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #53: Chow Yi Min, Yvette (Rank: 53)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Chow Yi Min, Yvette') OR lower(trim(name)) = lower('Chow Yi Min Yvette') OR lower(trim(name)) = lower('Yvette Chow Yi Min')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Chow Yi Min, Yvette'), lower('Chow Yi Min Yvette'), lower('Yvette Chow Yi Min')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Chow Yi Min, Yvette', 'chow-yi-min-yvette-1c31c6', '3151', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Chow Yi Min Yvette') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Yvette Chow Yi Min') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 53, 53.0, 53.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #54: Dan Toh Guan You (Rank: 54)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Dan Toh Guan You')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Dan Toh Guan You')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Dan Toh Guan You', 'dan-toh-guan-you-50ee63', '43', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 54, 54.0, 54.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #55: Kyan Tan Chun Hong (Rank: 55)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Kyan Tan Chun Hong')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Kyan Tan Chun Hong')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Kyan Tan Chun Hong', 'kyan-tan-chun-hong-03f80e', '58', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 55, 55.0, 55.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #56: Cyrus Chiam (Rank: 56)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Cyrus Chiam')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Cyrus Chiam')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Cyrus Chiam', 'cyrus-chiam-985656', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 56, 56.0, 56.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #57: Joel Khoo Zhuo Le (Rank: 57)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Joel Khoo Zhuo Le')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Joel Khoo Zhuo Le')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Joel Khoo Zhuo Le', 'joel-khoo-zhuo-le-650428', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 57, 57.0, 57.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #58: Fong Luke Tin (Rank: 58)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Fong Luke Tin')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Fong Luke Tin')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Fong Luke Tin', 'fong-luke-tin-5b0770', 'TBD', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 58, 58.0, 58.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #59: Huang Tianyi (Rank: 59)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Huang Tianyi')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Huang Tianyi')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Huang Tianyi', 'huang-tianyi-d985a7', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 59, 59.0, 59.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #60: Ethan Tan Jing Zhou (Rank: 60)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Ethan Tan Jing Zhou')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Ethan Tan Jing Zhou')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Ethan Tan Jing Zhou', 'ethan-tan-jing-zhou-b97103', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 60, 60.0, 60.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #61: Joshua Khoo (Rank: 61)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Joshua Khoo')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Joshua Khoo')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Joshua Khoo', 'joshua-khoo-00727a', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 61, 61.0, 61.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #62: Charlene Yong Heng Ning (Rank: 62)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Charlene Yong Heng Ning')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Charlene Yong Heng Ning')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Charlene Yong Heng Ning', 'charlene-yong-heng-ning-cac0b5', '766', 'Changi Sailing Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 62, 62.0, 62.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #63: Rachel Lim Qian Hui (Rank: 63)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Rachel Lim Qian Hui')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Rachel Lim Qian Hui')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Rachel Lim Qian Hui', 'rachel-lim-qian-hui-04fa60', '3197', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 63, 63.0, 63.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #64: Irwin Yit Kei Fung (Rank: 64)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Irwin Yit Kei Fung')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Irwin Yit Kei Fung')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Irwin Yit Kei Fung', 'irwin-yit-kei-fung-5c6f5b', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 64, 64.0, 64.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #65: Lim Rui Xuan, Lavene (Rank: 65)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Lim Rui Xuan, Lavene') OR lower(trim(name)) = lower('Lim Rui Xuan Lavene') OR lower(trim(name)) = lower('Lavene Lim Rui Xuan')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Lim Rui Xuan, Lavene'), lower('Lim Rui Xuan Lavene'), lower('Lavene Lim Rui Xuan')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Lim Rui Xuan, Lavene', 'lim-rui-xuan-lavene-adc06b', 'TBD', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Lim Rui Xuan Lavene') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Lavene Lim Rui Xuan') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 65, 65.0, 65.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- Gold #66: Hagen Goh (Rank: 66)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Hagen Goh')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Hagen Goh')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Hagen Goh', 'hagen-goh-9d8ade', '3600', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 66, 66.0, 66.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #67: Zachary Low (Rank: 67)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Zachary Low')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Zachary Low')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Zachary Low', 'zachary-low-15daea', '38', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 67, 67.0, 67.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #68: Denzel Seah (Rank: 68)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Denzel Seah')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Denzel Seah')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Denzel Seah', 'denzel-seah-7f5fe9', '3925', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 68, 68.0, 68.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #69: Xavier Puah Yang Zheng (Rank: 69)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Xavier Puah Yang Zheng')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Xavier Puah Yang Zheng')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Xavier Puah Yang Zheng', 'xavier-puah-yang-zheng-3a3fa1', '2037', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 69, 69.0, 69.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #70: Aidan Armand Anuar (Rank: 70)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Aidan Armand Anuar')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Aidan Armand Anuar')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Aidan Armand Anuar', 'aidan-armand-anuar-ea848d', '3143', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 70, 70.0, 70.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #71: Jamiroquai Tay Kai Nuo (Rank: 71)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Jamiroquai Tay Kai Nuo')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Jamiroquai Tay Kai Nuo')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Jamiroquai Tay Kai Nuo', 'jamiroquai-tay-kai-nuo-5a2440', 'TBD', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 71, 71.0, 71.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- Gold #72: Estelle Yeo (Rank: 72)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) = lower('Estelle Yeo')
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Estelle Yeo')))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Estelle Yeo', 'estelle-yeo-35fda9', '62', 'Changi Sailing Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_gold_id, v_sailor_id, 72, 72.0, 72.0, false, 'F', 'SGP', 'verified', now(), now(), now());

END $$;