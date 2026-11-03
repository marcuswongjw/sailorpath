-- Migration 175: Import 38th All Japan 420 Class Sailing Championship 2025/2026
--
-- Imports the official national championship results for:
-- Event: 38th All Japan 420 Class Sailing Championship 2025 (第38回全日本420級セーリング選手権大会)
-- Venue: Odotsu Yacht Harbor, Nichinan, Miyazaki Prefecture, Japan
-- Dates: 25 – 28 December 2025
-- Authority: Japan 420 Class Association & Miyazaki Sailing Federation
-- Fleet: 420 (56 boats / 112 sailors), 4 races, 1 discard
--
-- Source: https://www.japan420sailing.org/race_result/2728/ (Official PDF: 【成績表】12月29日 (1).pdf)
--
-- All operations execute in a single atomic transaction.

BEGIN;

-- 1. Insert New Verified Sailor Profiles
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '441d6c8a-a9a0-593d-802d-049a8f1fd156', 'Kaiyo Okada', 'kaiyo-okada-2ccab8', 'JPN 55525', '津工業高校ヨット部', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '45a752b0-180d-52d6-b852-aa2eb2c67c0e', 'Hidero Ito', 'hidero-ito-15024b', 'JPN 55525', '津工業高校ヨット部', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f7e6f592-8675-5009-ab34-321321406034', 'Yuji Nishimura', 'yuji-nishimura-96374e', 'JPN 57546', '霞ヶ浦セーリングチーム', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0fec5c2e-b0ae-5f30-a16c-28530ca3ab5e', 'Hiroto Hayakawa', 'hiroto-hayakawa-628951', 'JPN 57546', '霞ヶ浦セーリングチーム', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd63cc199-98e9-5eb8-91a8-a705dc95d629', 'Ayumu Uchida', 'ayumu-uchida-ed10b3', 'JPN 57009', '葉山町セーリング協会', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '1fe3068b-75d8-5e02-95ed-3091397cb211', 'Izuho Nakagawa', 'izuho-nakagawa-10b83b', 'JPN 57009', '葉山町セーリング協会', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '38d44229-4fc7-573f-84cd-3944fceb584e', 'Towa Hamada', 'towa-hamada-00c384', 'JPN 56403', '日本経済大学/一社)福岡セーリングクラブ', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '75181070-fc83-579d-b3e7-1799959b96e7', 'Sakuya Miyamae', 'sakuya-miyamae-c0cd2b', 'JPN 56403', '日本経済大学/一社)福岡セーリングクラブ', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '925c5c1f-89e3-56b1-a55a-6710f685f836', 'Haru Okada', 'haru-okada-22d7de', 'JPN 57505', '津工業高校ヨット部', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '11bd03db-9007-5300-81f8-626d444978c4', 'Keito Atsumi', 'keito-atsumi-84d019', 'JPN 57505', '津工業高校ヨット部', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c3fd872d-5143-537e-9b7e-6d600698b8d1', 'Daiki Tanaka', 'daiki-tanaka-bd91d8', 'JPN 57109', '山口県セーリング連盟/HOPE', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '01144665-4db3-545e-bda5-3966b8ec7372', 'Yukinaga Kajimura', 'yukinaga-kajimura-c0aa9e', 'JPN 57109', '山口県セーリング連盟/HOPE', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '9f2ade83-cc10-59b4-b806-cb33573e8cb0', 'Kiyoto Yamazaki', 'kiyoto-yamazaki-dacb52', 'JPN 56596', '碧南セーリングクラブ', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2cf54ef6-0276-5f38-bd18-cec0502f3f6c', 'Shota Miyachi', 'shota-miyachi-af149c', 'JPN 56596', '碧南セーリングクラブ', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3992aa68-97b2-5974-8d82-b143cd0accca', 'Misaki Tsunomori', 'misaki-tsunomori-7aa92d', 'JPN 55487', '霞ヶ浦セーリングチーム', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e4ffa42b-42b0-5be2-afd3-793c98a40914', 'Yuma Asano', 'yuma-asano-c59188', 'JPN 55487', '霞ヶ浦セーリングチーム', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2f1f22d2-beb0-5fe9-bc32-926bbaf73ad4', 'Yuto Inoue', 'yuto-inoue-3b965f', 'JPN 55798', '宮崎県立宮崎海洋高等学校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f5d26c55-f669-5a79-8dbc-c4a5d92281bc', 'Kiryue Yoshioka', 'kiryue-yoshioka-bf231f', 'JPN 55798', '宮崎県立宮崎海洋高等学校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '34d229e3-149c-5551-aa98-42ef0798386c', 'Chihiro Tanoue', 'chihiro-tanoue-89a24f', 'JPN 57474', 'NPO SAGA SAILING', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'cf1098b5-824f-5cb8-a1c2-6520bf00f8ac', 'Kokone Imaizumi', 'kokone-imaizumi-371a24', 'JPN 57474', 'NPO SAGA SAILING', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e7c0d225-0597-5c0a-9c12-a52a252b430e', 'Kizuku Otsubo', 'kizuku-otsubo-253f60', 'JPN 57419', 'NPO SAGA SAILING', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c182b857-8088-506d-88aa-785d4e727396', 'Retsu Yonekura', 'retsu-yonekura-791b4a', 'JPN 57419', 'NPO SAGA SAILING', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'cca12153-c55d-5fcd-8af7-c5a32d6310d7', 'Shima Hisamatsu', 'shima-hisamatsu-f5394d', 'JPN 56463', '福岡第一高校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'cf3d0271-ba48-5df7-abe4-580fb98157e2', 'Yu Kuramoto', 'yu-kuramoto-b8e1a3', 'JPN 56463', '福岡第一高校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '1b7b24d6-73be-5e9e-9c3c-d2c547bbf760', 'Ryo Mizusawa', 'ryo-mizusawa-8c870c', 'JPN 56911', '香川県立高松商業高等学校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '169cb109-d93b-5025-a11b-63c1dc290369', 'Kosei Fuchigami', 'kosei-fuchigami-7454ba', 'JPN 56671', '津工業高校ヨット部', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '684c4b0b-448f-51c5-b206-a21a2a683dab', 'Manato Yamazumi', 'manato-yamazumi-fbe199', 'JPN 56671', '津工業高校ヨット部', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '10653959-2270-5a95-bd23-88141dbacd17', 'Kotaro Yamauchi', 'kotaro-yamauchi-00325d', 'JPN 54626', '霞ヶ浦セーリングチーム', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'b557a308-9982-5a4f-939d-b795d07e4caf', 'Yuta Ozaki', 'yuta-ozaki-494f85', 'JPN 56165', '霞ヶ浦セーリングチーム', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ed5112be-81b0-5025-8d6c-c8cfae7f812f', 'Yusei Sakamaki', 'yusei-sakamaki-aa8fc8', 'JPN 56165', '霞ヶ浦セーリングチーム', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ab87ae72-327b-500d-bf59-1b6bde5eb13b', 'Yuyu Aoyama', 'yuyu-aoyama-c06ca6', 'JPN 57100', '葉山町セーリング協会', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '674f9bc2-4a18-5325-b0c5-b50cb0b1d46e', 'Sosuke Inaba', 'sosuke-inaba-199327', 'JPN 57100', '葉山町セーリング協会', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '9273ce46-fe2e-5658-b104-c000d5da8286', 'Hozumi Mitani', 'hozumi-mitani-d9ab86', 'JPN 55827', '葉山町セーリング協会', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'b4561750-5681-54a1-adb0-334c344a3c4f', 'Nanato Iwasaki', 'nanato-iwasaki-f9aa42', 'JPN 55827', '葉山町セーリング協会', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '8344ce9c-8a71-5080-b478-f43ca693f7b8', 'Shinji Zaitsu', 'shinji-zaitsu-91110c', 'JPN 54629', '中村学園三陽高等学校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '79c633a6-1aca-579e-85bb-88aca66357aa', 'Yuto Tanaka', 'yuto-tanaka-4ecb1c', 'JPN 54629', '中村学園三陽高等学校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5b4c86bf-b7c8-57a4-b16a-5c9e221a85a1', 'Maika Ueda', 'maika-ueda-d67c5a', 'JPN 57405', '葉山町セーリング協会', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ac34f6c4-dc1d-5fc7-81b0-1b5003d913ec', 'Naoki Sato', 'naoki-sato-78676a', 'JPN 57405', '葉山町セーリング協会', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '85288ca5-41f1-52be-be6c-a4f9f5a787cc', 'Masanori Takasu', 'masanori-takasu-15361b', 'JPN 57098', '碧南セーリングクラブ', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c50fc291-67e0-5097-8df3-1081f048adb5', 'Ryuji Hirasawa', 'ryuji-hirasawa-8d4419', 'JPN 57098', '碧南セーリングクラブ', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e558d878-1d4a-561c-b152-f209f49a24ff', 'Mifuu Suetsugu', 'mifuu-suetsugu-40c397', 'JPN 55907', '山口県セーリング連盟', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '66a5e779-d9e8-5bda-b019-565da87861ea', 'Komei Katsui', 'komei-katsui-93988c', 'JPN 55907', '山口県セーリング連盟', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e09f7ecb-f03a-5cc0-bbf7-38f2c588cf6a', 'Yuka Kubota', 'yuka-kubota-b72eb5', 'JPN 57473', 'NPO SAGA SAILING', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c9df16c6-c1ef-5b35-a9e2-8b70baebc19c', 'Yumi Miyaguchi', 'yumi-miyaguchi-9ac0ef', 'JPN 57473', 'NPO SAGA SAILING', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '78c93af4-8cfa-52d1-8fd9-e2643b4d9db9', 'Daisuke Mori', 'daisuke-mori-d6b09c', 'JPN 55067', '日南振徳高校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '6636796c-c012-55c6-9fd5-9e54f8e20460', 'Eishin Itai', 'eishin-itai-ace0fa', 'JPN 55067', '日南振徳高校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3145be8a-1ad8-5ab5-ab0d-34cbed017610', 'Haruka Kano', 'haruka-kano-c6e292', 'JPN 55627', '長崎工業高等学校ヨット部OG', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '99e4ee3e-a20d-5a0d-a09b-8bb263d4d9a3', 'Mio Takahira', 'mio-takahira-e4cdb3', 'JPN 55627', '長崎工業高等学校ヨット部OG', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'b7a47cb4-ad60-53c3-9dce-2684de9af2b2', 'Sorata Uozumi', 'sorata-uozumi-c539bf', 'JPN 55583', '中村学園三陽高等学校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3541c249-2178-500b-a7bf-f7e8214828b4', 'Kihei Sadamune', 'kihei-sadamune-260d33', 'JPN 55583', '中村学園三陽高等学校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '672d2b03-be0a-57b8-8e50-2fe3a72a195a', 'Seiya Shiraishi', 'seiya-shiraishi-e78897', 'JPN 55928', '江の島ヨットクラブジュニア', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '214f82fe-8d5a-5467-ad7d-91538135ca86', 'Koyo Nishimura', 'koyo-nishimura-b3cb4d', 'JPN 55928', '江の島ヨットクラブジュニア', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '184cb967-064c-58d0-a7aa-f4362ce3c950', 'Eri Fukushima', 'eri-fukushima-796065', 'JPN 57354', '津工業高校ヨット部', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '37152a7b-3aa1-55af-9ff5-103b68dea907', 'Yoshimi Sasaki', 'yoshimi-sasaki-1c4150', 'JPN 57354', '津工業高校ヨット部', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3b742466-9ff9-5295-986b-7974dc96f0ba', 'Soichiro Seki', 'soichiro-seki-cfa427', 'JPN 57106', '江の島ヨットクラブジュニア', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '573185b0-234c-5dd6-83dd-29c1daf6736c', 'Koki Yamashita', 'koki-yamashita-a65c05', 'JPN 57106', '江の島ヨットクラブジュニア', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3fcebe88-f7a2-5234-aa87-d688b978158f', 'Aoi Isobe', 'aoi-isobe-6797d4', 'JPN 54410', '山口県セーリング連盟', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4c1ab070-ee5b-5f9d-92d5-0d1e5cd3b20b', 'Konatsu Aminaga', 'konatsu-aminaga-21ad75', 'JPN 54410', '山口県セーリング連盟', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f7c9fe3d-938d-5727-8a55-a762cc6ac182', 'Ayana Isaka', 'ayana-isaka-b115e1', 'JPN 55009', '霞ヶ浦セーリングチーム', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7a4f33a3-da1e-5f14-bc7e-6d91cf5b3cf7', 'Nina Suzuki', 'nina-suzuki-652028', 'JPN 57467', '碧南セーリングクラブ', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'eaa5559e-5c82-532a-83f1-80f821e8b7ec', 'Sora Miura', 'sora-miura-1845b7', 'JPN 57467', '碧南セーリングクラブ', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'b31b43ab-ba2d-5092-becf-af04512bbdcc', 'Seina Kawachi', 'seina-kawachi-46425b', 'JPN 55697', '香川県立高松商業高等学校', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2b487173-a438-5151-bf61-9705138e5904', 'Momoha Ueda', 'momoha-ueda-6c4419', 'JPN 55697', '香川県立高松商業高等学校', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e9a1206b-cbd9-575f-a3e7-e96ec592642a', 'Ruichi Nakano', 'ruichi-nakano-719644', 'JPN 56749', '和歌山県セーリング連盟', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '56aa5cdf-6528-569b-a40d-3bd000b0572b', 'Takumi Ito', 'takumi-ito-ccb9bc', 'JPN 56749', '和歌山県セーリング連盟', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '25aaa20d-9cc7-53fe-a5a0-d1b5f5f61756', 'Shota Fujimoto', 'shota-fujimoto-01c284', 'JPN 55797', '日南振徳高校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7a923b39-26a8-5578-a29f-e843d74d1a2e', 'Riku Fujishita', 'riku-fujishita-0d3138', 'JPN 55797', '日南振徳高校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'eafb6b18-a37b-5a4b-9f73-3c8ab78cc299', 'Hyotaro Azema', 'hyotaro-azema-3dcb5e', 'JPN 56004', '碧南セーリングクラブ', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '1532f901-2a00-52d5-bc2b-82ca623c9b2c', 'Gen Uchida', 'gen-uchida-08c0a1', 'JPN 56004', '碧南セーリングクラブ', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '55676ff5-7075-5d6e-8aed-f25449467fe6', 'Ruri Nakayama', 'ruri-nakayama-79c3a0', 'JPN 56961', '福岡第一高校/一社)福岡セーリングクラブ', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'b88da980-dc3f-5a38-a2fe-c5698c803009', 'Hiro Kashio', 'hiro-kashio-d3ddf2', 'JPN 56716', '和歌山県セーリング連盟', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0472a38c-d6d0-5262-b784-e132e38a0f63', 'Naruo Wada', 'naruo-wada-74665a', 'JPN 56716', '和歌山県セーリング連盟', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0a103a01-a892-5c7f-a671-634fa5565dc9', 'Ibuki Watanabe', 'ibuki-watanabe-247140', 'JPN 55936', '津工業高校ヨット部', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c9828880-ea2f-56c6-a0f2-7d8c00d85c6b', 'Shiryu Fujioka', 'shiryu-fujioka-3833cb', 'JPN 55936', '津工業高校ヨット部', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '8a01c3d7-068f-5199-8a29-1f7dcd259ffe', 'Kotaro Kanezaki', 'kotaro-kanezaki-fd1176', 'JPN 54624', '中村学園三陽高等学校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'fbb34bd5-4d5a-5c61-9df1-eb28663b3322', 'Koki Hirota', 'koki-hirota-8a51f5', 'JPN 54624', '中村学園三陽高等学校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'be8e6612-d612-5d81-af05-55959ed41617', 'Hazu Miura', 'hazu-miura-c53b80', 'JPN 56937', '葉山町セーリング協会', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '11cdad5d-56b9-5850-a635-062e9ac793af', 'Mito Nagaoka', 'mito-nagaoka-57964e', 'JPN 56937', '葉山町セーリング協会', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '72d3b737-676a-5d43-a29e-8a0f65d6cf09', 'Rio Morita', 'rio-morita-26ad2d', 'JPN 57142', '大分県セーリング連盟', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '14e4d4ab-6f67-5783-b7e0-a4bee8acc8a2', 'Natsuo Tomitaka', 'natsuo-tomitaka-646372', 'JPN 57142', '大分県セーリング連盟', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'fc9e5636-074b-5350-b472-a122ac643a62', 'Aimi Kameda', 'aimi-kameda-e2310a', 'JPN 57035', '長崎工業高等学校ヨット部', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '8dff5ad3-9cb3-51a8-8850-53c2fb916b0b', 'Misaki Morihama', 'misaki-morihama-d41743', 'JPN 57035', '長崎工業高等学校ヨット部', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '642b57ba-4135-5d26-af02-71c2af77b4cd', 'Sodai Umino', 'sodai-umino-38b4cb', 'JPN 56586', '宮崎県立宮崎海洋高等学校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'dfa37f49-854a-5e38-b15f-583d0ab0702c', 'Kanato Miyashita', 'kanato-miyashita-c665e6', 'JPN 56586', '宮崎県立宮崎海洋高等学校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'fe2f3596-2ba0-514e-a7e2-252eafcc08d6', 'Ayaka Sato', 'ayaka-sato-6179fc', 'JPN 56349', '葉山町セーリング協会', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c0873663-c26a-55a7-90fc-f52149a80b13', 'Kai Omae', 'kai-omae-84d951', 'JPN 56349', '葉山町セーリング協会', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '54929eac-b75e-5608-b958-ce4543b75bb2', 'Ko Nagahori', 'ko-nagahori-8f6706', 'JPN 54675', 'ユースチーム東京／中央区ヨット連盟ジュニア', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '1768402c-cd57-51d2-87bf-f46a0c05ee07', 'Kotaho Kinoshita', 'kotaho-kinoshita-62d99f', 'JPN 54941', '和歌山県セーリング連盟', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5e3a39c0-17ee-5947-b744-268b9be4f7eb', 'Kaede Murata', 'kaede-murata-2ffebe', 'JPN 54941', '和歌山県セーリング連盟', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'b0286ebc-3930-5e9c-a259-76cc65153538', 'Munetake Hashimoto', 'munetake-hashimoto-819ea7', 'JPN 55066', '香川県立高松商業高等学校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '6bc87a34-8207-5563-a8fd-71b59e430ad7', 'Koya Gabeyama', 'koya-gabeyama-b45ab6', 'JPN 55066', '香川県立高松商業高等学校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ca773abb-947a-5cf8-8f34-a4c8c0fe700f', 'Raito Matsumoto', 'raito-matsumoto-d2213c', 'JPN 55074', '宮崎県立宮崎海洋高等学校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '40143d00-1b02-5787-9f96-9801b0228059', 'Hiroto Watanabe', 'hiroto-watanabe-bbfdb7', 'JPN 55074', '宮崎県立宮崎海洋高等学校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c8eade68-b133-5ade-a579-f5623484bbeb', 'Yuika Himejima', 'yuika-himejima-1fb0ef', 'JPN 57143', '大分県セーリング連盟', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '9ff2a8cf-d706-52df-bcbc-4af0e451581a', 'Saku Yamagata', 'saku-yamagata-98d25f', 'JPN 57143', '大分県セーリング連盟', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'ccf08692-22d6-51c6-a78e-0ebd6df6fa34', 'Kanata Kakiwa', 'kanata-kakiwa-62fa6f', 'JPN 55903', '中村学園三陽高等学校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c3b63fbb-385c-5f16-af39-f3de5265426b', 'Shota Hino', 'shota-hino-4370cc', 'JPN 55903', '中村学園三陽高等学校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '17b67332-4b45-5db2-8b7d-19e30f9453ae', 'Kaiki Takasu', 'kaiki-takasu-dde16e', 'JPN 56595', '碧南セーリングクラブ', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '7348068f-8651-53fe-89b5-3725f311327f', 'Hayato Kato', 'hayato-kato-0e4902', 'JPN 56595', '碧南セーリングクラブ', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '6be981d5-983a-58f9-bf3d-fd683bff1fe5', 'Arisa Muro', 'arisa-muro-f2caff', 'JPN 56316', '碧南セーリングクラブ', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'bc2c57c6-653e-58d4-b324-ebe4d05bfc1e', 'Mea Nagura', 'mea-nagura-4726f5', 'JPN 56316', '碧南セーリングクラブ', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4971cb16-3e90-5752-97b6-b044a0301e27', 'Soshi Nagami', 'soshi-nagami-11518b', 'JPN 56932', '福岡第一高校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'de021787-cb74-597d-9360-9803e5203e39', 'Uhiro Hayashi', 'uhiro-hayashi-9b4c7d', 'JPN 56932', '福岡第一高校', 'JPN', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '12fb4377-b32e-5abd-898e-d01d0dd6af45', 'Sarasa Hirashima', 'sarasa-hirashima-4731ac', 'JPN 55626', '長崎工業高等学校ヨット部', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '2513b875-816b-58bc-8c25-8daaff5e88e3', 'Shiwa Ideta', 'shiwa-ideta-df5921', 'JPN 55626', '長崎工業高等学校ヨット部', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'eba1cbb3-76ee-556a-af0c-3170722ff05a', 'Saki Yamaguchi', 'saki-yamaguchi-966bd5', 'JPN 54888', '長崎工業高等学校ヨット部OG', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'de1e6579-c814-5b1d-b333-b792bf701cbb', 'Hinata Sugimoto', 'hinata-sugimoto-b0e179', 'JPN 54888', '長崎工業高等学校ヨット部OG', 'JPN', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' OR public.sailors.club = 'Official regatta entry' THEN EXCLUDED.club ELSE public.sailors.club END,
    nationality = COALESCE(public.sailors.nationality, EXCLUDED.nationality),
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);

