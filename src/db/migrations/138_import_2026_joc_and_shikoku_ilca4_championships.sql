-- Migration 138: Import 2026 JOC Junior Olympic Cup and 2026 ILCA Shikoku Championship (ILCA 4)
-- Verified from Official Notice Board on RacingRulesOfSailing (Documents 14997 and 14895) and Bulkhead Magazine.

BEGIN;

-- 1. Regatta Events
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    '9c450567-e896-586a-baec-21ed0f82da1e',
    '2026 JOC Junior Olympic Cup (Junior Division)',
    '2026-joc-junior-olympic-cup-junior-division',
    '2026-07-25',
    '2026-07-26',
    'Sakaiminato Public Marina, Tottori, Japan',
    'Japan Sailing Federation & Tottori Sailing Federation',
    '["ILCA 4"]'::jsonb,
    false,
    false,
    '6 completed races over 2 days (July 25–26, 2026).',
    'Low Point System with 1 discard after 6 races.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;

INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    '94d7a2ca-0440-5709-b2ed-2bf3aaae9e46',
    '2026 ILCA Shikoku Championship',
    '2026-ilca-shikoku-championship',
    '2026-09-12',
    '2026-09-13',
    'Takamatsu City Yacht Harbor, Kagawa, Japan',
    'Japan Laser Class Association (JLCA) & Kagawa Sailing Federation',
    '["ILCA 4"]'::jsonb,
    false,
    false,
    '5 completed races over 2 days (September 12–13, 2026).',
    'Low Point System with 1 discard after 5 races.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;

-- 2. Regatta Class Sheets
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name
) VALUES (
    '88b046b2-def3-54da-9639-324fafcc544e',
    '9c450567-e896-586a-baec-21ed0f82da1e',
    '2026 JOC Junior Olympic Cup (ILCA 4)',
    '2026-joc-junior-olympic-cup-ilca4',
    '2026-07-25',
    '2026-07-26',
    6,
    'Open',
    6,
    'JPN',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'Sakaiminato Public Marina, Tottori, Japan',
    'Japan Sailing Federation & Tottori Sailing Federation',
    'published',
    'https://www.racingrulesofsailing.org/documents/14997/event',
    'RacingRulesOfSailing Document 14997 - 2026 JOC Junior Olympic Cup (Junior Division) ILCA 4 Final Results'
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count;

INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name
) VALUES (
    '860ad180-2454-5a8a-8c69-9b8d8f871c37',
    '94d7a2ca-0440-5709-b2ed-2bf3aaae9e46',
    '2026 ILCA Shikoku Championship (ILCA 4)',
    '2026-ilca-shikoku-championship-ilca4',
    '2026-09-12',
    '2026-09-13',
    5,
    'Open',
    5,
    'JPN',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'Takamatsu City Yacht Harbor, Kagawa, Japan',
    'Japan Laser Class Association (JLCA) & Kagawa Sailing Federation',
    'published',
    'https://www.racingrulesofsailing.org/documents/14895/event',
    'RacingRulesOfSailing Document 14895 / Bulkhead Magazine - 2026 ILCA Shikoku Championship ILCA 4 Final Results'
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count;

-- 3. New Sailor Profiles
INSERT INTO public.sailors (
    id, name, handle, sail_number, sail_number_ilca4, nationality, gender, club
) VALUES (
    '17730390-104a-530f-bd89-bc3c933b573d', 'Kosei Nakada', 'ilca4-jpn-kosei-nakada-133167', 'JPN 133167', '133167', 'JPN', 'M', 'Kanagawa Youth YC'
) ON CONFLICT (id) DO UPDATE SET
    sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, EXCLUDED.sail_number_ilca4),
    club = COALESCE(sailors.club, EXCLUDED.club);

INSERT INTO public.sailors (
    id, name, handle, sail_number, sail_number_ilca4, nationality, gender, club
) VALUES (
    '2603ae3c-4d98-5984-84ac-6cdfdddb2a33', 'Yura Miya', 'ilca4-jpn-yura-miya-208002', 'JPN 208002', '208002', 'JPN', 'M', 'Tottori Sailing Federation'
) ON CONFLICT (id) DO UPDATE SET
    sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, EXCLUDED.sail_number_ilca4),
    club = COALESCE(sailors.club, EXCLUDED.club);

