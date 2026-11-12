-- SEA Games & Pre-SEA Games 2025: Resolution of 15 held entries across 7 sheets
BEGIN;
DO $resolve$
DECLARE
  v_pre_ilca4_girls uuid := '869a681e-7bb1-5f34-bb98-7f5658dc1091';
  v_pre_opti_boys uuid := '68fee56a-f7ec-5e48-bc9d-6e3fe3716379';
  v_pre_opti_girls uuid := 'b9a09331-71de-5250-a8f2-ad989781c8a9';
  v_sea_ilca4_boys uuid := 'ea6be3b0-32e9-51bf-a164-43643891f486';
  v_sea_ilca4_girls uuid := '42879c98-f145-5ab7-9595-36615d5fafb1';
  v_sea_opti_boys uuid := 'dd5239ba-7bf5-591a-802c-0340070c591d';
  v_sea_opti_girls uuid := 'ad71e545-0b78-5aac-aeeb-555a916747d0';
  v_count int;
BEGIN
  PERFORM pg_advisory_xact_lock(hashtextextended('sea-games-2025-resolution', 0));

  -- Verify current result counts on the 7 sheets
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_pre_ilca4_girls;
  IF v_count != 7 THEN RAISE EXCEPTION 'Expected 7 results on pre_ilca4_girls, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_pre_opti_boys;
  IF v_count != 35 THEN RAISE EXCEPTION 'Expected 35 results on pre_opti_boys, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_pre_opti_girls;
  IF v_count != 23 THEN RAISE EXCEPTION 'Expected 23 results on pre_opti_girls, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sea_ilca4_boys;
  IF v_count != 4 THEN RAISE EXCEPTION 'Expected 4 results on sea_ilca4_boys, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sea_ilca4_girls;
  IF v_count != 4 THEN RAISE EXCEPTION 'Expected 4 results on sea_ilca4_girls, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sea_opti_boys;
  IF v_count != 5 THEN RAISE EXCEPTION 'Expected 5 results on sea_opti_boys, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sea_opti_girls;
  IF v_count != 4 THEN RAISE EXCEPTION 'Expected 4 results on sea_opti_girls, found %', v_count; END IF;

  -- Step 1: Register aliases for matched sailors
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('3a2198bc-fe35-49c3-a5ba-2a32a35c81c6', 'MUHAMMAD YAASIN SYAHRIZAN') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('3a2198bc-fe35-49c3-a5ba-2a32a35c81c6', 'Muhammad Yaasin Syahrizan') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('3d2fede9-5b4d-444d-9eb1-49d05991d128', 'AUNG SITT MOUNG') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('3d2fede9-5b4d-444d-9eb1-49d05991d128', 'Aung Sitt Moung') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('d4115422-92eb-49c1-b0fe-92da82fd4957', 'LYDIA HANNAH JASMINE LUKMAN') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('d4115422-92eb-49c1-b0fe-92da82fd4957', 'Lydia Hannah Jasmine Lukman') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('7b927e81-db43-6629-1296-8e09329a33d5', 'DANIELA SOPHIA MAYOR') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('7b927e81-db43-6629-1296-8e09329a33d5', 'Daniela Sophia Mayor') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('ffa6f01a-8891-4c9a-a169-33a1008ecd31', 'IQBAL NAZHAM MUSMULIADI') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('ffa6f01a-8891-4c9a-a169-33a1008ecd31', 'Iqbal Nazham Musmuliadi') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('a6963324-b0a4-56dc-94f5-f78816b28b6b', 'MARK ADREY AMADEO') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('a6963324-b0a4-56dc-94f5-f78816b28b6b', 'Mark Adrey Amadeo') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('b33f7ace-2a40-5394-8858-007b26ae3163', 'NUR ZAFRINA SYUHADA MOHD ZAILAN') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('b33f7ace-2a40-5394-8858-007b26ae3163', 'Nur Zafrina Syuhada Mohd Zailan') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('20af3d01-7d86-4111-bad1-0c2be026e039', 'NIA ZAHADI') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('20af3d01-7d86-4111-bad1-0c2be026e039', 'Nia Zahadi') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('c4e262cc-1d16-4e95-90a0-c168b25c2de1', 'EHAN LEE') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('c4e262cc-1d16-4e95-90a0-c168b25c2de1', 'Ehan Lee') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('644b1498-1f04-4e1e-b7a0-f2bd29f874d7', 'DANIAN HUANG') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('644b1498-1f04-4e1e-b7a0-f2bd29f874d7', 'Danian Huang') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('e4c77476-aeef-45b2-b905-495b594b1353', 'NAPAPHAT/BUASUANG') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('e4c77476-aeef-45b2-b905-495b594b1353', 'Napaphat Buasuang') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('e4c77476-aeef-45b2-b905-495b594b1353', 'Napaphat/Buasuang') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('3b9072c4-2980-4557-b1f1-b9993c803824', 'SURAPA MUANGNGAM') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('3b9072c4-2980-4557-b1f1-b9993c803824', 'Surapa Muangngam') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('b6cda8c3-5a90-4a1d-88d6-b0f52996cab7', 'DHAMAPORN ARUNO') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('b6cda8c3-5a90-4a1d-88d6-b0f52996cab7', 'Dhamaporn Aruno') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('6d6d7dd3-8b95-4230-af00-01321a224c3e', 'SURATSAYAPORN KAEWRAKUM') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('6d6d7dd3-8b95-4230-af00-01321a224c3e', 'Suratsayaporn Kaewrakum') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('9122c3b5-7b7d-43c1-ab7b-c5d2d2f2fb96', 'ARAYA KLANGMUEANG') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('9122c3b5-7b7d-43c1-ab7b-c5d2d2f2fb96', 'Araya Klangmueang') ON CONFLICT DO NOTHING;

  -- Step 2: Insert the 15 held results, participants, and race results
  -- Entry 1: MUHAMMAD YAASIN SYAHRIZAN (sea-games-2025 Optimist - Rank 3)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    'c173a9ff-3f09-5b32-be5f-8ede81a6f02d', '3a2198bc-fe35-49c3-a5ba-2a32a35c81c6', 'dd5239ba-7bf5-591a-802c-0340070c591d', 'MUHAMMAD YAASIN SYAHRIZAN', 'MAS 115', 'individual',
    3, 33.0, 27.0, 'M', 'MAS', false, false,
    'https://www.racingrulesofsailing.org/documents/170952', 'https://www.racingrulesofsailing.org/documents/170952', '33rd SEA Games 2025 — Sailing — Optimist Boys results', 'pdf', 'Identity resolved: Matches existing profile Muhammad Yaasin Bin Syahrizan (MAS, sail 115, bronze medalist). Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    '240a4ab5-3526-53fa-abd8-e958dd3c6555', 'c173a9ff-3f09-5b32-be5f-8ede81a6f02d', '3a2198bc-fe35-49c3-a5ba-2a32a35c81c6', 'MUHAMMAD YAASIN SYAHRIZAN', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c173a9ff-3f09-5b32-be5f-8ede81a6f02d', 1, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c173a9ff-3f09-5b32-be5f-8ede81a6f02d', 2, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c173a9ff-3f09-5b32-be5f-8ede81a6f02d', 3, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c173a9ff-3f09-5b32-be5f-8ede81a6f02d', 4, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c173a9ff-3f09-5b32-be5f-8ede81a6f02d', 5, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c173a9ff-3f09-5b32-be5f-8ede81a6f02d', 6, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c173a9ff-3f09-5b32-be5f-8ede81a6f02d', 7, 6.0, NULL, true, '(6.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c173a9ff-3f09-5b32-be5f-8ede81a6f02d', 8, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c173a9ff-3f09-5b32-be5f-8ede81a6f02d', 9, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c173a9ff-3f09-5b32-be5f-8ede81a6f02d', 10, 2.0, NULL, false, '2.0');

  -- Entry 2: AUNG SITT MOUNG (sea-games-2025 Optimist - Rank 5)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    '3bc7f351-9dc9-5799-b959-869d9ddcd2bc', '3d2fede9-5b4d-444d-9eb1-49d05991d128', 'dd5239ba-7bf5-591a-802c-0340070c591d', 'AUNG SITT MOUNG', 'MYA 1', 'individual',
    5, 40.0, 34.0, 'M', 'MYA', false, false,
    'https://www.racingrulesofsailing.org/documents/170952', 'https://www.racingrulesofsailing.org/documents/170952', '33rd SEA Games 2025 — Sailing — Optimist Boys results', 'pdf', 'Identity resolved: Matches existing profile Aung Sitt Maung (Yangon Sailing Club, MYA). Transliteration variant Moung vs Maung. Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    '9c8e7d7f-e359-59fa-95f7-68d04c61b349', '3bc7f351-9dc9-5799-b959-869d9ddcd2bc', '3d2fede9-5b4d-444d-9eb1-49d05991d128', 'AUNG SITT MOUNG', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('3bc7f351-9dc9-5799-b959-869d9ddcd2bc', 1, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('3bc7f351-9dc9-5799-b959-869d9ddcd2bc', 2, 6.0, NULL, true, '(6.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('3bc7f351-9dc9-5799-b959-869d9ddcd2bc', 3, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('3bc7f351-9dc9-5799-b959-869d9ddcd2bc', 4, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('3bc7f351-9dc9-5799-b959-869d9ddcd2bc', 5, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('3bc7f351-9dc9-5799-b959-869d9ddcd2bc', 6, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('3bc7f351-9dc9-5799-b959-869d9ddcd2bc', 7, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('3bc7f351-9dc9-5799-b959-869d9ddcd2bc', 8, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('3bc7f351-9dc9-5799-b959-869d9ddcd2bc', 9, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('3bc7f351-9dc9-5799-b959-869d9ddcd2bc', 10, 5.0, NULL, false, '5.0');

  -- Entry 3: LYDIA HANNAH JASMINE LUKMAN (sea-games-2025 Optimist - Rank 3)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    '24736a55-d6ec-5722-bf7f-d8dfebf69489', 'd4115422-92eb-49c1-b0fe-92da82fd4957', 'ad71e545-0b78-5aac-aeeb-555a916747d0', 'LYDIA HANNAH JASMINE LUKMAN', 'MAS 112', 'individual',
    3, 33.0, 28.0, 'F', 'MAS', false, false,
    'https://www.racingrulesofsailing.org/documents/170952', 'https://www.racingrulesofsailing.org/documents/170952', '33rd SEA Games 2025 — Sailing — Optimist Girls results', 'pdf', 'Identity resolved: Matches existing profile Lydia Hannah Jasmine Binti Lukman (MAS, sail 112, bronze medalist). Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    'b0d5cd5e-3acd-5ce0-bbe7-579b66a02eed', '24736a55-d6ec-5722-bf7f-d8dfebf69489', 'd4115422-92eb-49c1-b0fe-92da82fd4957', 'LYDIA HANNAH JASMINE LUKMAN', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('24736a55-d6ec-5722-bf7f-d8dfebf69489', 1, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('24736a55-d6ec-5722-bf7f-d8dfebf69489', 2, 5.0, NULL, true, '(5.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('24736a55-d6ec-5722-bf7f-d8dfebf69489', 3, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('24736a55-d6ec-5722-bf7f-d8dfebf69489', 4, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('24736a55-d6ec-5722-bf7f-d8dfebf69489', 5, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('24736a55-d6ec-5722-bf7f-d8dfebf69489', 6, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('24736a55-d6ec-5722-bf7f-d8dfebf69489', 7, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('24736a55-d6ec-5722-bf7f-d8dfebf69489', 8, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('24736a55-d6ec-5722-bf7f-d8dfebf69489', 9, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('24736a55-d6ec-5722-bf7f-d8dfebf69489', 10, 3.0, NULL, false, '3.0');

  -- Entry 4: DANIELA SOPHIA MAYOR (sea-games-2025 Optimist - Rank 5)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    'ffc79f36-ea70-5760-8cb1-f0c5c33f6a3a', '7b927e81-db43-6629-1296-8e09329a33d5', 'ad71e545-0b78-5aac-aeeb-555a916747d0', 'DANIELA SOPHIA MAYOR', 'PHI 7', 'individual',
    5, 41.0, 35.0, 'F', 'PHI', false, false,
    'https://www.racingrulesofsailing.org/documents/170952', 'https://www.racingrulesofsailing.org/documents/170952', '33rd SEA Games 2025 — Sailing — Optimist Girls results', 'pdf', 'Identity resolved: Matches existing profile Daniela Mayor (PSA, PHI). Full name recorded. Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    '0664350d-d9a1-51d0-995e-2ad8017a3185', 'ffc79f36-ea70-5760-8cb1-f0c5c33f6a3a', '7b927e81-db43-6629-1296-8e09329a33d5', 'DANIELA SOPHIA MAYOR', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('ffc79f36-ea70-5760-8cb1-f0c5c33f6a3a', 1, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('ffc79f36-ea70-5760-8cb1-f0c5c33f6a3a', 2, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('ffc79f36-ea70-5760-8cb1-f0c5c33f6a3a', 3, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('ffc79f36-ea70-5760-8cb1-f0c5c33f6a3a', 4, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('ffc79f36-ea70-5760-8cb1-f0c5c33f6a3a', 5, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('ffc79f36-ea70-5760-8cb1-f0c5c33f6a3a', 6, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('ffc79f36-ea70-5760-8cb1-f0c5c33f6a3a', 7, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('ffc79f36-ea70-5760-8cb1-f0c5c33f6a3a', 8, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('ffc79f36-ea70-5760-8cb1-f0c5c33f6a3a', 9, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('ffc79f36-ea70-5760-8cb1-f0c5c33f6a3a', 10, 6.0, NULL, true, '(6.0)');

  -- Entry 5: IQBAL NAZHAM MUSMULIADI (sea-games-2025 ILCA 4 - Rank 4)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    '4d1e82fc-df83-5556-9ff7-4d79ba521f45', 'ffa6f01a-8891-4c9a-a169-33a1008ecd31', 'ea6be3b0-32e9-51bf-a164-43643891f486', 'IQBAL NAZHAM MUSMULIADI', 'MAS209887', 'individual',
    4, 32.0, 27.0, 'M', 'MAS', false, false,
    'https://www.racingrulesofsailing.org/documents/170965', 'https://www.racingrulesofsailing.org/documents/170965', '33rd SEA Games 2025 — Sailing — ILCA 4 Boys results', 'pdf', 'Identity resolved: Matches existing profile Iqbal Nazham Bin Musmuliadi (MSN/MSA, MAS). Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    '5c5ad568-a76e-55cc-904d-ad8b2e82a124', '4d1e82fc-df83-5556-9ff7-4d79ba521f45', 'ffa6f01a-8891-4c9a-a169-33a1008ecd31', 'IQBAL NAZHAM MUSMULIADI', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4d1e82fc-df83-5556-9ff7-4d79ba521f45', 1, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4d1e82fc-df83-5556-9ff7-4d79ba521f45', 2, 5.0, NULL, true, '(5.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4d1e82fc-df83-5556-9ff7-4d79ba521f45', 3, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4d1e82fc-df83-5556-9ff7-4d79ba521f45', 4, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4d1e82fc-df83-5556-9ff7-4d79ba521f45', 5, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4d1e82fc-df83-5556-9ff7-4d79ba521f45', 6, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4d1e82fc-df83-5556-9ff7-4d79ba521f45', 7, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4d1e82fc-df83-5556-9ff7-4d79ba521f45', 8, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4d1e82fc-df83-5556-9ff7-4d79ba521f45', 9, 3.0, NULL, false, '3.0');

  -- Entry 6: MARK ADREY AMADEO (sea-games-2025 ILCA 4 - Rank 5)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    '662f60bc-e902-5a87-9168-5301314346c7', 'a6963324-b0a4-56dc-94f5-f78816b28b6b', 'ea6be3b0-32e9-51bf-a164-43643891f486', 'MARK ADREY AMADEO', 'PHI225455', 'individual',
    5, 32.0, 27.0, 'M', 'PHI', false, false,
    'https://www.racingrulesofsailing.org/documents/170965', 'https://www.racingrulesofsailing.org/documents/170965', '33rd SEA Games 2025 — Sailing — ILCA 4 Boys results', 'pdf', 'Identity resolved: Matches existing profile Mark Amadeo (PSA, PHI, sail PHI225455). Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    'ad5835f5-7236-5b61-a68f-08e7ba5fcb71', '662f60bc-e902-5a87-9168-5301314346c7', 'a6963324-b0a4-56dc-94f5-f78816b28b6b', 'MARK ADREY AMADEO', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('662f60bc-e902-5a87-9168-5301314346c7', 1, 5.0, NULL, true, '(5.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('662f60bc-e902-5a87-9168-5301314346c7', 2, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('662f60bc-e902-5a87-9168-5301314346c7', 3, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('662f60bc-e902-5a87-9168-5301314346c7', 4, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('662f60bc-e902-5a87-9168-5301314346c7', 5, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('662f60bc-e902-5a87-9168-5301314346c7', 6, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('662f60bc-e902-5a87-9168-5301314346c7', 7, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('662f60bc-e902-5a87-9168-5301314346c7', 8, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('662f60bc-e902-5a87-9168-5301314346c7', 9, 4.0, NULL, false, '4.0');

  -- Entry 7: NUR ZAFRINA SYUHADA MOHD ZAILAN (sea-games-2025 ILCA 4 - Rank 2)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    '4abdeb96-1ae1-5425-af8d-5de9986329a4', 'b33f7ace-2a40-5394-8858-007b26ae3163', '42879c98-f145-5ab7-9595-36615d5fafb1', 'NUR ZAFRINA SYUHADA MOHD ZAILAN', 'MAS209888', 'individual',
    2, 27.0, 21.0, 'F', 'MAS', false, false,
    'https://www.racingrulesofsailing.org/documents/170965', 'https://www.racingrulesofsailing.org/documents/170965', '33rd SEA Games 2025 — Sailing — ILCA 4 Girls results', 'pdf', 'Identity resolved: Matches existing profile Nur Zafrina Syuhada Binti Mohd Zailan (MSN/MSA, MAS, silver medalist). Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    '0a6626e5-5fdf-51f9-93a7-e2f15718cfa6', '4abdeb96-1ae1-5425-af8d-5de9986329a4', 'b33f7ace-2a40-5394-8858-007b26ae3163', 'NUR ZAFRINA SYUHADA MOHD ZAILAN', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4abdeb96-1ae1-5425-af8d-5de9986329a4', 1, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4abdeb96-1ae1-5425-af8d-5de9986329a4', 2, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4abdeb96-1ae1-5425-af8d-5de9986329a4', 3, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4abdeb96-1ae1-5425-af8d-5de9986329a4', 4, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4abdeb96-1ae1-5425-af8d-5de9986329a4', 5, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4abdeb96-1ae1-5425-af8d-5de9986329a4', 6, 6.0, 'RET', true, '(6.0 RET)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4abdeb96-1ae1-5425-af8d-5de9986329a4', 7, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4abdeb96-1ae1-5425-af8d-5de9986329a4', 8, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4abdeb96-1ae1-5425-af8d-5de9986329a4', 9, 3.0, NULL, false, '3.0');

  -- Entry 8: NIA ZAHADI (pre-sea-games-2025 ILCA 4 - Rank 4)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    'e4be3961-068b-5fa2-b900-86c4a3495d93', '20af3d01-7d86-4111-bad1-0c2be026e039', '869a681e-7bb1-5f34-bb98-7f5658dc1091', 'NIA ZAHADI', 'SGP224245', 'individual',
    4, 40.0, 31.0, 'F', 'SGP', false, false,
    'https://www.racingrulesofsailing.org/documents/168534', 'https://www.racingrulesofsailing.org/documents/168534', 'Pre-33rd SEA Games 2025 — ILCA 4 Girls results', 'pdf', 'Identity resolved: Matches existing profile Nia Mehry Zahedi (Singapore Sailing Federation, sail 224245). Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    'd2b0fc20-64c5-5d7e-b49f-183c1ac2fc77', 'e4be3961-068b-5fa2-b900-86c4a3495d93', '20af3d01-7d86-4111-bad1-0c2be026e039', 'NIA ZAHADI', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('e4be3961-068b-5fa2-b900-86c4a3495d93', 1, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('e4be3961-068b-5fa2-b900-86c4a3495d93', 2, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('e4be3961-068b-5fa2-b900-86c4a3495d93', 3, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('e4be3961-068b-5fa2-b900-86c4a3495d93', 4, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('e4be3961-068b-5fa2-b900-86c4a3495d93', 5, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('e4be3961-068b-5fa2-b900-86c4a3495d93', 6, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('e4be3961-068b-5fa2-b900-86c4a3495d93', 7, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('e4be3961-068b-5fa2-b900-86c4a3495d93', 8, 9.0, 'UFD', true, '(9.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('e4be3961-068b-5fa2-b900-86c4a3495d93', 9, 4.0, NULL, false, '4.0');

  -- Entry 9: EHAN LEE (pre-sea-games-2025 Optimist - Rank 10)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    '39863ceb-dfd4-5736-a947-7a9048086056', 'c4e262cc-1d16-4e95-90a0-c168b25c2de1', '68fee56a-f7ec-5e48-bc9d-6e3fe3716379', 'EHAN LEE', 'SGP83', 'individual',
    10, 126.0, 87.0, 'M', 'SGP', false, false,
    'https://www.racingrulesofsailing.org/documents/168536', 'https://www.racingrulesofsailing.org/documents/168536', 'Provisional — Pre-33rd SEA Games 2025 — Optimist Boys results', 'pdf', 'Identity resolved: Matches existing profile Ethan Lee (Singapore Sailing Federation, international sail SGP 83). Typo Ehan in source table. Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    '1f2097bd-f842-5ace-8585-1c71720292e3', '39863ceb-dfd4-5736-a947-7a9048086056', 'c4e262cc-1d16-4e95-90a0-c168b25c2de1', 'EHAN LEE', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('39863ceb-dfd4-5736-a947-7a9048086056', 1, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('39863ceb-dfd4-5736-a947-7a9048086056', 2, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('39863ceb-dfd4-5736-a947-7a9048086056', 3, 39.0, 'UFD', true, '(39.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('39863ceb-dfd4-5736-a947-7a9048086056', 4, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('39863ceb-dfd4-5736-a947-7a9048086056', 5, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('39863ceb-dfd4-5736-a947-7a9048086056', 6, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('39863ceb-dfd4-5736-a947-7a9048086056', 7, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('39863ceb-dfd4-5736-a947-7a9048086056', 8, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('39863ceb-dfd4-5736-a947-7a9048086056', 9, 16.0, NULL, false, '16.0');

  -- Entry 10: DANIAN HUANG (pre-sea-games-2025 Optimist - Rank 25)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    '28dee5dd-1f8a-5531-9aed-50e4018b7546', '644b1498-1f04-4e1e-b7a0-f2bd29f874d7', '68fee56a-f7ec-5e48-bc9d-6e3fe3716379', 'DANIAN HUANG', 'SGP3300', 'individual',
    25, 206.0, 167.0, 'M', 'SGP', false, false,
    'https://www.racingrulesofsailing.org/documents/168536', 'https://www.racingrulesofsailing.org/documents/168536', 'Provisional — Pre-33rd SEA Games 2025 — Optimist Boys results', 'pdf', 'Identity resolved: Matches existing profile Damien Huang (Singapore Sailing Federation / SAFYC, sail 3300). Typo Danian in source table. Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    '856cb81c-9ad2-5110-b959-cac688bcad43', '28dee5dd-1f8a-5531-9aed-50e4018b7546', '644b1498-1f04-4e1e-b7a0-f2bd29f874d7', 'DANIAN HUANG', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('28dee5dd-1f8a-5531-9aed-50e4018b7546', 1, 39.0, 'UFD', true, '(39.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('28dee5dd-1f8a-5531-9aed-50e4018b7546', 2, 39.0, 'UFD', false, '39.0 UFD');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('28dee5dd-1f8a-5531-9aed-50e4018b7546', 3, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('28dee5dd-1f8a-5531-9aed-50e4018b7546', 4, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('28dee5dd-1f8a-5531-9aed-50e4018b7546', 5, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('28dee5dd-1f8a-5531-9aed-50e4018b7546', 6, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('28dee5dd-1f8a-5531-9aed-50e4018b7546', 7, 39.0, 'UFD', false, '39.0 UFD');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('28dee5dd-1f8a-5531-9aed-50e4018b7546', 8, 22.0, NULL, false, '22.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('28dee5dd-1f8a-5531-9aed-50e4018b7546', 9, 13.0, NULL, false, '13.0');

  -- Entry 11: NAPAPHAT/BUASUANG (pre-sea-games-2025 Optimist - Rank 36)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    '71f8cf6c-fa63-557e-a787-0732222ea85b', 'e4c77476-aeef-45b2-b905-495b594b1353', '68fee56a-f7ec-5e48-bc9d-6e3fe3716379', 'NAPAPHAT/BUASUANG', 'THA544', 'individual',
    36, 310.0, 271.0, 'M', 'THA', false, false,
    'https://www.racingrulesofsailing.org/documents/168536', 'https://www.racingrulesofsailing.org/documents/168536', 'Provisional — Pre-33rd SEA Games 2025 — Optimist Boys results', 'pdf', 'Identity resolved: Matches existing profile Napabhat Buasuang (ACDC.SC, THA). Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    '367606fc-5152-5934-9e87-776adb869818', '71f8cf6c-fa63-557e-a787-0732222ea85b', 'e4c77476-aeef-45b2-b905-495b594b1353', 'NAPAPHAT/BUASUANG', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('71f8cf6c-fa63-557e-a787-0732222ea85b', 1, 39.0, 'DNF', true, '(39.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('71f8cf6c-fa63-557e-a787-0732222ea85b', 2, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('71f8cf6c-fa63-557e-a787-0732222ea85b', 3, 34.0, NULL, false, '34.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('71f8cf6c-fa63-557e-a787-0732222ea85b', 4, 39.0, 'DNF', false, '39.0 DNF');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('71f8cf6c-fa63-557e-a787-0732222ea85b', 5, 37.0, NULL, false, '37.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('71f8cf6c-fa63-557e-a787-0732222ea85b', 6, 39.0, 'DNF', false, '39.0 DNF');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('71f8cf6c-fa63-557e-a787-0732222ea85b', 7, 29.0, NULL, false, '29.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('71f8cf6c-fa63-557e-a787-0732222ea85b', 8, 32.0, NULL, false, '32.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('71f8cf6c-fa63-557e-a787-0732222ea85b', 9, 35.0, NULL, false, '35.0');

  -- Entry 12: SURAPA MUANGNGAM (pre-sea-games-2025 Optimist - Rank 1)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    '5049150b-0806-52ff-be6b-a3ed5a7496c1', '3b9072c4-2980-4557-b1f1-b9993c803824', 'b9a09331-71de-5250-a8f2-ad989781c8a9', 'SURAPA MUANGNGAM', 'THA1941', 'individual',
    1, 21.0, 17.0, 'F', 'THA', false, false,
    'https://www.racingrulesofsailing.org/documents/168536', 'https://www.racingrulesofsailing.org/documents/168536', 'Provisional — Pre-33rd SEA Games 2025 — Optimist Girls results', 'pdf', 'Identity resolved: Matches existing profile Surapha Muangngam (YRAT, THA, sail 1941, gold medalist). Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    'e8378295-959d-5769-9f2e-894d4bfb4981', '5049150b-0806-52ff-be6b-a3ed5a7496c1', '3b9072c4-2980-4557-b1f1-b9993c803824', 'SURAPA MUANGNGAM', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5049150b-0806-52ff-be6b-a3ed5a7496c1', 1, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5049150b-0806-52ff-be6b-a3ed5a7496c1', 2, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5049150b-0806-52ff-be6b-a3ed5a7496c1', 3, 4.0, NULL, true, '(4.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5049150b-0806-52ff-be6b-a3ed5a7496c1', 4, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5049150b-0806-52ff-be6b-a3ed5a7496c1', 5, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5049150b-0806-52ff-be6b-a3ed5a7496c1', 6, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5049150b-0806-52ff-be6b-a3ed5a7496c1', 7, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5049150b-0806-52ff-be6b-a3ed5a7496c1', 8, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5049150b-0806-52ff-be6b-a3ed5a7496c1', 9, 3.0, NULL, false, '3.0');

  -- Entry 13: DHAMAPORN ARUNO (pre-sea-games-2025 Optimist - Rank 19)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    '4bdad2c4-0159-5278-a0c6-307348bd26c8', 'b6cda8c3-5a90-4a1d-88d6-b0f52996cab7', 'b9a09331-71de-5250-a8f2-ad989781c8a9', 'DHAMAPORN ARUNO', 'THA1881', 'individual',
    19, 156.0, 128.0, 'F', 'THA', false, false,
    'https://www.racingrulesofsailing.org/documents/168536', 'https://www.racingrulesofsailing.org/documents/168536', 'Provisional — Pre-33rd SEA Games 2025 — Optimist Girls results', 'pdf', 'Identity resolved: Matches existing profile Dhammaporn Aruno (ACDC.SC, THA, sail 1881). Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    '4c4595c1-4be4-552a-96cd-9c7b792114fa', '4bdad2c4-0159-5278-a0c6-307348bd26c8', 'b6cda8c3-5a90-4a1d-88d6-b0f52996cab7', 'DHAMAPORN ARUNO', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4bdad2c4-0159-5278-a0c6-307348bd26c8', 1, 28.0, 'DNF', true, '(28.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4bdad2c4-0159-5278-a0c6-307348bd26c8', 2, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4bdad2c4-0159-5278-a0c6-307348bd26c8', 3, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4bdad2c4-0159-5278-a0c6-307348bd26c8', 4, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4bdad2c4-0159-5278-a0c6-307348bd26c8', 5, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4bdad2c4-0159-5278-a0c6-307348bd26c8', 6, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4bdad2c4-0159-5278-a0c6-307348bd26c8', 7, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4bdad2c4-0159-5278-a0c6-307348bd26c8', 8, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4bdad2c4-0159-5278-a0c6-307348bd26c8', 9, 24.0, NULL, false, '24.0');

  -- Entry 14: SURATSAYAPORN KAEWRAKUM (pre-sea-games-2025 Optimist - Rank 20)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    '33273928-a8ee-53a2-bb69-600ad7cad1f8', '6d6d7dd3-8b95-4230-af00-01321a224c3e', 'b9a09331-71de-5250-a8f2-ad989781c8a9', 'SURATSAYAPORN KAEWRAKUM', 'THA1696', 'individual',
    20, 171.0, 143.0, 'F', 'THA', false, false,
    'https://www.racingrulesofsailing.org/documents/168536', 'https://www.racingrulesofsailing.org/documents/168536', 'Provisional — Pre-33rd SEA Games 2025 — Optimist Girls results', 'pdf', 'Identity resolved: Matches existing profile Suratsayapron Kaewrakum (ACDC.SC, THA, sail 1696). Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    '77d385ee-dc1a-574b-8285-2ab42972f5a2', '33273928-a8ee-53a2-bb69-600ad7cad1f8', '6d6d7dd3-8b95-4230-af00-01321a224c3e', 'SURATSAYAPORN KAEWRAKUM', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('33273928-a8ee-53a2-bb69-600ad7cad1f8', 1, 28.0, 'DNF', true, '(28.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('33273928-a8ee-53a2-bb69-600ad7cad1f8', 2, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('33273928-a8ee-53a2-bb69-600ad7cad1f8', 3, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('33273928-a8ee-53a2-bb69-600ad7cad1f8', 4, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('33273928-a8ee-53a2-bb69-600ad7cad1f8', 5, 24.0, NULL, false, '24.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('33273928-a8ee-53a2-bb69-600ad7cad1f8', 6, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('33273928-a8ee-53a2-bb69-600ad7cad1f8', 7, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('33273928-a8ee-53a2-bb69-600ad7cad1f8', 8, 25.0, NULL, false, '25.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('33273928-a8ee-53a2-bb69-600ad7cad1f8', 9, 18.0, NULL, false, '18.0');

  -- Entry 15: ARAYA KLANGMUEANG (pre-sea-games-2025 Optimist - Rank 21)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    'f53661c4-da60-586a-ab9c-861d3ca61592', '9122c3b5-7b7d-43c1-ab7b-c5d2d2f2fb96', 'b9a09331-71de-5250-a8f2-ad989781c8a9', 'ARAYA KLANGMUEANG', 'THA1498', 'individual',
    21, 178.0, 150.0, 'F', 'THA', false, false,
    'https://www.racingrulesofsailing.org/documents/168536', 'https://www.racingrulesofsailing.org/documents/168536', 'Provisional — Pre-33rd SEA Games 2025 — Optimist Girls results', 'pdf', 'Identity resolved: Matches existing profile Aranya Klangmueang (YRAT, THA, sail 1498). Transliteration variant Araya vs Aranya. Excluded from Singapore rankings.',
    'verified', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    '7c7ac7f6-a72b-589f-a25a-7bd241ce73df', 'f53661c4-da60-586a-ab9c-861d3ca61592', '9122c3b5-7b7d-43c1-ab7b-c5d2d2f2fb96', 'ARAYA KLANGMUEANG', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f53661c4-da60-586a-ab9c-861d3ca61592', 1, 28.0, 'DNF', true, '(28.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f53661c4-da60-586a-ab9c-861d3ca61592', 2, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f53661c4-da60-586a-ab9c-861d3ca61592', 3, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f53661c4-da60-586a-ab9c-861d3ca61592', 4, 18.0, NULL, false, '18.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f53661c4-da60-586a-ab9c-861d3ca61592', 5, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f53661c4-da60-586a-ab9c-861d3ca61592', 6, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f53661c4-da60-586a-ab9c-861d3ca61592', 7, 19.0, NULL, false, '19.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f53661c4-da60-586a-ab9c-861d3ca61592', 8, 13.0, NULL, false, '13.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f53661c4-da60-586a-ab9c-861d3ca61592', 9, 22.0, NULL, false, '22.0');

  -- Step 3: Verify final counts on all 7 sheets
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_pre_ilca4_girls;
  IF v_count != 8 THEN RAISE EXCEPTION 'Expected 8 results on pre_ilca4_girls, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_pre_opti_boys;
  IF v_count != 38 THEN RAISE EXCEPTION 'Expected 38 results on pre_opti_boys, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_pre_opti_girls;
  IF v_count != 27 THEN RAISE EXCEPTION 'Expected 27 results on pre_opti_girls, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sea_ilca4_boys;
  IF v_count != 6 THEN RAISE EXCEPTION 'Expected 6 results on sea_ilca4_boys, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sea_ilca4_girls;
  IF v_count != 5 THEN RAISE EXCEPTION 'Expected 5 results on sea_ilca4_girls, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sea_opti_boys;
  IF v_count != 7 THEN RAISE EXCEPTION 'Expected 7 results on sea_opti_boys, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sea_opti_girls;
  IF v_count != 6 THEN RAISE EXCEPTION 'Expected 6 results on sea_opti_girls, found %', v_count; END IF;

  -- Step 4: Update schedule_notes on all 7 sheets to reflect 100% completion
  UPDATE public.regattas
  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 8 of 8 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_pre_ilca4_girls AND total_fleet_size = 8;

  UPDATE public.regattas
  SET schedule_notes = 'Official source status: provisional. Provisional organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 38 of 38 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_pre_opti_boys AND total_fleet_size = 38;

  UPDATE public.regattas
  SET schedule_notes = 'Official source status: provisional. Provisional organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 27 of 27 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_pre_opti_girls AND total_fleet_size = 27;

  UPDATE public.regattas
  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 6 of 6 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_sea_ilca4_boys AND total_fleet_size = 6;

  UPDATE public.regattas
  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 5 of 5 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_sea_ilca4_girls AND total_fleet_size = 5;

  UPDATE public.regattas
  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 7 of 7 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_sea_opti_boys AND total_fleet_size = 7;

  UPDATE public.regattas
  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 6 of 6 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_sea_opti_girls AND total_fleet_size = 6;

  -- Step 5: Audit logging
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source) VALUES
    ('results.resolve_identity', 'regatta', v_pre_ilca4_girls, 'pre-sea-games-2025-ilca4-girls', 'Resolved 1 held entry (Nia Zahedi). Sheet is now 100% complete (8/8).', '{"resolved_count": 1}'::jsonb, 'sea-games-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_pre_opti_boys, 'pre-sea-games-2025-optimist-boys', 'Resolved 3 held entries (Ethan Lee, Damien Huang, Napabhat Buasuang). Sheet is now 100% complete (38/38).', '{"resolved_count": 3}'::jsonb, 'sea-games-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_pre_opti_girls, 'pre-sea-games-2025-optimist-girls', 'Resolved 4 held entries (Surapha Muangngam, Dhammaporn Aruno, Suratsayapron Kaewrakum, Aranya Klangmueang). Sheet is now 100% complete (27/27).', '{"resolved_count": 4}'::jsonb, 'sea-games-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_sea_ilca4_boys, 'sea-games-2025-ilca4-boys', 'Resolved 2 held entries (Iqbal Nazham Musmuliadi, Mark Adrey Amadeo). Sheet is now 100% complete (6/6).', '{"resolved_count": 2}'::jsonb, 'sea-games-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_sea_ilca4_girls, 'sea-games-2025-ilca4-girls', 'Resolved 1 held entry (Nur Zafrina Syuhada Mohd Zailan). Sheet is now 100% complete (5/5).', '{"resolved_count": 1}'::jsonb, 'sea-games-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_sea_opti_boys, 'sea-games-2025-optimist-boys', 'Resolved 2 held entries (Muhammad Yaasin Syahrizan, Aung Sitt Moung). Sheet is now 100% complete (7/7).', '{"resolved_count": 2}'::jsonb, 'sea-games-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_sea_opti_girls, 'sea-games-2025-optimist-girls', 'Resolved 2 held entries (Lydia Hannah Jasmine Lukman, Daniela Sophia Mayor). Sheet is now 100% complete (6/6).', '{"resolved_count": 2}'::jsonb, 'sea-games-2025-resolution-2026-11-12');

END $resolve$;
COMMIT;
