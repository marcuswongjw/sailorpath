-- Migration 137: Import 49th West Japan Optimist Championship 2026
-- Event: 第49回西日本オプティミスト級セーリング選手権大会
-- Dates: 2026-07-31 to 2026-08-02, Fukuoka City Yacht Harbor (Odo), Fukuoka, Japan
-- Class A: 64 boats, 7 races (1 discard). Class B: 30 boats, 7 races (1 discard).

BEGIN;

-- 1. Regatta Event
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    '49371fb1-63ab-5353-ba3c-659466fe0948',
    '49th West Japan Optimist Championship 2026',
    '49th-west-japan-optimist-championship-2026',
    '2026-07-31',
    '2026-08-02',
    'Fukuoka City Yacht Harbor (Odo), Fukuoka, Japan',
    'West Japan JODA & Fukuoka Sailing Club',
    '["Optimist"]'::jsonb,
    false,
    false,
    '7 completed races over 3 racing days (July 31 - August 2, 2026).',
    'Low Point System with 1 discard after 7 races.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;

-- 2. Regatta Class Sheets (Class A and Class B)
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name
) VALUES (
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '49371fb1-63ab-5353-ba3c-659466fe0948',
    '49th West Japan Optimist Championship 2026 (Class A)',
    '49th-west-japan-optimist-championship-2026-class-a',
    '2026-07-31',
    '2026-08-02',
    64,
    'Class A',
    7,
    'JPN',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Fukuoka City Yacht Harbor (Odo), Fukuoka, Japan',
    'West Japan JODA & Fukuoka Sailing Club',
    'published',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績'
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count;
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name
) VALUES (
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '49371fb1-63ab-5353-ba3c-659466fe0948',
    '49th West Japan Optimist Championship 2026 (Class B)',
    '49th-west-japan-optimist-championship-2026-class-b',
    '2026-07-31',
    '2026-08-02',
    30,
    'Class B',
    7,
    'JPN',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Fukuoka City Yacht Harbor (Odo), Fukuoka, Japan',
    'West Japan JODA & Fukuoka Sailing Club',
    'published',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績'
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count;

-- 3. New Sailor Profiles (74 new profiles)
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('dcc54f4d-b617-5465-a02a-e9374cf448c8', 'Taishi Aoyama', 'opti-jpn-taishi-aoyama-3463', 'JPN 3463', 'JPN', 'M', 'B&G別府海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('95ea388f-2aa4-5d67-97ba-2ad363d82c94', 'Atsuki Kinoshita', 'opti-jpn-atsuki-kinoshita-3270', 'JPN 3270', 'JPN', 'M', 'B&G兵庫ジュニア海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('e9654b43-fcbb-59f6-9ca2-6d95eea04675', 'Saho Miyazaki', 'opti-jpn-saho-miyazaki-3163', 'JPN 3163', 'JPN', 'F', 'B&G兵庫ジュニア海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('561c0b8a-613a-5e0d-8674-79b1debe2ebb', 'Yudai Miyaji', 'opti-jpn-yudai-miyaji-2988', 'JPN 2988', 'JPN', 'M', '瀬戸内ジュニアセーリングクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('5c3eff3d-3a16-506c-96de-861b6cb9abd9', 'Mikito Watanabe', 'opti-jpn-mikito-watanabe-3510', 'JPN 3510', 'JPN', 'M', 'B&G高松海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('6c64e8bd-d1a0-526e-b66e-88ba470b4c1d', 'Rikuto Shiokawa', 'opti-jpn-rikuto-shiokawa-3283', 'JPN 3283', 'JPN', 'M', '広島セーリングスクール')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('b7d594e0-5ac0-5eb9-91eb-47f115074104', 'Hanako Kawakita', 'opti-jpn-hanako-kawakita-3437', 'JPN 3437', 'JPN', 'F', 'B&G高松海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('e210f42c-f575-5e8a-8546-db86dbeb9f7e', 'Shinnosuke Sawamura', 'opti-jpn-shinnosuke-sawamura-3426', 'JPN 3426', 'JPN', 'M', 'B&G福岡ジュニアヨット海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('7ab84ead-c647-53b3-b905-4045acfac377', 'Tsukasa Hirota', 'opti-jpn-tsukasa-hirota-2930', 'JPN 2930', 'JPN', 'M', '琵琶湖ジュニアヨットクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('328e9f20-6d65-5279-b4ae-41eb8565343d', 'Kosaku Okazaki', 'opti-jpn-kosaku-okazaki-3275', 'JPN 3275', 'JPN', 'M', 'B&G高松海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('bfb6cdc3-693b-59fe-920f-dfa21ea37457', 'Ryuutarou Yamauchi', 'opti-jpn-ryuutarou-yamauchi-3392', 'JPN 3392', 'JPN', 'M', 'B&G高松海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('a0d33c75-883c-55a1-91ad-8159b07b5b0d', 'Isshin Miyatake', 'opti-jpn-isshin-miyatake-3224', 'JPN 3224', 'JPN', 'M', '広島セーリングスクール')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('293dfa2f-e955-5053-9a92-d846f5a93164', 'Hitoki Inoue', 'opti-jpn-hitoki-inoue-3239', 'JPN 3239', 'JPN', 'M', 'B&G兵庫ジュニア海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('4e0c0402-8c97-5d4e-a1ec-eb057942d1f0', 'Ryohei Yamaguchi', 'opti-jpn-ryohei-yamaguchi-3416', 'JPN 3416', 'JPN', 'M', '一社)福岡セーリングクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('f75f35c4-9c00-5652-ad25-3d420f1a624c', 'Chikun Boku', 'opti-jpn-chikun-boku-3325', 'JPN 3325', 'JPN', 'M', '博多ハイクアウツジュニアヨットクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('68613c6a-8e51-584c-96b3-f898b9e9418d', 'Sotarou Miyanaga', 'opti-jpn-sotarou-miyanaga-3491', 'JPN 3491', 'JPN', 'M', '一社）石垣海洋少年団＆石垣ジュニアヨットクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('83f74d6f-42e8-52fe-a8d4-1a5b2c9cb6c4', 'Satoshi Toyota', 'opti-jpn-satoshi-toyota-3326', 'JPN 3326', 'JPN', 'M', '瀬戸内ジュニアセーリングクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('6b6f8f4a-3108-5288-af73-f67f3009f4de', 'Kanta Takasaki', 'opti-jpn-kanta-takasaki-3257', 'JPN 3257', 'JPN', 'M', 'B&G福岡ジュニアヨット海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('911910db-2a56-5f9b-9c94-f344c68357bf', 'Chika Yamamoto', 'opti-jpn-chika-yamamoto-3280', 'JPN 3280', 'JPN', 'F', '博多ハイクアウツジュニアヨットクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('2f1b2e31-5c69-5fd5-b56d-81eb700672ee', 'Soma Tomioka', 'opti-jpn-soma-tomioka-3171', 'JPN 3171', 'JPN', 'M', 'B&G高松海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('296aede8-004f-5c15-aa46-40339ad01e1b', 'Yoshitaka Nakano', 'opti-jpn-yoshitaka-nakano-3347', 'JPN 3347', 'JPN', 'M', 'B&G福岡ジュニアヨット海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('563ad55d-8ce5-5ebf-81ab-14b11ce05bc9', 'Sorato Enomoto', 'opti-jpn-sorato-enomoto-3131', 'JPN 3131', 'JPN', 'M', '和歌山ジュニアヨットクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('80cae78d-cb51-5d1f-8430-b43a54c1143f', 'Kohana Yamamoto', 'opti-jpn-kohana-yamamoto-3399', 'JPN 3399', 'JPN', 'F', '一社)福岡セーリングクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('dd8236c3-b48d-5324-adcf-f7d91bf45666', 'Aoi Iwasaki', 'opti-jpn-aoi-iwasaki-3252', 'JPN 3252', 'JPN', 'M', 'B&G高松海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('ab978d87-be24-57db-a016-2189e7ee493f', 'Kai Kaneko', 'opti-jpn-kai-kaneko-3471', 'JPN 3471', 'JPN', 'M', '玄海セーリングジュニアクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('0dd9ad90-2a03-5e0e-908b-cdc671b86a4c', 'Shota Miyazaki', 'opti-jpn-shota-miyazaki-3240', 'JPN 3240', 'JPN', 'M', '博多ハイクアウツジュニアヨットクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('480ebee0-7617-5942-ac38-521a36cb6531', 'Hideaki Shimomura', 'opti-jpn-hideaki-shimomura-3251', 'JPN 3251', 'JPN', 'M', 'B&G高松海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('3722533b-b04f-5ba3-8cd3-4ed5d1af6585', 'Shuntarou Yamaguchi', 'opti-jpn-shuntarou-yamaguchi-3085', 'JPN 3085', 'JPN', 'M', '博多ハイクアウツジュニアヨットクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('a803d5b6-4b1b-589e-a69a-5eb8c513a528', 'Kazuho Miyazaki', 'opti-jpn-kazuho-miyazaki-3311', 'JPN 3311', 'JPN', 'M', 'B&G兵庫ジュニア海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('f91b86e6-bb0b-5a9a-9fc8-a96b17bbd49d', 'Naotarou Ishigaki', 'opti-jpn-naotarou-ishigaki-3490', 'JPN 3490', 'JPN', 'M', '一社）石垣海洋少年団＆石垣ジュニアヨットクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('29480d71-1e0b-52f7-8fcf-262754e9fb47', 'Yukihito Ochi', 'opti-jpn-yukihito-ochi-3368', 'JPN 3368', 'JPN', 'M', 'B&G兵庫ジュニア海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('ad2f058a-0396-5b6a-9e82-b5249393fec3', 'Sota Kimura', 'opti-jpn-sota-kimura-3314', 'JPN 3314', 'JPN', 'M', 'B&G兵庫ジュニア海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('c6b57c5c-01cc-5e9c-ada6-363a17c702c0', 'Fuka Nakagawa', 'opti-jpn-fuka-nakagawa-3276', 'JPN 3276', 'JPN', 'F', '玄海セーリングジュニアクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('8a2ee680-494a-5686-adb9-4015b20f0a76', 'Ken Vandouusen', 'opti-jpn-ken-vandouusen-3237', 'JPN 3237', 'JPN', 'M', 'Ｂ＆Ｇハウステンボス町ジュニア海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('44230f67-3406-527a-9540-b01c9517ca4f', 'Mitsuki Gouda', 'opti-jpn-mitsuki-gouda-3272', 'JPN 3272', 'JPN', 'M', '広島セーリングスクール')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('2db7b7f0-d035-557c-9f76-5adb83a10664', 'Haruma Eda', 'opti-jpn-haruma-eda-2767', 'JPN 2767', 'JPN', 'M', '宮津ジュニアヨットクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('6ddf0abd-ae26-5b95-86d9-ae4c2120fc2b', 'Asahi Matsuo', 'opti-jpn-asahi-matsuo-3186', 'JPN 3186', 'JPN', 'M', 'B&G時津海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('70d0c56c-4095-5534-b367-a6166d734c22', 'Toma Maesono', 'opti-jpn-toma-maesono-3044', 'JPN 3044', 'JPN', 'M', '鹿児島ジュニアヨットクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('a5bbe96a-ee3d-5695-858c-17c8b43d6b90', 'Shunnosuke Kira', 'opti-jpn-shunnosuke-kira-3105', 'JPN 3105', 'JPN', 'M', 'B&G時津海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('be45b088-bfbe-5660-b147-f0dbc2786ba2', 'Miko Matsuura', 'opti-jpn-miko-matsuura-3279', 'JPN 3279', 'JPN', 'F', '玄海セーリングジュニアクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('f61f3ce8-4511-565d-89c3-4957d873b82b', 'Minagi Koshi', 'opti-jpn-minagi-koshi-3042', 'JPN 3042', 'JPN', 'M', '鹿児島ジュニアヨットクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('d039c011-e3d2-5e4e-8ced-1ca85a3e71e4', 'Ouki Umemura', 'opti-jpn-ouki-umemura-3110', 'JPN 3110', 'JPN', 'M', 'B＆G新居浜海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('b1e4fd3c-5d4f-5bda-b847-848263191516', 'Junshi Ou', 'opti-jpn-junshi-ou-3102', 'JPN 3102', 'JPN', 'M', 'B&G松山海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('696c994c-5f41-5ddf-b180-70b2c5f40b9f', 'Mikoto Takahashi', 'opti-jpn-mikoto-takahashi-3104', 'JPN 3104', 'JPN', 'M', 'B&G松山海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('17385aeb-afc4-52a4-8f9b-7ed80ec70b73', 'Riku Adachi', 'opti-jpn-riku-adachi-3406', 'JPN 3406', 'JPN', 'M', '一社)福岡セーリングクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('d4749289-b2f3-5607-9ae1-fa33bdbcdad5', 'Maiko Higaki', 'opti-jpn-maiko-higaki-3434', 'JPN 3434', 'JPN', 'F', 'B&G兵庫ジュニア海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('53d19e4a-4ca4-5cc8-b637-32a195361b3c', 'Atsushi Kubota', 'opti-jpn-atsushi-kubota-3408', 'JPN 3408', 'JPN', 'M', 'B&G福岡ジュニアヨット海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('ce4ae904-7a57-570a-97cf-738e72df4cfb', 'Aoha Oohira', 'opti-jpn-aoha-oohira-3178', 'JPN 3178', 'JPN', 'F', 'B&G兵庫ジュニア海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('a695679e-6669-5758-b472-0de56b552d3a', 'Kodai Shimomura', 'opti-jpn-kodai-shimomura-239', 'JPN 239', 'JPN', 'M', 'B&G兵庫ジュニア海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('3c9f092c-76ef-56f9-a0c9-7e858a2450be', 'Yasuharu Shiroishi', 'opti-jpn-yasuharu-shiroishi-3250', 'JPN 3250', 'JPN', 'M', 'B&G高松海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('151993ac-0601-503e-8931-61459413489f', 'Ema Yamate', 'opti-jpn-ema-yamate-3419', 'JPN 3419', 'JPN', 'F', '一社)福岡セーリングクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('7323557f-08b2-5fcd-a0c6-965bc4fb5ba2', 'Amane Yamamoto', 'opti-jpn-amane-yamamoto-3420', 'JPN 3420', 'JPN', 'M', '一社)福岡セーリングクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('5af2bcfc-6aaf-56dc-8b53-5ed1e322ef7f', 'Buntarou Yamate', 'opti-jpn-buntarou-yamate-3418', 'JPN 3418', 'JPN', 'M', '一社)福岡セーリングクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('9ca50e97-0c1a-528c-8aee-77d3752d6e9c', 'Hana Nakazawa', 'opti-jpn-hana-nakazawa-3462', 'JPN 3462', 'JPN', 'F', 'B&G兵庫ジュニア海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('8972d9cd-8a0c-5848-b586-34f49cb7680a', 'Youma Tsujino', 'opti-jpn-youma-tsujino-2942', 'JPN 2942', 'JPN', 'M', '広島セーリングスクール')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('914e5690-a53e-57f6-845b-d6a855de33af', 'Riho Sawamura', 'opti-jpn-riho-sawamura-3286', 'JPN 3286', 'JPN', 'F', 'B&G福岡ジュニアヨット海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('86f35eee-b2b0-55d2-9f95-b25bf3939762', 'Takumi Izumaru', 'opti-jpn-takumi-izumaru-3427', 'JPN 3427', 'JPN', 'M', 'B&G兵庫ジュニア海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('f0f73b54-a171-5968-a9a5-b8d3bdbedcda', 'Soma Sako', 'opti-jpn-soma-sako-3364', 'JPN 3364', 'JPN', 'M', '鹿児島ジュニアヨットクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('63f38113-ed71-5337-b0fb-cd047c6e0f5c', 'Keishuu Ueki', 'opti-jpn-keishuu-ueki-2619', 'JPN 2619', 'JPN', 'M', 'B&G時津海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('16983245-a74f-5b1c-811c-f9287c03e699', 'Rikako Tagami', 'opti-jpn-rikako-tagami-3243', 'JPN 3243', 'JPN', 'F', '一社)福岡セーリングクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('161cc46a-9659-58d3-be97-0aaf1605dc07', 'Hanamaru Ukai', 'opti-jpn-hanamaru-ukai-3463', 'JPN 3463', 'JPN', 'M', 'B&G別府海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('390a1506-cdbf-598e-bffe-6c77a50bfbad', 'Tamaki Tanaka', 'opti-jpn-tamaki-tanaka-2986', 'JPN 2986', 'JPN', 'F', 'B&G兵庫ジュニア海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('73892d6c-7f16-5b32-aff0-0d717f85edde', 'Kazuma Fukahori', 'opti-jpn-kazuma-fukahori-2618', 'JPN 2618', 'JPN', 'M', 'B&G時津海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('15ddf966-8cd9-5da9-8192-6cfa3f09e0cf', 'Ayano Sakurai', 'opti-jpn-ayano-sakurai-3004', 'JPN 3004', 'JPN', 'F', '北九州ジュニアヨットクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('6775e734-c818-53c9-8fad-e8bd749e2740', 'Ayumu Matsuo', 'opti-jpn-ayumu-matsuo-2616', 'JPN 2616', 'JPN', 'M', 'B&G時津海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('1b120673-9333-56cd-93cc-177139ee9000', 'Takuma Sako', 'opti-jpn-takuma-sako-2819', 'JPN 2819', 'JPN', 'M', '鹿児島ジュニアヨットクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('c62bc809-1e57-5653-899a-737a1b8a4349', 'Yuki Nagao', 'opti-jpn-yuki-nagao-3172', 'JPN 3172', 'JPN', 'M', 'B&G高松海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('a441ee16-32a6-5559-8e28-0f3f0b0abb07', 'Hiroshi Ou', 'opti-jpn-hiroshi-ou-3102', 'JPN 3102', 'JPN', 'M', 'B&G松山海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('c140fbe4-211e-592a-a28f-431cfa7aa4b0', 'Kasumi Nagayama', 'opti-jpn-kasumi-nagayama-2664', 'JPN 2664', 'JPN', 'F', 'B&G福岡ジュニアヨット海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('07228aa1-03fb-5eac-9292-ca54fb5f4921', 'Honoka Shiokawa', 'opti-jpn-honoka-shiokawa-3225', 'JPN 3225', 'JPN', 'F', '広島セーリングスクール')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('d7d4caf7-b0ae-5bbb-ba73-abae87cbbd16', 'Mizuho Irie', 'opti-jpn-mizuho-irie-9', 'JPN 9', 'JPN', 'M', '一社)福岡セーリングクラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('1d6a7924-ff83-5128-9e2d-a07a3cb10e9d', 'Takiko Minehira', 'opti-jpn-takiko-minehira-1', 'JPN 1', 'JPN', 'F', 'B＆G新居浜海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('f2659406-cdbc-55fb-b6bb-760cd11e2d0e', 'Misaki Tanaka', 'opti-jpn-misaki-tanaka-2983', 'JPN 2983', 'JPN', 'F', 'B&G松山海洋クラブ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('ffea3548-0341-59c3-9e67-2f78872746af', 'Taichi Yuasa', 'opti-jpn-taichi-yuasa-3059', 'JPN 3059', 'JPN', 'M', 'B&G別府海洋クラブ')
ON CONFLICT (id) DO NOTHING;

-- 4. Sailor Aliases (Kanji names)
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('0c3ea04a-905c-45f1-abb7-a4a917e7da14', '久保田 夏実')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('0c3ea04a-905c-45f1-abb7-a4a917e7da14', '久保田夏実')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5f6d71a5-1dc3-599c-b9be-377150d4dd3a', '村中 菜々')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5f6d71a5-1dc3-599c-b9be-377150d4dd3a', '村中菜々')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('e36afcc6-d8af-589b-88a8-fa608d94a470', '井上 はる')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('e36afcc6-d8af-589b-88a8-fa608d94a470', '井上はる')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5630e6fd-a5f6-537f-8754-461b642feccd', '山本 健瑚')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5630e6fd-a5f6-537f-8754-461b642feccd', '山本健瑚')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5fd47d5e-bc45-545d-8daa-0cc63bc1c84e', '安藤 果帆')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5fd47d5e-bc45-545d-8daa-0cc63bc1c84e', '安藤果帆')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f0bd203e-94f4-5484-8ddf-cbdd19aab450', '笠木 蓮斗')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f0bd203e-94f4-5484-8ddf-cbdd19aab450', '笠木蓮斗')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('823c8645-7014-5734-8a89-0aa2a1739d46', '坂口 美結')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('823c8645-7014-5734-8a89-0aa2a1739d46', '坂口美結')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c764b218-e565-5b0b-905e-d56b0c7d4a9d', '檜垣 菜々子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c764b218-e565-5b0b-905e-d56b0c7d4a9d', '檜垣菜々子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c0a8cdf2-00af-5908-bb52-6f52f8d26e21', '栗本 悠里')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c0a8cdf2-00af-5908-bb52-6f52f8d26e21', '栗本悠里')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2b82f965-5e0d-5063-bb05-b3f1cf099740', '竹内 海聖')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2b82f965-5e0d-5063-bb05-b3f1cf099740', '竹内海聖')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('e373e71d-025b-55b0-acf6-ce6dfb8eb06c', '吉岡 祐月')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('e373e71d-025b-55b0-acf6-ce6dfb8eb06c', '吉岡祐月')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ed754d7e-169a-587a-9cd6-d8ca4eb79027', '永見 波奈')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ed754d7e-169a-587a-9cd6-d8ca4eb79027', '永見波奈')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ff62d4d8-c48a-587d-ab98-b19b551126cb', '岩﨑 楓太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ff62d4d8-c48a-587d-ab98-b19b551126cb', '岩﨑楓太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('dcc54f4d-b617-5465-a02a-e9374cf448c8', '青山 大志')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('dcc54f4d-b617-5465-a02a-e9374cf448c8', '青山大志')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('95ea388f-2aa4-5d67-97ba-2ad363d82c94', '木下 純希')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('95ea388f-2aa4-5d67-97ba-2ad363d82c94', '木下純希')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('e9654b43-fcbb-59f6-9ca2-6d95eea04675', '宮﨑 咲帆')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('e9654b43-fcbb-59f6-9ca2-6d95eea04675', '宮﨑咲帆')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('561c0b8a-613a-5e0d-8674-79b1debe2ebb', '宮地 雄大')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('561c0b8a-613a-5e0d-8674-79b1debe2ebb', '宮地雄大')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5c3eff3d-3a16-506c-96de-861b6cb9abd9', '渡邉 幹人')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5c3eff3d-3a16-506c-96de-861b6cb9abd9', '渡邉幹人')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('659a7737-50cd-5c70-ae0b-7827574aac17', '宮崎 心桜')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('659a7737-50cd-5c70-ae0b-7827574aac17', '宮崎心桜')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('046f010b-9c1c-5f1a-9646-267d9b5a36a5', '仲山 結夏')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('046f010b-9c1c-5f1a-9646-267d9b5a36a5', '仲山結夏')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1ceeb9fd-977e-5c55-bec1-1a0b14846e1b', '廣田 穣')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1ceeb9fd-977e-5c55-bec1-1a0b14846e1b', '廣田穣')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2e9a2d64-59c9-58e5-93c7-060df21e4417', '今村 颯人')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2e9a2d64-59c9-58e5-93c7-060df21e4417', '今村颯人')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6c64e8bd-d1a0-526e-b66e-88ba470b4c1d', '汐川 陸人')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6c64e8bd-d1a0-526e-b66e-88ba470b4c1d', '汐川陸人')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b7d594e0-5ac0-5eb9-91eb-47f115074104', '川北 華子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b7d594e0-5ac0-5eb9-91eb-47f115074104', '川北華子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('234b96c7-73e8-59f9-832d-6d9015917659', '宮武 大我')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('234b96c7-73e8-59f9-832d-6d9015917659', '宮武大我')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('136afe66-3153-513f-b61e-20a2225c0bfb', '井上 豊海')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('136afe66-3153-513f-b61e-20a2225c0bfb', '井上豊海')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('e210f42c-f575-5e8a-8546-db86dbeb9f7e', '澤村 真之介')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('e210f42c-f575-5e8a-8546-db86dbeb9f7e', '澤村真之介')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1ebfc70d-f150-581f-92fd-df32debbae3e', '枝 大耀')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1ebfc70d-f150-581f-92fd-df32debbae3e', '枝大耀')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('7ab84ead-c647-53b3-b905-4045acfac377', '廣田 士')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('7ab84ead-c647-53b3-b905-4045acfac377', '廣田士')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('328e9f20-6d65-5279-b4ae-41eb8565343d', '岡﨑 亘作')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('328e9f20-6d65-5279-b4ae-41eb8565343d', '岡﨑亘作')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('bfb6cdc3-693b-59fe-920f-dfa21ea37457', '山内 琉太郎')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('bfb6cdc3-693b-59fe-920f-dfa21ea37457', '山内琉太郎')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a0d33c75-883c-55a1-91ad-8159b07b5b0d', '宮武 一心')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a0d33c75-883c-55a1-91ad-8159b07b5b0d', '宮武一心')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('293dfa2f-e955-5053-9a92-d846f5a93164', '井上 仁希')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('293dfa2f-e955-5053-9a92-d846f5a93164', '井上仁希')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('4e0c0402-8c97-5d4e-a1ec-eb057942d1f0', '山口 凌平')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('4e0c0402-8c97-5d4e-a1ec-eb057942d1f0', '山口凌平')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f75f35c4-9c00-5652-ad25-3d420f1a624c', '朴 智勛')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f75f35c4-9c00-5652-ad25-3d420f1a624c', '朴智勛')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('68613c6a-8e51-584c-96b3-f898b9e9418d', '宮永 聖汰朗')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('68613c6a-8e51-584c-96b3-f898b9e9418d', '宮永聖汰朗')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('83f74d6f-42e8-52fe-a8d4-1a5b2c9cb6c4', '豊田 慧')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('83f74d6f-42e8-52fe-a8d4-1a5b2c9cb6c4', '豊田慧')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6b6f8f4a-3108-5288-af73-f67f3009f4de', '高﨑 勘太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6b6f8f4a-3108-5288-af73-f67f3009f4de', '高﨑勘太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('911910db-2a56-5f9b-9c94-f344c68357bf', '山本 千華')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('911910db-2a56-5f9b-9c94-f344c68357bf', '山本千華')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2f1b2e31-5c69-5fd5-b56d-81eb700672ee', '冨岡 奏馬')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2f1b2e31-5c69-5fd5-b56d-81eb700672ee', '冨岡奏馬')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('296aede8-004f-5c15-aa46-40339ad01e1b', '中野 嘉隆')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('296aede8-004f-5c15-aa46-40339ad01e1b', '中野嘉隆')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('563ad55d-8ce5-5ebf-81ab-14b11ce05bc9', '榎本 昊透')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('563ad55d-8ce5-5ebf-81ab-14b11ce05bc9', '榎本昊透')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('80cae78d-cb51-5d1f-8430-b43a54c1143f', '山本 小華')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('80cae78d-cb51-5d1f-8430-b43a54c1143f', '山本小華')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('dd8236c3-b48d-5324-adcf-f7d91bf45666', '岩﨑 蒼')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('dd8236c3-b48d-5324-adcf-f7d91bf45666', '岩﨑蒼')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ab978d87-be24-57db-a016-2189e7ee493f', '金子 和生')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ab978d87-be24-57db-a016-2189e7ee493f', '金子和生')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('0dd9ad90-2a03-5e0e-908b-cdc671b86a4c', '宮崎 翔太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('0dd9ad90-2a03-5e0e-908b-cdc671b86a4c', '宮崎翔太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('480ebee0-7617-5942-ac38-521a36cb6531', '下村 英昭')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('480ebee0-7617-5942-ac38-521a36cb6531', '下村英昭')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('3722533b-b04f-5ba3-8cd3-4ed5d1af6585', '山口 駿太郎')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('3722533b-b04f-5ba3-8cd3-4ed5d1af6585', '山口駿太郎')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a803d5b6-4b1b-589e-a69a-5eb8c513a528', '宮﨑 一帆')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a803d5b6-4b1b-589e-a69a-5eb8c513a528', '宮﨑一帆')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f91b86e6-bb0b-5a9a-9fc8-a96b17bbd49d', '石垣 直太郎')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f91b86e6-bb0b-5a9a-9fc8-a96b17bbd49d', '石垣直太郎')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('29480d71-1e0b-52f7-8fcf-262754e9fb47', '越智 祥史')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('29480d71-1e0b-52f7-8fcf-262754e9fb47', '越智祥史')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ad2f058a-0396-5b6a-9e82-b5249393fec3', '木村 奏太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ad2f058a-0396-5b6a-9e82-b5249393fec3', '木村奏太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c6b57c5c-01cc-5e9c-ada6-363a17c702c0', '中川 楓香')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c6b57c5c-01cc-5e9c-ada6-363a17c702c0', '中川楓香')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('8a2ee680-494a-5686-adb9-4015b20f0a76', 'ヴァンドｳーセン 元')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('8a2ee680-494a-5686-adb9-4015b20f0a76', 'ヴァンドｳーセン元')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('44230f67-3406-527a-9540-b01c9517ca4f', '合田 光希')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('44230f67-3406-527a-9540-b01c9517ca4f', '合田光希')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2db7b7f0-d035-557c-9f76-5adb83a10664', '枝 大真')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2db7b7f0-d035-557c-9f76-5adb83a10664', '枝大真')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6ddf0abd-ae26-5b95-86d9-ae4c2120fc2b', '松尾 昂')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6ddf0abd-ae26-5b95-86d9-ae4c2120fc2b', '松尾昂')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('70d0c56c-4095-5534-b367-a6166d734c22', '前薗 冬真')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('70d0c56c-4095-5534-b367-a6166d734c22', '前薗冬真')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a5bbe96a-ee3d-5695-858c-17c8b43d6b90', '吉良 駿之介')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a5bbe96a-ee3d-5695-858c-17c8b43d6b90', '吉良駿之介')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('be45b088-bfbe-5660-b147-f0dbc2786ba2', '松浦 美虹')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('be45b088-bfbe-5660-b147-f0dbc2786ba2', '松浦美虹')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f61f3ce8-4511-565d-89c3-4957d873b82b', '合志 心凪')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f61f3ce8-4511-565d-89c3-4957d873b82b', '合志心凪')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d039c011-e3d2-5e4e-8ced-1ca85a3e71e4', '梅村 旺来')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d039c011-e3d2-5e4e-8ced-1ca85a3e71e4', '梅村旺来')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b1e4fd3c-5d4f-5bda-b847-848263191516', '王 詢之')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b1e4fd3c-5d4f-5bda-b847-848263191516', '王詢之')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('696c994c-5f41-5ddf-b180-70b2c5f40b9f', '髙橋 実言')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('696c994c-5f41-5ddf-b180-70b2c5f40b9f', '髙橋実言')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('17385aeb-afc4-52a4-8f9b-7ed80ec70b73', '安達 陸')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('17385aeb-afc4-52a4-8f9b-7ed80ec70b73', '安達陸')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d4749289-b2f3-5607-9ae1-fa33bdbcdad5', '檜垣 麻衣子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d4749289-b2f3-5607-9ae1-fa33bdbcdad5', '檜垣麻衣子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('53d19e4a-4ca4-5cc8-b637-32a195361b3c', '久保田 聖')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('53d19e4a-4ca4-5cc8-b637-32a195361b3c', '久保田聖')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ce4ae904-7a57-570a-97cf-738e72df4cfb', '大平 碧波')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ce4ae904-7a57-570a-97cf-738e72df4cfb', '大平碧波')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a695679e-6669-5758-b472-0de56b552d3a', '下村 航大')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a695679e-6669-5758-b472-0de56b552d3a', '下村航大')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('3c9f092c-76ef-56f9-a0c9-7e858a2450be', '城石 靖春')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('3c9f092c-76ef-56f9-a0c9-7e858a2450be', '城石靖春')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('151993ac-0601-503e-8931-61459413489f', '山手 絵万')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('151993ac-0601-503e-8931-61459413489f', '山手絵万')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('7323557f-08b2-5fcd-a0c6-965bc4fb5ba2', '山本 周')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('7323557f-08b2-5fcd-a0c6-965bc4fb5ba2', '山本周')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5af2bcfc-6aaf-56dc-8b53-5ed1e322ef7f', '山手 文太郎')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5af2bcfc-6aaf-56dc-8b53-5ed1e322ef7f', '山手文太郎')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('9ca50e97-0c1a-528c-8aee-77d3752d6e9c', '中澤 はな')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('9ca50e97-0c1a-528c-8aee-77d3752d6e9c', '中澤はな')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('8972d9cd-8a0c-5848-b586-34f49cb7680a', '辻野 陽真')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('8972d9cd-8a0c-5848-b586-34f49cb7680a', '辻野陽真')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('914e5690-a53e-57f6-845b-d6a855de33af', '澤村 莉帆')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('914e5690-a53e-57f6-845b-d6a855de33af', '澤村莉帆')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('86f35eee-b2b0-55d2-9f95-b25bf3939762', '伊豆丸 巧')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('86f35eee-b2b0-55d2-9f95-b25bf3939762', '伊豆丸巧')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f0f73b54-a171-5968-a9a5-b8d3bdbedcda', '迫 宗摩')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f0f73b54-a171-5968-a9a5-b8d3bdbedcda', '迫宗摩')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('63f38113-ed71-5337-b0fb-cd047c6e0f5c', '植木 慶修')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('63f38113-ed71-5337-b0fb-cd047c6e0f5c', '植木慶修')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('16983245-a74f-5b1c-811c-f9287c03e699', '田上 莉佳子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('16983245-a74f-5b1c-811c-f9287c03e699', '田上莉佳子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('161cc46a-9659-58d3-be97-0aaf1605dc07', '鵜飼 花丸')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('161cc46a-9659-58d3-be97-0aaf1605dc07', '鵜飼花丸')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('390a1506-cdbf-598e-bffe-6c77a50bfbad', '田中 環')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('390a1506-cdbf-598e-bffe-6c77a50bfbad', '田中環')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('73892d6c-7f16-5b32-aff0-0d717f85edde', '深堀 一真')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('73892d6c-7f16-5b32-aff0-0d717f85edde', '深堀一真')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('15ddf966-8cd9-5da9-8192-6cfa3f09e0cf', '櫻井 綺乃')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('15ddf966-8cd9-5da9-8192-6cfa3f09e0cf', '櫻井綺乃')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6775e734-c818-53c9-8fad-e8bd749e2740', '松尾 歩')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6775e734-c818-53c9-8fad-e8bd749e2740', '松尾歩')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1b120673-9333-56cd-93cc-177139ee9000', '迫 拓摩')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1b120673-9333-56cd-93cc-177139ee9000', '迫拓摩')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c62bc809-1e57-5653-899a-737a1b8a4349', '長尾 優希')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c62bc809-1e57-5653-899a-737a1b8a4349', '長尾優希')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a441ee16-32a6-5559-8e28-0f3f0b0abb07', '王 博之')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a441ee16-32a6-5559-8e28-0f3f0b0abb07', '王博之')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c140fbe4-211e-592a-a28f-431cfa7aa4b0', '長山 花純')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c140fbe4-211e-592a-a28f-431cfa7aa4b0', '長山花純')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('07228aa1-03fb-5eac-9292-ca54fb5f4921', '汐川 帆香')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('07228aa1-03fb-5eac-9292-ca54fb5f4921', '汐川帆香')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d7d4caf7-b0ae-5bbb-ba73-abae87cbbd16', '入江 瑞穂')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d7d4caf7-b0ae-5bbb-ba73-abae87cbbd16', '入江瑞穂')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1d6a7924-ff83-5128-9e2d-a07a3cb10e9d', '峰平 多喜子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1d6a7924-ff83-5128-9e2d-a07a3cb10e9d', '峰平多喜子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f2659406-cdbc-55fb-b6bb-760cd11e2d0e', '田中 美咲')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f2659406-cdbc-55fb-b6bb-760cd11e2d0e', '田中美咲')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ffea3548-0341-59c3-9e67-2f78872746af', '湯浅 汰一')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ffea3548-0341-59c3-9e67-2f78872746af', '湯浅汰一')
ON CONFLICT (alias_name) DO NOTHING;