INSERT INTO public.sailors (
    id, name, handle, sail_number, sail_number_ilca4, nationality, gender, club
) VALUES (
    'ffc2dc40-1260-5e12-98cb-1dbb938b75ed', 'Kodai Okamoto', 'ilca4-jpn-kodai-okamoto-208000', 'JPN 208000', '208000', 'JPN', 'M', 'Tottori Sailing Federation'
) ON CONFLICT (id) DO UPDATE SET
    sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, EXCLUDED.sail_number_ilca4),
    club = COALESCE(sailors.club, EXCLUDED.club);

INSERT INTO public.sailors (
    id, name, handle, sail_number, sail_number_ilca4, nationality, gender, club
) VALUES (
    '7dfbad6c-5ac8-55e1-a503-aff7f9fd7239', 'Rishin Kimura', 'ilca4-jpn-rishin-kimura-203075', 'JPN 203075', '203075', 'JPN', 'M', 'Tottori Sailing Federation'
) ON CONFLICT (id) DO UPDATE SET
    sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, EXCLUDED.sail_number_ilca4),
    club = COALESCE(sailors.club, EXCLUDED.club);

INSERT INTO public.sailors (
    id, name, handle, sail_number, sail_number_ilca4, nationality, gender, club
) VALUES (
    '4331c469-130c-5430-9512-9ade01682df9', 'Kazuma Sakamoto', 'ilca4-jpn-kazuma-sakamoto-203074', 'JPN 203074', '203074', 'JPN', 'M', 'Tottori Sailing Federation'
) ON CONFLICT (id) DO UPDATE SET
    sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, EXCLUDED.sail_number_ilca4),
    club = COALESCE(sailors.club, EXCLUDED.club);

INSERT INTO public.sailors (
    id, name, handle, sail_number, sail_number_ilca4, nationality, gender, club
) VALUES (
    'eff4e2f5-20f7-5e1e-86ff-9fac59d427ef', 'Motohiko Tokumaru', 'ilca4-jpn-motohiko-tokumaru-213160', 'JPN 213160', '213160', 'JPN', 'M', 'Fukuoka'
) ON CONFLICT (id) DO UPDATE SET
    sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, EXCLUDED.sail_number_ilca4),
    club = COALESCE(sailors.club, EXCLUDED.club);

INSERT INTO public.sailors (
    id, name, handle, sail_number, sail_number_ilca4, nationality, gender, club
) VALUES (
    '06af3a01-d4f8-5eb9-a345-e5e9ccae75df', 'Akiko Yazaki', 'ilca4-jpn-akiko-yazaki-154080', 'JPN 154080', '154080', 'JPN', 'F', 'Suwako'
) ON CONFLICT (id) DO UPDATE SET
    sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, EXCLUDED.sail_number_ilca4),
    club = COALESCE(sailors.club, EXCLUDED.club);

INSERT INTO public.sailors (
    id, name, handle, sail_number, sail_number_ilca4, nationality, gender, club
) VALUES (
    'c5ff18f3-1581-5463-b057-272b4f31c528', 'Sora Ogawa', 'ilca4-jpn-sora-ogawa-156040', 'JPN 156040', '156040', 'JPN', 'M', 'B&G Takamatsu'
) ON CONFLICT (id) DO UPDATE SET
    sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, EXCLUDED.sail_number_ilca4),
    club = COALESCE(sailors.club, EXCLUDED.club);

INSERT INTO public.sailors (
    id, name, handle, sail_number, sail_number_ilca4, nationality, gender, club
) VALUES (
    'd03d9a75-d308-5b09-8733-75f82441a0f0', 'Chinatsu Tokumaru', 'ilca4-jpn-chinatsu-tokumaru-133160', 'JPN 133160', '133160', 'JPN', 'F', 'Fukuoka'
) ON CONFLICT (id) DO UPDATE SET
    sail_number_ilca4 = COALESCE(sailors.sail_number_ilca4, EXCLUDED.sail_number_ilca4),
    club = COALESCE(sailors.club, EXCLUDED.club);

