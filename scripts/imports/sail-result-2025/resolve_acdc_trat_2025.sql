-- ACDC Cup & Trat Regatta 2025: Resolution of 24 held entries (Cluster 3D)
BEGIN;
DO $resolve$
DECLARE
  v_acdc_ilca4 uuid := 'b8d4edd6-9059-579b-84f9-30198597f440';
  v_acdc_ilca6 uuid := 'a62775e2-103c-52f9-827a-e4e01066e2d4';
  v_acdc_ilca7 uuid := '7a8de0db-47a2-56dc-b240-fb2b46075a12';
  v_acdc_opti_gold uuid := 'e1a64cdd-fa07-553c-bc72-e56fd1f86fee';
  v_acdc_opti_silver uuid := 'b4595995-1be5-505f-b1a9-5cb00005c04b';
  v_trat_ilca6 uuid := 'b8df6f6f-d18a-52db-a03b-7b0e96603c00';
  v_trat_opti_silver uuid := '7ad27b8b-7df1-5229-b0e6-9e7cb7d2c24e';
  v_count int;
BEGIN
  PERFORM pg_advisory_xact_lock(hashtextextended('acdc-trat-2025-resolution', 0));

  -- Verify initial counts on sheets
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_acdc_ilca4;
  IF v_count != 15 THEN RAISE EXCEPTION 'Expected 15 results on acdc_ilca4, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_acdc_ilca6;
  IF v_count != 2 THEN RAISE EXCEPTION 'Expected 2 results on acdc_ilca6, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_acdc_ilca7;
  IF v_count != 2 THEN RAISE EXCEPTION 'Expected 2 results on acdc_ilca7, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_acdc_opti_gold;
  IF v_count != 61 THEN RAISE EXCEPTION 'Expected 61 results on acdc_opti_gold, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_acdc_opti_silver;
  IF v_count != 43 THEN RAISE EXCEPTION 'Expected 43 results on acdc_opti_silver, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_trat_ilca6;
  IF v_count != 8 THEN RAISE EXCEPTION 'Expected 8 results on trat_ilca6, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_trat_opti_silver;
  IF v_count != 40 THEN RAISE EXCEPTION 'Expected 40 results on trat_opti_silver, found %', v_count; END IF;

  -- Step 1: Create source-faithful profiles for new sailors
  INSERT INTO public.sailors (id, name, handle, club, nationality, sail_number, gender, created_at, updated_at)
  VALUES ('51a8b92d-74d1-52a1-bf87-4328eb92040c', 'Ya Zhang', 'ya-zhang-sr25-51a8b9', 'QINGDAO', 'CHN', 'CHN122', 'F', now(), now())
  ON CONFLICT (id) DO NOTHING;
  INSERT INTO public.sailors (id, name, handle, club, nationality, sail_number, gender, created_at, updated_at)
  VALUES ('729acda4-25b3-57df-b11c-2f31f9d45e52', 'Nuttapat Arttapiyapun', 'nuttapat-arttapiyapun-sr25-729acd', 'ACDC. SC', 'THA', 'THA187', 'M', now(), now())
  ON CONFLICT (id) DO NOTHING;
  INSERT INTO public.sailors (id, name, handle, club, nationality, sail_number, gender, created_at, updated_at)
  VALUES ('f4c93ba2-66ab-5908-99cf-59e3bdc60f4e', 'Klaochanok (Trat DNC)', 'klaochanok-trat-dnc-sr25-f4c93b', 'YRAT', 'THA', '', 'F', now(), now())
  ON CONFLICT (id) DO NOTHING;
  INSERT INTO public.sailors (id, name, handle, club, nationality, sail_number, gender, created_at, updated_at)
  VALUES ('c37db018-8ee6-5fb6-9f82-a0eb82fa9b61', 'T (Trat DNC)', 't-trat-dnc-sr25-c37db0', 'YRAT', 'THA', '', 'M', now(), now())
  ON CONFLICT (id) DO NOTHING;

  -- Step 2: Register aliases for matched and new sailors
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('51a8b92d-74d1-52a1-bf87-4328eb92040c', 'YA ZHANG') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('51a8b92d-74d1-52a1-bf87-4328eb92040c', 'Ya Zhang') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('97050c23-371f-427e-a571-e20486cbb936', 'KUNPICHET PANCHANG') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('97050c23-371f-427e-a571-e20486cbb936', 'Kunpichet Panchang') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('611ef739-d28b-57c3-b6fe-183b006a2a38', 'KAUNG KHANT KO') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('611ef739-d28b-57c3-b6fe-183b006a2a38', 'Kaung Khant Ko') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('dfefca66-a570-5f96-bec6-eb566501bdbb', 'DUANGDUENG WICHAI') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('dfefca66-a570-5f96-bec6-eb566501bdbb', 'Duangdueng Wichai') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('1c03e3e7-ea29-526f-88b3-fd77ce113868', 'NAVATAWAN Jaemjit') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('1c03e3e7-ea29-526f-88b3-fd77ce113868', 'Navatawan Jaemjit') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('8953feed-5a7e-4fe1-978c-7ddcb9ac3fbb', 'Kunthee Khunmuang') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('8953feed-5a7e-4fe1-978c-7ddcb9ac3fbb', 'KUNTHEE KHUNMUANG') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('02f7450f-b247-49cf-ba12-2f33a7f0642e', 'CHARIE BASNET') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('02f7450f-b247-49cf-ba12-2f33a7f0642e', 'Charie Basnet') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('729acda4-25b3-57df-b11c-2f31f9d45e52', 'NUTTAPAT ARTTAPIYAPUN') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('729acda4-25b3-57df-b11c-2f31f9d45e52', 'Nuttapat Arttapiyapun') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7', 'KHAIRUL ILZANI MOND AFENDY') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7', 'Khairul Ilzani Mond Afendy') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('2bda4fc0-b72c-4b0b-b21f-597107dc5ca8', 'MUAZ MUJAHID KHAMARUE AZUAN') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('2bda4fc0-b72c-4b0b-b21f-597107dc5ca8', 'Muaz Mujahid Khamarue Azuan') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('863b5d54-6357-50d0-b16e-75e44de37e41', 'ITTIVORAKUL') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('863b5d54-6357-50d0-b16e-75e44de37e41', 'Ittivorakul') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('fd3c4362-b9e5-4fce-bac2-01232f20d014', 'NIRADA SASIWATTHANAPORN') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('fd3c4362-b9e5-4fce-bac2-01232f20d014', 'Nirada Sasiwatthanaporn') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('796bc25b-e641-4630-8c8d-20241e73f843', 'MIA AZRAHIA MOHDAZRALD') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('796bc25b-e641-4630-8c8d-20241e73f843', 'Mia Azrahia Mohdazrald') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('04f1c65e-eeb7-4c89-9f6e-16298c33be02', 'Klaochanok Chatawattanasopakul') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('04f1c65e-eeb7-4c89-9f6e-16298c33be02', 'KLAOCHANOK CHATAWATTANASOPAKUL') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('0788d794-c84e-5242-9da9-3d51d26e4eb7', 'NITHATSANA RODNUN') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('0788d794-c84e-5242-9da9-3d51d26e4eb7', 'Nithatsana Rodnun') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('90a471f5-bd58-400f-a995-e115951ee1ed', 'KITCHAKHUN SOMKHANNGONE') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('90a471f5-bd58-400f-a995-e115951ee1ed', 'Kitchakhun Somkhanngone') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('2b2f3955-49bf-5a67-8643-70307409f211', 'Aueaoangkun jadsanam') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('2b2f3955-49bf-5a67-8643-70307409f211', 'AUEAOANGKUN JADSANAM') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('1c03e3e7-ea29-526f-88b3-fd77ce113868', 'NAVATAWAN JAEMJIT') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('1c03e3e7-ea29-526f-88b3-fd77ce113868', 'Navatawan Jaemjit') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('433063e8-3178-50b1-8b3e-68470a3e8cc6', 'KITTIKPHAT SACHATO') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('433063e8-3178-50b1-8b3e-68470a3e8cc6', 'Kittikphat Sachato') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('28ed0b2b-49b3-52ff-ad02-f1f260bfac0b', 'BOONTARIKA BANTICHAT') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('28ed0b2b-49b3-52ff-ad02-f1f260bfac0b', 'Boontarika Bantichat') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('f4c93ba2-66ab-5908-99cf-59e3bdc60f4e', 'KLAOCHANOK') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('c37db018-8ee6-5fb6-9f82-a0eb82fa9b61', 'T') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('f3e4cce1-2a81-4794-ba02-a570d43efb21', 'SUTNINAN NAKPASOM') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('f3e4cce1-2a81-4794-ba02-a570d43efb21', 'Sutninan Nakpasom') ON CONFLICT DO NOTHING;

  -- Step 3: Insert 24 regatta results, participants, and race scores
  -- [0] YA ZHANG (acdc-cup-international-2025, rank 10)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '05120608-6374-414d-a162-af2bb3a6367b', '51a8b92d-74d1-52a1-bf87-4328eb92040c', 'b4595995-1be5-505f-b1a9-5cb00005c04b', 10, 95.0, 121.0,
    false, false, 'F', 'CHN',
    'https://www.racingrulesofsailing.org/documents/134936', 'ACDC Cup 2025 — Optimist Silver results', 'pdf', 'Identity resolved: Source-faithful profile created for Ya Zhang (Qingdao, CHN, sail CHN122).',
    'verified', now(), 'YA ZHANG', 'CHN122',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '82df4ae1-19d1-4262-934b-180edbbd1963', '05120608-6374-414d-a162-af2bb3a6367b', '51a8b92d-74d1-52a1-bf87-4328eb92040c', 'YA ZHANG', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('05120608-6374-414d-a162-af2bb3a6367b', 1, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('05120608-6374-414d-a162-af2bb3a6367b', 2, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('05120608-6374-414d-a162-af2bb3a6367b', 3, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('05120608-6374-414d-a162-af2bb3a6367b', 4, 13.0, NULL, false, '13.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('05120608-6374-414d-a162-af2bb3a6367b', 5, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('05120608-6374-414d-a162-af2bb3a6367b', 6, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('05120608-6374-414d-a162-af2bb3a6367b', 7, 26.0, NULL, true, '(26.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('05120608-6374-414d-a162-af2bb3a6367b', 8, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('05120608-6374-414d-a162-af2bb3a6367b', 9, 22.0, NULL, false, '22.0');

  -- [1] KUNPICHET PANCHANG (acdc-cup-international-2025, rank 11)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '05a16e48-fb96-4b39-b851-314e6b0e0082', '97050c23-371f-427e-a571-e20486cbb936', 'b4595995-1be5-505f-b1a9-5cb00005c04b', 11, 98.0, 118.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/134936', 'ACDC Cup 2025 — Optimist Silver results', 'pdf', 'Identity resolved: Matches existing profile Kulpichet Phanchang (RNSC, THA). Romanisation variant Kunpichet Panchang.',
    'verified', now(), 'KUNPICHET PANCHANG', 'THA798',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '61c09d2e-7af3-4abd-b127-ea6057c3f9a1', '05a16e48-fb96-4b39-b851-314e6b0e0082', '97050c23-371f-427e-a571-e20486cbb936', 'KUNPICHET PANCHANG', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('05a16e48-fb96-4b39-b851-314e6b0e0082', 1, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('05a16e48-fb96-4b39-b851-314e6b0e0082', 2, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('05a16e48-fb96-4b39-b851-314e6b0e0082', 3, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('05a16e48-fb96-4b39-b851-314e6b0e0082', 4, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('05a16e48-fb96-4b39-b851-314e6b0e0082', 5, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('05a16e48-fb96-4b39-b851-314e6b0e0082', 6, 20.0, NULL, true, '(20.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('05a16e48-fb96-4b39-b851-314e6b0e0082', 7, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('05a16e48-fb96-4b39-b851-314e6b0e0082', 8, 18.0, NULL, false, '18.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('05a16e48-fb96-4b39-b851-314e6b0e0082', 9, 7.0, NULL, false, '7.0');

  -- [2] KAUNG KHANT KO (acdc-cup-international-2025, rank 21)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '2aba1cbf-b826-487f-83c4-0eacd997e1e3', '611ef739-d28b-57c3-b6fe-183b006a2a38', 'b4595995-1be5-505f-b1a9-5cb00005c04b', 21, 148.0, 191.0,
    false, false, 'M', 'MYA',
    'https://www.racingrulesofsailing.org/documents/134936', 'ACDC Cup 2025 — Optimist Silver results', 'pdf', 'Identity resolved: Matches existing profile Kaung Khant Khant Ko (YSC, MYA). Naming variant Kaung Khant Ko.',
    'verified', now(), 'KAUNG KHANT KO', 'MYA277',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'fa1f2a54-c131-43ac-8ddb-02cb377b90b0', '2aba1cbf-b826-487f-83c4-0eacd997e1e3', '611ef739-d28b-57c3-b6fe-183b006a2a38', 'KAUNG KHANT KO', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2aba1cbf-b826-487f-83c4-0eacd997e1e3', 1, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2aba1cbf-b826-487f-83c4-0eacd997e1e3', 2, 29.0, NULL, false, '29.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2aba1cbf-b826-487f-83c4-0eacd997e1e3', 3, 18.0, NULL, false, '18.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2aba1cbf-b826-487f-83c4-0eacd997e1e3', 4, 24.0, NULL, false, '24.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2aba1cbf-b826-487f-83c4-0eacd997e1e3', 5, 43.0, NULL, true, '(43.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2aba1cbf-b826-487f-83c4-0eacd997e1e3', 6, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2aba1cbf-b826-487f-83c4-0eacd997e1e3', 7, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2aba1cbf-b826-487f-83c4-0eacd997e1e3', 8, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2aba1cbf-b826-487f-83c4-0eacd997e1e3', 9, 11.0, NULL, false, '11.0');

  -- [3] DUANGDUENG WICHAI (acdc-cup-international-2025, rank 24)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '44a0a968-2715-49c7-9d3e-6e68d075e8c7', 'dfefca66-a570-5f96-bec6-eb566501bdbb', 'b4595995-1be5-505f-b1a9-5cb00005c04b', 24, 175.0, 227.0,
    false, false, 'F', 'THA',
    'https://www.racingrulesofsailing.org/documents/134936', 'ACDC Cup 2025 — Optimist Silver results', 'pdf', 'Identity resolved: Matches existing profile Duangdeuen Wichai (RNSC, THA). Romanisation variant Duangdueng.',
    'verified', now(), 'DUANGDUENG WICHAI', 'THA723',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '345189a5-b98c-41f5-b864-feb2688ca849', '44a0a968-2715-49c7-9d3e-6e68d075e8c7', 'dfefca66-a570-5f96-bec6-eb566501bdbb', 'DUANGDUENG WICHAI', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('44a0a968-2715-49c7-9d3e-6e68d075e8c7', 1, 33.0, NULL, false, '33.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('44a0a968-2715-49c7-9d3e-6e68d075e8c7', 2, 19.0, NULL, false, '19.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('44a0a968-2715-49c7-9d3e-6e68d075e8c7', 3, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('44a0a968-2715-49c7-9d3e-6e68d075e8c7', 4, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('44a0a968-2715-49c7-9d3e-6e68d075e8c7', 5, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('44a0a968-2715-49c7-9d3e-6e68d075e8c7', 6, 52.0, 'UFD', true, '(52.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('44a0a968-2715-49c7-9d3e-6e68d075e8c7', 7, 31.0, NULL, false, '31.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('44a0a968-2715-49c7-9d3e-6e68d075e8c7', 8, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('44a0a968-2715-49c7-9d3e-6e68d075e8c7', 9, 23.0, NULL, false, '23.0');

  -- [4] NAVATAWAN Jaemjit (acdc-cup-international-2025, rank 25)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '7ee270fb-e1eb-4ca6-990e-5fa4b526ef6c', '1c03e3e7-ea29-526f-88b3-fd77ce113868', 'b4595995-1be5-505f-b1a9-5cb00005c04b', 25, 176.0, 211.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/134936', 'ACDC Cup 2025 — Optimist Silver results', 'pdf', 'Identity resolved: Matches existing profile Navatawan Jeanjit (RTFYC, THA, sail 1979).',
    'verified', now(), 'NAVATAWAN Jaemjit', '(R)THA1979',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '66112256-5f6a-4056-8402-59ebcd3ec33f', '7ee270fb-e1eb-4ca6-990e-5fa4b526ef6c', '1c03e3e7-ea29-526f-88b3-fd77ce113868', 'NAVATAWAN Jaemjit', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('7ee270fb-e1eb-4ca6-990e-5fa4b526ef6c', 1, 35.0, NULL, true, '(35.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('7ee270fb-e1eb-4ca6-990e-5fa4b526ef6c', 2, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('7ee270fb-e1eb-4ca6-990e-5fa4b526ef6c', 3, 19.0, NULL, false, '19.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('7ee270fb-e1eb-4ca6-990e-5fa4b526ef6c', 4, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('7ee270fb-e1eb-4ca6-990e-5fa4b526ef6c', 5, 19.0, NULL, false, '19.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('7ee270fb-e1eb-4ca6-990e-5fa4b526ef6c', 6, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('7ee270fb-e1eb-4ca6-990e-5fa4b526ef6c', 7, 25.0, NULL, false, '25.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('7ee270fb-e1eb-4ca6-990e-5fa4b526ef6c', 8, 22.0, NULL, false, '22.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('7ee270fb-e1eb-4ca6-990e-5fa4b526ef6c', 9, 28.0, NULL, false, '28.0');

  -- [5] Kunthee Khunmuang (acdc-cup-international-2025, rank 30)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'c984353a-520b-4c58-9e41-95534b77e797', '8953feed-5a7e-4fe1-978c-7ddcb9ac3fbb', 'b4595995-1be5-505f-b1a9-5cb00005c04b', 30, 211.0, 263.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/134936', 'ACDC Cup 2025 — Optimist Silver results', 'pdf', 'Identity resolved: Matches existing profile Kanthee Khunmuang (SSA, THA, sail 54). Romanisation variant Kunthee.',
    'verified', now(), 'Kunthee Khunmuang', 'THA54',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '4a85e495-05f1-41a0-8de2-21efb91623a2', 'c984353a-520b-4c58-9e41-95534b77e797', '8953feed-5a7e-4fe1-978c-7ddcb9ac3fbb', 'Kunthee Khunmuang', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c984353a-520b-4c58-9e41-95534b77e797', 1, 32.0, NULL, false, '32.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c984353a-520b-4c58-9e41-95534b77e797', 2, 52.0, 'UFD', true, '(52.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c984353a-520b-4c58-9e41-95534b77e797', 3, 39.0, NULL, false, '39.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c984353a-520b-4c58-9e41-95534b77e797', 4, 30.0, NULL, false, '30.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c984353a-520b-4c58-9e41-95534b77e797', 5, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c984353a-520b-4c58-9e41-95534b77e797', 6, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c984353a-520b-4c58-9e41-95534b77e797', 7, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c984353a-520b-4c58-9e41-95534b77e797', 8, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c984353a-520b-4c58-9e41-95534b77e797', 9, 25.0, NULL, false, '25.0');

  -- [6] CHARIE BASNET (acdc-cup-international-2025, rank 41)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '6255d6b3-f362-40fe-99e9-d408261aa0ca', '02f7450f-b247-49cf-ba12-2f33a7f0642e', 'b4595995-1be5-505f-b1a9-5cb00005c04b', 41, 303.0, 355.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/134936', 'ACDC Cup 2025 — Optimist Silver results', 'pdf', 'Identity resolved: Matches existing profile Charlie Basnet (RNSC, THA). Source spelling typo Charie.',
    'verified', now(), 'CHARIE BASNET', 'THA115',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '4bd5821b-2cae-4d43-b078-88206ee9e099', '6255d6b3-f362-40fe-99e9-d408261aa0ca', '02f7450f-b247-49cf-ba12-2f33a7f0642e', 'CHARIE BASNET', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6255d6b3-f362-40fe-99e9-d408261aa0ca', 1, 39.0, NULL, false, '39.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6255d6b3-f362-40fe-99e9-d408261aa0ca', 2, 32.0, NULL, false, '32.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6255d6b3-f362-40fe-99e9-d408261aa0ca', 3, 30.0, NULL, false, '30.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6255d6b3-f362-40fe-99e9-d408261aa0ca', 4, 28.0, NULL, false, '28.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6255d6b3-f362-40fe-99e9-d408261aa0ca', 5, 52.0, 'UFD', true, '(52.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6255d6b3-f362-40fe-99e9-d408261aa0ca', 6, 36.0, NULL, false, '36.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6255d6b3-f362-40fe-99e9-d408261aa0ca', 7, 43.0, NULL, false, '43.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6255d6b3-f362-40fe-99e9-d408261aa0ca', 8, 52.0, 'DNC', false, '52.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6255d6b3-f362-40fe-99e9-d408261aa0ca', 9, 43.0, NULL, false, '43.0');

  -- [7] NUTTAPAT ARTTAPIYAPUN (acdc-cup-international-2025, rank 50)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '97bb1891-bb93-44ee-ac45-9f35a1fa2e3c', '729acda4-25b3-57df-b11c-2f31f9d45e52', 'b4595995-1be5-505f-b1a9-5cb00005c04b', 50, 394.0, 446.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/134936', 'ACDC Cup 2025 — Optimist Silver results', 'pdf', 'Identity resolved: Source-faithful profile created for Nuttapat Arttapiyapun (ACDC.SC, THA, sail THA187).',
    'verified', now(), 'NUTTAPAT ARTTAPIYAPUN', 'THA187',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'd0a79710-fa11-43f3-8c7d-b9e1b278eeb7', '97bb1891-bb93-44ee-ac45-9f35a1fa2e3c', '729acda4-25b3-57df-b11c-2f31f9d45e52', 'NUTTAPAT ARTTAPIYAPUN', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('97bb1891-bb93-44ee-ac45-9f35a1fa2e3c', 1, 52.0, 'DNF', true, '(52.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('97bb1891-bb93-44ee-ac45-9f35a1fa2e3c', 2, 44.0, NULL, false, '44.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('97bb1891-bb93-44ee-ac45-9f35a1fa2e3c', 3, 47.0, NULL, false, '47.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('97bb1891-bb93-44ee-ac45-9f35a1fa2e3c', 4, 48.0, NULL, false, '48.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('97bb1891-bb93-44ee-ac45-9f35a1fa2e3c', 5, 52.0, 'DNC', false, '52.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('97bb1891-bb93-44ee-ac45-9f35a1fa2e3c', 6, 47.0, NULL, false, '47.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('97bb1891-bb93-44ee-ac45-9f35a1fa2e3c', 7, 52.0, 'DNC', false, '52.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('97bb1891-bb93-44ee-ac45-9f35a1fa2e3c', 8, 52.0, 'DNC', false, '52.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('97bb1891-bb93-44ee-ac45-9f35a1fa2e3c', 9, 52.0, 'DNC', false, '52.0 DNC');

  -- [8] KHAIRUL ILZANI MOND AFENDY (acdc-cup-international-2025, rank 13)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'df28d522-104c-43d0-a4ba-e5ec9d721ac5', 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7', 'e1a64cdd-fa07-553c-bc72-e56fd1f86fee', 13, 127.0, 154.0,
    false, false, 'M', 'MAS',
    'https://www.racingrulesofsailing.org/documents/134935', 'ACDC Cup 2025 — Optimist Gold results', 'pdf', 'Identity resolved: Matches existing profile Khairul Ilzani Bin Mohd Afendy (MAS). Source spelling typo MOND vs Mohd.',
    'verified', now(), 'KHAIRUL ILZANI MOND AFENDY', 'MAS31',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '9ec76dd2-96a5-4f0f-a148-74a1c2734b86', 'df28d522-104c-43d0-a4ba-e5ec9d721ac5', 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7', 'KHAIRUL ILZANI MOND AFENDY', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('df28d522-104c-43d0-a4ba-e5ec9d721ac5', 1, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('df28d522-104c-43d0-a4ba-e5ec9d721ac5', 2, 27.0, NULL, true, '(27.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('df28d522-104c-43d0-a4ba-e5ec9d721ac5', 3, 13.0, NULL, false, '13.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('df28d522-104c-43d0-a4ba-e5ec9d721ac5', 4, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('df28d522-104c-43d0-a4ba-e5ec9d721ac5', 5, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('df28d522-104c-43d0-a4ba-e5ec9d721ac5', 6, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('df28d522-104c-43d0-a4ba-e5ec9d721ac5', 7, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('df28d522-104c-43d0-a4ba-e5ec9d721ac5', 8, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('df28d522-104c-43d0-a4ba-e5ec9d721ac5', 9, 13.0, NULL, false, '13.0');

  -- [9] MUAZ MUJAHID KHAMARUE AZUAN (acdc-cup-international-2025, rank 20)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '4eec0651-82d5-4050-8f34-d1c62ae1a61c', '2bda4fc0-b72c-4b0b-b21f-597107dc5ca8', 'e1a64cdd-fa07-553c-bc72-e56fd1f86fee', 20, 166.0, 234.0,
    false, false, 'M', 'MAS',
    'https://www.racingrulesofsailing.org/documents/134935', 'ACDC Cup 2025 — Optimist Gold results', 'pdf', 'Identity resolved: Matches existing profile Muaz Mujahid Bin Khamarul Azwan (MAS, sail 28). Transliteration variant Khamarue Azuan.',
    'verified', now(), 'MUAZ MUJAHID KHAMARUE AZUAN', 'MAS28',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '698f58e9-8868-456c-9705-2fd6112a3645', '4eec0651-82d5-4050-8f34-d1c62ae1a61c', '2bda4fc0-b72c-4b0b-b21f-597107dc5ca8', 'MUAZ MUJAHID KHAMARUE AZUAN', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4eec0651-82d5-4050-8f34-d1c62ae1a61c', 1, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4eec0651-82d5-4050-8f34-d1c62ae1a61c', 2, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4eec0651-82d5-4050-8f34-d1c62ae1a61c', 3, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4eec0651-82d5-4050-8f34-d1c62ae1a61c', 4, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4eec0651-82d5-4050-8f34-d1c62ae1a61c', 5, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4eec0651-82d5-4050-8f34-d1c62ae1a61c', 6, 35.0, NULL, false, '35.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4eec0651-82d5-4050-8f34-d1c62ae1a61c', 7, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4eec0651-82d5-4050-8f34-d1c62ae1a61c', 8, 68.0, 'UFD', true, '(68.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4eec0651-82d5-4050-8f34-d1c62ae1a61c', 9, 27.0, NULL, false, '27.0');

  -- [10] ITTIVORAKUL (acdc-cup-international-2025, rank 21)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '6c8ffedf-bf9d-494d-b7b3-5d6e3f8ebcff', '863b5d54-6357-50d0-b16e-75e44de37e41', 'e1a64cdd-fa07-553c-bc72-e56fd1f86fee', 21, 166.0, 206.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/134935', 'ACDC Cup 2025 — Optimist Gold results', 'pdf', 'Identity resolved: Matches existing profile Chanyachart Ittivorakul (ACDC.SC, THA, sail 1887). Source published with surname only.',
    'verified', now(), 'ITTIVORAKUL', 'THA1887',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'aa7273b4-b505-4946-9835-6bd458b376ee', '6c8ffedf-bf9d-494d-b7b3-5d6e3f8ebcff', '863b5d54-6357-50d0-b16e-75e44de37e41', 'ITTIVORAKUL', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6c8ffedf-bf9d-494d-b7b3-5d6e3f8ebcff', 1, 36.0, NULL, false, '36.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6c8ffedf-bf9d-494d-b7b3-5d6e3f8ebcff', 2, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6c8ffedf-bf9d-494d-b7b3-5d6e3f8ebcff', 3, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6c8ffedf-bf9d-494d-b7b3-5d6e3f8ebcff', 4, 18.0, NULL, false, '18.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6c8ffedf-bf9d-494d-b7b3-5d6e3f8ebcff', 5, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6c8ffedf-bf9d-494d-b7b3-5d6e3f8ebcff', 6, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6c8ffedf-bf9d-494d-b7b3-5d6e3f8ebcff', 7, 29.0, NULL, false, '29.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6c8ffedf-bf9d-494d-b7b3-5d6e3f8ebcff', 8, 25.0, NULL, false, '25.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6c8ffedf-bf9d-494d-b7b3-5d6e3f8ebcff', 9, 40.0, NULL, true, '(40.0)');

  -- [11] NIRADA SASIWATTHANAPORN (acdc-cup-international-2025, rank 36)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'b7b5990f-b159-4785-9d1d-005d17b548d1', 'fd3c4362-b9e5-4fce-bac2-01232f20d014', 'e1a64cdd-fa07-553c-bc72-e56fd1f86fee', 36, 263.0, 308.0,
    false, false, 'F', 'THA',
    'https://www.racingrulesofsailing.org/documents/134935', 'ACDC Cup 2025 — Optimist Gold results', 'pdf', 'Identity resolved: Matches existing profile Nirada Sasiwattanaporn (YRAT, THA, sail 1925). Transliteration variant Sasiwatthanaporn.',
    'verified', now(), 'NIRADA SASIWATTHANAPORN', 'THA1925',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '45b02749-ce90-4846-a41d-ad62bae6913f', 'b7b5990f-b159-4785-9d1d-005d17b548d1', 'fd3c4362-b9e5-4fce-bac2-01232f20d014', 'NIRADA SASIWATTHANAPORN', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b7b5990f-b159-4785-9d1d-005d17b548d1', 1, 24.0, NULL, false, '24.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b7b5990f-b159-4785-9d1d-005d17b548d1', 2, 35.0, NULL, false, '35.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b7b5990f-b159-4785-9d1d-005d17b548d1', 3, 30.0, NULL, false, '30.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b7b5990f-b159-4785-9d1d-005d17b548d1', 4, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b7b5990f-b159-4785-9d1d-005d17b548d1', 5, 42.0, NULL, false, '42.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b7b5990f-b159-4785-9d1d-005d17b548d1', 6, 24.0, NULL, false, '24.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b7b5990f-b159-4785-9d1d-005d17b548d1', 7, 45.0, NULL, true, '(45.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b7b5990f-b159-4785-9d1d-005d17b548d1', 8, 43.0, NULL, false, '43.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('b7b5990f-b159-4785-9d1d-005d17b548d1', 9, 38.0, NULL, false, '38.0');

  -- [12] MIA AZRAHIA MOHDAZRALD (acdc-cup-international-2025, rank 43)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '57ded7db-b850-4497-9614-8dc28b7b4bbe', '796bc25b-e641-4630-8c8d-20241e73f843', 'e1a64cdd-fa07-553c-bc72-e56fd1f86fee', 43, 284.0, 334.0,
    false, false, 'F', 'MAS',
    'https://www.racingrulesofsailing.org/documents/134935', 'ACDC Cup 2025 — Optimist Gold results', 'pdf', 'Identity resolved: Matches existing profile Mia Azrania bt Mohd Azrald (MAS). Source OCR/spelling typo Azrahia.',
    'verified', now(), 'MIA AZRAHIA MOHDAZRALD', 'MAS89',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '10337d75-ec66-4dc5-b23b-7b1c7f405c92', '57ded7db-b850-4497-9614-8dc28b7b4bbe', '796bc25b-e641-4630-8c8d-20241e73f843', 'MIA AZRAHIA MOHDAZRALD', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('57ded7db-b850-4497-9614-8dc28b7b4bbe', 1, 44.0, NULL, false, '44.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('57ded7db-b850-4497-9614-8dc28b7b4bbe', 2, 38.0, NULL, false, '38.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('57ded7db-b850-4497-9614-8dc28b7b4bbe', 3, 44.0, NULL, false, '44.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('57ded7db-b850-4497-9614-8dc28b7b4bbe', 4, 50.0, NULL, true, '(50.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('57ded7db-b850-4497-9614-8dc28b7b4bbe', 5, 35.0, NULL, false, '35.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('57ded7db-b850-4497-9614-8dc28b7b4bbe', 6, 34.0, NULL, false, '34.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('57ded7db-b850-4497-9614-8dc28b7b4bbe', 7, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('57ded7db-b850-4497-9614-8dc28b7b4bbe', 8, 33.0, NULL, false, '33.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('57ded7db-b850-4497-9614-8dc28b7b4bbe', 9, 33.0, NULL, false, '33.0');

  -- [13] Klaochanok Chatawattanasopakul (acdc-cup-international-2025, rank 59)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '919dd7cd-9425-43ed-b9db-b21321fe4bae', '04f1c65e-eeb7-4c89-9f6e-16298c33be02', 'e1a64cdd-fa07-553c-bc72-e56fd1f86fee', 59, 439.0, 504.0,
    false, false, 'F', 'THA',
    'https://www.racingrulesofsailing.org/documents/134935', 'ACDC Cup 2025 — Optimist Gold results', 'pdf', 'Identity resolved: Matches existing profile Klaochanok Chatawattanasopakun (ACDC.SC, THA, sail 3935). Final consonant variant l vs n.',
    'verified', now(), 'Klaochanok Chatawattanasopakul', 'THA3935',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'da38e561-fec4-4819-9852-1973dcadf7aa', '919dd7cd-9425-43ed-b9db-b21321fe4bae', '04f1c65e-eeb7-4c89-9f6e-16298c33be02', 'Klaochanok Chatawattanasopakul', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('919dd7cd-9425-43ed-b9db-b21321fe4bae', 1, 53.0, NULL, false, '53.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('919dd7cd-9425-43ed-b9db-b21321fe4bae', 2, 54.0, NULL, false, '54.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('919dd7cd-9425-43ed-b9db-b21321fe4bae', 3, 61.0, NULL, false, '61.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('919dd7cd-9425-43ed-b9db-b21321fe4bae', 4, 60.0, NULL, false, '60.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('919dd7cd-9425-43ed-b9db-b21321fe4bae', 5, 65.0, NULL, true, '(65.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('919dd7cd-9425-43ed-b9db-b21321fe4bae', 6, 58.0, NULL, false, '58.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('919dd7cd-9425-43ed-b9db-b21321fe4bae', 7, 57.0, NULL, false, '57.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('919dd7cd-9425-43ed-b9db-b21321fe4bae', 8, 51.0, NULL, false, '51.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('919dd7cd-9425-43ed-b9db-b21321fe4bae', 9, 45.0, NULL, false, '45.0');

  -- [14] NITHATSANA RODNUN (acdc-cup-international-2025, rank 1)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '75b2ec3e-8f66-4732-867e-5fde33836997', '0788d794-c84e-5242-9da9-3d51d26e4eb7', '7a8de0db-47a2-56dc-b240-fb2b46075a12', 1, 10.0, 14.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/134934', 'ACDC Cup 2025 — ILCA 7 results', 'pdf', 'Identity resolved: Matches existing profile Nithasn Rodhnun (RTNYC, THA, sail 180177). Transliteration variant Nithatsana Rodnun.',
    'verified', now(), 'NITHATSANA RODNUN', '180177',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'bc9469ea-22a9-4825-9bbd-ad44b66cb363', '75b2ec3e-8f66-4732-867e-5fde33836997', '0788d794-c84e-5242-9da9-3d51d26e4eb7', 'NITHATSANA RODNUN', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('75b2ec3e-8f66-4732-867e-5fde33836997', 1, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('75b2ec3e-8f66-4732-867e-5fde33836997', 2, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('75b2ec3e-8f66-4732-867e-5fde33836997', 3, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('75b2ec3e-8f66-4732-867e-5fde33836997', 4, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('75b2ec3e-8f66-4732-867e-5fde33836997', 5, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('75b2ec3e-8f66-4732-867e-5fde33836997', 6, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('75b2ec3e-8f66-4732-867e-5fde33836997', 7, 4.0, 'DNS', true, '(4.0 DNS)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('75b2ec3e-8f66-4732-867e-5fde33836997', 8, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('75b2ec3e-8f66-4732-867e-5fde33836997', 9, 1.0, NULL, false, '1.0');

  -- [15] KITCHAKHUN SOMKHANNGONE (acdc-cup-international-2025, rank 4)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '06dd7f4d-efc6-4ce8-a83d-e7cd291cd605', '90a471f5-bd58-400f-a995-e115951ee1ed', 'b8d4edd6-9059-579b-84f9-30198597f440', 4, 32.0, 38.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/134932', 'ACDC Cup 2025 — ILCA 4 results', 'pdf', 'Identity resolved: Matches existing profile Kiitchakhun Somkhanngoen (YRAT, THA). Romanisation variant Somkhanngone.',
    'verified', now(), 'KITCHAKHUN SOMKHANNGONE', '21738',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '81dc6f31-28dd-4ded-b0f5-d511b1f3847e', '06dd7f4d-efc6-4ce8-a83d-e7cd291cd605', '90a471f5-bd58-400f-a995-e115951ee1ed', 'KITCHAKHUN SOMKHANNGONE', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('06dd7f4d-efc6-4ce8-a83d-e7cd291cd605', 1, 6.0, NULL, true, '(6.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('06dd7f4d-efc6-4ce8-a83d-e7cd291cd605', 2, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('06dd7f4d-efc6-4ce8-a83d-e7cd291cd605', 3, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('06dd7f4d-efc6-4ce8-a83d-e7cd291cd605', 4, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('06dd7f4d-efc6-4ce8-a83d-e7cd291cd605', 5, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('06dd7f4d-efc6-4ce8-a83d-e7cd291cd605', 6, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('06dd7f4d-efc6-4ce8-a83d-e7cd291cd605', 7, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('06dd7f4d-efc6-4ce8-a83d-e7cd291cd605', 8, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('06dd7f4d-efc6-4ce8-a83d-e7cd291cd605', 9, 3.0, NULL, false, '3.0');

  -- [16] Aueaoangkun jadsanam (acdc-cup-international-2025, rank 1)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '98cec31d-0131-4347-87f6-d8840ae0d5d0', '2b2f3955-49bf-5a67-8643-70307409f211', 'a62775e2-103c-52f9-827a-e4e01066e2d4', 1, 8.0, 10.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/134933', 'ACDC Cup 2025 — ILCA 6 results', 'pdf', 'Identity resolved: Matches existing profile Aueangkun Jadsanam (ACDC SC, THA, sail 9). Romanisation variant Aueaoangkun.',
    'verified', now(), 'Aueaoangkun jadsanam', '9',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '98b3fb16-2a19-4085-8478-b38e7a378001', '98cec31d-0131-4347-87f6-d8840ae0d5d0', '2b2f3955-49bf-5a67-8643-70307409f211', 'Aueaoangkun jadsanam', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('98cec31d-0131-4347-87f6-d8840ae0d5d0', 1, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('98cec31d-0131-4347-87f6-d8840ae0d5d0', 2, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('98cec31d-0131-4347-87f6-d8840ae0d5d0', 3, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('98cec31d-0131-4347-87f6-d8840ae0d5d0', 4, 2.0, NULL, true, '(2.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('98cec31d-0131-4347-87f6-d8840ae0d5d0', 5, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('98cec31d-0131-4347-87f6-d8840ae0d5d0', 6, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('98cec31d-0131-4347-87f6-d8840ae0d5d0', 7, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('98cec31d-0131-4347-87f6-d8840ae0d5d0', 8, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('98cec31d-0131-4347-87f6-d8840ae0d5d0', 9, 1.0, NULL, false, '1.0');

  -- [17] AUEAOANGKUN JADSANAM (trat-regatta-2025, rank 4)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '46ba971d-f1b4-4beb-80a7-320f6dbc7c00', '2b2f3955-49bf-5a67-8643-70307409f211', 'b8df6f6f-d18a-52db-a03b-7b0e96603c00', 4, 14.0, 14.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/141363', 'Trat Regatta 2025 — ILCA 6 results', 'pdf', 'Identity resolved: Matches existing profile Aueangkun Jadsanam (ACDC.SC, THA).',
    'verified', now(), 'AUEAOANGKUN JADSANAM', 'NO. NUM',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'c465d45f-9f14-49f2-8cdb-b1a5bd21654f', '46ba971d-f1b4-4beb-80a7-320f6dbc7c00', '2b2f3955-49bf-5a67-8643-70307409f211', 'AUEAOANGKUN JADSANAM', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('46ba971d-f1b4-4beb-80a7-320f6dbc7c00', 1, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('46ba971d-f1b4-4beb-80a7-320f6dbc7c00', 2, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('46ba971d-f1b4-4beb-80a7-320f6dbc7c00', 3, 5.0, NULL, false, '5.0');

  -- [18] NAVATAWAN JAEMJIT (trat-regatta-2025, rank 3)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '3ce119b3-8297-4a2a-b5ca-9f78779cb085', '1c03e3e7-ea29-526f-88b3-fd77ce113868', '7ad27b8b-7df1-5229-b0e6-9e7cb7d2c24e', 3, 11.0, 11.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/141365', 'Trat Regatta 2025 — Optimist Silver results', 'pdf', 'Identity resolved: Matches existing profile Navatawan Jeanjit (MRS.SC., THA, sail 1979).',
    'verified', now(), 'NAVATAWAN JAEMJIT', 'THA1979',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '83989c4a-1258-4704-9f22-5f69d8e51cc1', '3ce119b3-8297-4a2a-b5ca-9f78779cb085', '1c03e3e7-ea29-526f-88b3-fd77ce113868', 'NAVATAWAN JAEMJIT', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('3ce119b3-8297-4a2a-b5ca-9f78779cb085', 1, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('3ce119b3-8297-4a2a-b5ca-9f78779cb085', 2, 9.0, NULL, false, '9.0');

  -- [19] KITTIKPHAT SACHATO (trat-regatta-2025, rank 9)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'f2aeac13-9f2f-4366-88e4-e19ce0559ae3', '433063e8-3178-50b1-8b3e-68470a3e8cc6', '7ad27b8b-7df1-5229-b0e6-9e7cb7d2c24e', 9, 19.0, 19.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/141365', 'Trat Regatta 2025 — Optimist Silver results', 'pdf', 'Identity resolved: Matches existing profile Kittiphat Sachato (YRAT, THA, sail NZL4529). Source spelling variant Kittikphat.',
    'verified', now(), 'KITTIKPHAT SACHATO', 'NZL4529',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '382ca8ba-6279-4176-b4c3-c1f9ad440c2d', 'f2aeac13-9f2f-4366-88e4-e19ce0559ae3', '433063e8-3178-50b1-8b3e-68470a3e8cc6', 'KITTIKPHAT SACHATO', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f2aeac13-9f2f-4366-88e4-e19ce0559ae3', 1, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f2aeac13-9f2f-4366-88e4-e19ce0559ae3', 2, 16.0, NULL, false, '16.0');

  -- [20] BOONTARIKA BANTICHAT (trat-regatta-2025, rank 19)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '9fa70baa-a308-45e8-95be-e3af36db2f2f', '28ed0b2b-49b3-52ff-ad02-f1f260bfac0b', '7ad27b8b-7df1-5229-b0e6-9e7cb7d2c24e', 19, 39.0, 39.0,
    false, false, 'F', 'THA',
    'https://www.racingrulesofsailing.org/documents/141365', 'Trat Regatta 2025 — Optimist Silver results', 'pdf', 'Identity resolved: Matches existing profile Boontarik Bantichat (MRS.SC, THA). Source name variant Boontarika.',
    'verified', now(), 'BOONTARIKA BANTICHAT', '53',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'de863027-5925-43ca-938a-d8cd3c819320', '9fa70baa-a308-45e8-95be-e3af36db2f2f', '28ed0b2b-49b3-52ff-ad02-f1f260bfac0b', 'BOONTARIKA BANTICHAT', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('9fa70baa-a308-45e8-95be-e3af36db2f2f', 1, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('9fa70baa-a308-45e8-95be-e3af36db2f2f', 2, 19.0, NULL, false, '19.0');

  -- [21] KLAOCHANOK (trat-regatta-2025, rank 25)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'a984fdcd-a803-40b6-a7e7-ec53e81a7507', 'f4c93ba2-66ab-5908-99cf-59e3bdc60f4e', '7ad27b8b-7df1-5229-b0e6-9e7cb7d2c24e', 25, 94.0, 94.0,
    false, false, 'F', 'THA',
    'https://www.racingrulesofsailing.org/documents/141365', 'Trat Regatta 2025 — Optimist Silver results', 'pdf', 'Identity resolved: Source-faithful profile created for unstarted entry Klaochanok (YRAT, DNC entry).',
    'verified', now(), 'KLAOCHANOK', '',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '4bfb25f5-be71-4196-84a0-93436406a85f', 'a984fdcd-a803-40b6-a7e7-ec53e81a7507', 'f4c93ba2-66ab-5908-99cf-59e3bdc60f4e', 'KLAOCHANOK', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a984fdcd-a803-40b6-a7e7-ec53e81a7507', 1, 47.0, 'DNC', false, '47.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a984fdcd-a803-40b6-a7e7-ec53e81a7507', 2, 47.0, 'DNC', false, '47.0 DNC');

  -- [22] T (trat-regatta-2025, rank 25)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '7760f947-9496-4fe3-8d1e-8b092a3f7c89', 'c37db018-8ee6-5fb6-9f82-a0eb82fa9b61', '7ad27b8b-7df1-5229-b0e6-9e7cb7d2c24e', 25, 94.0, 94.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/141365', 'Trat Regatta 2025 — Optimist Silver results', 'pdf', 'Identity resolved: Source-faithful profile created for unstarted entry T (YRAT, DNC entry).',
    'verified', now(), 'T', '',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '628686e4-33fe-4fff-9cc8-b705ab0268f3', '7760f947-9496-4fe3-8d1e-8b092a3f7c89', 'c37db018-8ee6-5fb6-9f82-a0eb82fa9b61', 'T', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('7760f947-9496-4fe3-8d1e-8b092a3f7c89', 1, 47.0, 'DNC', false, '47.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('7760f947-9496-4fe3-8d1e-8b092a3f7c89', 2, 47.0, 'DNC', false, '47.0 DNC');

  -- [23] SUTNINAN NAKPASOM (trat-regatta-2025, rank 25)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '45413f23-8266-48f2-b09c-fb53d8d564de', 'f3e4cce1-2a81-4794-ba02-a570d43efb21', '7ad27b8b-7df1-5229-b0e6-9e7cb7d2c24e', 25, 94.0, 94.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/141365', 'Trat Regatta 2025 — Optimist Silver results', 'pdf', 'Identity resolved: Matches existing profile Suthinan Nakpasom (YRAT, THA, sail 1987). Source spelling variant Sutninan.',
    'verified', now(), 'SUTNINAN NAKPASOM', 'THA 1987',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '0bba3cad-ee9c-401b-9b2a-7a3711255ac5', '45413f23-8266-48f2-b09c-fb53d8d564de', 'f3e4cce1-2a81-4794-ba02-a570d43efb21', 'SUTNINAN NAKPASOM', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('45413f23-8266-48f2-b09c-fb53d8d564de', 1, 47.0, 'DNC', false, '47.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('45413f23-8266-48f2-b09c-fb53d8d564de', 2, 47.0, 'DNC', false, '47.0 DNC');

  -- Step 4: Verify final counts on all 7 affected sheets
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_acdc_ilca4;
  IF v_count != 16 THEN RAISE EXCEPTION 'Expected 16 results on acdc_ilca4, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_acdc_ilca6;
  IF v_count != 3 THEN RAISE EXCEPTION 'Expected 3 results on acdc_ilca6, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_acdc_ilca7;
  IF v_count != 3 THEN RAISE EXCEPTION 'Expected 3 results on acdc_ilca7, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_acdc_opti_gold;
  IF v_count != 67 THEN RAISE EXCEPTION 'Expected 67 results on acdc_opti_gold, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_acdc_opti_silver;
  IF v_count != 51 THEN RAISE EXCEPTION 'Expected 51 results on acdc_opti_silver, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_trat_ilca6;
  IF v_count != 9 THEN RAISE EXCEPTION 'Expected 9 results on trat_ilca6, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_trat_opti_silver;
  IF v_count != 46 THEN RAISE EXCEPTION 'Expected 46 results on trat_opti_silver, found %', v_count; END IF;

  -- Step 5: Update schedule_notes to reflect complete imports
  UPDATE public.regattas
  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 16 of 16 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_acdc_ilca4;

  UPDATE public.regattas
  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 3 of 3 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_acdc_ilca6;

  UPDATE public.regattas
  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 3 of 3 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_acdc_ilca7;

  UPDATE public.regattas
  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 67 of 67 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_acdc_opti_gold;

  UPDATE public.regattas
  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 51 of 51 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_acdc_opti_silver;

  UPDATE public.regattas
  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 9 of 9 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_trat_ilca6;

  UPDATE public.regattas
  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 46 of 46 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_trat_opti_silver;

  -- Step 6: Audit logging
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source) VALUES
    ('results.resolve_identity', 'regatta', v_acdc_ilca4, 'acdc-cup-international-2025-ilca4', 'Resolved 1 held entry (Kiitchakhun Somkhanngoen). Sheet is 100% complete (16/16).', '{"resolved_count": 1}'::jsonb, 'acdc-trat-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_acdc_ilca6, 'acdc-cup-international-2025-ilca6', 'Resolved 1 held entry (Aueangkun Jadsanam). Sheet is 100% complete (3/3).', '{"resolved_count": 1}'::jsonb, 'acdc-trat-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_acdc_ilca7, 'acdc-cup-international-2025-ilca7', 'Resolved 1 held entry (Nithasn Rodhnun). Sheet is 100% complete (3/3).', '{"resolved_count": 1}'::jsonb, 'acdc-trat-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_acdc_opti_gold, 'acdc-cup-international-2025-optimist-gold', 'Resolved 6 held entries. Sheet is 100% complete (67/67).', '{"resolved_count": 6}'::jsonb, 'acdc-trat-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_acdc_opti_silver, 'acdc-cup-international-2025-optimist-silver', 'Resolved 8 held entries. Sheet is 100% complete (51/51).', '{"resolved_count": 8}'::jsonb, 'acdc-trat-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_trat_ilca6, 'trat-regatta-2025-ilca6', 'Resolved 1 held entry (Aueangkun Jadsanam). Sheet is 100% complete (9/9).', '{"resolved_count": 1}'::jsonb, 'acdc-trat-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_trat_opti_silver, 'trat-regatta-2025-optimist-silver', 'Resolved 6 held entries. Sheet is 100% complete (46/46).', '{"resolved_count": 6}'::jsonb, 'acdc-trat-2025-resolution-2026-11-12');

END $resolve$;
COMMIT;
