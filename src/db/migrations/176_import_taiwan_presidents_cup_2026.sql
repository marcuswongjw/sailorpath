-- Migration 176: Import 115th Academic Year National President's Cup Sailing Regatta 2026
--
-- Imports the official national championship results for:
-- Event: 115th Academic Year National President's Cup Sailing Regatta 2026 (115學年度總統盃全國帆船錦標賽)
-- Venue: Penghu / Tainan, Taiwan (Chinese Taipei)
-- Dates: 14 – 16 August 2026
-- Authority: Chinese Taipei Sailing Association (CTSA / 中華民國帆船協會)
-- Scope: 8 Fleets (134 total entries across 420, ILCA 4, ILCA 6, ILCA 7, Optimist), 6 races, 1 discard
--
-- Source: http://www.ct-sailing.org.tw / https://www.sailwave.com/results/115PresidentCup.htm
-- Corroborated visually against official CTSA PDF: Sailwave_results_-_成績_-_115總統盃.pdf
--
-- All operations execute in a single atomic transaction.

BEGIN;

-- 1. Insert New Verified Sailor Profiles
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7d1a349e-5675-50fb-b0a6-2efc40f4e906', 'Yen-Yun Weng', 'yen-yun-weng-a65aba', 'TPE 41009', '西門實小基訓站', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '309280c8-279c-518f-8673-2496c0bf7172', 'Yu-Cheng Kao', 'yu-cheng-kao-9e41b5', 'TPE 41009', '西門實小基訓站', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '52c54c04-19a2-5ffd-b3e0-18d2b0e711c3', 'Shu-Yuan Yang', 'shu-yuan-yang-6fc7fc', 'TPE56234', '西門實小基訓站', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '61c31681-b07f-5ef9-ba7d-5d86b572903c', 'Ming-Ni Wu', 'ming-ni-wu-871fab', 'TPE51172', '西門實小基訓站', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e2cb88db-992c-5b42-af56-5af66ace6804', 'Ming-Yuan Wei', 'ming-yuan-wei-2428d3', 'TPE51172', '西門實小基訓站', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '1bb526cf-8094-59a4-ad00-42c5adc0fe07', 'Feng Chang', 'feng-chang-d1ee70', 'TPE57242', '舊城蓮潭帆船隊', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ea1a795a-53bd-5135-a346-b61df2a92c28', 'Hao-Chung Cheng', 'hao-chung-cheng-8b8e90', 'TPE57242', '舊城蓮潭帆船隊', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd1e310ac-9ea8-5b8e-959f-493fcb253c7e', 'Yu Lee', 'yu-lee-8fac9d', 'TPE214516', '宜蘭縣帆船委員會', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f6be3f6f-ca95-510a-8dc1-2cd5e34d0b3a', 'Yu-Ching Kang', 'yu-ching-kang-08282a', 'TPE211956', '宜蘭縣帆船委員會', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f45e0130-7dca-5f3f-bc95-6271720a6550', 'Yu-Hsin Kang', 'yu-hsin-kang-1ed67c', 'TPE211389', '宜蘭縣帆船委員會', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'cd40d57b-bbdd-57cb-8892-df62ca9de263', 'Yu-Tsen Cheng', 'yu-tsen-cheng-3e167e', 'TPE171717', '舊城蓮潭帆船隊', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '44846191-11f2-509c-9168-dbcd34b8e4ee', 'Dan Lee', 'dan-lee-e227e5', 'TPE217710', '宜蘭縣帆船委員會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '086f8230-4b3b-5ce9-a37d-50032114a00d', 'Hsia-An Wu', 'hsia-an-wu-5ad966', 'TPE180471', '舊城蓮潭帆船隊', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ca5a740b-f83f-59ba-9e8c-71171b957085', 'Cheng-Hsuan Lee', 'cheng-hsuan-lee-f380a9', 'TPE 206219', '宜蘭縣帆船委員會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c2f440b9-b509-59c9-928e-d25c9f722fb3', 'Hsi-Hsiang Chen', 'hsi-hsiang-chen-126fb9', 'TPE P71', '高雄市鹽埕國中', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '8ff74b8a-c2cc-544f-ada9-17b2f4e44527', 'Chia-Cheng Chen', 'chia-cheng-chen-6e4ccd', 'TPE 211738', '岳明國中小', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3abf7cb1-2d4f-5e3b-857e-85407987d1a9', 'Yu-Chun Liu', 'yu-chun-liu-4e93cf', 'TPE225258', '舊城蓮潭帆船隊', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '604b8e9d-46c9-5dfb-a85a-0398148f64c8', 'Ho-Yen Chen', 'ho-yen-chen-7ca23d', 'TPE220704', '澎湖縣帆船協會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4f2b6610-234b-5964-aad9-e14c17a079ff', 'Yu-Lun Wu', 'yu-lun-wu-2829a3', 'TPE 224989', '澎湖縣帆船協會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e263fbe8-e092-5c21-9677-b7b94f69aaa1', 'Pin-Chieh Chen', 'pin-chieh-chen-9f2b3e', 'TPE206217', '宜蘭縣帆船委員會', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e18f1669-26db-522e-bac6-5a5277752a74', 'Chia-Yi Tsai', 'chia-yi-tsai-c6ba9a', 'TPE P1', '國立中山大學', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd3979635-ef2f-5ed9-814a-00e7ef627ea0', 'Tsai-Hsin Yang', 'tsai-hsin-yang-8a689e', 'TPE219715', '西門實小基訓站', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'bf078d94-b180-5e38-a378-b8ce8a09e797', 'Tsai-Tien Chien', 'tsai-tien-chien-9910e7', 'TPE215315', 'Petit Sailing Team', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ee1ccc12-b89b-5d0d-a2e5-c6ab9d390200', 'Tien Tien', 'tien-tien-fec116', 'TPE225249', '舊城蓮潭帆船隊', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '892240d1-d33f-5e7d-8c74-b5e7472665a7', 'Chia-Lun Tsai', 'chia-lun-tsai-b3fbf0', 'TPE DNC', '西門實小基訓站', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0e172325-9574-5be1-8f0a-962445b55a23', 'Kuan-Ying Lin', 'kuan-ying-lin-a61fff', 'TPE221517', '台北市體育會帆委會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '041a01c8-5ef3-5dd8-a9a3-cae71af93ab5', 'Wei-Chi Yang', 'wei-chi-yang-0fe8eb', 'TPE208551', '宜蘭縣帆船委員會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '274834bb-812d-5609-9908-f3463957d8dc', 'Yi-Ho Chen', 'yi-ho-chen-64c423', 'TPE211956', '宜蘭縣帆船委員會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '47c5be42-05bb-5acb-9351-073c5402ea47', 'Tung-Yen Wang', 'tung-yen-wang-b0c510', 'TPE 3', '澎湖縣帆船協會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c0f558e7-1414-56ea-84d8-eb6366ed0c8c', 'Tzu-Tung Huang', 'tzu-tung-huang-9f8036', 'TPE 220019', '高雄市鹽埕國中', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '6ab02afb-fd98-559c-a6dd-ef7543aa4d1c', 'Yi Huang', 'yi-huang-5a3347', 'TPE217273', '宜蘭縣帆船委員會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '8bf566f5-98b6-5eec-b7fe-e23defb55572', 'Chia-Che Chang', 'chia-che-chang-475446', 'TPE163105', '桃園市體育會帆委會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4f2280b1-db6c-5673-8c3d-099a056733ab', 'Lang-Yi Yen', 'lang-yi-yen-bded9c', 'TPE203364', '西門實小基訓站', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'dc759d26-e36e-51ac-ac48-94e2ac11c692', 'Chih-Wei Chang', 'chih-wei-chang-c72721', 'TPE224425', '桃園市體育會帆委會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e33cf953-d1c6-5488-9525-340830ba794f', 'Chen-Hsiang Chang', 'chen-hsiang-chang-7f5af8', 'TPE218856', '個人', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'fb290f51-17a8-5826-8bb4-80748775937d', 'Chun-Hu Chen', 'chun-hu-chen-51e483', 'TPE 205952', '舊城蓮潭帆船隊', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '07565255-54e5-5231-bf77-f63808f8ea40', 'Shih-Ying Chen', 'shih-ying-chen-1ad3a8', 'TPE 224989', '台北市體育會帆委會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ad90926a-f326-511a-bfd4-6aab27047ac9', 'Chi-Pao Hsiao', 'chi-pao-hsiao-8fb639', 'TPE L1', '舊城蓮潭帆船隊', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ba3d436a-6be2-5197-af64-dfcd9fa3cf44', 'Yu-Han Kao', 'yu-han-kao-8f8d6b', 'TPE313', '西門實小帆船隊', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '601073d9-76a1-5384-8eef-8b15a2ba71dd', 'Jui-Chun Yeh', 'jui-chun-yeh-373969', 'TPE522', '高雄市', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '8c4d48e7-2178-51f9-be51-63a857d51159', 'Shu-Ya Hsu', 'shu-ya-hsu-8f85a6', 'TPE258', '金門帆船協會', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '06575f3d-3a87-5420-acbc-8693b2325462', 'Chen-Yueh Wu', 'chen-yueh-wu-88147d', 'TPE329', '西門實小帆船隊', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'b88efdbf-f3bc-550a-907d-812ffe4e17cf', 'Chia-Yin Yang', 'chia-yin-yang-dc2292', 'TPE319', '西門實小帆船隊', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '69a37535-3ce6-5411-b57e-ec4857045f7c', 'Ai-Jan Lin', 'ai-jan-lin-4ece3d', 'TPE990', '宜蘭縣帆船委員會', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '08350803-1171-57de-a0b6-4c9f6f8a4771', 'Yun-Yun Chuang', 'yun-yun-chuang-455b47', 'TPE772', '舊城蓮潭帆船隊', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '78ac9250-8763-5e62-a94a-e25440100616', 'Shan-Ya Lee', 'shan-ya-lee-96ed5f', 'TPE427', '舊城蓮潭帆船隊', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7a2ac7a7-8764-5d8d-9c0f-9a5e1e175e45', 'Pin-Hsuan Huang', 'pin-hsuan-huang-1b324e', 'TPE2010', '高雄市鹽埕國中', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd2384e74-ecef-53b2-8006-54f4ccdcbc36', 'Shan-Yu Lee', 'shan-yu-lee-ba4e99', 'TPE773', '舊城蓮潭帆船隊', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c8ebccc0-3c26-538e-a69f-b7bfb87e61c5', 'Ping-Shan Tsai', 'ping-shan-tsai-aa60e9', 'TPE2581', '西門實小帆船隊', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c1a03a94-6e78-55f8-a2d7-5b6853cd3f55', 'Yi-Ti Lin', 'yi-ti-lin-85ccb2', 'TPE205', '岳明國中小', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7e9cdcc8-c8b0-588d-b373-043757706939', 'Hsun-Wei Lee', 'hsun-wei-lee-6a6f6c', 'TPE3581', '西門實小帆船隊', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '898e5637-3419-5904-860b-cf3db1e6acab', 'Chen-Hsuan Hsu', 'chen-hsuan-hsu-a23a8e', 'TPE7581', '西門實小帆船隊', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '27fd04c9-03a2-5dbc-9c25-075401cb66d1', 'En-Chi Lu', 'en-chi-lu-e62423', 'TPE517', '澎湖縣帆船協會', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'fdf1c741-7d7c-57b2-a2ae-ecef43d8ca14', 'Szu-Ai Wu', 'szu-ai-wu-69f313', 'TPE201', '岳明國中小', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '91856758-95b0-51ad-92d4-145092644ee4', 'Yu-Chiao Yeh', 'yu-chiao-yeh-11fa67', 'TPE P9', '舊城蓮潭帆船隊', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a909e581-5406-53d1-a259-1d69c9ac685e', 'Hui-Jou Chen', 'hui-jou-chen-ee2198', 'TPE526', '澎湖縣帆船協會', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '8b073b9f-d28e-548c-a2b6-c46c8fc8a4bb', 'Mei-Ni Chen', 'mei-ni-chen-8c29e6', 'TPE P1', '高雄市鹽埕國中', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'b9ac8abe-fd53-5c72-bd25-205a8a936fd6', 'Hsuan-Nung Liu', 'hsuan-nung-liu-bb31c2', 'TPE1122', '慈心華德福', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7bd860c8-2451-573b-9f98-ef8d0eb732e1', 'Yun-Chen Pan', 'yun-chen-pan-0db92a', 'TPE369', '台北市體育會帆委會', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f35b2033-9efa-59b4-a8a9-7e13c227393f', 'Hui-Yun Chen', 'hui-yun-chen-33b109', 'TPE DNC', '澎湖縣帆船協會', 'TPE', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '6bf21dbb-951a-593f-958a-83e8a1f747f7', 'Li-Pan Cheng', 'li-pan-cheng-82d86b', 'TPE379', '西門實小帆船隊', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '88a2fbbe-aab5-574e-8857-17af0d41761b', 'Ko-Pang Chen', 'ko-pang-chen-ead486', 'TPE388', '西門實小帆船隊', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'fa95f8cf-a1aa-5899-8a7b-a103437ccb66', 'Yu-Chen Wu', 'yu-chen-wu-fa4918', 'TPE0438', '慈心華德福', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd633d303-0df9-5e24-813e-3b9883b6f5d7', 'Ching-Hao Huang', 'ching-hao-huang-f0d9f4', 'TPE7027', '宜蘭縣帆船委員會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '254c367b-6e51-5f0d-aed7-8eb7a5891fee', 'Hsin-Yi Chen', 'hsin-yi-chen-17c79f', 'TPE228', '高雄美國學校', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5f06d81b-8f07-519b-b6e0-52afda7684a6', 'Tzu-Le Liu', 'tzu-le-liu-d2b4a2', 'TPE336', 'Petit Sailing Team', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '85242f97-5154-5a43-a4b8-2616129bf515', 'Chien-Jun Lin', 'chien-jun-lin-a879be', 'TPE304', '慈心華德福', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f1676640-6736-5ced-aa15-5d34ece931db', 'Yu-Heng Kao', 'yu-heng-kao-38c0ed', 'TPE399', '西門實小帆船隊', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '8eb39919-2873-52ba-b924-5caceb21772b', 'Ching-Heng Chen', 'ching-heng-chen-e76520', 'TPE305', '慈心華德福', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'aea31e27-b622-557f-84cb-9b21f710ea62', 'Yu-En Chou', 'yu-en-chou-e5baea', 'TPE1', '高雄市鹽埕國中', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5ffedc80-dc4c-5c6c-832a-dfb8118c82c2', 'Chun-Lun Chuang', 'chun-lun-chuang-bdd943', 'TPE353', '台北市體育會帆委會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3abc74d9-167d-5bc9-b5e4-a496ec17a4ed', 'Yu-An Chen', 'yu-an-chen-5979f5', 'TPE352', '台北市體育會帆委會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd76e6581-d1b0-5211-a72d-88ac7a602f51', 'Yung-Yung Chen', 'yung-yung-chen-fe6e27', 'TPE361', '台北市體育會帆委會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'bbe13c8b-4ee2-57fd-af74-84ba978b0bf3', 'Chan-Jui Liu', 'chan-jui-liu-4acf54', 'TPE771', '舊城蓮潭帆船隊', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '42ef2ae2-4817-54ae-b791-c8b9aaea9d53', 'Chi-Kang Huang', 'chi-kang-huang-4cdabc', 'TPE535', '澎湖縣帆船協會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7e455f91-5dc1-5764-abf4-63893c88207a', 'Yu-Fan Shih', 'yu-fan-shih-00b113', 'TPE7389', '慈心華德福', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7b5e9e3f-885d-5e04-9f8b-044cd97414e3', 'Yin-Tung Lee', 'yin-tung-lee-5d38e3', 'TPE525', '澎湖縣帆船協會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0e7373c9-08a9-5ed7-9193-a49820138f4b', 'Tai-Cheng Chao', 'tai-cheng-chao-206aed', 'TPE017', '高雄市鹽埕國中', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4c1c8dd4-a538-5a6e-9618-039e3f1e763e', 'Wei-Fan Chao', 'wei-fan-chao-4800a5', 'TPE1125', '個人', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2c9932ca-baf4-50d8-81d9-db4b948667db', 'Kang-Chun Yeh', 'kang-chun-yeh-f18401', 'TPE928', '高雄市', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'b2c05554-8405-55c8-bcbf-9c8b2e209f90', 'Chih-Yu Chen', 'chih-yu-chen-e3bfe5', 'TPE206', '岳明國中小', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5f830d4c-6d5c-5325-ae75-d9f6b3671839', 'Chi-Jui Yeh', 'chi-jui-yeh-81aecc', 'TPE350', '台北市體育會帆委會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c9629945-7f1b-51a9-a04a-b189e950e511', 'Chin-Li Lin', 'chin-li-lin-01d925', 'TPE355', '台北市體育會帆委會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '86b36815-73c2-5333-8a7c-bbb82e3688be', 'Chien-Yu Huang', 'chien-yu-huang-0631b3', 'TPE351', '台北市體育會帆委會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4236390e-1f4d-5242-b2eb-e676bd551f60', 'Ying-Yu Chen', 'ying-yu-chen-ccdac4', 'TPE775', '舊城蓮潭帆船隊', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '72201bba-eca0-5022-bc09-619dd58d66ff', 'Yu-Chi Chen', 'yu-chi-chen-cc6f50', 'TPE202', '岳明國中小', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'b1a7dd64-fe8a-5606-9782-3049cdc83425', 'Chi-Sheng Chen', 'chi-sheng-chen-1f698f', 'TPE500', '澎湖縣帆船協會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '6f68806a-c832-5155-87cb-7bed1c3ec1fd', 'Chen-Lin Chu', 'chen-lin-chu-a3e007', 'TPE4591', '西門實小帆船隊', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5af9588b-6ef2-5b2f-8726-7288ca98dd37', 'Chen-Feng Chen', 'chen-feng-chen-fef575', 'TPE555', '澎湖縣帆船協會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '9de08b25-9cd5-50d4-9e7a-15f082355500', 'Fan-En Wu', 'fan-en-wu-ca8c3b', 'TPE207', '宜蘭縣帆船委員會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '84417cff-bddd-546e-ac5c-324412cb9891', 'Yi-Chen Hsu', 'yi-chen-hsu-acb341', 'TPE545', '澎湖縣帆船協會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '9853539d-7c57-521b-bc4a-b2a6993f19a7', 'Chun-Ho Chuang', 'chun-ho-chuang-21e728', 'TPE P8', '舊城蓮潭帆船隊', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c26826da-22ca-5c19-a3eb-f900199e637d', 'Tzu-An Wang', 'tzu-an-wang-cb47ff', 'TPE R21', '澎湖縣帆船協會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '8f88d815-3012-5a9e-8630-3e4896575835', 'Shih-Cheng Chuang', 'shih-cheng-chuang-396e58', 'TPE81', '慈心華德福', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7f05991f-650b-5825-89e3-27d05b8aba9a', 'Tao-Yin Tan', 'tao-yin-tan-6d272c', 'TPE360', '台北市體育會帆委會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0d5a6da7-f86a-5d68-ad55-bb48a4206750', 'Yu-Yu Chang', 'yu-yu-chang-3c6f7d', 'TPE6581', '西門實小帆船隊', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a1036258-40db-56bc-91e4-219d20c32d19', 'Yu-Hsuan Kuo', 'yu-hsuan-kuo-2f2293', 'TPE356', '台北市體育會帆委會', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '29179602-7806-5522-a6af-71908371af48', 'Fan-Chun Liao', 'fan-chun-liao-821f15', 'TPE358', '西門實小帆船隊', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5a624207-08d4-53e9-8381-42cf361b8e70', 'Yun-Hao Chuang', 'yun-hao-chuang-144b9e', 'TPE DNC', '舊城蓮潭帆船隊', 'TPE', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);