-- 4. Update Existing Sailors with ILCA 4 Sail Numbers
UPDATE public.sailors
SET sail_number_ilca4 = '208946'
WHERE id = '51090326-f0c9-5140-8db8-fbe90cbf12d5';

UPDATE public.sailors
SET sail_number_ilca4 = '143011'
WHERE id = '7d9cdace-e35e-53e9-b310-81a4e7b95dbb';

-- 5. Sailor Aliases
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('17730390-104a-530f-bd89-bc3c933b573d', '中田 航誠')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('17730390-104a-530f-bd89-bc3c933b573d', '中田航誠')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2603ae3c-4d98-5984-84ac-6cdfdddb2a33', '箕矢 有楽')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2603ae3c-4d98-5984-84ac-6cdfdddb2a33', '箕矢有楽')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ffc2dc40-1260-5e12-98cb-1dbb938b75ed', '岡本 昂大')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ffc2dc40-1260-5e12-98cb-1dbb938b75ed', '岡本昂大')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('7dfbad6c-5ac8-55e1-a503-aff7f9fd7239', '木村 梨新')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('7dfbad6c-5ac8-55e1-a503-aff7f9fd7239', '木村梨新')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('4331c469-130c-5430-9512-9ade01682df9', '坂本 一真')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('4331c469-130c-5430-9512-9ade01682df9', '坂本一真')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('eff4e2f5-20f7-5e1e-86ff-9fac59d427ef', '徳丸 元彦')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('eff4e2f5-20f7-5e1e-86ff-9fac59d427ef', '徳丸元彦')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('06af3a01-d4f8-5eb9-a345-e5e9ccae75df', '矢崎 明子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('06af3a01-d4f8-5eb9-a345-e5e9ccae75df', '矢崎明子')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c5ff18f3-1581-5463-b057-272b4f31c528', '小川 空')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c5ff18f3-1581-5463-b057-272b4f31c528', '小川空')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d03d9a75-d308-5b09-8733-75f82441a0f0', '徳丸 知夏')
ON CONFLICT (alias_name) DO NOTHING;
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('d03d9a75-d308-5b09-8733-75f82441a0f0', '徳丸知夏')
ON CONFLICT (alias_name) DO NOTHING;

