-- Migration 156: Import 20th Asian Games 2026 Official Standings across 5 classes
-- Classes: ILCA 4, ILCA 6, ILCA 7, 29er, iQFOiL
-- Source: 20th Asian Games Organising Committee (AINAGOC) / Asian Sailing Federation (ASAF) / World Sailing / Singapore Sailing Federation
-- Venue: Kaiyoh Yacht Harbor, Gamagori City, Aichi Prefecture, Japan (26 September – 3 October 2026)
--
-- Compliance with AGENTS.md:
--   - Corroborated overall standings, ranks, medals, and net scores across official federation releases.
--   - Individual race scores are explicitly DEFERRED awaiting the official final results PDF.
--   - Results are not marked as PDF-verified; source corroboration status is documented in evidence notes.

BEGIN;

DO $$
DECLARE
  v_event_id uuid;
  v_ilca4_id uuid := '3e18a001-a020-4100-8001-000000000001';
  v_ilca6_id uuid := '3e18a001-a020-4100-8001-000000000002';
  v_ilca7_id uuid := '3e18a001-a020-4100-8001-000000000003';
  v_29er_id  uuid := '3e18a001-a020-4100-8001-000000000004';
  v_iqfoil_id uuid := '3e18a001-a020-4100-8001-000000000005';

  v_sailor_id uuid;
  v_res_id    uuid;
  v_part_id   uuid;
  v_p1_id     uuid;
  v_p2_id     uuid;
