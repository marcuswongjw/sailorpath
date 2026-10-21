-- Migration 136: Import 44th Riviera Cup East Japan Optimist Championship 2026
-- Event: 第44回リビエラカップ東日本オプティミスト級セーリング選手権大会
-- Dates: 2026-08-21 to 2026-08-23, Enoshima Yacht Harbor, Kanagawa, Japan
-- Class A: 87 boats, 7 races (1 discard). Class B: 22 boats, 13 races (3 discards).

BEGIN;

-- 1. Regatta Event
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    '0ba6cae1-9cfb-5aeb-af29-ff62a60fdd9f',
    '44th Riviera Cup East Japan Optimist Championship 2026',
    '44th-riviera-cup-east-japan-optimist-championship-2026',
    '2026-08-21',
    '2026-08-23',
    'Enoshima Yacht Harbor, Kanagawa, Japan',
    'Enoshima Yacht Club Junior (EYCJ) & Kanto JODA',
    '["Optimist"]'::jsonb,
    false,
    false,
    'Class A sailed 7 races (Aug 21-23); Class B sailed 13 races (Aug 22-23).',
    'Low Point System: Class A with 1 discard after 7 races; Class B with 3 discards after 13 races.'
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
    'add537f4-4531-5793-b0db-408493c608c5',
    '0ba6cae1-9cfb-5aeb-af29-ff62a60fdd9f',
    '44th Riviera Cup East Japan Optimist Championship 2026 (Class A)',
    '44th-riviera-cup-east-japan-optimist-championship-2026-class-a',
    '2026-08-21',
    '2026-08-23',
    87,
    'Class A',
    7,
    'JPN',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Enoshima Yacht Harbor, Kanagawa, Japan',
    'Enoshima Yacht Club Junior (EYCJ) & Kanto JODA',
    'published',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績'
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count;
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name
) VALUES (
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '0ba6cae1-9cfb-5aeb-af29-ff62a60fdd9f',
    '44th Riviera Cup East Japan Optimist Championship 2026 (Class B)',
    '44th-riviera-cup-east-japan-optimist-championship-2026-class-b',
    '2026-08-21',
    '2026-08-23',
    22,
    'Class B',
    13,
    'JPN',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Enoshima Yacht Harbor, Kanagawa, Japan',
    'Enoshima Yacht Club Junior (EYCJ) & Kanto JODA',
    'published',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績'
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count;

-- 3. New Sailor Profiles (83 new profiles)
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('0eeae64f-3b7c-5d25-b09c-0ae3e5eaa483', 'Kaito Higuchi', 'opti-jpn-kaito-higuchi-3478', 'JPN 3478', 'JPN', 'M', '湘南JYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('6581432e-6145-5bfc-800a-7c7cd7a5619d', 'Tooko Nishimura', 'opti-jpn-tooko-nishimura-3365', 'JPN 3365', 'JPN', 'F', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('6983fb52-7275-5278-86f0-9674f98aca01', 'Kota Nomura', 'opti-jpn-kota-nomura-3456', 'JPN 3456', 'JPN', 'M', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('cf720117-fc78-5233-94cb-d39bd57a1433', 'Keita Matsunaga', 'opti-jpn-keita-matsunaga-3095', 'JPN 3095', 'JPN', 'M', '中央区JYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('2bdc9622-d3e1-5026-a3bc-f0b8f30f1b6d', 'Ayame Sanada', 'opti-jpn-ayame-sanada-3255', 'JPN 3255', 'JPN', 'F', 'YJYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('b1713fdf-e19a-5b91-af9f-8db1a0fe4165', 'Hikaru Takano', 'opti-jpn-hikaru-takano-3435', 'JPN 3435', 'JPN', 'M', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('d292d6d5-a89b-568f-82f3-a448289014e4', 'Eiji Satou', 'opti-jpn-eiji-satou-3447', 'JPN 3447', 'JPN', 'M', '夢の島YC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('fe4c5005-571b-5805-8bbb-6063851835f9', 'Kenshin Ikegaya', 'opti-jpn-kenshin-ikegaya-3018', 'JPN 3018', 'JPN', 'M', '海陽海洋C')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('5c489dbf-8fa5-5c2f-bf4e-dc55f6b8ba08', 'Rui Yoshida', 'opti-jpn-rui-yoshida-3381', 'JPN 3381', 'JPN', 'M', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('d93c9115-6be9-5d29-80e2-e232e4cc89d4', 'Taisei Inomata', 'opti-jpn-taisei-inomata-3378', 'JPN 3378', 'JPN', 'M', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('a4fc7a7a-62dc-5c60-b40b-089d09341dcb', 'Eito Matsuura', 'opti-jpn-eito-matsuura-3322', 'JPN 3322', 'JPN', 'M', '三重JYYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('cdb4723d-4a2c-543f-8d54-4abb9d7080aa', 'Haruma Matsuura', 'opti-jpn-haruma-matsuura-3473', 'JPN 3473', 'JPN', 'M', '三重JYYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('03255e8b-9496-5297-af53-6945dfbe901e', 'Shunya Tabuchi', 'opti-jpn-shunya-tabuchi-3020', 'JPN 3020', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('70fcc745-a909-53ab-a54b-1ba753b5c569', 'Ayaka Inaba', 'opti-jpn-ayaka-inaba-3445', 'JPN 3445', 'JPN', 'F', '夢の島YC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('b04104ba-7b19-5217-ac34-e806fbefd542', 'Ruri Ishii', 'opti-jpn-ruri-ishii-3168', 'JPN 3168', 'JPN', 'F', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('e0235830-8309-53a8-937e-6f339c5554eb', 'Yusei Sakaue', 'opti-jpn-yusei-sakaue-2993', 'JPN 2993', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('0eb30de4-6e06-50f3-b8d4-3f02cc0130dd', 'Nana Yamamura', 'opti-jpn-nana-yamamura-3480', 'JPN 3480', 'JPN', 'F', '夢の島YC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('652c1835-ecb4-5ee1-8ee0-cdd5bc9e6d55', 'Misa Kawashima', 'opti-jpn-misa-kawashima-3433', 'JPN 3433', 'JPN', 'F', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('48867110-3451-5b67-a8bd-247b239b21b7', 'Hinari Kosaka', 'opti-jpn-hinari-kosaka-3157', 'JPN 3157', 'JPN', 'F', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('cc7f1a70-617c-5f0f-95c0-11ff6c600a27', 'Enhou Takehara', 'opti-jpn-enhou-takehara-3361', 'JPN 3361', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('2e14e145-fef6-5982-b963-d801f1bb6a31', 'Yuzuki Kubota', 'opti-jpn-yuzuki-kubota-3125', 'JPN 3125', 'JPN', 'F', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('c0619908-2d1c-5ad5-8c34-6200ce5aa6b5', 'Rikuto Inaba', 'opti-jpn-rikuto-inaba-3468', 'JPN 3468', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('7983e169-6802-58d2-b8c3-8b7a65225184', 'Aira Elizabeth Kawabata Duncan', 'opti-jpn-aira-elizabeth-kawabata-duncan-3127', 'JPN 3127', 'JPN', 'F', 'FSSC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('29e386e1-b43b-5dea-80bb-b50ed04c1317', 'Sei Yamamura', 'opti-jpn-sei-yamamura-3338', 'JPN 3338', 'JPN', 'M', '夢の島YC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('a3ded086-1ecc-5be9-9458-382e9fbbe835', 'Eiko Kishi', 'opti-jpn-eiko-kishi-3129', 'JPN 3129', 'JPN', 'F', 'FSSC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('55c04350-4b48-5cf1-96a4-5bdc914beead', 'Masato Mizumoto', 'opti-jpn-masato-mizumoto-3411', 'JPN 3411', 'JPN', 'M', 'チーム江東')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('924d1f93-fc4d-54a0-a6a6-8738f48d6c3a', 'Honami Sumita', 'opti-jpn-honami-sumita-2893', 'JPN 2893', 'JPN', 'F', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('f31fc009-bdb8-56bd-8419-6b780b5c21d6', 'Ooshimarion', 'opti-jpn-ooshimarion-3382', 'JPN 3382', 'JPN', 'F', 'YJYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('ed71ace5-6086-578f-8e30-ad1d4fb1e949', 'Charikowa emiria Emiria', 'opti-jpn-charikowa-emiria-emiria-3410', 'JPN 3410', 'JPN', 'F', 'チーム江東')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('489d4743-1a7b-5f61-b3c2-2576df0df2fe', 'Shohei Hayashi', 'opti-jpn-shohei-hayashi-3469', 'JPN 3469', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('b9540a9d-2e0c-57d4-be71-ded6162cd8b0', 'Hibiki Hata', 'opti-jpn-hibiki-hata-3373', 'JPN 3373', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('45578225-5f60-5a09-91e6-a93d66f23988', 'Mana Ejima', 'opti-jpn-mana-ejima-2890', 'JPN 2890', 'JPN', 'F', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('2769907e-9b02-5e6d-9196-f223e302c525', 'Sakutarou Kubo', 'opti-jpn-sakutarou-kubo-2894', 'JPN 2894', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('db249593-6acb-55d3-9e73-e39980a2e9b7', 'Rino Morizane', 'opti-jpn-rino-morizane-3438', 'JPN 3438', 'JPN', 'F', 'KMC横浜JYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('2e3bb12e-a03a-535e-974f-140cd5eae63c', 'Hiizu Kobayashi', 'opti-jpn-hiizu-kobayashi-3461', 'JPN 3461', 'JPN', 'M', 'FSSC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('530f7665-acf6-5acd-9e30-ffd791f0d607', 'Aoto Iwasaki', 'opti-jpn-aoto-iwasaki-3371', 'JPN 3371', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('98b0e59d-28c6-5856-b937-ab6815a64d89', 'Gaku Hashimoto', 'opti-jpn-gaku-hashimoto-2992', 'JPN 2992', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('9ff9e58f-1e5f-5656-9752-7f2e3e6ceee1', 'Kaisei Sasaki', 'opti-jpn-kaisei-sasaki-2922', 'JPN 2922', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('3981f7f0-9bcf-5579-b973-ce145ff74af7', 'Nazuna Katagiri', 'opti-jpn-nazuna-katagiri-3169', 'JPN 3169', 'JPN', 'F', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('cb200b97-f924-502c-bd8f-d2d4cf5d87b7', 'Hikari Oguma', 'opti-jpn-hikari-oguma-3304', 'JPN 3304', 'JPN', 'F', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('b6cc0462-6ade-5f4e-9b69-6e439ea2f637', 'Eito Yonekura', 'opti-jpn-eito-yonekura-3021', 'JPN 3021', 'JPN', 'M', '横浜市民YHJYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('dde9ddd6-db05-5d2f-945c-69c1c40bfefa', 'Haruka Takahashi', 'opti-jpn-haruka-takahashi-3227', 'JPN 3227', 'JPN', 'M', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('1db25bd8-0213-553a-ac38-68887eb97519', 'Shuu Kazama', 'opti-jpn-shuu-kazama-2858', 'JPN 2858', 'JPN', 'M', '横浜市民YHJYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('839db335-1f1f-5265-9172-941d448dfde4', 'Yuki Takehara', 'opti-jpn-yuki-takehara-3302', 'JPN 3302', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('93211061-87e0-541b-a995-8a7f2a9ec78f', 'Takuto Seki', 'opti-jpn-takuto-seki-3208', 'JPN 3208', 'JPN', 'M', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('a7253e72-5a0e-5965-b71c-2f21435ced4b', 'Riri Fuchigami', 'opti-jpn-riri-fuchigami-3390', 'JPN 3390', 'JPN', 'F', 'チーム江東')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('eb4ed52c-da43-57fe-a977-3bf7a74f4a26', 'Sota Kikuchi', 'opti-jpn-sota-kikuchi-3372', 'JPN 3372', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('c8699aad-198a-5c7f-b8e0-19e22c81389b', 'Wahei Saegusa', 'opti-jpn-wahei-saegusa-3360', 'JPN 3360', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('c5cc6ae1-1174-53d1-b271-2ad004a24cb8', 'Tatsuki Osabe', 'opti-jpn-tatsuki-osabe-3303', 'JPN 3303', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('2ea5119e-ad68-53f6-bef1-4da853c13863', 'Nene Miyata', 'opti-jpn-nene-miyata-3114', 'JPN 3114', 'JPN', 'F', '横浜市民YHJYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('5b4f3be2-7312-52de-9494-8a157b59aaf9', 'Tasuku Nakamura', 'opti-jpn-tasuku-nakamura-3409', 'JPN 3409', 'JPN', 'M', 'チーム江東')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('abf594ea-f72f-57a8-b3d7-831633d2169d', 'Ayamo Torai', 'opti-jpn-ayamo-torai-3460', 'JPN 3460', 'JPN', 'F', '富山県JYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('101de41c-3d78-5248-a9b2-36a88119d281', 'Itsuki Watanabe', 'opti-jpn-itsuki-watanabe-3246', 'JPN 3246', 'JPN', 'M', 'YJYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('d23076d3-9729-5791-b1dc-7deb5ad9bc93', 'Honoka Kimura', 'opti-jpn-honoka-kimura-3512', 'JPN 3512', 'JPN', 'F', '夢の島YC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('4aa15132-b6cd-5283-b6e0-2abad8e69e39', 'Yasukazu Wimberley', 'opti-jpn-yasukazu-wimberley-3170', 'JPN 3170', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('0926e251-b81b-5585-9328-bfb95db14484', 'Tomoharu Seki', 'opti-jpn-tomoharu-seki-3139', 'JPN 3139', 'JPN', 'M', '横浜市民YHJYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('2c4324c2-fc52-523c-ab68-c93a200e0e2d', 'Sana Kayama', 'opti-jpn-sana-kayama-2967', 'JPN 2967', 'JPN', 'F', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('ab13f6f7-bb7f-5cea-8aaa-c9452a282670', 'Kiko Matsuda', 'opti-jpn-kiko-matsuda-2843', 'JPN 2843', 'JPN', 'F', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('ace62ef8-e779-5ce7-9b50-21c456520cec', 'Kanichi Wimberley', 'opti-jpn-kanichi-wimberley-2969', 'JPN 2969', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('6a8873bc-12ed-58a4-be8b-14f9d6ff1fe3', 'Kohei Hayashi', 'opti-jpn-kohei-hayashi-2940', 'JPN 2940', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('f68b54e7-7c68-5bba-a46a-d5b06708c413', 'Osepukova miro Miro', 'opti-jpn-osepukova-miro-miro-3306', 'JPN 3306', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('df3b979c-913d-5cc0-9a91-928938db6e62', 'Arata Takano', 'opti-jpn-arata-takano-3228', 'JPN 3228', 'JPN', 'M', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('79064913-e335-5eb2-9d2b-36cfcb1ade66', 'Rise Tsuge', 'opti-jpn-rise-tsuge-3315', 'JPN 3315', 'JPN', 'F', '三重JYYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('89895bbd-2b5e-5395-9225-0bfa155a1975', 'Kairi Nakamura', 'opti-jpn-kairi-nakamura-3389', 'JPN 3389', 'JPN', 'M', '夢の島YC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('56a195f7-573f-5799-b561-c37c60641c64', 'Itsuki Izawa', 'opti-jpn-itsuki-izawa-2606', 'JPN 2606', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('59f80ba3-ef5c-595d-a574-8401f7c939b7', 'Saki Noborio', 'opti-jpn-saki-noborio-3230', 'JPN 3230', 'JPN', 'F', 'FSSC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('e76834f4-43f9-5a53-88b2-4b7c59fd3f7c', 'Atsuto Yamazaki', 'opti-jpn-atsuto-yamazaki-3109', 'JPN 3109', 'JPN', 'M', 'YJYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('f9e15ee1-4848-573a-9a2e-d0991fafd1fb', 'Mantarou Kubota', 'opti-jpn-mantarou-kubota-2608', 'JPN 2608', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('c01f57a0-fea8-5419-9303-761b13a3ab93', 'Haruho Tabuchi', 'opti-jpn-haruho-tabuchi-32', 'JPN 32', 'JPN', 'M', 'CYBCJr')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('f4ae5487-ca29-59ac-8da3-c3272688babf', 'Kaito Aoki', 'opti-jpn-kaito-aoki-2605', 'JPN 2605', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('087d1030-05d8-51aa-b5a0-a3b3ba0e203a', 'Kaede Matsuura', 'opti-jpn-kaede-matsuura-3100', 'JPN 3100', 'JPN', 'F', '夢の島YC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('63669df5-1304-5513-be57-f98dac68910e', 'Yuina Iijima', 'opti-jpn-yuina-iijima-3096', 'JPN 3096', 'JPN', 'F', '夢の島YC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('15a2b569-9eeb-5f34-9a8b-c9745da43690', 'Taiichirou Sakaue', 'opti-jpn-taiichirou-sakaue-1', 'JPN 1', 'JPN', 'M', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('cd738e04-cc4c-5b9c-94a0-078cbada7f6e', 'Gento Nakayama', 'opti-jpn-gento-nakayama-2609', 'JPN 2609', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('6f0dd3b6-1bc2-52b3-a1a5-850717b7dee4', 'Mannakatomouta', 'opti-jpn-mannakatomouta-2940', 'JPN 2940', 'JPN', 'F', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('523be7c2-3db8-5273-a02a-9c840f48bf5f', 'Kanna Yamamura', 'opti-jpn-kanna-yamamura-338', 'JPN 338', 'JPN', 'F', '夢の島YC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('273c51a6-5102-5da4-aa7b-101fa09fb3be', 'Fujino Tatsuno', 'opti-jpn-fujino-tatsuno-4', 'JPN 4', 'JPN', 'F', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('5a69a6ad-12c9-543f-a19d-684d03bb3b27', 'Fuji Miyazawa', 'opti-jpn-fuji-miyazawa-2968', 'JPN 2968', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('a23a1b3d-fb0a-51b1-b886-ba4f9629bd3f', 'Kyouka Kadotani', 'opti-jpn-kyouka-kadotani-3320', 'JPN 3320', 'JPN', 'F', 'YJYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('cbfe767f-5bf4-536b-8c84-e2c92b6e3bc9', 'Hikari Yukumoto', 'opti-jpn-hikari-yukumoto-2597', 'JPN 2597', 'JPN', 'F', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('f9a8e58b-5d02-5cdf-9b89-3b53f305c6d5', 'Satouasahi', 'opti-jpn-satouasahi-3189', 'JPN 3189', 'JPN', 'M', '横浜市民YHJYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('36a84a18-97ca-56cc-88cf-5305436e68e2', 'Eba Murata', 'opti-jpn-eba-murata-3057', 'JPN 3057', 'JPN', 'M', 'FSSC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('a25ae618-37b6-5d86-9487-3b4b799d8687', 'Aoto Horiuchi', 'opti-jpn-aoto-horiuchi-3259', 'JPN 3259', 'JPN', 'M', 'EYCJ')
ON CONFLICT (id) DO NOTHING;

-- 4. Sailor Aliases (Kanji names)
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('21fee251-d07b-4f4b-be01-efead0178e57', 'Rohan Maliah HKG')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('21fee251-d07b-4f4b-be01-efead0178e57', 'RohanMaliahHKG')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1ac9dc89-783e-56c9-8c8d-785a5e10cccc', '山田 晟')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1ac9dc89-783e-56c9-8c8d-785a5e10cccc', '山田晟')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('187c0d31-a090-5d29-bcce-7e6d5e120279', '清水 優太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('187c0d31-a090-5d29-bcce-7e6d5e120279', '清水優太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c3777043-8cd8-525e-8a1e-be9d476a4ccc', '阪間 俊仁')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c3777043-8cd8-525e-8a1e-be9d476a4ccc', '阪間俊仁')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('89eed0ba-4c8d-49dc-a03e-6624a364f93c', '中村 海翔')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('89eed0ba-4c8d-49dc-a03e-6624a364f93c', '中村海翔')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('eba0deb0-10e4-4d3e-a5e5-5e3fa6287288', '樋口 颯希')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('eba0deb0-10e4-4d3e-a5e5-5e3fa6287288', '樋口颯希')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d5866bfe-8e21-585d-b8e7-2b76cb8feba7', '中田 琴海')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d5866bfe-8e21-585d-b8e7-2b76cb8feba7', '中田琴海')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f328eec8-af48-5826-9ffd-36ba379122c2', '樋口 耀紀')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f328eec8-af48-5826-9ffd-36ba379122c2', '樋口耀紀')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b24f2640-1c36-50ea-8fa3-243a3a48f08a', '亀田 留衣')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b24f2640-1c36-50ea-8fa3-243a3a48f08a', '亀田留衣')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b62a8c3f-fdc5-5574-85c1-e0731ba62fda', '富岡 英恵')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b62a8c3f-fdc5-5574-85c1-e0731ba62fda', '富岡英恵')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('11621fc9-3a7c-5509-8e01-5a2c92eeca01', '長堀 奨')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('11621fc9-3a7c-5509-8e01-5a2c92eeca01', '長堀奨')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ad4668e3-78b5-5402-a9a4-7641af07c063', '伊藤 照真')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ad4668e3-78b5-5402-a9a4-7641af07c063', '伊藤照真')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('0eeae64f-3b7c-5d25-b09c-0ae3e5eaa483', '樋口 楓斗')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('0eeae64f-3b7c-5d25-b09c-0ae3e5eaa483', '樋口楓斗')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6581432e-6145-5bfc-800a-7c7cd7a5619d', '西村 都央子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6581432e-6145-5bfc-800a-7c7cd7a5619d', '西村都央子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b6d30022-7628-522d-92fe-d63d1199a66b', '丹波 翔叡')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b6d30022-7628-522d-92fe-d63d1199a66b', '丹波翔叡')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6983fb52-7275-5278-86f0-9674f98aca01', '野村 厚太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6983fb52-7275-5278-86f0-9674f98aca01', '野村厚太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d5b1460c-ffb5-5bb9-bd8b-7f4e2c4bfab1', '辰野 志奈乃')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d5b1460c-ffb5-5bb9-bd8b-7f4e2c4bfab1', '辰野志奈乃')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('13bd0aab-ee6e-5536-8fb7-836169c66fac', '椎名 悠貴')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('13bd0aab-ee6e-5536-8fb7-836169c66fac', '椎名悠貴')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b0a725c6-026d-511e-8333-9adde320a379', '石川 凛乃')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b0a725c6-026d-511e-8333-9adde320a379', '石川凛乃')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5f728a1a-6dc6-5da1-a806-0beeb4f3010c', '内田 海音')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5f728a1a-6dc6-5da1-a806-0beeb4f3010c', '内田海音')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('dcd4351e-c984-5c40-bcd0-14f7698e841c', '岩波 由夏')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('dcd4351e-c984-5c40-bcd0-14f7698e841c', '岩波由夏')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('9c2aa8a7-86d0-5c81-9bef-ba0f0878d944', '平野 萌生')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('9c2aa8a7-86d0-5c81-9bef-ba0f0878d944', '平野萌生')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1af41791-9ec0-59c0-89d9-36d65f21dc4e', '今井 創也')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1af41791-9ec0-59c0-89d9-36d65f21dc4e', '今井創也')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('69a4292e-5d7e-5d91-bd42-df20e0db1a79', '宇多 泰誠')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('69a4292e-5d7e-5d91-bd42-df20e0db1a79', '宇多泰誠')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('cf720117-fc78-5233-94cb-d39bd57a1433', '松永 啓汰')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('cf720117-fc78-5233-94cb-d39bd57a1433', '松永啓汰')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('eaad9ca1-6091-594b-bc28-317b17adff58', '田淵 勇帆')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('eaad9ca1-6091-594b-bc28-317b17adff58', '田淵勇帆')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6e3927aa-a435-5bc6-bb40-867479f8ed5d', '水谷 智子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6e3927aa-a435-5bc6-bb40-867479f8ed5d', '水谷智子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c70ced96-bb4c-5869-9d1d-38d1ec05f79f', '根岸 渚沙')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c70ced96-bb4c-5869-9d1d-38d1ec05f79f', '根岸渚沙')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2bdc9622-d3e1-5026-a3bc-f0b8f30f1b6d', '眞田 彩愛')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2bdc9622-d3e1-5026-a3bc-f0b8f30f1b6d', '眞田彩愛')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b1713fdf-e19a-5b91-af9f-8db1a0fe4165', '髙野 光')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b1713fdf-e19a-5b91-af9f-8db1a0fe4165', '髙野光')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d292d6d5-a89b-568f-82f3-a448289014e4', '佐藤 英司')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d292d6d5-a89b-568f-82f3-a448289014e4', '佐藤英司')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('fe4c5005-571b-5805-8bbb-6063851835f9', '池ヶ谷 絢真')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('fe4c5005-571b-5805-8bbb-6063851835f9', '池ヶ谷絢真')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5c489dbf-8fa5-5c2f-bf4e-dc55f6b8ba08', '吉田 琉良')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5c489dbf-8fa5-5c2f-bf4e-dc55f6b8ba08', '吉田琉良')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d93c9115-6be9-5d29-80e2-e232e4cc89d4', '猪俣 汰星')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d93c9115-6be9-5d29-80e2-e232e4cc89d4', '猪俣汰星')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a4fc7a7a-62dc-5c60-b40b-089d09341dcb', '松浦 瑛士')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a4fc7a7a-62dc-5c60-b40b-089d09341dcb', '松浦瑛士')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('25ac7774-b971-5708-afb2-ce8fed50bbd3', '高橋 武尊')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('25ac7774-b971-5708-afb2-ce8fed50bbd3', '高橋武尊')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('cdb4723d-4a2c-543f-8d54-4abb9d7080aa', '松浦 悠真')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('cdb4723d-4a2c-543f-8d54-4abb9d7080aa', '松浦悠真')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('03255e8b-9496-5297-af53-6945dfbe901e', '田淵 隼矢')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('03255e8b-9496-5297-af53-6945dfbe901e', '田淵隼矢')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('70fcc745-a909-53ab-a54b-1ba753b5c569', '稲葉 絢圭')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('70fcc745-a909-53ab-a54b-1ba753b5c569', '稲葉絢圭')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b04104ba-7b19-5217-ac34-e806fbefd542', '石井 瑠里')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b04104ba-7b19-5217-ac34-e806fbefd542', '石井瑠里')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('e0235830-8309-53a8-937e-6f339c5554eb', '坂上 雄誠')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('e0235830-8309-53a8-937e-6f339c5554eb', '坂上雄誠')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('0eb30de4-6e06-50f3-b8d4-3f02cc0130dd', '山村 南菜')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('0eb30de4-6e06-50f3-b8d4-3f02cc0130dd', '山村南菜')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('4c6c867b-dead-5727-b7c7-c79d8a61176f', '上敷領 美海')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('4c6c867b-dead-5727-b7c7-c79d8a61176f', '上敷領美海')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('652c1835-ecb4-5ee1-8ee0-cdd5bc9e6d55', '川島 美彩')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('652c1835-ecb4-5ee1-8ee0-cdd5bc9e6d55', '川島美彩')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('48867110-3451-5b67-a8bd-247b239b21b7', '小坂 一花凜')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('48867110-3451-5b67-a8bd-247b239b21b7', '小坂一花凜')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('cc7f1a70-617c-5f0f-95c0-11ff6c600a27', '竹原 円豊')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('cc7f1a70-617c-5f0f-95c0-11ff6c600a27', '竹原円豊')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2e14e145-fef6-5982-b963-d801f1bb6a31', '窪田 柚希')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2e14e145-fef6-5982-b963-d801f1bb6a31', '窪田柚希')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c0619908-2d1c-5ad5-8c34-6200ce5aa6b5', '稲葉 陸斗')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c0619908-2d1c-5ad5-8c34-6200ce5aa6b5', '稲葉陸斗')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('7983e169-6802-58d2-b8c3-8b7a65225184', '川端ダンカン あいらエリザベス')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('7983e169-6802-58d2-b8c3-8b7a65225184', '川端ダンカンあいらエリザベス')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('29e386e1-b43b-5dea-80bb-b50ed04c1317', '山村 晟')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('29e386e1-b43b-5dea-80bb-b50ed04c1317', '山村晟')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a3ded086-1ecc-5be9-9458-382e9fbbe835', '岸 栄子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a3ded086-1ecc-5be9-9458-382e9fbbe835', '岸栄子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('55c04350-4b48-5cf1-96a4-5bdc914beead', '水本 真人')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('55c04350-4b48-5cf1-96a4-5bdc914beead', '水本真人')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('924d1f93-fc4d-54a0-a6a6-8738f48d6c3a', '住田 穂波')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('924d1f93-fc4d-54a0-a6a6-8738f48d6c3a', '住田穂波')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f31fc009-bdb8-56bd-8419-6b780b5c21d6', '大嶋 璃音')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f31fc009-bdb8-56bd-8419-6b780b5c21d6', '大嶋璃音')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ed71ace5-6086-578f-8e30-ad1d4fb1e949', 'チャリコワ')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('489d4743-1a7b-5f61-b3c2-2576df0df2fe', '林 昇平')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('489d4743-1a7b-5f61-b3c2-2576df0df2fe', '林昇平')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b9540a9d-2e0c-57d4-be71-ded6162cd8b0', '秦 響希')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b9540a9d-2e0c-57d4-be71-ded6162cd8b0', '秦響希')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('45578225-5f60-5a09-91e6-a93d66f23988', '江島 まな')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('45578225-5f60-5a09-91e6-a93d66f23988', '江島まな')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2769907e-9b02-5e6d-9196-f223e302c525', '久保 朔太郎')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2769907e-9b02-5e6d-9196-f223e302c525', '久保朔太郎')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('db249593-6acb-55d3-9e73-e39980a2e9b7', '森實 莉乃')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('db249593-6acb-55d3-9e73-e39980a2e9b7', '森實莉乃')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2e3bb12e-a03a-535e-974f-140cd5eae63c', '小林 秀')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2e3bb12e-a03a-535e-974f-140cd5eae63c', '小林秀')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('530f7665-acf6-5acd-9e30-ffd791f0d607', '岩﨑 碧飛')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('530f7665-acf6-5acd-9e30-ffd791f0d607', '岩﨑碧飛')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('98b0e59d-28c6-5856-b937-ab6815a64d89', '橋本 岳')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('98b0e59d-28c6-5856-b937-ab6815a64d89', '橋本岳')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('9ff9e58f-1e5f-5656-9752-7f2e3e6ceee1', '佐々木 海晟')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('9ff9e58f-1e5f-5656-9752-7f2e3e6ceee1', '佐々木海晟')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('3981f7f0-9bcf-5579-b973-ce145ff74af7', '片桐 なずな')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('3981f7f0-9bcf-5579-b973-ce145ff74af7', '片桐なずな')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('cb200b97-f924-502c-bd8f-d2d4cf5d87b7', '小熊 ひかり')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('cb200b97-f924-502c-bd8f-d2d4cf5d87b7', '小熊ひかり')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b6cc0462-6ade-5f4e-9b69-6e439ea2f637', '米倉 瑛斗')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b6cc0462-6ade-5f4e-9b69-6e439ea2f637', '米倉瑛斗')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('dde9ddd6-db05-5d2f-945c-69c1c40bfefa', '高橋 悠')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('dde9ddd6-db05-5d2f-945c-69c1c40bfefa', '高橋悠')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1db25bd8-0213-553a-ac38-68887eb97519', '風間 修羽')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1db25bd8-0213-553a-ac38-68887eb97519', '風間修羽')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('839db335-1f1f-5265-9172-941d448dfde4', '竹原 由基')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('839db335-1f1f-5265-9172-941d448dfde4', '竹原由基')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('93211061-87e0-541b-a995-8a7f2a9ec78f', '関 逞人')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('93211061-87e0-541b-a995-8a7f2a9ec78f', '関逞人')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a7253e72-5a0e-5965-b71c-2f21435ced4b', '渕上 凛々')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a7253e72-5a0e-5965-b71c-2f21435ced4b', '渕上凛々')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('eb4ed52c-da43-57fe-a977-3bf7a74f4a26', '菊池 颯太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('eb4ed52c-da43-57fe-a977-3bf7a74f4a26', '菊池颯太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c8699aad-198a-5c7f-b8e0-19e22c81389b', '三枝 和平')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c8699aad-198a-5c7f-b8e0-19e22c81389b', '三枝和平')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c5cc6ae1-1174-53d1-b271-2ad004a24cb8', '長部 立希')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c5cc6ae1-1174-53d1-b271-2ad004a24cb8', '長部立希')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2ea5119e-ad68-53f6-bef1-4da853c13863', '宮田 寧々')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2ea5119e-ad68-53f6-bef1-4da853c13863', '宮田寧々')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5b4f3be2-7312-52de-9494-8a157b59aaf9', '中村 翼')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5b4f3be2-7312-52de-9494-8a157b59aaf9', '中村翼')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('abf594ea-f72f-57a8-b3d7-831633d2169d', '虎井 彩雲')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('abf594ea-f72f-57a8-b3d7-831633d2169d', '虎井彩雲')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('101de41c-3d78-5248-a9b2-36a88119d281', '渡辺 樹')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('101de41c-3d78-5248-a9b2-36a88119d281', '渡辺樹')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d23076d3-9729-5791-b1dc-7deb5ad9bc93', '木村 帆乃佳')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d23076d3-9729-5791-b1dc-7deb5ad9bc93', '木村帆乃佳')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('4aa15132-b6cd-5283-b6e0-2abad8e69e39', 'ウィンバーリー 康算')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('4aa15132-b6cd-5283-b6e0-2abad8e69e39', 'ウィンバーリー康算')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('0926e251-b81b-5585-9328-bfb95db14484', '関 智晴')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('0926e251-b81b-5585-9328-bfb95db14484', '関智晴')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2c4324c2-fc52-523c-ab68-c93a200e0e2d', '嘉山 沙南')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2c4324c2-fc52-523c-ab68-c93a200e0e2d', '嘉山沙南')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ab13f6f7-bb7f-5cea-8aaa-c9452a282670', '松田 季子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ab13f6f7-bb7f-5cea-8aaa-c9452a282670', '松田季子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ace62ef8-e779-5ce7-9b50-21c456520cec', 'ウィンバーリー 貫一')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ace62ef8-e779-5ce7-9b50-21c456520cec', 'ウィンバーリー貫一')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6a8873bc-12ed-58a4-be8b-14f9d6ff1fe3', '林 昊平')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6a8873bc-12ed-58a4-be8b-14f9d6ff1fe3', '林昊平')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f68b54e7-7c68-5bba-a46a-d5b06708c413', 'オセプコヴァ')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('df3b979c-913d-5cc0-9a91-928938db6e62', '髙野 新')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('df3b979c-913d-5cc0-9a91-928938db6e62', '髙野新')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('79064913-e335-5eb2-9d2b-36cfcb1ade66', '柘植 莉世')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('79064913-e335-5eb2-9d2b-36cfcb1ade66', '柘植莉世')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('89895bbd-2b5e-5395-9225-0bfa155a1975', '中村 海俐')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('89895bbd-2b5e-5395-9225-0bfa155a1975', '中村海俐')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('56a195f7-573f-5799-b561-c37c60641c64', '井澤 樹')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('56a195f7-573f-5799-b561-c37c60641c64', '井澤樹')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('59f80ba3-ef5c-595d-a574-8401f7c939b7', '登尾 咲')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('59f80ba3-ef5c-595d-a574-8401f7c939b7', '登尾咲')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('e76834f4-43f9-5a53-88b2-4b7c59fd3f7c', '山崎 篤人')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('e76834f4-43f9-5a53-88b2-4b7c59fd3f7c', '山崎篤人')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f9e15ee1-4848-573a-9a2e-d0991fafd1fb', '久保田 万太郎')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f9e15ee1-4848-573a-9a2e-d0991fafd1fb', '久保田万太郎')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c01f57a0-fea8-5419-9303-761b13a3ab93', '田淵 陽帆')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c01f57a0-fea8-5419-9303-761b13a3ab93', '田淵陽帆')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f4ae5487-ca29-59ac-8da3-c3272688babf', '青木 海翔')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f4ae5487-ca29-59ac-8da3-c3272688babf', '青木海翔')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('087d1030-05d8-51aa-b5a0-a3b3ba0e203a', '松浦 楓')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('087d1030-05d8-51aa-b5a0-a3b3ba0e203a', '松浦楓')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('63669df5-1304-5513-be57-f98dac68910e', '飯嶋 柚衣凪')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('63669df5-1304-5513-be57-f98dac68910e', '飯嶋柚衣凪')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('15a2b569-9eeb-5f34-9a8b-c9745da43690', '坂上 泰一朗')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('15a2b569-9eeb-5f34-9a8b-c9745da43690', '坂上泰一朗')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('cd738e04-cc4c-5b9c-94a0-078cbada7f6e', '中山 弦音')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('cd738e04-cc4c-5b9c-94a0-078cbada7f6e', '中山弦音')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6f0dd3b6-1bc2-52b3-a1a5-850717b7dee4', '真中 朋歌')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6f0dd3b6-1bc2-52b3-a1a5-850717b7dee4', '真中朋歌')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('523be7c2-3db8-5273-a02a-9c840f48bf5f', '山村 環菜')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('523be7c2-3db8-5273-a02a-9c840f48bf5f', '山村環菜')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('273c51a6-5102-5da4-aa7b-101fa09fb3be', '辰野 富志乃')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('273c51a6-5102-5da4-aa7b-101fa09fb3be', '辰野富志乃')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5a69a6ad-12c9-543f-a19d-684d03bb3b27', '宮沢 ふじ')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5a69a6ad-12c9-543f-a19d-684d03bb3b27', '宮沢ふじ')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a23a1b3d-fb0a-51b1-b886-ba4f9629bd3f', '⻆谷 京香')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a23a1b3d-fb0a-51b1-b886-ba4f9629bd3f', '⻆谷京香')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('cbfe767f-5bf4-536b-8c84-e2c92b6e3bc9', '行本 ひかり')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('cbfe767f-5bf4-536b-8c84-e2c92b6e3bc9', '行本ひかり')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f9a8e58b-5d02-5cdf-9b89-3b53f305c6d5', '佐藤 旭')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f9a8e58b-5d02-5cdf-9b89-3b53f305c6d5', '佐藤旭')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('36a84a18-97ca-56cc-88cf-5305436e68e2', '村田 英波')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('36a84a18-97ca-56cc-88cf-5305436e68e2', '村田英波')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a25ae618-37b6-5d86-9487-3b4b799d8687', '堀内 碧渡')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a25ae618-37b6-5d86-9487-3b4b799d8687', '堀内碧渡')
ON CONFLICT (alias_name) DO NOTHING;