-- 5. Regatta Results: Class A (64 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '731107b8-21ac-5e18-8a17-a36bdfe687f1',
    '0c3ea04a-905c-45f1-abb7-a4a917e7da14',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '久保田 夏実',
    'JPN 3375',
    'individual',
    1,
    17.0,
    13.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'dbee0684-488b-56c4-94b5-81f1c38b9e62',
    '731107b8-21ac-5e18-8a17-a36bdfe687f1',
    '0c3ea04a-905c-45f1-abb7-a4a917e7da14',
    '久保田 夏実',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '731107b8-21ac-5e18-8a17-a36bdfe687f1',
    1,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '731107b8-21ac-5e18-8a17-a36bdfe687f1',
    2,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '731107b8-21ac-5e18-8a17-a36bdfe687f1',
    3,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '731107b8-21ac-5e18-8a17-a36bdfe687f1',
    4,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '731107b8-21ac-5e18-8a17-a36bdfe687f1',
    5,
    4.0,
    NULL,
    true,
    '(4.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '731107b8-21ac-5e18-8a17-a36bdfe687f1',
    6,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '731107b8-21ac-5e18-8a17-a36bdfe687f1',
    7,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '4dc517c8-2ad7-5a48-8bb6-015b070bc82a',
    '5f6d71a5-1dc3-599c-b9be-377150d4dd3a',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '村中 菜々',
    'JPN 3356',
    'individual',
    2,
    24.0,
    16.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '42f24767-d212-5341-88cb-7c83c9361bd8',
    '4dc517c8-2ad7-5a48-8bb6-015b070bc82a',
    '5f6d71a5-1dc3-599c-b9be-377150d4dd3a',
    '村中 菜々',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4dc517c8-2ad7-5a48-8bb6-015b070bc82a',
    1,
    8.0,
    NULL,
    true,
    '(8.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4dc517c8-2ad7-5a48-8bb6-015b070bc82a',
    2,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4dc517c8-2ad7-5a48-8bb6-015b070bc82a',
    3,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4dc517c8-2ad7-5a48-8bb6-015b070bc82a',
    4,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4dc517c8-2ad7-5a48-8bb6-015b070bc82a',
    5,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4dc517c8-2ad7-5a48-8bb6-015b070bc82a',
    6,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4dc517c8-2ad7-5a48-8bb6-015b070bc82a',
    7,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '2e6df2e9-8721-5996-9927-2e68ec946372',
    'e36afcc6-d8af-589b-88a8-fa608d94a470',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '井上 はる',
    'JPN 3489',
    'individual',
    3,
    33.0,
    20.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c1b7f5b7-b65a-5d7c-9628-2b03fc0bdf67',
    '2e6df2e9-8721-5996-9927-2e68ec946372',
    'e36afcc6-d8af-589b-88a8-fa608d94a470',
    '井上 はる',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e6df2e9-8721-5996-9927-2e68ec946372',
    1,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e6df2e9-8721-5996-9927-2e68ec946372',
    2,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e6df2e9-8721-5996-9927-2e68ec946372',
    3,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e6df2e9-8721-5996-9927-2e68ec946372',
    4,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e6df2e9-8721-5996-9927-2e68ec946372',
    5,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e6df2e9-8721-5996-9927-2e68ec946372',
    6,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e6df2e9-8721-5996-9927-2e68ec946372',
    7,
    13.0,
    NULL,
    true,
    '(13.0)'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '558e39fd-b6e4-59d9-9743-b11f8a548b0f',
    '5630e6fd-a5f6-537f-8754-461b642feccd',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '山本 健瑚',
    'JPN 3441',
    'individual',
    4,
    37.0,
    21.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2fe9d8c3-ad48-5229-b27a-1e02bb98247e',
    '558e39fd-b6e4-59d9-9743-b11f8a548b0f',
    '5630e6fd-a5f6-537f-8754-461b642feccd',
    '山本 健瑚',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '558e39fd-b6e4-59d9-9743-b11f8a548b0f',
    1,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '558e39fd-b6e4-59d9-9743-b11f8a548b0f',
    2,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '558e39fd-b6e4-59d9-9743-b11f8a548b0f',
    3,
    16.0,
    NULL,
    true,
    '(16.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '558e39fd-b6e4-59d9-9743-b11f8a548b0f',
    4,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '558e39fd-b6e4-59d9-9743-b11f8a548b0f',
    5,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '558e39fd-b6e4-59d9-9743-b11f8a548b0f',
    6,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '558e39fd-b6e4-59d9-9743-b11f8a548b0f',
    7,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'e13f4887-70da-5992-9f83-af0c70432264',
    '5fd47d5e-bc45-545d-8daa-0cc63bc1c84e',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '安藤 果帆',
    'JPN 3455',
    'individual',
    5,
    52.0,
    37.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a12c6b21-3556-51be-b392-278000e6bd10',
    'e13f4887-70da-5992-9f83-af0c70432264',
    '5fd47d5e-bc45-545d-8daa-0cc63bc1c84e',
    '安藤 果帆',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e13f4887-70da-5992-9f83-af0c70432264',
    1,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e13f4887-70da-5992-9f83-af0c70432264',
    2,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e13f4887-70da-5992-9f83-af0c70432264',
    3,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e13f4887-70da-5992-9f83-af0c70432264',
    4,
    15.0,
    NULL,
    true,
    '(15.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e13f4887-70da-5992-9f83-af0c70432264',
    5,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e13f4887-70da-5992-9f83-af0c70432264',
    6,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e13f4887-70da-5992-9f83-af0c70432264',
    7,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'e44aeaa4-20c5-5ebb-9c87-db5f47b9b845',
    'f0bd203e-94f4-5484-8ddf-cbdd19aab450',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '笠木 蓮斗',
    'JPN 3430',
    'individual',
    6,
    63.0,
    46.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4e7ec516-a81f-5785-8e79-4cae66e17e22',
    'e44aeaa4-20c5-5ebb-9c87-db5f47b9b845',
    'f0bd203e-94f4-5484-8ddf-cbdd19aab450',
    '笠木 蓮斗',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e44aeaa4-20c5-5ebb-9c87-db5f47b9b845',
    1,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e44aeaa4-20c5-5ebb-9c87-db5f47b9b845',
    2,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e44aeaa4-20c5-5ebb-9c87-db5f47b9b845',
    3,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e44aeaa4-20c5-5ebb-9c87-db5f47b9b845',
    4,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e44aeaa4-20c5-5ebb-9c87-db5f47b9b845',
    5,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e44aeaa4-20c5-5ebb-9c87-db5f47b9b845',
    6,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e44aeaa4-20c5-5ebb-9c87-db5f47b9b845',
    7,
    17.0,
    NULL,
    true,
    '(17.0)'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '093de6f0-a027-5914-aa11-0684c67ff6e9',
    '823c8645-7014-5734-8a89-0aa2a1739d46',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '坂口 美結',
    'JPN 3415',
    'individual',
    7,
    61.0,
    47.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b24cebb9-3f34-5f48-b348-7227a002403b',
    '093de6f0-a027-5914-aa11-0684c67ff6e9',
    '823c8645-7014-5734-8a89-0aa2a1739d46',
    '坂口 美結',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '093de6f0-a027-5914-aa11-0684c67ff6e9',
    1,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '093de6f0-a027-5914-aa11-0684c67ff6e9',
    2,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '093de6f0-a027-5914-aa11-0684c67ff6e9',
    3,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '093de6f0-a027-5914-aa11-0684c67ff6e9',
    4,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '093de6f0-a027-5914-aa11-0684c67ff6e9',
    5,
    14.0,
    NULL,
    true,
    '(14.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '093de6f0-a027-5914-aa11-0684c67ff6e9',
    6,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '093de6f0-a027-5914-aa11-0684c67ff6e9',
    7,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '7263e979-1627-5f4d-befc-fc8cd3e46740',
    'c764b218-e565-5b0b-905e-d56b0c7d4a9d',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '檜垣 菜々子',
    'JPN 3434',
    'individual',
    8,
    71.0,
    54.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a68cf7c9-8136-53e3-a33e-e7f87c619985',
    '7263e979-1627-5f4d-befc-fc8cd3e46740',
    'c764b218-e565-5b0b-905e-d56b0c7d4a9d',
    '檜垣 菜々子',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7263e979-1627-5f4d-befc-fc8cd3e46740',
    1,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7263e979-1627-5f4d-befc-fc8cd3e46740',
    2,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7263e979-1627-5f4d-befc-fc8cd3e46740',
    3,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7263e979-1627-5f4d-befc-fc8cd3e46740',
    4,
    17.0,
    NULL,
    true,
    '(17.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7263e979-1627-5f4d-befc-fc8cd3e46740',
    5,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7263e979-1627-5f4d-befc-fc8cd3e46740',
    6,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7263e979-1627-5f4d-befc-fc8cd3e46740',
    7,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'c04bd567-3f3a-5615-b724-971084d3f517',
    'c0a8cdf2-00af-5908-bb52-6f52f8d26e21',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '栗本 悠里',
    'JPN 3458',
    'individual',
    9,
    72.0,
    56.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '816c86d5-028f-51ca-adb2-ec62536d0c93',
    'c04bd567-3f3a-5615-b724-971084d3f517',
    'c0a8cdf2-00af-5908-bb52-6f52f8d26e21',
    '栗本 悠里',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c04bd567-3f3a-5615-b724-971084d3f517',
    1,
    16.0,
    NULL,
    true,
    '(16.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c04bd567-3f3a-5615-b724-971084d3f517',
    2,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c04bd567-3f3a-5615-b724-971084d3f517',
    3,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c04bd567-3f3a-5615-b724-971084d3f517',
    4,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c04bd567-3f3a-5615-b724-971084d3f517',
    5,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c04bd567-3f3a-5615-b724-971084d3f517',
    6,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c04bd567-3f3a-5615-b724-971084d3f517',
    7,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '03170288-a92e-5f15-9015-eb6edfc96272',
    '2b82f965-5e0d-5063-bb05-b3f1cf099740',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '竹内 海聖',
    'JPN 3344',
    'individual',
    10,
    72.0,
    57.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'dafaca0b-79bb-51b2-9f63-812b6f5a2a9b',
    '03170288-a92e-5f15-9015-eb6edfc96272',
    '2b82f965-5e0d-5063-bb05-b3f1cf099740',
    '竹内 海聖',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03170288-a92e-5f15-9015-eb6edfc96272',
    1,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03170288-a92e-5f15-9015-eb6edfc96272',
    2,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03170288-a92e-5f15-9015-eb6edfc96272',
    3,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03170288-a92e-5f15-9015-eb6edfc96272',
    4,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03170288-a92e-5f15-9015-eb6edfc96272',
    5,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03170288-a92e-5f15-9015-eb6edfc96272',
    6,
    15.0,
    NULL,
    true,
    '(15.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03170288-a92e-5f15-9015-eb6edfc96272',
    7,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '2254e432-6787-5fe2-98c8-637141fcc361',
    'e373e71d-025b-55b0-acf6-ce6dfb8eb06c',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '吉岡 祐月',
    'JPN 3472',
    'individual',
    11,
    87.0,
    63.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6b7c7861-f5ea-581f-abb2-7662daa53366',
    '2254e432-6787-5fe2-98c8-637141fcc361',
    'e373e71d-025b-55b0-acf6-ce6dfb8eb06c',
    '吉岡 祐月',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2254e432-6787-5fe2-98c8-637141fcc361',
    1,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2254e432-6787-5fe2-98c8-637141fcc361',
    2,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2254e432-6787-5fe2-98c8-637141fcc361',
    3,
    24.0,
    NULL,
    true,
    '(24.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2254e432-6787-5fe2-98c8-637141fcc361',
    4,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2254e432-6787-5fe2-98c8-637141fcc361',
    5,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2254e432-6787-5fe2-98c8-637141fcc361',
    6,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2254e432-6787-5fe2-98c8-637141fcc361',
    7,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'd26f6411-e3aa-58d5-8147-c8a0524821ea',
    'ed754d7e-169a-587a-9cd6-d8ca4eb79027',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '永見 波奈',
    'JPN 3417',
    'individual',
    12,
    120.0,
    77.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bad5ee0b-cc9f-583c-ba8e-4b58e3a4e4bb',
    'd26f6411-e3aa-58d5-8147-c8a0524821ea',
    'ed754d7e-169a-587a-9cd6-d8ca4eb79027',
    '永見 波奈',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd26f6411-e3aa-58d5-8147-c8a0524821ea',
    1,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd26f6411-e3aa-58d5-8147-c8a0524821ea',
    2,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd26f6411-e3aa-58d5-8147-c8a0524821ea',
    3,
    43.0,
    NULL,
    true,
    '(43.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd26f6411-e3aa-58d5-8147-c8a0524821ea',
    4,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd26f6411-e3aa-58d5-8147-c8a0524821ea',
    5,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd26f6411-e3aa-58d5-8147-c8a0524821ea',
    6,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd26f6411-e3aa-58d5-8147-c8a0524821ea',
    7,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '1be3188c-0144-53f5-af50-03e807b7ba64',
    'ff62d4d8-c48a-587d-ab98-b19b551126cb',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '岩﨑 楓太',
    'JPN 3232',
    'individual',
    13,
    104.0,
    85.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f9a37273-22ee-5dd4-ae9c-74663398cc4f',
    '1be3188c-0144-53f5-af50-03e807b7ba64',
    'ff62d4d8-c48a-587d-ab98-b19b551126cb',
    '岩﨑 楓太',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1be3188c-0144-53f5-af50-03e807b7ba64',
    1,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1be3188c-0144-53f5-af50-03e807b7ba64',
    2,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1be3188c-0144-53f5-af50-03e807b7ba64',
    3,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1be3188c-0144-53f5-af50-03e807b7ba64',
    4,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1be3188c-0144-53f5-af50-03e807b7ba64',
    5,
    19.0,
    NULL,
    true,
    '(19.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1be3188c-0144-53f5-af50-03e807b7ba64',
    6,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1be3188c-0144-53f5-af50-03e807b7ba64',
    7,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'd18b4c08-2ec7-525b-a817-dd261d8ba576',
    'dcc54f4d-b617-5465-a02a-e9374cf448c8',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '青山 大志',
    'JPN 3463',
    'individual',
    14,
    169.0,
    104.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5e6f79a4-aac9-5792-9d12-9b78c31ecabb',
    'd18b4c08-2ec7-525b-a817-dd261d8ba576',
    'dcc54f4d-b617-5465-a02a-e9374cf448c8',
    '青山 大志',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd18b4c08-2ec7-525b-a817-dd261d8ba576',
    1,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd18b4c08-2ec7-525b-a817-dd261d8ba576',
    2,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd18b4c08-2ec7-525b-a817-dd261d8ba576',
    3,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd18b4c08-2ec7-525b-a817-dd261d8ba576',
    4,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd18b4c08-2ec7-525b-a817-dd261d8ba576',
    5,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd18b4c08-2ec7-525b-a817-dd261d8ba576',
    6,
    65.0,
    'DSQ',
    true,
    '(65.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd18b4c08-2ec7-525b-a817-dd261d8ba576',
    7,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'ee823bb5-508f-548c-88d1-6e84eebe4414',
    '95ea388f-2aa4-5d67-97ba-2ad363d82c94',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '木下 純希',
    'JPN 3270',
    'individual',
    15,
    142.0,
    112.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '384b49a8-bc14-53a6-ab58-0ec443e42742',
    'ee823bb5-508f-548c-88d1-6e84eebe4414',
    '95ea388f-2aa4-5d67-97ba-2ad363d82c94',
    '木下 純希',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ee823bb5-508f-548c-88d1-6e84eebe4414',
    1,
    30.0,
    NULL,
    true,
    '(30.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ee823bb5-508f-548c-88d1-6e84eebe4414',
    2,
    30.0,
    NULL,
    false,
    '30.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ee823bb5-508f-548c-88d1-6e84eebe4414',
    3,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ee823bb5-508f-548c-88d1-6e84eebe4414',
    4,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ee823bb5-508f-548c-88d1-6e84eebe4414',
    5,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ee823bb5-508f-548c-88d1-6e84eebe4414',
    6,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ee823bb5-508f-548c-88d1-6e84eebe4414',
    7,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'bd9a87d3-1d35-5a8d-a540-4c1375cc89fb',
    'e9654b43-fcbb-59f6-9ca2-6d95eea04675',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '宮﨑 咲帆',
    'JPN 3163',
    'individual',
    16,
    177.0,
    112.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ea361ec3-0ce8-5593-a1af-e3ad03bc95b4',
    'bd9a87d3-1d35-5a8d-a540-4c1375cc89fb',
    'e9654b43-fcbb-59f6-9ca2-6d95eea04675',
    '宮﨑 咲帆',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd9a87d3-1d35-5a8d-a540-4c1375cc89fb',
    1,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd9a87d3-1d35-5a8d-a540-4c1375cc89fb',
    2,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd9a87d3-1d35-5a8d-a540-4c1375cc89fb',
    3,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd9a87d3-1d35-5a8d-a540-4c1375cc89fb',
    4,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd9a87d3-1d35-5a8d-a540-4c1375cc89fb',
    5,
    30.0,
    NULL,
    false,
    '30.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd9a87d3-1d35-5a8d-a540-4c1375cc89fb',
    6,
    32.0,
    NULL,
    false,
    '32.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd9a87d3-1d35-5a8d-a540-4c1375cc89fb',
    7,
    65.0,
    'NSC',
    true,
    '(65.0)'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '41e24a51-070b-5cbe-bd6c-0e0f0e980c86',
    '561c0b8a-613a-5e0d-8674-79b1debe2ebb',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '宮地 雄大',
    'JPN 2988',
    'individual',
    17,
    145.0,
    114.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '403ce6b5-df32-59cb-8de0-8fb5404f5599',
    '41e24a51-070b-5cbe-bd6c-0e0f0e980c86',
    '561c0b8a-613a-5e0d-8674-79b1debe2ebb',
    '宮地 雄大',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41e24a51-070b-5cbe-bd6c-0e0f0e980c86',
    1,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41e24a51-070b-5cbe-bd6c-0e0f0e980c86',
    2,
    31.0,
    NULL,
    true,
    '(31.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41e24a51-070b-5cbe-bd6c-0e0f0e980c86',
    3,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41e24a51-070b-5cbe-bd6c-0e0f0e980c86',
    4,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41e24a51-070b-5cbe-bd6c-0e0f0e980c86',
    5,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41e24a51-070b-5cbe-bd6c-0e0f0e980c86',
    6,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '41e24a51-070b-5cbe-bd6c-0e0f0e980c86',
    7,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '1cd09f06-3d86-5aa2-b703-44817f816da2',
    '5c3eff3d-3a16-506c-96de-861b6cb9abd9',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '渡邉 幹人',
    'JPN 3510',
    'individual',
    18,
    157.0,
    117.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5b43f104-d2d4-55f1-9774-e1709480ed79',
    '1cd09f06-3d86-5aa2-b703-44817f816da2',
    '5c3eff3d-3a16-506c-96de-861b6cb9abd9',
    '渡邉 幹人',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1cd09f06-3d86-5aa2-b703-44817f816da2',
    1,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1cd09f06-3d86-5aa2-b703-44817f816da2',
    2,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1cd09f06-3d86-5aa2-b703-44817f816da2',
    3,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1cd09f06-3d86-5aa2-b703-44817f816da2',
    4,
    40.0,
    NULL,
    true,
    '(40.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1cd09f06-3d86-5aa2-b703-44817f816da2',
    5,
    38.0,
    NULL,
    false,
    '38.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1cd09f06-3d86-5aa2-b703-44817f816da2',
    6,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1cd09f06-3d86-5aa2-b703-44817f816da2',
    7,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'bf1a3ab7-0c1c-5cbc-9fab-f8501fee93c5',
    '659a7737-50cd-5c70-ae0b-7827574aac17',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '宮崎 心桜',
    'JPN 3476',
    'individual',
    19,
    159.0,
    121.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0654067f-95f8-5682-85fa-0d95dfa3392a',
    'bf1a3ab7-0c1c-5cbc-9fab-f8501fee93c5',
    '659a7737-50cd-5c70-ae0b-7827574aac17',
    '宮崎 心桜',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf1a3ab7-0c1c-5cbc-9fab-f8501fee93c5',
    1,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf1a3ab7-0c1c-5cbc-9fab-f8501fee93c5',
    2,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf1a3ab7-0c1c-5cbc-9fab-f8501fee93c5',
    3,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf1a3ab7-0c1c-5cbc-9fab-f8501fee93c5',
    4,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf1a3ab7-0c1c-5cbc-9fab-f8501fee93c5',
    5,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf1a3ab7-0c1c-5cbc-9fab-f8501fee93c5',
    6,
    38.0,
    NULL,
    true,
    '(38.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf1a3ab7-0c1c-5cbc-9fab-f8501fee93c5',
    7,
    30.0,
    NULL,
    false,
    '30.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '785c6013-eee5-5a41-93e8-c7ded2958738',
    '046f010b-9c1c-5f1a-9646-267d9b5a36a5',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '仲山 結夏',
    'JPN 3345',
    'individual',
    20,
    156.0,
    123.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '18aa76ce-28bd-5f03-a93e-47df71f8bd7a',
    '785c6013-eee5-5a41-93e8-c7ded2958738',
    '046f010b-9c1c-5f1a-9646-267d9b5a36a5',
    '仲山 結夏',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '785c6013-eee5-5a41-93e8-c7ded2958738',
    1,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '785c6013-eee5-5a41-93e8-c7ded2958738',
    2,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '785c6013-eee5-5a41-93e8-c7ded2958738',
    3,
    33.0,
    NULL,
    true,
    '(33.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '785c6013-eee5-5a41-93e8-c7ded2958738',
    4,
    33.0,
    NULL,
    false,
    '33.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '785c6013-eee5-5a41-93e8-c7ded2958738',
    5,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '785c6013-eee5-5a41-93e8-c7ded2958738',
    6,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '785c6013-eee5-5a41-93e8-c7ded2958738',
    7,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '884da5cb-394f-5d91-b464-6787dbdb39cc',
    '1ceeb9fd-977e-5c55-bec1-1a0b14846e1b',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '廣田 穣',
    'JPN 3395',
    'individual',
    21,
    184.0,
    128.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9641ff3e-9657-58a8-a782-163400cd7572',
    '884da5cb-394f-5d91-b464-6787dbdb39cc',
    '1ceeb9fd-977e-5c55-bec1-1a0b14846e1b',
    '廣田 穣',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '884da5cb-394f-5d91-b464-6787dbdb39cc',
    1,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '884da5cb-394f-5d91-b464-6787dbdb39cc',
    2,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '884da5cb-394f-5d91-b464-6787dbdb39cc',
    3,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '884da5cb-394f-5d91-b464-6787dbdb39cc',
    4,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '884da5cb-394f-5d91-b464-6787dbdb39cc',
    5,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '884da5cb-394f-5d91-b464-6787dbdb39cc',
    6,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '884da5cb-394f-5d91-b464-6787dbdb39cc',
    7,
    56.0,
    NULL,
    true,
    '(56.0)'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'f30dcdac-3e11-5c7c-a756-877c2e78eeeb',
    '2e9a2d64-59c9-58e5-93c7-060df21e4417',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '今村 颯人',
    'JPN 3404',
    'individual',
    22,
    175.0,
    129.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '38c799a7-83ea-54c9-85e1-a1193167702e',
    'f30dcdac-3e11-5c7c-a756-877c2e78eeeb',
    '2e9a2d64-59c9-58e5-93c7-060df21e4417',
    '今村 颯人',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f30dcdac-3e11-5c7c-a756-877c2e78eeeb',
    1,
    43.0,
    NULL,
    false,
    '43.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f30dcdac-3e11-5c7c-a756-877c2e78eeeb',
    2,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f30dcdac-3e11-5c7c-a756-877c2e78eeeb',
    3,
    46.0,
    NULL,
    true,
    '(46.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f30dcdac-3e11-5c7c-a756-877c2e78eeeb',
    4,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f30dcdac-3e11-5c7c-a756-877c2e78eeeb',
    5,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f30dcdac-3e11-5c7c-a756-877c2e78eeeb',
    6,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f30dcdac-3e11-5c7c-a756-877c2e78eeeb',
    7,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'ae164cc0-7fb4-5f60-a7f9-118c9fab86e5',
    '6c64e8bd-d1a0-526e-b66e-88ba470b4c1d',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '汐川 陸人',
    'JPN 3283',
    'individual',
    23,
    195.0,
    141.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '54020119-87a4-5480-9a35-c9dc4cb65859',
    'ae164cc0-7fb4-5f60-a7f9-118c9fab86e5',
    '6c64e8bd-d1a0-526e-b66e-88ba470b4c1d',
    '汐川 陸人',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae164cc0-7fb4-5f60-a7f9-118c9fab86e5',
    1,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae164cc0-7fb4-5f60-a7f9-118c9fab86e5',
    2,
    54.0,
    NULL,
    true,
    '(54.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae164cc0-7fb4-5f60-a7f9-118c9fab86e5',
    3,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae164cc0-7fb4-5f60-a7f9-118c9fab86e5',
    4,
    34.0,
    NULL,
    false,
    '34.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae164cc0-7fb4-5f60-a7f9-118c9fab86e5',
    5,
    36.0,
    NULL,
    false,
    '36.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae164cc0-7fb4-5f60-a7f9-118c9fab86e5',
    6,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ae164cc0-7fb4-5f60-a7f9-118c9fab86e5',
    7,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'ad819267-01e1-5fe0-8fda-ef50b9d0c66e',
    'b7d594e0-5ac0-5eb9-91eb-47f115074104',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '川北 華子',
    'JPN 3437',
    'individual',
    24,
    173.0,
    141.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '992554e7-ac6a-51ed-bf0a-8124f4fc5a67',
    'ad819267-01e1-5fe0-8fda-ef50b9d0c66e',
    'b7d594e0-5ac0-5eb9-91eb-47f115074104',
    '川北 華子',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ad819267-01e1-5fe0-8fda-ef50b9d0c66e',
    1,
    32.0,
    NULL,
    true,
    '(32.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ad819267-01e1-5fe0-8fda-ef50b9d0c66e',
    2,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ad819267-01e1-5fe0-8fda-ef50b9d0c66e',
    3,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ad819267-01e1-5fe0-8fda-ef50b9d0c66e',
    4,
    32.0,
    NULL,
    false,
    '32.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ad819267-01e1-5fe0-8fda-ef50b9d0c66e',
    5,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ad819267-01e1-5fe0-8fda-ef50b9d0c66e',
    6,
    30.0,
    NULL,
    false,
    '30.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ad819267-01e1-5fe0-8fda-ef50b9d0c66e',
    7,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'e79ace09-d2e6-5b3d-9ee1-d3574d6bb64c',
    '234b96c7-73e8-59f9-832d-6d9015917659',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '宮武 大我',
    'JPN 3422',
    'individual',
    25,
    183.0,
    143.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c06fd9fa-1ae6-546a-af9b-240ab1371b79',
    'e79ace09-d2e6-5b3d-9ee1-d3574d6bb64c',
    '234b96c7-73e8-59f9-832d-6d9015917659',
    '宮武 大我',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e79ace09-d2e6-5b3d-9ee1-d3574d6bb64c',
    1,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e79ace09-d2e6-5b3d-9ee1-d3574d6bb64c',
    2,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e79ace09-d2e6-5b3d-9ee1-d3574d6bb64c',
    3,
    40.0,
    NULL,
    true,
    '(40.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e79ace09-d2e6-5b3d-9ee1-d3574d6bb64c',
    4,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e79ace09-d2e6-5b3d-9ee1-d3574d6bb64c',
    5,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e79ace09-d2e6-5b3d-9ee1-d3574d6bb64c',
    6,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e79ace09-d2e6-5b3d-9ee1-d3574d6bb64c',
    7,
    33.0,
    NULL,
    false,
    '33.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '38ab7e15-8d48-5619-82be-06bcd6b421bb',
    '136afe66-3153-513f-b61e-20a2225c0bfb',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '井上 豊海',
    'JPN 3470',
    'individual',
    26,
    209.0,
    144.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a3bbe5f8-21c9-5def-9426-a7961efa42d2',
    '38ab7e15-8d48-5619-82be-06bcd6b421bb',
    '136afe66-3153-513f-b61e-20a2225c0bfb',
    '井上 豊海',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38ab7e15-8d48-5619-82be-06bcd6b421bb',
    1,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38ab7e15-8d48-5619-82be-06bcd6b421bb',
    2,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38ab7e15-8d48-5619-82be-06bcd6b421bb',
    3,
    39.0,
    NULL,
    false,
    '39.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38ab7e15-8d48-5619-82be-06bcd6b421bb',
    4,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38ab7e15-8d48-5619-82be-06bcd6b421bb',
    5,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38ab7e15-8d48-5619-82be-06bcd6b421bb',
    6,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38ab7e15-8d48-5619-82be-06bcd6b421bb',
    7,
    65.0,
    'DSQ',
    true,
    '(65.0)'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '2853995b-0883-5840-9f01-545d6b7bee52',
    'e210f42c-f575-5e8a-8546-db86dbeb9f7e',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '澤村 真之介',
    'JPN 3426',
    'individual',
    27,
    216.0,
    156.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'dfe9ce1d-d693-5e95-8828-9bbcda0247f1',
    '2853995b-0883-5840-9f01-545d6b7bee52',
    'e210f42c-f575-5e8a-8546-db86dbeb9f7e',
    '澤村 真之介',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2853995b-0883-5840-9f01-545d6b7bee52',
    1,
    60.0,
    NULL,
    true,
    '(60.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2853995b-0883-5840-9f01-545d6b7bee52',
    2,
    39.0,
    NULL,
    false,
    '39.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2853995b-0883-5840-9f01-545d6b7bee52',
    3,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2853995b-0883-5840-9f01-545d6b7bee52',
    4,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2853995b-0883-5840-9f01-545d6b7bee52',
    5,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2853995b-0883-5840-9f01-545d6b7bee52',
    6,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2853995b-0883-5840-9f01-545d6b7bee52',
    7,
    46.0,
    NULL,
    false,
    '46.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'e314b9bc-84f0-5f40-ae92-8538a2beda39',
    '1ebfc70d-f150-581f-92fd-df32debbae3e',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '枝 大耀',
    'JPN 3449',
    'individual',
    28,
    223.0,
    158.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '77607fb0-2413-5515-8420-ecb6b870f9ba',
    'e314b9bc-84f0-5f40-ae92-8538a2beda39',
    '1ebfc70d-f150-581f-92fd-df32debbae3e',
    '枝 大耀',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e314b9bc-84f0-5f40-ae92-8538a2beda39',
    1,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e314b9bc-84f0-5f40-ae92-8538a2beda39',
    2,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e314b9bc-84f0-5f40-ae92-8538a2beda39',
    3,
    45.0,
    NULL,
    false,
    '45.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e314b9bc-84f0-5f40-ae92-8538a2beda39',
    4,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e314b9bc-84f0-5f40-ae92-8538a2beda39',
    5,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e314b9bc-84f0-5f40-ae92-8538a2beda39',
    6,
    37.0,
    NULL,
    false,
    '37.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e314b9bc-84f0-5f40-ae92-8538a2beda39',
    7,
    65.0,
    'DNF',
    true,
    '(65.0)'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '0989cb30-3846-5ce3-8ce9-6b916cfbe66d',
    '7ab84ead-c647-53b3-b905-4045acfac377',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '廣田 士',
    'JPN 2930',
    'individual',
    29,
    197.0,
    163.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '233bfc3f-4b8c-5a6d-a5b9-558f567c6b88',
    '0989cb30-3846-5ce3-8ce9-6b916cfbe66d',
    '7ab84ead-c647-53b3-b905-4045acfac377',
    '廣田 士',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0989cb30-3846-5ce3-8ce9-6b916cfbe66d',
    1,
    34.0,
    NULL,
    true,
    '(34.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0989cb30-3846-5ce3-8ce9-6b916cfbe66d',
    2,
    34.0,
    NULL,
    false,
    '34.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0989cb30-3846-5ce3-8ce9-6b916cfbe66d',
    3,
    32.0,
    NULL,
    false,
    '32.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0989cb30-3846-5ce3-8ce9-6b916cfbe66d',
    4,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0989cb30-3846-5ce3-8ce9-6b916cfbe66d',
    5,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0989cb30-3846-5ce3-8ce9-6b916cfbe66d',
    6,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0989cb30-3846-5ce3-8ce9-6b916cfbe66d',
    7,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'aa0dac1d-f9d6-51d6-abc7-c7bb5eb3b78d',
    '328e9f20-6d65-5279-b4ae-41eb8565343d',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '岡﨑 亘作',
    'JPN 3275',
    'individual',
    30,
    214.0,
    167.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6a86b630-56fc-5197-b82e-590d72c4d9d0',
    'aa0dac1d-f9d6-51d6-abc7-c7bb5eb3b78d',
    '328e9f20-6d65-5279-b4ae-41eb8565343d',
    '岡﨑 亘作',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa0dac1d-f9d6-51d6-abc7-c7bb5eb3b78d',
    1,
    46.0,
    NULL,
    false,
    '46.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa0dac1d-f9d6-51d6-abc7-c7bb5eb3b78d',
    2,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa0dac1d-f9d6-51d6-abc7-c7bb5eb3b78d',
    3,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa0dac1d-f9d6-51d6-abc7-c7bb5eb3b78d',
    4,
    47.0,
    NULL,
    true,
    '(47.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa0dac1d-f9d6-51d6-abc7-c7bb5eb3b78d',
    5,
    31.0,
    NULL,
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa0dac1d-f9d6-51d6-abc7-c7bb5eb3b78d',
    6,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa0dac1d-f9d6-51d6-abc7-c7bb5eb3b78d',
    7,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '222f2eb6-f1ff-578f-be73-3159de3c326a',
    'bfb6cdc3-693b-59fe-920f-dfa21ea37457',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '山内 琉太郎',
    'JPN 3392',
    'individual',
    31,
    215.0,
    170.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1dca2c52-a474-5af6-a63e-a2736f856a43',
    '222f2eb6-f1ff-578f-be73-3159de3c326a',
    'bfb6cdc3-693b-59fe-920f-dfa21ea37457',
    '山内 琉太郎',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '222f2eb6-f1ff-578f-be73-3159de3c326a',
    1,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '222f2eb6-f1ff-578f-be73-3159de3c326a',
    2,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '222f2eb6-f1ff-578f-be73-3159de3c326a',
    3,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '222f2eb6-f1ff-578f-be73-3159de3c326a',
    4,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '222f2eb6-f1ff-578f-be73-3159de3c326a',
    5,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '222f2eb6-f1ff-578f-be73-3159de3c326a',
    6,
    45.0,
    NULL,
    true,
    '(45.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '222f2eb6-f1ff-578f-be73-3159de3c326a',
    7,
    35.0,
    NULL,
    false,
    '35.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '9a4b2163-dbbc-548b-94d7-e56ff83b1730',
    'a0d33c75-883c-55a1-91ad-8159b07b5b0d',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '宮武 一心',
    'JPN 3224',
    'individual',
    32,
    219.0,
    176.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '560f9463-5129-577d-874b-503a1d071c06',
    '9a4b2163-dbbc-548b-94d7-e56ff83b1730',
    'a0d33c75-883c-55a1-91ad-8159b07b5b0d',
    '宮武 一心',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a4b2163-dbbc-548b-94d7-e56ff83b1730',
    1,
    39.0,
    NULL,
    false,
    '39.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a4b2163-dbbc-548b-94d7-e56ff83b1730',
    2,
    40.0,
    NULL,
    false,
    '40.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a4b2163-dbbc-548b-94d7-e56ff83b1730',
    3,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a4b2163-dbbc-548b-94d7-e56ff83b1730',
    4,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a4b2163-dbbc-548b-94d7-e56ff83b1730',
    5,
    32.0,
    NULL,
    false,
    '32.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a4b2163-dbbc-548b-94d7-e56ff83b1730',
    6,
    43.0,
    NULL,
    true,
    '(43.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a4b2163-dbbc-548b-94d7-e56ff83b1730',
    7,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '5452c63c-ff67-5f38-85b9-7cdf976962b0',
    '293dfa2f-e955-5053-9a92-d846f5a93164',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '井上 仁希',
    'JPN 3239',
    'individual',
    33,
    228.0,
    179.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b4feacaa-252b-55a8-a4fb-13810d11fe3c',
    '5452c63c-ff67-5f38-85b9-7cdf976962b0',
    '293dfa2f-e955-5053-9a92-d846f5a93164',
    '井上 仁希',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5452c63c-ff67-5f38-85b9-7cdf976962b0',
    1,
    38.0,
    NULL,
    false,
    '38.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5452c63c-ff67-5f38-85b9-7cdf976962b0',
    2,
    42.0,
    NULL,
    false,
    '42.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5452c63c-ff67-5f38-85b9-7cdf976962b0',
    3,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5452c63c-ff67-5f38-85b9-7cdf976962b0',
    4,
    35.0,
    NULL,
    false,
    '35.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5452c63c-ff67-5f38-85b9-7cdf976962b0',
    5,
    49.0,
    NULL,
    true,
    '(49.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5452c63c-ff67-5f38-85b9-7cdf976962b0',
    6,
    31.0,
    NULL,
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5452c63c-ff67-5f38-85b9-7cdf976962b0',
    7,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '43a5bcf7-8e5b-5722-924c-e372c887ccc5',
    '4e0c0402-8c97-5d4e-a1ec-eb057942d1f0',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '山口 凌平',
    'JPN 3416',
    'individual',
    34,
    221.0,
    183.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'faf31625-87d7-5b06-bd3e-44691d3dca28',
    '43a5bcf7-8e5b-5722-924c-e372c887ccc5',
    '4e0c0402-8c97-5d4e-a1ec-eb057942d1f0',
    '山口 凌平',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43a5bcf7-8e5b-5722-924c-e372c887ccc5',
    1,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43a5bcf7-8e5b-5722-924c-e372c887ccc5',
    2,
    38.0,
    NULL,
    true,
    '(38.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43a5bcf7-8e5b-5722-924c-e372c887ccc5',
    3,
    35.0,
    NULL,
    false,
    '35.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43a5bcf7-8e5b-5722-924c-e372c887ccc5',
    4,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43a5bcf7-8e5b-5722-924c-e372c887ccc5',
    5,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43a5bcf7-8e5b-5722-924c-e372c887ccc5',
    6,
    33.0,
    NULL,
    false,
    '33.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43a5bcf7-8e5b-5722-924c-e372c887ccc5',
    7,
    36.0,
    NULL,
    false,
    '36.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '483c2065-d9cd-57a8-bd7c-3ad896537737',
    'f75f35c4-9c00-5652-ad25-3d420f1a624c',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '朴 智勛',
    'JPN 3325',
    'individual',
    35,
    225.0,
    184.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4bd66ddb-c348-56ae-8772-543f7934e725',
    '483c2065-d9cd-57a8-bd7c-3ad896537737',
    'f75f35c4-9c00-5652-ad25-3d420f1a624c',
    '朴 智勛',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '483c2065-d9cd-57a8-bd7c-3ad896537737',
    1,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '483c2065-d9cd-57a8-bd7c-3ad896537737',
    2,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '483c2065-d9cd-57a8-bd7c-3ad896537737',
    3,
    34.0,
    NULL,
    false,
    '34.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '483c2065-d9cd-57a8-bd7c-3ad896537737',
    4,
    38.0,
    NULL,
    false,
    '38.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '483c2065-d9cd-57a8-bd7c-3ad896537737',
    5,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '483c2065-d9cd-57a8-bd7c-3ad896537737',
    6,
    41.0,
    NULL,
    true,
    '(41.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '483c2065-d9cd-57a8-bd7c-3ad896537737',
    7,
    38.0,
    NULL,
    false,
    '38.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'bf0988c9-50bb-5e77-a38d-131b061c72bb',
    '68613c6a-8e51-584c-96b3-f898b9e9418d',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '宮永 聖汰朗',
    'JPN 3491',
    'individual',
    36,
    235.0,
    187.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9b78d13d-b1e9-50af-92f7-b7ad6034667b',
    'bf0988c9-50bb-5e77-a38d-131b061c72bb',
    '68613c6a-8e51-584c-96b3-f898b9e9418d',
    '宮永 聖汰朗',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf0988c9-50bb-5e77-a38d-131b061c72bb',
    1,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf0988c9-50bb-5e77-a38d-131b061c72bb',
    2,
    37.0,
    NULL,
    false,
    '37.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf0988c9-50bb-5e77-a38d-131b061c72bb',
    3,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf0988c9-50bb-5e77-a38d-131b061c72bb',
    4,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf0988c9-50bb-5e77-a38d-131b061c72bb',
    5,
    48.0,
    NULL,
    true,
    '(48.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf0988c9-50bb-5e77-a38d-131b061c72bb',
    6,
    46.0,
    NULL,
    false,
    '46.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf0988c9-50bb-5e77-a38d-131b061c72bb',
    7,
    47.0,
    NULL,
    false,
    '47.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '23a4829f-45d2-57f4-9e4d-f27dfb9c1a91',
    '83f74d6f-42e8-52fe-a8d4-1a5b2c9cb6c4',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '豊田 慧',
    'JPN 3326',
    'individual',
    37,
    241.0,
    189.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '02f1acc8-ba9c-5943-a765-4e7550daa240',
    '23a4829f-45d2-57f4-9e4d-f27dfb9c1a91',
    '83f74d6f-42e8-52fe-a8d4-1a5b2c9cb6c4',
    '豊田 慧',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23a4829f-45d2-57f4-9e4d-f27dfb9c1a91',
    1,
    52.0,
    NULL,
    true,
    '(52.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23a4829f-45d2-57f4-9e4d-f27dfb9c1a91',
    2,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23a4829f-45d2-57f4-9e4d-f27dfb9c1a91',
    3,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23a4829f-45d2-57f4-9e4d-f27dfb9c1a91',
    4,
    41.0,
    NULL,
    false,
    '41.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23a4829f-45d2-57f4-9e4d-f27dfb9c1a91',
    5,
    33.0,
    NULL,
    false,
    '33.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23a4829f-45d2-57f4-9e4d-f27dfb9c1a91',
    6,
    36.0,
    NULL,
    false,
    '36.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23a4829f-45d2-57f4-9e4d-f27dfb9c1a91',
    7,
    32.0,
    NULL,
    false,
    '32.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '39cb0de8-f4c0-5c87-9314-ca5581b11371',
    '6b6f8f4a-3108-5288-af73-f67f3009f4de',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '高﨑 勘太',
    'JPN 3257',
    'individual',
    38,
    250.0,
    195.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e8054bfd-23c3-5fa5-aa64-21cbf6277e95',
    '39cb0de8-f4c0-5c87-9314-ca5581b11371',
    '6b6f8f4a-3108-5288-af73-f67f3009f4de',
    '高﨑 勘太',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39cb0de8-f4c0-5c87-9314-ca5581b11371',
    1,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39cb0de8-f4c0-5c87-9314-ca5581b11371',
    2,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39cb0de8-f4c0-5c87-9314-ca5581b11371',
    3,
    31.0,
    NULL,
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39cb0de8-f4c0-5c87-9314-ca5581b11371',
    4,
    39.0,
    NULL,
    false,
    '39.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39cb0de8-f4c0-5c87-9314-ca5581b11371',
    5,
    34.0,
    NULL,
    false,
    '34.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39cb0de8-f4c0-5c87-9314-ca5581b11371',
    6,
    55.0,
    NULL,
    true,
    '(55.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '39cb0de8-f4c0-5c87-9314-ca5581b11371',
    7,
    42.0,
    NULL,
    false,
    '42.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'cba5f719-71d8-5ec2-82d2-54fb15eeafd9',
    '911910db-2a56-5f9b-9c94-f344c68357bf',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '山本 千華',
    'JPN 3280',
    'individual',
    39,
    244.0,
    197.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a086e703-8ece-5278-aeb5-a5c7ea629219',
    'cba5f719-71d8-5ec2-82d2-54fb15eeafd9',
    '911910db-2a56-5f9b-9c94-f344c68357bf',
    '山本 千華',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cba5f719-71d8-5ec2-82d2-54fb15eeafd9',
    1,
    37.0,
    NULL,
    false,
    '37.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cba5f719-71d8-5ec2-82d2-54fb15eeafd9',
    2,
    43.0,
    NULL,
    false,
    '43.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cba5f719-71d8-5ec2-82d2-54fb15eeafd9',
    3,
    30.0,
    NULL,
    false,
    '30.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cba5f719-71d8-5ec2-82d2-54fb15eeafd9',
    4,
    44.0,
    NULL,
    false,
    '44.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cba5f719-71d8-5ec2-82d2-54fb15eeafd9',
    5,
    47.0,
    NULL,
    true,
    '(47.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cba5f719-71d8-5ec2-82d2-54fb15eeafd9',
    6,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cba5f719-71d8-5ec2-82d2-54fb15eeafd9',
    7,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '0a68ba14-c6c8-5ff7-8ed7-e9b3eed43ea1',
    '2f1b2e31-5c69-5fd5-b56d-81eb700672ee',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '冨岡 奏馬',
    'JPN 3171',
    'individual',
    40,
    248.0,
    202.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7315fb14-f17a-5e3f-961f-37dbf75a89ee',
    '0a68ba14-c6c8-5ff7-8ed7-e9b3eed43ea1',
    '2f1b2e31-5c69-5fd5-b56d-81eb700672ee',
    '冨岡 奏馬',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0a68ba14-c6c8-5ff7-8ed7-e9b3eed43ea1',
    1,
    44.0,
    NULL,
    false,
    '44.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0a68ba14-c6c8-5ff7-8ed7-e9b3eed43ea1',
    2,
    46.0,
    NULL,
    true,
    '(46.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0a68ba14-c6c8-5ff7-8ed7-e9b3eed43ea1',
    3,
    41.0,
    NULL,
    false,
    '41.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0a68ba14-c6c8-5ff7-8ed7-e9b3eed43ea1',
    4,
    31.0,
    NULL,
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0a68ba14-c6c8-5ff7-8ed7-e9b3eed43ea1',
    5,
    35.0,
    NULL,
    false,
    '35.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0a68ba14-c6c8-5ff7-8ed7-e9b3eed43ea1',
    6,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0a68ba14-c6c8-5ff7-8ed7-e9b3eed43ea1',
    7,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '3105c64f-3594-5783-be31-2ace06c16ded',
    '296aede8-004f-5c15-aa46-40339ad01e1b',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '中野 嘉隆',
    'JPN 3347',
    'individual',
    41,
    283.0,
    227.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7b2c868b-2de9-58d2-93a3-e9e20dc23880',
    '3105c64f-3594-5783-be31-2ace06c16ded',
    '296aede8-004f-5c15-aa46-40339ad01e1b',
    '中野 嘉隆',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3105c64f-3594-5783-be31-2ace06c16ded',
    1,
    51.0,
    NULL,
    false,
    '51.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3105c64f-3594-5783-be31-2ace06c16ded',
    2,
    56.0,
    NULL,
    true,
    '(56.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3105c64f-3594-5783-be31-2ace06c16ded',
    3,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3105c64f-3594-5783-be31-2ace06c16ded',
    4,
    36.0,
    NULL,
    false,
    '36.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3105c64f-3594-5783-be31-2ace06c16ded',
    5,
    37.0,
    NULL,
    false,
    '37.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3105c64f-3594-5783-be31-2ace06c16ded',
    6,
    39.0,
    NULL,
    false,
    '39.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3105c64f-3594-5783-be31-2ace06c16ded',
    7,
    39.0,
    NULL,
    false,
    '39.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '538ce335-307d-5d7e-89a8-ad9518ef4563',
    '563ad55d-8ce5-5ebf-81ab-14b11ce05bc9',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '榎本 昊透',
    'JPN 3131',
    'individual',
    42,
    288.0,
    236.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '55f9a877-e52c-579a-9b76-e5d6851213ba',
    '538ce335-307d-5d7e-89a8-ad9518ef4563',
    '563ad55d-8ce5-5ebf-81ab-14b11ce05bc9',
    '榎本 昊透',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '538ce335-307d-5d7e-89a8-ad9518ef4563',
    1,
    31.0,
    NULL,
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '538ce335-307d-5d7e-89a8-ad9518ef4563',
    2,
    32.0,
    NULL,
    false,
    '32.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '538ce335-307d-5d7e-89a8-ad9518ef4563',
    3,
    52.0,
    NULL,
    true,
    '(52.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '538ce335-307d-5d7e-89a8-ad9518ef4563',
    4,
    50.0,
    NULL,
    false,
    '50.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '538ce335-307d-5d7e-89a8-ad9518ef4563',
    5,
    45.0,
    NULL,
    false,
    '45.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '538ce335-307d-5d7e-89a8-ad9518ef4563',
    6,
    44.0,
    NULL,
    false,
    '44.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '538ce335-307d-5d7e-89a8-ad9518ef4563',
    7,
    34.0,
    NULL,
    false,
    '34.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '61efe245-c9e8-52d9-bf6a-c1e8084a411c',
    '80cae78d-cb51-5d1f-8430-b43a54c1143f',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '山本 小華',
    'JPN 3399',
    'individual',
    43,
    295.0,
    241.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8ea2089c-7283-5acb-8d80-343d87552cb1',
    '61efe245-c9e8-52d9-bf6a-c1e8084a411c',
    '80cae78d-cb51-5d1f-8430-b43a54c1143f',
    '山本 小華',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '61efe245-c9e8-52d9-bf6a-c1e8084a411c',
    1,
    33.0,
    NULL,
    false,
    '33.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '61efe245-c9e8-52d9-bf6a-c1e8084a411c',
    2,
    36.0,
    NULL,
    false,
    '36.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '61efe245-c9e8-52d9-bf6a-c1e8084a411c',
    3,
    54.0,
    NULL,
    true,
    '(54.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '61efe245-c9e8-52d9-bf6a-c1e8084a411c',
    4,
    49.0,
    NULL,
    false,
    '49.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '61efe245-c9e8-52d9-bf6a-c1e8084a411c',
    5,
    52.0,
    NULL,
    false,
    '52.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '61efe245-c9e8-52d9-bf6a-c1e8084a411c',
    6,
    34.0,
    NULL,
    false,
    '34.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '61efe245-c9e8-52d9-bf6a-c1e8084a411c',
    7,
    37.0,
    NULL,
    false,
    '37.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '7e7b0668-f554-5e50-9d47-0c572144a0cd',
    'dd8236c3-b48d-5324-adcf-f7d91bf45666',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '岩﨑 蒼',
    'JPN 3252',
    'individual',
    44,
    317.0,
    254.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '40f23201-bc3f-508d-b842-094df5a65b63',
    '7e7b0668-f554-5e50-9d47-0c572144a0cd',
    'dd8236c3-b48d-5324-adcf-f7d91bf45666',
    '岩﨑 蒼',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e7b0668-f554-5e50-9d47-0c572144a0cd',
    1,
    36.0,
    NULL,
    false,
    '36.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e7b0668-f554-5e50-9d47-0c572144a0cd',
    2,
    48.0,
    NULL,
    false,
    '48.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e7b0668-f554-5e50-9d47-0c572144a0cd',
    3,
    56.0,
    NULL,
    false,
    '56.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e7b0668-f554-5e50-9d47-0c572144a0cd',
    4,
    63.0,
    NULL,
    true,
    '(63.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e7b0668-f554-5e50-9d47-0c572144a0cd',
    5,
    63.0,
    NULL,
    false,
    '63.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e7b0668-f554-5e50-9d47-0c572144a0cd',
    6,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7e7b0668-f554-5e50-9d47-0c572144a0cd',
    7,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'b151a92c-e5c5-51b1-81ef-4c74ae6fcec6',
    'ab978d87-be24-57db-a016-2189e7ee493f',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '金子 和生',
    'JPN 3471',
    'individual',
    45,
    308.0,
    258.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '57f67259-27e1-59f0-a72f-84f99cda481f',
    'b151a92c-e5c5-51b1-81ef-4c74ae6fcec6',
    'ab978d87-be24-57db-a016-2189e7ee493f',
    '金子 和生',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b151a92c-e5c5-51b1-81ef-4c74ae6fcec6',
    1,
    42.0,
    NULL,
    false,
    '42.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b151a92c-e5c5-51b1-81ef-4c74ae6fcec6',
    2,
    41.0,
    NULL,
    false,
    '41.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b151a92c-e5c5-51b1-81ef-4c74ae6fcec6',
    3,
    42.0,
    NULL,
    false,
    '42.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b151a92c-e5c5-51b1-81ef-4c74ae6fcec6',
    4,
    42.0,
    NULL,
    false,
    '42.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b151a92c-e5c5-51b1-81ef-4c74ae6fcec6',
    5,
    41.0,
    NULL,
    false,
    '41.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b151a92c-e5c5-51b1-81ef-4c74ae6fcec6',
    6,
    50.0,
    NULL,
    true,
    '(50.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b151a92c-e5c5-51b1-81ef-4c74ae6fcec6',
    7,
    50.0,
    NULL,
    false,
    '50.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '9c444f1b-3f68-5ee9-a82c-18a9984dd6d1',
    '0dd9ad90-2a03-5e0e-908b-cdc671b86a4c',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '宮崎 翔太',
    'JPN 3240',
    'individual',
    46,
    320.0,
    262.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'dced1adf-99b6-52ac-8994-200620b77619',
    '9c444f1b-3f68-5ee9-a82c-18a9984dd6d1',
    '0dd9ad90-2a03-5e0e-908b-cdc671b86a4c',
    '宮崎 翔太',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c444f1b-3f68-5ee9-a82c-18a9984dd6d1',
    1,
    48.0,
    NULL,
    false,
    '48.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c444f1b-3f68-5ee9-a82c-18a9984dd6d1',
    2,
    50.0,
    NULL,
    false,
    '50.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c444f1b-3f68-5ee9-a82c-18a9984dd6d1',
    3,
    37.0,
    NULL,
    false,
    '37.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c444f1b-3f68-5ee9-a82c-18a9984dd6d1',
    4,
    58.0,
    NULL,
    true,
    '(58.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c444f1b-3f68-5ee9-a82c-18a9984dd6d1',
    5,
    39.0,
    NULL,
    false,
    '39.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c444f1b-3f68-5ee9-a82c-18a9984dd6d1',
    6,
    40.0,
    NULL,
    false,
    '40.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9c444f1b-3f68-5ee9-a82c-18a9984dd6d1',
    7,
    48.0,
    NULL,
    false,
    '48.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'ff9d4fd6-e8fb-51a9-84cc-f88516d9d20b',
    '480ebee0-7617-5942-ac38-521a36cb6531',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '下村 英昭',
    'JPN 3251',
    'individual',
    47,
    328.0,
    263.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'eafb5e74-d78f-541f-9ad9-bfef1eb3ae2b',
    'ff9d4fd6-e8fb-51a9-84cc-f88516d9d20b',
    '480ebee0-7617-5942-ac38-521a36cb6531',
    '下村 英昭',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff9d4fd6-e8fb-51a9-84cc-f88516d9d20b',
    1,
    55.0,
    NULL,
    false,
    '55.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff9d4fd6-e8fb-51a9-84cc-f88516d9d20b',
    2,
    55.0,
    NULL,
    false,
    '55.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff9d4fd6-e8fb-51a9-84cc-f88516d9d20b',
    3,
    44.0,
    NULL,
    false,
    '44.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff9d4fd6-e8fb-51a9-84cc-f88516d9d20b',
    4,
    30.0,
    NULL,
    false,
    '30.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff9d4fd6-e8fb-51a9-84cc-f88516d9d20b',
    5,
    59.0,
    NULL,
    false,
    '59.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff9d4fd6-e8fb-51a9-84cc-f88516d9d20b',
    6,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff9d4fd6-e8fb-51a9-84cc-f88516d9d20b',
    7,
    65.0,
    'DNF',
    true,
    '(65.0)'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '915774fb-986c-5489-9d8a-a7a5055a2223',
    '3722533b-b04f-5ba3-8cd3-4ed5d1af6585',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '山口 駿太郎',
    'JPN 3085',
    'individual',
    48,
    331.0,
    266.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bec61b70-f6d5-5fc5-9b8a-fa2d17222d52',
    '915774fb-986c-5489-9d8a-a7a5055a2223',
    '3722533b-b04f-5ba3-8cd3-4ed5d1af6585',
    '山口 駿太郎',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '915774fb-986c-5489-9d8a-a7a5055a2223',
    1,
    65.0,
    'DSQ',
    true,
    '(65.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '915774fb-986c-5489-9d8a-a7a5055a2223',
    2,
    57.0,
    NULL,
    false,
    '57.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '915774fb-986c-5489-9d8a-a7a5055a2223',
    3,
    36.0,
    NULL,
    false,
    '36.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '915774fb-986c-5489-9d8a-a7a5055a2223',
    4,
    37.0,
    NULL,
    false,
    '37.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '915774fb-986c-5489-9d8a-a7a5055a2223',
    5,
    62.0,
    NULL,
    false,
    '62.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '915774fb-986c-5489-9d8a-a7a5055a2223',
    6,
    51.0,
    NULL,
    false,
    '51.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '915774fb-986c-5489-9d8a-a7a5055a2223',
    7,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '358d5f07-c042-5b81-b501-5097c455f55e',
    'a803d5b6-4b1b-589e-a69a-5eb8c513a528',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '宮﨑 一帆',
    'JPN 3311',
    'individual',
    49,
    327.0,
    272.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ac58dcc9-b01b-599c-8fe9-1565a071a1de',
    '358d5f07-c042-5b81-b501-5097c455f55e',
    'a803d5b6-4b1b-589e-a69a-5eb8c513a528',
    '宮﨑 一帆',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '358d5f07-c042-5b81-b501-5097c455f55e',
    1,
    40.0,
    NULL,
    false,
    '40.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '358d5f07-c042-5b81-b501-5097c455f55e',
    2,
    45.0,
    NULL,
    false,
    '45.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '358d5f07-c042-5b81-b501-5097c455f55e',
    3,
    55.0,
    NULL,
    true,
    '(55.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '358d5f07-c042-5b81-b501-5097c455f55e',
    4,
    43.0,
    NULL,
    false,
    '43.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '358d5f07-c042-5b81-b501-5097c455f55e',
    5,
    50.0,
    NULL,
    false,
    '50.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '358d5f07-c042-5b81-b501-5097c455f55e',
    6,
    53.0,
    NULL,
    false,
    '53.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '358d5f07-c042-5b81-b501-5097c455f55e',
    7,
    41.0,
    NULL,
    false,
    '41.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '243ece53-a317-52bc-87fc-e90d2d7829b4',
    'f91b86e6-bb0b-5a9a-9fc8-a96b17bbd49d',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '石垣 直太郎',
    'JPN 3490',
    'individual',
    50,
    336.0,
    278.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4890ba58-9c88-5cb4-b0bb-5a8a8c3b1a65',
    '243ece53-a317-52bc-87fc-e90d2d7829b4',
    'f91b86e6-bb0b-5a9a-9fc8-a96b17bbd49d',
    '石垣 直太郎',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '243ece53-a317-52bc-87fc-e90d2d7829b4',
    1,
    41.0,
    NULL,
    false,
    '41.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '243ece53-a317-52bc-87fc-e90d2d7829b4',
    2,
    44.0,
    NULL,
    false,
    '44.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '243ece53-a317-52bc-87fc-e90d2d7829b4',
    3,
    58.0,
    NULL,
    true,
    '(58.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '243ece53-a317-52bc-87fc-e90d2d7829b4',
    4,
    45.0,
    NULL,
    false,
    '45.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '243ece53-a317-52bc-87fc-e90d2d7829b4',
    5,
    46.0,
    NULL,
    false,
    '46.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '243ece53-a317-52bc-87fc-e90d2d7829b4',
    6,
    47.0,
    NULL,
    false,
    '47.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '243ece53-a317-52bc-87fc-e90d2d7829b4',
    7,
    55.0,
    NULL,
    false,
    '55.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '6e6d7480-a036-5f53-a52b-fd46774ecaeb',
    '29480d71-1e0b-52f7-8fcf-262754e9fb47',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '越智 祥史',
    'JPN 3368',
    'individual',
    51,
    338.0,
    279.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '581f69bf-71fe-541c-a6f2-26803791869d',
    '6e6d7480-a036-5f53-a52b-fd46774ecaeb',
    '29480d71-1e0b-52f7-8fcf-262754e9fb47',
    '越智 祥史',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e6d7480-a036-5f53-a52b-fd46774ecaeb',
    1,
    35.0,
    NULL,
    false,
    '35.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e6d7480-a036-5f53-a52b-fd46774ecaeb',
    2,
    33.0,
    NULL,
    false,
    '33.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e6d7480-a036-5f53-a52b-fd46774ecaeb',
    3,
    59.0,
    NULL,
    true,
    '(59.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e6d7480-a036-5f53-a52b-fd46774ecaeb',
    4,
    53.0,
    NULL,
    false,
    '53.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e6d7480-a036-5f53-a52b-fd46774ecaeb',
    5,
    43.0,
    NULL,
    false,
    '43.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e6d7480-a036-5f53-a52b-fd46774ecaeb',
    6,
    58.0,
    NULL,
    false,
    '58.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e6d7480-a036-5f53-a52b-fd46774ecaeb',
    7,
    57.0,
    NULL,
    false,
    '57.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'a56184ae-6331-5f03-bccf-3bc38a77502c',
    'ad2f058a-0396-5b6a-9e82-b5249393fec3',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '木村 奏太',
    'JPN 3314',
    'individual',
    52,
    346.0,
    281.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9ea99c67-1011-503e-b0a9-8eff92524a30',
    'a56184ae-6331-5f03-bccf-3bc38a77502c',
    'ad2f058a-0396-5b6a-9e82-b5249393fec3',
    '木村 奏太',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a56184ae-6331-5f03-bccf-3bc38a77502c',
    1,
    65.0,
    'DNC',
    true,
    '(65.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a56184ae-6331-5f03-bccf-3bc38a77502c',
    2,
    65.0,
    'DNC',
    false,
    '65.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a56184ae-6331-5f03-bccf-3bc38a77502c',
    3,
    38.0,
    NULL,
    false,
    '38.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a56184ae-6331-5f03-bccf-3bc38a77502c',
    4,
    51.0,
    NULL,
    false,
    '51.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a56184ae-6331-5f03-bccf-3bc38a77502c',
    5,
    61.0,
    NULL,
    false,
    '61.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a56184ae-6331-5f03-bccf-3bc38a77502c',
    6,
    35.0,
    NULL,
    false,
    '35.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a56184ae-6331-5f03-bccf-3bc38a77502c',
    7,
    31.0,
    NULL,
    false,
    '31.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '2c48ad58-4a51-54d2-9370-ffeb8e439100',
    'c6b57c5c-01cc-5e9c-ada6-363a17c702c0',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '中川 楓香',
    'JPN 3276',
    'individual',
    53,
    342.0,
    281.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0484a66c-ca6b-5a7f-989b-a7595315f13c',
    '2c48ad58-4a51-54d2-9370-ffeb8e439100',
    'c6b57c5c-01cc-5e9c-ada6-363a17c702c0',
    '中川 楓香',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c48ad58-4a51-54d2-9370-ffeb8e439100',
    1,
    61.0,
    NULL,
    true,
    '(61.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c48ad58-4a51-54d2-9370-ffeb8e439100',
    2,
    35.0,
    NULL,
    false,
    '35.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c48ad58-4a51-54d2-9370-ffeb8e439100',
    3,
    48.0,
    NULL,
    false,
    '48.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c48ad58-4a51-54d2-9370-ffeb8e439100',
    4,
    48.0,
    NULL,
    false,
    '48.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c48ad58-4a51-54d2-9370-ffeb8e439100',
    5,
    51.0,
    NULL,
    false,
    '51.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c48ad58-4a51-54d2-9370-ffeb8e439100',
    6,
    56.0,
    NULL,
    false,
    '56.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c48ad58-4a51-54d2-9370-ffeb8e439100',
    7,
    43.0,
    NULL,
    false,
    '43.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '249a5254-a218-5cff-b626-9f44addbfe6a',
    '8a2ee680-494a-5686-adb9-4015b20f0a76',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    'ヴァンドｳーセン 元',
    'JPN 3237',
    'individual',
    54,
    349.0,
    296.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '43f4906a-66da-5630-b2fc-2bc1a852c0f5',
    '249a5254-a218-5cff-b626-9f44addbfe6a',
    '8a2ee680-494a-5686-adb9-4015b20f0a76',
    'ヴァンドｳーセン 元',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '249a5254-a218-5cff-b626-9f44addbfe6a',
    1,
    53.0,
    NULL,
    true,
    '(53.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '249a5254-a218-5cff-b626-9f44addbfe6a',
    2,
    52.0,
    NULL,
    false,
    '52.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '249a5254-a218-5cff-b626-9f44addbfe6a',
    3,
    53.0,
    NULL,
    false,
    '53.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '249a5254-a218-5cff-b626-9f44addbfe6a',
    4,
    46.0,
    NULL,
    false,
    '46.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '249a5254-a218-5cff-b626-9f44addbfe6a',
    5,
    44.0,
    NULL,
    false,
    '44.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '249a5254-a218-5cff-b626-9f44addbfe6a',
    6,
    52.0,
    NULL,
    false,
    '52.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '249a5254-a218-5cff-b626-9f44addbfe6a',
    7,
    49.0,
    NULL,
    false,
    '49.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'f1ef2e16-7050-5c97-b8b4-3049e91666d3',
    '44230f67-3406-527a-9540-b01c9517ca4f',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '合田 光希',
    'JPN 3272',
    'individual',
    55,
    366.0,
    301.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '235304b0-afc5-5a2a-9136-0193e70e5914',
    'f1ef2e16-7050-5c97-b8b4-3049e91666d3',
    '44230f67-3406-527a-9540-b01c9517ca4f',
    '合田 光希',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f1ef2e16-7050-5c97-b8b4-3049e91666d3',
    1,
    50.0,
    NULL,
    false,
    '50.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f1ef2e16-7050-5c97-b8b4-3049e91666d3',
    2,
    65.0,
    'DSQ',
    true,
    '(65.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f1ef2e16-7050-5c97-b8b4-3049e91666d3',
    3,
    49.0,
    NULL,
    false,
    '49.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f1ef2e16-7050-5c97-b8b4-3049e91666d3',
    4,
    61.0,
    NULL,
    false,
    '61.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f1ef2e16-7050-5c97-b8b4-3049e91666d3',
    5,
    42.0,
    NULL,
    false,
    '42.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f1ef2e16-7050-5c97-b8b4-3049e91666d3',
    6,
    54.0,
    NULL,
    false,
    '54.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f1ef2e16-7050-5c97-b8b4-3049e91666d3',
    7,
    45.0,
    NULL,
    false,
    '45.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'ab2c59ed-0fcb-5d0f-9bbd-b576a0ad4c58',
    '2db7b7f0-d035-557c-9f76-5adb83a10664',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '枝 大真',
    'JPN 2767',
    'individual',
    56,
    364.0,
    304.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'de27ce5a-34b1-5d75-9265-79ee1b74f750',
    'ab2c59ed-0fcb-5d0f-9bbd-b576a0ad4c58',
    '2db7b7f0-d035-557c-9f76-5adb83a10664',
    '枝 大真',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab2c59ed-0fcb-5d0f-9bbd-b576a0ad4c58',
    1,
    57.0,
    NULL,
    false,
    '57.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab2c59ed-0fcb-5d0f-9bbd-b576a0ad4c58',
    2,
    60.0,
    NULL,
    true,
    '(60.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab2c59ed-0fcb-5d0f-9bbd-b576a0ad4c58',
    3,
    47.0,
    NULL,
    false,
    '47.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab2c59ed-0fcb-5d0f-9bbd-b576a0ad4c58',
    4,
    54.0,
    NULL,
    false,
    '54.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab2c59ed-0fcb-5d0f-9bbd-b576a0ad4c58',
    5,
    58.0,
    NULL,
    false,
    '58.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab2c59ed-0fcb-5d0f-9bbd-b576a0ad4c58',
    6,
    48.0,
    NULL,
    false,
    '48.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab2c59ed-0fcb-5d0f-9bbd-b576a0ad4c58',
    7,
    40.0,
    NULL,
    false,
    '40.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'd4eed59a-4827-5662-9677-231fc3b4a689',
    '6ddf0abd-ae26-5b95-86d9-ae4c2120fc2b',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '松尾 昂',
    'JPN 3186',
    'individual',
    57,
    364.0,
    304.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd4261835-72de-5262-8fb1-4b4052ec3c01',
    'd4eed59a-4827-5662-9677-231fc3b4a689',
    '6ddf0abd-ae26-5b95-86d9-ae4c2120fc2b',
    '松尾 昂',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd4eed59a-4827-5662-9677-231fc3b4a689',
    1,
    47.0,
    NULL,
    false,
    '47.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd4eed59a-4827-5662-9677-231fc3b4a689',
    2,
    49.0,
    NULL,
    false,
    '49.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd4eed59a-4827-5662-9677-231fc3b4a689',
    3,
    50.0,
    NULL,
    false,
    '50.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd4eed59a-4827-5662-9677-231fc3b4a689',
    4,
    57.0,
    NULL,
    false,
    '57.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd4eed59a-4827-5662-9677-231fc3b4a689',
    5,
    60.0,
    NULL,
    true,
    '(60.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd4eed59a-4827-5662-9677-231fc3b4a689',
    6,
    49.0,
    NULL,
    false,
    '49.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd4eed59a-4827-5662-9677-231fc3b4a689',
    7,
    52.0,
    NULL,
    false,
    '52.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'f021e48d-8c7c-5729-b016-093a1b79c0a6',
    '70d0c56c-4095-5534-b367-a6166d734c22',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '前薗 冬真',
    'JPN 3044',
    'individual',
    58,
    379.0,
    314.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8af26795-2376-58f1-b3e1-0f2b042c45e6',
    'f021e48d-8c7c-5729-b016-093a1b79c0a6',
    '70d0c56c-4095-5534-b367-a6166d734c22',
    '前薗 冬真',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f021e48d-8c7c-5729-b016-093a1b79c0a6',
    1,
    45.0,
    NULL,
    false,
    '45.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f021e48d-8c7c-5729-b016-093a1b79c0a6',
    2,
    47.0,
    NULL,
    false,
    '47.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f021e48d-8c7c-5729-b016-093a1b79c0a6',
    3,
    57.0,
    NULL,
    false,
    '57.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f021e48d-8c7c-5729-b016-093a1b79c0a6',
    4,
    52.0,
    NULL,
    false,
    '52.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f021e48d-8c7c-5729-b016-093a1b79c0a6',
    5,
    54.0,
    NULL,
    false,
    '54.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f021e48d-8c7c-5729-b016-093a1b79c0a6',
    6,
    59.0,
    NULL,
    false,
    '59.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f021e48d-8c7c-5729-b016-093a1b79c0a6',
    7,
    65.0,
    'DNF',
    true,
    '(65.0)'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '0be17040-2331-5cc1-9ba1-039fcc1819d8',
    'a5bbe96a-ee3d-5695-858c-17c8b43d6b90',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '吉良 駿之介',
    'JPN 3105',
    'individual',
    59,
    381.0,
    316.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f4f8a18a-4f82-5919-b55e-0a7804a2a4c1',
    '0be17040-2331-5cc1-9ba1-039fcc1819d8',
    'a5bbe96a-ee3d-5695-858c-17c8b43d6b90',
    '吉良 駿之介',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0be17040-2331-5cc1-9ba1-039fcc1819d8',
    1,
    49.0,
    NULL,
    false,
    '49.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0be17040-2331-5cc1-9ba1-039fcc1819d8',
    2,
    51.0,
    NULL,
    false,
    '51.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0be17040-2331-5cc1-9ba1-039fcc1819d8',
    3,
    63.0,
    NULL,
    false,
    '63.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0be17040-2331-5cc1-9ba1-039fcc1819d8',
    4,
    60.0,
    NULL,
    false,
    '60.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0be17040-2331-5cc1-9ba1-039fcc1819d8',
    5,
    40.0,
    NULL,
    false,
    '40.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0be17040-2331-5cc1-9ba1-039fcc1819d8',
    6,
    65.0,
    'DSQ',
    true,
    '(65.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0be17040-2331-5cc1-9ba1-039fcc1819d8',
    7,
    53.0,
    NULL,
    false,
    '53.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'f7b717d2-eb05-5102-a1b7-f3c7fa3e73e4',
    'be45b088-bfbe-5660-b147-f0dbc2786ba2',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '松浦 美虹',
    'JPN 3279',
    'individual',
    60,
    396.0,
    331.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a387d0c4-49a0-55d3-a5f4-2db953247420',
    'f7b717d2-eb05-5102-a1b7-f3c7fa3e73e4',
    'be45b088-bfbe-5660-b147-f0dbc2786ba2',
    '松浦 美虹',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7b717d2-eb05-5102-a1b7-f3c7fa3e73e4',
    1,
    65.0,
    'DNC',
    true,
    '(65.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7b717d2-eb05-5102-a1b7-f3c7fa3e73e4',
    2,
    65.0,
    'DNC',
    false,
    '65.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7b717d2-eb05-5102-a1b7-f3c7fa3e73e4',
    3,
    60.0,
    NULL,
    false,
    '60.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7b717d2-eb05-5102-a1b7-f3c7fa3e73e4',
    4,
    56.0,
    NULL,
    false,
    '56.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7b717d2-eb05-5102-a1b7-f3c7fa3e73e4',
    5,
    57.0,
    NULL,
    false,
    '57.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7b717d2-eb05-5102-a1b7-f3c7fa3e73e4',
    6,
    42.0,
    NULL,
    false,
    '42.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7b717d2-eb05-5102-a1b7-f3c7fa3e73e4',
    7,
    51.0,
    NULL,
    false,
    '51.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '5043b7c9-e715-54a5-922b-665dc16a4d87',
    'f61f3ce8-4511-565d-89c3-4957d873b82b',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '合志 心凪',
    'JPN 3042',
    'individual',
    61,
    399.0,
    337.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6f95a95c-7fa7-500a-92c4-d87aaed97749',
    '5043b7c9-e715-54a5-922b-665dc16a4d87',
    'f61f3ce8-4511-565d-89c3-4957d873b82b',
    '合志 心凪',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5043b7c9-e715-54a5-922b-665dc16a4d87',
    1,
    54.0,
    NULL,
    false,
    '54.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5043b7c9-e715-54a5-922b-665dc16a4d87',
    2,
    59.0,
    NULL,
    false,
    '59.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5043b7c9-e715-54a5-922b-665dc16a4d87',
    3,
    51.0,
    NULL,
    false,
    '51.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5043b7c9-e715-54a5-922b-665dc16a4d87',
    4,
    62.0,
    NULL,
    true,
    '(62.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5043b7c9-e715-54a5-922b-665dc16a4d87',
    5,
    53.0,
    NULL,
    false,
    '53.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5043b7c9-e715-54a5-922b-665dc16a4d87',
    6,
    61.0,
    NULL,
    false,
    '61.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5043b7c9-e715-54a5-922b-665dc16a4d87',
    7,
    59.0,
    NULL,
    false,
    '59.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '3e84c6ff-7a30-54a5-96d7-8037ddb2e7b4',
    'd039c011-e3d2-5e4e-8ced-1ca85a3e71e4',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '梅村 旺来',
    'JPN 3110',
    'individual',
    62,
    404.0,
    339.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bcbd6dff-3436-5a4f-816b-2f378861b527',
    '3e84c6ff-7a30-54a5-96d7-8037ddb2e7b4',
    'd039c011-e3d2-5e4e-8ced-1ca85a3e71e4',
    '梅村 旺来',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e84c6ff-7a30-54a5-96d7-8037ddb2e7b4',
    1,
    58.0,
    NULL,
    false,
    '58.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e84c6ff-7a30-54a5-96d7-8037ddb2e7b4',
    2,
    65.0,
    'DNF',
    true,
    '(65.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e84c6ff-7a30-54a5-96d7-8037ddb2e7b4',
    3,
    62.0,
    NULL,
    false,
    '62.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e84c6ff-7a30-54a5-96d7-8037ddb2e7b4',
    4,
    55.0,
    NULL,
    false,
    '55.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e84c6ff-7a30-54a5-96d7-8037ddb2e7b4',
    5,
    55.0,
    NULL,
    false,
    '55.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e84c6ff-7a30-54a5-96d7-8037ddb2e7b4',
    6,
    65.0,
    'NSC',
    false,
    '65.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e84c6ff-7a30-54a5-96d7-8037ddb2e7b4',
    7,
    44.0,
    NULL,
    false,
    '44.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'a3304f9c-2180-5773-afe8-16d5e86e1a14',
    'b1e4fd3c-5d4f-5bda-b847-848263191516',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '王 詢之',
    'JPN 3102',
    'individual',
    63,
    407.0,
    343.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2bbce659-9bd0-5279-8cb9-2dc16c1d5243',
    'a3304f9c-2180-5773-afe8-16d5e86e1a14',
    'b1e4fd3c-5d4f-5bda-b847-848263191516',
    '王 詢之',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a3304f9c-2180-5773-afe8-16d5e86e1a14',
    1,
    56.0,
    NULL,
    false,
    '56.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a3304f9c-2180-5773-afe8-16d5e86e1a14',
    2,
    53.0,
    NULL,
    false,
    '53.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a3304f9c-2180-5773-afe8-16d5e86e1a14',
    3,
    64.0,
    NULL,
    true,
    '(64.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a3304f9c-2180-5773-afe8-16d5e86e1a14',
    4,
    64.0,
    NULL,
    false,
    '64.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a3304f9c-2180-5773-afe8-16d5e86e1a14',
    5,
    56.0,
    NULL,
    false,
    '56.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a3304f9c-2180-5773-afe8-16d5e86e1a14',
    6,
    60.0,
    NULL,
    false,
    '60.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a3304f9c-2180-5773-afe8-16d5e86e1a14',
    7,
    54.0,
    NULL,
    false,
    '54.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '680d6949-eac8-517d-b2da-0a7a7e029a4e',
    '696c994c-5f41-5ddf-b180-70b2c5f40b9f',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '髙橋 実言',
    'JPN 3104',
    'individual',
    64,
    416.0,
    352.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:50.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ce32fce7-b32a-55fb-96e4-7f8cdd3f6f39',
    '680d6949-eac8-517d-b2da-0a7a7e029a4e',
    '696c994c-5f41-5ddf-b180-70b2c5f40b9f',
    '髙橋 実言',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '680d6949-eac8-517d-b2da-0a7a7e029a4e',
    1,
    59.0,
    NULL,
    false,
    '59.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '680d6949-eac8-517d-b2da-0a7a7e029a4e',
    2,
    58.0,
    NULL,
    false,
    '58.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '680d6949-eac8-517d-b2da-0a7a7e029a4e',
    3,
    61.0,
    NULL,
    false,
    '61.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '680d6949-eac8-517d-b2da-0a7a7e029a4e',
    4,
    59.0,
    NULL,
    false,
    '59.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '680d6949-eac8-517d-b2da-0a7a7e029a4e',
    5,
    64.0,
    NULL,
    true,
    '(64.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '680d6949-eac8-517d-b2da-0a7a7e029a4e',
    6,
    57.0,
    NULL,
    false,
    '57.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '680d6949-eac8-517d-b2da-0a7a7e029a4e',
    7,
    58.0,
    NULL,
    false,
    '58.0'
);