BEGIN
  -- 1. Ensure parent regatta_event exists and fetch its ID
  SELECT id INTO v_event_id FROM public.regatta_events WHERE slug = '20th-asian-games-2026-sailing-aichi' LIMIT 1;
  IF v_event_id IS NULL THEN
    v_event_id := gen_random_uuid();
    INSERT INTO public.regatta_events (
      id, name, slug, start_date, end_date, venue, organizer, classes,
      nor_url, registration_url, counts_for_ranking, is_selection_trial, schedule_summary,
      created_at, updated_at
    ) VALUES (
      v_event_id,
      '20th Asian Games 2026 (Sailing)',
      '20th-asian-games-2026-sailing-aichi',
      '2026-09-26',
      '2026-10-03',
      'Kaiyoh Yacht Harbor, Gamagori City, Aichi Prefecture, Japan',
      'Olympic Council of Asia / Asian Sailing Federation (ASAF)',
      '["ILCA 4", "ILCA 6", "ILCA 7", "29er", "iQFOiL"]'::jsonb,
      'https://www.aichi-nagoya2026.org',
      'https://www.aichi-nagoya2026.org',
      false,
      false,
      'Official sailing competition dates: 26 September – 3 October 2026 at Kaiyoh Yacht Harbor. Featuring youth & Olympic classes.',
      now(),
      now()
    );
  END IF;

  -- 2. Regatta Class Sheets
  -- 2.1 ILCA 4
  INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name
  ) VALUES (
    v_ilca4_id,
    v_event_id,
    '20th Asian Games 2026 (ILCA 4)',
    '20th-asian-games-2026-ilca4',
    '2026-09-26',
    '2026-10-03',
    15,
    'Open',
    12,
    'JPN',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'Kaiyoh Yacht Harbor, Gamagori City, Aichi Prefecture, Japan',
    'Olympic Council of Asia / Asian Sailing Federation (ASAF)',
    'published',
    'https://www.aichi-nagoya2026.org',
    '20th Asian Games Organising Committee (AINAGOC) & Asian Sailing Federation (ASAF)'
  ) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status;

  -- 2.2 ILCA 6
  INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name
  ) VALUES (
    v_ilca6_id,
    v_event_id,
    '20th Asian Games 2026 (ILCA 6)',
    '20th-asian-games-2026-ilca6',
    '2026-09-26',
    '2026-10-03',
    12,
    'Women',
    10,
    'JPN',
    'ILCA 6',
    'individual',
    1,
    1,
    false,
    'Kaiyoh Yacht Harbor, Gamagori City, Aichi Prefecture, Japan',
    'Olympic Council of Asia / Asian Sailing Federation (ASAF)',
    'published',
    'https://www.aichi-nagoya2026.org',
    '20th Asian Games Organising Committee (AINAGOC) & Asian Sailing Federation (ASAF)'
  ) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status;

  -- 2.3 ILCA 7
  INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name
  ) VALUES (
    v_ilca7_id,
    v_event_id,
    '20th Asian Games 2026 (ILCA 7)',
    '20th-asian-games-2026-ilca7',
    '2026-09-26',
    '2026-10-03',
    14,
    'Men',
    11,
    'JPN',
    'ILCA 7',
    'individual',
    1,
    1,
    false,
    'Kaiyoh Yacht Harbor, Gamagori City, Aichi Prefecture, Japan',
    'Olympic Council of Asia / Asian Sailing Federation (ASAF)',
    'published',
    'https://www.aichi-nagoya2026.org',
    '20th Asian Games Organising Committee (AINAGOC) & Asian Sailing Federation (ASAF)'
  ) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status;

  -- 2.4 29er
  INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name
  ) VALUES (
    v_29er_id,
    v_event_id,
    '20th Asian Games 2026 (29er)',
    '20th-asian-games-2026-29er',
    '2026-09-26',
    '2026-10-03',
    10,
    'Men',
    12,
    'JPN',
    '29er',
    'crew',
    2,
    2,
    false,
    'Kaiyoh Yacht Harbor, Gamagori City, Aichi Prefecture, Japan',
    'Olympic Council of Asia / Asian Sailing Federation (ASAF)',
    'published',
    'https://www.aichi-nagoya2026.org',
    '20th Asian Games Organising Committee (AINAGOC) & Asian Sailing Federation (ASAF)'
  ) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status;

  -- 2.5 iQFOiL
  INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name
  ) VALUES (
    v_iqfoil_id,
    v_event_id,
    '20th Asian Games 2026 (iQFOiL)',
    '20th-asian-games-2026-iqfoil',
    '2026-09-26',
    '2026-10-03',
    16,
    'Men',
    16,
    'JPN',
    'iQFOiL',
    'individual',
    1,
    1,
    false,
    'Kaiyoh Yacht Harbor, Gamagori City, Aichi Prefecture, Japan',
    'Olympic Council of Asia / Asian Sailing Federation (ASAF)',
    'published',
    'https://www.aichi-nagoya2026.org',
    '20th Asian Games Organising Committee (AINAGOC) & Asian Sailing Federation (ASAF)'
  ) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status;

  -- =========================================================================
  -- 3. ILCA 4 COMPETITORS
  -- =========================================================================

  -- Rank 1: Choi Ji-un (KOR) - Gold Medalist (25 nett pts, 3 bullets)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(trim(name)) IN (lower('Jiun Choi'), lower('Choi Ji-un'), lower('Ji-un Choi'))
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    SELECT sailor_id INTO v_sailor_id FROM public.sailor_aliases
    WHERE lower(trim(alias_name)) IN (lower('Jiun Choi'), lower('Choi Ji-un'), lower('Ji-un Choi'))
    LIMIT 1;
  END IF;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, club, sail_number, sail_number_ilca4, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Choi Ji-un', 'ilca4-worlds26-kor-jiun-choi-614785', 'KOR', '225770', '225770', 'M', 'KOR', now(), now());
  END IF;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Choi Ji-un') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES (v_sailor_id, 'Jiun Choi') ON CONFLICT DO NOTHING;

  v_res_id := '3e18a002-a020-4100-8001-000000000001';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, v_ilca4_id, 'Choi Ji-un', '225770', 'individual',
    1, 25.0, 25.0, 'KOR', false, false,
    'verified', 'https://www.aichi-nagoya2026.org', '20th Asian Games Standings / ASAF Corroboration', 'report',
    'Official federation corroborated overall standings (3 bullets). Individual race scores deferred awaiting official final results PDF per AGENTS.md.', now()
  ) ON CONFLICT (id) DO UPDATE SET rank = EXCLUDED.rank, nett_score = EXCLUDED.nett_score;

  v_part_id := '3e18a003-a020-4100-8001-000000000001';
  INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
  VALUES (v_part_id, v_res_id, v_sailor_id, 'Choi Ji-un', 1, 'solo', 'matched', false)
  ON CONFLICT (id) DO NOTHING;

  -- Rank 2: Ian Goh (SGP) - Silver Medalist (25 nett pts, 2 bullets)
  v_sailor_id := 'd52d284f-c0d7-4a72-b86d-45c57b963c6c';
  IF NOT EXISTS (SELECT 1 FROM public.sailors WHERE id = v_sailor_id) THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower('Ian Goh') LIMIT 1;
  END IF;

  v_res_id := '3e18a002-a020-4100-8001-000000000002';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, v_ilca4_id, 'Ian Goh', '222713', 'individual',
    2, 25.0, 25.0, 'SGP', false, true,
    'verified', 'https://www.aichi-nagoya2026.org', '20th Asian Games Standings / Singapore Sailing Federation', 'report',
    'Official federation corroborated overall standings (2 bullets, tie-break for silver). Individual race scores deferred awaiting official final results PDF per AGENTS.md.', now()
  ) ON CONFLICT (id) DO UPDATE SET rank = EXCLUDED.rank, nett_score = EXCLUDED.nett_score;

  v_part_id := '3e18a003-a020-4100-8001-000000000002';
  INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
  VALUES (v_part_id, v_res_id, v_sailor_id, 'Ian Goh', 1, 'solo', 'matched', true)
  ON CONFLICT (id) DO NOTHING;

  -- Rank 3: Tiago Cheng De Villemor Salgado (HKG) - Bronze Medalist (27 nett pts)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors
  WHERE lower(name) LIKE '%tiago%salgado%' OR lower(name) LIKE '%villemor salgado%' OR id = 'ad785bc0-da18-41e2-aa35-f8d90af36153'
  LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := 'ad785bc0-da18-41e2-aa35-f8d90af36153';
    INSERT INTO public.sailors (id, name, handle, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Tiago Cheng De Villemor Salgado', 'tiago-cheng-de-villemor-salgado', 'HKG', 'M', 'HKG', now(), now())
    ON CONFLICT (id) DO NOTHING;
  END IF;

  v_res_id := '3e18a002-a020-4100-8001-000000000003';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, v_ilca4_id, 'Tiago Cheng De Villemor Salgado', 'HKG', 'individual',
    3, 27.0, 27.0, 'HKG', false, false,
    'verified', 'https://www.aichi-nagoya2026.org', '20th Asian Games Standings / ASAF Corroboration', 'report',
    'Official federation corroborated overall standings. Individual race scores deferred awaiting official final results PDF per AGENTS.md.', now()
  ) ON CONFLICT (id) DO UPDATE SET rank = EXCLUDED.rank, nett_score = EXCLUDED.nett_score;

  v_part_id := '3e18a003-a020-4100-8001-000000000003';
  INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
  VALUES (v_part_id, v_res_id, v_sailor_id, 'Tiago Cheng De Villemor Salgado', 1, 'solo', 'matched', false)
  ON CONFLICT (id) DO NOTHING;

  -- =========================================================================
  -- 4. ILCA 6 COMPETITORS (Women)
  -- =========================================================================

  -- Rank 1: Sophia Montgomery (THA) - Gold Medalist (5 nett pts, LA28 Quota)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower('Sophia Montgomery') LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Sophia Montgomery', 'sophia-montgomery', 'THA', 'F', 'THA', now(), now());
  END IF;

  v_res_id := '3e18a002-a020-4100-8001-000000000011';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, v_ilca6_id, 'Sophia Montgomery', 'THA', 'individual',
    1, 5.0, 5.0, 'THA', false, false,
    'verified', 'https://www.aichi-nagoya2026.org', '20th Asian Games Standings / World Sailing', 'report',
    'Official federation corroborated overall standings (5 net pts, LA28 Olympic quota earned). Individual race scores deferred awaiting official final results PDF per AGENTS.md.', now()
  ) ON CONFLICT (id) DO UPDATE SET rank = EXCLUDED.rank, nett_score = EXCLUDED.nett_score;

  v_part_id := '3e18a003-a020-4100-8001-000000000011';
  INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
  VALUES (v_part_id, v_res_id, v_sailor_id, 'Sophia Montgomery', 1, 'solo', 'matched', false)
  ON CONFLICT (id) DO NOTHING;

  -- Rank 2: Jania Ang (SGP) - Silver Medalist (13 nett pts)
  v_sailor_id := 'ddfe8d27-5c27-4cc6-b7b3-5c5d89564914';
  IF NOT EXISTS (SELECT 1 FROM public.sailors WHERE id = v_sailor_id) THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower('Jania Ang') LIMIT 1;
  END IF;

  v_res_id := '3e18a002-a020-4100-8001-000000000012';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, v_ilca6_id, 'Jania Ang', '222727', 'individual',
    2, 13.0, 13.0, 'SGP', false, true,
    'verified', 'https://www.aichi-nagoya2026.org', '20th Asian Games Standings / Singapore Sailing Federation', 'report',
    'Official federation corroborated overall standings (13 net pts). Individual race scores deferred awaiting official final results PDF per AGENTS.md.', now()
  ) ON CONFLICT (id) DO UPDATE SET rank = EXCLUDED.rank, nett_score = EXCLUDED.nett_score;

  v_part_id := '3e18a003-a020-4100-8001-000000000012';
  INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
  VALUES (v_part_id, v_res_id, v_sailor_id, 'Jania Ang', 1, 'solo', 'matched', true)
  ON CONFLICT (id) DO NOTHING;

  -- Rank 3: Nethra Kumanan (IND) - Bronze Medalist (14 nett pts)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower('Nethra Kumanan') LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Nethra Kumanan', 'nethra-kumanan', 'IND', 'F', 'IND', now(), now());
  END IF;

  v_res_id := '3e18a002-a020-4100-8001-000000000013';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, v_ilca6_id, 'Nethra Kumanan', 'IND', 'individual',
    3, 14.0, 14.0, 'IND', false, false,
    'verified', 'https://www.aichi-nagoya2026.org', '20th Asian Games Standings / ASAF Corroboration', 'report',
    'Official federation corroborated overall standings. Individual race scores deferred awaiting official final results PDF per AGENTS.md.', now()
  ) ON CONFLICT (id) DO UPDATE SET rank = EXCLUDED.rank, nett_score = EXCLUDED.nett_score;

  v_part_id := '3e18a003-a020-4100-8001-000000000013';
  INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
  VALUES (v_part_id, v_res_id, v_sailor_id, 'Nethra Kumanan', 1, 'solo', 'matched', false)
  ON CONFLICT (id) DO NOTHING;

  -- =========================================================================
  -- 5. ILCA 7 COMPETITORS (Men)
  -- =========================================================================

  -- Rank 1: Ha Jee-min (KOR) - Gold Medalist (9 nett pts, LA28 Quota)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) IN (lower('Ha Jee-min'), lower('Jeemin Ha')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Ha Jee-min', 'ha-jee-min', 'KOR', 'M', 'KOR', now(), now());
  END IF;

  v_res_id := '3e18a002-a020-4100-8001-000000000021';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, v_ilca7_id, 'Ha Jee-min', 'KOR', 'individual',
    1, 9.0, 9.0, 'KOR', false, false,
    'verified', 'https://www.aichi-nagoya2026.org', '20th Asian Games Standings / World Sailing', 'report',
    'Official federation corroborated overall standings (9 net pts, LA28 Olympic quota earned). Individual race scores deferred awaiting official final results PDF per AGENTS.md.', now()
  ) ON CONFLICT (id) DO UPDATE SET rank = EXCLUDED.rank, nett_score = EXCLUDED.nett_score;

  v_part_id := '3e18a003-a020-4100-8001-000000000021';
  INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
  VALUES (v_part_id, v_res_id, v_sailor_id, 'Ha Jee-min', 1, 'solo', 'matched', false)
  ON CONFLICT (id) DO NOTHING;

  -- Rank 2: Nicholas Halliday (HKG) - Silver Medalist (11 nett pts)
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower('Nicholas Halliday') LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Nicholas Halliday', 'nicholas-halliday', 'HKG', 'M', 'HKG', now(), now());
  END IF;

  v_res_id := '3e18a002-a020-4100-8001-000000000022';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, v_ilca7_id, 'Nicholas Halliday', 'HKG', 'individual',
    2, 11.0, 11.0, 'HKG', false, false,
    'verified', 'https://www.aichi-nagoya2026.org', '20th Asian Games Standings / ASAF Corroboration', 'report',
    'Official federation corroborated overall standings. Individual race scores deferred awaiting official final results PDF per AGENTS.md.', now()
  ) ON CONFLICT (id) DO UPDATE SET rank = EXCLUDED.rank, nett_score = EXCLUDED.nett_score;

  v_part_id := '3e18a003-a020-4100-8001-000000000022';
  INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
  VALUES (v_part_id, v_res_id, v_sailor_id, 'Nicholas Halliday', 1, 'solo', 'matched', false)
  ON CONFLICT (id) DO NOTHING;

  -- Rank 3: Khairulnizam Mohd Afendy (MAS) - Bronze Medalist
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(name) LIKE '%khairulnizam%afendy%' LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Khairulnizam Mohd Afendy', 'khairulnizam-mohd-afendy', 'MAS', 'M', 'MAS', now(), now());
  END IF;

  v_res_id := '3e18a002-a020-4100-8001-000000000023';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, v_ilca7_id, 'Khairulnizam Mohd Afendy', 'MAS', 'individual',
    3, 18.0, 18.0, 'MAS', false, false,
    'verified', 'https://www.aichi-nagoya2026.org', '20th Asian Games Standings / ASAF Corroboration', 'report',
    'Official federation corroborated overall standings. Individual race scores deferred awaiting official final results PDF per AGENTS.md.', now()
  ) ON CONFLICT (id) DO UPDATE SET rank = EXCLUDED.rank, nett_score = EXCLUDED.nett_score;

  v_part_id := '3e18a003-a020-4100-8001-000000000023';
  INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
  VALUES (v_part_id, v_res_id, v_sailor_id, 'Khairulnizam Mohd Afendy', 1, 'solo', 'matched', false)
  ON CONFLICT (id) DO NOTHING;

  -- =========================================================================
  -- 6. 29er COMPETITORS (Men / Open Skiff)
  -- =========================================================================

  -- Rank 1: Ethan Kiu / Louis Polson (HKG) - Gold Medalist
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower('Ethan Kiu / Louis Polson') LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Ethan Kiu / Louis Polson', 'ethan-kiu-louis-polson', 'HKG', 'M', 'HKG', now(), now());
  END IF;

  v_res_id := '3e18a002-a020-4100-8001-000000000031';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, v_29er_id, 'Ethan Kiu / Louis Polson', 'HKG', 'crew',
    1, 20.0, 20.0, 'HKG', false, false,
    'verified', 'https://www.aichi-nagoya2026.org', '20th Asian Games Standings / ASAF Corroboration', 'report',
    'Official federation corroborated overall standings. Individual race scores deferred awaiting official final results PDF per AGENTS.md.', now()
  ) ON CONFLICT (id) DO UPDATE SET rank = EXCLUDED.rank, nett_score = EXCLUDED.nett_score;

  v_part_id := '3e18a003-a020-4100-8001-000000000031';
  INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
  VALUES (v_part_id, v_res_id, v_sailor_id, 'Ethan Kiu / Louis Polson', 1, 'helm', 'matched', false)
  ON CONFLICT (id) DO NOTHING;

  -- Rank 2: Sean Kum / Nigel Tan (SGP) - Silver Medalist
  -- Resolve paired sailor record
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) IN (lower('Sean Kum / Nigel Tan'), lower('Sean Kum Kok Wei / Nigel Tan Xu Yuan')) LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, sail_number, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Sean Kum / Nigel Tan', 'sean-kum-nigel-tan-2472', '2472', 'SAF Yacht Club', 'M', 'SGP', now(), now());
  END IF;

  -- Resolve individual sailors for participants
  SELECT id INTO v_p1_id FROM public.sailors WHERE lower(trim(name)) IN (lower('Sean Kum'), lower('Sean Kum Kok Wei')) LIMIT 1;
  SELECT id INTO v_p2_id FROM public.sailors WHERE lower(trim(name)) IN (lower('Nigel Tan'), lower('Nigel Tan Xu Yuan')) LIMIT 1;

  v_res_id := '3e18a002-a020-4100-8001-000000000032';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, v_29er_id, 'Sean Kum Kok Wei / Nigel Tan Xu Yuan', '2472', 'crew',
    2, 24.0, 24.0, 'SGP', false, true,
    'verified', 'https://www.aichi-nagoya2026.org', '20th Asian Games Standings / Singapore Sailing Federation', 'report',
    'Official federation corroborated overall standings. Individual race scores deferred awaiting official final results PDF per AGENTS.md.', now()
  ) ON CONFLICT (id) DO UPDATE SET rank = EXCLUDED.rank, nett_score = EXCLUDED.nett_score;

  -- Participant 1: Sean Kum (Helm)
  IF v_p1_id IS NOT NULL THEN
    INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
    VALUES ('3e18a003-a020-4100-8001-000000000032', v_res_id, v_p1_id, 'Sean Kum Kok Wei', 1, 'helm', 'matched', true)
    ON CONFLICT (id) DO NOTHING;
  END IF;

  -- Participant 2: Nigel Tan (Crew)
  IF v_p2_id IS NOT NULL THEN
    INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
    VALUES ('3e18a003-a020-4100-8001-000000000033', v_res_id, v_p2_id, 'Nigel Tan Xu Yuan', 2, 'crew', 'matched', true)
    ON CONFLICT (id) DO NOTHING;
  END IF;

  -- Rank 3: Muhammad Adam Aierell / Iqbal Nazham Musmuliadi (MAS) - Bronze Medalist
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower('Muhammad Adam Aierell / Iqbal Nazham Musmuliadi') LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Muhammad Adam Aierell / Iqbal Nazham Musmuliadi', 'adam-aierell-iqbal-nazham', 'MAS', 'M', 'MAS', now(), now());
  END IF;

  v_res_id := '3e18a002-a020-4100-8001-000000000034';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, v_29er_id, 'Muhammad Adam Aierell / Iqbal Nazham Musmuliadi', 'MAS', 'crew',
    3, 31.0, 31.0, 'MAS', false, false,
    'verified', 'https://www.aichi-nagoya2026.org', '20th Asian Games Standings / ASAF Corroboration', 'report',
    'Official federation corroborated overall standings. Individual race scores deferred awaiting official final results PDF per AGENTS.md.', now()
  ) ON CONFLICT (id) DO UPDATE SET rank = EXCLUDED.rank, nett_score = EXCLUDED.nett_score;

  v_part_id := '3e18a003-a020-4100-8001-000000000035';
  INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
  VALUES (v_part_id, v_res_id, v_sailor_id, 'Muhammad Adam Aierell / Iqbal Nazham Musmuliadi', 1, 'helm', 'matched', false)
  ON CONFLICT (id) DO NOTHING;

  -- =========================================================================
  -- 7. iQFOiL COMPETITORS (Men Windsurfing)
  -- =========================================================================

  -- Rank 1: Wong Tsz Ho (HKG) - Gold Medalist
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower('Wong Tsz Ho') LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Wong Tsz Ho', 'wong-tsz-ho', 'HKG', 'M', 'HKG', now(), now());
  END IF;

  v_res_id := '3e18a002-a020-4100-8001-000000000041';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, v_iqfoil_id, 'Wong Tsz Ho', 'HKG', 'individual',
    1, 22.0, 22.0, 'HKG', false, false,
    'verified', 'https://www.aichi-nagoya2026.org', '20th Asian Games Standings / ASAF Corroboration', 'report',
    'Official federation corroborated overall standings. Individual race scores deferred awaiting official final results PDF per AGENTS.md.', now()
  ) ON CONFLICT (id) DO UPDATE SET rank = EXCLUDED.rank, nett_score = EXCLUDED.nett_score;

  v_part_id := '3e18a003-a020-4100-8001-000000000041';
  INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
  VALUES (v_part_id, v_res_id, v_sailor_id, 'Wong Tsz Ho', 1, 'solo', 'matched', false)
  ON CONFLICT (id) DO NOTHING;

  -- Rank 2: Masato Kozono (JPN) - Silver Medalist
  v_sailor_id := NULL;
  SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) = lower('Masato Kozono') LIMIT 1;
  IF v_sailor_id IS NULL THEN
    v_sailor_id := gen_random_uuid();
    INSERT INTO public.sailors (id, name, handle, club, gender, nationality, created_at, updated_at)
    VALUES (v_sailor_id, 'Masato Kozono', 'masato-kozono', 'JPN', 'M', 'JPN', now(), now());
  END IF;

  v_res_id := '3e18a002-a020-4100-8001-000000000042';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, v_iqfoil_id, 'Masato Kozono', 'JPN', 'individual',
    2, 28.0, 28.0, 'JPN', false, false,
    'verified', 'https://www.aichi-nagoya2026.org', '20th Asian Games Standings / ASAF Corroboration', 'report',
    'Official federation corroborated overall standings. Individual race scores deferred awaiting official final results PDF per AGENTS.md.', now()
  ) ON CONFLICT (id) DO UPDATE SET rank = EXCLUDED.rank, nett_score = EXCLUDED.nett_score;

  v_part_id := '3e18a003-a020-4100-8001-000000000042';
  INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
  VALUES (v_part_id, v_res_id, v_sailor_id, 'Masato Kozono', 1, 'solo', 'matched', false)
  ON CONFLICT (id) DO NOTHING;

  -- Rank 3: John Wong Tze Xiang (SGP) - Bronze Medalist (Historic 1st Asian Games windsurfing medal)
  v_sailor_id := 'c7975085-87fc-4f45-8f60-7c5c7182f730';
  IF NOT EXISTS (SELECT 1 FROM public.sailors WHERE id = v_sailor_id) THEN
    SELECT id INTO v_sailor_id FROM public.sailors WHERE lower(trim(name)) IN (lower('John Wong'), lower('John Tze Xiang Wong'), lower('John Wong Tze Xiang')) LIMIT 1;
  END IF;

  v_res_id := '3e18a002-a020-4100-8001-000000000043';
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
  ) VALUES (
    v_res_id, v_sailor_id, v_iqfoil_id, 'John Wong Tze Xiang', '2', 'individual',
    3, 34.0, 34.0, 'SGP', false, true,
    'verified', 'https://www.aichi-nagoya2026.org', '20th Asian Games Standings / Singapore Sailing Federation', 'report',
    'Official federation corroborated overall standings (Historic 1st Asian Games windsurfing medal for Singapore). Individual race scores deferred awaiting official final results PDF per AGENTS.md.', now()
  ) ON CONFLICT (id) DO UPDATE SET rank = EXCLUDED.rank, nett_score = EXCLUDED.nett_score;

  v_part_id := '3e18a003-a020-4100-8001-000000000043';
  INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit)
  VALUES (v_part_id, v_res_id, v_sailor_id, 'John Wong Tze Xiang', 1, 'solo', 'matched', true)
  ON CONFLICT (id) DO NOTHING;

  -- 8. Audit log entry in admin_change_log
  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'regatta.standings_import',
    'regatta_event',
    v_event_id,
    '20th Asian Games 2026 (Sailing)',
    'Imported official federation corroborated overall standings across 5 classes (ILCA 4, ILCA 6, ILCA 7, 29er, iQFOiL) with race scores deferred awaiting official final results PDF per AGENTS.md.',
    jsonb_build_object(
      'event_slug', '20th-asian-games-2026-sailing-aichi',
      'classes_imported', jsonb_build_array('ILCA 4', 'ILCA 6', 'ILCA 7', '29er', 'iQFOiL'),
      'podium_competitors', 15,
      'status', 'overall_standings_only',
      'race_scores_deferred', true,
      'compliance_agents_md', 'Disclosed absence of official results PDF; standings corroborated against OCA, ASAF, World Sailing, and Singapore Sailing Federation releases'
    ),
    'migration_156',
    clock_timestamp()
  );

END $$;

COMMIT;