-- 6. Regatta Results, Participants, and Race Results
-- 6.1 2026 JOC Junior Olympic Cup (ILCA 4)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '7d67d213-ce82-5e3c-9d0c-94e2602e5358',
    '17730390-104a-530f-bd89-bc3c933b573d',
    '88b046b2-def3-54da-9639-324fafcc544e',
    '中田 航誠',
    '133167',
    'individual',
    1,
    9.0,
    7.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/14997/event',
    '2026 JOC Junior Olympic Cup (Junior Division) ILCA 4 Final Results',
    'pdf',
    'Official final results from RacingRulesOfSailing Document 14997, Sakaiminato Public Marina, Tottori (July 25-26, 2026).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1463f951-89d8-5ea1-8909-ac8d2fd48c3b',
    '7d67d213-ce82-5e3c-9d0c-94e2602e5358',
    '17730390-104a-530f-bd89-bc3c933b573d',
    '中田 航誠',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d67d213-ce82-5e3c-9d0c-94e2602e5358',
    1,
    1.0,
    NULL,
    false,
    '1'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d67d213-ce82-5e3c-9d0c-94e2602e5358',
    2,
    2.0,
    NULL,
    true,
    '2'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d67d213-ce82-5e3c-9d0c-94e2602e5358',
    3,
    1.0,
    NULL,
    false,
    '1'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d67d213-ce82-5e3c-9d0c-94e2602e5358',
    4,
    2.0,
    NULL,
    false,
    '2'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d67d213-ce82-5e3c-9d0c-94e2602e5358',
    5,
    2.0,
    NULL,
    false,
    '2'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7d67d213-ce82-5e3c-9d0c-94e2602e5358',
    6,
    1.0,
    NULL,
    false,
    '1'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '8eec3f3a-7048-58ab-9cd2-b07384fedaa1',
    '51090326-f0c9-5140-8db8-fbe90cbf12d5',
    '88b046b2-def3-54da-9639-324fafcc544e',
    '堀野 葵',
    '208946',
    'individual',
    2,
    9.0,
    7.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/14997/event',
    '2026 JOC Junior Olympic Cup (Junior Division) ILCA 4 Final Results',
    'pdf',
    'Official final results from RacingRulesOfSailing Document 14997, Sakaiminato Public Marina, Tottori (July 25-26, 2026).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '817e337a-8327-584f-a45f-fe002daa105f',
    '8eec3f3a-7048-58ab-9cd2-b07384fedaa1',
    '51090326-f0c9-5140-8db8-fbe90cbf12d5',
    '堀野 葵',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8eec3f3a-7048-58ab-9cd2-b07384fedaa1',
    1,
    2.0,
    NULL,
    true,
    '2'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8eec3f3a-7048-58ab-9cd2-b07384fedaa1',
    2,
    1.0,
    NULL,
    false,
    '1'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8eec3f3a-7048-58ab-9cd2-b07384fedaa1',
    3,
    2.0,
    NULL,
    false,
    '2'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8eec3f3a-7048-58ab-9cd2-b07384fedaa1',
    4,
    1.0,
    NULL,
    false,
    '1'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8eec3f3a-7048-58ab-9cd2-b07384fedaa1',
    5,
    1.0,
    NULL,
    false,
    '1'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8eec3f3a-7048-58ab-9cd2-b07384fedaa1',
    6,
    2.0,
    NULL,
    false,
    '2'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '7393894d-9f75-5195-a05a-28983c16eb7c',
    '2603ae3c-4d98-5984-84ac-6cdfdddb2a33',
    '88b046b2-def3-54da-9639-324fafcc544e',
    '箕矢 有楽',
    '208002',
    'individual',
    3,
    21.0,
    16.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/14997/event',
    '2026 JOC Junior Olympic Cup (Junior Division) ILCA 4 Final Results',
    'pdf',
    'Official final results from RacingRulesOfSailing Document 14997, Sakaiminato Public Marina, Tottori (July 25-26, 2026).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bf04a158-eb90-52aa-91b3-2de2108af1db',
    '7393894d-9f75-5195-a05a-28983c16eb7c',
    '2603ae3c-4d98-5984-84ac-6cdfdddb2a33',
    '箕矢 有楽',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7393894d-9f75-5195-a05a-28983c16eb7c',
    1,
    3.0,
    NULL,
    false,
    '3'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7393894d-9f75-5195-a05a-28983c16eb7c',
    2,
    3.0,
    NULL,
    false,
    '3'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7393894d-9f75-5195-a05a-28983c16eb7c',
    3,
    4.0,
    NULL,
    false,
    '4'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7393894d-9f75-5195-a05a-28983c16eb7c',
    4,
    3.0,
    NULL,
    false,
    '3'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7393894d-9f75-5195-a05a-28983c16eb7c',
    5,
    5.0,
    NULL,
    true,
    '5'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '7393894d-9f75-5195-a05a-28983c16eb7c',
    6,
    3.0,
    NULL,
    false,
    '3'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'e4e01098-4086-5535-a7db-1e19a09437b0',
    'ffc2dc40-1260-5e12-98cb-1dbb938b75ed',
    '88b046b2-def3-54da-9639-324fafcc544e',
    '岡本 昂大',
    '208000',
    'individual',
    4,
    23.0,
    18.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/14997/event',
    '2026 JOC Junior Olympic Cup (Junior Division) ILCA 4 Final Results',
    'pdf',
    'Official final results from RacingRulesOfSailing Document 14997, Sakaiminato Public Marina, Tottori (July 25-26, 2026).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8dde1830-722b-56ba-b062-849f7218bc7f',
    'e4e01098-4086-5535-a7db-1e19a09437b0',
    'ffc2dc40-1260-5e12-98cb-1dbb938b75ed',
    '岡本 昂大',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4e01098-4086-5535-a7db-1e19a09437b0',
    1,
    4.0,
    NULL,
    false,
    '4'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4e01098-4086-5535-a7db-1e19a09437b0',
    2,
    4.0,
    NULL,
    false,
    '4'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4e01098-4086-5535-a7db-1e19a09437b0',
    3,
    3.0,
    NULL,
    false,
    '3'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4e01098-4086-5535-a7db-1e19a09437b0',
    4,
    4.0,
    NULL,
    false,
    '4'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4e01098-4086-5535-a7db-1e19a09437b0',
    5,
    3.0,
    NULL,
    false,
    '3'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e4e01098-4086-5535-a7db-1e19a09437b0',
    6,
    5.0,
    NULL,
    true,
    '5'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '8cd95c77-9149-5453-88b6-78f596ff4bb9',
    '7dfbad6c-5ac8-55e1-a503-aff7f9fd7239',
    '88b046b2-def3-54da-9639-324fafcc544e',
    '木村 梨新',
    '203075',
    'individual',
    5,
    30.0,
    24.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/14997/event',
    '2026 JOC Junior Olympic Cup (Junior Division) ILCA 4 Final Results',
    'pdf',
    'Official final results from RacingRulesOfSailing Document 14997, Sakaiminato Public Marina, Tottori (July 25-26, 2026).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '74d709c9-f23b-53cb-903a-568169485f19',
    '8cd95c77-9149-5453-88b6-78f596ff4bb9',
    '7dfbad6c-5ac8-55e1-a503-aff7f9fd7239',
    '木村 梨新',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8cd95c77-9149-5453-88b6-78f596ff4bb9',
    1,
    6.0,
    NULL,
    true,
    '6'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8cd95c77-9149-5453-88b6-78f596ff4bb9',
    2,
    6.0,
    NULL,
    false,
    '6'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8cd95c77-9149-5453-88b6-78f596ff4bb9',
    3,
    5.0,
    NULL,
    false,
    '5'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8cd95c77-9149-5453-88b6-78f596ff4bb9',
    4,
    5.0,
    NULL,
    false,
    '5'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8cd95c77-9149-5453-88b6-78f596ff4bb9',
    5,
    4.0,
    NULL,
    false,
    '4'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '8cd95c77-9149-5453-88b6-78f596ff4bb9',
    6,
    4.0,
    NULL,
    false,
    '4'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '20657710-1c9f-5e62-842b-e762076e5302',
    '4331c469-130c-5430-9512-9ade01682df9',
    '88b046b2-def3-54da-9639-324fafcc544e',
    '坂本 一真',
    '203074',
    'individual',
    6,
    35.0,
    28.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/14997/event',
    '2026 JOC Junior Olympic Cup (Junior Division) ILCA 4 Final Results',
    'pdf',
    'Official final results from RacingRulesOfSailing Document 14997, Sakaiminato Public Marina, Tottori (July 25-26, 2026).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '60cad15b-4898-5ecd-8a9a-18a1552d798b',
    '20657710-1c9f-5e62-842b-e762076e5302',
    '4331c469-130c-5430-9512-9ade01682df9',
    '坂本 一真',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20657710-1c9f-5e62-842b-e762076e5302',
    1,
    5.0,
    NULL,
    false,
    '5'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20657710-1c9f-5e62-842b-e762076e5302',
    2,
    5.0,
    NULL,
    false,
    '5'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20657710-1c9f-5e62-842b-e762076e5302',
    3,
    6.0,
    NULL,
    false,
    '6'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20657710-1c9f-5e62-842b-e762076e5302',
    4,
    6.0,
    NULL,
    false,
    '6'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20657710-1c9f-5e62-842b-e762076e5302',
    5,
    6.0,
    NULL,
    false,
    '6'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20657710-1c9f-5e62-842b-e762076e5302',
    6,
    7.0,
    'RET',
    true,
    'RET'
);
-- 6.2 2026 ILCA Shikoku Championship (ILCA 4)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '44daa610-6f94-5260-80a9-3c644f4c122d',
    '7d9cdace-e35e-53e9-b310-81a4e7b95dbb',
    '860ad180-2454-5a8a-8c69-9b8d8f871c37',
    '秋村 柚月',
    '143011',
    'individual',
    1,
    8.0,
    6.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/14895/event',
    '2026 ILCA Shikoku Championship ILCA 4 Final Results',
    'pdf',
    'Official final results from RacingRulesOfSailing Document 14895 & Bulkhead Magazine, Takamatsu City Yacht Harbor (September 12-13, 2026).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b250a990-3707-54aa-ab66-d1a2ff7fe736',
    '44daa610-6f94-5260-80a9-3c644f4c122d',
    '7d9cdace-e35e-53e9-b310-81a4e7b95dbb',
    '秋村 柚月',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '44daa610-6f94-5260-80a9-3c644f4c122d',
    1,
    2.0,
    NULL,
    false,
    '2'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '44daa610-6f94-5260-80a9-3c644f4c122d',
    2,
    1.0,
    NULL,
    false,
    '1'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '44daa610-6f94-5260-80a9-3c644f4c122d',
    3,
    2.0,
    NULL,
    true,
    '2'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '44daa610-6f94-5260-80a9-3c644f4c122d',
    4,
    1.0,
    NULL,
    false,
    '1'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '44daa610-6f94-5260-80a9-3c644f4c122d',
    5,
    2.0,
    NULL,
    false,
    '2'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    'f55723c5-c8a2-55ec-a16e-5b60075c0ad1',
    'eff4e2f5-20f7-5e1e-86ff-9fac59d427ef',
    '860ad180-2454-5a8a-8c69-9b8d8f871c37',
    '徳丸 元彦',
    '213160',
    'individual',
    2,
    13.0,
    9.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/14895/event',
    '2026 ILCA Shikoku Championship ILCA 4 Final Results',
    'pdf',
    'Official final results from RacingRulesOfSailing Document 14895 & Bulkhead Magazine, Takamatsu City Yacht Harbor (September 12-13, 2026).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8702c5d5-77fd-551c-9da9-3fb9e867b2f2',
    'f55723c5-c8a2-55ec-a16e-5b60075c0ad1',
    'eff4e2f5-20f7-5e1e-86ff-9fac59d427ef',
    '徳丸 元彦',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f55723c5-c8a2-55ec-a16e-5b60075c0ad1',
    1,
    4.0,
    NULL,
    true,
    '4'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f55723c5-c8a2-55ec-a16e-5b60075c0ad1',
    2,
    3.0,
    NULL,
    false,
    '3'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f55723c5-c8a2-55ec-a16e-5b60075c0ad1',
    3,
    1.0,
    NULL,
    false,
    '1'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f55723c5-c8a2-55ec-a16e-5b60075c0ad1',
    4,
    4.0,
    NULL,
    false,
    '4'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f55723c5-c8a2-55ec-a16e-5b60075c0ad1',
    5,
    1.0,
    NULL,
    false,
    '1'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '63a7c481-cd68-509b-8ea9-d7590f4fb34b',
    '06af3a01-d4f8-5eb9-a345-e5e9ccae75df',
    '860ad180-2454-5a8a-8c69-9b8d8f871c37',
    '矢崎 明子',
    '154080',
    'individual',
    3,
    17.0,
    11.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/14895/event',
    '2026 ILCA Shikoku Championship ILCA 4 Final Results',
    'pdf',
    'Official final results from RacingRulesOfSailing Document 14895 & Bulkhead Magazine, Takamatsu City Yacht Harbor (September 12-13, 2026).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1aac1d89-fb09-547e-b687-825e87809c0d',
    '63a7c481-cd68-509b-8ea9-d7590f4fb34b',
    '06af3a01-d4f8-5eb9-a345-e5e9ccae75df',
    '矢崎 明子',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63a7c481-cd68-509b-8ea9-d7590f4fb34b',
    1,
    1.0,
    NULL,
    false,
    '1'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63a7c481-cd68-509b-8ea9-d7590f4fb34b',
    2,
    6.0,
    'UFD',
    true,
    'UFD'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63a7c481-cd68-509b-8ea9-d7590f4fb34b',
    3,
    5.0,
    NULL,
    false,
    '5'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63a7c481-cd68-509b-8ea9-d7590f4fb34b',
    4,
    2.0,
    NULL,
    false,
    '2'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '63a7c481-cd68-509b-8ea9-d7590f4fb34b',
    5,
    3.0,
    NULL,
    false,
    '3'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '52ff6a1f-a30f-51be-a6c4-8c8a080b4f03',
    'c5ff18f3-1581-5463-b057-272b4f31c528',
    '860ad180-2454-5a8a-8c69-9b8d8f871c37',
    '小川 空',
    '156040',
    'individual',
    4,
    19.0,
    13.0,
    'M',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/14895/event',
    '2026 ILCA Shikoku Championship ILCA 4 Final Results',
    'pdf',
    'Official final results from RacingRulesOfSailing Document 14895 & Bulkhead Magazine, Takamatsu City Yacht Harbor (September 12-13, 2026).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6a799d31-d00d-54a3-a570-7a16475c4c6e',
    '52ff6a1f-a30f-51be-a6c4-8c8a080b4f03',
    'c5ff18f3-1581-5463-b057-272b4f31c528',
    '小川 空',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52ff6a1f-a30f-51be-a6c4-8c8a080b4f03',
    1,
    3.0,
    NULL,
    false,
    '3'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52ff6a1f-a30f-51be-a6c4-8c8a080b4f03',
    2,
    6.0,
    'UFD',
    true,
    'UFD'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52ff6a1f-a30f-51be-a6c4-8c8a080b4f03',
    3,
    3.0,
    NULL,
    false,
    '3'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52ff6a1f-a30f-51be-a6c4-8c8a080b4f03',
    4,
    3.0,
    NULL,
    false,
    '3'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '52ff6a1f-a30f-51be-a6c4-8c8a080b4f03',
    5,
    4.0,
    NULL,
    false,
    '4'
);
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    verification_status, evidence_url, evidence_name, evidence_type, evidence_notes, verified_at
) VALUES (
    '23215312-07b2-5839-8e29-a3ee9c349d44',
    'd03d9a75-d308-5b09-8733-75f82441a0f0',
    '860ad180-2454-5a8a-8c69-9b8d8f871c37',
    '徳丸 知夏',
    '133160',
    'individual',
    5,
    21.0,
    16.0,
    'F',
    'JPN',
    false,
    false,
    'verified',
    'https://www.racingrulesofsailing.org/documents/14895/event',
    '2026 ILCA Shikoku Championship ILCA 4 Final Results',
    'pdf',
    'Official final results from RacingRulesOfSailing Document 14895 & Bulkhead Magazine, Takamatsu City Yacht Harbor (September 12-13, 2026).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    rank = EXCLUDED.rank,
    total_score = EXCLUDED.total_score,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2c6df863-dbb4-5824-9471-30a1ca00f3d2',
    '23215312-07b2-5839-8e29-a3ee9c349d44',
    'd03d9a75-d308-5b09-8733-75f82441a0f0',
    '徳丸 知夏',
    1,
    'solo',
    'matched',
    false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23215312-07b2-5839-8e29-a3ee9c349d44',
    1,
    5.0,
    NULL,
    true,
    '5'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23215312-07b2-5839-8e29-a3ee9c349d44',
    2,
    2.0,
    NULL,
    false,
    '2'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23215312-07b2-5839-8e29-a3ee9c349d44',
    3,
    4.0,
    NULL,
    false,
    '4'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23215312-07b2-5839-8e29-a3ee9c349d44',
    4,
    5.0,
    NULL,
    false,
    '5'
);
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23215312-07b2-5839-8e29-a3ee9c349d44',
    5,
    5.0,
    NULL,
    false,
    '5'
);
-- 7. Admin Change Log
INSERT INTO public.admin_change_log (
    actor_email, action, entity_type, entity_id, entity_label, summary, details, source
) VALUES (
    'admin@sailorpath.com',
    'results.import_official_2026_joc_and_shikoku_ilca4',
    'regattas',
    '88b046b2-def3-54da-9639-324fafcc544e',
    '2026 JOC Junior Olympic Cup and ILCA Shikoku Championship (ILCA 4)',
    'Imported official final results for 2026 JOC Junior Olympic Cup (6 boats, 6 races) and 2026 ILCA Shikoku Championship (5 boats, 5 races)',
    '{"joc_fleet": 6, "shikoku_fleet": 5, "crossClassLinks": ["Aoi Horino (51090326-f0c9-5140-8db8-fbe90cbf12d5)", "Yuzuki Akimura (7d9cdace-e35e-53e9-b310-81a4e7b95dbb)"]}'::jsonb,
    'official-rrs-import'
);

COMMIT;
