-- Thailand Nationals, District, and Children's Day 2025: Resolution of 27 held entries (Cluster 3E)
BEGIN;
DO $resolve$
DECLARE
  v_childrens_ilca6 uuid := '159c4ad0-d7ee-543b-aa1c-752898cfeabc';
  v_childrens_opti_green uuid := '571a6dae-7ec0-596c-aa35-1eaa0c9f13a0';
  v_childrens_opti_gold uuid := '4d9921dd-f364-54d1-b8e7-1395e3836e08';
  v_childrens_opti_silver uuid := 'a631abfa-5b04-59aa-9b71-3afe5490d542';
  v_longdist_ilca4 uuid := '17541783-3aa2-5bcf-8c85-1af83adb290d';
  v_longdist_opti uuid := 'eeafd5ca-f435-5efb-b58e-d4c98bf53eca';
  v_district_ilca4 uuid := 'c9fcde35-3332-5194-906f-774fe4ee8502';
  v_district_ilca7 uuid := '39c41f2f-9c85-575a-b009-665d52c7a17c';
  v_nationals_ilca4 uuid := '81faaba4-7246-5e56-9de1-bd3ba0e19a00';
  v_nationals_ilca6 uuid := 'cd3712e1-b4a9-50a0-b3a6-0e1fa96640c4';
  v_nationals_ilca7 uuid := '5fcf0002-c34f-592b-8f17-5d55dd165050';
  v_count int;
