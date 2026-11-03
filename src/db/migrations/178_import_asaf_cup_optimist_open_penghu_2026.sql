-- Migration 178: Import 2026 ASAF Cup Optimist Open Championships (Penghu, Taiwan)
-- Sanctioned by Asian Sailing Federation (ASAF) & Chinese Taipei Sailing Association (CTSA)
-- Official Event #15171 on racingrulesofsailing.org (Documents 201421, 201422, 201423, 201182)
-- Arithmetic verification: 100% verified across 71 entries and 616 race scores.
BEGIN;

-- 1. Insert new sailor profiles
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, bio, created_at, updated_at
) VALUES (
    '969d699b-ac23-51dc-b1ac-00e7070595e1', 'Dohwan Kim', 'dohwan-kim-e6d23d', 'KOR564', 'Teamkorea(pohangcity)', 'KOR', 'M', 'ASAF Cup Optimist Open competitor representing KOR.', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, bio, created_at, updated_at
) VALUES (
    '7e0abc5a-75d5-5273-b0f8-4cec7d106914', 'Hirunsiri Munkhongpornpaiboon', 'hirunsiri-munkhongpornpaiboon-ce70f3', 'THA932', 'Thailand', 'THA', 'M', 'ASAF Cup Optimist Open competitor representing THA.', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, bio, created_at, updated_at
) VALUES (
    'a3a56f5a-b9a0-55f9-be09-78ce57354464', 'He-Yen Chen', 'he-yen-chen-3552f9', 'R25', '澎湖縣帆船 協會', 'TPE', 'M', 'ASAF Cup Optimist Open competitor representing TPE. Chinese name: 陳和彥.', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, bio, created_at, updated_at
) VALUES (
    '4d904c1b-b1a3-5873-942b-69138cf8b4ab', 'Daniel Alonso Bantegui Subia', 'daniel-alonso-bantegui-subia-1975ed', 'PHI21', 'PhilippineSailingAssociation', 'PHI', 'M', 'ASAF Cup Optimist Open competitor representing PHI.', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, bio, created_at, updated_at
) VALUES (
    '642a6ff9-06dd-587d-b230-7b98505312cc', 'Chan Cheuk Him', 'chan-cheuk-him-624cbe', 'HKG192', 'RoyalHong KongYacht Club', 'HKG', 'M', 'ASAF Cup Optimist Open competitor representing HKG. Chinese name: 陳卓謙.', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, bio, created_at, updated_at
) VALUES (
    '56cdc1b0-297b-55f1-ab53-18ce968dba2b', 'Yu-Chen Chen', 'yu-chen-chen-74fdd4', 'TPE317', '西門實 小帆船 隊', 'TPE', 'F', 'ASAF Cup Optimist Open competitor representing TPE. Chinese name: 陳宥蓁.', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, bio, created_at, updated_at
) VALUES (
    '2e113407-8fa8-53d2-98a4-2c53d3ed524b', 'Sebin You', 'sebin-you-42af62', 'KOR505', 'Teamkorea(', 'KOR', 'F', 'ASAF Cup Optimist Open competitor representing KOR.', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, bio, created_at, updated_at
) VALUES (
    '23f21394-9b28-5e5b-8a72-c105f459ee3d', 'Chiao-Chen Chang', 'chiao-chen-chang-d09e8a', 'TPE5188', '澎湖縣 帆船協 會', 'TPE', 'F', 'ASAF Cup Optimist Open competitor representing TPE. Chinese name: 張喬媜.', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, bio, created_at, updated_at
) VALUES (
    '132d6125-f1ac-5af0-abc8-6f3c4bef497a', 'Chaeyeong Lee', 'chaeyeong-lee-198a52', 'KOR563', 'Teamkorea(pohangcity)', 'KOR', 'F', 'ASAF Cup Optimist Open competitor representing KOR.', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, bio, created_at, updated_at
) VALUES (
    '84663b62-4f86-5524-b36f-5ae550f7d9d0', 'Seojun Park', 'seojun-park-60edef', 'KOR56', 'Teamkorea(pohangcity)', 'KOR', 'M', 'ASAF Cup Optimist Open competitor representing KOR.', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, bio, created_at, updated_at
) VALUES (
    'd96df1be-ce1b-5c26-aee9-b0da2039fc23', 'Siwon Park', 'siwon-park-b0ebc6', 'KOR565', 'Teamkorea(pohangcity)', 'KOR', 'M', 'ASAF Cup Optimist Open competitor representing KOR.', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, bio, created_at, updated_at
) VALUES (
    '6cd1b091-b483-5fc2-943b-73dd44b20e34', 'Yun-Jen Chang', 'yun-jen-chang-4f530f', 'TPE5166', '澎湖縣 帆船協 會', 'TPE', 'M', 'ASAF Cup Optimist Open competitor representing TPE. Chinese name: 張阭荏.', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, bio, created_at, updated_at
) VALUES (
    '85cbacff-0840-591e-88a0-92215b9bd163', 'Yu-Chen Lo', 'yu-chen-lo-3a3089', 'R77', '澎湖縣 帆船協 會', 'TPE', 'M', 'ASAF Cup Optimist Open competitor representing TPE. Chinese name: 羅宇辰.', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, bio, created_at, updated_at
) VALUES (
    '5230ac1c-fae8-5e83-b2f4-4802d6bd3eff', 'Yu-Chen Yeh', 'yu-chen-yeh-0a2810', 'R22', '澎湖縣 帆船協 會', 'TPE', 'M', 'ASAF Cup Optimist Open competitor representing TPE. Chinese name: 葉宥辰.', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, bio, created_at, updated_at
) VALUES (
    '2557f24d-a76c-5f88-9e4a-19c769578dc4', 'Chaewon Lee', 'chaewon-lee-3c7067', 'KOR558', 'Teamkorea(pohangcity)', 'KOR', 'F', 'ASAF Cup Optimist Open competitor representing KOR.', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, bio, created_at, updated_at
) VALUES (
    '8bced126-c787-51c1-83c2-0fc825937c97', 'Yu-Shu Chen', 'yu-shu-chen-946dcc', 'TPE2916', '澎湖縣 帆船協 會', 'TPE', 'M', 'ASAF Cup Optimist Open competitor representing TPE. Chinese name: 陳語書.', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, bio, created_at, updated_at
) VALUES (
    'cbf9a3b6-5893-5595-b5c2-9390ddfb0879', 'Hsin-Cheng Hsieh', 'hsin-cheng-hsieh-abd4b8', 'R23', '澎湖縣 帆船協 會', 'TPE', 'M', 'ASAF Cup Optimist Open competitor representing TPE. Chinese name: 解信誠.', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);

