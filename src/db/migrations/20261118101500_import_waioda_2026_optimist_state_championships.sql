-- Migration: 20261118101500_import_waioda_2026_optimist_state_championships.sql
-- Description: Import 2026 WAIODA Optimist WA State Championships (Open 23, Intermediate 19; 10 races, 2 discards).
-- Source: Royal Freshwater Bay Yacht Club / Sportspage official result sheets (no official PDF published; confirmed final by user).

BEGIN;

CREATE TEMP TABLE _waioda_2026_payload (
  fleet text NOT NULL,
  source_rank integer NOT NULL,
  sail_number text NOT NULL,
  source_name text NOT NULL,
  club text NOT NULL,
  total_score real NOT NULL,
  nett_score real NOT NULL,
  race_scores jsonb NOT NULL,
  sailor_id uuid,
  handle text
) ON COMMIT DROP;

INSERT INTO _waioda_2026_payload (fleet, source_rank, sail_number, source_name, club, total_score, nett_score, race_scores, sailor_id, handle) VALUES
  ('Open', 1, '1904', 'Harry Cooper', 'RFBYC/FSC', 23.0, 11.0, '["1( 1)", "2( 2)", "1( 1)", "1( 1)", "[ 4]( 4)", "1( 1)", "2( 2)", "2( 2)", "1( 1)", "[ 8]( 8)"]'::jsonb, 'b8cbccdc-a8ce-47cf-8728-5011daab6617'::uuid, 'waioda26-harry-cooper-1904'),
  ('Open', 2, '1304', 'Lily-May Weller', 'FSC', 21.0, 14.0, '["2( 2)", "1( 1)", "[ 3]( 3)", "2( 2)", "2( 2)", "[ 4]( 4)", "1( 1)", "1( 1)", "2( 2)", "3( 3)"]'::jsonb, 'a3082455-4079-441d-8436-478f4c9024b7'::uuid, 'waioda26-lily-may-weller-1304'),
  ('Open', 3, '1740', 'Jayden Epari', 'RFBYC', 38.0, 26.0, '["4( 4)", "4( 4)", "2( 2)", "3( 3)", "3( 3)", "2( 2)", "[ 5]( 5)", "5( 5)", "3( 3)", "[ 7]( 7)"]'::jsonb, 'bf23fd36-3596-4b3c-b92d-9123a1a84c14'::uuid, 'waioda26-jayden-epari-1740'),
  ('Open', 4, '1291', 'Connor Grant', 'FSC/SoPYC', 50.0, 30.0, '["3( 3)", "3( 3)", "4( 4)", "4( 4)", "1( 1)", "3( 3)", "[ 9]( 9)", "6( 6)", "6( 6)", "[ 11]( 11)"]'::jsonb, 'ad46f601-d513-4b82-803f-46a12a4ff2eb'::uuid, 'waioda26-connor-grant-1291'),
  ('Open', 5, '1316', 'Asher Williams', 'SoPYC', 77.0, 48.0, '["6( 6)", "8( 8)", "8( 8)", "6( 6)", "5( 5)", "5( 5)", "3( 3)", "[ 10]( 10)", "7( 7)", "[ 19]( 19)"]'::jsonb, '5359625c-bf84-49d1-b983-b908bd5b7f2e'::uuid, 'waioda26-asher-williams-1316'),
  ('Open', 6, '529', 'Humphrey Hager', 'RFBYC', 87.0, 56.0, '["7( 7)", "7( 7)", "6( 6)", "[ 16]( 16)", "11( 11)", "7( 7)", "4( 4)", "4( 4)", "[ 15]( 15)", "10( 10)"]'::jsonb, 'b8e6f44d-407f-5a09-8ce1-761d67253264'::uuid, 'waioda26-humphrey-hager-529'),
  ('Open', 7, '1486', 'Dylan Epari', 'RFBYC', 98.0, 57.0, '["9( 9)", "5( 5)", "5( 5)", "7( 7)", "8( 8)", "[ 24](RET)", "6( 6)", "3( 3)", "[ 17]( 17)", "14( 14)"]'::jsonb, 'db009883-9497-4b94-aebb-faefa490f260'::uuid, 'waioda26-dylan-epari-1486'),
  ('Open', 8, '1520', 'Ollie Harry', 'FSC', 101.0, 62.0, '["5( 5)", "6( 6)", "10( 10)", "12( 12)", "9( 9)", "9( 9)", "[ 22]( 22)", "[ 17]( 17)", "5( 5)", "6( 6)"]'::jsonb, '49e3b629-7287-5783-a7d3-d00366db458b'::uuid, 'waioda26-ollie-harry-1520'),
  ('Open', 9, '457', 'Noa Ploumis', 'FSC', 98.0, 70.0, '["10( 10)", "12( 12)", "7( 7)", "9( 9)", "[ 13]( 13)", "11( 11)", "[ 15]( 15)", "8( 8)", "4( 4)", "9( 9)"]'::jsonb, NULL, 'waioda26-noa-ploumis-457'),
  ('Open', 10, '1905', 'Callum Grant', 'FSC/SoPYC', 106.0, 73.0, '["[ 16]( 16)", "10( 10)", "11( 11)", "11( 11)", "10( 10)", "[ 17]( 17)", "14( 14)", "7( 7)", "8( 8)", "2( 2)"]'::jsonb, 'a920942d-e921-4639-8fe8-bc183c330619'::uuid, 'waioda26-callum-grant-1905'),
  ('Open', 11, '560', 'Hayden Leighton', 'RFBYC', 110.0, 80.0, '["13( 13)", "13( 13)", "[ 14]( 14)", "13( 13)", "6( 6)", "13( 13)", "8( 8)", "13( 13)", "[ 16]( 16)", "1( 1)"]'::jsonb, '9665941b-a00e-5d45-b44f-dacb4195bad6'::uuid, 'waioda26-hayden-leighton-560'),
  ('Open', 12, '327', 'Caitlin Grant', 'FSC/SoPYC', 133.0, 87.0, '["[ 24](RET)", "9( 9)", "12( 12)", "5( 5)", "7( 7)", "[ 22]( 22)", "17( 17)", "11( 11)", "10( 10)", "16( 16)"]'::jsonb, '60dd4d51-c920-5e84-b1e4-b662df586d2f'::uuid, 'waioda26-caitlin-grant-327'),
  ('Open', 13, '503', 'Matthew Sanders', 'RPYC', 134.0, 100.0, '["[ 18]( 18)", "11( 11)", "13( 13)", "15( 15)", "14( 14)", "15( 15)", "[ 16]( 16)", "14( 14)", "13( 13)", "5( 5)"]'::jsonb, '0e50e1f3-1582-531e-a22f-8c830e1c66f0'::uuid, 'waioda26-matthew-sanders-503'),
  ('Open', 14, '325', 'Alice Cameron', 'FSC', 140.0, 103.0, '["15( 15)", "17( 17)", "17( 17)", "[ 18]( 18)", "15( 15)", "[ 19]( 19)", "10( 10)", "16( 16)", "9( 9)", "4( 4)"]'::jsonb, '5f837edc-6728-50d4-901d-6a8ea81dc026'::uuid, 'waioda26-alice-cameron-325'),
  ('Open', 15, '1718', 'Leo Stay', 'RFBYC', 152.0, 108.0, '["12( 12)", "16( 16)", "21( 21)", "14( 14)", "[ 22]( 22)", "6( 6)", "7( 7)", "21( 21)", "11( 11)", "[ 22]( 22)"]'::jsonb, '341233b1-e3cf-5a0e-8636-88088ce0cb20'::uuid, 'waioda26-leo-stay-1718'),
  ('Open', 16, '1157', 'Daniel Saladine', 'MBSC', 151.0, 110.0, '["[ 20]( 20)", "19( 19)", "16( 16)", "8( 8)", "[ 21]( 21)", "18( 18)", "13( 13)", "9( 9)", "14( 14)", "13( 13)"]'::jsonb, 'cb9a3ee2-bfe4-5259-a130-6cf1752ce7e7'::uuid, 'waioda26-daniel-saladine-1157'),
  ('Open', 17, '1500', 'Lauchlan Naylor', 'RFBYC/FSC', 159.0, 115.0, '["17( 17)", "[ 21]( 21)", "19( 19)", "10( 10)", "17( 17)", "8( 8)", "[ 23]( 23)", "15( 15)", "12( 12)", "17( 17)"]'::jsonb, '5e989cd1-b734-5443-9d3e-ea9794a9686f'::uuid, 'waioda26-lauchlan-naylor-1500'),
  ('Open', 18, '1861', 'Massimo Guidotti', 'FSC', 162.0, 118.0, '["14( 14)", "14( 14)", "15( 15)", "[ 22]( 22)", "20( 20)", "10( 10)", "12( 12)", "[ 22]( 22)", "21( 21)", "12( 12)"]'::jsonb, '6532ff66-67dd-59ba-877f-0e4a4db12199'::uuid, 'waioda26-massimo-guidotti-1861'),
  ('Open', 19, '282', 'Adeline Sanders', 'RPYC', 165.0, 123.0, '["[ 19]( 19)", "18( 18)", "9( 9)", "17( 17)", "12( 12)", "14( 14)", "19( 19)", "19( 19)", "[ 23]( 23)", "15( 15)"]'::jsonb, '9a874041-f749-5c35-a40a-a10deb2d3d8c'::uuid, 'waioda26-adeline-sanders-282'),
  ('Open', 20, '947', 'Charlie Boulton', 'RFBYC', 173.0, 129.0, '["8( 8)", "15( 15)", "18( 18)", "[ 20]( 20)", "18( 18)", "16( 16)", "18( 18)", "[ 24](RET)", "18( 18)", "18( 18)"]'::jsonb, 'e2d76144-8458-5f5a-a466-7b4359a454e8'::uuid, 'waioda26-charlie-boulton-947'),
  ('Open', 21, '1864', 'Ella Lowry', 'SoPYC', 170.0, 129.0, '["11( 11)", "[ 20]( 20)", "20( 20)", "[ 21]( 21)", "16( 16)", "12( 12)", "11( 11)", "20( 20)", "19( 19)", "20( 20)"]'::jsonb, NULL, 'waioda26-ella-lowry-1864'),
  ('Open', 22, '563', 'Shay Page', 'HYC', 201.0, 155.0, '["[ 24](RET)", "[ 22]( 22)", "22( 22)", "19( 19)", "19( 19)", "21( 21)", "21( 21)", "12( 12)", "20( 20)", "21( 21)"]'::jsonb, '4d487477-0c02-58bd-87e3-ccfd1e2b8fc8'::uuid, 'waioda26-shay-page-563'),
  ('Open', 23, '246', 'Jacques Burling', 'FSC', 216.0, 170.0, '["21( 21)", "[ 23]( 23)", "[ 23]( 23)", "23( 23)", "23( 23)", "20( 20)", "20( 20)", "18( 18)", "22( 22)", "23( 23)"]'::jsonb, 'e6668df4-6390-5d15-8761-1bf98a312b78'::uuid, 'waioda26-jacques-burling-246'),
  ('Intermediate', 1, '1152', 'Louis Crowther', 'RFBYC', 18.0, 12.0, '["1( 1)", "1( 1)", "2( 2)", "2( 2)", "2( 2)", "1( 1)", "1( 1)", "[ 3]( 3)", "[ 3]( 3)", "2( 2)"]'::jsonb, 'aba84567-9a62-5f40-85f5-3f5e37ad16c1'::uuid, 'waioda26-louis-crowther-1152'),
  ('Intermediate', 2, '1514', 'Clara Olsen', 'TCYC/FSC', 52.0, 25.0, '["[ 20](DNF)", "[ 7]( 7)", "3( 3)", "4( 4)", "4( 4)", "2( 2)", "5( 5)", "2( 2)", "2( 2)", "3( 3)"]'::jsonb, NULL, 'waioda26-clara-olsen-1514'),
  ('Intermediate', 3, '593', 'Thomas Carroll', 'SoPYC', 53.0, 28.0, '["2( 2)", "5( 5)", "[ 7](SCP)", "6( 6)", "7( 7)", "[ 18]( 18)", "2( 2)", "1( 1)", "1( 1)", "4( 4)"]'::jsonb, 'dc73328b-c4db-541b-8d79-7020d51bf9a9'::uuid, 'waioda26-thomas-carroll-593'),
  ('Intermediate', 4, '1677', 'Harry Cunningham', 'FSC', 45.0, 28.0, '["3( 3)", "2( 2)", "[ 7]( 7)", "7( 7)", "3( 3)", "3( 3)", "3( 3)", "[ 10]( 10)", "6( 6)", "1( 1)"]'::jsonb, '980b8ddb-e1d6-5ab8-a7f3-662cedff1755'::uuid, 'waioda26-harry-cunningham-1677'),
  ('Intermediate', 5, '1287', 'Shun Archibald', 'RFBYC', 58.0, 34.0, '["4( 4)", "3( 3)", "6( 6)", "3( 3)", "1( 1)", "5( 5)", "4( 4)", "[ 13]( 13)", "8( 8)", "[ 11]( 11)"]'::jsonb, '00069d4d-4df9-50d9-9551-f2212d3b7c66'::uuid, 'waioda26-shun-archibald-1287'),
  ('Intermediate', 6, '1355', 'William Carroll', 'SoPYC', 76.0, 49.0, '["5( 5)", "4( 4)", "5( 5)", "5( 5)", "5( 5)", "12( 12)", "6( 6)", "[ 14]( 14)", "[ 13]( 13)", "7( 7)"]'::jsonb, 'a3c51e0f-01e8-5894-a709-a280e1ffe376'::uuid, 'waioda26-william-carroll-1355'),
  ('Intermediate', 7, '559', 'Aiden Wong', 'RPYC', 75.0, 53.0, '["[ 10]( 10)", "9( 9)", "9( 9)", "1( 1)", "9( 9)", "7( 7)", "[ 12]( 12)", "5( 5)", "5( 5)", "8( 8)"]'::jsonb, NULL, 'waioda26-aiden-wong-559'),
  ('Intermediate', 8, '287', 'Blake Harkin', 'FSC', 79.0, 57.0, '["6( 6)", "6( 6)", "[ 11]( 11)", "[ 11]( 11)", "8( 8)", "4( 4)", "11( 11)", "8( 8)", "9( 9)", "5( 5)"]'::jsonb, 'b6369fa8-878c-519a-a304-b9b8374d660e'::uuid, 'waioda26-blake-harkin-287'),
  ('Intermediate', 9, '740', 'Hugo Crowther', 'RFBYC', 96.0, 62.0, '["[ 20](DNF)", "10( 10)", "8( 8)", "8( 8)", "13( 13)", "6( 6)", "[ 14](SCP)", "7( 7)", "4( 4)", "6( 6)"]'::jsonb, '9fbb7cec-2583-5d47-990a-93fdb10dba32'::uuid, 'waioda26-hugo-crowther-740'),
  ('Intermediate', 10, '557', 'Quade Potter', 'WYC', 110.0, 72.0, '["7( 7)", "8( 8)", "4( 4)", "[ 18]( 18)", "6( 6)", "8( 8)", "9( 9)", "15( 15)", "[ 20](DSQ)", "15( 15)"]'::jsonb, '331d73ce-a518-5129-8c22-2b6294040fb6'::uuid, 'waioda26-quade-potter-557'),
  ('Intermediate', 11, '281', 'Oakley Raven', 'NYC', 123.0, 87.0, '["8( 8)", "11( 11)", "[ 16]( 16)", "13( 13)", "11( 11)", "16( 16)", "[ 20](DNF)", "4( 4)", "11( 11)", "13( 13)"]'::jsonb, NULL, 'waioda26-oakley-raven-281'),
  ('Intermediate', 12, '220', 'Amy Cameron', 'FSC', 134.0, 94.0, '["12( 12)", "[ 20](DNC)", "[ 20](DNC)", "10( 10)", "15( 15)", "9( 9)", "13( 13)", "9( 9)", "12( 12)", "14( 14)"]'::jsonb, 'ff5ae8f1-504b-5885-aba7-1618a9bfab99'::uuid, 'waioda26-amy-cameron-220'),
  ('Intermediate', 13, '1942', 'Zeno Brackenridge', 'RFBYC', 135.0, 95.0, '["9( 9)", "13( 13)", "10( 10)", "9( 9)", "[ 20](DSQ)", "10( 10)", "[ 20](DNF)", "20(RET)", "14( 14)", "10( 10)"]'::jsonb, 'ff8c5b6c-ec78-5769-8f0c-ae368ee1edb4'::uuid, 'waioda26-zeno-brackenridge-1942'),
  ('Intermediate', 14, '1203', 'Audrey Cameron', 'FSC', 140.0, 100.0, '["11( 11)", "[ 20](DNC)", "[ 20](DNC)", "20(DNC)", "18( 18)", "17( 17)", "7( 7)", "11( 11)", "7( 7)", "9( 9)"]'::jsonb, 'b0687a1f-46e7-53d6-932b-e8bb5a2cdeb9'::uuid, 'waioda26-audrey-cameron-1203'),
  ('Intermediate', 15, '657', 'Toby Brooks', 'RFBYC', 139.0, 102.0, '["[ 20](DNS)", "15( 15)", "13( 13)", "12( 12)", "10( 10)", "14( 14)", "10( 10)", "12( 12)", "16( 16)", "[ 17]( 17)"]'::jsonb, NULL, 'waioda26-toby-brooks-657'),
  ('Intermediate', 16, '294', 'Sienna Ratcliff', 'TCYC', 150.0, 110.0, '["[ 20](DNS)", "17( 17)", "14( 14)", "16( 16)", "14( 14)", "[ 20](RET)", "15( 15)", "6( 6)", "10( 10)", "18( 18)"]'::jsonb, NULL, 'waioda26-sienna-ratcliff-294'),
  ('Intermediate', 17, '680', 'Hector Campbell-Sloan', 'FSC', 155.0, 116.0, '["[ 20](DNS)", "14( 14)", "12( 12)", "15( 15)", "16( 16)", "11( 11)", "16( 16)", "17( 17)", "15( 15)", "[ 19]( 19)"]'::jsonb, '7156515a-964c-5b40-8550-3c0f386a6d5a'::uuid, 'waioda26-hector-campbell-sl-680'),
  ('Intermediate', 18, '566', 'Edison Williams', 'RPYC', 151.0, 116.0, '["13( 13)", "16( 16)", "15( 15)", "[ 17]( 17)", "17( 17)", "13( 13)", "14( 14)", "16( 16)", "[ 18]( 18)", "12( 12)"]'::jsonb, '8a82e08a-0937-5004-a427-9d52b1222c44'::uuid, 'waioda26-edison-williams-566'),
  ('Intermediate', 19, '1393', 'Maya Forrester', 'RFBYC', 161.0, 121.0, '["[ 20](DNC)", "12( 12)", "17( 17)", "14( 14)", "12( 12)", "15( 15)", "[ 20](RET)", "18( 18)", "17( 17)", "16( 16)"]'::jsonb, 'ed8edcb0-8d0c-5e82-a7a4-866072fd4955'::uuid, 'waioda26-maya-forrester-1393');