BEGIN
  PERFORM pg_advisory_xact_lock(hashtextextended('nationals-district-childrens-2025-resolution', 0));

  -- Verify initial counts on sheets
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_childrens_ilca6;
  IF v_count != 10 THEN RAISE EXCEPTION 'Expected 10 results on childrens_ilca6, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_childrens_opti_green;
  IF v_count != 24 THEN RAISE EXCEPTION 'Expected 24 results on childrens_opti_green, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_childrens_opti_gold;
  IF v_count != 30 THEN RAISE EXCEPTION 'Expected 30 results on childrens_opti_gold, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_childrens_opti_silver;
  IF v_count != 31 THEN RAISE EXCEPTION 'Expected 31 results on childrens_opti_silver, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_longdist_ilca4;
  IF v_count != 12 THEN RAISE EXCEPTION 'Expected 12 results on longdist_ilca4, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_longdist_opti;
  IF v_count != 53 THEN RAISE EXCEPTION 'Expected 53 results on longdist_opti, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_district_ilca4;
  IF v_count != 40 THEN RAISE EXCEPTION 'Expected 40 results on district_ilca4, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_district_ilca7;
  IF v_count != 12 THEN RAISE EXCEPTION 'Expected 12 results on district_ilca7, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_nationals_ilca4;
  IF v_count != 32 THEN RAISE EXCEPTION 'Expected 32 results on nationals_ilca4, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_nationals_ilca6;
  IF v_count != 28 THEN RAISE EXCEPTION 'Expected 28 results on nationals_ilca6, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_nationals_ilca7;
  IF v_count != 31 THEN RAISE EXCEPTION 'Expected 31 results on nationals_ilca7, found %', v_count; END IF;

  -- Step 1: Create source-faithful profiles for new sailors and restore unmerged profiles
  INSERT INTO public.sailors (id, name, handle, club, nationality, sail_number, gender, dob, created_at, updated_at)
  VALUES ('efba7d9a-d71a-55b9-90fc-5ec21941baa1', 'Torn Rattana', 'torn-rattana-thai25-efba7d', 'RVYC/YRAT', 'THA', '221947', 'M', '2008-01-01', now(), now())
  ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name, handle = EXCLUDED.handle, club = EXCLUDED.club, nationality = EXCLUDED.nationality, sail_number = EXCLUDED.sail_number, gender = EXCLUDED.gender, dob = EXCLUDED.dob;
  INSERT INTO public.sailors (id, name, handle, club, nationality, sail_number, gender, created_at, updated_at)
  VALUES ('e976db5a-36bb-5fe4-8509-3221ac075841', 'Kim (Jeonbuk)', 'kim-jeonbuk-sr25-e976db', 'Jeun buk', 'KOR', '215573', 'F', now(), now())
  ON CONFLICT (id) DO NOTHING;
  INSERT INTO public.sailors (id, name, handle, club, nationality, sail_number, gender, created_at, updated_at)
  VALUES ('07bf0465-389d-5487-b6f7-b248a3cb859b', 'Aran Klangmueang', 'aran-klangmueang-sr25-07bf04', 'YRAT', 'THA', '1903', 'M', now(), now())
  ON CONFLICT (id) DO NOTHING;
  INSERT INTO public.sailors (id, name, handle, club, nationality, sail_number, gender, created_at, updated_at)
  VALUES ('c78219ad-ecf3-529a-9e11-8be4f10a8c22', 'Wonjeong Lee', 'wonjeong-lee-sr25-c78219', 'GYEONGGI-DO YACHT ASSOCIATION', 'KOR', '224347', 'M', now(), now())
  ON CONFLICT (id) DO NOTHING;
  INSERT INTO public.sailors (id, name, handle, club, nationality, sail_number, gender, created_at, updated_at)
  VALUES ('fb14e7a2-f584-5f21-9486-d242c75a34e0', 'Minsol Jeon', 'minsol-jeon-sr25-fb14e7', 'GANGWON', 'KOR', '207987', 'F', now(), now())
  ON CONFLICT (id) DO NOTHING;

  -- Step 2: Register aliases and restore distinct results for Torn Rattana
  DELETE FROM public.sailor_aliases WHERE sailor_id = '717ef058-5716-5951-a848-0723f95e8f28' AND alias_name = 'Torn Rattana';
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES
    ('efba7d9a-d71a-55b9-90fc-5ec21941baa1', 'Torn Rattana'),
    ('efba7d9a-d71a-55b9-90fc-5ec21941baa1', 'TORN RATTANA'),
    ('efba7d9a-d71a-55b9-90fc-5ec21941baa1', 'Torn RATTANA')
  ON CONFLICT (alias_name) DO UPDATE SET sailor_id = EXCLUDED.sailor_id;

  -- Repoint existing results of Torn Rattana (sail 221947) previously merged into Ton Rattana
  UPDATE public.regatta_results SET sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1'
  WHERE id IN (
    '11b5d23c-71fb-5559-8816-a4a9e2247c07',
    '88522579-83bc-547a-89f9-b3b082d56fcd',
    '57f9fb2d-c022-50a4-8fb2-e5cedfd3e2ec',
    '9783ff6b-c307-5bc2-ac7b-518c3c6a7f2d',
    '5d5bf98c-da7a-52ed-9ba9-2ffd10dd70b0',
    '31d214ea-f890-598a-a9e0-8e3f9df61ded'
  );
  UPDATE public.regatta_result_participants SET sailor_id = 'efba7d9a-d71a-55b9-90fc-5ec21941baa1'
  WHERE regatta_result_id IN (
    '11b5d23c-71fb-5559-8816-a4a9e2247c07',
    '88522579-83bc-547a-89f9-b3b082d56fcd',
    '57f9fb2d-c022-50a4-8fb2-e5cedfd3e2ec',
    '9783ff6b-c307-5bc2-ac7b-518c3c6a7f2d',
    '5d5bf98c-da7a-52ed-9ba9-2ffd10dd70b0',
    '31d214ea-f890-598a-a9e0-8e3f9df61ded'
  );

  -- Re-insert Torn Rattana Rank 3 in ILCA Thailand Nationals 2025 (ILCA 4)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'cb4f9040-48d7-5248-b5ce-4aeb934924cd', 'efba7d9a-d71a-55b9-90fc-5ec21941baa1', v_nationals_ilca4, 3, 42.0, 55.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/116668', 'ILCA Thailand Nationals 2025 — ILCA 4 results', 'pdf',
    'Identity unmerged & restored: Torn Rattana (RVYC/YRAT, sail 221947) distinct from Ton Rattana (RVYC, sail 222180).',
    'verified', now(), 'TORN RATTANA', '221947',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'e58ed71d-be6e-536d-9f56-f2a50d737a32', 'cb4f9040-48d7-5248-b5ce-4aeb934924cd', 'efba7d9a-d71a-55b9-90fc-5ec21941baa1',
    'TORN RATTANA', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES
    ('cb4f9040-48d7-5248-b5ce-4aeb934924cd', 1, 8.0, NULL, false, '8.0'),
    ('cb4f9040-48d7-5248-b5ce-4aeb934924cd', 2, 9.0, NULL, false, '9.0'),
    ('cb4f9040-48d7-5248-b5ce-4aeb934924cd', 3, 9.0, NULL, false, '9.0'),
    ('cb4f9040-48d7-5248-b5ce-4aeb934924cd', 4, 13.0, NULL, true, '(13.0)'),
    ('cb4f9040-48d7-5248-b5ce-4aeb934924cd', 5, 5.0, NULL, false, '5.0'),
    ('cb4f9040-48d7-5248-b5ce-4aeb934924cd', 6, 5.0, NULL, false, '5.0'),
    ('cb4f9040-48d7-5248-b5ce-4aeb934924cd', 7, 4.0, NULL, false, '4.0'),
    ('cb4f9040-48d7-5248-b5ce-4aeb934924cd', 8, 2.0, NULL, false, '2.0');

  -- Insert missing Rank 2 and Rank 6 in Children's Day 2025 Optimist Gold (Sorawit Naksuk, Panudat Polpool)
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES
    ('5d26c5a2-fefa-462b-9aea-23fc1092f5cf', 'SORAWIT NAKSUK'),
    ('2c3a793f-5bb5-531e-9290-5d976898618a', 'PANUDAT POLPOOL'),
    ('2c3a793f-5bb5-531e-9290-5d976898618a', 'panudat polpool')
  ON CONFLICT DO NOTHING;

  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'f2e4b419-58ec-5cf4-b841-382a887b4ea1', '5d26c5a2-fefa-462b-9aea-23fc1092f5cf', v_childrens_opti_gold, 2, 18.0, 28.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/103600', 'Children’s Day Regatta 2025 — Optimist Gold results', 'pdf',
    'Official provisional source: SORAWIT NAKSUK; sail THA1493; club YRAT; YOB 2012. Series score excluding worst score yields nett 18.0, gross 28.0.',
    'verified', now(), 'SORAWIT NAKSUK', 'THA1493',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '7ba78db6-e910-53bc-9ebf-4f6ffad67a12', 'f2e4b419-58ec-5cf4-b841-382a887b4ea1', '5d26c5a2-fefa-462b-9aea-23fc1092f5cf',
    'SORAWIT NAKSUK', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES
    ('f2e4b419-58ec-5cf4-b841-382a887b4ea1', 1, 3.0, NULL, false, '3'),
    ('f2e4b419-58ec-5cf4-b841-382a887b4ea1', 2, 8.0, NULL, false, '8.0'),
    ('f2e4b419-58ec-5cf4-b841-382a887b4ea1', 3, 3.0, NULL, false, '3'),
    ('f2e4b419-58ec-5cf4-b841-382a887b4ea1', 4, 1.0, NULL, false, '1'),
    ('f2e4b419-58ec-5cf4-b841-382a887b4ea1', 5, 3.0, NULL, false, '3'),
    ('f2e4b419-58ec-5cf4-b841-382a887b4ea1', 6, 10.0, NULL, true, '(10.0)');

  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'd4c1f938-1649-5da7-95ae-13e64f777e48', '2c3a793f-5bb5-531e-9290-5d976898618a', v_childrens_opti_gold, 6, 38.0, 52.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/103600', 'Children’s Day Regatta 2025 — Optimist Gold results', 'pdf',
    'Official provisional source: panudat polpool; sail THA1295; club YRAT; YOB 2012. Series score excluding worst score yields nett 38.0, gross 52.0.',
    'verified', now(), 'panudat polpool', 'THA1295',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'a5e4d291-766a-54cf-bfa4-0c2ef3899723', 'd4c1f938-1649-5da7-95ae-13e64f777e48', '2c3a793f-5bb5-531e-9290-5d976898618a',
    'panudat polpool', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES
    ('d4c1f938-1649-5da7-95ae-13e64f777e48', 1, 12.0, NULL, false, '12.0'),
    ('d4c1f938-1649-5da7-95ae-13e64f777e48', 2, 11.0, NULL, false, '11.0'),
    ('d4c1f938-1649-5da7-95ae-13e64f777e48', 3, 7.0, NULL, false, '7.0'),
    ('d4c1f938-1649-5da7-95ae-13e64f777e48', 4, 14.0, NULL, true, '(14.0)'),
    ('d4c1f938-1649-5da7-95ae-13e64f777e48', 5, 1.0, NULL, false, '1.0'),
    ('d4c1f938-1649-5da7-95ae-13e64f777e48', 6, 7.0, NULL, false, '7.0');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('e976db5a-36bb-5fe4-8509-3221ac075841', 'Kim') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('8b594c37-db52-4549-a765-f51fd619238d', 'NETCHANOK CHATAAWATTANASOPAKUN') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('8b594c37-db52-4549-a765-f51fd619238d', 'Netchanok Chataawattanasopakun') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('a5a0ff6f-0576-4a4c-b583-149f6f6d7304', 'Suwaphark Plumjit') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('a5a0ff6f-0576-4a4c-b583-149f6f6d7304', 'SUWAPHARK PLUMJIT') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('fe102225-248d-48a9-a92c-683cadcdbda8', 'Kunthon Khunmuang') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('fe102225-248d-48a9-a92c-683cadcdbda8', 'KUNTHON KHUNMUANG') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('bcb9374d-c256-4add-9abe-98b7832706cc', 'Tara') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('611e949a-fdcf-4727-8dbf-1430097ac813', 'CHANANCHAI TAITHONGCHAI') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('611e949a-fdcf-4727-8dbf-1430097ac813', 'Chananchai Taithongchai') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('21fee251-d07b-4f4b-be01-efead0178e57', 'Rohan') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('04d423bc-bd18-47ad-967a-45b1ef44cefd', 'JUSTIN LIU') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('04d423bc-bd18-47ad-967a-45b1ef44cefd', 'Justin Liu') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('07bf0465-389d-5487-b6f7-b248a3cb859b', 'ARAN KLANGMUEANG') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('07bf0465-389d-5487-b6f7-b248a3cb859b', 'Aran Klangmueang') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('638fc9a3-1d0e-4e9d-a750-e44f46655473', 'ANANCHAI TAITHONGCHAI') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('638fc9a3-1d0e-4e9d-a750-e44f46655473', 'Ananchai Taithongchai') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('04f1c65e-eeb7-4c89-9f6e-16298c33be02', 'KLAOCHNOK CHTAWATTANASOPAKUN') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('04f1c65e-eeb7-4c89-9f6e-16298c33be02', 'Klaochnok Chtawattanasopakun') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('976342b7-69ec-4200-8e46-684855939591', 'PIMPISA DEVAHASTIN NA AYUDHAYA') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('976342b7-69ec-4200-8e46-684855939591', 'Pimpisa Devahastin Na Ayudhaya') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('1b12d594-107f-40e1-9967-c65f59f6b27a', 'NUFAEL HAKIMI BIN IZHAR') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('1b12d594-107f-40e1-9967-c65f59f6b27a', 'Nufael Hakimi Bin Izhar') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('241af289-a3d3-4054-8f9a-a874c1a62471', 'IMANINA RAISYA BINTI IZHAR') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('241af289-a3d3-4054-8f9a-a874c1a62471', 'Imanina Raisya Binti Izhar') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('4f1eb555-5b44-517d-8d05-9ff0fd18f5ec', 'PUMITUS MEEIMSIN') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('4f1eb555-5b44-517d-8d05-9ff0fd18f5ec', 'Pumitus Meeimsin') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('90a471f5-bd58-400f-a995-e115951ee1ed', 'KITCHAKHUN') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('1ba65410-fa86-472d-ad75-bc510bffd07b', 'JEMIMMA CHANG') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('1ba65410-fa86-472d-ad75-bc510bffd07b', 'Jemimma Chang') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('957c49e1-11ff-5bd5-adbe-e59de172eb0c', 'CASEY') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('c78219ad-ecf3-529a-9e11-8be4f10a8c22', 'WONJEONGLEE') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('c78219ad-ecf3-529a-9e11-8be4f10a8c22', 'Wonjeong Lee') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('d29da64f-723a-45e0-a4d6-57eb7a1b1e82', 'NOPPASORN KHUNBOONJAN') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('d29da64f-723a-45e0-a4d6-57eb7a1b1e82', 'Noppasorn Khunboonjan') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('92b23e0a-9b81-518e-b23a-a46fab806ace', 'BRANEE MUANGNGAM') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('92b23e0a-9b81-518e-b23a-a46fab806ace', 'Branee Muangngam') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('5ec2f363-6683-5607-8bd8-b2984890b6c2', 'NANAFUNAZAWA') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('fb14e7a2-f584-5f21-9486-d242c75a34e0', 'JEONMINSOL') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('fb14e7a2-f584-5f21-9486-d242c75a34e0', 'Jeonminsol') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('fb14e7a2-f584-5f21-9486-d242c75a34e0', 'Minsol Jeon') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('5878691c-f01b-4ab4-976c-e6ad27b8782d', 'MUHAMMAD ADAM AIERELL BIN MOHD AZIZOL AMIRUL') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('5878691c-f01b-4ab4-976c-e6ad27b8782d', 'Muhammad Adam Aierell Bin Mohd Azizol Amirul') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('7302a702-2b88-5d53-a946-0bd10f257f43', 'JUNG YEON KIM') ON CONFLICT DO NOTHING;
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('7302a702-2b88-5d53-a946-0bd10f257f43', 'Jung Yeon Kim') ON CONFLICT DO NOTHING;

  -- Step 3: Insert 27 regatta results, participants, and race scores
  -- [0] Kim (childrens-day-regatta-2025, rank 8)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '72d94e9e-3006-4b9b-9f90-1ba7c9e73688', 'e976db5a-36bb-5fe4-8509-3221ac075841', '159c4ad0-d7ee-543b-aa1c-752898cfeabc', 8, 34.0, 34.0,
    false, false, 'F', 'KOR',
    'https://www.racingrulesofsailing.org/documents/103603', 'Children’s Day Regatta 2025 — ILCA 6 results', 'pdf', 'Identity resolved: Source-faithful profile created for Korean youth competitor Kim (Jeonbuk, KOR, sail 215573).',
    'verified', now(), 'Kim', '215573',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '7621906a-4287-4aa1-9b92-763c5e465059', '72d94e9e-3006-4b9b-9f90-1ba7c9e73688', 'e976db5a-36bb-5fe4-8509-3221ac075841', 'Kim', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('72d94e9e-3006-4b9b-9f90-1ba7c9e73688', 1, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('72d94e9e-3006-4b9b-9f90-1ba7c9e73688', 2, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('72d94e9e-3006-4b9b-9f90-1ba7c9e73688', 3, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('72d94e9e-3006-4b9b-9f90-1ba7c9e73688', 4, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('72d94e9e-3006-4b9b-9f90-1ba7c9e73688', 5, 9.0, NULL, false, '9.0');

  -- [1] NETCHANOK CHATAAWATTANASOPAKUN (childrens-day-regatta-2025, rank 3)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '2ce0d75f-f4d1-41c8-b27d-559c748010bd', '8b594c37-db52-4549-a765-f51fd619238d', '571a6dae-7ec0-596c-aa35-1eaa0c9f13a0', 3, 16.0, 23.0,
    false, false, 'F', 'THA',
    'https://www.racingrulesofsailing.org/documents/103602', 'Children’s Day Regatta 2025 — Optimist Green results', 'pdf', 'Identity resolved: Matches existing profile Netchanok Chatawattanasopakun (ACDC.SC, THA).',
    'verified', now(), 'NETCHANOK CHATAAWATTANASOPAKUN', 'THA15',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'de91eea7-03d7-4b3e-9fc5-407c7488dddf', '2ce0d75f-f4d1-41c8-b27d-559c748010bd', '8b594c37-db52-4549-a765-f51fd619238d', 'NETCHANOK CHATAAWATTANASOPAKUN', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2ce0d75f-f4d1-41c8-b27d-559c748010bd', 1, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2ce0d75f-f4d1-41c8-b27d-559c748010bd', 2, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2ce0d75f-f4d1-41c8-b27d-559c748010bd', 3, 7.0, NULL, true, '(7.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2ce0d75f-f4d1-41c8-b27d-559c748010bd', 4, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2ce0d75f-f4d1-41c8-b27d-559c748010bd', 5, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2ce0d75f-f4d1-41c8-b27d-559c748010bd', 6, 2.0, NULL, false, '2.0');

  -- [2] Suwaphark Plumjit (childrens-day-regatta-2025, rank 8)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '48c477f6-48f2-41fb-ae4e-94169d913881', 'a5a0ff6f-0576-4a4c-b583-149f6f6d7304', '571a6dae-7ec0-596c-aa35-1eaa0c9f13a0', 8, 33.0, 42.0,
    false, false, 'F', 'THA',
    'https://www.racingrulesofsailing.org/documents/103602', 'Children’s Day Regatta 2025 — Optimist Green results', 'pdf', 'Identity resolved: Matches existing profile Suwaphak Plumjit (ACDC.SC, THA). Romanisation variant Suwaphark.',
    'verified', now(), 'Suwaphark Plumjit', 'THA1589',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'fd78360c-808f-4d39-8c85-fb4cc4a0e430', '48c477f6-48f2-41fb-ae4e-94169d913881', 'a5a0ff6f-0576-4a4c-b583-149f6f6d7304', 'Suwaphark Plumjit', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('48c477f6-48f2-41fb-ae4e-94169d913881', 1, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('48c477f6-48f2-41fb-ae4e-94169d913881', 2, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('48c477f6-48f2-41fb-ae4e-94169d913881', 3, 9.0, NULL, true, '(9.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('48c477f6-48f2-41fb-ae4e-94169d913881', 4, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('48c477f6-48f2-41fb-ae4e-94169d913881', 5, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('48c477f6-48f2-41fb-ae4e-94169d913881', 6, 5.0, NULL, false, '5.0');

  -- [3] Kunthon Khunmuang (childrens-day-regatta-2025, rank 21)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '59001346-b78d-45fc-846f-18532863cdf1', 'fe102225-248d-48a9-a92c-683cadcdbda8', '571a6dae-7ec0-596c-aa35-1eaa0c9f13a0', 21, 101.0, 129.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/103602', 'Children’s Day Regatta 2025 — Optimist Green results', 'pdf', 'Identity resolved: Matches existing profile Kanthon Khunmuang (YRAT, THA). Romanisation variant Kunthon.',
    'verified', now(), 'Kunthon Khunmuang', '35',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'd16817db-81cb-4f76-91df-30eb3a5e4ae7', '59001346-b78d-45fc-846f-18532863cdf1', 'fe102225-248d-48a9-a92c-683cadcdbda8', 'Kunthon Khunmuang', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('59001346-b78d-45fc-846f-18532863cdf1', 1, 22.0, NULL, false, '22.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('59001346-b78d-45fc-846f-18532863cdf1', 2, 25.0, NULL, false, '25.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('59001346-b78d-45fc-846f-18532863cdf1', 3, 28.0, 'DNF', true, '(28.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('59001346-b78d-45fc-846f-18532863cdf1', 4, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('59001346-b78d-45fc-846f-18532863cdf1', 5, 18.0, NULL, false, '18.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('59001346-b78d-45fc-846f-18532863cdf1', 6, 19.0, NULL, false, '19.0');

  -- [4] Tara (childrens-day-regatta-2025, rank 13)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '2676fce3-bd03-4e19-bc68-6ecc1140f30e', 'bcb9374d-c256-4add-9abe-98b7832706cc', '4d9921dd-f364-54d1-b8e7-1395e3836e08', 13, 59.0, 88.0,
    false, false, 'F', 'HKG',
    'https://www.racingrulesofsailing.org/documents/103600', 'Children’s Day Regatta 2025 — Optimist Gold results', 'pdf', 'Identity resolved: Matches existing profile Tara Maliah (RHKYC / HKODA, HKG, sail HKG184).',
    'verified', now(), 'Tara', 'HKG184',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '074c8404-105c-42c7-b09d-2d6f38fe05cd', '2676fce3-bd03-4e19-bc68-6ecc1140f30e', 'bcb9374d-c256-4add-9abe-98b7832706cc', 'Tara', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2676fce3-bd03-4e19-bc68-6ecc1140f30e', 1, 17.0, NULL, false, '17');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2676fce3-bd03-4e19-bc68-6ecc1140f30e', 2, 12.0, NULL, false, '12');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2676fce3-bd03-4e19-bc68-6ecc1140f30e', 3, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2676fce3-bd03-4e19-bc68-6ecc1140f30e', 4, 29.0, NULL, true, '(29 )');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2676fce3-bd03-4e19-bc68-6ecc1140f30e', 5, 16.0, NULL, false, '16');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('2676fce3-bd03-4e19-bc68-6ecc1140f30e', 6, 9.0, NULL, false, '9');

  -- [5] CHANANCHAI TAITHONGCHAI (childrens-day-regatta-2025, rank 26)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '4ec418d8-8d7d-42c6-b30d-bfb7d71fc81c', '611e949a-fdcf-4727-8dbf-1430097ac813', '4d9921dd-f364-54d1-b8e7-1395e3836e08', 26, 115.0, 159.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/103600', 'Children’s Day Regatta 2025 — Optimist Gold results', 'pdf', 'Identity resolved: Matches existing profile Chananchai Tiathongchai (ACDC.SC, THA). Romanisation variant Taithongchai.',
    'verified', now(), 'CHANANCHAI TAITHONGCHAI', 'THA1487',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '53092c82-84f1-4c8a-b47a-55510e50e1c3', '4ec418d8-8d7d-42c6-b30d-bfb7d71fc81c', '611e949a-fdcf-4727-8dbf-1430097ac813', 'CHANANCHAI TAITHONGCHAI', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4ec418d8-8d7d-42c6-b30d-bfb7d71fc81c', 1, 24.0, NULL, false, '24');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4ec418d8-8d7d-42c6-b30d-bfb7d71fc81c', 2, 34.0, NULL, false, '34');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4ec418d8-8d7d-42c6-b30d-bfb7d71fc81c', 3, 44.0, NULL, true, '(44 )');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4ec418d8-8d7d-42c6-b30d-bfb7d71fc81c', 4, 10.0, NULL, false, '10');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4ec418d8-8d7d-42c6-b30d-bfb7d71fc81c', 5, 26.0, NULL, false, '26');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4ec418d8-8d7d-42c6-b30d-bfb7d71fc81c', 6, 21.0, NULL, false, '21');

  -- [6] KITCHAKHUN SOMKHANNGONE (childrens-day-regatta-2025, rank 29)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'c0b5ed90-8691-4e7d-b8e2-7064d6ae4930', '90a471f5-bd58-400f-a995-e115951ee1ed', '4d9921dd-f364-54d1-b8e7-1395e3836e08', 29, 118.0, 155.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/103600', 'Children’s Day Regatta 2025 — Optimist Gold results', 'pdf', 'Identity resolved: Matches existing profile Kiitchakhun Somkhanngoen (ACDC.SC, THA).',
    'verified', now(), 'KITCHAKHUN SOMKHANNGONE', 'THA1567',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '91b578c2-41bc-4265-8890-4c1d969f2777', 'c0b5ed90-8691-4e7d-b8e2-7064d6ae4930', '90a471f5-bd58-400f-a995-e115951ee1ed', 'KITCHAKHUN SOMKHANNGONE', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c0b5ed90-8691-4e7d-b8e2-7064d6ae4930', 1, 37.0, NULL, true, '(37 )');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c0b5ed90-8691-4e7d-b8e2-7064d6ae4930', 2, 32.0, NULL, false, '32');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c0b5ed90-8691-4e7d-b8e2-7064d6ae4930', 3, 12.0, NULL, false, '12');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c0b5ed90-8691-4e7d-b8e2-7064d6ae4930', 4, 23.0, NULL, false, '23');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c0b5ed90-8691-4e7d-b8e2-7064d6ae4930', 5, 27.0, NULL, false, '27');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c0b5ed90-8691-4e7d-b8e2-7064d6ae4930', 6, 24.0, NULL, false, '24');

  -- [7] Rohan (childrens-day-regatta-2025, rank 7)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'f937e7a8-da91-44d1-83a9-eb499a091ff7', '21fee251-d07b-4f4b-be01-efead0178e57', 'a631abfa-5b04-59aa-9b71-3afe5490d542', 7, 101.0, 172.0,
    false, false, 'M', 'HKG',
    'https://www.racingrulesofsailing.org/documents/103601', 'Children’s Day Regatta 2025 — Optimist Silver results', 'pdf', 'Identity resolved: Matches existing profile Rohan Maliah (RHKYC, HKG, sail HKG173).',
    'verified', now(), 'Rohan', 'HKG173',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '5c9bce4b-3425-4515-aba5-06f5ccd5b8f9', 'f937e7a8-da91-44d1-83a9-eb499a091ff7', '21fee251-d07b-4f4b-be01-efead0178e57', 'Rohan', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f937e7a8-da91-44d1-83a9-eb499a091ff7', 1, 42.0, NULL, false, '42');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f937e7a8-da91-44d1-83a9-eb499a091ff7', 2, 71.0, 'DSQ', true, '(71 DSQ)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f937e7a8-da91-44d1-83a9-eb499a091ff7', 3, 18.0, NULL, false, '18');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f937e7a8-da91-44d1-83a9-eb499a091ff7', 4, 2.0, NULL, false, '2');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f937e7a8-da91-44d1-83a9-eb499a091ff7', 5, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f937e7a8-da91-44d1-83a9-eb499a091ff7', 6, 36.0, 'UFD', false, '36 UFD');

  -- [8] JUSTIN LIU (childrens-day-regatta-2025, rank 12)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '6ed51c2f-861b-42d5-9b8f-2c3e4e841f23', '04d423bc-bd18-47ad-967a-45b1ef44cefd', 'a631abfa-5b04-59aa-9b71-3afe5490d542', 12, 119.0, 175.0,
    false, false, 'M', 'HKG',
    'https://www.racingrulesofsailing.org/documents/103601', 'Children’s Day Regatta 2025 — Optimist Silver results', 'pdf', 'Identity resolved: Matches existing profile Liu Qi Heng (RHKYC, HKG, sail HKG 236; English name Justin Liu).',
    'verified', now(), 'JUSTIN LIU', 'HKG236',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'f463301e-f66f-4608-b464-7a337797c30f', '6ed51c2f-861b-42d5-9b8f-2c3e4e841f23', '04d423bc-bd18-47ad-967a-45b1ef44cefd', 'JUSTIN LIU', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6ed51c2f-861b-42d5-9b8f-2c3e4e841f23', 1, 56.0, NULL, true, '(56 )');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6ed51c2f-861b-42d5-9b8f-2c3e4e841f23', 2, 54.0, NULL, false, '54');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6ed51c2f-861b-42d5-9b8f-2c3e4e841f23', 3, 25.0, NULL, false, '25');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6ed51c2f-861b-42d5-9b8f-2c3e4e841f23', 4, 1.0, NULL, false, '1');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6ed51c2f-861b-42d5-9b8f-2c3e4e841f23', 5, 36.0, 'UFD', false, '36 UFD');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('6ed51c2f-861b-42d5-9b8f-2c3e4e841f23', 6, 3.0, NULL, false, '3');

  -- [9] ARAN KLANGMUEANG (childrens-day-regatta-2025, rank 20)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '3c138b3d-1a82-4468-93f3-c9a513a663c6', '07bf0465-389d-5487-b6f7-b248a3cb859b', 'a631abfa-5b04-59aa-9b71-3afe5490d542', 20, 148.0, 207.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/103601', 'Children’s Day Regatta 2025 — Optimist Silver results', 'pdf', 'Identity resolved: Source-faithful profile created for Thai youth competitor Aran Klangmueang (YRAT, THA, sail THA1903). Distinct from Aranya Klangmueang (sail THA1775).',
    'verified', now(), 'ARAN KLANGMUEANG', 'THA1903',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '73942590-5f20-411c-acb7-3264e091991c', '3c138b3d-1a82-4468-93f3-c9a513a663c6', '07bf0465-389d-5487-b6f7-b248a3cb859b', 'ARAN KLANGMUEANG', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('3c138b3d-1a82-4468-93f3-c9a513a663c6', 1, 59.0, NULL, true, '(59 )');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('3c138b3d-1a82-4468-93f3-c9a513a663c6', 2, 57.0, NULL, false, '57');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('3c138b3d-1a82-4468-93f3-c9a513a663c6', 3, 47.0, NULL, false, '47');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('3c138b3d-1a82-4468-93f3-c9a513a663c6', 4, 11.0, NULL, false, '11');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('3c138b3d-1a82-4468-93f3-c9a513a663c6', 5, 24.0, NULL, false, '24');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('3c138b3d-1a82-4468-93f3-c9a513a663c6', 6, 9.0, NULL, false, '9');

  -- [10] ANANCHAI TAITHONGCHAI (childrens-day-regatta-2025, rank 21)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'cde59172-267b-4794-b3ed-a65674d88228', '638fc9a3-1d0e-4e9d-a750-e44f46655473', 'a631abfa-5b04-59aa-9b71-3afe5490d542', 21, 154.0, 210.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/103601', 'Children’s Day Regatta 2025 — Optimist Silver results', 'pdf', 'Identity resolved: Matches existing profile Anantachai Tiathongchai (ACDC.SC, THA). Romanisation variant Ananchai Taithongchai.',
    'verified', now(), 'ANANCHAI TAITHONGCHAI', 'THA1549',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'a5769a98-598e-4822-80d5-43f1806a4e5e', 'cde59172-267b-4794-b3ed-a65674d88228', '638fc9a3-1d0e-4e9d-a750-e44f46655473', 'ANANCHAI TAITHONGCHAI', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('cde59172-267b-4794-b3ed-a65674d88228', 1, 54.0, NULL, false, '54');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('cde59172-267b-4794-b3ed-a65674d88228', 2, 56.0, NULL, true, '(56 )');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('cde59172-267b-4794-b3ed-a65674d88228', 3, 49.0, NULL, false, '49');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('cde59172-267b-4794-b3ed-a65674d88228', 4, 18.0, NULL, false, '18');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('cde59172-267b-4794-b3ed-a65674d88228', 5, 16.0, NULL, false, '16');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('cde59172-267b-4794-b3ed-a65674d88228', 6, 17.0, NULL, false, '17');

  -- [11] KLAOCHNOK CHTAWATTANASOPAKUN (thailand-nationals-long-distance-2025, rank 27)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'c6275cbd-ed96-4b78-a721-6a22af1823ce', '04f1c65e-eeb7-4c89-9f6e-16298c33be02', 'eeafd5ca-f435-5efb-b58e-d4c98bf53eca', 27, 27.0, 27.0,
    false, false, 'F', 'THA',
    'https://www.racingrulesofsailing.org/documents/141362', 'Thailand Nationals Long Distance 2025 — Optimist results', 'pdf', 'Identity resolved: Matches existing profile Klaochanok Chatawattanasopakun (ACDC.SC, THA). Source spelling typo Klaochnok Chtawattanasopakun.',
    'verified', now(), 'KLAOCHNOK CHTAWATTANASOPAKUN', 'THA1246',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'dc229741-ce86-4969-9b8c-e0b88c32755e', 'c6275cbd-ed96-4b78-a721-6a22af1823ce', '04f1c65e-eeb7-4c89-9f6e-16298c33be02', 'KLAOCHNOK CHTAWATTANASOPAKUN', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c6275cbd-ed96-4b78-a721-6a22af1823ce', 1, 27.0, NULL, false, '27.0');

  -- [12] NAVATAWAN JAEMJIT (thailand-nationals-long-distance-2025, rank 44)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '760d715e-9f32-4a7b-a1a0-52df23dcbbdd', '1c03e3e7-ea29-526f-88b3-fd77ce113868', 'eeafd5ca-f435-5efb-b58e-d4c98bf53eca', 44, 44.0, 44.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/141362', 'Thailand Nationals Long Distance 2025 — Optimist results', 'pdf', 'Identity resolved: Matches existing profile Navatawan Jeanjit (RTFYC, THA, sail 1979).',
    'verified', now(), 'NAVATAWAN JAEMJIT', 'THA1979',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'd81c4742-a242-4574-800a-9b7cf78c8f55', '760d715e-9f32-4a7b-a1a0-52df23dcbbdd', '1c03e3e7-ea29-526f-88b3-fd77ce113868', 'NAVATAWAN JAEMJIT', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('760d715e-9f32-4a7b-a1a0-52df23dcbbdd', 1, 44.0, NULL, false, '44.0');

  -- [13] PIMPISA DEVAHASTIN NA AYUDHAYA (thailand-nationals-long-distance-2025, rank 50)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'c3a186c2-e02c-4d9d-8403-fcf56ecb39b7', '976342b7-69ec-4200-8e46-684855939591', 'eeafd5ca-f435-5efb-b58e-d4c98bf53eca', 50, 59.0, 59.0,
    false, false, 'F', 'THA',
    'https://www.racingrulesofsailing.org/documents/141362', 'Thailand Nationals Long Distance 2025 — Optimist results', 'pdf', 'Identity resolved: Matches existing profile Pimpisa Devahastin Na Ayudhya (ACDC.SC, THA). Spelling variant Ayudhaya.',
    'verified', now(), 'PIMPISA DEVAHASTIN NA AYUDHAYA', 'THA599',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '410124f9-5889-4266-aaf5-c0ab78aa8fb4', 'c3a186c2-e02c-4d9d-8403-fcf56ecb39b7', '976342b7-69ec-4200-8e46-684855939591', 'PIMPISA DEVAHASTIN NA AYUDHAYA', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c3a186c2-e02c-4d9d-8403-fcf56ecb39b7', 1, 59.0, 'DNF', false, '59.0 DNF');

  -- [14] NUFAEL HAKIMI BIN IZHAR (thailand-nationals-long-distance-2025, rank 50)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '7403eb32-359b-4eee-bb3b-e1a36a5cc20d', '1b12d594-107f-40e1-9967-c65f59f6b27a', 'eeafd5ca-f435-5efb-b58e-d4c98bf53eca', 50, 59.0, 59.0,
    false, false, 'M', 'MAS',
    'https://www.racingrulesofsailing.org/documents/141362', 'Thailand Nationals Long Distance 2025 — Optimist results', 'pdf', 'Identity resolved: Matches existing profile Nufael Hakimi Izhar (MAS, TSA).',
    'verified', now(), 'NUFAEL HAKIMI BIN IZHAR', 'MAS 246',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '0226ccfe-9303-4dbd-8864-9d8ffe30be29', '7403eb32-359b-4eee-bb3b-e1a36a5cc20d', '1b12d594-107f-40e1-9967-c65f59f6b27a', 'NUFAEL HAKIMI BIN IZHAR', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('7403eb32-359b-4eee-bb3b-e1a36a5cc20d', 1, 59.0, 'DNF', false, '59.0 DNF');

  -- [15] IMANINA RAISYA BINTI IZHAR (thailand-nationals-long-distance-2025, rank 50)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'e2122191-79b2-445d-8441-c983c400e353', '241af289-a3d3-4054-8f9a-a874c1a62471', 'eeafd5ca-f435-5efb-b58e-d4c98bf53eca', 50, 59.0, 59.0,
    false, false, 'F', 'MAS',
    'https://www.racingrulesofsailing.org/documents/141362', 'Thailand Nationals Long Distance 2025 — Optimist results', 'pdf', 'Identity resolved: Matches existing profile Imanina Raisya bt Izhar (MAS, TSA).',
    'verified', now(), 'IMANINA RAISYA BINTI IZHAR', 'MAS 245',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'e1f3a8f8-f568-40cf-a7a0-b26ab63fe6d4', 'e2122191-79b2-445d-8441-c983c400e353', '241af289-a3d3-4054-8f9a-a874c1a62471', 'IMANINA RAISYA BINTI IZHAR', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('e2122191-79b2-445d-8441-c983c400e353', 1, 59.0, 'DNF', false, '59.0 DNF');

  -- [16] PUMITUS MEEIMSIN (thailand-nationals-long-distance-2025, rank 15)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'c9adb464-cfbd-4053-ae3a-0cf371d5d997', '4f1eb555-5b44-517d-8d05-9ff0fd18f5ec', '17541783-3aa2-5bcf-8c85-1af83adb290d', 15, 15.0, 15.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/141364', 'Thailand Nationals Long Distance 2025 — ILCA 4 results', 'pdf', 'Identity resolved: Matches existing profile Pumitus Mee-Iamsin (YRAT, THA). Spelling variant Meeimsin.',
    'verified', now(), 'PUMITUS MEEIMSIN', '22023',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '24132bec-050c-4191-b3f1-58b70799322c', 'c9adb464-cfbd-4053-ae3a-0cf371d5d997', '4f1eb555-5b44-517d-8d05-9ff0fd18f5ec', 'PUMITUS MEEIMSIN', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c9adb464-cfbd-4053-ae3a-0cf371d5d997', 1, 15.0, NULL, false, '15.0');

  -- [17] KITCHAKHUN (ilca-district-championship-2025, rank 15)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '25bcb36f-b4d3-4361-865d-967edf2adf01', '90a471f5-bd58-400f-a995-e115951ee1ed', 'c9fcde35-3332-5194-906f-774fe4ee8502', 15, 48.0, 48.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/116666', 'ILCA District Championship 2025 — ILCA 4 results', 'pdf', 'Identity resolved: Matches existing profile Kiitchakhun Somkhanngoen (YRAT, THA). Source published with first name only.',
    'verified', now(), 'KITCHAKHUN', 'THA 228917',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '43dd5a8b-1682-47bf-a994-0a039734a76a', '25bcb36f-b4d3-4361-865d-967edf2adf01', '90a471f5-bd58-400f-a995-e115951ee1ed', 'KITCHAKHUN', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('25bcb36f-b4d3-4361-865d-967edf2adf01', 1, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('25bcb36f-b4d3-4361-865d-967edf2adf01', 2, 35.0, NULL, false, '35.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('25bcb36f-b4d3-4361-865d-967edf2adf01', 3, 7.0, NULL, false, '7.0');

  -- [18] JEMIMMA CHANG (ilca-district-championship-2025, rank 16)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '0411a286-628c-4d6c-8fbb-7850cae9a73c', '1ba65410-fa86-472d-ad75-bc510bffd07b', 'c9fcde35-3332-5194-906f-774fe4ee8502', 16, 50.0, 50.0,
    false, false, 'F', 'SGP',
    'https://www.racingrulesofsailing.org/documents/116666', 'ILCA District Championship 2025 — ILCA 4 results', 'pdf', 'Identity resolved: Matches existing profile Jemima Chang (PAssion Wave / PA, SGP). Source spelling variant Jemimma.',
    'verified', now(), 'JEMIMMA CHANG', 'SGP 214636',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '98b47806-9fef-4e1e-afc2-5296db4d5f10', '0411a286-628c-4d6c-8fbb-7850cae9a73c', '1ba65410-fa86-472d-ad75-bc510bffd07b', 'JEMIMMA CHANG', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('0411a286-628c-4d6c-8fbb-7850cae9a73c', 1, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('0411a286-628c-4d6c-8fbb-7850cae9a73c', 2, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('0411a286-628c-4d6c-8fbb-7850cae9a73c', 3, 20.0, NULL, false, '20.0');

  -- [19] CASEY (ilca-district-championship-2025, rank 11)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'f7eb52ff-7eca-4a94-823a-f1c466cf5a33', '957c49e1-11ff-5bd5-adbe-e59de172eb0c', '39c41f2f-9c85-575a-b009-665d52c7a17c', 11, 43.0, 43.0,
    false, false, 'M', 'THA',
    'https://www.racingrulesofsailing.org/documents/116665', 'ILCA District Championship 2025 — ILCA 7 results', 'pdf', 'Identity resolved: Matches existing profile Casey Algra (RVYC, THA, sail 200119). Source published with first name only.',
    'verified', now(), 'CASEY', 'THA 200119',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '47239298-2fb8-412f-802e-1fe71d71ee0c', 'f7eb52ff-7eca-4a94-823a-f1c466cf5a33', '957c49e1-11ff-5bd5-adbe-e59de172eb0c', 'CASEY', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f7eb52ff-7eca-4a94-823a-f1c466cf5a33', 1, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f7eb52ff-7eca-4a94-823a-f1c466cf5a33', 2, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f7eb52ff-7eca-4a94-823a-f1c466cf5a33', 3, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f7eb52ff-7eca-4a94-823a-f1c466cf5a33', 4, 10.0, NULL, false, '10.0');

  -- [20] WONJEONGLEE (ilca-thailand-nationals-2025, rank 16)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '00f6d1b5-474e-4c18-99ed-d24a424f0abe', 'c78219ad-ecf3-529a-9e11-8be4f10a8c22', '5fcf0002-c34f-592b-8f17-5d55dd165050', 16, 107.0, 126.0,
    false, false, 'M', 'KOR',
    'https://www.racingrulesofsailing.org/documents/116670', 'ILCA Thailand Nationals 2025 — ILCA 7 results', 'pdf', 'Identity resolved: Source-faithful profile created for Korean competitor Wonjeong Lee (Gyeonggi-do Yacht Association, KOR, sail 224347).',
    'verified', now(), 'WONJEONGLEE', '224347',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '5ff4611c-1254-4d7a-8230-3d587590b270', '00f6d1b5-474e-4c18-99ed-d24a424f0abe', 'c78219ad-ecf3-529a-9e11-8be4f10a8c22', 'WONJEONGLEE', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('00f6d1b5-474e-4c18-99ed-d24a424f0abe', 1, 9.0, NULL, false, '9.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('00f6d1b5-474e-4c18-99ed-d24a424f0abe', 2, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('00f6d1b5-474e-4c18-99ed-d24a424f0abe', 3, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('00f6d1b5-474e-4c18-99ed-d24a424f0abe', 4, 19.0, NULL, true, '(19.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('00f6d1b5-474e-4c18-99ed-d24a424f0abe', 5, 18.0, NULL, false, '18.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('00f6d1b5-474e-4c18-99ed-d24a424f0abe', 6, 19.0, NULL, false, '19.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('00f6d1b5-474e-4c18-99ed-d24a424f0abe', 7, 14.0, NULL, false, '14.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('00f6d1b5-474e-4c18-99ed-d24a424f0abe', 8, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('00f6d1b5-474e-4c18-99ed-d24a424f0abe', 9, 11.0, NULL, false, '11.0');

  -- [21] NOPPASORN KHUNBOONJAN (ilca-thailand-nationals-2025, rank 3)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '4fb49eb3-ecc2-4ca8-8364-c423bbe796c3', 'd29da64f-723a-45e0-a4d6-57eb7a1b1e82', 'cd3712e1-b4a9-50a0-b3a6-0e1fa96640c4', 3, 25.0, 34.0,
    false, false, 'F', 'THA',
    'https://www.racingrulesofsailing.org/documents/116669', 'ILCA Thailand Nationals 2025 — ILCA 6 results', 'pdf', 'Identity resolved: Matches existing profile Noppassorn Khunboonjan (YRAT, THA). Romanisation variant Noppasorn.',
    'verified', now(), 'NOPPASORN KHUNBOONJAN', '220240',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'a15efb69-9f5b-4b88-9a6b-99c7013d9759', '4fb49eb3-ecc2-4ca8-8364-c423bbe796c3', 'd29da64f-723a-45e0-a4d6-57eb7a1b1e82', 'NOPPASORN KHUNBOONJAN', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4fb49eb3-ecc2-4ca8-8364-c423bbe796c3', 1, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4fb49eb3-ecc2-4ca8-8364-c423bbe796c3', 2, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4fb49eb3-ecc2-4ca8-8364-c423bbe796c3', 3, 2.0, NULL, false, '2.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4fb49eb3-ecc2-4ca8-8364-c423bbe796c3', 4, 9.0, NULL, true, '(9.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4fb49eb3-ecc2-4ca8-8364-c423bbe796c3', 5, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4fb49eb3-ecc2-4ca8-8364-c423bbe796c3', 6, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4fb49eb3-ecc2-4ca8-8364-c423bbe796c3', 7, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('4fb49eb3-ecc2-4ca8-8364-c423bbe796c3', 8, 1.0, NULL, false, '1.0');

  -- [22] BRANEE MUANGNGAM (ilca-thailand-nationals-2025, rank 8)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'daabf532-ec45-4b05-9b84-e43275c718d7', '92b23e0a-9b81-518e-b23a-a46fab806ace', 'cd3712e1-b4a9-50a0-b3a6-0e1fa96640c4', 8, 47.0, 61.0,
    false, false, 'F', 'THA',
    'https://www.racingrulesofsailing.org/documents/116669', 'ILCA Thailand Nationals 2025 — ILCA 6 results', 'pdf', 'Identity resolved: Matches existing profile Paranee Muangngam (YRAT, THA). Romanisation variant Branee vs Paranee.',
    'verified', now(), 'BRANEE MUANGNGAM', '210290',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '05bd62c2-50a5-43c5-afb1-7d23b5b7830a', 'daabf532-ec45-4b05-9b84-e43275c718d7', '92b23e0a-9b81-518e-b23a-a46fab806ace', 'BRANEE MUANGNGAM', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('daabf532-ec45-4b05-9b84-e43275c718d7', 1, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('daabf532-ec45-4b05-9b84-e43275c718d7', 2, 12.0, NULL, false, '12.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('daabf532-ec45-4b05-9b84-e43275c718d7', 3, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('daabf532-ec45-4b05-9b84-e43275c718d7', 4, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('daabf532-ec45-4b05-9b84-e43275c718d7', 5, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('daabf532-ec45-4b05-9b84-e43275c718d7', 6, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('daabf532-ec45-4b05-9b84-e43275c718d7', 7, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('daabf532-ec45-4b05-9b84-e43275c718d7', 8, 14.0, NULL, true, '(14.0)');

  -- [23] NANAFUNAZAWA (ilca-thailand-nationals-2025, rank 10)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'fd5589bf-14b9-47a0-a3d8-c7acf2d22f71', '5ec2f363-6683-5607-8bd8-b2984890b6c2', 'cd3712e1-b4a9-50a0-b3a6-0e1fa96640c4', 10, 60.0, 93.0,
    false, false, 'F', 'JPN',
    'https://www.racingrulesofsailing.org/documents/116669', 'ILCA Thailand Nationals 2025 — ILCA 6 results', 'pdf', 'Identity resolved: Matches existing profile Nana Funazawa (JPN).',
    'verified', now(), 'NANAFUNAZAWA', '208625',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'c10c57c5-895d-4e40-ac1b-ab97e97762cb', 'fd5589bf-14b9-47a0-a3d8-c7acf2d22f71', '5ec2f363-6683-5607-8bd8-b2984890b6c2', 'NANAFUNAZAWA', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('fd5589bf-14b9-47a0-a3d8-c7acf2d22f71', 1, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('fd5589bf-14b9-47a0-a3d8-c7acf2d22f71', 2, 11.0, NULL, false, '11.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('fd5589bf-14b9-47a0-a3d8-c7acf2d22f71', 3, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('fd5589bf-14b9-47a0-a3d8-c7acf2d22f71', 4, 10.0, NULL, false, '10.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('fd5589bf-14b9-47a0-a3d8-c7acf2d22f71', 5, 6.0, NULL, false, '6.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('fd5589bf-14b9-47a0-a3d8-c7acf2d22f71', 6, 33.0, 'UFD', true, '(33.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('fd5589bf-14b9-47a0-a3d8-c7acf2d22f71', 7, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('fd5589bf-14b9-47a0-a3d8-c7acf2d22f71', 8, 2.0, NULL, false, '2.0');

  -- [24] JEONMINSOL (ilca-thailand-nationals-2025, rank 29)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    'db15bc4c-aaa5-4bea-a087-47a36aee4fde', 'fb14e7a2-f584-5f21-9486-d242c75a34e0', 'cd3712e1-b4a9-50a0-b3a6-0e1fa96640c4', 29, 183.0, 216.0,
    false, false, 'F', 'KOR',
    'https://www.racingrulesofsailing.org/documents/116669', 'ILCA Thailand Nationals 2025 — ILCA 6 results', 'pdf', 'Identity resolved: Source-faithful profile created for Korean competitor Minsol Jeon (Gangwon, KOR, sail 207987).',
    'verified', now(), 'JEONMINSOL', '207987',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '414f5d50-7afa-425a-b8e1-17459f33ad44', 'db15bc4c-aaa5-4bea-a087-47a36aee4fde', 'fb14e7a2-f584-5f21-9486-d242c75a34e0', 'JEONMINSOL', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('db15bc4c-aaa5-4bea-a087-47a36aee4fde', 1, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('db15bc4c-aaa5-4bea-a087-47a36aee4fde', 2, 26.0, NULL, false, '26.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('db15bc4c-aaa5-4bea-a087-47a36aee4fde', 3, 33.0, 'UFD', true, '(33.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('db15bc4c-aaa5-4bea-a087-47a36aee4fde', 4, 31.0, NULL, false, '31.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('db15bc4c-aaa5-4bea-a087-47a36aee4fde', 5, 25.0, NULL, false, '25.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('db15bc4c-aaa5-4bea-a087-47a36aee4fde', 6, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('db15bc4c-aaa5-4bea-a087-47a36aee4fde', 7, 27.0, NULL, false, '27.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('db15bc4c-aaa5-4bea-a087-47a36aee4fde', 8, 21.0, NULL, false, '21.0');

  -- [25] MUHAMMAD ADAM AIERELL BIN MOHD AZIZOL AMIRUL (ilca-thailand-nationals-2025, rank 5)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '23036941-24c6-40a4-b4c8-71997f7fe780', '5878691c-f01b-4ab4-976c-e6ad27b8782d', '81faaba4-7246-5e56-9de1-bd3ba0e19a00', 5, 49.0, 75.0,
    false, false, 'M', 'MAS',
    'https://www.racingrulesofsailing.org/documents/116668', 'ILCA Thailand Nationals 2025 — ILCA 4 results', 'pdf', 'Identity resolved: Matches existing profile Muhammad Adam Aierell Mohd Azizol Amirul (MSA/MSN, MAS).',
    'verified', now(), 'MUHAMMAD ADAM AIERELL BIN MOHD AZIZOL AMIRUL', '209892',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    '931fa52e-0651-4f09-8258-da9f4af63139', '23036941-24c6-40a4-b4c8-71997f7fe780', '5878691c-f01b-4ab4-976c-e6ad27b8782d', 'MUHAMMAD ADAM AIERELL BIN MOHD AZIZOL AMIRUL', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('23036941-24c6-40a4-b4c8-71997f7fe780', 1, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('23036941-24c6-40a4-b4c8-71997f7fe780', 2, 16.0, NULL, false, '16.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('23036941-24c6-40a4-b4c8-71997f7fe780', 3, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('23036941-24c6-40a4-b4c8-71997f7fe780', 4, 5.0, NULL, false, '5.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('23036941-24c6-40a4-b4c8-71997f7fe780', 5, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('23036941-24c6-40a4-b4c8-71997f7fe780', 6, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('23036941-24c6-40a4-b4c8-71997f7fe780', 7, 8.0, NULL, false, '8.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('23036941-24c6-40a4-b4c8-71997f7fe780', 8, 26.0, NULL, true, '(26.0)');

  -- [26] JUNG YEON KIM (ilca-thailand-nationals-2025, rank 30)
  INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, rank, nett_score, total_score,
    is_dns, is_overseas_commitment, gender, nationality,
    official_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at, entry_label, entry_sail_number,
    entry_type, created_at, updated_at
  ) VALUES (
    '623b0375-4e90-4e4c-8cfa-92ced18869df', '7302a702-2b88-5d53-a946-0bd10f257f43', '81faaba4-7246-5e56-9de1-bd3ba0e19a00', 30, 186.0, 222.0,
    false, false, 'M', 'KOR',
    'https://www.racingrulesofsailing.org/documents/116668', 'ILCA Thailand Nationals 2025 — ILCA 4 results', 'pdf', 'Identity resolved: Matches existing profile Jeongyeon Kim (Gangwon, KOR). Romanisation variant Jung Yeon Kim.',
    'verified', now(), 'JUNG YEON KIM', '215619',
    'individual', now(), now()
  );
  INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
  ) VALUES (
    'c58c9cb6-6d62-4c77-93d6-2d18b326dfcd', '623b0375-4e90-4e4c-8cfa-92ced18869df', '7302a702-2b88-5d53-a946-0bd10f257f43', 'JUNG YEON KIM', 1, 'solo', 'matched', true, now(), now()
  );
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('623b0375-4e90-4e4c-8cfa-92ced18869df', 1, 36.0, 'UFD', true, '(36.0 UFD)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('623b0375-4e90-4e4c-8cfa-92ced18869df', 2, 17.0, NULL, false, '17.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('623b0375-4e90-4e4c-8cfa-92ced18869df', 3, 28.0, NULL, false, '28.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('623b0375-4e90-4e4c-8cfa-92ced18869df', 4, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('623b0375-4e90-4e4c-8cfa-92ced18869df', 5, 32.0, NULL, false, '32.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('623b0375-4e90-4e4c-8cfa-92ced18869df', 6, 25.0, NULL, false, '25.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('623b0375-4e90-4e4c-8cfa-92ced18869df', 7, 33.0, NULL, false, '33.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('623b0375-4e90-4e4c-8cfa-92ced18869df', 8, 31.0, NULL, false, '31.0');

  -- Step 4: Verify final counts on all 11 affected sheets
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_childrens_ilca6;
  IF v_count != 11 THEN RAISE EXCEPTION 'Expected 11 results on childrens_ilca6, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_childrens_opti_green;
  IF v_count != 27 THEN RAISE EXCEPTION 'Expected 27 results on childrens_opti_green, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_childrens_opti_gold;
  IF v_count != 35 THEN RAISE EXCEPTION 'Expected 35 results on childrens_opti_gold, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_childrens_opti_silver;
  IF v_count != 35 THEN RAISE EXCEPTION 'Expected 35 results on childrens_opti_silver, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_longdist_ilca4;
  IF v_count != 13 THEN RAISE EXCEPTION 'Expected 13 results on longdist_ilca4, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_longdist_opti;
  IF v_count != 58 THEN RAISE EXCEPTION 'Expected 58 results on longdist_opti, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_district_ilca4;
  IF v_count != 42 THEN RAISE EXCEPTION 'Expected 42 results on district_ilca4, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_district_ilca7;
  IF v_count != 13 THEN RAISE EXCEPTION 'Expected 13 results on district_ilca7, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_nationals_ilca4;
  IF v_count != 35 THEN RAISE EXCEPTION 'Expected 35 results on nationals_ilca4, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_nationals_ilca6;
  IF v_count != 32 THEN RAISE EXCEPTION 'Expected 32 results on nationals_ilca6, found %', v_count; END IF;
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_nationals_ilca7;
  IF v_count != 32 THEN RAISE EXCEPTION 'Expected 32 results on nationals_ilca7, found %', v_count; END IF;

  -- Step 5: Update schedule_notes on all 11 sheets to reflect complete imports
  UPDATE public.regattas
  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 11 of 11 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_childrens_ilca6;

  UPDATE public.regattas
  SET schedule_notes = 'Official source status: provisional. Provisional organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 27 of 27 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_childrens_opti_green;

  UPDATE public.regattas
  SET schedule_notes = 'Official source status: provisional. Published organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 35 of 35 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_childrens_opti_gold;

  UPDATE public.regattas
  SET schedule_notes = 'Official source status: provisional. Published organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 35 of 35 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_childrens_opti_silver;

  UPDATE public.regattas
  SET schedule_notes = 'Official source status: provisional. Provisional organiser results. Original combined PY handicap standings; class subset, with original ranks and scores. Complete import: 13 of 13 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_longdist_ilca4;

  UPDATE public.regattas
  SET schedule_notes = 'Official source status: provisional. Provisional organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 58 of 58 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_longdist_opti;

  UPDATE public.regattas
  SET schedule_notes = 'Official source status: provisional. Published organiser results; final/provisional status not stated. Official fleet ranks, scoring codes and discards retained. Complete import: 42 of 42 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_district_ilca4;

  UPDATE public.regattas
  SET schedule_notes = 'Official source status: provisional. Published organiser results; final/provisional status not stated. Official fleet ranks, scoring codes and discards retained. Complete import: 13 of 13 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_district_ilca7;

  UPDATE public.regattas
  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 35 of 35 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_nationals_ilca4;

  UPDATE public.regattas
  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 32 of 32 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_nationals_ilca6;

  UPDATE public.regattas
  SET schedule_notes = 'Final organiser results. Official fleet ranks, scoring codes and discards retained. Complete import: 32 of 32 class entries imported; 0 awaiting identity or source review.', updated_at = now()
  WHERE id = v_nationals_ilca7;

  -- Step 6: Audit logging
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source) VALUES
    ('results.resolve_identity', 'regatta', v_childrens_ilca6, 'childrens-day-regatta-2025-ilca6', 'Resolved 1 held entry (Kim). Sheet is 100% complete (11/11).', '{"resolved_count": 1}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_childrens_opti_green, 'childrens-day-regatta-2025-optimist-green', 'Resolved 3 held entries. Sheet is 100% complete (27/27).', '{"resolved_count": 3}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_childrens_opti_gold, 'childrens-day-regatta-2025-optimist-gold', 'Resolved 3 held entries (Tara, Chananchai, Kiitchakhun) and restored 2 entries with source arithmetic discrepancies (Sorawit Naksuk, Panudat Polpool). Sheet is 100% complete (35/35).', '{"resolved_count": 3, "restored_count": 2}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_childrens_opti_silver, 'childrens-day-regatta-2025-optimist-silver', 'Resolved 4 held entries. Sheet is 100% complete (35/35).', '{"resolved_count": 4}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_longdist_ilca4, 'thailand-nationals-long-distance-2025-ilca4', 'Resolved 1 held entry (Pumitus Mee-Iamsin). Sheet is 100% complete (13/13).', '{"resolved_count": 1}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_longdist_opti, 'thailand-nationals-long-distance-2025-optimist', 'Resolved 5 held entries. Sheet is 100% complete (58/58).', '{"resolved_count": 5}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_district_ilca4, 'ilca-district-championship-2025-ilca4', 'Resolved 2 held entries (Kiitchakhun, Jemima Chang). Sheet is 100% complete (42/42).', '{"resolved_count": 2}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_district_ilca7, 'ilca-district-championship-2025-ilca7', 'Resolved 1 held entry (Casey Algra). Sheet is 100% complete (13/13).', '{"resolved_count": 1}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_nationals_ilca4, 'ilca-thailand-nationals-2025-ilca4', 'Resolved 2 held entries (Muhammad Adam Aierell, Jeongyeon Kim) and restored Torn Rattana (Rank 3) unmerged from Ton Rattana. Sheet is 100% complete (35/35).', '{"resolved_count": 2, "restored_count": 1}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_nationals_ilca6, 'ilca-thailand-nationals-2025-ilca6', 'Resolved 4 held entries (Noppassorn, Paranee, Nana Funazawa, Minsol Jeon). Sheet is 100% complete (32/32).', '{"resolved_count": 4}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_nationals_ilca7, 'ilca-thailand-nationals-2025-ilca7', 'Resolved 1 held entry (Wonjeong Lee). Sheet is 100% complete (32/32).', '{"resolved_count": 1}'::jsonb, 'nationals-district-childrens-2025-resolution-2026-11-12');

END $resolve$;
COMMIT;