-- 5. Regatta Results: Class A (87 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '71858e29-7afb-56da-9955-653f687ed4c3',
    '21fee251-d07b-4f4b-be01-efead0178e57',
    'add537f4-4531-5793-b0db-408493c608c5',
    'Rohan Maliah HKG',
    'HKG 197',
    'individual',
    1,
    34.0,
    19.0,
    'M',
    'HKG',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fbd50185-7932-5027-b7c9-7da36124618f',
    '71858e29-7afb-56da-9955-653f687ed4c3',
    '21fee251-d07b-4f4b-be01-efead0178e57',
    'Rohan Maliah HKG',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71858e29-7afb-56da-9955-653f687ed4c3',
    1,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71858e29-7afb-56da-9955-653f687ed4c3',
    2,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71858e29-7afb-56da-9955-653f687ed4c3',
    3,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71858e29-7afb-56da-9955-653f687ed4c3',
    4,
    15.0,
    NULL,
    true,
    '(15.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71858e29-7afb-56da-9955-653f687ed4c3',
    5,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71858e29-7afb-56da-9955-653f687ed4c3',
    6,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71858e29-7afb-56da-9955-653f687ed4c3',
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
    'aa95bd12-d7d6-53fc-a10c-af0ec8a9d1f8',
    '1ac9dc89-783e-56c9-8c8d-785a5e10cccc',
    'add537f4-4531-5793-b0db-408493c608c5',
    '山田 晟',
    'JPN 3394',
    'individual',
    2,
    34.0,
    21.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'cd84e4d6-28e5-5b1c-8d58-cf7b011c13c0',
    'aa95bd12-d7d6-53fc-a10c-af0ec8a9d1f8',
    '1ac9dc89-783e-56c9-8c8d-785a5e10cccc',
    '山田 晟',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa95bd12-d7d6-53fc-a10c-af0ec8a9d1f8',
    1,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa95bd12-d7d6-53fc-a10c-af0ec8a9d1f8',
    2,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa95bd12-d7d6-53fc-a10c-af0ec8a9d1f8',
    3,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa95bd12-d7d6-53fc-a10c-af0ec8a9d1f8',
    4,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa95bd12-d7d6-53fc-a10c-af0ec8a9d1f8',
    5,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa95bd12-d7d6-53fc-a10c-af0ec8a9d1f8',
    6,
    13.0,
    NULL,
    true,
    '(13.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aa95bd12-d7d6-53fc-a10c-af0ec8a9d1f8',
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
    'a28bc975-8f96-5430-bbf8-b38667d604fe',
    '187c0d31-a090-5d29-bcce-7e6d5e120279',
    'add537f4-4531-5793-b0db-408493c608c5',
    '清水 優太',
    'JPN 3479',
    'individual',
    3,
    35.0,
    24.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7f5a5b95-2a2e-5203-ae2c-2126d5b02713',
    'a28bc975-8f96-5430-bbf8-b38667d604fe',
    '187c0d31-a090-5d29-bcce-7e6d5e120279',
    '清水 優太',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a28bc975-8f96-5430-bbf8-b38667d604fe',
    1,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a28bc975-8f96-5430-bbf8-b38667d604fe',
    2,
    11.0,
    NULL,
    true,
    '(11.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a28bc975-8f96-5430-bbf8-b38667d604fe',
    3,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a28bc975-8f96-5430-bbf8-b38667d604fe',
    4,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a28bc975-8f96-5430-bbf8-b38667d604fe',
    5,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a28bc975-8f96-5430-bbf8-b38667d604fe',
    6,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a28bc975-8f96-5430-bbf8-b38667d604fe',
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
    '3b446eb4-5acf-54d9-9d31-c9572f790b19',
    'c3777043-8cd8-525e-8a1e-be9d476a4ccc',
    'add537f4-4531-5793-b0db-408493c608c5',
    '阪間 俊仁',
    'JPN 3154',
    'individual',
    4,
    44.0,
    34.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a6656290-fbf6-5b1f-8df1-650344a8efda',
    '3b446eb4-5acf-54d9-9d31-c9572f790b19',
    'c3777043-8cd8-525e-8a1e-be9d476a4ccc',
    '阪間 俊仁',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3b446eb4-5acf-54d9-9d31-c9572f790b19',
    1,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3b446eb4-5acf-54d9-9d31-c9572f790b19',
    2,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3b446eb4-5acf-54d9-9d31-c9572f790b19',
    3,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3b446eb4-5acf-54d9-9d31-c9572f790b19',
    4,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3b446eb4-5acf-54d9-9d31-c9572f790b19',
    5,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3b446eb4-5acf-54d9-9d31-c9572f790b19',
    6,
    10.0,
    NULL,
    true,
    '(10.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3b446eb4-5acf-54d9-9d31-c9572f790b19',
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
    '03fba881-5e55-5e33-9f43-3c3427dfb08f',
    '89eed0ba-4c8d-49dc-a03e-6624a364f93c',
    'add537f4-4531-5793-b0db-408493c608c5',
    '中村 海翔',
    'JPN 3444',
    'individual',
    5,
    53.0,
    38.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '17061453-008f-5682-a6dd-b02c97b361d0',
    '03fba881-5e55-5e33-9f43-3c3427dfb08f',
    '89eed0ba-4c8d-49dc-a03e-6624a364f93c',
    '中村 海翔',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03fba881-5e55-5e33-9f43-3c3427dfb08f',
    1,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03fba881-5e55-5e33-9f43-3c3427dfb08f',
    2,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03fba881-5e55-5e33-9f43-3c3427dfb08f',
    3,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03fba881-5e55-5e33-9f43-3c3427dfb08f',
    4,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03fba881-5e55-5e33-9f43-3c3427dfb08f',
    5,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03fba881-5e55-5e33-9f43-3c3427dfb08f',
    6,
    15.0,
    NULL,
    true,
    '(15.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '03fba881-5e55-5e33-9f43-3c3427dfb08f',
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
    '801090d3-edac-50f1-a6cc-2ad379ed2faa',
    'eba0deb0-10e4-4d3e-a5e5-5e3fa6287288',
    'add537f4-4531-5793-b0db-408493c608c5',
    '樋口 颯希',
    'JPN 3443',
    'individual',
    6,
    58.0,
    39.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7baa0b15-5b23-529b-a2b2-28274dc3791d',
    '801090d3-edac-50f1-a6cc-2ad379ed2faa',
    'eba0deb0-10e4-4d3e-a5e5-5e3fa6287288',
    '樋口 颯希',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '801090d3-edac-50f1-a6cc-2ad379ed2faa',
    1,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '801090d3-edac-50f1-a6cc-2ad379ed2faa',
    2,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '801090d3-edac-50f1-a6cc-2ad379ed2faa',
    3,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '801090d3-edac-50f1-a6cc-2ad379ed2faa',
    4,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '801090d3-edac-50f1-a6cc-2ad379ed2faa',
    5,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '801090d3-edac-50f1-a6cc-2ad379ed2faa',
    6,
    19.0,
    NULL,
    true,
    '(19.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '801090d3-edac-50f1-a6cc-2ad379ed2faa',
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
    'fadb9ed8-7901-5e7b-8473-4dfe9f77ceb4',
    'd5866bfe-8e21-585d-b8e7-2b76cb8feba7',
    'add537f4-4531-5793-b0db-408493c608c5',
    '中田 琴海',
    'JPN 3446',
    'individual',
    7,
    67.0,
    48.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '40370225-fd6e-5998-bae9-36d00a92114f',
    'fadb9ed8-7901-5e7b-8473-4dfe9f77ceb4',
    'd5866bfe-8e21-585d-b8e7-2b76cb8feba7',
    '中田 琴海',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fadb9ed8-7901-5e7b-8473-4dfe9f77ceb4',
    1,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fadb9ed8-7901-5e7b-8473-4dfe9f77ceb4',
    2,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fadb9ed8-7901-5e7b-8473-4dfe9f77ceb4',
    3,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fadb9ed8-7901-5e7b-8473-4dfe9f77ceb4',
    4,
    19.0,
    NULL,
    true,
    '(19.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fadb9ed8-7901-5e7b-8473-4dfe9f77ceb4',
    5,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fadb9ed8-7901-5e7b-8473-4dfe9f77ceb4',
    6,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fadb9ed8-7901-5e7b-8473-4dfe9f77ceb4',
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
    '72311772-31d3-5bb4-8553-055b95facf95',
    'f328eec8-af48-5826-9ffd-36ba379122c2',
    'add537f4-4531-5793-b0db-408493c608c5',
    '樋口 耀紀',
    'JPN 3442',
    'individual',
    8,
    93.0,
    56.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '95ffe6ad-88e6-58c3-bf44-9bbeb185225a',
    '72311772-31d3-5bb4-8553-055b95facf95',
    'f328eec8-af48-5826-9ffd-36ba379122c2',
    '樋口 耀紀',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72311772-31d3-5bb4-8553-055b95facf95',
    1,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72311772-31d3-5bb4-8553-055b95facf95',
    2,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72311772-31d3-5bb4-8553-055b95facf95',
    3,
    37.0,
    NULL,
    true,
    '(37.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72311772-31d3-5bb4-8553-055b95facf95',
    4,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72311772-31d3-5bb4-8553-055b95facf95',
    5,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72311772-31d3-5bb4-8553-055b95facf95',
    6,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '72311772-31d3-5bb4-8553-055b95facf95',
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
    '62cc6928-ba5e-5c9d-8817-4abffa0a969b',
    'b24f2640-1c36-50ea-8fa3-243a3a48f08a',
    'add537f4-4531-5793-b0db-408493c608c5',
    '亀田 留衣',
    'JPN 3550',
    'individual',
    9,
    88.0,
    57.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '51869673-782b-571b-b3f5-c4cafd9867c6',
    '62cc6928-ba5e-5c9d-8817-4abffa0a969b',
    'b24f2640-1c36-50ea-8fa3-243a3a48f08a',
    '亀田 留衣',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62cc6928-ba5e-5c9d-8817-4abffa0a969b',
    1,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62cc6928-ba5e-5c9d-8817-4abffa0a969b',
    2,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62cc6928-ba5e-5c9d-8817-4abffa0a969b',
    3,
    31.0,
    NULL,
    true,
    '(31.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62cc6928-ba5e-5c9d-8817-4abffa0a969b',
    4,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62cc6928-ba5e-5c9d-8817-4abffa0a969b',
    5,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62cc6928-ba5e-5c9d-8817-4abffa0a969b',
    6,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62cc6928-ba5e-5c9d-8817-4abffa0a969b',
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
    'c308f403-3cdb-5b90-a334-7313d676c65e',
    'b62a8c3f-fdc5-5574-85c1-e0731ba62fda',
    'add537f4-4531-5793-b0db-408493c608c5',
    '富岡 英恵',
    'JPN 3211',
    'individual',
    10,
    84.0,
    62.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2cad524d-71a9-5aab-9b69-596886ebb161',
    'c308f403-3cdb-5b90-a334-7313d676c65e',
    'b62a8c3f-fdc5-5574-85c1-e0731ba62fda',
    '富岡 英恵',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c308f403-3cdb-5b90-a334-7313d676c65e',
    1,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c308f403-3cdb-5b90-a334-7313d676c65e',
    2,
    22.0,
    NULL,
    true,
    '(22.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c308f403-3cdb-5b90-a334-7313d676c65e',
    3,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c308f403-3cdb-5b90-a334-7313d676c65e',
    4,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c308f403-3cdb-5b90-a334-7313d676c65e',
    5,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c308f403-3cdb-5b90-a334-7313d676c65e',
    6,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c308f403-3cdb-5b90-a334-7313d676c65e',
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
    '8f9df741-170e-5a58-ac30-0f1fbfd336eb',
    '11621fc9-3a7c-5509-8e01-5a2c92eeca01',
    'add537f4-4531-5793-b0db-408493c608c5',
    '長堀 奨',
    'JPN 3153',
    'individual',
    11,
    86.0,
    62.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '07c38cb9-3c87-5e25-b6aa-f0a0f8eb0ddc',
    '8f9df741-170e-5a58-ac30-0f1fbfd336eb',
    '11621fc9-3a7c-5509-8e01-5a2c92eeca01',
    '長堀 奨',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f9df741-170e-5a58-ac30-0f1fbfd336eb',
    1,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f9df741-170e-5a58-ac30-0f1fbfd336eb',
    2,
    24.0,
    NULL,
    true,
    '(24.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f9df741-170e-5a58-ac30-0f1fbfd336eb',
    3,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f9df741-170e-5a58-ac30-0f1fbfd336eb',
    4,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f9df741-170e-5a58-ac30-0f1fbfd336eb',
    5,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f9df741-170e-5a58-ac30-0f1fbfd336eb',
    6,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f9df741-170e-5a58-ac30-0f1fbfd336eb',
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
    'b1a5a883-5b42-5283-b238-395952e6e14e',
    'ad4668e3-78b5-5402-a9a4-7641af07c063',
    'add537f4-4531-5793-b0db-408493c608c5',
    '伊藤 照真',
    'JPN 3440',
    'individual',
    12,
    166.0,
    78.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '10afa16c-5bed-5e21-8d45-bdcfdd0fdc3c',
    'b1a5a883-5b42-5283-b238-395952e6e14e',
    'ad4668e3-78b5-5402-a9a4-7641af07c063',
    '伊藤 照真',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1a5a883-5b42-5283-b238-395952e6e14e',
    1,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1a5a883-5b42-5283-b238-395952e6e14e',
    2,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1a5a883-5b42-5283-b238-395952e6e14e',
    3,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1a5a883-5b42-5283-b238-395952e6e14e',
    4,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1a5a883-5b42-5283-b238-395952e6e14e',
    5,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1a5a883-5b42-5283-b238-395952e6e14e',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1a5a883-5b42-5283-b238-395952e6e14e',
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
    '8ee5a6b2-b99c-56d4-ac50-6712eae0c31a',
    '0eeae64f-3b7c-5d25-b09c-0ae3e5eaa483',
    'add537f4-4531-5793-b0db-408493c608c5',
    '樋口 楓斗',
    'JPN 3478',
    'individual',
    13,
    124.0,
    96.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c5fa3592-4b97-5bff-bdab-5cdcdf9acb7f',
    '8ee5a6b2-b99c-56d4-ac50-6712eae0c31a',
    '0eeae64f-3b7c-5d25-b09c-0ae3e5eaa483',
    '樋口 楓斗',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ee5a6b2-b99c-56d4-ac50-6712eae0c31a',
    1,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ee5a6b2-b99c-56d4-ac50-6712eae0c31a',
    2,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ee5a6b2-b99c-56d4-ac50-6712eae0c31a',
    3,
    28.0,
    NULL,
    true,
    '(28.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ee5a6b2-b99c-56d4-ac50-6712eae0c31a',
    4,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ee5a6b2-b99c-56d4-ac50-6712eae0c31a',
    5,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ee5a6b2-b99c-56d4-ac50-6712eae0c31a',
    6,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8ee5a6b2-b99c-56d4-ac50-6712eae0c31a',
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
    '65553b33-5de8-55a2-adba-2cd61b89054e',
    '6581432e-6145-5bfc-800a-7c7cd7a5619d',
    'add537f4-4531-5793-b0db-408493c608c5',
    '西村 都央子',
    'JPN 3365',
    'individual',
    14,
    142.0,
    103.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f17414bf-1098-5bea-b192-ac5ffa69bd1d',
    '65553b33-5de8-55a2-adba-2cd61b89054e',
    '6581432e-6145-5bfc-800a-7c7cd7a5619d',
    '西村 都央子',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '65553b33-5de8-55a2-adba-2cd61b89054e',
    1,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '65553b33-5de8-55a2-adba-2cd61b89054e',
    2,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '65553b33-5de8-55a2-adba-2cd61b89054e',
    3,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '65553b33-5de8-55a2-adba-2cd61b89054e',
    4,
    39.0,
    NULL,
    true,
    '(39.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '65553b33-5de8-55a2-adba-2cd61b89054e',
    5,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '65553b33-5de8-55a2-adba-2cd61b89054e',
    6,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '65553b33-5de8-55a2-adba-2cd61b89054e',
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
    '3c7a49d5-78ba-5149-8896-8f286f58d410',
    'b6d30022-7628-522d-92fe-d63d1199a66b',
    'add537f4-4531-5793-b0db-408493c608c5',
    '丹波 翔叡',
    'JPN 3487',
    'individual',
    15,
    192.0,
    104.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bbd4e6c6-fa69-5c57-b05d-f5285a950e45',
    '3c7a49d5-78ba-5149-8896-8f286f58d410',
    'b6d30022-7628-522d-92fe-d63d1199a66b',
    '丹波 翔叡',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c7a49d5-78ba-5149-8896-8f286f58d410',
    1,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c7a49d5-78ba-5149-8896-8f286f58d410',
    2,
    88.0,
    'DSQ',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c7a49d5-78ba-5149-8896-8f286f58d410',
    3,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c7a49d5-78ba-5149-8896-8f286f58d410',
    4,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c7a49d5-78ba-5149-8896-8f286f58d410',
    5,
    30.0,
    NULL,
    false,
    '30.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c7a49d5-78ba-5149-8896-8f286f58d410',
    6,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c7a49d5-78ba-5149-8896-8f286f58d410',
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
    '00564807-0560-507a-9aa6-e1557d3427b4',
    '6983fb52-7275-5278-86f0-9674f98aca01',
    'add537f4-4531-5793-b0db-408493c608c5',
    '野村 厚太',
    'JPN 3456',
    'individual',
    16,
    137.0,
    107.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'cc35e70a-cc3d-5293-ae68-6d04a795f455',
    '00564807-0560-507a-9aa6-e1557d3427b4',
    '6983fb52-7275-5278-86f0-9674f98aca01',
    '野村 厚太',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00564807-0560-507a-9aa6-e1557d3427b4',
    1,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00564807-0560-507a-9aa6-e1557d3427b4',
    2,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00564807-0560-507a-9aa6-e1557d3427b4',
    3,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00564807-0560-507a-9aa6-e1557d3427b4',
    4,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00564807-0560-507a-9aa6-e1557d3427b4',
    5,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00564807-0560-507a-9aa6-e1557d3427b4',
    6,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00564807-0560-507a-9aa6-e1557d3427b4',
    7,
    30.0,
    NULL,
    true,
    '(30.0)'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'e6cb3d1c-cdc9-5416-aa0d-9fcb0774d9f4',
    'd5b1460c-ffb5-5bb9-bd8b-7f4e2c4bfab1',
    'add537f4-4531-5793-b0db-408493c608c5',
    '辰野 志奈乃',
    'JPN 3425',
    'individual',
    17,
    143.0,
    110.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5fcac7c8-dc21-5d4d-b460-b605f14141cc',
    'e6cb3d1c-cdc9-5416-aa0d-9fcb0774d9f4',
    'd5b1460c-ffb5-5bb9-bd8b-7f4e2c4bfab1',
    '辰野 志奈乃',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6cb3d1c-cdc9-5416-aa0d-9fcb0774d9f4',
    1,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6cb3d1c-cdc9-5416-aa0d-9fcb0774d9f4',
    2,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6cb3d1c-cdc9-5416-aa0d-9fcb0774d9f4',
    3,
    33.0,
    NULL,
    true,
    '(33.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6cb3d1c-cdc9-5416-aa0d-9fcb0774d9f4',
    4,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6cb3d1c-cdc9-5416-aa0d-9fcb0774d9f4',
    5,
    32.0,
    NULL,
    false,
    '32.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6cb3d1c-cdc9-5416-aa0d-9fcb0774d9f4',
    6,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6cb3d1c-cdc9-5416-aa0d-9fcb0774d9f4',
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
    'e4896495-9f25-581a-8b57-a4544fb2981a',
    '13bd0aab-ee6e-5536-8fb7-836169c66fac',
    'add537f4-4531-5793-b0db-408493c608c5',
    '椎名 悠貴',
    'JPN 3448',
    'individual',
    18,
    142.0,
    113.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ff455bcc-5cdf-51b8-b2d1-02afbfa8123a',
    'e4896495-9f25-581a-8b57-a4544fb2981a',
    '13bd0aab-ee6e-5536-8fb7-836169c66fac',
    '椎名 悠貴',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4896495-9f25-581a-8b57-a4544fb2981a',
    1,
    29.0,
    NULL,
    true,
    '(29.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4896495-9f25-581a-8b57-a4544fb2981a',
    2,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4896495-9f25-581a-8b57-a4544fb2981a',
    3,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4896495-9f25-581a-8b57-a4544fb2981a',
    4,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4896495-9f25-581a-8b57-a4544fb2981a',
    5,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4896495-9f25-581a-8b57-a4544fb2981a',
    6,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4896495-9f25-581a-8b57-a4544fb2981a',
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
    '15e01b52-d11e-58bf-ab12-ab3c5a07c39b',
    'b0a725c6-026d-511e-8333-9adde320a379',
    'add537f4-4531-5793-b0db-408493c608c5',
    '石川 凛乃',
    'JPN 3488',
    'individual',
    19,
    202.0,
    114.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a1ac34cc-fef7-55af-b989-cf44d1e04811',
    '15e01b52-d11e-58bf-ab12-ab3c5a07c39b',
    'b0a725c6-026d-511e-8333-9adde320a379',
    '石川 凛乃',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15e01b52-d11e-58bf-ab12-ab3c5a07c39b',
    1,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15e01b52-d11e-58bf-ab12-ab3c5a07c39b',
    2,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15e01b52-d11e-58bf-ab12-ab3c5a07c39b',
    3,
    30.0,
    NULL,
    false,
    '30.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15e01b52-d11e-58bf-ab12-ab3c5a07c39b',
    4,
    30.0,
    NULL,
    false,
    '30.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15e01b52-d11e-58bf-ab12-ab3c5a07c39b',
    5,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15e01b52-d11e-58bf-ab12-ab3c5a07c39b',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '15e01b52-d11e-58bf-ab12-ab3c5a07c39b',
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
    '8bc4aeb1-d57e-57e4-90e8-c9d8e49097a5',
    '5f728a1a-6dc6-5da1-a806-0beeb4f3010c',
    'add537f4-4531-5793-b0db-408493c608c5',
    '内田 海音',
    'JPN 3511',
    'individual',
    20,
    156.0,
    120.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4e06dcb4-f791-5192-a8fd-d353436686cf',
    '8bc4aeb1-d57e-57e4-90e8-c9d8e49097a5',
    '5f728a1a-6dc6-5da1-a806-0beeb4f3010c',
    '内田 海音',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8bc4aeb1-d57e-57e4-90e8-c9d8e49097a5',
    1,
    31.0,
    NULL,
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8bc4aeb1-d57e-57e4-90e8-c9d8e49097a5',
    2,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8bc4aeb1-d57e-57e4-90e8-c9d8e49097a5',
    3,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8bc4aeb1-d57e-57e4-90e8-c9d8e49097a5',
    4,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8bc4aeb1-d57e-57e4-90e8-c9d8e49097a5',
    5,
    36.0,
    NULL,
    true,
    '(36.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8bc4aeb1-d57e-57e4-90e8-c9d8e49097a5',
    6,
    34.0,
    NULL,
    false,
    '34.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8bc4aeb1-d57e-57e4-90e8-c9d8e49097a5',
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
    '5d4fb526-9a37-509d-9ab7-15a04900ef2f',
    'dcd4351e-c984-5c40-bcd0-14f7698e841c',
    'add537f4-4531-5793-b0db-408493c608c5',
    '岩波 由夏',
    'JPN 3376',
    'individual',
    21,
    160.0,
    126.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '59b1b091-bc97-5a92-a829-a4e0e046a273',
    '5d4fb526-9a37-509d-9ab7-15a04900ef2f',
    'dcd4351e-c984-5c40-bcd0-14f7698e841c',
    '岩波 由夏',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d4fb526-9a37-509d-9ab7-15a04900ef2f',
    1,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d4fb526-9a37-509d-9ab7-15a04900ef2f',
    2,
    32.0,
    NULL,
    false,
    '32.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d4fb526-9a37-509d-9ab7-15a04900ef2f',
    3,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d4fb526-9a37-509d-9ab7-15a04900ef2f',
    4,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d4fb526-9a37-509d-9ab7-15a04900ef2f',
    5,
    34.0,
    NULL,
    true,
    '(34.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d4fb526-9a37-509d-9ab7-15a04900ef2f',
    6,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d4fb526-9a37-509d-9ab7-15a04900ef2f',
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
    'fd83fa2a-8a33-5261-90ee-2190da17c310',
    '9c2aa8a7-86d0-5c81-9bef-ba0f0878d944',
    'add537f4-4531-5793-b0db-408493c608c5',
    '平野 萌生',
    'JPN 3358',
    'individual',
    22,
    168.0,
    129.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b22f6ed1-44ee-5800-9cf8-bd4944d35bfd',
    'fd83fa2a-8a33-5261-90ee-2190da17c310',
    '9c2aa8a7-86d0-5c81-9bef-ba0f0878d944',
    '平野 萌生',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fd83fa2a-8a33-5261-90ee-2190da17c310',
    1,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fd83fa2a-8a33-5261-90ee-2190da17c310',
    2,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fd83fa2a-8a33-5261-90ee-2190da17c310',
    3,
    39.0,
    NULL,
    true,
    '(39.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fd83fa2a-8a33-5261-90ee-2190da17c310',
    4,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fd83fa2a-8a33-5261-90ee-2190da17c310',
    5,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fd83fa2a-8a33-5261-90ee-2190da17c310',
    6,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fd83fa2a-8a33-5261-90ee-2190da17c310',
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
    'dd1dadd1-2b0c-5098-a66f-02f5a1efb1a0',
    '1af41791-9ec0-59c0-89d9-36d65f21dc4e',
    'add537f4-4531-5793-b0db-408493c608c5',
    '今井 創也',
    'JPN 3282',
    'individual',
    23,
    186.0,
    148.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0ff8ca97-39f0-530b-b5d0-bd86eacd8a9e',
    'dd1dadd1-2b0c-5098-a66f-02f5a1efb1a0',
    '1af41791-9ec0-59c0-89d9-36d65f21dc4e',
    '今井 創也',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dd1dadd1-2b0c-5098-a66f-02f5a1efb1a0',
    1,
    35.0,
    NULL,
    false,
    '35.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dd1dadd1-2b0c-5098-a66f-02f5a1efb1a0',
    2,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dd1dadd1-2b0c-5098-a66f-02f5a1efb1a0',
    3,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dd1dadd1-2b0c-5098-a66f-02f5a1efb1a0',
    4,
    38.0,
    NULL,
    true,
    '(38.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dd1dadd1-2b0c-5098-a66f-02f5a1efb1a0',
    5,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dd1dadd1-2b0c-5098-a66f-02f5a1efb1a0',
    6,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dd1dadd1-2b0c-5098-a66f-02f5a1efb1a0',
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
    'a6ddbabc-a9f8-5dd6-8ea2-162f179f202a',
    '69a4292e-5d7e-5d91-bd42-df20e0db1a79',
    'add537f4-4531-5793-b0db-408493c608c5',
    '宇多 泰誠',
    'JPN 3467',
    'individual',
    24,
    202.0,
    150.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '20bdde13-4782-599b-95b1-495dd720078b',
    'a6ddbabc-a9f8-5dd6-8ea2-162f179f202a',
    '69a4292e-5d7e-5d91-bd42-df20e0db1a79',
    '宇多 泰誠',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a6ddbabc-a9f8-5dd6-8ea2-162f179f202a',
    1,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a6ddbabc-a9f8-5dd6-8ea2-162f179f202a',
    2,
    37.0,
    NULL,
    false,
    '37.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a6ddbabc-a9f8-5dd6-8ea2-162f179f202a',
    3,
    47.0,
    NULL,
    false,
    '47.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a6ddbabc-a9f8-5dd6-8ea2-162f179f202a',
    4,
    52.0,
    NULL,
    true,
    '(52.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a6ddbabc-a9f8-5dd6-8ea2-162f179f202a',
    5,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a6ddbabc-a9f8-5dd6-8ea2-162f179f202a',
    6,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a6ddbabc-a9f8-5dd6-8ea2-162f179f202a',
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
    'c0f01bce-4c2a-5983-805d-b7a7db3072c6',
    'cf720117-fc78-5233-94cb-d39bd57a1433',
    'add537f4-4531-5793-b0db-408493c608c5',
    '松永 啓汰',
    'JPN 3095',
    'individual',
    25,
    189.0,
    151.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '02dce8b3-15cd-5609-be0e-3f665cb00a34',
    'c0f01bce-4c2a-5983-805d-b7a7db3072c6',
    'cf720117-fc78-5233-94cb-d39bd57a1433',
    '松永 啓汰',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c0f01bce-4c2a-5983-805d-b7a7db3072c6',
    1,
    38.0,
    NULL,
    true,
    '(38.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c0f01bce-4c2a-5983-805d-b7a7db3072c6',
    2,
    33.0,
    NULL,
    false,
    '33.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c0f01bce-4c2a-5983-805d-b7a7db3072c6',
    3,
    38.0,
    NULL,
    false,
    '38.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c0f01bce-4c2a-5983-805d-b7a7db3072c6',
    4,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c0f01bce-4c2a-5983-805d-b7a7db3072c6',
    5,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c0f01bce-4c2a-5983-805d-b7a7db3072c6',
    6,
    33.0,
    NULL,
    false,
    '33.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c0f01bce-4c2a-5983-805d-b7a7db3072c6',
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
    '76119505-a917-5eb4-99b6-8abe1da7d100',
    'eaad9ca1-6091-594b-bc28-317b17adff58',
    'add537f4-4531-5793-b0db-408493c608c5',
    '田淵 勇帆',
    'JPN 3486',
    'individual',
    26,
    240.0,
    152.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '69ae2fbf-b660-561f-bd05-654e25dd2781',
    '76119505-a917-5eb4-99b6-8abe1da7d100',
    'eaad9ca1-6091-594b-bc28-317b17adff58',
    '田淵 勇帆',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '76119505-a917-5eb4-99b6-8abe1da7d100',
    1,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '76119505-a917-5eb4-99b6-8abe1da7d100',
    2,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '76119505-a917-5eb4-99b6-8abe1da7d100',
    3,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '76119505-a917-5eb4-99b6-8abe1da7d100',
    4,
    51.0,
    NULL,
    false,
    '51.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '76119505-a917-5eb4-99b6-8abe1da7d100',
    5,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '76119505-a917-5eb4-99b6-8abe1da7d100',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '76119505-a917-5eb4-99b6-8abe1da7d100',
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
    'f6105567-356f-561e-bb20-558fb6c0108e',
    '6e3927aa-a435-5bc6-bb40-867479f8ed5d',
    'add537f4-4531-5793-b0db-408493c608c5',
    '水谷 智子',
    'JPN 3041',
    'individual',
    27,
    243.0,
    155.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd7607ecc-5d4f-5ba3-a690-e736fe877b1f',
    'f6105567-356f-561e-bb20-558fb6c0108e',
    '6e3927aa-a435-5bc6-bb40-867479f8ed5d',
    '水谷 智子',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f6105567-356f-561e-bb20-558fb6c0108e',
    1,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f6105567-356f-561e-bb20-558fb6c0108e',
    2,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f6105567-356f-561e-bb20-558fb6c0108e',
    3,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f6105567-356f-561e-bb20-558fb6c0108e',
    4,
    45.0,
    NULL,
    false,
    '45.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f6105567-356f-561e-bb20-558fb6c0108e',
    5,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f6105567-356f-561e-bb20-558fb6c0108e',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f6105567-356f-561e-bb20-558fb6c0108e',
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
    '887f6759-30e3-583d-8054-863c32e59033',
    'c70ced96-bb4c-5869-9d1d-38d1ec05f79f',
    'add537f4-4531-5793-b0db-408493c608c5',
    '根岸 渚沙',
    'JPN 3202',
    'individual',
    28,
    197.0,
    155.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4fb05528-9444-56c7-b8c3-79d82f5237df',
    '887f6759-30e3-583d-8054-863c32e59033',
    'c70ced96-bb4c-5869-9d1d-38d1ec05f79f',
    '根岸 渚沙',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '887f6759-30e3-583d-8054-863c32e59033',
    1,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '887f6759-30e3-583d-8054-863c32e59033',
    2,
    31.0,
    NULL,
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '887f6759-30e3-583d-8054-863c32e59033',
    3,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '887f6759-30e3-583d-8054-863c32e59033',
    4,
    42.0,
    NULL,
    true,
    '(42.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '887f6759-30e3-583d-8054-863c32e59033',
    5,
    31.0,
    NULL,
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '887f6759-30e3-583d-8054-863c32e59033',
    6,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '887f6759-30e3-583d-8054-863c32e59033',
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
    '20447b07-4225-5129-8f42-36e78b726af9',
    '2bdc9622-d3e1-5026-a3bc-f0b8f30f1b6d',
    'add537f4-4531-5793-b0db-408493c608c5',
    '眞田 彩愛',
    'JPN 3255',
    'individual',
    29,
    211.0,
    162.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e3fd3d33-e37c-5982-a557-0c4043a7da9c',
    '20447b07-4225-5129-8f42-36e78b726af9',
    '2bdc9622-d3e1-5026-a3bc-f0b8f30f1b6d',
    '眞田 彩愛',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20447b07-4225-5129-8f42-36e78b726af9',
    1,
    46.0,
    NULL,
    false,
    '46.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20447b07-4225-5129-8f42-36e78b726af9',
    2,
    45.0,
    NULL,
    false,
    '45.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20447b07-4225-5129-8f42-36e78b726af9',
    3,
    49.0,
    NULL,
    true,
    '(49.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20447b07-4225-5129-8f42-36e78b726af9',
    4,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20447b07-4225-5129-8f42-36e78b726af9',
    5,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20447b07-4225-5129-8f42-36e78b726af9',
    6,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20447b07-4225-5129-8f42-36e78b726af9',
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
    '3fd5ed2e-a58f-53b7-b4aa-00a6a88ac886',
    'b1713fdf-e19a-5b91-af9f-8db1a0fe4165',
    'add537f4-4531-5793-b0db-408493c608c5',
    '髙野 光',
    'JPN 3435',
    'individual',
    30,
    255.0,
    167.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a6718d5c-f255-5669-96e9-c15b70925a0d',
    '3fd5ed2e-a58f-53b7-b4aa-00a6a88ac886',
    'b1713fdf-e19a-5b91-af9f-8db1a0fe4165',
    '髙野 光',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3fd5ed2e-a58f-53b7-b4aa-00a6a88ac886',
    1,
    39.0,
    NULL,
    false,
    '39.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3fd5ed2e-a58f-53b7-b4aa-00a6a88ac886',
    2,
    36.0,
    NULL,
    false,
    '36.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3fd5ed2e-a58f-53b7-b4aa-00a6a88ac886',
    3,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3fd5ed2e-a58f-53b7-b4aa-00a6a88ac886',
    4,
    31.0,
    NULL,
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3fd5ed2e-a58f-53b7-b4aa-00a6a88ac886',
    5,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3fd5ed2e-a58f-53b7-b4aa-00a6a88ac886',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3fd5ed2e-a58f-53b7-b4aa-00a6a88ac886',
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
    '31ab4b77-56cc-5c5c-ae92-0743e7193e0d',
    'd292d6d5-a89b-568f-82f3-a448289014e4',
    'add537f4-4531-5793-b0db-408493c608c5',
    '佐藤 英司',
    'JPN 3447',
    'individual',
    31,
    218.0,
    179.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6d45aa97-575d-54ca-b3d2-17cabed12842',
    '31ab4b77-56cc-5c5c-ae92-0743e7193e0d',
    'd292d6d5-a89b-568f-82f3-a448289014e4',
    '佐藤 英司',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31ab4b77-56cc-5c5c-ae92-0743e7193e0d',
    1,
    34.0,
    NULL,
    false,
    '34.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31ab4b77-56cc-5c5c-ae92-0743e7193e0d',
    2,
    39.0,
    NULL,
    true,
    '(39.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31ab4b77-56cc-5c5c-ae92-0743e7193e0d',
    3,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31ab4b77-56cc-5c5c-ae92-0743e7193e0d',
    4,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31ab4b77-56cc-5c5c-ae92-0743e7193e0d',
    5,
    33.0,
    NULL,
    false,
    '33.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31ab4b77-56cc-5c5c-ae92-0743e7193e0d',
    6,
    31.0,
    NULL,
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '31ab4b77-56cc-5c5c-ae92-0743e7193e0d',
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
    '6485b90a-cbe6-5dae-8106-e5716e47af1c',
    'fe4c5005-571b-5805-8bbb-6063851835f9',
    'add537f4-4531-5793-b0db-408493c608c5',
    '池ヶ谷 絢真',
    'JPN 3018',
    'individual',
    32,
    268.0,
    180.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fa71329e-d8f1-590d-bd09-7ca13ac2a5a6',
    '6485b90a-cbe6-5dae-8106-e5716e47af1c',
    'fe4c5005-571b-5805-8bbb-6063851835f9',
    '池ヶ谷 絢真',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6485b90a-cbe6-5dae-8106-e5716e47af1c',
    1,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6485b90a-cbe6-5dae-8106-e5716e47af1c',
    2,
    35.0,
    NULL,
    false,
    '35.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6485b90a-cbe6-5dae-8106-e5716e47af1c',
    3,
    32.0,
    NULL,
    false,
    '32.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6485b90a-cbe6-5dae-8106-e5716e47af1c',
    4,
    32.0,
    NULL,
    false,
    '32.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6485b90a-cbe6-5dae-8106-e5716e47af1c',
    5,
    43.0,
    NULL,
    false,
    '43.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6485b90a-cbe6-5dae-8106-e5716e47af1c',
    6,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6485b90a-cbe6-5dae-8106-e5716e47af1c',
    7,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'b075fd29-5917-53c1-85b5-c07e52e1645a',
    '5c489dbf-8fa5-5c2f-bf4e-dc55f6b8ba08',
    'add537f4-4531-5793-b0db-408493c608c5',
    '吉田 琉良',
    'JPN 3381',
    'individual',
    33,
    259.0,
    193.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '81295251-75ac-5387-b7b5-537d333e5393',
    'b075fd29-5917-53c1-85b5-c07e52e1645a',
    '5c489dbf-8fa5-5c2f-bf4e-dc55f6b8ba08',
    '吉田 琉良',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b075fd29-5917-53c1-85b5-c07e52e1645a',
    1,
    66.0,
    NULL,
    true,
    '(66.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b075fd29-5917-53c1-85b5-c07e52e1645a',
    2,
    55.0,
    NULL,
    false,
    '55.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b075fd29-5917-53c1-85b5-c07e52e1645a',
    3,
    44.0,
    NULL,
    false,
    '44.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b075fd29-5917-53c1-85b5-c07e52e1645a',
    4,
    47.0,
    NULL,
    false,
    '47.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b075fd29-5917-53c1-85b5-c07e52e1645a',
    5,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b075fd29-5917-53c1-85b5-c07e52e1645a',
    6,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b075fd29-5917-53c1-85b5-c07e52e1645a',
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
    '47a5c640-4b32-514b-a6ef-08a91e4455e4',
    'd93c9115-6be9-5d29-80e2-e232e4cc89d4',
    'add537f4-4531-5793-b0db-408493c608c5',
    '猪俣 汰星',
    'JPN 3378',
    'individual',
    34,
    289.0,
    201.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'cba82828-a407-5afd-92a0-d7e0452cce29',
    '47a5c640-4b32-514b-a6ef-08a91e4455e4',
    'd93c9115-6be9-5d29-80e2-e232e4cc89d4',
    '猪俣 汰星',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '47a5c640-4b32-514b-a6ef-08a91e4455e4',
    1,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '47a5c640-4b32-514b-a6ef-08a91e4455e4',
    2,
    66.0,
    NULL,
    false,
    '66.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '47a5c640-4b32-514b-a6ef-08a91e4455e4',
    3,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '47a5c640-4b32-514b-a6ef-08a91e4455e4',
    4,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '47a5c640-4b32-514b-a6ef-08a91e4455e4',
    5,
    44.0,
    NULL,
    false,
    '44.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '47a5c640-4b32-514b-a6ef-08a91e4455e4',
    6,
    32.0,
    NULL,
    false,
    '32.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '47a5c640-4b32-514b-a6ef-08a91e4455e4',
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
    '09beeaf4-0f21-51e1-aa16-76258d1b193f',
    'a4fc7a7a-62dc-5c60-b40b-089d09341dcb',
    'add537f4-4531-5793-b0db-408493c608c5',
    '松浦 瑛士',
    'JPN 3322',
    'individual',
    35,
    277.0,
    210.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ebd69dfa-ec58-5a56-ba3b-ad611fcccde1',
    '09beeaf4-0f21-51e1-aa16-76258d1b193f',
    'a4fc7a7a-62dc-5c60-b40b-089d09341dcb',
    '松浦 瑛士',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '09beeaf4-0f21-51e1-aa16-76258d1b193f',
    1,
    67.0,
    NULL,
    true,
    '(67.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '09beeaf4-0f21-51e1-aa16-76258d1b193f',
    2,
    56.0,
    NULL,
    false,
    '56.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '09beeaf4-0f21-51e1-aa16-76258d1b193f',
    3,
    35.0,
    NULL,
    false,
    '35.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '09beeaf4-0f21-51e1-aa16-76258d1b193f',
    4,
    35.0,
    NULL,
    false,
    '35.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '09beeaf4-0f21-51e1-aa16-76258d1b193f',
    5,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '09beeaf4-0f21-51e1-aa16-76258d1b193f',
    6,
    35.0,
    NULL,
    false,
    '35.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '09beeaf4-0f21-51e1-aa16-76258d1b193f',
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
    '5b60eb6d-f69b-561c-8e87-38240847159c',
    '25ac7774-b971-5708-afb2-ce8fed50bbd3',
    'add537f4-4531-5793-b0db-408493c608c5',
    '高橋 武尊',
    'JPN 3367',
    'individual',
    36,
    307.0,
    219.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8cbf533e-4e02-5a20-9236-3eb5962c4aeb',
    '5b60eb6d-f69b-561c-8e87-38240847159c',
    '25ac7774-b971-5708-afb2-ce8fed50bbd3',
    '高橋 武尊',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5b60eb6d-f69b-561c-8e87-38240847159c',
    1,
    40.0,
    NULL,
    false,
    '40.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5b60eb6d-f69b-561c-8e87-38240847159c',
    2,
    88.0,
    'UFD',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5b60eb6d-f69b-561c-8e87-38240847159c',
    3,
    34.0,
    NULL,
    false,
    '34.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5b60eb6d-f69b-561c-8e87-38240847159c',
    4,
    37.0,
    NULL,
    false,
    '37.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5b60eb6d-f69b-561c-8e87-38240847159c',
    5,
    53.0,
    NULL,
    false,
    '53.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5b60eb6d-f69b-561c-8e87-38240847159c',
    6,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5b60eb6d-f69b-561c-8e87-38240847159c',
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
    '2c378336-1e9a-5126-b370-24d76a817bd3',
    'cdb4723d-4a2c-543f-8d54-4abb9d7080aa',
    'add537f4-4531-5793-b0db-408493c608c5',
    '松浦 悠真',
    'JPN 3473',
    'individual',
    37,
    308.0,
    220.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'db14c6d9-8b81-5072-a3e4-a94c50488423',
    '2c378336-1e9a-5126-b370-24d76a817bd3',
    'cdb4723d-4a2c-543f-8d54-4abb9d7080aa',
    '松浦 悠真',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c378336-1e9a-5126-b370-24d76a817bd3',
    1,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c378336-1e9a-5126-b370-24d76a817bd3',
    2,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c378336-1e9a-5126-b370-24d76a817bd3',
    3,
    42.0,
    NULL,
    false,
    '42.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c378336-1e9a-5126-b370-24d76a817bd3',
    4,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c378336-1e9a-5126-b370-24d76a817bd3',
    5,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c378336-1e9a-5126-b370-24d76a817bd3',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c378336-1e9a-5126-b370-24d76a817bd3',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '7236e489-a011-58d1-9cf1-21238919be6f',
    '03255e8b-9496-5297-af53-6945dfbe901e',
    'add537f4-4531-5793-b0db-408493c608c5',
    '田淵 隼矢',
    'JPN 3020',
    'individual',
    38,
    327.0,
    239.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '666e01af-99b1-5778-ba86-290fe0045a34',
    '7236e489-a011-58d1-9cf1-21238919be6f',
    '03255e8b-9496-5297-af53-6945dfbe901e',
    '田淵 隼矢',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7236e489-a011-58d1-9cf1-21238919be6f',
    1,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7236e489-a011-58d1-9cf1-21238919be6f',
    2,
    74.0,
    NULL,
    false,
    '74.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7236e489-a011-58d1-9cf1-21238919be6f',
    3,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7236e489-a011-58d1-9cf1-21238919be6f',
    4,
    33.0,
    NULL,
    false,
    '33.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7236e489-a011-58d1-9cf1-21238919be6f',
    5,
    50.0,
    NULL,
    false,
    '50.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7236e489-a011-58d1-9cf1-21238919be6f',
    6,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7236e489-a011-58d1-9cf1-21238919be6f',
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
    '2d5ab22b-c8c2-57ee-850c-4e5894f11115',
    '70fcc745-a909-53ab-a54b-1ba753b5c569',
    'add537f4-4531-5793-b0db-408493c608c5',
    '稲葉 絢圭',
    'JPN 3445',
    'individual',
    39,
    329.0,
    241.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1a5f5112-eaf3-59b9-b09a-a62a9e1b35df',
    '2d5ab22b-c8c2-57ee-850c-4e5894f11115',
    '70fcc745-a909-53ab-a54b-1ba753b5c569',
    '稲葉 絢圭',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d5ab22b-c8c2-57ee-850c-4e5894f11115',
    1,
    65.0,
    NULL,
    false,
    '65.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d5ab22b-c8c2-57ee-850c-4e5894f11115',
    2,
    40.0,
    NULL,
    false,
    '40.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d5ab22b-c8c2-57ee-850c-4e5894f11115',
    3,
    40.0,
    NULL,
    false,
    '40.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d5ab22b-c8c2-57ee-850c-4e5894f11115',
    4,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d5ab22b-c8c2-57ee-850c-4e5894f11115',
    5,
    38.0,
    NULL,
    false,
    '38.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d5ab22b-c8c2-57ee-850c-4e5894f11115',
    6,
    36.0,
    NULL,
    false,
    '36.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2d5ab22b-c8c2-57ee-850c-4e5894f11115',
    7,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'cdd1a898-0add-557d-80b0-eb7defc7a9ec',
    'b04104ba-7b19-5217-ac34-e806fbefd542',
    'add537f4-4531-5793-b0db-408493c608c5',
    '石井 瑠里',
    'JPN 3168',
    'individual',
    40,
    343.0,
    255.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '71986722-ab82-5c97-8a22-893addefd834',
    'cdd1a898-0add-557d-80b0-eb7defc7a9ec',
    'b04104ba-7b19-5217-ac34-e806fbefd542',
    '石井 瑠里',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cdd1a898-0add-557d-80b0-eb7defc7a9ec',
    1,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cdd1a898-0add-557d-80b0-eb7defc7a9ec',
    2,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cdd1a898-0add-557d-80b0-eb7defc7a9ec',
    3,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cdd1a898-0add-557d-80b0-eb7defc7a9ec',
    4,
    49.0,
    NULL,
    false,
    '49.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cdd1a898-0add-557d-80b0-eb7defc7a9ec',
    5,
    35.0,
    NULL,
    false,
    '35.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cdd1a898-0add-557d-80b0-eb7defc7a9ec',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cdd1a898-0add-557d-80b0-eb7defc7a9ec',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '7d9c366f-d53d-542b-9fb7-f4a1e52bce06',
    'e0235830-8309-53a8-937e-6f339c5554eb',
    'add537f4-4531-5793-b0db-408493c608c5',
    '坂上 雄誠',
    'JPN 2993',
    'individual',
    41,
    343.0,
    255.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a4de01be-04cd-57d1-a5e1-c5ea56d2e8f4',
    '7d9c366f-d53d-542b-9fb7-f4a1e52bce06',
    'e0235830-8309-53a8-937e-6f339c5554eb',
    '坂上 雄誠',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d9c366f-d53d-542b-9fb7-f4a1e52bce06',
    1,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d9c366f-d53d-542b-9fb7-f4a1e52bce06',
    2,
    52.0,
    NULL,
    false,
    '52.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d9c366f-d53d-542b-9fb7-f4a1e52bce06',
    3,
    52.0,
    NULL,
    false,
    '52.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d9c366f-d53d-542b-9fb7-f4a1e52bce06',
    4,
    40.0,
    NULL,
    false,
    '40.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d9c366f-d53d-542b-9fb7-f4a1e52bce06',
    5,
    42.0,
    NULL,
    false,
    '42.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d9c366f-d53d-542b-9fb7-f4a1e52bce06',
    6,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d9c366f-d53d-542b-9fb7-f4a1e52bce06',
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
    '8f1ca326-f5ca-5830-8dfd-392db41275c7',
    '0eb30de4-6e06-50f3-b8d4-3f02cc0130dd',
    'add537f4-4531-5793-b0db-408493c608c5',
    '山村 南菜',
    'JPN 3480',
    'individual',
    42,
    364.0,
    276.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6a8574da-210b-5804-ace7-2672792b1c8c',
    '8f1ca326-f5ca-5830-8dfd-392db41275c7',
    '0eb30de4-6e06-50f3-b8d4-3f02cc0130dd',
    '山村 南菜',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f1ca326-f5ca-5830-8dfd-392db41275c7',
    1,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f1ca326-f5ca-5830-8dfd-392db41275c7',
    2,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f1ca326-f5ca-5830-8dfd-392db41275c7',
    3,
    41.0,
    NULL,
    false,
    '41.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f1ca326-f5ca-5830-8dfd-392db41275c7',
    4,
    65.0,
    NULL,
    false,
    '65.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f1ca326-f5ca-5830-8dfd-392db41275c7',
    5,
    40.0,
    NULL,
    false,
    '40.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f1ca326-f5ca-5830-8dfd-392db41275c7',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8f1ca326-f5ca-5830-8dfd-392db41275c7',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '7144c7d3-41a9-57ec-8835-b26e886f0d89',
    '4c6c867b-dead-5727-b7c7-c79d8a61176f',
    'add537f4-4531-5793-b0db-408493c608c5',
    '上敷領 美海',
    'JPN 3231',
    'individual',
    43,
    365.0,
    277.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7a12a47e-3aef-511f-8184-bdcaa65ff08e',
    '7144c7d3-41a9-57ec-8835-b26e886f0d89',
    '4c6c867b-dead-5727-b7c7-c79d8a61176f',
    '上敷領 美海',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7144c7d3-41a9-57ec-8835-b26e886f0d89',
    1,
    36.0,
    NULL,
    false,
    '36.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7144c7d3-41a9-57ec-8835-b26e886f0d89',
    2,
    34.0,
    NULL,
    false,
    '34.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7144c7d3-41a9-57ec-8835-b26e886f0d89',
    3,
    58.0,
    NULL,
    false,
    '58.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7144c7d3-41a9-57ec-8835-b26e886f0d89',
    4,
    74.0,
    NULL,
    false,
    '74.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7144c7d3-41a9-57ec-8835-b26e886f0d89',
    5,
    46.0,
    NULL,
    false,
    '46.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7144c7d3-41a9-57ec-8835-b26e886f0d89',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7144c7d3-41a9-57ec-8835-b26e886f0d89',
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
    '53e16e5a-9b2d-5afb-a3fe-5fade024deaf',
    '652c1835-ecb4-5ee1-8ee0-cdd5bc9e6d55',
    'add537f4-4531-5793-b0db-408493c608c5',
    '川島 美彩',
    'JPN 3433',
    'individual',
    44,
    372.0,
    284.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0104002f-9a0e-5329-9995-3263d258b6a6',
    '53e16e5a-9b2d-5afb-a3fe-5fade024deaf',
    '652c1835-ecb4-5ee1-8ee0-cdd5bc9e6d55',
    '川島 美彩',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53e16e5a-9b2d-5afb-a3fe-5fade024deaf',
    1,
    53.0,
    NULL,
    false,
    '53.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53e16e5a-9b2d-5afb-a3fe-5fade024deaf',
    2,
    48.0,
    NULL,
    false,
    '48.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53e16e5a-9b2d-5afb-a3fe-5fade024deaf',
    3,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53e16e5a-9b2d-5afb-a3fe-5fade024deaf',
    4,
    36.0,
    NULL,
    false,
    '36.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53e16e5a-9b2d-5afb-a3fe-5fade024deaf',
    5,
    47.0,
    NULL,
    false,
    '47.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53e16e5a-9b2d-5afb-a3fe-5fade024deaf',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53e16e5a-9b2d-5afb-a3fe-5fade024deaf',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '6195a185-39d2-5a63-a792-2430a2f7d74d',
    '48867110-3451-5b67-a8bd-247b239b21b7',
    'add537f4-4531-5793-b0db-408493c608c5',
    '小坂 一花凜',
    'JPN 3157',
    'individual',
    45,
    374.0,
    286.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c5eaf521-f0f2-52fc-a28a-eaa178f505c0',
    '6195a185-39d2-5a63-a792-2430a2f7d74d',
    '48867110-3451-5b67-a8bd-247b239b21b7',
    '小坂 一花凜',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6195a185-39d2-5a63-a792-2430a2f7d74d',
    1,
    51.0,
    NULL,
    false,
    '51.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6195a185-39d2-5a63-a792-2430a2f7d74d',
    2,
    60.0,
    NULL,
    false,
    '60.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6195a185-39d2-5a63-a792-2430a2f7d74d',
    3,
    66.0,
    NULL,
    false,
    '66.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6195a185-39d2-5a63-a792-2430a2f7d74d',
    4,
    48.0,
    NULL,
    false,
    '48.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6195a185-39d2-5a63-a792-2430a2f7d74d',
    5,
    37.0,
    NULL,
    false,
    '37.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6195a185-39d2-5a63-a792-2430a2f7d74d',
    6,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6195a185-39d2-5a63-a792-2430a2f7d74d',
    7,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '99d2e265-5472-5472-91af-bf7bcee7563e',
    'cc7f1a70-617c-5f0f-95c0-11ff6c600a27',
    'add537f4-4531-5793-b0db-408493c608c5',
    '竹原 円豊',
    'JPN 3361',
    'individual',
    46,
    379.0,
    291.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1bd507f9-76e2-581d-a442-1e3c64e1cfa2',
    '99d2e265-5472-5472-91af-bf7bcee7563e',
    'cc7f1a70-617c-5f0f-95c0-11ff6c600a27',
    '竹原 円豊',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99d2e265-5472-5472-91af-bf7bcee7563e',
    1,
    56.0,
    NULL,
    false,
    '56.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99d2e265-5472-5472-91af-bf7bcee7563e',
    2,
    72.0,
    NULL,
    false,
    '72.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99d2e265-5472-5472-91af-bf7bcee7563e',
    3,
    36.0,
    NULL,
    false,
    '36.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99d2e265-5472-5472-91af-bf7bcee7563e',
    4,
    44.0,
    NULL,
    false,
    '44.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99d2e265-5472-5472-91af-bf7bcee7563e',
    5,
    52.0,
    NULL,
    false,
    '52.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99d2e265-5472-5472-91af-bf7bcee7563e',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '99d2e265-5472-5472-91af-bf7bcee7563e',
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
    '2c22142c-d2b8-5de7-b7a7-8426e4097b77',
    '2e14e145-fef6-5982-b963-d801f1bb6a31',
    'add537f4-4531-5793-b0db-408493c608c5',
    '窪田 柚希',
    'JPN 3125',
    'individual',
    47,
    390.0,
    302.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1482666d-86e0-5837-8972-805f2c44c396',
    '2c22142c-d2b8-5de7-b7a7-8426e4097b77',
    '2e14e145-fef6-5982-b963-d801f1bb6a31',
    '窪田 柚希',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c22142c-d2b8-5de7-b7a7-8426e4097b77',
    1,
    32.0,
    NULL,
    false,
    '32.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c22142c-d2b8-5de7-b7a7-8426e4097b77',
    2,
    30.0,
    NULL,
    false,
    '30.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c22142c-d2b8-5de7-b7a7-8426e4097b77',
    3,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c22142c-d2b8-5de7-b7a7-8426e4097b77',
    4,
    60.0,
    NULL,
    false,
    '60.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c22142c-d2b8-5de7-b7a7-8426e4097b77',
    5,
    67.0,
    NULL,
    false,
    '67.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c22142c-d2b8-5de7-b7a7-8426e4097b77',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c22142c-d2b8-5de7-b7a7-8426e4097b77',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '0425644d-cc33-5bda-82b9-540da44df138',
    'c0619908-2d1c-5ad5-8c34-6200ce5aa6b5',
    'add537f4-4531-5793-b0db-408493c608c5',
    '稲葉 陸斗',
    'JPN 3468',
    'individual',
    48,
    396.0,
    308.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '307e9ab1-1195-5496-af82-7908f2c515a4',
    '0425644d-cc33-5bda-82b9-540da44df138',
    'c0619908-2d1c-5ad5-8c34-6200ce5aa6b5',
    '稲葉 陸斗',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0425644d-cc33-5bda-82b9-540da44df138',
    1,
    41.0,
    NULL,
    false,
    '41.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0425644d-cc33-5bda-82b9-540da44df138',
    2,
    44.0,
    NULL,
    false,
    '44.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0425644d-cc33-5bda-82b9-540da44df138',
    3,
    77.0,
    NULL,
    false,
    '77.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0425644d-cc33-5bda-82b9-540da44df138',
    4,
    56.0,
    NULL,
    false,
    '56.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0425644d-cc33-5bda-82b9-540da44df138',
    5,
    60.0,
    NULL,
    false,
    '60.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0425644d-cc33-5bda-82b9-540da44df138',
    6,
    30.0,
    NULL,
    false,
    '30.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0425644d-cc33-5bda-82b9-540da44df138',
    7,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '434259d6-83dd-5927-9bab-57ba6bf0075e',
    '7983e169-6802-58d2-b8c3-8b7a65225184',
    'add537f4-4531-5793-b0db-408493c608c5',
    '川端ダンカン あいらエリザベス',
    'JPN 3127',
    'individual',
    49,
    398.0,
    310.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '59b5cdfc-76e7-586b-83ec-08c045505b35',
    '434259d6-83dd-5927-9bab-57ba6bf0075e',
    '7983e169-6802-58d2-b8c3-8b7a65225184',
    '川端ダンカン あいらエリザベス',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '434259d6-83dd-5927-9bab-57ba6bf0075e',
    1,
    33.0,
    NULL,
    false,
    '33.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '434259d6-83dd-5927-9bab-57ba6bf0075e',
    2,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '434259d6-83dd-5927-9bab-57ba6bf0075e',
    3,
    54.0,
    NULL,
    false,
    '54.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '434259d6-83dd-5927-9bab-57ba6bf0075e',
    4,
    50.0,
    NULL,
    false,
    '50.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '434259d6-83dd-5927-9bab-57ba6bf0075e',
    5,
    57.0,
    NULL,
    false,
    '57.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '434259d6-83dd-5927-9bab-57ba6bf0075e',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '434259d6-83dd-5927-9bab-57ba6bf0075e',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '5a9489de-03bf-504e-a8b2-7c5682fb9085',
    '29e386e1-b43b-5dea-80bb-b50ed04c1317',
    'add537f4-4531-5793-b0db-408493c608c5',
    '山村 晟',
    'JPN 3338',
    'individual',
    50,
    410.0,
    322.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9cf22fb8-9100-5f3d-b348-1b24d98e07aa',
    '5a9489de-03bf-504e-a8b2-7c5682fb9085',
    '29e386e1-b43b-5dea-80bb-b50ed04c1317',
    '山村 晟',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a9489de-03bf-504e-a8b2-7c5682fb9085',
    1,
    63.0,
    NULL,
    false,
    '63.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a9489de-03bf-504e-a8b2-7c5682fb9085',
    2,
    51.0,
    NULL,
    false,
    '51.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a9489de-03bf-504e-a8b2-7c5682fb9085',
    3,
    60.0,
    NULL,
    false,
    '60.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a9489de-03bf-504e-a8b2-7c5682fb9085',
    4,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a9489de-03bf-504e-a8b2-7c5682fb9085',
    5,
    39.0,
    NULL,
    false,
    '39.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a9489de-03bf-504e-a8b2-7c5682fb9085',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5a9489de-03bf-504e-a8b2-7c5682fb9085',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'c45d2438-d505-53e8-8804-5fb895f36ebf',
    'a3ded086-1ecc-5be9-9458-382e9fbbe835',
    'add537f4-4531-5793-b0db-408493c608c5',
    '岸 栄子',
    'JPN 3129',
    'individual',
    51,
    411.0,
    323.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f15b43af-abf1-531f-8696-085677cc5817',
    'c45d2438-d505-53e8-8804-5fb895f36ebf',
    'a3ded086-1ecc-5be9-9458-382e9fbbe835',
    '岸 栄子',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c45d2438-d505-53e8-8804-5fb895f36ebf',
    1,
    30.0,
    NULL,
    false,
    '30.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c45d2438-d505-53e8-8804-5fb895f36ebf',
    2,
    42.0,
    NULL,
    false,
    '42.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c45d2438-d505-53e8-8804-5fb895f36ebf',
    3,
    76.0,
    NULL,
    false,
    '76.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c45d2438-d505-53e8-8804-5fb895f36ebf',
    4,
    46.0,
    NULL,
    false,
    '46.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c45d2438-d505-53e8-8804-5fb895f36ebf',
    5,
    41.0,
    NULL,
    false,
    '41.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c45d2438-d505-53e8-8804-5fb895f36ebf',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c45d2438-d505-53e8-8804-5fb895f36ebf',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '32e74d7a-2491-5579-b685-e5dec8a6eeb5',
    '55c04350-4b48-5cf1-96a4-5bdc914beead',
    'add537f4-4531-5793-b0db-408493c608c5',
    '水本 真人',
    'JPN 3411',
    'individual',
    52,
    419.0,
    331.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8d054223-d445-5e6b-868f-b8df363cbdf3',
    '32e74d7a-2491-5579-b685-e5dec8a6eeb5',
    '55c04350-4b48-5cf1-96a4-5bdc914beead',
    '水本 真人',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32e74d7a-2491-5579-b685-e5dec8a6eeb5',
    1,
    42.0,
    NULL,
    false,
    '42.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32e74d7a-2491-5579-b685-e5dec8a6eeb5',
    2,
    47.0,
    NULL,
    false,
    '47.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32e74d7a-2491-5579-b685-e5dec8a6eeb5',
    3,
    45.0,
    NULL,
    false,
    '45.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32e74d7a-2491-5579-b685-e5dec8a6eeb5',
    4,
    43.0,
    NULL,
    false,
    '43.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32e74d7a-2491-5579-b685-e5dec8a6eeb5',
    5,
    66.0,
    NULL,
    false,
    '66.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32e74d7a-2491-5579-b685-e5dec8a6eeb5',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32e74d7a-2491-5579-b685-e5dec8a6eeb5',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'b28d009d-d736-579a-bdcb-ce537ab897a0',
    '924d1f93-fc4d-54a0-a6a6-8738f48d6c3a',
    'add537f4-4531-5793-b0db-408493c608c5',
    '住田 穂波',
    'JPN 2893',
    'individual',
    53,
    420.0,
    332.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9f70885a-8199-5d2e-9415-fbd1259177bb',
    'b28d009d-d736-579a-bdcb-ce537ab897a0',
    '924d1f93-fc4d-54a0-a6a6-8738f48d6c3a',
    '住田 穂波',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b28d009d-d736-579a-bdcb-ce537ab897a0',
    1,
    49.0,
    NULL,
    false,
    '49.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b28d009d-d736-579a-bdcb-ce537ab897a0',
    2,
    69.0,
    NULL,
    false,
    '69.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b28d009d-d736-579a-bdcb-ce537ab897a0',
    3,
    63.0,
    NULL,
    false,
    '63.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b28d009d-d736-579a-bdcb-ce537ab897a0',
    4,
    67.0,
    NULL,
    false,
    '67.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b28d009d-d736-579a-bdcb-ce537ab897a0',
    5,
    45.0,
    NULL,
    false,
    '45.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b28d009d-d736-579a-bdcb-ce537ab897a0',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b28d009d-d736-579a-bdcb-ce537ab897a0',
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
    'a80a7674-8715-56f2-8f51-e782cb3daa2e',
    'f31fc009-bdb8-56bd-8419-6b780b5c21d6',
    'add537f4-4531-5793-b0db-408493c608c5',
    '大嶋 璃音',
    'JPN 3382',
    'individual',
    54,
    432.0,
    344.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '28cbf6ab-3b3a-5b76-9ab8-ea1ffdb3b69c',
    'a80a7674-8715-56f2-8f51-e782cb3daa2e',
    'f31fc009-bdb8-56bd-8419-6b780b5c21d6',
    '大嶋 璃音',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a80a7674-8715-56f2-8f51-e782cb3daa2e',
    1,
    54.0,
    NULL,
    false,
    '54.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a80a7674-8715-56f2-8f51-e782cb3daa2e',
    2,
    70.0,
    NULL,
    false,
    '70.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a80a7674-8715-56f2-8f51-e782cb3daa2e',
    3,
    43.0,
    NULL,
    false,
    '43.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a80a7674-8715-56f2-8f51-e782cb3daa2e',
    4,
    41.0,
    NULL,
    false,
    '41.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a80a7674-8715-56f2-8f51-e782cb3daa2e',
    5,
    48.0,
    NULL,
    false,
    '48.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a80a7674-8715-56f2-8f51-e782cb3daa2e',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a80a7674-8715-56f2-8f51-e782cb3daa2e',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '7ff36278-d9d8-5ccb-91ac-99baee8c3d10',
    'ed71ace5-6086-578f-8e30-ad1d4fb1e949',
    'add537f4-4531-5793-b0db-408493c608c5',
    'チャリコワ',
    'JPN 3410',
    'individual',
    55,
    439.0,
    351.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5654bf44-05cb-5ef0-9c12-30dc9dc3b29f',
    '7ff36278-d9d8-5ccb-91ac-99baee8c3d10',
    'ed71ace5-6086-578f-8e30-ad1d4fb1e949',
    'チャリコワ',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7ff36278-d9d8-5ccb-91ac-99baee8c3d10',
    1,
    43.0,
    NULL,
    false,
    '43.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7ff36278-d9d8-5ccb-91ac-99baee8c3d10',
    2,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7ff36278-d9d8-5ccb-91ac-99baee8c3d10',
    3,
    61.0,
    NULL,
    false,
    '61.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7ff36278-d9d8-5ccb-91ac-99baee8c3d10',
    4,
    66.0,
    NULL,
    false,
    '66.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7ff36278-d9d8-5ccb-91ac-99baee8c3d10',
    5,
    64.0,
    NULL,
    false,
    '64.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7ff36278-d9d8-5ccb-91ac-99baee8c3d10',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7ff36278-d9d8-5ccb-91ac-99baee8c3d10',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'db6c26e8-a7cd-5933-bd9c-611099fa9a40',
    '489d4743-1a7b-5f61-b3c2-2576df0df2fe',
    'add537f4-4531-5793-b0db-408493c608c5',
    '林 昇平',
    'JPN 3469',
    'individual',
    56,
    444.0,
    356.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ba1f9862-c561-530d-973a-ce527859d29e',
    'db6c26e8-a7cd-5933-bd9c-611099fa9a40',
    '489d4743-1a7b-5f61-b3c2-2576df0df2fe',
    '林 昇平',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'db6c26e8-a7cd-5933-bd9c-611099fa9a40',
    1,
    37.0,
    NULL,
    false,
    '37.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'db6c26e8-a7cd-5933-bd9c-611099fa9a40',
    2,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'db6c26e8-a7cd-5933-bd9c-611099fa9a40',
    3,
    68.0,
    NULL,
    false,
    '68.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'db6c26e8-a7cd-5933-bd9c-611099fa9a40',
    4,
    68.0,
    NULL,
    false,
    '68.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'db6c26e8-a7cd-5933-bd9c-611099fa9a40',
    5,
    70.0,
    NULL,
    false,
    '70.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'db6c26e8-a7cd-5933-bd9c-611099fa9a40',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'db6c26e8-a7cd-5933-bd9c-611099fa9a40',
    7,
    88.0,
    'DSQ',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'b37572e2-cb84-5619-9fa1-47a174a012ac',
    'b9540a9d-2e0c-57d4-be71-ded6162cd8b0',
    'add537f4-4531-5793-b0db-408493c608c5',
    '秦 響希',
    'JPN 3373',
    'individual',
    57,
    453.0,
    365.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '06715fb6-7b79-5da3-a2e3-1bd41a48a494',
    'b37572e2-cb84-5619-9fa1-47a174a012ac',
    'b9540a9d-2e0c-57d4-be71-ded6162cd8b0',
    '秦 響希',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b37572e2-cb84-5619-9fa1-47a174a012ac',
    1,
    50.0,
    NULL,
    false,
    '50.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b37572e2-cb84-5619-9fa1-47a174a012ac',
    2,
    38.0,
    NULL,
    false,
    '38.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b37572e2-cb84-5619-9fa1-47a174a012ac',
    3,
    73.0,
    NULL,
    false,
    '73.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b37572e2-cb84-5619-9fa1-47a174a012ac',
    4,
    55.0,
    NULL,
    false,
    '55.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b37572e2-cb84-5619-9fa1-47a174a012ac',
    5,
    61.0,
    NULL,
    false,
    '61.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b37572e2-cb84-5619-9fa1-47a174a012ac',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b37572e2-cb84-5619-9fa1-47a174a012ac',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'a117a1ea-210c-579c-abd8-250a3ba6bcb8',
    '45578225-5f60-5a09-91e6-a93d66f23988',
    'add537f4-4531-5793-b0db-408493c608c5',
    '江島 まな',
    'JPN 2890',
    'individual',
    58,
    453.0,
    365.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'df74ad5d-2401-5b0d-959f-bfe6a1315135',
    'a117a1ea-210c-579c-abd8-250a3ba6bcb8',
    '45578225-5f60-5a09-91e6-a93d66f23988',
    '江島 まな',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a117a1ea-210c-579c-abd8-250a3ba6bcb8',
    1,
    45.0,
    NULL,
    false,
    '45.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a117a1ea-210c-579c-abd8-250a3ba6bcb8',
    2,
    62.0,
    NULL,
    false,
    '62.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a117a1ea-210c-579c-abd8-250a3ba6bcb8',
    3,
    62.0,
    NULL,
    false,
    '62.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a117a1ea-210c-579c-abd8-250a3ba6bcb8',
    4,
    57.0,
    NULL,
    false,
    '57.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a117a1ea-210c-579c-abd8-250a3ba6bcb8',
    5,
    51.0,
    NULL,
    false,
    '51.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a117a1ea-210c-579c-abd8-250a3ba6bcb8',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a117a1ea-210c-579c-abd8-250a3ba6bcb8',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '8d46cda4-ceaf-51b8-a127-c08406f10fc6',
    '2769907e-9b02-5e6d-9196-f223e302c525',
    'add537f4-4531-5793-b0db-408493c608c5',
    '久保 朔太郎',
    'JPN 2894',
    'individual',
    59,
    461.0,
    373.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2433f8f8-b3f1-5a01-bc37-e05ce5e86cd5',
    '8d46cda4-ceaf-51b8-a127-c08406f10fc6',
    '2769907e-9b02-5e6d-9196-f223e302c525',
    '久保 朔太郎',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8d46cda4-ceaf-51b8-a127-c08406f10fc6',
    1,
    61.0,
    NULL,
    false,
    '61.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8d46cda4-ceaf-51b8-a127-c08406f10fc6',
    2,
    65.0,
    NULL,
    false,
    '65.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8d46cda4-ceaf-51b8-a127-c08406f10fc6',
    3,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8d46cda4-ceaf-51b8-a127-c08406f10fc6',
    4,
    59.0,
    NULL,
    false,
    '59.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8d46cda4-ceaf-51b8-a127-c08406f10fc6',
    5,
    74.0,
    NULL,
    false,
    '74.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8d46cda4-ceaf-51b8-a127-c08406f10fc6',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8d46cda4-ceaf-51b8-a127-c08406f10fc6',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '50d4b466-6576-58f7-9b58-ede958826c13',
    'db249593-6acb-55d3-9e73-e39980a2e9b7',
    'add537f4-4531-5793-b0db-408493c608c5',
    '森實 莉乃',
    'JPN 3438',
    'individual',
    60,
    462.0,
    374.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3caf19fb-b7dd-5a6c-8bc7-c35ddac00a55',
    '50d4b466-6576-58f7-9b58-ede958826c13',
    'db249593-6acb-55d3-9e73-e39980a2e9b7',
    '森實 莉乃',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50d4b466-6576-58f7-9b58-ede958826c13',
    1,
    44.0,
    NULL,
    false,
    '44.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50d4b466-6576-58f7-9b58-ede958826c13',
    2,
    50.0,
    NULL,
    false,
    '50.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50d4b466-6576-58f7-9b58-ede958826c13',
    3,
    72.0,
    NULL,
    false,
    '72.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50d4b466-6576-58f7-9b58-ede958826c13',
    4,
    64.0,
    NULL,
    false,
    '64.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50d4b466-6576-58f7-9b58-ede958826c13',
    5,
    56.0,
    NULL,
    false,
    '56.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50d4b466-6576-58f7-9b58-ede958826c13',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '50d4b466-6576-58f7-9b58-ede958826c13',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '0899e8bc-b7ed-5a5e-b080-652c1e7ae24e',
    '2e3bb12e-a03a-535e-974f-140cd5eae63c',
    'add537f4-4531-5793-b0db-408493c608c5',
    '小林 秀',
    'JPN 3461',
    'individual',
    61,
    469.0,
    381.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'cac6ab51-5d0c-594b-8e42-f8c9a718d8c1',
    '0899e8bc-b7ed-5a5e-b080-652c1e7ae24e',
    '2e3bb12e-a03a-535e-974f-140cd5eae63c',
    '小林 秀',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0899e8bc-b7ed-5a5e-b080-652c1e7ae24e',
    1,
    62.0,
    NULL,
    false,
    '62.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0899e8bc-b7ed-5a5e-b080-652c1e7ae24e',
    2,
    53.0,
    NULL,
    false,
    '53.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0899e8bc-b7ed-5a5e-b080-652c1e7ae24e',
    3,
    86.0,
    NULL,
    false,
    '86.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0899e8bc-b7ed-5a5e-b080-652c1e7ae24e',
    4,
    34.0,
    NULL,
    false,
    '34.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0899e8bc-b7ed-5a5e-b080-652c1e7ae24e',
    5,
    58.0,
    NULL,
    false,
    '58.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0899e8bc-b7ed-5a5e-b080-652c1e7ae24e',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0899e8bc-b7ed-5a5e-b080-652c1e7ae24e',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '07a1538e-9f30-5e46-9a4f-eb67634c7ab5',
    '530f7665-acf6-5acd-9e30-ffd791f0d607',
    'add537f4-4531-5793-b0db-408493c608c5',
    '岩﨑 碧飛',
    'JPN 3371',
    'individual',
    62,
    470.0,
    382.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'abf705e0-32e9-5dd7-99e8-be7aa0c8fbae',
    '07a1538e-9f30-5e46-9a4f-eb67634c7ab5',
    '530f7665-acf6-5acd-9e30-ffd791f0d607',
    '岩﨑 碧飛',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '07a1538e-9f30-5e46-9a4f-eb67634c7ab5',
    1,
    47.0,
    NULL,
    false,
    '47.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '07a1538e-9f30-5e46-9a4f-eb67634c7ab5',
    2,
    43.0,
    NULL,
    false,
    '43.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '07a1538e-9f30-5e46-9a4f-eb67634c7ab5',
    3,
    78.0,
    NULL,
    false,
    '78.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '07a1538e-9f30-5e46-9a4f-eb67634c7ab5',
    4,
    77.0,
    NULL,
    false,
    '77.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '07a1538e-9f30-5e46-9a4f-eb67634c7ab5',
    5,
    49.0,
    NULL,
    false,
    '49.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '07a1538e-9f30-5e46-9a4f-eb67634c7ab5',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '07a1538e-9f30-5e46-9a4f-eb67634c7ab5',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'c86bd9b1-b2ed-5e85-b953-f0b159b52429',
    '98b0e59d-28c6-5856-b937-ab6815a64d89',
    'add537f4-4531-5793-b0db-408493c608c5',
    '橋本 岳',
    'JPN 2992',
    'individual',
    63,
    470.0,
    382.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f30bf8f9-4fa7-5501-8a29-605b92b42096',
    'c86bd9b1-b2ed-5e85-b953-f0b159b52429',
    '98b0e59d-28c6-5856-b937-ab6815a64d89',
    '橋本 岳',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c86bd9b1-b2ed-5e85-b953-f0b159b52429',
    1,
    59.0,
    NULL,
    false,
    '59.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c86bd9b1-b2ed-5e85-b953-f0b159b52429',
    2,
    61.0,
    NULL,
    false,
    '61.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c86bd9b1-b2ed-5e85-b953-f0b159b52429',
    3,
    51.0,
    NULL,
    false,
    '51.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c86bd9b1-b2ed-5e85-b953-f0b159b52429',
    4,
    54.0,
    NULL,
    false,
    '54.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c86bd9b1-b2ed-5e85-b953-f0b159b52429',
    5,
    69.0,
    NULL,
    false,
    '69.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c86bd9b1-b2ed-5e85-b953-f0b159b52429',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c86bd9b1-b2ed-5e85-b953-f0b159b52429',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '0a118778-8e9a-5035-8aa3-c44bd685ea0d',
    '9ff9e58f-1e5f-5656-9752-7f2e3e6ceee1',
    'add537f4-4531-5793-b0db-408493c608c5',
    '佐々木 海晟',
    'JPN 2922',
    'individual',
    64,
    470.0,
    382.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9f78764f-8656-5c62-bfd5-f8b8e019cc06',
    '0a118778-8e9a-5035-8aa3-c44bd685ea0d',
    '9ff9e58f-1e5f-5656-9752-7f2e3e6ceee1',
    '佐々木 海晟',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0a118778-8e9a-5035-8aa3-c44bd685ea0d',
    1,
    55.0,
    NULL,
    false,
    '55.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0a118778-8e9a-5035-8aa3-c44bd685ea0d',
    2,
    58.0,
    NULL,
    false,
    '58.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0a118778-8e9a-5035-8aa3-c44bd685ea0d',
    3,
    69.0,
    NULL,
    false,
    '69.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0a118778-8e9a-5035-8aa3-c44bd685ea0d',
    4,
    58.0,
    NULL,
    false,
    '58.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0a118778-8e9a-5035-8aa3-c44bd685ea0d',
    5,
    54.0,
    NULL,
    false,
    '54.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0a118778-8e9a-5035-8aa3-c44bd685ea0d',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0a118778-8e9a-5035-8aa3-c44bd685ea0d',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '6ec01c25-cc6c-597c-be37-2ed67ad6e201',
    '3981f7f0-9bcf-5579-b973-ce145ff74af7',
    'add537f4-4531-5793-b0db-408493c608c5',
    '片桐 なずな',
    'JPN 3169',
    'individual',
    65,
    473.0,
    385.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e3779584-7d67-5d4a-ad62-bba75529890a',
    '6ec01c25-cc6c-597c-be37-2ed67ad6e201',
    '3981f7f0-9bcf-5579-b973-ce145ff74af7',
    '片桐 なずな',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ec01c25-cc6c-597c-be37-2ed67ad6e201',
    1,
    64.0,
    NULL,
    false,
    '64.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ec01c25-cc6c-597c-be37-2ed67ad6e201',
    2,
    49.0,
    NULL,
    false,
    '49.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ec01c25-cc6c-597c-be37-2ed67ad6e201',
    3,
    55.0,
    NULL,
    false,
    '55.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ec01c25-cc6c-597c-be37-2ed67ad6e201',
    4,
    70.0,
    NULL,
    false,
    '70.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ec01c25-cc6c-597c-be37-2ed67ad6e201',
    5,
    59.0,
    NULL,
    false,
    '59.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ec01c25-cc6c-597c-be37-2ed67ad6e201',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6ec01c25-cc6c-597c-be37-2ed67ad6e201',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'c3b6b0b0-9d0a-5fc2-943c-e1117160d9c2',
    'cb200b97-f924-502c-bd8f-d2d4cf5d87b7',
    'add537f4-4531-5793-b0db-408493c608c5',
    '小熊 ひかり',
    'JPN 3304',
    'individual',
    66,
    474.0,
    386.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '17635d7c-411d-5f5c-83ae-c0cac0c7ddd1',
    'c3b6b0b0-9d0a-5fc2-943c-e1117160d9c2',
    'cb200b97-f924-502c-bd8f-d2d4cf5d87b7',
    '小熊 ひかり',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c3b6b0b0-9d0a-5fc2-943c-e1117160d9c2',
    1,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c3b6b0b0-9d0a-5fc2-943c-e1117160d9c2',
    2,
    68.0,
    NULL,
    false,
    '68.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c3b6b0b0-9d0a-5fc2-943c-e1117160d9c2',
    3,
    48.0,
    NULL,
    false,
    '48.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c3b6b0b0-9d0a-5fc2-943c-e1117160d9c2',
    4,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c3b6b0b0-9d0a-5fc2-943c-e1117160d9c2',
    5,
    65.0,
    NULL,
    false,
    '65.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c3b6b0b0-9d0a-5fc2-943c-e1117160d9c2',
    6,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c3b6b0b0-9d0a-5fc2-943c-e1117160d9c2',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'bf077cdc-c8e5-5b59-a701-5042c76a0ca2',
    'b6cc0462-6ade-5f4e-9b69-6e439ea2f637',
    'add537f4-4531-5793-b0db-408493c608c5',
    '米倉 瑛斗',
    'JPN 3021',
    'individual',
    67,
    477.0,
    389.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c5224aaf-3eff-5d28-8451-bae2866eb3d1',
    'bf077cdc-c8e5-5b59-a701-5042c76a0ca2',
    'b6cc0462-6ade-5f4e-9b69-6e439ea2f637',
    '米倉 瑛斗',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf077cdc-c8e5-5b59-a701-5042c76a0ca2',
    1,
    48.0,
    NULL,
    false,
    '48.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf077cdc-c8e5-5b59-a701-5042c76a0ca2',
    2,
    41.0,
    NULL,
    false,
    '41.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf077cdc-c8e5-5b59-a701-5042c76a0ca2',
    3,
    70.0,
    NULL,
    false,
    '70.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf077cdc-c8e5-5b59-a701-5042c76a0ca2',
    4,
    71.0,
    NULL,
    false,
    '71.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf077cdc-c8e5-5b59-a701-5042c76a0ca2',
    5,
    71.0,
    NULL,
    false,
    '71.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf077cdc-c8e5-5b59-a701-5042c76a0ca2',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf077cdc-c8e5-5b59-a701-5042c76a0ca2',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '445884c2-b949-5b8e-b16a-6ef4579a6d69',
    'dde9ddd6-db05-5d2f-945c-69c1c40bfefa',
    'add537f4-4531-5793-b0db-408493c608c5',
    '高橋 悠',
    'JPN 3227',
    'individual',
    68,
    483.0,
    395.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5e0d8d14-540c-5774-8033-654c84de8991',
    '445884c2-b949-5b8e-b16a-6ef4579a6d69',
    'dde9ddd6-db05-5d2f-945c-69c1c40bfefa',
    '高橋 悠',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '445884c2-b949-5b8e-b16a-6ef4579a6d69',
    1,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '445884c2-b949-5b8e-b16a-6ef4579a6d69',
    2,
    73.0,
    NULL,
    false,
    '73.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '445884c2-b949-5b8e-b16a-6ef4579a6d69',
    3,
    64.0,
    NULL,
    false,
    '64.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '445884c2-b949-5b8e-b16a-6ef4579a6d69',
    4,
    53.0,
    NULL,
    false,
    '53.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '445884c2-b949-5b8e-b16a-6ef4579a6d69',
    5,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '445884c2-b949-5b8e-b16a-6ef4579a6d69',
    6,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '445884c2-b949-5b8e-b16a-6ef4579a6d69',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'b53eff68-fc8a-5d8e-9b89-37ec3b2d1bd1',
    '1db25bd8-0213-553a-ac38-68887eb97519',
    'add537f4-4531-5793-b0db-408493c608c5',
    '風間 修羽',
    'JPN 2858',
    'individual',
    69,
    498.0,
    410.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '479b78d7-bb7c-5a5b-af54-60b9f1bca20d',
    'b53eff68-fc8a-5d8e-9b89-37ec3b2d1bd1',
    '1db25bd8-0213-553a-ac38-68887eb97519',
    '風間 修羽',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b53eff68-fc8a-5d8e-9b89-37ec3b2d1bd1',
    1,
    60.0,
    NULL,
    false,
    '60.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b53eff68-fc8a-5d8e-9b89-37ec3b2d1bd1',
    2,
    71.0,
    NULL,
    false,
    '71.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b53eff68-fc8a-5d8e-9b89-37ec3b2d1bd1',
    3,
    57.0,
    NULL,
    false,
    '57.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b53eff68-fc8a-5d8e-9b89-37ec3b2d1bd1',
    4,
    72.0,
    NULL,
    false,
    '72.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b53eff68-fc8a-5d8e-9b89-37ec3b2d1bd1',
    5,
    62.0,
    NULL,
    false,
    '62.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b53eff68-fc8a-5d8e-9b89-37ec3b2d1bd1',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b53eff68-fc8a-5d8e-9b89-37ec3b2d1bd1',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'd07b5a72-a152-5bd2-95c9-f8ebe5936063',
    '839db335-1f1f-5265-9172-941d448dfde4',
    'add537f4-4531-5793-b0db-408493c608c5',
    '竹原 由基',
    'JPN 3302',
    'individual',
    70,
    503.0,
    415.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c3c8eeb6-786e-5d87-863b-e6b21afdc25b',
    'd07b5a72-a152-5bd2-95c9-f8ebe5936063',
    '839db335-1f1f-5265-9172-941d448dfde4',
    '竹原 由基',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd07b5a72-a152-5bd2-95c9-f8ebe5936063',
    1,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd07b5a72-a152-5bd2-95c9-f8ebe5936063',
    2,
    75.0,
    NULL,
    false,
    '75.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd07b5a72-a152-5bd2-95c9-f8ebe5936063',
    3,
    46.0,
    NULL,
    false,
    '46.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd07b5a72-a152-5bd2-95c9-f8ebe5936063',
    4,
    63.0,
    NULL,
    false,
    '63.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd07b5a72-a152-5bd2-95c9-f8ebe5936063',
    5,
    55.0,
    NULL,
    false,
    '55.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd07b5a72-a152-5bd2-95c9-f8ebe5936063',
    6,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd07b5a72-a152-5bd2-95c9-f8ebe5936063',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'cbc5ef10-03be-5fdf-a5dd-823034bff8c8',
    '93211061-87e0-541b-a995-8a7f2a9ec78f',
    'add537f4-4531-5793-b0db-408493c608c5',
    '関 逞人',
    'JPN 3208',
    'individual',
    71,
    505.0,
    417.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bc08828b-f461-57e5-a819-ad3d94aaca88',
    'cbc5ef10-03be-5fdf-a5dd-823034bff8c8',
    '93211061-87e0-541b-a995-8a7f2a9ec78f',
    '関 逞人',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cbc5ef10-03be-5fdf-a5dd-823034bff8c8',
    1,
    88.0,
    'RET',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cbc5ef10-03be-5fdf-a5dd-823034bff8c8',
    2,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cbc5ef10-03be-5fdf-a5dd-823034bff8c8',
    3,
    53.0,
    NULL,
    false,
    '53.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cbc5ef10-03be-5fdf-a5dd-823034bff8c8',
    4,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cbc5ef10-03be-5fdf-a5dd-823034bff8c8',
    5,
    72.0,
    NULL,
    false,
    '72.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cbc5ef10-03be-5fdf-a5dd-823034bff8c8',
    6,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cbc5ef10-03be-5fdf-a5dd-823034bff8c8',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '927b3f70-f8a5-50ce-b7f2-0949866acd56',
    'a7253e72-5a0e-5965-b71c-2f21435ced4b',
    'add537f4-4531-5793-b0db-408493c608c5',
    '渕上 凛々',
    'JPN 3390',
    'individual',
    72,
    508.0,
    420.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'cbdb871e-1c58-56fb-a362-795aa358d5ab',
    '927b3f70-f8a5-50ce-b7f2-0949866acd56',
    'a7253e72-5a0e-5965-b71c-2f21435ced4b',
    '渕上 凛々',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '927b3f70-f8a5-50ce-b7f2-0949866acd56',
    1,
    58.0,
    NULL,
    false,
    '58.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '927b3f70-f8a5-50ce-b7f2-0949866acd56',
    2,
    67.0,
    NULL,
    false,
    '67.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '927b3f70-f8a5-50ce-b7f2-0949866acd56',
    3,
    65.0,
    NULL,
    false,
    '65.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '927b3f70-f8a5-50ce-b7f2-0949866acd56',
    4,
    62.0,
    NULL,
    false,
    '62.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '927b3f70-f8a5-50ce-b7f2-0949866acd56',
    5,
    80.0,
    NULL,
    false,
    '80.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '927b3f70-f8a5-50ce-b7f2-0949866acd56',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '927b3f70-f8a5-50ce-b7f2-0949866acd56',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'ede791cc-8532-5a5b-8435-46c6782c827e',
    'eb4ed52c-da43-57fe-a977-3bf7a74f4a26',
    'add537f4-4531-5793-b0db-408493c608c5',
    '菊池 颯太',
    'JPN 3372',
    'individual',
    73,
    514.0,
    426.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fa828614-c42a-5ef4-88e3-b1e6ea0fc254',
    'ede791cc-8532-5a5b-8435-46c6782c827e',
    'eb4ed52c-da43-57fe-a977-3bf7a74f4a26',
    '菊池 颯太',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ede791cc-8532-5a5b-8435-46c6782c827e',
    1,
    57.0,
    NULL,
    false,
    '57.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ede791cc-8532-5a5b-8435-46c6782c827e',
    2,
    59.0,
    NULL,
    false,
    '59.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ede791cc-8532-5a5b-8435-46c6782c827e',
    3,
    79.0,
    NULL,
    false,
    '79.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ede791cc-8532-5a5b-8435-46c6782c827e',
    4,
    75.0,
    NULL,
    false,
    '75.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ede791cc-8532-5a5b-8435-46c6782c827e',
    5,
    68.0,
    NULL,
    false,
    '68.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ede791cc-8532-5a5b-8435-46c6782c827e',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ede791cc-8532-5a5b-8435-46c6782c827e',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'bfe7ca04-5569-56d4-ade9-07db43eb5c1c',
    'c8699aad-198a-5c7f-b8e0-19e22c81389b',
    'add537f4-4531-5793-b0db-408493c608c5',
    '三枝 和平',
    'JPN 3360',
    'individual',
    74,
    516.0,
    428.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4b2d2bbb-1515-5b13-b12f-5c40623ea8eb',
    'bfe7ca04-5569-56d4-ade9-07db43eb5c1c',
    'c8699aad-198a-5c7f-b8e0-19e22c81389b',
    '三枝 和平',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bfe7ca04-5569-56d4-ade9-07db43eb5c1c',
    1,
    52.0,
    NULL,
    false,
    '52.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bfe7ca04-5569-56d4-ade9-07db43eb5c1c',
    2,
    46.0,
    NULL,
    false,
    '46.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bfe7ca04-5569-56d4-ade9-07db43eb5c1c',
    3,
    82.0,
    NULL,
    false,
    '82.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bfe7ca04-5569-56d4-ade9-07db43eb5c1c',
    4,
    81.0,
    NULL,
    false,
    '81.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bfe7ca04-5569-56d4-ade9-07db43eb5c1c',
    5,
    79.0,
    NULL,
    false,
    '79.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bfe7ca04-5569-56d4-ade9-07db43eb5c1c',
    6,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bfe7ca04-5569-56d4-ade9-07db43eb5c1c',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'a8df2478-7f76-5732-b1ec-8c51bd045727',
    'c5cc6ae1-1174-53d1-b271-2ad004a24cb8',
    'add537f4-4531-5793-b0db-408493c608c5',
    '長部 立希',
    'JPN 3303',
    'individual',
    75,
    525.0,
    437.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ad7c882a-844e-5c47-a430-938ae6f0811c',
    'a8df2478-7f76-5732-b1ec-8c51bd045727',
    'c5cc6ae1-1174-53d1-b271-2ad004a24cb8',
    '長部 立希',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a8df2478-7f76-5732-b1ec-8c51bd045727',
    1,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a8df2478-7f76-5732-b1ec-8c51bd045727',
    2,
    64.0,
    NULL,
    false,
    '64.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a8df2478-7f76-5732-b1ec-8c51bd045727',
    3,
    50.0,
    NULL,
    false,
    '50.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a8df2478-7f76-5732-b1ec-8c51bd045727',
    4,
    84.0,
    NULL,
    false,
    '84.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a8df2478-7f76-5732-b1ec-8c51bd045727',
    5,
    63.0,
    NULL,
    false,
    '63.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a8df2478-7f76-5732-b1ec-8c51bd045727',
    6,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a8df2478-7f76-5732-b1ec-8c51bd045727',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'ca5eeda7-0bf4-54b0-bb55-50c7b0150b59',
    '2ea5119e-ad68-53f6-bef1-4da853c13863',
    'add537f4-4531-5793-b0db-408493c608c5',
    '宮田 寧々',
    'JPN 3114',
    'individual',
    76,
    533.0,
    445.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'edfedc97-55d8-51b7-85a9-8834f334c71d',
    'ca5eeda7-0bf4-54b0-bb55-50c7b0150b59',
    '2ea5119e-ad68-53f6-bef1-4da853c13863',
    '宮田 寧々',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca5eeda7-0bf4-54b0-bb55-50c7b0150b59',
    1,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca5eeda7-0bf4-54b0-bb55-50c7b0150b59',
    2,
    57.0,
    NULL,
    false,
    '57.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca5eeda7-0bf4-54b0-bb55-50c7b0150b59',
    3,
    59.0,
    NULL,
    false,
    '59.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca5eeda7-0bf4-54b0-bb55-50c7b0150b59',
    4,
    80.0,
    NULL,
    false,
    '80.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca5eeda7-0bf4-54b0-bb55-50c7b0150b59',
    5,
    73.0,
    NULL,
    false,
    '73.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca5eeda7-0bf4-54b0-bb55-50c7b0150b59',
    6,
    88.0,
    'DSQ',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca5eeda7-0bf4-54b0-bb55-50c7b0150b59',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'e0e58270-ed04-5329-81ab-a826888bdcfe',
    '5b4f3be2-7312-52de-9494-8a157b59aaf9',
    'add537f4-4531-5793-b0db-408493c608c5',
    '中村 翼',
    'JPN 3409',
    'individual',
    77,
    545.0,
    457.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '73071124-19af-54a7-a0a7-b6934cc25431',
    'e0e58270-ed04-5329-81ab-a826888bdcfe',
    '5b4f3be2-7312-52de-9494-8a157b59aaf9',
    '中村 翼',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e0e58270-ed04-5329-81ab-a826888bdcfe',
    1,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e0e58270-ed04-5329-81ab-a826888bdcfe',
    2,
    54.0,
    NULL,
    false,
    '54.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e0e58270-ed04-5329-81ab-a826888bdcfe',
    3,
    71.0,
    NULL,
    false,
    '71.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e0e58270-ed04-5329-81ab-a826888bdcfe',
    4,
    78.0,
    NULL,
    false,
    '78.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e0e58270-ed04-5329-81ab-a826888bdcfe',
    5,
    78.0,
    NULL,
    false,
    '78.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e0e58270-ed04-5329-81ab-a826888bdcfe',
    6,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e0e58270-ed04-5329-81ab-a826888bdcfe',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'f5a51bd3-9a08-5dd2-bc69-94e7c81203a3',
    'abf594ea-f72f-57a8-b3d7-831633d2169d',
    'add537f4-4531-5793-b0db-408493c608c5',
    '虎井 彩雲',
    'JPN 3460',
    'individual',
    78,
    556.0,
    468.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '011e8192-46f8-55cb-87f3-9c28beee1527',
    'f5a51bd3-9a08-5dd2-bc69-94e7c81203a3',
    'abf594ea-f72f-57a8-b3d7-831633d2169d',
    '虎井 彩雲',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f5a51bd3-9a08-5dd2-bc69-94e7c81203a3',
    1,
    88.0,
    'DNC',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f5a51bd3-9a08-5dd2-bc69-94e7c81203a3',
    2,
    88.0,
    'DNC',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f5a51bd3-9a08-5dd2-bc69-94e7c81203a3',
    3,
    56.0,
    NULL,
    false,
    '56.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f5a51bd3-9a08-5dd2-bc69-94e7c81203a3',
    4,
    73.0,
    NULL,
    false,
    '73.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f5a51bd3-9a08-5dd2-bc69-94e7c81203a3',
    5,
    75.0,
    NULL,
    false,
    '75.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f5a51bd3-9a08-5dd2-bc69-94e7c81203a3',
    6,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f5a51bd3-9a08-5dd2-bc69-94e7c81203a3',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '860d76c6-91fd-5c46-bcae-3efe0a1b4854',
    '101de41c-3d78-5248-a9b2-36a88119d281',
    'add537f4-4531-5793-b0db-408493c608c5',
    '渡辺 樹',
    'JPN 3246',
    'individual',
    79,
    564.0,
    476.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '964b4f0e-b30a-5b51-ba80-37360dfe2980',
    '860d76c6-91fd-5c46-bcae-3efe0a1b4854',
    '101de41c-3d78-5248-a9b2-36a88119d281',
    '渡辺 樹',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '860d76c6-91fd-5c46-bcae-3efe0a1b4854',
    1,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '860d76c6-91fd-5c46-bcae-3efe0a1b4854',
    2,
    63.0,
    NULL,
    false,
    '63.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '860d76c6-91fd-5c46-bcae-3efe0a1b4854',
    3,
    75.0,
    NULL,
    false,
    '75.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '860d76c6-91fd-5c46-bcae-3efe0a1b4854',
    4,
    79.0,
    NULL,
    false,
    '79.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '860d76c6-91fd-5c46-bcae-3efe0a1b4854',
    5,
    83.0,
    NULL,
    false,
    '83.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '860d76c6-91fd-5c46-bcae-3efe0a1b4854',
    6,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '860d76c6-91fd-5c46-bcae-3efe0a1b4854',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'aef0b70b-152f-5163-99d4-9671ffce3ba2',
    'd23076d3-9729-5791-b1dc-7deb5ad9bc93',
    'add537f4-4531-5793-b0db-408493c608c5',
    '木村 帆乃佳',
    'JPN 3512',
    'individual',
    80,
    571.0,
    483.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e14c7f1a-213f-5eff-9ede-244027803c57',
    'aef0b70b-152f-5163-99d4-9671ffce3ba2',
    'd23076d3-9729-5791-b1dc-7deb5ad9bc93',
    '木村 帆乃佳',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aef0b70b-152f-5163-99d4-9671ffce3ba2',
    1,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aef0b70b-152f-5163-99d4-9671ffce3ba2',
    2,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aef0b70b-152f-5163-99d4-9671ffce3ba2',
    3,
    74.0,
    NULL,
    false,
    '74.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aef0b70b-152f-5163-99d4-9671ffce3ba2',
    4,
    61.0,
    NULL,
    false,
    '61.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aef0b70b-152f-5163-99d4-9671ffce3ba2',
    5,
    84.0,
    NULL,
    false,
    '84.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aef0b70b-152f-5163-99d4-9671ffce3ba2',
    6,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aef0b70b-152f-5163-99d4-9671ffce3ba2',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '870e0c92-41c4-5bfd-9c59-c91391697576',
    '4aa15132-b6cd-5283-b6e0-2abad8e69e39',
    'add537f4-4531-5793-b0db-408493c608c5',
    'ウィンバーリー 康算',
    'JPN 3170',
    'individual',
    81,
    582.0,
    494.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '994a535e-9c35-5a6c-ad1e-bfd27b887517',
    '870e0c92-41c4-5bfd-9c59-c91391697576',
    '4aa15132-b6cd-5283-b6e0-2abad8e69e39',
    'ウィンバーリー 康算',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '870e0c92-41c4-5bfd-9c59-c91391697576',
    1,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '870e0c92-41c4-5bfd-9c59-c91391697576',
    2,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '870e0c92-41c4-5bfd-9c59-c91391697576',
    3,
    80.0,
    NULL,
    false,
    '80.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '870e0c92-41c4-5bfd-9c59-c91391697576',
    4,
    69.0,
    NULL,
    false,
    '69.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '870e0c92-41c4-5bfd-9c59-c91391697576',
    5,
    81.0,
    NULL,
    false,
    '81.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '870e0c92-41c4-5bfd-9c59-c91391697576',
    6,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '870e0c92-41c4-5bfd-9c59-c91391697576',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '1ccbf4c7-c87a-5823-8644-5a0cbd9d00bf',
    '0926e251-b81b-5585-9328-bfb95db14484',
    'add537f4-4531-5793-b0db-408493c608c5',
    '関 智晴',
    'JPN 3139',
    'individual',
    82,
    583.0,
    495.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e9842f23-52c7-5962-8682-0918f12529c2',
    '1ccbf4c7-c87a-5823-8644-5a0cbd9d00bf',
    '0926e251-b81b-5585-9328-bfb95db14484',
    '関 智晴',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1ccbf4c7-c87a-5823-8644-5a0cbd9d00bf',
    1,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1ccbf4c7-c87a-5823-8644-5a0cbd9d00bf',
    2,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1ccbf4c7-c87a-5823-8644-5a0cbd9d00bf',
    3,
    67.0,
    NULL,
    false,
    '67.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1ccbf4c7-c87a-5823-8644-5a0cbd9d00bf',
    4,
    82.0,
    NULL,
    false,
    '82.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1ccbf4c7-c87a-5823-8644-5a0cbd9d00bf',
    5,
    82.0,
    NULL,
    false,
    '82.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1ccbf4c7-c87a-5823-8644-5a0cbd9d00bf',
    6,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1ccbf4c7-c87a-5823-8644-5a0cbd9d00bf',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '3c50c7c1-4397-51f3-b0a5-0ebc260bb11b',
    '2c4324c2-fc52-523c-ab68-c93a200e0e2d',
    'add537f4-4531-5793-b0db-408493c608c5',
    '嘉山 沙南',
    'JPN 2967',
    'individual',
    83,
    588.0,
    500.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4ab2a0d7-b12b-562d-a7f5-6e7c878c7ccb',
    '3c50c7c1-4397-51f3-b0a5-0ebc260bb11b',
    '2c4324c2-fc52-523c-ab68-c93a200e0e2d',
    '嘉山 沙南',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c50c7c1-4397-51f3-b0a5-0ebc260bb11b',
    1,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c50c7c1-4397-51f3-b0a5-0ebc260bb11b',
    2,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c50c7c1-4397-51f3-b0a5-0ebc260bb11b',
    3,
    83.0,
    NULL,
    false,
    '83.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c50c7c1-4397-51f3-b0a5-0ebc260bb11b',
    4,
    76.0,
    NULL,
    false,
    '76.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c50c7c1-4397-51f3-b0a5-0ebc260bb11b',
    5,
    77.0,
    NULL,
    false,
    '77.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c50c7c1-4397-51f3-b0a5-0ebc260bb11b',
    6,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c50c7c1-4397-51f3-b0a5-0ebc260bb11b',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '0b548649-fcc6-5071-9e9c-6a58e3f42085',
    'ab13f6f7-bb7f-5cea-8aaa-c9452a282670',
    'add537f4-4531-5793-b0db-408493c608c5',
    '松田 季子',
    'JPN 2843',
    'individual',
    84,
    594.0,
    506.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '17224bbf-444d-53cb-9266-eea8692c48b4',
    '0b548649-fcc6-5071-9e9c-6a58e3f42085',
    'ab13f6f7-bb7f-5cea-8aaa-c9452a282670',
    '松田 季子',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b548649-fcc6-5071-9e9c-6a58e3f42085',
    1,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b548649-fcc6-5071-9e9c-6a58e3f42085',
    2,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b548649-fcc6-5071-9e9c-6a58e3f42085',
    3,
    81.0,
    NULL,
    false,
    '81.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b548649-fcc6-5071-9e9c-6a58e3f42085',
    4,
    85.0,
    NULL,
    false,
    '85.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b548649-fcc6-5071-9e9c-6a58e3f42085',
    5,
    76.0,
    NULL,
    false,
    '76.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b548649-fcc6-5071-9e9c-6a58e3f42085',
    6,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '0b548649-fcc6-5071-9e9c-6a58e3f42085',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '3d587e36-da00-565d-a3f6-f84addc480db',
    'ace62ef8-e779-5ce7-9b50-21c456520cec',
    'add537f4-4531-5793-b0db-408493c608c5',
    'ウィンバーリー 貫一',
    'JPN 2969',
    'individual',
    85,
    604.0,
    516.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4b0fdc38-ecf5-5d98-a197-b79802ca9f41',
    '3d587e36-da00-565d-a3f6-f84addc480db',
    'ace62ef8-e779-5ce7-9b50-21c456520cec',
    'ウィンバーリー 貫一',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d587e36-da00-565d-a3f6-f84addc480db',
    1,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d587e36-da00-565d-a3f6-f84addc480db',
    2,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d587e36-da00-565d-a3f6-f84addc480db',
    3,
    84.0,
    NULL,
    false,
    '84.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d587e36-da00-565d-a3f6-f84addc480db',
    4,
    83.0,
    NULL,
    false,
    '83.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d587e36-da00-565d-a3f6-f84addc480db',
    5,
    85.0,
    NULL,
    false,
    '85.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d587e36-da00-565d-a3f6-f84addc480db',
    6,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3d587e36-da00-565d-a3f6-f84addc480db',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '4192078e-c52f-52d3-a96f-1a643c4f06cc',
    '6a8873bc-12ed-58a4-be8b-14f9d6ff1fe3',
    'add537f4-4531-5793-b0db-408493c608c5',
    '林 昊平',
    'JPN 2940',
    'individual',
    86,
    609.0,
    521.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'aed0be4c-ecbd-5177-89fb-76d447357ee5',
    '4192078e-c52f-52d3-a96f-1a643c4f06cc',
    '6a8873bc-12ed-58a4-be8b-14f9d6ff1fe3',
    '林 昊平',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4192078e-c52f-52d3-a96f-1a643c4f06cc',
    1,
    88.0,
    'DNF',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4192078e-c52f-52d3-a96f-1a643c4f06cc',
    2,
    88.0,
    'DNC',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4192078e-c52f-52d3-a96f-1a643c4f06cc',
    3,
    85.0,
    NULL,
    false,
    '85.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4192078e-c52f-52d3-a96f-1a643c4f06cc',
    4,
    86.0,
    NULL,
    false,
    '86.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4192078e-c52f-52d3-a96f-1a643c4f06cc',
    5,
    86.0,
    NULL,
    false,
    '86.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4192078e-c52f-52d3-a96f-1a643c4f06cc',
    6,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4192078e-c52f-52d3-a96f-1a643c4f06cc',
    7,
    88.0,
    'DNF',
    false,
    '88.0'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '5d8a16d6-2e62-528c-8bd9-fb1b294ca29c',
    'f68b54e7-7c68-5bba-a46a-d5b06708c413',
    'add537f4-4531-5793-b0db-408493c608c5',
    'オセプコヴァ',
    'JPN 3306',
    'individual',
    87,
    616.0,
    528.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Aクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Signed 2026/8/24 6:06.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'cfd94b26-9e28-58a5-b2a6-1806ef83ac22',
    '5d8a16d6-2e62-528c-8bd9-fb1b294ca29c',
    'f68b54e7-7c68-5bba-a46a-d5b06708c413',
    'オセプコヴァ',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d8a16d6-2e62-528c-8bd9-fb1b294ca29c',
    1,
    88.0,
    'DNC',
    true,
    '(88.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d8a16d6-2e62-528c-8bd9-fb1b294ca29c',
    2,
    88.0,
    'DNC',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d8a16d6-2e62-528c-8bd9-fb1b294ca29c',
    3,
    88.0,
    'DNC',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d8a16d6-2e62-528c-8bd9-fb1b294ca29c',
    4,
    88.0,
    'DNC',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d8a16d6-2e62-528c-8bd9-fb1b294ca29c',
    5,
    88.0,
    'DNC',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d8a16d6-2e62-528c-8bd9-fb1b294ca29c',
    6,
    88.0,
    'DNC',
    false,
    '88.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d8a16d6-2e62-528c-8bd9-fb1b294ca29c',
    7,
    88.0,
    'DNC',
    false,
    '88.0'
);