-- 2. Create Parent Regatta Event
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer,
    classes, nor_url, created_at, updated_at
) VALUES (
    '38fb8127-ec56-5fa4-bda5-74844ce55a90',
    '115th Academic Year National President''s Cup Sailing Regatta 2026',
    'taiwan-presidents-cup-2026',
    '2026-08-14',
    '2026-08-16',
    'Penghu / Tainan, Taiwan',
    'Chinese Taipei Sailing Association (CTSA)',
    '["420", "ILCA 4", "ILCA 6", "ILCA 7", "optimist"]'::jsonb,
    'https://www.ct-sailing.org.tw/index.php/%E8%B3%BD%E4%BA%8B%E8%B3%87%E8%A8%8A/%E7%AB%B6%E8%B3%BD%E6%88%90%E7%B8%BE%E5%85%AC%E5%91%8A/item/1568-115%E5%B9%B4%E7%B8%BD%E7%B5%B1%E7%9B%83%E5%85%A8%E5%9C%8B%E5%B8%86%E8%88%B9%E9%8C%A6%E6%A8%99%E8%B3%BD-%E7%AB%B6%E8%B3%BD%E6%88%90%E7%B8%BE.html',
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    updated_at = clock_timestamp();

-- Sheet: 115th Academic Year National President's Cup Sailing Regatta 2026 — 420
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    'a791ecba-4d95-5762-8d65-4dc174f81c43',
    '38fb8127-ec56-5fa4-bda5-74844ce55a90',
    '115th Academic Year National President''s Cup Sailing Regatta 2026 — 420',
    'taiwan-presidents-cup-2026-420-7db585',
    '2026-08-16',
    '2026-08-16',
    4,
    'Open',
    6,
    'TPE',
    '420',
    'crew',
    2,
    2,
    false,
    'Penghu / Tainan, Taiwan',
    'Chinese Taipei Sailing Association (CTSA)',
    'published',
    'https://www.sailwave.com/results/115PresidentCup.htm',
    'CTSA Official Results Sailwave_results_-_成績_-_115總統盃.pdf',
    '115th Academic Year National President''s Cup Sailing Regatta 2026 (115學年度總統盃全國帆船錦標賽). 6 races sailed with 1 discard.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a9780c51-558e-5654-972f-cc559c5d2218', '7d1a349e-5675-50fb-b0a6-2efc40f4e906', 'a791ecba-4d95-5762-8d65-4dc174f81c43', 'Yen-Yun Weng & Yu-Cheng Kao', '41009', 'crew', 1,
    10.0, 5.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Helm: Yen-Yun Weng (翁硯昀), Crew: Yu-Cheng Kao (高宇呈). Club: 西門實小基訓站. Division: 大專組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a736d90e-c503-509f-a9b9-edde488cc978', 'a9780c51-558e-5654-972f-cc559c5d2218', '7d1a349e-5675-50fb-b0a6-2efc40f4e906', 'Yen-Yun Weng', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '55b25bed-e9e6-5537-ba78-1188b60727ab', 'a9780c51-558e-5654-972f-cc559c5d2218', '309280c8-279c-518f-8673-2496c0bf7172', 'Yu-Cheng Kao', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a9780c51-558e-5654-972f-cc559c5d2218', 1, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a9780c51-558e-5654-972f-cc559c5d2218', 2, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a9780c51-558e-5654-972f-cc559c5d2218', 3, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a9780c51-558e-5654-972f-cc559c5d2218', 4, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a9780c51-558e-5654-972f-cc559c5d2218', 5, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a9780c51-558e-5654-972f-cc559c5d2218', 6, 5.0, 'DNC', true, '(5.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '0e4eceef-7295-5366-96d5-67ce8730d0ec', 'ca255c9c-bebe-5992-8f15-1debf2701811', 'a791ecba-4d95-5762-8d65-4dc174f81c43', 'Jui-Hsuan Chen & Shu-Yuan Yang', 'TPE56234', 'crew', 2,
    15.0, 10.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Helm: Jui-Hsuan Chen (陳睿萱), Crew: Shu-Yuan Yang (楊舒媛). Club: 西門實小基訓站. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'df660bee-70f8-547f-b6f4-f27e791c30af', '0e4eceef-7295-5366-96d5-67ce8730d0ec', 'ca255c9c-bebe-5992-8f15-1debf2701811', 'Jui-Hsuan Chen', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a230a89d-95e8-54c8-91b2-9381731482d2', '0e4eceef-7295-5366-96d5-67ce8730d0ec', '52c54c04-19a2-5ffd-b3e0-18d2b0e711c3', 'Shu-Yuan Yang', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0e4eceef-7295-5366-96d5-67ce8730d0ec', 1, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0e4eceef-7295-5366-96d5-67ce8730d0ec', 2, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0e4eceef-7295-5366-96d5-67ce8730d0ec', 3, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0e4eceef-7295-5366-96d5-67ce8730d0ec', 4, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0e4eceef-7295-5366-96d5-67ce8730d0ec', 5, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0e4eceef-7295-5366-96d5-67ce8730d0ec', 6, 5.0, 'DNC', true, '(5.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '14695093-128b-5a08-8d48-aad9cd4f3b9a', '61c31681-b07f-5ef9-ba7d-5d86b572903c', 'a791ecba-4d95-5762-8d65-4dc174f81c43', 'Ming-Ni Wu & Ming-Yuan Wei', 'TPE51172', 'crew', 3,
    17.0, 13.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Helm: Ming-Ni Wu (巫明霓), Crew: Ming-Yuan Wei (魏明瑗). Club: 西門實小基訓站. Division: 大專組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '31446267-49ab-5648-a1e8-dccfdde9bc9e', '14695093-128b-5a08-8d48-aad9cd4f3b9a', '61c31681-b07f-5ef9-ba7d-5d86b572903c', 'Ming-Ni Wu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f025a955-3562-53fd-97a9-ca183f42c94c', '14695093-128b-5a08-8d48-aad9cd4f3b9a', 'e2cb88db-992c-5b42-af56-5af66ace6804', 'Ming-Yuan Wei', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14695093-128b-5a08-8d48-aad9cd4f3b9a', 1, 4.0, NULL, true, '(4.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14695093-128b-5a08-8d48-aad9cd4f3b9a', 2, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14695093-128b-5a08-8d48-aad9cd4f3b9a', 3, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14695093-128b-5a08-8d48-aad9cd4f3b9a', 4, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14695093-128b-5a08-8d48-aad9cd4f3b9a', 5, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14695093-128b-5a08-8d48-aad9cd4f3b9a', 6, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f97f9d6e-15a4-5331-9d8a-5651a9fda7b7', '1bb526cf-8094-59a4-ad00-42c5adc0fe07', 'a791ecba-4d95-5762-8d65-4dc174f81c43', 'Feng Chang & Hao-Chung Cheng', 'TPE57242', 'crew', 4,
    21.0, 17.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Helm: Feng Chang (張豐), Crew: Hao-Chung Cheng (鄭皓中). Club: 舊城蓮潭帆船隊. Division: 大專組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '58c73c63-7288-5eb9-8204-d8ebe45ee515', 'f97f9d6e-15a4-5331-9d8a-5651a9fda7b7', '1bb526cf-8094-59a4-ad00-42c5adc0fe07', 'Feng Chang', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b31c0034-672b-5a4e-9159-8f07bb030f9e', 'f97f9d6e-15a4-5331-9d8a-5651a9fda7b7', 'ea1a795a-53bd-5135-a346-b61df2a92c28', 'Hao-Chung Cheng', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f97f9d6e-15a4-5331-9d8a-5651a9fda7b7', 1, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f97f9d6e-15a4-5331-9d8a-5651a9fda7b7', 2, 4.0, NULL, true, '(4.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f97f9d6e-15a4-5331-9d8a-5651a9fda7b7', 3, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f97f9d6e-15a4-5331-9d8a-5651a9fda7b7', 4, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f97f9d6e-15a4-5331-9d8a-5651a9fda7b7', 5, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f97f9d6e-15a4-5331-9d8a-5651a9fda7b7', 6, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
-- Sheet: 115th Academic Year National President's Cup Sailing Regatta 2026 — ILCA 4 (G)
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    'a483d978-c75f-5be9-abe7-2918f5649abe',
    '38fb8127-ec56-5fa4-bda5-74844ce55a90',
    '115th Academic Year National President''s Cup Sailing Regatta 2026 — ILCA 4 (G)',
    'taiwan-presidents-cup-2026-ilca-4-g-b430c4',
    '2026-08-16',
    '2026-08-16',
    12,
    'Girls',
    6,
    'TPE',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'Penghu / Tainan, Taiwan',
    'Chinese Taipei Sailing Association (CTSA)',
    'published',
    'https://www.sailwave.com/results/115PresidentCup.htm',
    'CTSA Official Results Sailwave_results_-_成績_-_115總統盃.pdf',
    '115th Academic Year National President''s Cup Sailing Regatta 2026 (115學年度總統盃全國帆船錦標賽). 6 races sailed with 1 discard.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '5c207743-fa3a-5edc-a9ce-4d7208298501', '6e1c5516-938f-44fa-9898-f997676aa998', 'a483d978-c75f-5be9-abe7-2918f5649abe', 'Yong-Fen Yang', 'TPE225799', 'individual', 1,
    23.0, 10.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yong-Fen Yang (楊詠雰). Club: 慈心華德福. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd597a5bb-5171-522c-b3a8-0eec5c84ede1', '5c207743-fa3a-5edc-a9ce-4d7208298501', '6e1c5516-938f-44fa-9898-f997676aa998', 'Yong-Fen Yang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5c207743-fa3a-5edc-a9ce-4d7208298501', 1, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5c207743-fa3a-5edc-a9ce-4d7208298501', 2, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5c207743-fa3a-5edc-a9ce-4d7208298501', 3, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5c207743-fa3a-5edc-a9ce-4d7208298501', 4, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5c207743-fa3a-5edc-a9ce-4d7208298501', 5, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5c207743-fa3a-5edc-a9ce-4d7208298501', 6, 13.0, 'UFD', true, '(13.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '66f7e5b4-c20a-5ba4-a2bf-61cc4fe88690', '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24', 'a483d978-c75f-5be9-abe7-2918f5649abe', 'Huang Chi Fang', 'TPE220975', 'individual', 2,
    16.0, 12.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Huang Chi Fang (黃祺方). Club: Petit Sailing Team. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '84eb5224-a73b-5988-9565-293f5e03bc23', '66f7e5b4-c20a-5ba4-a2bf-61cc4fe88690', '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24', 'Huang Chi Fang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '66f7e5b4-c20a-5ba4-a2bf-61cc4fe88690', 1, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '66f7e5b4-c20a-5ba4-a2bf-61cc4fe88690', 2, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '66f7e5b4-c20a-5ba4-a2bf-61cc4fe88690', 3, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '66f7e5b4-c20a-5ba4-a2bf-61cc4fe88690', 4, 4.0, NULL, true, '(4.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '66f7e5b4-c20a-5ba4-a2bf-61cc4fe88690', 5, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '66f7e5b4-c20a-5ba4-a2bf-61cc4fe88690', 6, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '9ab736b9-715f-590e-ba30-4d84974beafc', 'b393c33b-604a-44a2-a38f-8007c7c7864c', 'a483d978-c75f-5be9-abe7-2918f5649abe', 'Yen-Chen Wang', '163120', 'individual', 3,
    20.0, 15.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yen-Chen Wang (王妍禎). Club: 舊城蓮潭帆船隊. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ef05559f-f1cc-51b5-b38f-b28a6f946105', '9ab736b9-715f-590e-ba30-4d84974beafc', 'b393c33b-604a-44a2-a38f-8007c7c7864c', 'Yen-Chen Wang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9ab736b9-715f-590e-ba30-4d84974beafc', 1, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9ab736b9-715f-590e-ba30-4d84974beafc', 2, 5.0, NULL, true, '(5.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9ab736b9-715f-590e-ba30-4d84974beafc', 3, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9ab736b9-715f-590e-ba30-4d84974beafc', 4, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9ab736b9-715f-590e-ba30-4d84974beafc', 5, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9ab736b9-715f-590e-ba30-4d84974beafc', 6, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a0bf55f6-9cbe-50af-b423-da38da9de6c9', 'e6c9edb9-50e0-4c08-aa12-10adddc47146', 'a483d978-c75f-5be9-abe7-2918f5649abe', 'Sin-Ping Lee', 'TPE223464', 'individual', 4,
    24.0, 18.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Sin-Ping Lee (李心平). Club: Petit Sailing Team. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '8818fa66-6932-5e29-820a-326cb332ec4e', 'a0bf55f6-9cbe-50af-b423-da38da9de6c9', 'e6c9edb9-50e0-4c08-aa12-10adddc47146', 'Sin-Ping Lee', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a0bf55f6-9cbe-50af-b423-da38da9de6c9', 1, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a0bf55f6-9cbe-50af-b423-da38da9de6c9', 2, 6.0, NULL, true, '(6.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a0bf55f6-9cbe-50af-b423-da38da9de6c9', 3, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a0bf55f6-9cbe-50af-b423-da38da9de6c9', 4, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a0bf55f6-9cbe-50af-b423-da38da9de6c9', 5, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a0bf55f6-9cbe-50af-b423-da38da9de6c9', 6, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a9a95764-2ffd-501b-9e67-6ca08486eef6', 'e81d9357-afbd-4c0b-a9e9-abfdead88975', 'a483d978-c75f-5be9-abe7-2918f5649abe', 'Jung-Tsen Kao', 'TPE223465', 'individual', 5,
    26.0, 19.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Jung-Tsen Kao (高戎岑). Club: 西門實小基訓站. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '2d526749-1a3f-5dcf-bf86-1e9b66ffcd65', 'a9a95764-2ffd-501b-9e67-6ca08486eef6', 'e81d9357-afbd-4c0b-a9e9-abfdead88975', 'Jung-Tsen Kao', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a9a95764-2ffd-501b-9e67-6ca08486eef6', 1, 7.0, NULL, true, '(7.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a9a95764-2ffd-501b-9e67-6ca08486eef6', 2, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a9a95764-2ffd-501b-9e67-6ca08486eef6', 3, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a9a95764-2ffd-501b-9e67-6ca08486eef6', 4, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a9a95764-2ffd-501b-9e67-6ca08486eef6', 5, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a9a95764-2ffd-501b-9e67-6ca08486eef6', 6, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '41121002-6125-5b42-a3d6-78499f738635', 'd1e310ac-9ea8-5b8e-959f-493fcb253c7e', 'a483d978-c75f-5be9-abe7-2918f5649abe', 'Yu Lee', 'TPE214516', 'individual', 6,
    26.0, 20.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yu Lee (李榆). Club: 宜蘭縣帆船委員會. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b8a0a47c-c3f3-5d11-a21d-e579eb4a5861', '41121002-6125-5b42-a3d6-78499f738635', 'd1e310ac-9ea8-5b8e-959f-493fcb253c7e', 'Yu Lee', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41121002-6125-5b42-a3d6-78499f738635', 1, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41121002-6125-5b42-a3d6-78499f738635', 2, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41121002-6125-5b42-a3d6-78499f738635', 3, 6.0, NULL, true, '(6.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41121002-6125-5b42-a3d6-78499f738635', 4, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41121002-6125-5b42-a3d6-78499f738635', 5, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41121002-6125-5b42-a3d6-78499f738635', 6, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'daa448a6-bc1e-5a0d-ac25-52d20ccdfad5', 'bc7c7145-2943-4798-8eac-f9fc3c664d84', 'a483d978-c75f-5be9-abe7-2918f5649abe', 'Yan-Yun Wang', 'TPE221514', 'individual', 7,
    52.0, 41.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yan-Yun Wang (王彥勻). Club: 慈心華德福. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '947ddd22-ec13-5571-857d-78cf02412f6f', 'daa448a6-bc1e-5a0d-ac25-52d20ccdfad5', 'bc7c7145-2943-4798-8eac-f9fc3c664d84', 'Yan-Yun Wang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'daa448a6-bc1e-5a0d-ac25-52d20ccdfad5', 1, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'daa448a6-bc1e-5a0d-ac25-52d20ccdfad5', 2, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'daa448a6-bc1e-5a0d-ac25-52d20ccdfad5', 3, 11.0, NULL, true, '(11.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'daa448a6-bc1e-5a0d-ac25-52d20ccdfad5', 4, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'daa448a6-bc1e-5a0d-ac25-52d20ccdfad5', 5, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'daa448a6-bc1e-5a0d-ac25-52d20ccdfad5', 6, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '830dd126-260b-57bf-af19-ca6e73a4a96a', 'f6be3f6f-ca95-510a-8dc1-2cd5e34d0b3a', 'a483d978-c75f-5be9-abe7-2918f5649abe', 'Yu-Ching Kang', 'TPE211956', 'individual', 8,
    54.0, 42.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yu-Ching Kang (康予瀞). Club: 宜蘭縣帆船委員會. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '104dbb6d-86d0-59ba-b6fc-83b5080df744', '830dd126-260b-57bf-af19-ca6e73a4a96a', 'f6be3f6f-ca95-510a-8dc1-2cd5e34d0b3a', 'Yu-Ching Kang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '830dd126-260b-57bf-af19-ca6e73a4a96a', 1, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '830dd126-260b-57bf-af19-ca6e73a4a96a', 2, 12.0, NULL, true, '(12.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '830dd126-260b-57bf-af19-ca6e73a4a96a', 3, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '830dd126-260b-57bf-af19-ca6e73a4a96a', 4, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '830dd126-260b-57bf-af19-ca6e73a4a96a', 5, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '830dd126-260b-57bf-af19-ca6e73a4a96a', 6, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd71e70f6-d488-504a-b2c1-303ad5cb9744', '70371bac-6222-4625-8df8-296f67f622dc', 'a483d978-c75f-5be9-abe7-2918f5649abe', 'En-Rui Hsu', 'TPE208532', 'individual', 9,
    56.0, 43.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: En-Rui Hsu (許恩睿). Club: 西門實小基訓站. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'abea56d0-4f55-50f8-9b07-12c0da757067', 'd71e70f6-d488-504a-b2c1-303ad5cb9744', '70371bac-6222-4625-8df8-296f67f622dc', 'En-Rui Hsu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd71e70f6-d488-504a-b2c1-303ad5cb9744', 1, 13.0, 'UFD', true, '(13.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd71e70f6-d488-504a-b2c1-303ad5cb9744', 2, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd71e70f6-d488-504a-b2c1-303ad5cb9744', 3, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd71e70f6-d488-504a-b2c1-303ad5cb9744', 4, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd71e70f6-d488-504a-b2c1-303ad5cb9744', 5, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd71e70f6-d488-504a-b2c1-303ad5cb9744', 6, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'b928d0b0-2ca8-55ad-9668-7e495a40a0ea', 'fbe35ec3-7641-4c10-a598-747e60b46a14', 'a483d978-c75f-5be9-abe7-2918f5649abe', 'Ai-Mei Lien', 'TPE224990', 'individual', 10,
    56.0, 44.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Ai-Mei Lien (連愛玫). Club: 澎湖縣帆船協會. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '85bb3f6d-90a1-5b3d-a6d8-9c22888758d8', 'b928d0b0-2ca8-55ad-9668-7e495a40a0ea', 'fbe35ec3-7641-4c10-a598-747e60b46a14', 'Ai-Mei Lien', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b928d0b0-2ca8-55ad-9668-7e495a40a0ea', 1, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b928d0b0-2ca8-55ad-9668-7e495a40a0ea', 2, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b928d0b0-2ca8-55ad-9668-7e495a40a0ea', 3, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b928d0b0-2ca8-55ad-9668-7e495a40a0ea', 4, 12.0, NULL, true, '(12.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b928d0b0-2ca8-55ad-9668-7e495a40a0ea', 5, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b928d0b0-2ca8-55ad-9668-7e495a40a0ea', 6, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ea92ef36-4d55-575d-b256-5f298e71938f', 'f45e0130-7dca-5f3f-bc95-6271720a6550', 'a483d978-c75f-5be9-abe7-2918f5649abe', 'Yu-Hsin Kang', 'TPE211389', 'individual', 11,
    55.0, 45.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yu-Hsin Kang (康予馨). Club: 宜蘭縣帆船委員會. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1d382dd9-ebd7-5263-9383-949b0cf4cba6', 'ea92ef36-4d55-575d-b256-5f298e71938f', 'f45e0130-7dca-5f3f-bc95-6271720a6550', 'Yu-Hsin Kang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea92ef36-4d55-575d-b256-5f298e71938f', 1, 10.0, NULL, true, '(10.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea92ef36-4d55-575d-b256-5f298e71938f', 2, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea92ef36-4d55-575d-b256-5f298e71938f', 3, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea92ef36-4d55-575d-b256-5f298e71938f', 4, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea92ef36-4d55-575d-b256-5f298e71938f', 5, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea92ef36-4d55-575d-b256-5f298e71938f', 6, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '5a7a191b-3241-5f06-b400-0021abd10fef', 'cd40d57b-bbdd-57cb-8892-df62ca9de263', 'a483d978-c75f-5be9-abe7-2918f5649abe', 'Yu-Tsen Cheng', 'TPE171717', 'individual', 12,
    62.0, 50.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yu-Tsen Cheng (鄭羽岑). Club: 舊城蓮潭帆船隊. Division: .', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c31d00e5-96d5-5566-ba72-a7b6437dc19b', '5a7a191b-3241-5f06-b400-0021abd10fef', 'cd40d57b-bbdd-57cb-8892-df62ca9de263', 'Yu-Tsen Cheng', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a7a191b-3241-5f06-b400-0021abd10fef', 1, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a7a191b-3241-5f06-b400-0021abd10fef', 2, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a7a191b-3241-5f06-b400-0021abd10fef', 3, 12.0, NULL, true, '(12.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a7a191b-3241-5f06-b400-0021abd10fef', 4, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a7a191b-3241-5f06-b400-0021abd10fef', 5, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a7a191b-3241-5f06-b400-0021abd10fef', 6, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
-- Sheet: 115th Academic Year National President's Cup Sailing Regatta 2026 — ILCA 4 (B)
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '8eb5bac6-755e-5aac-a3d8-64e8a8ac6257',
    '38fb8127-ec56-5fa4-bda5-74844ce55a90',
    '115th Academic Year National President''s Cup Sailing Regatta 2026 — ILCA 4 (B)',
    'taiwan-presidents-cup-2026-ilca-4-b-9d82b6',
    '2026-08-16',
    '2026-08-16',
    19,
    'Boys',
    6,
    'TPE',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'Penghu / Tainan, Taiwan',
    'Chinese Taipei Sailing Association (CTSA)',
    'published',
    'https://www.sailwave.com/results/115PresidentCup.htm',
    'CTSA Official Results Sailwave_results_-_成績_-_115總統盃.pdf',
    '115th Academic Year National President''s Cup Sailing Regatta 2026 (115學年度總統盃全國帆船錦標賽). 6 races sailed with 1 discard.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '40a690b3-6a7f-5161-bc16-5f43cb30bf7d', 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4', '8eb5bac6-755e-5aac-a3d8-64e8a8ac6257', 'Chen Yu Kai', 'TPE222236', 'individual', 1,
    7.0, 5.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chen Yu Kai (陳鈺凱). Club: 宜蘭縣帆船委員會. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c1c9ce0a-5ace-5f34-98f8-29fb302294cb', '40a690b3-6a7f-5161-bc16-5f43cb30bf7d', 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4', 'Chen Yu Kai', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40a690b3-6a7f-5161-bc16-5f43cb30bf7d', 1, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40a690b3-6a7f-5161-bc16-5f43cb30bf7d', 2, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40a690b3-6a7f-5161-bc16-5f43cb30bf7d', 3, 2.0, NULL, true, '(2.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40a690b3-6a7f-5161-bc16-5f43cb30bf7d', 4, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40a690b3-6a7f-5161-bc16-5f43cb30bf7d', 5, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '40a690b3-6a7f-5161-bc16-5f43cb30bf7d', 6, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '03ebab1b-66b9-558f-91ab-46dbf0f84e15', '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e', '8eb5bac6-755e-5aac-a3d8-64e8a8ac6257', 'Yeh Chen Yang', 'TPE228160', 'individual', 2,
    31.0, 11.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yeh Chen Yang (葉宸揚). Club: Petit Sailing Team. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f04517c4-8b3a-5348-b25f-203728dfc3fb', '03ebab1b-66b9-558f-91ab-46dbf0f84e15', '077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e', 'Yeh Chen Yang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03ebab1b-66b9-558f-91ab-46dbf0f84e15', 1, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03ebab1b-66b9-558f-91ab-46dbf0f84e15', 2, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03ebab1b-66b9-558f-91ab-46dbf0f84e15', 3, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03ebab1b-66b9-558f-91ab-46dbf0f84e15', 4, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03ebab1b-66b9-558f-91ab-46dbf0f84e15', 5, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03ebab1b-66b9-558f-91ab-46dbf0f84e15', 6, 20.0, 'UFD', true, '(20.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '0783d446-7f29-5062-acf5-48e49b3e7848', '6b018765-b6a9-5682-ada3-f3002829594e', '8eb5bac6-755e-5aac-a3d8-64e8a8ac6257', 'Yong Ray Chuang', '53', 'individual', 3,
    16.0, 13.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yong Ray Chuang (莊永睿). Club: Petit Sailing Team. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '19658a4e-aedb-52dd-ac4f-3366e94425e9', '0783d446-7f29-5062-acf5-48e49b3e7848', '6b018765-b6a9-5682-ada3-f3002829594e', 'Yong Ray Chuang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0783d446-7f29-5062-acf5-48e49b3e7848', 1, 3.0, NULL, true, '(3.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0783d446-7f29-5062-acf5-48e49b3e7848', 2, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0783d446-7f29-5062-acf5-48e49b3e7848', 3, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0783d446-7f29-5062-acf5-48e49b3e7848', 4, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0783d446-7f29-5062-acf5-48e49b3e7848', 5, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0783d446-7f29-5062-acf5-48e49b3e7848', 6, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '0f35ce50-1b2e-5e55-9675-fdbfa8ec0bf7', '44846191-11f2-509c-9168-dbcd34b8e4ee', '8eb5bac6-755e-5aac-a3d8-64e8a8ac6257', 'Dan Lee', 'TPE217710', 'individual', 4,
    26.0, 20.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Dan Lee (李丹). Club: 宜蘭縣帆船委員會. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '13c27fb3-43a1-5803-90a3-623bc24bb1bd', '0f35ce50-1b2e-5e55-9675-fdbfa8ec0bf7', '44846191-11f2-509c-9168-dbcd34b8e4ee', 'Dan Lee', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0f35ce50-1b2e-5e55-9675-fdbfa8ec0bf7', 1, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0f35ce50-1b2e-5e55-9675-fdbfa8ec0bf7', 2, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0f35ce50-1b2e-5e55-9675-fdbfa8ec0bf7', 3, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0f35ce50-1b2e-5e55-9675-fdbfa8ec0bf7', 4, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0f35ce50-1b2e-5e55-9675-fdbfa8ec0bf7', 5, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0f35ce50-1b2e-5e55-9675-fdbfa8ec0bf7', 6, 6.0, NULL, true, '(6.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '59b999f1-4d37-5f1a-8423-7c94360d429a', '6ed1c6b7-6a64-4ce5-9565-ddedf27b12a5', '8eb5bac6-755e-5aac-a3d8-64e8a8ac6257', 'Hao-Ran Hsu', 'TPE225251', 'individual', 5,
    35.0, 27.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Hao-Ran Hsu (徐浩然). Club: 舊城蓮潭帆船隊. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'dbf7c1d1-7c00-5cba-80c5-c8fb3d17acb2', '59b999f1-4d37-5f1a-8423-7c94360d429a', '6ed1c6b7-6a64-4ce5-9565-ddedf27b12a5', 'Hao-Ran Hsu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59b999f1-4d37-5f1a-8423-7c94360d429a', 1, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59b999f1-4d37-5f1a-8423-7c94360d429a', 2, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59b999f1-4d37-5f1a-8423-7c94360d429a', 3, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59b999f1-4d37-5f1a-8423-7c94360d429a', 4, 8.0, NULL, true, '(8.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59b999f1-4d37-5f1a-8423-7c94360d429a', 5, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59b999f1-4d37-5f1a-8423-7c94360d429a', 6, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '28b9ce69-55ab-57f2-a2d6-0f27238e26e3', '1e809bd2-f00a-4c45-84e2-94e7ffc3215b', '8eb5bac6-755e-5aac-a3d8-64e8a8ac6257', 'Cyun-Yan Tai', 'TPE210623', 'individual', 6,
    48.0, 28.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Cyun-Yan Tai (戴群諺). Club: 西門實小基訓站. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0f60a212-1d90-575d-b0c0-913f6cd9afaa', '28b9ce69-55ab-57f2-a2d6-0f27238e26e3', '1e809bd2-f00a-4c45-84e2-94e7ffc3215b', 'Cyun-Yan Tai', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '28b9ce69-55ab-57f2-a2d6-0f27238e26e3', 1, 20.0, 'UFD', true, '(20.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '28b9ce69-55ab-57f2-a2d6-0f27238e26e3', 2, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '28b9ce69-55ab-57f2-a2d6-0f27238e26e3', 3, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '28b9ce69-55ab-57f2-a2d6-0f27238e26e3', 4, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '28b9ce69-55ab-57f2-a2d6-0f27238e26e3', 5, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '28b9ce69-55ab-57f2-a2d6-0f27238e26e3', 6, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '80cc9b3c-010d-5bc4-ab88-230a0b831e1d', 'f661a603-313b-472f-a363-9d58914e04c0', '8eb5bac6-755e-5aac-a3d8-64e8a8ac6257', 'Tzu-Ho Liu', '67', 'individual', 7,
    37.0, 29.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Tzu-Ho Liu (劉子禾). Club: Petit Sailing Team. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f49154c3-8ffa-5148-9331-84d9894d798f', '80cc9b3c-010d-5bc4-ab88-230a0b831e1d', 'f661a603-313b-472f-a363-9d58914e04c0', 'Tzu-Ho Liu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '80cc9b3c-010d-5bc4-ab88-230a0b831e1d', 1, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '80cc9b3c-010d-5bc4-ab88-230a0b831e1d', 2, 8.0, NULL, true, '(8.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '80cc9b3c-010d-5bc4-ab88-230a0b831e1d', 3, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '80cc9b3c-010d-5bc4-ab88-230a0b831e1d', 4, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '80cc9b3c-010d-5bc4-ab88-230a0b831e1d', 5, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '80cc9b3c-010d-5bc4-ab88-230a0b831e1d', 6, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '466836bd-58a2-522f-8f81-cb62126d066b', 'd9fae5c5-d3db-400e-9896-d2d00d7d8d83', '8eb5bac6-755e-5aac-a3d8-64e8a8ac6257', 'Chi-Hsi Lin', 'TPE203017', 'individual', 8,
    40.0, 32.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chi-Hsi Lin (林紀希). Club: 澎湖縣帆船協會. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1c3a1c50-0fb2-5e7f-86de-7b26b461da9e', '466836bd-58a2-522f-8f81-cb62126d066b', 'd9fae5c5-d3db-400e-9896-d2d00d7d8d83', 'Chi-Hsi Lin', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '466836bd-58a2-522f-8f81-cb62126d066b', 1, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '466836bd-58a2-522f-8f81-cb62126d066b', 2, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '466836bd-58a2-522f-8f81-cb62126d066b', 3, 8.0, NULL, true, '(8.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '466836bd-58a2-522f-8f81-cb62126d066b', 4, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '466836bd-58a2-522f-8f81-cb62126d066b', 5, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '466836bd-58a2-522f-8f81-cb62126d066b', 6, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '397d7704-97e8-55e4-9e7a-736e9e275ea9', '086f8230-4b3b-5ce9-a37d-50032114a00d', '8eb5bac6-755e-5aac-a3d8-64e8a8ac6257', 'Hsia-An Wu', 'TPE180471', 'individual', 9,
    63.0, 50.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Hsia-An Wu (吳夏安). Club: 舊城蓮潭帆船隊. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '257a33a7-9db4-55bb-8b3c-28c1aec8771c', '397d7704-97e8-55e4-9e7a-736e9e275ea9', '086f8230-4b3b-5ce9-a37d-50032114a00d', 'Hsia-An Wu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '397d7704-97e8-55e4-9e7a-736e9e275ea9', 1, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '397d7704-97e8-55e4-9e7a-736e9e275ea9', 2, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '397d7704-97e8-55e4-9e7a-736e9e275ea9', 3, 13.0, NULL, true, '(13.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '397d7704-97e8-55e4-9e7a-736e9e275ea9', 4, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '397d7704-97e8-55e4-9e7a-736e9e275ea9', 5, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '397d7704-97e8-55e4-9e7a-736e9e275ea9', 6, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd94cc786-6eed-5651-897b-111e2c81f63a', 'bbc40d80-aedd-5383-8e46-063b2f8cabe0', '8eb5bac6-755e-5aac-a3d8-64e8a8ac6257', 'Ting-Jen Lin', '211961', 'individual', 10,
    68.0, 53.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Ting-Jen Lin (林廷任). Club: 岳明國中小. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'edd2e121-11d6-58f4-9012-4a70142583c6', 'd94cc786-6eed-5651-897b-111e2c81f63a', 'bbc40d80-aedd-5383-8e46-063b2f8cabe0', 'Ting-Jen Lin', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd94cc786-6eed-5651-897b-111e2c81f63a', 1, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd94cc786-6eed-5651-897b-111e2c81f63a', 2, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd94cc786-6eed-5651-897b-111e2c81f63a', 3, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd94cc786-6eed-5651-897b-111e2c81f63a', 4, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd94cc786-6eed-5651-897b-111e2c81f63a', 5, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd94cc786-6eed-5651-897b-111e2c81f63a', 6, 15.0, NULL, true, '(15.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd2205c5d-44f6-5531-bf1d-0301d8eec424', 'ca5a740b-f83f-59ba-9e8c-71171b957085', '8eb5bac6-755e-5aac-a3d8-64e8a8ac6257', 'Cheng-Hsuan Lee', '206219', 'individual', 11,
    66.0, 54.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Cheng-Hsuan Lee (李承軒). Club: 宜蘭縣帆船委員會. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'cef6a4a5-077d-5c73-9531-c550f0a43074', 'd2205c5d-44f6-5531-bf1d-0301d8eec424', 'ca5a740b-f83f-59ba-9e8c-71171b957085', 'Cheng-Hsuan Lee', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd2205c5d-44f6-5531-bf1d-0301d8eec424', 1, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd2205c5d-44f6-5531-bf1d-0301d8eec424', 2, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd2205c5d-44f6-5531-bf1d-0301d8eec424', 3, 12.0, NULL, true, '(12.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd2205c5d-44f6-5531-bf1d-0301d8eec424', 4, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd2205c5d-44f6-5531-bf1d-0301d8eec424', 5, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd2205c5d-44f6-5531-bf1d-0301d8eec424', 6, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '89e06a07-bb55-54d9-8ba7-89ed2fcfb179', 'c2f440b9-b509-59c9-928e-d25c9f722fb3', '8eb5bac6-755e-5aac-a3d8-64e8a8ac6257', 'Hsi-Hsiang Chen', 'P71', 'individual', 12,
    75.0, 57.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Hsi-Hsiang Chen (陳璽翔). Club: 高雄市鹽埕國中. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '776812dd-2843-5bdd-9a59-785bf0be5961', '89e06a07-bb55-54d9-8ba7-89ed2fcfb179', 'c2f440b9-b509-59c9-928e-d25c9f722fb3', 'Hsi-Hsiang Chen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89e06a07-bb55-54d9-8ba7-89ed2fcfb179', 1, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89e06a07-bb55-54d9-8ba7-89ed2fcfb179', 2, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89e06a07-bb55-54d9-8ba7-89ed2fcfb179', 3, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89e06a07-bb55-54d9-8ba7-89ed2fcfb179', 4, 18.0, NULL, true, '(18.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89e06a07-bb55-54d9-8ba7-89ed2fcfb179', 5, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89e06a07-bb55-54d9-8ba7-89ed2fcfb179', 6, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '475d2a9a-028a-566c-9bb5-6ec7025a8e47', '935c9e05-db8b-4d9c-9a5b-960d2e7d5c53', '8eb5bac6-755e-5aac-a3d8-64e8a8ac6257', 'Yu-Hsiang Huang', 'TPE225165', 'individual', 13,
    77.0, 62.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yu-Hsiang Huang (黃昱翔). Club: 西門實小基訓站. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9f2ddd6e-aee6-529f-a548-d063bb84253d', '475d2a9a-028a-566c-9bb5-6ec7025a8e47', '935c9e05-db8b-4d9c-9a5b-960d2e7d5c53', 'Yu-Hsiang Huang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '475d2a9a-028a-566c-9bb5-6ec7025a8e47', 1, 15.0, NULL, true, '(15.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '475d2a9a-028a-566c-9bb5-6ec7025a8e47', 2, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '475d2a9a-028a-566c-9bb5-6ec7025a8e47', 3, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '475d2a9a-028a-566c-9bb5-6ec7025a8e47', 4, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '475d2a9a-028a-566c-9bb5-6ec7025a8e47', 5, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '475d2a9a-028a-566c-9bb5-6ec7025a8e47', 6, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '6ee956f1-5d00-5a31-857d-1a32572f4f4d', '8ff74b8a-c2cc-544f-ada9-17b2f4e44527', '8eb5bac6-755e-5aac-a3d8-64e8a8ac6257', 'Chia-Cheng Chen', '211738', 'individual', 14,
    83.0, 66.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chia-Cheng Chen (陳家程). Club: 岳明國中小. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a16f88ce-eb5a-5f06-ae24-6d2193702528', '6ee956f1-5d00-5a31-857d-1a32572f4f4d', '8ff74b8a-c2cc-544f-ada9-17b2f4e44527', 'Chia-Cheng Chen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ee956f1-5d00-5a31-857d-1a32572f4f4d', 1, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ee956f1-5d00-5a31-857d-1a32572f4f4d', 2, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ee956f1-5d00-5a31-857d-1a32572f4f4d', 3, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ee956f1-5d00-5a31-857d-1a32572f4f4d', 4, 17.0, NULL, true, '(17.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ee956f1-5d00-5a31-857d-1a32572f4f4d', 5, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ee956f1-5d00-5a31-857d-1a32572f4f4d', 6, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'bad17fef-8314-59f9-a0e8-ebfc4369c39e', 'fc743756-eaa4-5d96-9dc9-b9c22ffe845c', '8eb5bac6-755e-5aac-a3d8-64e8a8ac6257', 'Ting-En Lin', 'U1', 'individual', 15,
    86.0, 69.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Ting-En Lin (林廷恩). Club: 岳明國中小. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '8ced8b63-9644-59f6-a8d8-e4b71964c01a', 'bad17fef-8314-59f9-a0e8-ebfc4369c39e', 'fc743756-eaa4-5d96-9dc9-b9c22ffe845c', 'Ting-En Lin', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bad17fef-8314-59f9-a0e8-ebfc4369c39e', 1, 17.0, NULL, true, '(17.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bad17fef-8314-59f9-a0e8-ebfc4369c39e', 2, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bad17fef-8314-59f9-a0e8-ebfc4369c39e', 3, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bad17fef-8314-59f9-a0e8-ebfc4369c39e', 4, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bad17fef-8314-59f9-a0e8-ebfc4369c39e', 5, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bad17fef-8314-59f9-a0e8-ebfc4369c39e', 6, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '9fb997e5-7c21-5f8f-87b5-d15310efc7a0', '3abf7cb1-2d4f-5e3b-857e-85407987d1a9', '8eb5bac6-755e-5aac-a3d8-64e8a8ac6257', 'Yu-Chun Liu', 'TPE225258', 'individual', 16,
    88.0, 69.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yu-Chun Liu (劉宥均). Club: 舊城蓮潭帆船隊. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0e3ccee5-4333-5eab-b7fc-4d5918d33269', '9fb997e5-7c21-5f8f-87b5-d15310efc7a0', '3abf7cb1-2d4f-5e3b-857e-85407987d1a9', 'Yu-Chun Liu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9fb997e5-7c21-5f8f-87b5-d15310efc7a0', 1, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9fb997e5-7c21-5f8f-87b5-d15310efc7a0', 2, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9fb997e5-7c21-5f8f-87b5-d15310efc7a0', 3, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9fb997e5-7c21-5f8f-87b5-d15310efc7a0', 4, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9fb997e5-7c21-5f8f-87b5-d15310efc7a0', 5, 19.0, NULL, true, '(19.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9fb997e5-7c21-5f8f-87b5-d15310efc7a0', 6, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '15988497-813c-567a-b0ab-f283f1128e33', 'd0231a7c-9606-5aa8-8025-fa1500017fcd', '8eb5bac6-755e-5aac-a3d8-64e8a8ac6257', 'Jhen-Syun You', 'TPE173563', 'individual', 17,
    92.0, 74.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Jhen-Syun You (温淯湋). Club: 舊城蓮潭帆船隊. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '63723220-68d3-5113-a2f3-c7772fa61307', '15988497-813c-567a-b0ab-f283f1128e33', 'd0231a7c-9606-5aa8-8025-fa1500017fcd', 'Jhen-Syun You', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15988497-813c-567a-b0ab-f283f1128e33', 1, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15988497-813c-567a-b0ab-f283f1128e33', 2, 18.0, NULL, true, '(18.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15988497-813c-567a-b0ab-f283f1128e33', 3, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15988497-813c-567a-b0ab-f283f1128e33', 4, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15988497-813c-567a-b0ab-f283f1128e33', 5, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15988497-813c-567a-b0ab-f283f1128e33', 6, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e75408e7-261b-5352-9047-d06664b9666a', '604b8e9d-46c9-5dfb-a85a-0398148f64c8', '8eb5bac6-755e-5aac-a3d8-64e8a8ac6257', 'Ho-Yen Chen', 'TPE220704', 'individual', 18,
    93.0, 75.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Ho-Yen Chen (陳和彥). Club: 澎湖縣帆船協會. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0d41ae31-e912-5532-afa1-73f2ab50fe1f', 'e75408e7-261b-5352-9047-d06664b9666a', '604b8e9d-46c9-5dfb-a85a-0398148f64c8', 'Ho-Yen Chen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e75408e7-261b-5352-9047-d06664b9666a', 1, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e75408e7-261b-5352-9047-d06664b9666a', 2, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e75408e7-261b-5352-9047-d06664b9666a', 3, 18.0, NULL, true, '(18.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e75408e7-261b-5352-9047-d06664b9666a', 4, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e75408e7-261b-5352-9047-d06664b9666a', 5, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e75408e7-261b-5352-9047-d06664b9666a', 6, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f9817b22-1ab0-5b8e-b111-35c7a55f4fb6', '4f2b6610-234b-5964-aad9-e14c17a079ff', '8eb5bac6-755e-5aac-a3d8-64e8a8ac6257', 'Yu-Lun Wu', '224989', 'individual', 19,
    111.0, 92.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yu-Lun Wu (吳御綸). Club: 澎湖縣帆船協會. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4b232d45-990b-5815-ae05-f70a9c6c1412', 'f9817b22-1ab0-5b8e-b111-35c7a55f4fb6', '4f2b6610-234b-5964-aad9-e14c17a079ff', 'Yu-Lun Wu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f9817b22-1ab0-5b8e-b111-35c7a55f4fb6', 1, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f9817b22-1ab0-5b8e-b111-35c7a55f4fb6', 2, 19.0, NULL, true, '(19.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f9817b22-1ab0-5b8e-b111-35c7a55f4fb6', 3, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f9817b22-1ab0-5b8e-b111-35c7a55f4fb6', 4, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f9817b22-1ab0-5b8e-b111-35c7a55f4fb6', 5, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f9817b22-1ab0-5b8e-b111-35c7a55f4fb6', 6, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
-- Sheet: 115th Academic Year National President's Cup Sailing Regatta 2026 — ILCA 6 (G)
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    'a1d7d2cb-f2bd-5da0-9bd4-fcf2291de25f',
    '38fb8127-ec56-5fa4-bda5-74844ce55a90',
    '115th Academic Year National President''s Cup Sailing Regatta 2026 — ILCA 6 (G)',
    'taiwan-presidents-cup-2026-ilca-6-g-40b8d1',
    '2026-08-16',
    '2026-08-16',
    9,
    'Girls',
    6,
    'TPE',
    'ILCA 6',
    'individual',
    1,
    1,
    false,
    'Penghu / Tainan, Taiwan',
    'Chinese Taipei Sailing Association (CTSA)',
    'published',
    'https://www.sailwave.com/results/115PresidentCup.htm',
    'CTSA Official Results Sailwave_results_-_成績_-_115總統盃.pdf',
    '115th Academic Year National President''s Cup Sailing Regatta 2026 (115學年度總統盃全國帆船錦標賽). 6 races sailed with 1 discard.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '3ece4ae2-1016-558e-b805-600b46100444', 'e263fbe8-e092-5c21-9677-b7b94f69aaa1', 'a1d7d2cb-f2bd-5da0-9bd4-fcf2291de25f', 'Pin-Chieh Chen', 'TPE206217', 'individual', 1,
    20.0, 12.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Pin-Chieh Chen (陳品潔). Club: 宜蘭縣帆船委員會. Division: 一般組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a4841993-988f-5eea-8ce8-62840106740b', '3ece4ae2-1016-558e-b805-600b46100444', 'e263fbe8-e092-5c21-9677-b7b94f69aaa1', 'Pin-Chieh Chen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3ece4ae2-1016-558e-b805-600b46100444', 1, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3ece4ae2-1016-558e-b805-600b46100444', 2, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3ece4ae2-1016-558e-b805-600b46100444', 3, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3ece4ae2-1016-558e-b805-600b46100444', 4, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3ece4ae2-1016-558e-b805-600b46100444', 5, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3ece4ae2-1016-558e-b805-600b46100444', 6, 8.0, NULL, true, '(8.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '5411c596-25de-5597-bba7-d6fc3de5a6ba', 'e18f1669-26db-522e-bac6-5a5277752a74', 'a1d7d2cb-f2bd-5da0-9bd4-fcf2291de25f', 'Chia-Yi Tsai', 'P1', 'individual', 2,
    18.0, 13.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chia-Yi Tsai (蔡佳倚). Club: 國立中山大學. Division: 大專組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7d19bc83-0ac3-51a2-abdf-06121fe105bd', '5411c596-25de-5597-bba7-d6fc3de5a6ba', 'e18f1669-26db-522e-bac6-5a5277752a74', 'Chia-Yi Tsai', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5411c596-25de-5597-bba7-d6fc3de5a6ba', 1, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5411c596-25de-5597-bba7-d6fc3de5a6ba', 2, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5411c596-25de-5597-bba7-d6fc3de5a6ba', 3, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5411c596-25de-5597-bba7-d6fc3de5a6ba', 4, 5.0, NULL, true, '(5.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5411c596-25de-5597-bba7-d6fc3de5a6ba', 5, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5411c596-25de-5597-bba7-d6fc3de5a6ba', 6, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'fbf592c7-7c6c-5196-af59-345173655b4f', 'd47a1360-502a-5e67-bb6f-a258032b716b', 'a1d7d2cb-f2bd-5da0-9bd4-fcf2291de25f', 'Hehsi（lucy） Huang', 'TPE211718', 'individual', 3,
    23.0, 15.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Hehsi（lucy） Huang (黃禾曦). Club: 宜蘭縣帆船委員會. Division: 一般組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '84766ac9-c79b-53e2-84e5-8b7efb8028cc', 'fbf592c7-7c6c-5196-af59-345173655b4f', 'd47a1360-502a-5e67-bb6f-a258032b716b', 'Hehsi（lucy） Huang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fbf592c7-7c6c-5196-af59-345173655b4f', 1, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fbf592c7-7c6c-5196-af59-345173655b4f', 2, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fbf592c7-7c6c-5196-af59-345173655b4f', 3, 8.0, NULL, true, '(8.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fbf592c7-7c6c-5196-af59-345173655b4f', 4, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fbf592c7-7c6c-5196-af59-345173655b4f', 5, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fbf592c7-7c6c-5196-af59-345173655b4f', 6, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '56bed680-b99a-5949-9060-64e41b27d11e', 'c755dfaa-75cc-4739-8a41-18eafa49dc9d', 'a1d7d2cb-f2bd-5da0-9bd4-fcf2291de25f', 'Kuan-Ying Lee', 'TPE223469', 'individual', 4,
    26.0, 19.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Kuan-Ying Lee (李冠穎). Club: 西門實小基訓站. Division: 大專組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e087e5f1-b3e6-55df-a809-2168b9e158e4', '56bed680-b99a-5949-9060-64e41b27d11e', 'c755dfaa-75cc-4739-8a41-18eafa49dc9d', 'Kuan-Ying Lee', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '56bed680-b99a-5949-9060-64e41b27d11e', 1, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '56bed680-b99a-5949-9060-64e41b27d11e', 2, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '56bed680-b99a-5949-9060-64e41b27d11e', 3, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '56bed680-b99a-5949-9060-64e41b27d11e', 4, 7.0, NULL, true, '(7.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '56bed680-b99a-5949-9060-64e41b27d11e', 5, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '56bed680-b99a-5949-9060-64e41b27d11e', 6, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'fcdb4cb4-3f93-5e5d-b0ce-133143fff456', 'd3979635-ef2f-5ed9-814a-00e7ef627ea0', 'a1d7d2cb-f2bd-5da0-9bd4-fcf2291de25f', 'Tsai-Hsin Yang', 'TPE219715', 'individual', 5,
    25.0, 19.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Tsai-Hsin Yang (楊采昕). Club: 西門實小基訓站. Division: 大專組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e2bdd68b-019a-5895-9932-06279420ef93', 'fcdb4cb4-3f93-5e5d-b0ce-133143fff456', 'd3979635-ef2f-5ed9-814a-00e7ef627ea0', 'Tsai-Hsin Yang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fcdb4cb4-3f93-5e5d-b0ce-133143fff456', 1, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fcdb4cb4-3f93-5e5d-b0ce-133143fff456', 2, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fcdb4cb4-3f93-5e5d-b0ce-133143fff456', 3, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fcdb4cb4-3f93-5e5d-b0ce-133143fff456', 4, 6.0, NULL, true, '(6.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fcdb4cb4-3f93-5e5d-b0ce-133143fff456', 5, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fcdb4cb4-3f93-5e5d-b0ce-133143fff456', 6, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c1201c4b-19f0-5bf9-9041-aca9e856616a', 'bf078d94-b180-5e38-a378-b8ce8a09e797', 'a1d7d2cb-f2bd-5da0-9bd4-fcf2291de25f', 'Tsai-Tien Chien', 'TPE215315', 'individual', 6,
    28.0, 21.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Tsai-Tien Chien (錢采湉). Club: Petit Sailing Team. Division: 大專組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1a37263a-733d-5c7c-b681-563dfef2ac53', 'c1201c4b-19f0-5bf9-9041-aca9e856616a', 'bf078d94-b180-5e38-a378-b8ce8a09e797', 'Tsai-Tien Chien', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1201c4b-19f0-5bf9-9041-aca9e856616a', 1, 7.0, NULL, true, '(7.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1201c4b-19f0-5bf9-9041-aca9e856616a', 2, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1201c4b-19f0-5bf9-9041-aca9e856616a', 3, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1201c4b-19f0-5bf9-9041-aca9e856616a', 4, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1201c4b-19f0-5bf9-9041-aca9e856616a', 5, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1201c4b-19f0-5bf9-9041-aca9e856616a', 6, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'b5f81b6c-291a-5200-b26a-5397882d3973', '2bb09661-11b7-5714-a6b2-a495ed6f517f', 'a1d7d2cb-f2bd-5da0-9bd4-fcf2291de25f', 'Yi San Huang', 'TPE221513', 'individual', 7,
    31.0, 23.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yi San Huang (黃薏珊). Club: Petit Sailing Team. Division: 大專組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '03fd8add-d739-5e4c-9160-fc503d3d0050', 'b5f81b6c-291a-5200-b26a-5397882d3973', '2bb09661-11b7-5714-a6b2-a495ed6f517f', 'Yi San Huang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5f81b6c-291a-5200-b26a-5397882d3973', 1, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5f81b6c-291a-5200-b26a-5397882d3973', 2, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5f81b6c-291a-5200-b26a-5397882d3973', 3, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5f81b6c-291a-5200-b26a-5397882d3973', 4, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5f81b6c-291a-5200-b26a-5397882d3973', 5, 8.0, NULL, true, '(8.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5f81b6c-291a-5200-b26a-5397882d3973', 6, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '2c651c1a-8aa7-52b4-8040-ad52fe9d1d29', 'ee1ccc12-b89b-5d0d-a2e5-c6ab9d390200', 'a1d7d2cb-f2bd-5da0-9bd4-fcf2291de25f', 'Tien Tien', 'TPE225249', 'individual', 8,
    48.0, 38.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Tien Tien (田恬). Club: 舊城蓮潭帆船隊. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a14a9413-5f85-505c-b8f2-f7a3d15bab6c', '2c651c1a-8aa7-52b4-8040-ad52fe9d1d29', 'ee1ccc12-b89b-5d0d-a2e5-c6ab9d390200', 'Tien Tien', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c651c1a-8aa7-52b4-8040-ad52fe9d1d29', 1, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c651c1a-8aa7-52b4-8040-ad52fe9d1d29', 2, 10.0, 'UFD', true, '(10.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c651c1a-8aa7-52b4-8040-ad52fe9d1d29', 3, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c651c1a-8aa7-52b4-8040-ad52fe9d1d29', 4, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c651c1a-8aa7-52b4-8040-ad52fe9d1d29', 5, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c651c1a-8aa7-52b4-8040-ad52fe9d1d29', 6, 8.0, 'DPI', false, '8.0 DPI1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '461ed9b8-75ed-5b36-8d32-81004d4e1272', '892240d1-d33f-5e7d-8c74-b5e7472665a7', 'a1d7d2cb-f2bd-5da0-9bd4-fcf2291de25f', 'Chia-Lun Tsai', 'DNC', 'individual', 9,
    60.0, 50.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chia-Lun Tsai (蔡佳倫). Club: 西門實小基訓站. Division: 大專組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9d374fb2-1aa9-5e5e-ab21-b5b97bc8b7e5', '461ed9b8-75ed-5b36-8d32-81004d4e1272', '892240d1-d33f-5e7d-8c74-b5e7472665a7', 'Chia-Lun Tsai', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '461ed9b8-75ed-5b36-8d32-81004d4e1272', 1, 10.0, 'DNC', true, '(10.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '461ed9b8-75ed-5b36-8d32-81004d4e1272', 2, 10.0, 'DNC', false, '10.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '461ed9b8-75ed-5b36-8d32-81004d4e1272', 3, 10.0, 'DNC', false, '10.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '461ed9b8-75ed-5b36-8d32-81004d4e1272', 4, 10.0, 'DNC', false, '10.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '461ed9b8-75ed-5b36-8d32-81004d4e1272', 5, 10.0, 'DNC', false, '10.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '461ed9b8-75ed-5b36-8d32-81004d4e1272', 6, 10.0, 'DNC', false, '10.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
-- Sheet: 115th Academic Year National President's Cup Sailing Regatta 2026 — ILCA 6 (B)
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    'f3f6f64e-3fd7-5b65-bb4b-f729dc75d4a2',
    '38fb8127-ec56-5fa4-bda5-74844ce55a90',
    '115th Academic Year National President''s Cup Sailing Regatta 2026 — ILCA 6 (B)',
    'taiwan-presidents-cup-2026-ilca-6-b-80c46d',
    '2026-08-16',
    '2026-08-16',
    8,
    'Boys',
    6,
    'TPE',
    'ILCA 6',
    'individual',
    1,
    1,
    false,
    'Penghu / Tainan, Taiwan',
    'Chinese Taipei Sailing Association (CTSA)',
    'published',
    'https://www.sailwave.com/results/115PresidentCup.htm',
    'CTSA Official Results Sailwave_results_-_成績_-_115總統盃.pdf',
    '115th Academic Year National President''s Cup Sailing Regatta 2026 (115學年度總統盃全國帆船錦標賽). 6 races sailed with 1 discard.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd7bd6858-2089-5747-b430-cbb2c190bd25', '0e172325-9574-5be1-8f0a-962445b55a23', 'f3f6f64e-3fd7-5b65-bb4b-f729dc75d4a2', 'Kuan-Ying Lin', 'TPE221517', 'individual', 1,
    13.0, 8.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Kuan-Ying Lin (林冠穎). Club: 台北市體育會帆委會. Division: 大專組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7a8f136f-d343-5c45-b145-5d0b6df81e00', 'd7bd6858-2089-5747-b430-cbb2c190bd25', '0e172325-9574-5be1-8f0a-962445b55a23', 'Kuan-Ying Lin', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd7bd6858-2089-5747-b430-cbb2c190bd25', 1, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd7bd6858-2089-5747-b430-cbb2c190bd25', 2, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd7bd6858-2089-5747-b430-cbb2c190bd25', 3, 5.0, NULL, true, '(5.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd7bd6858-2089-5747-b430-cbb2c190bd25', 4, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd7bd6858-2089-5747-b430-cbb2c190bd25', 5, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd7bd6858-2089-5747-b430-cbb2c190bd25', 6, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '47bbbd6a-a4c9-53a2-9691-7a52ddc1c3cd', '3a8088c8-5adb-5a4f-9dda-bf34404d55e7', 'f3f6f64e-3fd7-5b65-bb4b-f729dc75d4a2', 'Teng-Hsi Yeh', 'TPE225163', 'individual', 2,
    13.0, 9.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Teng-Hsi Yeh (葉騰晰). Club: 個人. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'fea60403-4548-558f-8548-2408ec1f67ad', '47bbbd6a-a4c9-53a2-9691-7a52ddc1c3cd', '3a8088c8-5adb-5a4f-9dda-bf34404d55e7', 'Teng-Hsi Yeh', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '47bbbd6a-a4c9-53a2-9691-7a52ddc1c3cd', 1, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '47bbbd6a-a4c9-53a2-9691-7a52ddc1c3cd', 2, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '47bbbd6a-a4c9-53a2-9691-7a52ddc1c3cd', 3, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '47bbbd6a-a4c9-53a2-9691-7a52ddc1c3cd', 4, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '47bbbd6a-a4c9-53a2-9691-7a52ddc1c3cd', 5, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '47bbbd6a-a4c9-53a2-9691-7a52ddc1c3cd', 6, 4.0, NULL, true, '(4.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '0e503de7-e33d-5661-af5a-0ef253331fdb', '30fc62cd-a394-5f7f-93fa-ace8448becb6', 'f3f6f64e-3fd7-5b65-bb4b-f729dc75d4a2', 'Waixiang Yang', 'TPE221511', 'individual', 3,
    23.0, 16.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Waixiang Yang (楊崴翔). Club: 宜蘭縣帆船委員會. Division: 一般組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '97adafb5-6b3a-5a1a-b69f-92c3dde767d5', '0e503de7-e33d-5661-af5a-0ef253331fdb', '30fc62cd-a394-5f7f-93fa-ace8448becb6', 'Waixiang Yang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0e503de7-e33d-5661-af5a-0ef253331fdb', 1, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0e503de7-e33d-5661-af5a-0ef253331fdb', 2, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0e503de7-e33d-5661-af5a-0ef253331fdb', 3, 7.0, NULL, true, '(7.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0e503de7-e33d-5661-af5a-0ef253331fdb', 4, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0e503de7-e33d-5661-af5a-0ef253331fdb', 5, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0e503de7-e33d-5661-af5a-0ef253331fdb', 6, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '6183a348-6a3a-5716-be82-820a0d0c5946', '041a01c8-5ef3-5dd8-a9a3-cae71af93ab5', 'f3f6f64e-3fd7-5b65-bb4b-f729dc75d4a2', 'Wei-Chi Yang', 'TPE208551', 'individual', 4,
    30.0, 23.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Wei-Chi Yang (楊崴棋). Club: 宜蘭縣帆船委員會. Division: 大專組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0c8f40ff-c688-5483-a6dd-91e485b08ff3', '6183a348-6a3a-5716-be82-820a0d0c5946', '041a01c8-5ef3-5dd8-a9a3-cae71af93ab5', 'Wei-Chi Yang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6183a348-6a3a-5716-be82-820a0d0c5946', 1, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6183a348-6a3a-5716-be82-820a0d0c5946', 2, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6183a348-6a3a-5716-be82-820a0d0c5946', 3, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6183a348-6a3a-5716-be82-820a0d0c5946', 4, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6183a348-6a3a-5716-be82-820a0d0c5946', 5, 7.0, NULL, true, '(7.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6183a348-6a3a-5716-be82-820a0d0c5946', 6, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '7888ee86-d702-51a4-81c0-aac137f63ea9', '274834bb-812d-5609-9908-f3463957d8dc', 'f3f6f64e-3fd7-5b65-bb4b-f729dc75d4a2', 'Yi-Ho Chen', 'TPE211956', 'individual', 5,
    30.0, 24.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yi-Ho Chen (陳翊禾). Club: 宜蘭縣帆船委員會. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd5403347-777e-5cf9-84c8-7a08125a0f73', '7888ee86-d702-51a4-81c0-aac137f63ea9', '274834bb-812d-5609-9908-f3463957d8dc', 'Yi-Ho Chen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7888ee86-d702-51a4-81c0-aac137f63ea9', 1, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7888ee86-d702-51a4-81c0-aac137f63ea9', 2, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7888ee86-d702-51a4-81c0-aac137f63ea9', 3, 6.0, NULL, true, '(6.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7888ee86-d702-51a4-81c0-aac137f63ea9', 4, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7888ee86-d702-51a4-81c0-aac137f63ea9', 5, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7888ee86-d702-51a4-81c0-aac137f63ea9', 6, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c71dbe10-805e-5da5-bbfe-d2ded42d9839', '47c5be42-05bb-5acb-9351-073c5402ea47', 'f3f6f64e-3fd7-5b65-bb4b-f729dc75d4a2', 'Tung-Yen Wang', '3', 'individual', 6,
    34.0, 25.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Tung-Yen Wang (王東彥). Club: 澎湖縣帆船協會. Division: 大專組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd252b60a-90b7-5c5c-8e70-4ccf5db07f7c', 'c71dbe10-805e-5da5-bbfe-d2ded42d9839', '47c5be42-05bb-5acb-9351-073c5402ea47', 'Tung-Yen Wang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c71dbe10-805e-5da5-bbfe-d2ded42d9839', 1, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c71dbe10-805e-5da5-bbfe-d2ded42d9839', 2, 9.0, 'DNC', true, '(9.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c71dbe10-805e-5da5-bbfe-d2ded42d9839', 3, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c71dbe10-805e-5da5-bbfe-d2ded42d9839', 4, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c71dbe10-805e-5da5-bbfe-d2ded42d9839', 5, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c71dbe10-805e-5da5-bbfe-d2ded42d9839', 6, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '09c3a703-acd5-5a93-abf6-7003f3de04b5', 'c0f558e7-1414-56ea-84d8-eb6366ed0c8c', 'f3f6f64e-3fd7-5b65-bb4b-f729dc75d4a2', 'Tzu-Tung Huang', '220019', 'individual', 7,
    37.0, 29.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Tzu-Tung Huang (黃子彤). Club: 高雄市鹽埕國中. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '16f19444-8cf6-5460-b283-3b7c9fb03161', '09c3a703-acd5-5a93-abf6-7003f3de04b5', 'c0f558e7-1414-56ea-84d8-eb6366ed0c8c', 'Tzu-Tung Huang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '09c3a703-acd5-5a93-abf6-7003f3de04b5', 1, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '09c3a703-acd5-5a93-abf6-7003f3de04b5', 2, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '09c3a703-acd5-5a93-abf6-7003f3de04b5', 3, 8.0, NULL, true, '(8.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '09c3a703-acd5-5a93-abf6-7003f3de04b5', 4, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '09c3a703-acd5-5a93-abf6-7003f3de04b5', 5, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '09c3a703-acd5-5a93-abf6-7003f3de04b5', 6, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c500b99b-847c-544a-bb92-5426e6ff02cb', '4938635b-ea3b-4028-a516-4c1d48a4e7a5', 'f3f6f64e-3fd7-5b65-bb4b-f729dc75d4a2', 'Ming-Shuo Chang', 'TPE170427', 'individual', 8,
    39.0, 30.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Ming-Shuo Chang (張洺碩). Club: 澎湖縣帆船協會. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5d614820-f9f5-579c-bb6c-9df34a2744e8', 'c500b99b-847c-544a-bb92-5426e6ff02cb', '4938635b-ea3b-4028-a516-4c1d48a4e7a5', 'Ming-Shuo Chang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c500b99b-847c-544a-bb92-5426e6ff02cb', 1, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c500b99b-847c-544a-bb92-5426e6ff02cb', 2, 9.0, 'UFD', true, '(9.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c500b99b-847c-544a-bb92-5426e6ff02cb', 3, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c500b99b-847c-544a-bb92-5426e6ff02cb', 4, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c500b99b-847c-544a-bb92-5426e6ff02cb', 5, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c500b99b-847c-544a-bb92-5426e6ff02cb', 6, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
-- Sheet: 115th Academic Year National President's Cup Sailing Regatta 2026 — ILCA 7
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '9a6dbf5c-6499-593b-a6b7-51b1b4333e4d',
    '38fb8127-ec56-5fa4-bda5-74844ce55a90',
    '115th Academic Year National President''s Cup Sailing Regatta 2026 — ILCA 7',
    'taiwan-presidents-cup-2026-ilca-7-ef3f10',
    '2026-08-16',
    '2026-08-16',
    10,
    'Open',
    6,
    'TPE',
    'ILCA 7',
    'individual',
    1,
    1,
    false,
    'Penghu / Tainan, Taiwan',
    'Chinese Taipei Sailing Association (CTSA)',
    'published',
    'https://www.sailwave.com/results/115PresidentCup.htm',
    'CTSA Official Results Sailwave_results_-_成績_-_115總統盃.pdf',
    '115th Academic Year National President''s Cup Sailing Regatta 2026 (115學年度總統盃全國帆船錦標賽). 6 races sailed with 1 discard.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '0b6896a8-4ab3-5500-ad0f-e03509c27590', '6a1927b4-9af9-5ca1-aa3a-512511e88263', '9a6dbf5c-6499-593b-a6b7-51b1b4333e4d', 'Yang Huang', 'TPE 209964', 'individual', 1,
    6.0, 5.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yang Huang (黃洋). Club: 個人. Division: 一般組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c87e5fcc-2807-51bc-8e32-8c8d8b58068f', '0b6896a8-4ab3-5500-ad0f-e03509c27590', '6a1927b4-9af9-5ca1-aa3a-512511e88263', 'Yang Huang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b6896a8-4ab3-5500-ad0f-e03509c27590', 1, 1.0, NULL, true, '(1.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b6896a8-4ab3-5500-ad0f-e03509c27590', 2, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b6896a8-4ab3-5500-ad0f-e03509c27590', 3, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b6896a8-4ab3-5500-ad0f-e03509c27590', 4, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b6896a8-4ab3-5500-ad0f-e03509c27590', 5, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b6896a8-4ab3-5500-ad0f-e03509c27590', 6, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f2e9a6c2-5427-51ff-b01a-839b2377e3f9', '6ab02afb-fd98-559c-a6dd-ef7543aa4d1c', '9a6dbf5c-6499-593b-a6b7-51b1b4333e4d', 'Yi Huang', 'TPE217273', 'individual', 2,
    16.0, 12.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yi Huang (黃宜). Club: 宜蘭縣帆船委員會. Division: 大專組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'de2cf6ba-aec7-58d8-b3d2-ae0b014aa8ad', 'f2e9a6c2-5427-51ff-b01a-839b2377e3f9', '6ab02afb-fd98-559c-a6dd-ef7543aa4d1c', 'Yi Huang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f2e9a6c2-5427-51ff-b01a-839b2377e3f9', 1, 4.0, NULL, true, '(4.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f2e9a6c2-5427-51ff-b01a-839b2377e3f9', 2, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f2e9a6c2-5427-51ff-b01a-839b2377e3f9', 3, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f2e9a6c2-5427-51ff-b01a-839b2377e3f9', 4, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f2e9a6c2-5427-51ff-b01a-839b2377e3f9', 5, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f2e9a6c2-5427-51ff-b01a-839b2377e3f9', 6, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '70950ea2-cac6-51f1-8bd3-bc512e8d7756', '27cdb9d1-3035-5a39-b85a-94533038a886', '9a6dbf5c-6499-593b-a6b7-51b1b4333e4d', 'Chen Yu Shin', 'TPE213037', 'individual', 3,
    21.0, 16.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chen Yu Shin (陳鈺新). Club: 宜蘭縣帆船委員會. Division: 高中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '2ceeeca8-3b6d-5fff-b5b4-4ab0b561b206', '70950ea2-cac6-51f1-8bd3-bc512e8d7756', '27cdb9d1-3035-5a39-b85a-94533038a886', 'Chen Yu Shin', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '70950ea2-cac6-51f1-8bd3-bc512e8d7756', 1, 5.0, NULL, true, '(5.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '70950ea2-cac6-51f1-8bd3-bc512e8d7756', 2, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '70950ea2-cac6-51f1-8bd3-bc512e8d7756', 3, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '70950ea2-cac6-51f1-8bd3-bc512e8d7756', 4, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '70950ea2-cac6-51f1-8bd3-bc512e8d7756', 5, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '70950ea2-cac6-51f1-8bd3-bc512e8d7756', 6, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ae22657a-2e20-52d7-ab5b-d0e4bef0def2', '8bf566f5-98b6-5eec-b7fe-e23defb55572', '9a6dbf5c-6499-593b-a6b7-51b1b4333e4d', 'Chia-Che Chang', 'TPE163105', 'individual', 4,
    22.0, 18.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chia-Che Chang (張嘉哲). Club: 桃園市體育會帆委會. Division: 大專組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1a42318f-ecd4-5aa1-8d75-9d6891a2c0aa', 'ae22657a-2e20-52d7-ab5b-d0e4bef0def2', '8bf566f5-98b6-5eec-b7fe-e23defb55572', 'Chia-Che Chang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae22657a-2e20-52d7-ab5b-d0e4bef0def2', 1, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae22657a-2e20-52d7-ab5b-d0e4bef0def2', 2, 4.0, NULL, true, '(4.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae22657a-2e20-52d7-ab5b-d0e4bef0def2', 3, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae22657a-2e20-52d7-ab5b-d0e4bef0def2', 4, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae22657a-2e20-52d7-ab5b-d0e4bef0def2', 5, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae22657a-2e20-52d7-ab5b-d0e4bef0def2', 6, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ff143453-4b80-5524-85c2-97dd5537da40', '4f2280b1-db6c-5673-8c3d-099a056733ab', '9a6dbf5c-6499-593b-a6b7-51b1b4333e4d', 'Lang-Yi Yen', 'TPE203364', 'individual', 5,
    30.0, 24.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Lang-Yi Yen (嚴朗毅). Club: 西門實小基訓站. Division: 大專組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'edb9c3c1-e509-57b4-8b51-0c13bf47afe8', 'ff143453-4b80-5524-85c2-97dd5537da40', '4f2280b1-db6c-5673-8c3d-099a056733ab', 'Lang-Yi Yen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff143453-4b80-5524-85c2-97dd5537da40', 1, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff143453-4b80-5524-85c2-97dd5537da40', 2, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff143453-4b80-5524-85c2-97dd5537da40', 3, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff143453-4b80-5524-85c2-97dd5537da40', 4, 6.0, NULL, true, '(6.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff143453-4b80-5524-85c2-97dd5537da40', 5, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff143453-4b80-5524-85c2-97dd5537da40', 6, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ea982f20-4210-5785-bf54-417ccd280c57', 'dc759d26-e36e-51ac-ac48-94e2ac11c692', '9a6dbf5c-6499-593b-a6b7-51b1b4333e4d', 'Chih-Wei Chang', 'TPE224425', 'individual', 6,
    33.0, 25.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chih-Wei Chang (張志維). Club: 桃園市體育會帆委會. Division: 一般組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'bd6b2a70-01ee-5440-af1f-339a77059d18', 'ea982f20-4210-5785-bf54-417ccd280c57', 'dc759d26-e36e-51ac-ac48-94e2ac11c692', 'Chih-Wei Chang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea982f20-4210-5785-bf54-417ccd280c57', 1, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea982f20-4210-5785-bf54-417ccd280c57', 2, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea982f20-4210-5785-bf54-417ccd280c57', 3, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea982f20-4210-5785-bf54-417ccd280c57', 4, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea982f20-4210-5785-bf54-417ccd280c57', 5, 8.0, NULL, true, '(8.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea982f20-4210-5785-bf54-417ccd280c57', 6, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '25e176ac-479c-5fec-840f-119bb4f5dcdf', 'e33cf953-d1c6-5488-9525-340830ba794f', '9a6dbf5c-6499-593b-a6b7-51b1b4333e4d', 'Chen-Hsiang Chang', 'TPE218856', 'individual', 7,
    45.0, 36.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chen-Hsiang Chang (張楨祥). Club: 個人. Division: 一般組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '001ffa68-56b4-5457-b261-63dabe7a0554', '25e176ac-479c-5fec-840f-119bb4f5dcdf', 'e33cf953-d1c6-5488-9525-340830ba794f', 'Chen-Hsiang Chang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25e176ac-479c-5fec-840f-119bb4f5dcdf', 1, 9.0, NULL, true, '(9.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25e176ac-479c-5fec-840f-119bb4f5dcdf', 2, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25e176ac-479c-5fec-840f-119bb4f5dcdf', 3, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25e176ac-479c-5fec-840f-119bb4f5dcdf', 4, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25e176ac-479c-5fec-840f-119bb4f5dcdf', 5, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25e176ac-479c-5fec-840f-119bb4f5dcdf', 6, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'fffddfa5-639a-5890-ad7d-16b9c52b4faf', 'fb290f51-17a8-5826-8bb4-80748775937d', '9a6dbf5c-6499-593b-a6b7-51b1b4333e4d', 'Chun-Hu Chen', '205952', 'individual', 8,
    50.0, 39.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chun-Hu Chen (陳軍互). Club: 舊城蓮潭帆船隊. Division: 一般組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'fa146058-a036-520d-8123-85f0e6e38255', 'fffddfa5-639a-5890-ad7d-16b9c52b4faf', 'fb290f51-17a8-5826-8bb4-80748775937d', 'Chun-Hu Chen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fffddfa5-639a-5890-ad7d-16b9c52b4faf', 1, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fffddfa5-639a-5890-ad7d-16b9c52b4faf', 2, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fffddfa5-639a-5890-ad7d-16b9c52b4faf', 3, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fffddfa5-639a-5890-ad7d-16b9c52b4faf', 4, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fffddfa5-639a-5890-ad7d-16b9c52b4faf', 5, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fffddfa5-639a-5890-ad7d-16b9c52b4faf', 6, 11.0, 'DNC', true, '(11.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '785cfa85-fcc8-56fe-9f61-8f6e2eb3c214', '07565255-54e5-5231-bf77-f63808f8ea40', '9a6dbf5c-6499-593b-a6b7-51b1b4333e4d', 'Shih-Ying Chen', '224989', 'individual', 9,
    53.0, 42.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Shih-Ying Chen (陳時英). Club: 台北市體育會帆委會. Division: 一般組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b2312609-e449-576b-a941-3c1817b7a365', '785cfa85-fcc8-56fe-9f61-8f6e2eb3c214', '07565255-54e5-5231-bf77-f63808f8ea40', 'Shih-Ying Chen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '785cfa85-fcc8-56fe-9f61-8f6e2eb3c214', 1, 11.0, 'BFD', true, '(11.0 BFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '785cfa85-fcc8-56fe-9f61-8f6e2eb3c214', 2, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '785cfa85-fcc8-56fe-9f61-8f6e2eb3c214', 3, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '785cfa85-fcc8-56fe-9f61-8f6e2eb3c214', 4, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '785cfa85-fcc8-56fe-9f61-8f6e2eb3c214', 5, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '785cfa85-fcc8-56fe-9f61-8f6e2eb3c214', 6, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '512ccc8e-bf1e-5f13-abb4-30da9971ff7d', 'ad90926a-f326-511a-bfd4-6aab27047ac9', '9a6dbf5c-6499-593b-a6b7-51b1b4333e4d', 'Chi-Pao Hsiao', 'L1', 'individual', 10,
    62.0, 51.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chi-Pao Hsiao (蕭棋寶). Club: 舊城蓮潭帆船隊. Division: 大專組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ebd0ef54-1512-545e-9008-09d47903cd2a', '512ccc8e-bf1e-5f13-abb4-30da9971ff7d', 'ad90926a-f326-511a-bfd4-6aab27047ac9', 'Chi-Pao Hsiao', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '512ccc8e-bf1e-5f13-abb4-30da9971ff7d', 1, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '512ccc8e-bf1e-5f13-abb4-30da9971ff7d', 2, 11.0, 'UFD', true, '(11.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '512ccc8e-bf1e-5f13-abb4-30da9971ff7d', 3, 11.0, 'DNC', false, '11.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '512ccc8e-bf1e-5f13-abb4-30da9971ff7d', 4, 11.0, 'DNC', false, '11.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '512ccc8e-bf1e-5f13-abb4-30da9971ff7d', 5, 11.0, 'DNC', false, '11.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '512ccc8e-bf1e-5f13-abb4-30da9971ff7d', 6, 11.0, 'DNC', false, '11.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
-- Sheet: 115th Academic Year National President's Cup Sailing Regatta 2026 — Optimist (G)
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    '7b855483-d7fc-5ad2-8651-92441dd649e1',
    '38fb8127-ec56-5fa4-bda5-74844ce55a90',
    '115th Academic Year National President''s Cup Sailing Regatta 2026 — Optimist (G)',
    'taiwan-presidents-cup-2026-optimist-g-27a325',
    '2026-08-16',
    '2026-08-16',
    28,
    'Girls',
    6,
    'TPE',
    'optimist',
    'individual',
    1,
    1,
    false,
    'Penghu / Tainan, Taiwan',
    'Chinese Taipei Sailing Association (CTSA)',
    'published',
    'https://www.sailwave.com/results/115PresidentCup.htm',
    'CTSA Official Results Sailwave_results_-_成績_-_115總統盃.pdf',
    '115th Academic Year National President''s Cup Sailing Regatta 2026 (115學年度總統盃全國帆船錦標賽). 6 races sailed with 1 discard.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '341aebe5-52a8-55b3-85c6-44442c5e5cd5', 'ba3d436a-6be2-5197-af64-dfcd9fa3cf44', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Yu-Han Kao', 'TPE313', 'individual', 1,
    12.0, 8.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yu-Han Kao (高宇涵). Club: 西門實小帆船隊. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '30371e8e-8a35-5ee3-909a-7aa23dc31a48', '341aebe5-52a8-55b3-85c6-44442c5e5cd5', 'ba3d436a-6be2-5197-af64-dfcd9fa3cf44', 'Yu-Han Kao', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '341aebe5-52a8-55b3-85c6-44442c5e5cd5', 1, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '341aebe5-52a8-55b3-85c6-44442c5e5cd5', 2, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '341aebe5-52a8-55b3-85c6-44442c5e5cd5', 3, 4.0, NULL, true, '(4.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '341aebe5-52a8-55b3-85c6-44442c5e5cd5', 4, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '341aebe5-52a8-55b3-85c6-44442c5e5cd5', 5, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '341aebe5-52a8-55b3-85c6-44442c5e5cd5', 6, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '4f6d6dea-4456-54b3-a3c6-f098a7fde3c6', 'e08a26a2-0a66-49bc-a0c1-f5e5849df216', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Chia-Hsin Chiu', 'TPE377', 'individual', 2,
    13.0, 10.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chia-Hsin Chiu (邱家妡). Club: 西門實小帆船隊. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b31c265c-76d0-57c5-89a2-29bb301134c7', '4f6d6dea-4456-54b3-a3c6-f098a7fde3c6', 'e08a26a2-0a66-49bc-a0c1-f5e5849df216', 'Chia-Hsin Chiu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f6d6dea-4456-54b3-a3c6-f098a7fde3c6', 1, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f6d6dea-4456-54b3-a3c6-f098a7fde3c6', 2, 3.0, NULL, true, '(3.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f6d6dea-4456-54b3-a3c6-f098a7fde3c6', 3, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f6d6dea-4456-54b3-a3c6-f098a7fde3c6', 4, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f6d6dea-4456-54b3-a3c6-f098a7fde3c6', 5, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f6d6dea-4456-54b3-a3c6-f098a7fde3c6', 6, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '2d67ae3f-ae75-5789-8ef5-ac991f6ee275', '1acada38-b48d-5cb1-9016-563f3ae24665', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Huang Yu Chieh', 'TPE326', 'individual', 3,
    30.0, 19.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Huang Yu Chieh (黃宇婕). Club: 西門實小帆船隊. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '52ca8bc2-d7a2-5bd4-8859-3a0d3b1c3a9d', '2d67ae3f-ae75-5789-8ef5-ac991f6ee275', '1acada38-b48d-5cb1-9016-563f3ae24665', 'Huang Yu Chieh', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d67ae3f-ae75-5789-8ef5-ac991f6ee275', 1, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d67ae3f-ae75-5789-8ef5-ac991f6ee275', 2, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d67ae3f-ae75-5789-8ef5-ac991f6ee275', 3, 11.0, NULL, true, '(11.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d67ae3f-ae75-5789-8ef5-ac991f6ee275', 4, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d67ae3f-ae75-5789-8ef5-ac991f6ee275', 5, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d67ae3f-ae75-5789-8ef5-ac991f6ee275', 6, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '13a2bf11-e897-5471-9b3c-e5c7da38429d', '6e4263c5-fa7d-5f0f-ac9f-1889811e809b', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Huang Yu Tzu', 'TPE338', 'individual', 4,
    32.0, 21.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Huang Yu Tzu (黃宇慈). Club: 西門實小帆船隊. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9b5f2d38-cc6f-5395-a326-588a6a2df755', '13a2bf11-e897-5471-9b3c-e5c7da38429d', '6e4263c5-fa7d-5f0f-ac9f-1889811e809b', 'Huang Yu Tzu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '13a2bf11-e897-5471-9b3c-e5c7da38429d', 1, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '13a2bf11-e897-5471-9b3c-e5c7da38429d', 2, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '13a2bf11-e897-5471-9b3c-e5c7da38429d', 3, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '13a2bf11-e897-5471-9b3c-e5c7da38429d', 4, 11.0, NULL, true, '(11.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '13a2bf11-e897-5471-9b3c-e5c7da38429d', 5, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '13a2bf11-e897-5471-9b3c-e5c7da38429d', 6, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c8da7c8b-5c41-5ef7-8e42-28d3e89adeaa', '605abece-e556-4c50-a947-ff64a6792ff4', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Chen You Jhen', 'TPE317', 'individual', 5,
    29.0, 22.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chen You Jhen (陳宥蓁). Club: 西門實小帆船隊. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7e513d27-a3b3-51a3-a633-f558a70a88bb', 'c8da7c8b-5c41-5ef7-8e42-28d3e89adeaa', '605abece-e556-4c50-a947-ff64a6792ff4', 'Chen You Jhen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8da7c8b-5c41-5ef7-8e42-28d3e89adeaa', 1, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8da7c8b-5c41-5ef7-8e42-28d3e89adeaa', 2, 7.0, NULL, true, '(7.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8da7c8b-5c41-5ef7-8e42-28d3e89adeaa', 3, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8da7c8b-5c41-5ef7-8e42-28d3e89adeaa', 4, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8da7c8b-5c41-5ef7-8e42-28d3e89adeaa', 5, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8da7c8b-5c41-5ef7-8e42-28d3e89adeaa', 6, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e4506201-2297-5bf1-a3e4-a1f4b1e629ab', '601073d9-76a1-5384-8eef-8b15a2ba71dd', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Jui-Chun Yeh', 'TPE522', 'individual', 6,
    40.0, 31.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Jui-Chun Yeh (葉芮均). Club: 高雄市. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ebe0d62c-4903-52aa-bdd2-62eaf9b1d687', 'e4506201-2297-5bf1-a3e4-a1f4b1e629ab', '601073d9-76a1-5384-8eef-8b15a2ba71dd', 'Jui-Chun Yeh', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4506201-2297-5bf1-a3e4-a1f4b1e629ab', 1, 9.0, NULL, true, '(9.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4506201-2297-5bf1-a3e4-a1f4b1e629ab', 2, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4506201-2297-5bf1-a3e4-a1f4b1e629ab', 3, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4506201-2297-5bf1-a3e4-a1f4b1e629ab', 4, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4506201-2297-5bf1-a3e4-a1f4b1e629ab', 5, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4506201-2297-5bf1-a3e4-a1f4b1e629ab', 6, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '1fc98367-d648-5677-8899-eab3b912dd31', '8c4d48e7-2178-51f9-be51-63a857d51159', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Shu-Ya Hsu', 'TPE258', 'individual', 7,
    41.0, 31.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Shu-Ya Hsu (許舒雅). Club: 金門帆船協會. Division: .', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd4f2005d-f92b-517f-a966-f484769139f2', '1fc98367-d648-5677-8899-eab3b912dd31', '8c4d48e7-2178-51f9-be51-63a857d51159', 'Shu-Ya Hsu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1fc98367-d648-5677-8899-eab3b912dd31', 1, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1fc98367-d648-5677-8899-eab3b912dd31', 2, 10.0, NULL, true, '(10.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1fc98367-d648-5677-8899-eab3b912dd31', 3, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1fc98367-d648-5677-8899-eab3b912dd31', 4, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1fc98367-d648-5677-8899-eab3b912dd31', 5, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1fc98367-d648-5677-8899-eab3b912dd31', 6, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'b419b5e1-c83f-59ec-912c-ae326a88db01', '06575f3d-3a87-5420-acbc-8693b2325462', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Chen-Yueh Wu', 'TPE329', 'individual', 8,
    67.0, 38.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chen-Yueh Wu (巫晨玥). Club: 西門實小帆船隊. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'eeca579e-7091-5258-b37d-74b95ddb3351', 'b419b5e1-c83f-59ec-912c-ae326a88db01', '06575f3d-3a87-5420-acbc-8693b2325462', 'Chen-Yueh Wu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b419b5e1-c83f-59ec-912c-ae326a88db01', 1, 29.0, 'UFD', true, '(29.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b419b5e1-c83f-59ec-912c-ae326a88db01', 2, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b419b5e1-c83f-59ec-912c-ae326a88db01', 3, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b419b5e1-c83f-59ec-912c-ae326a88db01', 4, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b419b5e1-c83f-59ec-912c-ae326a88db01', 5, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b419b5e1-c83f-59ec-912c-ae326a88db01', 6, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'abe8d090-5e3f-5741-b92f-69bd371858e6', 'b88efdbf-f3bc-550a-907d-812ffe4e17cf', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Chia-Yin Yang', 'TPE319', 'individual', 9,
    55.0, 43.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chia-Yin Yang (楊家茵). Club: 西門實小帆船隊. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c9a895e4-b00b-5cab-942e-94fb3e5b194b', 'abe8d090-5e3f-5741-b92f-69bd371858e6', 'b88efdbf-f3bc-550a-907d-812ffe4e17cf', 'Chia-Yin Yang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'abe8d090-5e3f-5741-b92f-69bd371858e6', 1, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'abe8d090-5e3f-5741-b92f-69bd371858e6', 2, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'abe8d090-5e3f-5741-b92f-69bd371858e6', 3, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'abe8d090-5e3f-5741-b92f-69bd371858e6', 4, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'abe8d090-5e3f-5741-b92f-69bd371858e6', 5, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'abe8d090-5e3f-5741-b92f-69bd371858e6', 6, 12.0, NULL, true, '(12.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '39d77423-3ee4-5e64-9276-7e2167fc2470', '69a37535-3ce6-5411-b57e-ec4857045f7c', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Ai-Jan Lin', 'TPE990', 'individual', 10,
    59.0, 45.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Ai-Jan Lin (林藹然). Club: 宜蘭縣帆船委員會. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0c21977d-8549-5608-8ca6-3693715f4017', '39d77423-3ee4-5e64-9276-7e2167fc2470', '69a37535-3ce6-5411-b57e-ec4857045f7c', 'Ai-Jan Lin', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39d77423-3ee4-5e64-9276-7e2167fc2470', 1, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39d77423-3ee4-5e64-9276-7e2167fc2470', 2, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39d77423-3ee4-5e64-9276-7e2167fc2470', 3, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39d77423-3ee4-5e64-9276-7e2167fc2470', 4, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39d77423-3ee4-5e64-9276-7e2167fc2470', 5, 14.0, NULL, true, '(14.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39d77423-3ee4-5e64-9276-7e2167fc2470', 6, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '146014cc-6e70-510d-874c-6f42fe049bba', '08350803-1171-57de-a0b6-4c9f6f8a4771', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Yun-Yun Chuang', 'TPE772', 'individual', 11,
    58.0, 46.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yun-Yun Chuang (莊昀澐). Club: 舊城蓮潭帆船隊. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd1c0f524-836a-50f2-903c-d60631ecd5be', '146014cc-6e70-510d-874c-6f42fe049bba', '08350803-1171-57de-a0b6-4c9f6f8a4771', 'Yun-Yun Chuang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '146014cc-6e70-510d-874c-6f42fe049bba', 1, 12.0, NULL, true, '(12.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '146014cc-6e70-510d-874c-6f42fe049bba', 2, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '146014cc-6e70-510d-874c-6f42fe049bba', 3, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '146014cc-6e70-510d-874c-6f42fe049bba', 4, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '146014cc-6e70-510d-874c-6f42fe049bba', 5, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '146014cc-6e70-510d-874c-6f42fe049bba', 6, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '63fe0057-98a0-5d78-9464-15fc9a3790a9', '78ac9250-8763-5e62-a94a-e25440100616', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Shan-Ya Lee', 'TPE427', 'individual', 12,
    60.0, 48.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Shan-Ya Lee (李善雅). Club: 舊城蓮潭帆船隊. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ff35e02a-81d0-5050-816e-da7a8cc7c13b', '63fe0057-98a0-5d78-9464-15fc9a3790a9', '78ac9250-8763-5e62-a94a-e25440100616', 'Shan-Ya Lee', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63fe0057-98a0-5d78-9464-15fc9a3790a9', 1, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63fe0057-98a0-5d78-9464-15fc9a3790a9', 2, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63fe0057-98a0-5d78-9464-15fc9a3790a9', 3, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63fe0057-98a0-5d78-9464-15fc9a3790a9', 4, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63fe0057-98a0-5d78-9464-15fc9a3790a9', 5, 12.0, NULL, true, '(12.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63fe0057-98a0-5d78-9464-15fc9a3790a9', 6, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c4378027-3804-5896-893a-bbaf559c74ae', '7a2ac7a7-8764-5d8d-9c0f-9a5e1e175e45', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Pin-Hsuan Huang', 'TPE2010', 'individual', 13,
    80.0, 63.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Pin-Hsuan Huang (黃品瑄). Club: 高雄市鹽埕國中. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0485691d-e117-5bf4-a6a8-78c7582679f3', 'c4378027-3804-5896-893a-bbaf559c74ae', '7a2ac7a7-8764-5d8d-9c0f-9a5e1e175e45', 'Pin-Hsuan Huang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4378027-3804-5896-893a-bbaf559c74ae', 1, 17.0, NULL, true, '(17.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4378027-3804-5896-893a-bbaf559c74ae', 2, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4378027-3804-5896-893a-bbaf559c74ae', 3, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4378027-3804-5896-893a-bbaf559c74ae', 4, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4378027-3804-5896-893a-bbaf559c74ae', 5, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4378027-3804-5896-893a-bbaf559c74ae', 6, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f2944c2d-1a7f-5103-8980-cd55523e5af6', 'd2384e74-ecef-53b2-8006-54f4ccdcbc36', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Shan-Yu Lee', 'TPE773', 'individual', 14,
    85.0, 69.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Shan-Yu Lee (李善羽). Club: 舊城蓮潭帆船隊. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4c5dbd5c-2f5a-5d9e-b6f5-6c4f319f22f5', 'f2944c2d-1a7f-5103-8980-cd55523e5af6', 'd2384e74-ecef-53b2-8006-54f4ccdcbc36', 'Shan-Yu Lee', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f2944c2d-1a7f-5103-8980-cd55523e5af6', 1, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f2944c2d-1a7f-5103-8980-cd55523e5af6', 2, 16.0, NULL, true, '(16.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f2944c2d-1a7f-5103-8980-cd55523e5af6', 3, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f2944c2d-1a7f-5103-8980-cd55523e5af6', 4, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f2944c2d-1a7f-5103-8980-cd55523e5af6', 5, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f2944c2d-1a7f-5103-8980-cd55523e5af6', 6, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'b128a02c-1cf0-567c-90e8-b38ae9bf790f', 'c8ebccc0-3c26-538e-a69f-b7bfb87e61c5', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Ping-Shan Tsai', 'TPE2581', 'individual', 15,
    94.0, 75.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Ping-Shan Tsai (蔡秉珊). Club: 西門實小帆船隊. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9b6605dc-f99d-5967-a58e-d377d2cc68d5', 'b128a02c-1cf0-567c-90e8-b38ae9bf790f', 'c8ebccc0-3c26-538e-a69f-b7bfb87e61c5', 'Ping-Shan Tsai', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b128a02c-1cf0-567c-90e8-b38ae9bf790f', 1, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b128a02c-1cf0-567c-90e8-b38ae9bf790f', 2, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b128a02c-1cf0-567c-90e8-b38ae9bf790f', 3, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b128a02c-1cf0-567c-90e8-b38ae9bf790f', 4, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b128a02c-1cf0-567c-90e8-b38ae9bf790f', 5, 19.0, NULL, true, '(19.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b128a02c-1cf0-567c-90e8-b38ae9bf790f', 6, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '666a03a8-6af5-52c2-96ca-265908f0b4ca', 'c1a03a94-6e78-55f8-a2d7-5b6853cd3f55', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Yi-Ti Lin', 'TPE205', 'individual', 16,
    111.0, 82.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yi-Ti Lin (林伊娣). Club: 岳明國中小. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '637b3c0b-50e0-5031-a85c-2cc16323ef46', '666a03a8-6af5-52c2-96ca-265908f0b4ca', 'c1a03a94-6e78-55f8-a2d7-5b6853cd3f55', 'Yi-Ti Lin', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '666a03a8-6af5-52c2-96ca-265908f0b4ca', 1, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '666a03a8-6af5-52c2-96ca-265908f0b4ca', 2, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '666a03a8-6af5-52c2-96ca-265908f0b4ca', 3, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '666a03a8-6af5-52c2-96ca-265908f0b4ca', 4, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '666a03a8-6af5-52c2-96ca-265908f0b4ca', 5, 29.0, 'DNF', true, '(29.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '666a03a8-6af5-52c2-96ca-265908f0b4ca', 6, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '924e7688-3a82-50eb-ad09-5e40716a04be', '7e9cdcc8-c8b0-588d-b373-043757706939', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Hsun-Wei Lee', 'TPE3581', 'individual', 17,
    108.0, 88.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Hsun-Wei Lee (李薰唯). Club: 西門實小帆船隊. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '42113867-c88e-51e9-b136-6da8f8848bc6', '924e7688-3a82-50eb-ad09-5e40716a04be', '7e9cdcc8-c8b0-588d-b373-043757706939', 'Hsun-Wei Lee', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '924e7688-3a82-50eb-ad09-5e40716a04be', 1, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '924e7688-3a82-50eb-ad09-5e40716a04be', 2, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '924e7688-3a82-50eb-ad09-5e40716a04be', 3, 20.0, NULL, true, '(20.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '924e7688-3a82-50eb-ad09-5e40716a04be', 4, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '924e7688-3a82-50eb-ad09-5e40716a04be', 5, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '924e7688-3a82-50eb-ad09-5e40716a04be', 6, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '97e5d134-84be-53d8-b21d-517d7e8bef6d', '898e5637-3419-5904-860b-cf3db1e6acab', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Chen-Hsuan Hsu', 'TPE7581', 'individual', 18,
    120.0, 91.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chen-Hsuan Hsu (徐晨瑄). Club: 西門實小帆船隊. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e3ae386f-21ea-5a8e-8d1f-d1998507e297', '97e5d134-84be-53d8-b21d-517d7e8bef6d', '898e5637-3419-5904-860b-cf3db1e6acab', 'Chen-Hsuan Hsu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97e5d134-84be-53d8-b21d-517d7e8bef6d', 1, 29.0, 'UFD', true, '(29.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97e5d134-84be-53d8-b21d-517d7e8bef6d', 2, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97e5d134-84be-53d8-b21d-517d7e8bef6d', 3, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97e5d134-84be-53d8-b21d-517d7e8bef6d', 4, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97e5d134-84be-53d8-b21d-517d7e8bef6d', 5, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97e5d134-84be-53d8-b21d-517d7e8bef6d', 6, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '324d6fb6-1675-5679-8030-b1ecabc635b4', '27fd04c9-03a2-5dbc-9c25-075401cb66d1', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'En-Chi Lu', 'TPE517', 'individual', 19,
    124.0, 95.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: En-Chi Lu (魯恩琦). Club: 澎湖縣帆船協會. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '6d66065c-bef6-5ba4-8be7-788b580ee230', '324d6fb6-1675-5679-8030-b1ecabc635b4', '27fd04c9-03a2-5dbc-9c25-075401cb66d1', 'En-Chi Lu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '324d6fb6-1675-5679-8030-b1ecabc635b4', 1, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '324d6fb6-1675-5679-8030-b1ecabc635b4', 2, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '324d6fb6-1675-5679-8030-b1ecabc635b4', 3, 29.0, 'DNC', true, '(29.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '324d6fb6-1675-5679-8030-b1ecabc635b4', 4, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '324d6fb6-1675-5679-8030-b1ecabc635b4', 5, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '324d6fb6-1675-5679-8030-b1ecabc635b4', 6, 29.0, 'UFD', false, '29.0 UFD'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '2b31d3ae-7944-5540-b5b0-be3237274f28', 'fdf1c741-7d7c-57b2-a2ae-ecef43d8ca14', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Szu-Ai Wu', 'TPE201', 'individual', 20,
    127.0, 98.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Szu-Ai Wu (吳思艾). Club: 岳明國中小. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c3c377dc-b460-59e7-9924-8da4128adee1', '2b31d3ae-7944-5540-b5b0-be3237274f28', 'fdf1c741-7d7c-57b2-a2ae-ecef43d8ca14', 'Szu-Ai Wu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b31d3ae-7944-5540-b5b0-be3237274f28', 1, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b31d3ae-7944-5540-b5b0-be3237274f28', 2, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b31d3ae-7944-5540-b5b0-be3237274f28', 3, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b31d3ae-7944-5540-b5b0-be3237274f28', 4, 29.0, 'DNF', true, '(29.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b31d3ae-7944-5540-b5b0-be3237274f28', 5, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b31d3ae-7944-5540-b5b0-be3237274f28', 6, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'decca756-0689-52a5-b79b-9d85014eb42b', '9e435ef8-0d1f-5789-bd82-eab75023cf9d', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Yong Ai Chuang', 'TPE323', 'individual', 21,
    127.0, 102.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yong Ai Chuang (莊永愛). Club: Petit Sailing Team. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3e9aa64a-3cdf-5b70-85ea-10329e46b640', 'decca756-0689-52a5-b79b-9d85014eb42b', '9e435ef8-0d1f-5789-bd82-eab75023cf9d', 'Yong Ai Chuang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'decca756-0689-52a5-b79b-9d85014eb42b', 1, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'decca756-0689-52a5-b79b-9d85014eb42b', 2, 25.0, NULL, true, '(25.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'decca756-0689-52a5-b79b-9d85014eb42b', 3, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'decca756-0689-52a5-b79b-9d85014eb42b', 4, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'decca756-0689-52a5-b79b-9d85014eb42b', 5, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'decca756-0689-52a5-b79b-9d85014eb42b', 6, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '7e1e93cf-b588-5a2e-b24a-89d41978013e', '2930fe0f-f92d-579b-b4ad-e126f189b59b', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Minyun , Yeh', 'TPE115', 'individual', 22,
    133.0, 104.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Minyun , Yeh (葉敏妘). Club: Petit Sailing Team. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7c48bcf9-a414-53ce-ad8f-03ed5c86d4c7', '7e1e93cf-b588-5a2e-b24a-89d41978013e', '2930fe0f-f92d-579b-b4ad-e126f189b59b', 'Minyun , Yeh', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e1e93cf-b588-5a2e-b24a-89d41978013e', 1, 29.0, 'UFD', true, '(29.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e1e93cf-b588-5a2e-b24a-89d41978013e', 2, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e1e93cf-b588-5a2e-b24a-89d41978013e', 3, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e1e93cf-b588-5a2e-b24a-89d41978013e', 4, 29.0, 'DNF', false, '29.0 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e1e93cf-b588-5a2e-b24a-89d41978013e', 5, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e1e93cf-b588-5a2e-b24a-89d41978013e', 6, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'bf0af6c4-cfc1-5a88-8674-a5a8e643726d', '91856758-95b0-51ad-92d4-145092644ee4', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Yu-Chiao Yeh', 'P9', 'individual', 23,
    135.0, 106.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yu-Chiao Yeh (葉雨橋). Club: 舊城蓮潭帆船隊. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'cc404f6c-65a8-51ab-9e03-94e12464e8aa', 'bf0af6c4-cfc1-5a88-8674-a5a8e643726d', '91856758-95b0-51ad-92d4-145092644ee4', 'Yu-Chiao Yeh', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf0af6c4-cfc1-5a88-8674-a5a8e643726d', 1, 29.0, 'UFD', true, '(29.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf0af6c4-cfc1-5a88-8674-a5a8e643726d', 2, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf0af6c4-cfc1-5a88-8674-a5a8e643726d', 3, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf0af6c4-cfc1-5a88-8674-a5a8e643726d', 4, 29.0, 'DNF', false, '29.0 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf0af6c4-cfc1-5a88-8674-a5a8e643726d', 5, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf0af6c4-cfc1-5a88-8674-a5a8e643726d', 6, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '8761ab53-486b-5093-98ea-cf0f35a43bd0', 'a909e581-5406-53d1-a259-1d69c9ac685e', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Hui-Jou Chen', 'TPE526', 'individual', 24,
    136.0, 107.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Hui-Jou Chen (陳慧柔). Club: 澎湖縣帆船協會. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '39569e5d-7395-5c13-bb0e-ce93373de31e', '8761ab53-486b-5093-98ea-cf0f35a43bd0', 'a909e581-5406-53d1-a259-1d69c9ac685e', 'Hui-Jou Chen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8761ab53-486b-5093-98ea-cf0f35a43bd0', 1, 29.0, 'UFD', true, '(29.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8761ab53-486b-5093-98ea-cf0f35a43bd0', 2, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8761ab53-486b-5093-98ea-cf0f35a43bd0', 3, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8761ab53-486b-5093-98ea-cf0f35a43bd0', 4, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8761ab53-486b-5093-98ea-cf0f35a43bd0', 5, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8761ab53-486b-5093-98ea-cf0f35a43bd0', 6, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '3d1012a8-9380-5045-a857-b2bda3a6c348', '8b073b9f-d28e-548c-a2b6-c46c8fc8a4bb', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Mei-Ni Chen', 'P1', 'individual', 25,
    148.0, 119.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Mei-Ni Chen (陳媺霓). Club: 高雄市鹽埕國中. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '695b745a-0c3a-5868-9c38-25e687c858ce', '3d1012a8-9380-5045-a857-b2bda3a6c348', '8b073b9f-d28e-548c-a2b6-c46c8fc8a4bb', 'Mei-Ni Chen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d1012a8-9380-5045-a857-b2bda3a6c348', 1, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d1012a8-9380-5045-a857-b2bda3a6c348', 2, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d1012a8-9380-5045-a857-b2bda3a6c348', 3, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d1012a8-9380-5045-a857-b2bda3a6c348', 4, 29.0, 'DNF', true, '(29.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d1012a8-9380-5045-a857-b2bda3a6c348', 5, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d1012a8-9380-5045-a857-b2bda3a6c348', 6, 29.0, 'UFD', false, '29.0 UFD'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '725c2d7a-f14c-5aec-81bb-1b92f88c0af3', 'b9ac8abe-fd53-5c72-bd25-205a8a936fd6', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Hsuan-Nung Liu', 'TPE1122', 'individual', 26,
    161.0, 132.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Hsuan-Nung Liu (劉暄儂). Club: 慈心華德福. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'cc77249e-610a-5e1f-870d-7e548b08bb76', '725c2d7a-f14c-5aec-81bb-1b92f88c0af3', 'b9ac8abe-fd53-5c72-bd25-205a8a936fd6', 'Hsuan-Nung Liu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '725c2d7a-f14c-5aec-81bb-1b92f88c0af3', 1, 29.0, 'UFD', true, '(29.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '725c2d7a-f14c-5aec-81bb-1b92f88c0af3', 2, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '725c2d7a-f14c-5aec-81bb-1b92f88c0af3', 3, 29.0, 'DNS', false, '29.0 DNS'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '725c2d7a-f14c-5aec-81bb-1b92f88c0af3', 4, 29.0, 'DNF', false, '29.0 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '725c2d7a-f14c-5aec-81bb-1b92f88c0af3', 5, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '725c2d7a-f14c-5aec-81bb-1b92f88c0af3', 6, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '97c02ec9-f44b-54dd-915c-6e68f44dd7d1', '7bd860c8-2451-573b-9f98-ef8d0eb732e1', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Yun-Chen Pan', 'TPE369', 'individual', 27,
    161.0, 132.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yun-Chen Pan (潘畇蓁). Club: 台北市體育會帆委會. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b201a003-4452-5025-8a72-a9eb364d3040', '97c02ec9-f44b-54dd-915c-6e68f44dd7d1', '7bd860c8-2451-573b-9f98-ef8d0eb732e1', 'Yun-Chen Pan', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97c02ec9-f44b-54dd-915c-6e68f44dd7d1', 1, 29.0, 'UFD', true, '(29.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97c02ec9-f44b-54dd-915c-6e68f44dd7d1', 2, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97c02ec9-f44b-54dd-915c-6e68f44dd7d1', 3, 29.0, 'DNC', false, '29.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97c02ec9-f44b-54dd-915c-6e68f44dd7d1', 4, 29.0, 'DNF', false, '29.0 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97c02ec9-f44b-54dd-915c-6e68f44dd7d1', 5, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97c02ec9-f44b-54dd-915c-6e68f44dd7d1', 6, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '1c850387-ce97-58c2-a633-ba24a78fe1cb', 'f35b2033-9efa-59b4-a8a9-7e13c227393f', '7b855483-d7fc-5ad2-8651-92441dd649e1', 'Hui-Yun Chen', 'DNC', 'individual', 28,
    174.0, 145.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Hui-Yun Chen (陳慧云). Club: 澎湖縣帆船協會. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '8b1983ab-1f29-5820-966c-20072ef6e333', '1c850387-ce97-58c2-a633-ba24a78fe1cb', 'f35b2033-9efa-59b4-a8a9-7e13c227393f', 'Hui-Yun Chen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c850387-ce97-58c2-a633-ba24a78fe1cb', 1, 29.0, 'DNC', true, '(29.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c850387-ce97-58c2-a633-ba24a78fe1cb', 2, 29.0, 'DNC', false, '29.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c850387-ce97-58c2-a633-ba24a78fe1cb', 3, 29.0, 'DNC', false, '29.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c850387-ce97-58c2-a633-ba24a78fe1cb', 4, 29.0, 'DNC', false, '29.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c850387-ce97-58c2-a633-ba24a78fe1cb', 5, 29.0, 'DNC', false, '29.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c850387-ce97-58c2-a633-ba24a78fe1cb', 6, 29.0, 'DNC', false, '29.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
-- Sheet: 115th Academic Year National President's Cup Sailing Regatta 2026 — Optimist (B)
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    'e026cddf-ba73-5539-96b9-b40bbe641438',
    '38fb8127-ec56-5fa4-bda5-74844ce55a90',
    '115th Academic Year National President''s Cup Sailing Regatta 2026 — Optimist (B)',
    'taiwan-presidents-cup-2026-optimist-b-d555a4',
    '2026-08-16',
    '2026-08-16',
    44,
    'Boys',
    6,
    'TPE',
    'optimist',
    'individual',
    1,
    1,
    false,
    'Penghu / Tainan, Taiwan',
    'Chinese Taipei Sailing Association (CTSA)',
    'published',
    'https://www.sailwave.com/results/115PresidentCup.htm',
    'CTSA Official Results Sailwave_results_-_成績_-_115總統盃.pdf',
    '115th Academic Year National President''s Cup Sailing Regatta 2026 (115學年度總統盃全國帆船錦標賽). 6 races sailed with 1 discard.',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status,
    updated_at = clock_timestamp();
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'fe130161-5b76-5ba4-83f6-1e0b0410a62f', '6bf21dbb-951a-593f-958a-83e8a1f747f7', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Li-Pan Cheng', 'TPE379', 'individual', 1,
    19.0, 12.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Li-Pan Cheng (鄭立磐). Club: 西門實小帆船隊. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a8d915e0-2c81-5dca-9831-a51d60606ebf', 'fe130161-5b76-5ba4-83f6-1e0b0410a62f', '6bf21dbb-951a-593f-958a-83e8a1f747f7', 'Li-Pan Cheng', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fe130161-5b76-5ba4-83f6-1e0b0410a62f', 1, 7.0, NULL, true, '(7.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fe130161-5b76-5ba4-83f6-1e0b0410a62f', 2, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fe130161-5b76-5ba4-83f6-1e0b0410a62f', 3, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fe130161-5b76-5ba4-83f6-1e0b0410a62f', 4, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fe130161-5b76-5ba4-83f6-1e0b0410a62f', 5, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fe130161-5b76-5ba4-83f6-1e0b0410a62f', 6, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '8271c216-7332-5f59-b46f-4fd83cc76d6a', '88a2fbbe-aab5-574e-8857-17af0d41761b', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Ko-Pang Chen', 'TPE388', 'individual', 2,
    29.0, 18.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Ko-Pang Chen (陳可邦). Club: 西門實小帆船隊. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '947a54f9-8996-5a38-8746-ee80f7026f15', '8271c216-7332-5f59-b46f-4fd83cc76d6a', '88a2fbbe-aab5-574e-8857-17af0d41761b', 'Ko-Pang Chen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8271c216-7332-5f59-b46f-4fd83cc76d6a', 1, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8271c216-7332-5f59-b46f-4fd83cc76d6a', 2, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8271c216-7332-5f59-b46f-4fd83cc76d6a', 3, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8271c216-7332-5f59-b46f-4fd83cc76d6a', 4, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8271c216-7332-5f59-b46f-4fd83cc76d6a', 5, 11.0, NULL, true, '(11.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8271c216-7332-5f59-b46f-4fd83cc76d6a', 6, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '60cab248-e55a-5043-88e0-a9b73cdc8784', 'f01d617a-7ded-4ad3-b8b7-33cedd3339d9', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'You-Shan Liao', 'TPE357', 'individual', 3,
    34.0, 22.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: You-Shan Liao (廖宥善). Club: 西門實小帆船隊. Division: 一般組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0f92a641-41ca-561a-81c1-ce0f32c9dbdd', '60cab248-e55a-5043-88e0-a9b73cdc8784', 'f01d617a-7ded-4ad3-b8b7-33cedd3339d9', 'You-Shan Liao', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '60cab248-e55a-5043-88e0-a9b73cdc8784', 1, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '60cab248-e55a-5043-88e0-a9b73cdc8784', 2, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '60cab248-e55a-5043-88e0-a9b73cdc8784', 3, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '60cab248-e55a-5043-88e0-a9b73cdc8784', 4, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '60cab248-e55a-5043-88e0-a9b73cdc8784', 5, 12.0, NULL, true, '(12.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '60cab248-e55a-5043-88e0-a9b73cdc8784', 6, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f3b3433a-f1a5-562e-b969-c2a6404ca95d', 'fa95f8cf-a1aa-5899-8a7b-a103437ccb66', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Yu-Chen Wu', 'TPE0438', 'individual', 4,
    35.0, 24.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yu-Chen Wu (吳宥辰). Club: 慈心華德福. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'abc07eca-f8f0-56eb-ad5e-1d7e8e72ba83', 'f3b3433a-f1a5-562e-b969-c2a6404ca95d', 'fa95f8cf-a1aa-5899-8a7b-a103437ccb66', 'Yu-Chen Wu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f3b3433a-f1a5-562e-b969-c2a6404ca95d', 1, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f3b3433a-f1a5-562e-b969-c2a6404ca95d', 2, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f3b3433a-f1a5-562e-b969-c2a6404ca95d', 3, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f3b3433a-f1a5-562e-b969-c2a6404ca95d', 4, 11.0, NULL, true, '(11.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f3b3433a-f1a5-562e-b969-c2a6404ca95d', 5, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f3b3433a-f1a5-562e-b969-c2a6404ca95d', 6, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '72f5de69-b959-5b39-9dca-614b17a94977', 'd633d303-0df9-5e24-813e-3b9883b6f5d7', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Ching-Hao Huang', 'TPE7027', 'individual', 5,
    69.0, 24.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Ching-Hao Huang (黃靖皓). Club: 宜蘭縣帆船委員會. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '95d4fa46-e17d-5867-be09-e459c278f14b', '72f5de69-b959-5b39-9dca-614b17a94977', 'd633d303-0df9-5e24-813e-3b9883b6f5d7', 'Ching-Hao Huang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72f5de69-b959-5b39-9dca-614b17a94977', 1, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72f5de69-b959-5b39-9dca-614b17a94977', 2, 45.0, 'UFD', true, '(45.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72f5de69-b959-5b39-9dca-614b17a94977', 3, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72f5de69-b959-5b39-9dca-614b17a94977', 4, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72f5de69-b959-5b39-9dca-614b17a94977', 5, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72f5de69-b959-5b39-9dca-614b17a94977', 6, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '27bbff29-17a8-5fc2-b3d8-b36fadcbd175', '254c367b-6e51-5f0d-aed7-8eb7a5891fee', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Hsin-Yi Chen', 'TPE228', 'individual', 6,
    70.0, 25.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Hsin-Yi Chen (陳信邑). Club: 高雄美國學校. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c64d70f1-2168-5c7b-872c-3fab93641df6', '27bbff29-17a8-5fc2-b3d8-b36fadcbd175', '254c367b-6e51-5f0d-aed7-8eb7a5891fee', 'Hsin-Yi Chen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '27bbff29-17a8-5fc2-b3d8-b36fadcbd175', 1, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '27bbff29-17a8-5fc2-b3d8-b36fadcbd175', 2, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '27bbff29-17a8-5fc2-b3d8-b36fadcbd175', 3, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '27bbff29-17a8-5fc2-b3d8-b36fadcbd175', 4, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '27bbff29-17a8-5fc2-b3d8-b36fadcbd175', 5, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '27bbff29-17a8-5fc2-b3d8-b36fadcbd175', 6, 45.0, 'UFD', true, '(45.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e6dd2aa4-b93b-59eb-b50d-46ef8a04bdc8', 'e08a26a2-0a66-49bc-a0c1-f5e5849df216', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Chia-Hsin Chiu', 'TPE312', 'individual', 7,
    76.0, 31.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chia-Hsin Chiu (邱家煦). Club: 西門實小帆船隊. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9f0c3ad1-d1d5-5b25-9ea1-e5d8786762b4', 'e6dd2aa4-b93b-59eb-b50d-46ef8a04bdc8', 'e08a26a2-0a66-49bc-a0c1-f5e5849df216', 'Chia-Hsin Chiu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6dd2aa4-b93b-59eb-b50d-46ef8a04bdc8', 1, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6dd2aa4-b93b-59eb-b50d-46ef8a04bdc8', 2, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6dd2aa4-b93b-59eb-b50d-46ef8a04bdc8', 3, 45.0, 'DSQ', true, '(45.0 DSQ)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6dd2aa4-b93b-59eb-b50d-46ef8a04bdc8', 4, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6dd2aa4-b93b-59eb-b50d-46ef8a04bdc8', 5, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6dd2aa4-b93b-59eb-b50d-46ef8a04bdc8', 6, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '39a5415c-5956-58ef-a2a7-151c4b5f86f8', '5f06d81b-8f07-519b-b6e0-52afda7684a6', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Tzu-Le Liu', 'TPE336', 'individual', 8,
    45.0, 31.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Tzu-Le Liu (劉子樂). Club: Petit Sailing Team. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1e67777e-f63e-57e1-892f-efb87b47d43d', '39a5415c-5956-58ef-a2a7-151c4b5f86f8', '5f06d81b-8f07-519b-b6e0-52afda7684a6', 'Tzu-Le Liu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39a5415c-5956-58ef-a2a7-151c4b5f86f8', 1, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39a5415c-5956-58ef-a2a7-151c4b5f86f8', 2, 14.0, NULL, true, '(14.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39a5415c-5956-58ef-a2a7-151c4b5f86f8', 3, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39a5415c-5956-58ef-a2a7-151c4b5f86f8', 4, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39a5415c-5956-58ef-a2a7-151c4b5f86f8', 5, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39a5415c-5956-58ef-a2a7-151c4b5f86f8', 6, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '90ed9670-f176-5a51-9618-cbebfc4080a5', '85242f97-5154-5a43-a4b8-2616129bf515', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Chien-Jun Lin', 'TPE304', 'individual', 9,
    48.0, 35.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chien-Jun Lin (林謙潤). Club: 慈心華德福. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4e35e863-e84a-52b1-83da-fe40f9a3f8d9', '90ed9670-f176-5a51-9618-cbebfc4080a5', '85242f97-5154-5a43-a4b8-2616129bf515', 'Chien-Jun Lin', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90ed9670-f176-5a51-9618-cbebfc4080a5', 1, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90ed9670-f176-5a51-9618-cbebfc4080a5', 2, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90ed9670-f176-5a51-9618-cbebfc4080a5', 3, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90ed9670-f176-5a51-9618-cbebfc4080a5', 4, 13.0, NULL, true, '(13.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90ed9670-f176-5a51-9618-cbebfc4080a5', 5, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90ed9670-f176-5a51-9618-cbebfc4080a5', 6, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f752f667-aa4e-5715-b1fd-ed2860b94755', 'f1676640-6736-5ced-aa15-5d34ece931db', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Yu-Heng Kao', 'TPE399', 'individual', 10,
    57.0, 38.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yu-Heng Kao (高宇恒). Club: 西門實小帆船隊. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '024eea85-6a61-58a1-864f-5aca93cb8997', 'f752f667-aa4e-5715-b1fd-ed2860b94755', 'f1676640-6736-5ced-aa15-5d34ece931db', 'Yu-Heng Kao', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f752f667-aa4e-5715-b1fd-ed2860b94755', 1, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f752f667-aa4e-5715-b1fd-ed2860b94755', 2, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f752f667-aa4e-5715-b1fd-ed2860b94755', 3, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f752f667-aa4e-5715-b1fd-ed2860b94755', 4, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f752f667-aa4e-5715-b1fd-ed2860b94755', 5, 19.0, NULL, true, '(19.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f752f667-aa4e-5715-b1fd-ed2860b94755', 6, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'fb8ea5b5-8b22-5ed7-a1d4-54f6bd000f21', '8eb39919-2873-52ba-b924-5caceb21772b', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Ching-Heng Chen', 'TPE305', 'individual', 11,
    90.0, 45.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Ching-Heng Chen (陳靖衡). Club: 慈心華德福. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9dbdb9bb-1821-51a9-8802-7b15c605d07e', 'fb8ea5b5-8b22-5ed7-a1d4-54f6bd000f21', '8eb39919-2873-52ba-b924-5caceb21772b', 'Ching-Heng Chen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fb8ea5b5-8b22-5ed7-a1d4-54f6bd000f21', 1, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fb8ea5b5-8b22-5ed7-a1d4-54f6bd000f21', 2, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fb8ea5b5-8b22-5ed7-a1d4-54f6bd000f21', 3, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fb8ea5b5-8b22-5ed7-a1d4-54f6bd000f21', 4, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fb8ea5b5-8b22-5ed7-a1d4-54f6bd000f21', 5, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fb8ea5b5-8b22-5ed7-a1d4-54f6bd000f21', 6, 45.0, 'UFD', true, '(45.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '544dd11e-2c14-5aca-bd2e-fa1158f7f030', 'aea31e27-b622-557f-84cb-9b21f710ea62', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Yu-En Chou', 'TPE1', 'individual', 12,
    66.0, 53.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yu-En Chou (周宥恩). Club: 高雄市鹽埕國中. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9e718d00-8b64-5a09-a148-6d6757ecaae4', '544dd11e-2c14-5aca-bd2e-fa1158f7f030', 'aea31e27-b622-557f-84cb-9b21f710ea62', 'Yu-En Chou', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '544dd11e-2c14-5aca-bd2e-fa1158f7f030', 1, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '544dd11e-2c14-5aca-bd2e-fa1158f7f030', 2, 13.0, NULL, true, '(13.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '544dd11e-2c14-5aca-bd2e-fa1158f7f030', 3, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '544dd11e-2c14-5aca-bd2e-fa1158f7f030', 4, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '544dd11e-2c14-5aca-bd2e-fa1158f7f030', 5, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '544dd11e-2c14-5aca-bd2e-fa1158f7f030', 6, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '758f38ad-04b0-5991-9cfc-9e77d0c47975', 'c755dfaa-75cc-4739-8a41-18eafa49dc9d', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Kuan-Ying Lee', 'TPE302', 'individual', 13,
    82.0, 57.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Kuan-Ying Lee (蔡政哲). Club: 西門實小帆船隊. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '742f949d-dab9-5dc8-902a-1a65ef02dada', '758f38ad-04b0-5991-9cfc-9e77d0c47975', 'c755dfaa-75cc-4739-8a41-18eafa49dc9d', 'Kuan-Ying Lee', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '758f38ad-04b0-5991-9cfc-9e77d0c47975', 1, 25.0, NULL, true, '(25.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '758f38ad-04b0-5991-9cfc-9e77d0c47975', 2, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '758f38ad-04b0-5991-9cfc-9e77d0c47975', 3, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '758f38ad-04b0-5991-9cfc-9e77d0c47975', 4, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '758f38ad-04b0-5991-9cfc-9e77d0c47975', 5, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '758f38ad-04b0-5991-9cfc-9e77d0c47975', 6, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '056b7fc4-cf19-541b-9118-64f20a5f11bd', '5ffedc80-dc4c-5c6c-832a-dfb8118c82c2', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Chun-Lun Chuang', 'TPE353', 'individual', 14,
    96.0, 70.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chun-Lun Chuang (莊濬綸). Club: 台北市體育會帆委會. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '8ba7729d-d7c6-557a-b3fe-22bbe06b0803', '056b7fc4-cf19-541b-9118-64f20a5f11bd', '5ffedc80-dc4c-5c6c-832a-dfb8118c82c2', 'Chun-Lun Chuang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '056b7fc4-cf19-541b-9118-64f20a5f11bd', 1, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '056b7fc4-cf19-541b-9118-64f20a5f11bd', 2, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '056b7fc4-cf19-541b-9118-64f20a5f11bd', 3, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '056b7fc4-cf19-541b-9118-64f20a5f11bd', 4, 26.0, NULL, true, '(26.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '056b7fc4-cf19-541b-9118-64f20a5f11bd', 5, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '056b7fc4-cf19-541b-9118-64f20a5f11bd', 6, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '8c51b5e7-b0ef-503e-9b57-2f5381cdc2f7', '3abc74d9-167d-5bc9-b5e4-a496ec17a4ed', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Yu-An Chen', 'TPE352', 'individual', 15,
    117.0, 72.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yu-An Chen (陳又安). Club: 台北市體育會帆委會. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '385ce203-1f4c-522d-b26b-c205bf9b9890', '8c51b5e7-b0ef-503e-9b57-2f5381cdc2f7', '3abc74d9-167d-5bc9-b5e4-a496ec17a4ed', 'Yu-An Chen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c51b5e7-b0ef-503e-9b57-2f5381cdc2f7', 1, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c51b5e7-b0ef-503e-9b57-2f5381cdc2f7', 2, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c51b5e7-b0ef-503e-9b57-2f5381cdc2f7', 3, 45.0, 'UFD', true, '(45.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c51b5e7-b0ef-503e-9b57-2f5381cdc2f7', 4, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c51b5e7-b0ef-503e-9b57-2f5381cdc2f7', 5, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8c51b5e7-b0ef-503e-9b57-2f5381cdc2f7', 6, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '435cab6a-9683-5b42-ae7f-c5756d9dbf84', 'd76e6581-d1b0-5211-a72d-88ac7a602f51', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Yung-Yung Chen', 'TPE361', 'individual', 16,
    105.0, 81.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yung-Yung Chen (陳詠詠). Club: 台北市體育會帆委會. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '6544a513-fcdc-5ae0-bc81-00cf2a45426b', '435cab6a-9683-5b42-ae7f-c5756d9dbf84', 'd76e6581-d1b0-5211-a72d-88ac7a602f51', 'Yung-Yung Chen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '435cab6a-9683-5b42-ae7f-c5756d9dbf84', 1, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '435cab6a-9683-5b42-ae7f-c5756d9dbf84', 2, 24.0, NULL, true, '(24.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '435cab6a-9683-5b42-ae7f-c5756d9dbf84', 3, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '435cab6a-9683-5b42-ae7f-c5756d9dbf84', 4, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '435cab6a-9683-5b42-ae7f-c5756d9dbf84', 5, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '435cab6a-9683-5b42-ae7f-c5756d9dbf84', 6, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '77071e57-8501-5faf-b8df-d63178b70066', 'bbe13c8b-4ee2-57fd-af74-84ba978b0bf3', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Chan-Jui Liu', 'TPE771', 'individual', 17,
    111.0, 84.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chan-Jui Liu (劉展睿). Club: 舊城蓮潭帆船隊. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '65f3fe24-d300-5551-8cc2-43a69e1282e8', '77071e57-8501-5faf-b8df-d63178b70066', 'bbe13c8b-4ee2-57fd-af74-84ba978b0bf3', 'Chan-Jui Liu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77071e57-8501-5faf-b8df-d63178b70066', 1, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77071e57-8501-5faf-b8df-d63178b70066', 2, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77071e57-8501-5faf-b8df-d63178b70066', 3, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77071e57-8501-5faf-b8df-d63178b70066', 4, 27.0, NULL, true, '(27.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77071e57-8501-5faf-b8df-d63178b70066', 5, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77071e57-8501-5faf-b8df-d63178b70066', 6, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '92aef25d-1920-5124-800c-fb2436d94668', '42ef2ae2-4817-54ae-b791-c8b9aaea9d53', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Chi-Kang Huang', 'TPE535', 'individual', 18,
    108.0, 85.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chi-Kang Huang (黃佶康). Club: 澎湖縣帆船協會. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '37b1bb77-5ba3-562e-aef1-b3ba47bf9288', '92aef25d-1920-5124-800c-fb2436d94668', '42ef2ae2-4817-54ae-b791-c8b9aaea9d53', 'Chi-Kang Huang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '92aef25d-1920-5124-800c-fb2436d94668', 1, 23.0, NULL, true, '(23.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '92aef25d-1920-5124-800c-fb2436d94668', 2, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '92aef25d-1920-5124-800c-fb2436d94668', 3, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '92aef25d-1920-5124-800c-fb2436d94668', 4, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '92aef25d-1920-5124-800c-fb2436d94668', 5, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '92aef25d-1920-5124-800c-fb2436d94668', 6, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f47afa5e-4b11-5cd8-a62a-908a817ad62d', '7e455f91-5dc1-5764-abf4-63893c88207a', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Yu-Fan Shih', 'TPE7389', 'individual', 19,
    120.0, 91.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yu-Fan Shih (施聿凡). Club: 慈心華德福. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '26d05d10-039a-59f3-ba40-2ca1c3d7ddc3', 'f47afa5e-4b11-5cd8-a62a-908a817ad62d', '7e455f91-5dc1-5764-abf4-63893c88207a', 'Yu-Fan Shih', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f47afa5e-4b11-5cd8-a62a-908a817ad62d', 1, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f47afa5e-4b11-5cd8-a62a-908a817ad62d', 2, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f47afa5e-4b11-5cd8-a62a-908a817ad62d', 3, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f47afa5e-4b11-5cd8-a62a-908a817ad62d', 4, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f47afa5e-4b11-5cd8-a62a-908a817ad62d', 5, 29.0, NULL, true, '(29.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f47afa5e-4b11-5cd8-a62a-908a817ad62d', 6, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f127cdbc-b92b-5ec6-a308-03ae8c07c147', '7b5e9e3f-885d-5e04-9f8b-044cd97414e3', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Yin-Tung Lee', 'TPE525', 'individual', 20,
    128.0, 96.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yin-Tung Lee (李鄞秱). Club: 澎湖縣帆船協會. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f5f6a496-e6bd-51a3-be80-dd3119f181bc', 'f127cdbc-b92b-5ec6-a308-03ae8c07c147', '7b5e9e3f-885d-5e04-9f8b-044cd97414e3', 'Yin-Tung Lee', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f127cdbc-b92b-5ec6-a308-03ae8c07c147', 1, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f127cdbc-b92b-5ec6-a308-03ae8c07c147', 2, 32.0, NULL, true, '(32.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f127cdbc-b92b-5ec6-a308-03ae8c07c147', 3, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f127cdbc-b92b-5ec6-a308-03ae8c07c147', 4, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f127cdbc-b92b-5ec6-a308-03ae8c07c147', 5, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f127cdbc-b92b-5ec6-a308-03ae8c07c147', 6, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c2f89640-2163-5484-8443-d93abe8c2bf0', '0e7373c9-08a9-5ed7-9193-a49820138f4b', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Tai-Cheng Chao', 'TPE017', 'individual', 21,
    123.0, 97.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Tai-Cheng Chao (趙泰程). Club: 高雄市鹽埕國中. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '16c9e27a-9027-53d3-b075-aa3e2bc481a1', 'c2f89640-2163-5484-8443-d93abe8c2bf0', '0e7373c9-08a9-5ed7-9193-a49820138f4b', 'Tai-Cheng Chao', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2f89640-2163-5484-8443-d93abe8c2bf0', 1, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2f89640-2163-5484-8443-d93abe8c2bf0', 2, 26.0, NULL, true, '(26.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2f89640-2163-5484-8443-d93abe8c2bf0', 3, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2f89640-2163-5484-8443-d93abe8c2bf0', 4, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2f89640-2163-5484-8443-d93abe8c2bf0', 5, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2f89640-2163-5484-8443-d93abe8c2bf0', 6, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '0f29cddd-4370-5bfc-92f1-a60cf6987eda', '4c1c8dd4-a538-5a6e-9618-039e3f1e763e', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Wei-Fan Chao', 'TPE1125', 'individual', 22,
    123.0, 98.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Wei-Fan Chao (趙威帆). Club: 個人. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'bed65b1e-b50e-500a-88f0-0d3594cbe04e', '0f29cddd-4370-5bfc-92f1-a60cf6987eda', '4c1c8dd4-a538-5a6e-9618-039e3f1e763e', 'Wei-Fan Chao', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0f29cddd-4370-5bfc-92f1-a60cf6987eda', 1, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0f29cddd-4370-5bfc-92f1-a60cf6987eda', 2, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0f29cddd-4370-5bfc-92f1-a60cf6987eda', 3, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0f29cddd-4370-5bfc-92f1-a60cf6987eda', 4, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0f29cddd-4370-5bfc-92f1-a60cf6987eda', 5, 25.0, NULL, true, '(25.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0f29cddd-4370-5bfc-92f1-a60cf6987eda', 6, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '7451e3a2-44a6-58a3-8e29-9535b9046efe', '2c9932ca-baf4-50d8-81d9-db4b948667db', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Kang-Chun Yeh', 'TPE928', 'individual', 23,
    131.0, 100.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Kang-Chun Yeh (葉罡均). Club: 高雄市. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'da71f12a-7843-5d3d-a958-be3ada146c7a', '7451e3a2-44a6-58a3-8e29-9535b9046efe', '2c9932ca-baf4-50d8-81d9-db4b948667db', 'Kang-Chun Yeh', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7451e3a2-44a6-58a3-8e29-9535b9046efe', 1, 31.0, NULL, true, '(31.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7451e3a2-44a6-58a3-8e29-9535b9046efe', 2, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7451e3a2-44a6-58a3-8e29-9535b9046efe', 3, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7451e3a2-44a6-58a3-8e29-9535b9046efe', 4, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7451e3a2-44a6-58a3-8e29-9535b9046efe', 5, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7451e3a2-44a6-58a3-8e29-9535b9046efe', 6, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'b4bac96e-6aec-5114-91a3-eda1b8b28e37', 'b2c05554-8405-55c8-bcbf-9c8b2e209f90', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Chih-Yu Chen', 'TPE206', 'individual', 24,
    147.0, 102.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chih-Yu Chen (陳志宇). Club: 岳明國中小. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f754b3d9-2d88-5aa4-93c5-a1d0e206940e', 'b4bac96e-6aec-5114-91a3-eda1b8b28e37', 'b2c05554-8405-55c8-bcbf-9c8b2e209f90', 'Chih-Yu Chen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b4bac96e-6aec-5114-91a3-eda1b8b28e37', 1, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b4bac96e-6aec-5114-91a3-eda1b8b28e37', 2, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b4bac96e-6aec-5114-91a3-eda1b8b28e37', 3, 45.0, 'DNC', true, '(45.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b4bac96e-6aec-5114-91a3-eda1b8b28e37', 4, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b4bac96e-6aec-5114-91a3-eda1b8b28e37', 5, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b4bac96e-6aec-5114-91a3-eda1b8b28e37', 6, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '14f2b1c1-67a6-57d3-86ce-5a5feca1fb0d', '23f9e8e0-42ec-5054-bb35-ff2ff4c549dc', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Huang,Shang-Kai (Rocky)', 'TPE0525', 'individual', 25,
    135.0, 108.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Huang,Shang-Kai (Rocky) (黃上愷). Club: Petit Sailing Team. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '08e1731e-23ba-50c0-baa6-564ea0439491', '14f2b1c1-67a6-57d3-86ce-5a5feca1fb0d', '23f9e8e0-42ec-5054-bb35-ff2ff4c549dc', 'Huang,Shang-Kai (Rocky)', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14f2b1c1-67a6-57d3-86ce-5a5feca1fb0d', 1, 27.0, NULL, true, '(27.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14f2b1c1-67a6-57d3-86ce-5a5feca1fb0d', 2, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14f2b1c1-67a6-57d3-86ce-5a5feca1fb0d', 3, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14f2b1c1-67a6-57d3-86ce-5a5feca1fb0d', 4, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14f2b1c1-67a6-57d3-86ce-5a5feca1fb0d', 5, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14f2b1c1-67a6-57d3-86ce-5a5feca1fb0d', 6, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '2aaceb09-f266-50cc-ad50-360dcb7c38aa', '5f830d4c-6d5c-5325-ae75-d9f6b3671839', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Chi-Jui Yeh', 'TPE350', 'individual', 26,
    154.0, 109.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chi-Jui Yeh (葉其叡). Club: 台北市體育會帆委會. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4c145ef6-ff4e-5146-b4a5-99a40480f40d', '2aaceb09-f266-50cc-ad50-360dcb7c38aa', '5f830d4c-6d5c-5325-ae75-d9f6b3671839', 'Chi-Jui Yeh', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2aaceb09-f266-50cc-ad50-360dcb7c38aa', 1, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2aaceb09-f266-50cc-ad50-360dcb7c38aa', 2, 30.0, NULL, false, '30.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2aaceb09-f266-50cc-ad50-360dcb7c38aa', 3, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2aaceb09-f266-50cc-ad50-360dcb7c38aa', 4, 45.0, 'DNF', true, '(45.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2aaceb09-f266-50cc-ad50-360dcb7c38aa', 5, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2aaceb09-f266-50cc-ad50-360dcb7c38aa', 6, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '683eb743-3b4f-58c5-b782-4f4f538b421f', 'c9629945-7f1b-51a9-a04a-b189e950e511', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Chin-Li Lin', 'TPE355', 'individual', 27,
    167.0, 122.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chin-Li Lin (林晉立). Club: 台北市體育會帆委會. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '12c8efbc-67d3-5a56-aef7-e9327195ae05', '683eb743-3b4f-58c5-b782-4f4f538b421f', 'c9629945-7f1b-51a9-a04a-b189e950e511', 'Chin-Li Lin', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '683eb743-3b4f-58c5-b782-4f4f538b421f', 1, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '683eb743-3b4f-58c5-b782-4f4f538b421f', 2, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '683eb743-3b4f-58c5-b782-4f4f538b421f', 3, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '683eb743-3b4f-58c5-b782-4f4f538b421f', 4, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '683eb743-3b4f-58c5-b782-4f4f538b421f', 5, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '683eb743-3b4f-58c5-b782-4f4f538b421f', 6, 45.0, 'UFD', true, '(45.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '5e45b818-d208-55b3-90d9-baacef2fa9bc', '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Huang Chi Fang', 'TPE306', 'individual', 28,
    170.0, 125.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Huang Chi Fang (胡閔皓). Club: 慈心華德福. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '31aa2411-119a-50a7-9688-f0e5f43b1801', '5e45b818-d208-55b3-90d9-baacef2fa9bc', '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24', 'Huang Chi Fang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e45b818-d208-55b3-90d9-baacef2fa9bc', 1, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e45b818-d208-55b3-90d9-baacef2fa9bc', 2, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e45b818-d208-55b3-90d9-baacef2fa9bc', 3, 45.0, 'DNS', true, '(45.0 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e45b818-d208-55b3-90d9-baacef2fa9bc', 4, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e45b818-d208-55b3-90d9-baacef2fa9bc', 5, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5e45b818-d208-55b3-90d9-baacef2fa9bc', 6, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '7efb57f1-718c-530b-aaf1-1198bb46421b', '86b36815-73c2-5333-8a7c-bbb82e3688be', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Chien-Yu Huang', 'TPE351', 'individual', 29,
    163.0, 128.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chien-Yu Huang (黃建宇). Club: 台北市體育會帆委會. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '40d8c53e-600c-55c4-aeb3-101df66b78ab', '7efb57f1-718c-530b-aaf1-1198bb46421b', '86b36815-73c2-5333-8a7c-bbb82e3688be', 'Chien-Yu Huang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7efb57f1-718c-530b-aaf1-1198bb46421b', 1, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7efb57f1-718c-530b-aaf1-1198bb46421b', 2, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7efb57f1-718c-530b-aaf1-1198bb46421b', 3, 31.0, NULL, false, '31.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7efb57f1-718c-530b-aaf1-1198bb46421b', 4, 33.0, NULL, false, '33.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7efb57f1-718c-530b-aaf1-1198bb46421b', 5, 35.0, NULL, true, '(35.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7efb57f1-718c-530b-aaf1-1198bb46421b', 6, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '07333ca8-5835-503c-9864-39da79f07a3a', '4236390e-1f4d-5242-b2eb-e676bd551f60', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Ying-Yu Chen', 'TPE775', 'individual', 30,
    173.0, 128.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Ying-Yu Chen (陳映宇). Club: 舊城蓮潭帆船隊. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '2e0a0e60-0493-583e-8ad5-e9542edbbf06', '07333ca8-5835-503c-9864-39da79f07a3a', '4236390e-1f4d-5242-b2eb-e676bd551f60', 'Ying-Yu Chen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '07333ca8-5835-503c-9864-39da79f07a3a', 1, 45.0, 'UFD', true, '(45.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '07333ca8-5835-503c-9864-39da79f07a3a', 2, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '07333ca8-5835-503c-9864-39da79f07a3a', 3, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '07333ca8-5835-503c-9864-39da79f07a3a', 4, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '07333ca8-5835-503c-9864-39da79f07a3a', 5, 31.0, NULL, false, '31.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '07333ca8-5835-503c-9864-39da79f07a3a', 6, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '31f6322f-d819-5386-9792-60cf830062f5', '72201bba-eca0-5022-bc09-619dd58d66ff', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Yu-Chi Chen', 'TPE202', 'individual', 31,
    192.0, 147.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yu-Chi Chen (陳宥齊). Club: 岳明國中小. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'eea08b0f-4ce4-583d-8c23-93a8213de431', '31f6322f-d819-5386-9792-60cf830062f5', '72201bba-eca0-5022-bc09-619dd58d66ff', 'Yu-Chi Chen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31f6322f-d819-5386-9792-60cf830062f5', 1, 30.0, NULL, false, '30.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31f6322f-d819-5386-9792-60cf830062f5', 2, 45.0, 'UFD', true, '(45.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31f6322f-d819-5386-9792-60cf830062f5', 3, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31f6322f-d819-5386-9792-60cf830062f5', 4, 31.0, NULL, false, '31.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31f6322f-d819-5386-9792-60cf830062f5', 5, 33.0, NULL, false, '33.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31f6322f-d819-5386-9792-60cf830062f5', 6, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e40646dc-f9ff-5fd6-93c1-0a2c5df0558e', 'b1a7dd64-fe8a-5606-9782-3049cdc83425', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Chi-Sheng Chen', 'TPE500', 'individual', 32,
    195.0, 150.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chi-Sheng Chen (陳齊盛). Club: 澎湖縣帆船協會. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ef9a7a32-ea78-524c-be9d-31de3b379774', 'e40646dc-f9ff-5fd6-93c1-0a2c5df0558e', 'b1a7dd64-fe8a-5606-9782-3049cdc83425', 'Chi-Sheng Chen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e40646dc-f9ff-5fd6-93c1-0a2c5df0558e', 1, 39.0, NULL, false, '39.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e40646dc-f9ff-5fd6-93c1-0a2c5df0558e', 2, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e40646dc-f9ff-5fd6-93c1-0a2c5df0558e', 3, 32.0, NULL, false, '32.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e40646dc-f9ff-5fd6-93c1-0a2c5df0558e', 4, 30.0, NULL, false, '30.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e40646dc-f9ff-5fd6-93c1-0a2c5df0558e', 5, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e40646dc-f9ff-5fd6-93c1-0a2c5df0558e', 6, 45.0, 'UFD', true, '(45.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '7d508a96-220f-5fc5-b0a3-c48935c3829f', '6f68806a-c832-5155-87cb-7bed1c3ec1fd', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Chen-Lin Chu', 'TPE4591', 'individual', 33,
    192.0, 154.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chen-Lin Chu (朱宸麟). Club: 西門實小帆船隊. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b989a5dd-9610-5753-b166-6c26771f9a73', '7d508a96-220f-5fc5-b0a3-c48935c3829f', '6f68806a-c832-5155-87cb-7bed1c3ec1fd', 'Chen-Lin Chu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d508a96-220f-5fc5-b0a3-c48935c3829f', 1, 32.0, NULL, false, '32.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d508a96-220f-5fc5-b0a3-c48935c3829f', 2, 33.0, NULL, false, '33.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d508a96-220f-5fc5-b0a3-c48935c3829f', 3, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d508a96-220f-5fc5-b0a3-c48935c3829f', 4, 32.0, NULL, false, '32.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d508a96-220f-5fc5-b0a3-c48935c3829f', 5, 38.0, NULL, true, '(38.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d508a96-220f-5fc5-b0a3-c48935c3829f', 6, 30.0, NULL, false, '30.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'eb271968-2dde-5149-adc6-9fe2875ad312', '5af9588b-6ef2-5b2f-8726-7288ca98dd37', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Chen-Feng Chen', 'TPE555', 'individual', 34,
    201.0, 156.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chen-Feng Chen (陳振豐). Club: 澎湖縣帆船協會. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '8cf2203b-0e7b-5d50-8859-1aa617c32248', 'eb271968-2dde-5149-adc6-9fe2875ad312', '5af9588b-6ef2-5b2f-8726-7288ca98dd37', 'Chen-Feng Chen', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb271968-2dde-5149-adc6-9fe2875ad312', 1, 45.0, 'UFD', true, '(45.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb271968-2dde-5149-adc6-9fe2875ad312', 2, 31.0, NULL, false, '31.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb271968-2dde-5149-adc6-9fe2875ad312', 3, 45.0, 'DNS', false, '45.0 DNS'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb271968-2dde-5149-adc6-9fe2875ad312', 4, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb271968-2dde-5149-adc6-9fe2875ad312', 5, 30.0, NULL, false, '30.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb271968-2dde-5149-adc6-9fe2875ad312', 6, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'faeab3e9-dd17-5c57-945d-f6260dea2ed1', '9de08b25-9cd5-50d4-9e7a-15f082355500', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Fan-En Wu', 'TPE207', 'individual', 35,
    212.0, 167.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Fan-En Wu (吳泛恩). Club: 宜蘭縣帆船委員會. Division: 國中組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c85fc2a3-d1dc-5260-8a66-c98d0e97b7e1', 'faeab3e9-dd17-5c57-945d-f6260dea2ed1', '9de08b25-9cd5-50d4-9e7a-15f082355500', 'Fan-En Wu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'faeab3e9-dd17-5c57-945d-f6260dea2ed1', 1, 34.0, NULL, false, '34.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'faeab3e9-dd17-5c57-945d-f6260dea2ed1', 2, 34.0, NULL, false, '34.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'faeab3e9-dd17-5c57-945d-f6260dea2ed1', 3, 45.0, 'DNS', true, '(45.0 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'faeab3e9-dd17-5c57-945d-f6260dea2ed1', 4, 34.0, NULL, false, '34.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'faeab3e9-dd17-5c57-945d-f6260dea2ed1', 5, 34.0, NULL, false, '34.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'faeab3e9-dd17-5c57-945d-f6260dea2ed1', 6, 31.0, NULL, false, '31.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd077ca28-6d52-51c9-9965-cab94e665e69', '84417cff-bddd-546e-ac5c-324412cb9891', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Yi-Chen Hsu', 'TPE545', 'individual', 36,
    214.0, 169.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yi-Chen Hsu (許竩辰). Club: 澎湖縣帆船協會. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd30522a3-186f-5f49-aef6-a41474a396a3', 'd077ca28-6d52-51c9-9965-cab94e665e69', '84417cff-bddd-546e-ac5c-324412cb9891', 'Yi-Chen Hsu', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd077ca28-6d52-51c9-9965-cab94e665e69', 1, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd077ca28-6d52-51c9-9965-cab94e665e69', 2, 45.0, 'UFD', true, '(45.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd077ca28-6d52-51c9-9965-cab94e665e69', 3, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd077ca28-6d52-51c9-9965-cab94e665e69', 4, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd077ca28-6d52-51c9-9965-cab94e665e69', 5, 32.0, NULL, false, '32.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd077ca28-6d52-51c9-9965-cab94e665e69', 6, 45.0, 'UFD', false, '45.0 UFD'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'fad7c97e-3547-5a7f-b116-11bc7d05d394', '9853539d-7c57-521b-bc4a-b2a6993f19a7', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Chun-Ho Chuang', 'P8', 'individual', 37,
    224.0, 179.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Chun-Ho Chuang (莊浚禾). Club: 舊城蓮潭帆船隊. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd78cb4ed-483d-5819-b881-d626966613f6', 'fad7c97e-3547-5a7f-b116-11bc7d05d394', '9853539d-7c57-521b-bc4a-b2a6993f19a7', 'Chun-Ho Chuang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fad7c97e-3547-5a7f-b116-11bc7d05d394', 1, 38.0, NULL, false, '38.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fad7c97e-3547-5a7f-b116-11bc7d05d394', 2, 45.0, 'UFD', true, '(45.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fad7c97e-3547-5a7f-b116-11bc7d05d394', 3, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fad7c97e-3547-5a7f-b116-11bc7d05d394', 4, 45.0, 'DNF', false, '45.0 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fad7c97e-3547-5a7f-b116-11bc7d05d394', 5, 36.0, NULL, false, '36.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fad7c97e-3547-5a7f-b116-11bc7d05d394', 6, 32.0, NULL, false, '32.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '555db16d-9024-5f07-8172-233e1636c566', 'c26826da-22ca-5c19-a3eb-f900199e637d', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Tzu-An Wang', 'R21', 'individual', 38,
    230.0, 185.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Tzu-An Wang (王子銨). Club: 澎湖縣帆船協會. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5394929b-98a2-5218-8a60-5cb5bb07d5c5', '555db16d-9024-5f07-8172-233e1636c566', 'c26826da-22ca-5c19-a3eb-f900199e637d', 'Tzu-An Wang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '555db16d-9024-5f07-8172-233e1636c566', 1, 36.0, NULL, false, '36.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '555db16d-9024-5f07-8172-233e1636c566', 2, 45.0, 'UFD', true, '(45.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '555db16d-9024-5f07-8172-233e1636c566', 3, 30.0, NULL, false, '30.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '555db16d-9024-5f07-8172-233e1636c566', 4, 45.0, 'DNF', false, '45.0 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '555db16d-9024-5f07-8172-233e1636c566', 5, 41.0, NULL, false, '41.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '555db16d-9024-5f07-8172-233e1636c566', 6, 33.0, NULL, false, '33.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'cb53c05c-d1b6-5205-af32-f1dc98f3dcf1', '8f88d815-3012-5a9e-8630-3e4896575835', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Shih-Cheng Chuang', 'TPE81', 'individual', 39,
    238.0, 193.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Shih-Cheng Chuang (莊詩正). Club: 慈心華德福. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '492495cf-92b2-5947-a39d-e7246a6a7d2b', 'cb53c05c-d1b6-5205-af32-f1dc98f3dcf1', '8f88d815-3012-5a9e-8630-3e4896575835', 'Shih-Cheng Chuang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cb53c05c-d1b6-5205-af32-f1dc98f3dcf1', 1, 37.0, NULL, false, '37.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cb53c05c-d1b6-5205-af32-f1dc98f3dcf1', 2, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cb53c05c-d1b6-5205-af32-f1dc98f3dcf1', 3, 45.0, 'DNC', true, '(45.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cb53c05c-d1b6-5205-af32-f1dc98f3dcf1', 4, 45.0, 'DNF', false, '45.0 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cb53c05c-d1b6-5205-af32-f1dc98f3dcf1', 5, 42.0, NULL, false, '42.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cb53c05c-d1b6-5205-af32-f1dc98f3dcf1', 6, 34.0, NULL, false, '34.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f319375b-d4dc-50cd-a7af-5e2f8da13bfb', '7f05991f-650b-5825-89e3-27d05b8aba9a', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Tao-Yin Tan', 'TPE360', 'individual', 40,
    241.0, 196.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Tao-Yin Tan (覃道胤). Club: 台北市體育會帆委會. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1053da94-2652-59f2-8918-b4667e818677', 'f319375b-d4dc-50cd-a7af-5e2f8da13bfb', '7f05991f-650b-5825-89e3-27d05b8aba9a', 'Tao-Yin Tan', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f319375b-d4dc-50cd-a7af-5e2f8da13bfb', 1, 33.0, NULL, false, '33.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f319375b-d4dc-50cd-a7af-5e2f8da13bfb', 2, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f319375b-d4dc-50cd-a7af-5e2f8da13bfb', 3, 45.0, 'DNC', true, '(45.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f319375b-d4dc-50cd-a7af-5e2f8da13bfb', 4, 45.0, 'DNC', false, '45.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f319375b-d4dc-50cd-a7af-5e2f8da13bfb', 5, 45.0, 'DNC', false, '45.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f319375b-d4dc-50cd-a7af-5e2f8da13bfb', 6, 45.0, 'UFD', false, '45.0 UFD'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '50e3b80a-69f2-5f55-be05-6f4da27f37ed', '0d5a6da7-f86a-5d68-ad55-bb48a4206750', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Yu-Yu Chang', 'TPE6581', 'individual', 41,
    254.0, 209.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yu-Yu Chang (張佑語). Club: 西門實小帆船隊. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1e7ecfa1-0cf8-55bd-92e8-71d402615290', '50e3b80a-69f2-5f55-be05-6f4da27f37ed', '0d5a6da7-f86a-5d68-ad55-bb48a4206750', 'Yu-Yu Chang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50e3b80a-69f2-5f55-be05-6f4da27f37ed', 1, 45.0, 'DNC', true, '(45.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50e3b80a-69f2-5f55-be05-6f4da27f37ed', 2, 45.0, 'RET', false, '45.0 RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50e3b80a-69f2-5f55-be05-6f4da27f37ed', 3, 45.0, 'DNS', false, '45.0 DNS'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50e3b80a-69f2-5f55-be05-6f4da27f37ed', 4, 45.0, 'DNF', false, '45.0 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50e3b80a-69f2-5f55-be05-6f4da27f37ed', 5, 39.0, NULL, false, '39.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50e3b80a-69f2-5f55-be05-6f4da27f37ed', 6, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '960574e4-cfba-50d2-b1e0-c4d6a42fb3a0', 'a1036258-40db-56bc-91e4-219d20c32d19', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Yu-Hsuan Kuo', 'TPE356', 'individual', 42,
    255.0, 210.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yu-Hsuan Kuo (郭侑軒). Club: 台北市體育會帆委會. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '05f833f2-131a-58e6-b9cc-8f8c69fa5bfe', '960574e4-cfba-50d2-b1e0-c4d6a42fb3a0', 'a1036258-40db-56bc-91e4-219d20c32d19', 'Yu-Hsuan Kuo', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '960574e4-cfba-50d2-b1e0-c4d6a42fb3a0', 1, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '960574e4-cfba-50d2-b1e0-c4d6a42fb3a0', 2, 45.0, 'UFD', true, '(45.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '960574e4-cfba-50d2-b1e0-c4d6a42fb3a0', 3, 45.0, 'DNS', false, '45.0 DNS'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '960574e4-cfba-50d2-b1e0-c4d6a42fb3a0', 4, 45.0, 'DNF', false, '45.0 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '960574e4-cfba-50d2-b1e0-c4d6a42fb3a0', 5, 40.0, NULL, false, '40.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '960574e4-cfba-50d2-b1e0-c4d6a42fb3a0', 6, 45.0, 'DNC', false, '45.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e8daf4f2-b02d-5799-b3f8-91c7f96da449', '29179602-7806-5522-a6af-71908371af48', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Fan-Chun Liao', 'TPE358', 'individual', 43,
    262.0, 217.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Fan-Chun Liao (廖凡鈞). Club: 西門實小帆船隊. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '52625b41-fd30-5386-91d3-6e5d2fba9a89', 'e8daf4f2-b02d-5799-b3f8-91c7f96da449', '29179602-7806-5522-a6af-71908371af48', 'Fan-Chun Liao', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8daf4f2-b02d-5799-b3f8-91c7f96da449', 1, 45.0, 'UFD', true, '(45.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8daf4f2-b02d-5799-b3f8-91c7f96da449', 2, 45.0, 'UFD', false, '45.0 UFD'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8daf4f2-b02d-5799-b3f8-91c7f96da449', 3, 45.0, 'DNS', false, '45.0 DNS'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8daf4f2-b02d-5799-b3f8-91c7f96da449', 4, 45.0, 'DNC', false, '45.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8daf4f2-b02d-5799-b3f8-91c7f96da449', 5, 37.0, NULL, false, '37.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8daf4f2-b02d-5799-b3f8-91c7f96da449', 6, 45.0, 'UFD', false, '45.0 UFD'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ef7e8107-b9f4-574a-aae7-6464d72e2b1e', '5a624207-08d4-53e9-8381-42cf361b8e70', 'e026cddf-ba73-5539-96b9-b40bbe641438', 'Yun-Hao Chuang', 'DNC', 'individual', 44,
    270.0, 225.0, false, false, 'https://www.sailwave.com/results/115PresidentCup.htm',
    'http://www.ct-sailing.org.tw/media/k2/attachments/Sailwave_results_-_%E6%88%90%E7%B8%BE_-_115%E7%B8%BD%E7%B5%B1%E7%9B%83.pdf',
    'CTSA 115th President''s Cup Official Results PDF', 'document',
    '115th President''s Cup 2026. Sailor: Yun-Hao Chuang (莊昀昊). Club: 舊城蓮潭帆船隊. Division: 國小組.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9aa1bac0-4ba0-5d5f-9daf-6085563262a3', 'ef7e8107-b9f4-574a-aae7-6464d72e2b1e', '5a624207-08d4-53e9-8381-42cf361b8e70', 'Yun-Hao Chuang', 1, 'solo', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ef7e8107-b9f4-574a-aae7-6464d72e2b1e', 1, 45.0, 'DNC', true, '(45.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ef7e8107-b9f4-574a-aae7-6464d72e2b1e', 2, 45.0, 'DNC', false, '45.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ef7e8107-b9f4-574a-aae7-6464d72e2b1e', 3, 45.0, 'DNC', false, '45.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ef7e8107-b9f4-574a-aae7-6464d72e2b1e', 4, 45.0, 'DNC', false, '45.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ef7e8107-b9f4-574a-aae7-6464d72e2b1e', 5, 45.0, 'DNC', false, '45.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ef7e8107-b9f4-574a-aae7-6464d72e2b1e', 6, 45.0, 'DNC', false, '45.0 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

COMMIT;
