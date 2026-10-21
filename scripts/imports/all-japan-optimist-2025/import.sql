-- Migration 134: Import 57th All Japan Optimist Sailing Championship 2025
-- Event: 第57回全日本オプティミスト級セーリング選手権大会（兼 2026年JODAナショナルチーム第1次選考会）
-- Official Final PDF: https://www.racingrulesofsailing.org/documents/169417
-- Date: 2025-11-20 to 2025-11-24, Nishinomiya, Japan. Fleet: 81 boats, 7 races.

BEGIN;

-- 1. Regatta Event
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, nor_url, schedule_summary, scoring_rules
) VALUES (
    '3a7c6f81-9b14-5d42-8712-4015cbb81925',
    '57th All Japan Optimist Sailing Championship 2025',
    '57th-all-japan-optimist-sailing-championship-2025',
    '2025-11-20',
    '2025-11-24',
    'Shin-Nishinomiya Yacht Harbor, Hyogo, Japan',
    'Japan Optimist Dinghy Association (JODA)',
    '["Optimist"]'::jsonb,
    false,
    true,
    'https://www.racingrulesofsailing.org/documents/167338',
    '7 completed races over 4 scheduled days. Final day abandoned due to light winds; standings through Day 3 confirmed as final.',
    'Low Point System with 1 discard after 7 races.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;

-- 2. Regatta Class Sheet
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name
) VALUES (
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '3a7c6f81-9b14-5d42-8712-4015cbb81925',
    '57th All Japan Optimist Sailing Championship 2025',
    '57th-all-japan-optimist-sailing-championship-2025',
    '2025-11-20',
    '2025-11-24',
    81,
    'Open',
    7,
    'JPN',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Shin-Nishinomiya Yacht Harbor, Hyogo, Japan',
    'Japan Optimist Dinghy Association (JODA)',
    'published',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）'
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count;

-- 3. New Sailor Profiles (66 sailors)
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('80b84cf7-7443-5799-ae95-3ce659637bd4', 'Shoi Fujita', 'opti-jpn-shoi-fujita-3407', 'JPN 3407', 'JPN', 'M', 'B&G兵庫J海洋C')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('51090326-f0c9-5140-8db8-fbe90cbf12d5', 'Aoi Horino', 'opti-jpn-aoi-horino-3432', 'JPN 3432', 'JPN', 'M', 'B&G兵庫J海洋C')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('d5866bfe-8e21-585d-b8e7-2b76cb8feba7', 'Kotami Nakada', 'opti-jpn-kotami-nakada-3446', 'JPN 3446', 'JPN', 'F', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('a7def62a-9cc0-5c4d-a10a-6b8bd2eb3dc4', 'Kotoha Sunaga', 'opti-jpn-kotoha-sunaga-3286', 'JPN 3286', 'JPN', 'F', '湘南JYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('a79fd718-f18f-596a-8548-70605f2b3452', 'Toshitada Higaki', 'opti-jpn-toshitada-higaki-3414', 'JPN 3414', 'JPN', 'M', 'B&G兵庫J海洋C')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('b45c3a55-05b3-50aa-bb37-2731f3f98d4e', 'Shin Genseki', 'opti-jpn-shin-genseki-3444', 'JPN 3444', 'JPN', 'M', '湘南JYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('b24f2640-1c36-50ea-8fa3-243a3a48f08a', 'Rui Kameda', 'opti-jpn-rui-kameda-3474', 'JPN 3474', 'JPN', 'F', '湘南JYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('f328eec8-af48-5826-9ffd-36ba379122c2', 'Yoshiki Higuchi', 'opti-jpn-yoshiki-higuchi-3442', 'JPN 3442', 'JPN', 'M', '湘南JYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('187c0d31-a090-5d29-bcce-7e6d5e120279', 'Yuta Shimizu', 'opti-jpn-yuta-shimizu-3479', 'JPN 3479', 'JPN', 'M', '湘南JYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('b0a725c6-026d-511e-8333-9adde320a379', 'Rino Ishikawa', 'opti-jpn-rino-ishikawa-3488', 'JPN 3488', 'JPN', 'F', 'YJYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('e373e71d-025b-55b0-acf6-ce6dfb8eb06c', 'Yuzuki Yoshioka', 'opti-jpn-yuzuki-yoshioka-3315', 'JPN 3315', 'JPN', 'M', '真野浜SC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('5630e6fd-a5f6-537f-8754-461b642feccd', 'Kengo Yamamoto', 'opti-jpn-kengo-yamamoto-3441', 'JPN 3441', 'JPN', 'M', '博多ﾊｲｸｱｳﾂ JYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('c3777043-8cd8-525e-8a1e-be9d476a4ccc', 'Shunto Sakama', 'opti-jpn-shunto-sakama-3154', 'JPN 3154', 'JPN', 'M', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('ff62d4d8-c48a-587d-ab98-b19b551126cb', 'Futa Iwasaki', 'opti-jpn-futa-iwasaki-3232', 'JPN 3232', 'JPN', 'M', 'B&G高松海洋C')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('823c8645-7014-5734-8a89-0aa2a1739d46', 'Miyu Sakaguchi', 'opti-jpn-miyu-sakaguchi-3415', 'JPN 3415', 'JPN', 'F', '福岡SC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('88a4cc04-e045-553c-8d3e-d4dc02c8b92c', 'Sana Makino', 'opti-jpn-sana-makino-3202', 'JPN 3202', 'JPN', 'F', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('e36afcc6-d8af-589b-88a8-fa608d94a470', 'Haru Inoue', 'opti-jpn-haru-inoue-3439', 'JPN 3439', 'JPN', 'F', 'HSS')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('2e9a2d64-59c9-58e5-93c7-060df21e4417', 'Hayato Imamura', 'opti-jpn-hayato-imamura-3404', 'JPN 3404', 'JPN', 'M', '福岡SC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('2b82f965-5e0d-5063-bb05-b3f1cf099740', 'Kaisei Takeuchi', 'opti-jpn-kaisei-takeuchi-3344', 'JPN 3344', 'JPN', 'M', 'HSS')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('f0bd203e-94f4-5484-8ddf-cbdd19aab450', 'Rento Kasagi', 'opti-jpn-rento-kasagi-3430', 'JPN 3430', 'JPN', 'M', 'B&G別府海洋C')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('c70ced96-bb4c-5869-9d1d-38d1ec05f79f', 'Nagisa Negishi', 'opti-jpn-nagisa-negishi-3169', 'JPN 3169', 'JPN', 'F', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('d9d62a14-21a0-5384-bee0-6e752ec87728', 'Shoma Kizaki', 'opti-jpn-shoma-kizaki-3336', 'JPN 3336', 'JPN', 'M', 'B&GFJYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('99964fca-8cf3-5f2a-ad26-e7b593fc55a2', 'Muneyuki Kanehisa', 'opti-jpn-muneyuki-kanehisa-3281', 'JPN 3281', 'JPN', 'M', 'B&G松山海洋C')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('6e3927aa-a435-5bc6-bb40-867479f8ed5d', 'Tomoko Mizutani', 'opti-jpn-tomoko-mizutani-3041', 'JPN 3041', 'JPN', 'F', '夢の島YC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('de0c3f56-b814-5e6e-9cc0-6759c8dab972', 'Ryusei Ujiie', 'opti-jpn-ryusei-ujiie-3435', 'JPN 3435', 'JPN', 'M', '富山県JYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('091c9564-e25e-5910-9d32-dce8511865aa', 'Jo Ikeda', 'opti-jpn-jo-ikeda-3456', 'JPN 3456', 'JPN', 'M', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('18d31b19-6b63-51b9-b8f5-abdf03d8331e', 'Kenjuro Imai', 'opti-jpn-kenjuro-imai-3210', 'JPN 3210', 'JPN', 'M', 'B&GFJYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('5fd47d5e-bc45-545d-8daa-0cc63bc1c84e', 'Kaho Ando', 'opti-jpn-kaho-ando-3455', 'JPN 3455', 'JPN', 'F', 'B&GFJYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('136afe66-3153-513f-b61e-20a2225c0bfb', 'Toyomi Inoue', 'opti-jpn-toyomi-inoue-3470', 'JPN 3470', 'JPN', 'M', 'HSS')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('1af41791-9ec0-59c0-89d9-36d65f21dc4e', 'Soya Imai', 'opti-jpn-soya-imai-3168', 'JPN 3168', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('234b96c7-73e8-59f9-832d-6d9015917659', 'Taiga Miyatake', 'opti-jpn-taiga-miyatake-3422', 'JPN 3422', 'JPN', 'M', 'HSS')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('d5b1460c-ffb5-5bb9-bd8b-7f4e2c4bfab1', 'Shinano Tatsuno', 'opti-jpn-shinano-tatsuno-3425', 'JPN 3425', 'JPN', 'F', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('659a7737-50cd-5c70-ae0b-7827574aac17', 'Koharu Miyazaki', 'opti-jpn-koharu-miyazaki-3476', 'JPN 3476', 'JPN', 'F', '博多ﾊｲｸｱｳﾂ JYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('c0a8cdf2-00af-5908-bb52-6f52f8d26e21', 'Yuri Kurimoto', 'opti-jpn-yuri-kurimoto-3458', 'JPN 3458', 'JPN', 'M', '和歌山JYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('740ac6c8-3424-579c-900c-73348b365168', 'Haruya Imai', 'opti-jpn-haruya-imai-3467', 'JPN 3467', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('3e685fbd-6579-5195-8537-442cd9a85771', 'Toma Hori', 'opti-jpn-toma-hori-3457', 'JPN 3457', 'JPN', 'M', '和歌山JYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('be617744-2ecc-57fe-b837-85b80ab95e06', 'Tomoharu Shiroishi', 'opti-jpn-tomoharu-shiroishi-3250', 'JPN 3250', 'JPN', 'M', 'B&G高松海洋C')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('640dd123-66d5-5a8a-8a22-e5d4de5d8a35', 'Takumi Kawamoto', 'opti-jpn-takumi-kawamoto-3314', 'JPN 3314', 'JPN', 'M', 'B&G兵庫J海洋C')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('13bd0aab-ee6e-5536-8fb7-836169c66fac', 'Yuki Shiina', 'opti-jpn-yuki-shiina-3448', 'JPN 3448', 'JPN', 'M', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('5f728a1a-6dc6-5da1-a806-0beeb4f3010c', 'Kaito Uchida', 'opti-jpn-kaito-uchida-3288', 'JPN 3288', 'JPN', 'M', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('ad4668e3-78b5-5402-a9a4-7641af07c063', 'Shoma Ito', 'opti-jpn-shoma-ito-3409', 'JPN 3409', 'JPN', 'M', 'チーム江東')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('60fc244e-f889-52e0-bb3b-00e8bedff4d7', 'Yasuhiro Nishimura', 'opti-jpn-yasuhiro-nishimura-3365', 'JPN 3365', 'JPN', 'M', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('b62a8c3f-fdc5-5574-85c1-e0731ba62fda', 'Hanae Tomioka', 'opti-jpn-hanae-tomioka-3211', 'JPN 3211', 'JPN', 'F', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('046f010b-9c1c-5f1a-9646-267d9b5a36a5', 'Yuika Nakayama', 'opti-jpn-yuika-nakayama-3345', 'JPN 3345', 'JPN', 'F', 'サウスSC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('55b10636-fbeb-5102-8b5b-86dd1f1e5ebb', 'Ryohei Sasaki', 'opti-jpn-ryohei-sasaki-3110', 'JPN 3110', 'JPN', 'M', 'B&G高松海洋C')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('1ebfc70d-f150-581f-92fd-df32debbae3e', 'Taiyo Eda', 'opti-jpn-taiyo-eda-2767', 'JPN 2767', 'JPN', 'M', '宮津JYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('67ff3eda-7825-5bbc-ade2-611d292a728e', 'Haruto Morita', 'opti-jpn-haruto-morita-3373', 'JPN 3373', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('1ceeb9fd-977e-5c55-bec1-1a0b14846e1b', 'Jo Hirota', 'opti-jpn-jo-hirota-3395', 'JPN 3395', 'JPN', 'M', '琵琶湖JYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('9c2aa8a7-86d0-5c81-9bef-ba0f0878d944', 'Moe Hirano', 'opti-jpn-moe-hirano-3358', 'JPN 3358', 'JPN', 'F', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('1162e397-e58d-5441-aa38-5189647b190f', 'Taisei Nakamura', 'opti-jpn-taisei-nakamura-3260', 'JPN 3260', 'JPN', 'M', '三重JYYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('c764b218-e565-5b0b-905e-d56b0c7d4a9d', 'Nanako Higaki', 'opti-jpn-nanako-higaki-3434', 'JPN 3434', 'JPN', 'F', 'B&G兵庫J海洋C')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('11621fc9-3a7c-5509-8e01-5a2c92eeca01', 'Sho Nagahori', 'opti-jpn-sho-nagahori-3153', 'JPN 3153', 'JPN', 'M', '中央区JYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('dcd4351e-c984-5c40-bcd0-14f7698e841c', 'Yuka Iwanami', 'opti-jpn-yuka-iwanami-3376', 'JPN 3376', 'JPN', 'F', '個人会員')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('b6d30022-7628-522d-92fe-d63d1199a66b', 'Shoei Tanba', 'opti-jpn-shoei-tanba-3487', 'JPN 3487', 'JPN', 'M', 'EYCJ')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('4c6c867b-dead-5727-b7c7-c79d8a61176f', 'Minami Kamishikiryo', 'opti-jpn-minami-kamishikiryo-3231', 'JPN 3231', 'JPN', 'F', 'YJYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('ed754d7e-169a-587a-9cd6-d8ca4eb79027', 'Hana Nagami', 'opti-jpn-hana-nagami-3417', 'JPN 3417', 'JPN', 'F', '福岡SC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('eaad9ca1-6091-594b-bc28-317b17adff58', 'Yuho Tabuchi', 'opti-jpn-yuho-tabuchi-3486', 'JPN 3486', 'JPN', 'M', 'CYBCJr')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('796c7035-28ea-56c5-ac8f-79f905be0624', 'Yuki Uchida', 'opti-jpn-yuki-uchida-3372', 'JPN 3372', 'JPN', 'F', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('4a8e458e-16cf-50ab-8cfd-db97f4aefca1', 'Yue Moriya', 'opti-jpn-yue-moriya-3340', 'JPN 3340', 'JPN', 'F', '湘南JYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('fdedf2c3-c37c-5c26-866d-0e4f56ceddde', 'Kaisei Imamura', 'opti-jpn-kaisei-imamura-3419', 'JPN 3419', 'JPN', 'M', '福岡SC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('25ac7774-b971-5708-afb2-ce8fed50bbd3', 'Takeru Takahashi', 'opti-jpn-takeru-takahashi-3367', 'JPN 3367', 'JPN', 'M', '海陽海洋 C')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('83945565-f700-5935-81d5-9b7eb94bc968', 'Uta Nakayama', 'opti-jpn-uta-nakayama-3469', 'JPN 3469', 'JPN', 'F', '葉山町SA')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('ed9b204a-47b0-5e95-a72a-c918dde47252', 'Kota Omori', 'opti-jpn-kota-omori-3449', 'JPN 3449', 'JPN', 'M', '宮津JYC')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('7d9cdace-e35e-53e9-b310-81a4e7b95dbb', 'Yuzuki Akimura', 'opti-jpn-yuzuki-akimura-3184', 'JPN 3184', 'JPN', 'F', 'B&G高松海洋C')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('78c986b8-aeb4-536f-83b8-242f45297dc2', 'Ruka Eguchi', 'opti-jpn-ruka-eguchi-3379', 'JPN 3379', 'JPN', 'F', 'B&G新居浜海C')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club)
VALUES ('69a4292e-5d7e-5d91-bd42-df20e0db1a79', 'Taisei Uda', 'opti-jpn-taisei-uda-3371', 'JPN 3371', 'JPN', 'M', '葉山町SA')
ON CONFLICT (id) DO NOTHING;

-- 4. Sailor Aliases (Original Kanji names and variants)
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('80b84cf7-7443-5799-ae95-3ce659637bd4', '藤田 翔伊')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('80b84cf7-7443-5799-ae95-3ce659637bd4', '藤田翔伊')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('51090326-f0c9-5140-8db8-fbe90cbf12d5', '堀野 葵')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('51090326-f0c9-5140-8db8-fbe90cbf12d5', '堀野葵')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6471b3cc-1310-54f1-945c-c06115d54996', '角森 帆朱')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6471b3cc-1310-54f1-945c-c06115d54996', '角森帆朱')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1b5e6155-88c2-4e32-b173-24e6bfa54c1c', '三浦 太輝')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1b5e6155-88c2-4e32-b173-24e6bfa54c1c', '三浦太輝')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d5866bfe-8e21-585d-b8e7-2b76cb8feba7', '中田 琴海')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d5866bfe-8e21-585d-b8e7-2b76cb8feba7', '中田琴海')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a7def62a-9cc0-5c4d-a10a-6b8bd2eb3dc4', '須永 言葉')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a7def62a-9cc0-5c4d-a10a-6b8bd2eb3dc4', '須永言葉')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('28032f7a-8535-431c-a220-cc5a529ebd38', '上條 正弘')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('28032f7a-8535-431c-a220-cc5a529ebd38', '上條正弘')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('eba0deb0-10e4-4d3e-a5e5-5e3fa6287288', '樋口 颯希')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('eba0deb0-10e4-4d3e-a5e5-5e3fa6287288', '樋口颯希')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('89eed0ba-4c8d-49dc-a03e-6624a364f93c', '中村 海翔')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('89eed0ba-4c8d-49dc-a03e-6624a364f93c', '中村海翔')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5890ff0d-ad50-4352-84a0-29135867289a', '川上 渚')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5890ff0d-ad50-4352-84a0-29135867289a', '川上渚')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2780f0eb-ea28-44e6-ba67-22a35fb9913d', '松永 虎汰郎')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2780f0eb-ea28-44e6-ba67-22a35fb9913d', '松永虎汰郎')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a79fd718-f18f-596a-8548-70605f2b3452', '檜垣 俊忠')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('a79fd718-f18f-596a-8548-70605f2b3452', '檜垣俊忠')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b45c3a55-05b3-50aa-bb37-2731f3f98d4e', '源関 新')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b45c3a55-05b3-50aa-bb37-2731f3f98d4e', '源関新')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b24f2640-1c36-50ea-8fa3-243a3a48f08a', '亀田 留衣')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b24f2640-1c36-50ea-8fa3-243a3a48f08a', '亀田留衣')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f328eec8-af48-5826-9ffd-36ba379122c2', '樋口 耀紀')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f328eec8-af48-5826-9ffd-36ba379122c2', '樋口耀紀')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5f6d71a5-1dc3-599c-b9be-377150d4dd3a', '村中 菜々')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5f6d71a5-1dc3-599c-b9be-377150d4dd3a', '村中菜々')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('187c0d31-a090-5d29-bcce-7e6d5e120279', '清水 優太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('187c0d31-a090-5d29-bcce-7e6d5e120279', '清水優太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b0a725c6-026d-511e-8333-9adde320a379', '石川 凛乃')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b0a725c6-026d-511e-8333-9adde320a379', '石川凛乃')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('e373e71d-025b-55b0-acf6-ce6dfb8eb06c', '吉岡 祐月')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('e373e71d-025b-55b0-acf6-ce6dfb8eb06c', '吉岡祐月')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b8f8b747-639d-5920-adfe-ec84e34cc40b', '平野 陽也')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b8f8b747-639d-5920-adfe-ec84e34cc40b', '平野陽也')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5630e6fd-a5f6-537f-8754-461b642feccd', '山本 健瑚')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5630e6fd-a5f6-537f-8754-461b642feccd', '山本健瑚')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('3d7d17df-71ad-4195-b41d-abdebbed13bc', '村中 莉子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('3d7d17df-71ad-4195-b41d-abdebbed13bc', '村中莉子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c3777043-8cd8-525e-8a1e-be9d476a4ccc', '阪間 俊仁')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c3777043-8cd8-525e-8a1e-be9d476a4ccc', '阪間俊仁')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('18e73ee3-3792-59f9-aa32-649ca6ca325d', '登田 直')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('18e73ee3-3792-59f9-aa32-649ca6ca325d', '登田直')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1ac9dc89-783e-56c9-8c8d-785a5e10cccc', '山田 晟')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1ac9dc89-783e-56c9-8c8d-785a5e10cccc', '山田晟')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('0c3ea04a-905c-45f1-abb7-a4a917e7da14', '久保田 夏実')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('0c3ea04a-905c-45f1-abb7-a4a917e7da14', '久保田夏実')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ff62d4d8-c48a-587d-ab98-b19b551126cb', '岩﨑 楓太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ff62d4d8-c48a-587d-ab98-b19b551126cb', '岩﨑楓太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('823c8645-7014-5734-8a89-0aa2a1739d46', '坂口 美結')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('823c8645-7014-5734-8a89-0aa2a1739d46', '坂口美結')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('88a4cc04-e045-553c-8d3e-d4dc02c8b92c', '牧野 紗奈')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('88a4cc04-e045-553c-8d3e-d4dc02c8b92c', '牧野紗奈')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('e36afcc6-d8af-589b-88a8-fa608d94a470', '井上 はる')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('e36afcc6-d8af-589b-88a8-fa608d94a470', '井上はる')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('3d6c3a59-ea5b-5d31-a9eb-c4db5a510958', '直井 舷太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('3d6c3a59-ea5b-5d31-a9eb-c4db5a510958', '直井舷太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2e9a2d64-59c9-58e5-93c7-060df21e4417', '今村 颯人')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2e9a2d64-59c9-58e5-93c7-060df21e4417', '今村颯人')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2b82f965-5e0d-5063-bb05-b3f1cf099740', '竹内 海聖')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2b82f965-5e0d-5063-bb05-b3f1cf099740', '竹内海聖')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f0bd203e-94f4-5484-8ddf-cbdd19aab450', '笠木 蓮斗')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f0bd203e-94f4-5484-8ddf-cbdd19aab450', '笠木蓮斗')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c70ced96-bb4c-5869-9d1d-38d1ec05f79f', '根岸 渚沙')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c70ced96-bb4c-5869-9d1d-38d1ec05f79f', '根岸渚沙')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d9d62a14-21a0-5384-bee0-6e752ec87728', '木﨑 翔嶋')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d9d62a14-21a0-5384-bee0-6e752ec87728', '木﨑翔嶋')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('99964fca-8cf3-5f2a-ad26-e7b593fc55a2', '兼久 宗之')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('99964fca-8cf3-5f2a-ad26-e7b593fc55a2', '兼久宗之')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6e3927aa-a435-5bc6-bb40-867479f8ed5d', '水谷 智子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('6e3927aa-a435-5bc6-bb40-867479f8ed5d', '水谷智子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('de0c3f56-b814-5e6e-9cc0-6759c8dab972', '氏家 琉星')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('de0c3f56-b814-5e6e-9cc0-6759c8dab972', '氏家琉星')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('091c9564-e25e-5910-9d32-dce8511865aa', '池田 晟')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('091c9564-e25e-5910-9d32-dce8511865aa', '池田晟')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('18d31b19-6b63-51b9-b8f5-abdf03d8331e', '今井 堅朱朗')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('18d31b19-6b63-51b9-b8f5-abdf03d8331e', '今井堅朱朗')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5fd47d5e-bc45-545d-8daa-0cc63bc1c84e', '安藤 果帆')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5fd47d5e-bc45-545d-8daa-0cc63bc1c84e', '安藤果帆')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('136afe66-3153-513f-b61e-20a2225c0bfb', '井上 豊海')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('136afe66-3153-513f-b61e-20a2225c0bfb', '井上豊海')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1af41791-9ec0-59c0-89d9-36d65f21dc4e', '今井 創也')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1af41791-9ec0-59c0-89d9-36d65f21dc4e', '今井創也')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('234b96c7-73e8-59f9-832d-6d9015917659', '宮武 大我')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('234b96c7-73e8-59f9-832d-6d9015917659', '宮武大我')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d5b1460c-ffb5-5bb9-bd8b-7f4e2c4bfab1', '辰野 志奈乃')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d5b1460c-ffb5-5bb9-bd8b-7f4e2c4bfab1', '辰野志奈乃')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('659a7737-50cd-5c70-ae0b-7827574aac17', '宮﨑 心桜')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('659a7737-50cd-5c70-ae0b-7827574aac17', '宮﨑心桜')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c0a8cdf2-00af-5908-bb52-6f52f8d26e21', '栗本 悠里')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c0a8cdf2-00af-5908-bb52-6f52f8d26e21', '栗本悠里')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('740ac6c8-3424-579c-900c-73348b365168', '今井 晴也')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('740ac6c8-3424-579c-900c-73348b365168', '今井晴也')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('3e685fbd-6579-5195-8537-442cd9a85771', '堀 冬馬')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('3e685fbd-6579-5195-8537-442cd9a85771', '堀冬馬')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('be617744-2ecc-57fe-b837-85b80ab95e06', '城石 朋春')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('be617744-2ecc-57fe-b837-85b80ab95e06', '城石朋春')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('640dd123-66d5-5a8a-8a22-e5d4de5d8a35', '川本 拓実')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('640dd123-66d5-5a8a-8a22-e5d4de5d8a35', '川本拓実')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('8e182f64-ea94-4254-9ae3-b4611981dc3b', '平澤 海翔')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('8e182f64-ea94-4254-9ae3-b4611981dc3b', '平澤海翔')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('13bd0aab-ee6e-5536-8fb7-836169c66fac', '椎名 悠貴')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('13bd0aab-ee6e-5536-8fb7-836169c66fac', '椎名悠貴')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5f728a1a-6dc6-5da1-a806-0beeb4f3010c', '内田 海音')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('5f728a1a-6dc6-5da1-a806-0beeb4f3010c', '内田海音')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ad4668e3-78b5-5402-a9a4-7641af07c063', '伊藤 照真')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ad4668e3-78b5-5402-a9a4-7641af07c063', '伊藤照真')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('60fc244e-f889-52e0-bb3b-00e8bedff4d7', '西村 泰洋')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('60fc244e-f889-52e0-bb3b-00e8bedff4d7', '西村泰洋')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b62a8c3f-fdc5-5574-85c1-e0731ba62fda', '富岡 英恵')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b62a8c3f-fdc5-5574-85c1-e0731ba62fda', '富岡英恵')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('046f010b-9c1c-5f1a-9646-267d9b5a36a5', '仲山 結夏')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('046f010b-9c1c-5f1a-9646-267d9b5a36a5', '仲山結夏')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('55b10636-fbeb-5102-8b5b-86dd1f1e5ebb', '佐々木 椋平')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('55b10636-fbeb-5102-8b5b-86dd1f1e5ebb', '佐々木椋平')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1ebfc70d-f150-581f-92fd-df32debbae3e', '枝 大耀')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1ebfc70d-f150-581f-92fd-df32debbae3e', '枝大耀')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('67ff3eda-7825-5bbc-ade2-611d292a728e', '森田 晴翔')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('67ff3eda-7825-5bbc-ade2-611d292a728e', '森田晴翔')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1ceeb9fd-977e-5c55-bec1-1a0b14846e1b', '廣田 穣')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1ceeb9fd-977e-5c55-bec1-1a0b14846e1b', '廣田穣')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('9c2aa8a7-86d0-5c81-9bef-ba0f0878d944', '平野 萌生')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('9c2aa8a7-86d0-5c81-9bef-ba0f0878d944', '平野萌生')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1162e397-e58d-5441-aa38-5189647b190f', '中村 太晴')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1162e397-e58d-5441-aa38-5189647b190f', '中村太晴')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c764b218-e565-5b0b-905e-d56b0c7d4a9d', '檜垣 菜々子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c764b218-e565-5b0b-905e-d56b0c7d4a9d', '檜垣菜々子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('11621fc9-3a7c-5509-8e01-5a2c92eeca01', '長堀 奨')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('11621fc9-3a7c-5509-8e01-5a2c92eeca01', '長堀奨')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('dcd4351e-c984-5c40-bcd0-14f7698e841c', '岩波 由夏')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('dcd4351e-c984-5c40-bcd0-14f7698e841c', '岩波由夏')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b6d30022-7628-522d-92fe-d63d1199a66b', '丹波 翔叡')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b6d30022-7628-522d-92fe-d63d1199a66b', '丹波翔叡')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('4c6c867b-dead-5727-b7c7-c79d8a61176f', '上敷領 美海')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('4c6c867b-dead-5727-b7c7-c79d8a61176f', '上敷領美海')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ed754d7e-169a-587a-9cd6-d8ca4eb79027', '永見 波奈')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ed754d7e-169a-587a-9cd6-d8ca4eb79027', '永見波奈')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('eaad9ca1-6091-594b-bc28-317b17adff58', '田淵 勇帆')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('eaad9ca1-6091-594b-bc28-317b17adff58', '田淵勇帆')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('796c7035-28ea-56c5-ac8f-79f905be0624', '内田 有希')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('796c7035-28ea-56c5-ac8f-79f905be0624', '内田有希')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('4a8e458e-16cf-50ab-8cfd-db97f4aefca1', '守屋 由慧')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('4a8e458e-16cf-50ab-8cfd-db97f4aefca1', '守屋由慧')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('fdedf2c3-c37c-5c26-866d-0e4f56ceddde', '今村 海晴')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('fdedf2c3-c37c-5c26-866d-0e4f56ceddde', '今村海晴')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('25ac7774-b971-5708-afb2-ce8fed50bbd3', '高橋 武尊')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('25ac7774-b971-5708-afb2-ce8fed50bbd3', '高橋武尊')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('83945565-f700-5935-81d5-9b7eb94bc968', '中山 うた')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('83945565-f700-5935-81d5-9b7eb94bc968', '中山うた')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ed9b204a-47b0-5e95-a72a-c918dde47252', '大森 康太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ed9b204a-47b0-5e95-a72a-c918dde47252', '大森康太')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('7d9cdace-e35e-53e9-b310-81a4e7b95dbb', '秋村 柚月')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('7d9cdace-e35e-53e9-b310-81a4e7b95dbb', '秋村柚月')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('78c986b8-aeb4-536f-83b8-242f45297dc2', '江口 瑠海')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('78c986b8-aeb4-536f-83b8-242f45297dc2', '江口瑠海')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('69a4292e-5d7e-5d91-bd42-df20e0db1a79', '宇多 泰誠')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('69a4292e-5d7e-5d91-bd42-df20e0db1a79', '宇多泰誠')
ON CONFLICT (alias_name) DO NOTHING;

