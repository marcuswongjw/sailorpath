-- Migration 158: Import Completed 2026 Australian Optimist Regattas
--
-- Events & Fleets Imported:
--   1. 2026 Musto Australian Optimist Championship — Intermediate Fleet (42 boats, 9 races, 1 discard)
--   2. 2026 Tasmanian Optimist State Championship — Open Fleet (6 boats, 6 races, 1 discard)
--   3. 2026 Tasmanian Optimist State Championship — Intermediate Fleet (6 boats, 6 races, 1 discard)
--   4. 2026 VIODA International Optimist Victorian & Open Championship — Open Fleet (38 boats, 8 races, 1 discard)
--   5. 2026 VIODA International Optimist Victorian & Open Championship — Intermediate Fleet (27 boats, 7 races, 1 discard)
--   6. 2026 NSW Optimist State Championship — Open Fleet (42 boats, 3 races, 0 discards)
--   7. 2026 NSW Optimist State Championship — Intermediate Fleet (55 boats, 2 races, 0 discards)
--   8. 2026 ACT Optimist Championship — Open Fleet (27 boats, 7 races, 1 discard)
--   9. 2026 ACT Optimist Championship — Intermediate Fleet (17 boats, 6 races, 1 discard)
--
-- Total results: 260. Total race scores: 1,470.
-- PDF corroboration unavailable: verified against official digital HTML results portals (SailingResults.net & Sailwave).
-- Atomic transaction with idempotent guards.

BEGIN;

-- 1. Regatta Events
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    'da92ae7c-9010-408a-b306-e70d89cbdd19',
    '2026 Musto Australian Optimist Championship',
    '2026-musto-australian-optimist-championship',
    '2026-01-08',
    '2026-01-15',
    'Royal Yacht Club of Tasmania, Sandy Bay, Hobart, Tasmania, Australia',
    'Australian International Optimist Dinghy Association and Royal Yacht Club of Tasmania',
    '["Optimist"]'::jsonb,
    false,
    false,
    'National youth championship held 8–15 January 2026 on the River Derwent, Hobart.',
    'Low Point System with 1 discard after 5 races.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    '700a433b-3e0d-5e76-8188-b06e17f52fcc',
    '2026 Tasmanian Optimist State Championship',
    '2026-tasmanian-optimist-state-championship',
    '2026-02-28',
    '2026-03-01',
    'Royal Yacht Club of Tasmania, Hobart, TAS, Australia',
    'Tasmanian International Optimist Dinghy Association (TIODA) / RYCT',
    '["Optimist"]'::jsonb,
    false,
    false,
    'State championship regatta conducted 28 February – 1 March 2026 on the River Derwent.',
    'Low Point System with 1 discard after 5 races.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    '6e99289f-9201-59ad-8da5-e50ef0f7056d',
    '2026 VIODA International Optimist Victorian & Open Championship',
    '2026-vioda-victorian-open-championship',
    '2026-03-07',
    '2026-03-09',
    'Royal Brighton Yacht Club, Melbourne, VIC, Australia',
    'Victorian International Optimist Dinghy Association (VIODA) / RBYC',
    '["Optimist"]'::jsonb,
    false,
    false,
    'Annual Victorian state championship held 7–9 March 2026 at Royal Brighton Yacht Club, Port Phillip.',
    'Low Point System with 1 discard after 5 races.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    '2f4ef4c3-e42c-52cd-be6a-c64dbb5cb5b2',
    '2026 NSW Optimist State Championship',
    '2026-nsw-optimist-state-championship',
    '2026-03-21',
    '2026-03-22',
    'Royal Prince Alfred Yacht Club, Pittwater, NSW, Australia',
    'NSW International Optimist Dinghy Association (NSWIODA) / RPAYC',
    '["Optimist"]'::jsonb,
    false,
    false,
    'NSW state championship conducted 21–22 March 2026 at RPAYC, Pittwater.',
    'Low Point System with no discards.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    '75b647f0-1339-5bf4-9d42-9ba9a5257cb7',
    '2026 ACT Optimist Championship',
    '2026-act-optimist-championship',
    '2026-10-24',
    '2026-10-25',
    'Canberra Yacht Club, Lake Burley Griffin, ACT, Australia',
    'Canberra Yacht Club (CYC) / NSWIODA',
    '["Optimist"]'::jsonb,
    false,
    false,
    'ACT territory championship held 24–25 October 2026 at Canberra Yacht Club, Lake Burley Griffin.',
    'Low Point System with 1 discard after 5 races.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;

-- 2. Regatta Class Sheets
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861',
    'da92ae7c-9010-408a-b306-e70d89cbdd19',
    '2026 Musto Australian Optimist Championship — Intermediate Fleet',
    '2026-musto-australian-optimist-championship-intermediate',
    '2026-01-08',
    '2026-01-15',
    42,
    'Intermediate',
    9,
    'AUS',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Royal Yacht Club of Tasmania, Sandy Bay, Hobart, Tasmania, Australia',
    'Australian International Optimist Dinghy Association and Royal Yacht Club of Tasmania',
    'published',
    'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2',
    '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results',
    'Official results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results.',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '5f48a6df-cfee-5082-9df4-ec59ea97559d',
    '700a433b-3e0d-5e76-8188-b06e17f52fcc',
    '2026 Tasmanian Optimist State Championship — Open Fleet',
    '2026-tasmanian-optimist-state-championship-open',
    '2026-02-28',
    '2026-03-01',
    6,
    'Open',
    6,
    'AUS',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Royal Yacht Club of Tasmania, Hobart, TAS, Australia',
    'Tasmanian International Optimist Dinghy Association (TIODA) / RYCT',
    'published',
    'https://sailingresults.net/sa/results/overall.aspx?ID=82313',
    '2026 Tasmanian Optimist State Championship Official Results',
    'Official results from 2026 Tasmanian Optimist State Championship Official Results.',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '7cafc90f-d7b9-528e-bab7-62f8769fb7f5',
    '700a433b-3e0d-5e76-8188-b06e17f52fcc',
    '2026 Tasmanian Optimist State Championship — Intermediate Fleet',
    '2026-tasmanian-optimist-state-championship-intermediate',
    '2026-02-28',
    '2026-03-01',
    6,
    'Intermediate',
    6,
    'AUS',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Royal Yacht Club of Tasmania, Hobart, TAS, Australia',
    'Tasmanian International Optimist Dinghy Association (TIODA) / RYCT',
    'published',
    'https://sailingresults.net/sa/results/overall.aspx?ID=82313',
    '2026 Tasmanian Optimist State Championship Official Results',
    'Official results from 2026 Tasmanian Optimist State Championship Official Results.',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '688ab6bd-0de5-5250-a6f4-c4b4f459af43',
    '6e99289f-9201-59ad-8da5-e50ef0f7056d',
    '2026 VIODA International Optimist Victorian & Open Championship — Open Fleet',
    '2026-vioda-victorian-open-championship-open',
    '2026-03-07',
    '2026-03-09',
    38,
    'Open',
    8,
    'AUS',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Royal Brighton Yacht Club, Melbourne, VIC, Australia',
    'Victorian International Optimist Dinghy Association (VIODA) / RBYC',
    'published',
    'https://sailingresults.net/sa/results/overall.aspx?ID=82126',
    'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results',
    'Official results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results.',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe',
    '6e99289f-9201-59ad-8da5-e50ef0f7056d',
    '2026 VIODA International Optimist Victorian & Open Championship — Intermediate Fleet',
    '2026-vioda-victorian-open-championship-intermediate',
    '2026-03-07',
    '2026-03-09',
    27,
    'Intermediate',
    7,
    'AUS',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Royal Brighton Yacht Club, Melbourne, VIC, Australia',
    'Victorian International Optimist Dinghy Association (VIODA) / RBYC',
    'published',
    'https://sailingresults.net/sa/results/overall.aspx?ID=82126',
    'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results',
    'Official results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results.',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '119ca9a1-4094-533e-9fed-8beff972332c',
    '2f4ef4c3-e42c-52cd-be6a-c64dbb5cb5b2',
    '2026 NSW Optimist State Championship — Open Fleet',
    '2026-nsw-optimist-state-championship-open',
    '2026-03-21',
    '2026-03-22',
    42,
    'Open',
    3,
    'AUS',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Royal Prince Alfred Yacht Club, Pittwater, NSW, Australia',
    'NSW International Optimist Dinghy Association (NSWIODA) / RPAYC',
    'published',
    'https://www.sailwave.com/results/states26.htm',
    'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club',
    'Official results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club.',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    'cae865eb-9b5a-5988-aeb3-4443130a307d',
    '2f4ef4c3-e42c-52cd-be6a-c64dbb5cb5b2',
    '2026 NSW Optimist State Championship — Intermediate Fleet',
    '2026-nsw-optimist-state-championship-intermediate',
    '2026-03-21',
    '2026-03-22',
    55,
    'Intermediate',
    2,
    'AUS',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Royal Prince Alfred Yacht Club, Pittwater, NSW, Australia',
    'NSW International Optimist Dinghy Association (NSWIODA) / RPAYC',
    'published',
    'https://www.sailwave.com/results/states26.htm',
    'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club',
    'Official results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club.',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba',
    '75b647f0-1339-5bf4-9d42-9ba9a5257cb7',
    '2026 ACT Optimist Championship — Open Fleet',
    '2026-act-optimist-championship-open',
    '2026-10-24',
    '2026-10-25',
    27,
    'Open',
    7,
    'AUS',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Canberra Yacht Club, Lake Burley Griffin, ACT, Australia',
    'Canberra Yacht Club (CYC) / NSWIODA',
    'published',
    'https://austeamsailing.com/events/ACT26.htm',
    'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club',
    'Official results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club.',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '436486db-ddee-5821-b217-946127fb5506',
    '75b647f0-1339-5bf4-9d42-9ba9a5257cb7',
    '2026 ACT Optimist Championship — Intermediate Fleet',
    '2026-act-optimist-championship-intermediate',
    '2026-10-24',
    '2026-10-25',
    17,
    'Intermediate',
    6,
    'AUS',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Canberra Yacht Club, Lake Burley Griffin, ACT, Australia',
    'Canberra Yacht Club (CYC) / NSWIODA',
    'published',
    'https://austeamsailing.com/events/ACT26.htm',
    'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club',
    'Official results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club.',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);

