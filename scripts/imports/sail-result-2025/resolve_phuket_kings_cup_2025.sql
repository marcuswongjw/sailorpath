-- Phuket King's Cup 2025: Resolution of 9 held entries (Cluster 3C)
BEGIN;
DO $resolve$
DECLARE
  v_pkc_ilca6 uuid := '2cef00cb-a63b-5eca-b905-5c76cb43d130';
  v_pkc_ilca7 uuid := 'f2d53719-ece3-5162-92dd-87b247029fcd';
  v_pkc_opti uuid := 'a3f68fb2-f72e-5eaf-b452-9a5671749ce6';
  v_count int;
BEGIN
  PERFORM pg_advisory_xact_lock(hashtextextended('phuket-kings-cup-2025-resolution', 0));

  -- Verify initial counts on sheets
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_pkc_ilca6;
  IF v_count != 2 THEN RAISE EXCEPTION 'Expected 2 results on pkc_ilca6, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_pkc_ilca7;
  IF v_count != 5 THEN RAISE EXCEPTION 'Expected 5 results on pkc_ilca7 (Christian Wiedmann already inserted), found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_pkc_opti;
  IF v_count != 34 THEN RAISE EXCEPTION 'Expected 34 results on pkc_opti, found %', v_count; END IF;

  -- Step 1: Create source-faithful profiles for new sailors
  INSERT INTO public.sailors (id, name, handle, club, nationality, sail_number, gender, created_at, updated_at)
  VALUES ('07d9bca1-925a-5282-bdae-40fa1878b1d9', 'Marcus Yau', 'marcus-yau-sr25-07d9bc', 'UWC', 'HKG', 'HKG 195004', 'M', now(), now())
  ON CONFLICT (id) DO NOTHING;
  INSERT INTO public.sailors (id, name, handle, club, nationality, sail_number, gender, created_at, updated_at)
  VALUES ('1bfa6741-cb12-58e1-95be-286a073deba3', 'Tanyatip', 'tanyatip-sr25-1bfa67', 'NAC3.SC.', 'THA', '723', 'F', now(), now())
  ON CONFLICT (id) DO NOTHING;

  -- Step 2: Register aliases for matched and new sailors (including Christian Wiedmann)
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('3b468b8a-579d-5429-8d3f-27db5e17aed2', 'CHRISTIAN WIEDMANN') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('3b468b8a-579d-5429-8d3f-27db5e17aed2', 'Christian Wiedmann') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('07d9bca1-925a-5282-bdae-40fa1878b1d9', 'MARCUS YAU') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('07d9bca1-925a-5282-bdae-40fa1878b1d9', 'Marcus Yau') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('3b9072c4-2980-4557-b1f1-b9993c803824', 'SURAPA MUANGNGAM') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('3b9072c4-2980-4557-b1f1-b9993c803824', 'Surapa Muangngam') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('efc33f0d-a581-4dd3-99ee-2c245bb1c9cd', 'TAWAREE RUKSAPAN') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('efc33f0d-a581-4dd3-99ee-2c245bb1c9cd', 'Tawaree Ruksapan') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('aa2952d1-ba70-464e-8666-096ff9fef554', 'AUMMARIN JUNTAJON') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('aa2952d1-ba70-464e-8666-096ff9fef554', 'Aummarin Juntajon') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('fd3c4362-b9e5-4fce-bac2-01232f20d014', 'NIRADA SASIWUATTANAPORN') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('fd3c4362-b9e5-4fce-bac2-01232f20d014', 'Nirada Sasiwuattanaporn') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('d5453895-83cb-4b63-b701-804ce42ce4b2', 'NOPPADOL TOKPO') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('d5453895-83cb-4b63-b701-804ce42ce4b2', 'Noppadol Tokpo') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('1bfa6741-cb12-58e1-95be-286a073deba3', 'TANYATIP') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('1bfa6741-cb12-58e1-95be-286a073deba3', 'Tanyatip') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('6b42e276-4836-4f99-bb40-0542ee7b5dde', 'KANYAPAT PISOOTTIWING') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('6b42e276-4836-4f99-bb40-0542ee7b5dde', 'Kanyapat Pisoottiwing') ON CONFLICT DO NOTHING;

  -- Step 3: Insert 8 regatta results, participants, and race scores
  -- [1] MARCUS YAU (rank 10)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '5262f4f5-e38d-44f8-97dd-0823345a3bc7', '07d9bca1-925a-5282-bdae-40fa1878b1d9', '2cef00cb-a63b-5eca-b905-5c76cb43d130', 10, 80.0, 92.0,
    false, false, 'M', 'HKG',
    'https://www.racingrulesofsailing.org/documents/169974', '37th Phuket King’s Cup Regatta 2025 — ILCA 6 Open results', 'pdf', 'Identity resolved: Source-faithful profile created for Marcus Yau (HKG, UWC). Original combined PY handicap fleet ranks and scores retained; this class is a subset of the official fleet.',
    'verified', now(), 'MARCUS YAU', 'HKG 195004',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '3abc05c6-6ba5-48e2-a26b-8071f3eb40dc', '5262f4f5-e38d-44f8-97dd-0823345a3bc7', '07d9bca1-925a-5282-bdae-40fa1878b1d9', 'MARCUS YAU', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5262f4f5-e38d-44f8-97dd-0823345a3bc7', 1, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5262f4f5-e38d-44f8-97dd-0823345a3bc7', 2, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5262f4f5-e38d-44f8-97dd-0823345a3bc7', 3, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5262f4f5-e38d-44f8-97dd-0823345a3bc7', 4, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5262f4f5-e38d-44f8-97dd-0823345a3bc7', 5, 12.0, 'UFD', true, '(12.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5262f4f5-e38d-44f8-97dd-0823345a3bc7', 6, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5262f4f5-e38d-44f8-97dd-0823345a3bc7', 7, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5262f4f5-e38d-44f8-97dd-0823345a3bc7', 8, 12.0, 'DNC', false, '12.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5262f4f5-e38d-44f8-97dd-0823345a3bc7', 9, 12.0, 'DNC', false, '12.0 DNC');

  -- [2] SURAPA MUANGNGAM (rank 1)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'aaa06816-59ee-4b63-b1d6-acd7d416ccef', '3b9072c4-2980-4557-b1f1-b9993c803824', 'a3f68fb2-f72e-5eaf-b452-9a5671749ce6', 1, 10.0, 14.0,
    false, false, 'F', 'THA',
    'https://www.racingrulesofsailing.org/documents/169977', '37th Phuket King’s Cup Regatta 2025 — Optimist Open results', 'pdf', 'Identity resolved: Matches existing profile Surapha Muangngam (YRAT, THA, sail 1941).',
    'verified', now(), 'SURAPA MUANGNGAM', '1941',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '29a4222b-1427-4196-8343-011bcdc478fe', 'aaa06816-59ee-4b63-b1d6-acd7d416ccef', '3b9072c4-2980-4557-b1f1-b9993c803824', 'SURAPA MUANGNGAM', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('aaa06816-59ee-4b63-b1d6-acd7d416ccef', 1, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('aaa06816-59ee-4b63-b1d6-acd7d416ccef', 2, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('aaa06816-59ee-4b63-b1d6-acd7d416ccef', 3, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('aaa06816-59ee-4b63-b1d6-acd7d416ccef', 4, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('aaa06816-59ee-4b63-b1d6-acd7d416ccef', 5, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('aaa06816-59ee-4b63-b1d6-acd7d416ccef', 6, 4.0, NULL, true, '(4.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('aaa06816-59ee-4b63-b1d6-acd7d416ccef', 7, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('aaa06816-59ee-4b63-b1d6-acd7d416ccef', 8, 2.0, NULL, false, '2.0');

  -- [3] TAWAREE RUKSAPAN (rank 5)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '27149c24-7d19-4119-bb39-d8fa5ccf6fdd', 'efc33f0d-a581-4dd3-99ee-2c245bb1c9cd', 'a3f68fb2-f72e-5eaf-b452-9a5671749ce6', 5, 54.0, 69.0,
    false, false, 'F', 'THA',
    'https://www.racingrulesofsailing.org/documents/169977', '37th Phuket King’s Cup Regatta 2025 — Optimist Open results', 'pdf', 'Identity resolved: Matches existing profile Thawaree Raksapun (YRAT/RTFYC, THA, sail 1789).',
    'verified', now(), 'TAWAREE RUKSAPAN', '1789',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '51fb8b61-2e80-46bc-a0bf-766bc4781782', '27149c24-7d19-4119-bb39-d8fa5ccf6fdd', 'efc33f0d-a581-4dd3-99ee-2c245bb1c9cd', 'TAWAREE RUKSAPAN', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('27149c24-7d19-4119-bb39-d8fa5ccf6fdd', 1, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('27149c24-7d19-4119-bb39-d8fa5ccf6fdd', 2, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('27149c24-7d19-4119-bb39-d8fa5ccf6fdd', 3, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('27149c24-7d19-4119-bb39-d8fa5ccf6fdd', 4, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('27149c24-7d19-4119-bb39-d8fa5ccf6fdd', 5, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('27149c24-7d19-4119-bb39-d8fa5ccf6fdd', 6, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('27149c24-7d19-4119-bb39-d8fa5ccf6fdd', 7, 15.0, NULL, true, '(15.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('27149c24-7d19-4119-bb39-d8fa5ccf6fdd', 8, 3.0, NULL, false, '3.0');

  -- [4] AUMMARIN JUNTAJON (rank 9)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'af7b1151-6808-4a99-b1b8-93ccb0a68802', 'aa2952d1-ba70-464e-8666-096ff9fef554', 'a3f68fb2-f72e-5eaf-b452-9a5671749ce6', 9, 78.0, 102.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/169977', '37th Phuket King’s Cup Regatta 2025 — Optimist Open results', 'pdf', 'Identity resolved: Matches existing profile Amarin Juntajon (YRAT, THA). Romanisation variant Aummarin vs Amarin.',
    'verified', now(), 'AUMMARIN JUNTAJON', 'THA 1395',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '28998b2f-8411-491c-9c8d-ffeb1d9f5623', 'af7b1151-6808-4a99-b1b8-93ccb0a68802', 'aa2952d1-ba70-464e-8666-096ff9fef554', 'AUMMARIN JUNTAJON', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('af7b1151-6808-4a99-b1b8-93ccb0a68802', 1, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('af7b1151-6808-4a99-b1b8-93ccb0a68802', 2, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('af7b1151-6808-4a99-b1b8-93ccb0a68802', 3, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('af7b1151-6808-4a99-b1b8-93ccb0a68802', 4, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('af7b1151-6808-4a99-b1b8-93ccb0a68802', 5, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('af7b1151-6808-4a99-b1b8-93ccb0a68802', 6, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('af7b1151-6808-4a99-b1b8-93ccb0a68802', 7, 24.0, NULL, true, '(24.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('af7b1151-6808-4a99-b1b8-93ccb0a68802', 8, 12.0, NULL, false, '12.0');

  -- [5] NIRADA SASIWUATTANAPORN (rank 15)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '59ba3558-4c69-448c-9238-104ba78ff2d2', 'fd3c4362-b9e5-4fce-bac2-01232f20d014', 'a3f68fb2-f72e-5eaf-b452-9a5671749ce6', 15, 100.0, 128.0,
    false, false, 'F', 'THA',
    'https://www.racingrulesofsailing.org/documents/169977', '37th Phuket King’s Cup Regatta 2025 — Optimist Open results', 'pdf', 'Identity resolved: Matches existing profile Nirada Sasiwattanaporn (YRAT, THA). Source spelling variant Sasiwuattanaporn vs Sasiwattanaporn.',
    'verified', now(), 'NIRADA SASIWUATTANAPORN', '1373',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '1f5c1f4e-7787-4b2c-a3f0-4913beb5c7e3', '59ba3558-4c69-448c-9238-104ba78ff2d2', 'fd3c4362-b9e5-4fce-bac2-01232f20d014', 'NIRADA SASIWUATTANAPORN', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('59ba3558-4c69-448c-9238-104ba78ff2d2', 1, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('59ba3558-4c69-448c-9238-104ba78ff2d2', 2, 28.0, NULL, true, '(28.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('59ba3558-4c69-448c-9238-104ba78ff2d2', 3, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('59ba3558-4c69-448c-9238-104ba78ff2d2', 4, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('59ba3558-4c69-448c-9238-104ba78ff2d2', 5, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('59ba3558-4c69-448c-9238-104ba78ff2d2', 6, 18.0, NULL, false, '18.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('59ba3558-4c69-448c-9238-104ba78ff2d2', 7, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('59ba3558-4c69-448c-9238-104ba78ff2d2', 8, 13.0, NULL, false, '13.0');

  -- [6] NOPPADOL TOKPO (rank 26)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'a2688def-5a35-4c36-8270-cb58ef7c8827', 'd5453895-83cb-4b63-b701-804ce42ce4b2', 'a3f68fb2-f72e-5eaf-b452-9a5671749ce6', 26, 188.0, 230.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/169977', '37th Phuket King’s Cup Regatta 2025 — Optimist Open results', 'pdf', 'Identity resolved: Matches existing profile Nopadol Tokpo (RNSC, THA, sail 8884). Romanisation variant Noppadol vs Nopadol.',
    'verified', now(), 'NOPPADOL TOKPO', 'THA 8884',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'be49e993-94c7-4baf-8b73-cb95030767f3', 'a2688def-5a35-4c36-8270-cb58ef7c8827', 'd5453895-83cb-4b63-b701-804ce42ce4b2', 'NOPPADOL TOKPO', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a2688def-5a35-4c36-8270-cb58ef7c8827', 1, 22.0, NULL, false, '22.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a2688def-5a35-4c36-8270-cb58ef7c8827', 2, 42.0, 'DSQ', true, '(42.0 DSQ)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a2688def-5a35-4c36-8270-cb58ef7c8827', 3, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a2688def-5a35-4c36-8270-cb58ef7c8827', 4, 29.0, NULL, false, '29.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a2688def-5a35-4c36-8270-cb58ef7c8827', 5, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a2688def-5a35-4c36-8270-cb58ef7c8827', 6, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a2688def-5a35-4c36-8270-cb58ef7c8827', 7, 31.0, NULL, false, '31.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a2688def-5a35-4c36-8270-cb58ef7c8827', 8, 42.0, 'DNF', false, '42.0 DNF');

  -- [7] TANYATIP (rank 28)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'b5f68999-0de0-42e0-b19d-7d35860370a5', '1bfa6741-cb12-58e1-95be-286a073deba3', 'a3f68fb2-f72e-5eaf-b452-9a5671749ce6', 28, 195.0, 237.0,
    false, false, 'F', 'THA',
    'https://www.racingrulesofsailing.org/documents/169977', '37th Phuket King’s Cup Regatta 2025 — Optimist Open results', 'pdf', 'Identity resolved: Source-faithful profile created for Tanyatip (THA, NAC3.SC., sail 723).',
    'verified', now(), 'TANYATIP', '723',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '480e4621-6243-452f-993f-d5d42143fa89', 'b5f68999-0de0-42e0-b19d-7d35860370a5', '1bfa6741-cb12-58e1-95be-286a073deba3', 'TANYATIP', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b5f68999-0de0-42e0-b19d-7d35860370a5', 1, 29.0, NULL, false, '29.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b5f68999-0de0-42e0-b19d-7d35860370a5', 2, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b5f68999-0de0-42e0-b19d-7d35860370a5', 3, 42.0, 'BFD', true, '(42.0 BFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b5f68999-0de0-42e0-b19d-7d35860370a5', 4, 24.0, NULL, false, '24.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b5f68999-0de0-42e0-b19d-7d35860370a5', 5, 28.0, NULL, false, '28.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b5f68999-0de0-42e0-b19d-7d35860370a5', 6, 30.0, NULL, false, '30.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b5f68999-0de0-42e0-b19d-7d35860370a5', 7, 22.0, NULL, false, '22.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b5f68999-0de0-42e0-b19d-7d35860370a5', 8, 42.0, 'DNF', false, '42.0 DNF');

  -- [8] KANYAPAT PISOOTTIWING (rank 31)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '9bc43e1c-948b-47ef-8d9b-2c159f7e4298', '6b42e276-4836-4f99-bb40-0542ee7b5dde', 'a3f68fb2-f72e-5eaf-b452-9a5671749ce6', 31, 211.0, 253.0,
    false, false, 'F', 'THA',
    'https://www.racingrulesofsailing.org/documents/169977', '37th Phuket King’s Cup Regatta 2025 — Optimist Open results', 'pdf', 'Identity resolved: Matches existing profile Kanyapat Pisoottiwong (YRAT, THA, sail 1556). Source spelling variant Pisoottiwing vs Pisoottiwong.',
    'verified', now(), 'KANYAPAT PISOOTTIWING', 'THA 1556',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '99bd608c-8cf5-4547-8c40-0b7d8818f801', '9bc43e1c-948b-47ef-8d9b-2c159f7e4298', '6b42e276-4836-4f99-bb40-0542ee7b5dde', 'KANYAPAT PISOOTTIWING', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('9bc43e1c-948b-47ef-8d9b-2c159f7e4298', 1, 32.0, NULL, false, '32.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('9bc43e1c-948b-47ef-8d9b-2c159f7e4298', 2, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('9bc43e1c-948b-47ef-8d9b-2c159f7e4298', 3, 42.0, 'BFD', true, '(42.0 BFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('9bc43e1c-948b-47ef-8d9b-2c159f7e4298', 4, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('9bc43e1c-948b-47ef-8d9b-2c159f7e4298', 5, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('9bc43e1c-948b-47ef-8d9b-2c159f7e4298', 6, 34.0, NULL, false, '34.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('9bc43e1c-948b-47ef-8d9b-2c159f7e4298', 7, 30.0, NULL, false, '30.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('9bc43e1c-948b-47ef-8d9b-2c159f7e4298', 8, 42.0, 'DNF', false, '42.0 DNF');

  -- Step 4: Verify final counts
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_pkc_ilca6;
  IF v_count != 3 THEN RAISE EXCEPTION 'Expected 3 results on pkc_ilca6, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_pkc_ilca7;
  IF v_count != 5 THEN RAISE EXCEPTION 'Expected 5 results on pkc_ilca7, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_pkc_opti;
  IF v_count != 41 THEN RAISE EXCEPTION 'Expected 41 results on pkc_opti, found %', v_count; END IF;

  -- Step 5: Update schedule_notes to reflect complete imports
  UPDATE public.regattas
  SET schedule_notes = 'Final organiser results. Original combined PY handicap standings; class subset, with original ranks and scores. Complete import: 3 of 3 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_pkc_ilca6;

  UPDATE public.regattas
  SET schedule_notes = 'Final organiser results. Original combined PY handicap standings; class subset, with original ranks and scores. Complete import: 5 of 5 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_pkc_ilca7;

  UPDATE public.regattas
  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 41 of 41 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_pkc_opti;

  -- Step 6: Audit logging
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source) VALUES
    ('results.resolve_identity', 'regatta', v_pkc_ilca6, 'phuket-kings-cup-2025-ilca6', 'Resolved 1 held entry (Marcus Yau). Sheet is now 100% complete (3/3 class entries).', '{"resolved_count": 1}'::jsonb, 'phuket-kings-cup-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_pkc_ilca7, 'phuket-kings-cup-2025-ilca7', 'Corroborated 1 previously resolved entry (Apiwat Christian Wiedmann). Sheet is 100% complete (5/5 class entries).', '{"resolved_count": 1}'::jsonb, 'phuket-kings-cup-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_pkc_opti, 'phuket-kings-cup-2025-optimist', 'Resolved 7 held entries. Sheet is now 100% complete (41/41).', '{"resolved_count": 7}'::jsonb, 'phuket-kings-cup-2025-resolution-2026-11-12');

END $resolve$;
COMMIT;
