-- YRAT Cup Series 5 (2025): Resolution of 10 held junior entries and sailor deduplication
BEGIN;
DO $resolve$
DECLARE
  v_sheet_ilca4 uuid := 'c319a67f-0640-540f-92a9-69718217c089';
  v_sheet_gold uuid := 'b2cefb1c-26c6-510d-8ee8-41d663dc36e0';
  v_sheet_silver uuid := 'f8b2ae66-e664-5b49-bc41-a1325ac63e2e';
  v_huanran_id uuid := '87cc8912-d304-407f-934f-5cadd7a4921e';
  v_jolin_id uuid := '018b6ed4-9636-47e1-8d40-aa5e21a22f32';
  v_count int;
BEGIN
  PERFORM pg_advisory_xact_lock(hashtextextended('yrat-series5-resolution', 0));

  -- Verify current result counts on the 3 sheets
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sheet_ilca4;
  IF v_count != 16 THEN RAISE EXCEPTION 'Expected 16 results on YRAT ILCA 4, found %', v_count; END IF;

  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sheet_gold;
  IF v_count != 36 THEN RAISE EXCEPTION 'Expected 36 results on YRAT Opti Gold, found %', v_count; END IF;

  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sheet_silver;
  IF v_count != 24 THEN RAISE EXCEPTION 'Expected 24 results on YRAT Opti Silver, found %', v_count; END IF;

  -- Step 1: Merge duplicate Huanran Zheng into canonical Jolin Zheng
  IF EXISTS (SELECT 1 FROM public.sailors WHERE id = v_huanran_id) THEN
    UPDATE public.regatta_results SET sailor_id = v_jolin_id WHERE sailor_id = v_huanran_id;
    UPDATE public.regatta_result_participants SET sailor_id = v_jolin_id WHERE sailor_id = v_huanran_id;
    DELETE FROM public.sailor_aliases WHERE sailor_id = v_huanran_id;
    INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES
      (v_jolin_id, 'Huanran Zheng'),
      (v_jolin_id, 'Huanran ZHENG'),
      (v_jolin_id, 'Zheng')
    ON CONFLICT DO NOTHING;
    DELETE FROM public.sailors WHERE id = v_huanran_id;
    INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source) VALUES
      ('sailor.merge', 'sailor', v_jolin_id, 'Jolin Zheng', 'Merged duplicate Huanran Zheng into canonical profile Jolin Zheng (RHKYC, sail 209319, DOB 2011-01-01).', jsonb_build_object('merged_from', v_huanran_id), 'yrat-series5-resolution-2026-11-12');
  END IF;

  -- Step 2: Register aliases for matched sailors
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('018b6ed4-9636-47e1-8d40-aa5e21a22f32', 'Zheng') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('018b6ed4-9636-47e1-8d40-aa5e21a22f32', 'Huanran Zheng') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('018b6ed4-9636-47e1-8d40-aa5e21a22f32', 'Huanran ZHENG') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('90a471f5-bd58-400f-a995-e115951ee1ed', 'Kitchakhun Somkhanngone') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('90a471f5-bd58-400f-a995-e115951ee1ed', 'KITCHAKHUN SOMKHANNGONE') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('4f1eb555-5b44-517d-8d05-9ff0fd18f5ec', 'Pumitus Mee-Eiamsin') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('4f1eb555-5b44-517d-8d05-9ff0fd18f5ec', 'PUMITUS MEE-EIAMSIN') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('071e2770-8de0-4d2f-b8c3-bd6cb31fef05', 'Ratcharta Sadtrakulwattan') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('182f006d-6103-4990-a289-421c0d94e552', 'Itthichai Taithongchai') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('182f006d-6103-4990-a289-421c0d94e552', 'ITTHICHAI TAITHONGCHAI') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('4ea7704c-a106-47d1-b424-6565e8dd9c3f', 'Yue Yan') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('9fe16e38-700a-4ba6-8618-5f6779a9b23f', 'Patarakorn Poonpat') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('9fe16e38-700a-4ba6-8618-5f6779a9b23f', 'PATARAKORN POONPAT') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('154feedb-6173-4142-8d3e-88f1567b22e7', 'Santhat Suthamgoasl') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('8b594c37-db52-4549-a765-f51fd619238d', 'Netchanok Chatawattanasopskun') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('8b594c37-db52-4549-a765-f51fd619238d', 'NETCHANOK CHATAWATTANASOPSKUN') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('1c03e3e7-ea29-526f-88b3-fd77ce113868', 'Navatawan Jaemjit') ON CONFLICT DO NOTHING;

  -- Step 3: Insert the 10 junior results, participants, and race results
  -- Entry 1: Zheng (ILCA 4 Open - Rank 10)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    '781f9e2d-cdcd-59b7-ab5e-f68e80d7e455', '018b6ed4-9636-47e1-8d40-aa5e21a22f32', 'c319a67f-0640-540f-92a9-69718217c089', 'Zheng', '209319', 'individual',
    10, 58.0, 43.0, 'F', 'SGP', false, false,
    'https://www.racingrulesofsailing.org/documents/156704', 'https://www.racingrulesofsailing.org/documents/156704', '2025 YRAT Cup Series 5 — ILCA 4 Open results', 'pdf', 'Identity resolved: RHKYC entry Zheng (sail 209319) matches canonical profile Jolin Zheng (Huanran Zheng). Duplicate Huanran Zheng merged into Jolin Zheng. Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    '8e7a7fbc-98c5-5e34-9a52-8fe7df6f88ef', '781f9e2d-cdcd-59b7-ab5e-f68e80d7e455', '018b6ed4-9636-47e1-8d40-aa5e21a22f32', 'Zheng', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('781f9e2d-cdcd-59b7-ab5e-f68e80d7e455', 1, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('781f9e2d-cdcd-59b7-ab5e-f68e80d7e455', 2, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('781f9e2d-cdcd-59b7-ab5e-f68e80d7e455', 3, 15.0, NULL, true, '(15.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('781f9e2d-cdcd-59b7-ab5e-f68e80d7e455', 4, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('781f9e2d-cdcd-59b7-ab5e-f68e80d7e455', 5, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('781f9e2d-cdcd-59b7-ab5e-f68e80d7e455', 6, 8.0, NULL, false, '8.0');

  -- Entry 2: KITCHAKHUN SOMKHANNGONE (ILCA 4 Open - Rank 13)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    '8e84c28d-f185-5fcb-a861-a8546114da38', '90a471f5-bd58-400f-a995-e115951ee1ed', 'c319a67f-0640-540f-92a9-69718217c089', 'KITCHAKHUN SOMKHANNGONE', '21738', 'individual',
    13, 76.0, 61.0, 'M', 'THA', false, false,
    'https://www.racingrulesofsailing.org/documents/156704', 'https://www.racingrulesofsailing.org/documents/156704', '2025 YRAT Cup Series 5 — ILCA 4 Open results', 'pdf', 'Identity resolved: Matches existing profile Kiitchakhun Somkhanngoen (YRAT, THA). Registered alias Kitchakhun Somkhanngone. Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    'e09708a8-7801-57c5-a9de-cc9fc6dad156', '8e84c28d-f185-5fcb-a861-a8546114da38', '90a471f5-bd58-400f-a995-e115951ee1ed', 'KITCHAKHUN SOMKHANNGONE', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('8e84c28d-f185-5fcb-a861-a8546114da38', 1, 13.0, NULL, false, '13.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('8e84c28d-f185-5fcb-a861-a8546114da38', 2, 15.0, NULL, true, '(15.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('8e84c28d-f185-5fcb-a861-a8546114da38', 3, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('8e84c28d-f185-5fcb-a861-a8546114da38', 4, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('8e84c28d-f185-5fcb-a861-a8546114da38', 5, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('8e84c28d-f185-5fcb-a861-a8546114da38', 6, 11.0, NULL, false, '11.0');

  -- Entry 3: PUMITUS MEE-EIAMSIN (ILCA 4 Open - Rank 15)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    '4a62e461-8d19-5b09-aa49-31f902cceba5', '4f1eb555-5b44-517d-8d05-9ff0fd18f5ec', 'c319a67f-0640-540f-92a9-69718217c089', 'PUMITUS MEE-EIAMSIN', 'THA 22023', 'individual',
    15, 84.0, 68.0, 'M', 'THA', false, false,
    'https://www.racingrulesofsailing.org/documents/156704', 'https://www.racingrulesofsailing.org/documents/156704', '2025 YRAT Cup Series 5 — ILCA 4 Open results', 'pdf', 'Identity resolved: Matches existing profile Pumitus Mee-Iamsin (YRAT, THA). Historic event sail: THA 22023. Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    'da0167b9-982b-59c9-b15b-289d7991b04d', '4a62e461-8d19-5b09-aa49-31f902cceba5', '4f1eb555-5b44-517d-8d05-9ff0fd18f5ec', 'PUMITUS MEE-EIAMSIN', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4a62e461-8d19-5b09-aa49-31f902cceba5', 1, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4a62e461-8d19-5b09-aa49-31f902cceba5', 2, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4a62e461-8d19-5b09-aa49-31f902cceba5', 3, 16.0, NULL, true, '(16.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4a62e461-8d19-5b09-aa49-31f902cceba5', 4, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4a62e461-8d19-5b09-aa49-31f902cceba5', 5, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4a62e461-8d19-5b09-aa49-31f902cceba5', 6, 15.0, NULL, false, '15.0');

  -- Entry 4: Ratcharta Sadtrakulwattan (Optimist Gold - Rank 6)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    'b7733c26-2d78-5c14-a405-366fa51ee12f', '071e2770-8de0-4d2f-b8c3-bd6cb31fef05', 'b2cefb1c-26c6-510d-8ee8-41d663dc36e0', 'Ratcharta Sadtrakulwattan', 'THA1963', 'individual',
    6, 37.0, 25.0, 'M', 'THA', false, false,
    'https://www.racingrulesofsailing.org/documents/156714', 'https://www.racingrulesofsailing.org/documents/156714', 'Provisional — 2025 YRAT Cup Series 5 — Optimist Gold results', 'pdf', 'Identity resolved: Matches existing profile Rachata Sadtrakulwatanna (YRAT, THA, sail 1963). Registered alias Ratcharta Sadtrakulwattan. Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    '6a12fab6-4b6a-5c8f-b35e-d4c42981fca9', 'b7733c26-2d78-5c14-a405-366fa51ee12f', '071e2770-8de0-4d2f-b8c3-bd6cb31fef05', 'Ratcharta Sadtrakulwattan', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b7733c26-2d78-5c14-a405-366fa51ee12f', 1, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b7733c26-2d78-5c14-a405-366fa51ee12f', 2, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b7733c26-2d78-5c14-a405-366fa51ee12f', 3, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b7733c26-2d78-5c14-a405-366fa51ee12f', 4, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b7733c26-2d78-5c14-a405-366fa51ee12f', 5, 12.0, NULL, true, '(12.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b7733c26-2d78-5c14-a405-366fa51ee12f', 6, 1.0, NULL, false, '1.0');

  -- Entry 5: ITTHICHAI TAITHONGCHAI (Optimist Gold - Rank 8)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    'a87c55ad-f871-5ed8-9b69-800dd73e6576', '182f006d-6103-4990-a289-421c0d94e552', 'b2cefb1c-26c6-510d-8ee8-41d663dc36e0', 'ITTHICHAI TAITHONGCHAI', 'THA2865', 'individual',
    8, 52.0, 33.0, 'M', 'THA', false, false,
    'https://www.racingrulesofsailing.org/documents/156714', 'https://www.racingrulesofsailing.org/documents/156714', 'Provisional — 2025 YRAT Cup Series 5 — Optimist Gold results', 'pdf', 'Identity resolved: Matches existing profile Itthichai Tiathongchai (YRAT, THA). Registered alias Itthichai Taithongchai. Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    'df9c610e-97a2-5f7d-9583-b07f92519eac', 'a87c55ad-f871-5ed8-9b69-800dd73e6576', '182f006d-6103-4990-a289-421c0d94e552', 'ITTHICHAI TAITHONGCHAI', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a87c55ad-f871-5ed8-9b69-800dd73e6576', 1, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a87c55ad-f871-5ed8-9b69-800dd73e6576', 2, 19.0, NULL, true, '(19.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a87c55ad-f871-5ed8-9b69-800dd73e6576', 3, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a87c55ad-f871-5ed8-9b69-800dd73e6576', 4, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a87c55ad-f871-5ed8-9b69-800dd73e6576', 5, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a87c55ad-f871-5ed8-9b69-800dd73e6576', 6, 9.0, NULL, false, '9.0');

  -- Entry 6: Yue Yan (Optimist Gold - Rank 10)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    '29c0ef02-33e3-593b-9e21-46397fd27ea0', '4ea7704c-a106-47d1-b424-6565e8dd9c3f', 'b2cefb1c-26c6-510d-8ee8-41d663dc36e0', 'Yue Yan', 'CHN7709', 'individual',
    10, 80.0, 54.0, 'F', 'CHN', false, false,
    'https://www.racingrulesofsailing.org/documents/156714', 'https://www.racingrulesofsailing.org/documents/156714', 'Provisional — 2025 YRAT Cup Series 5 — Optimist Gold results', 'pdf', 'Identity resolved: Matches existing profile Yueyan Jin (CHN, sail CHN7709 across regional regattas). Official source table omitted surname Jin. Registered alias Yue Yan. Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    'e4e2b960-7330-5631-8633-e27ab85ed47c', '29c0ef02-33e3-593b-9e21-46397fd27ea0', '4ea7704c-a106-47d1-b424-6565e8dd9c3f', 'Yue Yan', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('29c0ef02-33e3-593b-9e21-46397fd27ea0', 1, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('29c0ef02-33e3-593b-9e21-46397fd27ea0', 2, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('29c0ef02-33e3-593b-9e21-46397fd27ea0', 3, 18.0, NULL, false, '18.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('29c0ef02-33e3-593b-9e21-46397fd27ea0', 4, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('29c0ef02-33e3-593b-9e21-46397fd27ea0', 5, 26.0, NULL, true, '(26.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('29c0ef02-33e3-593b-9e21-46397fd27ea0', 6, 10.0, NULL, false, '10.0');

  -- Entry 7: PATARAKORN POONPAT (Optimist Gold - Rank 11)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    'c59e4245-2804-5756-bca9-b38cfabe8429', '9fe16e38-700a-4ba6-8618-5f6779a9b23f', 'b2cefb1c-26c6-510d-8ee8-41d663dc36e0', 'PATARAKORN POONPAT', 'THA88', 'individual',
    11, 93.0, 68.0, 'M', 'THA', false, false,
    'https://www.racingrulesofsailing.org/documents/156714', 'https://www.racingrulesofsailing.org/documents/156714', 'Provisional — 2025 YRAT Cup Series 5 — Optimist Gold results', 'pdf', 'Identity resolved: Matches existing profile Pattarakorn Poonpat (ACDC.SC, THA, sail 88). Registered alias Patarakorn Poonpat. Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    '7ad3dbdb-3b02-5498-995d-c38df78e45e6', 'c59e4245-2804-5756-bca9-b38cfabe8429', '9fe16e38-700a-4ba6-8618-5f6779a9b23f', 'PATARAKORN POONPAT', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c59e4245-2804-5756-bca9-b38cfabe8429', 1, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c59e4245-2804-5756-bca9-b38cfabe8429', 2, 24.0, NULL, false, '24.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c59e4245-2804-5756-bca9-b38cfabe8429', 3, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c59e4245-2804-5756-bca9-b38cfabe8429', 4, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c59e4245-2804-5756-bca9-b38cfabe8429', 5, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c59e4245-2804-5756-bca9-b38cfabe8429', 6, 25.0, NULL, true, '(25.0)');

  -- Entry 8: Santhat Suthamgoasl (Optimist Gold - Rank 41)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    'ac9ee458-4ec9-5414-9ffe-d17b716d56b3', '154feedb-6173-4142-8d3e-88f1567b22e7', 'b2cefb1c-26c6-510d-8ee8-41d663dc36e0', 'Santhat Suthamgoasl', 'THA1879', 'individual',
    41, 248.0, 206.0, 'M', 'THA', false, false,
    'https://www.racingrulesofsailing.org/documents/156714', 'https://www.racingrulesofsailing.org/documents/156714', 'Provisional — 2025 YRAT Cup Series 5 — Optimist Gold results', 'pdf', 'Identity resolved: Matches existing profile Santhat Suthamgosal (ACDC, THA, sail 1879). Registered alias Santhat Suthamgoasl. Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    'c6f2d709-64e6-5f6f-9833-26d6636f7691', 'ac9ee458-4ec9-5414-9ffe-d17b716d56b3', '154feedb-6173-4142-8d3e-88f1567b22e7', 'Santhat Suthamgoasl', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('ac9ee458-4ec9-5414-9ffe-d17b716d56b3', 1, 41.0, NULL, false, '41.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('ac9ee458-4ec9-5414-9ffe-d17b716d56b3', 2, 42.0, 'DNF', true, '(42.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('ac9ee458-4ec9-5414-9ffe-d17b716d56b3', 3, 42.0, 'DNF', false, '42.0 DNF');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('ac9ee458-4ec9-5414-9ffe-d17b716d56b3', 4, 41.0, NULL, false, '41.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('ac9ee458-4ec9-5414-9ffe-d17b716d56b3', 5, 41.0, NULL, false, '41.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('ac9ee458-4ec9-5414-9ffe-d17b716d56b3', 6, 41.0, NULL, false, '41.0');

  -- Entry 9: NETCHANOK CHATAWATTANASOPSKUN (Optimist Silver - Rank 7)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    '07abec54-5ac9-5849-9664-20a0184bd4d1', '8b594c37-db52-4549-a765-f51fd619238d', 'f8b2ae66-e664-5b49-bc41-a1325ac63e2e', 'NETCHANOK CHATAWATTANASOPSKUN', '1562', 'individual',
    7, 52.0, 38.0, 'F', 'THA', false, false,
    'https://www.racingrulesofsailing.org/documents/156714', 'https://www.racingrulesofsailing.org/documents/156714', 'Provisional — 2025 YRAT Cup Series 5 — Optimist Silver results', 'pdf', 'Identity resolved: Matches existing profile Netchanok Chatawattanasopakun (ACDC.SC, THA). Registered alias Netchanok Chatawattanasopskun. Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    '9b782035-6cb2-5ee3-9148-c778cfd58c31', '07abec54-5ac9-5849-9664-20a0184bd4d1', '8b594c37-db52-4549-a765-f51fd619238d', 'NETCHANOK CHATAWATTANASOPSKUN', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('07abec54-5ac9-5849-9664-20a0184bd4d1', 1, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('07abec54-5ac9-5849-9664-20a0184bd4d1', 2, 14.0, NULL, true, '(14.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('07abec54-5ac9-5849-9664-20a0184bd4d1', 3, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('07abec54-5ac9-5849-9664-20a0184bd4d1', 4, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('07abec54-5ac9-5849-9664-20a0184bd4d1', 5, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('07abec54-5ac9-5849-9664-20a0184bd4d1', 6, 12.0, NULL, false, '12.0');

  -- Entry 10: Navatawan Jaemjit (Optimist Silver - Rank 18)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    '7fa79f52-a7be-59ea-a527-1607d3993ecf', '1c03e3e7-ea29-526f-88b3-fd77ce113868', 'f8b2ae66-e664-5b49-bc41-a1325ac63e2e', 'Navatawan Jaemjit', 'THA1979', 'individual',
    18, 99.0, 77.0, 'F', 'THA', false, false,
    'https://www.racingrulesofsailing.org/documents/156714', 'https://www.racingrulesofsailing.org/documents/156714', 'Provisional — 2025 YRAT Cup Series 5 — Optimist Silver results', 'pdf', 'Identity resolved: Matches existing profile Navatawan Jeanjit (RTFYC, THA, sail 1979). Registered alias Navatawan Jaemjit. Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    'f68bece6-bc37-57b6-9076-04a6221d763f', '7fa79f52-a7be-59ea-a527-1607d3993ecf', '1c03e3e7-ea29-526f-88b3-fd77ce113868', 'Navatawan Jaemjit', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('7fa79f52-a7be-59ea-a527-1607d3993ecf', 1, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('7fa79f52-a7be-59ea-a527-1607d3993ecf', 2, 19.0, NULL, false, '19.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('7fa79f52-a7be-59ea-a527-1607d3993ecf', 3, 22.0, NULL, true, '(22.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('7fa79f52-a7be-59ea-a527-1607d3993ecf', 4, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('7fa79f52-a7be-59ea-a527-1607d3993ecf', 5, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('7fa79f52-a7be-59ea-a527-1607d3993ecf', 6, 17.0, NULL, false, '17.0');

  -- Step 4: Verify final counts on all 3 sheets
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sheet_ilca4;
  IF v_count != 19 THEN RAISE EXCEPTION 'Expected 19 results on YRAT ILCA 4, found %', v_count; END IF;

  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sheet_gold;
  IF v_count != 41 THEN RAISE EXCEPTION 'Expected 41 results on YRAT Opti Gold, found %', v_count; END IF;

  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sheet_silver;
  IF v_count != 26 THEN RAISE EXCEPTION 'Expected 26 results on YRAT Opti Silver, found %', v_count; END IF;

  -- Step 5: Update schedule_notes on all 3 sheets to reflect 100% completion
  UPDATE public.regattas
  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 19 of 19 class entries imported; 0 awaiting identity or source review.',
      updated_at = now()
  WHERE id = v_sheet_ilca4 AND total_fleet_size = 19;

  UPDATE public.regattas
  SET schedule_notes = 'Official source status: provisional. Provisional organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 41 of 41 class entries imported; 0 awaiting identity or source review.',
      updated_at = now()
  WHERE id = v_sheet_gold AND total_fleet_size = 41;

  UPDATE public.regattas
  SET schedule_notes = 'Official source status: provisional. Provisional organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 26 of 26 class entries imported; 0 awaiting identity or source review.',
      updated_at = now()
  WHERE id = v_sheet_silver AND total_fleet_size = 26;

  -- Step 6: Audit logging
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source) VALUES
    ('results.resolve_identity', 'regatta', v_sheet_ilca4, 'yrat-cup-series-5-2025-ilca4', 'Resolved 3 held entries (Zheng, KITCHAKHUN SOMKHANNGONE, PUMITUS MEE-EIAMSIN). Sheet is now 100% complete (19/19).', '{"resolved_count": 3}'::jsonb, 'yrat-series5-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_sheet_gold, 'yrat-cup-series-5-2025-optimist-gold', 'Resolved 5 held entries (Ratcharta Sadtrakulwattan, ITTHICHAI TAITHONGCHAI, Yue Yan, PATARAKORN POONPAT, Santhat Suthamgoasl). Sheet is now 100% complete (41/41).', '{"resolved_count": 5}'::jsonb, 'yrat-series5-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_sheet_silver, 'yrat-cup-series-5-2025-optimist-silver', 'Resolved 2 held entries (NETCHANOK CHATAWATTANASOPSKUN, Navatawan Jaemjit). Sheet is now 100% complete (26/26).', '{"resolved_count": 2}'::jsonb, 'yrat-series5-resolution-2026-11-12');

END $resolve$;
COMMIT;
