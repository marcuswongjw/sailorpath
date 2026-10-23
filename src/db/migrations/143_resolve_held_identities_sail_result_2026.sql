-- Migration 143: Resolve 11 Held Result Entries from sail-result-2026
-- Confirmed by user on 23 October 2026:
-- 1. Phacharapol Munwong (attach ILCA 215071, sail 0, ILCA sail 5; create distinct profile for Optimist 1255)
-- 2. Nur Hafizahanani Binti Zailan (attach both ILCA 6 results to Nur Hafizanah Binti Zailan)
-- 3. Somboon TaweeBoonrungrueng (combine into 1 new profile with aliases)
-- 4. Noppadol To-pho (attach both results to Nopadol Tokpo with aliases)
-- 5. Henry Zou (create new distinct profile for ILCA 4 214613, leaving Henry Zub distinct)

BEGIN;

-- ============================================================
-- 1. Create New Profiles for Distinct / Combined Sailors
-- ============================================================

INSERT INTO public.sailors (id, name, handle, sail_number, club, nationality, gender, dob, created_at, updated_at)
VALUES (
  '75f8e7bf-b2ce-2331-af33-efaeaf5366dc',
  'Phacharapol',
  'phacharapol-opti-1255-b49e21',
  'THA 1255',
  'YRAT',
  'THA',
  'M',
  NULL,
  now(), now()
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.sailors (id, name, handle, sail_number, club, nationality, gender, dob, created_at, updated_at)
VALUES (
  'b19cb961-68c3-76e5-830b-fdb23dde0cdb',
  'Somboon TaweeBoonrungrueng',
  'somboon-taweeboonrungrueng-d39a11',
  'THA 223',
  'YRAT',
  'THA',
  'M',
  '2012-01-01'::date,
  now(), now()
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.sailors (id, name, handle, sail_number, sail_number_ilca4, club, nationality, gender, dob, created_at, updated_at)
VALUES (
  '8b737931-4735-7169-6a9b-3adf071b8ebb',
  'Henry Zou',
  'henry-zou-ilca4-e48f02',
  '',
  '214613',
  'Royal Varuna Yacht Club',
  'THA',
  'M',
  NULL,
  now(), now()
) ON CONFLICT (id) DO NOTHING;

-- Aliases
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('81620549-758e-5209-9f80-4ac3f7cedbbf', 'PHACHARAP0L MUNWORG'),
  ('81620549-758e-5209-9f80-4ac3f7cedbbf', 'PHACHARAPOL MUNWONG'),
  ('96bfe722-1e1a-4e2c-901e-dae4789973ac', 'NUR HAFIZAHANANI BINTI ZAILAN'),
  ('96bfe722-1e1a-4e2c-901e-dae4789973ac', 'NUR HAFIZAHANANI'),
  ('b19cb961-68c3-76e5-830b-fdb23dde0cdb', 'SOMBUN THAWEEBUNRUNGRUEANG'),
  ('b19cb961-68c3-76e5-830b-fdb23dde0cdb', 'Somboon TaweeBoonrungrueng'),
  ('d5453895-83cb-4b63-b701-804ce42ce4b2', 'NOPPHADON TOPHO'),
  ('d5453895-83cb-4b63-b701-804ce42ce4b2', 'Noppadol To-pho')
ON CONFLICT DO NOTHING;


-- Result: PHACHARAP0L MUNWORG (Rank 21, Sail 215071) in ACDC Cup International Sailing Championship 2026 — ILCA 4
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, birth_year,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type,
    evidence_notes, verification_status, verified_at, created_at, updated_at
) VALUES (
    'a97287a1-f2de-166c-3534-f73678411a1a',
    '81620549-758e-5209-9f80-4ac3f7cedbbf',
    '7165c5b6-367c-5c33-bb0f-451e9c253528',
    'PHACHARAP0L MUNWORG',
    '215071',
    'individual',
    21,
    240,
    196,
    'M',
    'THA',
    2022,
    false, false,
    'https://www.racingrulesofsailing.org/documents/200613',
    'https://www.racingrulesofsailing.org/documents/200613',
    'Official acdc-cup-international-sailing-championship-2026 result document 200613',
    'pdf',
    'Identity reviewed and confirmed by user on 23 October 2026.',
    'verified',
    now(), now(), now()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    rank = EXCLUDED.rank,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '75aa2735-b77e-8e2b-9105-1daa0fd52756',
    'a97287a1-f2de-166c-3534-f73678411a1a',
    '81620549-758e-5209-9f80-4ac3f7cedbbf',
    'PHACHARAP0L MUNWORG',
    1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES
    ('a97287a1-f2de-166c-3534-f73678411a1a', 1, 20, NULL, false, '20.0'),
    ('a97287a1-f2de-166c-3534-f73678411a1a', 2, 19, NULL, false, '19.0'),
    ('a97287a1-f2de-166c-3534-f73678411a1a', 3, 21, NULL, true, '(21.0)'),
    ('a97287a1-f2de-166c-3534-f73678411a1a', 4, 16, NULL, false, '16.0'),
    ('a97287a1-f2de-166c-3534-f73678411a1a', 5, 23, NULL, true, '(23.0)'),
    ('a97287a1-f2de-166c-3534-f73678411a1a', 6, 20, NULL, false, '20.0'),
    ('a97287a1-f2de-166c-3534-f73678411a1a', 7, 21, NULL, false, '21.0'),
    ('a97287a1-f2de-166c-3534-f73678411a1a', 8, 21, NULL, false, '21.0'),
    ('a97287a1-f2de-166c-3534-f73678411a1a', 9, 21, NULL, false, '21.0'),
    ('a97287a1-f2de-166c-3534-f73678411a1a', 10, 18, NULL, false, '18.0'),
    ('a97287a1-f2de-166c-3534-f73678411a1a', 11, 21, NULL, false, '21.0'),
    ('a97287a1-f2de-166c-3534-f73678411a1a', 12, 19, NULL, false, '19.0');

-- Result: NUR HAFIZAHANANI BINTI ZAILAN (Rank 2, Sail 224712) in ACDC Cup International Sailing Championship 2026 — ILCA 6
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, birth_year,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type,
    evidence_notes, verification_status, verified_at, created_at, updated_at
) VALUES (
    'ac4d1143-b0e7-9a59-6603-e3a868110f68',
    '96bfe722-1e1a-4e2c-901e-dae4789973ac',
    '86e147fd-aad6-5047-a274-8bdeb1c69068',
    'NUR HAFIZAHANANI BINTI ZAILAN',
    '224712',
    'individual',
    2,
    27,
    18,
    'F',
    'MAS',
    2008,
    false, false,
    'https://www.racingrulesofsailing.org/documents/200613',
    'https://www.racingrulesofsailing.org/documents/200613',
    'Official acdc-cup-international-sailing-championship-2026 result document 200613',
    'pdf',
    'Identity reviewed and confirmed by user on 23 October 2026.',
    'verified',
    now(), now(), now()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    rank = EXCLUDED.rank,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8ec3602d-1059-55c9-af5e-dc25f2b168f3',
    'ac4d1143-b0e7-9a59-6603-e3a868110f68',
    '96bfe722-1e1a-4e2c-901e-dae4789973ac',
    'NUR HAFIZAHANANI BINTI ZAILAN',
    1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES
    ('ac4d1143-b0e7-9a59-6603-e3a868110f68', 1, 1, NULL, false, '1.0'),
    ('ac4d1143-b0e7-9a59-6603-e3a868110f68', 2, 1, NULL, false, '1.0'),
    ('ac4d1143-b0e7-9a59-6603-e3a868110f68', 3, 2, NULL, false, '2.0'),
    ('ac4d1143-b0e7-9a59-6603-e3a868110f68', 4, 3, NULL, false, '3.0'),
    ('ac4d1143-b0e7-9a59-6603-e3a868110f68', 5, 5, NULL, true, '(5.0)'),
    ('ac4d1143-b0e7-9a59-6603-e3a868110f68', 6, 2, NULL, false, '2.0'),
    ('ac4d1143-b0e7-9a59-6603-e3a868110f68', 7, 2, NULL, false, '2.0'),
    ('ac4d1143-b0e7-9a59-6603-e3a868110f68', 8, 2, NULL, false, '2.0'),
    ('ac4d1143-b0e7-9a59-6603-e3a868110f68', 9, 1, NULL, false, '1.0'),
    ('ac4d1143-b0e7-9a59-6603-e3a868110f68', 10, 2, NULL, false, '2.0'),
    ('ac4d1143-b0e7-9a59-6603-e3a868110f68', 11, 4, NULL, true, '(4.0)'),
    ('ac4d1143-b0e7-9a59-6603-e3a868110f68', 12, 2, NULL, false, '2.0');

-- Result: PHACHARAPOL (Rank 52, Sail THA1255) in Children's Day Regatta 2026 — Optimist
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, birth_year,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type,
    evidence_notes, verification_status, verified_at, created_at, updated_at
) VALUES (
    '22cb1908-627b-f9d5-11d8-e42d3c782d5f',
    '75f8e7bf-b2ce-2331-af33-efaeaf5366dc',
    'e6fbe149-37f9-52cb-96e6-88e5c93d869c',
    'PHACHARAPOL',
    'THA1255',
    'individual',
    52,
    307,
    244,
    'M',
    'THA',
    2012,
    false, false,
    'https://www.racingrulesofsailing.org/documents/172817',
    'https://www.racingrulesofsailing.org/documents/172817',
    'Official children-s-day-regatta-2026 result document 172817',
    'pdf',
    'Identity reviewed and confirmed by user on 23 October 2026.',
    'verified',
    now(), now(), now()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    rank = EXCLUDED.rank,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4a530257-457d-e563-bc10-002e6f1a243d',
    '22cb1908-627b-f9d5-11d8-e42d3c782d5f',
    '75f8e7bf-b2ce-2331-af33-efaeaf5366dc',
    'PHACHARAPOL',
    1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES
    ('22cb1908-627b-f9d5-11d8-e42d3c782d5f', 1, 34, NULL, false, '34.0'),
    ('22cb1908-627b-f9d5-11d8-e42d3c782d5f', 2, 48, NULL, false, '48.0'),
    ('22cb1908-627b-f9d5-11d8-e42d3c782d5f', 3, 36, NULL, false, '36.0'),
    ('22cb1908-627b-f9d5-11d8-e42d3c782d5f', 4, 63, 'DNC', true, '(63.0 DNC)'),
    ('22cb1908-627b-f9d5-11d8-e42d3c782d5f', 5, 63, 'DNC', false, '63.0 DNC'),
    ('22cb1908-627b-f9d5-11d8-e42d3c782d5f', 6, 63, 'DNC', false, '63.0 DNC');

-- Result: PHACHARAPOL MUNWONG (Rank 61, Sail 0) in Children's Day Regatta 2026 — Optimist
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, birth_year,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type,
    evidence_notes, verification_status, verified_at, created_at, updated_at
) VALUES (
    '5a2d04f5-92f8-b5b7-2d27-20081828230b',
    '81620549-758e-5209-9f80-4ac3f7cedbbf',
    'e6fbe149-37f9-52cb-96e6-88e5c93d869c',
    'PHACHARAPOL MUNWONG',
    '0',
    'individual',
    61,
    378,
    315,
    'M',
    'THA',
    2012,
    false, false,
    'https://www.racingrulesofsailing.org/documents/172817',
    'https://www.racingrulesofsailing.org/documents/172817',
    'Official children-s-day-regatta-2026 result document 172817',
    'pdf',
    'Identity reviewed and confirmed by user on 23 October 2026.',
    'verified',
    now(), now(), now()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    rank = EXCLUDED.rank,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '950ebe6f-41ff-5112-857c-2926ef4a3123',
    '5a2d04f5-92f8-b5b7-2d27-20081828230b',
    '81620549-758e-5209-9f80-4ac3f7cedbbf',
    'PHACHARAPOL MUNWONG',
    1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES
    ('5a2d04f5-92f8-b5b7-2d27-20081828230b', 1, 63, 'DNC', true, '(63.0 DNC)'),
    ('5a2d04f5-92f8-b5b7-2d27-20081828230b', 2, 63, 'DNC', false, '63.0 DNC'),
    ('5a2d04f5-92f8-b5b7-2d27-20081828230b', 3, 63, 'DNC', false, '63.0 DNC'),
    ('5a2d04f5-92f8-b5b7-2d27-20081828230b', 4, 63, 'DNC', false, '63.0 DNC'),
    ('5a2d04f5-92f8-b5b7-2d27-20081828230b', 5, 63, 'DNC', false, '63.0 DNC'),
    ('5a2d04f5-92f8-b5b7-2d27-20081828230b', 6, 63, 'DNC', false, '63.0 DNC');

-- Result: PHACHARAPOL MUNWONG (Rank 7, Sail 5) in EGAT and YRAT Regatta 2026 — ILCA 4
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, birth_year,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type,
    evidence_notes, verification_status, verified_at, created_at, updated_at
) VALUES (
    '059cec3b-d4a5-7c02-5545-667d677fa372',
    '81620549-758e-5209-9f80-4ac3f7cedbbf',
    '28e32d7a-2de6-5628-a0b6-6797f3bc0eb2',
    'PHACHARAPOL MUNWONG',
    '5',
    'individual',
    7,
    35,
    35,
    'M',
    'THA',
    NULL,
    false, false,
    'https://www.racingrulesofsailing.org/documents/197632',
    'https://www.racingrulesofsailing.org/documents/197632',
    'Official egat-and-yrat-regatta-2026 result document 197632',
    'pdf',
    'Identity reviewed and confirmed by user on 23 October 2026.',
    'verified',
    now(), now(), now()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    rank = EXCLUDED.rank,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '339455d5-470c-af32-cd68-c7e2d55e4b30',
    '059cec3b-d4a5-7c02-5545-667d677fa372',
    '81620549-758e-5209-9f80-4ac3f7cedbbf',
    'PHACHARAPOL MUNWONG',
    1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES
    ('059cec3b-d4a5-7c02-5545-667d677fa372', 1, 7, NULL, false, '7.0'),
    ('059cec3b-d4a5-7c02-5545-667d677fa372', 2, 4, NULL, false, '4.0'),
    ('059cec3b-d4a5-7c02-5545-667d677fa372', 3, 9, NULL, false, '9.0'),
    ('059cec3b-d4a5-7c02-5545-667d677fa372', 4, 4, NULL, false, '4.0'),
    ('059cec3b-d4a5-7c02-5545-667d677fa372', 5, 6, NULL, false, '6.0'),
    ('059cec3b-d4a5-7c02-5545-667d677fa372', 6, 5, NULL, false, '5.0');

-- Result: NOPPHADON TOPHO (Rank 34, Sail 33) in EGAT and YRAT Regatta 2026 — Optimist
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, birth_year,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type,
    evidence_notes, verification_status, verified_at, created_at, updated_at
) VALUES (
    '213886ec-45a8-fac2-1304-990a84d8010f',
    'd5453895-83cb-4b63-b701-804ce42ce4b2',
    '5d3925a0-65b1-52b8-9b89-dd059afc5ad0',
    'NOPPHADON TOPHO',
    '33',
    'individual',
    34,
    205,
    205,
    'M',
    'THA',
    2011,
    false, false,
    'https://www.racingrulesofsailing.org/documents/197632',
    'https://www.racingrulesofsailing.org/documents/197632',
    'Official egat-and-yrat-regatta-2026 result document 197632',
    'pdf',
    'Identity reviewed and confirmed by user on 23 October 2026.',
    'verified',
    now(), now(), now()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    rank = EXCLUDED.rank,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5a16d2d0-c8b0-f1e8-b15b-feb508473a2c',
    '213886ec-45a8-fac2-1304-990a84d8010f',
    'd5453895-83cb-4b63-b701-804ce42ce4b2',
    'NOPPHADON TOPHO',
    1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES
    ('213886ec-45a8-fac2-1304-990a84d8010f', 1, 35, NULL, false, '35.0'),
    ('213886ec-45a8-fac2-1304-990a84d8010f', 2, 34, NULL, false, '34.0'),
    ('213886ec-45a8-fac2-1304-990a84d8010f', 3, 27, NULL, false, '27.0'),
    ('213886ec-45a8-fac2-1304-990a84d8010f', 4, 33, NULL, false, '33.0'),
    ('213886ec-45a8-fac2-1304-990a84d8010f', 5, 39, NULL, false, '39.0'),
    ('213886ec-45a8-fac2-1304-990a84d8010f', 6, 37, NULL, false, '37.0');

-- Result: SOMBUN THAWEEBUNRUNGRUEANG (Rank 46, Sail 39) in EGAT and YRAT Regatta 2026 — Optimist
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, birth_year,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type,
    evidence_notes, verification_status, verified_at, created_at, updated_at
) VALUES (
    'e596f15b-394d-99bc-376d-0710a1cb7f12',
    'b19cb961-68c3-76e5-830b-fdb23dde0cdb',
    '5d3925a0-65b1-52b8-9b89-dd059afc5ad0',
    'SOMBUN THAWEEBUNRUNGRUEANG',
    '39',
    'individual',
    46,
    273,
    273,
    'M',
    'THA',
    2012,
    false, false,
    'https://www.racingrulesofsailing.org/documents/197632',
    'https://www.racingrulesofsailing.org/documents/197632',
    'Official egat-and-yrat-regatta-2026 result document 197632',
    'pdf',
    'Identity reviewed and confirmed by user on 23 October 2026.',
    'verified',
    now(), now(), now()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    rank = EXCLUDED.rank,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '152d5fef-18e6-de48-5455-b61bcf2abf85',
    'e596f15b-394d-99bc-376d-0710a1cb7f12',
    'b19cb961-68c3-76e5-830b-fdb23dde0cdb',
    'SOMBUN THAWEEBUNRUNGRUEANG',
    1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES
    ('e596f15b-394d-99bc-376d-0710a1cb7f12', 1, 40, NULL, false, '40.0'),
    ('e596f15b-394d-99bc-376d-0710a1cb7f12', 2, 45, NULL, false, '45.0'),
    ('e596f15b-394d-99bc-376d-0710a1cb7f12', 3, 49, 'UFD', false, '49.0 UFD'),
    ('e596f15b-394d-99bc-376d-0710a1cb7f12', 4, 46, NULL, false, '46.0'),
    ('e596f15b-394d-99bc-376d-0710a1cb7f12', 5, 49, 'DNF', false, '49.0 DNF'),
    ('e596f15b-394d-99bc-376d-0710a1cb7f12', 6, 44, NULL, false, '44.0');

-- Result: HENRY ZOU (Rank 17, Sail 214613) in ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 4
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, birth_year,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type,
    evidence_notes, verification_status, verified_at, created_at, updated_at
) VALUES (
    '5c9f1e58-41cb-9293-7e82-84ea629c6b75',
    '8b737931-4735-7169-6a9b-3adf071b8ebb',
    'e001877f-bffd-55c3-a5c7-cc2803132edf',
    'HENRY ZOU',
    '214613',
    'individual',
    17,
    179,
    143,
    'M',
    'CHN',
    2011,
    false, false,
    'https://rvycresults.com/Results/2026/ILCA2026/Results.html?refresh=2&speed=70&step=2',
    'https://rvycresults.com/Results/2026/ILCA2026/Results.html?refresh=2&speed=70&step=2',
    'ILCA Thailand National Championship 23–26 January 2026 — Royal Varuna Yacht Club',
    'link',
    'Identity reviewed and confirmed by user on 23 October 2026.',
    'verified',
    now(), now(), now()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    rank = EXCLUDED.rank,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6fe25b49-b6ce-520c-4d90-405f0e581edd',
    '5c9f1e58-41cb-9293-7e82-84ea629c6b75',
    '8b737931-4735-7169-6a9b-3adf071b8ebb',
    'HENRY ZOU',
    1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES
    ('5c9f1e58-41cb-9293-7e82-84ea629c6b75', 1, 32, NULL, false, '32.0'),
    ('5c9f1e58-41cb-9293-7e82-84ea629c6b75', 2, 22, NULL, false, '22.0'),
    ('5c9f1e58-41cb-9293-7e82-84ea629c6b75', 3, 15, NULL, false, '15.0'),
    ('5c9f1e58-41cb-9293-7e82-84ea629c6b75', 4, 36, NULL, true, '(36.0)'),
    ('5c9f1e58-41cb-9293-7e82-84ea629c6b75', 5, 7, NULL, false, '7.0'),
    ('5c9f1e58-41cb-9293-7e82-84ea629c6b75', 6, 12, NULL, false, '12.0'),
    ('5c9f1e58-41cb-9293-7e82-84ea629c6b75', 7, 17, NULL, false, '17.0'),
    ('5c9f1e58-41cb-9293-7e82-84ea629c6b75', 8, 20, NULL, false, '20.0'),
    ('5c9f1e58-41cb-9293-7e82-84ea629c6b75', 9, 18, NULL, false, '18.0');

-- Result: Somboon TaweeBoonrungrueng (Rank 29, Sail THA223) in Ranong Regatta Sailing Championship 2026 — Optimist
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, birth_year,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type,
    evidence_notes, verification_status, verified_at, created_at, updated_at
) VALUES (
    'de762375-021f-2ad2-b447-18f843a4854f',
    'b19cb961-68c3-76e5-830b-fdb23dde0cdb',
    '0b16b891-6ac6-531a-8be9-67477c4c1289',
    'Somboon TaweeBoonrungrueng',
    'THA223',
    'individual',
    29,
    224,
    189,
    'M',
    'THA',
    2012,
    false, false,
    'https://sailingtech.in.th/preview/results/ranong-regatta-2026/optimist-overall.html',
    'https://sailingtech.in.th/preview/results/ranong-regatta-2026/optimist-overall.html',
    '',
    'link',
    'Identity reviewed and confirmed by user on 23 October 2026.',
    'verified',
    now(), now(), now()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    rank = EXCLUDED.rank,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f2545986-272a-acd5-4765-662a123b6b1d',
    'de762375-021f-2ad2-b447-18f843a4854f',
    'b19cb961-68c3-76e5-830b-fdb23dde0cdb',
    'Somboon TaweeBoonrungrueng',
    1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES
    ('de762375-021f-2ad2-b447-18f843a4854f', 1, 17, NULL, false, '17.0'),
    ('de762375-021f-2ad2-b447-18f843a4854f', 2, 31, NULL, false, '31.0'),
    ('de762375-021f-2ad2-b447-18f843a4854f', 3, 26, NULL, false, '26.0'),
    ('de762375-021f-2ad2-b447-18f843a4854f', 4, 29, NULL, false, '29.0'),
    ('de762375-021f-2ad2-b447-18f843a4854f', 5, 32, NULL, false, '32.0'),
    ('de762375-021f-2ad2-b447-18f843a4854f', 6, 26, NULL, false, '26.0'),
    ('de762375-021f-2ad2-b447-18f843a4854f', 7, 35, 'UFD', true, '(35.0 UFD)'),
    ('de762375-021f-2ad2-b447-18f843a4854f', 8, 28, NULL, false, '28.0');

-- Result: Noppadol To-pho (Rank 30, Sail 522) in Ranong Regatta Sailing Championship 2026 — Optimist
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, birth_year,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type,
    evidence_notes, verification_status, verified_at, created_at, updated_at
) VALUES (
    'bdec8141-dbea-9ed1-167e-dde0b019e5da',
    'd5453895-83cb-4b63-b701-804ce42ce4b2',
    '0b16b891-6ac6-531a-8be9-67477c4c1289',
    'Noppadol To-pho',
    '522',
    'individual',
    30,
    226,
    195,
    'M',
    'THA',
    2011,
    false, false,
    'https://sailingtech.in.th/preview/results/ranong-regatta-2026/optimist-overall.html',
    'https://sailingtech.in.th/preview/results/ranong-regatta-2026/optimist-overall.html',
    '',
    'link',
    'Identity reviewed and confirmed by user on 23 October 2026.',
    'verified',
    now(), now(), now()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    rank = EXCLUDED.rank,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b1a63761-7cd6-752b-fb43-7121d7cfb3a9',
    'bdec8141-dbea-9ed1-167e-dde0b019e5da',
    'd5453895-83cb-4b63-b701-804ce42ce4b2',
    'Noppadol To-pho',
    1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES
    ('bdec8141-dbea-9ed1-167e-dde0b019e5da', 1, 29, NULL, false, '29.0'),
    ('bdec8141-dbea-9ed1-167e-dde0b019e5da', 2, 24, NULL, false, '24.0'),
    ('bdec8141-dbea-9ed1-167e-dde0b019e5da', 3, 31, NULL, true, '(31.0)'),
    ('bdec8141-dbea-9ed1-167e-dde0b019e5da', 4, 31, NULL, false, '31.0'),
    ('bdec8141-dbea-9ed1-167e-dde0b019e5da', 5, 27, NULL, false, '27.0'),
    ('bdec8141-dbea-9ed1-167e-dde0b019e5da', 6, 28, NULL, false, '28.0'),
    ('bdec8141-dbea-9ed1-167e-dde0b019e5da', 7, 27, NULL, false, '27.0'),
    ('bdec8141-dbea-9ed1-167e-dde0b019e5da', 8, 29, NULL, false, '29.0');

-- Result: NUR HAFIZAHANANI (Rank 9, Sail 4712) in Thailand International Sailing Championships 2026 — ILCA 6
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, birth_year,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type,
    evidence_notes, verification_status, verified_at, created_at, updated_at
) VALUES (
    'fd1bb621-25c3-751b-eced-78f35de272a3',
    '96bfe722-1e1a-4e2c-901e-dae4789973ac',
    'cd6b9360-31a0-5164-9f2d-9c08ac532d61',
    'NUR HAFIZAHANANI',
    '4712',
    'individual',
    9,
    110,
    87,
    'F',
    'MAS',
    2007,
    false, false,
    'https://www.racingrulesofsailing.org/documents/183990',
    'https://www.racingrulesofsailing.org/documents/183990',
    'Official thailand-international-sailing-championships-2026 result document 183990',
    'pdf',
    'Identity reviewed and confirmed by user on 23 October 2026.',
    'verified',
    now(), now(), now()
) ON CONFLICT (id) DO UPDATE SET
    sailor_id = EXCLUDED.sailor_id,
    rank = EXCLUDED.rank,
    nett_score = EXCLUDED.nett_score;

INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e1693a4b-e769-d281-7394-5cc2dd722f19',
    'fd1bb621-25c3-751b-eced-78f35de272a3',
    '96bfe722-1e1a-4e2c-901e-dae4789973ac',
    'NUR HAFIZAHANANI',
    1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;

INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES
    ('fd1bb621-25c3-751b-eced-78f35de272a3', 1, 10, NULL, false, '10.0'),
    ('fd1bb621-25c3-751b-eced-78f35de272a3', 2, 9, NULL, false, '9.0'),
    ('fd1bb621-25c3-751b-eced-78f35de272a3', 3, 5, NULL, false, '5.0'),
    ('fd1bb621-25c3-751b-eced-78f35de272a3', 4, 9, NULL, false, '9.0'),
    ('fd1bb621-25c3-751b-eced-78f35de272a3', 5, 10, NULL, false, '10.0'),
    ('fd1bb621-25c3-751b-eced-78f35de272a3', 6, 11, NULL, true, '(11.0)'),
    ('fd1bb621-25c3-751b-eced-78f35de272a3', 7, 10, NULL, false, '10.0'),
    ('fd1bb621-25c3-751b-eced-78f35de272a3', 8, 9, NULL, false, '9.0'),
    ('fd1bb621-25c3-751b-eced-78f35de272a3', 9, 10, NULL, false, '10.0'),
    ('fd1bb621-25c3-751b-eced-78f35de272a3', 10, 12, NULL, true, '(12.0)'),
    ('fd1bb621-25c3-751b-eced-78f35de272a3', 11, 6, NULL, false, '6.0'),
    ('fd1bb621-25c3-751b-eced-78f35de272a3', 12, 9, NULL, false, '9.0');

COMMIT;