-- 5. Regatta Results (81 individual rows)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '4d7932e3-c7ef-5118-90d3-921865427f5d',
    '80b84cf7-7443-5799-ae95-3ce659637bd4',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '藤田 翔伊',
    'JPN 3407',
    'individual',
    1,
    14.0,
    9.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '6051d6b1-3596-5f89-baf1-e62897afdf61',
    '51090326-f0c9-5140-8db8-fbe90cbf12d5',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '堀野 葵',
    'JPN 3432',
    'individual',
    2,
    37.0,
    25.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'ea782a9b-1451-5e81-a70e-efe833f8ec06',
    '6471b3cc-1310-54f1-945c-c06115d54996',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '角森 帆朱',
    'JPN 3355',
    'individual',
    3,
    83.0,
    46.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'adfb849b-d244-5360-907d-45f99ce3a733',
    '1b5e6155-88c2-4e32-b173-24e6bfa54c1c',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '三浦 太輝',
    'JPN 3447',
    'individual',
    4,
    66.0,
    51.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'ad9c06e4-b8a4-5e4e-ae4c-8da13fe420dd',
    'd5866bfe-8e21-585d-b8e7-2b76cb8feba7',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '中田 琴海',
    'JPN 3446',
    'individual',
    5,
    95.0,
    57.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '67d0d259-a3e1-5122-acb0-e31f14782133',
    'a7def62a-9cc0-5c4d-a10a-6b8bd2eb3dc4',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '須永 言葉',
    'JPN 3286',
    'individual',
    6,
    96.0,
    70.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'e4113492-6588-544c-9b14-808ffc58a2f8',
    '28032f7a-8535-431c-a220-cc5a529ebd38',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '上條 正弘',
    'JPN 3440',
    'individual',
    7,
    117.0,
    78.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '43ebb342-d0cc-5e5b-a4fe-37a10b03b75a',
    'eba0deb0-10e4-4d3e-a5e5-5e3fa6287288',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '樋口 颯希',
    'JPN 3443',
    'individual',
    8,
    142.0,
    90.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '3da88211-9bae-58a2-8f6f-dc530e3977c1',
    '89eed0ba-4c8d-49dc-a03e-6624a364f93c',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '中村 海翔',
    'JPN 3389',
    'individual',
    9,
    124.0,
    92.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'fa3dc4b7-b0e2-56c4-bcf6-d961e2bc73a9',
    '5890ff0d-ad50-4352-84a0-29135867289a',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '川上 渚',
    'JPN 3462',
    'individual',
    10,
    129.0,
    96.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'f984179f-9e50-5a9b-975f-7d62635f0ea4',
    '2780f0eb-ea28-44e6-ba67-22a35fb9913d',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '松永 虎汰郎',
    'JPN 3351',
    'individual',
    11,
    159.0,
    105.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '3034dde0-060f-5032-b460-198aa46b196b',
    'a79fd718-f18f-596a-8548-70605f2b3452',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '檜垣 俊忠',
    'JPN 3414',
    'individual',
    12,
    145.0,
    106.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '3eaeb5ed-f5ec-525c-a362-28a760942eba',
    'b45c3a55-05b3-50aa-bb37-2731f3f98d4e',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '源関 新',
    'JPN 3444',
    'individual',
    13,
    140.0,
    109.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'ab9bdb75-acf5-5449-8ea7-d980f7395371',
    'b24f2640-1c36-50ea-8fa3-243a3a48f08a',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '亀田 留衣',
    'JPN 3474',
    'individual',
    14,
    160.0,
    110.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '28bef6f8-3136-56d0-8429-e6f2da097643',
    'f328eec8-af48-5826-9ffd-36ba379122c2',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '樋口 耀紀',
    'JPN 3442',
    'individual',
    15,
    185.0,
    113.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '3df572ae-0419-5bab-8943-da607d6b3c57',
    '5f6d71a5-1dc3-599c-b9be-377150d4dd3a',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '村中 菜々',
    'JPN 3178',
    'individual',
    16,
    162.0,
    117.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '6433e3a5-2d2b-5a93-943b-e6d60dfd8f56',
    '187c0d31-a090-5d29-bcce-7e6d5e120279',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '清水 優太',
    'JPN 3479',
    'individual',
    17,
    164.0,
    122.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'c84bef28-d2a8-555f-9ab1-5ae7e9915aec',
    'b0a725c6-026d-511e-8333-9adde320a379',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '石川 凛乃',
    'JPN 3488',
    'individual',
    18,
    187.0,
    123.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'a215d4db-525c-516a-839f-4151d76dc13f',
    'e373e71d-025b-55b0-acf6-ce6dfb8eb06c',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '吉岡 祐月',
    'JPN 3315',
    'individual',
    19,
    201.0,
    132.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '037882eb-4bcc-5a30-9c1b-0e2c66402ac3',
    'b8f8b747-639d-5920-adfe-ec84e34cc40b',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '平野 陽也',
    'JPN 3337',
    'individual',
    20,
    203.0,
    133.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '5483c4dc-34b8-5307-9112-9ef5a1733af2',
    '5630e6fd-a5f6-537f-8754-461b642feccd',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '山本 健瑚',
    'JPN 3441',
    'individual',
    21,
    202.0,
    142.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '77e59a85-0a78-5101-bc60-0ba5225c80d7',
    '3d7d17df-71ad-4195-b41d-abdebbed13bc',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '村中 莉子',
    'JPN 3356',
    'individual',
    22,
    226.0,
    144.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'ec348d04-42b4-5ea3-b2fd-f6568dc88d2a',
    'c3777043-8cd8-525e-8a1e-be9d476a4ccc',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '阪間 俊仁',
    'JPN 3154',
    'individual',
    23,
    205.0,
    145.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '02ca02c4-34e1-52fd-8463-3142368a2d52',
    '18e73ee3-3792-59f9-aa32-649ca6ca325d',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '登田 直',
    'JPN 3423',
    'individual',
    24,
    225.6,
    149.6,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'c4f7a630-887f-5ffa-aea0-a95e156386e3',
    '1ac9dc89-783e-56c9-8c8d-785a5e10cccc',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '山田 晟',
    'JPN 3394',
    'individual',
    25,
    201.0,
    151.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'ca5efe5b-9f97-5216-9a66-5ae9a659e631',
    '0c3ea04a-905c-45f1-abb7-a4a917e7da14',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '久保田 夏実',
    'JPN 3375',
    'individual',
    26,
    204.0,
    161.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'aacc29fe-93f2-5495-9c5d-df23a535b2d3',
    'ff62d4d8-c48a-587d-ab98-b19b551126cb',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '岩﨑 楓太',
    'JPN 3232',
    'individual',
    27,
    217.0,
    161.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '1a206536-c6fd-5a0e-91d3-3f1e6693b3c2',
    '823c8645-7014-5734-8a89-0aa2a1739d46',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '坂口 美結',
    'JPN 3415',
    'individual',
    28,
    241.0,
    172.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '1845d89e-f34b-5345-9644-c32908795169',
    '88a4cc04-e045-553c-8d3e-d4dc02c8b92c',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '牧野 紗奈',
    'JPN 3202',
    'individual',
    29,
    246.0,
    173.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '2bca9113-a5b0-5576-b3c2-6c11db63cc28',
    'e36afcc6-d8af-589b-88a8-fa608d94a470',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '井上 はる',
    'JPN 3439',
    'individual',
    30,
    249.0,
    179.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '515d4bfb-66e6-5ce1-af36-ae4e62e8ea99',
    '3d6c3a59-ea5b-5d31-a9eb-c4db5a510958',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '直井 舷太',
    'JPN 3253',
    'individual',
    31,
    262.0,
    182.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '037bd687-a35b-5b9b-b7d6-3ee0d3627d4c',
    '2e9a2d64-59c9-58e5-93c7-060df21e4417',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '今村 颯人',
    'JPN 3404',
    'individual',
    32,
    270.0,
    188.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '33c34af4-38e1-51a1-891c-0c6be8fe4aa9',
    '2b82f965-5e0d-5063-bb05-b3f1cf099740',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '竹内 海聖',
    'JPN 3344',
    'individual',
    33,
    256.0,
    195.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'e60e967c-d55e-5bff-98cd-42c9d464fd55',
    'f0bd203e-94f4-5484-8ddf-cbdd19aab450',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '笠木 蓮斗',
    'JPN 3430',
    'individual',
    34,
    278.0,
    196.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '3251d780-5d5b-5903-b8c1-9ce65ddde61a',
    'c70ced96-bb4c-5869-9d1d-38d1ec05f79f',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '根岸 渚沙',
    'JPN 3169',
    'individual',
    35,
    285.0,
    210.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'b5185ab8-a95d-580b-ab6e-f9282a0a122b',
    'd9d62a14-21a0-5384-bee0-6e752ec87728',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '木﨑 翔嶋',
    'JPN 3336',
    'individual',
    36,
    301.0,
    219.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '1f511ef9-60b6-5072-ba73-d484b467e706',
    '99964fca-8cf3-5f2a-ad26-e7b593fc55a2',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '兼久 宗之',
    'JPN 3281',
    'individual',
    37,
    306.0,
    224.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '8e437246-030d-50f4-b254-ddcd1d1cc751',
    '6e3927aa-a435-5bc6-bb40-867479f8ed5d',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '水谷 智子',
    'JPN 3041',
    'individual',
    38,
    293.0,
    227.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'bf6a9a1d-6449-50db-8c78-6bf5905f95cf',
    'de0c3f56-b814-5e6e-9cc0-6759c8dab972',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '氏家 琉星',
    'JPN 3435',
    'individual',
    39,
    298.0,
    230.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '29274e5a-54db-567e-9b8a-e57712e5aa05',
    '091c9564-e25e-5910-9d32-dce8511865aa',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '池田 晟',
    'JPN 3456',
    'individual',
    40,
    276.0,
    230.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '3e98da1d-0cf5-5607-9abe-c8a1bc823b15',
    '18d31b19-6b63-51b9-b8f5-abdf03d8331e',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '今井 堅朱朗',
    'JPN 3210',
    'individual',
    41,
    310.0,
    235.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '20f8bdd0-6116-561f-a8dc-abeceb3ed58f',
    '5fd47d5e-bc45-545d-8daa-0cc63bc1c84e',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '安藤 果帆',
    'JPN 3455',
    'individual',
    42,
    302.0,
    237.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '9d2c4d94-07d4-5d23-bf53-16f0ea91cd2e',
    '136afe66-3153-513f-b61e-20a2225c0bfb',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '井上 豊海',
    'JPN 3470',
    'individual',
    43,
    303.0,
    243.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '5f37073b-dead-5c88-9474-b30124be1b1a',
    '1af41791-9ec0-59c0-89d9-36d65f21dc4e',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '今井 創也',
    'JPN 3168',
    'individual',
    44,
    320.0,
    247.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'cde1b0fb-bc4a-52c1-b502-a6119fb4e3b1',
    '234b96c7-73e8-59f9-832d-6d9015917659',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '宮武 大我',
    'JPN 3422',
    'individual',
    45,
    321.0,
    248.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'cd9bad9b-5ccb-5f43-80e7-7f68ade00028',
    'd5b1460c-ffb5-5bb9-bd8b-7f4e2c4bfab1',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '辰野 志奈乃',
    'JPN 3425',
    'individual',
    46,
    326.0,
    252.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'df3e5978-696d-58bf-9c50-2db2866db8c7',
    '659a7737-50cd-5c70-ae0b-7827574aac17',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '宮﨑 心桜',
    'JPN 3476',
    'individual',
    47,
    333.0,
    255.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '739c0a68-3bdf-5907-8a72-5988b051236f',
    'c0a8cdf2-00af-5908-bb52-6f52f8d26e21',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '栗本 悠里',
    'JPN 3458',
    'individual',
    48,
    322.0,
    257.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '34743a77-415b-52ba-808a-f288f3084506',
    '740ac6c8-3424-579c-900c-73348b365168',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '今井 晴也',
    'JPN 3467',
    'individual',
    49,
    321.0,
    258.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '832003a1-58cc-52cc-931c-6c4d1509dc4f',
    '3e685fbd-6579-5195-8537-442cd9a85771',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '堀 冬馬',
    'JPN 3457',
    'individual',
    50,
    329.0,
    261.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '2e9c5bbe-8578-5aca-96d3-31ffae60e5c6',
    'be617744-2ecc-57fe-b837-85b80ab95e06',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '城石 朋春',
    'JPN 3250',
    'individual',
    51,
    331.0,
    263.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '28702a61-b612-57b6-8888-8bd7a84d429c',
    '640dd123-66d5-5a8a-8a22-e5d4de5d8a35',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '川本 拓実',
    'JPN 3314',
    'individual',
    52,
    338.0,
    266.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'b0842a37-346a-5357-b077-c31bc0cd467b',
    '8e182f64-ea94-4254-9ae3-b4611981dc3b',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '平澤 海翔',
    'JPN 3411',
    'individual',
    53,
    348.0,
    266.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'ee6edf45-c30b-50ab-869e-b3d60d86705d',
    '13bd0aab-ee6e-5536-8fb7-836169c66fac',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '椎名 悠貴',
    'JPN 3448',
    'individual',
    54,
    357.0,
    275.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '7f880b35-9105-5d32-81c2-3f707be3ee6a',
    '5f728a1a-6dc6-5da1-a806-0beeb4f3010c',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '内田 海音',
    'JPN 3288',
    'individual',
    55,
    344.0,
    279.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '33efc76e-d10d-54dc-bfec-7d92b98126d2',
    'ad4668e3-78b5-5402-a9a4-7641af07c063',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '伊藤 照真',
    'JPN 3409',
    'individual',
    56,
    359.0,
    285.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'fb5f2cf5-bf59-51b0-af96-2ccfdce1b30c',
    '60fc244e-f889-52e0-bb3b-00e8bedff4d7',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '西村 泰洋',
    'JPN 3365',
    'individual',
    57,
    348.0,
    290.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'b4a3cff9-2385-5e8e-8bf7-c754fe8af683',
    'b62a8c3f-fdc5-5574-85c1-e0731ba62fda',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '富岡 英恵',
    'JPN 3211',
    'individual',
    58,
    356.0,
    295.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'b11e030d-6a96-5fa9-8eb4-c3ad485e13e4',
    '046f010b-9c1c-5f1a-9646-267d9b5a36a5',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '仲山 結夏',
    'JPN 3345',
    'individual',
    59,
    379.0,
    301.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '3b1c86b3-9b31-5316-b9e0-761c1b431719',
    '55b10636-fbeb-5102-8b5b-86dd1f1e5ebb',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '佐々木 椋平',
    'JPN 3110',
    'individual',
    60,
    373.0,
    302.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '9a090e69-f62f-5aa8-a194-ab7dcc991c9d',
    '1ebfc70d-f150-581f-92fd-df32debbae3e',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '枝 大耀',
    'JPN 2767',
    'individual',
    61,
    386.0,
    308.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '01780e22-9d5d-5910-996f-63c42528a929',
    '67ff3eda-7825-5bbc-ade2-611d292a728e',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '森田 晴翔',
    'JPN 3373',
    'individual',
    62,
    385.0,
    312.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '93bac8b3-9b6c-504d-8847-c7aeced3f6fd',
    '1ceeb9fd-977e-5c55-bec1-1a0b14846e1b',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '廣田 穣',
    'JPN 3395',
    'individual',
    63,
    394.0,
    317.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'aba52ef2-8c84-5046-a245-8cca33105056',
    '9c2aa8a7-86d0-5c81-9bef-ba0f0878d944',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '平野 萌生',
    'JPN 3358',
    'individual',
    64,
    388.0,
    317.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '6e40c41b-c4b9-5fa5-8034-d70f11cff1aa',
    '1162e397-e58d-5441-aa38-5189647b190f',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '中村 太晴',
    'JPN 3260',
    'individual',
    65,
    399.0,
    319.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '5d7e566d-188b-5f49-8ff8-d7d8a55aba16',
    'c764b218-e565-5b0b-905e-d56b0c7d4a9d',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '檜垣 菜々子',
    'JPN 3434',
    'individual',
    66,
    391.0,
    320.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'a2a9edde-ffae-57e6-9bb7-c1cddfaac214',
    '11621fc9-3a7c-5509-8e01-5a2c92eeca01',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '長堀 奨',
    'JPN 3153',
    'individual',
    67,
    397.0,
    321.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '2c498f4f-e8e1-5f73-8cd6-1b72cb573d79',
    'dcd4351e-c984-5c40-bcd0-14f7698e841c',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '岩波 由夏',
    'JPN 3376',
    'individual',
    68,
    401.0,
    330.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'afe2015a-365e-5363-9b60-1527d1d0ed74',
    'b6d30022-7628-522d-92fe-d63d1199a66b',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '丹波 翔叡',
    'JPN 3487',
    'individual',
    69,
    408.0,
    335.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '53fe615d-0b86-5819-a882-72a06e3eddce',
    '4c6c867b-dead-5727-b7c7-c79d8a61176f',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '上敷領 美海',
    'JPN 3231',
    'individual',
    70,
    413.0,
    337.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '1ed19b35-02b4-526f-bee0-ec7c3394bfea',
    'ed754d7e-169a-587a-9cd6-d8ca4eb79027',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '永見 波奈',
    'JPN 3417',
    'individual',
    71,
    419.0,
    341.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'b6d6c82b-e54f-52be-b748-6da5592d3297',
    'eaad9ca1-6091-594b-bc28-317b17adff58',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '田淵 勇帆',
    'JPN 3486',
    'individual',
    72,
    424.0,
    348.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'bdcdd93d-db13-555e-96c7-97035c0696fa',
    '796c7035-28ea-56c5-ac8f-79f905be0624',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '内田 有希',
    'JPN 3372',
    'individual',
    73,
    430.0,
    349.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '7f416839-a12f-5433-bd9f-4321f5364d9c',
    '4a8e458e-16cf-50ab-8cfd-db97f4aefca1',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '守屋 由慧',
    'JPN 3340',
    'individual',
    74,
    429.0,
    350.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '71ebd58a-df62-574d-b665-b5b357de5e72',
    'fdedf2c3-c37c-5c26-866d-0e4f56ceddde',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '今村 海晴',
    'JPN 3419',
    'individual',
    75,
    443.0,
    361.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '9eba869a-11cb-51ca-b6a1-2c359a84d732',
    '25ac7774-b971-5708-afb2-ce8fed50bbd3',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '高橋 武尊',
    'JPN 3367',
    'individual',
    76,
    458.0,
    378.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '4d0c86c0-c120-5dd1-bf48-43a92d6f8cc7',
    '83945565-f700-5935-81d5-9b7eb94bc968',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '中山 うた',
    'JPN 3469',
    'individual',
    77,
    457.0,
    378.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '04bb295a-5964-5475-a95a-d818c473d07a',
    'ed9b204a-47b0-5e95-a72a-c918dde47252',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '大森 康太',
    'JPN 3449',
    'individual',
    78,
    466.0,
    384.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '1be94ed7-abfd-516e-94da-8c90fff3915b',
    '7d9cdace-e35e-53e9-b310-81a4e7b95dbb',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '秋村 柚月',
    'JPN 3184',
    'individual',
    79,
    469.0,
    389.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '610d233f-5e62-54b1-a858-71a65c9997f8',
    '78c986b8-aeb4-536f-83b8-242f45297dc2',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '江口 瑠海',
    'JPN 3379',
    'individual',
    80,
    477.0,
    396.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '62fdeeb4-693b-588e-896c-b282044abf30',
    '69a4292e-5d7e-5d91-bd42-df20e0db1a79',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '宇多 泰誠',
    'JPN 3371',
    'individual',
    81,
    485.0,
    409.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/169417',
    'Result 20251124（最終）',
    'pdf',
    'Official final results from JODA 57th All Japan Optimist Sailing Championship, Nishinomiya, signed 2025/11/24 12:53.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