-- 2. Create Parent Regatta Event
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer,
    classes, nor_url, created_at, updated_at
) VALUES (
    '57c12ad0-1f21-51cd-9fb6-ecf109757dca',
    '38th All Japan 420 Class Sailing Championship 2025',
    'all-japan-420-championship-2025',
    '2025-12-25',
    '2025-12-28',
    'Odotsu Yacht Harbor, Nichinan, Miyazaki Prefecture, Japan',
    'Japan 420 Class Association & Miyazaki Sailing Federation',
    '["420"]'::jsonb,
    'https://www.japan420sailing.org/race_result/2728/',
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    updated_at = clock_timestamp();

-- 3. Create 420 Regatta Sheet
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at, created_at, updated_at
) VALUES (
    'c899bccb-322f-5e67-87bd-2ca65e0dbfee',
    '57c12ad0-1f21-51cd-9fb6-ecf109757dca',
    '38th All Japan 420 Class Sailing Championship 2025 — 420',
    'all-japan-420-championship-2025-420',
    '2025-12-28',
    '2025-12-28',
    56,
    'Open',
    4,
    'JPN',
    '420',
    'crew',
    2,
    2,
    false,
    'Odotsu Yacht Harbor, Nichinan, Miyazaki Prefecture, Japan',
    'Japan 420 Class Association & Miyazaki Sailing Federation',
    'published',
    'https://www.japan420sailing.org/race_result/2728/',
    'Japan 420 Class Association Official PDF 【成績表】12月29日 (1).pdf',
    '38th All Japan 420 Class Sailing Championship 2025 final results (第38回全日本420級セーリング選手権大会).',
    clock_timestamp(),
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;

-- 4. Insert Regatta Results, Participants, and Race Scores
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '707dac79-904a-5ec4-ae01-a6c6eb473e98', '441d6c8a-a9a0-593d-802d-049a8f1fd156', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Kaiyo Okada & Hidero Ito', '55525', 'crew', 1,
    63.0, 6.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Kaiyo Okada (岡田 海洋), Crew: Hidero Ito (伊藤 秀郎). Club: 津工業高校ヨット部. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c482275e-d13c-51f1-8ef6-ec88001cfa81', '707dac79-904a-5ec4-ae01-a6c6eb473e98', '441d6c8a-a9a0-593d-802d-049a8f1fd156', 'Kaiyo Okada', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '071f675e-15b8-5688-82ea-1c77805b3156', '707dac79-904a-5ec4-ae01-a6c6eb473e98', '45a752b0-180d-52d6-b852-aa2eb2c67c0e', 'Hidero Ito', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '707dac79-904a-5ec4-ae01-a6c6eb473e98', 1, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '707dac79-904a-5ec4-ae01-a6c6eb473e98', 2, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '707dac79-904a-5ec4-ae01-a6c6eb473e98', 3, 57.0, 'UFD', true, '(57.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '707dac79-904a-5ec4-ae01-a6c6eb473e98', 4, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f0b06bd3-1842-5e7a-88c5-29942ee7db97', 'f7e6f592-8675-5009-ab34-321321406034', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Yuji Nishimura & Hiroto Hayakawa', '57546', 'crew', 2,
    14.0, 7.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Yuji Nishimura (西村 祐司), Crew: Hiroto Hayakawa (早川 大翔). Club: 霞ヶ浦セーリングチーム. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5882c9bf-3203-5dc8-8ece-d1915f5ec288', 'f0b06bd3-1842-5e7a-88c5-29942ee7db97', 'f7e6f592-8675-5009-ab34-321321406034', 'Yuji Nishimura', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3f54be50-ea2c-59d8-a967-23d6d56f8bc6', 'f0b06bd3-1842-5e7a-88c5-29942ee7db97', '0fec5c2e-b0ae-5f30-a16c-28530ca3ab5e', 'Hiroto Hayakawa', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f0b06bd3-1842-5e7a-88c5-29942ee7db97', 1, 7.0, NULL, true, '(7.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f0b06bd3-1842-5e7a-88c5-29942ee7db97', 2, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f0b06bd3-1842-5e7a-88c5-29942ee7db97', 3, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f0b06bd3-1842-5e7a-88c5-29942ee7db97', 4, 1.0, NULL, false, '1.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '5ade5681-f504-5687-bc50-1066d1c9d3f5', 'd63cc199-98e9-5eb8-91a8-a705dc95d629', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Ayumu Uchida & Izuho Nakagawa', '57009', 'crew', 3,
    27.0, 16.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Ayumu Uchida (内田 歩), Crew: Izuho Nakagawa (中川 出帆). Club: 葉山町セーリング協会. Division: U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ec3bf839-8f3e-56d2-9d83-526d06f8b842', '5ade5681-f504-5687-bc50-1066d1c9d3f5', 'd63cc199-98e9-5eb8-91a8-a705dc95d629', 'Ayumu Uchida', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ee8ebdeb-23f5-5ef8-ac28-9d4687b00f34', '5ade5681-f504-5687-bc50-1066d1c9d3f5', '1fe3068b-75d8-5e02-95ed-3091397cb211', 'Izuho Nakagawa', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5ade5681-f504-5687-bc50-1066d1c9d3f5', 1, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5ade5681-f504-5687-bc50-1066d1c9d3f5', 2, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5ade5681-f504-5687-bc50-1066d1c9d3f5', 3, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5ade5681-f504-5687-bc50-1066d1c9d3f5', 4, 11.0, NULL, true, '(11.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'fa1ae62c-fcc0-5aa2-aaf4-6265d91d7072', '38d44229-4fc7-573f-84cd-3944fceb584e', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Towa Hamada & Sakuya Miyamae', '56403', 'crew', 4,
    24.0, 16.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Towa Hamada (濵田 登羽), Crew: Sakuya Miyamae (宮前 咲也). Club: 日本経済大学/一社)福岡セーリングクラブ. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a0ad3fbe-f19f-58cc-8ce1-709f3cb5ef6e', 'fa1ae62c-fcc0-5aa2-aaf4-6265d91d7072', '38d44229-4fc7-573f-84cd-3944fceb584e', 'Towa Hamada', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '8877ab60-6629-5a26-b061-0e8cc7a02db5', 'fa1ae62c-fcc0-5aa2-aaf4-6265d91d7072', '75181070-fc83-579d-b3e7-1799959b96e7', 'Sakuya Miyamae', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa1ae62c-fcc0-5aa2-aaf4-6265d91d7072', 1, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa1ae62c-fcc0-5aa2-aaf4-6265d91d7072', 2, 8.0, NULL, true, '(8.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa1ae62c-fcc0-5aa2-aaf4-6265d91d7072', 3, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa1ae62c-fcc0-5aa2-aaf4-6265d91d7072', 4, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '042b4249-5208-5de5-9f99-fce028a50a6e', '925c5c1f-89e3-56b1-a55a-6710f685f836', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Haru Okada & Keito Atsumi', '57505', 'crew', 5,
    53.0, 18.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Haru Okada (岡田 晴), Crew: Keito Atsumi (渥美 圭登). Club: 津工業高校ヨット部. Division: U17.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e26dbe2a-26a9-590f-a755-2cdc947152f3', '042b4249-5208-5de5-9f99-fce028a50a6e', '925c5c1f-89e3-56b1-a55a-6710f685f836', 'Haru Okada', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'aeb2c30d-af57-51ab-aaab-90c485da2385', '042b4249-5208-5de5-9f99-fce028a50a6e', '11bd03db-9007-5300-81f8-626d444978c4', 'Keito Atsumi', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '042b4249-5208-5de5-9f99-fce028a50a6e', 1, 35.0, NULL, true, '(35.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '042b4249-5208-5de5-9f99-fce028a50a6e', 2, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '042b4249-5208-5de5-9f99-fce028a50a6e', 3, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '042b4249-5208-5de5-9f99-fce028a50a6e', 4, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '3fab58c2-b686-5779-8c0f-563b62043c51', 'c3fd872d-5143-537e-9b7e-6d600698b8d1', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Daiki Tanaka & Yukinaga Kajimura', '57109', 'crew', 6,
    35.0, 20.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Daiki Tanaka (田中 大基), Crew: Yukinaga Kajimura (梶村 幸永). Club: 山口県セーリング連盟/HOPE. Division: U17.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0b0ebca0-a5d1-5af8-9127-9e5f7ac38263', '3fab58c2-b686-5779-8c0f-563b62043c51', 'c3fd872d-5143-537e-9b7e-6d600698b8d1', 'Daiki Tanaka', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3fb65776-45e6-54c5-b8c2-657290075aec', '3fab58c2-b686-5779-8c0f-563b62043c51', '01144665-4db3-545e-bda5-3966b8ec7372', 'Yukinaga Kajimura', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3fab58c2-b686-5779-8c0f-563b62043c51', 1, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3fab58c2-b686-5779-8c0f-563b62043c51', 2, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3fab58c2-b686-5779-8c0f-563b62043c51', 3, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3fab58c2-b686-5779-8c0f-563b62043c51', 4, 15.0, NULL, true, '(15.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ac6c6bd6-0151-5063-a50e-f4976735a0ae', '9f2ade83-cc10-59b4-b806-cb33573e8cb0', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Kiyoto Yamazaki & Shota Miyachi', '56596', 'crew', 7,
    77.0, 20.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Kiyoto Yamazaki (山崎 聖斗), Crew: Shota Miyachi (宮地 翔大). Club: 碧南セーリングクラブ. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5a95cadb-cba4-550c-98eb-2b7cfc49ec3a', 'ac6c6bd6-0151-5063-a50e-f4976735a0ae', '9f2ade83-cc10-59b4-b806-cb33573e8cb0', 'Kiyoto Yamazaki', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b9c24616-f905-554a-a0f6-3dea96b7ae97', 'ac6c6bd6-0151-5063-a50e-f4976735a0ae', '2cf54ef6-0276-5f38-bd18-cec0502f3f6c', 'Shota Miyachi', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ac6c6bd6-0151-5063-a50e-f4976735a0ae', 1, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ac6c6bd6-0151-5063-a50e-f4976735a0ae', 2, 57.0, 'DNF', true, '(57.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ac6c6bd6-0151-5063-a50e-f4976735a0ae', 3, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ac6c6bd6-0151-5063-a50e-f4976735a0ae', 4, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'de41c9c7-6ce9-5a8c-90cf-a8ff39a96e8f', '3992aa68-97b2-5974-8d82-b143cd0accca', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Misaki Tsunomori & Yuma Asano', '55487', 'crew', 8,
    37.0, 20.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Misaki Tsunomori (角森 未岬), Crew: Yuma Asano (浅野 悠真). Club: 霞ヶ浦セーリングチーム. Division: U17.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ebcd95f3-78af-525c-a9e9-646f3aee1770', 'de41c9c7-6ce9-5a8c-90cf-a8ff39a96e8f', '3992aa68-97b2-5974-8d82-b143cd0accca', 'Misaki Tsunomori', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1d8c9ce6-d636-5013-a4f9-72f6840500a7', 'de41c9c7-6ce9-5a8c-90cf-a8ff39a96e8f', 'e4ffa42b-42b0-5be2-afd3-793c98a40914', 'Yuma Asano', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'de41c9c7-6ce9-5a8c-90cf-a8ff39a96e8f', 1, 3.0, NULL, false, '3.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'de41c9c7-6ce9-5a8c-90cf-a8ff39a96e8f', 2, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'de41c9c7-6ce9-5a8c-90cf-a8ff39a96e8f', 3, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'de41c9c7-6ce9-5a8c-90cf-a8ff39a96e8f', 4, 17.0, NULL, true, '(17.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '20c7ba3a-1dd4-5ccb-b305-26ea4d5d1262', '2f1f22d2-beb0-5fe9-bc32-926bbaf73ad4', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Yuto Inoue & Kiryue Yoshioka', '55798', 'crew', 9,
    78.0, 21.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Yuto Inoue (井上 勇翔), Crew: Kiryue Yoshioka (吉岡 喜琉). Club: 宮崎県立宮崎海洋高等学校. Division: U17.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4da4fe85-1413-5c03-8daf-29a1ec9eb4f3', '20c7ba3a-1dd4-5ccb-b305-26ea4d5d1262', '2f1f22d2-beb0-5fe9-bc32-926bbaf73ad4', 'Yuto Inoue', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a7cca982-9d82-5884-9fa7-a0ff6bbe9cf6', '20c7ba3a-1dd4-5ccb-b305-26ea4d5d1262', 'f5d26c55-f669-5a79-8dbc-c4a5d92281bc', 'Kiryue Yoshioka', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20c7ba3a-1dd4-5ccb-b305-26ea4d5d1262', 1, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20c7ba3a-1dd4-5ccb-b305-26ea4d5d1262', 2, 57.0, 'UFD', true, '(57.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20c7ba3a-1dd4-5ccb-b305-26ea4d5d1262', 3, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20c7ba3a-1dd4-5ccb-b305-26ea4d5d1262', 4, 7.0, NULL, false, '7.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'd7954e44-a444-5a8c-88ce-dc07bb63d8d2', '34d229e3-149c-5551-aa98-42ef0798386c', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Chihiro Tanoue & Kokone Imaizumi', '57474', 'crew', 10,
    43.0, 22.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Chihiro Tanoue (田上 千尋), Crew: Kokone Imaizumi (今泉 心響). Club: NPO SAGA SAILING. Division: Girls, U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4f1e12ac-cf6c-5155-8bfe-000b9022fcb3', 'd7954e44-a444-5a8c-88ce-dc07bb63d8d2', '34d229e3-149c-5551-aa98-42ef0798386c', 'Chihiro Tanoue', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd87919a1-9fce-5f16-a4b6-b85b02caba30', 'd7954e44-a444-5a8c-88ce-dc07bb63d8d2', 'cf1098b5-824f-5cb8-a1c2-6520bf00f8ac', 'Kokone Imaizumi', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd7954e44-a444-5a8c-88ce-dc07bb63d8d2', 1, 21.0, NULL, true, '(21.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd7954e44-a444-5a8c-88ce-dc07bb63d8d2', 2, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd7954e44-a444-5a8c-88ce-dc07bb63d8d2', 3, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd7954e44-a444-5a8c-88ce-dc07bb63d8d2', 4, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '7b8b6d6a-73b0-5dc4-9c16-0797b851b6da', 'e7c0d225-0597-5c0a-9c12-a52a252b430e', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Kizuku Otsubo & Retsu Yonekura', '57419', 'crew', 11,
    53.0, 30.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Kizuku Otsubo (大坪 築), Crew: Retsu Yonekura (米倉 烈). Club: NPO SAGA SAILING. Division: U17.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '192f5f70-93ee-5158-80b3-84d9149393bc', '7b8b6d6a-73b0-5dc4-9c16-0797b851b6da', 'e7c0d225-0597-5c0a-9c12-a52a252b430e', 'Kizuku Otsubo', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a7a37372-88fa-57a1-a344-fa862d0a97e4', '7b8b6d6a-73b0-5dc4-9c16-0797b851b6da', 'c182b857-8088-506d-88aa-785d4e727396', 'Retsu Yonekura', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7b8b6d6a-73b0-5dc4-9c16-0797b851b6da', 1, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7b8b6d6a-73b0-5dc4-9c16-0797b851b6da', 2, 4.0, NULL, false, '4.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7b8b6d6a-73b0-5dc4-9c16-0797b851b6da', 3, 23.0, NULL, true, '(23.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7b8b6d6a-73b0-5dc4-9c16-0797b851b6da', 4, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'fa6ba9c5-a9e1-5673-97eb-b89a08ee580c', 'cca12153-c55d-5fcd-8af7-c5a32d6310d7', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Shima Hisamatsu & Yu Kuramoto', '56463', 'crew', 12,
    48.0, 34.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Shima Hisamatsu (久松 志摩), Crew: Yu Kuramoto (倉元 優羽). Club: 福岡第一高校. Division: U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '42ea9030-c6c5-5ad2-bc30-d55d2ff78f43', 'fa6ba9c5-a9e1-5673-97eb-b89a08ee580c', 'cca12153-c55d-5fcd-8af7-c5a32d6310d7', 'Shima Hisamatsu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '644db947-6c49-595a-b365-f006a820ffcc', 'fa6ba9c5-a9e1-5673-97eb-b89a08ee580c', 'cf3d0271-ba48-5df7-abe4-580fb98157e2', 'Yu Kuramoto', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa6ba9c5-a9e1-5673-97eb-b89a08ee580c', 1, 14.0, NULL, true, '(14.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa6ba9c5-a9e1-5673-97eb-b89a08ee580c', 2, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa6ba9c5-a9e1-5673-97eb-b89a08ee580c', 3, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa6ba9c5-a9e1-5673-97eb-b89a08ee580c', 4, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c1271522-64dc-53e6-85ff-26ff835b2f81', '3e5c315f-7c0b-4888-8f3b-61a735092505', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Tomohiro Kawakita & Ryo Mizusawa', '56911', 'crew', 13,
    72.0, 38.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Tomohiro Kawakita (川北 智大), Crew: Ryo Mizusawa (水澤 諒). Club: 香川県立高松商業高等学校. Division: U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'bcf426a9-c1d0-5f60-95d2-a7116d43280c', 'c1271522-64dc-53e6-85ff-26ff835b2f81', '3e5c315f-7c0b-4888-8f3b-61a735092505', 'Tomohiro Kawakita', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '697517b2-e8c8-5c19-bf52-84cffff45dff', 'c1271522-64dc-53e6-85ff-26ff835b2f81', '1b7b24d6-73be-5e9e-9c3c-d2c547bbf760', 'Ryo Mizusawa', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1271522-64dc-53e6-85ff-26ff835b2f81', 1, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1271522-64dc-53e6-85ff-26ff835b2f81', 2, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1271522-64dc-53e6-85ff-26ff835b2f81', 3, 34.0, NULL, true, '(34.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1271522-64dc-53e6-85ff-26ff835b2f81', 4, 9.0, NULL, false, '9.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '6ddd9ce1-ab81-5e48-beaf-892293386476', '169cb109-d93b-5025-a11b-63c1dc290369', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Kosei Fuchigami & Manato Yamazumi', '56671', 'crew', 14,
    58.0, 39.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Kosei Fuchigami (渕上 幸星), Crew: Manato Yamazumi (山住 愛翔). Club: 津工業高校ヨット部. Division: U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1c3579ba-450d-5ecc-bddf-8038b51a160f', '6ddd9ce1-ab81-5e48-beaf-892293386476', '169cb109-d93b-5025-a11b-63c1dc290369', 'Kosei Fuchigami', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '94c0fbf4-87cb-5a62-95a7-b197da6fbb1f', '6ddd9ce1-ab81-5e48-beaf-892293386476', '684c4b0b-448f-51c5-b206-a21a2a683dab', 'Manato Yamazumi', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ddd9ce1-ab81-5e48-beaf-892293386476', 1, 5.0, NULL, false, '5.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ddd9ce1-ab81-5e48-beaf-892293386476', 2, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ddd9ce1-ab81-5e48-beaf-892293386476', 3, 19.0, NULL, true, '(19.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ddd9ce1-ab81-5e48-beaf-892293386476', 4, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '205fe407-8f47-5688-82cd-e15474adbd1a', '0ed8fb56-420e-46a7-9056-86732c1f2e01', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Koei Hamakawa & Kotaro Yamauchi', '54626', 'crew', 15,
    63.0, 39.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Koei Hamakawa (濱川 航英), Crew: Kotaro Yamauchi (山内 琥太郎). Club: 霞ヶ浦セーリングチーム. Division: U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '73da655b-92a4-51be-9f65-b25990cf9845', '205fe407-8f47-5688-82cd-e15474adbd1a', '0ed8fb56-420e-46a7-9056-86732c1f2e01', 'Koei Hamakawa', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5d6efc3c-05a7-5249-8631-44e6917f8482', '205fe407-8f47-5688-82cd-e15474adbd1a', '10653959-2270-5a95-bd23-88141dbacd17', 'Kotaro Yamauchi', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '205fe407-8f47-5688-82cd-e15474adbd1a', 1, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '205fe407-8f47-5688-82cd-e15474adbd1a', 2, 24.0, NULL, true, '(24.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '205fe407-8f47-5688-82cd-e15474adbd1a', 3, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '205fe407-8f47-5688-82cd-e15474adbd1a', 4, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c86f0abf-af48-58f8-840b-85c3b6ca7078', 'b557a308-9982-5a4f-939d-b795d07e4caf', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Yuta Ozaki & Yusei Sakamaki', '56165', 'crew', 16,
    97.0, 40.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Yuta Ozaki (尾崎 友太), Crew: Yusei Sakamaki (酒巻 佑成). Club: 霞ヶ浦セーリングチーム. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'fbe4bc28-84cb-5765-8080-60bcd0e2aef7', 'c86f0abf-af48-58f8-840b-85c3b6ca7078', 'b557a308-9982-5a4f-939d-b795d07e4caf', 'Yuta Ozaki', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '75bf5d6b-ecaa-5148-9fda-5f67c5adb993', 'c86f0abf-af48-58f8-840b-85c3b6ca7078', 'ed5112be-81b0-5025-8d6c-c8cfae7f812f', 'Yusei Sakamaki', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c86f0abf-af48-58f8-840b-85c3b6ca7078', 1, 2.0, NULL, false, '2.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c86f0abf-af48-58f8-840b-85c3b6ca7078', 2, 57.0, 'UFD', true, '(57.0 UFD)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c86f0abf-af48-58f8-840b-85c3b6ca7078', 3, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c86f0abf-af48-58f8-840b-85c3b6ca7078', 4, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '10ded2cd-7578-5fe6-93cf-e79f5c6c39f8', 'ab87ae72-327b-500d-bf59-1b6bde5eb13b', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Yuyu Aoyama & Sosuke Inaba', '57100', 'crew', 17,
    61.0, 42.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Yuyu Aoyama (青山 侑友), Crew: Sosuke Inaba (稲葉 奏介). Club: 葉山町セーリング協会. Division: U17.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7d539a86-ad93-5137-98c5-3071baf6763b', '10ded2cd-7578-5fe6-93cf-e79f5c6c39f8', 'ab87ae72-327b-500d-bf59-1b6bde5eb13b', 'Yuyu Aoyama', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9af8abc5-4f59-5c93-8c72-4a4f894e32fb', '10ded2cd-7578-5fe6-93cf-e79f5c6c39f8', '674f9bc2-4a18-5325-b0c5-b50cb0b1d46e', 'Sosuke Inaba', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '10ded2cd-7578-5fe6-93cf-e79f5c6c39f8', 1, 13.0, NULL, false, '13.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '10ded2cd-7578-5fe6-93cf-e79f5c6c39f8', 2, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '10ded2cd-7578-5fe6-93cf-e79f5c6c39f8', 3, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '10ded2cd-7578-5fe6-93cf-e79f5c6c39f8', 4, 19.0, NULL, true, '(19.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '6e5fafb8-d33c-5d5b-b47e-ddc4548bcdf7', '9273ce46-fe2e-5658-b104-c000d5da8286', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Hozumi Mitani & Nanato Iwasaki', '55827', 'crew', 18,
    74.0, 46.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Hozumi Mitani (三谷 帆澄), Crew: Nanato Iwasaki (岩﨑 七飛). Club: 葉山町セーリング協会. Division: U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '35d3c867-f151-57a3-a418-bd7d0fd16efd', '6e5fafb8-d33c-5d5b-b47e-ddc4548bcdf7', '9273ce46-fe2e-5658-b104-c000d5da8286', 'Hozumi Mitani', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd02d9ade-63d8-5e84-a882-53a453337d8b', '6e5fafb8-d33c-5d5b-b47e-ddc4548bcdf7', 'b4561750-5681-54a1-adb0-334c344a3c4f', 'Nanato Iwasaki', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e5fafb8-d33c-5d5b-b47e-ddc4548bcdf7', 1, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e5fafb8-d33c-5d5b-b47e-ddc4548bcdf7', 2, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e5fafb8-d33c-5d5b-b47e-ddc4548bcdf7', 3, 15.0, NULL, false, '15.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e5fafb8-d33c-5d5b-b47e-ddc4548bcdf7', 4, 28.0, NULL, true, '(28.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '39afa12e-ea87-599a-943b-88c63d55081a', '8344ce9c-8a71-5080-b478-f43ca693f7b8', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Shinji Zaitsu & Yuto Tanaka', '54629', 'crew', 19,
    76.0, 47.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Shinji Zaitsu (財津 慎司), Crew: Yuto Tanaka (田中 悠人). Club: 中村学園三陽高等学校. Division: U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0705f30d-4efe-5489-969c-cd1b85c69f97', '39afa12e-ea87-599a-943b-88c63d55081a', '8344ce9c-8a71-5080-b478-f43ca693f7b8', 'Shinji Zaitsu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd2addc01-93fc-5a2c-82d1-5c0f2cc8c744', '39afa12e-ea87-599a-943b-88c63d55081a', '79c633a6-1aca-579e-85bb-88aca66357aa', 'Yuto Tanaka', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39afa12e-ea87-599a-943b-88c63d55081a', 1, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39afa12e-ea87-599a-943b-88c63d55081a', 2, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39afa12e-ea87-599a-943b-88c63d55081a', 3, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39afa12e-ea87-599a-943b-88c63d55081a', 4, 29.0, NULL, true, '(29.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'db1a2c21-87bd-5981-a12d-fac08ed862e2', '5b4c86bf-b7c8-57a4-b16a-5c9e221a85a1', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Maika Ueda & Naoki Sato', '57405', 'crew', 20,
    76.0, 50.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Maika Ueda (上田 舞花), Crew: Naoki Sato (佐藤 直輝). Club: 葉山町セーリング協会. Division: U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1d3f9682-13da-54e2-a89a-aa6dd87210f0', 'db1a2c21-87bd-5981-a12d-fac08ed862e2', '5b4c86bf-b7c8-57a4-b16a-5c9e221a85a1', 'Maika Ueda', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '89c70b4f-cb1b-5a07-893d-1bcd1aba5668', 'db1a2c21-87bd-5981-a12d-fac08ed862e2', 'ac34f6c4-dc1d-5fc7-81b0-1b5003d913ec', 'Naoki Sato', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'db1a2c21-87bd-5981-a12d-fac08ed862e2', 1, 26.0, NULL, true, '(26.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'db1a2c21-87bd-5981-a12d-fac08ed862e2', 2, 10.0, NULL, false, '10.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'db1a2c21-87bd-5981-a12d-fac08ed862e2', 3, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'db1a2c21-87bd-5981-a12d-fac08ed862e2', 4, 16.0, NULL, false, '16.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '69ba6653-ad93-59de-bc36-21ce1875a071', '85288ca5-41f1-52be-be6c-a4f9f5a787cc', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Masanori Takasu & Ryuji Hirasawa', '57098', 'crew', 21,
    78.0, 51.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Masanori Takasu (高須 雅規), Crew: Ryuji Hirasawa (平澤 琉司). Club: 碧南セーリングクラブ. Division: Open.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '048a4775-941f-5dfb-903a-012e5406dcca', '69ba6653-ad93-59de-bc36-21ce1875a071', '85288ca5-41f1-52be-be6c-a4f9f5a787cc', 'Masanori Takasu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '362e0179-3714-58ef-aecd-cfd767d90a04', '69ba6653-ad93-59de-bc36-21ce1875a071', 'c50fc291-67e0-5097-8df3-1081f048adb5', 'Ryuji Hirasawa', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '69ba6653-ad93-59de-bc36-21ce1875a071', 1, 8.0, NULL, false, '8.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '69ba6653-ad93-59de-bc36-21ce1875a071', 2, 17.0, NULL, false, '17.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '69ba6653-ad93-59de-bc36-21ce1875a071', 3, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '69ba6653-ad93-59de-bc36-21ce1875a071', 4, 27.0, NULL, true, '(27.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '78cb920e-2ac3-53a3-a693-f2fdb2e92241', 'e558d878-1d4a-561c-b152-f209f49a24ff', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Mifuu Suetsugu & Komei Katsui', '55907', 'crew', 22,
    89.0, 52.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Mifuu Suetsugu (末次 海風), Crew: Komei Katsui (勝井 孔明). Club: 山口県セーリング連盟. Division: U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e5c4c9c0-d2c3-5631-ae96-4b6906122e45', '78cb920e-2ac3-53a3-a693-f2fdb2e92241', 'e558d878-1d4a-561c-b152-f209f49a24ff', 'Mifuu Suetsugu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '8544c366-3f56-54b8-8288-23918c64c452', '78cb920e-2ac3-53a3-a693-f2fdb2e92241', '66a5e779-d9e8-5bda-b019-565da87861ea', 'Komei Katsui', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '78cb920e-2ac3-53a3-a693-f2fdb2e92241', 1, 37.0, NULL, true, '(37.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '78cb920e-2ac3-53a3-a693-f2fdb2e92241', 2, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '78cb920e-2ac3-53a3-a693-f2fdb2e92241', 3, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '78cb920e-2ac3-53a3-a693-f2fdb2e92241', 4, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e12b271e-4c8a-5342-a83c-9181c59c97f1', 'e09f7ecb-f03a-5cc0-bbf7-38f2c588cf6a', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Yuka Kubota & Yumi Miyaguchi', '57473', 'crew', 23,
    118.0, 61.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Yuka Kubota (久保田 結花), Crew: Yumi Miyaguchi (宮口 釉美). Club: NPO SAGA SAILING. Division: Girls, U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9a2f5daa-8335-552c-a75d-175fe440b9da', 'e12b271e-4c8a-5342-a83c-9181c59c97f1', 'e09f7ecb-f03a-5cc0-bbf7-38f2c588cf6a', 'Yuka Kubota', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c95dd58c-fb65-5f44-b8f7-9088072d31cc', 'e12b271e-4c8a-5342-a83c-9181c59c97f1', 'c9df16c6-c1ef-5b35-a9e2-8b70baebc19c', 'Yumi Miyaguchi', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e12b271e-4c8a-5342-a83c-9181c59c97f1', 1, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e12b271e-4c8a-5342-a83c-9181c59c97f1', 2, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e12b271e-4c8a-5342-a83c-9181c59c97f1', 3, 57.0, 'DNF', true, '(57.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e12b271e-4c8a-5342-a83c-9181c59c97f1', 4, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e7ab662f-4c10-5560-bc51-65dfdcb28df3', '78c93af4-8cfa-52d1-8fd9-e2643b4d9db9', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Daisuke Mori & Eishin Itai', '55067', 'crew', 24,
    120.0, 63.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Daisuke Mori (森 大輔), Crew: Eishin Itai (板井 英心). Club: 日南振徳高校. Division: U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '4c1549ba-e76c-50e4-9365-063142244114', 'e7ab662f-4c10-5560-bc51-65dfdcb28df3', '78c93af4-8cfa-52d1-8fd9-e2643b4d9db9', 'Daisuke Mori', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '981e1226-57a7-524a-aa3b-82bf7b38628d', 'e7ab662f-4c10-5560-bc51-65dfdcb28df3', '6636796c-c012-55c6-9fd5-9e54f8e20460', 'Eishin Itai', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e7ab662f-4c10-5560-bc51-65dfdcb28df3', 1, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e7ab662f-4c10-5560-bc51-65dfdcb28df3', 2, 6.0, NULL, false, '6.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e7ab662f-4c10-5560-bc51-65dfdcb28df3', 3, 38.0, NULL, false, '38.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e7ab662f-4c10-5560-bc51-65dfdcb28df3', 4, 57.0, 'DSQ', true, '(57.0 DSQ)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '9d9e36c2-50c6-5c17-a9e0-7ed607bd26ae', '3145be8a-1ad8-5ab5-ab0d-34cbed017610', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Haruka Kano & Mio Takahira', '55627', 'crew', 25,
    99.0, 66.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Haruka Kano (狩野 遥風), Crew: Mio Takahira (高比良 弥桜). Club: 長崎工業高等学校ヨット部OG. Division: Girls.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '920fe624-35ce-5c90-8f6c-d37343727d7c', '9d9e36c2-50c6-5c17-a9e0-7ed607bd26ae', '3145be8a-1ad8-5ab5-ab0d-34cbed017610', 'Haruka Kano', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3c2eca16-f2eb-539d-a9e0-17ee8f324215', '9d9e36c2-50c6-5c17-a9e0-7ed607bd26ae', '99e4ee3e-a20d-5a0d-a09b-8bb263d4d9a3', 'Mio Takahira', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9d9e36c2-50c6-5c17-a9e0-7ed607bd26ae', 1, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9d9e36c2-50c6-5c17-a9e0-7ed607bd26ae', 2, 19.0, NULL, false, '19.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9d9e36c2-50c6-5c17-a9e0-7ed607bd26ae', 3, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9d9e36c2-50c6-5c17-a9e0-7ed607bd26ae', 4, 33.0, NULL, true, '(33.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '14ee41f7-0917-54cf-9836-25fbd73e7dca', 'b7a47cb4-ad60-53c3-9dce-2684de9af2b2', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Sorata Uozumi & Kihei Sadamune', '55583', 'crew', 26,
    110.0, 69.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Sorata Uozumi (魚住 空汰), Crew: Kihei Sadamune (定宗 喜平). Club: 中村学園三陽高等学校. Division: U17.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '8f6a320e-57a0-50fa-966b-1d1934553491', '14ee41f7-0917-54cf-9836-25fbd73e7dca', 'b7a47cb4-ad60-53c3-9dce-2684de9af2b2', 'Sorata Uozumi', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '856d0599-5fd8-5d55-9211-9ad5e42e0b26', '14ee41f7-0917-54cf-9836-25fbd73e7dca', '3541c249-2178-500b-a7bf-f7e8214828b4', 'Kihei Sadamune', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14ee41f7-0917-54cf-9836-25fbd73e7dca', 1, 41.0, NULL, true, '(41.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14ee41f7-0917-54cf-9836-25fbd73e7dca', 2, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14ee41f7-0917-54cf-9836-25fbd73e7dca', 3, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14ee41f7-0917-54cf-9836-25fbd73e7dca', 4, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '75f4e2d6-68e7-54da-b7a2-d132ed8cf328', '672d2b03-be0a-57b8-8e50-2fe3a72a195a', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Seiya Shiraishi & Koyo Nishimura', '55928', 'crew', 27,
    103.0, 70.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Seiya Shiraishi (白石 征也), Crew: Koyo Nishimura (西村 航洋). Club: 江の島ヨットクラブジュニア. Division: U17.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3615fd59-0b3b-5e06-9461-36da03278f78', '75f4e2d6-68e7-54da-b7a2-d132ed8cf328', '672d2b03-be0a-57b8-8e50-2fe3a72a195a', 'Seiya Shiraishi', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f941858d-8e6c-5446-aee0-e94e7572ac99', '75f4e2d6-68e7-54da-b7a2-d132ed8cf328', '214f82fe-8d5a-5467-ad7d-91538135ca86', 'Koyo Nishimura', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75f4e2d6-68e7-54da-b7a2-d132ed8cf328', 1, 33.0, NULL, true, '(33.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75f4e2d6-68e7-54da-b7a2-d132ed8cf328', 2, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75f4e2d6-68e7-54da-b7a2-d132ed8cf328', 3, 14.0, NULL, false, '14.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '75f4e2d6-68e7-54da-b7a2-d132ed8cf328', 4, 31.0, NULL, false, '31.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '1981ce59-1697-52e6-ba62-5b36478947bb', '184cb967-064c-58d0-a7aa-f4362ce3c950', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Eri Fukushima & Yoshimi Sasaki', '57354', 'crew', 28,
    109.0, 72.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Eri Fukushima (福島 笑莉), Crew: Yoshimi Sasaki (ササキ ヨシミ). Club: 津工業高校ヨット部. Division: Girls, U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c76e4ef9-396d-5c99-b124-89bb65a601e5', '1981ce59-1697-52e6-ba62-5b36478947bb', '184cb967-064c-58d0-a7aa-f4362ce3c950', 'Eri Fukushima', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3560e688-57fd-5b57-b398-ffc7690f27d8', '1981ce59-1697-52e6-ba62-5b36478947bb', '37152a7b-3aa1-55af-9ff5-103b68dea907', 'Yoshimi Sasaki', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1981ce59-1697-52e6-ba62-5b36478947bb', 1, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1981ce59-1697-52e6-ba62-5b36478947bb', 2, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1981ce59-1697-52e6-ba62-5b36478947bb', 3, 37.0, NULL, true, '(37.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1981ce59-1697-52e6-ba62-5b36478947bb', 4, 12.0, NULL, false, '12.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c24de8bb-a7ee-5cd2-819f-56d9f1966449', '3b742466-9ff9-5295-986b-7974dc96f0ba', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Soichiro Seki & Koki Yamashita', '57106', 'crew', 29,
    102.0, 72.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Soichiro Seki (関 颯一郎), Crew: Koki Yamashita (山下 航希). Club: 江の島ヨットクラブジュニア. Division: U17.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '6ba715b7-6bab-5d80-9b0b-586d011b5b09', 'c24de8bb-a7ee-5cd2-819f-56d9f1966449', '3b742466-9ff9-5295-986b-7974dc96f0ba', 'Soichiro Seki', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ba7f9c5d-cceb-5d93-90a9-752e39a019ab', 'c24de8bb-a7ee-5cd2-819f-56d9f1966449', '573185b0-234c-5dd6-83dd-29c1daf6736c', 'Koki Yamashita', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c24de8bb-a7ee-5cd2-819f-56d9f1966449', 1, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c24de8bb-a7ee-5cd2-819f-56d9f1966449', 2, 26.0, NULL, false, '26.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c24de8bb-a7ee-5cd2-819f-56d9f1966449', 3, 22.0, NULL, false, '22.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c24de8bb-a7ee-5cd2-819f-56d9f1966449', 4, 30.0, NULL, true, '(30.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '7338dd51-4d75-57d5-9d60-4b31197af790', '3fcebe88-f7a2-5234-aa87-d688b978158f', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Aoi Isobe & Konatsu Aminaga', '54410', 'crew', 30,
    108.0, 76.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Aoi Isobe (五十部 葵), Crew: Konatsu Aminaga (網永 好夏). Club: 山口県セーリング連盟. Division: Girls, U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ad43cf5f-5d88-5c5c-a0c8-9c2db11e99a8', '7338dd51-4d75-57d5-9d60-4b31197af790', '3fcebe88-f7a2-5234-aa87-d688b978158f', 'Aoi Isobe', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0e20509d-e231-5175-a854-0f272ebb5587', '7338dd51-4d75-57d5-9d60-4b31197af790', '4c1ab070-ee5b-5f9d-92d5-0d1e5cd3b20b', 'Konatsu Aminaga', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7338dd51-4d75-57d5-9d60-4b31197af790', 1, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7338dd51-4d75-57d5-9d60-4b31197af790', 2, 32.0, NULL, true, '(32.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7338dd51-4d75-57d5-9d60-4b31197af790', 3, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7338dd51-4d75-57d5-9d60-4b31197af790', 4, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'b696abf9-6bbe-54b2-a6d1-eaea3c9b389b', 'f7c9fe3d-938d-5727-8a55-a762cc6ac182', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Ayana Isaka & Riho Sanematsu', '55009', 'crew', 31,
    134.0, 77.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Ayana Isaka (井坂 文菜), Crew: Riho Sanematsu (實松 莉歩). Club: 霞ヶ浦セーリングチーム. Division: Girls, U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '75efc145-9914-51f0-867e-199b67071582', 'b696abf9-6bbe-54b2-a6d1-eaea3c9b389b', 'f7c9fe3d-938d-5727-8a55-a762cc6ac182', 'Ayana Isaka', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd2674c52-bdda-5973-8fd3-324c59dc781d', 'b696abf9-6bbe-54b2-a6d1-eaea3c9b389b', 'a63cb70f-12ad-480b-8fd6-f919ceea28f3', 'Riho Sanematsu', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b696abf9-6bbe-54b2-a6d1-eaea3c9b389b', 1, 57.0, 'DNF', true, '(57.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b696abf9-6bbe-54b2-a6d1-eaea3c9b389b', 2, 30.0, NULL, false, '30.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b696abf9-6bbe-54b2-a6d1-eaea3c9b389b', 3, 11.0, NULL, false, '11.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b696abf9-6bbe-54b2-a6d1-eaea3c9b389b', 4, 36.0, NULL, false, '36.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '4b59e916-681f-5c06-a3b0-3271a36cb2af', '7a4f33a3-da1e-5f14-bc7e-6d91cf5b3cf7', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Nina Suzuki & Sora Miura', '57467', 'crew', 32,
    115.0, 77.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Nina Suzuki (鈴木 仁菜), Crew: Sora Miura (三浦 想来). Club: 碧南セーリングクラブ. Division: Girls, U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '197183a0-1d94-5d0b-bfa5-8465402b8191', '4b59e916-681f-5c06-a3b0-3271a36cb2af', '7a4f33a3-da1e-5f14-bc7e-6d91cf5b3cf7', 'Nina Suzuki', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'fb1ae45a-1b3b-5238-9616-82a06e0184ba', '4b59e916-681f-5c06-a3b0-3271a36cb2af', 'eaa5559e-5c82-532a-83f1-80f821e8b7ec', 'Sora Miura', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b59e916-681f-5c06-a3b0-3271a36cb2af', 1, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b59e916-681f-5c06-a3b0-3271a36cb2af', 2, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b59e916-681f-5c06-a3b0-3271a36cb2af', 3, 20.0, NULL, false, '20.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b59e916-681f-5c06-a3b0-3271a36cb2af', 4, 38.0, NULL, true, '(38.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '4be87653-f568-58cc-97cf-fcb37c4e141a', 'b31b43ab-ba2d-5092-becf-af04512bbdcc', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Seina Kawachi & Momoha Ueda', '55697', 'crew', 33,
    124.0, 84.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Seina Kawachi (河内 聖奈), Crew: Momoha Ueda (植田 桃羽). Club: 香川県立高松商業高等学校. Division: Girls, U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'adcddd63-c816-524d-901c-dd5e5c007095', '4be87653-f568-58cc-97cf-fcb37c4e141a', 'b31b43ab-ba2d-5092-becf-af04512bbdcc', 'Seina Kawachi', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b7433d22-2da6-5987-a29b-fe1a021e1893', '4be87653-f568-58cc-97cf-fcb37c4e141a', '2b487173-a438-5151-bf61-9705138e5904', 'Momoha Ueda', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4be87653-f568-58cc-97cf-fcb37c4e141a', 1, 32.0, NULL, false, '32.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4be87653-f568-58cc-97cf-fcb37c4e141a', 2, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4be87653-f568-58cc-97cf-fcb37c4e141a', 3, 40.0, NULL, true, '(40.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4be87653-f568-58cc-97cf-fcb37c4e141a', 4, 25.0, NULL, false, '25.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '4163745a-f96c-5b77-8387-4671d90ea7d9', 'e9a1206b-cbd9-575f-a3e7-e96ec592642a', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Ruichi Nakano & Takumi Ito', '56749', 'crew', 34,
    125.0, 86.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Ruichi Nakano (中野 瑠一), Crew: Takumi Ito (伊藤 匠史). Club: 和歌山県セーリング連盟. Division: U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0e00fb9d-5c58-551a-ba65-af38d7fed4fb', '4163745a-f96c-5b77-8387-4671d90ea7d9', 'e9a1206b-cbd9-575f-a3e7-e96ec592642a', 'Ruichi Nakano', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '84552cc6-71e5-5dcf-a93e-7c36eed39c43', '4163745a-f96c-5b77-8387-4671d90ea7d9', '56aa5cdf-6528-569b-a40d-3bd000b0572b', 'Takumi Ito', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4163745a-f96c-5b77-8387-4671d90ea7d9', 1, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4163745a-f96c-5b77-8387-4671d90ea7d9', 2, 31.0, NULL, false, '31.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4163745a-f96c-5b77-8387-4671d90ea7d9', 3, 32.0, NULL, false, '32.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4163745a-f96c-5b77-8387-4671d90ea7d9', 4, 39.0, NULL, true, '(39.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '874ddd36-b090-5d36-8398-3b20b753eaca', '25aaa20d-9cc7-53fe-a5a0-d1b5f5f61756', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Shota Fujimoto & Riku Fujishita', '55797', 'crew', 35,
    137.0, 93.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Shota Fujimoto (藤本 翔大), Crew: Riku Fujishita (藤下 理邦). Club: 日南振徳高校. Division: U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'def6e848-a50e-5a88-a5f9-91e68984da2b', '874ddd36-b090-5d36-8398-3b20b753eaca', '25aaa20d-9cc7-53fe-a5a0-d1b5f5f61756', 'Shota Fujimoto', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a6c11476-2a88-532e-90f3-7a982f01db0e', '874ddd36-b090-5d36-8398-3b20b753eaca', '7a923b39-26a8-5578-a29f-e843d74d1a2e', 'Riku Fujishita', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '874ddd36-b090-5d36-8398-3b20b753eaca', 1, 44.0, NULL, true, '(44.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '874ddd36-b090-5d36-8398-3b20b753eaca', 2, 39.0, NULL, false, '39.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '874ddd36-b090-5d36-8398-3b20b753eaca', 3, 33.0, NULL, false, '33.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '874ddd36-b090-5d36-8398-3b20b753eaca', 4, 21.0, NULL, false, '21.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '7c87b316-e21d-5e13-b524-2471405e871d', 'eafb6b18-a37b-5a4b-9f73-3c8ab78cc299', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Hyotaro Azema & Gen Uchida', '56004', 'crew', 36,
    136.0, 94.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Hyotaro Azema (畦間 彪太郎), Crew: Gen Uchida (内田 弦). Club: 碧南セーリングクラブ. Division: U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '6943592d-a67c-5815-b61b-6350ca99e425', '7c87b316-e21d-5e13-b524-2471405e871d', 'eafb6b18-a37b-5a4b-9f73-3c8ab78cc299', 'Hyotaro Azema', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a7771f99-f65b-5881-8c57-606d2bd0207a', '7c87b316-e21d-5e13-b524-2471405e871d', '1532f901-2a00-52d5-bc2b-82ca623c9b2c', 'Gen Uchida', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7c87b316-e21d-5e13-b524-2471405e871d', 1, 30.0, NULL, false, '30.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7c87b316-e21d-5e13-b524-2471405e871d', 2, 23.0, NULL, false, '23.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7c87b316-e21d-5e13-b524-2471405e871d', 3, 41.0, NULL, false, '41.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7c87b316-e21d-5e13-b524-2471405e871d', 4, 42.0, NULL, true, '(42.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '6c350326-a5c3-5f0f-b3ca-83269d4649bc', '823c8645-7014-5734-8a89-0aa2a1739d46', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Miyu Sakaguchi & Ruri Nakayama', '56961', 'crew', 37,
    142.0, 95.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Miyu Sakaguchi (坂口 美結), Crew: Ruri Nakayama (中山 瑠梨). Club: 福岡第一高校/一社)福岡セーリングクラブ. Division: Girls, U17.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c92e534f-6e48-5624-8b60-48675a77addd', '6c350326-a5c3-5f0f-b3ca-83269d4649bc', '823c8645-7014-5734-8a89-0aa2a1739d46', 'Miyu Sakaguchi', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b163b6fe-adbf-560f-9316-829b1d2975b5', '6c350326-a5c3-5f0f-b3ca-83269d4649bc', '55676ff5-7075-5d6e-8aed-f25449467fe6', 'Ruri Nakayama', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c350326-a5c3-5f0f-b3ca-83269d4649bc', 1, 39.0, NULL, false, '39.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c350326-a5c3-5f0f-b3ca-83269d4649bc', 2, 38.0, NULL, false, '38.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c350326-a5c3-5f0f-b3ca-83269d4649bc', 3, 18.0, NULL, false, '18.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6c350326-a5c3-5f0f-b3ca-83269d4649bc', 4, 47.0, NULL, true, '(47.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '25dd75f8-c424-57f3-89ed-9319f1a4b759', 'b88da980-dc3f-5a38-a2fe-c5698c803009', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Hiro Kashio & Naruo Wada', '56716', 'crew', 38,
    133.0, 97.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Hiro Kashio (樫尾 紘), Crew: Naruo Wada (和田 成生). Club: 和歌山県セーリング連盟. Division: U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '79871fcb-17a1-587f-8d70-d81d504a53aa', '25dd75f8-c424-57f3-89ed-9319f1a4b759', 'b88da980-dc3f-5a38-a2fe-c5698c803009', 'Hiro Kashio', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e7b50dd1-910c-557a-b8f9-2df02c97ccf9', '25dd75f8-c424-57f3-89ed-9319f1a4b759', '0472a38c-d6d0-5262-b784-e132e38a0f63', 'Naruo Wada', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25dd75f8-c424-57f3-89ed-9319f1a4b759', 1, 36.0, NULL, true, '(36.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25dd75f8-c424-57f3-89ed-9319f1a4b759', 2, 34.0, NULL, false, '34.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25dd75f8-c424-57f3-89ed-9319f1a4b759', 3, 31.0, NULL, false, '31.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '25dd75f8-c424-57f3-89ed-9319f1a4b759', 4, 32.0, NULL, false, '32.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '38c8b9c2-196b-533d-9c7a-a697170b0817', '0a103a01-a892-5c7f-a671-634fa5565dc9', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Ibuki Watanabe & Shiryu Fujioka', '55936', 'crew', 39,
    159.0, 102.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Ibuki Watanabe (渡邊 依歩輝), Crew: Shiryu Fujioka (藤岡 子龍). Club: 津工業高校ヨット部. Division: U17.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ac85d87b-36d5-5451-8bef-ff418bb98c17', '38c8b9c2-196b-533d-9c7a-a697170b0817', '0a103a01-a892-5c7f-a671-634fa5565dc9', 'Ibuki Watanabe', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd5ebd4dc-051e-5595-8655-820e8fc478e5', '38c8b9c2-196b-533d-9c7a-a697170b0817', 'c9828880-ea2f-56c6-a0f2-7d8c00d85c6b', 'Shiryu Fujioka', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38c8b9c2-196b-533d-9c7a-a697170b0817', 1, 28.0, NULL, false, '28.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38c8b9c2-196b-533d-9c7a-a697170b0817', 2, 29.0, NULL, false, '29.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38c8b9c2-196b-533d-9c7a-a697170b0817', 3, 57.0, 'DNF', true, '(57.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38c8b9c2-196b-533d-9c7a-a697170b0817', 4, 45.0, NULL, false, '45.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '174ce3ca-c82b-539c-bf88-3dd8a7d0d0c5', '8a01c3d7-068f-5199-8a29-1f7dcd259ffe', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Kotaro Kanezaki & Koki Hirota', '54624', 'crew', 40,
    145.0, 104.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Kotaro Kanezaki (金崎 琥太郎), Crew: Koki Hirota (廣田 耕己). Club: 中村学園三陽高等学校. Division: U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd03e8ab1-d573-50d7-86d8-f78ab3cd8581', '174ce3ca-c82b-539c-bf88-3dd8a7d0d0c5', '8a01c3d7-068f-5199-8a29-1f7dcd259ffe', 'Kotaro Kanezaki', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '657c9a31-7aa0-559c-a402-db746d50a2e9', '174ce3ca-c82b-539c-bf88-3dd8a7d0d0c5', 'fbb34bd5-4d5a-5c61-9df1-eb28663b3322', 'Koki Hirota', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '174ce3ca-c82b-539c-bf88-3dd8a7d0d0c5', 1, 40.0, NULL, false, '40.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '174ce3ca-c82b-539c-bf88-3dd8a7d0d0c5', 2, 41.0, NULL, true, '(41.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '174ce3ca-c82b-539c-bf88-3dd8a7d0d0c5', 3, 30.0, NULL, false, '30.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '174ce3ca-c82b-539c-bf88-3dd8a7d0d0c5', 4, 34.0, NULL, false, '34.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '10d75c54-a1fa-5490-9aed-677f9255db7e', 'be8e6612-d612-5d81-af05-55959ed41617', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Hazu Miura & Mito Nagaoka', '56937', 'crew', 41,
    165.0, 108.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Hazu Miura (三浦 波珠), Crew: Mito Nagaoka (長岡 美都). Club: 葉山町セーリング協会. Division: Girls, U17.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ce4009f5-84c7-5ade-b4e5-bfc7c9b9fcb4', '10d75c54-a1fa-5490-9aed-677f9255db7e', 'be8e6612-d612-5d81-af05-55959ed41617', 'Hazu Miura', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '858b917c-c5ac-5146-9aed-eb64e37fcc91', '10d75c54-a1fa-5490-9aed-677f9255db7e', '11cdad5d-56b9-5850-a635-062e9ac793af', 'Mito Nagaoka', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '10d75c54-a1fa-5490-9aed-677f9255db7e', 1, 57.0, 'DNC', true, '(57.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '10d75c54-a1fa-5490-9aed-677f9255db7e', 2, 57.0, NULL, false, '57.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '10d75c54-a1fa-5490-9aed-677f9255db7e', 3, 27.0, NULL, false, '27.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '10d75c54-a1fa-5490-9aed-677f9255db7e', 4, 24.0, NULL, false, '24.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '4c7d629a-f9aa-5d33-8731-dc04a19a2336', '72d3b737-676a-5d43-a29e-8a0f65d6cf09', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Rio Morita & Natsuo Tomitaka', '57142', 'crew', 42,
    152.0, 111.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Rio Morita (森田 莉央), Crew: Natsuo Tomitaka (冨高 夏央). Club: 大分県セーリング連盟. Division: Girls, U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '00a137dc-bb49-5886-bc8d-11fd0d754c49', '4c7d629a-f9aa-5d33-8731-dc04a19a2336', '72d3b737-676a-5d43-a29e-8a0f65d6cf09', 'Rio Morita', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '8870783d-8255-5bc0-99e9-f26accae7f30', '4c7d629a-f9aa-5d33-8731-dc04a19a2336', '14e4d4ab-6f67-5783-b7e0-a4bee8acc8a2', 'Natsuo Tomitaka', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4c7d629a-f9aa-5d33-8731-dc04a19a2336', 1, 38.0, NULL, false, '38.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4c7d629a-f9aa-5d33-8731-dc04a19a2336', 2, 37.0, NULL, false, '37.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4c7d629a-f9aa-5d33-8731-dc04a19a2336', 3, 36.0, NULL, false, '36.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4c7d629a-f9aa-5d33-8731-dc04a19a2336', 4, 41.0, NULL, true, '(41.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '3a14a9fc-a9b4-5482-9ac7-9bbefd647241', 'fc9e5636-074b-5350-b472-a122ac643a62', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Aimi Kameda & Misaki Morihama', '57035', 'crew', 43,
    172.0, 115.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Aimi Kameda (亀田 愛美), Crew: Misaki Morihama (森濱 美咲). Club: 長崎工業高等学校ヨット部. Division: Girls.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '69ca7c07-9f31-5c27-9cf0-95753cabb1a3', '3a14a9fc-a9b4-5482-9ac7-9bbefd647241', 'fc9e5636-074b-5350-b472-a122ac643a62', 'Aimi Kameda', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '33631cc2-9f1e-59a7-83bc-f03c8e55e64f', '3a14a9fc-a9b4-5482-9ac7-9bbefd647241', '8dff5ad3-9cb3-51a8-8850-53c2fb916b0b', 'Misaki Morihama', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a14a9fc-a9b4-5482-9ac7-9bbefd647241', 1, 31.0, NULL, false, '31.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a14a9fc-a9b4-5482-9ac7-9bbefd647241', 2, 33.0, NULL, false, '33.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a14a9fc-a9b4-5482-9ac7-9bbefd647241', 3, 57.0, 'DNF', true, '(57.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3a14a9fc-a9b4-5482-9ac7-9bbefd647241', 4, 51.0, NULL, false, '51.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a77ee914-cb5e-5124-b8dc-790535a8da64', '642b57ba-4135-5d26-af02-71c2af77b4cd', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Sodai Umino & Kanato Miyashita', '56586', 'crew', 44,
    175.0, 118.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Sodai Umino (海野 颯大), Crew: Kanato Miyashita (宮下 叶翔). Club: 宮崎県立宮崎海洋高等学校. Division: U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ee25abd1-6f2a-5ec3-a5a2-9f778fd8dffa', 'a77ee914-cb5e-5124-b8dc-790535a8da64', '642b57ba-4135-5d26-af02-71c2af77b4cd', 'Sodai Umino', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '37c3f8a9-8deb-5a8d-8565-d613291da8a0', 'a77ee914-cb5e-5124-b8dc-790535a8da64', 'dfa37f49-854a-5e38-b15f-583d0ab0702c', 'Kanato Miyashita', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a77ee914-cb5e-5124-b8dc-790535a8da64', 1, 34.0, NULL, false, '34.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a77ee914-cb5e-5124-b8dc-790535a8da64', 2, 36.0, NULL, false, '36.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a77ee914-cb5e-5124-b8dc-790535a8da64', 3, 57.0, 'DNF', true, '(57.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a77ee914-cb5e-5124-b8dc-790535a8da64', 4, 48.0, NULL, false, '48.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '1d74e634-b979-5f71-9898-753692051844', 'fe2f3596-2ba0-514e-a7e2-252eafcc08d6', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Ayaka Sato & Kai Omae', '56349', 'crew', 45,
    175.0, 118.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Ayaka Sato (佐藤 彩香), Crew: Kai Omae (大前 櫂). Club: 葉山町セーリング協会. Division: U17.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e36cd426-c4c0-5faf-89a3-5c3757bc718e', '1d74e634-b979-5f71-9898-753692051844', 'fe2f3596-2ba0-514e-a7e2-252eafcc08d6', 'Ayaka Sato', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '58785a8e-c518-5536-9c43-4ea1e9955168', '1d74e634-b979-5f71-9898-753692051844', 'c0873663-c26a-55a7-90fc-f52149a80b13', 'Kai Omae', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1d74e634-b979-5f71-9898-753692051844', 1, 57.0, 'DNC', true, '(57.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1d74e634-b979-5f71-9898-753692051844', 2, 46.0, NULL, false, '46.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1d74e634-b979-5f71-9898-753692051844', 3, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1d74e634-b979-5f71-9898-753692051844', 4, 37.0, NULL, false, '37.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'cb63dec6-4982-5a6a-99fb-e16b63374018', '1b5e6155-88c2-4e32-b173-24e6bfa54c1c', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Taiki Miura & Ko Nagahori', '54675', 'crew', 46,
    179.0, 122.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Taiki Miura (三浦 太輝), Crew: Ko Nagahori (長堀 滉). Club: ユースチーム東京／中央区ヨット連盟ジュニア. Division: U17.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1c0712ba-fd57-5eaa-957f-9e73f3d1bfff', 'cb63dec6-4982-5a6a-99fb-e16b63374018', '1b5e6155-88c2-4e32-b173-24e6bfa54c1c', 'Taiki Miura', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd290e317-be6d-5ad8-92c1-939b61df4b9b', 'cb63dec6-4982-5a6a-99fb-e16b63374018', '54929eac-b75e-5608-b958-ce4543b75bb2', 'Ko Nagahori', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cb63dec6-4982-5a6a-99fb-e16b63374018', 1, 57.0, 'DNS', true, '(57.0 DNS)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cb63dec6-4982-5a6a-99fb-e16b63374018', 2, 43.0, NULL, false, '43.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cb63dec6-4982-5a6a-99fb-e16b63374018', 3, 39.0, NULL, false, '39.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cb63dec6-4982-5a6a-99fb-e16b63374018', 4, 40.0, NULL, false, '40.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '16ac0c44-a9b9-59ea-87bb-36fbf897bde5', '1768402c-cd57-51d2-87bf-f46a0c05ee07', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Kotaho Kinoshita & Kaede Murata', '54941', 'crew', 47,
    171.0, 127.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Kotaho Kinoshita (木下 琴穂), Crew: Kaede Murata (村田 楓). Club: 和歌山県セーリング連盟. Division: Girls, U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '66aa4d21-f3ec-5ce7-97a3-b23323e16008', '16ac0c44-a9b9-59ea-87bb-36fbf897bde5', '1768402c-cd57-51d2-87bf-f46a0c05ee07', 'Kotaho Kinoshita', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'fecff115-366d-5a80-b220-6bde466939e2', '16ac0c44-a9b9-59ea-87bb-36fbf897bde5', '5e3a39c0-17ee-5947-b744-268b9be4f7eb', 'Kaede Murata', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16ac0c44-a9b9-59ea-87bb-36fbf897bde5', 1, 43.0, NULL, false, '43.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16ac0c44-a9b9-59ea-87bb-36fbf897bde5', 2, 42.0, NULL, false, '42.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16ac0c44-a9b9-59ea-87bb-36fbf897bde5', 3, 42.0, NULL, false, '42.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16ac0c44-a9b9-59ea-87bb-36fbf897bde5', 4, 44.0, NULL, true, '(44.0)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '4c5f34ed-0c18-5a43-9c6d-94777260aab4', 'b0286ebc-3930-5e9c-a259-76cc65153538', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Munetake Hashimoto & Koya Gabeyama', '55066', 'crew', 48,
    189.0, 132.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Munetake Hashimoto (橋本 宗武), Crew: Koya Gabeyama (我部山 耕矢). Club: 香川県立高松商業高等学校. Division: U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'bc3f5ae2-b93c-5ee5-91e6-f475b655eef3', '4c5f34ed-0c18-5a43-9c6d-94777260aab4', 'b0286ebc-3930-5e9c-a259-76cc65153538', 'Munetake Hashimoto', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'dca022ac-7b58-559d-aa37-74b9e0c976ad', '4c5f34ed-0c18-5a43-9c6d-94777260aab4', '6bc87a34-8207-5563-a8fd-71b59e430ad7', 'Koya Gabeyama', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4c5f34ed-0c18-5a43-9c6d-94777260aab4', 1, 57.0, 'DNF', true, '(57.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4c5f34ed-0c18-5a43-9c6d-94777260aab4', 2, 40.0, NULL, false, '40.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4c5f34ed-0c18-5a43-9c6d-94777260aab4', 3, 57.0, NULL, false, '57.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4c5f34ed-0c18-5a43-9c6d-94777260aab4', 4, 35.0, NULL, false, '35.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '7d053862-68cf-5519-a59f-c8d0acc60ae7', 'ca773abb-947a-5cf8-8f34-a4c8c0fe700f', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Raito Matsumoto & Hiroto Watanabe', '55074', 'crew', 49,
    193.0, 136.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Raito Matsumoto (松本 頼都), Crew: Hiroto Watanabe (渡辺 大翔). Club: 宮崎県立宮崎海洋高等学校. Division: U17.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '156f47e8-5e62-5e42-9330-cce29e7d8f41', '7d053862-68cf-5519-a59f-c8d0acc60ae7', 'ca773abb-947a-5cf8-8f34-a4c8c0fe700f', 'Raito Matsumoto', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b76def68-c9c7-59ea-91fd-517f7ef74773', '7d053862-68cf-5519-a59f-c8d0acc60ae7', '40143d00-1b02-5787-9f96-9801b0228059', 'Hiroto Watanabe', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d053862-68cf-5519-a59f-c8d0acc60ae7', 1, 42.0, NULL, false, '42.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d053862-68cf-5519-a59f-c8d0acc60ae7', 2, 45.0, NULL, false, '45.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d053862-68cf-5519-a59f-c8d0acc60ae7', 3, 57.0, 'DNF', true, '(57.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d053862-68cf-5519-a59f-c8d0acc60ae7', 4, 49.0, NULL, false, '49.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'eec4a473-08ab-5a1f-9841-03bc55ed8138', 'c8eade68-b133-5ade-a579-f5623484bbeb', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Yuika Himejima & Saku Yamagata', '57143', 'crew', 50,
    214.0, 157.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Yuika Himejima (姫嶋 唯華), Crew: Saku Yamagata (山形 咲公). Club: 大分県セーリング連盟. Division: Girls, U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '95110524-8954-58df-87bf-549127eb0996', 'eec4a473-08ab-5a1f-9841-03bc55ed8138', 'c8eade68-b133-5ade-a579-f5623484bbeb', 'Yuika Himejima', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '40aa3b60-881d-532e-810d-c9adbf080292', 'eec4a473-08ab-5a1f-9841-03bc55ed8138', '9ff2a8cf-d706-52df-bcbc-4af0e451581a', 'Saku Yamagata', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eec4a473-08ab-5a1f-9841-03bc55ed8138', 1, 57.0, 'DNF', true, '(57.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eec4a473-08ab-5a1f-9841-03bc55ed8138', 2, 57.0, NULL, false, '57.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eec4a473-08ab-5a1f-9841-03bc55ed8138', 3, 57.0, NULL, false, '57.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eec4a473-08ab-5a1f-9841-03bc55ed8138', 4, 43.0, NULL, false, '43.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '60233a99-c37d-54b9-9333-f64c7954a92b', 'ccf08692-22d6-51c6-a78e-0ebd6df6fa34', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Kanata Kakiwa & Shota Hino', '55903', 'crew', 51,
    215.0, 158.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Kanata Kakiwa (垣岩 奏多), Crew: Shota Hino (日野 翔太). Club: 中村学園三陽高等学校. Division: U17.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0459a862-fbbf-5343-ad72-172b9db39455', '60233a99-c37d-54b9-9333-f64c7954a92b', 'ccf08692-22d6-51c6-a78e-0ebd6df6fa34', 'Kanata Kakiwa', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3a6b1135-6eb9-5fd7-b98b-78bbb3898afb', '60233a99-c37d-54b9-9333-f64c7954a92b', 'c3b63fbb-385c-5f16-af39-f3de5265426b', 'Shota Hino', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '60233a99-c37d-54b9-9333-f64c7954a92b', 1, 57.0, 'DNF', true, '(57.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '60233a99-c37d-54b9-9333-f64c7954a92b', 2, 44.0, NULL, false, '44.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '60233a99-c37d-54b9-9333-f64c7954a92b', 3, 57.0, NULL, false, '57.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '60233a99-c37d-54b9-9333-f64c7954a92b', 4, 57.0, NULL, false, '57.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'a5750ecd-5894-5c41-b1b0-967dac714120', '17b67332-4b45-5db2-8b7d-19e30f9453ae', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Kaiki Takasu & Hayato Kato', '56595', 'crew', 52,
    217.0, 160.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Kaiki Takasu (高須 海輝), Crew: Hayato Kato (加藤 迅徒). Club: 碧南セーリングクラブ. Division: U17.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7702a783-6d06-5d9b-bf16-18fddd1f49c2', 'a5750ecd-5894-5c41-b1b0-967dac714120', '17b67332-4b45-5db2-8b7d-19e30f9453ae', 'Kaiki Takasu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3acea459-ddc0-52bb-af7f-e8a8adf5d3f5', 'a5750ecd-5894-5c41-b1b0-967dac714120', '7348068f-8651-53fe-89b5-3725f311327f', 'Hayato Kato', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5750ecd-5894-5c41-b1b0-967dac714120', 1, 57.0, 'DNF', true, '(57.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5750ecd-5894-5c41-b1b0-967dac714120', 2, 57.0, NULL, false, '57.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5750ecd-5894-5c41-b1b0-967dac714120', 3, 57.0, NULL, false, '57.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a5750ecd-5894-5c41-b1b0-967dac714120', 4, 46.0, NULL, false, '46.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '4a7f2b73-aa3a-5f71-b0ac-fe5f4f297d7d', '6be981d5-983a-58f9-bf3d-fd683bff1fe5', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Arisa Muro & Mea Nagura', '56316', 'crew', 53,
    221.0, 164.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Arisa Muro (室 ありさ), Crew: Mea Nagura (名倉 めあ). Club: 碧南セーリングクラブ. Division: Girls.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '19fe9484-4f26-5799-a394-2ec802134915', '4a7f2b73-aa3a-5f71-b0ac-fe5f4f297d7d', '6be981d5-983a-58f9-bf3d-fd683bff1fe5', 'Arisa Muro', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'bd4658a3-34f6-50ad-8741-7d82cc33ae8c', '4a7f2b73-aa3a-5f71-b0ac-fe5f4f297d7d', 'bc2c57c6-653e-58d4-b324-ebe4d05bfc1e', 'Mea Nagura', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4a7f2b73-aa3a-5f71-b0ac-fe5f4f297d7d', 1, 57.0, 'DNF', true, '(57.0 DNF)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4a7f2b73-aa3a-5f71-b0ac-fe5f4f297d7d', 2, 57.0, NULL, false, '57.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4a7f2b73-aa3a-5f71-b0ac-fe5f4f297d7d', 3, 57.0, NULL, false, '57.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4a7f2b73-aa3a-5f71-b0ac-fe5f4f297d7d', 4, 50.0, NULL, false, '50.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'b2685346-db7e-5b5c-bdbd-d6ed64f02d21', '4971cb16-3e90-5752-97b6-b044a0301e27', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Soshi Nagami & Uhiro Hayashi', '56932', 'crew', 54,
    228.0, 171.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Soshi Nagami (永見 宗士), Crew: Uhiro Hayashi (林 宇洋). Club: 福岡第一高校. Division: U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '33e23085-a29d-5e59-9428-a678d8c42dfe', 'b2685346-db7e-5b5c-bdbd-d6ed64f02d21', '4971cb16-3e90-5752-97b6-b044a0301e27', 'Soshi Nagami', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '189662aa-d880-5949-ab8f-bd4592c1137e', 'b2685346-db7e-5b5c-bdbd-d6ed64f02d21', 'de021787-cb74-597d-9360-9803e5203e39', 'Uhiro Hayashi', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b2685346-db7e-5b5c-bdbd-d6ed64f02d21', 1, 57.0, 'DNC', true, '(57.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b2685346-db7e-5b5c-bdbd-d6ed64f02d21', 2, 57.0, NULL, false, '57.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b2685346-db7e-5b5c-bdbd-d6ed64f02d21', 3, 57.0, NULL, false, '57.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b2685346-db7e-5b5c-bdbd-d6ed64f02d21', 4, 57.0, NULL, false, '57.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'fdccd681-172c-56b8-895e-608c96db28eb', '12fb4377-b32e-5abd-898e-d01d0dd6af45', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Sarasa Hirashima & Shiwa Ideta', '55626', 'crew', 54,
    228.0, 171.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Sarasa Hirashima (平嶋 更紗), Crew: Shiwa Ideta (出田 紫和). Club: 長崎工業高等学校ヨット部. Division: Girls, U19.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b3fe66ea-d038-5696-84e9-e4d76c5d1206', 'fdccd681-172c-56b8-895e-608c96db28eb', '12fb4377-b32e-5abd-898e-d01d0dd6af45', 'Sarasa Hirashima', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd1d33c4e-b8a4-5e45-b631-247a7350dd92', 'fdccd681-172c-56b8-895e-608c96db28eb', '2513b875-816b-58bc-8c25-8daaff5e88e3', 'Shiwa Ideta', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fdccd681-172c-56b8-895e-608c96db28eb', 1, 57.0, 'DNC', true, '(57.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fdccd681-172c-56b8-895e-608c96db28eb', 2, 57.0, NULL, false, '57.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fdccd681-172c-56b8-895e-608c96db28eb', 3, 57.0, NULL, false, '57.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fdccd681-172c-56b8-895e-608c96db28eb', 4, 57.0, NULL, false, '57.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '018e3805-bc4f-53b0-a629-8d9e1db60067', 'eba1cbb3-76ee-556a-af0c-3170722ff05a', 'c899bccb-322f-5e67-87bd-2ca65e0dbfee', 'Saki Yamaguchi & Hinata Sugimoto', '54888', 'crew', 54,
    228.0, 171.0, false, false, 'https://www.japan420sailing.org/race_result/2728/',
    'https://www.japan420sailing.org/race_result/2728/', '38th All Japan 420 Championship Official Results PDF',
    'document', 'All Japan 420 Championship 2025. Helm: Saki Yamaguchi (山口 咲葵), Crew: Hinata Sugimoto (杉本 ひなた). Club: 長崎工業高等学校ヨット部OG. Division: Girls.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd32dfa71-e1e7-51a0-b4f3-03200c5b30d9', '018e3805-bc4f-53b0-a629-8d9e1db60067', 'eba1cbb3-76ee-556a-af0c-3170722ff05a', 'Saki Yamaguchi', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '3c06a95a-c335-5c3c-8383-e986ea116d70', '018e3805-bc4f-53b0-a629-8d9e1db60067', 'de1e6579-c814-5b1d-b333-b792bf701cbb', 'Hinata Sugimoto', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '018e3805-bc4f-53b0-a629-8d9e1db60067', 1, 57.0, 'DNC', true, '(57.0 DNC)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '018e3805-bc4f-53b0-a629-8d9e1db60067', 2, 57.0, NULL, false, '57.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '018e3805-bc4f-53b0-a629-8d9e1db60067', 3, 57.0, NULL, false, '57.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '018e3805-bc4f-53b0-a629-8d9e1db60067', 4, 57.0, NULL, false, '57.0'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

COMMIT;