-- 6. Regatta Results: Class B (22 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '8b5c86e0-21ff-552e-a38b-2cd4caee8b39',
    'df3b979c-913d-5cc0-9a91-928938db6e62',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '髙野 新',
    'JPN 3228',
    'individual',
    1,
    39.0,
    18.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '21dc5b2d-590c-52bf-9f2f-76704855fa79',
    '8b5c86e0-21ff-552e-a38b-2cd4caee8b39',
    'df3b979c-913d-5cc0-9a91-928938db6e62',
    '髙野 新',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8b5c86e0-21ff-552e-a38b-2cd4caee8b39',
    1,
    8.0,
    NULL,
    true,
    '(8.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8b5c86e0-21ff-552e-a38b-2cd4caee8b39',
    2,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8b5c86e0-21ff-552e-a38b-2cd4caee8b39',
    3,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8b5c86e0-21ff-552e-a38b-2cd4caee8b39',
    4,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8b5c86e0-21ff-552e-a38b-2cd4caee8b39',
    5,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8b5c86e0-21ff-552e-a38b-2cd4caee8b39',
    6,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8b5c86e0-21ff-552e-a38b-2cd4caee8b39',
    7,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8b5c86e0-21ff-552e-a38b-2cd4caee8b39',
    8,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8b5c86e0-21ff-552e-a38b-2cd4caee8b39',
    9,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8b5c86e0-21ff-552e-a38b-2cd4caee8b39',
    10,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8b5c86e0-21ff-552e-a38b-2cd4caee8b39',
    11,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8b5c86e0-21ff-552e-a38b-2cd4caee8b39',
    12,
    5.0,
    NULL,
    true,
    '(5.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8b5c86e0-21ff-552e-a38b-2cd4caee8b39',
    13,
    8.0,
    NULL,
    true,
    '(8.0)'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '8fd64a95-2f3b-5b42-ae78-0d133de7aefb',
    '79064913-e335-5eb2-9d2b-36cfcb1ade66',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '柘植 莉世',
    'JPN 3315',
    'individual',
    2,
    50.0,
    26.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '840e335d-01e4-5bae-b215-9bf85b909a1b',
    '8fd64a95-2f3b-5b42-ae78-0d133de7aefb',
    '79064913-e335-5eb2-9d2b-36cfcb1ade66',
    '柘植 莉世',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fd64a95-2f3b-5b42-ae78-0d133de7aefb',
    1,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fd64a95-2f3b-5b42-ae78-0d133de7aefb',
    2,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fd64a95-2f3b-5b42-ae78-0d133de7aefb',
    3,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fd64a95-2f3b-5b42-ae78-0d133de7aefb',
    4,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fd64a95-2f3b-5b42-ae78-0d133de7aefb',
    5,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fd64a95-2f3b-5b42-ae78-0d133de7aefb',
    6,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fd64a95-2f3b-5b42-ae78-0d133de7aefb',
    7,
    6.0,
    NULL,
    true,
    '(6.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fd64a95-2f3b-5b42-ae78-0d133de7aefb',
    8,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fd64a95-2f3b-5b42-ae78-0d133de7aefb',
    9,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fd64a95-2f3b-5b42-ae78-0d133de7aefb',
    10,
    11.0,
    NULL,
    true,
    '(11.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fd64a95-2f3b-5b42-ae78-0d133de7aefb',
    11,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fd64a95-2f3b-5b42-ae78-0d133de7aefb',
    12,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fd64a95-2f3b-5b42-ae78-0d133de7aefb',
    13,
    7.0,
    NULL,
    true,
    '(7.0)'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '899dd99a-d711-5841-8c36-5294ba6f7c6d',
    '89895bbd-2b5e-5395-9225-0bfa155a1975',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '中村 海俐',
    'JPN 3389',
    'individual',
    3,
    74.0,
    30.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6b9dd044-9c67-5f59-a944-c2be29b4be65',
    '899dd99a-d711-5841-8c36-5294ba6f7c6d',
    '89895bbd-2b5e-5395-9225-0bfa155a1975',
    '中村 海俐',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '899dd99a-d711-5841-8c36-5294ba6f7c6d',
    1,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '899dd99a-d711-5841-8c36-5294ba6f7c6d',
    2,
    21.0,
    NULL,
    true,
    '(21.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '899dd99a-d711-5841-8c36-5294ba6f7c6d',
    3,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '899dd99a-d711-5841-8c36-5294ba6f7c6d',
    4,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '899dd99a-d711-5841-8c36-5294ba6f7c6d',
    5,
    9.0,
    NULL,
    true,
    '(9.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '899dd99a-d711-5841-8c36-5294ba6f7c6d',
    6,
    14.0,
    NULL,
    true,
    '(14.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '899dd99a-d711-5841-8c36-5294ba6f7c6d',
    7,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '899dd99a-d711-5841-8c36-5294ba6f7c6d',
    8,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '899dd99a-d711-5841-8c36-5294ba6f7c6d',
    9,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '899dd99a-d711-5841-8c36-5294ba6f7c6d',
    10,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '899dd99a-d711-5841-8c36-5294ba6f7c6d',
    11,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '899dd99a-d711-5841-8c36-5294ba6f7c6d',
    12,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '899dd99a-d711-5841-8c36-5294ba6f7c6d',
    13,
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
    '00a55246-31b3-525e-bdd8-57b892af0a67',
    '56a195f7-573f-5799-b561-c37c60641c64',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '井澤 樹',
    'JPN 2606',
    'individual',
    4,
    65.0,
    41.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1e5d5efa-9d01-5a51-b868-17dc4bde1a12',
    '00a55246-31b3-525e-bdd8-57b892af0a67',
    '56a195f7-573f-5799-b561-c37c60641c64',
    '井澤 樹',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00a55246-31b3-525e-bdd8-57b892af0a67',
    1,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00a55246-31b3-525e-bdd8-57b892af0a67',
    2,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00a55246-31b3-525e-bdd8-57b892af0a67',
    3,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00a55246-31b3-525e-bdd8-57b892af0a67',
    4,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00a55246-31b3-525e-bdd8-57b892af0a67',
    5,
    8.0,
    NULL,
    true,
    '(8.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00a55246-31b3-525e-bdd8-57b892af0a67',
    6,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00a55246-31b3-525e-bdd8-57b892af0a67',
    7,
    9.0,
    NULL,
    true,
    '(9.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00a55246-31b3-525e-bdd8-57b892af0a67',
    8,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00a55246-31b3-525e-bdd8-57b892af0a67',
    9,
    7.0,
    NULL,
    true,
    '(7.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00a55246-31b3-525e-bdd8-57b892af0a67',
    10,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00a55246-31b3-525e-bdd8-57b892af0a67',
    11,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00a55246-31b3-525e-bdd8-57b892af0a67',
    12,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '00a55246-31b3-525e-bdd8-57b892af0a67',
    13,
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
    'e6371955-02d6-5686-bdea-e9b3918a0f8c',
    '59f80ba3-ef5c-595d-a574-8401f7c939b7',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '登尾 咲',
    'JPN 3230',
    'individual',
    5,
    80.0,
    47.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c120bbaa-ef69-5fe2-b5f3-32f08d0b78c8',
    'e6371955-02d6-5686-bdea-e9b3918a0f8c',
    '59f80ba3-ef5c-595d-a574-8401f7c939b7',
    '登尾 咲',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6371955-02d6-5686-bdea-e9b3918a0f8c',
    1,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6371955-02d6-5686-bdea-e9b3918a0f8c',
    2,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6371955-02d6-5686-bdea-e9b3918a0f8c',
    3,
    9.0,
    NULL,
    true,
    '(9.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6371955-02d6-5686-bdea-e9b3918a0f8c',
    4,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6371955-02d6-5686-bdea-e9b3918a0f8c',
    5,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6371955-02d6-5686-bdea-e9b3918a0f8c',
    6,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6371955-02d6-5686-bdea-e9b3918a0f8c',
    7,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6371955-02d6-5686-bdea-e9b3918a0f8c',
    8,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6371955-02d6-5686-bdea-e9b3918a0f8c',
    9,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6371955-02d6-5686-bdea-e9b3918a0f8c',
    10,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6371955-02d6-5686-bdea-e9b3918a0f8c',
    11,
    12.0,
    NULL,
    true,
    '(12.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6371955-02d6-5686-bdea-e9b3918a0f8c',
    12,
    12.0,
    NULL,
    true,
    '(12.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6371955-02d6-5686-bdea-e9b3918a0f8c',
    13,
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
    '97ba91d3-f1c7-5475-9e34-aed273112e2c',
    'e76834f4-43f9-5a53-88b2-4b7c59fd3f7c',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '山崎 篤人',
    'JPN 3109',
    'individual',
    6,
    90.0,
    52.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5b29514f-3b65-5567-b92f-8d3ef0a20192',
    '97ba91d3-f1c7-5475-9e34-aed273112e2c',
    'e76834f4-43f9-5a53-88b2-4b7c59fd3f7c',
    '山崎 篤人',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97ba91d3-f1c7-5475-9e34-aed273112e2c',
    1,
    12.0,
    NULL,
    true,
    '(12.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97ba91d3-f1c7-5475-9e34-aed273112e2c',
    2,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97ba91d3-f1c7-5475-9e34-aed273112e2c',
    3,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97ba91d3-f1c7-5475-9e34-aed273112e2c',
    4,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97ba91d3-f1c7-5475-9e34-aed273112e2c',
    5,
    10.0,
    NULL,
    true,
    '(10.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97ba91d3-f1c7-5475-9e34-aed273112e2c',
    6,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97ba91d3-f1c7-5475-9e34-aed273112e2c',
    7,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97ba91d3-f1c7-5475-9e34-aed273112e2c',
    8,
    16.0,
    NULL,
    true,
    '(16.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97ba91d3-f1c7-5475-9e34-aed273112e2c',
    9,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97ba91d3-f1c7-5475-9e34-aed273112e2c',
    10,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97ba91d3-f1c7-5475-9e34-aed273112e2c',
    11,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97ba91d3-f1c7-5475-9e34-aed273112e2c',
    12,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '97ba91d3-f1c7-5475-9e34-aed273112e2c',
    13,
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
    '8fca1462-0452-545b-b975-d3925c5fa980',
    'f9e15ee1-4848-573a-9a2e-d0991fafd1fb',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '久保田 万太郎',
    'JPN 2608',
    'individual',
    7,
    130.0,
    74.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a4c27437-5c29-54a4-bee5-594b0f839982',
    '8fca1462-0452-545b-b975-d3925c5fa980',
    'f9e15ee1-4848-573a-9a2e-d0991fafd1fb',
    '久保田 万太郎',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fca1462-0452-545b-b975-d3925c5fa980',
    1,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fca1462-0452-545b-b975-d3925c5fa980',
    2,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fca1462-0452-545b-b975-d3925c5fa980',
    3,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fca1462-0452-545b-b975-d3925c5fa980',
    4,
    21.0,
    NULL,
    true,
    '(21.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fca1462-0452-545b-b975-d3925c5fa980',
    5,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fca1462-0452-545b-b975-d3925c5fa980',
    6,
    18.0,
    NULL,
    true,
    '(18.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fca1462-0452-545b-b975-d3925c5fa980',
    7,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fca1462-0452-545b-b975-d3925c5fa980',
    8,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fca1462-0452-545b-b975-d3925c5fa980',
    9,
    17.0,
    NULL,
    true,
    '(17.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fca1462-0452-545b-b975-d3925c5fa980',
    10,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fca1462-0452-545b-b975-d3925c5fa980',
    11,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fca1462-0452-545b-b975-d3925c5fa980',
    12,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8fca1462-0452-545b-b975-d3925c5fa980',
    13,
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
    'e450acd3-0a43-59b8-96d8-a22ac2e0b60c',
    'c01f57a0-fea8-5419-9303-761b13a3ab93',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '田淵 陽帆',
    'JPN 32',
    'individual',
    8,
    128.0,
    76.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a74a193b-a9e7-5e94-997c-44557c1e968f',
    'e450acd3-0a43-59b8-96d8-a22ac2e0b60c',
    'c01f57a0-fea8-5419-9303-761b13a3ab93',
    '田淵 陽帆',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e450acd3-0a43-59b8-96d8-a22ac2e0b60c',
    1,
    15.0,
    NULL,
    true,
    '(15.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e450acd3-0a43-59b8-96d8-a22ac2e0b60c',
    2,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e450acd3-0a43-59b8-96d8-a22ac2e0b60c',
    3,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e450acd3-0a43-59b8-96d8-a22ac2e0b60c',
    4,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e450acd3-0a43-59b8-96d8-a22ac2e0b60c',
    5,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e450acd3-0a43-59b8-96d8-a22ac2e0b60c',
    6,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e450acd3-0a43-59b8-96d8-a22ac2e0b60c',
    7,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e450acd3-0a43-59b8-96d8-a22ac2e0b60c',
    8,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e450acd3-0a43-59b8-96d8-a22ac2e0b60c',
    9,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e450acd3-0a43-59b8-96d8-a22ac2e0b60c',
    10,
    17.0,
    NULL,
    true,
    '(17.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e450acd3-0a43-59b8-96d8-a22ac2e0b60c',
    11,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e450acd3-0a43-59b8-96d8-a22ac2e0b60c',
    12,
    20.0,
    NULL,
    true,
    '(20.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e450acd3-0a43-59b8-96d8-a22ac2e0b60c',
    13,
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
    'ff7619c3-3ac6-52f7-af57-b58f356a1902',
    'f4ae5487-ca29-59ac-8da3-c3272688babf',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '青木 海翔',
    'JPN 2605',
    'individual',
    9,
    140.0,
    84.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ddb1d02b-5d80-5277-9740-c0efee50c265',
    'ff7619c3-3ac6-52f7-af57-b58f356a1902',
    'f4ae5487-ca29-59ac-8da3-c3272688babf',
    '青木 海翔',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff7619c3-3ac6-52f7-af57-b58f356a1902',
    1,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff7619c3-3ac6-52f7-af57-b58f356a1902',
    2,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff7619c3-3ac6-52f7-af57-b58f356a1902',
    3,
    21.0,
    NULL,
    true,
    '(21.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff7619c3-3ac6-52f7-af57-b58f356a1902',
    4,
    19.0,
    NULL,
    true,
    '(19.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff7619c3-3ac6-52f7-af57-b58f356a1902',
    5,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff7619c3-3ac6-52f7-af57-b58f356a1902',
    6,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff7619c3-3ac6-52f7-af57-b58f356a1902',
    7,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff7619c3-3ac6-52f7-af57-b58f356a1902',
    8,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff7619c3-3ac6-52f7-af57-b58f356a1902',
    9,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff7619c3-3ac6-52f7-af57-b58f356a1902',
    10,
    16.0,
    NULL,
    true,
    '(16.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff7619c3-3ac6-52f7-af57-b58f356a1902',
    11,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff7619c3-3ac6-52f7-af57-b58f356a1902',
    12,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ff7619c3-3ac6-52f7-af57-b58f356a1902',
    13,
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
    'dabb7446-152b-5054-8890-f0b644faa6b0',
    '087d1030-05d8-51aa-b5a0-a3b3ba0e203a',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '松浦 楓',
    'JPN 3100',
    'individual',
    10,
    141.0,
    86.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '106e1186-fe52-5e83-85ca-3fc199604685',
    'dabb7446-152b-5054-8890-f0b644faa6b0',
    '087d1030-05d8-51aa-b5a0-a3b3ba0e203a',
    '松浦 楓',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dabb7446-152b-5054-8890-f0b644faa6b0',
    1,
    18.0,
    NULL,
    true,
    '(18.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dabb7446-152b-5054-8890-f0b644faa6b0',
    2,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dabb7446-152b-5054-8890-f0b644faa6b0',
    3,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dabb7446-152b-5054-8890-f0b644faa6b0',
    4,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dabb7446-152b-5054-8890-f0b644faa6b0',
    5,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dabb7446-152b-5054-8890-f0b644faa6b0',
    6,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dabb7446-152b-5054-8890-f0b644faa6b0',
    7,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dabb7446-152b-5054-8890-f0b644faa6b0',
    8,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dabb7446-152b-5054-8890-f0b644faa6b0',
    9,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dabb7446-152b-5054-8890-f0b644faa6b0',
    10,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dabb7446-152b-5054-8890-f0b644faa6b0',
    11,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dabb7446-152b-5054-8890-f0b644faa6b0',
    12,
    21.0,
    NULL,
    true,
    '(21.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'dabb7446-152b-5054-8890-f0b644faa6b0',
    13,
    16.0,
    NULL,
    true,
    '(16.0)'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '5f6832d1-2398-5096-ba95-69a9e2507797',
    '63669df5-1304-5513-be57-f98dac68910e',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '飯嶋 柚衣凪',
    'JPN 3096',
    'individual',
    11,
    151.0,
    99.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '30bfeded-e279-5f65-a92a-634c74e0324b',
    '5f6832d1-2398-5096-ba95-69a9e2507797',
    '63669df5-1304-5513-be57-f98dac68910e',
    '飯嶋 柚衣凪',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5f6832d1-2398-5096-ba95-69a9e2507797',
    1,
    19.0,
    NULL,
    true,
    '(19.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5f6832d1-2398-5096-ba95-69a9e2507797',
    2,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5f6832d1-2398-5096-ba95-69a9e2507797',
    3,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5f6832d1-2398-5096-ba95-69a9e2507797',
    4,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5f6832d1-2398-5096-ba95-69a9e2507797',
    5,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5f6832d1-2398-5096-ba95-69a9e2507797',
    6,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5f6832d1-2398-5096-ba95-69a9e2507797',
    7,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5f6832d1-2398-5096-ba95-69a9e2507797',
    8,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5f6832d1-2398-5096-ba95-69a9e2507797',
    9,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5f6832d1-2398-5096-ba95-69a9e2507797',
    10,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5f6832d1-2398-5096-ba95-69a9e2507797',
    11,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5f6832d1-2398-5096-ba95-69a9e2507797',
    12,
    15.0,
    NULL,
    true,
    '(15.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5f6832d1-2398-5096-ba95-69a9e2507797',
    13,
    18.0,
    NULL,
    true,
    '(18.0)'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'b5013e30-045c-5009-855c-55e9d19223ed',
    '15a2b569-9eeb-5f34-9a8b-c9745da43690',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '坂上 泰一朗',
    'JPN 1',
    'individual',
    12,
    151.0,
    102.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e3664de2-86a7-5d6e-9d92-50193e9e7159',
    'b5013e30-045c-5009-855c-55e9d19223ed',
    '15a2b569-9eeb-5f34-9a8b-c9745da43690',
    '坂上 泰一朗',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5013e30-045c-5009-855c-55e9d19223ed',
    1,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5013e30-045c-5009-855c-55e9d19223ed',
    2,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5013e30-045c-5009-855c-55e9d19223ed',
    3,
    18.0,
    NULL,
    true,
    '(18.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5013e30-045c-5009-855c-55e9d19223ed',
    4,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5013e30-045c-5009-855c-55e9d19223ed',
    5,
    17.0,
    NULL,
    true,
    '(17.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5013e30-045c-5009-855c-55e9d19223ed',
    6,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5013e30-045c-5009-855c-55e9d19223ed',
    7,
    14.0,
    NULL,
    true,
    '(14.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5013e30-045c-5009-855c-55e9d19223ed',
    8,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5013e30-045c-5009-855c-55e9d19223ed',
    9,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5013e30-045c-5009-855c-55e9d19223ed',
    10,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5013e30-045c-5009-855c-55e9d19223ed',
    11,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5013e30-045c-5009-855c-55e9d19223ed',
    12,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5013e30-045c-5009-855c-55e9d19223ed',
    13,
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
    '8123c77a-a234-55e5-84cb-8340c3a4c76c',
    'cd738e04-cc4c-5b9c-94a0-078cbada7f6e',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '中山 弦音',
    'JPN 2609',
    'individual',
    13,
    171.0,
    109.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'dad398d1-c462-55bf-850c-f05307498353',
    '8123c77a-a234-55e5-84cb-8340c3a4c76c',
    'cd738e04-cc4c-5b9c-94a0-078cbada7f6e',
    '中山 弦音',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8123c77a-a234-55e5-84cb-8340c3a4c76c',
    1,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8123c77a-a234-55e5-84cb-8340c3a4c76c',
    2,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8123c77a-a234-55e5-84cb-8340c3a4c76c',
    3,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8123c77a-a234-55e5-84cb-8340c3a4c76c',
    4,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8123c77a-a234-55e5-84cb-8340c3a4c76c',
    5,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8123c77a-a234-55e5-84cb-8340c3a4c76c',
    6,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8123c77a-a234-55e5-84cb-8340c3a4c76c',
    7,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8123c77a-a234-55e5-84cb-8340c3a4c76c',
    8,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8123c77a-a234-55e5-84cb-8340c3a4c76c',
    9,
    19.0,
    NULL,
    true,
    '(19.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8123c77a-a234-55e5-84cb-8340c3a4c76c',
    10,
    23.0,
    'OCS',
    true,
    '(23.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8123c77a-a234-55e5-84cb-8340c3a4c76c',
    11,
    20.0,
    NULL,
    true,
    '(20.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8123c77a-a234-55e5-84cb-8340c3a4c76c',
    12,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8123c77a-a234-55e5-84cb-8340c3a4c76c',
    13,
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
    '16a7c67d-3eec-5255-8126-995050d6b370',
    '6f0dd3b6-1bc2-52b3-a1a5-850717b7dee4',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '真中 朋歌',
    'JPN 2940',
    'individual',
    14,
    172.0,
    111.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e2629f17-9492-5ce0-aabc-f74edbe4b82f',
    '16a7c67d-3eec-5255-8126-995050d6b370',
    '6f0dd3b6-1bc2-52b3-a1a5-850717b7dee4',
    '真中 朋歌',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16a7c67d-3eec-5255-8126-995050d6b370',
    1,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16a7c67d-3eec-5255-8126-995050d6b370',
    2,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16a7c67d-3eec-5255-8126-995050d6b370',
    3,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16a7c67d-3eec-5255-8126-995050d6b370',
    4,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16a7c67d-3eec-5255-8126-995050d6b370',
    5,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16a7c67d-3eec-5255-8126-995050d6b370',
    6,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16a7c67d-3eec-5255-8126-995050d6b370',
    7,
    18.0,
    NULL,
    true,
    '(18.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16a7c67d-3eec-5255-8126-995050d6b370',
    8,
    20.0,
    NULL,
    true,
    '(20.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16a7c67d-3eec-5255-8126-995050d6b370',
    9,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16a7c67d-3eec-5255-8126-995050d6b370',
    10,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16a7c67d-3eec-5255-8126-995050d6b370',
    11,
    23.0,
    'OCS',
    true,
    '(23.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16a7c67d-3eec-5255-8126-995050d6b370',
    12,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '16a7c67d-3eec-5255-8126-995050d6b370',
    13,
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
    '77ee933a-884b-5512-84a3-8a74da6e1b28',
    '523be7c2-3db8-5273-a02a-9c840f48bf5f',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '山村 環菜',
    'JPN 338',
    'individual',
    15,
    196.0,
    132.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3ad0cb60-f2ba-51c5-b130-6c37f995ee76',
    '77ee933a-884b-5512-84a3-8a74da6e1b28',
    '523be7c2-3db8-5273-a02a-9c840f48bf5f',
    '山村 環菜',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77ee933a-884b-5512-84a3-8a74da6e1b28',
    1,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77ee933a-884b-5512-84a3-8a74da6e1b28',
    2,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77ee933a-884b-5512-84a3-8a74da6e1b28',
    3,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77ee933a-884b-5512-84a3-8a74da6e1b28',
    4,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77ee933a-884b-5512-84a3-8a74da6e1b28',
    5,
    20.0,
    NULL,
    true,
    '(20.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77ee933a-884b-5512-84a3-8a74da6e1b28',
    6,
    22.0,
    NULL,
    true,
    '(22.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77ee933a-884b-5512-84a3-8a74da6e1b28',
    7,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77ee933a-884b-5512-84a3-8a74da6e1b28',
    8,
    22.0,
    NULL,
    true,
    '(22.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77ee933a-884b-5512-84a3-8a74da6e1b28',
    9,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77ee933a-884b-5512-84a3-8a74da6e1b28',
    10,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77ee933a-884b-5512-84a3-8a74da6e1b28',
    11,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77ee933a-884b-5512-84a3-8a74da6e1b28',
    12,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77ee933a-884b-5512-84a3-8a74da6e1b28',
    13,
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
    '43c714fb-3195-5b20-be6f-4ad7c3f1fc91',
    '273c51a6-5102-5da4-aa7b-101fa09fb3be',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '辰野 富志乃',
    'JPN 4',
    'individual',
    16,
    194.0,
    135.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '551604e0-c469-5a2a-9a3c-da8f5aaaae0a',
    '43c714fb-3195-5b20-be6f-4ad7c3f1fc91',
    '273c51a6-5102-5da4-aa7b-101fa09fb3be',
    '辰野 富志乃',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43c714fb-3195-5b20-be6f-4ad7c3f1fc91',
    1,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43c714fb-3195-5b20-be6f-4ad7c3f1fc91',
    2,
    19.0,
    NULL,
    true,
    '(19.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43c714fb-3195-5b20-be6f-4ad7c3f1fc91',
    3,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43c714fb-3195-5b20-be6f-4ad7c3f1fc91',
    4,
    20.0,
    NULL,
    true,
    '(20.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43c714fb-3195-5b20-be6f-4ad7c3f1fc91',
    5,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43c714fb-3195-5b20-be6f-4ad7c3f1fc91',
    6,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43c714fb-3195-5b20-be6f-4ad7c3f1fc91',
    7,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43c714fb-3195-5b20-be6f-4ad7c3f1fc91',
    8,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43c714fb-3195-5b20-be6f-4ad7c3f1fc91',
    9,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43c714fb-3195-5b20-be6f-4ad7c3f1fc91',
    10,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43c714fb-3195-5b20-be6f-4ad7c3f1fc91',
    11,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43c714fb-3195-5b20-be6f-4ad7c3f1fc91',
    12,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43c714fb-3195-5b20-be6f-4ad7c3f1fc91',
    13,
    20.0,
    NULL,
    true,
    '(20.0)'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '3c37d589-bf9b-5124-85f3-6574171fde49',
    '5a69a6ad-12c9-543f-a19d-684d03bb3b27',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '宮沢 ふじ',
    'JPN 2968',
    'individual',
    17,
    196.0,
    139.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5ac0b89d-dd0a-5f3c-8efe-6dce13fe1d77',
    '3c37d589-bf9b-5124-85f3-6574171fde49',
    '5a69a6ad-12c9-543f-a19d-684d03bb3b27',
    '宮沢 ふじ',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c37d589-bf9b-5124-85f3-6574171fde49',
    1,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c37d589-bf9b-5124-85f3-6574171fde49',
    2,
    20.0,
    NULL,
    true,
    '(20.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c37d589-bf9b-5124-85f3-6574171fde49',
    3,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c37d589-bf9b-5124-85f3-6574171fde49',
    4,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c37d589-bf9b-5124-85f3-6574171fde49',
    5,
    18.0,
    NULL,
    true,
    '(18.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c37d589-bf9b-5124-85f3-6574171fde49',
    6,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c37d589-bf9b-5124-85f3-6574171fde49',
    7,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c37d589-bf9b-5124-85f3-6574171fde49',
    8,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c37d589-bf9b-5124-85f3-6574171fde49',
    9,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c37d589-bf9b-5124-85f3-6574171fde49',
    10,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c37d589-bf9b-5124-85f3-6574171fde49',
    11,
    19.0,
    NULL,
    true,
    '(19.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c37d589-bf9b-5124-85f3-6574171fde49',
    12,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3c37d589-bf9b-5124-85f3-6574171fde49',
    13,
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
    '2b0c6342-9fb0-5f1e-bf2e-5110ea76d124',
    'a23a1b3d-fb0a-51b1-b886-ba4f9629bd3f',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '⻆谷 京香',
    'JPN 3320',
    'individual',
    18,
    208.0,
    146.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '12f9886c-1336-5dd2-bba3-8ed859f95807',
    '2b0c6342-9fb0-5f1e-bf2e-5110ea76d124',
    'a23a1b3d-fb0a-51b1-b886-ba4f9629bd3f',
    '⻆谷 京香',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b0c6342-9fb0-5f1e-bf2e-5110ea76d124',
    1,
    20.0,
    NULL,
    true,
    '(20.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b0c6342-9fb0-5f1e-bf2e-5110ea76d124',
    2,
    22.0,
    NULL,
    true,
    '(22.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b0c6342-9fb0-5f1e-bf2e-5110ea76d124',
    3,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b0c6342-9fb0-5f1e-bf2e-5110ea76d124',
    4,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b0c6342-9fb0-5f1e-bf2e-5110ea76d124',
    5,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b0c6342-9fb0-5f1e-bf2e-5110ea76d124',
    6,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b0c6342-9fb0-5f1e-bf2e-5110ea76d124',
    7,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b0c6342-9fb0-5f1e-bf2e-5110ea76d124',
    8,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b0c6342-9fb0-5f1e-bf2e-5110ea76d124',
    9,
    20.0,
    NULL,
    true,
    '(20.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b0c6342-9fb0-5f1e-bf2e-5110ea76d124',
    10,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b0c6342-9fb0-5f1e-bf2e-5110ea76d124',
    11,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b0c6342-9fb0-5f1e-bf2e-5110ea76d124',
    12,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2b0c6342-9fb0-5f1e-bf2e-5110ea76d124',
    13,
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
    'c5ebbff1-405f-5443-abce-50ef9fdafd38',
    'cbfe767f-5bf4-536b-8c84-e2c92b6e3bc9',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '行本 ひかり',
    'JPN 2597',
    'individual',
    19,
    209.0,
    148.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9aa37579-c68b-5516-b10a-4f03379b70c0',
    'c5ebbff1-405f-5443-abce-50ef9fdafd38',
    'cbfe767f-5bf4-536b-8c84-e2c92b6e3bc9',
    '行本 ひかり',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5ebbff1-405f-5443-abce-50ef9fdafd38',
    1,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5ebbff1-405f-5443-abce-50ef9fdafd38',
    2,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5ebbff1-405f-5443-abce-50ef9fdafd38',
    3,
    19.0,
    NULL,
    true,
    '(19.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5ebbff1-405f-5443-abce-50ef9fdafd38',
    4,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5ebbff1-405f-5443-abce-50ef9fdafd38',
    5,
    21.0,
    NULL,
    true,
    '(21.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5ebbff1-405f-5443-abce-50ef9fdafd38',
    6,
    21.0,
    NULL,
    true,
    '(21.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5ebbff1-405f-5443-abce-50ef9fdafd38',
    7,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5ebbff1-405f-5443-abce-50ef9fdafd38',
    8,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5ebbff1-405f-5443-abce-50ef9fdafd38',
    9,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5ebbff1-405f-5443-abce-50ef9fdafd38',
    10,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5ebbff1-405f-5443-abce-50ef9fdafd38',
    11,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5ebbff1-405f-5443-abce-50ef9fdafd38',
    12,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c5ebbff1-405f-5443-abce-50ef9fdafd38',
    13,
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
    'd5444412-5780-5408-81fc-a1949e5b3414',
    'f9a8e58b-5d02-5cdf-9b89-3b53f305c6d5',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '佐藤 旭',
    'JPN 3189',
    'individual',
    20,
    226.0,
    162.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c29f9c63-a404-56bf-916a-0d4249c0ac70',
    'd5444412-5780-5408-81fc-a1949e5b3414',
    'f9a8e58b-5d02-5cdf-9b89-3b53f305c6d5',
    '佐藤 旭',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5444412-5780-5408-81fc-a1949e5b3414',
    1,
    21.0,
    NULL,
    true,
    '(21.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5444412-5780-5408-81fc-a1949e5b3414',
    2,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5444412-5780-5408-81fc-a1949e5b3414',
    3,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5444412-5780-5408-81fc-a1949e5b3414',
    4,
    22.0,
    NULL,
    true,
    '(22.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5444412-5780-5408-81fc-a1949e5b3414',
    5,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5444412-5780-5408-81fc-a1949e5b3414',
    6,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5444412-5780-5408-81fc-a1949e5b3414',
    7,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5444412-5780-5408-81fc-a1949e5b3414',
    8,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5444412-5780-5408-81fc-a1949e5b3414',
    9,
    21.0,
    NULL,
    true,
    '(21.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5444412-5780-5408-81fc-a1949e5b3414',
    10,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5444412-5780-5408-81fc-a1949e5b3414',
    11,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5444412-5780-5408-81fc-a1949e5b3414',
    12,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd5444412-5780-5408-81fc-a1949e5b3414',
    13,
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
    '24694880-e151-5adf-9d87-ace671cbf532',
    '36a84a18-97ca-56cc-88cf-5305436e68e2',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '村田 英波',
    'JPN 3057',
    'individual',
    21,
    231.0,
    166.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bf21819f-805d-538c-950c-9a2119d5899c',
    '24694880-e151-5adf-9d87-ace671cbf532',
    '36a84a18-97ca-56cc-88cf-5305436e68e2',
    '村田 英波',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '24694880-e151-5adf-9d87-ace671cbf532',
    1,
    22.0,
    NULL,
    true,
    '(22.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '24694880-e151-5adf-9d87-ace671cbf532',
    2,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '24694880-e151-5adf-9d87-ace671cbf532',
    3,
    22.0,
    NULL,
    true,
    '(22.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '24694880-e151-5adf-9d87-ace671cbf532',
    4,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '24694880-e151-5adf-9d87-ace671cbf532',
    5,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '24694880-e151-5adf-9d87-ace671cbf532',
    6,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '24694880-e151-5adf-9d87-ace671cbf532',
    7,
    21.0,
    NULL,
    true,
    '(21.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '24694880-e151-5adf-9d87-ace671cbf532',
    8,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '24694880-e151-5adf-9d87-ace671cbf532',
    9,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '24694880-e151-5adf-9d87-ace671cbf532',
    10,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '24694880-e151-5adf-9d87-ace671cbf532',
    11,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '24694880-e151-5adf-9d87-ace671cbf532',
    12,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '24694880-e151-5adf-9d87-ace671cbf532',
    13,
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
    '63ad98f4-687c-5478-b75a-2a4a14fef99b',
    'a25ae618-37b6-5d86-9487-3b4b799d8687',
    'b2058708-09e8-531a-9742-da388e9dfa85',
    '堀内 碧渡',
    'JPN 3259',
    'individual',
    22,
    256.0,
    187.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link',
    '第44回リビエラカップ東日本OP選手権 OP級 Bクラス 成績',
    'pdf',
    'Official final results from Kanto JODA 44th Riviera Cup East Japan OP Championship, Enoshima. Recorded 2026/8/23 15:57.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8a846b91-0741-5a84-a572-ba6ac3499c8b',
    '63ad98f4-687c-5478-b75a-2a4a14fef99b',
    'a25ae618-37b6-5d86-9487-3b4b799d8687',
    '堀内 碧渡',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63ad98f4-687c-5478-b75a-2a4a14fef99b',
    1,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63ad98f4-687c-5478-b75a-2a4a14fef99b',
    2,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63ad98f4-687c-5478-b75a-2a4a14fef99b',
    3,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63ad98f4-687c-5478-b75a-2a4a14fef99b',
    4,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63ad98f4-687c-5478-b75a-2a4a14fef99b',
    5,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63ad98f4-687c-5478-b75a-2a4a14fef99b',
    6,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63ad98f4-687c-5478-b75a-2a4a14fef99b',
    7,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63ad98f4-687c-5478-b75a-2a4a14fef99b',
    8,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63ad98f4-687c-5478-b75a-2a4a14fef99b',
    9,
    23.0,
    'DNC',
    true,
    '(23.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63ad98f4-687c-5478-b75a-2a4a14fef99b',
    10,
    23.0,
    'DNC',
    true,
    '(23.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63ad98f4-687c-5478-b75a-2a4a14fef99b',
    11,
    23.0,
    'DNC',
    true,
    '(23.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63ad98f4-687c-5478-b75a-2a4a14fef99b',
    12,
    23.0,
    'DNC',
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63ad98f4-687c-5478-b75a-2a4a14fef99b',
    13,
    23.0,
    'DNC',
    false,
    '23.0'
);

-- 7. Admin Change Log
INSERT INTO public.admin_change_log (
    actor_email, action, entity_type, entity_id, entity_label, summary, details, source
) VALUES (
    'admin@sailorpath.com',
    'results.import_official_east_japan_opti_2026',
    'regattas',
    'add537f4-4531-5793-b0db-408493c608c5',
    '44th Riviera Cup East Japan Optimist Championship 2026',
    'Imported official final results from 44th Riviera Cup East Japan Championship (Class A: 87 boats, Class B: 22 boats)',
    '{"fleetSizeA": 87, "racesA": 7, "fleetSizeB": 22, "racesB": 13, "newProfiles": 83, "officialSourceA": "https://drive.google.com/file/d/1kcgvCwiDCK25AoYtC-gYziXl8aqNJ5tM/view?usp=drive_link", "officialSourceB": "https://drive.google.com/file/d/1L8rRvrfohcwM5NrJOGDb_-TdG1Ksgl8z/view?usp=drive_link"}'::jsonb,
    'official-joda-east-import'
);

COMMIT;