-- 6. Regatta Result Participants
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3665a5bc-4550-5cc8-91a8-27206091f249',
    '4d7932e3-c7ef-5118-90d3-921865427f5d',
    '80b84cf7-7443-5799-ae95-3ce659637bd4',
    '藤田 翔伊',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '10d61f80-77c7-53c7-bfbf-c40471e33c9f',
    '6051d6b1-3596-5f89-baf1-e62897afdf61',
    '51090326-f0c9-5140-8db8-fbe90cbf12d5',
    '堀野 葵',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ce1db0bb-fddd-54ba-bfc4-017aa784ca7f',
    'ea782a9b-1451-5e81-a70e-efe833f8ec06',
    '6471b3cc-1310-54f1-945c-c06115d54996',
    '角森 帆朱',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2cb93e58-96d6-556f-8265-08e580dc48b4',
    'adfb849b-d244-5360-907d-45f99ce3a733',
    '1b5e6155-88c2-4e32-b173-24e6bfa54c1c',
    '三浦 太輝',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd4727bb5-f891-5c9a-b0fd-4e5b4193a241',
    'ad9c06e4-b8a4-5e4e-ae4c-8da13fe420dd',
    'd5866bfe-8e21-585d-b8e7-2b76cb8feba7',
    '中田 琴海',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '64130cac-404f-53ef-a75c-14caacb9daf8',
    '67d0d259-a3e1-5122-acb0-e31f14782133',
    'a7def62a-9cc0-5c4d-a10a-6b8bd2eb3dc4',
    '須永 言葉',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '51255ed6-c8c0-5d70-a37c-25ec222d997c',
    'e4113492-6588-544c-9b14-808ffc58a2f8',
    '28032f7a-8535-431c-a220-cc5a529ebd38',
    '上條 正弘',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '59d6e672-0e42-5167-ba63-2cea525b3f28',
    '43ebb342-d0cc-5e5b-a4fe-37a10b03b75a',
    'eba0deb0-10e4-4d3e-a5e5-5e3fa6287288',
    '樋口 颯希',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'cde2cff5-6c41-55aa-8f78-10ee2e1d58f7',
    '3da88211-9bae-58a2-8f6f-dc530e3977c1',
    '89eed0ba-4c8d-49dc-a03e-6624a364f93c',
    '中村 海翔',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '11bdda56-6ff3-5f41-879f-7336be83814f',
    'fa3dc4b7-b0e2-56c4-bcf6-d961e2bc73a9',
    '5890ff0d-ad50-4352-84a0-29135867289a',
    '川上 渚',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '832ba7ad-823d-59bd-a7d5-26830bd08568',
    'f984179f-9e50-5a9b-975f-7d62635f0ea4',
    '2780f0eb-ea28-44e6-ba67-22a35fb9913d',
    '松永 虎汰郎',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '88695432-009a-5c8c-bcd5-5e2db5fb8a5b',
    '3034dde0-060f-5032-b460-198aa46b196b',
    'a79fd718-f18f-596a-8548-70605f2b3452',
    '檜垣 俊忠',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0f24fe4c-6a44-5d05-8e6e-3eeba8fbd78c',
    '3eaeb5ed-f5ec-525c-a362-28a760942eba',
    'b45c3a55-05b3-50aa-bb37-2731f3f98d4e',
    '源関 新',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4e4b4f26-892e-5a08-8d49-8e1a30a64ad4',
    'ab9bdb75-acf5-5449-8ea7-d980f7395371',
    'b24f2640-1c36-50ea-8fa3-243a3a48f08a',
    '亀田 留衣',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b09c3879-1634-5b8a-992f-15fe919fed93',
    '28bef6f8-3136-56d0-8429-e6f2da097643',
    'f328eec8-af48-5826-9ffd-36ba379122c2',
    '樋口 耀紀',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'aed2bc76-b71b-5655-afd5-e756d7e67f7c',
    '3df572ae-0419-5bab-8943-da607d6b3c57',
    '5f6d71a5-1dc3-599c-b9be-377150d4dd3a',
    '村中 菜々',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9d336580-ce11-51cd-8dc2-c2dc23eb19b0',
    '6433e3a5-2d2b-5a93-943b-e6d60dfd8f56',
    '187c0d31-a090-5d29-bcce-7e6d5e120279',
    '清水 優太',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8247bd22-bc46-56d9-b19f-81b32e4d7f94',
    'c84bef28-d2a8-555f-9ab1-5ae7e9915aec',
    'b0a725c6-026d-511e-8333-9adde320a379',
    '石川 凛乃',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9d38691e-7f54-5286-a3d0-aae3bd533ae5',
    'a215d4db-525c-516a-839f-4151d76dc13f',
    'e373e71d-025b-55b0-acf6-ce6dfb8eb06c',
    '吉岡 祐月',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1b93c045-ddbf-554a-aca3-40ae8cd51c9a',
    '037882eb-4bcc-5a30-9c1b-0e2c66402ac3',
    'b8f8b747-639d-5920-adfe-ec84e34cc40b',
    '平野 陽也',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '73617d49-3bec-5792-bc98-a6d435599b80',
    '5483c4dc-34b8-5307-9112-9ef5a1733af2',
    '5630e6fd-a5f6-537f-8754-461b642feccd',
    '山本 健瑚',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e00b362e-a462-5479-9b79-1308c9de5ade',
    '77e59a85-0a78-5101-bc60-0ba5225c80d7',
    '3d7d17df-71ad-4195-b41d-abdebbed13bc',
    '村中 莉子',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '466b5e5d-11d7-5447-8cbf-2f593554ae3c',
    'ec348d04-42b4-5ea3-b2fd-f6568dc88d2a',
    'c3777043-8cd8-525e-8a1e-be9d476a4ccc',
    '阪間 俊仁',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '735132b3-dcb6-5ca3-ae4c-ea9235698b52',
    '02ca02c4-34e1-52fd-8463-3142368a2d52',
    '18e73ee3-3792-59f9-aa32-649ca6ca325d',
    '登田 直',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a0c9f240-5f46-57d4-8bf6-d7666d420c93',
    'c4f7a630-887f-5ffa-aea0-a95e156386e3',
    '1ac9dc89-783e-56c9-8c8d-785a5e10cccc',
    '山田 晟',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b0690728-423c-5464-93d4-a782bf0e674b',
    'ca5efe5b-9f97-5216-9a66-5ae9a659e631',
    '0c3ea04a-905c-45f1-abb7-a4a917e7da14',
    '久保田 夏実',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3af90e35-6564-5577-869d-98343bb04e19',
    'aacc29fe-93f2-5495-9c5d-df23a535b2d3',
    'ff62d4d8-c48a-587d-ab98-b19b551126cb',
    '岩﨑 楓太',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7b078911-25bc-5c07-ae4c-784be59b8c0a',
    '1a206536-c6fd-5a0e-91d3-3f1e6693b3c2',
    '823c8645-7014-5734-8a89-0aa2a1739d46',
    '坂口 美結',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '71e78ac0-ada3-5a4c-b3e6-220fdc37c275',
    '1845d89e-f34b-5345-9644-c32908795169',
    '88a4cc04-e045-553c-8d3e-d4dc02c8b92c',
    '牧野 紗奈',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e2d4d9b2-1de6-5996-a58b-8f523ebcbda6',
    '2bca9113-a5b0-5576-b3c2-6c11db63cc28',
    'e36afcc6-d8af-589b-88a8-fa608d94a470',
    '井上 はる',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'cde75ce3-9a6d-5702-8837-dc853d6b0a3c',
    '515d4bfb-66e6-5ce1-af36-ae4e62e8ea99',
    '3d6c3a59-ea5b-5d31-a9eb-c4db5a510958',
    '直井 舷太',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e01f92d6-ca8a-544b-9522-40de8b6ec722',
    '037bd687-a35b-5b9b-b7d6-3ee0d3627d4c',
    '2e9a2d64-59c9-58e5-93c7-060df21e4417',
    '今村 颯人',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '57e746b9-5ec9-5d66-9378-6e9e188a88eb',
    '33c34af4-38e1-51a1-891c-0c6be8fe4aa9',
    '2b82f965-5e0d-5063-bb05-b3f1cf099740',
    '竹内 海聖',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '68d64e1c-aace-5fd8-9035-9f80a3ffe98b',
    'e60e967c-d55e-5bff-98cd-42c9d464fd55',
    'f0bd203e-94f4-5484-8ddf-cbdd19aab450',
    '笠木 蓮斗',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd59b9d2b-8f69-52c9-8424-0e13710c7b11',
    '3251d780-5d5b-5903-b8c1-9ce65ddde61a',
    'c70ced96-bb4c-5869-9d1d-38d1ec05f79f',
    '根岸 渚沙',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '276a3201-9c30-58ce-a65c-7a5528487b6c',
    'b5185ab8-a95d-580b-ab6e-f9282a0a122b',
    'd9d62a14-21a0-5384-bee0-6e752ec87728',
    '木﨑 翔嶋',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8a2cc289-12aa-5acb-a559-6700c20f0455',
    '1f511ef9-60b6-5072-ba73-d484b467e706',
    '99964fca-8cf3-5f2a-ad26-e7b593fc55a2',
    '兼久 宗之',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f72b4cce-b440-5108-a434-b9637d12a47b',
    '8e437246-030d-50f4-b254-ddcd1d1cc751',
    '6e3927aa-a435-5bc6-bb40-867479f8ed5d',
    '水谷 智子',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a2d3cc24-b52e-5935-bb38-54b8d2b1d350',
    'bf6a9a1d-6449-50db-8c78-6bf5905f95cf',
    'de0c3f56-b814-5e6e-9cc0-6759c8dab972',
    '氏家 琉星',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '16e8fe5a-418d-5e34-8978-222f178667d5',
    '29274e5a-54db-567e-9b8a-e57712e5aa05',
    '091c9564-e25e-5910-9d32-dce8511865aa',
    '池田 晟',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9cf65ffd-8a44-5359-9f51-fa3809785e80',
    '3e98da1d-0cf5-5607-9abe-c8a1bc823b15',
    '18d31b19-6b63-51b9-b8f5-abdf03d8331e',
    '今井 堅朱朗',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f46cd7f1-1099-5999-87b0-382b7f26ea52',
    '20f8bdd0-6116-561f-a8dc-abeceb3ed58f',
    '5fd47d5e-bc45-545d-8daa-0cc63bc1c84e',
    '安藤 果帆',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '07a2ba13-d08f-53a8-88d5-a2051b6c646c',
    '9d2c4d94-07d4-5d23-bf53-16f0ea91cd2e',
    '136afe66-3153-513f-b61e-20a2225c0bfb',
    '井上 豊海',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '200e9ada-abc6-5020-895c-40815a77d1a8',
    '5f37073b-dead-5c88-9474-b30124be1b1a',
    '1af41791-9ec0-59c0-89d9-36d65f21dc4e',
    '今井 創也',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6189c468-3ef0-5a7e-a88d-86102e0056c1',
    'cde1b0fb-bc4a-52c1-b502-a6119fb4e3b1',
    '234b96c7-73e8-59f9-832d-6d9015917659',
    '宮武 大我',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fc2d3177-f44d-5c23-a874-d7ff8a403699',
    'cd9bad9b-5ccb-5f43-80e7-7f68ade00028',
    'd5b1460c-ffb5-5bb9-bd8b-7f4e2c4bfab1',
    '辰野 志奈乃',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fa55cf7d-65d4-5057-a2ab-5f651dcd490e',
    'df3e5978-696d-58bf-9c50-2db2866db8c7',
    '659a7737-50cd-5c70-ae0b-7827574aac17',
    '宮﨑 心桜',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6c13eb93-51d9-5b3c-8da9-ff3eea56284c',
    '739c0a68-3bdf-5907-8a72-5988b051236f',
    'c0a8cdf2-00af-5908-bb52-6f52f8d26e21',
    '栗本 悠里',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '088bfed7-ea1e-511b-a1bb-5e87066d4370',
    '34743a77-415b-52ba-808a-f288f3084506',
    '740ac6c8-3424-579c-900c-73348b365168',
    '今井 晴也',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '888eeb8c-1c31-5360-a0e7-b5ef5d55d52a',
    '832003a1-58cc-52cc-931c-6c4d1509dc4f',
    '3e685fbd-6579-5195-8537-442cd9a85771',
    '堀 冬馬',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6476a6b7-8be6-52cc-bd09-9ad174e9d8ce',
    '2e9c5bbe-8578-5aca-96d3-31ffae60e5c6',
    'be617744-2ecc-57fe-b837-85b80ab95e06',
    '城石 朋春',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '31c6e534-d57a-5f53-95a9-81859fe0a3da',
    '28702a61-b612-57b6-8888-8bd7a84d429c',
    '640dd123-66d5-5a8a-8a22-e5d4de5d8a35',
    '川本 拓実',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd5ddc608-c79a-53bd-87c3-efd09a414055',
    'b0842a37-346a-5357-b077-c31bc0cd467b',
    '8e182f64-ea94-4254-9ae3-b4611981dc3b',
    '平澤 海翔',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'da99dffd-4887-5f3e-9e3d-0e7a35f7e4f3',
    'ee6edf45-c30b-50ab-869e-b3d60d86705d',
    '13bd0aab-ee6e-5536-8fb7-836169c66fac',
    '椎名 悠貴',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '43e89165-66cb-59d3-9730-981a8fe90bab',
    '7f880b35-9105-5d32-81c2-3f707be3ee6a',
    '5f728a1a-6dc6-5da1-a806-0beeb4f3010c',
    '内田 海音',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a7e90e1b-2a6e-5cf8-9f8d-d59b57fecfd4',
    '33efc76e-d10d-54dc-bfec-7d92b98126d2',
    'ad4668e3-78b5-5402-a9a4-7641af07c063',
    '伊藤 照真',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b55e9eea-9590-582d-8584-7dacb74555c4',
    'fb5f2cf5-bf59-51b0-af96-2ccfdce1b30c',
    '60fc244e-f889-52e0-bb3b-00e8bedff4d7',
    '西村 泰洋',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'dad6e316-df1d-59ed-9f3b-fe5f4d8ab8cb',
    'b4a3cff9-2385-5e8e-8bf7-c754fe8af683',
    'b62a8c3f-fdc5-5574-85c1-e0731ba62fda',
    '富岡 英恵',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7971a287-c783-59f7-9944-7dd6d660f706',
    'b11e030d-6a96-5fa9-8eb4-c3ad485e13e4',
    '046f010b-9c1c-5f1a-9646-267d9b5a36a5',
    '仲山 結夏',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5bcb774b-77dc-50a1-8108-3011ad4d98bc',
    '3b1c86b3-9b31-5316-b9e0-761c1b431719',
    '55b10636-fbeb-5102-8b5b-86dd1f1e5ebb',
    '佐々木 椋平',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e477b89d-6ed2-5539-96a8-14d41adb7409',
    '9a090e69-f62f-5aa8-a194-ab7dcc991c9d',
    '1ebfc70d-f150-581f-92fd-df32debbae3e',
    '枝 大耀',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fa76d74a-2e73-5d2c-bd80-6ae4c8bf59f3',
    '01780e22-9d5d-5910-996f-63c42528a929',
    '67ff3eda-7825-5bbc-ade2-611d292a728e',
    '森田 晴翔',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'eb83b187-ae17-5bf9-88f4-f936cf9aec5c',
    '93bac8b3-9b6c-504d-8847-c7aeced3f6fd',
    '1ceeb9fd-977e-5c55-bec1-1a0b14846e1b',
    '廣田 穣',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '97bdf022-e414-5213-8921-67e48fcbd50f',
    'aba52ef2-8c84-5046-a245-8cca33105056',
    '9c2aa8a7-86d0-5c81-9bef-ba0f0878d944',
    '平野 萌生',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd5a6aca2-b3ab-51d7-b7a3-4353bddaa5ae',
    '6e40c41b-c4b9-5fa5-8034-d70f11cff1aa',
    '1162e397-e58d-5441-aa38-5189647b190f',
    '中村 太晴',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a7e96405-ddf5-5a69-8052-ef6ecfa1f928',
    '5d7e566d-188b-5f49-8ff8-d7d8a55aba16',
    'c764b218-e565-5b0b-905e-d56b0c7d4a9d',
    '檜垣 菜々子',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '56e207c3-9cb2-5f99-9bb3-a14406c86006',
    'a2a9edde-ffae-57e6-9bb7-c1cddfaac214',
    '11621fc9-3a7c-5509-8e01-5a2c92eeca01',
    '長堀 奨',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '48e2cfc5-5e0b-5100-8ac0-f8068a95be29',
    '2c498f4f-e8e1-5f73-8cd6-1b72cb573d79',
    'dcd4351e-c984-5c40-bcd0-14f7698e841c',
    '岩波 由夏',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '93a91bc8-d440-5696-af55-20a9b757d46f',
    'afe2015a-365e-5363-9b60-1527d1d0ed74',
    'b6d30022-7628-522d-92fe-d63d1199a66b',
    '丹波 翔叡',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4949dd80-ffd7-57c7-8214-052d9f30a685',
    '53fe615d-0b86-5819-a882-72a06e3eddce',
    '4c6c867b-dead-5727-b7c7-c79d8a61176f',
    '上敷領 美海',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5b9b2795-c20f-55c3-b27e-2e5582eb5e04',
    '1ed19b35-02b4-526f-bee0-ec7c3394bfea',
    'ed754d7e-169a-587a-9cd6-d8ca4eb79027',
    '永見 波奈',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f60210ea-1787-53db-b9d2-707f83d3ffae',
    'b6d6c82b-e54f-52be-b748-6da5592d3297',
    'eaad9ca1-6091-594b-bc28-317b17adff58',
    '田淵 勇帆',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c40fb87a-6c34-5f42-a2d2-21fda25e177a',
    'bdcdd93d-db13-555e-96c7-97035c0696fa',
    '796c7035-28ea-56c5-ac8f-79f905be0624',
    '内田 有希',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '79c7349b-2f84-57a2-ba1b-db01028c00e7',
    '7f416839-a12f-5433-bd9f-4321f5364d9c',
    '4a8e458e-16cf-50ab-8cfd-db97f4aefca1',
    '守屋 由慧',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f20bd840-9db0-50be-ae0a-9844f28b25f1',
    '71ebd58a-df62-574d-b665-b5b357de5e72',
    'fdedf2c3-c37c-5c26-866d-0e4f56ceddde',
    '今村 海晴',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '95e0e0c0-03cb-5570-a0e6-49ec8c6410c2',
    '9eba869a-11cb-51ca-b6a1-2c359a84d732',
    '25ac7774-b971-5708-afb2-ce8fed50bbd3',
    '高橋 武尊',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7c27a8d3-fbfb-551c-81f6-b461281f4c09',
    '4d0c86c0-c120-5dd1-bf48-43a92d6f8cc7',
    '83945565-f700-5935-81d5-9b7eb94bc968',
    '中山 うた',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3f4456c6-15f8-5f0c-b243-94fc593bb841',
    '04bb295a-5964-5475-a95a-d818c473d07a',
    'ed9b204a-47b0-5e95-a72a-c918dde47252',
    '大森 康太',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '53a821e3-9fb4-576b-988b-874b884c18cd',
    '1be94ed7-abfd-516e-94da-8c90fff3915b',
    '7d9cdace-e35e-53e9-b310-81a4e7b95dbb',
    '秋村 柚月',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3f0000c5-9596-527f-a5ef-65b98d130dd1',
    '610d233f-5e62-54b1-a858-71a65c9997f8',
    '78c986b8-aeb4-536f-83b8-242f45297dc2',
    '江口 瑠海',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd6bd812a-fa99-50df-831a-34d905100b1b',
    '62fdeeb4-693b-588e-896c-b282044abf30',
    '69a4292e-5d7e-5d91-bd42-df20e0db1a79',
    '宇多 泰誠',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;

