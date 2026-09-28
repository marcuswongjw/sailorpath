-- 078_add_rsyc_2026_knockout_results.sql
-- Import official results for RSYC Optimist Silver Fleet Knockout Championship 2026
-- Dates: 26–27 September 2026
-- Venue: Republic of Singapore Yacht Club, 52 West Coast Ferry Road, Singapore 126887
-- Organiser: Republic of Singapore Yacht Club (RSYC)
-- Fleet: Optimist Silver Fleet (53 competitors across 11 knockout final rank brackets)

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
      total_fleet_size = 53,
      race_count = 8,
      geography = 'SG',
      counts_for_ranking = true,
      is_selection_trial = false,
      venue = 'Republic of Singapore Yacht Club, 52 West Coast Ferry Road, Singapore 126887',
      organizer = 'Republic of Singapore Yacht Club',
      nor_url = 'https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2026/',
      registration_url = 'https://tinyurl.com/RSYCSilverFleetOKC2026',
      schedule_notes = 'RSYC Optimist Silver Fleet Knockout Championship 2026 (26–27 September 2026) at RSYC. Knockout series format: Qualifying Rounds, Repechage Round, Final Rounds, and Petite Final Rounds. 53 competitors.',
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
      53,
      8,
      'SG',
      true,
      false,
      'Republic of Singapore Yacht Club, 52 West Coast Ferry Road, Singapore 126887',
      'Republic of Singapore Yacht Club',
      'https://rsyc.org.sg/rsyc-regatta/rsyc-optimist-silver-fleet-knockout-championship-2026/',
      'https://tinyurl.com/RSYCSilverFleetOKC2026',
      'RSYC Optimist Silver Fleet Knockout Championship 2026 (26–27 September 2026) at RSYC. Knockout series format: Qualifying Rounds, Repechage Round, Final Rounds, and Petite Final Rounds. 53 competitors.',
      'published',
      now(),
      now()
    );
  END IF;

  -- 3. Clear existing results for this regatta
  DELETE FROM public.regatta_results WHERE regatta_id = v_regatta_id;

  -- 4. Insert / Match Sailors and Add Results (53 competitors)

  -- #1: Jade Tan (Final Rank: 1)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Jade Tan'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Jade Tan')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Jade Tan', 'jade-tan-d76aa3', '3555', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 1, 1.0, 1.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- #2: Wai Yong Le (Final Rank: 1)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Wai Yong Le'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Wai Yong Le')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Wai Yong Le', 'wai-yong-le-e8c7b6', '3488', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 1, 1.0, 1.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #3: Wu Jiaqian (Final Rank: 1)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Wu Jiaqian'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Wu Jiaqian')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Wu Jiaqian', 'wu-jiaqian-242070', '3424', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 1, 1.0, 1.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #4: Axel Lin (Final Rank: 1)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Axel Lin'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Axel Lin')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Axel Lin', 'axel-lin-c1bdce', '720', 'Changi Sailing Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 1, 1.0, 1.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #5: Kiyansh Kanishk Singh (Final Rank: 1)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Kiyansh Kanishk Singh'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Kiyansh Kanishk Singh')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Kiyansh Kanishk Singh', 'kiyansh-kanishk-singh-f57c0e', '2046', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 1, 1.0, 1.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #6: Hongren Wang (Final Rank: 6)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Hongren Wang'), lower('Wang Hongren'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Hongren Wang'), lower('Wang Hongren')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Hongren Wang', 'hongren-wang-4787c5', '2039', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Wang Hongren') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 6, 6.0, 6.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #7: Han Moyan (Final Rank: 6)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Han Moyan'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Han Moyan')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Han Moyan', 'han-moyan-a83045', '2042', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 6, 6.0, 6.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #8: Damien Seah (Final Rank: 6)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Damien Seah'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Damien Seah')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Damien Seah', 'damien-seah-fd4694', '3825', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 6, 6.0, 6.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #9: Jerome Puah Yang Yi (Final Rank: 6)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Jerome Puah Yang Yi'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Jerome Puah Yang Yi')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Jerome Puah Yang Yi', 'jerome-puah-yang-yi-698098', '2037', 'PAssion Wave', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 6, 6.0, 6.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #10: Zheng Ryan Feiran (Final Rank: 6)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Zheng Ryan Feiran'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Zheng Ryan Feiran')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Zheng Ryan Feiran', 'zheng-ryan-feiran-8b44f7', '2045', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 6, 6.0, 6.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #11: Ezra Mak Yi Yang (Final Rank: 11)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Ezra Mak Yi Yang'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Ezra Mak Yi Yang')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Ezra Mak Yi Yang', 'ezra-mak-yi-yang-ffff5a', '3535', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 11, 11.0, 11.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #12: Skyler Kang (Final Rank: 11)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Skyler Kang'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Skyler Kang')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Skyler Kang', 'skyler-kang-895cd7', '2041', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 11, 11.0, 11.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #13: Du Jiayi (Final Rank: 11)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Du Jiayi'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Du Jiayi')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Du Jiayi', 'du-jiayi-6b9010', '3141', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 11, 11.0, 11.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #14: Chiang Ziyi Adele (Final Rank: 11)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Chiang Ziyi Adele'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Chiang Ziyi Adele')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Chiang Ziyi Adele', 'chiang-ziyi-adele-fd9870', '3120', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 11, 11.0, 11.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- #15: Thaddaeus Renz (Final Rank: 11)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Thaddaeus Renz'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Thaddaeus Renz')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Thaddaeus Renz', 'thaddaeus-renz-a67942', '2058', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 11, 11.0, 11.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #16: Muhammad Rehan Bin Mohamed Salim (Final Rank: 16)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Muhammad Rehan Bin Mohamed Salim'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Muhammad Rehan Bin Mohamed Salim')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Muhammad Rehan Bin Mohamed Salim', 'muhammad-rehan-bin-mohamed-salim-49b407', '2059', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 16, 16.0, 16.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #17: Lim Xin Chen Sven (Final Rank: 16)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Lim Xin Chen Sven'), lower('Sven Lim'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Lim Xin Chen Sven'), lower('Sven Lim')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Lim Xin Chen Sven', 'lim-xin-chen-sven-f61e24', '3893', 'Changi Sailing Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Sven Lim') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 16, 16.0, 16.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #18: Llewellyn Ding Zhe Tay (Final Rank: 16)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Llewellyn Ding Zhe Tay'), lower('Llewellyn Tay Ding Zhe'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Llewellyn Ding Zhe Tay'), lower('Llewellyn Tay Ding Zhe')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Llewellyn Ding Zhe Tay', 'llewellyn-ding-zhe-tay-c040b2', '3013', 'Changi Sailing Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Llewellyn Tay Ding Zhe') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 16, 16.0, 16.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #19: Jae Toh (Final Rank: 16)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Jae Toh'), lower('Jae Toh Guan Yu'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Jae Toh'), lower('Jae Toh Guan Yu')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Jae Toh', 'jae-toh-265e5a', '3311', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Jae Toh Guan Yu') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 16, 16.0, 16.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #20: Andrea Kwan (Final Rank: 16)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Andrea Kwan'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Andrea Kwan')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Andrea Kwan', 'andrea-kwan-e9b6c6', '3745', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 16, 16.0, 16.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- #21: Seraphina Kang (Final Rank: 21)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Seraphina Kang'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Seraphina Kang')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Seraphina Kang', 'seraphina-kang-d62f0f', '2040', 'Constant Wind', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 21, 21.0, 21.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- #22: Jacob Jit Yeung Kok (Final Rank: 21)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Jacob Jit Yeung Kok'), lower('Jacob Kok Jit Yeung'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Jacob Jit Yeung Kok'), lower('Jacob Kok Jit Yeung')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Jacob Jit Yeung Kok', 'jacob-jit-yeung-kok-024414', '3087', 'Changi Sailing Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Jacob Kok Jit Yeung') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 21, 21.0, 21.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #23: Henry Shayan Mittelhauser (Final Rank: 21)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Henry Shayan Mittelhauser'), lower('Mittelhauser, Henry Shayan'), lower('Mittelhauser Henry Shayan'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Henry Shayan Mittelhauser'), lower('Mittelhauser, Henry Shayan'), lower('Mittelhauser Henry Shayan')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Henry Shayan Mittelhauser', 'henry-shayan-mittelhauser-d8a1e5', '3060', 'Changi Sailing Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Mittelhauser, Henry Shayan') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Mittelhauser Henry Shayan') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 21, 21.0, 21.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #24: Yuki Youqi Wang (Final Rank: 21)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Yuki Youqi Wang'), lower('Wang Youqi Yuki'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Yuki Youqi Wang'), lower('Wang Youqi Yuki')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Yuki Youqi Wang', 'yuki-youqi-wang-e7d3fa', '3523', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Wang Youqi Yuki') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 21, 21.0, 21.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- #25: Enzo Kengsin Teo (Final Rank: 21)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Enzo Kengsin Teo'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Enzo Kengsin Teo')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Enzo Kengsin Teo', 'enzo-kengsin-teo-21e1cd', '2044', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 21, 21.0, 21.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #26: Cyrus Gustafson (Final Rank: 26)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Cyrus Gustafson'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Cyrus Gustafson')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Cyrus Gustafson', 'cyrus-gustafson-c33707', '3342', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 26, 26.0, 26.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #27: Isaias Cheow (Final Rank: 26)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Isaias Cheow'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Isaias Cheow')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Isaias Cheow', 'isaias-cheow-f4d50c', '3307', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 26, 26.0, 26.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #28: Emil Lam (Final Rank: 26)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Emil Lam'), lower('Emil Lam Ze'), lower('Lam Ze Emil'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Emil Lam'), lower('Emil Lam Ze'), lower('Lam Ze Emil')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Emil Lam', 'emil-lam-455a14', '2049', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Emil Lam Ze') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Lam Ze Emil') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 26, 26.0, 26.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #29: Luca Yang Kexing (Final Rank: 26)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Luca Yang Kexing'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Luca Yang Kexing')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Luca Yang Kexing', 'luca-yang-kexing-a9e3e8', '707', 'Changi Sailing Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 26, 26.0, 26.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #30: Oliver Cheong Rui Heng (Final Rank: 26)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Oliver Cheong Rui Heng'), lower('Cheong Rui Heng, Oliver'), lower('Cheong Rui Heng Oliver'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Oliver Cheong Rui Heng'), lower('Cheong Rui Heng, Oliver'), lower('Cheong Rui Heng Oliver')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Oliver Cheong Rui Heng', 'oliver-cheong-rui-heng-fcefa2', '3474', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Cheong Rui Heng, Oliver') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Cheong Rui Heng Oliver') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 26, 26.0, 26.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #31: Li Yu'An (Final Rank: 31)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Li Yu''An'), lower('Li Yu An'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Li Yu''An'), lower('Li Yu An')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Li Yu''An', 'li-yu-an-676f02', '3433', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Li Yu An') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 31, 31.0, 31.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #32: Allison Li Xin Teh (Final Rank: 31)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Allison Li Xin Teh'), lower('Allison Teh Li Xin'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Allison Li Xin Teh'), lower('Allison Teh Li Xin')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Allison Li Xin Teh', 'allison-li-xin-teh-8d2a4b', '787', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Allison Teh Li Xin') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 31, 31.0, 31.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- #33: Goh Siak Yiak Ian (Final Rank: 31)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Goh Siak Yiak Ian'), lower('Goh Siak Yiak, Ian'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Goh Siak Yiak Ian'), lower('Goh Siak Yiak, Ian')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Goh Siak Yiak Ian', 'goh-siak-yiak-ian-fffa38', '3818', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Goh Siak Yiak, Ian') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 31, 31.0, 31.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #34: Ian Teng (Final Rank: 31)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Ian Teng'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Ian Teng')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Ian Teng', 'ian-teng-8771f5', '2038', 'PAssion Wave', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 31, 31.0, 31.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #35: Tobias Ng (Final Rank: 31)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Tobias Ng'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Tobias Ng')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Tobias Ng', 'tobias-ng-6d9d60', '3487', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 31, 31.0, 31.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #36: Foo Jun Zhe Laurence (Final Rank: 36)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Foo Jun Zhe Laurence'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Foo Jun Zhe Laurence')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Foo Jun Zhe Laurence', 'foo-jun-zhe-laurence-fde537', '3712', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 36, 36.0, 36.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #37: Du Xingyu (Final Rank: 36)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Du Xingyu'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Du Xingyu')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Du Xingyu', 'du-xingyu-a4bee9', '3142', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 36, 36.0, 36.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #38: Amelie Camille Pitsilis (Final Rank: 36)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Amelie Camille Pitsilis'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Amelie Camille Pitsilis')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Amelie Camille Pitsilis', 'amelie-camille-pitsilis-4bdecf', '702', 'Changi Sailing Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 36, 36.0, 36.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- #39: Adam Leow (Final Rank: 36)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Adam Leow'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Adam Leow')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Adam Leow', 'adam-leow-f6bb4a', '2063', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 36, 36.0, 36.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #40: Evan Yu (Final Rank: 36)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Evan Yu'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Evan Yu')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Evan Yu', 'evan-yu-bebfbb', '3426', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 36, 36.0, 36.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #41: Zachary Chew (Final Rank: 41)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Zachary Chew'), lower('Chew Liang Zheng Zachary'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Zachary Chew'), lower('Chew Liang Zheng Zachary')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Zachary Chew', 'zachary-chew-289b7e', '3448', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Chew Liang Zheng Zachary') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 41, 41.0, 41.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #42: Hannah Lee (Final Rank: 41)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Hannah Lee'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Hannah Lee')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Hannah Lee', 'hannah-lee-eaa127', '3449', 'Constant Wind', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 41, 41.0, 41.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- #43: Christopher Tan (Final Rank: 41)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Christopher Tan'), lower('Christopher Tan Kai'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Christopher Tan'), lower('Christopher Tan Kai')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Christopher Tan', 'christopher-tan-d4ef2f', '2057', 'PAssion Wave', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Christopher Tan Kai') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 41, 41.0, 41.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #44: Tan Kai Hui Hillary (Final Rank: 41)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Tan Kai Hui Hillary'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Tan Kai Hui Hillary')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Tan Kai Hui Hillary', 'tan-kai-hui-hillary-04881d', '777', 'SAF Yacht Club', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 41, 41.0, 41.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- #45: Efrem Mak Yi En (Final Rank: 41)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Efrem Mak Yi En'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Efrem Mak Yi En')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Efrem Mak Yi En', 'efrem-mak-yi-en-d9d4cf', '3222', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 41, 41.0, 41.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #46: Dylan Cheng (Final Rank: 46)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Dylan Cheng'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Dylan Cheng')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Dylan Cheng', 'dylan-cheng-e6db98', '2048', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 46, 46.0, 46.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #47: Hu An (Final Rank: 46)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Hu An'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Hu An')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Hu An', 'hu-an-1fa27c', '3450', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 46, 46.0, 46.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #48: Wu Youxun (Final Rank: 46)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Wu Youxun'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Wu Youxun')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Wu Youxun', 'wu-youxun-c4ac55', '3070', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 46, 46.0, 46.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #49: Deborah Goh (Final Rank: 46)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Deborah Goh'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Deborah Goh')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Deborah Goh', 'deborah-goh-f42921', '3440', 'Constant Wind', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 46, 46.0, 46.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- #50: Nadia Zahedi (Final Rank: 46)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Nadia Zahedi'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Nadia Zahedi')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Nadia Zahedi', 'nadia-zahedi-432aff', '4724', 'PAssion Wave', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 46, 46.0, 46.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- #51: Isaac Chong (Final Rank: 51)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Isaac Chong'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Isaac Chong')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Isaac Chong', 'isaac-chong-ab9422', '2064', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 51, 51.0, 51.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  -- #52: Charlotte Kanon Yap (Final Rank: 51)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Charlotte Kanon Yap'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Charlotte Kanon Yap')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Charlotte Kanon Yap', 'charlotte-kanon-yap-fc939f', '2065', 'Constant Wind', 'F', 'SGP', now(), now());
  END IF;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 51, 51.0, 51.0, false, 'F', 'SGP', 'verified', now(), now(), now());

  -- #53: Joel Lim Kang Le (Final Rank: 51)
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Joel Lim Kang Le'), lower('Joel Lim'))
     OR id IN (SELECT sailor_id FROM public.sailor_aliases WHERE lower(trim(alias_name)) IN (lower('Joel Lim Kang Le'), lower('Joel Lim')))
  LIMIT 1;

  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Joel Lim Kang Le', 'joel-lim-kang-le-655b59', '3451', 'Constant Wind', 'M', 'SGP', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Joel Lim') ON CONFLICT (alias_name) DO NOTHING;
  INSERT INTO public.regatta_results (id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_regatta_id, v_sailor_id, 51, 51.0, 51.0, false, 'M', 'SGP', 'verified', now(), now(), now());

  RAISE NOTICE 'Successfully imported RSYC Optimist Silver Fleet Knockout Championship 2026 results (53 competitors).';
END $$;