-- 2. Insert Regatta Event Hub
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer,
    classes, nor_url, created_at, updated_at
) VALUES (
    '034bf987-fc94-5d18-8f28-62f0e71b1380',
    '2026 ASAF Cup Optimist Open Championships',
    'asaf-cup-optimist-open-championships-2026',
    '2026-08-05',
    '2026-08-10',
    'Guanyinting, Penghu, Chinese Taipei',
    'Asian Sailing Federation (ASAF) / Chinese Taipei Sailing Association (CTSA)',
    '["optimist"]'::jsonb,
    'https://www.racingrulesofsailing.org/documents/15171/event',
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    updated_at = clock_timestamp();

-- 3. Insert Regatta Sheets
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '144e5965-df12-5df4-9fc8-2f98016009ec',
    '034bf987-fc94-5d18-8f28-62f0e71b1380',
    '2026 ASAF Cup Optimist Open Championships — Boys Fleet',
    'asaf-cup-optimist-open-championships-2026-boys',
    '2026-08-05',
    '2026-08-10',
    34,
    'Boys',
    8,
    'TPE',
    'optimist',
    'individual',
    1,
    1,
    false,
    'Guanyinting, Penghu, Chinese Taipei',
    'Asian Sailing Federation (ASAF) / Chinese Taipei Sailing Association (CTSA)',
    'published',
    'https://www.racingrulesofsailing.org/documents/15171/event',
    'Racing Rules of Sailing Document 15171',
    '2026 ASAF Cup Optimist Open Championships official final series results',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
-- Results for boys
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '80c89c24-0f40-5cbb-8018-d8ef552aa554', '969d699b-ac23-51dc-b1ac-00e7070595e1', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Dohwan Kim', 'KOR564', 'individual', 1,
    41.0, 26.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 1 | B/U15 | KOR | Points: 26.0 nett (41.0 gross) | Club: Teamkorea(pohangcity)', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5b4654bd-6de9-550c-8b70-a5aa6490f7aa', '80c89c24-0f40-5cbb-8018-d8ef552aa554', '969d699b-ac23-51dc-b1ac-00e7070595e1', 'Dohwan Kim', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '80c89c24-0f40-5cbb-8018-d8ef552aa554', 1, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '80c89c24-0f40-5cbb-8018-d8ef552aa554', 2, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '80c89c24-0f40-5cbb-8018-d8ef552aa554', 3, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '80c89c24-0f40-5cbb-8018-d8ef552aa554', 4, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '80c89c24-0f40-5cbb-8018-d8ef552aa554', 5, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '80c89c24-0f40-5cbb-8018-d8ef552aa554', 6, 15.0, NULL, true, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '80c89c24-0f40-5cbb-8018-d8ef552aa554', 7, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '80c89c24-0f40-5cbb-8018-d8ef552aa554', 8, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a1061deb-fc98-5665-948c-39a5d04a4480', 'f01d617a-7ded-4ad3-b8b7-33cedd3339d9', '144e5965-df12-5df4-9fc8-2f98016009ec', 'You-Shan Liao', 'TPE357', 'individual', 2,
    67.0, 32.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 2 | B/U15 | TPE | Points: 32.0 nett (67.0 gross) | Club: 西門實小帆 船隊', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '81226ff7-cad8-5b91-a56a-423bb2ba5a8c', 'a1061deb-fc98-5665-948c-39a5d04a4480', 'f01d617a-7ded-4ad3-b8b7-33cedd3339d9', 'You-Shan Liao', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a1061deb-fc98-5665-948c-39a5d04a4480', 1, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a1061deb-fc98-5665-948c-39a5d04a4480', 2, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a1061deb-fc98-5665-948c-39a5d04a4480', 3, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a1061deb-fc98-5665-948c-39a5d04a4480', 4, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a1061deb-fc98-5665-948c-39a5d04a4480', 5, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a1061deb-fc98-5665-948c-39a5d04a4480', 6, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a1061deb-fc98-5665-948c-39a5d04a4480', 7, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a1061deb-fc98-5665-948c-39a5d04a4480', 8, 35.0, NULL, true, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '95cbe10f-dbfa-5ead-b7d3-4f693f4665d3', 'd633d303-0df9-5e24-813e-3b9883b6f5d7', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Ching-Hao Huang', 'TPE7027', 'individual', 3,
    53.0, 35.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 3 | B/U15 | TPE | Points: 35.0 nett (53.0 gross) | Club: 慈心帆船社', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'dede5be9-5d33-5cd3-9e01-88e4e838a04e', '95cbe10f-dbfa-5ead-b7d3-4f693f4665d3', 'd633d303-0df9-5e24-813e-3b9883b6f5d7', 'Ching-Hao Huang', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '95cbe10f-dbfa-5ead-b7d3-4f693f4665d3', 1, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '95cbe10f-dbfa-5ead-b7d3-4f693f4665d3', 2, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '95cbe10f-dbfa-5ead-b7d3-4f693f4665d3', 3, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '95cbe10f-dbfa-5ead-b7d3-4f693f4665d3', 4, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '95cbe10f-dbfa-5ead-b7d3-4f693f4665d3', 5, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '95cbe10f-dbfa-5ead-b7d3-4f693f4665d3', 6, 18.0, NULL, true, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '95cbe10f-dbfa-5ead-b7d3-4f693f4665d3', 7, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '95cbe10f-dbfa-5ead-b7d3-4f693f4665d3', 8, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'eebe9e5b-3930-5530-8342-9305611c7d5f', 'f1676640-6736-5ced-aa15-5d34ece931db', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Yu-Heng Kao', 'TPE399', 'individual', 4,
    52.0, 39.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 4 | B/U12 | TPE | Points: 39.0 nett (52.0 gross) | Club: 西門實小帆 船隊', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '42a6a35e-cb85-5072-a185-d2ea0528a491', 'eebe9e5b-3930-5530-8342-9305611c7d5f', 'f1676640-6736-5ced-aa15-5d34ece931db', 'Yu-Heng Kao', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eebe9e5b-3930-5530-8342-9305611c7d5f', 1, 13.0, NULL, true, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eebe9e5b-3930-5530-8342-9305611c7d5f', 2, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eebe9e5b-3930-5530-8342-9305611c7d5f', 3, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eebe9e5b-3930-5530-8342-9305611c7d5f', 4, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eebe9e5b-3930-5530-8342-9305611c7d5f', 5, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eebe9e5b-3930-5530-8342-9305611c7d5f', 6, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eebe9e5b-3930-5530-8342-9305611c7d5f', 7, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eebe9e5b-3930-5530-8342-9305611c7d5f', 8, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '8d150ebe-fbed-585d-bcfe-794c646755af', 'fa95f8cf-a1aa-5899-8a7b-a103437ccb66', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Yu-Chen Wu', 'TPE0438', 'individual', 5,
    55.0, 41.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 5 | B/U15 | TPE | Points: 41.0 nett (55.0 gross) | Club: 慈心帆船社', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '2479e325-4ac8-5a67-a9f1-c9653bbe05aa', '8d150ebe-fbed-585d-bcfe-794c646755af', 'fa95f8cf-a1aa-5899-8a7b-a103437ccb66', 'Yu-Chen Wu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8d150ebe-fbed-585d-bcfe-794c646755af', 1, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8d150ebe-fbed-585d-bcfe-794c646755af', 2, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8d150ebe-fbed-585d-bcfe-794c646755af', 3, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8d150ebe-fbed-585d-bcfe-794c646755af', 4, 14.0, NULL, true, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8d150ebe-fbed-585d-bcfe-794c646755af', 5, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8d150ebe-fbed-585d-bcfe-794c646755af', 6, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8d150ebe-fbed-585d-bcfe-794c646755af', 7, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8d150ebe-fbed-585d-bcfe-794c646755af', 8, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '9452e8a0-d29f-5363-8e9b-a663f3e1ac8f', '254c367b-6e51-5f0d-aed7-8eb7a5891fee', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Hsin-Yi Chen', 'TPE228', 'individual', 6,
    62.0, 45.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 6 | B/U15 | TPE | Points: 45.0 nett (62.0 gross) | Club: 高雄美國學 校', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '48650413-f2c0-5978-a1c1-7fade29bb3ae', '9452e8a0-d29f-5363-8e9b-a663f3e1ac8f', '254c367b-6e51-5f0d-aed7-8eb7a5891fee', 'Hsin-Yi Chen', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9452e8a0-d29f-5363-8e9b-a663f3e1ac8f', 1, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9452e8a0-d29f-5363-8e9b-a663f3e1ac8f', 2, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9452e8a0-d29f-5363-8e9b-a663f3e1ac8f', 3, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9452e8a0-d29f-5363-8e9b-a663f3e1ac8f', 4, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9452e8a0-d29f-5363-8e9b-a663f3e1ac8f', 5, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9452e8a0-d29f-5363-8e9b-a663f3e1ac8f', 6, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9452e8a0-d29f-5363-8e9b-a663f3e1ac8f', 7, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9452e8a0-d29f-5363-8e9b-a663f3e1ac8f', 8, 17.0, NULL, true, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '25c56434-43d8-5367-b1e7-3dddcae718b5', '6bf21dbb-951a-593f-958a-83e8a1f747f7', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Li-Pan Cheng', 'TPE379', 'individual', 7,
    63.0, 48.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 7 | B/U15 | TPE | Points: 48.0 nett (63.0 gross) | Club: 西門實小帆 船隊', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'aeccd3a2-40a1-56ce-9f08-77fe470996a3', '25c56434-43d8-5367-b1e7-3dddcae718b5', '6bf21dbb-951a-593f-958a-83e8a1f747f7', 'Li-Pan Cheng', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25c56434-43d8-5367-b1e7-3dddcae718b5', 1, 15.0, NULL, true, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25c56434-43d8-5367-b1e7-3dddcae718b5', 2, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25c56434-43d8-5367-b1e7-3dddcae718b5', 3, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25c56434-43d8-5367-b1e7-3dddcae718b5', 4, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25c56434-43d8-5367-b1e7-3dddcae718b5', 5, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25c56434-43d8-5367-b1e7-3dddcae718b5', 6, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25c56434-43d8-5367-b1e7-3dddcae718b5', 7, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25c56434-43d8-5367-b1e7-3dddcae718b5', 8, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'beafa6ce-3295-5ba8-8def-649e01117e07', '85242f97-5154-5a43-a4b8-2616129bf515', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Chien-Jun Lin', 'TPE304', 'individual', 8,
    74.0, 52.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 8 | B/U15 | TPE | Points: 52.0 nett (74.0 gross) | Club: 慈心帆船社', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '70f37556-3d13-52ba-aeab-36c209105273', 'beafa6ce-3295-5ba8-8def-649e01117e07', '85242f97-5154-5a43-a4b8-2616129bf515', 'Chien-Jun Lin', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'beafa6ce-3295-5ba8-8def-649e01117e07', 1, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'beafa6ce-3295-5ba8-8def-649e01117e07', 2, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'beafa6ce-3295-5ba8-8def-649e01117e07', 3, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'beafa6ce-3295-5ba8-8def-649e01117e07', 4, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'beafa6ce-3295-5ba8-8def-649e01117e07', 5, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'beafa6ce-3295-5ba8-8def-649e01117e07', 6, 22.0, NULL, true, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'beafa6ce-3295-5ba8-8def-649e01117e07', 7, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'beafa6ce-3295-5ba8-8def-649e01117e07', 8, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '5c92d3f4-b9db-5328-b9d2-42ebd378c7bb', '7e0abc5a-75d5-5273-b0f8-4cec7d106914', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Hirunsiri Munkhongpornpaiboon', 'THA932', 'individual', 9,
    79.0, 61.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 9 | B/U12 | THA | Points: 61.0 nett (79.0 gross) | Club: Thailand', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '807ac1ad-8d18-541e-84c2-3166e835f159', '5c92d3f4-b9db-5328-b9d2-42ebd378c7bb', '7e0abc5a-75d5-5273-b0f8-4cec7d106914', 'Hirunsiri Munkhongpornpaiboon', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5c92d3f4-b9db-5328-b9d2-42ebd378c7bb', 1, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5c92d3f4-b9db-5328-b9d2-42ebd378c7bb', 2, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5c92d3f4-b9db-5328-b9d2-42ebd378c7bb', 3, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5c92d3f4-b9db-5328-b9d2-42ebd378c7bb', 4, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5c92d3f4-b9db-5328-b9d2-42ebd378c7bb', 5, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5c92d3f4-b9db-5328-b9d2-42ebd378c7bb', 6, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5c92d3f4-b9db-5328-b9d2-42ebd378c7bb', 7, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5c92d3f4-b9db-5328-b9d2-42ebd378c7bb', 8, 18.0, NULL, true, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '26cc2747-e3f0-5baa-a8f3-c2993f52dd69', '5f06d81b-8f07-519b-b6e0-52afda7684a6', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Tzu-Le Liu', 'TPE336', 'individual', 10,
    76.0, 62.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 10 | B/U15 | TPE | Points: 62.0 nett (76.0 gross) | Club: 慈心帆船社', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f3a4d648-e704-54f3-9c33-f4062f5a3855', '26cc2747-e3f0-5baa-a8f3-c2993f52dd69', '5f06d81b-8f07-519b-b6e0-52afda7684a6', 'Tzu-Le Liu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '26cc2747-e3f0-5baa-a8f3-c2993f52dd69', 1, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '26cc2747-e3f0-5baa-a8f3-c2993f52dd69', 2, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '26cc2747-e3f0-5baa-a8f3-c2993f52dd69', 3, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '26cc2747-e3f0-5baa-a8f3-c2993f52dd69', 4, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '26cc2747-e3f0-5baa-a8f3-c2993f52dd69', 5, 14.0, NULL, true, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '26cc2747-e3f0-5baa-a8f3-c2993f52dd69', 6, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '26cc2747-e3f0-5baa-a8f3-c2993f52dd69', 7, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '26cc2747-e3f0-5baa-a8f3-c2993f52dd69', 8, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '6db81bb8-214e-5315-86a2-fea61bcfe034', 'e08a26a2-0a66-49bc-a0c1-f5e5849df216', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Chia-Hsin Chiu', 'TPE312', 'individual', 11,
    86.5, 65.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 11 | B/U12 | TPE | Points: 65.0 nett (86.5 gross) | Club: 西門實小帆 船隊', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f7d374d4-cb70-5335-9753-8219b17f81a9', '6db81bb8-214e-5315-86a2-fea61bcfe034', 'e08a26a2-0a66-49bc-a0c1-f5e5849df216', 'Chia-Hsin Chiu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6db81bb8-214e-5315-86a2-fea61bcfe034', 1, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6db81bb8-214e-5315-86a2-fea61bcfe034', 2, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6db81bb8-214e-5315-86a2-fea61bcfe034', 3, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6db81bb8-214e-5315-86a2-fea61bcfe034', 4, 21.5, NULL, true, '21.5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6db81bb8-214e-5315-86a2-fea61bcfe034', 5, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6db81bb8-214e-5315-86a2-fea61bcfe034', 6, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6db81bb8-214e-5315-86a2-fea61bcfe034', 7, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6db81bb8-214e-5315-86a2-fea61bcfe034', 8, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '7068d1f2-3513-552f-8e02-ea5763617cbd', '8eb39919-2873-52ba-b924-5caceb21772b', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Ching-Heng Chen', 'TPE0525', 'individual', 12,
    80.0, 65.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 12 | B/U15 | TPE | Points: 65.0 nett (80.0 gross) | Club: 慈心帆船社', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'be9a9b8b-3fac-5ef9-a2f4-eb0ba3d3b375', '7068d1f2-3513-552f-8e02-ea5763617cbd', '8eb39919-2873-52ba-b924-5caceb21772b', 'Ching-Heng Chen', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7068d1f2-3513-552f-8e02-ea5763617cbd', 1, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7068d1f2-3513-552f-8e02-ea5763617cbd', 2, 15.0, NULL, true, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7068d1f2-3513-552f-8e02-ea5763617cbd', 3, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7068d1f2-3513-552f-8e02-ea5763617cbd', 4, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7068d1f2-3513-552f-8e02-ea5763617cbd', 5, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7068d1f2-3513-552f-8e02-ea5763617cbd', 6, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7068d1f2-3513-552f-8e02-ea5763617cbd', 7, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7068d1f2-3513-552f-8e02-ea5763617cbd', 8, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '092eb327-2c09-5a4f-b461-e0e2961972af', '88a2fbbe-aab5-574e-8857-17af0d41761b', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Ko-Pang Chen', 'TPE388', 'individual', 13,
    92.0, 76.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 13 | B/U15 | TPE | Points: 76.0 nett (92.0 gross) | Club: 西門實小帆 船隊', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a0324b48-aaf2-5604-b3f3-5c976402eee9', '092eb327-2c09-5a4f-b461-e0e2961972af', '88a2fbbe-aab5-574e-8857-17af0d41761b', 'Ko-Pang Chen', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '092eb327-2c09-5a4f-b461-e0e2961972af', 1, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '092eb327-2c09-5a4f-b461-e0e2961972af', 2, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '092eb327-2c09-5a4f-b461-e0e2961972af', 3, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '092eb327-2c09-5a4f-b461-e0e2961972af', 4, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '092eb327-2c09-5a4f-b461-e0e2961972af', 5, 16.0, NULL, true, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '092eb327-2c09-5a4f-b461-e0e2961972af', 6, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '092eb327-2c09-5a4f-b461-e0e2961972af', 7, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '092eb327-2c09-5a4f-b461-e0e2961972af', 8, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'dc4f475a-ddf3-5588-8054-54ab44dcf2a7', 'c755dfaa-75cc-4739-8a41-18eafa49dc9d', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Cheng-Che Tsai', 'TPE302', 'individual', 14,
    114.0, 79.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 14 | B/U12 | TPE | Points: 79.0 nett (114.0 gross) | Club: 西門實小帆 船隊', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f3502408-b304-555b-bd21-ba3898e6638e', 'dc4f475a-ddf3-5588-8054-54ab44dcf2a7', 'c755dfaa-75cc-4739-8a41-18eafa49dc9d', 'Cheng-Che Tsai', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc4f475a-ddf3-5588-8054-54ab44dcf2a7', 1, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc4f475a-ddf3-5588-8054-54ab44dcf2a7', 2, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc4f475a-ddf3-5588-8054-54ab44dcf2a7', 3, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc4f475a-ddf3-5588-8054-54ab44dcf2a7', 4, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc4f475a-ddf3-5588-8054-54ab44dcf2a7', 5, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc4f475a-ddf3-5588-8054-54ab44dcf2a7', 6, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc4f475a-ddf3-5588-8054-54ab44dcf2a7', 7, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dc4f475a-ddf3-5588-8054-54ab44dcf2a7', 8, 35.0, NULL, true, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ff3b8279-75aa-528a-b00f-addb3649b601', 'c2f440b9-b509-59c9-928e-d25c9f722fb3', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Hsi-Hsiang Chen', 'TPE305', 'individual', 15,
    109.0, 86.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 15 | B/U15 | TPE | Points: 86.0 nett (109.0 gross) | Club: 個人', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9554ad84-fee8-5ab1-bb82-e5e64cfc35a8', 'ff3b8279-75aa-528a-b00f-addb3649b601', 'c2f440b9-b509-59c9-928e-d25c9f722fb3', 'Hsi-Hsiang Chen', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff3b8279-75aa-528a-b00f-addb3649b601', 1, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff3b8279-75aa-528a-b00f-addb3649b601', 2, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff3b8279-75aa-528a-b00f-addb3649b601', 3, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff3b8279-75aa-528a-b00f-addb3649b601', 4, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff3b8279-75aa-528a-b00f-addb3649b601', 5, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff3b8279-75aa-528a-b00f-addb3649b601', 6, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff3b8279-75aa-528a-b00f-addb3649b601', 7, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff3b8279-75aa-528a-b00f-addb3649b601', 8, 23.0, NULL, true, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '64471b59-8ccb-565d-8575-73b72ac32712', '3abc74d9-167d-5bc9-b5e4-a496ec17a4ed', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Yu-An Chen', 'TPE352', 'individual', 16,
    112.0, 96.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 16 | B/U15 | TPE | Points: 96.0 nett (112.0 gross) | Club: 台北市體育 總會帆船協 會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c0e2302e-683c-56ed-8aa0-e0b5f134b0e5', '64471b59-8ccb-565d-8575-73b72ac32712', '3abc74d9-167d-5bc9-b5e4-a496ec17a4ed', 'Yu-An Chen', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '64471b59-8ccb-565d-8575-73b72ac32712', 1, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '64471b59-8ccb-565d-8575-73b72ac32712', 2, 16.0, NULL, true, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '64471b59-8ccb-565d-8575-73b72ac32712', 3, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '64471b59-8ccb-565d-8575-73b72ac32712', 4, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '64471b59-8ccb-565d-8575-73b72ac32712', 5, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '64471b59-8ccb-565d-8575-73b72ac32712', 6, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '64471b59-8ccb-565d-8575-73b72ac32712', 7, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '64471b59-8ccb-565d-8575-73b72ac32712', 8, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f7bd08ec-5250-579b-aef9-246a12eae7dd', '5ffedc80-dc4c-5c6c-832a-dfb8118c82c2', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Chun-Lun Chuang', 'TPE353', 'individual', 17,
    132.0, 110.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 17 | B/U15 | TPE | Points: 110.0 nett (132.0 gross) | Club: 台北市體育 總會帆船協 會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '190ebfc4-252b-5e3e-a90d-2c4052b1ef20', 'f7bd08ec-5250-579b-aef9-246a12eae7dd', '5ffedc80-dc4c-5c6c-832a-dfb8118c82c2', 'Chun-Lun Chuang', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7bd08ec-5250-579b-aef9-246a12eae7dd', 1, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7bd08ec-5250-579b-aef9-246a12eae7dd', 2, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7bd08ec-5250-579b-aef9-246a12eae7dd', 3, 22.0, NULL, true, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7bd08ec-5250-579b-aef9-246a12eae7dd', 4, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7bd08ec-5250-579b-aef9-246a12eae7dd', 5, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7bd08ec-5250-579b-aef9-246a12eae7dd', 6, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7bd08ec-5250-579b-aef9-246a12eae7dd', 7, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7bd08ec-5250-579b-aef9-246a12eae7dd', 8, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e017e4b3-42f8-5c0b-a8f0-b66fdc2c499e', 'dde9ddd6-db05-5d2f-945c-69c1c40bfefa', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Haruka Takahashi', 'JPN3227', 'individual', 18,
    152.0, 127.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 18 | B/U10 | JPN | Points: 127.0 nett (152.0 gross) | Club: B&GHyogoJuniorOceanClub', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'fc673b16-fcd5-56e1-aafb-35291d6e5f5e', 'e017e4b3-42f8-5c0b-a8f0-b66fdc2c499e', 'dde9ddd6-db05-5d2f-945c-69c1c40bfefa', 'Haruka Takahashi', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e017e4b3-42f8-5c0b-a8f0-b66fdc2c499e', 1, 25.0, NULL, true, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e017e4b3-42f8-5c0b-a8f0-b66fdc2c499e', 2, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e017e4b3-42f8-5c0b-a8f0-b66fdc2c499e', 3, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e017e4b3-42f8-5c0b-a8f0-b66fdc2c499e', 4, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e017e4b3-42f8-5c0b-a8f0-b66fdc2c499e', 5, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e017e4b3-42f8-5c0b-a8f0-b66fdc2c499e', 6, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e017e4b3-42f8-5c0b-a8f0-b66fdc2c499e', 7, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e017e4b3-42f8-5c0b-a8f0-b66fdc2c499e', 8, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '6b12253b-58bc-5b7f-99ab-72ca047d8126', 'bbe13c8b-4ee2-57fd-af74-84ba978b0bf3', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Chan-Jui Liu', 'TPE771', 'individual', 19,
    167.0, 132.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 19 | B/U12 | TPE | Points: 132.0 nett (167.0 gross) | Club: 高雄市舊城 蓮潭帆船隊', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '67c42676-80e7-53b0-b494-6f3b71fb5b1a', '6b12253b-58bc-5b7f-99ab-72ca047d8126', 'bbe13c8b-4ee2-57fd-af74-84ba978b0bf3', 'Chan-Jui Liu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6b12253b-58bc-5b7f-99ab-72ca047d8126', 1, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6b12253b-58bc-5b7f-99ab-72ca047d8126', 2, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6b12253b-58bc-5b7f-99ab-72ca047d8126', 3, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6b12253b-58bc-5b7f-99ab-72ca047d8126', 4, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6b12253b-58bc-5b7f-99ab-72ca047d8126', 5, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6b12253b-58bc-5b7f-99ab-72ca047d8126', 6, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6b12253b-58bc-5b7f-99ab-72ca047d8126', 7, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6b12253b-58bc-5b7f-99ab-72ca047d8126', 8, 35.0, NULL, true, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '2f9e765e-ef8e-5e8d-ab8a-2f33f56bb117', 'd76e6581-d1b0-5211-a72d-88ac7a602f51', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Yung-Yung Chen', 'TPE361', 'individual', 20,
    165.0, 139.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 20 | B/U10 | TPE | Points: 139.0 nett (165.0 gross) | Club: 台北市體育 總會帆船協 會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a08dd4b8-49f5-5cce-a4d9-1dae434297d6', '2f9e765e-ef8e-5e8d-ab8a-2f33f56bb117', 'd76e6581-d1b0-5211-a72d-88ac7a602f51', 'Yung-Yung Chen', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2f9e765e-ef8e-5e8d-ab8a-2f33f56bb117', 1, 26.0, NULL, true, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2f9e765e-ef8e-5e8d-ab8a-2f33f56bb117', 2, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2f9e765e-ef8e-5e8d-ab8a-2f33f56bb117', 3, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2f9e765e-ef8e-5e8d-ab8a-2f33f56bb117', 4, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2f9e765e-ef8e-5e8d-ab8a-2f33f56bb117', 5, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2f9e765e-ef8e-5e8d-ab8a-2f33f56bb117', 6, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2f9e765e-ef8e-5e8d-ab8a-2f33f56bb117', 7, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2f9e765e-ef8e-5e8d-ab8a-2f33f56bb117', 8, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '57110690-3088-57db-815b-b436d6b3cfd7', '42ef2ae2-4817-54ae-b791-c8b9aaea9d53', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Chi-Kang Huang', 'TPE535', 'individual', 21,
    166.0, 141.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 21 | B/U10 | TPE | Points: 141.0 nett (166.0 gross) | Club: 澎湖縣帆船 協會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3bcec81f-0135-588c-a3dd-8341dc377f77', '57110690-3088-57db-815b-b436d6b3cfd7', '42ef2ae2-4817-54ae-b791-c8b9aaea9d53', 'Chi-Kang Huang', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '57110690-3088-57db-815b-b436d6b3cfd7', 1, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '57110690-3088-57db-815b-b436d6b3cfd7', 2, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '57110690-3088-57db-815b-b436d6b3cfd7', 3, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '57110690-3088-57db-815b-b436d6b3cfd7', 4, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '57110690-3088-57db-815b-b436d6b3cfd7', 5, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '57110690-3088-57db-815b-b436d6b3cfd7', 6, 25.0, NULL, true, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '57110690-3088-57db-815b-b436d6b3cfd7', 7, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '57110690-3088-57db-815b-b436d6b3cfd7', 8, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'b281e60f-f923-5ed2-899e-f908adfe03da', '7b5e9e3f-885d-5e04-9f8b-044cd97414e3', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Yin-Tung Lee', 'TPE525', 'individual', 22,
    168.0, 142.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 22 | B/U10 | TPE | Points: 142.0 nett (168.0 gross) | Club: 澎湖縣帆船 協會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '08e59943-0d4c-5464-bfaa-eaad99707182', 'b281e60f-f923-5ed2-899e-f908adfe03da', '7b5e9e3f-885d-5e04-9f8b-044cd97414e3', 'Yin-Tung Lee', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b281e60f-f923-5ed2-899e-f908adfe03da', 1, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b281e60f-f923-5ed2-899e-f908adfe03da', 2, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b281e60f-f923-5ed2-899e-f908adfe03da', 3, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b281e60f-f923-5ed2-899e-f908adfe03da', 4, 26.0, NULL, true, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b281e60f-f923-5ed2-899e-f908adfe03da', 5, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b281e60f-f923-5ed2-899e-f908adfe03da', 6, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b281e60f-f923-5ed2-899e-f908adfe03da', 7, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b281e60f-f923-5ed2-899e-f908adfe03da', 8, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '5a29f23a-87c6-54fe-b170-91431e4a278d', 'a3a56f5a-b9a0-55f9-be09-78ce57354464', '144e5965-df12-5df4-9fc8-2f98016009ec', 'He-Yen Chen', 'R25', 'individual', 23,
    173.0, 146.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 23 | B/U15 | TPE | Points: 146.0 nett (173.0 gross) | Club: 澎湖縣帆船 協會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f949b3cb-8ee7-5a73-ba16-72756415d2cf', '5a29f23a-87c6-54fe-b170-91431e4a278d', 'a3a56f5a-b9a0-55f9-be09-78ce57354464', 'He-Yen Chen', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a29f23a-87c6-54fe-b170-91431e4a278d', 1, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a29f23a-87c6-54fe-b170-91431e4a278d', 2, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a29f23a-87c6-54fe-b170-91431e4a278d', 3, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a29f23a-87c6-54fe-b170-91431e4a278d', 4, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a29f23a-87c6-54fe-b170-91431e4a278d', 5, 27.0, NULL, true, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a29f23a-87c6-54fe-b170-91431e4a278d', 6, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a29f23a-87c6-54fe-b170-91431e4a278d', 7, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a29f23a-87c6-54fe-b170-91431e4a278d', 8, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e52f2665-555b-5e10-80da-b0d9b96dad88', '7e455f91-5dc1-5764-abf4-63893c88207a', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Yu-Fan Shih', 'TPE7389', 'individual', 24,
    200.0, 165.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 24 | B/U15 | TPE | Points: 165.0 nett (200.0 gross) | Club: 慈心帆船社', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '8619d2dc-5966-5cdf-91b3-254d12ce7591', 'e52f2665-555b-5e10-80da-b0d9b96dad88', '7e455f91-5dc1-5764-abf4-63893c88207a', 'Yu-Fan Shih', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e52f2665-555b-5e10-80da-b0d9b96dad88', 1, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e52f2665-555b-5e10-80da-b0d9b96dad88', 2, 35.0, NULL, true, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e52f2665-555b-5e10-80da-b0d9b96dad88', 3, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e52f2665-555b-5e10-80da-b0d9b96dad88', 4, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e52f2665-555b-5e10-80da-b0d9b96dad88', 5, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e52f2665-555b-5e10-80da-b0d9b96dad88', 6, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e52f2665-555b-5e10-80da-b0d9b96dad88', 7, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e52f2665-555b-5e10-80da-b0d9b96dad88', 8, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '99590707-1e64-59d0-ae33-9a2a01fce95b', '4d904c1b-b1a3-5873-942b-69138cf8b4ab', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Daniel Alonso Bantegui Subia', 'PHI21', 'individual', 25,
    195.0, 167.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 25 | B/U12 | PHI | Points: 167.0 nett (195.0 gross) | Club: PhilippineSailingAssociation', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0879ab70-d94f-5639-af32-34bb697fe39a', '99590707-1e64-59d0-ae33-9a2a01fce95b', '4d904c1b-b1a3-5873-942b-69138cf8b4ab', 'Daniel Alonso Bantegui Subia', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99590707-1e64-59d0-ae33-9a2a01fce95b', 1, 28.0, NULL, true, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99590707-1e64-59d0-ae33-9a2a01fce95b', 2, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99590707-1e64-59d0-ae33-9a2a01fce95b', 3, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99590707-1e64-59d0-ae33-9a2a01fce95b', 4, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99590707-1e64-59d0-ae33-9a2a01fce95b', 5, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99590707-1e64-59d0-ae33-9a2a01fce95b', 6, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99590707-1e64-59d0-ae33-9a2a01fce95b', 7, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99590707-1e64-59d0-ae33-9a2a01fce95b', 8, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd865a321-a010-5728-a851-23852827c92c', '4236390e-1f4d-5242-b2eb-e676bd551f60', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Ying-Yu Chen', 'TPE775', 'individual', 26,
    196.0, 168.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 26 | B/U12 | TPE | Points: 168.0 nett (196.0 gross) | Club: 高雄市舊城 蓮潭帆船隊', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3fbf238e-4c0d-564e-b1ff-c224cfa4838a', 'd865a321-a010-5728-a851-23852827c92c', '4236390e-1f4d-5242-b2eb-e676bd551f60', 'Ying-Yu Chen', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd865a321-a010-5728-a851-23852827c92c', 1, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd865a321-a010-5728-a851-23852827c92c', 2, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd865a321-a010-5728-a851-23852827c92c', 3, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd865a321-a010-5728-a851-23852827c92c', 4, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd865a321-a010-5728-a851-23852827c92c', 5, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd865a321-a010-5728-a851-23852827c92c', 6, 28.0, NULL, true, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd865a321-a010-5728-a851-23852827c92c', 7, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd865a321-a010-5728-a851-23852827c92c', 8, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '53a69f80-06b0-5265-933b-653744084430', 'b1a7dd64-fe8a-5606-9782-3049cdc83425', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Chi-Sheng Chen', 'TPE500', 'individual', 27,
    209.0, 174.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 27 | B/U10 | TPE | Points: 174.0 nett (209.0 gross) | Club: 澎湖縣帆船 協會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a36a3b09-c243-5105-8f41-2a83459ae922', '53a69f80-06b0-5265-933b-653744084430', 'b1a7dd64-fe8a-5606-9782-3049cdc83425', 'Chi-Sheng Chen', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53a69f80-06b0-5265-933b-653744084430', 1, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53a69f80-06b0-5265-933b-653744084430', 2, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53a69f80-06b0-5265-933b-653744084430', 3, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53a69f80-06b0-5265-933b-653744084430', 4, 35.0, NULL, true, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53a69f80-06b0-5265-933b-653744084430', 5, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53a69f80-06b0-5265-933b-653744084430', 6, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53a69f80-06b0-5265-933b-653744084430', 7, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53a69f80-06b0-5265-933b-653744084430', 8, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '89b1ea93-e703-555c-a123-0f954858cd1c', '5af9588b-6ef2-5b2f-8726-7288ca98dd37', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Chen-Feng Chen', 'TPE555', 'individual', 28,
    207.0, 177.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 28 | B/U12 | TPE | Points: 177.0 nett (207.0 gross) | Club: 澎湖縣帆船 協會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'dc2947e4-9575-5a0d-ba29-76e180b3b556', '89b1ea93-e703-555c-a123-0f954858cd1c', '5af9588b-6ef2-5b2f-8726-7288ca98dd37', 'Chen-Feng Chen', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89b1ea93-e703-555c-a123-0f954858cd1c', 1, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89b1ea93-e703-555c-a123-0f954858cd1c', 2, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89b1ea93-e703-555c-a123-0f954858cd1c', 3, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89b1ea93-e703-555c-a123-0f954858cd1c', 4, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89b1ea93-e703-555c-a123-0f954858cd1c', 5, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89b1ea93-e703-555c-a123-0f954858cd1c', 6, 30.0, NULL, true, '30.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89b1ea93-e703-555c-a123-0f954858cd1c', 7, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89b1ea93-e703-555c-a123-0f954858cd1c', 8, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'dcea1171-bc1b-501a-a993-177bf754e75d', '86b36815-73c2-5333-8a7c-bbb82e3688be', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Chien-Yu Huang', 'TPE351', 'individual', 29,
    231.0, 196.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 29 | B/U10 | TPE | Points: 196.0 nett (231.0 gross) | Club: 台北市體育 總會帆船協 會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '36a5893d-ae5d-5c08-9dbc-547b94921bd5', 'dcea1171-bc1b-501a-a993-177bf754e75d', '86b36815-73c2-5333-8a7c-bbb82e3688be', 'Chien-Yu Huang', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dcea1171-bc1b-501a-a993-177bf754e75d', 1, 35.0, NULL, true, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dcea1171-bc1b-501a-a993-177bf754e75d', 2, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dcea1171-bc1b-501a-a993-177bf754e75d', 3, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dcea1171-bc1b-501a-a993-177bf754e75d', 4, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dcea1171-bc1b-501a-a993-177bf754e75d', 5, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dcea1171-bc1b-501a-a993-177bf754e75d', 6, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dcea1171-bc1b-501a-a993-177bf754e75d', 7, 30.0, NULL, false, '30.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dcea1171-bc1b-501a-a993-177bf754e75d', 8, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd25384a2-49b2-5dcd-a514-66d0de54cd70', '84417cff-bddd-546e-ac5c-324412cb9891', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Yi-Chen Hsu', 'TPE545', 'individual', 30,
    235.0, 200.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 30 | B/U10 | TPE | Points: 200.0 nett (235.0 gross) | Club: 澎湖縣帆船 協會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '75f47212-ed60-5abe-bb49-8d64d10fd848', 'd25384a2-49b2-5dcd-a514-66d0de54cd70', '84417cff-bddd-546e-ac5c-324412cb9891', 'Yi-Chen Hsu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd25384a2-49b2-5dcd-a514-66d0de54cd70', 1, 35.0, NULL, true, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd25384a2-49b2-5dcd-a514-66d0de54cd70', 2, 30.0, NULL, false, '30.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd25384a2-49b2-5dcd-a514-66d0de54cd70', 3, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd25384a2-49b2-5dcd-a514-66d0de54cd70', 4, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd25384a2-49b2-5dcd-a514-66d0de54cd70', 5, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd25384a2-49b2-5dcd-a514-66d0de54cd70', 6, 31.0, NULL, false, '31.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd25384a2-49b2-5dcd-a514-66d0de54cd70', 7, 31.0, NULL, false, '31.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd25384a2-49b2-5dcd-a514-66d0de54cd70', 8, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '45e92d5b-c1e9-5fd3-a3f4-11d0505e05eb', '1798d7d8-3214-57d5-8a53-029dc369050f', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Zac Allison Belgica', 'PHI231', 'individual', 31,
    235.0, 200.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 31 | B/U15 | PHI | Points: 200.0 nett (235.0 gross) | Club: PhilippineSailingAssociation', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9a6817e0-2d9d-59af-99ad-137608d4ad12', '45e92d5b-c1e9-5fd3-a3f4-11d0505e05eb', '1798d7d8-3214-57d5-8a53-029dc369050f', 'Zac Allison Belgica', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e92d5b-c1e9-5fd3-a3f4-11d0505e05eb', 1, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e92d5b-c1e9-5fd3-a3f4-11d0505e05eb', 2, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e92d5b-c1e9-5fd3-a3f4-11d0505e05eb', 3, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e92d5b-c1e9-5fd3-a3f4-11d0505e05eb', 4, 35.0, NULL, true, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e92d5b-c1e9-5fd3-a3f4-11d0505e05eb', 5, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e92d5b-c1e9-5fd3-a3f4-11d0505e05eb', 6, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e92d5b-c1e9-5fd3-a3f4-11d0505e05eb', 7, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e92d5b-c1e9-5fd3-a3f4-11d0505e05eb', 8, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd8224647-a9fe-5922-94b5-fa3bc9abcd43', '6a47226c-e5c9-4b83-b962-266bbd3c8ccd', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Tammachat Sriopas', 'THA3993', 'individual', 32,
    280.0, 245.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 32 | B/U15 | THA | Points: 245.0 nett (280.0 gross) | Club: Thailand', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '557ebc9c-d7f4-5e18-97ee-b63c630b77cd', 'd8224647-a9fe-5922-94b5-fa3bc9abcd43', '6a47226c-e5c9-4b83-b962-266bbd3c8ccd', 'Tammachat Sriopas', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd8224647-a9fe-5922-94b5-fa3bc9abcd43', 1, 35.0, NULL, true, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd8224647-a9fe-5922-94b5-fa3bc9abcd43', 2, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd8224647-a9fe-5922-94b5-fa3bc9abcd43', 3, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd8224647-a9fe-5922-94b5-fa3bc9abcd43', 4, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd8224647-a9fe-5922-94b5-fa3bc9abcd43', 5, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd8224647-a9fe-5922-94b5-fa3bc9abcd43', 6, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd8224647-a9fe-5922-94b5-fa3bc9abcd43', 7, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd8224647-a9fe-5922-94b5-fa3bc9abcd43', 8, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '88b81a53-55ba-5a30-ba34-333a7daa1ff1', '642a6ff9-06dd-587d-b230-7b98505312cc', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Chan Cheuk Him', 'HKG192', 'individual', 32,
    280.0, 245.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 32 | B/U15 | HKG | Points: 245.0 nett (280.0 gross) | Club: RoyalHong KongYacht Club', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0fbb10e7-fd5d-5921-8930-212aa59c4dd2', '88b81a53-55ba-5a30-ba34-333a7daa1ff1', '642a6ff9-06dd-587d-b230-7b98505312cc', 'Chan Cheuk Him', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '88b81a53-55ba-5a30-ba34-333a7daa1ff1', 1, 35.0, NULL, true, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '88b81a53-55ba-5a30-ba34-333a7daa1ff1', 2, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '88b81a53-55ba-5a30-ba34-333a7daa1ff1', 3, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '88b81a53-55ba-5a30-ba34-333a7daa1ff1', 4, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '88b81a53-55ba-5a30-ba34-333a7daa1ff1', 5, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '88b81a53-55ba-5a30-ba34-333a7daa1ff1', 6, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '88b81a53-55ba-5a30-ba34-333a7daa1ff1', 7, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '88b81a53-55ba-5a30-ba34-333a7daa1ff1', 8, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '7ba7f633-ed12-58b4-b65a-697db89e9557', '8c67fc05-1caf-434c-88a5-71ad35c4fba0', '144e5965-df12-5df4-9fc8-2f98016009ec', 'Setthawit Yodmanee', 'THA878', 'individual', 32,
    280.0, 245.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/boys_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 32 | B/U10 | THA | Points: 245.0 nett (280.0 gross) | Club: Thailand', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '38f8bcc2-7716-58cb-b370-4fea9c313bd3', '7ba7f633-ed12-58b4-b65a-697db89e9557', '8c67fc05-1caf-434c-88a5-71ad35c4fba0', 'Setthawit Yodmanee', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7ba7f633-ed12-58b4-b65a-697db89e9557', 1, 35.0, NULL, true, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7ba7f633-ed12-58b4-b65a-697db89e9557', 2, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7ba7f633-ed12-58b4-b65a-697db89e9557', 3, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7ba7f633-ed12-58b4-b65a-697db89e9557', 4, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7ba7f633-ed12-58b4-b65a-697db89e9557', 5, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7ba7f633-ed12-58b4-b65a-697db89e9557', 6, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7ba7f633-ed12-58b4-b65a-697db89e9557', 7, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7ba7f633-ed12-58b4-b65a-697db89e9557', 8, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '21053319-004d-5271-b2bb-fc0102b4038a',
    '034bf987-fc94-5d18-8f28-62f0e71b1380',
    '2026 ASAF Cup Optimist Open Championships — Girls Fleet',
    'asaf-cup-optimist-open-championships-2026-girls',
    '2026-08-05',
    '2026-08-10',
    21,
    'Girls',
    8,
    'TPE',
    'optimist',
    'individual',
    1,
    1,
    false,
    'Guanyinting, Penghu, Chinese Taipei',
    'Asian Sailing Federation (ASAF) / Chinese Taipei Sailing Association (CTSA)',
    'published',
    'https://www.racingrulesofsailing.org/documents/15171/event',
    'Racing Rules of Sailing Document 15171',
    '2026 ASAF Cup Optimist Open Championships official final series results',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
-- Results for girls
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '9acfe4a5-faa7-5d83-aaa4-4d1e2f50939d', 'fdb5520d-f181-4d5a-ad46-8157fd378a1a', '21053319-004d-5271-b2bb-fc0102b4038a', 'Suchanya Kaminthong', 'ITA9212', 'individual', 1,
    27.0, 19.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 1 | G/U15 | THA | Points: 19.0 nett (27.0 gross) | Club: Thailand', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e26066fb-5732-5f86-a69a-74ed431db022', '9acfe4a5-faa7-5d83-aaa4-4d1e2f50939d', 'fdb5520d-f181-4d5a-ad46-8157fd378a1a', 'Suchanya Kaminthong', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9acfe4a5-faa7-5d83-aaa4-4d1e2f50939d', 1, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9acfe4a5-faa7-5d83-aaa4-4d1e2f50939d', 2, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9acfe4a5-faa7-5d83-aaa4-4d1e2f50939d', 3, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9acfe4a5-faa7-5d83-aaa4-4d1e2f50939d', 4, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9acfe4a5-faa7-5d83-aaa4-4d1e2f50939d', 5, 8.0, NULL, true, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9acfe4a5-faa7-5d83-aaa4-4d1e2f50939d', 6, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9acfe4a5-faa7-5d83-aaa4-4d1e2f50939d', 7, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9acfe4a5-faa7-5d83-aaa4-4d1e2f50939d', 8, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '3d98ac08-6979-51ce-941c-933c346e5098', 'ba3d436a-6be2-5197-af64-dfcd9fa3cf44', '21053319-004d-5271-b2bb-fc0102b4038a', 'Yu-Han Kao', 'TPE313', 'individual', 2,
    26.0, 21.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 2 | G/U15 | TPE | Points: 21.0 nett (26.0 gross) | Club: 西門實 小帆船 隊', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'addce1b7-50a5-5250-9608-6497306f2ab0', '3d98ac08-6979-51ce-941c-933c346e5098', 'ba3d436a-6be2-5197-af64-dfcd9fa3cf44', 'Yu-Han Kao', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d98ac08-6979-51ce-941c-933c346e5098', 1, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d98ac08-6979-51ce-941c-933c346e5098', 2, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d98ac08-6979-51ce-941c-933c346e5098', 3, 5.0, NULL, true, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d98ac08-6979-51ce-941c-933c346e5098', 4, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d98ac08-6979-51ce-941c-933c346e5098', 5, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d98ac08-6979-51ce-941c-933c346e5098', 6, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d98ac08-6979-51ce-941c-933c346e5098', 7, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d98ac08-6979-51ce-941c-933c346e5098', 8, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'bcf339be-8f3b-5423-857d-cfd8d003e04d', 'e08a26a2-0a66-49bc-a0c1-f5e5849df216', '21053319-004d-5271-b2bb-fc0102b4038a', 'Chia-Hsin Chiu', 'TPE377', 'individual', 3,
    28.0, 21.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 3 | G/U15 | TPE | Points: 21.0 nett (28.0 gross) | Club: 西門實 小帆船 隊', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b1689ba2-e501-5b38-b578-ee321cb61039', 'bcf339be-8f3b-5423-857d-cfd8d003e04d', 'e08a26a2-0a66-49bc-a0c1-f5e5849df216', 'Chia-Hsin Chiu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bcf339be-8f3b-5423-857d-cfd8d003e04d', 1, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bcf339be-8f3b-5423-857d-cfd8d003e04d', 2, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bcf339be-8f3b-5423-857d-cfd8d003e04d', 3, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bcf339be-8f3b-5423-857d-cfd8d003e04d', 4, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bcf339be-8f3b-5423-857d-cfd8d003e04d', 5, 7.0, NULL, true, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bcf339be-8f3b-5423-857d-cfd8d003e04d', 6, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bcf339be-8f3b-5423-857d-cfd8d003e04d', 7, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bcf339be-8f3b-5423-857d-cfd8d003e04d', 8, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f7b7a0e3-6856-5cde-8a2c-748442d1164a', '8a200ad6-5c43-4b86-97bb-d0905a158577', '21053319-004d-5271-b2bb-fc0102b4038a', 'Theerakan Klaysomboon', 'THA1935', 'individual', 4,
    35.2, 24.2, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 4 | G/U12 | THA | Points: 24.2 nett (35.2 gross) | Club: Thailand', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '52d7b938-b4e1-582b-88e7-267d2a15a9dd', 'f7b7a0e3-6856-5cde-8a2c-748442d1164a', '8a200ad6-5c43-4b86-97bb-d0905a158577', 'Theerakan Klaysomboon', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7b7a0e3-6856-5cde-8a2c-748442d1164a', 1, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7b7a0e3-6856-5cde-8a2c-748442d1164a', 2, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7b7a0e3-6856-5cde-8a2c-748442d1164a', 3, 11.0, NULL, true, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7b7a0e3-6856-5cde-8a2c-748442d1164a', 4, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7b7a0e3-6856-5cde-8a2c-748442d1164a', 5, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7b7a0e3-6856-5cde-8a2c-748442d1164a', 6, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7b7a0e3-6856-5cde-8a2c-748442d1164a', 7, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7b7a0e3-6856-5cde-8a2c-748442d1164a', 8, 3.2, NULL, false, '3.2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'b338e505-5f4e-574f-99fb-178a722a5995', '56cdc1b0-297b-55f1-ab53-18ce968dba2b', '21053319-004d-5271-b2bb-fc0102b4038a', 'Yu-Chen Chen', 'TPE317', 'individual', 5,
    44.2, 32.2, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 5 | G/U12 | TPE | Points: 32.2 nett (44.2 gross) | Club: 西門實 小帆船 隊', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '66660cf7-044a-5edc-a8af-d05b44001731', 'b338e505-5f4e-574f-99fb-178a722a5995', '56cdc1b0-297b-55f1-ab53-18ce968dba2b', 'Yu-Chen Chen', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b338e505-5f4e-574f-99fb-178a722a5995', 1, 12.0, NULL, true, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b338e505-5f4e-574f-99fb-178a722a5995', 2, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b338e505-5f4e-574f-99fb-178a722a5995', 3, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b338e505-5f4e-574f-99fb-178a722a5995', 4, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b338e505-5f4e-574f-99fb-178a722a5995', 5, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b338e505-5f4e-574f-99fb-178a722a5995', 6, 3.2, NULL, false, '3.2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b338e505-5f4e-574f-99fb-178a722a5995', 7, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b338e505-5f4e-574f-99fb-178a722a5995', 8, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'bedc79d8-77a7-503b-b8cd-3360b6987cd0', 'e81d9357-afbd-4c0b-a9e9-abfdead88975', '21053319-004d-5271-b2bb-fc0102b4038a', 'Yu-Tzu Huang', 'TPE338', 'individual', 6,
    52.0, 39.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 6 | G/U15 | TPE | Points: 39.0 nett (52.0 gross) | Club: 西門實 小帆船 隊', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '280c3942-889c-56ec-aa5c-c9395e7d14e8', 'bedc79d8-77a7-503b-b8cd-3360b6987cd0', 'e81d9357-afbd-4c0b-a9e9-abfdead88975', 'Yu-Tzu Huang', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bedc79d8-77a7-503b-b8cd-3360b6987cd0', 1, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bedc79d8-77a7-503b-b8cd-3360b6987cd0', 2, 13.0, NULL, true, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bedc79d8-77a7-503b-b8cd-3360b6987cd0', 3, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bedc79d8-77a7-503b-b8cd-3360b6987cd0', 4, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bedc79d8-77a7-503b-b8cd-3360b6987cd0', 5, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bedc79d8-77a7-503b-b8cd-3360b6987cd0', 6, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bedc79d8-77a7-503b-b8cd-3360b6987cd0', 7, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bedc79d8-77a7-503b-b8cd-3360b6987cd0', 8, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '3ab1dd73-bf04-5d10-9be3-61c56aab8e10', '8c4d48e7-2178-51f9-be51-63a857d51159', '21053319-004d-5271-b2bb-fc0102b4038a', 'Shu-Ya Hsu', 'TPE258', 'individual', 7,
    54.0, 40.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 7 | G/U12 | TPE | Points: 40.0 nett (54.0 gross) | Club: 金門縣 帆船委 員會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1468986c-bad3-5928-8b3b-8ef21d826d74', '3ab1dd73-bf04-5d10-9be3-61c56aab8e10', '8c4d48e7-2178-51f9-be51-63a857d51159', 'Shu-Ya Hsu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3ab1dd73-bf04-5d10-9be3-61c56aab8e10', 1, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3ab1dd73-bf04-5d10-9be3-61c56aab8e10', 2, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3ab1dd73-bf04-5d10-9be3-61c56aab8e10', 3, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3ab1dd73-bf04-5d10-9be3-61c56aab8e10', 4, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3ab1dd73-bf04-5d10-9be3-61c56aab8e10', 5, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3ab1dd73-bf04-5d10-9be3-61c56aab8e10', 6, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3ab1dd73-bf04-5d10-9be3-61c56aab8e10', 7, 14.0, NULL, true, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3ab1dd73-bf04-5d10-9be3-61c56aab8e10', 8, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd9a43377-6823-5631-92d1-d5debdbd72d6', '1acada38-b48d-5cb1-9016-563f3ae24665', '21053319-004d-5271-b2bb-fc0102b4038a', 'Yu-Chieh Huang', 'TPE326', 'individual', 8,
    64.0, 49.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 8 | G/U15 | TPE | Points: 49.0 nett (64.0 gross) | Club: 西門實 小帆船 隊', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7bd0c030-674d-532a-82d5-d4f1b830c12a', 'd9a43377-6823-5631-92d1-d5debdbd72d6', '1acada38-b48d-5cb1-9016-563f3ae24665', 'Yu-Chieh Huang', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9a43377-6823-5631-92d1-d5debdbd72d6', 1, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9a43377-6823-5631-92d1-d5debdbd72d6', 2, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9a43377-6823-5631-92d1-d5debdbd72d6', 3, 15.0, NULL, true, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9a43377-6823-5631-92d1-d5debdbd72d6', 4, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9a43377-6823-5631-92d1-d5debdbd72d6', 5, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9a43377-6823-5631-92d1-d5debdbd72d6', 6, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9a43377-6823-5631-92d1-d5debdbd72d6', 7, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9a43377-6823-5631-92d1-d5debdbd72d6', 8, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '9ad3a482-a410-56a5-9fcc-fe303ec1c98d', '06575f3d-3a87-5420-acbc-8693b2325462', '21053319-004d-5271-b2bb-fc0102b4038a', 'Chen-Yueh Wu', 'TPE329', 'individual', 9,
    77.0, 65.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 9 | G/U12 | TPE | Points: 65.0 nett (77.0 gross) | Club: 西門實 小帆船 隊', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '224666f2-5bb3-5299-a9fc-3df25e766a65', '9ad3a482-a410-56a5-9fcc-fe303ec1c98d', '06575f3d-3a87-5420-acbc-8693b2325462', 'Chen-Yueh Wu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9ad3a482-a410-56a5-9fcc-fe303ec1c98d', 1, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9ad3a482-a410-56a5-9fcc-fe303ec1c98d', 2, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9ad3a482-a410-56a5-9fcc-fe303ec1c98d', 3, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9ad3a482-a410-56a5-9fcc-fe303ec1c98d', 4, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9ad3a482-a410-56a5-9fcc-fe303ec1c98d', 5, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9ad3a482-a410-56a5-9fcc-fe303ec1c98d', 6, 12.0, NULL, true, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9ad3a482-a410-56a5-9fcc-fe303ec1c98d', 7, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9ad3a482-a410-56a5-9fcc-fe303ec1c98d', 8, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e21d05e0-304f-5ec0-b0b6-0e61fafde3aa', '78ac9250-8763-5e62-a94a-e25440100616', '21053319-004d-5271-b2bb-fc0102b4038a', 'Shan-Ya Lee', 'TPE427', 'individual', 10,
    82.0, 66.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 10 | G/U15 | TPE | Points: 66.0 nett (82.0 gross) | Club: 高雄市 舊城蓮 潭帆船 隊', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'fd548982-a0cb-59c1-9abd-4faa0e2bfbf8', 'e21d05e0-304f-5ec0-b0b6-0e61fafde3aa', '78ac9250-8763-5e62-a94a-e25440100616', 'Shan-Ya Lee', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e21d05e0-304f-5ec0-b0b6-0e61fafde3aa', 1, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e21d05e0-304f-5ec0-b0b6-0e61fafde3aa', 2, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e21d05e0-304f-5ec0-b0b6-0e61fafde3aa', 3, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e21d05e0-304f-5ec0-b0b6-0e61fafde3aa', 4, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e21d05e0-304f-5ec0-b0b6-0e61fafde3aa', 5, 16.0, NULL, true, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e21d05e0-304f-5ec0-b0b6-0e61fafde3aa', 6, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e21d05e0-304f-5ec0-b0b6-0e61fafde3aa', 7, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e21d05e0-304f-5ec0-b0b6-0e61fafde3aa', 8, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'b48a9d5f-937a-5c96-8b1d-61133b553454', '69a37535-3ce6-5411-b57e-ec4857045f7c', '21053319-004d-5271-b2bb-fc0102b4038a', 'Ai-Jan Lin', 'TPE990', 'individual', 11,
    90.0, 71.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 11 | G/U15 | TPE | Points: 71.0 nett (90.0 gross) | Club: 個人', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4d36cbe1-2a92-5cb2-8cff-bec1b9e28128', 'b48a9d5f-937a-5c96-8b1d-61133b553454', '69a37535-3ce6-5411-b57e-ec4857045f7c', 'Ai-Jan Lin', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b48a9d5f-937a-5c96-8b1d-61133b553454', 1, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b48a9d5f-937a-5c96-8b1d-61133b553454', 2, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b48a9d5f-937a-5c96-8b1d-61133b553454', 3, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b48a9d5f-937a-5c96-8b1d-61133b553454', 4, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b48a9d5f-937a-5c96-8b1d-61133b553454', 5, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b48a9d5f-937a-5c96-8b1d-61133b553454', 6, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b48a9d5f-937a-5c96-8b1d-61133b553454', 7, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b48a9d5f-937a-5c96-8b1d-61133b553454', 8, 19.0, NULL, true, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'fed27feb-bcb2-59bf-acdd-894524441a92', '9ca50e97-0c1a-528c-8aee-77d3752d6e9c', '21053319-004d-5271-b2bb-fc0102b4038a', 'Hana Nakazawa', 'JPN3462', 'individual', 12,
    94.0, 78.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 12 | G/U12 | JPN | Points: 78.0 nett (94.0 gross) | Club: B&GHyogoJuniorOceanClub', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f12e545d-68c9-5407-8792-0ddb143fff4d', 'fed27feb-bcb2-59bf-acdd-894524441a92', '9ca50e97-0c1a-528c-8aee-77d3752d6e9c', 'Hana Nakazawa', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fed27feb-bcb2-59bf-acdd-894524441a92', 1, 16.0, NULL, true, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fed27feb-bcb2-59bf-acdd-894524441a92', 2, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fed27feb-bcb2-59bf-acdd-894524441a92', 3, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fed27feb-bcb2-59bf-acdd-894524441a92', 4, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fed27feb-bcb2-59bf-acdd-894524441a92', 5, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fed27feb-bcb2-59bf-acdd-894524441a92', 6, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fed27feb-bcb2-59bf-acdd-894524441a92', 7, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fed27feb-bcb2-59bf-acdd-894524441a92', 8, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd74ec8e0-1339-5b7a-ab0e-2e71da50d0b8', '08350803-1171-57de-a0b6-4c9f6f8a4771', '21053319-004d-5271-b2bb-fc0102b4038a', 'Yun-Yun Chuang', 'TPE772', 'individual', 13,
    95.0, 81.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 13 | G/U15 | TPE | Points: 81.0 nett (95.0 gross) | Club: 高雄市 舊城蓮 潭帆船 隊', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '549401df-d895-552a-94b2-a31cea227782', 'd74ec8e0-1339-5b7a-ab0e-2e71da50d0b8', '08350803-1171-57de-a0b6-4c9f6f8a4771', 'Yun-Yun Chuang', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd74ec8e0-1339-5b7a-ab0e-2e71da50d0b8', 1, 14.0, NULL, true, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd74ec8e0-1339-5b7a-ab0e-2e71da50d0b8', 2, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd74ec8e0-1339-5b7a-ab0e-2e71da50d0b8', 3, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd74ec8e0-1339-5b7a-ab0e-2e71da50d0b8', 4, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd74ec8e0-1339-5b7a-ab0e-2e71da50d0b8', 5, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd74ec8e0-1339-5b7a-ab0e-2e71da50d0b8', 6, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd74ec8e0-1339-5b7a-ab0e-2e71da50d0b8', 7, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd74ec8e0-1339-5b7a-ab0e-2e71da50d0b8', 8, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '2c80ef58-eda8-522c-96c8-1363e81b8831', 'b88efdbf-f3bc-550a-907d-812ffe4e17cf', '21053319-004d-5271-b2bb-fc0102b4038a', 'Chia-Yin Yang', 'TPE319', 'individual', 14,
    100.0, 84.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 14 | G/U12 | TPE | Points: 84.0 nett (100.0 gross) | Club: 西門實 小帆船 隊', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9dbdcd9d-de74-5304-a365-db999047a91a', '2c80ef58-eda8-522c-96c8-1363e81b8831', 'b88efdbf-f3bc-550a-907d-812ffe4e17cf', 'Chia-Yin Yang', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c80ef58-eda8-522c-96c8-1363e81b8831', 1, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c80ef58-eda8-522c-96c8-1363e81b8831', 2, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c80ef58-eda8-522c-96c8-1363e81b8831', 3, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c80ef58-eda8-522c-96c8-1363e81b8831', 4, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c80ef58-eda8-522c-96c8-1363e81b8831', 5, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c80ef58-eda8-522c-96c8-1363e81b8831', 6, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c80ef58-eda8-522c-96c8-1363e81b8831', 7, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c80ef58-eda8-522c-96c8-1363e81b8831', 8, 16.0, NULL, true, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '1779c7af-802c-5150-a51e-a04570fa8921', 'd2384e74-ecef-53b2-8006-54f4ccdcbc36', '21053319-004d-5271-b2bb-fc0102b4038a', 'Shan-Yu Lee', 'TPE773', 'individual', 15,
    128.0, 108.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 15 | G/U12 | TPE | Points: 108.0 nett (128.0 gross) | Club: 高雄市 舊城蓮 潭帆船 隊', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '74d85484-1c14-5c5c-82fa-8f20b4a1466f', '1779c7af-802c-5150-a51e-a04570fa8921', 'd2384e74-ecef-53b2-8006-54f4ccdcbc36', 'Shan-Yu Lee', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1779c7af-802c-5150-a51e-a04570fa8921', 1, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1779c7af-802c-5150-a51e-a04570fa8921', 2, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1779c7af-802c-5150-a51e-a04570fa8921', 3, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1779c7af-802c-5150-a51e-a04570fa8921', 4, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1779c7af-802c-5150-a51e-a04570fa8921', 5, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1779c7af-802c-5150-a51e-a04570fa8921', 6, 20.0, NULL, true, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1779c7af-802c-5150-a51e-a04570fa8921', 7, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1779c7af-802c-5150-a51e-a04570fa8921', 8, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '1f847a26-bc2a-5705-aef3-715ba801ede3', '2e113407-8fa8-53d2-98a4-2c53d3ed524b', '21053319-004d-5271-b2bb-fc0102b4038a', 'Sebin You', 'KOR505', 'individual', 16,
    141.0, 119.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 16 | G/U12 | KOR | Points: 119.0 nett (141.0 gross) | Club: Teamkorea(', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4864d276-d7fa-5bce-ae28-74a72d4cab73', '1f847a26-bc2a-5705-aef3-715ba801ede3', '2e113407-8fa8-53d2-98a4-2c53d3ed524b', 'Sebin You', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f847a26-bc2a-5705-aef3-715ba801ede3', 1, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f847a26-bc2a-5705-aef3-715ba801ede3', 2, 22.0, NULL, true, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f847a26-bc2a-5705-aef3-715ba801ede3', 3, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f847a26-bc2a-5705-aef3-715ba801ede3', 4, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f847a26-bc2a-5705-aef3-715ba801ede3', 5, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f847a26-bc2a-5705-aef3-715ba801ede3', 6, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f847a26-bc2a-5705-aef3-715ba801ede3', 7, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f847a26-bc2a-5705-aef3-715ba801ede3', 8, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'bed0390c-b387-5493-89f8-3a62a6fd5e28', '390a1506-cdbf-598e-bffe-6c77a50bfbad', '21053319-004d-5271-b2bb-fc0102b4038a', 'Tamaki Tanaka', 'JPN3432', 'individual', 17,
    141.0, 119.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 17 | G/U10 | JPN | Points: 119.0 nett (141.0 gross) | Club: B&GHyogoJuniorOceanClub', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3fb8d786-09f1-5aac-b0ea-45122621bbda', 'bed0390c-b387-5493-89f8-3a62a6fd5e28', '390a1506-cdbf-598e-bffe-6c77a50bfbad', 'Tamaki Tanaka', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bed0390c-b387-5493-89f8-3a62a6fd5e28', 1, 22.0, NULL, true, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bed0390c-b387-5493-89f8-3a62a6fd5e28', 2, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bed0390c-b387-5493-89f8-3a62a6fd5e28', 3, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bed0390c-b387-5493-89f8-3a62a6fd5e28', 4, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bed0390c-b387-5493-89f8-3a62a6fd5e28', 5, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bed0390c-b387-5493-89f8-3a62a6fd5e28', 6, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bed0390c-b387-5493-89f8-3a62a6fd5e28', 7, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bed0390c-b387-5493-89f8-3a62a6fd5e28', 8, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '65fa26a2-2389-5fcf-a339-44252cb54149', 'f35b2033-9efa-59b4-a8a9-7e13c227393f', '21053319-004d-5271-b2bb-fc0102b4038a', 'Hui-Yun Chen', 'TPE5168', 'individual', 18,
    143.0, 121.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 18 | G/U15 | TPE | Points: 121.0 nett (143.0 gross) | Club: 澎湖縣 帆船協 會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5b7118f9-6524-5a4d-b8a8-fce64513d236', '65fa26a2-2389-5fcf-a339-44252cb54149', 'f35b2033-9efa-59b4-a8a9-7e13c227393f', 'Hui-Yun Chen', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '65fa26a2-2389-5fcf-a339-44252cb54149', 1, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '65fa26a2-2389-5fcf-a339-44252cb54149', 2, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '65fa26a2-2389-5fcf-a339-44252cb54149', 3, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '65fa26a2-2389-5fcf-a339-44252cb54149', 4, 22.0, NULL, true, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '65fa26a2-2389-5fcf-a339-44252cb54149', 5, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '65fa26a2-2389-5fcf-a339-44252cb54149', 6, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '65fa26a2-2389-5fcf-a339-44252cb54149', 7, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '65fa26a2-2389-5fcf-a339-44252cb54149', 8, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f3dec635-887b-5103-be8d-adf9bd873ea5', '27fd04c9-03a2-5dbc-9c25-075401cb66d1', '21053319-004d-5271-b2bb-fc0102b4038a', 'En-Chi Lu', 'TPE517', 'individual', 19,
    149.0, 127.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 19 | G/U10 | TPE | Points: 127.0 nett (149.0 gross) | Club: 澎湖縣 帆船協 會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1b02bcff-60ec-5feb-98a4-b74e97fcad55', 'f3dec635-887b-5103-be8d-adf9bd873ea5', '27fd04c9-03a2-5dbc-9c25-075401cb66d1', 'En-Chi Lu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f3dec635-887b-5103-be8d-adf9bd873ea5', 1, 22.0, NULL, true, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f3dec635-887b-5103-be8d-adf9bd873ea5', 2, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f3dec635-887b-5103-be8d-adf9bd873ea5', 3, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f3dec635-887b-5103-be8d-adf9bd873ea5', 4, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f3dec635-887b-5103-be8d-adf9bd873ea5', 5, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f3dec635-887b-5103-be8d-adf9bd873ea5', 6, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f3dec635-887b-5103-be8d-adf9bd873ea5', 7, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f3dec635-887b-5103-be8d-adf9bd873ea5', 8, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '39de8f1a-5d44-50dd-954d-e4200ec9ae03', 'a909e581-5406-53d1-a259-1d69c9ac685e', '21053319-004d-5271-b2bb-fc0102b4038a', 'Hui-Jou Chen', 'TPE526', 'individual', 20,
    151.0, 129.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 20 | G/U10 | TPE | Points: 129.0 nett (151.0 gross) | Club: 澎湖縣 帆船協 會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '79df14c1-6f00-5dca-afae-94f47c6a5cfb', '39de8f1a-5d44-50dd-954d-e4200ec9ae03', 'a909e581-5406-53d1-a259-1d69c9ac685e', 'Hui-Jou Chen', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39de8f1a-5d44-50dd-954d-e4200ec9ae03', 1, 22.0, NULL, true, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39de8f1a-5d44-50dd-954d-e4200ec9ae03', 2, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39de8f1a-5d44-50dd-954d-e4200ec9ae03', 3, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39de8f1a-5d44-50dd-954d-e4200ec9ae03', 4, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39de8f1a-5d44-50dd-954d-e4200ec9ae03', 5, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39de8f1a-5d44-50dd-954d-e4200ec9ae03', 6, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39de8f1a-5d44-50dd-954d-e4200ec9ae03', 7, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39de8f1a-5d44-50dd-954d-e4200ec9ae03', 8, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ab09a30d-0974-5e3c-8850-6fc2501460f4', 'e8ce1948-803f-4646-a2f5-88d4c7ead815', '21053319-004d-5271-b2bb-fc0102b4038a', 'Napichaya Rattanadechakorn', 'THA1457', 'individual', 21,
    176.0, 154.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/girls_r8.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 21 | G/U12 | THA | Points: 154.0 nett (176.0 gross) | Club: Thailand', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '70980b9a-35e0-5775-979b-032cd5a108f7', 'ab09a30d-0974-5e3c-8850-6fc2501460f4', 'e8ce1948-803f-4646-a2f5-88d4c7ead815', 'Napichaya Rattanadechakorn', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab09a30d-0974-5e3c-8850-6fc2501460f4', 1, 22.0, NULL, true, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab09a30d-0974-5e3c-8850-6fc2501460f4', 2, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab09a30d-0974-5e3c-8850-6fc2501460f4', 3, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab09a30d-0974-5e3c-8850-6fc2501460f4', 4, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab09a30d-0974-5e3c-8850-6fc2501460f4', 5, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab09a30d-0974-5e3c-8850-6fc2501460f4', 6, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab09a30d-0974-5e3c-8850-6fc2501460f4', 7, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab09a30d-0974-5e3c-8850-6fc2501460f4', 8, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '0f1d53c2-3b95-5fb1-88be-be2be6f66b17',
    '034bf987-fc94-5d18-8f28-62f0e71b1380',
    '2026 ASAF Cup Optimist Open Championships — Novice Fleet',
    'asaf-cup-optimist-open-championships-2026-novice',
    '2026-08-05',
    '2026-08-10',
    16,
    'Novice',
    11,
    'TPE',
    'optimist',
    'individual',
    1,
    1,
    false,
    'Guanyinting, Penghu, Chinese Taipei',
    'Asian Sailing Federation (ASAF) / Chinese Taipei Sailing Association (CTSA)',
    'published',
    'https://www.racingrulesofsailing.org/documents/15171/event',
    'Racing Rules of Sailing Document 15171',
    '2026 ASAF Cup Optimist Open Championships official final series results',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
-- Results for novice
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'df6c90f7-e22f-5f2f-8ad2-4514790aefc5', 'c26826da-22ca-5c19-a3eb-f900199e637d', '0f1d53c2-3b95-5fb1-88be-be2be6f66b17', 'Tzu-An Wang', 'R21', 'individual', 1,
    21.0, 21.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/novice_r11.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 1 | B/N | TPE | Points: 21.0 nett (21.0 gross) | Club: 澎湖縣 帆船協 會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '57b75465-f133-5f79-8263-353e50c7c853', 'df6c90f7-e22f-5f2f-8ad2-4514790aefc5', 'c26826da-22ca-5c19-a3eb-f900199e637d', 'Tzu-An Wang', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df6c90f7-e22f-5f2f-8ad2-4514790aefc5', 1, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df6c90f7-e22f-5f2f-8ad2-4514790aefc5', 2, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df6c90f7-e22f-5f2f-8ad2-4514790aefc5', 3, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df6c90f7-e22f-5f2f-8ad2-4514790aefc5', 4, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df6c90f7-e22f-5f2f-8ad2-4514790aefc5', 5, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df6c90f7-e22f-5f2f-8ad2-4514790aefc5', 6, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df6c90f7-e22f-5f2f-8ad2-4514790aefc5', 7, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df6c90f7-e22f-5f2f-8ad2-4514790aefc5', 8, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df6c90f7-e22f-5f2f-8ad2-4514790aefc5', 9, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df6c90f7-e22f-5f2f-8ad2-4514790aefc5', 10, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df6c90f7-e22f-5f2f-8ad2-4514790aefc5', 11, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'eb0cb96e-844e-54d0-868e-4b85fc700f67', '5a624207-08d4-53e9-8381-42cf361b8e70', '0f1d53c2-3b95-5fb1-88be-be2be6f66b17', 'Yun-Hao Chuang', 'P8', 'individual', 2,
    40.0, 40.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/novice_r11.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 2 | B/N | TPE | Points: 40.0 nett (40.0 gross) | Club: 高雄市 舊城蓮 潭帆船 隊', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '02871ac8-0403-57da-8ce0-f20dbb1ec86e', 'eb0cb96e-844e-54d0-868e-4b85fc700f67', '5a624207-08d4-53e9-8381-42cf361b8e70', 'Yun-Hao Chuang', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb0cb96e-844e-54d0-868e-4b85fc700f67', 1, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb0cb96e-844e-54d0-868e-4b85fc700f67', 2, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb0cb96e-844e-54d0-868e-4b85fc700f67', 3, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb0cb96e-844e-54d0-868e-4b85fc700f67', 4, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb0cb96e-844e-54d0-868e-4b85fc700f67', 5, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb0cb96e-844e-54d0-868e-4b85fc700f67', 6, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb0cb96e-844e-54d0-868e-4b85fc700f67', 7, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb0cb96e-844e-54d0-868e-4b85fc700f67', 8, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb0cb96e-844e-54d0-868e-4b85fc700f67', 9, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb0cb96e-844e-54d0-868e-4b85fc700f67', 10, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb0cb96e-844e-54d0-868e-4b85fc700f67', 11, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '0170446b-322e-5634-8358-e10ac32d7ae0', '23f21394-9b28-5e5b-8a72-c105f459ee3d', '0f1d53c2-3b95-5fb1-88be-be2be6f66b17', 'Chiao-Chen Chang', 'TPE5188', 'individual', 3,
    58.0, 58.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/novice_r11.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 3 | G/N | TPE | Points: 58.0 nett (58.0 gross) | Club: 澎湖縣 帆船協 會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a09d81c0-cb49-5e7e-8aad-6a45173180eb', '0170446b-322e-5634-8358-e10ac32d7ae0', '23f21394-9b28-5e5b-8a72-c105f459ee3d', 'Chiao-Chen Chang', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0170446b-322e-5634-8358-e10ac32d7ae0', 1, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0170446b-322e-5634-8358-e10ac32d7ae0', 2, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0170446b-322e-5634-8358-e10ac32d7ae0', 3, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0170446b-322e-5634-8358-e10ac32d7ae0', 4, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0170446b-322e-5634-8358-e10ac32d7ae0', 5, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0170446b-322e-5634-8358-e10ac32d7ae0', 6, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0170446b-322e-5634-8358-e10ac32d7ae0', 7, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0170446b-322e-5634-8358-e10ac32d7ae0', 8, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0170446b-322e-5634-8358-e10ac32d7ae0', 9, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0170446b-322e-5634-8358-e10ac32d7ae0', 10, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0170446b-322e-5634-8358-e10ac32d7ae0', 11, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'cf26ed6a-6be0-5aab-9b49-b28171066df0', '132d6125-f1ac-5af0-abc8-6f3c4bef497a', '0f1d53c2-3b95-5fb1-88be-be2be6f66b17', 'Chaeyeong Lee', 'KOR563', 'individual', 4,
    68.0, 68.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/novice_r11.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 4 | G/N | KOR | Points: 68.0 nett (68.0 gross) | Club: Teamkorea(pohangcity)', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4aaf58c8-140c-51e2-b91a-01a3ac2e1a69', 'cf26ed6a-6be0-5aab-9b49-b28171066df0', '132d6125-f1ac-5af0-abc8-6f3c4bef497a', 'Chaeyeong Lee', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf26ed6a-6be0-5aab-9b49-b28171066df0', 1, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf26ed6a-6be0-5aab-9b49-b28171066df0', 2, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf26ed6a-6be0-5aab-9b49-b28171066df0', 3, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf26ed6a-6be0-5aab-9b49-b28171066df0', 4, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf26ed6a-6be0-5aab-9b49-b28171066df0', 5, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf26ed6a-6be0-5aab-9b49-b28171066df0', 6, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf26ed6a-6be0-5aab-9b49-b28171066df0', 7, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf26ed6a-6be0-5aab-9b49-b28171066df0', 8, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf26ed6a-6be0-5aab-9b49-b28171066df0', 9, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf26ed6a-6be0-5aab-9b49-b28171066df0', 10, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cf26ed6a-6be0-5aab-9b49-b28171066df0', 11, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '40af5ccb-bc1e-50df-9fe4-3acb2d2c2192', '84663b62-4f86-5524-b36f-5ae550f7d9d0', '0f1d53c2-3b95-5fb1-88be-be2be6f66b17', 'Seojun Park', 'KOR56', 'individual', 5,
    69.0, 69.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/novice_r11.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 5 | B/N | KOR | Points: 69.0 nett (69.0 gross) | Club: Teamkorea(pohangcity)', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '50d25e5c-1b17-57e1-a4d6-28037a9582f9', '40af5ccb-bc1e-50df-9fe4-3acb2d2c2192', '84663b62-4f86-5524-b36f-5ae550f7d9d0', 'Seojun Park', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40af5ccb-bc1e-50df-9fe4-3acb2d2c2192', 1, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40af5ccb-bc1e-50df-9fe4-3acb2d2c2192', 2, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40af5ccb-bc1e-50df-9fe4-3acb2d2c2192', 3, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40af5ccb-bc1e-50df-9fe4-3acb2d2c2192', 4, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40af5ccb-bc1e-50df-9fe4-3acb2d2c2192', 5, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40af5ccb-bc1e-50df-9fe4-3acb2d2c2192', 6, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40af5ccb-bc1e-50df-9fe4-3acb2d2c2192', 7, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40af5ccb-bc1e-50df-9fe4-3acb2d2c2192', 8, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40af5ccb-bc1e-50df-9fe4-3acb2d2c2192', 9, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40af5ccb-bc1e-50df-9fe4-3acb2d2c2192', 10, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40af5ccb-bc1e-50df-9fe4-3acb2d2c2192', 11, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a7006c1c-69d4-5696-a8aa-272d8e699bf0', 'd96df1be-ce1b-5c26-aee9-b0da2039fc23', '0f1d53c2-3b95-5fb1-88be-be2be6f66b17', 'Siwon Park', 'KOR565', 'individual', 6,
    71.0, 71.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/novice_r11.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 6 | B/N | KOR | Points: 71.0 nett (71.0 gross) | Club: Teamkorea(pohangcity)', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e09224ab-6f8b-574b-b8d0-94a752cda949', 'a7006c1c-69d4-5696-a8aa-272d8e699bf0', 'd96df1be-ce1b-5c26-aee9-b0da2039fc23', 'Siwon Park', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7006c1c-69d4-5696-a8aa-272d8e699bf0', 1, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7006c1c-69d4-5696-a8aa-272d8e699bf0', 2, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7006c1c-69d4-5696-a8aa-272d8e699bf0', 3, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7006c1c-69d4-5696-a8aa-272d8e699bf0', 4, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7006c1c-69d4-5696-a8aa-272d8e699bf0', 5, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7006c1c-69d4-5696-a8aa-272d8e699bf0', 6, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7006c1c-69d4-5696-a8aa-272d8e699bf0', 7, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7006c1c-69d4-5696-a8aa-272d8e699bf0', 8, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7006c1c-69d4-5696-a8aa-272d8e699bf0', 9, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7006c1c-69d4-5696-a8aa-272d8e699bf0', 10, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a7006c1c-69d4-5696-a8aa-272d8e699bf0', 11, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f25929c5-bf0c-5082-8b42-c609a19b2441', '6cd1b091-b483-5fc2-943b-73dd44b20e34', '0f1d53c2-3b95-5fb1-88be-be2be6f66b17', 'Yun-Jen Chang', 'TPE5166', 'individual', 7,
    75.0, 75.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/novice_r11.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 7 | B/N | TPE | Points: 75.0 nett (75.0 gross) | Club: 澎湖縣 帆船協 會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '13d734b6-46ad-53d7-9412-3ffc0a55a85e', 'f25929c5-bf0c-5082-8b42-c609a19b2441', '6cd1b091-b483-5fc2-943b-73dd44b20e34', 'Yun-Jen Chang', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f25929c5-bf0c-5082-8b42-c609a19b2441', 1, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f25929c5-bf0c-5082-8b42-c609a19b2441', 2, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f25929c5-bf0c-5082-8b42-c609a19b2441', 3, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f25929c5-bf0c-5082-8b42-c609a19b2441', 4, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f25929c5-bf0c-5082-8b42-c609a19b2441', 5, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f25929c5-bf0c-5082-8b42-c609a19b2441', 6, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f25929c5-bf0c-5082-8b42-c609a19b2441', 7, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f25929c5-bf0c-5082-8b42-c609a19b2441', 8, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f25929c5-bf0c-5082-8b42-c609a19b2441', 9, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f25929c5-bf0c-5082-8b42-c609a19b2441', 10, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f25929c5-bf0c-5082-8b42-c609a19b2441', 11, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '8879976c-f5e2-5147-b2ae-8c91256f3de3', '7f05991f-650b-5825-89e3-27d05b8aba9a', '0f1d53c2-3b95-5fb1-88be-be2be6f66b17', 'Tao-Yin Tan', 'TPE360', 'individual', 8,
    92.0, 92.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/novice_r11.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 8 | B/N | TPE | Points: 92.0 nett (92.0 gross) | Club: 台北市 體育總 會帆船 協會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1776728e-4727-5e05-a928-e26bfb579c21', '8879976c-f5e2-5147-b2ae-8c91256f3de3', '7f05991f-650b-5825-89e3-27d05b8aba9a', 'Tao-Yin Tan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8879976c-f5e2-5147-b2ae-8c91256f3de3', 1, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8879976c-f5e2-5147-b2ae-8c91256f3de3', 2, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8879976c-f5e2-5147-b2ae-8c91256f3de3', 3, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8879976c-f5e2-5147-b2ae-8c91256f3de3', 4, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8879976c-f5e2-5147-b2ae-8c91256f3de3', 5, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8879976c-f5e2-5147-b2ae-8c91256f3de3', 6, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8879976c-f5e2-5147-b2ae-8c91256f3de3', 7, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8879976c-f5e2-5147-b2ae-8c91256f3de3', 8, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8879976c-f5e2-5147-b2ae-8c91256f3de3', 9, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8879976c-f5e2-5147-b2ae-8c91256f3de3', 10, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8879976c-f5e2-5147-b2ae-8c91256f3de3', 11, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '5a1365ca-7e22-54cf-8ecd-dbdeee84160d', '85cbacff-0840-591e-88a0-92215b9bd163', '0f1d53c2-3b95-5fb1-88be-be2be6f66b17', 'Yu-Chen Lo', 'R77', 'individual', 9,
    117.0, 117.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/novice_r11.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 9 | B/N | TPE | Points: 117.0 nett (117.0 gross) | Club: 澎湖縣 帆船協 會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'be4ec26b-a74c-5a7e-98e0-ad5259d90f5d', '5a1365ca-7e22-54cf-8ecd-dbdeee84160d', '85cbacff-0840-591e-88a0-92215b9bd163', 'Yu-Chen Lo', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a1365ca-7e22-54cf-8ecd-dbdeee84160d', 1, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a1365ca-7e22-54cf-8ecd-dbdeee84160d', 2, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a1365ca-7e22-54cf-8ecd-dbdeee84160d', 3, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a1365ca-7e22-54cf-8ecd-dbdeee84160d', 4, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a1365ca-7e22-54cf-8ecd-dbdeee84160d', 5, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a1365ca-7e22-54cf-8ecd-dbdeee84160d', 6, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a1365ca-7e22-54cf-8ecd-dbdeee84160d', 7, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a1365ca-7e22-54cf-8ecd-dbdeee84160d', 8, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a1365ca-7e22-54cf-8ecd-dbdeee84160d', 9, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a1365ca-7e22-54cf-8ecd-dbdeee84160d', 10, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a1365ca-7e22-54cf-8ecd-dbdeee84160d', 11, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '72a6c51f-dde7-5e1d-806b-00276f075392', '5230ac1c-fae8-5e83-b2f4-4802d6bd3eff', '0f1d53c2-3b95-5fb1-88be-be2be6f66b17', 'Yu-Chen Yeh', 'R22', 'individual', 10,
    120.0, 120.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/novice_r11.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 10 | B/N | TPE | Points: 120.0 nett (120.0 gross) | Club: 澎湖縣 帆船協 會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '22308990-a369-510e-8df0-4581d2594447', '72a6c51f-dde7-5e1d-806b-00276f075392', '5230ac1c-fae8-5e83-b2f4-4802d6bd3eff', 'Yu-Chen Yeh', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72a6c51f-dde7-5e1d-806b-00276f075392', 1, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72a6c51f-dde7-5e1d-806b-00276f075392', 2, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72a6c51f-dde7-5e1d-806b-00276f075392', 3, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72a6c51f-dde7-5e1d-806b-00276f075392', 4, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72a6c51f-dde7-5e1d-806b-00276f075392', 5, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72a6c51f-dde7-5e1d-806b-00276f075392', 6, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72a6c51f-dde7-5e1d-806b-00276f075392', 7, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72a6c51f-dde7-5e1d-806b-00276f075392', 8, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72a6c51f-dde7-5e1d-806b-00276f075392', 9, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72a6c51f-dde7-5e1d-806b-00276f075392', 10, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72a6c51f-dde7-5e1d-806b-00276f075392', 11, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a4ae5a71-7487-58a6-ae91-02d7cc814d14', '2557f24d-a76c-5f88-9e4a-19c769578dc4', '0f1d53c2-3b95-5fb1-88be-be2be6f66b17', 'Chaewon Lee', 'KOR558', 'individual', 11,
    125.0, 125.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/novice_r11.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 11 | G/N | KOR | Points: 125.0 nett (125.0 gross) | Club: Teamkorea(pohangcity)', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b01f020d-d0dd-5b74-85ee-f6c5283a7a02', 'a4ae5a71-7487-58a6-ae91-02d7cc814d14', '2557f24d-a76c-5f88-9e4a-19c769578dc4', 'Chaewon Lee', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a4ae5a71-7487-58a6-ae91-02d7cc814d14', 1, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a4ae5a71-7487-58a6-ae91-02d7cc814d14', 2, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a4ae5a71-7487-58a6-ae91-02d7cc814d14', 3, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a4ae5a71-7487-58a6-ae91-02d7cc814d14', 4, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a4ae5a71-7487-58a6-ae91-02d7cc814d14', 5, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a4ae5a71-7487-58a6-ae91-02d7cc814d14', 6, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a4ae5a71-7487-58a6-ae91-02d7cc814d14', 7, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a4ae5a71-7487-58a6-ae91-02d7cc814d14', 8, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a4ae5a71-7487-58a6-ae91-02d7cc814d14', 9, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a4ae5a71-7487-58a6-ae91-02d7cc814d14', 10, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a4ae5a71-7487-58a6-ae91-02d7cc814d14', 11, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '90a2fefc-3897-5318-8c6a-1b308664a4f9', '8bced126-c787-51c1-83c2-0fc825937c97', '0f1d53c2-3b95-5fb1-88be-be2be6f66b17', 'Yu-Shu Chen', 'TPE2916', 'individual', 12,
    129.0, 129.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/novice_r11.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 12 | B/N | TPE | Points: 129.0 nett (129.0 gross) | Club: 澎湖縣 帆船協 會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3c5af6a3-6fae-50c0-a3e6-317ca14f14de', '90a2fefc-3897-5318-8c6a-1b308664a4f9', '8bced126-c787-51c1-83c2-0fc825937c97', 'Yu-Shu Chen', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90a2fefc-3897-5318-8c6a-1b308664a4f9', 1, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90a2fefc-3897-5318-8c6a-1b308664a4f9', 2, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90a2fefc-3897-5318-8c6a-1b308664a4f9', 3, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90a2fefc-3897-5318-8c6a-1b308664a4f9', 4, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90a2fefc-3897-5318-8c6a-1b308664a4f9', 5, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90a2fefc-3897-5318-8c6a-1b308664a4f9', 6, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90a2fefc-3897-5318-8c6a-1b308664a4f9', 7, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90a2fefc-3897-5318-8c6a-1b308664a4f9', 8, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90a2fefc-3897-5318-8c6a-1b308664a4f9', 9, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90a2fefc-3897-5318-8c6a-1b308664a4f9', 10, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90a2fefc-3897-5318-8c6a-1b308664a4f9', 11, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '7e4f9817-ec98-586d-ae1c-ec063e5c9e06', 'cbf9a3b6-5893-5595-b5c2-9390ddfb0879', '0f1d53c2-3b95-5fb1-88be-be2be6f66b17', 'Hsin-Cheng Hsieh', 'R23', 'individual', 13,
    135.0, 135.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/novice_r11.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 13 | B/N | TPE | Points: 135.0 nett (135.0 gross) | Club: 澎湖縣 帆船協 會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '69388559-0d84-5e34-92d3-f26e872c2beb', '7e4f9817-ec98-586d-ae1c-ec063e5c9e06', 'cbf9a3b6-5893-5595-b5c2-9390ddfb0879', 'Hsin-Cheng Hsieh', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e4f9817-ec98-586d-ae1c-ec063e5c9e06', 1, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e4f9817-ec98-586d-ae1c-ec063e5c9e06', 2, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e4f9817-ec98-586d-ae1c-ec063e5c9e06', 3, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e4f9817-ec98-586d-ae1c-ec063e5c9e06', 4, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e4f9817-ec98-586d-ae1c-ec063e5c9e06', 5, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e4f9817-ec98-586d-ae1c-ec063e5c9e06', 6, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e4f9817-ec98-586d-ae1c-ec063e5c9e06', 7, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e4f9817-ec98-586d-ae1c-ec063e5c9e06', 8, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e4f9817-ec98-586d-ae1c-ec063e5c9e06', 9, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e4f9817-ec98-586d-ae1c-ec063e5c9e06', 10, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e4f9817-ec98-586d-ae1c-ec063e5c9e06', 11, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'fffcb743-5549-58a1-b6b0-f42b6ca12d87', '4938635b-ea3b-4028-a516-4c1d48a4e7a5', '0f1d53c2-3b95-5fb1-88be-be2be6f66b17', 'Ming-Shuo Chang', 'R97', 'individual', 14,
    187.0, 187.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/novice_r11.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 14 | B/N | TPE | Points: 187.0 nett (187.0 gross) | Club: 澎湖縣 帆船協 會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'cbb38c8d-c512-59d7-8d26-8f87e88fb5e3', 'fffcb743-5549-58a1-b6b0-f42b6ca12d87', '4938635b-ea3b-4028-a516-4c1d48a4e7a5', 'Ming-Shuo Chang', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fffcb743-5549-58a1-b6b0-f42b6ca12d87', 1, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fffcb743-5549-58a1-b6b0-f42b6ca12d87', 2, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fffcb743-5549-58a1-b6b0-f42b6ca12d87', 3, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fffcb743-5549-58a1-b6b0-f42b6ca12d87', 4, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fffcb743-5549-58a1-b6b0-f42b6ca12d87', 5, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fffcb743-5549-58a1-b6b0-f42b6ca12d87', 6, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fffcb743-5549-58a1-b6b0-f42b6ca12d87', 7, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fffcb743-5549-58a1-b6b0-f42b6ca12d87', 8, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fffcb743-5549-58a1-b6b0-f42b6ca12d87', 9, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fffcb743-5549-58a1-b6b0-f42b6ca12d87', 10, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fffcb743-5549-58a1-b6b0-f42b6ca12d87', 11, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd9ff0c0e-dc01-57ae-a862-065116a22f80', 'd9fae5c5-d3db-400e-9896-d2d00d7d8d83', '0f1d53c2-3b95-5fb1-88be-be2be6f66b17', 'Chi-Hsi Lin', 'R98', 'individual', 14,
    187.0, 187.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/novice_r11.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 14 | B/N | TPE | Points: 187.0 nett (187.0 gross) | Club: 澎湖縣 帆船協 會', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd47461b9-624a-5222-ab8b-f6ed88dd6c8a', 'd9ff0c0e-dc01-57ae-a862-065116a22f80', 'd9fae5c5-d3db-400e-9896-d2d00d7d8d83', 'Chi-Hsi Lin', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9ff0c0e-dc01-57ae-a862-065116a22f80', 1, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9ff0c0e-dc01-57ae-a862-065116a22f80', 2, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9ff0c0e-dc01-57ae-a862-065116a22f80', 3, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9ff0c0e-dc01-57ae-a862-065116a22f80', 4, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9ff0c0e-dc01-57ae-a862-065116a22f80', 5, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9ff0c0e-dc01-57ae-a862-065116a22f80', 6, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9ff0c0e-dc01-57ae-a862-065116a22f80', 7, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9ff0c0e-dc01-57ae-a862-065116a22f80', 8, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9ff0c0e-dc01-57ae-a862-065116a22f80', 9, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9ff0c0e-dc01-57ae-a862-065116a22f80', 10, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd9ff0c0e-dc01-57ae-a862-065116a22f80', 11, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '73b3d9ff-c227-5d9f-87db-4a86faa5e48e', '4f2b6610-234b-5964-aad9-e14c17a079ff', '0f1d53c2-3b95-5fb1-88be-be2be6f66b17', 'Yu-Lun Wu', 'R99', 'individual', 14,
    187.0, 187.0, false, false, 'https://www.racingrulesofsailing.org/documents/15171/event',
    'scripts/imports/penghu-2026/novice_r11.pdf',
    '2026 ASAF Cup Optimist Open Championships Official PDF', 'document',
    'Rank 14 | B/N | TPE | Points: 187.0 nett (187.0 gross) | Club: 澎湖縣 帆船協', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1e203233-a2dc-5c1b-892e-aad54a0df479', '73b3d9ff-c227-5d9f-87db-4a86faa5e48e', '4f2b6610-234b-5964-aad9-e14c17a079ff', 'Yu-Lun Wu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '73b3d9ff-c227-5d9f-87db-4a86faa5e48e', 1, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '73b3d9ff-c227-5d9f-87db-4a86faa5e48e', 2, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '73b3d9ff-c227-5d9f-87db-4a86faa5e48e', 3, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '73b3d9ff-c227-5d9f-87db-4a86faa5e48e', 4, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '73b3d9ff-c227-5d9f-87db-4a86faa5e48e', 5, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '73b3d9ff-c227-5d9f-87db-4a86faa5e48e', 6, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '73b3d9ff-c227-5d9f-87db-4a86faa5e48e', 7, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '73b3d9ff-c227-5d9f-87db-4a86faa5e48e', 8, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '73b3d9ff-c227-5d9f-87db-4a86faa5e48e', 9, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '73b3d9ff-c227-5d9f-87db-4a86faa5e48e', 10, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '73b3d9ff-c227-5d9f-87db-4a86faa5e48e', 11, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

COMMIT;