-- 7. Individual Race Scores (567 race results)
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4d7932e3-c7ef-5118-90d3-921865427f5d',
    1,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4d7932e3-c7ef-5118-90d3-921865427f5d',
    2,
    5.0,
    NULL,
    true,
    '(5.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4d7932e3-c7ef-5118-90d3-921865427f5d',
    3,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4d7932e3-c7ef-5118-90d3-921865427f5d',
    4,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4d7932e3-c7ef-5118-90d3-921865427f5d',
    5,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4d7932e3-c7ef-5118-90d3-921865427f5d',
    6,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4d7932e3-c7ef-5118-90d3-921865427f5d',
    7,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6051d6b1-3596-5f89-baf1-e62897afdf61',
    1,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6051d6b1-3596-5f89-baf1-e62897afdf61',
    2,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6051d6b1-3596-5f89-baf1-e62897afdf61',
    3,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6051d6b1-3596-5f89-baf1-e62897afdf61',
    4,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6051d6b1-3596-5f89-baf1-e62897afdf61',
    5,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6051d6b1-3596-5f89-baf1-e62897afdf61',
    6,
    12.0,
    NULL,
    true,
    '(12.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6051d6b1-3596-5f89-baf1-e62897afdf61',
    7,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea782a9b-1451-5e81-a70e-efe833f8ec06',
    1,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea782a9b-1451-5e81-a70e-efe833f8ec06',
    2,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea782a9b-1451-5e81-a70e-efe833f8ec06',
    3,
    37.0,
    NULL,
    true,
    '(37.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea782a9b-1451-5e81-a70e-efe833f8ec06',
    4,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea782a9b-1451-5e81-a70e-efe833f8ec06',
    5,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea782a9b-1451-5e81-a70e-efe833f8ec06',
    6,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ea782a9b-1451-5e81-a70e-efe833f8ec06',
    7,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'adfb849b-d244-5360-907d-45f99ce3a733',
    1,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'adfb849b-d244-5360-907d-45f99ce3a733',
    2,
    15.0,
    NULL,
    true,
    '(15.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'adfb849b-d244-5360-907d-45f99ce3a733',
    3,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'adfb849b-d244-5360-907d-45f99ce3a733',
    4,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'adfb849b-d244-5360-907d-45f99ce3a733',
    5,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'adfb849b-d244-5360-907d-45f99ce3a733',
    6,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'adfb849b-d244-5360-907d-45f99ce3a733',
    7,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ad9c06e4-b8a4-5e4e-ae4c-8da13fe420dd',
    1,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ad9c06e4-b8a4-5e4e-ae4c-8da13fe420dd',
    2,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ad9c06e4-b8a4-5e4e-ae4c-8da13fe420dd',
    3,
    38.0,
    NULL,
    true,
    '(38.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ad9c06e4-b8a4-5e4e-ae4c-8da13fe420dd',
    4,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ad9c06e4-b8a4-5e4e-ae4c-8da13fe420dd',
    5,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ad9c06e4-b8a4-5e4e-ae4c-8da13fe420dd',
    6,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ad9c06e4-b8a4-5e4e-ae4c-8da13fe420dd',
    7,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '67d0d259-a3e1-5122-acb0-e31f14782133',
    1,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '67d0d259-a3e1-5122-acb0-e31f14782133',
    2,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '67d0d259-a3e1-5122-acb0-e31f14782133',
    3,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '67d0d259-a3e1-5122-acb0-e31f14782133',
    4,
    26.0,
    NULL,
    true,
    '(26.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '67d0d259-a3e1-5122-acb0-e31f14782133',
    5,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '67d0d259-a3e1-5122-acb0-e31f14782133',
    6,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '67d0d259-a3e1-5122-acb0-e31f14782133',
    7,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4113492-6588-544c-9b14-808ffc58a2f8',
    1,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4113492-6588-544c-9b14-808ffc58a2f8',
    2,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4113492-6588-544c-9b14-808ffc58a2f8',
    3,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4113492-6588-544c-9b14-808ffc58a2f8',
    4,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4113492-6588-544c-9b14-808ffc58a2f8',
    5,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4113492-6588-544c-9b14-808ffc58a2f8',
    6,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4113492-6588-544c-9b14-808ffc58a2f8',
    7,
    39.0,
    NULL,
    true,
    '(39.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43ebb342-d0cc-5e5b-a4fe-37a10b03b75a',
    1,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43ebb342-d0cc-5e5b-a4fe-37a10b03b75a',
    2,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43ebb342-d0cc-5e5b-a4fe-37a10b03b75a',
    3,
    45.0,
    NULL,
    false,
    '45.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43ebb342-d0cc-5e5b-a4fe-37a10b03b75a',
    4,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43ebb342-d0cc-5e5b-a4fe-37a10b03b75a',
    5,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43ebb342-d0cc-5e5b-a4fe-37a10b03b75a',
    6,
    52.0,
    NULL,
    true,
    '(52.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '43ebb342-d0cc-5e5b-a4fe-37a10b03b75a',
    7,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3da88211-9bae-58a2-8f6f-dc530e3977c1',
    1,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3da88211-9bae-58a2-8f6f-dc530e3977c1',
    2,
    32.0,
    NULL,
    true,
    '(32.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3da88211-9bae-58a2-8f6f-dc530e3977c1',
    3,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3da88211-9bae-58a2-8f6f-dc530e3977c1',
    4,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3da88211-9bae-58a2-8f6f-dc530e3977c1',
    5,
    31.0,
    NULL,
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3da88211-9bae-58a2-8f6f-dc530e3977c1',
    6,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3da88211-9bae-58a2-8f6f-dc530e3977c1',
    7,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa3dc4b7-b0e2-56c4-bcf6-d961e2bc73a9',
    1,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa3dc4b7-b0e2-56c4-bcf6-d961e2bc73a9',
    2,
    31.0,
    NULL,
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa3dc4b7-b0e2-56c4-bcf6-d961e2bc73a9',
    3,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa3dc4b7-b0e2-56c4-bcf6-d961e2bc73a9',
    4,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa3dc4b7-b0e2-56c4-bcf6-d961e2bc73a9',
    5,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa3dc4b7-b0e2-56c4-bcf6-d961e2bc73a9',
    6,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fa3dc4b7-b0e2-56c4-bcf6-d961e2bc73a9',
    7,
    33.0,
    NULL,
    true,
    '(33.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f984179f-9e50-5a9b-975f-7d62635f0ea4',
    1,
    3.0,
    NULL,
    false,
    '3.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f984179f-9e50-5a9b-975f-7d62635f0ea4',
    2,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f984179f-9e50-5a9b-975f-7d62635f0ea4',
    3,
    54.0,
    NULL,
    true,
    '(54.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f984179f-9e50-5a9b-975f-7d62635f0ea4',
    4,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f984179f-9e50-5a9b-975f-7d62635f0ea4',
    5,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f984179f-9e50-5a9b-975f-7d62635f0ea4',
    6,
    41.0,
    NULL,
    false,
    '41.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f984179f-9e50-5a9b-975f-7d62635f0ea4',
    7,
    38.0,
    NULL,
    false,
    '38.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3034dde0-060f-5032-b460-198aa46b196b',
    1,
    34.0,
    NULL,
    false,
    '34.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3034dde0-060f-5032-b460-198aa46b196b',
    2,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3034dde0-060f-5032-b460-198aa46b196b',
    3,
    39.0,
    NULL,
    true,
    '(39.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3034dde0-060f-5032-b460-198aa46b196b',
    4,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3034dde0-060f-5032-b460-198aa46b196b',
    5,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3034dde0-060f-5032-b460-198aa46b196b',
    6,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3034dde0-060f-5032-b460-198aa46b196b',
    7,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3eaeb5ed-f5ec-525c-a362-28a760942eba',
    1,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3eaeb5ed-f5ec-525c-a362-28a760942eba',
    2,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3eaeb5ed-f5ec-525c-a362-28a760942eba',
    3,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3eaeb5ed-f5ec-525c-a362-28a760942eba',
    4,
    31.0,
    NULL,
    true,
    '(31.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3eaeb5ed-f5ec-525c-a362-28a760942eba',
    5,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3eaeb5ed-f5ec-525c-a362-28a760942eba',
    6,
    31.0,
    NULL,
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3eaeb5ed-f5ec-525c-a362-28a760942eba',
    7,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab9bdb75-acf5-5449-8ea7-d980f7395371',
    1,
    50.0,
    NULL,
    true,
    '(50.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab9bdb75-acf5-5449-8ea7-d980f7395371',
    2,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab9bdb75-acf5-5449-8ea7-d980f7395371',
    3,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab9bdb75-acf5-5449-8ea7-d980f7395371',
    4,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab9bdb75-acf5-5449-8ea7-d980f7395371',
    5,
    49.0,
    NULL,
    false,
    '49.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab9bdb75-acf5-5449-8ea7-d980f7395371',
    6,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ab9bdb75-acf5-5449-8ea7-d980f7395371',
    7,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '28bef6f8-3136-56d0-8429-e6f2da097643',
    1,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '28bef6f8-3136-56d0-8429-e6f2da097643',
    2,
    34.0,
    NULL,
    false,
    '34.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '28bef6f8-3136-56d0-8429-e6f2da097643',
    3,
    72.0,
    NULL,
    true,
    '(72.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '28bef6f8-3136-56d0-8429-e6f2da097643',
    4,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '28bef6f8-3136-56d0-8429-e6f2da097643',
    5,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '28bef6f8-3136-56d0-8429-e6f2da097643',
    6,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '28bef6f8-3136-56d0-8429-e6f2da097643',
    7,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3df572ae-0419-5bab-8943-da607d6b3c57',
    1,
    32.0,
    NULL,
    false,
    '32.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3df572ae-0419-5bab-8943-da607d6b3c57',
    2,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3df572ae-0419-5bab-8943-da607d6b3c57',
    3,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3df572ae-0419-5bab-8943-da607d6b3c57',
    4,
    35.0,
    NULL,
    false,
    '35.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3df572ae-0419-5bab-8943-da607d6b3c57',
    5,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3df572ae-0419-5bab-8943-da607d6b3c57',
    6,
    45.0,
    NULL,
    true,
    '(45.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3df572ae-0419-5bab-8943-da607d6b3c57',
    7,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6433e3a5-2d2b-5a93-943b-e6d60dfd8f56',
    1,
    41.0,
    NULL,
    false,
    '41.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6433e3a5-2d2b-5a93-943b-e6d60dfd8f56',
    2,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6433e3a5-2d2b-5a93-943b-e6d60dfd8f56',
    3,
    42.0,
    NULL,
    true,
    '(42.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6433e3a5-2d2b-5a93-943b-e6d60dfd8f56',
    4,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6433e3a5-2d2b-5a93-943b-e6d60dfd8f56',
    5,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6433e3a5-2d2b-5a93-943b-e6d60dfd8f56',
    6,
    42.0,
    NULL,
    false,
    '42.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6433e3a5-2d2b-5a93-943b-e6d60dfd8f56',
    7,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c84bef28-d2a8-555f-9ab1-5ae7e9915aec',
    1,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c84bef28-d2a8-555f-9ab1-5ae7e9915aec',
    2,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c84bef28-d2a8-555f-9ab1-5ae7e9915aec',
    3,
    6.0,
    NULL,
    false,
    '6.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c84bef28-d2a8-555f-9ab1-5ae7e9915aec',
    4,
    64.0,
    NULL,
    true,
    '(64.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c84bef28-d2a8-555f-9ab1-5ae7e9915aec',
    5,
    37.0,
    NULL,
    false,
    '37.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c84bef28-d2a8-555f-9ab1-5ae7e9915aec',
    6,
    5.0,
    NULL,
    false,
    '5.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c84bef28-d2a8-555f-9ab1-5ae7e9915aec',
    7,
    44.0,
    NULL,
    false,
    '44.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a215d4db-525c-516a-839f-4151d76dc13f',
    1,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a215d4db-525c-516a-839f-4151d76dc13f',
    2,
    69.0,
    NULL,
    true,
    '(69.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a215d4db-525c-516a-839f-4151d76dc13f',
    3,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a215d4db-525c-516a-839f-4151d76dc13f',
    4,
    39.0,
    NULL,
    false,
    '39.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a215d4db-525c-516a-839f-4151d76dc13f',
    5,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a215d4db-525c-516a-839f-4151d76dc13f',
    6,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a215d4db-525c-516a-839f-4151d76dc13f',
    7,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '037882eb-4bcc-5a30-9c1b-0e2c66402ac3',
    1,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '037882eb-4bcc-5a30-9c1b-0e2c66402ac3',
    2,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '037882eb-4bcc-5a30-9c1b-0e2c66402ac3',
    3,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '037882eb-4bcc-5a30-9c1b-0e2c66402ac3',
    4,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '037882eb-4bcc-5a30-9c1b-0e2c66402ac3',
    5,
    46.0,
    NULL,
    false,
    '46.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '037882eb-4bcc-5a30-9c1b-0e2c66402ac3',
    6,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '037882eb-4bcc-5a30-9c1b-0e2c66402ac3',
    7,
    70.0,
    NULL,
    true,
    '(70.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5483c4dc-34b8-5307-9112-9ef5a1733af2',
    1,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5483c4dc-34b8-5307-9112-9ef5a1733af2',
    2,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5483c4dc-34b8-5307-9112-9ef5a1733af2',
    3,
    2.0,
    NULL,
    false,
    '2.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5483c4dc-34b8-5307-9112-9ef5a1733af2',
    4,
    46.0,
    NULL,
    false,
    '46.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5483c4dc-34b8-5307-9112-9ef5a1733af2',
    5,
    34.0,
    NULL,
    false,
    '34.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5483c4dc-34b8-5307-9112-9ef5a1733af2',
    6,
    60.0,
    NULL,
    true,
    '(60.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5483c4dc-34b8-5307-9112-9ef5a1733af2',
    7,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77e59a85-0a78-5101-bc60-0ba5225c80d7',
    1,
    82.0,
    'DNC',
    true,
    '(82.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77e59a85-0a78-5101-bc60-0ba5225c80d7',
    2,
    82.0,
    'DNC',
    false,
    '82.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77e59a85-0a78-5101-bc60-0ba5225c80d7',
    3,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77e59a85-0a78-5101-bc60-0ba5225c80d7',
    4,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77e59a85-0a78-5101-bc60-0ba5225c80d7',
    5,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77e59a85-0a78-5101-bc60-0ba5225c80d7',
    6,
    4.0,
    NULL,
    false,
    '4.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '77e59a85-0a78-5101-bc60-0ba5225c80d7',
    7,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ec348d04-42b4-5ea3-b2fd-f6568dc88d2a',
    1,
    7.0,
    NULL,
    false,
    '7.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ec348d04-42b4-5ea3-b2fd-f6568dc88d2a',
    2,
    40.0,
    NULL,
    false,
    '40.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ec348d04-42b4-5ea3-b2fd-f6568dc88d2a',
    3,
    60.0,
    NULL,
    true,
    '(60.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ec348d04-42b4-5ea3-b2fd-f6568dc88d2a',
    4,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ec348d04-42b4-5ea3-b2fd-f6568dc88d2a',
    5,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ec348d04-42b4-5ea3-b2fd-f6568dc88d2a',
    6,
    47.0,
    NULL,
    false,
    '47.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ec348d04-42b4-5ea3-b2fd-f6568dc88d2a',
    7,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '02ca02c4-34e1-52fd-8463-3142368a2d52',
    1,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '02ca02c4-34e1-52fd-8463-3142368a2d52',
    2,
    30.0,
    NULL,
    false,
    '30.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '02ca02c4-34e1-52fd-8463-3142368a2d52',
    3,
    27.6,
    'STP',
    false,
    '27.6'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '02ca02c4-34e1-52fd-8463-3142368a2d52',
    4,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '02ca02c4-34e1-52fd-8463-3142368a2d52',
    5,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '02ca02c4-34e1-52fd-8463-3142368a2d52',
    6,
    76.0,
    NULL,
    true,
    '(76.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '02ca02c4-34e1-52fd-8463-3142368a2d52',
    7,
    34.0,
    NULL,
    false,
    '34.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4f7a630-887f-5ffa-aea0-a95e156386e3',
    1,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4f7a630-887f-5ffa-aea0-a95e156386e3',
    2,
    50.0,
    NULL,
    true,
    '(50.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4f7a630-887f-5ffa-aea0-a95e156386e3',
    3,
    43.0,
    NULL,
    false,
    '43.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4f7a630-887f-5ffa-aea0-a95e156386e3',
    4,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4f7a630-887f-5ffa-aea0-a95e156386e3',
    5,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4f7a630-887f-5ffa-aea0-a95e156386e3',
    6,
    34.0,
    NULL,
    false,
    '34.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c4f7a630-887f-5ffa-aea0-a95e156386e3',
    7,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca5efe5b-9f97-5216-9a66-5ae9a659e631',
    1,
    43.0,
    NULL,
    true,
    '(43.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca5efe5b-9f97-5216-9a66-5ae9a659e631',
    2,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca5efe5b-9f97-5216-9a66-5ae9a659e631',
    3,
    34.0,
    NULL,
    false,
    '34.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca5efe5b-9f97-5216-9a66-5ae9a659e631',
    4,
    36.0,
    NULL,
    false,
    '36.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca5efe5b-9f97-5216-9a66-5ae9a659e631',
    5,
    32.0,
    NULL,
    false,
    '32.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca5efe5b-9f97-5216-9a66-5ae9a659e631',
    6,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ca5efe5b-9f97-5216-9a66-5ae9a659e631',
    7,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aacc29fe-93f2-5495-9c5d-df23a535b2d3',
    1,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aacc29fe-93f2-5495-9c5d-df23a535b2d3',
    2,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aacc29fe-93f2-5495-9c5d-df23a535b2d3',
    3,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aacc29fe-93f2-5495-9c5d-df23a535b2d3',
    4,
    30.0,
    NULL,
    false,
    '30.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aacc29fe-93f2-5495-9c5d-df23a535b2d3',
    5,
    30.0,
    NULL,
    false,
    '30.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aacc29fe-93f2-5495-9c5d-df23a535b2d3',
    6,
    56.0,
    NULL,
    true,
    '(56.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aacc29fe-93f2-5495-9c5d-df23a535b2d3',
    7,
    42.0,
    NULL,
    false,
    '42.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a206536-c6fd-5a0e-91d3-3f1e6693b3c2',
    1,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a206536-c6fd-5a0e-91d3-3f1e6693b3c2',
    2,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a206536-c6fd-5a0e-91d3-3f1e6693b3c2',
    3,
    36.0,
    NULL,
    false,
    '36.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a206536-c6fd-5a0e-91d3-3f1e6693b3c2',
    4,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a206536-c6fd-5a0e-91d3-3f1e6693b3c2',
    5,
    69.0,
    NULL,
    true,
    '(69.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a206536-c6fd-5a0e-91d3-3f1e6693b3c2',
    6,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1a206536-c6fd-5a0e-91d3-3f1e6693b3c2',
    7,
    48.0,
    NULL,
    false,
    '48.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1845d89e-f34b-5345-9644-c32908795169',
    1,
    73.0,
    NULL,
    true,
    '(73.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1845d89e-f34b-5345-9644-c32908795169',
    2,
    58.0,
    NULL,
    false,
    '58.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1845d89e-f34b-5345-9644-c32908795169',
    3,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1845d89e-f34b-5345-9644-c32908795169',
    4,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1845d89e-f34b-5345-9644-c32908795169',
    5,
    58.0,
    NULL,
    false,
    '58.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1845d89e-f34b-5345-9644-c32908795169',
    6,
    10.0,
    NULL,
    false,
    '10.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1845d89e-f34b-5345-9644-c32908795169',
    7,
    1.0,
    NULL,
    false,
    '1.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2bca9113-a5b0-5576-b3c2-6c11db63cc28',
    1,
    70.0,
    NULL,
    true,
    '(70.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2bca9113-a5b0-5576-b3c2-6c11db63cc28',
    2,
    35.0,
    NULL,
    false,
    '35.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2bca9113-a5b0-5576-b3c2-6c11db63cc28',
    3,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2bca9113-a5b0-5576-b3c2-6c11db63cc28',
    4,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2bca9113-a5b0-5576-b3c2-6c11db63cc28',
    5,
    47.0,
    NULL,
    false,
    '47.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2bca9113-a5b0-5576-b3c2-6c11db63cc28',
    6,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2bca9113-a5b0-5576-b3c2-6c11db63cc28',
    7,
    53.0,
    NULL,
    false,
    '53.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '515d4bfb-66e6-5ce1-af36-ae4e62e8ea99',
    1,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '515d4bfb-66e6-5ce1-af36-ae4e62e8ea99',
    2,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '515d4bfb-66e6-5ce1-af36-ae4e62e8ea99',
    3,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '515d4bfb-66e6-5ce1-af36-ae4e62e8ea99',
    4,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '515d4bfb-66e6-5ce1-af36-ae4e62e8ea99',
    5,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '515d4bfb-66e6-5ce1-af36-ae4e62e8ea99',
    6,
    80.0,
    NULL,
    true,
    '(80.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '515d4bfb-66e6-5ce1-af36-ae4e62e8ea99',
    7,
    58.0,
    NULL,
    false,
    '58.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '037bd687-a35b-5b9b-b7d6-3ee0d3627d4c',
    1,
    72.0,
    NULL,
    false,
    '72.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '037bd687-a35b-5b9b-b7d6-3ee0d3627d4c',
    2,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '037bd687-a35b-5b9b-b7d6-3ee0d3627d4c',
    3,
    82.0,
    'DNC',
    true,
    '(82.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '037bd687-a35b-5b9b-b7d6-3ee0d3627d4c',
    4,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '037bd687-a35b-5b9b-b7d6-3ee0d3627d4c',
    5,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '037bd687-a35b-5b9b-b7d6-3ee0d3627d4c',
    6,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '037bd687-a35b-5b9b-b7d6-3ee0d3627d4c',
    7,
    32.0,
    NULL,
    false,
    '32.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '33c34af4-38e1-51a1-891c-0c6be8fe4aa9',
    1,
    45.0,
    NULL,
    false,
    '45.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '33c34af4-38e1-51a1-891c-0c6be8fe4aa9',
    2,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '33c34af4-38e1-51a1-891c-0c6be8fe4aa9',
    3,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '33c34af4-38e1-51a1-891c-0c6be8fe4aa9',
    4,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '33c34af4-38e1-51a1-891c-0c6be8fe4aa9',
    5,
    61.0,
    NULL,
    true,
    '(61.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '33c34af4-38e1-51a1-891c-0c6be8fe4aa9',
    6,
    59.0,
    NULL,
    false,
    '59.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '33c34af4-38e1-51a1-891c-0c6be8fe4aa9',
    7,
    35.0,
    NULL,
    false,
    '35.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e60e967c-d55e-5bff-98cd-42c9d464fd55',
    1,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e60e967c-d55e-5bff-98cd-42c9d464fd55',
    2,
    14.0,
    NULL,
    false,
    '14.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e60e967c-d55e-5bff-98cd-42c9d464fd55',
    3,
    82.0,
    'UFD',
    true,
    '(82.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e60e967c-d55e-5bff-98cd-42c9d464fd55',
    4,
    52.0,
    NULL,
    false,
    '52.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e60e967c-d55e-5bff-98cd-42c9d464fd55',
    5,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e60e967c-d55e-5bff-98cd-42c9d464fd55',
    6,
    61.0,
    NULL,
    false,
    '61.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e60e967c-d55e-5bff-98cd-42c9d464fd55',
    7,
    43.0,
    NULL,
    false,
    '43.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3251d780-5d5b-5903-b8c1-9ce65ddde61a',
    1,
    59.0,
    NULL,
    false,
    '59.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3251d780-5d5b-5903-b8c1-9ce65ddde61a',
    2,
    75.0,
    NULL,
    true,
    '(75.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3251d780-5d5b-5903-b8c1-9ce65ddde61a',
    3,
    47.0,
    NULL,
    false,
    '47.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3251d780-5d5b-5903-b8c1-9ce65ddde61a',
    4,
    40.0,
    NULL,
    false,
    '40.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3251d780-5d5b-5903-b8c1-9ce65ddde61a',
    5,
    33.0,
    NULL,
    false,
    '33.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3251d780-5d5b-5903-b8c1-9ce65ddde61a',
    6,
    22.0,
    NULL,
    false,
    '22.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3251d780-5d5b-5903-b8c1-9ce65ddde61a',
    7,
    9.0,
    NULL,
    false,
    '9.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5185ab8-a95d-580b-ab6e-f9282a0a122b',
    1,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5185ab8-a95d-580b-ab6e-f9282a0a122b',
    2,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5185ab8-a95d-580b-ab6e-f9282a0a122b',
    3,
    16.0,
    NULL,
    false,
    '16.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5185ab8-a95d-580b-ab6e-f9282a0a122b',
    4,
    59.0,
    NULL,
    false,
    '59.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5185ab8-a95d-580b-ab6e-f9282a0a122b',
    5,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5185ab8-a95d-580b-ab6e-f9282a0a122b',
    6,
    82.0,
    'DSQ',
    true,
    '(82.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b5185ab8-a95d-580b-ab6e-f9282a0a122b',
    7,
    61.0,
    NULL,
    false,
    '61.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f511ef9-60b6-5072-ba73-d484b467e706',
    1,
    52.0,
    NULL,
    false,
    '52.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f511ef9-60b6-5072-ba73-d484b467e706',
    2,
    82.0,
    'DSQ',
    true,
    '(82.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f511ef9-60b6-5072-ba73-d484b467e706',
    3,
    48.0,
    NULL,
    false,
    '48.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f511ef9-60b6-5072-ba73-d484b467e706',
    4,
    34.0,
    NULL,
    false,
    '34.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f511ef9-60b6-5072-ba73-d484b467e706',
    5,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f511ef9-60b6-5072-ba73-d484b467e706',
    6,
    54.0,
    NULL,
    false,
    '54.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f511ef9-60b6-5072-ba73-d484b467e706',
    7,
    13.0,
    NULL,
    false,
    '13.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8e437246-030d-50f4-b254-ddcd1d1cc751',
    1,
    49.0,
    NULL,
    false,
    '49.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8e437246-030d-50f4-b254-ddcd1d1cc751',
    2,
    33.0,
    NULL,
    false,
    '33.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8e437246-030d-50f4-b254-ddcd1d1cc751',
    3,
    44.0,
    NULL,
    false,
    '44.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8e437246-030d-50f4-b254-ddcd1d1cc751',
    4,
    48.0,
    NULL,
    false,
    '48.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8e437246-030d-50f4-b254-ddcd1d1cc751',
    5,
    28.0,
    NULL,
    false,
    '28.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8e437246-030d-50f4-b254-ddcd1d1cc751',
    6,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8e437246-030d-50f4-b254-ddcd1d1cc751',
    7,
    66.0,
    NULL,
    true,
    '(66.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf6a9a1d-6449-50db-8c78-6bf5905f95cf',
    1,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf6a9a1d-6449-50db-8c78-6bf5905f95cf',
    2,
    18.0,
    NULL,
    false,
    '18.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf6a9a1d-6449-50db-8c78-6bf5905f95cf',
    3,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf6a9a1d-6449-50db-8c78-6bf5905f95cf',
    4,
    68.0,
    NULL,
    true,
    '(68.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf6a9a1d-6449-50db-8c78-6bf5905f95cf',
    5,
    68.0,
    NULL,
    false,
    '68.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf6a9a1d-6449-50db-8c78-6bf5905f95cf',
    6,
    57.0,
    NULL,
    false,
    '57.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bf6a9a1d-6449-50db-8c78-6bf5905f95cf',
    7,
    41.0,
    NULL,
    false,
    '41.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '29274e5a-54db-567e-9b8a-e57712e5aa05',
    1,
    44.0,
    NULL,
    false,
    '44.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '29274e5a-54db-567e-9b8a-e57712e5aa05',
    2,
    44.0,
    NULL,
    false,
    '44.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '29274e5a-54db-567e-9b8a-e57712e5aa05',
    3,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '29274e5a-54db-567e-9b8a-e57712e5aa05',
    4,
    44.0,
    NULL,
    false,
    '44.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '29274e5a-54db-567e-9b8a-e57712e5aa05',
    5,
    43.0,
    NULL,
    false,
    '43.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '29274e5a-54db-567e-9b8a-e57712e5aa05',
    6,
    46.0,
    NULL,
    true,
    '(46.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '29274e5a-54db-567e-9b8a-e57712e5aa05',
    7,
    31.0,
    NULL,
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e98da1d-0cf5-5607-9abe-c8a1bc823b15',
    1,
    75.0,
    NULL,
    true,
    '(75.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e98da1d-0cf5-5607-9abe-c8a1bc823b15',
    2,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e98da1d-0cf5-5607-9abe-c8a1bc823b15',
    3,
    70.0,
    NULL,
    false,
    '70.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e98da1d-0cf5-5607-9abe-c8a1bc823b15',
    4,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e98da1d-0cf5-5607-9abe-c8a1bc823b15',
    5,
    48.0,
    NULL,
    false,
    '48.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e98da1d-0cf5-5607-9abe-c8a1bc823b15',
    6,
    37.0,
    NULL,
    false,
    '37.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e98da1d-0cf5-5607-9abe-c8a1bc823b15',
    7,
    47.0,
    NULL,
    false,
    '47.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20f8bdd0-6116-561f-a8dc-abeceb3ed58f',
    1,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20f8bdd0-6116-561f-a8dc-abeceb3ed58f',
    2,
    45.0,
    NULL,
    false,
    '45.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20f8bdd0-6116-561f-a8dc-abeceb3ed58f',
    3,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20f8bdd0-6116-561f-a8dc-abeceb3ed58f',
    4,
    65.0,
    NULL,
    true,
    '(65.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20f8bdd0-6116-561f-a8dc-abeceb3ed58f',
    5,
    60.0,
    NULL,
    false,
    '60.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20f8bdd0-6116-561f-a8dc-abeceb3ed58f',
    6,
    40.0,
    NULL,
    false,
    '40.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20f8bdd0-6116-561f-a8dc-abeceb3ed58f',
    7,
    52.0,
    NULL,
    false,
    '52.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9d2c4d94-07d4-5d23-bf53-16f0ea91cd2e',
    1,
    51.0,
    NULL,
    false,
    '51.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9d2c4d94-07d4-5d23-bf53-16f0ea91cd2e',
    2,
    38.0,
    NULL,
    false,
    '38.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9d2c4d94-07d4-5d23-bf53-16f0ea91cd2e',
    3,
    46.0,
    NULL,
    false,
    '46.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9d2c4d94-07d4-5d23-bf53-16f0ea91cd2e',
    4,
    32.0,
    NULL,
    false,
    '32.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9d2c4d94-07d4-5d23-bf53-16f0ea91cd2e',
    5,
    38.0,
    NULL,
    false,
    '38.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9d2c4d94-07d4-5d23-bf53-16f0ea91cd2e',
    6,
    38.0,
    NULL,
    false,
    '38.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9d2c4d94-07d4-5d23-bf53-16f0ea91cd2e',
    7,
    60.0,
    NULL,
    true,
    '(60.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5f37073b-dead-5c88-9474-b30124be1b1a',
    1,
    37.0,
    NULL,
    false,
    '37.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5f37073b-dead-5c88-9474-b30124be1b1a',
    2,
    59.0,
    NULL,
    false,
    '59.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5f37073b-dead-5c88-9474-b30124be1b1a',
    3,
    73.0,
    NULL,
    true,
    '(73.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5f37073b-dead-5c88-9474-b30124be1b1a',
    4,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5f37073b-dead-5c88-9474-b30124be1b1a',
    5,
    41.0,
    NULL,
    false,
    '41.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5f37073b-dead-5c88-9474-b30124be1b1a',
    6,
    65.0,
    NULL,
    false,
    '65.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5f37073b-dead-5c88-9474-b30124be1b1a',
    7,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cde1b0fb-bc4a-52c1-b502-a6119fb4e3b1',
    1,
    30.0,
    NULL,
    false,
    '30.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cde1b0fb-bc4a-52c1-b502-a6119fb4e3b1',
    2,
    61.0,
    NULL,
    false,
    '61.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cde1b0fb-bc4a-52c1-b502-a6119fb4e3b1',
    3,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cde1b0fb-bc4a-52c1-b502-a6119fb4e3b1',
    4,
    47.0,
    NULL,
    false,
    '47.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cde1b0fb-bc4a-52c1-b502-a6119fb4e3b1',
    5,
    73.0,
    NULL,
    true,
    '(73.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cde1b0fb-bc4a-52c1-b502-a6119fb4e3b1',
    6,
    32.0,
    NULL,
    false,
    '32.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cde1b0fb-bc4a-52c1-b502-a6119fb4e3b1',
    7,
    51.0,
    NULL,
    false,
    '51.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd9bad9b-5ccb-5f43-80e7-7f68ade00028',
    1,
    74.0,
    NULL,
    true,
    '(74.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd9bad9b-5ccb-5f43-80e7-7f68ade00028',
    2,
    73.0,
    NULL,
    false,
    '73.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd9bad9b-5ccb-5f43-80e7-7f68ade00028',
    3,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd9bad9b-5ccb-5f43-80e7-7f68ade00028',
    4,
    43.0,
    NULL,
    false,
    '43.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd9bad9b-5ccb-5f43-80e7-7f68ade00028',
    5,
    35.0,
    NULL,
    false,
    '35.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd9bad9b-5ccb-5f43-80e7-7f68ade00028',
    6,
    48.0,
    NULL,
    false,
    '48.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'cd9bad9b-5ccb-5f43-80e7-7f68ade00028',
    7,
    36.0,
    NULL,
    false,
    '36.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df3e5978-696d-58bf-9c50-2db2866db8c7',
    1,
    53.0,
    NULL,
    false,
    '53.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df3e5978-696d-58bf-9c50-2db2866db8c7',
    2,
    39.0,
    NULL,
    false,
    '39.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df3e5978-696d-58bf-9c50-2db2866db8c7',
    3,
    33.0,
    NULL,
    false,
    '33.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df3e5978-696d-58bf-9c50-2db2866db8c7',
    4,
    55.0,
    NULL,
    false,
    '55.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df3e5978-696d-58bf-9c50-2db2866db8c7',
    5,
    52.0,
    NULL,
    false,
    '52.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df3e5978-696d-58bf-9c50-2db2866db8c7',
    6,
    78.0,
    NULL,
    true,
    '(78.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'df3e5978-696d-58bf-9c50-2db2866db8c7',
    7,
    23.0,
    NULL,
    false,
    '23.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '739c0a68-3bdf-5907-8a72-5988b051236f',
    1,
    42.0,
    NULL,
    false,
    '42.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '739c0a68-3bdf-5907-8a72-5988b051236f',
    2,
    37.0,
    NULL,
    false,
    '37.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '739c0a68-3bdf-5907-8a72-5988b051236f',
    3,
    31.0,
    NULL,
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '739c0a68-3bdf-5907-8a72-5988b051236f',
    4,
    54.0,
    NULL,
    false,
    '54.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '739c0a68-3bdf-5907-8a72-5988b051236f',
    5,
    65.0,
    NULL,
    true,
    '(65.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '739c0a68-3bdf-5907-8a72-5988b051236f',
    6,
    53.0,
    NULL,
    false,
    '53.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '739c0a68-3bdf-5907-8a72-5988b051236f',
    7,
    40.0,
    NULL,
    false,
    '40.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '34743a77-415b-52ba-808a-f288f3084506',
    1,
    55.0,
    NULL,
    false,
    '55.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '34743a77-415b-52ba-808a-f288f3084506',
    2,
    42.0,
    NULL,
    false,
    '42.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '34743a77-415b-52ba-808a-f288f3084506',
    3,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '34743a77-415b-52ba-808a-f288f3084506',
    4,
    33.0,
    NULL,
    false,
    '33.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '34743a77-415b-52ba-808a-f288f3084506',
    5,
    63.0,
    NULL,
    true,
    '(63.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '34743a77-415b-52ba-808a-f288f3084506',
    6,
    49.0,
    NULL,
    false,
    '49.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '34743a77-415b-52ba-808a-f288f3084506',
    7,
    50.0,
    NULL,
    false,
    '50.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '832003a1-58cc-52cc-931c-6c4d1509dc4f',
    1,
    64.0,
    NULL,
    false,
    '64.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '832003a1-58cc-52cc-931c-6c4d1509dc4f',
    2,
    36.0,
    NULL,
    false,
    '36.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '832003a1-58cc-52cc-931c-6c4d1509dc4f',
    3,
    68.0,
    NULL,
    true,
    '(68.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '832003a1-58cc-52cc-931c-6c4d1509dc4f',
    4,
    67.0,
    NULL,
    false,
    '67.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '832003a1-58cc-52cc-931c-6c4d1509dc4f',
    5,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '832003a1-58cc-52cc-931c-6c4d1509dc4f',
    6,
    11.0,
    NULL,
    false,
    '11.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '832003a1-58cc-52cc-931c-6c4d1509dc4f',
    7,
    62.0,
    NULL,
    false,
    '62.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e9c5bbe-8578-5aca-96d3-31ffae60e5c6',
    1,
    56.0,
    NULL,
    false,
    '56.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e9c5bbe-8578-5aca-96d3-31ffae60e5c6',
    2,
    68.0,
    NULL,
    true,
    '(68.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e9c5bbe-8578-5aca-96d3-31ffae60e5c6',
    3,
    20.0,
    NULL,
    false,
    '20.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e9c5bbe-8578-5aca-96d3-31ffae60e5c6',
    4,
    57.0,
    NULL,
    false,
    '57.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e9c5bbe-8578-5aca-96d3-31ffae60e5c6',
    5,
    50.0,
    NULL,
    false,
    '50.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e9c5bbe-8578-5aca-96d3-31ffae60e5c6',
    6,
    68.0,
    NULL,
    false,
    '68.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2e9c5bbe-8578-5aca-96d3-31ffae60e5c6',
    7,
    12.0,
    NULL,
    false,
    '12.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '28702a61-b612-57b6-8888-8bd7a84d429c',
    1,
    40.0,
    NULL,
    false,
    '40.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '28702a61-b612-57b6-8888-8bd7a84d429c',
    2,
    52.0,
    NULL,
    false,
    '52.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '28702a61-b612-57b6-8888-8bd7a84d429c',
    3,
    59.0,
    NULL,
    false,
    '59.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '28702a61-b612-57b6-8888-8bd7a84d429c',
    4,
    72.0,
    NULL,
    true,
    '(72.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '28702a61-b612-57b6-8888-8bd7a84d429c',
    5,
    71.0,
    NULL,
    false,
    '71.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '28702a61-b612-57b6-8888-8bd7a84d429c',
    6,
    15.0,
    NULL,
    false,
    '15.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '28702a61-b612-57b6-8888-8bd7a84d429c',
    7,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b0842a37-346a-5357-b077-c31bc0cd467b',
    1,
    82.0,
    'UFD',
    true,
    '(82.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b0842a37-346a-5357-b077-c31bc0cd467b',
    2,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b0842a37-346a-5357-b077-c31bc0cd467b',
    3,
    41.0,
    NULL,
    false,
    '41.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b0842a37-346a-5357-b077-c31bc0cd467b',
    4,
    19.0,
    NULL,
    false,
    '19.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b0842a37-346a-5357-b077-c31bc0cd467b',
    5,
    36.0,
    NULL,
    false,
    '36.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b0842a37-346a-5357-b077-c31bc0cd467b',
    6,
    74.0,
    NULL,
    false,
    '74.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b0842a37-346a-5357-b077-c31bc0cd467b',
    7,
    69.0,
    NULL,
    false,
    '69.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ee6edf45-c30b-50ab-869e-b3d60d86705d',
    1,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ee6edf45-c30b-50ab-869e-b3d60d86705d',
    2,
    76.0,
    NULL,
    false,
    '76.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ee6edf45-c30b-50ab-869e-b3d60d86705d',
    3,
    82.0,
    'RET',
    true,
    '(82.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ee6edf45-c30b-50ab-869e-b3d60d86705d',
    4,
    49.0,
    NULL,
    false,
    '49.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ee6edf45-c30b-50ab-869e-b3d60d86705d',
    5,
    42.0,
    NULL,
    false,
    '42.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ee6edf45-c30b-50ab-869e-b3d60d86705d',
    6,
    50.0,
    NULL,
    false,
    '50.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ee6edf45-c30b-50ab-869e-b3d60d86705d',
    7,
    37.0,
    NULL,
    false,
    '37.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f880b35-9105-5d32-81c2-3f707be3ee6a',
    1,
    36.0,
    NULL,
    false,
    '36.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f880b35-9105-5d32-81c2-3f707be3ee6a',
    2,
    54.0,
    NULL,
    false,
    '54.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f880b35-9105-5d32-81c2-3f707be3ee6a',
    3,
    65.0,
    NULL,
    true,
    '(65.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f880b35-9105-5d32-81c2-3f707be3ee6a',
    4,
    45.0,
    NULL,
    false,
    '45.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f880b35-9105-5d32-81c2-3f707be3ee6a',
    5,
    54.0,
    NULL,
    false,
    '54.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f880b35-9105-5d32-81c2-3f707be3ee6a',
    6,
    33.0,
    NULL,
    false,
    '33.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f880b35-9105-5d32-81c2-3f707be3ee6a',
    7,
    57.0,
    NULL,
    false,
    '57.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '33efc76e-d10d-54dc-bfec-7d92b98126d2',
    1,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '33efc76e-d10d-54dc-bfec-7d92b98126d2',
    2,
    70.0,
    NULL,
    false,
    '70.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '33efc76e-d10d-54dc-bfec-7d92b98126d2',
    3,
    32.0,
    NULL,
    false,
    '32.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '33efc76e-d10d-54dc-bfec-7d92b98126d2',
    4,
    50.0,
    NULL,
    false,
    '50.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '33efc76e-d10d-54dc-bfec-7d92b98126d2',
    5,
    45.0,
    NULL,
    false,
    '45.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '33efc76e-d10d-54dc-bfec-7d92b98126d2',
    6,
    63.0,
    NULL,
    false,
    '63.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '33efc76e-d10d-54dc-bfec-7d92b98126d2',
    7,
    74.0,
    NULL,
    true,
    '(74.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fb5f2cf5-bf59-51b0-af96-2ccfdce1b30c',
    1,
    58.0,
    NULL,
    true,
    '(58.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fb5f2cf5-bf59-51b0-af96-2ccfdce1b30c',
    2,
    53.0,
    NULL,
    false,
    '53.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fb5f2cf5-bf59-51b0-af96-2ccfdce1b30c',
    3,
    51.0,
    NULL,
    false,
    '51.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fb5f2cf5-bf59-51b0-af96-2ccfdce1b30c',
    4,
    58.0,
    NULL,
    false,
    '58.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fb5f2cf5-bf59-51b0-af96-2ccfdce1b30c',
    5,
    56.0,
    NULL,
    false,
    '56.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fb5f2cf5-bf59-51b0-af96-2ccfdce1b30c',
    6,
    51.0,
    NULL,
    false,
    '51.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'fb5f2cf5-bf59-51b0-af96-2ccfdce1b30c',
    7,
    21.0,
    NULL,
    false,
    '21.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b4a3cff9-2385-5e8e-8bf7-c754fe8af683',
    1,
    57.0,
    NULL,
    false,
    '57.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b4a3cff9-2385-5e8e-8bf7-c754fe8af683',
    2,
    51.0,
    NULL,
    false,
    '51.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b4a3cff9-2385-5e8e-8bf7-c754fe8af683',
    3,
    58.0,
    NULL,
    false,
    '58.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b4a3cff9-2385-5e8e-8bf7-c754fe8af683',
    4,
    61.0,
    NULL,
    true,
    '(61.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b4a3cff9-2385-5e8e-8bf7-c754fe8af683',
    5,
    44.0,
    NULL,
    false,
    '44.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b4a3cff9-2385-5e8e-8bf7-c754fe8af683',
    6,
    29.0,
    NULL,
    false,
    '29.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b4a3cff9-2385-5e8e-8bf7-c754fe8af683',
    7,
    56.0,
    NULL,
    false,
    '56.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b11e030d-6a96-5fa9-8eb4-c3ad485e13e4',
    1,
    68.0,
    NULL,
    false,
    '68.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b11e030d-6a96-5fa9-8eb4-c3ad485e13e4',
    2,
    43.0,
    NULL,
    false,
    '43.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b11e030d-6a96-5fa9-8eb4-c3ad485e13e4',
    3,
    35.0,
    NULL,
    false,
    '35.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b11e030d-6a96-5fa9-8eb4-c3ad485e13e4',
    4,
    60.0,
    NULL,
    false,
    '60.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b11e030d-6a96-5fa9-8eb4-c3ad485e13e4',
    5,
    25.0,
    NULL,
    false,
    '25.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b11e030d-6a96-5fa9-8eb4-c3ad485e13e4',
    6,
    70.0,
    NULL,
    false,
    '70.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b11e030d-6a96-5fa9-8eb4-c3ad485e13e4',
    7,
    78.0,
    NULL,
    true,
    '(78.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3b1c86b3-9b31-5316-b9e0-761c1b431719',
    1,
    33.0,
    NULL,
    false,
    '33.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3b1c86b3-9b31-5316-b9e0-761c1b431719',
    2,
    63.0,
    NULL,
    false,
    '63.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3b1c86b3-9b31-5316-b9e0-761c1b431719',
    3,
    30.0,
    NULL,
    false,
    '30.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3b1c86b3-9b31-5316-b9e0-761c1b431719',
    4,
    71.0,
    NULL,
    true,
    '(71.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3b1c86b3-9b31-5316-b9e0-761c1b431719',
    5,
    55.0,
    NULL,
    false,
    '55.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3b1c86b3-9b31-5316-b9e0-761c1b431719',
    6,
    58.0,
    NULL,
    false,
    '58.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3b1c86b3-9b31-5316-b9e0-761c1b431719',
    7,
    63.0,
    NULL,
    false,
    '63.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a090e69-f62f-5aa8-a194-ab7dcc991c9d',
    1,
    31.0,
    NULL,
    false,
    '31.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a090e69-f62f-5aa8-a194-ab7dcc991c9d',
    2,
    41.0,
    NULL,
    false,
    '41.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a090e69-f62f-5aa8-a194-ab7dcc991c9d',
    3,
    53.0,
    NULL,
    false,
    '53.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a090e69-f62f-5aa8-a194-ab7dcc991c9d',
    4,
    78.0,
    NULL,
    true,
    '(78.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a090e69-f62f-5aa8-a194-ab7dcc991c9d',
    5,
    62.0,
    NULL,
    false,
    '62.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a090e69-f62f-5aa8-a194-ab7dcc991c9d',
    6,
    75.0,
    NULL,
    false,
    '75.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a090e69-f62f-5aa8-a194-ab7dcc991c9d',
    7,
    46.0,
    NULL,
    false,
    '46.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01780e22-9d5d-5910-996f-63c42528a929',
    1,
    39.0,
    NULL,
    false,
    '39.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01780e22-9d5d-5910-996f-63c42528a929',
    2,
    46.0,
    NULL,
    false,
    '46.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01780e22-9d5d-5910-996f-63c42528a929',
    3,
    61.0,
    NULL,
    false,
    '61.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01780e22-9d5d-5910-996f-63c42528a929',
    4,
    73.0,
    NULL,
    true,
    '(73.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01780e22-9d5d-5910-996f-63c42528a929',
    5,
    67.0,
    NULL,
    false,
    '67.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01780e22-9d5d-5910-996f-63c42528a929',
    6,
    35.0,
    NULL,
    false,
    '35.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01780e22-9d5d-5910-996f-63c42528a929',
    7,
    64.0,
    NULL,
    false,
    '64.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '93bac8b3-9b6c-504d-8847-c7aeced3f6fd',
    1,
    54.0,
    NULL,
    false,
    '54.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '93bac8b3-9b6c-504d-8847-c7aeced3f6fd',
    2,
    64.0,
    NULL,
    false,
    '64.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '93bac8b3-9b6c-504d-8847-c7aeced3f6fd',
    3,
    49.0,
    NULL,
    false,
    '49.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '93bac8b3-9b6c-504d-8847-c7aeced3f6fd',
    4,
    77.0,
    NULL,
    true,
    '(77.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '93bac8b3-9b6c-504d-8847-c7aeced3f6fd',
    5,
    77.0,
    NULL,
    false,
    '77.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '93bac8b3-9b6c-504d-8847-c7aeced3f6fd',
    6,
    24.0,
    NULL,
    false,
    '24.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '93bac8b3-9b6c-504d-8847-c7aeced3f6fd',
    7,
    49.0,
    NULL,
    false,
    '49.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aba52ef2-8c84-5046-a245-8cca33105056',
    1,
    63.0,
    NULL,
    false,
    '63.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aba52ef2-8c84-5046-a245-8cca33105056',
    2,
    57.0,
    NULL,
    false,
    '57.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aba52ef2-8c84-5046-a245-8cca33105056',
    3,
    62.0,
    NULL,
    false,
    '62.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aba52ef2-8c84-5046-a245-8cca33105056',
    4,
    41.0,
    NULL,
    false,
    '41.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aba52ef2-8c84-5046-a245-8cca33105056',
    5,
    26.0,
    NULL,
    false,
    '26.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aba52ef2-8c84-5046-a245-8cca33105056',
    6,
    71.0,
    NULL,
    true,
    '(71.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'aba52ef2-8c84-5046-a245-8cca33105056',
    7,
    68.0,
    NULL,
    false,
    '68.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e40c41b-c4b9-5fa5-8034-d70f11cff1aa',
    1,
    35.0,
    NULL,
    false,
    '35.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e40c41b-c4b9-5fa5-8034-d70f11cff1aa',
    2,
    47.0,
    NULL,
    false,
    '47.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e40c41b-c4b9-5fa5-8034-d70f11cff1aa',
    3,
    52.0,
    NULL,
    false,
    '52.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e40c41b-c4b9-5fa5-8034-d70f11cff1aa',
    4,
    38.0,
    NULL,
    false,
    '38.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e40c41b-c4b9-5fa5-8034-d70f11cff1aa',
    5,
    80.0,
    NULL,
    true,
    '(80.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e40c41b-c4b9-5fa5-8034-d70f11cff1aa',
    6,
    72.0,
    NULL,
    false,
    '72.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6e40c41b-c4b9-5fa5-8034-d70f11cff1aa',
    7,
    75.0,
    NULL,
    false,
    '75.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d7e566d-188b-5f49-8ff8-d7d8a55aba16',
    1,
    66.0,
    NULL,
    false,
    '66.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d7e566d-188b-5f49-8ff8-d7d8a55aba16',
    2,
    71.0,
    NULL,
    true,
    '(71.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d7e566d-188b-5f49-8ff8-d7d8a55aba16',
    3,
    55.0,
    NULL,
    false,
    '55.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d7e566d-188b-5f49-8ff8-d7d8a55aba16',
    4,
    53.0,
    NULL,
    false,
    '53.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d7e566d-188b-5f49-8ff8-d7d8a55aba16',
    5,
    57.0,
    NULL,
    false,
    '57.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d7e566d-188b-5f49-8ff8-d7d8a55aba16',
    6,
    30.0,
    NULL,
    false,
    '30.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d7e566d-188b-5f49-8ff8-d7d8a55aba16',
    7,
    59.0,
    NULL,
    false,
    '59.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a2a9edde-ffae-57e6-9bb7-c1cddfaac214',
    1,
    47.0,
    NULL,
    false,
    '47.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a2a9edde-ffae-57e6-9bb7-c1cddfaac214',
    2,
    49.0,
    NULL,
    false,
    '49.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a2a9edde-ffae-57e6-9bb7-c1cddfaac214',
    3,
    76.0,
    NULL,
    true,
    '(76.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a2a9edde-ffae-57e6-9bb7-c1cddfaac214',
    4,
    70.0,
    NULL,
    false,
    '70.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a2a9edde-ffae-57e6-9bb7-c1cddfaac214',
    5,
    59.0,
    NULL,
    false,
    '59.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a2a9edde-ffae-57e6-9bb7-c1cddfaac214',
    6,
    69.0,
    NULL,
    false,
    '69.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a2a9edde-ffae-57e6-9bb7-c1cddfaac214',
    7,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c498f4f-e8e1-5f73-8cd6-1b72cb573d79',
    1,
    71.0,
    NULL,
    true,
    '(71.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c498f4f-e8e1-5f73-8cd6-1b72cb573d79',
    2,
    55.0,
    NULL,
    false,
    '55.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c498f4f-e8e1-5f73-8cd6-1b72cb573d79',
    3,
    67.0,
    NULL,
    false,
    '67.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c498f4f-e8e1-5f73-8cd6-1b72cb573d79',
    4,
    37.0,
    NULL,
    false,
    '37.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c498f4f-e8e1-5f73-8cd6-1b72cb573d79',
    5,
    39.0,
    NULL,
    false,
    '39.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c498f4f-e8e1-5f73-8cd6-1b72cb573d79',
    6,
    67.0,
    NULL,
    false,
    '67.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c498f4f-e8e1-5f73-8cd6-1b72cb573d79',
    7,
    65.0,
    NULL,
    false,
    '65.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'afe2015a-365e-5363-9b60-1527d1d0ed74',
    1,
    38.0,
    NULL,
    false,
    '38.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'afe2015a-365e-5363-9b60-1527d1d0ed74',
    2,
    62.0,
    NULL,
    false,
    '62.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'afe2015a-365e-5363-9b60-1527d1d0ed74',
    3,
    57.0,
    NULL,
    false,
    '57.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'afe2015a-365e-5363-9b60-1527d1d0ed74',
    4,
    42.0,
    NULL,
    false,
    '42.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'afe2015a-365e-5363-9b60-1527d1d0ed74',
    5,
    72.0,
    NULL,
    false,
    '72.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'afe2015a-365e-5363-9b60-1527d1d0ed74',
    6,
    64.0,
    NULL,
    false,
    '64.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'afe2015a-365e-5363-9b60-1527d1d0ed74',
    7,
    73.0,
    NULL,
    true,
    '(73.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53fe615d-0b86-5819-a882-72a06e3eddce',
    1,
    60.0,
    NULL,
    false,
    '60.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53fe615d-0b86-5819-a882-72a06e3eddce',
    2,
    72.0,
    NULL,
    false,
    '72.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53fe615d-0b86-5819-a882-72a06e3eddce',
    3,
    64.0,
    NULL,
    false,
    '64.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53fe615d-0b86-5819-a882-72a06e3eddce',
    4,
    69.0,
    NULL,
    false,
    '69.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53fe615d-0b86-5819-a882-72a06e3eddce',
    5,
    64.0,
    NULL,
    false,
    '64.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53fe615d-0b86-5819-a882-72a06e3eddce',
    6,
    8.0,
    NULL,
    false,
    '8.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '53fe615d-0b86-5819-a882-72a06e3eddce',
    7,
    76.0,
    NULL,
    true,
    '(76.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1ed19b35-02b4-526f-bee0-ec7c3394bfea',
    1,
    65.0,
    NULL,
    false,
    '65.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1ed19b35-02b4-526f-bee0-ec7c3394bfea',
    2,
    78.0,
    NULL,
    true,
    '(78.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1ed19b35-02b4-526f-bee0-ec7c3394bfea',
    3,
    50.0,
    NULL,
    false,
    '50.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1ed19b35-02b4-526f-bee0-ec7c3394bfea',
    4,
    62.0,
    NULL,
    false,
    '62.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1ed19b35-02b4-526f-bee0-ec7c3394bfea',
    5,
    75.0,
    NULL,
    false,
    '75.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1ed19b35-02b4-526f-bee0-ec7c3394bfea',
    6,
    44.0,
    NULL,
    false,
    '44.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1ed19b35-02b4-526f-bee0-ec7c3394bfea',
    7,
    45.0,
    NULL,
    false,
    '45.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b6d6c82b-e54f-52be-b748-6da5592d3297',
    1,
    62.0,
    NULL,
    false,
    '62.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b6d6c82b-e54f-52be-b748-6da5592d3297',
    2,
    48.0,
    NULL,
    false,
    '48.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b6d6c82b-e54f-52be-b748-6da5592d3297',
    3,
    75.0,
    NULL,
    false,
    '75.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b6d6c82b-e54f-52be-b748-6da5592d3297',
    4,
    66.0,
    NULL,
    false,
    '66.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b6d6c82b-e54f-52be-b748-6da5592d3297',
    5,
    76.0,
    NULL,
    true,
    '(76.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b6d6c82b-e54f-52be-b748-6da5592d3297',
    6,
    43.0,
    NULL,
    false,
    '43.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b6d6c82b-e54f-52be-b748-6da5592d3297',
    7,
    54.0,
    NULL,
    false,
    '54.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdcdd93d-db13-555e-96c7-97035c0696fa',
    1,
    77.0,
    NULL,
    false,
    '77.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdcdd93d-db13-555e-96c7-97035c0696fa',
    2,
    17.0,
    NULL,
    false,
    '17.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdcdd93d-db13-555e-96c7-97035c0696fa',
    3,
    63.0,
    NULL,
    false,
    '63.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdcdd93d-db13-555e-96c7-97035c0696fa',
    4,
    75.0,
    NULL,
    false,
    '75.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdcdd93d-db13-555e-96c7-97035c0696fa',
    5,
    51.0,
    NULL,
    false,
    '51.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdcdd93d-db13-555e-96c7-97035c0696fa',
    6,
    66.0,
    NULL,
    false,
    '66.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bdcdd93d-db13-555e-96c7-97035c0696fa',
    7,
    81.0,
    NULL,
    true,
    '(81.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f416839-a12f-5433-bd9f-4321f5364d9c',
    1,
    78.0,
    NULL,
    false,
    '78.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f416839-a12f-5433-bd9f-4321f5364d9c',
    2,
    60.0,
    NULL,
    false,
    '60.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f416839-a12f-5433-bd9f-4321f5364d9c',
    3,
    40.0,
    NULL,
    false,
    '40.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f416839-a12f-5433-bd9f-4321f5364d9c',
    4,
    79.0,
    NULL,
    true,
    '(79.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f416839-a12f-5433-bd9f-4321f5364d9c',
    5,
    66.0,
    NULL,
    false,
    '66.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f416839-a12f-5433-bd9f-4321f5364d9c',
    6,
    27.0,
    NULL,
    false,
    '27.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7f416839-a12f-5433-bd9f-4321f5364d9c',
    7,
    79.0,
    NULL,
    false,
    '79.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71ebd58a-df62-574d-b665-b5b357de5e72',
    1,
    48.0,
    NULL,
    false,
    '48.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71ebd58a-df62-574d-b665-b5b357de5e72',
    2,
    67.0,
    NULL,
    false,
    '67.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71ebd58a-df62-574d-b665-b5b357de5e72',
    3,
    82.0,
    'UFD',
    true,
    '(82.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71ebd58a-df62-574d-b665-b5b357de5e72',
    4,
    74.0,
    NULL,
    false,
    '74.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71ebd58a-df62-574d-b665-b5b357de5e72',
    5,
    78.0,
    NULL,
    false,
    '78.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71ebd58a-df62-574d-b665-b5b357de5e72',
    6,
    39.0,
    NULL,
    false,
    '39.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71ebd58a-df62-574d-b665-b5b357de5e72',
    7,
    55.0,
    NULL,
    false,
    '55.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9eba869a-11cb-51ca-b6a1-2c359a84d732',
    1,
    67.0,
    NULL,
    false,
    '67.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9eba869a-11cb-51ca-b6a1-2c359a84d732',
    2,
    74.0,
    NULL,
    false,
    '74.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9eba869a-11cb-51ca-b6a1-2c359a84d732',
    3,
    77.0,
    NULL,
    false,
    '77.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9eba869a-11cb-51ca-b6a1-2c359a84d732',
    4,
    80.0,
    NULL,
    true,
    '(80.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9eba869a-11cb-51ca-b6a1-2c359a84d732',
    5,
    53.0,
    NULL,
    false,
    '53.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9eba869a-11cb-51ca-b6a1-2c359a84d732',
    6,
    36.0,
    NULL,
    false,
    '36.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9eba869a-11cb-51ca-b6a1-2c359a84d732',
    7,
    71.0,
    NULL,
    false,
    '71.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4d0c86c0-c120-5dd1-bf48-43a92d6f8cc7',
    1,
    79.0,
    NULL,
    true,
    '(79.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4d0c86c0-c120-5dd1-bf48-43a92d6f8cc7',
    2,
    56.0,
    NULL,
    false,
    '56.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4d0c86c0-c120-5dd1-bf48-43a92d6f8cc7',
    3,
    69.0,
    NULL,
    false,
    '69.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4d0c86c0-c120-5dd1-bf48-43a92d6f8cc7',
    4,
    51.0,
    NULL,
    false,
    '51.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4d0c86c0-c120-5dd1-bf48-43a92d6f8cc7',
    5,
    70.0,
    NULL,
    false,
    '70.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4d0c86c0-c120-5dd1-bf48-43a92d6f8cc7',
    6,
    55.0,
    NULL,
    false,
    '55.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4d0c86c0-c120-5dd1-bf48-43a92d6f8cc7',
    7,
    77.0,
    NULL,
    false,
    '77.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04bb295a-5964-5475-a95a-d818c473d07a',
    1,
    46.0,
    NULL,
    false,
    '46.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04bb295a-5964-5475-a95a-d818c473d07a',
    2,
    77.0,
    NULL,
    false,
    '77.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04bb295a-5964-5475-a95a-d818c473d07a',
    3,
    56.0,
    NULL,
    false,
    '56.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04bb295a-5964-5475-a95a-d818c473d07a',
    4,
    56.0,
    NULL,
    false,
    '56.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04bb295a-5964-5475-a95a-d818c473d07a',
    5,
    82.0,
    'UFD',
    true,
    '(82.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04bb295a-5964-5475-a95a-d818c473d07a',
    6,
    77.0,
    NULL,
    false,
    '77.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04bb295a-5964-5475-a95a-d818c473d07a',
    7,
    72.0,
    NULL,
    false,
    '72.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1be94ed7-abfd-516e-94da-8c90fff3915b',
    1,
    76.0,
    NULL,
    false,
    '76.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1be94ed7-abfd-516e-94da-8c90fff3915b',
    2,
    65.0,
    NULL,
    false,
    '65.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1be94ed7-abfd-516e-94da-8c90fff3915b',
    3,
    66.0,
    NULL,
    false,
    '66.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1be94ed7-abfd-516e-94da-8c90fff3915b',
    4,
    63.0,
    NULL,
    false,
    '63.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1be94ed7-abfd-516e-94da-8c90fff3915b',
    5,
    40.0,
    NULL,
    false,
    '40.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1be94ed7-abfd-516e-94da-8c90fff3915b',
    6,
    79.0,
    NULL,
    false,
    '79.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1be94ed7-abfd-516e-94da-8c90fff3915b',
    7,
    80.0,
    NULL,
    true,
    '(80.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '610d233f-5e62-54b1-a858-71a65c9997f8',
    1,
    61.0,
    NULL,
    false,
    '61.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '610d233f-5e62-54b1-a858-71a65c9997f8',
    2,
    79.0,
    NULL,
    false,
    '79.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '610d233f-5e62-54b1-a858-71a65c9997f8',
    3,
    74.0,
    NULL,
    false,
    '74.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '610d233f-5e62-54b1-a858-71a65c9997f8',
    4,
    81.0,
    NULL,
    true,
    '(81.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '610d233f-5e62-54b1-a858-71a65c9997f8',
    5,
    79.0,
    NULL,
    false,
    '79.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '610d233f-5e62-54b1-a858-71a65c9997f8',
    6,
    73.0,
    NULL,
    false,
    '73.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '610d233f-5e62-54b1-a858-71a65c9997f8',
    7,
    30.0,
    NULL,
    false,
    '30.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62fdeeb4-693b-588e-896c-b282044abf30',
    1,
    69.0,
    NULL,
    false,
    '69.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62fdeeb4-693b-588e-896c-b282044abf30',
    2,
    66.0,
    NULL,
    false,
    '66.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62fdeeb4-693b-588e-896c-b282044abf30',
    3,
    71.0,
    NULL,
    false,
    '71.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62fdeeb4-693b-588e-896c-b282044abf30',
    4,
    76.0,
    NULL,
    true,
    '(76.0)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62fdeeb4-693b-588e-896c-b282044abf30',
    5,
    74.0,
    NULL,
    false,
    '74.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62fdeeb4-693b-588e-896c-b282044abf30',
    6,
    62.0,
    NULL,
    false,
    '62.0'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62fdeeb4-693b-588e-896c-b282044abf30',
    7,
    67.0,
    NULL,
    false,
    '67.0'
);

-- 8. Record in Admin Change Log
INSERT INTO public.admin_change_log (
    actor_email, action, entity_type, entity_id, entity_label, summary, details, source
) VALUES (
    'admin@sailorpath.com',
    'results.import_official_all_japan_optimist_2025',
    'regattas',
    'b72d1f40-7e39-56c8-9a21-82d3e4071592',
    '57th All Japan Optimist Sailing Championship 2025',
    'Imported official final results from 57th All Japan Optimist Championship (81 boats, 7 races)',
    '{"fleetSize": 81, "races": 7, "newProfiles": 66, "existingProfiles": 15, "officialSource": "https://www.racingrulesofsailing.org/documents/169417"}'::jsonb,
    'official-joda-rrs-import'
);

COMMIT;