-- 6. Regatta Results: Class B (30 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'f289cc4b-cfca-5d64-a3b8-f70c50c1ac0d',
    '17385aeb-afc4-52a4-8f9b-7ed80ec70b73',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '安達 陸',
    'JPN 3406',
    'individual',
    1,
    15.0,
    11.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd6063ebb-350a-5ab8-86e5-9e42c07ad746',
    'f289cc4b-cfca-5d64-a3b8-f70c50c1ac0d',
    '17385aeb-afc4-52a4-8f9b-7ed80ec70b73',
    '安達 陸',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f289cc4b-cfca-5d64-a3b8-f70c50c1ac0d',
    1,
    4.0,
    NULL,
    true,
    '(4.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f289cc4b-cfca-5d64-a3b8-f70c50c1ac0d',
    2,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f289cc4b-cfca-5d64-a3b8-f70c50c1ac0d',
    3,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f289cc4b-cfca-5d64-a3b8-f70c50c1ac0d',
    4,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f289cc4b-cfca-5d64-a3b8-f70c50c1ac0d',
    5,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f289cc4b-cfca-5d64-a3b8-f70c50c1ac0d',
    6,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f289cc4b-cfca-5d64-a3b8-f70c50c1ac0d',
    7,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '78eabe30-7c89-51d4-9c2e-8b445822f559',
    'd4749289-b2f3-5607-9ae1-fa33bdbcdad5',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '檜垣 麻衣子',
    'JPN 3434',
    'individual',
    2,
    15.0,
    12.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd1303d72-45d2-57f7-875f-92c741f3ce16',
    '78eabe30-7c89-51d4-9c2e-8b445822f559',
    'd4749289-b2f3-5607-9ae1-fa33bdbcdad5',
    '檜垣 麻衣子',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '78eabe30-7c89-51d4-9c2e-8b445822f559',
    1,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '78eabe30-7c89-51d4-9c2e-8b445822f559',
    2,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '78eabe30-7c89-51d4-9c2e-8b445822f559',
    3,
    3.0,
    NULL,
    true,
    '(3.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '78eabe30-7c89-51d4-9c2e-8b445822f559',
    4,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '78eabe30-7c89-51d4-9c2e-8b445822f559',
    5,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '78eabe30-7c89-51d4-9c2e-8b445822f559',
    6,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '78eabe30-7c89-51d4-9c2e-8b445822f559',
    7,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'c45e16b0-72e2-5f05-8e78-61b7e5459eda',
    '53d19e4a-4ca4-5cc8-b637-32a195361b3c',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '久保田 聖',
    'JPN 3408',
    'individual',
    3,
    35.0,
    27.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '751d74cd-6400-57d5-885c-34202f1073e0',
    'c45e16b0-72e2-5f05-8e78-61b7e5459eda',
    '53d19e4a-4ca4-5cc8-b637-32a195361b3c',
    '久保田 聖',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c45e16b0-72e2-5f05-8e78-61b7e5459eda',
    1,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c45e16b0-72e2-5f05-8e78-61b7e5459eda',
    2,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c45e16b0-72e2-5f05-8e78-61b7e5459eda',
    3,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c45e16b0-72e2-5f05-8e78-61b7e5459eda',
    4,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c45e16b0-72e2-5f05-8e78-61b7e5459eda',
    5,
    8.0,
    NULL,
    true,
    '(8.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c45e16b0-72e2-5f05-8e78-61b7e5459eda',
    6,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c45e16b0-72e2-5f05-8e78-61b7e5459eda',
    7,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'ca3395ce-6a21-50ee-b7cc-c2120e370e8c',
    'ce4ae904-7a57-570a-97cf-738e72df4cfb',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '大平 碧波',
    'JPN 3178',
    'individual',
    4,
    46.0,
    31.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0edd1f68-ecb6-548a-b6f3-e1774f281bf1',
    'ca3395ce-6a21-50ee-b7cc-c2120e370e8c',
    'ce4ae904-7a57-570a-97cf-738e72df4cfb',
    '大平 碧波',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca3395ce-6a21-50ee-b7cc-c2120e370e8c',
    1,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca3395ce-6a21-50ee-b7cc-c2120e370e8c',
    2,
    15.0,
    NULL,
    true,
    '(15.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca3395ce-6a21-50ee-b7cc-c2120e370e8c',
    3,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca3395ce-6a21-50ee-b7cc-c2120e370e8c',
    4,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca3395ce-6a21-50ee-b7cc-c2120e370e8c',
    5,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca3395ce-6a21-50ee-b7cc-c2120e370e8c',
    6,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca3395ce-6a21-50ee-b7cc-c2120e370e8c',
    7,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '7735e0d5-605f-5c4f-9f8e-7fb02a1ea750',
    'a695679e-6669-5758-b472-0de56b552d3a',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '下村 航大',
    'JPN 239',
    'individual',
    5,
    55.0,
    37.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '55bf073a-92bd-5725-a491-eb3db83feb6f',
    '7735e0d5-605f-5c4f-9f8e-7fb02a1ea750',
    'a695679e-6669-5758-b472-0de56b552d3a',
    '下村 航大',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7735e0d5-605f-5c4f-9f8e-7fb02a1ea750',
    1,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7735e0d5-605f-5c4f-9f8e-7fb02a1ea750',
    2,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7735e0d5-605f-5c4f-9f8e-7fb02a1ea750',
    3,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7735e0d5-605f-5c4f-9f8e-7fb02a1ea750',
    4,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7735e0d5-605f-5c4f-9f8e-7fb02a1ea750',
    5,
    18.0,
    NULL,
    true,
    '(18.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7735e0d5-605f-5c4f-9f8e-7fb02a1ea750',
    6,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7735e0d5-605f-5c4f-9f8e-7fb02a1ea750',
    7,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '38558ee3-b4e6-5b3d-895a-3d61c9112bb0',
    '3c9f092c-76ef-56f9-a0c9-7e858a2450be',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '城石 靖春',
    'JPN 3250',
    'individual',
    6,
    54.0,
    37.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1a197adf-bf54-5d72-9766-3ba6ffe64b90',
    '38558ee3-b4e6-5b3d-895a-3d61c9112bb0',
    '3c9f092c-76ef-56f9-a0c9-7e858a2450be',
    '城石 靖春',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38558ee3-b4e6-5b3d-895a-3d61c9112bb0',
    1,
    17.0,
    NULL,
    true,
    '(17.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38558ee3-b4e6-5b3d-895a-3d61c9112bb0',
    2,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38558ee3-b4e6-5b3d-895a-3d61c9112bb0',
    3,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38558ee3-b4e6-5b3d-895a-3d61c9112bb0',
    4,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38558ee3-b4e6-5b3d-895a-3d61c9112bb0',
    5,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38558ee3-b4e6-5b3d-895a-3d61c9112bb0',
    6,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '38558ee3-b4e6-5b3d-895a-3d61c9112bb0',
    7,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'c2436de6-70a5-5771-acab-a7f1de78bd22',
    '151993ac-0601-503e-8931-61459413489f',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '山手 絵万',
    'JPN 3419',
    'individual',
    7,
    53.0,
    38.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '40f02374-81cd-5f1b-aa20-aa677e5a0840',
    'c2436de6-70a5-5771-acab-a7f1de78bd22',
    '151993ac-0601-503e-8931-61459413489f',
    '山手 絵万',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2436de6-70a5-5771-acab-a7f1de78bd22',
    1,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2436de6-70a5-5771-acab-a7f1de78bd22',
    2,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2436de6-70a5-5771-acab-a7f1de78bd22',
    3,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2436de6-70a5-5771-acab-a7f1de78bd22',
    4,
    15.0,
    NULL,
    true,
    '(15.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2436de6-70a5-5771-acab-a7f1de78bd22',
    5,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2436de6-70a5-5771-acab-a7f1de78bd22',
    6,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c2436de6-70a5-5771-acab-a7f1de78bd22',
    7,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'e7055b0a-07ce-5c98-9aa2-5e40327b5bca',
    '7323557f-08b2-5fcd-a0c6-965bc4fb5ba2',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '山本 周',
    'JPN 3420',
    'individual',
    8,
    53.0,
    42.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ea8c2695-29c0-5948-9433-0ad46c6eef6f',
    'e7055b0a-07ce-5c98-9aa2-5e40327b5bca',
    '7323557f-08b2-5fcd-a0c6-965bc4fb5ba2',
    '山本 周',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e7055b0a-07ce-5c98-9aa2-5e40327b5bca',
    1,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e7055b0a-07ce-5c98-9aa2-5e40327b5bca',
    2,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e7055b0a-07ce-5c98-9aa2-5e40327b5bca',
    3,
    11.0,
    NULL,
    true,
    '(11.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e7055b0a-07ce-5c98-9aa2-5e40327b5bca',
    4,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e7055b0a-07ce-5c98-9aa2-5e40327b5bca',
    5,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e7055b0a-07ce-5c98-9aa2-5e40327b5bca',
    6,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e7055b0a-07ce-5c98-9aa2-5e40327b5bca',
    7,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '7bc4af1f-c047-5301-bb7d-db5d242f8ecd',
    '5af2bcfc-6aaf-56dc-8b53-5ed1e322ef7f',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '山手 文太郎',
    'JPN 3418',
    'individual',
    9,
    84.0,
    53.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b33f5ba6-e24e-5b3a-9dd0-1de4e6b0d777',
    '7bc4af1f-c047-5301-bb7d-db5d242f8ecd',
    '5af2bcfc-6aaf-56dc-8b53-5ed1e322ef7f',
    '山手 文太郎',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7bc4af1f-c047-5301-bb7d-db5d242f8ecd',
    1,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7bc4af1f-c047-5301-bb7d-db5d242f8ecd',
    2,
    31.0,
    'UFD',
    true,
    '(31.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7bc4af1f-c047-5301-bb7d-db5d242f8ecd',
    3,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7bc4af1f-c047-5301-bb7d-db5d242f8ecd',
    4,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7bc4af1f-c047-5301-bb7d-db5d242f8ecd',
    5,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7bc4af1f-c047-5301-bb7d-db5d242f8ecd',
    6,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7bc4af1f-c047-5301-bb7d-db5d242f8ecd',
    7,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '2a73741e-b33e-5c5d-b33b-bb6f02d479f3',
    '9ca50e97-0c1a-528c-8aee-77d3752d6e9c',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '中澤 はな',
    'JPN 3462',
    'individual',
    10,
    88.0,
    57.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ae00f354-9f9c-566e-8854-a7fb0f29502f',
    '2a73741e-b33e-5c5d-b33b-bb6f02d479f3',
    '9ca50e97-0c1a-528c-8aee-77d3752d6e9c',
    '中澤 はな',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2a73741e-b33e-5c5d-b33b-bb6f02d479f3',
    1,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2a73741e-b33e-5c5d-b33b-bb6f02d479f3',
    2,
    31.0,
    'RET',
    true,
    '(31.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2a73741e-b33e-5c5d-b33b-bb6f02d479f3',
    3,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2a73741e-b33e-5c5d-b33b-bb6f02d479f3',
    4,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2a73741e-b33e-5c5d-b33b-bb6f02d479f3',
    5,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2a73741e-b33e-5c5d-b33b-bb6f02d479f3',
    6,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2a73741e-b33e-5c5d-b33b-bb6f02d479f3',
    7,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'e67051a8-b915-5bd4-970d-5bd73ec7da03',
    '8972d9cd-8a0c-5848-b586-34f49cb7680a',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '辻野 陽真',
    'JPN 2942',
    'individual',
    11,
    96.0,
    65.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '50646a6a-5449-56f5-bc72-e8fff871b7ff',
    'e67051a8-b915-5bd4-970d-5bd73ec7da03',
    '8972d9cd-8a0c-5848-b586-34f49cb7680a',
    '辻野 陽真',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e67051a8-b915-5bd4-970d-5bd73ec7da03',
    1,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e67051a8-b915-5bd4-970d-5bd73ec7da03',
    2,
    31.0,
    'DNF',
    true,
    '(31.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e67051a8-b915-5bd4-970d-5bd73ec7da03',
    3,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e67051a8-b915-5bd4-970d-5bd73ec7da03',
    4,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e67051a8-b915-5bd4-970d-5bd73ec7da03',
    5,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e67051a8-b915-5bd4-970d-5bd73ec7da03',
    6,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e67051a8-b915-5bd4-970d-5bd73ec7da03',
    7,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '82b77e09-8836-5787-9972-948a93615138',
    '914e5690-a53e-57f6-845b-d6a855de33af',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '澤村 莉帆',
    'JPN 3286',
    'individual',
    12,
    92.0,
    71.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '79aa7060-a3c2-5e70-88e4-1affe2fed966',
    '82b77e09-8836-5787-9972-948a93615138',
    '914e5690-a53e-57f6-845b-d6a855de33af',
    '澤村 莉帆',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '82b77e09-8836-5787-9972-948a93615138',
    1,
    21.0,
    NULL,
    true,
    '(21.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '82b77e09-8836-5787-9972-948a93615138',
    2,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '82b77e09-8836-5787-9972-948a93615138',
    3,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '82b77e09-8836-5787-9972-948a93615138',
    4,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '82b77e09-8836-5787-9972-948a93615138',
    5,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '82b77e09-8836-5787-9972-948a93615138',
    6,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '82b77e09-8836-5787-9972-948a93615138',
    7,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '8f9e4242-f5ab-5ae7-af47-bd6630079858',
    '86f35eee-b2b0-55d2-9f95-b25bf3939762',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '伊豆丸 巧',
    'JPN 3427',
    'individual',
    13,
    106.0,
    75.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a0a5eaad-3ece-50f9-96f2-dd5fdb899ed8',
    '8f9e4242-f5ab-5ae7-af47-bd6630079858',
    '86f35eee-b2b0-55d2-9f95-b25bf3939762',
    '伊豆丸 巧',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f9e4242-f5ab-5ae7-af47-bd6630079858',
    1,
    31.0,
    'RET',
    true,
    '(31.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f9e4242-f5ab-5ae7-af47-bd6630079858',
    2,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f9e4242-f5ab-5ae7-af47-bd6630079858',
    3,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f9e4242-f5ab-5ae7-af47-bd6630079858',
    4,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f9e4242-f5ab-5ae7-af47-bd6630079858',
    5,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f9e4242-f5ab-5ae7-af47-bd6630079858',
    6,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f9e4242-f5ab-5ae7-af47-bd6630079858',
    7,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'b25eb4b7-b1d2-5629-8d49-7c31c056c59b',
    'f0f73b54-a171-5968-a9a5-b8d3bdbedcda',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '迫 宗摩',
    'JPN 3364',
    'individual',
    14,
    100.0,
    81.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '733900d4-9156-50e0-9795-ee7aca0d6b71',
    'b25eb4b7-b1d2-5629-8d49-7c31c056c59b',
    'f0f73b54-a171-5968-a9a5-b8d3bdbedcda',
    '迫 宗摩',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b25eb4b7-b1d2-5629-8d49-7c31c056c59b',
    1,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b25eb4b7-b1d2-5629-8d49-7c31c056c59b',
    2,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b25eb4b7-b1d2-5629-8d49-7c31c056c59b',
    3,
    19.0,
    NULL,
    true,
    '(19.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b25eb4b7-b1d2-5629-8d49-7c31c056c59b',
    4,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b25eb4b7-b1d2-5629-8d49-7c31c056c59b',
    5,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b25eb4b7-b1d2-5629-8d49-7c31c056c59b',
    6,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b25eb4b7-b1d2-5629-8d49-7c31c056c59b',
    7,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'b7c641cf-42ac-56af-989c-ae392988c93e',
    '63f38113-ed71-5337-b0fb-cd047c6e0f5c',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '植木 慶修',
    'JPN 2619',
    'individual',
    15,
    104.0,
    81.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c480ca12-e61f-5ada-9e12-af09842b7ad5',
    'b7c641cf-42ac-56af-989c-ae392988c93e',
    '63f38113-ed71-5337-b0fb-cd047c6e0f5c',
    '植木 慶修',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b7c641cf-42ac-56af-989c-ae392988c93e',
    1,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b7c641cf-42ac-56af-989c-ae392988c93e',
    2,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b7c641cf-42ac-56af-989c-ae392988c93e',
    3,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b7c641cf-42ac-56af-989c-ae392988c93e',
    4,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b7c641cf-42ac-56af-989c-ae392988c93e',
    5,
    23.0,
    NULL,
    true,
    '(23.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b7c641cf-42ac-56af-989c-ae392988c93e',
    6,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b7c641cf-42ac-56af-989c-ae392988c93e',
    7,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'b72be16b-57b5-5ff4-80a2-5dbd0f3b7288',
    '16983245-a74f-5b1c-811c-f9287c03e699',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '田上 莉佳子',
    'JPN 3243',
    'individual',
    16,
    115.0,
    84.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a73dc76b-ed4d-54d0-a445-7febfa2e8d68',
    'b72be16b-57b5-5ff4-80a2-5dbd0f3b7288',
    '16983245-a74f-5b1c-811c-f9287c03e699',
    '田上 莉佳子',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b72be16b-57b5-5ff4-80a2-5dbd0f3b7288',
    1,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b72be16b-57b5-5ff4-80a2-5dbd0f3b7288',
    2,
    31.0,
    'RET',
    true,
    '(31.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b72be16b-57b5-5ff4-80a2-5dbd0f3b7288',
    3,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b72be16b-57b5-5ff4-80a2-5dbd0f3b7288',
    4,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b72be16b-57b5-5ff4-80a2-5dbd0f3b7288',
    5,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b72be16b-57b5-5ff4-80a2-5dbd0f3b7288',
    6,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b72be16b-57b5-5ff4-80a2-5dbd0f3b7288',
    7,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'c8d8ea02-a704-5786-af31-c79dead93d97',
    '161cc46a-9659-58d3-be97-0aaf1605dc07',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '鵜飼 花丸',
    'JPN 3463',
    'individual',
    17,
    124.0,
    93.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bb6cfaee-daf0-5ca6-925b-cfefdd6867a2',
    'c8d8ea02-a704-5786-af31-c79dead93d97',
    '161cc46a-9659-58d3-be97-0aaf1605dc07',
    '鵜飼 花丸',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8d8ea02-a704-5786-af31-c79dead93d97',
    1,
    31.0,
    'DNF',
    true,
    '(31.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8d8ea02-a704-5786-af31-c79dead93d97',
    2,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8d8ea02-a704-5786-af31-c79dead93d97',
    3,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8d8ea02-a704-5786-af31-c79dead93d97',
    4,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8d8ea02-a704-5786-af31-c79dead93d97',
    5,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8d8ea02-a704-5786-af31-c79dead93d97',
    6,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c8d8ea02-a704-5786-af31-c79dead93d97',
    7,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'b85a0372-776f-5da1-a813-c480fe8df854',
    '390a1506-cdbf-598e-bffe-6c77a50bfbad',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '田中 環',
    'JPN 2986',
    'individual',
    18,
    118.0,
    96.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f312ef6d-6d0c-5c03-ba14-575ee9e9cc01',
    'b85a0372-776f-5da1-a813-c480fe8df854',
    '390a1506-cdbf-598e-bffe-6c77a50bfbad',
    '田中 環',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b85a0372-776f-5da1-a813-c480fe8df854',
    1,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b85a0372-776f-5da1-a813-c480fe8df854',
    2,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b85a0372-776f-5da1-a813-c480fe8df854',
    3,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b85a0372-776f-5da1-a813-c480fe8df854',
    4,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b85a0372-776f-5da1-a813-c480fe8df854',
    5,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b85a0372-776f-5da1-a813-c480fe8df854',
    6,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b85a0372-776f-5da1-a813-c480fe8df854',
    7,
    22.0,
    NULL,
    true,
    '(22.0)'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '78c5ec27-fe55-52df-b321-c5e198acddbf',
    '73892d6c-7f16-5b32-aff0-0d717f85edde',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '深堀 一真',
    'JPN 2618',
    'individual',
    19,
    127.0,
    102.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bb57bd88-1e6e-5199-b669-39ad54b317f1',
    '78c5ec27-fe55-52df-b321-c5e198acddbf',
    '73892d6c-7f16-5b32-aff0-0d717f85edde',
    '深堀 一真',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '78c5ec27-fe55-52df-b321-c5e198acddbf',
    1,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '78c5ec27-fe55-52df-b321-c5e198acddbf',
    2,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '78c5ec27-fe55-52df-b321-c5e198acddbf',
    3,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '78c5ec27-fe55-52df-b321-c5e198acddbf',
    4,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '78c5ec27-fe55-52df-b321-c5e198acddbf',
    5,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '78c5ec27-fe55-52df-b321-c5e198acddbf',
    6,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '78c5ec27-fe55-52df-b321-c5e198acddbf',
    7,
    25.0,
    NULL,
    true,
    '(25.0)'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '89c98176-d01f-5f62-b45c-c2aeabca5700',
    '15ddf966-8cd9-5da9-8192-6cfa3f09e0cf',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '櫻井 綺乃',
    'JPN 3004',
    'individual',
    20,
    136.0,
    105.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e1ce73fc-9788-5b0f-8446-879de37f016d',
    '89c98176-d01f-5f62-b45c-c2aeabca5700',
    '15ddf966-8cd9-5da9-8192-6cfa3f09e0cf',
    '櫻井 綺乃',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89c98176-d01f-5f62-b45c-c2aeabca5700',
    1,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89c98176-d01f-5f62-b45c-c2aeabca5700',
    2,
    31.0,
    'RET',
    true,
    '(31.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89c98176-d01f-5f62-b45c-c2aeabca5700',
    3,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89c98176-d01f-5f62-b45c-c2aeabca5700',
    4,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89c98176-d01f-5f62-b45c-c2aeabca5700',
    5,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89c98176-d01f-5f62-b45c-c2aeabca5700',
    6,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '89c98176-d01f-5f62-b45c-c2aeabca5700',
    7,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '19a1e7af-3858-5602-8143-2b909c219e88',
    '6775e734-c818-53c9-8fad-e8bd749e2740',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '松尾 歩',
    'JPN 2616',
    'individual',
    21,
    133.0,
    110.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8e7007a9-3b02-571d-b9f3-b3e5be98ecab',
    '19a1e7af-3858-5602-8143-2b909c219e88',
    '6775e734-c818-53c9-8fad-e8bd749e2740',
    '松尾 歩',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19a1e7af-3858-5602-8143-2b909c219e88',
    1,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19a1e7af-3858-5602-8143-2b909c219e88',
    2,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19a1e7af-3858-5602-8143-2b909c219e88',
    3,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19a1e7af-3858-5602-8143-2b909c219e88',
    4,
    23.0,
    NULL,
    true,
    '(23.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19a1e7af-3858-5602-8143-2b909c219e88',
    5,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19a1e7af-3858-5602-8143-2b909c219e88',
    6,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19a1e7af-3858-5602-8143-2b909c219e88',
    7,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'c1296350-065d-560d-84eb-1606f51b36c0',
    '1b120673-9333-56cd-93cc-177139ee9000',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '迫 拓摩',
    'JPN 2819',
    'individual',
    22,
    133.0,
    111.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '498558c8-bb7f-57b4-bece-bf4401614d43',
    'c1296350-065d-560d-84eb-1606f51b36c0',
    '1b120673-9333-56cd-93cc-177139ee9000',
    '迫 拓摩',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1296350-065d-560d-84eb-1606f51b36c0',
    1,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1296350-065d-560d-84eb-1606f51b36c0',
    2,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1296350-065d-560d-84eb-1606f51b36c0',
    3,
    22.0,
    NULL,
    true,
    '(22.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1296350-065d-560d-84eb-1606f51b36c0',
    4,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1296350-065d-560d-84eb-1606f51b36c0',
    5,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1296350-065d-560d-84eb-1606f51b36c0',
    6,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c1296350-065d-560d-84eb-1606f51b36c0',
    7,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'd531f9cd-e520-5d23-84e7-153628d5e499',
    'c62bc809-1e57-5653-899a-737a1b8a4349',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '長尾 優希',
    'JPN 3172',
    'individual',
    23,
    154.0,
    123.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f8d88dac-d480-5f33-a903-a77bacc5d834',
    'd531f9cd-e520-5d23-84e7-153628d5e499',
    'c62bc809-1e57-5653-899a-737a1b8a4349',
    '長尾 優希',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd531f9cd-e520-5d23-84e7-153628d5e499',
    1,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd531f9cd-e520-5d23-84e7-153628d5e499',
    2,
    31.0,
    'DNF',
    true,
    '(31.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd531f9cd-e520-5d23-84e7-153628d5e499',
    3,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd531f9cd-e520-5d23-84e7-153628d5e499',
    4,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd531f9cd-e520-5d23-84e7-153628d5e499',
    5,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd531f9cd-e520-5d23-84e7-153628d5e499',
    6,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd531f9cd-e520-5d23-84e7-153628d5e499',
    7,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '4019a5fe-fb30-5c09-a324-75e0896bf271',
    'a441ee16-32a6-5559-8e28-0f3f0b0abb07',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '王 博之',
    'JPN 3102',
    'individual',
    24,
    159.0,
    128.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ad5fcc4a-d0c4-5821-b7fc-56241e88a77b',
    '4019a5fe-fb30-5c09-a324-75e0896bf271',
    'a441ee16-32a6-5559-8e28-0f3f0b0abb07',
    '王 博之',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4019a5fe-fb30-5c09-a324-75e0896bf271',
    1,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4019a5fe-fb30-5c09-a324-75e0896bf271',
    2,
    31.0,
    'UFD',
    true,
    '(31.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4019a5fe-fb30-5c09-a324-75e0896bf271',
    3,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4019a5fe-fb30-5c09-a324-75e0896bf271',
    4,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4019a5fe-fb30-5c09-a324-75e0896bf271',
    5,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4019a5fe-fb30-5c09-a324-75e0896bf271',
    6,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4019a5fe-fb30-5c09-a324-75e0896bf271',
    7,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '5878e062-5a2a-50b9-be71-17504585dd76',
    'c140fbe4-211e-592a-a28f-431cfa7aa4b0',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '長山 花純',
    'JPN 2664',
    'individual',
    25,
    164.0,
    136.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd1eab3f7-b2f9-5f74-b248-6b05f123c836',
    '5878e062-5a2a-50b9-be71-17504585dd76',
    'c140fbe4-211e-592a-a28f-431cfa7aa4b0',
    '長山 花純',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5878e062-5a2a-50b9-be71-17504585dd76',
    1,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5878e062-5a2a-50b9-be71-17504585dd76',
    2,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5878e062-5a2a-50b9-be71-17504585dd76',
    3,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5878e062-5a2a-50b9-be71-17504585dd76',
    4,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5878e062-5a2a-50b9-be71-17504585dd76',
    5,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5878e062-5a2a-50b9-be71-17504585dd76',
    6,
    28.0,
    NULL,
    true,
    '(28.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5878e062-5a2a-50b9-be71-17504585dd76',
    7,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '8afc5662-dedf-5832-a00a-9c2b9fc35ae8',
    '07228aa1-03fb-5eac-9292-ca54fb5f4921',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '汐川 帆香',
    'JPN 3225',
    'individual',
    26,
    199.0,
    168.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '78a7b746-54f5-5a1c-9baa-68b7a2769dc5',
    '8afc5662-dedf-5832-a00a-9c2b9fc35ae8',
    '07228aa1-03fb-5eac-9292-ca54fb5f4921',
    '汐川 帆香',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8afc5662-dedf-5832-a00a-9c2b9fc35ae8',
    1,
    31.0,
    'DNF',
    true,
    '(31.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8afc5662-dedf-5832-a00a-9c2b9fc35ae8',
    2,
    31.0,
    'RET',
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8afc5662-dedf-5832-a00a-9c2b9fc35ae8',
    3,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8afc5662-dedf-5832-a00a-9c2b9fc35ae8',
    4,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8afc5662-dedf-5832-a00a-9c2b9fc35ae8',
    5,
    31.0,
    'RET',
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8afc5662-dedf-5832-a00a-9c2b9fc35ae8',
    6,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8afc5662-dedf-5832-a00a-9c2b9fc35ae8',
    7,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '9dd2486b-218e-50e8-b635-4722692e8e3d',
    'd7d4caf7-b0ae-5bbb-ba73-abae87cbbd16',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '入江 瑞穂',
    'JPN 9',
    'individual',
    27,
    201.0,
    170.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1226d46d-efd0-5944-b7e3-0b62da94a63a',
    '9dd2486b-218e-50e8-b635-4722692e8e3d',
    'd7d4caf7-b0ae-5bbb-ba73-abae87cbbd16',
    '入江 瑞穂',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9dd2486b-218e-50e8-b635-4722692e8e3d',
    1,
    31.0,
    'RET',
    true,
    '(31.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9dd2486b-218e-50e8-b635-4722692e8e3d',
    2,
    31.0,
    'DNF',
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9dd2486b-218e-50e8-b635-4722692e8e3d',
    3,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9dd2486b-218e-50e8-b635-4722692e8e3d',
    4,
    31.0,
    'STP',
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9dd2486b-218e-50e8-b635-4722692e8e3d',
    5,
    31.0,
    'DNC',
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9dd2486b-218e-50e8-b635-4722692e8e3d',
    6,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9dd2486b-218e-50e8-b635-4722692e8e3d',
    7,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '3f1e2e2b-b3e0-5111-ad90-f2f97609d13b',
    '1d6a7924-ff83-5128-9e2d-a07a3cb10e9d',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '峰平 多喜子',
    'JPN 1',
    'individual',
    28,
    202.0,
    171.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5f3272a4-6bed-501d-83a6-7c01d60bcf8d',
    '3f1e2e2b-b3e0-5111-ad90-f2f97609d13b',
    '1d6a7924-ff83-5128-9e2d-a07a3cb10e9d',
    '峰平 多喜子',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3f1e2e2b-b3e0-5111-ad90-f2f97609d13b',
    1,
    31.0,
    'DNC',
    true,
    '(31.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3f1e2e2b-b3e0-5111-ad90-f2f97609d13b',
    2,
    31.0,
    'DNC',
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3f1e2e2b-b3e0-5111-ad90-f2f97609d13b',
    3,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3f1e2e2b-b3e0-5111-ad90-f2f97609d13b',
    4,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3f1e2e2b-b3e0-5111-ad90-f2f97609d13b',
    5,
    31.0,
    'RET',
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3f1e2e2b-b3e0-5111-ad90-f2f97609d13b',
    6,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3f1e2e2b-b3e0-5111-ad90-f2f97609d13b',
    7,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '2802d41a-0edb-5359-aba9-ea5c40665484',
    'f2659406-cdbc-55fb-b6bb-760cd11e2d0e',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '田中 美咲',
    'JPN 2983',
    'individual',
    29,
    209.6,
    178.6,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a873087b-d856-5495-ba11-6b21a0aed057',
    '2802d41a-0edb-5359-aba9-ea5c40665484',
    'f2659406-cdbc-55fb-b6bb-760cd11e2d0e',
    '田中 美咲',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2802d41a-0edb-5359-aba9-ea5c40665484',
    1,
    31.0,
    'DNF',
    true,
    '(31.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2802d41a-0edb-5359-aba9-ea5c40665484',
    2,
    31.0,
    'DNF',
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2802d41a-0edb-5359-aba9-ea5c40665484',
    3,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2802d41a-0edb-5359-aba9-ea5c40665484',
    4,
    27.6,
    'STP',
    false,
    '27.6'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2802d41a-0edb-5359-aba9-ea5c40665484',
    5,
    31.0,
    'RET',
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2802d41a-0edb-5359-aba9-ea5c40665484',
    6,
    31.0,
    'RET',
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2802d41a-0edb-5359-aba9-ea5c40665484',
    7,
    31.0,
    'DNC',
    false,
    '31.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '7690d62c-d3ad-5a40-a4f9-c9ecb6b0a8ff',
    'ffea3548-0341-59c3-9e67-2f78872746af',
    '9133970a-a138-54d7-b321-46ce1d0d3673',
    '湯浅 汰一',
    'JPN 3059',
    'individual',
    30,
    215.0,
    184.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link',
    '第49回西日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from West Japan JODA 49th West Japan OP Championship, Fukuoka. Signed 2026/8/2 16:52.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4bc8906b-5b49-587f-b950-073917228a56',
    '7690d62c-d3ad-5a40-a4f9-c9ecb6b0a8ff',
    'ffea3548-0341-59c3-9e67-2f78872746af',
    '湯浅 汰一',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7690d62c-d3ad-5a40-a4f9-c9ecb6b0a8ff',
    1,
    31.0,
    'DNF',
    true,
    '(31.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7690d62c-d3ad-5a40-a4f9-c9ecb6b0a8ff',
    2,
    31.0,
    'DNF',
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7690d62c-d3ad-5a40-a4f9-c9ecb6b0a8ff',
    3,
    31.0,
    'UFD',
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7690d62c-d3ad-5a40-a4f9-c9ecb6b0a8ff',
    4,
    31.0,
    'RET',
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7690d62c-d3ad-5a40-a4f9-c9ecb6b0a8ff',
    5,
    31.0,
    'DNC',
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7690d62c-d3ad-5a40-a4f9-c9ecb6b0a8ff',
    6,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7690d62c-d3ad-5a40-a4f9-c9ecb6b0a8ff',
    7,
    31.0,
    'DNF',
    false,
    '31.0'
);

-- 7. Admin Change Log
INSERT INTO public.admin_change_log (
    actor_email, action, entity_type, entity_id, entity_label, summary, details, source
) VALUES (
    'admin@sailorpath.com',
    'results.import_official_west_japan_opti_2026',
    'regattas',
    '44f002e9-2070-5d8b-a9a5-424d0c6a0b9f',
    '49th West Japan Optimist Championship 2026',
    'Imported official final results from 49th West Japan Championship (Class A: 64 boats, Class B: 30 boats)',
    '{"fleetSizeA": 64, "racesA": 7, "fleetSizeB": 30, "racesB": 7, "newProfiles": 74, "officialSourceA": "https://drive.google.com/file/d/1SGblVqpoKLb2TiMWuYLY8zZl2MVpL1fE/view?usp=drive_link", "officialSourceB": "https://drive.google.com/file/d/1Idk7L0ZRCTJgfeC5EwcSdHTZTjGtyMxu/view?usp=drive_link"}'::jsonb,
    'official-joda-west-import'
);

COMMIT;
