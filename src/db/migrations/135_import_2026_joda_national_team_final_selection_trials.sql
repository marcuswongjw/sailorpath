-- Migration 135: Import 2026 JODA National Team Final Selection Trials (Hayama)
-- Event: 2026年JODAナショナルチーム最終選考会
-- Dates: 2026-02-20 to 2026-02-23, Hayama Port, Kanagawa, Japan
-- Official Final PDF: https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link
-- Fleet: 40 boats, 9 races, 1 discard. All 40 sailors already verified in SailorPath.

BEGIN;

-- 1. Regatta Event
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    '94330cd4-2e30-5530-a9fd-dfbef1d33878',
    '2026 JODA National Team Final Selection Trials',
    '2026-joda-national-team-final-selection-trials-hayama',
    '2026-02-20',
    '2026-02-23',
    'Hayama Port, Kanagawa, Japan',
    'Japan Optimist Dinghy Association (JODA) & Chuo JYC',
    '["Optimist"]'::jsonb,
    false,
    true,
    '9 completed races over 3 racing days (Feb 20-22). Feb 23 reserved/concluded.',
    'Low Point System with 1 discard after 9 races.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;

-- 2. Regatta Sheet
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name
) VALUES (
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '94330cd4-2e30-5530-a9fd-dfbef1d33878',
    '2026 JODA National Team Final Selection Trials',
    '2026-joda-national-team-final-selection-trials-hayama',
    '2026-02-20',
    '2026-02-23',
    40,
    'Open',
    9,
    'JPN',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Hayama Port, Kanagawa, Japan',
    'Japan Optimist Dinghy Association (JODA) & Chuo JYC',
    'published',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績'
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count;

-- 3. Regatta Results (40 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'e8c9275c-8cb3-56cd-811a-b4e9540b71ff',
    '2780f0eb-ea28-44e6-ba67-22a35fb9913d',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '松永 虎汰郎',
    'JPN 3351',
    'individual',
    1,
    24.0,
    19.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '1f6d4b00-7920-5989-a840-11edde6fbaf3',
    'eba0deb0-10e4-4d3e-a5e5-5e3fa6287288',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '樋口 颯希',
    'JPN 3443',
    'individual',
    2,
    73.0,
    51.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    'bc93000e-ad3d-5de9-b23d-cdfba602a48f',
    '0c3ea04a-905c-45f1-abb7-a4a917e7da14',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '久保田 夏実',
    'JPN 3375',
    'individual',
    3,
    84.0,
    63.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '01ec940e-88fc-54ca-a6b6-5bc4f7ab24a6',
    '5f6d71a5-1dc3-599c-b9be-377150d4dd3a',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '村中 菜々',
    'JPN 3356',
    'individual',
    4,
    98.0,
    67.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    'ba66d305-57b2-576b-a177-179258c05487',
    '1ac9dc89-783e-56c9-8c8d-785a5e10cccc',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '山田 晟',
    'JPN 3394',
    'individual',
    5,
    95.0,
    74.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '62a19f5b-db49-5b21-8966-edbed4691f96',
    '89eed0ba-4c8d-49dc-a03e-6624a364f93c',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '中村 海翔',
    'JPN 3444',
    'individual',
    6,
    112.0,
    82.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '32c0cf2d-d9bc-507c-9f5a-e9219dff3018',
    'e36afcc6-d8af-589b-88a8-fa608d94a470',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '井上 はる',
    'JPN 3489',
    'individual',
    7,
    128.0,
    94.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '7bb44422-ce48-5a14-b4c8-5c4989e80857',
    '6471b3cc-1310-54f1-945c-c06115d54996',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '角森 帆朱',
    'JPN 3355',
    'individual',
    8,
    140.0,
    99.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '6684a975-73a8-5d79-af0a-df6ae03dcf84',
    'b8f8b747-639d-5920-adfe-ec84e34cc40b',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '平野 陽也',
    'JPN 3337',
    'individual',
    9,
    134.0,
    106.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '652bc94c-5d73-5fd7-90bf-753d93212475',
    '2b82f965-5e0d-5063-bb05-b3f1cf099740',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '竹内 海聖',
    'JPN 3344',
    'individual',
    10,
    148.0,
    107.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '674f0da0-8c9b-5893-8178-b41973c4049a',
    'd5866bfe-8e21-585d-b8e7-2b76cb8feba7',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '中田 琴海',
    'JPN 3446',
    'individual',
    11,
    140.1,
    107.1,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    'b2e08db1-4a59-5614-b92a-605813f9f989',
    '234b96c7-73e8-59f9-832d-6d9015917659',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '宮武 大我',
    'JPN 3422',
    'individual',
    12,
    144.0,
    109.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    'bde9982a-6902-5e28-9a5c-9261c6b9982b',
    'f328eec8-af48-5826-9ffd-36ba379122c2',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '樋口 耀紀',
    'JPN 3442',
    'individual',
    13,
    154.0,
    113.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '3650d1e8-ca54-5a78-936c-bbe915305f25',
    'f0bd203e-94f4-5484-8ddf-cbdd19aab450',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '笠木 蓮斗',
    'JPN 3430',
    'individual',
    14,
    146.0,
    120.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '4b6c2565-596c-5f2f-8c19-bf70a421f054',
    'b24f2640-1c36-50ea-8fa3-243a3a48f08a',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '亀田 留衣',
    'JPN 3474',
    'individual',
    15,
    146.0,
    122.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '678dc021-0a4b-5553-9950-3255e7377c63',
    'ad4668e3-78b5-5402-a9a4-7641af07c063',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '伊藤 照真',
    'JPN 3440',
    'individual',
    16,
    166.0,
    136.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '2a01d9b8-f863-5ee6-a239-9855bb86cbb8',
    '5630e6fd-a5f6-537f-8754-461b642feccd',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '山本 健瑚',
    'JPN 3441',
    'individual',
    17,
    178.0,
    137.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    'd6cd5d4a-b83a-5acf-9779-339713a67222',
    '18e73ee3-3792-59f9-aa32-649ca6ca325d',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '登田 直',
    'JPN 3423',
    'individual',
    18,
    174.0,
    138.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '983d4056-7cd6-5a41-a1af-cac4c2904c7b',
    '3d6c3a59-ea5b-5d31-a9eb-c4db5a510958',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '直井 舷太',
    'JPN 3253',
    'individual',
    19,
    183.0,
    147.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '2589adb2-250c-5fb2-b59b-934b4da23dca',
    '740ac6c8-3424-579c-900c-73348b365168',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '今井 晴也',
    'JPN 3467',
    'individual',
    20,
    190.0,
    149.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '18bc03d6-3fc8-5ae0-acd2-8f2edad8c3ed',
    '5f728a1a-6dc6-5da1-a806-0beeb4f3010c',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '内田 海音',
    'JPN 3288',
    'individual',
    21,
    193.0,
    152.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    'eb2884e1-8395-5dcb-92e6-4cb0a8cdea54',
    'c3777043-8cd8-525e-8a1e-be9d476a4ccc',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '阪間 俊仁',
    'JPN 3154',
    'individual',
    22,
    196.0,
    155.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '74e28a91-3733-5853-aba9-aa80e7cde4bc',
    'e373e71d-025b-55b0-acf6-ce6dfb8eb06c',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '吉岡 祐月',
    'JPN 3315',
    'individual',
    23,
    212.0,
    171.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    'd0b9eed1-8bac-5c03-a5e2-c8febf311ba8',
    '5fd47d5e-bc45-545d-8daa-0cc63bc1c84e',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '安藤 果帆',
    'JPN 3455',
    'individual',
    24,
    213.0,
    172.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '19904c48-0ad1-5395-9c39-a69daad51c2c',
    '1af41791-9ec0-59c0-89d9-36d65f21dc4e',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '今井 創也',
    'JPN 3168',
    'individual',
    25,
    224.0,
    183.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '56adc788-4ca6-5a2f-9c3f-35811d816ba1',
    'ff62d4d8-c48a-587d-ab98-b19b551126cb',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '岩﨑 楓太',
    'JPN 3232',
    'individual',
    26,
    224.0,
    183.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '545a2ec3-a028-56af-88b8-b68707c5a618',
    '659a7737-50cd-5c70-ae0b-7827574aac17',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '宮﨑 心桜',
    'JPN 3476',
    'individual',
    27,
    229.0,
    188.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    'eb1cd103-27e6-54cc-835c-239601680b3f',
    'b0a725c6-026d-511e-8333-9adde320a379',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '石川 凛乃',
    'JPN 3488',
    'individual',
    28,
    233.0,
    192.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    'e19bd1f6-7185-5ce2-9310-bca0c7d8442f',
    'b62a8c3f-fdc5-5574-85c1-e0731ba62fda',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '富岡 英恵',
    'JPN 3211',
    'individual',
    29,
    235.0,
    194.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '414b41a3-ee25-5197-a659-6108d26bb0d8',
    '823c8645-7014-5734-8a89-0aa2a1739d46',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '坂口 美結',
    'JPN 3415',
    'individual',
    30,
    241.0,
    200.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '8647f1e0-7d24-5a95-810e-8bebb1869efe',
    'd5b1460c-ffb5-5bb9-bd8b-7f4e2c4bfab1',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '辰野 志奈乃',
    'JPN 3425',
    'individual',
    31,
    241.0,
    200.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '714ceb26-b200-5870-a2ab-a6a6b9a4d689',
    '6e3927aa-a435-5bc6-bb40-867479f8ed5d',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '水谷 智子',
    'JPN 3041',
    'individual',
    32,
    243.0,
    202.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    'a61cd722-d3c7-5d72-9df8-3524ce90e01d',
    '136afe66-3153-513f-b61e-20a2225c0bfb',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '井上 豊海',
    'JPN 3470',
    'individual',
    33,
    248.0,
    207.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '06d36ca3-1979-53ff-9990-7eb5e5a9244e',
    '13bd0aab-ee6e-5536-8fb7-836169c66fac',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '椎名 悠貴',
    'JPN 3448',
    'individual',
    34,
    260.0,
    219.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '04411d16-f921-581f-92a8-490f9aa1590f',
    'be617744-2ecc-57fe-b837-85b80ab95e06',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '城石 朋春',
    'JPN 3250',
    'individual',
    35,
    265.0,
    224.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '4706aa2a-2a55-57ed-8f11-f9737a24abad',
    '2e9a2d64-59c9-58e5-93c7-060df21e4417',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '今村 颯人',
    'JPN 3404',
    'individual',
    36,
    269.0,
    228.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    'f7a4d6dc-2c33-5e31-9662-741d669bbdf3',
    'c0a8cdf2-00af-5908-bb52-6f52f8d26e21',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '栗本 悠里',
    'JPN 3458',
    'individual',
    37,
    292.0,
    251.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    'e48104ac-d668-5d53-8a5e-dc834dc577be',
    'c70ced96-bb4c-5869-9d1d-38d1ec05f79f',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '根岸 渚沙',
    'JPN 3169',
    'individual',
    38,
    295.0,
    254.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '71319fc7-abeb-58cd-b421-aaadfeb3a5b1',
    '88a4cc04-e045-553c-8d3e-d4dc02c8b92c',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '牧野 紗奈',
    'JPN 3202',
    'individual',
    39,
    295.0,
    254.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
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
    '12577933-438f-5b67-828b-150c5e567d7a',
    '3e685fbd-6579-5195-8537-442cd9a85771',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '堀 冬馬',
    'JPN 3457',
    'individual',
    40,
    322.0,
    281.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link',
    '2026 JODA ナショナルチーム最終選考会 成績',
    'pdf',
    'Official final results from JODA 2026 National Team Final Selection Trials, Hayama Port. Signed 2026/2/24 20:43.',
    now()
) ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

-- 4. Regatta Result Participants (40 participants)
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b88ff12c-a194-57cf-bc11-7057f1bded64',
    'e8c9275c-8cb3-56cd-811a-b4e9540b71ff',
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
    'f175c104-b701-5459-bfcc-f4374030eab0',
    '1f6d4b00-7920-5989-a840-11edde6fbaf3',
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
    '99675fa6-f453-5e77-81c8-1e5be89a59a3',
    'bc93000e-ad3d-5de9-b23d-cdfba602a48f',
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
    '77ee4d00-0362-560b-a737-86aac30a3680',
    '01ec940e-88fc-54ca-a6b6-5bc4f7ab24a6',
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
    '40507641-c7c7-5e90-9462-e744b1d16296',
    'ba66d305-57b2-576b-a177-179258c05487',
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
    '2568fe18-c185-56e4-b6e8-b7203ee74f81',
    '62a19f5b-db49-5b21-8966-edbed4691f96',
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
    '22d2c99c-c978-59e5-98c3-2ef99cdb9380',
    '32c0cf2d-d9bc-507c-9f5a-e9219dff3018',
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
    'd8915197-1574-581c-91bc-045213c60e8d',
    '7bb44422-ce48-5a14-b4c8-5c4989e80857',
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
    '3a5e8d48-becd-5f2a-89d0-e300b05670e9',
    '6684a975-73a8-5d79-af0a-df6ae03dcf84',
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
    '00c57241-29e9-5148-9ac9-77b0bc96445e',
    '652bc94c-5d73-5fd7-90bf-753d93212475',
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
    'ee85d728-4b94-5bd5-bf5c-b90ebfdd0eea',
    '674f0da0-8c9b-5893-8178-b41973c4049a',
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
    '62852bed-8e37-5841-83fa-0192d2b9bf76',
    'b2e08db1-4a59-5614-b92a-605813f9f989',
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
    '015e15af-bccd-548b-9d52-d5c46e268526',
    'bde9982a-6902-5e28-9a5c-9261c6b9982b',
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
    '484d7250-1423-5924-a8f6-5136e0d275a0',
    '3650d1e8-ca54-5a78-936c-bbe915305f25',
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
    '1d024e9e-69d6-5d69-9a77-0618d7ddf28d',
    '4b6c2565-596c-5f2f-8c19-bf70a421f054',
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
    'ec446e68-43ba-55d8-957b-30829e8ff767',
    '678dc021-0a4b-5553-9950-3255e7377c63',
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
    '01a22100-b18c-5849-b652-ac3a5091c974',
    '2a01d9b8-f863-5ee6-a239-9855bb86cbb8',
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
    'd2228b22-9be3-58fa-8b02-6925c57e84c2',
    'd6cd5d4a-b83a-5acf-9779-339713a67222',
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
    'c58689cf-1fbd-5017-a344-a7cc02f47926',
    '983d4056-7cd6-5a41-a1af-cac4c2904c7b',
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
    '81c69205-7f19-5750-99f1-f421f1b5534b',
    '2589adb2-250c-5fb2-b59b-934b4da23dca',
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
    '5b349719-5342-55e4-8ead-2dff92f76f10',
    '18bc03d6-3fc8-5ae0-acd2-8f2edad8c3ed',
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
    '6f2ed266-b1fb-55a6-8115-179da9568edb',
    'eb2884e1-8395-5dcb-92e6-4cb0a8cdea54',
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
    'f140b584-4a00-578d-8cdf-6f6558116a7f',
    '74e28a91-3733-5853-aba9-aa80e7cde4bc',
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
    '2875adca-7d00-5785-b6a6-56033e85df9b',
    'd0b9eed1-8bac-5c03-a5e2-c8febf311ba8',
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
    '80669208-907c-5079-b77c-60faec76109d',
    '19904c48-0ad1-5395-9c39-a69daad51c2c',
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
    '5359de1c-de26-526a-b816-60763e3ac562',
    '56adc788-4ca6-5a2f-9c3f-35811d816ba1',
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
    '16ff7172-384c-53f6-9ad3-9df54686ca98',
    '545a2ec3-a028-56af-88b8-b68707c5a618',
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
    'a46ba96f-c6d5-5fdb-8897-69b478f45d18',
    'eb1cd103-27e6-54cc-835c-239601680b3f',
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
    'd836c147-c14c-5ac6-a2a7-8dfcd4c9088f',
    'e19bd1f6-7185-5ce2-9310-bca0c7d8442f',
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
    '47b073e6-8420-5857-9347-f90cbb407b35',
    '414b41a3-ee25-5197-a659-6108d26bb0d8',
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
    'ac2fad2c-2d31-52ca-96c4-a2acc5107128',
    '8647f1e0-7d24-5a95-810e-8bebb1869efe',
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
    '57c83886-53e2-527b-a45f-d9ec533cd4bc',
    '714ceb26-b200-5870-a2ab-a6a6b9a4d689',
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
    '0789e78e-2472-5f4f-9b36-04f63951a2a2',
    'a61cd722-d3c7-5d72-9df8-3524ce90e01d',
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
    '06a5ceb2-1ba5-5286-ae28-d84a86c9c0b8',
    '06d36ca3-1979-53ff-9990-7eb5e5a9244e',
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
    '7189bf02-f3ba-5a93-85ce-1c9866a9230b',
    '04411d16-f921-581f-92a8-490f9aa1590f',
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
    'ab893a8d-ce1e-5a87-9e73-fdc13ae66eef',
    '4706aa2a-2a55-57ed-8f11-f9737a24abad',
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
    'a928ca6e-ec19-5ef9-a362-44503e925bfb',
    'f7a4d6dc-2c33-5e31-9662-741d669bbdf3',
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
    'd2f6030a-3a7e-528e-869a-0d552f059d4b',
    'e48104ac-d668-5d53-8a5e-dc834dc577be',
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
    'a29e5124-26d8-5319-bd73-7bef9687e131',
    '71319fc7-abeb-58cd-b421-aaadfeb3a5b1',
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
    '895aaa48-e316-5de9-9694-056f88c7c84b',
    '12577933-438f-5b67-828b-150c5e567d7a',
    '3e685fbd-6579-5195-8537-442cd9a85771',
    '堀 冬馬',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;

-- 5. Race Results (360 individual race scores)
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8c9275c-8cb3-56cd-811a-b4e9540b71ff',
    1,
    5.0,
    NULL,
    true,
    '(5)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8c9275c-8cb3-56cd-811a-b4e9540b71ff',
    2,
    2.0,
    NULL,
    false,
    '2'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8c9275c-8cb3-56cd-811a-b4e9540b71ff',
    3,
    1.0,
    NULL,
    false,
    '1'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8c9275c-8cb3-56cd-811a-b4e9540b71ff',
    4,
    5.0,
    NULL,
    false,
    '5'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8c9275c-8cb3-56cd-811a-b4e9540b71ff',
    5,
    4.0,
    NULL,
    false,
    '4'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8c9275c-8cb3-56cd-811a-b4e9540b71ff',
    6,
    3.0,
    NULL,
    false,
    '3'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8c9275c-8cb3-56cd-811a-b4e9540b71ff',
    7,
    1.0,
    NULL,
    false,
    '1'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8c9275c-8cb3-56cd-811a-b4e9540b71ff',
    8,
    1.0,
    NULL,
    false,
    '1'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e8c9275c-8cb3-56cd-811a-b4e9540b71ff',
    9,
    2.0,
    NULL,
    false,
    '2'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f6d4b00-7920-5989-a840-11edde6fbaf3',
    1,
    10.0,
    NULL,
    false,
    '10'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f6d4b00-7920-5989-a840-11edde6fbaf3',
    2,
    1.0,
    NULL,
    false,
    '1'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f6d4b00-7920-5989-a840-11edde6fbaf3',
    3,
    9.0,
    NULL,
    false,
    '9'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f6d4b00-7920-5989-a840-11edde6fbaf3',
    4,
    4.0,
    NULL,
    false,
    '4'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f6d4b00-7920-5989-a840-11edde6fbaf3',
    5,
    22.0,
    NULL,
    true,
    '(22)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f6d4b00-7920-5989-a840-11edde6fbaf3',
    6,
    4.0,
    NULL,
    false,
    '4'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f6d4b00-7920-5989-a840-11edde6fbaf3',
    7,
    3.0,
    NULL,
    false,
    '3'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f6d4b00-7920-5989-a840-11edde6fbaf3',
    8,
    4.0,
    NULL,
    false,
    '4'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1f6d4b00-7920-5989-a840-11edde6fbaf3',
    9,
    16.0,
    NULL,
    false,
    '16'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc93000e-ad3d-5de9-b23d-cdfba602a48f',
    1,
    4.0,
    NULL,
    false,
    '4'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc93000e-ad3d-5de9-b23d-cdfba602a48f',
    2,
    11.0,
    NULL,
    false,
    '11'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc93000e-ad3d-5de9-b23d-cdfba602a48f',
    3,
    2.0,
    NULL,
    false,
    '2'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc93000e-ad3d-5de9-b23d-cdfba602a48f',
    4,
    21.0,
    NULL,
    true,
    '(21)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc93000e-ad3d-5de9-b23d-cdfba602a48f',
    5,
    18.0,
    NULL,
    false,
    '18'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc93000e-ad3d-5de9-b23d-cdfba602a48f',
    6,
    5.0,
    NULL,
    false,
    '5'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc93000e-ad3d-5de9-b23d-cdfba602a48f',
    7,
    13.0,
    NULL,
    false,
    '13'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc93000e-ad3d-5de9-b23d-cdfba602a48f',
    8,
    3.0,
    NULL,
    false,
    '3'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc93000e-ad3d-5de9-b23d-cdfba602a48f',
    9,
    7.0,
    NULL,
    false,
    '7'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01ec940e-88fc-54ca-a6b6-5bc4f7ab24a6',
    1,
    11.0,
    NULL,
    false,
    '11'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01ec940e-88fc-54ca-a6b6-5bc4f7ab24a6',
    2,
    6.0,
    NULL,
    false,
    '6'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01ec940e-88fc-54ca-a6b6-5bc4f7ab24a6',
    3,
    4.0,
    NULL,
    false,
    '4'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01ec940e-88fc-54ca-a6b6-5bc4f7ab24a6',
    4,
    19.0,
    NULL,
    false,
    '19'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01ec940e-88fc-54ca-a6b6-5bc4f7ab24a6',
    5,
    3.0,
    NULL,
    false,
    '3'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01ec940e-88fc-54ca-a6b6-5bc4f7ab24a6',
    6,
    7.0,
    NULL,
    false,
    '7'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01ec940e-88fc-54ca-a6b6-5bc4f7ab24a6',
    7,
    2.0,
    NULL,
    false,
    '2'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01ec940e-88fc-54ca-a6b6-5bc4f7ab24a6',
    8,
    31.0,
    NULL,
    true,
    '(31)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '01ec940e-88fc-54ca-a6b6-5bc4f7ab24a6',
    9,
    15.0,
    NULL,
    false,
    '15'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ba66d305-57b2-576b-a177-179258c05487',
    1,
    7.0,
    NULL,
    false,
    '7'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ba66d305-57b2-576b-a177-179258c05487',
    2,
    4.0,
    NULL,
    false,
    '4'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ba66d305-57b2-576b-a177-179258c05487',
    3,
    21.0,
    NULL,
    true,
    '(21)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ba66d305-57b2-576b-a177-179258c05487',
    4,
    8.0,
    NULL,
    false,
    '8'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ba66d305-57b2-576b-a177-179258c05487',
    5,
    11.0,
    NULL,
    false,
    '11'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ba66d305-57b2-576b-a177-179258c05487',
    6,
    2.0,
    NULL,
    false,
    '2'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ba66d305-57b2-576b-a177-179258c05487',
    7,
    9.0,
    NULL,
    false,
    '9'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ba66d305-57b2-576b-a177-179258c05487',
    8,
    21.0,
    NULL,
    false,
    '21'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ba66d305-57b2-576b-a177-179258c05487',
    9,
    12.0,
    NULL,
    false,
    '12'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62a19f5b-db49-5b21-8966-edbed4691f96',
    1,
    2.0,
    NULL,
    false,
    '2'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62a19f5b-db49-5b21-8966-edbed4691f96',
    2,
    28.0,
    NULL,
    false,
    '28'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62a19f5b-db49-5b21-8966-edbed4691f96',
    3,
    10.0,
    NULL,
    false,
    '10'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62a19f5b-db49-5b21-8966-edbed4691f96',
    4,
    9.0,
    NULL,
    false,
    '9'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62a19f5b-db49-5b21-8966-edbed4691f96',
    5,
    1.0,
    NULL,
    false,
    '1'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62a19f5b-db49-5b21-8966-edbed4691f96',
    6,
    29.0,
    NULL,
    false,
    '29'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62a19f5b-db49-5b21-8966-edbed4691f96',
    7,
    30.0,
    NULL,
    true,
    '(30)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62a19f5b-db49-5b21-8966-edbed4691f96',
    8,
    2.0,
    NULL,
    false,
    '2'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '62a19f5b-db49-5b21-8966-edbed4691f96',
    9,
    1.0,
    NULL,
    false,
    '1'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32c0cf2d-d9bc-507c-9f5a-e9219dff3018',
    1,
    19.0,
    NULL,
    false,
    '19'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32c0cf2d-d9bc-507c-9f5a-e9219dff3018',
    2,
    7.0,
    NULL,
    false,
    '7'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32c0cf2d-d9bc-507c-9f5a-e9219dff3018',
    3,
    13.0,
    NULL,
    false,
    '13'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32c0cf2d-d9bc-507c-9f5a-e9219dff3018',
    4,
    2.0,
    NULL,
    false,
    '2'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32c0cf2d-d9bc-507c-9f5a-e9219dff3018',
    5,
    24.0,
    NULL,
    false,
    '24'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32c0cf2d-d9bc-507c-9f5a-e9219dff3018',
    6,
    16.0,
    NULL,
    false,
    '16'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32c0cf2d-d9bc-507c-9f5a-e9219dff3018',
    7,
    34.0,
    NULL,
    true,
    '(34)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32c0cf2d-d9bc-507c-9f5a-e9219dff3018',
    8,
    5.0,
    NULL,
    false,
    '5'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '32c0cf2d-d9bc-507c-9f5a-e9219dff3018',
    9,
    8.0,
    NULL,
    false,
    '8'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7bb44422-ce48-5a14-b4c8-5c4989e80857',
    1,
    3.0,
    NULL,
    false,
    '3'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7bb44422-ce48-5a14-b4c8-5c4989e80857',
    2,
    3.0,
    NULL,
    false,
    '3'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7bb44422-ce48-5a14-b4c8-5c4989e80857',
    3,
    6.0,
    NULL,
    false,
    '6'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7bb44422-ce48-5a14-b4c8-5c4989e80857',
    4,
    41.0,
    'DNF',
    true,
    '(DNF 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7bb44422-ce48-5a14-b4c8-5c4989e80857',
    5,
    6.0,
    NULL,
    false,
    '6'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7bb44422-ce48-5a14-b4c8-5c4989e80857',
    6,
    32.0,
    NULL,
    false,
    '32'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7bb44422-ce48-5a14-b4c8-5c4989e80857',
    7,
    38.0,
    NULL,
    false,
    '38'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7bb44422-ce48-5a14-b4c8-5c4989e80857',
    8,
    8.0,
    NULL,
    false,
    '8'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7bb44422-ce48-5a14-b4c8-5c4989e80857',
    9,
    3.0,
    NULL,
    false,
    '3'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6684a975-73a8-5d79-af0a-df6ae03dcf84',
    1,
    27.0,
    NULL,
    false,
    '27'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6684a975-73a8-5d79-af0a-df6ae03dcf84',
    2,
    13.0,
    NULL,
    false,
    '13'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6684a975-73a8-5d79-af0a-df6ae03dcf84',
    3,
    7.0,
    NULL,
    false,
    '7'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6684a975-73a8-5d79-af0a-df6ae03dcf84',
    4,
    3.0,
    NULL,
    false,
    '3'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6684a975-73a8-5d79-af0a-df6ae03dcf84',
    5,
    19.0,
    NULL,
    false,
    '19'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6684a975-73a8-5d79-af0a-df6ae03dcf84',
    6,
    18.0,
    NULL,
    false,
    '18'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6684a975-73a8-5d79-af0a-df6ae03dcf84',
    7,
    28.0,
    NULL,
    true,
    '(28)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6684a975-73a8-5d79-af0a-df6ae03dcf84',
    8,
    13.0,
    NULL,
    false,
    '13'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '6684a975-73a8-5d79-af0a-df6ae03dcf84',
    9,
    6.0,
    NULL,
    false,
    '6'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '652bc94c-5d73-5fd7-90bf-753d93212475',
    1,
    16.0,
    NULL,
    false,
    '16'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '652bc94c-5d73-5fd7-90bf-753d93212475',
    2,
    18.0,
    NULL,
    false,
    '18'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '652bc94c-5d73-5fd7-90bf-753d93212475',
    3,
    3.0,
    NULL,
    false,
    '3'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '652bc94c-5d73-5fd7-90bf-753d93212475',
    4,
    15.0,
    NULL,
    false,
    '15'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '652bc94c-5d73-5fd7-90bf-753d93212475',
    5,
    2.0,
    NULL,
    false,
    '2'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '652bc94c-5d73-5fd7-90bf-753d93212475',
    6,
    9.0,
    NULL,
    false,
    '9'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '652bc94c-5d73-5fd7-90bf-753d93212475',
    7,
    20.0,
    NULL,
    false,
    '20'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '652bc94c-5d73-5fd7-90bf-753d93212475',
    8,
    24.0,
    NULL,
    false,
    '24'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '652bc94c-5d73-5fd7-90bf-753d93212475',
    9,
    41.0,
    'DNF',
    true,
    '(DNF 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '674f0da0-8c9b-5893-8178-b41973c4049a',
    1,
    5.1,
    'STP',
    false,
    'STP 5.1'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '674f0da0-8c9b-5893-8178-b41973c4049a',
    2,
    17.0,
    NULL,
    false,
    '17'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '674f0da0-8c9b-5893-8178-b41973c4049a',
    3,
    28.0,
    NULL,
    false,
    '28'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '674f0da0-8c9b-5893-8178-b41973c4049a',
    4,
    13.0,
    NULL,
    false,
    '13'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '674f0da0-8c9b-5893-8178-b41973c4049a',
    5,
    7.0,
    NULL,
    false,
    '7'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '674f0da0-8c9b-5893-8178-b41973c4049a',
    6,
    6.0,
    NULL,
    false,
    '6'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '674f0da0-8c9b-5893-8178-b41973c4049a',
    7,
    33.0,
    NULL,
    true,
    '(33)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '674f0da0-8c9b-5893-8178-b41973c4049a',
    8,
    18.0,
    NULL,
    false,
    '18'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '674f0da0-8c9b-5893-8178-b41973c4049a',
    9,
    13.0,
    NULL,
    false,
    '13'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b2e08db1-4a59-5614-b92a-605813f9f989',
    1,
    6.0,
    NULL,
    false,
    '6'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b2e08db1-4a59-5614-b92a-605813f9f989',
    2,
    35.0,
    NULL,
    true,
    '(35)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b2e08db1-4a59-5614-b92a-605813f9f989',
    3,
    5.0,
    NULL,
    false,
    '5'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b2e08db1-4a59-5614-b92a-605813f9f989',
    4,
    12.0,
    NULL,
    false,
    '12'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b2e08db1-4a59-5614-b92a-605813f9f989',
    5,
    15.0,
    NULL,
    false,
    '15'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b2e08db1-4a59-5614-b92a-605813f9f989',
    6,
    17.0,
    NULL,
    false,
    '17'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b2e08db1-4a59-5614-b92a-605813f9f989',
    7,
    10.0,
    NULL,
    false,
    '10'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b2e08db1-4a59-5614-b92a-605813f9f989',
    8,
    22.0,
    NULL,
    false,
    '22'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b2e08db1-4a59-5614-b92a-605813f9f989',
    9,
    22.0,
    NULL,
    false,
    '22'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bde9982a-6902-5e28-9a5c-9261c6b9982b',
    1,
    22.0,
    NULL,
    false,
    '22'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bde9982a-6902-5e28-9a5c-9261c6b9982b',
    2,
    12.0,
    NULL,
    false,
    '12'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bde9982a-6902-5e28-9a5c-9261c6b9982b',
    3,
    11.0,
    NULL,
    false,
    '11'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bde9982a-6902-5e28-9a5c-9261c6b9982b',
    4,
    1.0,
    NULL,
    false,
    '1'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bde9982a-6902-5e28-9a5c-9261c6b9982b',
    5,
    41.0,
    'RET',
    true,
    '(RET 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bde9982a-6902-5e28-9a5c-9261c6b9982b',
    6,
    10.0,
    NULL,
    false,
    '10'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bde9982a-6902-5e28-9a5c-9261c6b9982b',
    7,
    8.0,
    NULL,
    false,
    '8'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bde9982a-6902-5e28-9a5c-9261c6b9982b',
    8,
    25.0,
    NULL,
    false,
    '25'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bde9982a-6902-5e28-9a5c-9261c6b9982b',
    9,
    24.0,
    NULL,
    false,
    '24'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3650d1e8-ca54-5a78-936c-bbe915305f25',
    1,
    15.0,
    NULL,
    false,
    '15'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3650d1e8-ca54-5a78-936c-bbe915305f25',
    2,
    10.0,
    NULL,
    false,
    '10'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3650d1e8-ca54-5a78-936c-bbe915305f25',
    3,
    14.0,
    NULL,
    false,
    '14'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3650d1e8-ca54-5a78-936c-bbe915305f25',
    4,
    11.0,
    NULL,
    false,
    '11'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3650d1e8-ca54-5a78-936c-bbe915305f25',
    5,
    23.0,
    NULL,
    false,
    '23'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3650d1e8-ca54-5a78-936c-bbe915305f25',
    6,
    26.0,
    NULL,
    true,
    '(26)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3650d1e8-ca54-5a78-936c-bbe915305f25',
    7,
    6.0,
    NULL,
    false,
    '6'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3650d1e8-ca54-5a78-936c-bbe915305f25',
    8,
    20.0,
    NULL,
    false,
    '20'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3650d1e8-ca54-5a78-936c-bbe915305f25',
    9,
    21.0,
    NULL,
    false,
    '21'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b6c2565-596c-5f2f-8c19-bf70a421f054',
    1,
    24.0,
    NULL,
    true,
    '(24)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b6c2565-596c-5f2f-8c19-bf70a421f054',
    2,
    14.0,
    NULL,
    false,
    '14'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b6c2565-596c-5f2f-8c19-bf70a421f054',
    3,
    8.0,
    NULL,
    false,
    '8'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b6c2565-596c-5f2f-8c19-bf70a421f054',
    4,
    16.0,
    NULL,
    false,
    '16'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b6c2565-596c-5f2f-8c19-bf70a421f054',
    5,
    20.0,
    NULL,
    false,
    '20'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b6c2565-596c-5f2f-8c19-bf70a421f054',
    6,
    14.0,
    NULL,
    false,
    '14'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b6c2565-596c-5f2f-8c19-bf70a421f054',
    7,
    17.0,
    NULL,
    false,
    '17'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b6c2565-596c-5f2f-8c19-bf70a421f054',
    8,
    15.0,
    NULL,
    false,
    '15'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4b6c2565-596c-5f2f-8c19-bf70a421f054',
    9,
    18.0,
    NULL,
    false,
    '18'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '678dc021-0a4b-5553-9950-3255e7377c63',
    1,
    18.0,
    NULL,
    false,
    '18'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '678dc021-0a4b-5553-9950-3255e7377c63',
    2,
    26.0,
    NULL,
    false,
    '26'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '678dc021-0a4b-5553-9950-3255e7377c63',
    3,
    20.0,
    NULL,
    false,
    '20'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '678dc021-0a4b-5553-9950-3255e7377c63',
    4,
    7.0,
    NULL,
    false,
    '7'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '678dc021-0a4b-5553-9950-3255e7377c63',
    5,
    29.0,
    NULL,
    false,
    '29'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '678dc021-0a4b-5553-9950-3255e7377c63',
    6,
    30.0,
    NULL,
    true,
    '(30)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '678dc021-0a4b-5553-9950-3255e7377c63',
    7,
    12.0,
    NULL,
    false,
    '12'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '678dc021-0a4b-5553-9950-3255e7377c63',
    8,
    7.0,
    NULL,
    false,
    '7'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '678dc021-0a4b-5553-9950-3255e7377c63',
    9,
    17.0,
    NULL,
    false,
    '17'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2a01d9b8-f863-5ee6-a239-9855bb86cbb8',
    1,
    12.0,
    NULL,
    false,
    '12'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2a01d9b8-f863-5ee6-a239-9855bb86cbb8',
    2,
    25.0,
    NULL,
    false,
    '25'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2a01d9b8-f863-5ee6-a239-9855bb86cbb8',
    3,
    23.0,
    NULL,
    false,
    '23'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2a01d9b8-f863-5ee6-a239-9855bb86cbb8',
    4,
    41.0,
    'DNF',
    true,
    '(DNF 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2a01d9b8-f863-5ee6-a239-9855bb86cbb8',
    5,
    30.0,
    NULL,
    false,
    '30'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2a01d9b8-f863-5ee6-a239-9855bb86cbb8',
    6,
    8.0,
    NULL,
    false,
    '8'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2a01d9b8-f863-5ee6-a239-9855bb86cbb8',
    7,
    11.0,
    NULL,
    false,
    '11'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2a01d9b8-f863-5ee6-a239-9855bb86cbb8',
    8,
    14.0,
    NULL,
    false,
    '14'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2a01d9b8-f863-5ee6-a239-9855bb86cbb8',
    9,
    14.0,
    NULL,
    false,
    '14'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd6cd5d4a-b83a-5acf-9779-339713a67222',
    1,
    13.0,
    NULL,
    false,
    '13'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd6cd5d4a-b83a-5acf-9779-339713a67222',
    2,
    36.0,
    NULL,
    true,
    '(36)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd6cd5d4a-b83a-5acf-9779-339713a67222',
    3,
    12.0,
    NULL,
    false,
    '12'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd6cd5d4a-b83a-5acf-9779-339713a67222',
    4,
    17.0,
    NULL,
    false,
    '17'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd6cd5d4a-b83a-5acf-9779-339713a67222',
    5,
    27.0,
    NULL,
    false,
    '27'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd6cd5d4a-b83a-5acf-9779-339713a67222',
    6,
    34.0,
    NULL,
    false,
    '34'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd6cd5d4a-b83a-5acf-9779-339713a67222',
    7,
    7.0,
    NULL,
    false,
    '7'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd6cd5d4a-b83a-5acf-9779-339713a67222',
    8,
    19.0,
    NULL,
    false,
    '19'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd6cd5d4a-b83a-5acf-9779-339713a67222',
    9,
    9.0,
    NULL,
    false,
    '9'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '983d4056-7cd6-5a41-a1af-cac4c2904c7b',
    1,
    26.0,
    NULL,
    false,
    '26'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '983d4056-7cd6-5a41-a1af-cac4c2904c7b',
    2,
    24.0,
    NULL,
    false,
    '24'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '983d4056-7cd6-5a41-a1af-cac4c2904c7b',
    3,
    15.0,
    NULL,
    false,
    '15'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '983d4056-7cd6-5a41-a1af-cac4c2904c7b',
    4,
    24.0,
    NULL,
    false,
    '24'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '983d4056-7cd6-5a41-a1af-cac4c2904c7b',
    5,
    12.0,
    NULL,
    false,
    '12'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '983d4056-7cd6-5a41-a1af-cac4c2904c7b',
    6,
    35.0,
    NULL,
    false,
    '35'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '983d4056-7cd6-5a41-a1af-cac4c2904c7b',
    7,
    36.0,
    NULL,
    true,
    '(36)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '983d4056-7cd6-5a41-a1af-cac4c2904c7b',
    8,
    6.0,
    NULL,
    false,
    '6'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '983d4056-7cd6-5a41-a1af-cac4c2904c7b',
    9,
    5.0,
    NULL,
    false,
    '5'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2589adb2-250c-5fb2-b59b-934b4da23dca',
    1,
    25.0,
    NULL,
    false,
    '25'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2589adb2-250c-5fb2-b59b-934b4da23dca',
    2,
    29.0,
    NULL,
    false,
    '29'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2589adb2-250c-5fb2-b59b-934b4da23dca',
    3,
    19.0,
    NULL,
    false,
    '19'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2589adb2-250c-5fb2-b59b-934b4da23dca',
    4,
    18.0,
    NULL,
    false,
    '18'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2589adb2-250c-5fb2-b59b-934b4da23dca',
    5,
    41.0,
    'UFD',
    true,
    '(UFD 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2589adb2-250c-5fb2-b59b-934b4da23dca',
    6,
    21.0,
    NULL,
    false,
    '21'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2589adb2-250c-5fb2-b59b-934b4da23dca',
    7,
    16.0,
    NULL,
    false,
    '16'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2589adb2-250c-5fb2-b59b-934b4da23dca',
    8,
    17.0,
    NULL,
    false,
    '17'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2589adb2-250c-5fb2-b59b-934b4da23dca',
    9,
    4.0,
    NULL,
    false,
    '4'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '18bc03d6-3fc8-5ae0-acd2-8f2edad8c3ed',
    1,
    28.0,
    NULL,
    false,
    '28'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '18bc03d6-3fc8-5ae0-acd2-8f2edad8c3ed',
    2,
    9.0,
    NULL,
    false,
    '9'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '18bc03d6-3fc8-5ae0-acd2-8f2edad8c3ed',
    3,
    22.0,
    NULL,
    false,
    '22'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '18bc03d6-3fc8-5ae0-acd2-8f2edad8c3ed',
    4,
    22.0,
    NULL,
    false,
    '22'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '18bc03d6-3fc8-5ae0-acd2-8f2edad8c3ed',
    5,
    9.0,
    NULL,
    false,
    '9'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '18bc03d6-3fc8-5ae0-acd2-8f2edad8c3ed',
    6,
    11.0,
    NULL,
    false,
    '11'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '18bc03d6-3fc8-5ae0-acd2-8f2edad8c3ed',
    7,
    18.0,
    NULL,
    false,
    '18'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '18bc03d6-3fc8-5ae0-acd2-8f2edad8c3ed',
    8,
    33.0,
    NULL,
    false,
    '33'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '18bc03d6-3fc8-5ae0-acd2-8f2edad8c3ed',
    9,
    41.0,
    'RET',
    true,
    '(RET 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb2884e1-8395-5dcb-92e6-4cb0a8cdea54',
    1,
    9.0,
    NULL,
    false,
    '9'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb2884e1-8395-5dcb-92e6-4cb0a8cdea54',
    2,
    23.0,
    NULL,
    false,
    '23'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb2884e1-8395-5dcb-92e6-4cb0a8cdea54',
    3,
    16.0,
    NULL,
    false,
    '16'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb2884e1-8395-5dcb-92e6-4cb0a8cdea54',
    4,
    6.0,
    NULL,
    false,
    '6'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb2884e1-8395-5dcb-92e6-4cb0a8cdea54',
    5,
    41.0,
    'UFD',
    true,
    '(UFD 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb2884e1-8395-5dcb-92e6-4cb0a8cdea54',
    6,
    1.0,
    NULL,
    false,
    '1'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb2884e1-8395-5dcb-92e6-4cb0a8cdea54',
    7,
    25.0,
    NULL,
    false,
    '25'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb2884e1-8395-5dcb-92e6-4cb0a8cdea54',
    8,
    34.0,
    NULL,
    false,
    '34'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb2884e1-8395-5dcb-92e6-4cb0a8cdea54',
    9,
    41.0,
    'DNF',
    false,
    'DNF 41'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74e28a91-3733-5853-aba9-aa80e7cde4bc',
    1,
    14.0,
    NULL,
    false,
    '14'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74e28a91-3733-5853-aba9-aa80e7cde4bc',
    2,
    30.0,
    NULL,
    false,
    '30'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74e28a91-3733-5853-aba9-aa80e7cde4bc',
    3,
    32.0,
    NULL,
    false,
    '32'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74e28a91-3733-5853-aba9-aa80e7cde4bc',
    4,
    10.0,
    NULL,
    false,
    '10'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74e28a91-3733-5853-aba9-aa80e7cde4bc',
    5,
    28.0,
    NULL,
    false,
    '28'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74e28a91-3733-5853-aba9-aa80e7cde4bc',
    6,
    41.0,
    'UFD',
    true,
    '(UFD 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74e28a91-3733-5853-aba9-aa80e7cde4bc',
    7,
    5.0,
    NULL,
    false,
    '5'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74e28a91-3733-5853-aba9-aa80e7cde4bc',
    8,
    11.0,
    NULL,
    false,
    '11'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '74e28a91-3733-5853-aba9-aa80e7cde4bc',
    9,
    41.0,
    'UFD',
    false,
    'UFD 41'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd0b9eed1-8bac-5c03-a5e2-c8febf311ba8',
    1,
    31.0,
    NULL,
    false,
    '31'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd0b9eed1-8bac-5c03-a5e2-c8febf311ba8',
    2,
    15.0,
    NULL,
    false,
    '15'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd0b9eed1-8bac-5c03-a5e2-c8febf311ba8',
    3,
    26.0,
    NULL,
    false,
    '26'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd0b9eed1-8bac-5c03-a5e2-c8febf311ba8',
    4,
    41.0,
    'DNF',
    true,
    '(DNF 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd0b9eed1-8bac-5c03-a5e2-c8febf311ba8',
    5,
    35.0,
    NULL,
    false,
    '35'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd0b9eed1-8bac-5c03-a5e2-c8febf311ba8',
    6,
    15.0,
    NULL,
    false,
    '15'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd0b9eed1-8bac-5c03-a5e2-c8febf311ba8',
    7,
    21.0,
    NULL,
    false,
    '21'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd0b9eed1-8bac-5c03-a5e2-c8febf311ba8',
    8,
    10.0,
    NULL,
    false,
    '10'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'd0b9eed1-8bac-5c03-a5e2-c8febf311ba8',
    9,
    19.0,
    NULL,
    false,
    '19'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19904c48-0ad1-5395-9c39-a69daad51c2c',
    1,
    32.0,
    NULL,
    false,
    '32'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19904c48-0ad1-5395-9c39-a69daad51c2c',
    2,
    33.0,
    NULL,
    false,
    '33'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19904c48-0ad1-5395-9c39-a69daad51c2c',
    3,
    34.0,
    NULL,
    false,
    '34'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19904c48-0ad1-5395-9c39-a69daad51c2c',
    4,
    23.0,
    NULL,
    false,
    '23'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19904c48-0ad1-5395-9c39-a69daad51c2c',
    5,
    17.0,
    NULL,
    false,
    '17'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19904c48-0ad1-5395-9c39-a69daad51c2c',
    6,
    12.0,
    NULL,
    false,
    '12'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19904c48-0ad1-5395-9c39-a69daad51c2c',
    7,
    4.0,
    NULL,
    false,
    '4'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19904c48-0ad1-5395-9c39-a69daad51c2c',
    8,
    28.0,
    NULL,
    false,
    '28'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '19904c48-0ad1-5395-9c39-a69daad51c2c',
    9,
    41.0,
    'RET',
    true,
    '(RET 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '56adc788-4ca6-5a2f-9c3f-35811d816ba1',
    1,
    29.0,
    NULL,
    false,
    '29'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '56adc788-4ca6-5a2f-9c3f-35811d816ba1',
    2,
    38.0,
    NULL,
    false,
    '38'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '56adc788-4ca6-5a2f-9c3f-35811d816ba1',
    3,
    29.0,
    NULL,
    false,
    '29'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '56adc788-4ca6-5a2f-9c3f-35811d816ba1',
    4,
    41.0,
    'DNF',
    true,
    '(DNF 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '56adc788-4ca6-5a2f-9c3f-35811d816ba1',
    5,
    31.0,
    NULL,
    false,
    '31'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '56adc788-4ca6-5a2f-9c3f-35811d816ba1',
    6,
    13.0,
    NULL,
    false,
    '13'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '56adc788-4ca6-5a2f-9c3f-35811d816ba1',
    7,
    23.0,
    NULL,
    false,
    '23'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '56adc788-4ca6-5a2f-9c3f-35811d816ba1',
    8,
    9.0,
    NULL,
    false,
    '9'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '56adc788-4ca6-5a2f-9c3f-35811d816ba1',
    9,
    11.0,
    NULL,
    false,
    '11'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '545a2ec3-a028-56af-88b8-b68707c5a618',
    1,
    34.0,
    NULL,
    false,
    '34'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '545a2ec3-a028-56af-88b8-b68707c5a618',
    2,
    21.0,
    NULL,
    false,
    '21'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '545a2ec3-a028-56af-88b8-b68707c5a618',
    3,
    31.0,
    NULL,
    false,
    '31'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '545a2ec3-a028-56af-88b8-b68707c5a618',
    4,
    27.0,
    NULL,
    false,
    '27'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '545a2ec3-a028-56af-88b8-b68707c5a618',
    5,
    5.0,
    NULL,
    false,
    '5'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '545a2ec3-a028-56af-88b8-b68707c5a618',
    6,
    36.0,
    NULL,
    false,
    '36'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '545a2ec3-a028-56af-88b8-b68707c5a618',
    7,
    22.0,
    NULL,
    false,
    '22'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '545a2ec3-a028-56af-88b8-b68707c5a618',
    8,
    12.0,
    NULL,
    false,
    '12'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '545a2ec3-a028-56af-88b8-b68707c5a618',
    9,
    41.0,
    'DNF',
    true,
    '(DNF 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb1cd103-27e6-54cc-835c-239601680b3f',
    1,
    17.0,
    NULL,
    false,
    '17'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb1cd103-27e6-54cc-835c-239601680b3f',
    2,
    32.0,
    NULL,
    false,
    '32'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb1cd103-27e6-54cc-835c-239601680b3f',
    3,
    18.0,
    NULL,
    false,
    '18'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb1cd103-27e6-54cc-835c-239601680b3f',
    4,
    25.0,
    NULL,
    false,
    '25'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb1cd103-27e6-54cc-835c-239601680b3f',
    5,
    37.0,
    NULL,
    false,
    '37'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb1cd103-27e6-54cc-835c-239601680b3f',
    6,
    20.0,
    NULL,
    false,
    '20'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb1cd103-27e6-54cc-835c-239601680b3f',
    7,
    27.0,
    NULL,
    false,
    '27'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb1cd103-27e6-54cc-835c-239601680b3f',
    8,
    16.0,
    NULL,
    false,
    '16'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'eb1cd103-27e6-54cc-835c-239601680b3f',
    9,
    41.0,
    'DNF',
    true,
    '(DNF 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e19bd1f6-7185-5ce2-9310-bca0c7d8442f',
    1,
    33.0,
    NULL,
    false,
    '33'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e19bd1f6-7185-5ce2-9310-bca0c7d8442f',
    2,
    5.0,
    NULL,
    false,
    '5'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e19bd1f6-7185-5ce2-9310-bca0c7d8442f',
    3,
    24.0,
    NULL,
    false,
    '24'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e19bd1f6-7185-5ce2-9310-bca0c7d8442f',
    4,
    14.0,
    NULL,
    false,
    '14'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e19bd1f6-7185-5ce2-9310-bca0c7d8442f',
    5,
    32.0,
    NULL,
    false,
    '32'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e19bd1f6-7185-5ce2-9310-bca0c7d8442f',
    6,
    25.0,
    NULL,
    false,
    '25'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e19bd1f6-7185-5ce2-9310-bca0c7d8442f',
    7,
    41.0,
    'DNC',
    true,
    '(DNC 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e19bd1f6-7185-5ce2-9310-bca0c7d8442f',
    8,
    41.0,
    'RET',
    false,
    'RET 41'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e19bd1f6-7185-5ce2-9310-bca0c7d8442f',
    9,
    20.0,
    NULL,
    false,
    '20'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '414b41a3-ee25-5197-a659-6108d26bb0d8',
    1,
    21.0,
    NULL,
    false,
    '21'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '414b41a3-ee25-5197-a659-6108d26bb0d8',
    2,
    40.0,
    NULL,
    false,
    '40'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '414b41a3-ee25-5197-a659-6108d26bb0d8',
    3,
    25.0,
    NULL,
    false,
    '25'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '414b41a3-ee25-5197-a659-6108d26bb0d8',
    4,
    41.0,
    'DNF',
    true,
    '(DNF 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '414b41a3-ee25-5197-a659-6108d26bb0d8',
    5,
    33.0,
    NULL,
    false,
    '33'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '414b41a3-ee25-5197-a659-6108d26bb0d8',
    6,
    24.0,
    NULL,
    false,
    '24'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '414b41a3-ee25-5197-a659-6108d26bb0d8',
    7,
    24.0,
    NULL,
    false,
    '24'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '414b41a3-ee25-5197-a659-6108d26bb0d8',
    8,
    23.0,
    NULL,
    false,
    '23'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '414b41a3-ee25-5197-a659-6108d26bb0d8',
    9,
    10.0,
    NULL,
    false,
    '10'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8647f1e0-7d24-5a95-810e-8bebb1869efe',
    1,
    23.0,
    NULL,
    false,
    '23'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8647f1e0-7d24-5a95-810e-8bebb1869efe',
    2,
    16.0,
    NULL,
    false,
    '16'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8647f1e0-7d24-5a95-810e-8bebb1869efe',
    3,
    27.0,
    NULL,
    false,
    '27'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8647f1e0-7d24-5a95-810e-8bebb1869efe',
    4,
    28.0,
    NULL,
    false,
    '28'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8647f1e0-7d24-5a95-810e-8bebb1869efe',
    5,
    13.0,
    NULL,
    false,
    '13'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8647f1e0-7d24-5a95-810e-8bebb1869efe',
    6,
    39.0,
    NULL,
    false,
    '39'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8647f1e0-7d24-5a95-810e-8bebb1869efe',
    7,
    19.0,
    NULL,
    false,
    '19'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8647f1e0-7d24-5a95-810e-8bebb1869efe',
    8,
    35.0,
    NULL,
    false,
    '35'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8647f1e0-7d24-5a95-810e-8bebb1869efe',
    9,
    41.0,
    'DNF',
    true,
    '(DNF 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '714ceb26-b200-5870-a2ab-a6a6b9a4d689',
    1,
    38.0,
    NULL,
    false,
    '38'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '714ceb26-b200-5870-a2ab-a6a6b9a4d689',
    2,
    22.0,
    NULL,
    false,
    '22'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '714ceb26-b200-5870-a2ab-a6a6b9a4d689',
    3,
    17.0,
    NULL,
    false,
    '17'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '714ceb26-b200-5870-a2ab-a6a6b9a4d689',
    4,
    30.0,
    NULL,
    false,
    '30'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '714ceb26-b200-5870-a2ab-a6a6b9a4d689',
    5,
    8.0,
    NULL,
    false,
    '8'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '714ceb26-b200-5870-a2ab-a6a6b9a4d689',
    6,
    23.0,
    NULL,
    false,
    '23'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '714ceb26-b200-5870-a2ab-a6a6b9a4d689',
    7,
    32.0,
    NULL,
    false,
    '32'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '714ceb26-b200-5870-a2ab-a6a6b9a4d689',
    8,
    32.0,
    NULL,
    false,
    '32'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '714ceb26-b200-5870-a2ab-a6a6b9a4d689',
    9,
    41.0,
    'RET',
    true,
    '(RET 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a61cd722-d3c7-5d72-9df8-3524ce90e01d',
    1,
    20.0,
    NULL,
    false,
    '20'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a61cd722-d3c7-5d72-9df8-3524ce90e01d',
    2,
    39.0,
    NULL,
    false,
    '39'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a61cd722-d3c7-5d72-9df8-3524ce90e01d',
    3,
    35.0,
    NULL,
    false,
    '35'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a61cd722-d3c7-5d72-9df8-3524ce90e01d',
    4,
    20.0,
    NULL,
    false,
    '20'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a61cd722-d3c7-5d72-9df8-3524ce90e01d',
    5,
    10.0,
    NULL,
    false,
    '10'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a61cd722-d3c7-5d72-9df8-3524ce90e01d',
    6,
    27.0,
    NULL,
    false,
    '27'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a61cd722-d3c7-5d72-9df8-3524ce90e01d',
    7,
    15.0,
    NULL,
    false,
    '15'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a61cd722-d3c7-5d72-9df8-3524ce90e01d',
    8,
    41.0,
    'DNF',
    true,
    '(DNF 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'a61cd722-d3c7-5d72-9df8-3524ce90e01d',
    9,
    41.0,
    'RET',
    false,
    'RET 41'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '06d36ca3-1979-53ff-9990-7eb5e5a9244e',
    1,
    35.0,
    NULL,
    false,
    '35'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '06d36ca3-1979-53ff-9990-7eb5e5a9244e',
    2,
    20.0,
    NULL,
    false,
    '20'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '06d36ca3-1979-53ff-9990-7eb5e5a9244e',
    3,
    36.0,
    NULL,
    false,
    '36'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '06d36ca3-1979-53ff-9990-7eb5e5a9244e',
    4,
    41.0,
    'DNF',
    true,
    '(DNF 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '06d36ca3-1979-53ff-9990-7eb5e5a9244e',
    5,
    16.0,
    NULL,
    false,
    '16'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '06d36ca3-1979-53ff-9990-7eb5e5a9244e',
    6,
    31.0,
    NULL,
    false,
    '31'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '06d36ca3-1979-53ff-9990-7eb5e5a9244e',
    7,
    29.0,
    NULL,
    false,
    '29'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '06d36ca3-1979-53ff-9990-7eb5e5a9244e',
    8,
    29.0,
    NULL,
    false,
    '29'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '06d36ca3-1979-53ff-9990-7eb5e5a9244e',
    9,
    23.0,
    NULL,
    false,
    '23'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04411d16-f921-581f-92a8-490f9aa1590f',
    1,
    8.0,
    NULL,
    false,
    '8'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04411d16-f921-581f-92a8-490f9aa1590f',
    2,
    27.0,
    NULL,
    false,
    '27'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04411d16-f921-581f-92a8-490f9aa1590f',
    3,
    38.0,
    NULL,
    false,
    '38'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04411d16-f921-581f-92a8-490f9aa1590f',
    4,
    41.0,
    'DNF',
    true,
    '(DNF 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04411d16-f921-581f-92a8-490f9aa1590f',
    5,
    26.0,
    NULL,
    false,
    '26'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04411d16-f921-581f-92a8-490f9aa1590f',
    6,
    22.0,
    NULL,
    false,
    '22'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04411d16-f921-581f-92a8-490f9aa1590f',
    7,
    35.0,
    NULL,
    false,
    '35'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04411d16-f921-581f-92a8-490f9aa1590f',
    8,
    27.0,
    NULL,
    false,
    '27'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '04411d16-f921-581f-92a8-490f9aa1590f',
    9,
    41.0,
    'DNF',
    false,
    'DNF 41'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4706aa2a-2a55-57ed-8f11-f9737a24abad',
    1,
    30.0,
    NULL,
    false,
    '30'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4706aa2a-2a55-57ed-8f11-f9737a24abad',
    2,
    19.0,
    NULL,
    false,
    '19'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4706aa2a-2a55-57ed-8f11-f9737a24abad',
    3,
    41.0,
    'DNE',
    false,
    'DNE 41'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4706aa2a-2a55-57ed-8f11-f9737a24abad',
    4,
    26.0,
    NULL,
    false,
    '26'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4706aa2a-2a55-57ed-8f11-f9737a24abad',
    5,
    36.0,
    NULL,
    false,
    '36'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4706aa2a-2a55-57ed-8f11-f9737a24abad',
    6,
    19.0,
    NULL,
    false,
    '19'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4706aa2a-2a55-57ed-8f11-f9737a24abad',
    7,
    31.0,
    NULL,
    false,
    '31'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4706aa2a-2a55-57ed-8f11-f9737a24abad',
    8,
    26.0,
    NULL,
    false,
    '26'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4706aa2a-2a55-57ed-8f11-f9737a24abad',
    9,
    41.0,
    'DNF',
    true,
    '(DNF 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7a4d6dc-2c33-5e31-9662-741d669bbdf3',
    1,
    37.0,
    NULL,
    false,
    '37'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7a4d6dc-2c33-5e31-9662-741d669bbdf3',
    2,
    37.0,
    NULL,
    false,
    '37'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7a4d6dc-2c33-5e31-9662-741d669bbdf3',
    3,
    33.0,
    NULL,
    false,
    '33'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7a4d6dc-2c33-5e31-9662-741d669bbdf3',
    4,
    41.0,
    'DNF',
    true,
    '(DNF 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7a4d6dc-2c33-5e31-9662-741d669bbdf3',
    5,
    25.0,
    NULL,
    false,
    '25'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7a4d6dc-2c33-5e31-9662-741d669bbdf3',
    6,
    28.0,
    NULL,
    false,
    '28'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7a4d6dc-2c33-5e31-9662-741d669bbdf3',
    7,
    14.0,
    NULL,
    false,
    '14'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7a4d6dc-2c33-5e31-9662-741d669bbdf3',
    8,
    36.0,
    NULL,
    false,
    '36'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f7a4d6dc-2c33-5e31-9662-741d669bbdf3',
    9,
    41.0,
    'DNF',
    false,
    'DNF 41'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e48104ac-d668-5d53-8a5e-dc834dc577be',
    1,
    40.0,
    NULL,
    false,
    '40'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e48104ac-d668-5d53-8a5e-dc834dc577be',
    2,
    8.0,
    NULL,
    false,
    '8'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e48104ac-d668-5d53-8a5e-dc834dc577be',
    3,
    30.0,
    NULL,
    false,
    '30'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e48104ac-d668-5d53-8a5e-dc834dc577be',
    4,
    41.0,
    'DNF',
    true,
    '(DNF 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e48104ac-d668-5d53-8a5e-dc834dc577be',
    5,
    34.0,
    NULL,
    false,
    '34'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e48104ac-d668-5d53-8a5e-dc834dc577be',
    6,
    38.0,
    NULL,
    false,
    '38'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e48104ac-d668-5d53-8a5e-dc834dc577be',
    7,
    26.0,
    NULL,
    false,
    '26'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e48104ac-d668-5d53-8a5e-dc834dc577be',
    8,
    37.0,
    NULL,
    false,
    '37'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e48104ac-d668-5d53-8a5e-dc834dc577be',
    9,
    41.0,
    'DNF',
    false,
    'DNF 41'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71319fc7-abeb-58cd-b421-aaadfeb3a5b1',
    1,
    39.0,
    NULL,
    false,
    '39'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71319fc7-abeb-58cd-b421-aaadfeb3a5b1',
    2,
    31.0,
    NULL,
    false,
    '31'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71319fc7-abeb-58cd-b421-aaadfeb3a5b1',
    3,
    39.0,
    NULL,
    false,
    '39'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71319fc7-abeb-58cd-b421-aaadfeb3a5b1',
    4,
    29.0,
    NULL,
    false,
    '29'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71319fc7-abeb-58cd-b421-aaadfeb3a5b1',
    5,
    14.0,
    NULL,
    false,
    '14'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71319fc7-abeb-58cd-b421-aaadfeb3a5b1',
    6,
    33.0,
    NULL,
    false,
    '33'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71319fc7-abeb-58cd-b421-aaadfeb3a5b1',
    7,
    39.0,
    NULL,
    false,
    '39'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71319fc7-abeb-58cd-b421-aaadfeb3a5b1',
    8,
    30.0,
    NULL,
    false,
    '30'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '71319fc7-abeb-58cd-b421-aaadfeb3a5b1',
    9,
    41.0,
    'DNF',
    true,
    '(DNF 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '12577933-438f-5b67-828b-150c5e567d7a',
    1,
    36.0,
    NULL,
    false,
    '36'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '12577933-438f-5b67-828b-150c5e567d7a',
    2,
    34.0,
    NULL,
    false,
    '34'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '12577933-438f-5b67-828b-150c5e567d7a',
    3,
    37.0,
    NULL,
    false,
    '37'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '12577933-438f-5b67-828b-150c5e567d7a',
    4,
    41.0,
    'DNF',
    true,
    '(DNF 41)'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '12577933-438f-5b67-828b-150c5e567d7a',
    5,
    21.0,
    NULL,
    false,
    '21'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '12577933-438f-5b67-828b-150c5e567d7a',
    6,
    37.0,
    NULL,
    false,
    '37'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '12577933-438f-5b67-828b-150c5e567d7a',
    7,
    37.0,
    NULL,
    false,
    '37'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '12577933-438f-5b67-828b-150c5e567d7a',
    8,
    38.0,
    NULL,
    false,
    '38'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '12577933-438f-5b67-828b-150c5e567d7a',
    9,
    41.0,
    'DNF',
    false,
    'DNF 41'
);

-- 6. Admin Change Log
INSERT INTO public.admin_change_log (
    actor_email, action, entity_type, entity_id, entity_label, summary, details, source
) VALUES (
    'admin@sailorpath.com',
    'results.import_official_joda_ntqr_2026',
    'regattas',
    '4d15bf77-6c04-5575-b81d-c0f59b856598',
    '2026 JODA National Team Final Selection Trials',
    'Imported official final results from 2026 JODA National Team Final Selection Trials in Hayama (40 boats, 9 races)',
    '{"fleetSize": 40, "races": 9, "newProfiles": 0, "existingProfiles": 40, "officialSource": "https://drive.google.com/file/d/1bDChjvyqGILgUOjvC3auv7YdS9QLslsY/view?usp=drive_link"}'::jsonb,
    'official-joda-import'
);

COMMIT;