-- Create minimal profiles for the 7 new WAIODA sailors
INSERT INTO public.sailors (id, name, handle, sail_number, club, nationality, created_at, updated_at)
SELECT gen_random_uuid(), p.source_name, p.handle, p.sail_number, p.club, 'AUS', now(), now()
FROM _waioda_2026_payload p
WHERE p.sailor_id IS NULL
ON CONFLICT (handle) DO NOTHING;

UPDATE _waioda_2026_payload p
SET sailor_id = s.id
FROM public.sailors s
WHERE p.sailor_id IS NULL AND s.handle = p.handle;

UPDATE public.regatta_events SET venue = 'Royal Freshwater Bay Yacht Club, Peppermint Grove, WA', organizer = 'WAIODA / Royal Freshwater Bay Yacht Club', nor_url = 'https://rfbyc.asn.au/web/pages/optimiststatechampionships2026', scoring_rules = 'Appendix A low-point system; 10 races sailed, 8 to count (2 discards).', updated_at = now() WHERE id = 'f30715c5-c80c-433a-a6e2-6f7b61e5ed2b';

WITH fleets (slug, name, division, fleet_size, url) AS (VALUES
  ('waioda-optimist-wa-state-championships-2026-open', '2026 WAIODA Optimist WA State Championships — Open Fleet', 'Open', 23, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/OptimistStates2026/Open_Fleet_Championship.htm'),
  ('waioda-optimist-wa-state-championships-2026-intermediate', '2026 WAIODA Optimist WA State Championships — Intermediate Fleet', 'Intermediate', 19, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/OptimistStates2026/Intermediate_Fleet_Championship.htm')
)
INSERT INTO public.regattas (
  id, event_id, name, slug, date, end_date, total_fleet_size, division, race_count,
  geography, boat_class, counts_for_ranking, is_selection_trial, venue, organizer,
  official_results_url, official_results_source_name, schedule_notes, status, created_at, updated_at
)
SELECT gen_random_uuid(), 'f30715c5-c80c-433a-a6e2-6f7b61e5ed2b'::uuid, f.name, f.slug, DATE '2026-11-14', DATE '2026-11-15',
  f.fleet_size, f.division, 10, 'AUS', 'Optimist', false, false,
  'Royal Freshwater Bay Yacht Club, Peppermint Grove, WA', 'WAIODA / Royal Freshwater Bay Yacht Club',
  f.url, 'RFBYC / Sportspage Official Results (15 Nov 2026)',
  f.fleet_size::text || ' entries · 10 races · 2 discards · official RFBYC/Sportspage results.',
  'published', now(), now()
FROM fleets f
ON CONFLICT (slug) DO UPDATE SET
  event_id = EXCLUDED.event_id, name = EXCLUDED.name, total_fleet_size = EXCLUDED.total_fleet_size,
  race_count = 10, official_results_url = EXCLUDED.official_results_url, status = 'published', updated_at = now();

DELETE FROM public.regatta_results WHERE regatta_id IN (
  SELECT id FROM public.regattas WHERE slug IN ('waioda-optimist-wa-state-championships-2026-open', 'waioda-optimist-wa-state-championships-2026-intermediate')
);

INSERT INTO public.regatta_results (
  id, sailor_id, entry_label, entry_sail_number, entry_type, regatta_id, rank,
  nett_score, total_score, is_dns, is_overseas_commitment, gender, birth_year, nationality,
  evidence_url, evidence_name, evidence_type, official_url, evidence_notes,
  verification_status, verified_at, created_at, updated_at
)
SELECT gen_random_uuid(), p.sailor_id, p.source_name, p.sail_number, 'individual',
  r.id, p.source_rank, p.nett_score, p.total_score, false, false, s.gender,
  CASE WHEN s.dob IS NOT NULL THEN EXTRACT(YEAR FROM s.dob)::int ELSE NULL END, COALESCE(s.nationality, 'AUS'),
  r.official_results_url, r.official_results_source_name, 'link', r.official_results_url,
  'Imported from RFBYC / Sportspage official result sheet (confirmed final by user; no official PDF published).',
  'verified', now(), now(), now()
FROM _waioda_2026_payload p
JOIN public.sailors s ON s.id = p.sailor_id
JOIN public.regattas r ON r.slug = CASE p.fleet WHEN 'Open' THEN 'waioda-optimist-wa-state-championships-2026-open' ELSE 'waioda-optimist-wa-state-championships-2026-intermediate' END;

INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at)
SELECT gen_random_uuid(), rr.id, p.sailor_id, p.source_name, 1, 'solo', 'matched', false, now(), now()
FROM _waioda_2026_payload p
JOIN public.regattas r ON r.slug = CASE p.fleet WHEN 'Open' THEN 'waioda-optimist-wa-state-championships-2026-open' ELSE 'waioda-optimist-wa-state-championships-2026-intermediate' END
JOIN public.regatta_results rr ON rr.regatta_id = r.id AND rr.sailor_id = p.sailor_id;

INSERT INTO public.regatta_race_results (id, regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
SELECT gen_random_uuid(), rr.id, token.ordinality::integer,
  (regexp_match(token.raw_value, '([0-9.]+)'))[1]::real,
  NULLIF(NULLIF((regexp_match(token.raw_value, '\(([^)]+)\)'))[1], (regexp_match(token.raw_value, '([0-9.]+)'))[1]), ''),
  token.raw_value LIKE '[%',
  token.raw_value, now(), now()
FROM _waioda_2026_payload p
JOIN public.regattas r ON r.slug = CASE p.fleet WHEN 'Open' THEN 'waioda-optimist-wa-state-championships-2026-open' ELSE 'waioda-optimist-wa-state-championships-2026-intermediate' END
JOIN public.regatta_results rr ON rr.regatta_id = r.id AND rr.sailor_id = p.sailor_id
CROSS JOIN LATERAL jsonb_array_elements_text(p.race_scores) WITH ORDINALITY AS token(raw_value, ordinality);

INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
VALUES (
  'import', 'regatta', 'f30715c5-c80c-433a-a6e2-6f7b61e5ed2b', '2026 WAIODA Optimist WA State Championships',
  'Imported Open (23) and Intermediate (19) fleets from official RFBYC/Sportspage result sheets.',
  jsonb_build_object('open_entries', 23, 'intermediate_entries', 19, 'races', 10, 'pdf_corroboration', 'unavailable_on_rfbyc_waioda'),
  'daily_audit_20261118', clock_timestamp()
);

COMMIT;