-- 3. Sailor Profiles (198 profiles guaranteed)
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f8f1b2c8-c396-501f-a6dd-f51b6aa782d9', 'Toby Phillips', 'toby-phillips-worlds26-f8f1b2', 'AUS 1906', 'AUS', 'M', 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c34abc0a-3cf5-510b-be46-a2f4f07d6e23', 'Walter Heeley', 'walter-heeley-worlds26-c34abc', 'AUS 1575', 'AUS', 'M', 'Imported official result') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3079ace8-c905-42fb-b258-bbb7d13b299c', 'Harry Creak', 'harry-creak-anz26-3079ac', '1383', 'AUS', 'M', 'IHYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('8ffb1e6b-203c-4bab-ac2f-18de1db064b7', 'Heidi Sinclair-Hill', 'heidi-sinclair-hill-anz26-8ffb1e', '1364', 'SGP', 'F', 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1bbc2828-04a0-43b5-87eb-ef4f1e92514b', 'Yasin Yusuf Yusfianshah', 'yasin-yusuf-yusfianshah', '3575', 'SGP', 'M', 'SAF Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('747fa344-5126-4ba1-a876-470a982620c7', 'Shin Lin Chen Rui', 'shin-lin-chen-rui', '3333', 'SGP', 'M', 'SAF Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7411c058-0e0a-5a5d-aa05-fb3bd9edc4aa', 'Mac Darlington', 'mac-darlington-hkoda26-7411c0', 'AUS 1879', 'AUS', 'Unknown', 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('35f3c2cb-2ced-494d-aa27-c5f0cf3193dd', 'Erik Rydin', 'erik-rydin-anz26-35f3c2', '506', 'AUS', 'M', 'SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('30880421-1dc4-4a14-9c6b-8c00de39e4d8', 'Tom Griffiths', 'tom-griffiths-fd96wyi', '1744', 'AUS', 'M', 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b64cc6ae-a6e8-47a4-b702-b067d02e1f19', 'Jayden Wang', 'jayden-wang-anz26-b64cc6', '1748', 'AUS', 'M', 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ca6aadd0-01cf-45c2-b95d-5b2b182e3a81', 'Oliver Johnson', 'oliver-johnson-anz26-ca6aad', '1854', 'AUS', 'M', 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a08688e8-35e4-4ca6-9574-bd909c551806', 'Stirling Marshall', 'stirling-marshall-anz26-a08688', '1844', 'AUS', 'M', 'AWSC and SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d710b7c6-5d97-462d-8a9b-ae37b0379f46', 'Tate Cantwell', 'tate-cantwell-anz26-d710b7', '1860', 'AUS', 'M', 'SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1b22f933-9817-4f8b-a366-11315c5bc283', 'Lucy Lin', 'lucy-lin-anz26-1b22f9', '1938', 'SGP', 'F', 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0ea521ac-cf94-4f05-bd88-32e0d04c1579', 'Fred Cantwell', 'fred-cantwell-anz26-0ea521', '1859', 'AUS', 'M', 'SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('fe55751a-320e-48f8-92fd-fd40bca74292', 'Reid Martin', 'reid-martin-anz26-fe5575', '1728', 'AUS', 'M', 'PDSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('104a8fa8-d159-48c4-b4a2-d70dd7eec5d1', 'Angus Johnston', 'angus-johnston-anz26-104a8f', '1670', 'AUS', 'M', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b3d70d42-34b5-4324-8af8-6a829e581ceb', 'Damien Seah', 'damien-seah', '3825', 'SGP', 'M', 'SAF Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0f1eb283-e53c-533e-8113-55753e658647', 'Emma Tomkins', 'emma-tomkins-asians25', 'AUS 1781', 'AUS', 'F', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9ee1f9f1-aa37-4a62-8f85-67ab090c6d64', 'Axel Ryves', 'axel-ryves-anz26-9ee1f9', '1633', 'AUS', 'M', 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('15b30f88-d7b3-45f1-b9c2-a59c9972101b', 'Orlando Watts', 'orlando-watts-anz26-15b30f', '1745', 'AUS', 'M', 'RSYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('cdd61132-5975-4264-8804-cf78cd45258e', 'Meii You', 'meii-you-anz26-cdd611', '1549', 'SGP', 'F', 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('51a80a27-8665-4db2-afb4-0940cbc20376', 'Milton Li', 'milton-li-anz26-51a80a', '1559', 'AUS', 'M', 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0b2ef30b-3fd7-5beb-8137-07340ecf5ea3', 'Zachary Tait', 'zachary-tait-asians25', 'AUS 1743', 'AUS', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1bc09832-78c8-4648-bcd8-3e2f835d617f', 'Jae Guan Yu Toh', 'jae-guan-yu-toh', '3311', 'SGP', 'M', 'SAF Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a1bac017-5467-45ce-9ddc-53c13bcf2852', 'Lyla Greenwood', 'lyla-greenwood-anz26-a1bac0', '1909', 'AUS', 'F', 'RQYS SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c20196f2-9a66-49ca-a9a9-8324f8b20ee6', 'Alexander Walker', 'alexander-walker-anz26-c20196', '1685', 'AUS', 'M', 'RQYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3e8649b1-935e-436e-b72a-510dba915078', 'Harriet Behrens', 'harriet-behrens-anz26-3e8649', '1937', 'AUS', 'F', 'RQYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('cf486686-53b0-4c99-8231-1619dbbcb0f6', 'Cameron Underwood', 'cameron-underwood-fb5judp', '1001', 'AUS', 'M', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('16b59fff-e224-4eb6-b839-ea5ff1482211', 'Theo Altson', 'theo-altson-anz26-16b59f', '1801', 'AUS', 'M', 'SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('afb1dbf7-00c9-4033-94d3-5259920e3d94', 'Jessica Higgins', 'jessica-higgins-anz26-afb1db', '1885', 'AUS', 'F', 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2ce7f341-53ee-4434-a35f-106f45110f47', 'Thomas Pitt', 'thomas-pitt-anz26-2ce7f3', '1827', 'AUS', 'M', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('325b400d-1092-4711-b769-29b16989ea35', 'Aurelia Wilson', 'aurelia-wilson-anz26-325b40', '1941', 'AUS', 'F', 'RSYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('73a082e4-e3f8-48d7-a5fd-ef0f587867ea', 'William Rogers', 'william-rogers-anz26-73a082', '1847', 'SGP', 'M', 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6e620e7e-5678-525f-8760-caaacf2266a9', 'Emerald Jacobsen', 'emerald-jacobsen-asians25', 'AUS 1846', 'AUS', 'F', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('8f29ffb3-a556-46c9-82c5-4b20f6d75356', 'Xavier James', 'xavier-james-anz26-8f29ff', '999', 'AUS', 'M', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2e005437-68a4-51ab-bc8b-d377f51d55eb', 'Balthazar Roche', 'balthazar-roche-asians25', 'AUS 1931', 'AUS', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f5f68b83-bb5b-4523-963f-3f367d5b4771', 'Yufu Wang', 'yufu-wang-anz26-f5f68b', '1930', 'AUS', 'M', 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f26ce470-48a0-419e-967e-b1e936dad712', 'Lavinia Liu', 'lavinia-liu-anz26-f26ce4', '1866', 'AUS', 'F', 'ROAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b2f3bfeb-f969-518e-b631-70da18fadc0d', 'William Harris', 'william-harris-asians25', 'AUS 1932', 'AUS', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('54b6d292-7c1e-4da4-990b-802e674c06e5', 'James Edwards', 'james-edwards-anz26-54b6d2', '1568', 'AUS', 'M', 'MYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('65989797-50da-4aef-88b6-47ff0e2df976', 'Acklin Stent', 'acklin-stent-anz26-659897', '1907', 'AUS', 'M', 'MMYC/MYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e2a4b0c4-c2cc-4a03-b198-6378b590fc0b', 'Sebastian Cheng', 'sebastian-cheng-asianopti-aus', 'AUS 1491', 'AUS', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('5a61d861-917e-55b9-85db-9c122fcc9183', 'Luca De Giosa', 'luca-de-giosa-euro26-5a61d8', 'AUS 1920', 'AUS', 'M', 'Imported official result') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9f1d45de-707d-5b7e-a92c-e88596d5233d', 'Sijia Deng', 'sijia-deng-asians25', 'AUS 1720', 'AUS', 'F', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9e8f469d-4386-46dc-8533-5babc753dd05', 'Jack Mcguire', 'jack-mcguire-anz26-9e8f46', '1936', 'AUS', 'M', 'RQYS/SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('298175a4-db74-4a70-a55c-fdd65f4d3004', 'Hamilton Zhao', 'hamilton-zhao-anz26-298175', '1640', 'SGP', 'M', 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e461cef9-b775-4d3d-9836-2c78f7b8815c', 'Edward Brown', 'edward-brown-anz26-e461ce', '777', 'AUS', 'M', 'MYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7b929e9d-7925-4705-94ab-d175a82bb610', 'Kalle Gravare', 'kalle-gravare-anz26-7b929e', '1929', 'SGP', 'M', 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('8a0f7357-41e8-4de1-bf45-1353aaa660b0', 'Myles Phillips', 'myles-phillips-anz26-8a0f73', '1523', 'AUS', 'M', 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a8621760-ffb6-4283-8e2e-12bb7890d8a4', 'Seb Tucker', 'seb-tucker-09584cg', '0', 'SGP', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('434b1159-f466-49dc-b20c-aef801b6350a', 'Dan Toh Guan You', 'dan-toh-guan-you', '3811', 'SGP', 'M', 'SAF Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6732309a-18bb-5161-b260-d1e99b94e4dc', 'Huon Jones', 'opti-aus-huon-jones-949', '949', 'AUS', 'M', 'MSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('59816f93-32b5-5b51-b7c5-f5f17533aeaa', 'Fabio Moeller', 'opti-aus-fabio-moeller-1799', '1799', 'AUS', 'M', 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a60316a7-9870-5c31-861e-b5c4c5f02bbf', 'Isabel Yu', 'opti-aus-isabel-yu-1546', '1546', 'AUS', 'F', 'RSYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('31374565-e925-521a-a074-93c0d364cbc2', 'Zac Boyd', 'opti-aus-zac-boyd-1753', '1753', 'AUS', 'M', 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b8e6f44d-407f-5a09-8ce1-761d67253264', 'Humphrey Hager', 'opti-aus-humphrey-hager-529', '529', 'AUS', 'M', 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e912046c-3e11-5658-a475-acc04b70cb9a', 'Jack Sturm', 'opti-aus-jack-sturm-1389', '1389', 'AUS', 'M', 'RQYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1f83d34f-3841-534a-b7ff-6f06e614de9a', 'Jonathan Molloy', 'opti-aus-jonathan-molloy-1599', '1599', 'AUS', 'M', 'TYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('49e3b629-7287-5783-a7d3-d00366db458b', 'Ollie Harry', 'opti-aus-ollie-harry-1518', '1518', 'AUS', 'M', 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7f3d0b20-1951-5923-a815-94ec83024ae8', 'Lachlan King', 'opti-aus-lachlan-king-409', '409', 'AUS', 'M', 'RQYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('71010fdd-6c88-5e28-b9aa-5a1648dbe7b5', 'Anne Edwards', 'opti-aus-anne-edwards-1269', '1269', 'AUS', 'F', 'MYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d78e9d11-5477-5432-848b-af309c61ec2e', 'William Corkhill', 'opti-aus-william-corkhill-826', '826', 'AUS', 'M', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('53ca59e1-b29b-5fed-acfc-b65407a76960', 'Bono Svacek', 'opti-aus-bono-svacek-1855', '1855', 'AUS', 'M', 'RSYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6bb53a1d-beec-5217-a6bb-996c0f92b13f', 'William James', 'opti-aus-william-james-1517', '1517', 'AUS', 'M', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('41c571c0-0ca0-5403-b3e5-51b515ae9c38', 'Naomi Von Bubra', 'opti-aus-naomi-von-bubra-1709', '1709', 'AUS', 'F', 'RQYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('83fa263e-034d-55f8-aaaa-452f7b43fa85', 'Jozee Fowler', 'opti-aus-jozee-fowler-982', '982', 'AUS', 'F', 'SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f9a37376-1672-5dfb-98a2-a7e5006893d1', 'Charlie Mclaren', 'opti-aus-charlie-mclaren-1398', '1398', 'AUS', 'M', 'SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('22198eeb-11f7-5b24-9e11-30cbdee01fb1', 'Noah Tate', 'opti-aus-noah-tate-640', '640', 'AUS', 'M', 'RQYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c06e2055-9901-5c52-9279-24d59b25d2a4', 'Rory Martin', 'opti-aus-rory-martin-877', '877', 'AUS', 'M', 'PDSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9a41bcbd-ac5d-56f9-9c76-709aa5f78d69', 'Grace Newitt', 'opti-aus-grace-newitt-1865', '1865', 'AUS', 'F', 'RBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('48a1a52b-6bd7-5c30-8d2c-39eb3af7b314', 'Alex Baxter', 'opti-aus-alex-baxter-1767', '1767', 'AUS', 'M', 'RSYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('70391ae7-d567-55b9-b91c-3f80e65e3f84', 'Max Hughes', 'opti-aus-max-hughes-1734', '1734', 'AUS', 'M', 'RSYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6e96039b-08eb-545b-bd0d-84d0ca46eca9', 'Lucas Kattera', 'opti-aus-lucas-kattera-3652', '3652', 'AUS', 'M', 'Glendowie BC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('79de686e-027d-5809-99e8-453bfd3cf285', 'Miles White', 'opti-aus-miles-white-1432', '1432', 'AUS', 'M', 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f4e7e0f5-e123-5a27-900b-ec3a7b908d91', 'Michelle Crisp', 'opti-aus-michelle-crisp-674', '674', 'AUS', 'F', 'MSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('eee6d9a8-20bc-5f54-a5c5-c9ba6b51e502', 'James Paterson', 'opti-aus-james-paterson-1305', '1305', 'AUS', 'M', 'RQYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('60dd4d51-c920-5e84-b1e4-b662df586d2f', 'Caitlin Grant', 'opti-aus-caitlin-grant-327', '327', 'AUS', 'F', 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('fa8a0991-c6cb-529b-a5c2-26766e09b4b2', 'Lucy Norris', 'opti-aus-lucy-norris-1779', '1779', 'AUS', 'F', 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b70a3181-1954-5c93-966e-4407dbf63a36', 'Bobby Williams', 'opti-aus-bobby-williams-1926', '1926', 'AUS', 'M', 'IHYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b259b4fe-9ae6-521b-960b-34da1fe8a554', 'Jasmine Wang', 'opti-aus-jasmine-wang-1668', '1668', 'AUS', 'F', 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('5f837edc-6728-50d4-901d-6a8ea81dc026', 'Alice Cameron', 'opti-aus-alice-cameron-325', '325', 'AUS', 'F', 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b4522674-e289-551e-bdc3-136bf47f62c6', 'Henry Campbell', 'opti-aus-henry-campbell-1933', '1933', 'AUS', 'M', 'SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('579d0ed0-0d0b-5e5e-8ee8-a610dc49defa', 'Mila Tait', 'opti-aus-mila-tait-1701', '1701', 'AUS', 'F', 'RPAYC TASC NSC B16s') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b4803202-b601-5933-b9d5-c230caab796d', 'William Linscott', 'opti-aus-william-linscott-1408', '1408', 'AUS', 'M', 'SBSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d8ff4e35-8040-5c54-8d3c-f943992b3ed5', 'Francis Watts', 'opti-aus-francis-watts-1766', '1766', 'AUS', 'M', 'RSYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3a276e16-704b-5e50-a6ff-99e916ca2757', 'Anna Malpas', 'opti-aus-anna-malpas-535', '535', 'AUS', 'F', 'CYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('610c6290-0b02-560f-b492-236793c8714b', 'Hugo Liebeknecht', 'opti-aus-hugo-liebeknecht-992', '992', 'AUS', 'M', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d74ce041-92cb-578f-85a9-b1e22cb02f85', 'Felix Bradley', 'opti-aus-felix-bradley-1621', '1621', 'AUS', 'M', 'MSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1eae3001-9d62-5cdc-98f1-5acbaa97e369', 'Nathan Mao', 'opti-aus-nathan-mao-485', '485', 'AUS', 'M', 'MYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ffee66ca-ee78-504e-9fac-f2c556c77843', 'Sam Harris', 'opti-aus-sam-harris-1914', '1914', 'AUS', 'M', 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('13035f58-82f2-5cdc-897b-78260ba8a376', 'Bodhi Mckenzie', 'opti-aus-bodhi-mckenzie-963', '963', 'AUS', 'M', 'RGYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('5e989cd1-b734-5443-9d3e-ea9794a9686f', 'Lauchlan Naylor', 'opti-aus-lauchlan-naylor-1488', '1488', 'AUS', 'M', 'RFBYC/FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7f6a70db-bca7-5a07-8a00-b233c8acd2c9', 'Maisie Borg', 'opti-aus-maisie-borg-1590', '1590', 'AUS', 'F', 'RSYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('53113747-4b64-5bb9-8aca-f3a415600d66', 'Lottie Bown', 'opti-aus-lottie-bown-1090', '1090', 'AUS', NULL, 'SBSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('685e8339-e2cf-50f4-bd0a-acd4a3a0f9d5', 'Olive Alden', 'opti-aus-olive-alden-824', '824', 'AUS', NULL, 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('8b8d96f4-d1cc-5cff-a6dd-934378c3051b', 'Leonardo Demangone', 'opti-aus-leonardo-demangone-1299', '1299', 'AUS', NULL, 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('91b00521-c967-5967-a5d6-28f47904e434', 'Charlie Ryan', 'opti-aus-charlie-ryan-993', '993', 'AUS', NULL, 'SBSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d2137b68-2b58-5606-a57e-0e588d879c99', 'Luke Bennett', 'opti-aus-luke-bennett-1008', '1008', 'AUS', NULL, 'SBSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ed712766-f71b-5572-b169-7a88209f6507', 'Sam Smith', 'opti-aus-sam-smith-1870', '1870', 'AUS', 'M', 'SYC/ RBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8', 'Oliver Morris', 'opti-aus-oliver-morris-1822', '1822', 'AUS', 'M', 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('471b461c-5c75-57ae-b96d-5ecf09e15791', 'William Rose', 'opti-aus-william-rose-1447', '1447', 'AUS', 'M', 'MSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f', 'Joy Cheuk Yee Shen', 'opti-aus-joy-cheuk-yee-shen-921', '921', 'AUS', 'F', 'SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7ab25378-ed5a-5311-9841-0bf0891850ed', 'Tyler Deeth', 'opti-aus-tyler-deeth-859', '859', 'AUS', 'M', 'SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('dc9037eb-9773-5609-b677-013904a333c6', 'Ollie Walstab', 'opti-aus-ollie-walstab-1850', '1850', 'AUS', 'M', 'SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a20a9c8a-a4a9-5523-a08f-46e75fab4812', 'Bibi Stigter', 'opti-aus-bibi-stigter-1012', '1012', 'AUS', 'F', 'SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('888d0e66-7810-52a3-859d-e4bcaf6b9b38', 'Louis Davis', 'opti-aus-louis-davis-732', '732', 'AUS', 'M', 'RGYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3895ee0b-423d-54b2-ab8b-ed51a60f50a6', 'Aubrey Tan', 'opti-aus-aubrey-tan-1111', '1111', 'AUS', 'F', 'SYC/SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('8c844476-f530-577e-be42-e594122444d8', 'Finley Insermini', 'opti-aus-finley-insermini-1177', '1177', 'AUS', 'M', 'RBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3c97fe63-4ee9-5cbc-b588-9bad9f7b7fe1', 'Sebastian Moore', 'opti-aus-sebastian-moore-1082', '1082', 'AUS', 'M', 'SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1f3a483a-b110-567c-964e-f32063ec07c4', 'Edward Jukes', 'opti-aus-edward-jukes-1681', '1681', 'AUS', 'M', 'RBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('67957772-3fab-5f24-8fda-ea58259388aa', 'Ace Hill', 'opti-aus-ace-hill-1275', '1275', 'AUS', 'M', 'SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d4a93122-cac6-514d-a1c3-46a63c7aa978', 'Irida Bladon', 'opti-aus-irida-bladon-1222', '1222', 'AUS', 'F', 'SYC/RBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c68003c8-28d5-5806-8906-486b00a9c40b', 'Hugo Jarry', 'opti-aus-hugo-jarry-1223', '1223', 'AUS', 'M', 'RBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ea5e20c7-4333-5864-9a24-89612a85aba2', 'Hunter Bryant', 'opti-aus-hunter-bryant-1221', '1221', 'AUS', 'M', 'RBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('cd626087-622a-59d5-bc80-b1ae80513b4c', 'Oscar Kirby', 'opti-aus-oscar-kirby-1758', '1758', 'AUS', 'M', 'SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('948f00d5-2133-5e3f-9704-19d73a626e57', 'Patrick Moore', 'opti-aus-patrick-moore-1392', '1392', 'AUS', 'M', 'SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('cdffbdbb-edfd-5404-b65a-24ba2a5ad8da', 'Clovis Goussard', 'opti-aus-clovis-goussard-801', '801', 'AUS', 'M', 'RBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b90b6b1b-f763-5766-8a20-667dd663981b', 'Raphael Chandler', 'opti-aus-raphael-chandler-816', '816', 'AUS', 'M', 'RBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('dfc3cb43-1647-5675-98bb-8274a25d5190', 'Kengo Matsubara', 'opti-aus-kengo-matsubara-1509', '1509', 'AUS', 'M', 'ASC/RBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c23f1b7e-2073-524e-8a20-89af3fd18bf9', 'Tilly Gibson', 'opti-aus-tilly-gibson-1665', '1665', 'AUS', 'F', 'SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d164508c-c587-5c7f-9694-9b480ad61226', 'Thea Rydin', 'opti-aus-thea-rydin-218', '218', 'AUS', 'F', 'SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2a58ae97-d3c7-5d07-9ee8-e0c0f6c0970f', 'Sebastian Chandler', 'opti-aus-sebastian-chandler-851', '851', 'AUS', 'M', 'RBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c381b0a9-d3cd-59a2-b778-09f0146841be', 'Alexander Sorokin', 'opti-aus-alexander-sorokin-1430', '1430', 'AUS', 'M', 'SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('75e197ac-42f1-5371-9a4d-5f3649d820f0', 'Elliana Antoniou', 'opti-aus-elliana-antoniou-1370', '1370', 'AUS', 'F', 'SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('50147561-8c21-58b5-881e-9b3f4e157aa8', 'Indigo Feore', 'opti-aus-indigo-feore-1880', '1880', 'AUS', 'F', 'SYC/CYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f29883fd-c6d4-50eb-9b23-f4ef96c856c1', 'Marcus Hoang', 'opti-aus-marcus-hoang-1751', '1751', 'AUS', 'M', 'RBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e678ba0b-47a1-5a68-8bb0-717c041ee2b3', 'Oliver Kayakesen', 'opti-aus-oliver-kayakesen-1184', '1184', 'AUS', 'M', 'SSCBC/RBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('71d2372b-2c3e-54e1-a17a-630c7c3d1794', 'Madeleine Moore', 'opti-aus-madeleine-moore-1690', '1690', 'AUS', 'F', 'SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('550ec697-8d1d-5311-8bbd-9d9a3c981307', 'Florence Gartrell', 'opti-aus-florence-gartrell-582', '582', 'AUS', 'F', 'MYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f1b5322e-f4dc-5143-b5ba-d8b0123d334d', 'Eva Kirby', 'opti-aus-eva-kirby-1867', '1867', 'AUS', 'F', 'SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('bf9c93be-ecbb-54a2-9ad7-deb806289712', 'Lilli Doherty', 'opti-aus-lilli-doherty-1197', '1197', 'AUS', 'F', 'MYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f59d5ecb-926a-566c-a7c1-cfdca1cde8c2', 'Bobby Furneaux Williams', 'opti-aus-bobby-furneaux-williams-1926', '1926', 'AUS', 'M', 'IHYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('fc8d7069-1d5c-5065-982f-5b7c0d711185', 'Alex Mirceski', 'opti-aus-alex-mirceski-1791', '1791', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('045b2495-820a-5df1-b744-8439ea2e3d13', 'Edward Payne', 'opti-aus-edward-payne-1627', '1627', 'AUS', NULL, 'Hhsc') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e959c8e7-7d71-52bc-82d8-94e76a615407', 'Felix Sawers', 'opti-aus-felix-sawers-1724', '1724', 'AUS', NULL, 'PDSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('64e6b01c-0fc6-5fa5-87ee-52226925ff5c', 'Ariel Ashmore', 'opti-aus-ariel-ashmore-1721', '1721', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2625b7b9-c7eb-59ca-9d5a-d17f47546759', 'Jamie Lee Mason', 'opti-aus-jamie-lee-mason-1449', '1449', 'AUS', NULL, 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('09e13481-654a-59c6-a7d5-dc9bb6f79c25', 'Tessa Bonjean', 'opti-aus-tessa-bonjean-1543', '1543', 'AUS', NULL, 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('365765e9-9ea4-5de4-8228-00156c596e49', 'Oliver Korn', 'opti-aus-oliver-korn-709', '709', 'AUS', NULL, 'GRSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('8d01c0ff-f163-55fe-b538-2d5ece68fa04', 'Norah Bonjean', 'opti-aus-norah-bonjean-1532', '1532', 'AUS', NULL, 'Wsc') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ace9e6c1-bdd4-58f0-8159-a753458dfcb8', 'Markus Liu', 'opti-aus-markus-liu-1849', '1849', 'AUS', NULL, 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d6485671-0de9-5522-b3de-262e2cc27a13', 'Courtney Harrison', 'opti-aus-courtney-harrison-1735', '1735', 'AUS', NULL, 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c720156e-a4fc-5c44-8505-4ad78bb60d73', 'Willow Murray', 'opti-aus-willow-murray-1863', '1863', 'AUS', NULL, 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ae10ce7d-d964-568b-98ee-3b1f370dc97a', 'Jamie Korn', 'opti-aus-jamie-korn-1666', '1666', 'AUS', NULL, 'GRSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7e5da4f4-8418-5055-b693-11f5551817a5', 'Omar Mansour', 'opti-aus-omar-mansour-1839', '1839', 'AUS', NULL, 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2c632e1d-c35a-55b3-b30e-fdc04d8824b1', 'Maximilian Hultin', 'opti-aus-maximilian-hultin-1802', '1802', 'AUS', NULL, 'MHYC / NSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('cc7c3804-c292-5e08-808b-bcebb191b42a', 'Oliver Sun', 'opti-aus-oliver-sun-1606', '1606', 'AUS', NULL, 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6bb33423-d331-5bde-9731-2e09ea2eba83', 'Tom Kefford', 'opti-aus-tom-kefford-1405', '1405', 'AUS', NULL, 'CYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ff8ca5b1-553b-528c-b602-0d79507b82a2', 'William Liu', 'opti-aus-william-liu-1404', '1404', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6809147a-acdc-5a68-9d3a-a6ff1f4ecd6e', 'Ellery Chai', 'opti-aus-ellery-chai-1078', '1078', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('5e063632-d6af-5098-9e61-1fbb17c76588', 'Jasper Chai', 'opti-aus-jasper-chai-1348', '1348', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9c72b83f-429a-5d68-a220-7f2652aa5f42', 'Barrett Fitzmaurice', 'opti-aus-barrett-fitzmaurice-1293', '1293', 'AUS', NULL, 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('4c291012-2b60-5f2e-b850-b9e90f0c010c', 'Owen OHara', 'opti-aus-owen-ohara-1248', '1248', 'AUS', NULL, 'NSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f26e7a93-7b3f-5b8a-81ab-c5d767424cb8', 'Brayden Huang', 'opti-aus-brayden-huang-679', '679', 'AUS', NULL, 'NSC/MHYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2552c01d-6467-5dbf-b858-c798384746a4', 'William Lawson', 'opti-aus-william-lawson-1139', '1139', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2db88fe8-74ab-5338-9c7e-5d9977754fed', 'James Moorhead', 'opti-aus-james-moorhead-1812', '1812', 'AUS', NULL, 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('bab03bca-e72f-5b38-8901-d0aa700a480b', 'Alexander Quinn', 'opti-aus-alexander-quinn-1403', '1403', 'AUS', NULL, 'CYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6f46f86a-da84-5289-b718-711637e49fc5', 'Fletcher Royan', 'opti-aus-fletcher-royan-1401', '1401', 'AUS', NULL, 'NSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('97f0b854-923f-5124-9cfa-8360389bc308', 'Ebba Nixey', 'opti-aus-ebba-nixey-1786', '1786', 'AUS', NULL, 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b617fb8a-78ab-58d0-bf6e-6150e954658b', 'Alasdair Bonnitcha', 'opti-aus-alasdair-bonnitcha-1332', '1332', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6b68a537-97d3-5bad-8a4c-e2016f5cc8d2', 'Henry Salmon', 'opti-aus-henry-salmon-1003', '1003', 'AUS', NULL, 'GRSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3ed039ea-653f-5479-ac6b-79c3511aa962', 'Thomas Johnson', 'opti-aus-thomas-johnson-948', '948', 'AUS', NULL, 'RSYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('15b5c0ed-ac08-584c-874e-b7d9271dd53a', 'Sienna Murray', 'opti-aus-sienna-murray-1507', '1507', 'AUS', NULL, 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('be6e8fd1-74cd-5d69-ba96-c0dff384b40a', 'Kai Houtzager', 'opti-aus-kai-houtzager-1325', '1325', 'AUS', NULL, 'GRSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9b4f7a85-aa7d-5d77-9cd7-afb06469bc69', 'Sylvia Carlson', 'opti-aus-sylvia-carlson-1236', '1236', 'AUS', NULL, 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('381285e5-8415-5fde-8418-373f492b9eca', 'Sam Hardy', 'opti-aus-sam-hardy-1481', '1481', 'AUS', NULL, 'TASC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('98067f40-3792-57bb-9716-fc7bca16d664', 'Molly O''Donnell', 'opti-aus-molly-o-donnell-48', '48', 'AUS', NULL, 'Ascham') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9a2529e7-7c75-52b3-8525-95da0a667384', 'Joshua Greenhill', 'opti-aus-joshua-greenhill-11', '11', 'AUS', NULL, 'GRSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('dd86222a-4380-55f0-b7c9-f727b6f32f65', 'Maelyn Gilchrist', 'opti-aus-maelyn-gilchrist-1624', '1624', 'AUS', NULL, 'Ascham') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7e3ae5ad-6c88-5837-b715-9c615305d604', 'Dante Iacono', 'opti-aus-dante-iacono-1828', '1828', 'AUS', NULL, 'Cranbrook') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('23b717b1-7d59-5014-b1ae-3358bf3e8445', 'Laura OHara', 'opti-aus-laura-ohara-1214', '1214', 'AUS', NULL, 'NSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('07397f15-5cbb-54bf-b882-5c77502823a8', 'Max Howard', 'opti-aus-max-howard-1831', '1831', 'AUS', NULL, 'Cranbrook') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3cf1dd72-3f12-521f-a9be-a8dd0ba7ef0f', 'Arthur Douroux', 'opti-aus-arthur-douroux-663', '663', 'AUS', NULL, 'NSC-MHYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e3ddfc45-8f37-5f1c-b3eb-7783f0f82513', 'Thomas Douroux', 'opti-aus-thomas-douroux-160', '160', 'AUS', NULL, 'NSC-MHYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('cb189679-8d27-514b-898e-9dd5c60cdb6e', 'Matthias Gasan', 'opti-aus-matthias-gasan-1651', '1651', 'AUS', NULL, 'Scots') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('94f8a237-a0d6-56f1-8192-eccb7fee71e4', 'Joshua Quinn', 'opti-aus-joshua-quinn-534', '534', 'AUS', NULL, 'CYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('760c5ac0-36bc-5c43-b364-a683b74e088e', 'Henry Bolton', 'opti-aus-henry-bolton-1035', '1035', 'AUS', NULL, 'GRSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7409f7c8-f1e5-57ae-b7b4-d3ce110f19a9', 'Nicholas Hasek', 'opti-aus-nicholas-hasek-1761', '1761', 'AUS', NULL, 'Cranbrook') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('711dae05-bbdb-59b1-a315-7e93e8870c92', 'Jiacheng Liu', 'opti-aus-jiacheng-liu-1770', '1770', 'AUS', NULL, 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('272b09a5-259f-55f5-a8f1-a6ad6d1efdb1', 'Samuel Cartmer', 'opti-aus-samuel-cartmer-665', '665', 'AUS', NULL, 'GRSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a68e8e7f-d347-5326-a405-7f795be50f87', 'Lara Dorling', 'opti-aus-lara-dorling-1729', '1729', 'AUS', NULL, 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('22670cfa-0e57-5cbd-b6b0-aef9a8d515e7', 'Olivia Dorling', 'opti-aus-olivia-dorling-372', '372', 'AUS', NULL, 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('31ded344-685d-5597-916d-344220b9cbc0', 'Jack Auswild', 'opti-aus-jack-auswild-1806', '1806', 'AUS', NULL, 'Scots') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6b1c5ca4-6db9-51ea-b461-86a6503f50c8', 'Jamie Lin', 'opti-aus-jamie-lin-1642', '1642', 'AUS', NULL, 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('83bb6bcc-ed37-5b46-8841-dce66870fc3a', 'Eamon Strong', 'opti-aus-eamon-strong-1296', '1296', 'AUS', NULL, 'GRSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('228d609a-0e30-523f-ab39-4f8a4181bde0', 'Oscar Griffin', 'opti-aus-oscar-griffin-1832', '1832', 'AUS', NULL, 'Cranbrook') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0f1dbaf1-c074-5cba-9abc-c91bdde4434f', 'Amelia McKelvey', 'opti-aus-amelia-mckelvey-162', '162', 'AUS', NULL, 'Ascham') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a0364f92-dc90-5d0c-b4db-8fc31981c619', 'Marin Christodoulou Le Gac', 'opti-aus-marin-christodoulou-le-gac-1600', '1600', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e69e8c1b-a4f5-5f59-903b-b857e6a5cc5c', 'Sebastian Salter', 'opti-aus-sebastian-salter-1944', '1944', 'AUS', NULL, 'Cranbrook') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9fd9b1bf-7451-582c-a335-4fb1e7b0866d', 'Tom Withers', 'opti-aus-tom-withers-1697', '1697', 'AUS', NULL, 'Cranbrook') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('35855be2-e8fd-5966-aaff-55c5982c306b', 'Aodh Allatt', 'opti-aus-aodh-allatt-421', '421', 'AUS', NULL, 'CYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7543d5b6-2f3a-5264-81a4-d38f5c56e1b2', 'Lucas Gustafsson', 'opti-aus-lucas-gustafsson-490', '490', 'AUS', NULL, 'CYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c2061301-4809-54ee-9ea1-e1db57322a1e', 'Ferreol Fefe', 'opti-aus-ferreol-fefe-1887', '1887', 'AUS', NULL, 'CYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('8ba5da51-18a7-582e-8663-312927f31d4f', 'Orlando Kohen', 'opti-aus-orlando-kohen-418', '418', 'AUS', NULL, 'CYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('699fc47d-4df1-58af-a442-4dec10596d5c', 'Fiachra Allatt', 'opti-aus-fiachra-allatt-651', '651', 'AUS', NULL, 'CYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d13b04ec-811e-5e60-881b-37abee3a107a', 'Lachlan Birtles', 'opti-aus-lachlan-birtles-1828', '1828', 'AUS', NULL, 'Cranbrook') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6ca5db86-efad-5581-9c51-4e448b92f46b', 'Henry McCleave', 'opti-aus-henry-mccleave-154', '154', 'AUS', NULL, 'CYC') ON CONFLICT (id) DO NOTHING;

-- 4. Results, Participants, and Race Scores
-- Sheet: 2026 Musto Australian Optimist Championship — Intermediate Fleet (42 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'fcfacc28-0567-51a8-9ebc-7653b7a7d32c', '6732309a-18bb-5161-b260-d1e99b94e4dc', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Huon Jones', '949', 'individual', 1, 56.0, 38.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '99320b2d-31b3-55b5-abea-ba3db57e601a', 'fcfacc28-0567-51a8-9ebc-7653b7a7d32c', '6732309a-18bb-5161-b260-d1e99b94e4dc', 'Huon Jones', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fcfacc28-0567-51a8-9ebc-7653b7a7d32c', 1, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fcfacc28-0567-51a8-9ebc-7653b7a7d32c', 2, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fcfacc28-0567-51a8-9ebc-7653b7a7d32c', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fcfacc28-0567-51a8-9ebc-7653b7a7d32c', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fcfacc28-0567-51a8-9ebc-7653b7a7d32c', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fcfacc28-0567-51a8-9ebc-7653b7a7d32c', 6, 18.0, NULL, true, '(18)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fcfacc28-0567-51a8-9ebc-7653b7a7d32c', 7, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fcfacc28-0567-51a8-9ebc-7653b7a7d32c', 8, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fcfacc28-0567-51a8-9ebc-7653b7a7d32c', 9, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f8fbe3d7-552c-56a0-8adb-8b81db7ed48b', '59816f93-32b5-5b51-b7c5-f5f17533aeaa', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Fabio Moeller', '1799', 'individual', 2, 56.0, 40.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '50128551-c930-5725-84eb-a526cbfd3ef4', 'f8fbe3d7-552c-56a0-8adb-8b81db7ed48b', '59816f93-32b5-5b51-b7c5-f5f17533aeaa', 'Fabio Moeller', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f8fbe3d7-552c-56a0-8adb-8b81db7ed48b', 1, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f8fbe3d7-552c-56a0-8adb-8b81db7ed48b', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f8fbe3d7-552c-56a0-8adb-8b81db7ed48b', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f8fbe3d7-552c-56a0-8adb-8b81db7ed48b', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f8fbe3d7-552c-56a0-8adb-8b81db7ed48b', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f8fbe3d7-552c-56a0-8adb-8b81db7ed48b', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f8fbe3d7-552c-56a0-8adb-8b81db7ed48b', 7, 16.0, NULL, true, '(16)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f8fbe3d7-552c-56a0-8adb-8b81db7ed48b', 8, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f8fbe3d7-552c-56a0-8adb-8b81db7ed48b', 9, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '273ce868-c912-5cad-94f6-d15f3dea74bb', 'a60316a7-9870-5c31-861e-b5c4c5f02bbf', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Isabel Yu', '1546', 'individual', 3, 108.0, 65.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4b3de75a-3c08-58d9-bc8b-b8dbe33d82fa', '273ce868-c912-5cad-94f6-d15f3dea74bb', 'a60316a7-9870-5c31-861e-b5c4c5f02bbf', 'Isabel Yu', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('273ce868-c912-5cad-94f6-d15f3dea74bb', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('273ce868-c912-5cad-94f6-d15f3dea74bb', 2, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('273ce868-c912-5cad-94f6-d15f3dea74bb', 3, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('273ce868-c912-5cad-94f6-d15f3dea74bb', 4, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('273ce868-c912-5cad-94f6-d15f3dea74bb', 5, 43.0, 'UFD', true, '(43)UFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('273ce868-c912-5cad-94f6-d15f3dea74bb', 6, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('273ce868-c912-5cad-94f6-d15f3dea74bb', 7, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('273ce868-c912-5cad-94f6-d15f3dea74bb', 8, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('273ce868-c912-5cad-94f6-d15f3dea74bb', 9, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ba2fa637-f7da-5edc-9bbe-1e5ac487b382', '31374565-e925-521a-a074-93c0d364cbc2', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Zac Boyd', '1753', 'individual', 4, 109.0, 79.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4d9ca5f1-32f0-5f26-9a6e-45e651bcbeb9', 'ba2fa637-f7da-5edc-9bbe-1e5ac487b382', '31374565-e925-521a-a074-93c0d364cbc2', 'Zac Boyd', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba2fa637-f7da-5edc-9bbe-1e5ac487b382', 1, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba2fa637-f7da-5edc-9bbe-1e5ac487b382', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba2fa637-f7da-5edc-9bbe-1e5ac487b382', 3, 30.0, NULL, true, '(30)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba2fa637-f7da-5edc-9bbe-1e5ac487b382', 4, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba2fa637-f7da-5edc-9bbe-1e5ac487b382', 5, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba2fa637-f7da-5edc-9bbe-1e5ac487b382', 6, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba2fa637-f7da-5edc-9bbe-1e5ac487b382', 7, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba2fa637-f7da-5edc-9bbe-1e5ac487b382', 8, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba2fa637-f7da-5edc-9bbe-1e5ac487b382', 9, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '69934b35-2328-5d27-865c-963a5476f947', 'b8e6f44d-407f-5a09-8ce1-761d67253264', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Humphrey Hager', '529', 'individual', 5, 128.0, 85.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '69a330ef-4b2d-583d-a896-12605fee0b32', '69934b35-2328-5d27-865c-963a5476f947', 'b8e6f44d-407f-5a09-8ce1-761d67253264', 'Humphrey Hager', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('69934b35-2328-5d27-865c-963a5476f947', 1, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('69934b35-2328-5d27-865c-963a5476f947', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('69934b35-2328-5d27-865c-963a5476f947', 3, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('69934b35-2328-5d27-865c-963a5476f947', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('69934b35-2328-5d27-865c-963a5476f947', 5, 43.0, 'UFD', true, '(43)UFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('69934b35-2328-5d27-865c-963a5476f947', 6, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('69934b35-2328-5d27-865c-963a5476f947', 7, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('69934b35-2328-5d27-865c-963a5476f947', 8, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('69934b35-2328-5d27-865c-963a5476f947', 9, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '82e3e0bc-f669-53cf-8945-24c4bed8246d', 'e912046c-3e11-5658-a475-acc04b70cb9a', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Jack Sturm', '1389', 'individual', 6, 124.0, 88.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '55184837-08ff-554f-8bad-d6f18ee5ab47', '82e3e0bc-f669-53cf-8945-24c4bed8246d', 'e912046c-3e11-5658-a475-acc04b70cb9a', 'Jack Sturm', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82e3e0bc-f669-53cf-8945-24c4bed8246d', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82e3e0bc-f669-53cf-8945-24c4bed8246d', 2, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82e3e0bc-f669-53cf-8945-24c4bed8246d', 3, 36.0, NULL, true, '(36)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82e3e0bc-f669-53cf-8945-24c4bed8246d', 4, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82e3e0bc-f669-53cf-8945-24c4bed8246d', 5, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82e3e0bc-f669-53cf-8945-24c4bed8246d', 6, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82e3e0bc-f669-53cf-8945-24c4bed8246d', 7, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82e3e0bc-f669-53cf-8945-24c4bed8246d', 8, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82e3e0bc-f669-53cf-8945-24c4bed8246d', 9, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0890e080-c0c3-5c1b-8578-28f4966bac2c', '1f83d34f-3841-534a-b7ff-6f06e614de9a', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Jonathan Molloy', '1599', 'individual', 7, 133.0, 90.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bd11a249-0f9e-5116-b8ba-f365c3b390c4', '0890e080-c0c3-5c1b-8578-28f4966bac2c', '1f83d34f-3841-534a-b7ff-6f06e614de9a', 'Jonathan Molloy', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0890e080-c0c3-5c1b-8578-28f4966bac2c', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0890e080-c0c3-5c1b-8578-28f4966bac2c', 2, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0890e080-c0c3-5c1b-8578-28f4966bac2c', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0890e080-c0c3-5c1b-8578-28f4966bac2c', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0890e080-c0c3-5c1b-8578-28f4966bac2c', 5, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0890e080-c0c3-5c1b-8578-28f4966bac2c', 6, 43.0, 'DNF', true, '(43)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0890e080-c0c3-5c1b-8578-28f4966bac2c', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0890e080-c0c3-5c1b-8578-28f4966bac2c', 8, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0890e080-c0c3-5c1b-8578-28f4966bac2c', 9, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '94babfc8-4315-5ecf-8ec5-e8b172cab68d', '49e3b629-7287-5783-a7d3-d00366db458b', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Ollie Harry', '1518', 'individual', 8, 116.0, 93.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6ec86c54-1814-54d6-8dc8-1a0d1d9fbaa6', '94babfc8-4315-5ecf-8ec5-e8b172cab68d', '49e3b629-7287-5783-a7d3-d00366db458b', 'Ollie Harry', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('94babfc8-4315-5ecf-8ec5-e8b172cab68d', 1, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('94babfc8-4315-5ecf-8ec5-e8b172cab68d', 2, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('94babfc8-4315-5ecf-8ec5-e8b172cab68d', 3, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('94babfc8-4315-5ecf-8ec5-e8b172cab68d', 4, 23.0, NULL, true, '(23)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('94babfc8-4315-5ecf-8ec5-e8b172cab68d', 5, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('94babfc8-4315-5ecf-8ec5-e8b172cab68d', 6, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('94babfc8-4315-5ecf-8ec5-e8b172cab68d', 7, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('94babfc8-4315-5ecf-8ec5-e8b172cab68d', 8, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('94babfc8-4315-5ecf-8ec5-e8b172cab68d', 9, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ae5afef8-1112-5d5b-b893-eed65821aa42', '7f3d0b20-1951-5923-a815-94ec83024ae8', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Lachlan King', '409', 'individual', 9, 115.0, 95.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3f588cb7-bd81-5371-934a-35c98f998eb2', 'ae5afef8-1112-5d5b-b893-eed65821aa42', '7f3d0b20-1951-5923-a815-94ec83024ae8', 'Lachlan King', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ae5afef8-1112-5d5b-b893-eed65821aa42', 1, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ae5afef8-1112-5d5b-b893-eed65821aa42', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ae5afef8-1112-5d5b-b893-eed65821aa42', 3, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ae5afef8-1112-5d5b-b893-eed65821aa42', 4, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ae5afef8-1112-5d5b-b893-eed65821aa42', 5, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ae5afef8-1112-5d5b-b893-eed65821aa42', 6, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ae5afef8-1112-5d5b-b893-eed65821aa42', 7, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ae5afef8-1112-5d5b-b893-eed65821aa42', 8, 20.0, NULL, true, '(20)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ae5afef8-1112-5d5b-b893-eed65821aa42', 9, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'db435e0f-4a9a-5ab2-a9ec-fc468d809a50', '71010fdd-6c88-5e28-b9aa-5a1648dbe7b5', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Anne Edwards', '1269', 'individual', 10, 134.0, 101.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c35d07f9-0dfe-523a-ab84-25f4dfe13c2f', 'db435e0f-4a9a-5ab2-a9ec-fc468d809a50', '71010fdd-6c88-5e28-b9aa-5a1648dbe7b5', 'Anne Edwards', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('db435e0f-4a9a-5ab2-a9ec-fc468d809a50', 1, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('db435e0f-4a9a-5ab2-a9ec-fc468d809a50', 2, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('db435e0f-4a9a-5ab2-a9ec-fc468d809a50', 3, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('db435e0f-4a9a-5ab2-a9ec-fc468d809a50', 4, 33.0, NULL, true, '(33)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('db435e0f-4a9a-5ab2-a9ec-fc468d809a50', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('db435e0f-4a9a-5ab2-a9ec-fc468d809a50', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('db435e0f-4a9a-5ab2-a9ec-fc468d809a50', 7, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('db435e0f-4a9a-5ab2-a9ec-fc468d809a50', 8, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('db435e0f-4a9a-5ab2-a9ec-fc468d809a50', 9, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b3f3339d-b6c1-5183-a639-9c0b476db3f0', 'd78e9d11-5477-5432-848b-af309c61ec2e', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'William Corkhill', '826', 'individual', 11, 125.0, 101.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '250c8b8f-a36a-5110-a243-bcfd6697a328', 'b3f3339d-b6c1-5183-a639-9c0b476db3f0', 'd78e9d11-5477-5432-848b-af309c61ec2e', 'William Corkhill', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b3f3339d-b6c1-5183-a639-9c0b476db3f0', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b3f3339d-b6c1-5183-a639-9c0b476db3f0', 2, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b3f3339d-b6c1-5183-a639-9c0b476db3f0', 3, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b3f3339d-b6c1-5183-a639-9c0b476db3f0', 4, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b3f3339d-b6c1-5183-a639-9c0b476db3f0', 5, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b3f3339d-b6c1-5183-a639-9c0b476db3f0', 6, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b3f3339d-b6c1-5183-a639-9c0b476db3f0', 7, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b3f3339d-b6c1-5183-a639-9c0b476db3f0', 8, 24.0, NULL, true, '(24)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b3f3339d-b6c1-5183-a639-9c0b476db3f0', 9, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '6167d4a9-1c2a-5728-9e27-f421e0d5a7f9', '53ca59e1-b29b-5fed-acfc-b65407a76960', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Bono Svacek', '1855', 'individual', 12, 128.0, 101.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ab8c5af1-0a60-5b5a-b162-8ec5aef43c7d', '6167d4a9-1c2a-5728-9e27-f421e0d5a7f9', '53ca59e1-b29b-5fed-acfc-b65407a76960', 'Bono Svacek', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6167d4a9-1c2a-5728-9e27-f421e0d5a7f9', 1, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6167d4a9-1c2a-5728-9e27-f421e0d5a7f9', 2, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6167d4a9-1c2a-5728-9e27-f421e0d5a7f9', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6167d4a9-1c2a-5728-9e27-f421e0d5a7f9', 4, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6167d4a9-1c2a-5728-9e27-f421e0d5a7f9', 5, 27.0, NULL, true, '(27)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6167d4a9-1c2a-5728-9e27-f421e0d5a7f9', 6, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6167d4a9-1c2a-5728-9e27-f421e0d5a7f9', 7, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6167d4a9-1c2a-5728-9e27-f421e0d5a7f9', 8, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6167d4a9-1c2a-5728-9e27-f421e0d5a7f9', 9, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '67a59b40-8ea0-5817-a301-f662da03ac72', '6bb53a1d-beec-5217-a6bb-996c0f92b13f', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'William James', '1517', 'individual', 13, 145.0, 109.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'de16177a-7bd9-51f7-aa66-8d555b7d539c', '67a59b40-8ea0-5817-a301-f662da03ac72', '6bb53a1d-beec-5217-a6bb-996c0f92b13f', 'William James', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('67a59b40-8ea0-5817-a301-f662da03ac72', 1, 36.0, NULL, true, '(36)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('67a59b40-8ea0-5817-a301-f662da03ac72', 2, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('67a59b40-8ea0-5817-a301-f662da03ac72', 3, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('67a59b40-8ea0-5817-a301-f662da03ac72', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('67a59b40-8ea0-5817-a301-f662da03ac72', 5, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('67a59b40-8ea0-5817-a301-f662da03ac72', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('67a59b40-8ea0-5817-a301-f662da03ac72', 7, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('67a59b40-8ea0-5817-a301-f662da03ac72', 8, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('67a59b40-8ea0-5817-a301-f662da03ac72', 9, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '00ed8f7c-ef3b-5790-a26c-3ec938958bf2', '41c571c0-0ca0-5403-b3e5-51b515ae9c38', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Naomi Von Bubra', '1709', 'individual', 14, 146.0, 110.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '42fbfbda-0bc3-5e6b-9a26-9a3685aa56e7', '00ed8f7c-ef3b-5790-a26c-3ec938958bf2', '41c571c0-0ca0-5403-b3e5-51b515ae9c38', 'Naomi Von Bubra', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('00ed8f7c-ef3b-5790-a26c-3ec938958bf2', 1, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('00ed8f7c-ef3b-5790-a26c-3ec938958bf2', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('00ed8f7c-ef3b-5790-a26c-3ec938958bf2', 3, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('00ed8f7c-ef3b-5790-a26c-3ec938958bf2', 4, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('00ed8f7c-ef3b-5790-a26c-3ec938958bf2', 5, 36.0, NULL, true, '(36)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('00ed8f7c-ef3b-5790-a26c-3ec938958bf2', 6, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('00ed8f7c-ef3b-5790-a26c-3ec938958bf2', 7, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('00ed8f7c-ef3b-5790-a26c-3ec938958bf2', 8, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('00ed8f7c-ef3b-5790-a26c-3ec938958bf2', 9, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'cf86f615-8169-566f-ab0d-e38ad3add50d', '83fa263e-034d-55f8-aaaa-452f7b43fa85', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Jozee Fowler', '982', 'individual', 15, 154.0, 116.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8939839a-585e-5a34-867c-4f87fd479392', 'cf86f615-8169-566f-ab0d-e38ad3add50d', '83fa263e-034d-55f8-aaaa-452f7b43fa85', 'Jozee Fowler', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cf86f615-8169-566f-ab0d-e38ad3add50d', 1, 38.0, NULL, true, '(38)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cf86f615-8169-566f-ab0d-e38ad3add50d', 2, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cf86f615-8169-566f-ab0d-e38ad3add50d', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cf86f615-8169-566f-ab0d-e38ad3add50d', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cf86f615-8169-566f-ab0d-e38ad3add50d', 5, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cf86f615-8169-566f-ab0d-e38ad3add50d', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cf86f615-8169-566f-ab0d-e38ad3add50d', 7, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cf86f615-8169-566f-ab0d-e38ad3add50d', 8, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cf86f615-8169-566f-ab0d-e38ad3add50d', 9, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8910997a-5a52-5c45-add3-cca1940c4af4', 'f9a37376-1672-5dfb-98a2-a7e5006893d1', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Charlie Mclaren', '1398', 'individual', 16, 151.0, 120.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd0756693-8263-5463-8421-cbece052c6a9', '8910997a-5a52-5c45-add3-cca1940c4af4', 'f9a37376-1672-5dfb-98a2-a7e5006893d1', 'Charlie Mclaren', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8910997a-5a52-5c45-add3-cca1940c4af4', 1, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8910997a-5a52-5c45-add3-cca1940c4af4', 2, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8910997a-5a52-5c45-add3-cca1940c4af4', 3, 31.0, NULL, true, '(31)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8910997a-5a52-5c45-add3-cca1940c4af4', 4, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8910997a-5a52-5c45-add3-cca1940c4af4', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8910997a-5a52-5c45-add3-cca1940c4af4', 6, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8910997a-5a52-5c45-add3-cca1940c4af4', 7, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8910997a-5a52-5c45-add3-cca1940c4af4', 8, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8910997a-5a52-5c45-add3-cca1940c4af4', 9, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'dfe8865a-4a4f-5804-9957-674b34d8d333', '22198eeb-11f7-5b24-9e11-30cbdee01fb1', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Noah Tate', '640', 'individual', 17, 161.0, 133.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '18c91b71-8242-51a2-9f5b-ce8f9fbf8618', 'dfe8865a-4a4f-5804-9957-674b34d8d333', '22198eeb-11f7-5b24-9e11-30cbdee01fb1', 'Noah Tate', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfe8865a-4a4f-5804-9957-674b34d8d333', 1, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfe8865a-4a4f-5804-9957-674b34d8d333', 2, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfe8865a-4a4f-5804-9957-674b34d8d333', 3, 28.0, NULL, true, '(28)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfe8865a-4a4f-5804-9957-674b34d8d333', 4, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfe8865a-4a4f-5804-9957-674b34d8d333', 5, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfe8865a-4a4f-5804-9957-674b34d8d333', 6, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfe8865a-4a4f-5804-9957-674b34d8d333', 7, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfe8865a-4a4f-5804-9957-674b34d8d333', 8, 24.0, 'SCP', false, '24SCP') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfe8865a-4a4f-5804-9957-674b34d8d333', 9, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b82ebf5d-b9f3-5fe3-8ea9-875bf06e4ad3', 'c06e2055-9901-5c52-9279-24d59b25d2a4', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Rory Martin', '877', 'individual', 18, 180.0, 137.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'be7c6b95-eb94-5e50-926e-b11a40aa63b0', 'b82ebf5d-b9f3-5fe3-8ea9-875bf06e4ad3', 'c06e2055-9901-5c52-9279-24d59b25d2a4', 'Rory Martin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b82ebf5d-b9f3-5fe3-8ea9-875bf06e4ad3', 1, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b82ebf5d-b9f3-5fe3-8ea9-875bf06e4ad3', 2, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b82ebf5d-b9f3-5fe3-8ea9-875bf06e4ad3', 3, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b82ebf5d-b9f3-5fe3-8ea9-875bf06e4ad3', 4, 43.0, 'DNF', true, '(43)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b82ebf5d-b9f3-5fe3-8ea9-875bf06e4ad3', 5, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b82ebf5d-b9f3-5fe3-8ea9-875bf06e4ad3', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b82ebf5d-b9f3-5fe3-8ea9-875bf06e4ad3', 7, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b82ebf5d-b9f3-5fe3-8ea9-875bf06e4ad3', 8, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b82ebf5d-b9f3-5fe3-8ea9-875bf06e4ad3', 9, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '36d1319e-c183-5754-b4ef-6f4bbe182ea7', '9a41bcbd-ac5d-56f9-9c76-709aa5f78d69', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Grace Newitt', '1865', 'individual', 19, 190.0, 147.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c7f70b92-26ce-5139-b34b-48dd1d61e7a2', '36d1319e-c183-5754-b4ef-6f4bbe182ea7', '9a41bcbd-ac5d-56f9-9c76-709aa5f78d69', 'Grace Newitt', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36d1319e-c183-5754-b4ef-6f4bbe182ea7', 1, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36d1319e-c183-5754-b4ef-6f4bbe182ea7', 2, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36d1319e-c183-5754-b4ef-6f4bbe182ea7', 3, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36d1319e-c183-5754-b4ef-6f4bbe182ea7', 4, 36.0, NULL, false, '36') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36d1319e-c183-5754-b4ef-6f4bbe182ea7', 5, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36d1319e-c183-5754-b4ef-6f4bbe182ea7', 6, 43.0, 'DNF', true, '(43)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36d1319e-c183-5754-b4ef-6f4bbe182ea7', 7, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36d1319e-c183-5754-b4ef-6f4bbe182ea7', 8, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36d1319e-c183-5754-b4ef-6f4bbe182ea7', 9, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a86c5ad6-5395-5c22-b691-1e9a3d8ee727', '48a1a52b-6bd7-5c30-8d2c-39eb3af7b314', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Alex Baxter', '1767', 'individual', 20, 183.0, 150.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '66c3dd78-7d68-54b9-92b7-4be6255f6771', 'a86c5ad6-5395-5c22-b691-1e9a3d8ee727', '48a1a52b-6bd7-5c30-8d2c-39eb3af7b314', 'Alex Baxter', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a86c5ad6-5395-5c22-b691-1e9a3d8ee727', 1, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a86c5ad6-5395-5c22-b691-1e9a3d8ee727', 2, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a86c5ad6-5395-5c22-b691-1e9a3d8ee727', 3, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a86c5ad6-5395-5c22-b691-1e9a3d8ee727', 4, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a86c5ad6-5395-5c22-b691-1e9a3d8ee727', 5, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a86c5ad6-5395-5c22-b691-1e9a3d8ee727', 6, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a86c5ad6-5395-5c22-b691-1e9a3d8ee727', 7, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a86c5ad6-5395-5c22-b691-1e9a3d8ee727', 8, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a86c5ad6-5395-5c22-b691-1e9a3d8ee727', 9, 33.0, NULL, true, '(33)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd63af817-4ee5-5c30-a483-02a1ec9b1dfd', '70391ae7-d567-55b9-b91c-3f80e65e3f84', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Max Hughes', '1734', 'individual', 21, 186.0, 151.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '230ff3ff-131d-5b58-96c1-96c8e00eea6e', 'd63af817-4ee5-5c30-a483-02a1ec9b1dfd', '70391ae7-d567-55b9-b91c-3f80e65e3f84', 'Max Hughes', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d63af817-4ee5-5c30-a483-02a1ec9b1dfd', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d63af817-4ee5-5c30-a483-02a1ec9b1dfd', 2, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d63af817-4ee5-5c30-a483-02a1ec9b1dfd', 3, 35.0, NULL, true, '(35)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d63af817-4ee5-5c30-a483-02a1ec9b1dfd', 4, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d63af817-4ee5-5c30-a483-02a1ec9b1dfd', 5, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d63af817-4ee5-5c30-a483-02a1ec9b1dfd', 6, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d63af817-4ee5-5c30-a483-02a1ec9b1dfd', 7, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d63af817-4ee5-5c30-a483-02a1ec9b1dfd', 8, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d63af817-4ee5-5c30-a483-02a1ec9b1dfd', 9, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e08f07e8-24d6-518d-9a8b-aa1472949f2f', '6e96039b-08eb-545b-bd0d-84d0ca46eca9', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Lucas Kattera', '3652', 'individual', 22, 195.0, 152.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5cb3e0ea-990b-5c24-8402-672881a2dc1e', 'e08f07e8-24d6-518d-9a8b-aa1472949f2f', '6e96039b-08eb-545b-bd0d-84d0ca46eca9', 'Lucas Kattera', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e08f07e8-24d6-518d-9a8b-aa1472949f2f', 1, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e08f07e8-24d6-518d-9a8b-aa1472949f2f', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e08f07e8-24d6-518d-9a8b-aa1472949f2f', 3, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e08f07e8-24d6-518d-9a8b-aa1472949f2f', 4, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e08f07e8-24d6-518d-9a8b-aa1472949f2f', 5, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e08f07e8-24d6-518d-9a8b-aa1472949f2f', 6, 43.0, 'DNF', true, '(43)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e08f07e8-24d6-518d-9a8b-aa1472949f2f', 7, 43.0, 'BFD', false, '43BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e08f07e8-24d6-518d-9a8b-aa1472949f2f', 8, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e08f07e8-24d6-518d-9a8b-aa1472949f2f', 9, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9421ea93-8740-5160-8e22-4b92e17010b5', '79de686e-027d-5809-99e8-453bfd3cf285', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Miles White', '1432', 'individual', 23, 196.0, 153.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f7d139e9-1c32-514a-903f-6f57e00b9d0a', '9421ea93-8740-5160-8e22-4b92e17010b5', '79de686e-027d-5809-99e8-453bfd3cf285', 'Miles White', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9421ea93-8740-5160-8e22-4b92e17010b5', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9421ea93-8740-5160-8e22-4b92e17010b5', 2, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9421ea93-8740-5160-8e22-4b92e17010b5', 3, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9421ea93-8740-5160-8e22-4b92e17010b5', 4, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9421ea93-8740-5160-8e22-4b92e17010b5', 5, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9421ea93-8740-5160-8e22-4b92e17010b5', 6, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9421ea93-8740-5160-8e22-4b92e17010b5', 7, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9421ea93-8740-5160-8e22-4b92e17010b5', 8, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9421ea93-8740-5160-8e22-4b92e17010b5', 9, 43.0, 'UFD', true, '(43)UFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e35b52bf-cdd3-5fb8-ac15-6054ee65c162', 'f4e7e0f5-e123-5a27-900b-ec3a7b908d91', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Michelle Crisp', '674', 'individual', 24, 199.0, 156.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9e6e690d-6f14-5c91-aa72-299fa0ad3e12', 'e35b52bf-cdd3-5fb8-ac15-6054ee65c162', 'f4e7e0f5-e123-5a27-900b-ec3a7b908d91', 'Michelle Crisp', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e35b52bf-cdd3-5fb8-ac15-6054ee65c162', 1, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e35b52bf-cdd3-5fb8-ac15-6054ee65c162', 2, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e35b52bf-cdd3-5fb8-ac15-6054ee65c162', 3, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e35b52bf-cdd3-5fb8-ac15-6054ee65c162', 4, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e35b52bf-cdd3-5fb8-ac15-6054ee65c162', 5, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e35b52bf-cdd3-5fb8-ac15-6054ee65c162', 6, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e35b52bf-cdd3-5fb8-ac15-6054ee65c162', 7, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e35b52bf-cdd3-5fb8-ac15-6054ee65c162', 8, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e35b52bf-cdd3-5fb8-ac15-6054ee65c162', 9, 43.0, 'DNF', true, '(43)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd16c850e-252c-5472-9d08-b11f703085fe', 'eee6d9a8-20bc-5f54-a5c5-c9ba6b51e502', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'James Paterson', '1305', 'individual', 25, 203.0, 160.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'dd3ee857-180d-5e9d-9658-548820824883', 'd16c850e-252c-5472-9d08-b11f703085fe', 'eee6d9a8-20bc-5f54-a5c5-c9ba6b51e502', 'James Paterson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d16c850e-252c-5472-9d08-b11f703085fe', 1, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d16c850e-252c-5472-9d08-b11f703085fe', 2, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d16c850e-252c-5472-9d08-b11f703085fe', 3, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d16c850e-252c-5472-9d08-b11f703085fe', 4, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d16c850e-252c-5472-9d08-b11f703085fe', 5, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d16c850e-252c-5472-9d08-b11f703085fe', 6, 43.0, 'DNF', true, '(43)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d16c850e-252c-5472-9d08-b11f703085fe', 7, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d16c850e-252c-5472-9d08-b11f703085fe', 8, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d16c850e-252c-5472-9d08-b11f703085fe', 9, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '14a8fa58-6143-5d73-866e-f25e645e2baf', '60dd4d51-c920-5e84-b1e4-b662df586d2f', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Caitlin Grant', '327', 'individual', 26, 205.0, 162.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ded5022f-83e7-518f-ab15-e58c30d50ae6', '14a8fa58-6143-5d73-866e-f25e645e2baf', '60dd4d51-c920-5e84-b1e4-b662df586d2f', 'Caitlin Grant', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('14a8fa58-6143-5d73-866e-f25e645e2baf', 1, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('14a8fa58-6143-5d73-866e-f25e645e2baf', 2, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('14a8fa58-6143-5d73-866e-f25e645e2baf', 3, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('14a8fa58-6143-5d73-866e-f25e645e2baf', 4, 43.0, 'DNF', true, '(43)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('14a8fa58-6143-5d73-866e-f25e645e2baf', 5, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('14a8fa58-6143-5d73-866e-f25e645e2baf', 6, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('14a8fa58-6143-5d73-866e-f25e645e2baf', 7, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('14a8fa58-6143-5d73-866e-f25e645e2baf', 8, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('14a8fa58-6143-5d73-866e-f25e645e2baf', 9, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1b72265f-2744-5d23-90c9-6ebde70d989d', 'fa8a0991-c6cb-529b-a5c2-26766e09b4b2', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Lucy Norris', '1779', 'individual', 27, 202.0, 166.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f0196503-fa10-5967-8b0c-376bcd809044', '1b72265f-2744-5d23-90c9-6ebde70d989d', 'fa8a0991-c6cb-529b-a5c2-26766e09b4b2', 'Lucy Norris', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b72265f-2744-5d23-90c9-6ebde70d989d', 1, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b72265f-2744-5d23-90c9-6ebde70d989d', 2, 36.0, NULL, true, '(36)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b72265f-2744-5d23-90c9-6ebde70d989d', 3, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b72265f-2744-5d23-90c9-6ebde70d989d', 4, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b72265f-2744-5d23-90c9-6ebde70d989d', 5, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b72265f-2744-5d23-90c9-6ebde70d989d', 6, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b72265f-2744-5d23-90c9-6ebde70d989d', 7, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b72265f-2744-5d23-90c9-6ebde70d989d', 8, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b72265f-2744-5d23-90c9-6ebde70d989d', 9, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ac6f313b-122e-53f3-b284-3162cd20518d', 'b70a3181-1954-5c93-966e-4407dbf63a36', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Bobby Williams', '1926', 'individual', 28, 212.0, 169.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fda8ed5b-1f18-539d-89cd-5ef3e8c5866b', 'ac6f313b-122e-53f3-b284-3162cd20518d', 'b70a3181-1954-5c93-966e-4407dbf63a36', 'Bobby Williams', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ac6f313b-122e-53f3-b284-3162cd20518d', 1, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ac6f313b-122e-53f3-b284-3162cd20518d', 2, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ac6f313b-122e-53f3-b284-3162cd20518d', 3, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ac6f313b-122e-53f3-b284-3162cd20518d', 4, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ac6f313b-122e-53f3-b284-3162cd20518d', 5, 43.0, 'UFD', true, '(43)UFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ac6f313b-122e-53f3-b284-3162cd20518d', 6, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ac6f313b-122e-53f3-b284-3162cd20518d', 7, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ac6f313b-122e-53f3-b284-3162cd20518d', 8, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ac6f313b-122e-53f3-b284-3162cd20518d', 9, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '4a26ec84-0eca-5822-b638-55f61e45a6ad', 'b259b4fe-9ae6-521b-960b-34da1fe8a554', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Jasmine Wang', '1668', 'individual', 29, 219.0, 181.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c3274782-4ee7-52f5-ad26-753d8e904052', '4a26ec84-0eca-5822-b638-55f61e45a6ad', 'b259b4fe-9ae6-521b-960b-34da1fe8a554', 'Jasmine Wang', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a26ec84-0eca-5822-b638-55f61e45a6ad', 1, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a26ec84-0eca-5822-b638-55f61e45a6ad', 2, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a26ec84-0eca-5822-b638-55f61e45a6ad', 3, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a26ec84-0eca-5822-b638-55f61e45a6ad', 4, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a26ec84-0eca-5822-b638-55f61e45a6ad', 5, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a26ec84-0eca-5822-b638-55f61e45a6ad', 6, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a26ec84-0eca-5822-b638-55f61e45a6ad', 7, 36.0, NULL, false, '36') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a26ec84-0eca-5822-b638-55f61e45a6ad', 8, 38.0, NULL, true, '(38)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a26ec84-0eca-5822-b638-55f61e45a6ad', 9, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '190118d5-e65b-502b-8302-2a1561d9349a', '5f837edc-6728-50d4-901d-6a8ea81dc026', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Alice Cameron', '325', 'individual', 30, 251.0, 208.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '83b5507e-7883-5b88-9552-b1a56c97b7b1', '190118d5-e65b-502b-8302-2a1561d9349a', '5f837edc-6728-50d4-901d-6a8ea81dc026', 'Alice Cameron', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('190118d5-e65b-502b-8302-2a1561d9349a', 1, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('190118d5-e65b-502b-8302-2a1561d9349a', 2, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('190118d5-e65b-502b-8302-2a1561d9349a', 3, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('190118d5-e65b-502b-8302-2a1561d9349a', 4, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('190118d5-e65b-502b-8302-2a1561d9349a', 5, 43.0, 'SCP', true, '(43)SCP') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('190118d5-e65b-502b-8302-2a1561d9349a', 6, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('190118d5-e65b-502b-8302-2a1561d9349a', 7, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('190118d5-e65b-502b-8302-2a1561d9349a', 8, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('190118d5-e65b-502b-8302-2a1561d9349a', 9, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a7ff32d4-6408-5915-b84e-931b7752443a', 'b4522674-e289-551e-bdc3-136bf47f62c6', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Henry Campbell', '1933', 'individual', 31, 253.0, 210.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0b0fc5b5-faf4-5642-ac00-e5c71706334a', 'a7ff32d4-6408-5915-b84e-931b7752443a', 'b4522674-e289-551e-bdc3-136bf47f62c6', 'Henry Campbell', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a7ff32d4-6408-5915-b84e-931b7752443a', 1, 39.0, NULL, false, '39') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a7ff32d4-6408-5915-b84e-931b7752443a', 2, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a7ff32d4-6408-5915-b84e-931b7752443a', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a7ff32d4-6408-5915-b84e-931b7752443a', 4, 43.0, 'DNF', true, '(43)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a7ff32d4-6408-5915-b84e-931b7752443a', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a7ff32d4-6408-5915-b84e-931b7752443a', 6, 43.0, 'DNF', false, '43DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a7ff32d4-6408-5915-b84e-931b7752443a', 7, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a7ff32d4-6408-5915-b84e-931b7752443a', 8, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a7ff32d4-6408-5915-b84e-931b7752443a', 9, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ba6da13b-d568-5b3b-9040-00af5db4972b', '579d0ed0-0d0b-5e5e-8ee8-a610dc49defa', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Mila Tait', '1701', 'individual', 32, 256.0, 213.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e510e533-ac0a-57db-a0df-fc74b8b43a75', 'ba6da13b-d568-5b3b-9040-00af5db4972b', '579d0ed0-0d0b-5e5e-8ee8-a610dc49defa', 'Mila Tait', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba6da13b-d568-5b3b-9040-00af5db4972b', 1, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba6da13b-d568-5b3b-9040-00af5db4972b', 2, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba6da13b-d568-5b3b-9040-00af5db4972b', 3, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba6da13b-d568-5b3b-9040-00af5db4972b', 4, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba6da13b-d568-5b3b-9040-00af5db4972b', 5, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba6da13b-d568-5b3b-9040-00af5db4972b', 6, 43.0, 'DNF', true, '(43)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba6da13b-d568-5b3b-9040-00af5db4972b', 7, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba6da13b-d568-5b3b-9040-00af5db4972b', 8, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba6da13b-d568-5b3b-9040-00af5db4972b', 9, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '89cd005a-0e91-5dfe-bfbf-419f457e83f3', 'b4803202-b601-5933-b9d5-c230caab796d', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'William Linscott', '1408', 'individual', 33, 272.0, 229.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c6e6cbe8-a5ca-58e2-ad02-e4b78fc7e518', '89cd005a-0e91-5dfe-bfbf-419f457e83f3', 'b4803202-b601-5933-b9d5-c230caab796d', 'William Linscott', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('89cd005a-0e91-5dfe-bfbf-419f457e83f3', 1, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('89cd005a-0e91-5dfe-bfbf-419f457e83f3', 2, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('89cd005a-0e91-5dfe-bfbf-419f457e83f3', 3, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('89cd005a-0e91-5dfe-bfbf-419f457e83f3', 4, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('89cd005a-0e91-5dfe-bfbf-419f457e83f3', 5, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('89cd005a-0e91-5dfe-bfbf-419f457e83f3', 6, 43.0, 'DNF', true, '(43)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('89cd005a-0e91-5dfe-bfbf-419f457e83f3', 7, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('89cd005a-0e91-5dfe-bfbf-419f457e83f3', 8, 43.0, 'DNF', false, '43DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('89cd005a-0e91-5dfe-bfbf-419f457e83f3', 9, 43.0, 'DNC', false, '43DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a8bd3b29-7a35-52ec-bcb5-dcf35f887520', 'd8ff4e35-8040-5c54-8d3c-f943992b3ed5', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Francis Watts', '1766', 'individual', 34, 280.0, 237.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e00736ba-26fd-5d85-93d4-b26e6ed4bf9f', 'a8bd3b29-7a35-52ec-bcb5-dcf35f887520', 'd8ff4e35-8040-5c54-8d3c-f943992b3ed5', 'Francis Watts', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a8bd3b29-7a35-52ec-bcb5-dcf35f887520', 1, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a8bd3b29-7a35-52ec-bcb5-dcf35f887520', 2, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a8bd3b29-7a35-52ec-bcb5-dcf35f887520', 3, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a8bd3b29-7a35-52ec-bcb5-dcf35f887520', 4, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a8bd3b29-7a35-52ec-bcb5-dcf35f887520', 5, 43.0, 'UFD', true, '(43)UFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a8bd3b29-7a35-52ec-bcb5-dcf35f887520', 6, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a8bd3b29-7a35-52ec-bcb5-dcf35f887520', 7, 39.0, NULL, false, '39') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a8bd3b29-7a35-52ec-bcb5-dcf35f887520', 8, 39.0, NULL, false, '39') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a8bd3b29-7a35-52ec-bcb5-dcf35f887520', 9, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '554ec0ee-b078-5afe-bfdb-afde215fe463', '3a276e16-704b-5e50-a6ff-99e916ca2757', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Anna Malpas', '535', 'individual', 35, 281.0, 238.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '08ea853a-c50d-5cbf-8e18-bca8fb3d6f0f', '554ec0ee-b078-5afe-bfdb-afde215fe463', '3a276e16-704b-5e50-a6ff-99e916ca2757', 'Anna Malpas', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('554ec0ee-b078-5afe-bfdb-afde215fe463', 1, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('554ec0ee-b078-5afe-bfdb-afde215fe463', 2, 33.0, 'SCP', false, '33SCP') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('554ec0ee-b078-5afe-bfdb-afde215fe463', 3, 35.0, 'SCP', false, '35SCP') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('554ec0ee-b078-5afe-bfdb-afde215fe463', 4, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('554ec0ee-b078-5afe-bfdb-afde215fe463', 5, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('554ec0ee-b078-5afe-bfdb-afde215fe463', 6, 43.0, 'DNF', true, '(43)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('554ec0ee-b078-5afe-bfdb-afde215fe463', 7, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('554ec0ee-b078-5afe-bfdb-afde215fe463', 8, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('554ec0ee-b078-5afe-bfdb-afde215fe463', 9, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '63f2c4e7-5d13-5ef9-bad7-7826e76069d8', '610c6290-0b02-560f-b492-236793c8714b', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Hugo Liebeknecht', '992', 'individual', 36, 288.0, 245.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '47e0aca5-d1cd-573f-a0b3-70df018ec087', '63f2c4e7-5d13-5ef9-bad7-7826e76069d8', '610c6290-0b02-560f-b492-236793c8714b', 'Hugo Liebeknecht', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63f2c4e7-5d13-5ef9-bad7-7826e76069d8', 1, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63f2c4e7-5d13-5ef9-bad7-7826e76069d8', 2, 39.0, NULL, false, '39') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63f2c4e7-5d13-5ef9-bad7-7826e76069d8', 3, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63f2c4e7-5d13-5ef9-bad7-7826e76069d8', 4, 43.0, 'DNC', true, '(43)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63f2c4e7-5d13-5ef9-bad7-7826e76069d8', 5, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63f2c4e7-5d13-5ef9-bad7-7826e76069d8', 6, 43.0, 'DNF', false, '43DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63f2c4e7-5d13-5ef9-bad7-7826e76069d8', 7, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63f2c4e7-5d13-5ef9-bad7-7826e76069d8', 8, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63f2c4e7-5d13-5ef9-bad7-7826e76069d8', 9, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f67c92c0-71f8-5837-879c-fccd92f67e60', 'd74ce041-92cb-578f-85a9-b1e22cb02f85', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Felix Bradley', '1621', 'individual', 37, 298.0, 255.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b1682e7e-f3c6-52c6-98f9-a93fd93265f0', 'f67c92c0-71f8-5837-879c-fccd92f67e60', 'd74ce041-92cb-578f-85a9-b1e22cb02f85', 'Felix Bradley', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f67c92c0-71f8-5837-879c-fccd92f67e60', 1, 43.0, 'DNF', true, '(43)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f67c92c0-71f8-5837-879c-fccd92f67e60', 2, 37.0, NULL, false, '37') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f67c92c0-71f8-5837-879c-fccd92f67e60', 3, 39.0, NULL, false, '39') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f67c92c0-71f8-5837-879c-fccd92f67e60', 4, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f67c92c0-71f8-5837-879c-fccd92f67e60', 5, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f67c92c0-71f8-5837-879c-fccd92f67e60', 6, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f67c92c0-71f8-5837-879c-fccd92f67e60', 7, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f67c92c0-71f8-5837-879c-fccd92f67e60', 8, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f67c92c0-71f8-5837-879c-fccd92f67e60', 9, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '30f86018-9fd8-55f9-81fd-653445f51d25', '1eae3001-9d62-5cdc-98f1-5acbaa97e369', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Nathan Mao', '485', 'individual', 38, 302.0, 259.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9585b2e2-a1ae-5820-90aa-1bc615d0ac59', '30f86018-9fd8-55f9-81fd-653445f51d25', '1eae3001-9d62-5cdc-98f1-5acbaa97e369', 'Nathan Mao', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30f86018-9fd8-55f9-81fd-653445f51d25', 1, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30f86018-9fd8-55f9-81fd-653445f51d25', 2, 43.0, 'DNC', true, '(43)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30f86018-9fd8-55f9-81fd-653445f51d25', 3, 37.0, NULL, false, '37') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30f86018-9fd8-55f9-81fd-653445f51d25', 4, 43.0, 'DNF', false, '43DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30f86018-9fd8-55f9-81fd-653445f51d25', 5, 43.0, 'UFD', false, '43UFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30f86018-9fd8-55f9-81fd-653445f51d25', 6, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30f86018-9fd8-55f9-81fd-653445f51d25', 7, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30f86018-9fd8-55f9-81fd-653445f51d25', 8, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30f86018-9fd8-55f9-81fd-653445f51d25', 9, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ba8c082a-9172-5314-8227-0cfd5153502a', 'ffee66ca-ee78-504e-9fac-f2c556c77843', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Sam Harris', '1914', 'individual', 39, 318.0, 275.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1f5e39ba-fa70-5122-9608-47355c548a0f', 'ba8c082a-9172-5314-8227-0cfd5153502a', 'ffee66ca-ee78-504e-9fac-f2c556c77843', 'Sam Harris', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba8c082a-9172-5314-8227-0cfd5153502a', 1, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba8c082a-9172-5314-8227-0cfd5153502a', 2, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba8c082a-9172-5314-8227-0cfd5153502a', 3, 38.0, NULL, false, '38') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba8c082a-9172-5314-8227-0cfd5153502a', 4, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba8c082a-9172-5314-8227-0cfd5153502a', 5, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba8c082a-9172-5314-8227-0cfd5153502a', 6, 43.0, 'DNF', true, '(43)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba8c082a-9172-5314-8227-0cfd5153502a', 7, 43.0, 'BFD', false, '43BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba8c082a-9172-5314-8227-0cfd5153502a', 8, 40.0, NULL, false, '40') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ba8c082a-9172-5314-8227-0cfd5153502a', 9, 37.0, NULL, false, '37') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '081d3821-0950-5887-aa86-fe6a16ed3795', '13035f58-82f2-5cdc-897b-78260ba8a376', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Bodhi Mckenzie', '963', 'individual', 40, 330.0, 287.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4d4b11bf-cfd7-5a2f-b4ea-9ef8bdcf92c1', '081d3821-0950-5887-aa86-fe6a16ed3795', '13035f58-82f2-5cdc-897b-78260ba8a376', 'Bodhi Mckenzie', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('081d3821-0950-5887-aa86-fe6a16ed3795', 1, 37.0, NULL, false, '37') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('081d3821-0950-5887-aa86-fe6a16ed3795', 2, 38.0, NULL, false, '38') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('081d3821-0950-5887-aa86-fe6a16ed3795', 3, 41.0, NULL, false, '41') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('081d3821-0950-5887-aa86-fe6a16ed3795', 4, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('081d3821-0950-5887-aa86-fe6a16ed3795', 5, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('081d3821-0950-5887-aa86-fe6a16ed3795', 6, 43.0, 'DNF', true, '(43)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('081d3821-0950-5887-aa86-fe6a16ed3795', 7, 37.0, NULL, false, '37') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('081d3821-0950-5887-aa86-fe6a16ed3795', 8, 36.0, NULL, false, '36') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('081d3821-0950-5887-aa86-fe6a16ed3795', 9, 36.0, NULL, false, '36') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'fc99b36a-4334-5749-bd5c-a09c6df17cdf', '5e989cd1-b734-5443-9d3e-ea9794a9686f', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Lauchlan Naylor', '1488', 'individual', 41, 357.0, 314.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ca0837b2-4244-5df0-82a8-32854cce8d49', 'fc99b36a-4334-5749-bd5c-a09c6df17cdf', '5e989cd1-b734-5443-9d3e-ea9794a9686f', 'Lauchlan Naylor', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fc99b36a-4334-5749-bd5c-a09c6df17cdf', 1, 43.0, 'DNC', true, '(43)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fc99b36a-4334-5749-bd5c-a09c6df17cdf', 2, 43.0, 'DNC', false, '43DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fc99b36a-4334-5749-bd5c-a09c6df17cdf', 3, 40.0, NULL, false, '40') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fc99b36a-4334-5749-bd5c-a09c6df17cdf', 4, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fc99b36a-4334-5749-bd5c-a09c6df17cdf', 5, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fc99b36a-4334-5749-bd5c-a09c6df17cdf', 6, 43.0, 'DNF', false, '43DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fc99b36a-4334-5749-bd5c-a09c6df17cdf', 7, 40.0, NULL, false, '40') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fc99b36a-4334-5749-bd5c-a09c6df17cdf', 8, 37.0, NULL, false, '37') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fc99b36a-4334-5749-bd5c-a09c6df17cdf', 9, 43.0, 'DNC', false, '43DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1b1333e8-ffce-5f54-a8a1-0a5523155d61', '7f6a70db-bca7-5a07-8a00-b233c8acd2c9', '5e65ebeb-7e99-5eb3-bdbe-97ba468d4861', 'Maisie Borg', '1590', 'individual', 42, 378.0, 335.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', 'https://sailingresults.net/sa/results/overall.aspx?ID=82277.2', '2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results', 'url', 'Official published results from 2026 Musto Australian Optimist Championship — Intermediate Fleet Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1d7f1e17-8c19-5459-a638-239dff55c9e3', '1b1333e8-ffce-5f54-a8a1-0a5523155d61', '7f6a70db-bca7-5a07-8a00-b233c8acd2c9', 'Maisie Borg', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b1333e8-ffce-5f54-a8a1-0a5523155d61', 1, 43.0, 'DNC', true, '(43)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b1333e8-ffce-5f54-a8a1-0a5523155d61', 2, 40.0, NULL, false, '40') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b1333e8-ffce-5f54-a8a1-0a5523155d61', 3, 42.0, NULL, false, '42') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b1333e8-ffce-5f54-a8a1-0a5523155d61', 4, 43.0, 'DNF', false, '43DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b1333e8-ffce-5f54-a8a1-0a5523155d61', 5, 43.0, 'UFD', false, '43UFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b1333e8-ffce-5f54-a8a1-0a5523155d61', 6, 43.0, 'DNF', false, '43DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b1333e8-ffce-5f54-a8a1-0a5523155d61', 7, 38.0, NULL, false, '38') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b1333e8-ffce-5f54-a8a1-0a5523155d61', 8, 43.0, 'DNC', false, '43DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b1333e8-ffce-5f54-a8a1-0a5523155d61', 9, 43.0, 'DNC', false, '43DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Tasmanian Optimist State Championship — Open Fleet (6 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9715eec6-c3f2-5676-a916-fd002d621b8c', 'cf486686-53b0-4c99-8231-1619dbbcb0f6', '5f48a6df-cfee-5082-9df4-ec59ea97559d', 'Cameron Underwood', '1001', 'individual', 1, 6.0, 5.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', '2026 Tasmanian Optimist State Championship Official Results', 'url', 'Official published results from 2026 Tasmanian Optimist State Championship Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6cea7642-14c3-510c-94fb-c50e771dddd4', '9715eec6-c3f2-5676-a916-fd002d621b8c', 'cf486686-53b0-4c99-8231-1619dbbcb0f6', 'Cameron Underwood', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9715eec6-c3f2-5676-a916-fd002d621b8c', 1, 1.0, NULL, true, '(1)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9715eec6-c3f2-5676-a916-fd002d621b8c', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9715eec6-c3f2-5676-a916-fd002d621b8c', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9715eec6-c3f2-5676-a916-fd002d621b8c', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9715eec6-c3f2-5676-a916-fd002d621b8c', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9715eec6-c3f2-5676-a916-fd002d621b8c', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'cdacb543-d7da-5394-9788-09bead22b55f', '2ce7f341-53ee-4434-a35f-106f45110f47', '5f48a6df-cfee-5082-9df4-ec59ea97559d', 'Thomas Pitt', '1827', 'individual', 2, 13.0, 10.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', '2026 Tasmanian Optimist State Championship Official Results', 'url', 'Official published results from 2026 Tasmanian Optimist State Championship Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '48416d23-db73-5932-afdf-9925ba20e696', 'cdacb543-d7da-5394-9788-09bead22b55f', '2ce7f341-53ee-4434-a35f-106f45110f47', 'Thomas Pitt', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cdacb543-d7da-5394-9788-09bead22b55f', 1, 3.0, NULL, true, '(3)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cdacb543-d7da-5394-9788-09bead22b55f', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cdacb543-d7da-5394-9788-09bead22b55f', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cdacb543-d7da-5394-9788-09bead22b55f', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cdacb543-d7da-5394-9788-09bead22b55f', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cdacb543-d7da-5394-9788-09bead22b55f', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '55544f07-fc68-5be9-b32f-ad66a3c587ee', 'd78e9d11-5477-5432-848b-af309c61ec2e', '5f48a6df-cfee-5082-9df4-ec59ea97559d', 'William Corkhill', '826', 'individual', 3, 20.0, 16.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', '2026 Tasmanian Optimist State Championship Official Results', 'url', 'Official published results from 2026 Tasmanian Optimist State Championship Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '82b6570f-0fbd-519d-bfb7-d35e4a3b8f59', '55544f07-fc68-5be9-b32f-ad66a3c587ee', 'd78e9d11-5477-5432-848b-af309c61ec2e', 'William Corkhill', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55544f07-fc68-5be9-b32f-ad66a3c587ee', 1, 4.0, NULL, true, '(4)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55544f07-fc68-5be9-b32f-ad66a3c587ee', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55544f07-fc68-5be9-b32f-ad66a3c587ee', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55544f07-fc68-5be9-b32f-ad66a3c587ee', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55544f07-fc68-5be9-b32f-ad66a3c587ee', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55544f07-fc68-5be9-b32f-ad66a3c587ee', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'bba272c1-2a53-5106-993d-8740fdb37742', '6bb53a1d-beec-5217-a6bb-996c0f92b13f', '5f48a6df-cfee-5082-9df4-ec59ea97559d', 'William James', '828', 'individual', 4, 25.0, 20.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', '2026 Tasmanian Optimist State Championship Official Results', 'url', 'Official published results from 2026 Tasmanian Optimist State Championship Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '95e37f9d-8223-5146-a029-bb05e3177e4a', 'bba272c1-2a53-5106-993d-8740fdb37742', '6bb53a1d-beec-5217-a6bb-996c0f92b13f', 'William James', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bba272c1-2a53-5106-993d-8740fdb37742', 1, 5.0, NULL, true, '(5)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bba272c1-2a53-5106-993d-8740fdb37742', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bba272c1-2a53-5106-993d-8740fdb37742', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bba272c1-2a53-5106-993d-8740fdb37742', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bba272c1-2a53-5106-993d-8740fdb37742', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bba272c1-2a53-5106-993d-8740fdb37742', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '464a15a0-2986-5d7a-8795-979f7dcfb1e2', '8f29ffb3-a556-46c9-82c5-4b20f6d75356', '5f48a6df-cfee-5082-9df4-ec59ea97559d', 'Xavier James', '999', 'individual', 5, 28.0, 21.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', '2026 Tasmanian Optimist State Championship Official Results', 'url', 'Official published results from 2026 Tasmanian Optimist State Championship Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '45493412-6a23-5eb8-a90b-e73605d521f6', '464a15a0-2986-5d7a-8795-979f7dcfb1e2', '8f29ffb3-a556-46c9-82c5-4b20f6d75356', 'Xavier James', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('464a15a0-2986-5d7a-8795-979f7dcfb1e2', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('464a15a0-2986-5d7a-8795-979f7dcfb1e2', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('464a15a0-2986-5d7a-8795-979f7dcfb1e2', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('464a15a0-2986-5d7a-8795-979f7dcfb1e2', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('464a15a0-2986-5d7a-8795-979f7dcfb1e2', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('464a15a0-2986-5d7a-8795-979f7dcfb1e2', 6, 7.0, 'DNF', true, '(7)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'fed403b6-76a8-531c-b06c-ed9261b2b1ab', '104a8fa8-d159-48c4-b4a2-d70dd7eec5d1', '5f48a6df-cfee-5082-9df4-ec59ea97559d', 'Angus Johnston', '1670', 'individual', 6, 42.0, 35.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', '2026 Tasmanian Optimist State Championship Official Results', 'url', 'Official published results from 2026 Tasmanian Optimist State Championship Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '92b9bd09-1e60-5375-ab03-cf087bdc0415', 'fed403b6-76a8-531c-b06c-ed9261b2b1ab', '104a8fa8-d159-48c4-b4a2-d70dd7eec5d1', 'Angus Johnston', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fed403b6-76a8-531c-b06c-ed9261b2b1ab', 1, 7.0, 'DNC', true, '(7)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fed403b6-76a8-531c-b06c-ed9261b2b1ab', 2, 7.0, 'DNC', false, '7DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fed403b6-76a8-531c-b06c-ed9261b2b1ab', 3, 7.0, 'DNC', false, '7DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fed403b6-76a8-531c-b06c-ed9261b2b1ab', 4, 7.0, 'DNC', false, '7DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fed403b6-76a8-531c-b06c-ed9261b2b1ab', 5, 7.0, 'DNC', false, '7DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fed403b6-76a8-531c-b06c-ed9261b2b1ab', 6, 7.0, 'DNC', false, '7DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Tasmanian Optimist State Championship — Intermediate Fleet (6 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f27982e3-6cce-5bf3-9f60-475cfbdac1e4', '1f83d34f-3841-534a-b7ff-6f06e614de9a', '7cafc90f-d7b9-528e-bab7-62f8769fb7f5', 'Jonathan Molloy', '1599', 'individual', 1, 12.0, 7.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', '2026 Tasmanian Optimist State Championship Official Results', 'url', 'Official published results from 2026 Tasmanian Optimist State Championship Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '00f6a16c-eb70-5709-9d70-417d2e172586', 'f27982e3-6cce-5bf3-9f60-475cfbdac1e4', '1f83d34f-3841-534a-b7ff-6f06e614de9a', 'Jonathan Molloy', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f27982e3-6cce-5bf3-9f60-475cfbdac1e4', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f27982e3-6cce-5bf3-9f60-475cfbdac1e4', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f27982e3-6cce-5bf3-9f60-475cfbdac1e4', 3, 5.0, NULL, true, '(5)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f27982e3-6cce-5bf3-9f60-475cfbdac1e4', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f27982e3-6cce-5bf3-9f60-475cfbdac1e4', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f27982e3-6cce-5bf3-9f60-475cfbdac1e4', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c3f5f2e4-23d5-5437-92c3-40c6bcd95d39', '53113747-4b64-5bb9-8aca-f3a415600d66', '7cafc90f-d7b9-528e-bab7-62f8769fb7f5', 'Lottie Bown', '1090', 'individual', 2, 18.0, 13.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', '2026 Tasmanian Optimist State Championship Official Results', 'url', 'Official published results from 2026 Tasmanian Optimist State Championship Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '46f7ec03-9f2a-50bf-b3a7-b4c8c2fed8b2', 'c3f5f2e4-23d5-5437-92c3-40c6bcd95d39', '53113747-4b64-5bb9-8aca-f3a415600d66', 'Lottie Bown', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3f5f2e4-23d5-5437-92c3-40c6bcd95d39', 1, 5.0, NULL, true, '(5)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3f5f2e4-23d5-5437-92c3-40c6bcd95d39', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3f5f2e4-23d5-5437-92c3-40c6bcd95d39', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3f5f2e4-23d5-5437-92c3-40c6bcd95d39', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3f5f2e4-23d5-5437-92c3-40c6bcd95d39', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3f5f2e4-23d5-5437-92c3-40c6bcd95d39', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd0de740b-ed9f-5820-b889-92e154feb25c', '685e8339-e2cf-50f4-bd0a-acd4a3a0f9d5', '7cafc90f-d7b9-528e-bab7-62f8769fb7f5', 'Olive Alden', '824', 'individual', 3, 21.0, 14.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', '2026 Tasmanian Optimist State Championship Official Results', 'url', 'Official published results from 2026 Tasmanian Optimist State Championship Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'efca7006-8d7c-5279-8eea-f959d0b85073', 'd0de740b-ed9f-5820-b889-92e154feb25c', '685e8339-e2cf-50f4-bd0a-acd4a3a0f9d5', 'Olive Alden', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d0de740b-ed9f-5820-b889-92e154feb25c', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d0de740b-ed9f-5820-b889-92e154feb25c', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d0de740b-ed9f-5820-b889-92e154feb25c', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d0de740b-ed9f-5820-b889-92e154feb25c', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d0de740b-ed9f-5820-b889-92e154feb25c', 5, 7.0, 'DNF', true, '(7)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d0de740b-ed9f-5820-b889-92e154feb25c', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a0e14f96-94ac-5b7f-b947-28bad3885f82', '8b8d96f4-d1cc-5cff-a6dd-934378c3051b', '7cafc90f-d7b9-528e-bab7-62f8769fb7f5', 'Leonardo Demangone', '1299', 'individual', 4, 24.0, 17.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', '2026 Tasmanian Optimist State Championship Official Results', 'url', 'Official published results from 2026 Tasmanian Optimist State Championship Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c5c2efe9-6420-5f99-8961-544e5a0265a7', 'a0e14f96-94ac-5b7f-b947-28bad3885f82', '8b8d96f4-d1cc-5cff-a6dd-934378c3051b', 'Leonardo Demangone', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0e14f96-94ac-5b7f-b947-28bad3885f82', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0e14f96-94ac-5b7f-b947-28bad3885f82', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0e14f96-94ac-5b7f-b947-28bad3885f82', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0e14f96-94ac-5b7f-b947-28bad3885f82', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0e14f96-94ac-5b7f-b947-28bad3885f82', 5, 7.0, 'DNF', true, '(7)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0e14f96-94ac-5b7f-b947-28bad3885f82', 6, 7.0, 'DNF', false, '7DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8985d6b6-cca3-5f4d-b861-828f7e587985', '91b00521-c967-5967-a5d6-28f47904e434', '7cafc90f-d7b9-528e-bab7-62f8769fb7f5', 'Charlie Ryan', '993', 'individual', 5, 25.0, 18.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', '2026 Tasmanian Optimist State Championship Official Results', 'url', 'Official published results from 2026 Tasmanian Optimist State Championship Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b35ea69e-2ac3-5ad8-a0ff-a9b6a087fe56', '8985d6b6-cca3-5f4d-b861-828f7e587985', '91b00521-c967-5967-a5d6-28f47904e434', 'Charlie Ryan', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8985d6b6-cca3-5f4d-b861-828f7e587985', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8985d6b6-cca3-5f4d-b861-828f7e587985', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8985d6b6-cca3-5f4d-b861-828f7e587985', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8985d6b6-cca3-5f4d-b861-828f7e587985', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8985d6b6-cca3-5f4d-b861-828f7e587985', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8985d6b6-cca3-5f4d-b861-828f7e587985', 6, 7.0, 'DNC', true, '(7)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0e995ef2-f35c-5035-b9a5-3ae7df51aec0', 'd2137b68-2b58-5606-a57e-0e588d879c99', '7cafc90f-d7b9-528e-bab7-62f8769fb7f5', 'Luke Bennett', '1008', 'individual', 6, 42.0, 35.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', 'https://sailingresults.net/sa/results/overall.aspx?ID=82313', '2026 Tasmanian Optimist State Championship Official Results', 'url', 'Official published results from 2026 Tasmanian Optimist State Championship Official Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'af60f6e3-1307-5380-85c1-88c204dba0e5', '0e995ef2-f35c-5035-b9a5-3ae7df51aec0', 'd2137b68-2b58-5606-a57e-0e588d879c99', 'Luke Bennett', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0e995ef2-f35c-5035-b9a5-3ae7df51aec0', 1, 7.0, 'DNC', true, '(7)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0e995ef2-f35c-5035-b9a5-3ae7df51aec0', 2, 7.0, 'DNC', false, '7DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0e995ef2-f35c-5035-b9a5-3ae7df51aec0', 3, 7.0, 'DNC', false, '7DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0e995ef2-f35c-5035-b9a5-3ae7df51aec0', 4, 7.0, 'DNC', false, '7DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0e995ef2-f35c-5035-b9a5-3ae7df51aec0', 5, 7.0, 'DNC', false, '7DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0e995ef2-f35c-5035-b9a5-3ae7df51aec0', 6, 7.0, 'DNC', false, '7DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 VIODA International Optimist Victorian & Open Championship — Open Fleet (38 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a9411ee7-8884-5fdd-9c60-08f0bb0bf86f', 'f8f1b2c8-c396-501f-a6dd-f51b6aa782d9', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Toby Phillips', '1906', 'individual', 1, 23.0, 16.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7b0980bf-7930-542d-b011-5f9db252f7e2', 'a9411ee7-8884-5fdd-9c60-08f0bb0bf86f', 'f8f1b2c8-c396-501f-a6dd-f51b6aa782d9', 'Toby Phillips', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a9411ee7-8884-5fdd-9c60-08f0bb0bf86f', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a9411ee7-8884-5fdd-9c60-08f0bb0bf86f', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a9411ee7-8884-5fdd-9c60-08f0bb0bf86f', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a9411ee7-8884-5fdd-9c60-08f0bb0bf86f', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a9411ee7-8884-5fdd-9c60-08f0bb0bf86f', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a9411ee7-8884-5fdd-9c60-08f0bb0bf86f', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a9411ee7-8884-5fdd-9c60-08f0bb0bf86f', 7, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a9411ee7-8884-5fdd-9c60-08f0bb0bf86f', 8, 7.0, NULL, true, '(7)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0ef4f6a0-c64e-578f-8117-fec4cfa7c097', '65989797-50da-4aef-88b6-47ff0e2df976', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Acklin Stent', '1907', 'individual', 2, 59.0, 35.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e9e533e8-9466-5b9e-a60f-19928932bb7c', '0ef4f6a0-c64e-578f-8117-fec4cfa7c097', '65989797-50da-4aef-88b6-47ff0e2df976', 'Acklin Stent', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0ef4f6a0-c64e-578f-8117-fec4cfa7c097', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0ef4f6a0-c64e-578f-8117-fec4cfa7c097', 2, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0ef4f6a0-c64e-578f-8117-fec4cfa7c097', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0ef4f6a0-c64e-578f-8117-fec4cfa7c097', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0ef4f6a0-c64e-578f-8117-fec4cfa7c097', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0ef4f6a0-c64e-578f-8117-fec4cfa7c097', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0ef4f6a0-c64e-578f-8117-fec4cfa7c097', 7, 24.0, NULL, true, '(24)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0ef4f6a0-c64e-578f-8117-fec4cfa7c097', 8, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7e79432b-4f26-5405-bd49-9b2ca9d2e723', '9f1d45de-707d-5b7e-a92c-e88596d5233d', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Sijia Deng', '1720', 'individual', 3, 49.0, 36.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd5d5088b-99b7-5551-b948-50d67908ff31', '7e79432b-4f26-5405-bd49-9b2ca9d2e723', '9f1d45de-707d-5b7e-a92c-e88596d5233d', 'Sijia Deng', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e79432b-4f26-5405-bd49-9b2ca9d2e723', 1, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e79432b-4f26-5405-bd49-9b2ca9d2e723', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e79432b-4f26-5405-bd49-9b2ca9d2e723', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e79432b-4f26-5405-bd49-9b2ca9d2e723', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e79432b-4f26-5405-bd49-9b2ca9d2e723', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e79432b-4f26-5405-bd49-9b2ca9d2e723', 6, 13.0, NULL, true, '(13)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e79432b-4f26-5405-bd49-9b2ca9d2e723', 7, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e79432b-4f26-5405-bd49-9b2ca9d2e723', 8, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd0d1c903-3614-5937-8462-77e7b3efc56b', '5a61d861-917e-55b9-85db-9c122fcc9183', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Luca De Giosa', '1920', 'individual', 4, 56.0, 38.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '748564c7-b437-5ff9-bc35-fc268c88e728', 'd0d1c903-3614-5937-8462-77e7b3efc56b', '5a61d861-917e-55b9-85db-9c122fcc9183', 'Luca De Giosa', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d0d1c903-3614-5937-8462-77e7b3efc56b', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d0d1c903-3614-5937-8462-77e7b3efc56b', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d0d1c903-3614-5937-8462-77e7b3efc56b', 3, 18.0, NULL, true, '(18)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d0d1c903-3614-5937-8462-77e7b3efc56b', 4, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d0d1c903-3614-5937-8462-77e7b3efc56b', 5, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d0d1c903-3614-5937-8462-77e7b3efc56b', 6, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d0d1c903-3614-5937-8462-77e7b3efc56b', 7, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d0d1c903-3614-5937-8462-77e7b3efc56b', 8, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '166a2120-b13d-5dc9-b846-7d37970d3d8e', '2e005437-68a4-51ab-bc8b-d377f51d55eb', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Balthazar Roche', '1931', 'individual', 5, 79.0, 40.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7b6bf491-b462-5029-a784-dab3d2c14c79', '166a2120-b13d-5dc9-b846-7d37970d3d8e', '2e005437-68a4-51ab-bc8b-d377f51d55eb', 'Balthazar Roche', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('166a2120-b13d-5dc9-b846-7d37970d3d8e', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('166a2120-b13d-5dc9-b846-7d37970d3d8e', 2, 39.0, 'UFD', true, '(39)UFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('166a2120-b13d-5dc9-b846-7d37970d3d8e', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('166a2120-b13d-5dc9-b846-7d37970d3d8e', 4, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('166a2120-b13d-5dc9-b846-7d37970d3d8e', 5, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('166a2120-b13d-5dc9-b846-7d37970d3d8e', 6, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('166a2120-b13d-5dc9-b846-7d37970d3d8e', 7, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('166a2120-b13d-5dc9-b846-7d37970d3d8e', 8, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '04b68c71-febd-5235-b004-d96f1c969f20', '30880421-1dc4-4a14-9c6b-8c00de39e4d8', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Tom Griffiths', '1744', 'individual', 6, 86.0, 47.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a804e3dd-ce87-54cb-bd7f-d634e5bfa3cb', '04b68c71-febd-5235-b004-d96f1c969f20', '30880421-1dc4-4a14-9c6b-8c00de39e4d8', 'Tom Griffiths', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('04b68c71-febd-5235-b004-d96f1c969f20', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('04b68c71-febd-5235-b004-d96f1c969f20', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('04b68c71-febd-5235-b004-d96f1c969f20', 3, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('04b68c71-febd-5235-b004-d96f1c969f20', 4, 39.0, 'RET', true, '(39)RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('04b68c71-febd-5235-b004-d96f1c969f20', 5, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('04b68c71-febd-5235-b004-d96f1c969f20', 6, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('04b68c71-febd-5235-b004-d96f1c969f20', 7, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('04b68c71-febd-5235-b004-d96f1c969f20', 8, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b412ec85-429c-5a1c-9aeb-408a02191dc5', '0f1eb283-e53c-533e-8113-55753e658647', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Emma Tomkins', '1781', 'individual', 7, 60.0, 48.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '90801e9d-504b-5691-b33b-57f6582d4a81', 'b412ec85-429c-5a1c-9aeb-408a02191dc5', '0f1eb283-e53c-533e-8113-55753e658647', 'Emma Tomkins', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b412ec85-429c-5a1c-9aeb-408a02191dc5', 1, 12.0, NULL, true, '(12)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b412ec85-429c-5a1c-9aeb-408a02191dc5', 2, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b412ec85-429c-5a1c-9aeb-408a02191dc5', 3, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b412ec85-429c-5a1c-9aeb-408a02191dc5', 4, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b412ec85-429c-5a1c-9aeb-408a02191dc5', 5, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b412ec85-429c-5a1c-9aeb-408a02191dc5', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b412ec85-429c-5a1c-9aeb-408a02191dc5', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b412ec85-429c-5a1c-9aeb-408a02191dc5', 8, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'eaeacc82-1105-5a55-ace0-61aa0029c740', 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Oliver Johnson', '1854', 'individual', 8, 76.0, 54.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2d094b73-c159-5066-8002-296ba6d64a81', 'eaeacc82-1105-5a55-ace0-61aa0029c740', 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81', 'Oliver Johnson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eaeacc82-1105-5a55-ace0-61aa0029c740', 1, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eaeacc82-1105-5a55-ace0-61aa0029c740', 2, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eaeacc82-1105-5a55-ace0-61aa0029c740', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eaeacc82-1105-5a55-ace0-61aa0029c740', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eaeacc82-1105-5a55-ace0-61aa0029c740', 5, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eaeacc82-1105-5a55-ace0-61aa0029c740', 6, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eaeacc82-1105-5a55-ace0-61aa0029c740', 7, 22.0, NULL, true, '(22)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eaeacc82-1105-5a55-ace0-61aa0029c740', 8, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'dba0979e-4464-598d-a1cc-b32a858a13f3', 'd710b7c6-5d97-462d-8a9b-ae37b0379f46', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Tate Cantwell', '1860', 'individual', 9, 95.0, 56.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3285c5dd-5085-51ba-837d-f4315f13719d', 'dba0979e-4464-598d-a1cc-b32a858a13f3', 'd710b7c6-5d97-462d-8a9b-ae37b0379f46', 'Tate Cantwell', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dba0979e-4464-598d-a1cc-b32a858a13f3', 1, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dba0979e-4464-598d-a1cc-b32a858a13f3', 2, 39.0, 'UFD', true, '(39)UFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dba0979e-4464-598d-a1cc-b32a858a13f3', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dba0979e-4464-598d-a1cc-b32a858a13f3', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dba0979e-4464-598d-a1cc-b32a858a13f3', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dba0979e-4464-598d-a1cc-b32a858a13f3', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dba0979e-4464-598d-a1cc-b32a858a13f3', 7, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dba0979e-4464-598d-a1cc-b32a858a13f3', 8, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd26250ab-641d-5ac4-bb03-76576eeadcf1', 'ed712766-f71b-5572-b169-7a88209f6507', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Sam Smith', '1870', 'individual', 10, 95.0, 72.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0f33cdd0-b4c5-5dd9-b6a2-3a9454f157b4', 'd26250ab-641d-5ac4-bb03-76576eeadcf1', 'ed712766-f71b-5572-b169-7a88209f6507', 'Sam Smith', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d26250ab-641d-5ac4-bb03-76576eeadcf1', 1, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d26250ab-641d-5ac4-bb03-76576eeadcf1', 2, 23.0, NULL, true, '(23)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d26250ab-641d-5ac4-bb03-76576eeadcf1', 3, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d26250ab-641d-5ac4-bb03-76576eeadcf1', 4, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d26250ab-641d-5ac4-bb03-76576eeadcf1', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d26250ab-641d-5ac4-bb03-76576eeadcf1', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d26250ab-641d-5ac4-bb03-76576eeadcf1', 7, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d26250ab-641d-5ac4-bb03-76576eeadcf1', 8, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd11da3d8-8a07-58b9-b0f7-8ab10b3ce28e', '8a0f7357-41e8-4de1-bf45-1353aaa660b0', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Myles Phillips', '1523', 'individual', 11, 90.0, 74.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0b131f37-0ba6-537d-9581-e24fd64d5e92', 'd11da3d8-8a07-58b9-b0f7-8ab10b3ce28e', '8a0f7357-41e8-4de1-bf45-1353aaa660b0', 'Myles Phillips', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d11da3d8-8a07-58b9-b0f7-8ab10b3ce28e', 1, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d11da3d8-8a07-58b9-b0f7-8ab10b3ce28e', 2, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d11da3d8-8a07-58b9-b0f7-8ab10b3ce28e', 3, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d11da3d8-8a07-58b9-b0f7-8ab10b3ce28e', 4, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d11da3d8-8a07-58b9-b0f7-8ab10b3ce28e', 5, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d11da3d8-8a07-58b9-b0f7-8ab10b3ce28e', 6, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d11da3d8-8a07-58b9-b0f7-8ab10b3ce28e', 7, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d11da3d8-8a07-58b9-b0f7-8ab10b3ce28e', 8, 16.0, NULL, true, '(16)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3743dcdb-aab9-57fe-a1b2-cb101a87a00b', '7b929e9d-7925-4705-94ab-d175a82bb610', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Kalle Gravare', '1929', 'individual', 12, 98.0, 75.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8d9cb76d-5d07-58f5-b3fd-4de17f4d9b4a', '3743dcdb-aab9-57fe-a1b2-cb101a87a00b', '7b929e9d-7925-4705-94ab-d175a82bb610', 'Kalle Gravare', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3743dcdb-aab9-57fe-a1b2-cb101a87a00b', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3743dcdb-aab9-57fe-a1b2-cb101a87a00b', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3743dcdb-aab9-57fe-a1b2-cb101a87a00b', 3, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3743dcdb-aab9-57fe-a1b2-cb101a87a00b', 4, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3743dcdb-aab9-57fe-a1b2-cb101a87a00b', 5, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3743dcdb-aab9-57fe-a1b2-cb101a87a00b', 6, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3743dcdb-aab9-57fe-a1b2-cb101a87a00b', 7, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3743dcdb-aab9-57fe-a1b2-cb101a87a00b', 8, 23.0, NULL, true, '(23)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '65caab45-02bd-5eee-9de9-0b133caa01c1', 'f26ce470-48a0-419e-967e-b1e936dad712', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Lavinia Liu', '1866', 'individual', 13, 105.0, 86.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5a112076-922b-51f6-9a51-17d5c0704975', '65caab45-02bd-5eee-9de9-0b133caa01c1', 'f26ce470-48a0-419e-967e-b1e936dad712', 'Lavinia Liu', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('65caab45-02bd-5eee-9de9-0b133caa01c1', 1, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('65caab45-02bd-5eee-9de9-0b133caa01c1', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('65caab45-02bd-5eee-9de9-0b133caa01c1', 3, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('65caab45-02bd-5eee-9de9-0b133caa01c1', 4, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('65caab45-02bd-5eee-9de9-0b133caa01c1', 5, 19.0, NULL, true, '(19)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('65caab45-02bd-5eee-9de9-0b133caa01c1', 6, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('65caab45-02bd-5eee-9de9-0b133caa01c1', 7, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('65caab45-02bd-5eee-9de9-0b133caa01c1', 8, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c8cfe84d-ca90-53d7-abb8-8ef33008688f', 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Oliver Morris', '1822', 'individual', 14, 119.0, 94.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6b74d91d-3a1d-5f3c-b40f-186d6dac3a99', 'c8cfe84d-ca90-53d7-abb8-8ef33008688f', 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8', 'Oliver Morris', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c8cfe84d-ca90-53d7-abb8-8ef33008688f', 1, 25.0, NULL, true, '(25)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c8cfe84d-ca90-53d7-abb8-8ef33008688f', 2, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c8cfe84d-ca90-53d7-abb8-8ef33008688f', 3, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c8cfe84d-ca90-53d7-abb8-8ef33008688f', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c8cfe84d-ca90-53d7-abb8-8ef33008688f', 5, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c8cfe84d-ca90-53d7-abb8-8ef33008688f', 6, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c8cfe84d-ca90-53d7-abb8-8ef33008688f', 7, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c8cfe84d-ca90-53d7-abb8-8ef33008688f', 8, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c1ce42e1-95e4-536a-b2d4-85e9a6f61abc', '6e620e7e-5678-525f-8760-caaacf2266a9', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Emerald Jacobsen', '1846', 'individual', 15, 118.0, 95.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1ae3cf27-9b91-52dc-9d6b-5252ef984c17', 'c1ce42e1-95e4-536a-b2d4-85e9a6f61abc', '6e620e7e-5678-525f-8760-caaacf2266a9', 'Emerald Jacobsen', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c1ce42e1-95e4-536a-b2d4-85e9a6f61abc', 1, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c1ce42e1-95e4-536a-b2d4-85e9a6f61abc', 2, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c1ce42e1-95e4-536a-b2d4-85e9a6f61abc', 3, 23.0, NULL, true, '(23)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c1ce42e1-95e4-536a-b2d4-85e9a6f61abc', 4, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c1ce42e1-95e4-536a-b2d4-85e9a6f61abc', 5, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c1ce42e1-95e4-536a-b2d4-85e9a6f61abc', 6, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c1ce42e1-95e4-536a-b2d4-85e9a6f61abc', 7, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c1ce42e1-95e4-536a-b2d4-85e9a6f61abc', 8, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b9330077-00a8-5e66-9bbf-ae3464426ca7', '747fa344-5126-4ba1-a876-470a982620c7', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Shin Lin Chen Rui', '3333', 'individual', 16, 120.0, 99.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fb2fbb55-b4a6-5c8d-87c8-f71ad5d6a9f4', 'b9330077-00a8-5e66-9bbf-ae3464426ca7', '747fa344-5126-4ba1-a876-470a982620c7', 'Shin Lin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9330077-00a8-5e66-9bbf-ae3464426ca7', 1, 21.0, NULL, true, '(21)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9330077-00a8-5e66-9bbf-ae3464426ca7', 2, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9330077-00a8-5e66-9bbf-ae3464426ca7', 3, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9330077-00a8-5e66-9bbf-ae3464426ca7', 4, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9330077-00a8-5e66-9bbf-ae3464426ca7', 5, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9330077-00a8-5e66-9bbf-ae3464426ca7', 6, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9330077-00a8-5e66-9bbf-ae3464426ca7', 7, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9330077-00a8-5e66-9bbf-ae3464426ca7', 8, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '842e6d3c-a631-5a83-a6be-7fc7a77b0303', 'a08688e8-35e4-4ca6-9574-bd909c551806', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Stirling Marshall', '1844', 'individual', 17, 134.0, 104.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a50e3592-ac72-5696-9936-a506651965f4', '842e6d3c-a631-5a83-a6be-7fc7a77b0303', 'a08688e8-35e4-4ca6-9574-bd909c551806', 'Stirling Marshall', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('842e6d3c-a631-5a83-a6be-7fc7a77b0303', 1, 30.0, NULL, true, '(30)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('842e6d3c-a631-5a83-a6be-7fc7a77b0303', 2, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('842e6d3c-a631-5a83-a6be-7fc7a77b0303', 3, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('842e6d3c-a631-5a83-a6be-7fc7a77b0303', 4, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('842e6d3c-a631-5a83-a6be-7fc7a77b0303', 5, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('842e6d3c-a631-5a83-a6be-7fc7a77b0303', 6, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('842e6d3c-a631-5a83-a6be-7fc7a77b0303', 7, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('842e6d3c-a631-5a83-a6be-7fc7a77b0303', 8, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '4f03e3b0-e50c-577e-a219-542fc2d98343', '0ea521ac-cf94-4f05-bd88-32e0d04c1579', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Fred Cantwell', '1859', 'individual', 18, 135.0, 110.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bd9933b9-2327-5f23-b321-99f4ef0af469', '4f03e3b0-e50c-577e-a219-542fc2d98343', '0ea521ac-cf94-4f05-bd88-32e0d04c1579', 'Fred Cantwell', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f03e3b0-e50c-577e-a219-542fc2d98343', 1, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f03e3b0-e50c-577e-a219-542fc2d98343', 2, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f03e3b0-e50c-577e-a219-542fc2d98343', 3, 25.0, NULL, true, '(25)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f03e3b0-e50c-577e-a219-542fc2d98343', 4, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f03e3b0-e50c-577e-a219-542fc2d98343', 5, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f03e3b0-e50c-577e-a219-542fc2d98343', 6, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f03e3b0-e50c-577e-a219-542fc2d98343', 7, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f03e3b0-e50c-577e-a219-542fc2d98343', 8, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3740403d-475e-5287-ab2b-77ca7527a77b', '471b461c-5c75-57ae-b96d-5ecf09e15791', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'William Rose', '1447', 'individual', 19, 134.0, 111.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f03df2e1-6a76-5e49-8f02-4155afd0256c', '3740403d-475e-5287-ab2b-77ca7527a77b', '471b461c-5c75-57ae-b96d-5ecf09e15791', 'William Rose', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3740403d-475e-5287-ab2b-77ca7527a77b', 1, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3740403d-475e-5287-ab2b-77ca7527a77b', 2, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3740403d-475e-5287-ab2b-77ca7527a77b', 3, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3740403d-475e-5287-ab2b-77ca7527a77b', 4, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3740403d-475e-5287-ab2b-77ca7527a77b', 5, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3740403d-475e-5287-ab2b-77ca7527a77b', 6, 23.0, NULL, true, '(23)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3740403d-475e-5287-ab2b-77ca7527a77b', 7, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3740403d-475e-5287-ab2b-77ca7527a77b', 8, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'fb51b92f-1ab6-5fa0-8b83-2bae9ee955ba', 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Joy Cheuk Yee Shen', '921', 'individual', 20, 140.0, 119.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f6bc17c6-753b-5892-af5c-e8009ccfe775', 'fb51b92f-1ab6-5fa0-8b83-2bae9ee955ba', 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f', 'Joy Cheuk Yee Shen', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fb51b92f-1ab6-5fa0-8b83-2bae9ee955ba', 1, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fb51b92f-1ab6-5fa0-8b83-2bae9ee955ba', 2, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fb51b92f-1ab6-5fa0-8b83-2bae9ee955ba', 3, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fb51b92f-1ab6-5fa0-8b83-2bae9ee955ba', 4, 21.0, NULL, true, '(21)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fb51b92f-1ab6-5fa0-8b83-2bae9ee955ba', 5, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fb51b92f-1ab6-5fa0-8b83-2bae9ee955ba', 6, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fb51b92f-1ab6-5fa0-8b83-2bae9ee955ba', 7, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fb51b92f-1ab6-5fa0-8b83-2bae9ee955ba', 8, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9d6a2c82-76a1-53ac-9ecb-7d147f8423fa', '35f3c2cb-2ced-494d-aa27-c5f0cf3193dd', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Erik Rydin', '506', 'individual', 21, 155.0, 124.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '85df8b96-37ba-594f-96c8-aabd99e1c2d1', '9d6a2c82-76a1-53ac-9ecb-7d147f8423fa', '35f3c2cb-2ced-494d-aa27-c5f0cf3193dd', 'Erik Rydin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9d6a2c82-76a1-53ac-9ecb-7d147f8423fa', 1, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9d6a2c82-76a1-53ac-9ecb-7d147f8423fa', 2, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9d6a2c82-76a1-53ac-9ecb-7d147f8423fa', 3, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9d6a2c82-76a1-53ac-9ecb-7d147f8423fa', 4, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9d6a2c82-76a1-53ac-9ecb-7d147f8423fa', 5, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9d6a2c82-76a1-53ac-9ecb-7d147f8423fa', 6, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9d6a2c82-76a1-53ac-9ecb-7d147f8423fa', 7, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9d6a2c82-76a1-53ac-9ecb-7d147f8423fa', 8, 31.0, NULL, true, '(31)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0858b36e-a887-559a-b839-c1ef72332a46', 'afb1dbf7-00c9-4033-94d3-5259920e3d94', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Jessica Higgins', '1885', 'individual', 22, 171.0, 134.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f7da7c34-364b-5472-86f4-d266545f8361', '0858b36e-a887-559a-b839-c1ef72332a46', 'afb1dbf7-00c9-4033-94d3-5259920e3d94', 'Jessica Higgins', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0858b36e-a887-559a-b839-c1ef72332a46', 1, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0858b36e-a887-559a-b839-c1ef72332a46', 2, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0858b36e-a887-559a-b839-c1ef72332a46', 3, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0858b36e-a887-559a-b839-c1ef72332a46', 4, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0858b36e-a887-559a-b839-c1ef72332a46', 5, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0858b36e-a887-559a-b839-c1ef72332a46', 6, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0858b36e-a887-559a-b839-c1ef72332a46', 7, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0858b36e-a887-559a-b839-c1ef72332a46', 8, 37.0, NULL, true, '(37)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8a874df2-e664-5a7e-94f2-cf09ac2346a8', '3079ace8-c905-42fb-b258-bbb7d13b299c', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Harry Creak', '1383', 'individual', 23, 181.0, 146.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4901e1db-161b-5465-97d2-8683635fa413', '8a874df2-e664-5a7e-94f2-cf09ac2346a8', '3079ace8-c905-42fb-b258-bbb7d13b299c', 'Harry Creak', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a874df2-e664-5a7e-94f2-cf09ac2346a8', 1, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a874df2-e664-5a7e-94f2-cf09ac2346a8', 2, 35.0, NULL, true, '(35)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a874df2-e664-5a7e-94f2-cf09ac2346a8', 3, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a874df2-e664-5a7e-94f2-cf09ac2346a8', 4, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a874df2-e664-5a7e-94f2-cf09ac2346a8', 5, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a874df2-e664-5a7e-94f2-cf09ac2346a8', 6, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a874df2-e664-5a7e-94f2-cf09ac2346a8', 7, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a874df2-e664-5a7e-94f2-cf09ac2346a8', 8, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'fdeb43fc-0a91-5667-8e19-d85658bdbad8', '16b59fff-e224-4eb6-b839-ea5ff1482211', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Theo Altson', '1801', 'individual', 24, 184.0, 154.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1b3e58e1-620d-55f7-b78f-ee716c79af8e', 'fdeb43fc-0a91-5667-8e19-d85658bdbad8', '16b59fff-e224-4eb6-b839-ea5ff1482211', 'Theo Altson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fdeb43fc-0a91-5667-8e19-d85658bdbad8', 1, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fdeb43fc-0a91-5667-8e19-d85658bdbad8', 2, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fdeb43fc-0a91-5667-8e19-d85658bdbad8', 3, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fdeb43fc-0a91-5667-8e19-d85658bdbad8', 4, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fdeb43fc-0a91-5667-8e19-d85658bdbad8', 5, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fdeb43fc-0a91-5667-8e19-d85658bdbad8', 6, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fdeb43fc-0a91-5667-8e19-d85658bdbad8', 7, 30.0, NULL, true, '(30)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fdeb43fc-0a91-5667-8e19-d85658bdbad8', 8, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd840e2be-23fd-5bc3-8f3a-2688503a7314', 'e912046c-3e11-5658-a475-acc04b70cb9a', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Jack Sturm', '1389', 'individual', 25, 208.0, 169.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f6bd5b1c-f769-5159-8c6d-cbe7d2b640a3', 'd840e2be-23fd-5bc3-8f3a-2688503a7314', 'e912046c-3e11-5658-a475-acc04b70cb9a', 'Jack Sturm', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d840e2be-23fd-5bc3-8f3a-2688503a7314', 1, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d840e2be-23fd-5bc3-8f3a-2688503a7314', 2, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d840e2be-23fd-5bc3-8f3a-2688503a7314', 3, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d840e2be-23fd-5bc3-8f3a-2688503a7314', 4, 39.0, 'RET', true, '(39)RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d840e2be-23fd-5bc3-8f3a-2688503a7314', 5, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d840e2be-23fd-5bc3-8f3a-2688503a7314', 6, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d840e2be-23fd-5bc3-8f3a-2688503a7314', 7, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d840e2be-23fd-5bc3-8f3a-2688503a7314', 8, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '4a9960a6-e215-563c-9305-9e7c4b32c3ed', 'e461cef9-b775-4d3d-9836-2c78f7b8815c', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Edward Brown', '777', 'individual', 26, 213.0, 174.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9a27e359-93e1-57c3-83ec-407de02bc3ab', '4a9960a6-e215-563c-9305-9e7c4b32c3ed', 'e461cef9-b775-4d3d-9836-2c78f7b8815c', 'Edward Brown', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a9960a6-e215-563c-9305-9e7c4b32c3ed', 1, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a9960a6-e215-563c-9305-9e7c4b32c3ed', 2, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a9960a6-e215-563c-9305-9e7c4b32c3ed', 3, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a9960a6-e215-563c-9305-9e7c4b32c3ed', 4, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a9960a6-e215-563c-9305-9e7c4b32c3ed', 5, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a9960a6-e215-563c-9305-9e7c4b32c3ed', 6, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a9960a6-e215-563c-9305-9e7c4b32c3ed', 7, 39.0, 'RET', true, '(39)RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a9960a6-e215-563c-9305-9e7c4b32c3ed', 8, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'bb8db409-3593-5252-8ba6-c4821aee29d3', '434b1159-f466-49dc-b20c-aef801b6350a', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Dan Toh Guan You', '3811', 'individual', 27, 216.0, 181.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6662504b-b24c-566b-bfca-5c7133ac5e85', 'bb8db409-3593-5252-8ba6-c4821aee29d3', '434b1159-f466-49dc-b20c-aef801b6350a', 'Dan Toh', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb8db409-3593-5252-8ba6-c4821aee29d3', 1, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb8db409-3593-5252-8ba6-c4821aee29d3', 2, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb8db409-3593-5252-8ba6-c4821aee29d3', 3, 35.0, NULL, true, '(35)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb8db409-3593-5252-8ba6-c4821aee29d3', 4, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb8db409-3593-5252-8ba6-c4821aee29d3', 5, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb8db409-3593-5252-8ba6-c4821aee29d3', 6, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb8db409-3593-5252-8ba6-c4821aee29d3', 7, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb8db409-3593-5252-8ba6-c4821aee29d3', 8, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '63df910f-7bbe-5b4e-a17f-c2f32716a4cb', '7ab25378-ed5a-5311-9841-0bf0891850ed', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Tyler Deeth', '859', 'individual', 28, 226.0, 187.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '49b79848-e0a6-56b4-8435-5a043eeaef03', '63df910f-7bbe-5b4e-a17f-c2f32716a4cb', '7ab25378-ed5a-5311-9841-0bf0891850ed', 'Tyler Deeth', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63df910f-7bbe-5b4e-a17f-c2f32716a4cb', 1, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63df910f-7bbe-5b4e-a17f-c2f32716a4cb', 2, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63df910f-7bbe-5b4e-a17f-c2f32716a4cb', 3, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63df910f-7bbe-5b4e-a17f-c2f32716a4cb', 4, 39.0, 'RET', true, '(39)RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63df910f-7bbe-5b4e-a17f-c2f32716a4cb', 5, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63df910f-7bbe-5b4e-a17f-c2f32716a4cb', 6, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63df910f-7bbe-5b4e-a17f-c2f32716a4cb', 7, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63df910f-7bbe-5b4e-a17f-c2f32716a4cb', 8, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '17f7127e-ca5c-5a33-b873-0578c646569f', 'dc9037eb-9773-5609-b677-013904a333c6', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Ollie Walstab', '1850', 'individual', 29, 227.0, 193.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '13df0bca-37c3-523e-8baf-d6e128544166', '17f7127e-ca5c-5a33-b873-0578c646569f', 'dc9037eb-9773-5609-b677-013904a333c6', 'Ollie Walstab', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('17f7127e-ca5c-5a33-b873-0578c646569f', 1, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('17f7127e-ca5c-5a33-b873-0578c646569f', 2, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('17f7127e-ca5c-5a33-b873-0578c646569f', 3, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('17f7127e-ca5c-5a33-b873-0578c646569f', 4, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('17f7127e-ca5c-5a33-b873-0578c646569f', 5, 34.0, NULL, true, '(34)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('17f7127e-ca5c-5a33-b873-0578c646569f', 6, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('17f7127e-ca5c-5a33-b873-0578c646569f', 7, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('17f7127e-ca5c-5a33-b873-0578c646569f', 8, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ce137d22-97f2-5cde-bb08-67c20081f713', 'a20a9c8a-a4a9-5523-a08f-46e75fab4812', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Bibi Stigter', '1012', 'individual', 30, 231.0, 197.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c017a8cc-8dd1-5672-ac8c-4faeb44422ed', 'ce137d22-97f2-5cde-bb08-67c20081f713', 'a20a9c8a-a4a9-5523-a08f-46e75fab4812', 'Bibi Stigter', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ce137d22-97f2-5cde-bb08-67c20081f713', 1, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ce137d22-97f2-5cde-bb08-67c20081f713', 2, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ce137d22-97f2-5cde-bb08-67c20081f713', 3, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ce137d22-97f2-5cde-bb08-67c20081f713', 4, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ce137d22-97f2-5cde-bb08-67c20081f713', 5, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ce137d22-97f2-5cde-bb08-67c20081f713', 6, 34.0, NULL, true, '(34)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ce137d22-97f2-5cde-bb08-67c20081f713', 7, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ce137d22-97f2-5cde-bb08-67c20081f713', 8, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '4992758c-aed9-5d5a-8201-ab829761577d', '888d0e66-7810-52a3-859d-e4bcaf6b9b38', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Louis Davis', '732', 'individual', 31, 238.0, 199.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '02c15fc1-8ba9-5c60-9722-456634b1e97d', '4992758c-aed9-5d5a-8201-ab829761577d', '888d0e66-7810-52a3-859d-e4bcaf6b9b38', 'Louis Davis', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4992758c-aed9-5d5a-8201-ab829761577d', 1, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4992758c-aed9-5d5a-8201-ab829761577d', 2, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4992758c-aed9-5d5a-8201-ab829761577d', 3, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4992758c-aed9-5d5a-8201-ab829761577d', 4, 39.0, 'RET', true, '(39)RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4992758c-aed9-5d5a-8201-ab829761577d', 5, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4992758c-aed9-5d5a-8201-ab829761577d', 6, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4992758c-aed9-5d5a-8201-ab829761577d', 7, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4992758c-aed9-5d5a-8201-ab829761577d', 8, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a7531afb-76dc-563b-a3cb-f0587332878a', '3895ee0b-423d-54b2-ab8b-ed51a60f50a6', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Aubrey Tan', '1111', 'individual', 32, 243.0, 204.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1daec8f0-7b9a-5868-87a2-f6c360455371', 'a7531afb-76dc-563b-a3cb-f0587332878a', '3895ee0b-423d-54b2-ab8b-ed51a60f50a6', 'Aubrey Tan', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a7531afb-76dc-563b-a3cb-f0587332878a', 1, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a7531afb-76dc-563b-a3cb-f0587332878a', 2, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a7531afb-76dc-563b-a3cb-f0587332878a', 3, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a7531afb-76dc-563b-a3cb-f0587332878a', 4, 39.0, 'RET', true, '(39)RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a7531afb-76dc-563b-a3cb-f0587332878a', 5, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a7531afb-76dc-563b-a3cb-f0587332878a', 6, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a7531afb-76dc-563b-a3cb-f0587332878a', 7, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a7531afb-76dc-563b-a3cb-f0587332878a', 8, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '99d58b64-d7ad-5852-a42b-89e39a0f71c1', '8c844476-f530-577e-be42-e594122444d8', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Finley Insermini', '1177', 'individual', 33, 241.0, 207.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '123fc26f-5a60-5dd3-b20f-da0bac32408b', '99d58b64-d7ad-5852-a42b-89e39a0f71c1', '8c844476-f530-577e-be42-e594122444d8', 'Finley Insermini', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99d58b64-d7ad-5852-a42b-89e39a0f71c1', 1, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99d58b64-d7ad-5852-a42b-89e39a0f71c1', 2, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99d58b64-d7ad-5852-a42b-89e39a0f71c1', 3, 34.0, NULL, true, '(34)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99d58b64-d7ad-5852-a42b-89e39a0f71c1', 4, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99d58b64-d7ad-5852-a42b-89e39a0f71c1', 5, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99d58b64-d7ad-5852-a42b-89e39a0f71c1', 6, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99d58b64-d7ad-5852-a42b-89e39a0f71c1', 7, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99d58b64-d7ad-5852-a42b-89e39a0f71c1', 8, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '212bd4e2-978e-53b0-9f42-bd2877b1c818', '3c97fe63-4ee9-5cbc-b588-9bad9f7b7fe1', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Sebastian Moore', '1082', 'individual', 34, 249.0, 212.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2d6b4f97-b0e0-5509-9cfa-4cfdab829e23', '212bd4e2-978e-53b0-9f42-bd2877b1c818', '3c97fe63-4ee9-5cbc-b588-9bad9f7b7fe1', 'Sebastian Moore', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('212bd4e2-978e-53b0-9f42-bd2877b1c818', 1, 37.0, NULL, true, '(37)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('212bd4e2-978e-53b0-9f42-bd2877b1c818', 2, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('212bd4e2-978e-53b0-9f42-bd2877b1c818', 3, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('212bd4e2-978e-53b0-9f42-bd2877b1c818', 4, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('212bd4e2-978e-53b0-9f42-bd2877b1c818', 5, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('212bd4e2-978e-53b0-9f42-bd2877b1c818', 6, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('212bd4e2-978e-53b0-9f42-bd2877b1c818', 7, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('212bd4e2-978e-53b0-9f42-bd2877b1c818', 8, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2cb4e732-eb07-5375-8536-9e41f4d0b50a', '71010fdd-6c88-5e28-b9aa-5a1648dbe7b5', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Anne Edwards', '1269', 'individual', 35, 267.0, 228.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bdd3650b-03f0-5252-8c58-5d01b499bd39', '2cb4e732-eb07-5375-8536-9e41f4d0b50a', '71010fdd-6c88-5e28-b9aa-5a1648dbe7b5', 'Anne Edwards', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2cb4e732-eb07-5375-8536-9e41f4d0b50a', 1, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2cb4e732-eb07-5375-8536-9e41f4d0b50a', 2, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2cb4e732-eb07-5375-8536-9e41f4d0b50a', 3, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2cb4e732-eb07-5375-8536-9e41f4d0b50a', 4, 39.0, 'RET', true, '(39)RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2cb4e732-eb07-5375-8536-9e41f4d0b50a', 5, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2cb4e732-eb07-5375-8536-9e41f4d0b50a', 6, 39.0, 'DNF', false, '39DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2cb4e732-eb07-5375-8536-9e41f4d0b50a', 7, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2cb4e732-eb07-5375-8536-9e41f4d0b50a', 8, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '59e6f3d0-b931-5199-9064-6de3b4507b85', '54b6d292-7c1e-4da4-990b-802e674c06e5', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'James Edwards', '1568', 'individual', 36, 277.0, 238.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4c632aec-e69c-5e3d-b72b-8a116787889e', '59e6f3d0-b931-5199-9064-6de3b4507b85', '54b6d292-7c1e-4da4-990b-802e674c06e5', 'James Edwards', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('59e6f3d0-b931-5199-9064-6de3b4507b85', 1, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('59e6f3d0-b931-5199-9064-6de3b4507b85', 2, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('59e6f3d0-b931-5199-9064-6de3b4507b85', 3, 39.0, 'DNF', true, '(39)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('59e6f3d0-b931-5199-9064-6de3b4507b85', 4, 39.0, 'RET', false, '39RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('59e6f3d0-b931-5199-9064-6de3b4507b85', 5, 39.0, 'DNF', false, '39DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('59e6f3d0-b931-5199-9064-6de3b4507b85', 6, 36.0, NULL, false, '36') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('59e6f3d0-b931-5199-9064-6de3b4507b85', 7, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('59e6f3d0-b931-5199-9064-6de3b4507b85', 8, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '97c41a73-57f7-5622-8a64-d93b597388e5', '1f3a483a-b110-567c-964e-f32063ec07c4', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'Edward Jukes', '1681', 'individual', 37, 289.0, 250.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'dc12ac4a-5c56-595f-959c-1c4efc30cd41', '97c41a73-57f7-5622-8a64-d93b597388e5', '1f3a483a-b110-567c-964e-f32063ec07c4', 'Edward Jukes', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('97c41a73-57f7-5622-8a64-d93b597388e5', 1, 36.0, NULL, false, '36') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('97c41a73-57f7-5622-8a64-d93b597388e5', 2, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('97c41a73-57f7-5622-8a64-d93b597388e5', 3, 39.0, 'RET', true, '(39)RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('97c41a73-57f7-5622-8a64-d93b597388e5', 4, 39.0, 'RET', false, '39RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('97c41a73-57f7-5622-8a64-d93b597388e5', 5, 36.0, NULL, false, '36') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('97c41a73-57f7-5622-8a64-d93b597388e5', 6, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('97c41a73-57f7-5622-8a64-d93b597388e5', 7, 39.0, 'RET', false, '39RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('97c41a73-57f7-5622-8a64-d93b597388e5', 8, 36.0, NULL, false, '36') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8652a9c9-310a-5e87-a2a3-6da30d5d9dac', '73a082e4-e3f8-48d7-a5fd-ef0f587867ea', '688ab6bd-0de5-5250-a6f4-c4b4f459af43', 'William Rogers', '1847', 'individual', 38, 312.0, 273.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3517e94f-3add-52c6-b313-d7ea1f712983', '8652a9c9-310a-5e87-a2a3-6da30d5d9dac', '73a082e4-e3f8-48d7-a5fd-ef0f587867ea', 'William Rogers', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8652a9c9-310a-5e87-a2a3-6da30d5d9dac', 1, 39.0, 'DNC', true, '(39)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8652a9c9-310a-5e87-a2a3-6da30d5d9dac', 2, 39.0, 'DNC', false, '39DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8652a9c9-310a-5e87-a2a3-6da30d5d9dac', 3, 39.0, 'DNC', false, '39DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8652a9c9-310a-5e87-a2a3-6da30d5d9dac', 4, 39.0, 'DNC', false, '39DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8652a9c9-310a-5e87-a2a3-6da30d5d9dac', 5, 39.0, 'DNC', false, '39DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8652a9c9-310a-5e87-a2a3-6da30d5d9dac', 6, 39.0, 'DNC', false, '39DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8652a9c9-310a-5e87-a2a3-6da30d5d9dac', 7, 39.0, 'DNC', false, '39DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8652a9c9-310a-5e87-a2a3-6da30d5d9dac', 8, 39.0, 'DNC', false, '39DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 VIODA International Optimist Victorian & Open Championship — Intermediate Fleet (27 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7824d557-6183-5fc3-b996-402592df69aa', '67957772-3fab-5f24-8fda-ea58259388aa', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Ace Hill', '1275', 'individual', 1, 14.0, 9.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b8278c38-3290-5ac7-afb6-350ea7c18e42', '7824d557-6183-5fc3-b996-402592df69aa', '67957772-3fab-5f24-8fda-ea58259388aa', 'Ace Hill', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7824d557-6183-5fc3-b996-402592df69aa', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7824d557-6183-5fc3-b996-402592df69aa', 2, 5.0, NULL, true, '(5)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7824d557-6183-5fc3-b996-402592df69aa', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7824d557-6183-5fc3-b996-402592df69aa', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7824d557-6183-5fc3-b996-402592df69aa', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7824d557-6183-5fc3-b996-402592df69aa', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7824d557-6183-5fc3-b996-402592df69aa', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '5da8e62c-bad2-5e0b-a5c7-c50f0dd72b9e', 'd4a93122-cac6-514d-a1c3-46a63c7aa978', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Irida Bladon', '1222', 'individual', 2, 34.0, 21.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1e0bca38-c70c-5cd6-961b-48377a58a64b', '5da8e62c-bad2-5e0b-a5c7-c50f0dd72b9e', 'd4a93122-cac6-514d-a1c3-46a63c7aa978', 'Irida Bladon', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5da8e62c-bad2-5e0b-a5c7-c50f0dd72b9e', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5da8e62c-bad2-5e0b-a5c7-c50f0dd72b9e', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5da8e62c-bad2-5e0b-a5c7-c50f0dd72b9e', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5da8e62c-bad2-5e0b-a5c7-c50f0dd72b9e', 4, 13.0, NULL, true, '(13)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5da8e62c-bad2-5e0b-a5c7-c50f0dd72b9e', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5da8e62c-bad2-5e0b-a5c7-c50f0dd72b9e', 6, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5da8e62c-bad2-5e0b-a5c7-c50f0dd72b9e', 7, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3b294597-d026-58c7-ab00-8ae38b6f966f', 'c68003c8-28d5-5806-8906-486b00a9c40b', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Hugo Jarry', '1223', 'individual', 3, 32.0, 22.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '40d5ce4e-4651-50ac-b859-430f636b6417', '3b294597-d026-58c7-ab00-8ae38b6f966f', 'c68003c8-28d5-5806-8906-486b00a9c40b', 'Hugo Jarry', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b294597-d026-58c7-ab00-8ae38b6f966f', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b294597-d026-58c7-ab00-8ae38b6f966f', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b294597-d026-58c7-ab00-8ae38b6f966f', 3, 10.0, NULL, true, '(10)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b294597-d026-58c7-ab00-8ae38b6f966f', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b294597-d026-58c7-ab00-8ae38b6f966f', 5, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b294597-d026-58c7-ab00-8ae38b6f966f', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b294597-d026-58c7-ab00-8ae38b6f966f', 7, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '12bb3a3f-460b-577b-bbfb-fc73e7a1fc6e', '1bbc2828-04a0-43b5-87eb-ef4f1e92514b', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Yasin Yusuf Yusfianshah', '3575', 'individual', 4, 31.0, 22.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0c0e9f78-0aa5-5f6b-b33a-15dce023e08c', '12bb3a3f-460b-577b-bbfb-fc73e7a1fc6e', '1bbc2828-04a0-43b5-87eb-ef4f1e92514b', 'Yasin Yusuf Yusfianshah', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('12bb3a3f-460b-577b-bbfb-fc73e7a1fc6e', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('12bb3a3f-460b-577b-bbfb-fc73e7a1fc6e', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('12bb3a3f-460b-577b-bbfb-fc73e7a1fc6e', 3, 9.0, NULL, true, '(9)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('12bb3a3f-460b-577b-bbfb-fc73e7a1fc6e', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('12bb3a3f-460b-577b-bbfb-fc73e7a1fc6e', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('12bb3a3f-460b-577b-bbfb-fc73e7a1fc6e', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('12bb3a3f-460b-577b-bbfb-fc73e7a1fc6e', 7, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b82ea7f9-b1f3-5d0e-a088-34eeca8354c1', 'ea5e20c7-4333-5864-9a24-89612a85aba2', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Hunter Bryant', '1221', 'individual', 5, 46.0, 32.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '10c0717f-f88a-5b6a-add9-e538814e572d', 'b82ea7f9-b1f3-5d0e-a088-34eeca8354c1', 'ea5e20c7-4333-5864-9a24-89612a85aba2', 'Hunter Bryant', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b82ea7f9-b1f3-5d0e-a088-34eeca8354c1', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b82ea7f9-b1f3-5d0e-a088-34eeca8354c1', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b82ea7f9-b1f3-5d0e-a088-34eeca8354c1', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b82ea7f9-b1f3-5d0e-a088-34eeca8354c1', 4, 14.0, NULL, true, '(14)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b82ea7f9-b1f3-5d0e-a088-34eeca8354c1', 5, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b82ea7f9-b1f3-5d0e-a088-34eeca8354c1', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b82ea7f9-b1f3-5d0e-a088-34eeca8354c1', 7, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '45bf4a70-c263-5742-b5a6-97c1cf3eb5ac', '9a41bcbd-ac5d-56f9-9c76-709aa5f78d69', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Grace Newitt', '1865', 'individual', 6, 50.0, 36.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3a0d305f-decb-589b-b391-5d613ed3a866', '45bf4a70-c263-5742-b5a6-97c1cf3eb5ac', '9a41bcbd-ac5d-56f9-9c76-709aa5f78d69', 'Grace Newitt', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('45bf4a70-c263-5742-b5a6-97c1cf3eb5ac', 1, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('45bf4a70-c263-5742-b5a6-97c1cf3eb5ac', 2, 14.0, NULL, true, '(14)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('45bf4a70-c263-5742-b5a6-97c1cf3eb5ac', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('45bf4a70-c263-5742-b5a6-97c1cf3eb5ac', 4, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('45bf4a70-c263-5742-b5a6-97c1cf3eb5ac', 5, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('45bf4a70-c263-5742-b5a6-97c1cf3eb5ac', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('45bf4a70-c263-5742-b5a6-97c1cf3eb5ac', 7, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'fb402fd6-e0a3-50ee-8947-1e284a6dce6d', 'f9a37376-1672-5dfb-98a2-a7e5006893d1', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Charlie Mclaren', '1398', 'individual', 7, 48.0, 36.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '63c22ead-1db6-54b1-9059-e4c3d611d847', 'fb402fd6-e0a3-50ee-8947-1e284a6dce6d', 'f9a37376-1672-5dfb-98a2-a7e5006893d1', 'Charlie Mclaren', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fb402fd6-e0a3-50ee-8947-1e284a6dce6d', 1, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fb402fd6-e0a3-50ee-8947-1e284a6dce6d', 2, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fb402fd6-e0a3-50ee-8947-1e284a6dce6d', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fb402fd6-e0a3-50ee-8947-1e284a6dce6d', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fb402fd6-e0a3-50ee-8947-1e284a6dce6d', 5, 12.0, NULL, true, '(12)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fb402fd6-e0a3-50ee-8947-1e284a6dce6d', 6, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fb402fd6-e0a3-50ee-8947-1e284a6dce6d', 7, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'adf4b09e-ed59-54ec-8500-8f3d03ac375d', 'cd626087-622a-59d5-bc80-b1ae80513b4c', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Oscar Kirby', '1758', 'individual', 8, 51.0, 39.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2ee77554-6bc0-597f-9ca7-5f680edfa979', 'adf4b09e-ed59-54ec-8500-8f3d03ac375d', 'cd626087-622a-59d5-bc80-b1ae80513b4c', 'Oscar Kirby', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('adf4b09e-ed59-54ec-8500-8f3d03ac375d', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('adf4b09e-ed59-54ec-8500-8f3d03ac375d', 2, 12.0, NULL, true, '(12)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('adf4b09e-ed59-54ec-8500-8f3d03ac375d', 3, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('adf4b09e-ed59-54ec-8500-8f3d03ac375d', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('adf4b09e-ed59-54ec-8500-8f3d03ac375d', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('adf4b09e-ed59-54ec-8500-8f3d03ac375d', 6, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('adf4b09e-ed59-54ec-8500-8f3d03ac375d', 7, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '672e2f21-2149-52f2-971f-a5b63bdc9254', '948f00d5-2133-5e3f-9704-19d73a626e57', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Patrick Moore', '1392', 'individual', 9, 62.0, 49.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd3aa42b2-bafd-5ef8-ae85-fc69c6c03042', '672e2f21-2149-52f2-971f-a5b63bdc9254', '948f00d5-2133-5e3f-9704-19d73a626e57', 'Patrick Moore', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('672e2f21-2149-52f2-971f-a5b63bdc9254', 1, 13.0, NULL, true, '(13)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('672e2f21-2149-52f2-971f-a5b63bdc9254', 2, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('672e2f21-2149-52f2-971f-a5b63bdc9254', 3, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('672e2f21-2149-52f2-971f-a5b63bdc9254', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('672e2f21-2149-52f2-971f-a5b63bdc9254', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('672e2f21-2149-52f2-971f-a5b63bdc9254', 6, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('672e2f21-2149-52f2-971f-a5b63bdc9254', 7, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1052f4b5-baaa-5e14-a1bd-ace3ff05f1ea', 'cdffbdbb-edfd-5404-b65a-24ba2a5ad8da', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Clovis Goussard', '801', 'individual', 10, 85.0, 57.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '67db15c8-320e-53c9-880b-4e97dc9034dd', '1052f4b5-baaa-5e14-a1bd-ace3ff05f1ea', 'cdffbdbb-edfd-5404-b65a-24ba2a5ad8da', 'Clovis Goussard', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1052f4b5-baaa-5e14-a1bd-ace3ff05f1ea', 1, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1052f4b5-baaa-5e14-a1bd-ace3ff05f1ea', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1052f4b5-baaa-5e14-a1bd-ace3ff05f1ea', 3, 28.0, 'RET', true, '(28)RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1052f4b5-baaa-5e14-a1bd-ace3ff05f1ea', 4, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1052f4b5-baaa-5e14-a1bd-ace3ff05f1ea', 5, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1052f4b5-baaa-5e14-a1bd-ace3ff05f1ea', 6, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1052f4b5-baaa-5e14-a1bd-ace3ff05f1ea', 7, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '49f9960e-20e0-5e03-9984-e29f535c5961', 'b90b6b1b-f763-5766-8a20-667dd663981b', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Raphael Chandler', '816', 'individual', 11, 72.0, 59.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'df11f4c6-6c30-548b-bb60-7fca674175ef', '49f9960e-20e0-5e03-9984-e29f535c5961', 'b90b6b1b-f763-5766-8a20-667dd663981b', 'Raphael Chandler', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('49f9960e-20e0-5e03-9984-e29f535c5961', 1, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('49f9960e-20e0-5e03-9984-e29f535c5961', 2, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('49f9960e-20e0-5e03-9984-e29f535c5961', 3, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('49f9960e-20e0-5e03-9984-e29f535c5961', 4, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('49f9960e-20e0-5e03-9984-e29f535c5961', 5, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('49f9960e-20e0-5e03-9984-e29f535c5961', 6, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('49f9960e-20e0-5e03-9984-e29f535c5961', 7, 13.0, NULL, true, '(13)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'be63e632-1645-5687-a4b6-014ae24b64e0', 'b3d70d42-34b5-4324-8af8-6a829e581ceb', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Damien Seah', '3825', 'individual', 12, 79.0, 64.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0284ac4f-78fe-5575-8e16-9fe5ca5fc2ca', 'be63e632-1645-5687-a4b6-014ae24b64e0', 'b3d70d42-34b5-4324-8af8-6a829e581ceb', 'Damien Seah', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('be63e632-1645-5687-a4b6-014ae24b64e0', 1, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('be63e632-1645-5687-a4b6-014ae24b64e0', 2, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('be63e632-1645-5687-a4b6-014ae24b64e0', 3, 15.0, NULL, true, '(15)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('be63e632-1645-5687-a4b6-014ae24b64e0', 4, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('be63e632-1645-5687-a4b6-014ae24b64e0', 5, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('be63e632-1645-5687-a4b6-014ae24b64e0', 6, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('be63e632-1645-5687-a4b6-014ae24b64e0', 7, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'df42f9ad-43cf-5345-926f-961484a6892a', 'dfc3cb43-1647-5675-98bb-8274a25d5190', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Kengo Matsubara', '1509', 'individual', 13, 80.0, 64.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '925d6eb4-4357-5c56-b7a0-b0b703e25478', 'df42f9ad-43cf-5345-926f-961484a6892a', 'dfc3cb43-1647-5675-98bb-8274a25d5190', 'Kengo Matsubara', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('df42f9ad-43cf-5345-926f-961484a6892a', 1, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('df42f9ad-43cf-5345-926f-961484a6892a', 2, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('df42f9ad-43cf-5345-926f-961484a6892a', 3, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('df42f9ad-43cf-5345-926f-961484a6892a', 4, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('df42f9ad-43cf-5345-926f-961484a6892a', 5, 16.0, NULL, true, '(16)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('df42f9ad-43cf-5345-926f-961484a6892a', 6, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('df42f9ad-43cf-5345-926f-961484a6892a', 7, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '90e9b437-49b2-57a1-b58a-2894050b961a', 'c23f1b7e-2073-524e-8a20-89af3fd18bf9', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Tilly Gibson', '1665', 'individual', 14, 97.0, 78.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '89fe7feb-15c2-5864-9036-ba06a24d6dbc', '90e9b437-49b2-57a1-b58a-2894050b961a', 'c23f1b7e-2073-524e-8a20-89af3fd18bf9', 'Tilly Gibson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90e9b437-49b2-57a1-b58a-2894050b961a', 1, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90e9b437-49b2-57a1-b58a-2894050b961a', 2, 19.0, NULL, true, '(19)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90e9b437-49b2-57a1-b58a-2894050b961a', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90e9b437-49b2-57a1-b58a-2894050b961a', 4, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90e9b437-49b2-57a1-b58a-2894050b961a', 5, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90e9b437-49b2-57a1-b58a-2894050b961a', 6, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90e9b437-49b2-57a1-b58a-2894050b961a', 7, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '4554351b-f04e-5000-87f3-64d04f1e2830', 'd164508c-c587-5c7f-9694-9b480ad61226', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Thea Rydin', '218', 'individual', 15, 117.0, 89.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0fa85571-b5c3-5685-9931-9cd1638b9ad9', '4554351b-f04e-5000-87f3-64d04f1e2830', 'd164508c-c587-5c7f-9694-9b480ad61226', 'Thea Rydin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4554351b-f04e-5000-87f3-64d04f1e2830', 1, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4554351b-f04e-5000-87f3-64d04f1e2830', 2, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4554351b-f04e-5000-87f3-64d04f1e2830', 3, 28.0, 'RET', true, '(28)RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4554351b-f04e-5000-87f3-64d04f1e2830', 4, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4554351b-f04e-5000-87f3-64d04f1e2830', 5, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4554351b-f04e-5000-87f3-64d04f1e2830', 6, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4554351b-f04e-5000-87f3-64d04f1e2830', 7, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'efb3c63e-c9f2-57ae-b610-4e32dc8c3ec4', '2a58ae97-d3c7-5d07-9ee8-e0c0f6c0970f', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Sebastian Chandler', '851', 'individual', 16, 117.0, 93.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1e9e616e-7b57-54b7-bc9b-a0a7b9d102a5', 'efb3c63e-c9f2-57ae-b610-4e32dc8c3ec4', '2a58ae97-d3c7-5d07-9ee8-e0c0f6c0970f', 'Sebastian Chandler', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efb3c63e-c9f2-57ae-b610-4e32dc8c3ec4', 1, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efb3c63e-c9f2-57ae-b610-4e32dc8c3ec4', 2, 24.0, NULL, true, '(24)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efb3c63e-c9f2-57ae-b610-4e32dc8c3ec4', 3, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efb3c63e-c9f2-57ae-b610-4e32dc8c3ec4', 4, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efb3c63e-c9f2-57ae-b610-4e32dc8c3ec4', 5, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efb3c63e-c9f2-57ae-b610-4e32dc8c3ec4', 6, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efb3c63e-c9f2-57ae-b610-4e32dc8c3ec4', 7, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8c3b7e9e-2b9f-52bf-9a10-d0734ae6869e', 'c381b0a9-d3cd-59a2-b778-09f0146841be', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Alexander Sorokin', '1430', 'individual', 17, 120.0, 100.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9f297d47-81f0-5244-aae1-dc17deac03b0', '8c3b7e9e-2b9f-52bf-9a10-d0734ae6869e', 'c381b0a9-d3cd-59a2-b778-09f0146841be', 'Alexander Sorokin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c3b7e9e-2b9f-52bf-9a10-d0734ae6869e', 1, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c3b7e9e-2b9f-52bf-9a10-d0734ae6869e', 2, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c3b7e9e-2b9f-52bf-9a10-d0734ae6869e', 3, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c3b7e9e-2b9f-52bf-9a10-d0734ae6869e', 4, 20.0, NULL, true, '(20)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c3b7e9e-2b9f-52bf-9a10-d0734ae6869e', 5, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c3b7e9e-2b9f-52bf-9a10-d0734ae6869e', 6, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c3b7e9e-2b9f-52bf-9a10-d0734ae6869e', 7, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8e7311b3-ab66-5e9c-8d9e-b30385965427', '75e197ac-42f1-5371-9a4d-5f3649d820f0', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Elliana Antoniou', '1370', 'individual', 18, 136.0, 108.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9d3e1471-2d35-586d-97e6-6c238ec82c17', '8e7311b3-ab66-5e9c-8d9e-b30385965427', '75e197ac-42f1-5371-9a4d-5f3649d820f0', 'Elliana Antoniou', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8e7311b3-ab66-5e9c-8d9e-b30385965427', 1, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8e7311b3-ab66-5e9c-8d9e-b30385965427', 2, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8e7311b3-ab66-5e9c-8d9e-b30385965427', 3, 28.0, 'DNF', true, '(28)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8e7311b3-ab66-5e9c-8d9e-b30385965427', 4, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8e7311b3-ab66-5e9c-8d9e-b30385965427', 5, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8e7311b3-ab66-5e9c-8d9e-b30385965427', 6, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8e7311b3-ab66-5e9c-8d9e-b30385965427', 7, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0f0e7549-a87e-510e-aebf-8d37011817f9', '50147561-8c21-58b5-881e-9b3f4e157aa8', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Indigo Feore', '1880', 'individual', 19, 144.0, 116.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3ea5eb4d-9a2f-5e83-ba8b-851e198980c2', '0f0e7549-a87e-510e-aebf-8d37011817f9', '50147561-8c21-58b5-881e-9b3f4e157aa8', 'Indigo Feore', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f0e7549-a87e-510e-aebf-8d37011817f9', 1, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f0e7549-a87e-510e-aebf-8d37011817f9', 2, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f0e7549-a87e-510e-aebf-8d37011817f9', 3, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f0e7549-a87e-510e-aebf-8d37011817f9', 4, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f0e7549-a87e-510e-aebf-8d37011817f9', 5, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f0e7549-a87e-510e-aebf-8d37011817f9', 6, 28.0, 'DNC', true, '(28)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f0e7549-a87e-510e-aebf-8d37011817f9', 7, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd1183271-6bd0-5c39-8c8f-6c7bc9e06a80', 'f29883fd-c6d4-50eb-9b23-f4ef96c856c1', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Marcus Hoang', '1751', 'individual', 20, 153.0, 125.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'dc8d9804-6550-58e7-acd5-1a9fe104ff6d', 'd1183271-6bd0-5c39-8c8f-6c7bc9e06a80', 'f29883fd-c6d4-50eb-9b23-f4ef96c856c1', 'Marcus Hoang', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1183271-6bd0-5c39-8c8f-6c7bc9e06a80', 1, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1183271-6bd0-5c39-8c8f-6c7bc9e06a80', 2, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1183271-6bd0-5c39-8c8f-6c7bc9e06a80', 3, 28.0, 'DNF', true, '(28)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1183271-6bd0-5c39-8c8f-6c7bc9e06a80', 4, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1183271-6bd0-5c39-8c8f-6c7bc9e06a80', 5, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1183271-6bd0-5c39-8c8f-6c7bc9e06a80', 6, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1183271-6bd0-5c39-8c8f-6c7bc9e06a80', 7, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'deb46a5d-a921-5dcc-bd00-cf1ac68087eb', 'e678ba0b-47a1-5a68-8bb0-717c041ee2b3', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Oliver Kayakesen', '1184', 'individual', 21, 156.0, 128.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'dcfacbc1-a77a-5896-aa1f-8103912da62b', 'deb46a5d-a921-5dcc-bd00-cf1ac68087eb', 'e678ba0b-47a1-5a68-8bb0-717c041ee2b3', 'Oliver Kayakesen', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('deb46a5d-a921-5dcc-bd00-cf1ac68087eb', 1, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('deb46a5d-a921-5dcc-bd00-cf1ac68087eb', 2, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('deb46a5d-a921-5dcc-bd00-cf1ac68087eb', 3, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('deb46a5d-a921-5dcc-bd00-cf1ac68087eb', 4, 28.0, 'DNC', true, '(28)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('deb46a5d-a921-5dcc-bd00-cf1ac68087eb', 5, 28.0, 'DNC', false, '28DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('deb46a5d-a921-5dcc-bd00-cf1ac68087eb', 6, 28.0, 'DNC', false, '28DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('deb46a5d-a921-5dcc-bd00-cf1ac68087eb', 7, 28.0, 'DNC', false, '28DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '80066043-10a4-5649-b098-77a01d735cf3', '1bc09832-78c8-4648-bcd8-3e2f835d617f', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Jae Guan Yu Toh', '3311', 'individual', 22, 163.0, 135.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3f6b66c6-bbe4-5c0c-9b7f-40193c585880', '80066043-10a4-5649-b098-77a01d735cf3', '1bc09832-78c8-4648-bcd8-3e2f835d617f', 'Jae Toh', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('80066043-10a4-5649-b098-77a01d735cf3', 1, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('80066043-10a4-5649-b098-77a01d735cf3', 2, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('80066043-10a4-5649-b098-77a01d735cf3', 3, 28.0, 'DNF', true, '(28)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('80066043-10a4-5649-b098-77a01d735cf3', 4, 28.0, 'RET', false, '28RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('80066043-10a4-5649-b098-77a01d735cf3', 5, 28.0, 'DNC', false, '28DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('80066043-10a4-5649-b098-77a01d735cf3', 6, 28.0, 'DNC', false, '28DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('80066043-10a4-5649-b098-77a01d735cf3', 7, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '6960d518-5301-5945-b260-facd41ca4c8f', '71d2372b-2c3e-54e1-a17a-630c7c3d1794', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Madeleine Moore', '1690', 'individual', 23, 168.0, 140.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5ec21561-3926-5510-8f74-4be3bb94086a', '6960d518-5301-5945-b260-facd41ca4c8f', '71d2372b-2c3e-54e1-a17a-630c7c3d1794', 'Madeleine Moore', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6960d518-5301-5945-b260-facd41ca4c8f', 1, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6960d518-5301-5945-b260-facd41ca4c8f', 2, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6960d518-5301-5945-b260-facd41ca4c8f', 3, 28.0, 'RET', true, '(28)RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6960d518-5301-5945-b260-facd41ca4c8f', 4, 28.0, 'RET', false, '28RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6960d518-5301-5945-b260-facd41ca4c8f', 5, 28.0, 'DNC', false, '28DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6960d518-5301-5945-b260-facd41ca4c8f', 6, 28.0, 'DNC', false, '28DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6960d518-5301-5945-b260-facd41ca4c8f', 7, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8afef8d9-2c88-52a9-9ea4-850a4ed0c0ec', '550ec697-8d1d-5311-8bbd-9d9a3c981307', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Florence Gartrell', '582', 'individual', 24, 171.0, 143.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7a563937-ae0f-5d7d-b797-f2b0b37feebf', '8afef8d9-2c88-52a9-9ea4-850a4ed0c0ec', '550ec697-8d1d-5311-8bbd-9d9a3c981307', 'Florence Gartrell', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8afef8d9-2c88-52a9-9ea4-850a4ed0c0ec', 1, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8afef8d9-2c88-52a9-9ea4-850a4ed0c0ec', 2, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8afef8d9-2c88-52a9-9ea4-850a4ed0c0ec', 3, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8afef8d9-2c88-52a9-9ea4-850a4ed0c0ec', 4, 28.0, 'RET', true, '(28)RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8afef8d9-2c88-52a9-9ea4-850a4ed0c0ec', 5, 28.0, 'DNC', false, '28DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8afef8d9-2c88-52a9-9ea4-850a4ed0c0ec', 6, 28.0, 'DNC', false, '28DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8afef8d9-2c88-52a9-9ea4-850a4ed0c0ec', 7, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '09ff7a35-00d7-5704-ba52-6dcabb65bf1f', 'f1b5322e-f4dc-5143-b5ba-d8b0123d334d', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Eva Kirby', '1867', 'individual', 25, 179.0, 151.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2561b5e5-7c02-5bf9-bdcb-88601bd28aed', '09ff7a35-00d7-5704-ba52-6dcabb65bf1f', 'f1b5322e-f4dc-5143-b5ba-d8b0123d334d', 'Eva Kirby', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09ff7a35-00d7-5704-ba52-6dcabb65bf1f', 1, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09ff7a35-00d7-5704-ba52-6dcabb65bf1f', 2, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09ff7a35-00d7-5704-ba52-6dcabb65bf1f', 3, 28.0, 'RET', true, '(28)RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09ff7a35-00d7-5704-ba52-6dcabb65bf1f', 4, 28.0, 'RET', false, '28RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09ff7a35-00d7-5704-ba52-6dcabb65bf1f', 5, 28.0, 'DNC', false, '28DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09ff7a35-00d7-5704-ba52-6dcabb65bf1f', 6, 28.0, 'DNC', false, '28DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09ff7a35-00d7-5704-ba52-6dcabb65bf1f', 7, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '382c249e-9e07-58a8-9e33-e4897bb95c7e', 'bf9c93be-ecbb-54a2-9ad7-deb806289712', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Lilli Doherty', '1197', 'individual', 26, 187.0, 159.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '73be4ab6-9969-5163-a7da-9b89931aa579', '382c249e-9e07-58a8-9e33-e4897bb95c7e', 'bf9c93be-ecbb-54a2-9ad7-deb806289712', 'Lilli Doherty', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('382c249e-9e07-58a8-9e33-e4897bb95c7e', 1, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('382c249e-9e07-58a8-9e33-e4897bb95c7e', 2, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('382c249e-9e07-58a8-9e33-e4897bb95c7e', 3, 28.0, 'RET', true, '(28)RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('382c249e-9e07-58a8-9e33-e4897bb95c7e', 4, 28.0, 'RET', false, '28RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('382c249e-9e07-58a8-9e33-e4897bb95c7e', 5, 28.0, 'DNC', false, '28DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('382c249e-9e07-58a8-9e33-e4897bb95c7e', 6, 28.0, 'DNC', false, '28DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('382c249e-9e07-58a8-9e33-e4897bb95c7e', 7, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd265ce77-3667-574c-a4a1-322e7c0370c7', 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2', '14fc6b21-e72a-5ab4-9113-b1973f6b7dfe', 'Bobby Furneaux Williams', '1926', 'individual', 27, 196.0, 168.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'https://sailingresults.net/sa/results/overall.aspx?ID=82126', 'VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results', 'url', 'Official published results from VIODA Organic Garden International Optimist Victorian & Open Championship 2026 Results. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c1073b75-7298-5995-a472-624ab13fd3f2', 'd265ce77-3667-574c-a4a1-322e7c0370c7', 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2', 'Bobby Furneaux Williams', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d265ce77-3667-574c-a4a1-322e7c0370c7', 1, 28.0, 'DNC', true, '(28)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d265ce77-3667-574c-a4a1-322e7c0370c7', 2, 28.0, 'DNC', false, '28DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d265ce77-3667-574c-a4a1-322e7c0370c7', 3, 28.0, 'DNC', false, '28DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d265ce77-3667-574c-a4a1-322e7c0370c7', 4, 28.0, 'DNC', false, '28DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d265ce77-3667-574c-a4a1-322e7c0370c7', 5, 28.0, 'DNC', false, '28DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d265ce77-3667-574c-a4a1-322e7c0370c7', 6, 28.0, 'DNC', false, '28DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d265ce77-3667-574c-a4a1-322e7c0370c7', 7, 28.0, 'DNC', false, '28DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 NSW Optimist State Championship — Open Fleet (42 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1047a5dd-7ae4-5f7c-ac7d-51be87414631', 'c34abc0a-3cf5-510b-be46-a2f4f07d6e23', '119ca9a1-4094-533e-9fed-8beff972332c', 'Walter Heeley', '1575', 'individual', 1, 9.0, 9.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '56e749d6-3561-580d-85d5-59191ffc6745', '1047a5dd-7ae4-5f7c-ac7d-51be87414631', 'c34abc0a-3cf5-510b-be46-a2f4f07d6e23', 'Walter Heeley', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1047a5dd-7ae4-5f7c-ac7d-51be87414631', 1, 1.0, NULL, false, '1.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1047a5dd-7ae4-5f7c-ac7d-51be87414631', 2, 1.0, NULL, false, '1.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1047a5dd-7ae4-5f7c-ac7d-51be87414631', 3, 7.0, NULL, false, '7.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '379a9778-9b53-5e3d-9907-c448673c065d', 'b2f3bfeb-f969-518e-b631-70da18fadc0d', '119ca9a1-4094-533e-9fed-8beff972332c', 'William Harris', '1932', 'individual', 2, 20.0, 20.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5987ae04-60bc-5068-b367-e7dad19ea04c', '379a9778-9b53-5e3d-9907-c448673c065d', 'b2f3bfeb-f969-518e-b631-70da18fadc0d', 'William Harris', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('379a9778-9b53-5e3d-9907-c448673c065d', 1, 2.0, NULL, false, '2.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('379a9778-9b53-5e3d-9907-c448673c065d', 2, 4.0, NULL, false, '4.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('379a9778-9b53-5e3d-9907-c448673c065d', 3, 14.0, NULL, false, '14.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '291e0079-9b47-543a-8ebc-8646258ee2d5', '7b929e9d-7925-4705-94ab-d175a82bb610', '119ca9a1-4094-533e-9fed-8beff972332c', 'Kalle Gravare', '1929', 'individual', 3, 23.0, 23.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ee5e24f2-30a1-5216-bc80-35a9ab5c98c7', '291e0079-9b47-543a-8ebc-8646258ee2d5', '7b929e9d-7925-4705-94ab-d175a82bb610', 'Kalle Gravare', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('291e0079-9b47-543a-8ebc-8646258ee2d5', 1, 15.0, NULL, false, '15.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('291e0079-9b47-543a-8ebc-8646258ee2d5', 2, 2.0, NULL, false, '2.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('291e0079-9b47-543a-8ebc-8646258ee2d5', 3, 6.0, NULL, false, '6.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '839b4129-b455-50da-aa7d-0764a647f2cf', 'a1bac017-5467-45ce-9ddc-53c13bcf2852', '119ca9a1-4094-533e-9fed-8beff972332c', 'Lyla Greenwood', '1909', 'individual', 4, 27.0, 27.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c5153924-3af6-5aee-b550-6626b1003997', '839b4129-b455-50da-aa7d-0764a647f2cf', 'a1bac017-5467-45ce-9ddc-53c13bcf2852', 'Lyla Greenwood', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('839b4129-b455-50da-aa7d-0764a647f2cf', 1, 6.0, NULL, false, '6.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('839b4129-b455-50da-aa7d-0764a647f2cf', 2, 13.0, NULL, false, '13.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('839b4129-b455-50da-aa7d-0764a647f2cf', 3, 8.0, NULL, false, '8.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2b34c915-3408-512b-822e-4852fbd5e17f', '9f1d45de-707d-5b7e-a92c-e88596d5233d', '119ca9a1-4094-533e-9fed-8beff972332c', 'Sijia Deng', '1720', 'individual', 5, 34.0, 34.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'cfa243b6-0a31-5070-bc1e-c90658d92be5', '2b34c915-3408-512b-822e-4852fbd5e17f', '9f1d45de-707d-5b7e-a92c-e88596d5233d', 'Sijia Deng', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2b34c915-3408-512b-822e-4852fbd5e17f', 1, 4.0, NULL, false, '4.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2b34c915-3408-512b-822e-4852fbd5e17f', 2, 19.0, NULL, false, '19.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2b34c915-3408-512b-822e-4852fbd5e17f', 3, 11.0, NULL, false, '11.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '27b85f73-31ac-533c-89a8-921347172c58', 'fe55751a-320e-48f8-92fd-fd40bca74292', '119ca9a1-4094-533e-9fed-8beff972332c', 'Reid Martin', '1728', 'individual', 6, 34.0, 34.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a3ba6c37-e53b-5467-a20f-48d99cf7ada9', '27b85f73-31ac-533c-89a8-921347172c58', 'fe55751a-320e-48f8-92fd-fd40bca74292', 'Reid Martin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('27b85f73-31ac-533c-89a8-921347172c58', 1, 8.0, NULL, false, '8.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('27b85f73-31ac-533c-89a8-921347172c58', 2, 16.0, NULL, false, '16.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('27b85f73-31ac-533c-89a8-921347172c58', 3, 10.0, NULL, false, '10.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1867249c-b59e-51c1-930a-d962f9ab613e', '0b2ef30b-3fd7-5beb-8137-07340ecf5ea3', '119ca9a1-4094-533e-9fed-8beff972332c', 'Zachary Tait', '1743', 'individual', 7, 36.0, 36.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e1f7e98e-d74e-5759-929e-669dd51ee0ab', '1867249c-b59e-51c1-930a-d962f9ab613e', '0b2ef30b-3fd7-5beb-8137-07340ecf5ea3', 'Zachary Tait', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1867249c-b59e-51c1-930a-d962f9ab613e', 1, 18.0, NULL, false, '18.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1867249c-b59e-51c1-930a-d962f9ab613e', 2, 14.0, NULL, false, '14.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1867249c-b59e-51c1-930a-d962f9ab613e', 3, 4.0, NULL, false, '4.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '14bbe62f-8809-55fb-833d-8b8981bf9008', '325b400d-1092-4711-b769-29b16989ea35', '119ca9a1-4094-533e-9fed-8beff972332c', 'Aurelia Wilson', '1941', 'individual', 8, 36.0, 36.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a2703c2c-273e-51dd-934c-c302c8d358f4', '14bbe62f-8809-55fb-833d-8b8981bf9008', '325b400d-1092-4711-b769-29b16989ea35', 'Aurelia Wilson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('14bbe62f-8809-55fb-833d-8b8981bf9008', 1, 9.0, NULL, false, '9.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('14bbe62f-8809-55fb-833d-8b8981bf9008', 2, 6.0, NULL, false, '6.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('14bbe62f-8809-55fb-833d-8b8981bf9008', 3, 21.0, NULL, false, '21.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9dea3fba-5ba5-5161-ae6f-2fe3d9383c5e', '2e005437-68a4-51ab-bc8b-d377f51d55eb', '119ca9a1-4094-533e-9fed-8beff972332c', 'Balthazar Roche', '1931', 'individual', 9, 37.0, 37.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7e081e60-11c9-5767-a512-0b81b4603b70', '9dea3fba-5ba5-5161-ae6f-2fe3d9383c5e', '2e005437-68a4-51ab-bc8b-d377f51d55eb', 'Balthazar Roche', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9dea3fba-5ba5-5161-ae6f-2fe3d9383c5e', 1, 33.0, NULL, false, '33.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9dea3fba-5ba5-5161-ae6f-2fe3d9383c5e', 2, 3.0, NULL, false, '3.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9dea3fba-5ba5-5161-ae6f-2fe3d9383c5e', 3, 1.0, NULL, false, '1.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8d0522ff-a935-518e-961a-93a6dbcf466d', '51a80a27-8665-4db2-afb4-0940cbc20376', '119ca9a1-4094-533e-9fed-8beff972332c', 'Milton Li', '1559', 'individual', 10, 38.0, 38.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'aa1a095d-c109-5f22-9219-a9d0a1f71bb9', '8d0522ff-a935-518e-961a-93a6dbcf466d', '51a80a27-8665-4db2-afb4-0940cbc20376', 'Milton Li', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8d0522ff-a935-518e-961a-93a6dbcf466d', 1, 14.0, NULL, false, '14.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8d0522ff-a935-518e-961a-93a6dbcf466d', 2, 21.0, NULL, false, '21.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8d0522ff-a935-518e-961a-93a6dbcf466d', 3, 3.0, NULL, false, '3.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c3345cc4-2000-50dd-8686-df2c64c9bfa1', '9e8f469d-4386-46dc-8533-5babc753dd05', '119ca9a1-4094-533e-9fed-8beff972332c', 'Jack Mcguire', '1936', 'individual', 11, 38.0, 38.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e6cb96c1-def0-5e79-a163-d7ae4dac1985', 'c3345cc4-2000-50dd-8686-df2c64c9bfa1', '9e8f469d-4386-46dc-8533-5babc753dd05', 'Jack McGuire', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3345cc4-2000-50dd-8686-df2c64c9bfa1', 1, 10.0, NULL, false, '10.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3345cc4-2000-50dd-8686-df2c64c9bfa1', 2, 15.0, NULL, false, '15.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3345cc4-2000-50dd-8686-df2c64c9bfa1', 3, 13.0, NULL, false, '13.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'cb47990a-bb0f-591e-8fc2-e1e3d56a51fb', '5a61d861-917e-55b9-85db-9c122fcc9183', '119ca9a1-4094-533e-9fed-8beff972332c', 'Luca De Giosa', '1920', 'individual', 12, 43.0, 43.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4bf66656-cf5d-53a9-8368-9f41aaf9883d', 'cb47990a-bb0f-591e-8fc2-e1e3d56a51fb', '5a61d861-917e-55b9-85db-9c122fcc9183', 'Luca De Giosa', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cb47990a-bb0f-591e-8fc2-e1e3d56a51fb', 1, 31.0, NULL, false, '31.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cb47990a-bb0f-591e-8fc2-e1e3d56a51fb', 2, 7.0, NULL, false, '7.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cb47990a-bb0f-591e-8fc2-e1e3d56a51fb', 3, 5.0, NULL, false, '5.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8a4d9c6e-ce40-5cf3-b6cb-e106a6c68182', '1b22f933-9817-4f8b-a366-11315c5bc283', '119ca9a1-4094-533e-9fed-8beff972332c', 'Lucy Lin', '1938', 'individual', 13, 45.0, 45.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3bb05a7e-e22f-569f-967b-c5cfe2700c4e', '8a4d9c6e-ce40-5cf3-b6cb-e106a6c68182', '1b22f933-9817-4f8b-a366-11315c5bc283', 'Lucy Lin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a4d9c6e-ce40-5cf3-b6cb-e106a6c68182', 1, 22.0, NULL, false, '22.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a4d9c6e-ce40-5cf3-b6cb-e106a6c68182', 2, 8.0, NULL, false, '8.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a4d9c6e-ce40-5cf3-b6cb-e106a6c68182', 3, 15.0, NULL, false, '15.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '41adacc5-4d86-5c3e-9f4c-ac7df4f042af', 'a8621760-ffb6-4283-8e2e-12bb7890d8a4', '119ca9a1-4094-533e-9fed-8beff972332c', 'Seb Tucker', '1771', 'individual', 14, 46.0, 46.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '57e3d18e-5b62-50f2-9e6b-428367a76453', '41adacc5-4d86-5c3e-9f4c-ac7df4f042af', 'a8621760-ffb6-4283-8e2e-12bb7890d8a4', 'Seb tucker', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('41adacc5-4d86-5c3e-9f4c-ac7df4f042af', 1, 19.0, NULL, false, '19.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('41adacc5-4d86-5c3e-9f4c-ac7df4f042af', 2, 10.0, NULL, false, '10.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('41adacc5-4d86-5c3e-9f4c-ac7df4f042af', 3, 17.0, NULL, false, '17.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c3f52efa-997d-542c-847c-83abb9850631', '30880421-1dc4-4a14-9c6b-8c00de39e4d8', '119ca9a1-4094-533e-9fed-8beff972332c', 'Tom Griffiths', '1744', 'individual', 15, 50.0, 50.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9c5457fe-518e-5f1c-b9c1-55b058920d2c', 'c3f52efa-997d-542c-847c-83abb9850631', '30880421-1dc4-4a14-9c6b-8c00de39e4d8', 'Tom Griffiths', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3f52efa-997d-542c-847c-83abb9850631', 1, 43.0, 'UFD', false, '43.0 UFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3f52efa-997d-542c-847c-83abb9850631', 2, 5.0, NULL, false, '5.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3f52efa-997d-542c-847c-83abb9850631', 3, 2.0, NULL, false, '2.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3e2c94fb-037e-51df-9583-c855b051c874', '7411c058-0e0a-5a5d-aa05-fb3bd9edc4aa', '119ca9a1-4094-533e-9fed-8beff972332c', 'Mac Darlington', '1879', 'individual', 16, 50.0, 50.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4b67cfd5-0935-56e9-963f-3ef5c82f5cb5', '3e2c94fb-037e-51df-9583-c855b051c874', '7411c058-0e0a-5a5d-aa05-fb3bd9edc4aa', 'Mac Darlington', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3e2c94fb-037e-51df-9583-c855b051c874', 1, 17.0, NULL, false, '17.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3e2c94fb-037e-51df-9583-c855b051c874', 2, 17.0, NULL, false, '17.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3e2c94fb-037e-51df-9583-c855b051c874', 3, 16.0, NULL, false, '16.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b4979fd7-363f-56d2-bde4-c03ffa467d15', 'f8f1b2c8-c396-501f-a6dd-f51b6aa782d9', '119ca9a1-4094-533e-9fed-8beff972332c', 'Toby Phillips', '1906', 'individual', 17, 55.0, 55.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '44c979b8-d52d-53df-b31e-95e34fbab82d', 'b4979fd7-363f-56d2-bde4-c03ffa467d15', 'f8f1b2c8-c396-501f-a6dd-f51b6aa782d9', 'Toby Phillips', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b4979fd7-363f-56d2-bde4-c03ffa467d15', 1, 3.0, NULL, false, '3.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b4979fd7-363f-56d2-bde4-c03ffa467d15', 2, 9.0, NULL, false, '9.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b4979fd7-363f-56d2-bde4-c03ffa467d15', 3, 43.0, 'DNC', false, '43.0 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f61f48e4-bb92-5487-97d4-3cb5e97d45c1', '298175a4-db74-4a70-a55c-fdd65f4d3004', '119ca9a1-4094-533e-9fed-8beff972332c', 'Hamilton Zhao', '1878', 'individual', 18, 57.0, 57.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bfce187c-a10c-57a9-9996-48bea3c82b5b', 'f61f48e4-bb92-5487-97d4-3cb5e97d45c1', '298175a4-db74-4a70-a55c-fdd65f4d3004', 'Hamilton Zhao', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f61f48e4-bb92-5487-97d4-3cb5e97d45c1', 1, 24.0, NULL, false, '24.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f61f48e4-bb92-5487-97d4-3cb5e97d45c1', 2, 24.0, NULL, false, '24.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f61f48e4-bb92-5487-97d4-3cb5e97d45c1', 3, 9.0, NULL, false, '9.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '997331de-bdca-5982-bb37-df1ed3eea865', 'b64cc6ae-a6e8-47a4-b702-b067d02e1f19', '119ca9a1-4094-533e-9fed-8beff972332c', 'Jayden Wang', '1748', 'individual', 19, 58.0, 58.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c1c91683-5da2-51c8-873e-506b2a5e708b', '997331de-bdca-5982-bb37-df1ed3eea865', 'b64cc6ae-a6e8-47a4-b702-b067d02e1f19', 'Jayden Wang', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('997331de-bdca-5982-bb37-df1ed3eea865', 1, 11.0, NULL, false, '11.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('997331de-bdca-5982-bb37-df1ed3eea865', 2, 29.0, NULL, false, '29.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('997331de-bdca-5982-bb37-df1ed3eea865', 3, 18.0, NULL, false, '18.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c5c2439d-bcc7-55fd-8369-1393cf53903c', '6e620e7e-5678-525f-8760-caaacf2266a9', '119ca9a1-4094-533e-9fed-8beff972332c', 'Emerald Jacobsen', '1846', 'individual', 20, 59.0, 59.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '500d7f61-2aa3-58fb-a073-81ff8442830e', 'c5c2439d-bcc7-55fd-8369-1393cf53903c', '6e620e7e-5678-525f-8760-caaacf2266a9', 'Emerald Jacobsen', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c5c2439d-bcc7-55fd-8369-1393cf53903c', 1, 25.0, NULL, false, '25.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c5c2439d-bcc7-55fd-8369-1393cf53903c', 2, 22.0, NULL, false, '22.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c5c2439d-bcc7-55fd-8369-1393cf53903c', 3, 12.0, NULL, false, '12.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f9760a5e-dfa0-5cd6-8384-5d64379edf4b', '3e8649b1-935e-436e-b72a-510dba915078', '119ca9a1-4094-533e-9fed-8beff972332c', 'Harriet Behrens', '1937', 'individual', 21, 60.0, 60.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '919ee99a-e739-5670-bb06-6cf2ded6d2b1', 'f9760a5e-dfa0-5cd6-8384-5d64379edf4b', '3e8649b1-935e-436e-b72a-510dba915078', 'Harriet Behrens', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f9760a5e-dfa0-5cd6-8384-5d64379edf4b', 1, 7.0, NULL, false, '7.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f9760a5e-dfa0-5cd6-8384-5d64379edf4b', 2, 20.0, NULL, false, '20.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f9760a5e-dfa0-5cd6-8384-5d64379edf4b', 3, 33.0, NULL, false, '33.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ae70ae23-8397-5c80-b0b7-f6e2b5dc119e', '0f1eb283-e53c-533e-8113-55753e658647', '119ca9a1-4094-533e-9fed-8beff972332c', 'Emma Tomkins', '1781', 'individual', 22, 65.0, 65.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4ed9d4d6-1762-5752-a361-2349f047941c', 'ae70ae23-8397-5c80-b0b7-f6e2b5dc119e', '0f1eb283-e53c-533e-8113-55753e658647', 'Emma Tomkins', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ae70ae23-8397-5c80-b0b7-f6e2b5dc119e', 1, 5.0, NULL, false, '5.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ae70ae23-8397-5c80-b0b7-f6e2b5dc119e', 2, 33.0, NULL, false, '33.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ae70ae23-8397-5c80-b0b7-f6e2b5dc119e', 3, 27.0, NULL, false, '27.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a8d2b1b4-b8e8-5c57-8923-dabd0d9863dc', 'f5f68b83-bb5b-4523-963f-3f367d5b4771', '119ca9a1-4094-533e-9fed-8beff972332c', 'Yufu Wang', '1930', 'individual', 23, 66.0, 66.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '16cb8b0d-fea9-5b1d-b09f-5544b6c6db7b', 'a8d2b1b4-b8e8-5c57-8923-dabd0d9863dc', 'f5f68b83-bb5b-4523-963f-3f367d5b4771', 'Yufu Wang', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a8d2b1b4-b8e8-5c57-8923-dabd0d9863dc', 1, 13.0, NULL, false, '13.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a8d2b1b4-b8e8-5c57-8923-dabd0d9863dc', 2, 23.0, NULL, false, '23.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a8d2b1b4-b8e8-5c57-8923-dabd0d9863dc', 3, 30.0, NULL, false, '30.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0f51fc92-bc56-5542-b010-0dd12b086008', '8ffb1e6b-203c-4bab-ac2f-18de1db064b7', '119ca9a1-4094-533e-9fed-8beff972332c', 'Heidi Sinclair-Hill', '1364', 'individual', 24, 66.0, 66.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8360c14c-29de-5887-8b35-ab6b0bc8d87b', '0f51fc92-bc56-5542-b010-0dd12b086008', '8ffb1e6b-203c-4bab-ac2f-18de1db064b7', 'Heidi Sinclair-Hill', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f51fc92-bc56-5542-b010-0dd12b086008', 1, 16.0, NULL, false, '16.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f51fc92-bc56-5542-b010-0dd12b086008', 2, 18.0, NULL, false, '18.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f51fc92-bc56-5542-b010-0dd12b086008', 3, 32.0, NULL, false, '32.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3f8de3e8-94dc-5c71-98fc-85bf68b75e33', 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81', '119ca9a1-4094-533e-9fed-8beff972332c', 'Oliver Johnson', '1854', 'individual', 25, 67.0, 67.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b6088235-329f-5954-8493-377ae2b263c4', '3f8de3e8-94dc-5c71-98fc-85bf68b75e33', 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81', 'Oliver Johnson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3f8de3e8-94dc-5c71-98fc-85bf68b75e33', 1, 12.0, NULL, false, '12.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3f8de3e8-94dc-5c71-98fc-85bf68b75e33', 2, 27.0, NULL, false, '27.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3f8de3e8-94dc-5c71-98fc-85bf68b75e33', 3, 28.0, NULL, false, '28.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8c20fb90-5d75-5cb1-b3c3-d0c039333ceb', 'fc8d7069-1d5c-5065-982f-5b7c0d711185', '119ca9a1-4094-533e-9fed-8beff972332c', 'Alex Mirceski', '1791', 'individual', 26, 68.0, 68.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9559524c-ad6c-5123-bc0b-20d22f4393a8', '8c20fb90-5d75-5cb1-b3c3-d0c039333ceb', 'fc8d7069-1d5c-5065-982f-5b7c0d711185', 'Alex Mirceski', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c20fb90-5d75-5cb1-b3c3-d0c039333ceb', 1, 37.0, NULL, false, '37.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c20fb90-5d75-5cb1-b3c3-d0c039333ceb', 2, 11.0, NULL, false, '11.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c20fb90-5d75-5cb1-b3c3-d0c039333ceb', 3, 20.0, NULL, false, '20.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'eaf579e7-7336-5413-bfaf-10b061c31e4f', '045b2495-820a-5df1-b744-8439ea2e3d13', '119ca9a1-4094-533e-9fed-8beff972332c', 'Edward Payne', '1627', 'individual', 27, 68.0, 68.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ebbe2e28-313b-5c41-af19-8b00e7c51117', 'eaf579e7-7336-5413-bfaf-10b061c31e4f', '045b2495-820a-5df1-b744-8439ea2e3d13', 'Edward Payne', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eaf579e7-7336-5413-bfaf-10b061c31e4f', 1, 21.0, NULL, false, '21.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eaf579e7-7336-5413-bfaf-10b061c31e4f', 2, 25.0, NULL, false, '25.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eaf579e7-7336-5413-bfaf-10b061c31e4f', 3, 22.0, NULL, false, '22.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ad07a45f-8a41-5e6d-8071-aecf31e4f028', '471b461c-5c75-57ae-b96d-5ecf09e15791', '119ca9a1-4094-533e-9fed-8beff972332c', 'William Rose', '1447', 'individual', 28, 75.0, 75.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3ae32ec0-e2bc-5b05-b6f2-7db558fde789', 'ad07a45f-8a41-5e6d-8071-aecf31e4f028', '471b461c-5c75-57ae-b96d-5ecf09e15791', 'William Rose', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ad07a45f-8a41-5e6d-8071-aecf31e4f028', 1, 20.0, NULL, false, '20.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ad07a45f-8a41-5e6d-8071-aecf31e4f028', 2, 12.0, NULL, false, '12.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ad07a45f-8a41-5e6d-8071-aecf31e4f028', 3, 43.0, 'UFD', false, '43.0 UFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c6a99a90-ea73-51be-a3b4-34cdcd3846aa', 'f26ce470-48a0-419e-967e-b1e936dad712', '119ca9a1-4094-533e-9fed-8beff972332c', 'Lavinia Liu', '1866', 'individual', 29, 79.0, 79.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a73a598d-7292-504f-9247-87e5653d41fe', 'c6a99a90-ea73-51be-a3b4-34cdcd3846aa', 'f26ce470-48a0-419e-967e-b1e936dad712', 'Lavinia Liu', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c6a99a90-ea73-51be-a3b4-34cdcd3846aa', 1, 28.0, NULL, false, '28.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c6a99a90-ea73-51be-a3b4-34cdcd3846aa', 2, 32.0, NULL, false, '32.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c6a99a90-ea73-51be-a3b4-34cdcd3846aa', 3, 19.0, NULL, false, '19.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'efcf1721-5c8e-530a-b097-e7a4a4e5fc74', 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6', '119ca9a1-4094-533e-9fed-8beff972332c', 'Alexander Walker', '1685', 'individual', 30, 82.0, 82.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ed3edb51-b1bf-5b22-918a-ee9294cfaa2d', 'efcf1721-5c8e-530a-b097-e7a4a4e5fc74', 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6', 'Alexander Walker', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efcf1721-5c8e-530a-b097-e7a4a4e5fc74', 1, 26.0, NULL, false, '26.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efcf1721-5c8e-530a-b097-e7a4a4e5fc74', 2, 30.0, NULL, false, '30.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efcf1721-5c8e-530a-b097-e7a4a4e5fc74', 3, 26.0, NULL, false, '26.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '77f5c0d8-567c-5024-8179-9824ace762a6', '31374565-e925-521a-a074-93c0d364cbc2', '119ca9a1-4094-533e-9fed-8beff972332c', 'Zac Boyd', '1753', 'individual', 31, 83.0, 83.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7be6278a-eca5-5555-be3b-68ca394f1404', '77f5c0d8-567c-5024-8179-9824ace762a6', '31374565-e925-521a-a074-93c0d364cbc2', 'Zac Boyd', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77f5c0d8-567c-5024-8179-9824ace762a6', 1, 29.0, NULL, false, '29.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77f5c0d8-567c-5024-8179-9824ace762a6', 2, 31.0, NULL, false, '31.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77f5c0d8-567c-5024-8179-9824ace762a6', 3, 23.0, NULL, false, '23.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9778eaaf-f7f3-5006-bf9f-387b94e6c26f', '9ee1f9f1-aa37-4a62-8f85-67ab090c6d64', '119ca9a1-4094-533e-9fed-8beff972332c', 'Axel Ryves', '1633', 'individual', 32, 87.0, 87.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '33772104-aa83-55d7-bfb6-bbfb1137118d', '9778eaaf-f7f3-5006-bf9f-387b94e6c26f', '9ee1f9f1-aa37-4a62-8f85-67ab090c6d64', 'Axel Ryves', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9778eaaf-f7f3-5006-bf9f-387b94e6c26f', 1, 32.0, NULL, false, '32.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9778eaaf-f7f3-5006-bf9f-387b94e6c26f', 2, 26.0, NULL, false, '26.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9778eaaf-f7f3-5006-bf9f-387b94e6c26f', 3, 29.0, NULL, false, '29.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'da9a2b7a-1579-5dde-a811-8d1a862c43d1', '15b30f88-d7b3-45f1-b9c2-a59c9972101b', '119ca9a1-4094-533e-9fed-8beff972332c', 'Orlando Watts', '1745', 'individual', 33, 88.0, 88.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8b5b1fdb-fc8a-5a9e-91c7-ba447cec0604', 'da9a2b7a-1579-5dde-a811-8d1a862c43d1', '15b30f88-d7b3-45f1-b9c2-a59c9972101b', 'Orlando Watts', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('da9a2b7a-1579-5dde-a811-8d1a862c43d1', 1, 36.0, NULL, false, '36.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('da9a2b7a-1579-5dde-a811-8d1a862c43d1', 2, 28.0, NULL, false, '28.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('da9a2b7a-1579-5dde-a811-8d1a862c43d1', 3, 24.0, NULL, false, '24.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c23e5cce-5eef-5257-9c8c-4ea07f1c6e37', 'cdd61132-5975-4264-8804-cf78cd45258e', '119ca9a1-4094-533e-9fed-8beff972332c', 'Meii You', '1549', 'individual', 34, 90.0, 90.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a74a2519-5e07-5472-acd9-d523eac712e7', 'c23e5cce-5eef-5257-9c8c-4ea07f1c6e37', 'cdd61132-5975-4264-8804-cf78cd45258e', 'Meii You', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c23e5cce-5eef-5257-9c8c-4ea07f1c6e37', 1, 30.0, NULL, false, '30.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c23e5cce-5eef-5257-9c8c-4ea07f1c6e37', 2, 35.0, NULL, false, '35.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c23e5cce-5eef-5257-9c8c-4ea07f1c6e37', 3, 25.0, NULL, false, '25.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2f1f64cf-7186-5b22-98c9-b6748534021f', 'e959c8e7-7d71-52bc-82d8-94e76a615407', '119ca9a1-4094-533e-9fed-8beff972332c', 'Felix Sawers', '1724', 'individual', 35, 96.0, 96.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c2b725be-805a-557b-b8c7-0e723d75a1e2', '2f1f64cf-7186-5b22-98c9-b6748534021f', 'e959c8e7-7d71-52bc-82d8-94e76a615407', 'Felix Sawers', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f1f64cf-7186-5b22-98c9-b6748534021f', 1, 23.0, NULL, false, '23.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f1f64cf-7186-5b22-98c9-b6748534021f', 2, 36.0, NULL, false, '36.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f1f64cf-7186-5b22-98c9-b6748534021f', 3, 37.0, NULL, false, '37.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd18ba054-27e8-5d21-af46-feea2bb8c09e', '64e6b01c-0fc6-5fa5-87ee-52226925ff5c', '119ca9a1-4094-533e-9fed-8beff972332c', 'Ariel Ashmore', '1721', 'individual', 36, 99.0, 99.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0ef9941f-2d2c-5716-b6d0-2ab57ade2f39', 'd18ba054-27e8-5d21-af46-feea2bb8c09e', '64e6b01c-0fc6-5fa5-87ee-52226925ff5c', 'Ariel Ashmore', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d18ba054-27e8-5d21-af46-feea2bb8c09e', 1, 34.0, NULL, false, '34.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d18ba054-27e8-5d21-af46-feea2bb8c09e', 2, 34.0, NULL, false, '34.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d18ba054-27e8-5d21-af46-feea2bb8c09e', 3, 31.0, NULL, false, '31.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '095000e9-fefc-52e9-b4fe-8b4a8ce00e89', 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8', '119ca9a1-4094-533e-9fed-8beff972332c', 'Oliver Morris', '1822', 'individual', 37, 103.0, 103.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1afc5e76-0ba2-54a1-8e2a-2be62d375306', '095000e9-fefc-52e9-b4fe-8b4a8ce00e89', 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8', 'Oliver Morris', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('095000e9-fefc-52e9-b4fe-8b4a8ce00e89', 1, 27.0, NULL, false, '27.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('095000e9-fefc-52e9-b4fe-8b4a8ce00e89', 2, 40.0, NULL, false, '40.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('095000e9-fefc-52e9-b4fe-8b4a8ce00e89', 3, 36.0, NULL, false, '36.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9b4f42ba-efc2-5c0d-a22f-c24e2921f3e4', '2625b7b9-c7eb-59ca-9d5a-d17f47546759', '119ca9a1-4094-533e-9fed-8beff972332c', 'Jamie Lee Mason', '1449', 'individual', 38, 111.0, 111.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '17c13028-afc0-51ec-846d-ee49a3a987b4', '9b4f42ba-efc2-5c0d-a22f-c24e2921f3e4', '2625b7b9-c7eb-59ca-9d5a-d17f47546759', 'Jamie Lee Mason', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9b4f42ba-efc2-5c0d-a22f-c24e2921f3e4', 1, 35.0, NULL, false, '35.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9b4f42ba-efc2-5c0d-a22f-c24e2921f3e4', 2, 38.0, NULL, false, '38.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9b4f42ba-efc2-5c0d-a22f-c24e2921f3e4', 3, 38.0, NULL, false, '38.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2d5d0456-fe6e-541f-967f-6042804235b8', '09e13481-654a-59c6-a7d5-dc9bb6f79c25', '119ca9a1-4094-533e-9fed-8beff972332c', 'Tessa Bonjean', '1543', 'individual', 39, 113.0, 113.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7b36ad02-016f-5807-a3d9-95152579b6d0', '2d5d0456-fe6e-541f-967f-6042804235b8', '09e13481-654a-59c6-a7d5-dc9bb6f79c25', 'Tessa Bonjean', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2d5d0456-fe6e-541f-967f-6042804235b8', 1, 40.0, NULL, false, '40.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2d5d0456-fe6e-541f-967f-6042804235b8', 2, 39.0, NULL, false, '39.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2d5d0456-fe6e-541f-967f-6042804235b8', 3, 34.0, NULL, false, '34.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '63234d50-48fe-5337-aa46-a37ace7a1ea8', '365765e9-9ea4-5de4-8228-00156c596e49', '119ca9a1-4094-533e-9fed-8beff972332c', 'Oliver Korn', '709', 'individual', 40, 114.0, 114.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b1bb5b69-80df-560d-8d15-2a8989b6797d', '63234d50-48fe-5337-aa46-a37ace7a1ea8', '365765e9-9ea4-5de4-8228-00156c596e49', 'Oliver Korn', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63234d50-48fe-5337-aa46-a37ace7a1ea8', 1, 38.0, NULL, false, '38.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63234d50-48fe-5337-aa46-a37ace7a1ea8', 2, 41.0, NULL, false, '41.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63234d50-48fe-5337-aa46-a37ace7a1ea8', 3, 35.0, NULL, false, '35.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ed1201ee-9df5-5fce-a0ba-e4a278ede139', '8d01c0ff-f163-55fe-b538-2d5ece68fa04', '119ca9a1-4094-533e-9fed-8beff972332c', 'Norah Bonjean', '1532', 'individual', 41, 117.0, 117.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0a3ccec8-cb2f-55f9-a5d8-b66cba13b56a', 'ed1201ee-9df5-5fce-a0ba-e4a278ede139', '8d01c0ff-f163-55fe-b538-2d5ece68fa04', 'Norah Bonjean', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ed1201ee-9df5-5fce-a0ba-e4a278ede139', 1, 41.0, NULL, false, '41.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ed1201ee-9df5-5fce-a0ba-e4a278ede139', 2, 37.0, NULL, false, '37.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ed1201ee-9df5-5fce-a0ba-e4a278ede139', 3, 39.0, NULL, false, '39.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '6840929b-09d8-557f-80bb-b84814d3e285', 'ace9e6c1-bdd4-58f0-8159-a753458dfcb8', '119ca9a1-4094-533e-9fed-8beff972332c', 'Markus Liu', '1849', 'individual', 42, 124.0, 124.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b25a8398-178a-5f46-a5c5-1b8e3ff681e9', '6840929b-09d8-557f-80bb-b84814d3e285', 'ace9e6c1-bdd4-58f0-8159-a753458dfcb8', 'Markus Liu', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6840929b-09d8-557f-80bb-b84814d3e285', 1, 39.0, NULL, false, '39.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6840929b-09d8-557f-80bb-b84814d3e285', 2, 42.0, NULL, false, '42.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6840929b-09d8-557f-80bb-b84814d3e285', 3, 43.0, 'DNC', false, '43.0 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 NSW Optimist State Championship — Intermediate Fleet (55 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '95f60992-7140-5c94-a4a0-ab0e5955c37c', 'd6485671-0de9-5522-b3de-262e2cc27a13', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Courtney Harrison', '1735', 'individual', 1, 5.0, 5.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6514877b-4835-54c1-a1f8-a9c5f67db8bc', '95f60992-7140-5c94-a4a0-ab0e5955c37c', 'd6485671-0de9-5522-b3de-262e2cc27a13', 'Courtney Harrison', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('95f60992-7140-5c94-a4a0-ab0e5955c37c', 1, 1.0, NULL, false, '1.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('95f60992-7140-5c94-a4a0-ab0e5955c37c', 2, 4.0, NULL, false, '4.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'df0634b5-3edc-54ba-99ab-59e8e654a7d3', '70391ae7-d567-55b9-b91c-3f80e65e3f84', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Max Hughes', '1734', 'individual', 2, 9.0, 9.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '12477850-a120-51e2-84ac-e1d085e8e1e4', 'df0634b5-3edc-54ba-99ab-59e8e654a7d3', '70391ae7-d567-55b9-b91c-3f80e65e3f84', 'Max Hughes', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('df0634b5-3edc-54ba-99ab-59e8e654a7d3', 1, 4.0, NULL, false, '4.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('df0634b5-3edc-54ba-99ab-59e8e654a7d3', 2, 5.0, NULL, false, '5.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '559bab34-b0f7-5592-a967-5db8303dbded', 'c720156e-a4fc-5c44-8505-4ad78bb60d73', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Willow Murray', '1863', 'individual', 3, 10.0, 10.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '30a95645-9c65-5a3a-a997-3314223aa45f', '559bab34-b0f7-5592-a967-5db8303dbded', 'c720156e-a4fc-5c44-8505-4ad78bb60d73', 'Willow Murray', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('559bab34-b0f7-5592-a967-5db8303dbded', 1, 2.0, NULL, false, '2.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('559bab34-b0f7-5592-a967-5db8303dbded', 2, 8.0, NULL, false, '8.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '741f3f7f-6f04-57cd-98a9-d6f833c828c8', 'b259b4fe-9ae6-521b-960b-34da1fe8a554', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Jasmine Wang', '748', 'individual', 4, 14.0, 14.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '05fc604c-7464-56c3-bdb8-9077ed80b618', '741f3f7f-6f04-57cd-98a9-d6f833c828c8', 'b259b4fe-9ae6-521b-960b-34da1fe8a554', 'Jasmine Wang', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('741f3f7f-6f04-57cd-98a9-d6f833c828c8', 1, 12.0, NULL, false, '12.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('741f3f7f-6f04-57cd-98a9-d6f833c828c8', 2, 2.0, NULL, false, '2.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'fce193c1-8e4b-5be5-9c2e-73a748d4ae68', 'ae10ce7d-d964-568b-98ee-3b1f370dc97a', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Jamie Korn', '1666', 'individual', 5, 14.0, 14.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ba053548-3d5c-586d-ba25-a499890204ab', 'fce193c1-8e4b-5be5-9c2e-73a748d4ae68', 'ae10ce7d-d964-568b-98ee-3b1f370dc97a', 'Jamie Korn', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fce193c1-8e4b-5be5-9c2e-73a748d4ae68', 1, 11.0, NULL, false, '11.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fce193c1-8e4b-5be5-9c2e-73a748d4ae68', 2, 3.0, NULL, false, '3.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ffe3143a-366f-589f-a23b-f8b2f1d4cfbb', '53ca59e1-b29b-5fed-acfc-b65407a76960', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Bono Svacek', '1855', 'individual', 6, 15.0, 15.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'aa37f71e-04a2-5a04-8376-97d1dbb37dc1', 'ffe3143a-366f-589f-a23b-f8b2f1d4cfbb', '53ca59e1-b29b-5fed-acfc-b65407a76960', 'Bono Svacek', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ffe3143a-366f-589f-a23b-f8b2f1d4cfbb', 1, 14.0, NULL, false, '14.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ffe3143a-366f-589f-a23b-f8b2f1d4cfbb', 2, 1.0, NULL, false, '1.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '566875ae-01d2-5b18-9427-fe3b72aa9478', '79de686e-027d-5809-99e8-453bfd3cf285', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Miles White', '1432', 'individual', 7, 18.0, 18.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'da03e072-2a43-5cd9-b0dc-a1a709e68c0e', '566875ae-01d2-5b18-9427-fe3b72aa9478', '79de686e-027d-5809-99e8-453bfd3cf285', 'Miles White', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('566875ae-01d2-5b18-9427-fe3b72aa9478', 1, 8.0, NULL, false, '8.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('566875ae-01d2-5b18-9427-fe3b72aa9478', 2, 10.0, NULL, false, '10.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '410e1198-87a8-5728-85ee-2ac0a3bfebb7', '7e5da4f4-8418-5055-b693-11f5551817a5', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Omar Mansour', '1839', 'individual', 8, 20.0, 20.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '88657c8f-870b-5002-afa5-71869b8275ec', '410e1198-87a8-5728-85ee-2ac0a3bfebb7', '7e5da4f4-8418-5055-b693-11f5551817a5', 'Omar Mansour', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('410e1198-87a8-5728-85ee-2ac0a3bfebb7', 1, 3.0, NULL, false, '3.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('410e1198-87a8-5728-85ee-2ac0a3bfebb7', 2, 17.0, NULL, false, '17.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8cbfc893-8aa5-50af-88c1-5ac6bd9acf86', '2c632e1d-c35a-55b3-b30e-fdc04d8824b1', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Maximilian Hultin', '1802', 'individual', 9, 22.0, 22.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5eb3c0f8-5e95-56bf-98d4-b3b862cea8d2', '8cbfc893-8aa5-50af-88c1-5ac6bd9acf86', '2c632e1d-c35a-55b3-b30e-fdc04d8824b1', 'Maximilian Hultin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8cbfc893-8aa5-50af-88c1-5ac6bd9acf86', 1, 13.0, NULL, false, '13.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8cbfc893-8aa5-50af-88c1-5ac6bd9acf86', 2, 9.0, NULL, false, '9.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '277658d7-f9ca-51b8-8e37-b878e81cb0b0', 'cc7c3804-c292-5e08-808b-bcebb191b42a', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Oliver Sun', '1606', 'individual', 10, 27.0, 27.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'cd196668-0e8a-52fa-9d33-027ec7acf8ee', '277658d7-f9ca-51b8-8e37-b878e81cb0b0', 'cc7c3804-c292-5e08-808b-bcebb191b42a', 'Oliver Sun', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('277658d7-f9ca-51b8-8e37-b878e81cb0b0', 1, 16.0, NULL, false, '16.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('277658d7-f9ca-51b8-8e37-b878e81cb0b0', 2, 11.0, NULL, false, '11.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e9149b6a-d2b0-5f30-bea6-03bc2e87cf60', 'ffee66ca-ee78-504e-9fac-f2c556c77843', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Sam Harris', '1914', 'individual', 11, 31.0, 31.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '08f62c56-d35a-5a6b-97d9-f39316fce2e9', 'e9149b6a-d2b0-5f30-bea6-03bc2e87cf60', 'ffee66ca-ee78-504e-9fac-f2c556c77843', 'Sam Harris', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e9149b6a-d2b0-5f30-bea6-03bc2e87cf60', 1, 17.0, NULL, false, '17.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e9149b6a-d2b0-5f30-bea6-03bc2e87cf60', 2, 14.0, NULL, false, '14.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a9736431-ba93-5eae-91d3-25e089a5d56b', '6bb33423-d331-5bde-9731-2e09ea2eba83', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Tom Kefford', '1405', 'individual', 12, 32.0, 32.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'deefaee4-a157-5233-9a1e-f63c27a68caa', 'a9736431-ba93-5eae-91d3-25e089a5d56b', '6bb33423-d331-5bde-9731-2e09ea2eba83', 'Tom Kefford', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a9736431-ba93-5eae-91d3-25e089a5d56b', 1, 26.0, NULL, false, '26.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a9736431-ba93-5eae-91d3-25e089a5d56b', 2, 6.0, NULL, false, '6.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '72155894-9c67-5c2e-aea7-9a38f5ba087c', 'ff8ca5b1-553b-528c-b602-0d79507b82a2', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'William Liu', '1404', 'individual', 13, 32.0, 32.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9022d2a6-f247-5dcf-a3e2-1d7d56ab684d', '72155894-9c67-5c2e-aea7-9a38f5ba087c', 'ff8ca5b1-553b-528c-b602-0d79507b82a2', 'William Liu', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('72155894-9c67-5c2e-aea7-9a38f5ba087c', 1, 9.0, NULL, false, '9.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('72155894-9c67-5c2e-aea7-9a38f5ba087c', 2, 23.0, NULL, false, '23.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3be964d4-1a90-52c3-92b6-5c5c9e130281', '6809147a-acdc-5a68-9d3a-a6ff1f4ecd6e', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Ellery Chai', '1078', 'individual', 14, 35.0, 35.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '09741fd3-037f-51ba-a5fa-3d9c62609c94', '3be964d4-1a90-52c3-92b6-5c5c9e130281', '6809147a-acdc-5a68-9d3a-a6ff1f4ecd6e', 'Ellery Chai', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3be964d4-1a90-52c3-92b6-5c5c9e130281', 1, 5.0, NULL, false, '5.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3be964d4-1a90-52c3-92b6-5c5c9e130281', 2, 30.0, NULL, false, '30.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a3d59cc7-316a-5f81-a2ed-53d8e5611fe6', '5e063632-d6af-5098-9e61-1fbb17c76588', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Jasper Chai', '1348', 'individual', 15, 35.0, 35.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '025802c0-1672-56d4-8c58-069cfb8f1a97', 'a3d59cc7-316a-5f81-a2ed-53d8e5611fe6', '5e063632-d6af-5098-9e61-1fbb17c76588', 'Jasper Chai', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a3d59cc7-316a-5f81-a2ed-53d8e5611fe6', 1, 6.0, NULL, false, '6.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a3d59cc7-316a-5f81-a2ed-53d8e5611fe6', 2, 29.0, NULL, false, '29.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '91d5aede-d5e5-51ba-bdc0-22e070d1e1f6', '9c72b83f-429a-5d68-a220-7f2652aa5f42', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Barrett Fitzmaurice', '1293', 'individual', 16, 36.0, 36.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '005b8677-72ca-5233-aa92-03757253207a', '91d5aede-d5e5-51ba-bdc0-22e070d1e1f6', '9c72b83f-429a-5d68-a220-7f2652aa5f42', 'Barrett Fitzmaurice', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('91d5aede-d5e5-51ba-bdc0-22e070d1e1f6', 1, 29.0, NULL, false, '29.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('91d5aede-d5e5-51ba-bdc0-22e070d1e1f6', 2, 7.0, NULL, false, '7.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a2b04166-a7a3-5dfc-91b4-37cb70a96165', '4c291012-2b60-5f2e-b850-b9e90f0c010c', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Owen OHara', '1248', 'individual', 17, 36.0, 36.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '90632799-726a-52ef-ae0e-ced982664f2f', 'a2b04166-a7a3-5dfc-91b4-37cb70a96165', '4c291012-2b60-5f2e-b850-b9e90f0c010c', 'Owen OHara', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2b04166-a7a3-5dfc-91b4-37cb70a96165', 1, 18.0, NULL, false, '18.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2b04166-a7a3-5dfc-91b4-37cb70a96165', 2, 18.0, NULL, false, '18.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f68429dc-036f-515a-89f9-cbfd14d6c191', 'f26e7a93-7b3f-5b8a-81ab-c5d767424cb8', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Brayden Huang', '679', 'individual', 18, 38.0, 38.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bac60d7b-01a2-5c5a-9bc9-1ccabfeacc2d', 'f68429dc-036f-515a-89f9-cbfd14d6c191', 'f26e7a93-7b3f-5b8a-81ab-c5d767424cb8', 'Brayden Huang', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f68429dc-036f-515a-89f9-cbfd14d6c191', 1, 19.0, NULL, false, '19.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f68429dc-036f-515a-89f9-cbfd14d6c191', 2, 19.0, NULL, false, '19.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c3b6a127-0d86-5c82-81e4-866126261f23', '2552c01d-6467-5dbf-b858-c798384746a4', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'William Lawson', '1139', 'individual', 19, 41.0, 41.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f6acd1b2-a6b5-5fd0-bcb8-983506b1d5f6', 'c3b6a127-0d86-5c82-81e4-866126261f23', '2552c01d-6467-5dbf-b858-c798384746a4', 'William Lawson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3b6a127-0d86-5c82-81e4-866126261f23', 1, 20.0, NULL, false, '20.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3b6a127-0d86-5c82-81e4-866126261f23', 2, 21.0, NULL, false, '21.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'baf53759-c017-52cd-a421-32e8992e89aa', '2db88fe8-74ab-5338-9c7e-5d9977754fed', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'James Moorhead', '1812', 'individual', 20, 42.0, 42.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fffca12d-0ffa-5456-bd0f-46d9b72a30e3', 'baf53759-c017-52cd-a421-32e8992e89aa', '2db88fe8-74ab-5338-9c7e-5d9977754fed', 'James Moorhead', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('baf53759-c017-52cd-a421-32e8992e89aa', 1, 27.0, NULL, false, '27.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('baf53759-c017-52cd-a421-32e8992e89aa', 2, 15.0, NULL, false, '15.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '5548faa4-297b-5b4b-bb5c-3dfe4215094b', 'bab03bca-e72f-5b38-8901-d0aa700a480b', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Alexander Quinn', '1403', 'individual', 21, 43.0, 43.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd8aa4224-50fb-5c3b-99ef-c5a5c5d35e83', '5548faa4-297b-5b4b-bb5c-3dfe4215094b', 'bab03bca-e72f-5b38-8901-d0aa700a480b', 'Alexander Quinn', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5548faa4-297b-5b4b-bb5c-3dfe4215094b', 1, 15.0, NULL, false, '15.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5548faa4-297b-5b4b-bb5c-3dfe4215094b', 2, 28.0, NULL, false, '28.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0d58a609-9a0a-56c5-9b9e-b16401862c79', '579d0ed0-0d0b-5e5e-8ee8-a610dc49defa', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Mila Tait', '1701', 'individual', 22, 44.0, 44.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3f828aab-efda-5d79-8d12-26d26f7d1093', '0d58a609-9a0a-56c5-9b9e-b16401862c79', '579d0ed0-0d0b-5e5e-8ee8-a610dc49defa', 'Mila Tait', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0d58a609-9a0a-56c5-9b9e-b16401862c79', 1, 24.0, NULL, false, '24.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0d58a609-9a0a-56c5-9b9e-b16401862c79', 2, 20.0, NULL, false, '20.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0c21b3d9-7c72-5876-b615-413e345885fc', '3a276e16-704b-5e50-a6ff-99e916ca2757', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Anna Malpas', '535', 'individual', 23, 45.0, 45.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '528fcbf8-9518-51a2-b18b-448dc4a84ef3', '0c21b3d9-7c72-5876-b615-413e345885fc', '3a276e16-704b-5e50-a6ff-99e916ca2757', 'Anna Malpas', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0c21b3d9-7c72-5876-b615-413e345885fc', 1, 33.0, NULL, false, '33.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0c21b3d9-7c72-5876-b615-413e345885fc', 2, 12.0, NULL, false, '12.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '5e8a5aa6-9a30-56b4-81b7-4430838a1fc3', '6f46f86a-da84-5289-b718-711637e49fc5', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Fletcher Royan', '1401', 'individual', 24, 47.0, 47.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '20546f64-8d14-51e0-9921-a83d52755df2', '5e8a5aa6-9a30-56b4-81b7-4430838a1fc3', '6f46f86a-da84-5289-b718-711637e49fc5', 'Fletcher Royan', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5e8a5aa6-9a30-56b4-81b7-4430838a1fc3', 1, 10.0, NULL, false, '10.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5e8a5aa6-9a30-56b4-81b7-4430838a1fc3', 2, 37.0, NULL, false, '37.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3fde76a0-3603-511e-bd51-4ca1fe277da1', '97f0b854-923f-5124-9cfa-8360389bc308', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Ebba Nixey', '1786', 'individual', 25, 47.0, 47.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4edfefcb-d83c-5787-9dee-82b5e6467d9e', '3fde76a0-3603-511e-bd51-4ca1fe277da1', '97f0b854-923f-5124-9cfa-8360389bc308', 'Ebba Nixey', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3fde76a0-3603-511e-bd51-4ca1fe277da1', 1, 21.0, NULL, false, '21.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3fde76a0-3603-511e-bd51-4ca1fe277da1', 2, 26.0, NULL, false, '26.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f2c78a10-473b-5826-8c2a-02c4ab196147', 'd8ff4e35-8040-5c54-8d3c-f943992b3ed5', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Francis Watts', '1766', 'individual', 26, 54.0, 54.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e3b59a54-e4a7-5772-983a-2647afc5b08f', 'f2c78a10-473b-5826-8c2a-02c4ab196147', 'd8ff4e35-8040-5c54-8d3c-f943992b3ed5', 'Francis Watts', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f2c78a10-473b-5826-8c2a-02c4ab196147', 1, 7.0, NULL, false, '7.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f2c78a10-473b-5826-8c2a-02c4ab196147', 2, 47.0, NULL, false, '47.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e04bd35c-c839-5ee4-ac3a-df3f46f1e13d', 'b617fb8a-78ab-58d0-bf6e-6150e954658b', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Alasdair Bonnitcha', '1332', 'individual', 27, 56.0, 56.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2d3d8e92-3e33-572a-9a3a-4f718361b57f', 'e04bd35c-c839-5ee4-ac3a-df3f46f1e13d', 'b617fb8a-78ab-58d0-bf6e-6150e954658b', 'Alasdair Bonnitcha', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e04bd35c-c839-5ee4-ac3a-df3f46f1e13d', 1, 31.0, NULL, false, '31.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e04bd35c-c839-5ee4-ac3a-df3f46f1e13d', 2, 25.0, NULL, false, '25.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'de37e18a-fc99-5b0b-915b-c06f352b5b30', '6b68a537-97d3-5bad-8a4c-e2016f5cc8d2', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Henry Salmon', '1003', 'individual', 28, 57.0, 57.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '109c606d-9eaa-5961-ab29-b664eacbcd58', 'de37e18a-fc99-5b0b-915b-c06f352b5b30', '6b68a537-97d3-5bad-8a4c-e2016f5cc8d2', 'Henry Salmon', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('de37e18a-fc99-5b0b-915b-c06f352b5b30', 1, 44.0, NULL, false, '44.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('de37e18a-fc99-5b0b-915b-c06f352b5b30', 2, 13.0, NULL, false, '13.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '28b63c53-9e69-5160-812a-1195306e28b8', '3ed039ea-653f-5479-ac6b-79c3511aa962', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Thomas Johnson', '948', 'individual', 29, 57.0, 57.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bf034b6c-fb98-5d2f-864b-05196c2678f9', '28b63c53-9e69-5160-812a-1195306e28b8', '3ed039ea-653f-5479-ac6b-79c3511aa962', 'Thomas Johnson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('28b63c53-9e69-5160-812a-1195306e28b8', 1, 22.0, NULL, false, '22.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('28b63c53-9e69-5160-812a-1195306e28b8', 2, 35.0, NULL, false, '35.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '55d172b1-ba3a-5d4b-82d4-6c9f1bfc67e3', '15b5c0ed-ac08-584c-874e-b7d9271dd53a', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Sienna Murray', '1507', 'individual', 30, 58.0, 58.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '42936d0a-26b7-5924-9e80-12fefe3bd180', '55d172b1-ba3a-5d4b-82d4-6c9f1bfc67e3', '15b5c0ed-ac08-584c-874e-b7d9271dd53a', 'Sienna Murray', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55d172b1-ba3a-5d4b-82d4-6c9f1bfc67e3', 1, 34.0, NULL, false, '34.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55d172b1-ba3a-5d4b-82d4-6c9f1bfc67e3', 2, 24.0, NULL, false, '24.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e22590b1-5c23-59e8-817e-a95d82c6ccb9', 'be6e8fd1-74cd-5d69-ba96-c0dff384b40a', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Kai Houtzager', '1325', 'individual', 31, 59.0, 59.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f86947a9-dc0e-5074-8ab6-5f6190f98b29', 'e22590b1-5c23-59e8-817e-a95d82c6ccb9', 'be6e8fd1-74cd-5d69-ba96-c0dff384b40a', 'Kai Houtzager', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e22590b1-5c23-59e8-817e-a95d82c6ccb9', 1, 43.0, NULL, false, '43.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e22590b1-5c23-59e8-817e-a95d82c6ccb9', 2, 16.0, NULL, false, '16.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '31a2262c-7202-5f6f-b426-ac99bee0c037', '9b4f7a85-aa7d-5d77-9cd7-afb06469bc69', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Sylvia Carlson', '1236', 'individual', 32, 60.0, 60.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8a58be30-047f-5234-88cf-471a0677baa8', '31a2262c-7202-5f6f-b426-ac99bee0c037', '9b4f7a85-aa7d-5d77-9cd7-afb06469bc69', 'Sylvia Carlson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('31a2262c-7202-5f6f-b426-ac99bee0c037', 1, 38.0, NULL, false, '38.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('31a2262c-7202-5f6f-b426-ac99bee0c037', 2, 22.0, NULL, false, '22.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0ab0a9af-e290-5042-a98f-ea2cb32825bb', '381285e5-8415-5fde-8418-373f492b9eca', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Sam Hardy', '1481', 'individual', 33, 66.0, 66.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '351d29d5-6384-58f7-9f1f-f86920cd4ff4', '0ab0a9af-e290-5042-a98f-ea2cb32825bb', '381285e5-8415-5fde-8418-373f492b9eca', 'Sam Hardy', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0ab0a9af-e290-5042-a98f-ea2cb32825bb', 1, 35.0, NULL, false, '35.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0ab0a9af-e290-5042-a98f-ea2cb32825bb', 2, 31.0, NULL, false, '31.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3111a965-ebb3-59cd-9d30-0eb02a39855e', '98067f40-3792-57bb-9716-fc7bca16d664', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Molly O''Donnell', '48', 'individual', 34, 66.0, 66.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a90cc0ea-6d7c-56a1-a4fa-ee48d1e98cb7', '3111a965-ebb3-59cd-9d30-0eb02a39855e', '98067f40-3792-57bb-9716-fc7bca16d664', 'Molly O''Donnell', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3111a965-ebb3-59cd-9d30-0eb02a39855e', 1, 32.0, NULL, false, '32.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3111a965-ebb3-59cd-9d30-0eb02a39855e', 2, 34.0, NULL, false, '34.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f68fe213-d644-5423-a0ec-48e9e376f743', '9a2529e7-7c75-52b3-8525-95da0a667384', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Joshua Greenhill', '11', 'individual', 35, 68.0, 68.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0ab3b275-5ed4-5231-bac1-9745c8ac7cf9', 'f68fe213-d644-5423-a0ec-48e9e376f743', '9a2529e7-7c75-52b3-8525-95da0a667384', 'Joshua Greenhill', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f68fe213-d644-5423-a0ec-48e9e376f743', 1, 28.0, NULL, false, '28.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f68fe213-d644-5423-a0ec-48e9e376f743', 2, 40.0, NULL, false, '40.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f2c5cdde-fc11-51e2-9adf-f0f116d7b7ec', 'dd86222a-4380-55f0-b7c9-f727b6f32f65', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Maelyn Gilchrist', '1624', 'individual', 36, 69.0, 69.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '482e083a-2572-52ee-9a9f-f25e7770321e', 'f2c5cdde-fc11-51e2-9adf-f0f116d7b7ec', 'dd86222a-4380-55f0-b7c9-f727b6f32f65', 'Maelyn Gilchrist', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f2c5cdde-fc11-51e2-9adf-f0f116d7b7ec', 1, 25.0, NULL, false, '25.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f2c5cdde-fc11-51e2-9adf-f0f116d7b7ec', 2, 44.0, NULL, false, '44.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'dc0cc072-5b3a-51cd-b2f3-7a9e3e6cba8f', '7e3ae5ad-6c88-5837-b715-9c615305d604', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Dante Iacono', '1828', 'individual', 37, 71.0, 71.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '052cd0c6-192b-5c64-a7df-d51a7367d222', 'dc0cc072-5b3a-51cd-b2f3-7a9e3e6cba8f', '7e3ae5ad-6c88-5837-b715-9c615305d604', 'Dante Iacono', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc0cc072-5b3a-51cd-b2f3-7a9e3e6cba8f', 1, 23.0, NULL, false, '23.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc0cc072-5b3a-51cd-b2f3-7a9e3e6cba8f', 2, 48.0, NULL, false, '48.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3f7dd77b-2c8b-5900-abd5-43e5eacb661a', '23b717b1-7d59-5014-b1ae-3358bf3e8445', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Laura OHara', '1214', 'individual', 38, 72.0, 72.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7f60e568-d6a8-5dfa-aab8-f00848b974f7', '3f7dd77b-2c8b-5900-abd5-43e5eacb661a', '23b717b1-7d59-5014-b1ae-3358bf3e8445', 'Laura OHara', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3f7dd77b-2c8b-5900-abd5-43e5eacb661a', 1, 36.0, NULL, false, '36.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3f7dd77b-2c8b-5900-abd5-43e5eacb661a', 2, 36.0, NULL, false, '36.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b9627700-38c7-5040-90cc-90a71340e2fa', '07397f15-5cbb-54bf-b882-5c77502823a8', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Max Howard', '1831', 'individual', 39, 80.0, 80.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4a816b14-b673-51e5-b688-f9dba0b14e51', 'b9627700-38c7-5040-90cc-90a71340e2fa', '07397f15-5cbb-54bf-b882-5c77502823a8', 'Max Howard', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9627700-38c7-5040-90cc-90a71340e2fa', 1, 48.0, NULL, false, '48.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9627700-38c7-5040-90cc-90a71340e2fa', 2, 32.0, NULL, false, '32.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '27887898-7f87-5bfa-9466-76b793d701ff', '3cf1dd72-3f12-521f-a9be-a8dd0ba7ef0f', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Arthur Douroux', '663', 'individual', 40, 80.0, 80.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5248c15a-374a-537e-9192-b4c761e5ff33', '27887898-7f87-5bfa-9466-76b793d701ff', '3cf1dd72-3f12-521f-a9be-a8dd0ba7ef0f', 'Arthur Douroux', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('27887898-7f87-5bfa-9466-76b793d701ff', 1, 47.0, NULL, false, '47.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('27887898-7f87-5bfa-9466-76b793d701ff', 2, 33.0, NULL, false, '33.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '53de6a5d-5e3b-567b-b688-d99a2dbb20ed', 'e3ddfc45-8f37-5f1c-b3eb-7783f0f82513', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Thomas Douroux', '160', 'individual', 41, 80.0, 80.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '17ff30e4-e9bc-5fe5-8dab-fe02aff3b89d', '53de6a5d-5e3b-567b-b688-d99a2dbb20ed', 'e3ddfc45-8f37-5f1c-b3eb-7783f0f82513', 'Thomas Douroux', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('53de6a5d-5e3b-567b-b688-d99a2dbb20ed', 1, 37.0, NULL, false, '37.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('53de6a5d-5e3b-567b-b688-d99a2dbb20ed', 2, 43.0, NULL, false, '43.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'fb4ec83a-225b-586e-b497-d1e75c5d3b38', 'cb189679-8d27-514b-898e-9dd5c60cdb6e', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Matthias Gasan', '1651', 'individual', 42, 80.0, 80.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8e8e9c06-5c7c-576e-a2a9-d516675157d9', 'fb4ec83a-225b-586e-b497-d1e75c5d3b38', 'cb189679-8d27-514b-898e-9dd5c60cdb6e', 'Matthias Gasan', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fb4ec83a-225b-586e-b497-d1e75c5d3b38', 1, 42.0, NULL, false, '42.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fb4ec83a-225b-586e-b497-d1e75c5d3b38', 2, 38.0, NULL, false, '38.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'eecbc086-ed72-529f-b54e-bf6611739c2f', '94f8a237-a0d6-56f1-8192-eccb7fee71e4', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Joshua Quinn', '534', 'individual', 43, 81.0, 81.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '21ab1748-cb39-5030-828e-b1484e31a37c', 'eecbc086-ed72-529f-b54e-bf6611739c2f', '94f8a237-a0d6-56f1-8192-eccb7fee71e4', 'Joshua Quinn', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eecbc086-ed72-529f-b54e-bf6611739c2f', 1, 39.0, NULL, false, '39.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eecbc086-ed72-529f-b54e-bf6611739c2f', 2, 42.0, NULL, false, '42.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '97e66989-87ae-57c0-8de5-d581d520c67b', '760c5ac0-36bc-5c43-b364-a683b74e088e', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Henry Bolton', '1035', 'individual', 44, 83.0, 83.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '74797bab-9c06-5937-b5f9-63f8a51e25b5', '97e66989-87ae-57c0-8de5-d581d520c67b', '760c5ac0-36bc-5c43-b364-a683b74e088e', 'Henry Bolton', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('97e66989-87ae-57c0-8de5-d581d520c67b', 1, 56.0, 'UFD', false, '56.0 UFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('97e66989-87ae-57c0-8de5-d581d520c67b', 2, 27.0, NULL, false, '27.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7b557f3a-9165-543a-99b9-b949ec175498', '7409f7c8-f1e5-57ae-b7b4-d3ce110f19a9', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Nicholas Hasek', '1761', 'individual', 45, 86.0, 86.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '427370f6-7bac-57ba-bc07-095df29db729', '7b557f3a-9165-543a-99b9-b949ec175498', '7409f7c8-f1e5-57ae-b7b4-d3ce110f19a9', 'Nicholas Hasek', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7b557f3a-9165-543a-99b9-b949ec175498', 1, 30.0, NULL, false, '30.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7b557f3a-9165-543a-99b9-b949ec175498', 2, 56.0, 'DNF', false, '56.0 DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '93e7d47b-9116-566c-a31d-c78e451c65b5', '711dae05-bbdb-59b1-a315-7e93e8870c92', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Jiacheng Liu', '1770', 'individual', 46, 86.0, 86.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9d612699-0fd2-59b0-a6c4-13e08ad43496', '93e7d47b-9116-566c-a31d-c78e451c65b5', '711dae05-bbdb-59b1-a315-7e93e8870c92', 'Jiacheng Liu', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('93e7d47b-9116-566c-a31d-c78e451c65b5', 1, 40.0, NULL, false, '40.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('93e7d47b-9116-566c-a31d-c78e451c65b5', 2, 46.0, NULL, false, '46.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9ca9629d-9fcc-5eb0-84d0-dab585aa02af', '272b09a5-259f-55f5-a8f1-a6ad6d1efdb1', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Samuel Cartmer', '665', 'individual', 47, 90.0, 90.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6510a562-47da-5834-8281-80dcb7c2e037', '9ca9629d-9fcc-5eb0-84d0-dab585aa02af', '272b09a5-259f-55f5-a8f1-a6ad6d1efdb1', 'Samuel Cartmer', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9ca9629d-9fcc-5eb0-84d0-dab585aa02af', 1, 51.0, NULL, false, '51.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9ca9629d-9fcc-5eb0-84d0-dab585aa02af', 2, 39.0, NULL, false, '39.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c8d6eb83-779c-5afc-a72a-1b2fc7e091b7', 'a68e8e7f-d347-5326-a405-7f795be50f87', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Lara Dorling', '1729', 'individual', 48, 90.0, 90.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ae7ccaca-cfd8-505e-9aea-ccef2e7677dc', 'c8d6eb83-779c-5afc-a72a-1b2fc7e091b7', 'a68e8e7f-d347-5326-a405-7f795be50f87', 'Lara Dorling', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c8d6eb83-779c-5afc-a72a-1b2fc7e091b7', 1, 49.0, NULL, false, '49.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c8d6eb83-779c-5afc-a72a-1b2fc7e091b7', 2, 41.0, NULL, false, '41.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '90c0c980-a3bd-5e8b-950f-e7f607d9d40d', '22670cfa-0e57-5cbd-b6b0-aef9a8d515e7', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Olivia Dorling', '372', 'individual', 49, 91.0, 91.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5aad478b-d252-5921-a47e-6ab570414ffd', '90c0c980-a3bd-5e8b-950f-e7f607d9d40d', '22670cfa-0e57-5cbd-b6b0-aef9a8d515e7', 'Olivia Dorling', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90c0c980-a3bd-5e8b-950f-e7f607d9d40d', 1, 46.0, NULL, false, '46.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90c0c980-a3bd-5e8b-950f-e7f607d9d40d', 2, 45.0, NULL, false, '45.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '6be62e8a-0481-5aa9-9080-c380a4b6231c', '31ded344-685d-5597-916d-344220b9cbc0', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Jack Auswild', '1806', 'individual', 50, 92.0, 92.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2aa5f453-6958-5340-92e8-8dbe6a87d145', '6be62e8a-0481-5aa9-9080-c380a4b6231c', '31ded344-685d-5597-916d-344220b9cbc0', 'Jack Auswild', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6be62e8a-0481-5aa9-9080-c380a4b6231c', 1, 41.0, NULL, false, '41.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6be62e8a-0481-5aa9-9080-c380a4b6231c', 2, 51.0, NULL, false, '51.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1ef152be-7c11-5457-8c98-fbcd844bcce1', '6b1c5ca4-6db9-51ea-b461-86a6503f50c8', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Jamie Lin', '1642', 'individual', 51, 101.0, 101.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'dbe63e57-9205-5b25-88c2-b7584f4411c4', '1ef152be-7c11-5457-8c98-fbcd844bcce1', '6b1c5ca4-6db9-51ea-b461-86a6503f50c8', 'Jamie Lin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1ef152be-7c11-5457-8c98-fbcd844bcce1', 1, 45.0, NULL, false, '45.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1ef152be-7c11-5457-8c98-fbcd844bcce1', 2, 56.0, 'UFD', false, '56.0 UFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '17357514-4a9a-5cbc-8ff0-c98bb3fa72c3', '7f6a70db-bca7-5a07-8a00-b233c8acd2c9', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Maisie Borg', '1590', 'individual', 52, 102.0, 102.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b8d9b580-45d8-5310-ba37-cea8a3f71db9', '17357514-4a9a-5cbc-8ff0-c98bb3fa72c3', '7f6a70db-bca7-5a07-8a00-b233c8acd2c9', 'Maisie Borg', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('17357514-4a9a-5cbc-8ff0-c98bb3fa72c3', 1, 53.0, NULL, false, '53.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('17357514-4a9a-5cbc-8ff0-c98bb3fa72c3', 2, 49.0, NULL, false, '49.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9932fe46-18e9-57e4-bd04-4226c0dc0eea', '83bb6bcc-ed37-5b46-8841-dce66870fc3a', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Eamon Strong', '1296', 'individual', 53, 102.0, 102.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fc75e67d-ade9-5ccb-8a83-87fd7dfb23d4', '9932fe46-18e9-57e4-bd04-4226c0dc0eea', '83bb6bcc-ed37-5b46-8841-dce66870fc3a', 'Eamon Strong', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9932fe46-18e9-57e4-bd04-4226c0dc0eea', 1, 52.0, NULL, false, '52.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9932fe46-18e9-57e4-bd04-4226c0dc0eea', 2, 50.0, NULL, false, '50.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0c9039dc-0e50-5c34-9df1-2c7955dee329', '228d609a-0e30-523f-ab39-4f8a4181bde0', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Oscar Griffin', '1832', 'individual', 54, 106.0, 106.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'faf8782e-f2ec-5555-a284-ce7098e1a8bf', '0c9039dc-0e50-5c34-9df1-2c7955dee329', '228d609a-0e30-523f-ab39-4f8a4181bde0', 'Oscar Griffin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0c9039dc-0e50-5c34-9df1-2c7955dee329', 1, 50.0, NULL, false, '50.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0c9039dc-0e50-5c34-9df1-2c7955dee329', 2, 56.0, 'DNS', false, '56.0 DNS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '71978fd1-f7b0-5b1b-bd83-4f38964707db', '0f1dbaf1-c074-5cba-9abc-c91bdde4434f', 'cae865eb-9b5a-5988-aeb3-4443130a307d', 'Amelia McKelvey', '162', 'individual', 55, 112.0, 112.0,
    false, false, 'https://www.sailwave.com/results/states26.htm', 'https://www.sailwave.com/results/states26.htm', 'Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club', 'url', 'Official published results from Sailwave results for NSW Optimist Championship 2026 at Royal Prince Alfred Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '597f14c5-3df7-58b1-a3ac-c0dd205670e9', '71978fd1-f7b0-5b1b-bd83-4f38964707db', '0f1dbaf1-c074-5cba-9abc-c91bdde4434f', 'Amelia McKelvey', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('71978fd1-f7b0-5b1b-bd83-4f38964707db', 1, 56.0, 'DNC', false, '56.0 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('71978fd1-f7b0-5b1b-bd83-4f38964707db', 2, 56.0, 'DNC', false, '56.0 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 ACT Optimist Championship — Open Fleet (27 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'eb2698ed-ebc6-56e1-a97b-4ba0f4d918c3', '5a61d861-917e-55b9-85db-9c122fcc9183', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Luca De Giosa', '1920', 'individual', 1, 17.0, 10.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e526cf71-f621-5917-bb22-4e7d3e93edf5', 'eb2698ed-ebc6-56e1-a97b-4ba0f4d918c3', '5a61d861-917e-55b9-85db-9c122fcc9183', 'Luca De Giosa', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eb2698ed-ebc6-56e1-a97b-4ba0f4d918c3', 1, 1.0, NULL, false, '1.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eb2698ed-ebc6-56e1-a97b-4ba0f4d918c3', 2, 5.0, NULL, false, '5.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eb2698ed-ebc6-56e1-a97b-4ba0f4d918c3', 3, 1.0, NULL, false, '1.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eb2698ed-ebc6-56e1-a97b-4ba0f4d918c3', 4, 1.0, NULL, false, '1.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eb2698ed-ebc6-56e1-a97b-4ba0f4d918c3', 5, 7.0, NULL, true, '(7.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eb2698ed-ebc6-56e1-a97b-4ba0f4d918c3', 6, 1.0, NULL, false, '1.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eb2698ed-ebc6-56e1-a97b-4ba0f4d918c3', 7, 1.0, NULL, false, '1.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0e76403a-23b5-5b39-b17e-701318b34369', '1b22f933-9817-4f8b-a366-11315c5bc283', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Lucy Lin', '1938', 'individual', 2, 44.0, 33.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '04c4b370-61f4-557e-9f6a-30407173808e', '0e76403a-23b5-5b39-b17e-701318b34369', '1b22f933-9817-4f8b-a366-11315c5bc283', 'Lucy Lin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0e76403a-23b5-5b39-b17e-701318b34369', 1, 9.0, NULL, false, '9.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0e76403a-23b5-5b39-b17e-701318b34369', 2, 3.0, NULL, false, '3.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0e76403a-23b5-5b39-b17e-701318b34369', 3, 11.0, NULL, true, '(11.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0e76403a-23b5-5b39-b17e-701318b34369', 4, 3.0, NULL, false, '3.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0e76403a-23b5-5b39-b17e-701318b34369', 5, 4.0, NULL, false, '4.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0e76403a-23b5-5b39-b17e-701318b34369', 6, 8.0, NULL, false, '8.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0e76403a-23b5-5b39-b17e-701318b34369', 7, 6.0, NULL, false, '6.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '6287c874-983e-5712-8b26-d740894f8101', 'e2a4b0c4-c2cc-4a03-b198-6378b590fc0b', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Sebastian Cheng', '1491', 'individual', 3, 46.0, 35.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2acc3cac-eb5b-5b37-be57-6d6fd583a450', '6287c874-983e-5712-8b26-d740894f8101', 'e2a4b0c4-c2cc-4a03-b198-6378b590fc0b', 'Sebastian Cheng', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6287c874-983e-5712-8b26-d740894f8101', 1, 8.0, NULL, false, '8.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6287c874-983e-5712-8b26-d740894f8101', 2, 1.0, NULL, false, '1.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6287c874-983e-5712-8b26-d740894f8101', 3, 7.0, NULL, false, '7.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6287c874-983e-5712-8b26-d740894f8101', 4, 11.0, NULL, true, '(11.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6287c874-983e-5712-8b26-d740894f8101', 5, 3.0, NULL, false, '3.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6287c874-983e-5712-8b26-d740894f8101', 6, 11.0, NULL, false, '11.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6287c874-983e-5712-8b26-d740894f8101', 7, 5.0, NULL, false, '5.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'bfa9286d-e5f5-57c2-a434-ef6dd899d83a', '30880421-1dc4-4a14-9c6b-8c00de39e4d8', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Tom Griffiths', '1744', 'individual', 4, 46.0, 35.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4c6cdf28-2922-5e5c-abf3-9e4898cbcc84', 'bfa9286d-e5f5-57c2-a434-ef6dd899d83a', '30880421-1dc4-4a14-9c6b-8c00de39e4d8', 'Tom Griffiths', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bfa9286d-e5f5-57c2-a434-ef6dd899d83a', 1, 11.0, NULL, true, '(11.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bfa9286d-e5f5-57c2-a434-ef6dd899d83a', 2, 4.0, NULL, false, '4.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bfa9286d-e5f5-57c2-a434-ef6dd899d83a', 3, 8.0, NULL, false, '8.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bfa9286d-e5f5-57c2-a434-ef6dd899d83a', 4, 7.0, NULL, false, '7.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bfa9286d-e5f5-57c2-a434-ef6dd899d83a', 5, 5.0, NULL, false, '5.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bfa9286d-e5f5-57c2-a434-ef6dd899d83a', 6, 3.0, NULL, false, '3.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bfa9286d-e5f5-57c2-a434-ef6dd899d83a', 7, 8.0, NULL, false, '8.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '43cea3fe-1f14-5662-9d20-3abf1ba2a01d', 'b2f3bfeb-f969-518e-b631-70da18fadc0d', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'William Harris', '1932', 'individual', 5, 49.0, 37.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '15415f44-07d8-5cb0-a358-9c66f248aa6e', '43cea3fe-1f14-5662-9d20-3abf1ba2a01d', 'b2f3bfeb-f969-518e-b631-70da18fadc0d', 'William Harris', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('43cea3fe-1f14-5662-9d20-3abf1ba2a01d', 1, 2.0, NULL, false, '2.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('43cea3fe-1f14-5662-9d20-3abf1ba2a01d', 2, 11.0, NULL, false, '11.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('43cea3fe-1f14-5662-9d20-3abf1ba2a01d', 3, 9.0, NULL, false, '9.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('43cea3fe-1f14-5662-9d20-3abf1ba2a01d', 4, 10.0, NULL, false, '10.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('43cea3fe-1f14-5662-9d20-3abf1ba2a01d', 5, 2.0, NULL, false, '2.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('43cea3fe-1f14-5662-9d20-3abf1ba2a01d', 6, 12.0, NULL, true, '(12.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('43cea3fe-1f14-5662-9d20-3abf1ba2a01d', 7, 3.0, NULL, false, '3.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd94272b1-4ec3-5b8b-893e-bb3f15d4d884', '2e005437-68a4-51ab-bc8b-d377f51d55eb', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Balthazar Roche', '1931', 'individual', 6, 51.0, 37.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a1241fda-3263-536e-902b-953efa1a046a', 'd94272b1-4ec3-5b8b-893e-bb3f15d4d884', '2e005437-68a4-51ab-bc8b-d377f51d55eb', 'Balthazar Roche', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d94272b1-4ec3-5b8b-893e-bb3f15d4d884', 1, 13.0, NULL, false, '13.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d94272b1-4ec3-5b8b-893e-bb3f15d4d884', 2, 8.0, NULL, false, '8.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d94272b1-4ec3-5b8b-893e-bb3f15d4d884', 3, 4.0, NULL, false, '4.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d94272b1-4ec3-5b8b-893e-bb3f15d4d884', 4, 2.0, NULL, false, '2.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d94272b1-4ec3-5b8b-893e-bb3f15d4d884', 5, 8.0, NULL, false, '8.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d94272b1-4ec3-5b8b-893e-bb3f15d4d884', 6, 14.0, NULL, true, '(14.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d94272b1-4ec3-5b8b-893e-bb3f15d4d884', 7, 2.0, NULL, false, '2.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '047ed4c4-928e-5784-9240-88acf01aead2', '0f1eb283-e53c-533e-8113-55753e658647', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Emma Tomkins', '1781', 'individual', 7, 53.0, 38.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a262f504-7429-5527-a740-cc7c39f600bd', '047ed4c4-928e-5784-9240-88acf01aead2', '0f1eb283-e53c-533e-8113-55753e658647', 'Emma Tomkins', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('047ed4c4-928e-5784-9240-88acf01aead2', 1, 10.0, NULL, false, '10.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('047ed4c4-928e-5784-9240-88acf01aead2', 2, 15.0, NULL, true, '(15.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('047ed4c4-928e-5784-9240-88acf01aead2', 3, 12.0, NULL, false, '12.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('047ed4c4-928e-5784-9240-88acf01aead2', 4, 4.0, NULL, false, '4.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('047ed4c4-928e-5784-9240-88acf01aead2', 5, 1.0, NULL, false, '1.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('047ed4c4-928e-5784-9240-88acf01aead2', 6, 4.0, NULL, false, '4.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('047ed4c4-928e-5784-9240-88acf01aead2', 7, 7.0, NULL, false, '7.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2fda8317-e138-50be-bc47-f7489b51d174', '6e620e7e-5678-525f-8760-caaacf2266a9', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Emerald Jacobsen', '1846', 'individual', 8, 59.0, 45.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '77da953a-72bc-57f7-a95d-37c5236c6f7a', '2fda8317-e138-50be-bc47-f7489b51d174', '6e620e7e-5678-525f-8760-caaacf2266a9', 'Emerald Jacobsen', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2fda8317-e138-50be-bc47-f7489b51d174', 1, 14.0, NULL, true, '(14.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2fda8317-e138-50be-bc47-f7489b51d174', 2, 13.0, NULL, false, '13.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2fda8317-e138-50be-bc47-f7489b51d174', 3, 14.0, NULL, false, '14.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2fda8317-e138-50be-bc47-f7489b51d174', 4, 6.0, NULL, false, '6.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2fda8317-e138-50be-bc47-f7489b51d174', 5, 6.0, NULL, false, '6.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2fda8317-e138-50be-bc47-f7489b51d174', 6, 2.0, NULL, false, '2.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2fda8317-e138-50be-bc47-f7489b51d174', 7, 4.0, NULL, false, '4.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '95b768b9-cfc9-5637-bbda-ccf3e32acf74', 'cc7c3804-c292-5e08-808b-bcebb191b42a', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Oliver Sun', '1606', 'individual', 9, 79.0, 53.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a566cae2-3b68-56e9-b8e9-158c88eb8d48', '95b768b9-cfc9-5637-bbda-ccf3e32acf74', 'cc7c3804-c292-5e08-808b-bcebb191b42a', 'Oliver Sun', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('95b768b9-cfc9-5637-bbda-ccf3e32acf74', 1, 26.0, NULL, true, '(26.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('95b768b9-cfc9-5637-bbda-ccf3e32acf74', 2, 12.0, NULL, false, '12.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('95b768b9-cfc9-5637-bbda-ccf3e32acf74', 3, 3.0, NULL, false, '3.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('95b768b9-cfc9-5637-bbda-ccf3e32acf74', 4, 5.0, NULL, false, '5.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('95b768b9-cfc9-5637-bbda-ccf3e32acf74', 5, 15.0, NULL, false, '15.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('95b768b9-cfc9-5637-bbda-ccf3e32acf74', 6, 9.0, NULL, false, '9.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('95b768b9-cfc9-5637-bbda-ccf3e32acf74', 7, 9.0, NULL, false, '9.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e3c98173-9471-53dd-b574-7e0efb0c257e', 'a8621760-ffb6-4283-8e2e-12bb7890d8a4', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Seb Tucker', '1771', 'individual', 10, 73.0, 55.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ae2fef0d-6163-50d7-a0b8-4c4f9b291ae2', 'e3c98173-9471-53dd-b574-7e0efb0c257e', 'a8621760-ffb6-4283-8e2e-12bb7890d8a4', 'Seb Tucker', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3c98173-9471-53dd-b574-7e0efb0c257e', 1, 7.0, NULL, false, '7.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3c98173-9471-53dd-b574-7e0efb0c257e', 2, 10.0, NULL, false, '10.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3c98173-9471-53dd-b574-7e0efb0c257e', 3, 6.0, NULL, false, '6.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3c98173-9471-53dd-b574-7e0efb0c257e', 4, 9.0, NULL, false, '9.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3c98173-9471-53dd-b574-7e0efb0c257e', 5, 12.0, NULL, false, '12.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3c98173-9471-53dd-b574-7e0efb0c257e', 6, 18.0, NULL, true, '(18.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3c98173-9471-53dd-b574-7e0efb0c257e', 7, 11.0, NULL, false, '11.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '924d4c5c-01ae-5328-816b-bf0b37cff90a', '325b400d-1092-4711-b769-29b16989ea35', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Aurelia Wilson', '1941', 'individual', 11, 72.0, 56.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a24bd28c-2b60-5e78-b9cb-7b99406e422a', '924d4c5c-01ae-5328-816b-bf0b37cff90a', '325b400d-1092-4711-b769-29b16989ea35', 'Aurelia Wilson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('924d4c5c-01ae-5328-816b-bf0b37cff90a', 1, 6.0, NULL, false, '6.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('924d4c5c-01ae-5328-816b-bf0b37cff90a', 2, 7.0, NULL, false, '7.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('924d4c5c-01ae-5328-816b-bf0b37cff90a', 3, 15.0, NULL, false, '15.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('924d4c5c-01ae-5328-816b-bf0b37cff90a', 4, 16.0, NULL, true, '(16.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('924d4c5c-01ae-5328-816b-bf0b37cff90a', 5, 9.0, NULL, false, '9.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('924d4c5c-01ae-5328-816b-bf0b37cff90a', 6, 6.0, NULL, false, '6.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('924d4c5c-01ae-5328-816b-bf0b37cff90a', 7, 13.0, NULL, false, '13.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '55ee6fe3-fdd6-590e-8d39-3b0b7866111b', '8ffb1e6b-203c-4bab-ac2f-18de1db064b7', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Heidi Sinclair-Hill', '1364', 'individual', 12, 82.0, 58.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4fe23af5-f19f-56b7-8465-59501ae7d682', '55ee6fe3-fdd6-590e-8d39-3b0b7866111b', '8ffb1e6b-203c-4bab-ac2f-18de1db064b7', 'Heidi Sinclair-Hill', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55ee6fe3-fdd6-590e-8d39-3b0b7866111b', 1, 4.0, NULL, false, '4.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55ee6fe3-fdd6-590e-8d39-3b0b7866111b', 2, 2.0, NULL, false, '2.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55ee6fe3-fdd6-590e-8d39-3b0b7866111b', 3, 19.0, NULL, false, '19.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55ee6fe3-fdd6-590e-8d39-3b0b7866111b', 4, 14.0, NULL, false, '14.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55ee6fe3-fdd6-590e-8d39-3b0b7866111b', 5, 24.0, NULL, true, '(24.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55ee6fe3-fdd6-590e-8d39-3b0b7866111b', 6, 5.0, NULL, false, '5.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55ee6fe3-fdd6-590e-8d39-3b0b7866111b', 7, 14.0, NULL, false, '14.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8a5fbecd-3ffe-502a-b05d-69add2b5be49', '31374565-e925-521a-a074-93c0d364cbc2', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Zac Boyd', '1753', 'individual', 13, 93.0, 65.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c5d961a7-de91-504a-a99a-1f0db86088e0', '8a5fbecd-3ffe-502a-b05d-69add2b5be49', '31374565-e925-521a-a074-93c0d364cbc2', 'Zac Boyd', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a5fbecd-3ffe-502a-b05d-69add2b5be49', 1, 3.0, NULL, false, '3.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a5fbecd-3ffe-502a-b05d-69add2b5be49', 2, 6.0, NULL, false, '6.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a5fbecd-3ffe-502a-b05d-69add2b5be49', 3, 2.0, NULL, false, '2.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a5fbecd-3ffe-502a-b05d-69add2b5be49', 4, 8.0, NULL, false, '8.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a5fbecd-3ffe-502a-b05d-69add2b5be49', 5, 26.0, NULL, false, '26.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a5fbecd-3ffe-502a-b05d-69add2b5be49', 6, 20.0, NULL, false, '20.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a5fbecd-3ffe-502a-b05d-69add2b5be49', 7, 28.0, 'DNF', true, '(28.0 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2817238d-4e88-5d67-97e9-e2b3d66d8ac8', '7411c058-0e0a-5a5d-aa05-fb3bd9edc4aa', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Mac Darlington', '1879', 'individual', 14, 104.0, 79.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2dd82590-33dc-53af-b1db-0116a1c46586', '2817238d-4e88-5d67-97e9-e2b3d66d8ac8', '7411c058-0e0a-5a5d-aa05-fb3bd9edc4aa', 'Mac Darlington', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2817238d-4e88-5d67-97e9-e2b3d66d8ac8', 1, 12.0, NULL, false, '12.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2817238d-4e88-5d67-97e9-e2b3d66d8ac8', 2, 25.0, NULL, true, '(25.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2817238d-4e88-5d67-97e9-e2b3d66d8ac8', 3, 18.0, NULL, false, '18.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2817238d-4e88-5d67-97e9-e2b3d66d8ac8', 4, 13.0, NULL, false, '13.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2817238d-4e88-5d67-97e9-e2b3d66d8ac8', 5, 10.0, NULL, false, '10.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2817238d-4e88-5d67-97e9-e2b3d66d8ac8', 6, 10.0, NULL, false, '10.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2817238d-4e88-5d67-97e9-e2b3d66d8ac8', 7, 16.0, NULL, false, '16.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '892715e9-14df-56d6-bbbb-e0f8edc7de85', '15b30f88-d7b3-45f1-b9c2-a59c9972101b', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Orlando Watts', '1943', 'individual', 15, 107.0, 83.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '17278fc4-e152-5ee8-a87b-744bc9e7c054', '892715e9-14df-56d6-bbbb-e0f8edc7de85', '15b30f88-d7b3-45f1-b9c2-a59c9972101b', 'Orlando Watts', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('892715e9-14df-56d6-bbbb-e0f8edc7de85', 1, 24.0, NULL, true, '(24.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('892715e9-14df-56d6-bbbb-e0f8edc7de85', 2, 24.0, NULL, false, '24.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('892715e9-14df-56d6-bbbb-e0f8edc7de85', 3, 17.0, NULL, false, '17.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('892715e9-14df-56d6-bbbb-e0f8edc7de85', 4, 12.0, NULL, false, '12.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('892715e9-14df-56d6-bbbb-e0f8edc7de85', 5, 11.0, NULL, false, '11.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('892715e9-14df-56d6-bbbb-e0f8edc7de85', 6, 7.0, NULL, false, '7.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('892715e9-14df-56d6-bbbb-e0f8edc7de85', 7, 12.0, NULL, false, '12.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '82a7846d-d62b-51b5-88ab-26d756352b04', '53ca59e1-b29b-5fed-acfc-b65407a76960', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Bono Svacek', '1855', 'individual', 16, 113.0, 91.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8b9fd8eb-3aa6-5df3-80d3-1fda6ba87444', '82a7846d-d62b-51b5-88ab-26d756352b04', '53ca59e1-b29b-5fed-acfc-b65407a76960', 'Bono Svacek', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82a7846d-d62b-51b5-88ab-26d756352b04', 1, 15.0, NULL, false, '15.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82a7846d-d62b-51b5-88ab-26d756352b04', 2, 20.0, NULL, false, '20.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82a7846d-d62b-51b5-88ab-26d756352b04', 3, 22.0, NULL, true, '(22.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82a7846d-d62b-51b5-88ab-26d756352b04', 4, 19.0, NULL, false, '19.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82a7846d-d62b-51b5-88ab-26d756352b04', 5, 14.0, NULL, false, '14.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82a7846d-d62b-51b5-88ab-26d756352b04', 6, 13.0, NULL, false, '13.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82a7846d-d62b-51b5-88ab-26d756352b04', 7, 10.0, NULL, false, '10.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8d78203e-2b2d-56d0-b76c-9aa26537e669', '045b2495-820a-5df1-b744-8439ea2e3d13', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Edward Payne', '1627', 'individual', 17, 121.0, 100.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '787d175f-4549-5950-9ec6-ec0e91028182', '8d78203e-2b2d-56d0-b76c-9aa26537e669', '045b2495-820a-5df1-b744-8439ea2e3d13', 'Edward Payne', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8d78203e-2b2d-56d0-b76c-9aa26537e669', 1, 19.0, NULL, false, '19.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8d78203e-2b2d-56d0-b76c-9aa26537e669', 2, 21.0, NULL, true, '(21.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8d78203e-2b2d-56d0-b76c-9aa26537e669', 3, 13.0, NULL, false, '13.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8d78203e-2b2d-56d0-b76c-9aa26537e669', 4, 15.0, NULL, false, '15.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8d78203e-2b2d-56d0-b76c-9aa26537e669', 5, 13.0, NULL, false, '13.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8d78203e-2b2d-56d0-b76c-9aa26537e669', 6, 21.0, NULL, false, '21.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8d78203e-2b2d-56d0-b76c-9aa26537e669', 7, 19.0, NULL, false, '19.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '742f4619-6c57-54ae-bbff-02df43586205', '70391ae7-d567-55b9-b91c-3f80e65e3f84', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Max Hughes', '1734', 'individual', 18, 120.0, 100.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '816a5a41-a86a-54ec-9463-42a081704160', '742f4619-6c57-54ae-bbff-02df43586205', '70391ae7-d567-55b9-b91c-3f80e65e3f84', 'Max Hughes', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('742f4619-6c57-54ae-bbff-02df43586205', 1, 16.0, NULL, false, '16.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('742f4619-6c57-54ae-bbff-02df43586205', 2, 18.0, NULL, false, '18.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('742f4619-6c57-54ae-bbff-02df43586205', 3, 16.0, NULL, false, '16.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('742f4619-6c57-54ae-bbff-02df43586205', 4, 17.0, NULL, false, '17.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('742f4619-6c57-54ae-bbff-02df43586205', 5, 18.0, NULL, false, '18.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('742f4619-6c57-54ae-bbff-02df43586205', 6, 15.0, NULL, false, '15.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('742f4619-6c57-54ae-bbff-02df43586205', 7, 20.0, NULL, true, '(20.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a38151fc-f23b-5ce6-a7cf-0db2b90fbbc0', '7b929e9d-7925-4705-94ab-d175a82bb610', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Kalle Gravare', '1929', 'individual', 19, 136.0, 108.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'dbb5b66a-6632-5899-a7d9-0f2601ee8fd7', 'a38151fc-f23b-5ce6-a7cf-0db2b90fbbc0', '7b929e9d-7925-4705-94ab-d175a82bb610', 'Kalle Gravare', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a38151fc-f23b-5ce6-a7cf-0db2b90fbbc0', 1, 5.0, NULL, false, '5.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a38151fc-f23b-5ce6-a7cf-0db2b90fbbc0', 2, 14.0, NULL, false, '14.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a38151fc-f23b-5ce6-a7cf-0db2b90fbbc0', 3, 5.0, NULL, false, '5.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a38151fc-f23b-5ce6-a7cf-0db2b90fbbc0', 4, 28.0, 'DNC', true, '(28.0 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a38151fc-f23b-5ce6-a7cf-0db2b90fbbc0', 5, 28.0, 'DNC', false, '28.0 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a38151fc-f23b-5ce6-a7cf-0db2b90fbbc0', 6, 28.0, 'DNC', false, '28.0 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a38151fc-f23b-5ce6-a7cf-0db2b90fbbc0', 7, 28.0, 'DNC', false, '28.0 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '570771ca-8110-5f94-9539-3535e3131ded', 'a0364f92-dc90-5d0c-b4db-8fc31981c619', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Marin Christodoulou Le Gac', '1600', 'individual', 20, 133.0, 110.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '30550c3b-7046-5b83-b55f-f3496cb47675', '570771ca-8110-5f94-9539-3535e3131ded', 'a0364f92-dc90-5d0c-b4db-8fc31981c619', 'Marin Christodoulou Le Gac', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('570771ca-8110-5f94-9539-3535e3131ded', 1, 23.0, NULL, true, '(23.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('570771ca-8110-5f94-9539-3535e3131ded', 2, 19.0, NULL, false, '19.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('570771ca-8110-5f94-9539-3535e3131ded', 3, 10.0, NULL, false, '10.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('570771ca-8110-5f94-9539-3535e3131ded', 4, 18.0, NULL, false, '18.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('570771ca-8110-5f94-9539-3535e3131ded', 5, 23.0, NULL, false, '23.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('570771ca-8110-5f94-9539-3535e3131ded', 6, 17.0, NULL, false, '17.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('570771ca-8110-5f94-9539-3535e3131ded', 7, 23.0, NULL, false, '23.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '029f77ee-9cfe-5e7e-82af-372ec2fcc413', 'd6485671-0de9-5522-b3de-262e2cc27a13', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Courtney Harrison', '1735', 'individual', 21, 137.0, 112.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e41afcc0-ea67-5a99-8db7-f170d547961d', '029f77ee-9cfe-5e7e-82af-372ec2fcc413', 'd6485671-0de9-5522-b3de-262e2cc27a13', 'Courtney Harrison', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('029f77ee-9cfe-5e7e-82af-372ec2fcc413', 1, 17.0, NULL, false, '17.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('029f77ee-9cfe-5e7e-82af-372ec2fcc413', 2, 16.0, NULL, false, '16.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('029f77ee-9cfe-5e7e-82af-372ec2fcc413', 3, 20.0, NULL, false, '20.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('029f77ee-9cfe-5e7e-82af-372ec2fcc413', 4, 22.0, NULL, false, '22.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('029f77ee-9cfe-5e7e-82af-372ec2fcc413', 5, 16.0, NULL, false, '16.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('029f77ee-9cfe-5e7e-82af-372ec2fcc413', 6, 25.0, NULL, true, '(25.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('029f77ee-9cfe-5e7e-82af-372ec2fcc413', 7, 21.0, NULL, false, '21.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a797a1db-ba78-530d-baac-09d4c54a2b6c', 'b259b4fe-9ae6-521b-960b-34da1fe8a554', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Jasmine Wang', '748', 'individual', 22, 144.0, 120.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '56d77655-8d6a-5bc5-b912-8590f6666188', 'a797a1db-ba78-530d-baac-09d4c54a2b6c', 'b259b4fe-9ae6-521b-960b-34da1fe8a554', 'Jasmine Wang', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a797a1db-ba78-530d-baac-09d4c54a2b6c', 1, 22.0, NULL, false, '22.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a797a1db-ba78-530d-baac-09d4c54a2b6c', 2, 22.0, NULL, false, '22.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a797a1db-ba78-530d-baac-09d4c54a2b6c', 3, 21.0, NULL, false, '21.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a797a1db-ba78-530d-baac-09d4c54a2b6c', 4, 24.0, NULL, true, '(24.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a797a1db-ba78-530d-baac-09d4c54a2b6c', 5, 17.0, NULL, false, '17.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a797a1db-ba78-530d-baac-09d4c54a2b6c', 6, 23.0, NULL, false, '23.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a797a1db-ba78-530d-baac-09d4c54a2b6c', 7, 15.0, NULL, false, '15.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3ca11a66-5324-5b20-969e-5971056bf4d0', 'e69e8c1b-a4f5-5f59-903b-b857e6a5cc5c', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Sebastian Salter', '1944', 'individual', 23, 145.0, 120.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f6a77b88-b0a4-5fce-a3e0-7c52a42ea425', '3ca11a66-5324-5b20-969e-5971056bf4d0', 'e69e8c1b-a4f5-5f59-903b-b857e6a5cc5c', 'Sebastian Salter', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ca11a66-5324-5b20-969e-5971056bf4d0', 1, 18.0, NULL, false, '18.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ca11a66-5324-5b20-969e-5971056bf4d0', 2, 17.0, NULL, false, '17.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ca11a66-5324-5b20-969e-5971056bf4d0', 3, 25.0, NULL, true, '(25.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ca11a66-5324-5b20-969e-5971056bf4d0', 4, 23.0, NULL, false, '23.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ca11a66-5324-5b20-969e-5971056bf4d0', 5, 20.0, NULL, false, '20.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ca11a66-5324-5b20-969e-5971056bf4d0', 6, 24.0, NULL, false, '24.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ca11a66-5324-5b20-969e-5971056bf4d0', 7, 18.0, NULL, false, '18.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f76cbe66-6cbe-5c96-9ca5-ffa4c9096413', '79de686e-027d-5809-99e8-453bfd3cf285', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Miles White', '1882', 'individual', 24, 150.0, 123.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7457875b-9522-59f4-9b4d-dec0f52274b3', 'f76cbe66-6cbe-5c96-9ca5-ffa4c9096413', '79de686e-027d-5809-99e8-453bfd3cf285', 'Miles White', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f76cbe66-6cbe-5c96-9ca5-ffa4c9096413', 1, 20.0, NULL, false, '20.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f76cbe66-6cbe-5c96-9ca5-ffa4c9096413', 2, 9.0, NULL, false, '9.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f76cbe66-6cbe-5c96-9ca5-ffa4c9096413', 3, 27.0, NULL, true, '(27.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f76cbe66-6cbe-5c96-9ca5-ffa4c9096413', 4, 25.0, NULL, false, '25.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f76cbe66-6cbe-5c96-9ca5-ffa4c9096413', 5, 25.0, NULL, false, '25.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f76cbe66-6cbe-5c96-9ca5-ffa4c9096413', 6, 22.0, NULL, false, '22.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f76cbe66-6cbe-5c96-9ca5-ffa4c9096413', 7, 22.0, NULL, false, '22.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2a7e227f-9a52-5b6e-8ce5-37d037ec5996', '6bb33423-d331-5bde-9731-2e09ea2eba83', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Tom Kefford', '1405', 'individual', 25, 149.0, 123.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '83a3eaef-baae-52ec-8207-ff4ce492e9a8', '2a7e227f-9a52-5b6e-8ce5-37d037ec5996', '6bb33423-d331-5bde-9731-2e09ea2eba83', 'Tom Kefford', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2a7e227f-9a52-5b6e-8ce5-37d037ec5996', 1, 21.0, NULL, false, '21.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2a7e227f-9a52-5b6e-8ce5-37d037ec5996', 2, 26.0, NULL, true, '(26.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2a7e227f-9a52-5b6e-8ce5-37d037ec5996', 3, 24.0, NULL, false, '24.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2a7e227f-9a52-5b6e-8ce5-37d037ec5996', 4, 26.0, NULL, false, '26.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2a7e227f-9a52-5b6e-8ce5-37d037ec5996', 5, 19.0, NULL, false, '19.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2a7e227f-9a52-5b6e-8ce5-37d037ec5996', 6, 16.0, NULL, false, '16.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2a7e227f-9a52-5b6e-8ce5-37d037ec5996', 7, 17.0, NULL, false, '17.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'cc5410b7-7af5-5e77-80b0-960dadbb0c48', '2552c01d-6467-5dbf-b858-c798384746a4', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'William Lawson', '1139', 'individual', 26, 163.0, 135.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b33cd490-868d-59cc-b6a1-d217c8979e68', 'cc5410b7-7af5-5e77-80b0-960dadbb0c48', '2552c01d-6467-5dbf-b858-c798384746a4', 'William Lawson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc5410b7-7af5-5e77-80b0-960dadbb0c48', 1, 25.0, NULL, false, '25.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc5410b7-7af5-5e77-80b0-960dadbb0c48', 2, 23.0, NULL, false, '23.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc5410b7-7af5-5e77-80b0-960dadbb0c48', 3, 26.0, NULL, false, '26.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc5410b7-7af5-5e77-80b0-960dadbb0c48', 4, 20.0, NULL, false, '20.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc5410b7-7af5-5e77-80b0-960dadbb0c48', 5, 22.0, NULL, false, '22.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc5410b7-7af5-5e77-80b0-960dadbb0c48', 6, 19.0, NULL, false, '19.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc5410b7-7af5-5e77-80b0-960dadbb0c48', 7, 28.0, 'DNF', true, '(28.0 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c3a94ac8-a7dc-597e-96a6-6c2b0739f127', 'bab03bca-e72f-5b38-8901-d0aa700a480b', '3176cf6a-f6ae-5023-a8ae-b1ac8e6028ba', 'Alexander Quinn', '1403', 'individual', 27, 175.0, 147.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '09837d68-8ffa-5215-8277-ef600c89e1f3', 'c3a94ac8-a7dc-597e-96a6-6c2b0739f127', 'bab03bca-e72f-5b38-8901-d0aa700a480b', 'Alexander Quinn', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3a94ac8-a7dc-597e-96a6-6c2b0739f127', 1, 27.0, NULL, false, '27.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3a94ac8-a7dc-597e-96a6-6c2b0739f127', 2, 27.0, NULL, false, '27.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3a94ac8-a7dc-597e-96a6-6c2b0739f127', 3, 23.0, NULL, false, '23.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3a94ac8-a7dc-597e-96a6-6c2b0739f127', 4, 21.0, NULL, false, '21.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3a94ac8-a7dc-597e-96a6-6c2b0739f127', 5, 21.0, NULL, false, '21.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3a94ac8-a7dc-597e-96a6-6c2b0739f127', 6, 28.0, 'DNF', true, '(28.0 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3a94ac8-a7dc-597e-96a6-6c2b0739f127', 7, 28.0, 'DNF', false, '28.0 DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 ACT Optimist Championship — Intermediate Fleet (17 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'efe6897f-1b90-5b1d-abcf-b4b28edde772', '9b4f7a85-aa7d-5d77-9cd7-afb06469bc69', '436486db-ddee-5821-b217-946127fb5506', 'Sylvia Carlson', '1236', 'individual', 1, 18.0, 12.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '00c85431-0c94-5af2-b6d5-471989d51d1b', 'efe6897f-1b90-5b1d-abcf-b4b28edde772', '9b4f7a85-aa7d-5d77-9cd7-afb06469bc69', 'Sylvia Carlson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efe6897f-1b90-5b1d-abcf-b4b28edde772', 1, 4.0, NULL, false, '4.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efe6897f-1b90-5b1d-abcf-b4b28edde772', 2, 1.0, NULL, false, '1.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efe6897f-1b90-5b1d-abcf-b4b28edde772', 3, 2.0, NULL, false, '2.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efe6897f-1b90-5b1d-abcf-b4b28edde772', 4, 3.0, NULL, false, '3.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efe6897f-1b90-5b1d-abcf-b4b28edde772', 5, 6.0, NULL, true, '(6.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efe6897f-1b90-5b1d-abcf-b4b28edde772', 6, 2.0, NULL, false, '2.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '417275b9-f1b8-5ae4-9108-9a7470112dc0', 'ffee66ca-ee78-504e-9fac-f2c556c77843', '436486db-ddee-5821-b217-946127fb5506', 'Sam Harris', '1914', 'individual', 2, 18.0, 13.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e83d3a5d-9235-5499-bfb0-6803af735403', '417275b9-f1b8-5ae4-9108-9a7470112dc0', 'ffee66ca-ee78-504e-9fac-f2c556c77843', 'Sam Harris', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('417275b9-f1b8-5ae4-9108-9a7470112dc0', 1, 3.0, NULL, false, '3.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('417275b9-f1b8-5ae4-9108-9a7470112dc0', 2, 5.0, NULL, true, '(5.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('417275b9-f1b8-5ae4-9108-9a7470112dc0', 3, 1.0, NULL, false, '1.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('417275b9-f1b8-5ae4-9108-9a7470112dc0', 4, 2.0, NULL, false, '2.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('417275b9-f1b8-5ae4-9108-9a7470112dc0', 5, 4.0, NULL, false, '4.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('417275b9-f1b8-5ae4-9108-9a7470112dc0', 6, 3.0, NULL, false, '3.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '914e811f-1bd9-5c1c-a0ad-3b8a15247b5c', '9fd9b1bf-7451-582c-a335-4fb1e7b0866d', '436486db-ddee-5821-b217-946127fb5506', 'Tom Withers', '1697', 'individual', 3, 28.0, 20.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1b6a5bdd-20d6-5088-92db-fcf8b3387867', '914e811f-1bd9-5c1c-a0ad-3b8a15247b5c', '9fd9b1bf-7451-582c-a335-4fb1e7b0866d', 'Tom Withers', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('914e811f-1bd9-5c1c-a0ad-3b8a15247b5c', 1, 2.0, NULL, false, '2.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('914e811f-1bd9-5c1c-a0ad-3b8a15247b5c', 2, 4.0, NULL, false, '4.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('914e811f-1bd9-5c1c-a0ad-3b8a15247b5c', 3, 4.0, NULL, false, '4.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('914e811f-1bd9-5c1c-a0ad-3b8a15247b5c', 4, 4.0, NULL, false, '4.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('914e811f-1bd9-5c1c-a0ad-3b8a15247b5c', 5, 8.0, NULL, true, '(8.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('914e811f-1bd9-5c1c-a0ad-3b8a15247b5c', 6, 6.0, NULL, false, '6.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ebd3de56-1916-580f-ab99-58c3df7e8514', '22670cfa-0e57-5cbd-b6b0-aef9a8d515e7', '436486db-ddee-5821-b217-946127fb5506', 'Olivia Dorling', '1575', 'individual', 4, 35.0, 26.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e2d9dbc2-f381-5c65-9357-b68ed1e2cb9b', 'ebd3de56-1916-580f-ab99-58c3df7e8514', '22670cfa-0e57-5cbd-b6b0-aef9a8d515e7', 'Olivia Dorling', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ebd3de56-1916-580f-ab99-58c3df7e8514', 1, 9.0, NULL, true, '(9.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ebd3de56-1916-580f-ab99-58c3df7e8514', 2, 3.0, NULL, false, '3.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ebd3de56-1916-580f-ab99-58c3df7e8514', 3, 3.0, NULL, false, '3.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ebd3de56-1916-580f-ab99-58c3df7e8514', 4, 8.0, NULL, false, '8.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ebd3de56-1916-580f-ab99-58c3df7e8514', 5, 7.0, NULL, false, '7.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ebd3de56-1916-580f-ab99-58c3df7e8514', 6, 5.0, NULL, false, '5.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a2103322-2e71-54fe-9f55-baf457d295b6', '35855be2-e8fd-5966-aaff-55c5982c306b', '436486db-ddee-5821-b217-946127fb5506', 'Aodh Allatt', '421', 'individual', 5, 44.0, 28.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4be878b5-725b-57e2-ae8e-0a82e72f81eb', 'a2103322-2e71-54fe-9f55-baf457d295b6', '35855be2-e8fd-5966-aaff-55c5982c306b', 'Aodh Allatt', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2103322-2e71-54fe-9f55-baf457d295b6', 1, 6.0, NULL, false, '6.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2103322-2e71-54fe-9f55-baf457d295b6', 2, 16.0, NULL, true, '(16.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2103322-2e71-54fe-9f55-baf457d295b6', 3, 14.0, NULL, false, '14.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2103322-2e71-54fe-9f55-baf457d295b6', 4, 6.0, NULL, false, '6.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2103322-2e71-54fe-9f55-baf457d295b6', 5, 1.0, NULL, false, '1.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2103322-2e71-54fe-9f55-baf457d295b6', 6, 1.0, NULL, false, '1.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2f0f5f10-5039-507a-ac07-523d71a822bd', 'd8ff4e35-8040-5c54-8d3c-f943992b3ed5', '436486db-ddee-5821-b217-946127fb5506', 'Francis Watts', '1766', 'individual', 6, 48.0, 30.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b4938ea4-d52d-5278-ae4e-3fbe15445e3b', '2f0f5f10-5039-507a-ac07-523d71a822bd', 'd8ff4e35-8040-5c54-8d3c-f943992b3ed5', 'Francis Watts', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f0f5f10-5039-507a-ac07-523d71a822bd', 1, 5.0, NULL, false, '5.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f0f5f10-5039-507a-ac07-523d71a822bd', 2, 13.0, NULL, false, '13.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f0f5f10-5039-507a-ac07-523d71a822bd', 3, 7.0, NULL, false, '7.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f0f5f10-5039-507a-ac07-523d71a822bd', 4, 1.0, NULL, false, '1.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f0f5f10-5039-507a-ac07-523d71a822bd', 5, 18.0, 'NSC', true, '(18.0 NSC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f0f5f10-5039-507a-ac07-523d71a822bd', 6, 4.0, NULL, false, '4.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a5b26856-f38e-51da-a46c-f5d1a5b61500', '6809147a-acdc-5a68-9d3a-a6ff1f4ecd6e', '436486db-ddee-5821-b217-946127fb5506', 'Ellery Chai', '1078', 'individual', 7, 47.0, 33.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fb32e2ee-ec38-5f53-a888-9039def5f04f', 'a5b26856-f38e-51da-a46c-f5d1a5b61500', '6809147a-acdc-5a68-9d3a-a6ff1f4ecd6e', 'Ellery Chai', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a5b26856-f38e-51da-a46c-f5d1a5b61500', 1, 1.0, NULL, false, '1.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a5b26856-f38e-51da-a46c-f5d1a5b61500', 2, 2.0, NULL, false, '2.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a5b26856-f38e-51da-a46c-f5d1a5b61500', 3, 10.0, NULL, false, '10.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a5b26856-f38e-51da-a46c-f5d1a5b61500', 4, 7.0, NULL, false, '7.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a5b26856-f38e-51da-a46c-f5d1a5b61500', 5, 13.0, NULL, false, '13.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a5b26856-f38e-51da-a46c-f5d1a5b61500', 6, 14.0, NULL, true, '(14.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7e05b91c-9b6d-52c7-b649-589e509670de', '7543d5b6-2f3a-5264-81a4-d38f5c56e1b2', '436486db-ddee-5821-b217-946127fb5506', 'Lucas Gustafsson', '490', 'individual', 8, 49.0, 33.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1474c687-a328-573d-b1d0-6e9a3a8a6b39', '7e05b91c-9b6d-52c7-b649-589e509670de', '7543d5b6-2f3a-5264-81a4-d38f5c56e1b2', 'Lucas Gustafsson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e05b91c-9b6d-52c7-b649-589e509670de', 1, 16.0, NULL, true, '(16.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e05b91c-9b6d-52c7-b649-589e509670de', 2, 8.0, NULL, false, '8.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e05b91c-9b6d-52c7-b649-589e509670de', 3, 11.0, NULL, false, '11.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e05b91c-9b6d-52c7-b649-589e509670de', 4, 5.0, NULL, false, '5.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e05b91c-9b6d-52c7-b649-589e509670de', 5, 2.0, NULL, false, '2.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e05b91c-9b6d-52c7-b649-589e509670de', 6, 7.0, NULL, false, '7.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ec399f48-377a-506e-bd4c-530b6d3dd071', '15b5c0ed-ac08-584c-874e-b7d9271dd53a', '436486db-ddee-5821-b217-946127fb5506', 'Sienna Murray', '1507', 'individual', 9, 46.0, 36.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'da8a11aa-92a2-5ca4-92bb-daac918d0617', 'ec399f48-377a-506e-bd4c-530b6d3dd071', '15b5c0ed-ac08-584c-874e-b7d9271dd53a', 'Sienna Murray', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ec399f48-377a-506e-bd4c-530b6d3dd071', 1, 7.0, NULL, false, '7.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ec399f48-377a-506e-bd4c-530b6d3dd071', 2, 10.0, NULL, true, '(10.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ec399f48-377a-506e-bd4c-530b6d3dd071', 3, 6.0, NULL, false, '6.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ec399f48-377a-506e-bd4c-530b6d3dd071', 4, 10.0, NULL, false, '10.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ec399f48-377a-506e-bd4c-530b6d3dd071', 5, 3.0, NULL, false, '3.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ec399f48-377a-506e-bd4c-530b6d3dd071', 6, 10.0, NULL, false, '10.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9f63ec46-70c9-589b-a2af-62abf51ec218', 'c2061301-4809-54ee-9ea1-e1db57322a1e', '436486db-ddee-5821-b217-946127fb5506', 'Ferreol Fefe', '1887', 'individual', 10, 55.0, 37.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '234ab802-7cb0-5aca-8e4c-852c1bcdb763', '9f63ec46-70c9-589b-a2af-62abf51ec218', 'c2061301-4809-54ee-9ea1-e1db57322a1e', 'Ferreol Fefe', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9f63ec46-70c9-589b-a2af-62abf51ec218', 1, 8.0, NULL, false, '8.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9f63ec46-70c9-589b-a2af-62abf51ec218', 2, 7.0, NULL, false, '7.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9f63ec46-70c9-589b-a2af-62abf51ec218', 3, 8.0, NULL, false, '8.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9f63ec46-70c9-589b-a2af-62abf51ec218', 4, 9.0, NULL, false, '9.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9f63ec46-70c9-589b-a2af-62abf51ec218', 5, 5.0, NULL, false, '5.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9f63ec46-70c9-589b-a2af-62abf51ec218', 6, 18.0, 'DNS', true, '(18.0 DNS)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b8f8b17d-9437-5ec9-9472-f027c41074bf', '8ba5da51-18a7-582e-8663-312927f31d4f', '436486db-ddee-5821-b217-946127fb5506', 'Orlando Kohen', '418', 'individual', 11, 64.0, 49.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8b13eb58-4bad-5eb8-900f-716f2a012134', 'b8f8b17d-9437-5ec9-9472-f027c41074bf', '8ba5da51-18a7-582e-8663-312927f31d4f', 'Orlando Kohen', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b8f8b17d-9437-5ec9-9472-f027c41074bf', 1, 15.0, NULL, true, '(15.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b8f8b17d-9437-5ec9-9472-f027c41074bf', 2, 12.0, NULL, false, '12.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b8f8b17d-9437-5ec9-9472-f027c41074bf', 3, 5.0, NULL, false, '5.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b8f8b17d-9437-5ec9-9472-f027c41074bf', 4, 14.0, NULL, false, '14.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b8f8b17d-9437-5ec9-9472-f027c41074bf', 5, 10.0, NULL, false, '10.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b8f8b17d-9437-5ec9-9472-f027c41074bf', 6, 8.0, NULL, false, '8.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '13035823-0fed-5196-bdc1-64ad7e6269e2', '7409f7c8-f1e5-57ae-b7b4-d3ce110f19a9', '436486db-ddee-5821-b217-946127fb5506', 'Nicholas Hasek', '1831', 'individual', 12, 69.0, 55.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '96d91964-4c6c-5b12-9097-e29c29abc8b6', '13035823-0fed-5196-bdc1-64ad7e6269e2', '7409f7c8-f1e5-57ae-b7b4-d3ce110f19a9', 'Nicholas Hasek', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('13035823-0fed-5196-bdc1-64ad7e6269e2', 1, 11.0, NULL, false, '11.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('13035823-0fed-5196-bdc1-64ad7e6269e2', 2, 9.0, NULL, false, '9.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('13035823-0fed-5196-bdc1-64ad7e6269e2', 3, 13.0, NULL, false, '13.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('13035823-0fed-5196-bdc1-64ad7e6269e2', 4, 11.0, NULL, false, '11.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('13035823-0fed-5196-bdc1-64ad7e6269e2', 5, 14.0, NULL, true, '(14.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('13035823-0fed-5196-bdc1-64ad7e6269e2', 6, 11.0, NULL, false, '11.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7eed1a9f-07e2-5bcd-9881-b398a4fdb097', '07397f15-5cbb-54bf-b882-5c77502823a8', '436486db-ddee-5821-b217-946127fb5506', 'Max Howard', '1560', 'individual', 13, 76.0, 58.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5392b184-b7b4-5738-b2a0-b4e046f9c46a', '7eed1a9f-07e2-5bcd-9881-b398a4fdb097', '07397f15-5cbb-54bf-b882-5c77502823a8', 'Max Howard', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7eed1a9f-07e2-5bcd-9881-b398a4fdb097', 1, 10.0, NULL, false, '10.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7eed1a9f-07e2-5bcd-9881-b398a4fdb097', 2, 11.0, NULL, false, '11.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7eed1a9f-07e2-5bcd-9881-b398a4fdb097', 3, 9.0, NULL, false, '9.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7eed1a9f-07e2-5bcd-9881-b398a4fdb097', 4, 16.0, NULL, false, '16.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7eed1a9f-07e2-5bcd-9881-b398a4fdb097', 5, 18.0, 'NSC', true, '(18.0 NSC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7eed1a9f-07e2-5bcd-9881-b398a4fdb097', 6, 12.0, NULL, false, '12.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '204daf79-8eec-5c74-8205-6a67a0a5ff21', '94f8a237-a0d6-56f1-8192-eccb7fee71e4', '436486db-ddee-5821-b217-946127fb5506', 'Joshua Quinn', '534', 'individual', 14, 77.0, 59.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f98c07be-ccfe-5c80-a8a8-49cdc1b24a58', '204daf79-8eec-5c74-8205-6a67a0a5ff21', '94f8a237-a0d6-56f1-8192-eccb7fee71e4', 'Joshua Quinn', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('204daf79-8eec-5c74-8205-6a67a0a5ff21', 1, 12.0, NULL, false, '12.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('204daf79-8eec-5c74-8205-6a67a0a5ff21', 2, 14.0, NULL, false, '14.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('204daf79-8eec-5c74-8205-6a67a0a5ff21', 3, 18.0, 'DNC', true, '(18.0 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('204daf79-8eec-5c74-8205-6a67a0a5ff21', 4, 13.0, NULL, false, '13.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('204daf79-8eec-5c74-8205-6a67a0a5ff21', 5, 11.0, NULL, false, '11.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('204daf79-8eec-5c74-8205-6a67a0a5ff21', 6, 9.0, NULL, false, '9.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9230cda0-b2a6-584f-bc5b-4a890fc83b2d', '699fc47d-4df1-58af-a442-4dec10596d5c', '436486db-ddee-5821-b217-946127fb5506', 'Fiachra Allatt', '651', 'individual', 15, 78.0, 63.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3f42d7b8-c082-5c04-9e97-b7246b670f7b', '9230cda0-b2a6-584f-bc5b-4a890fc83b2d', '699fc47d-4df1-58af-a442-4dec10596d5c', 'Fiachra Allatt', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9230cda0-b2a6-584f-bc5b-4a890fc83b2d', 1, 14.0, NULL, false, '14.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9230cda0-b2a6-584f-bc5b-4a890fc83b2d', 2, 15.0, NULL, true, '(15.0)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9230cda0-b2a6-584f-bc5b-4a890fc83b2d', 3, 12.0, NULL, false, '12.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9230cda0-b2a6-584f-bc5b-4a890fc83b2d', 4, 15.0, NULL, false, '15.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9230cda0-b2a6-584f-bc5b-4a890fc83b2d', 5, 9.0, NULL, false, '9.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9230cda0-b2a6-584f-bc5b-4a890fc83b2d', 6, 13.0, NULL, false, '13.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0d7e58f9-5392-5696-9b2c-4a9a3bb17ab1', 'd13b04ec-811e-5e60-881b-37abee3a107a', '436486db-ddee-5821-b217-946127fb5506', 'Lachlan Birtles', '1828', 'individual', 16, 90.0, 72.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4cf9b445-4b9f-544f-92de-6ec77330295d', '0d7e58f9-5392-5696-9b2c-4a9a3bb17ab1', 'd13b04ec-811e-5e60-881b-37abee3a107a', 'Lachlan Birtles', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0d7e58f9-5392-5696-9b2c-4a9a3bb17ab1', 1, 13.0, NULL, false, '13.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0d7e58f9-5392-5696-9b2c-4a9a3bb17ab1', 2, 17.0, NULL, false, '17.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0d7e58f9-5392-5696-9b2c-4a9a3bb17ab1', 3, 18.0, 'DNC', true, '(18.0 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0d7e58f9-5392-5696-9b2c-4a9a3bb17ab1', 4, 12.0, NULL, false, '12.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0d7e58f9-5392-5696-9b2c-4a9a3bb17ab1', 5, 12.0, NULL, false, '12.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0d7e58f9-5392-5696-9b2c-4a9a3bb17ab1', 6, 18.0, 'DNF', false, '18.0 DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '76fb6570-3670-5b5a-be9f-3a943a0c73d3', '6ca5db86-efad-5581-9c51-4e448b92f46b', '436486db-ddee-5821-b217-946127fb5506', 'Henry McCleave', '154', 'individual', 17, 92.0, 74.0,
    false, false, 'https://austeamsailing.com/events/ACT26.htm', 'https://austeamsailing.com/events/ACT26.htm', 'Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club', 'url', 'Official published results from Sailwave results for ACT Optimist Championship 2026 at Canberra Yacht Club. Digital HTML verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fcdd1229-b18f-59e6-b263-9b84c0e0af1f', '76fb6570-3670-5b5a-be9f-3a943a0c73d3', '6ca5db86-efad-5581-9c51-4e448b92f46b', 'Henry McCleave', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('76fb6570-3670-5b5a-be9f-3a943a0c73d3', 1, 17.0, NULL, false, '17.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('76fb6570-3670-5b5a-be9f-3a943a0c73d3', 2, 6.0, NULL, false, '6.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('76fb6570-3670-5b5a-be9f-3a943a0c73d3', 3, 15.0, NULL, false, '15.0') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('76fb6570-3670-5b5a-be9f-3a943a0c73d3', 4, 18.0, 'DNF', true, '(18.0 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('76fb6570-3670-5b5a-be9f-3a943a0c73d3', 5, 18.0, 'DNC', false, '18.0 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('76fb6570-3670-5b5a-be9f-3a943a0c73d3', 6, 18.0, 'DNC', false, '18.0 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;

COMMIT;
