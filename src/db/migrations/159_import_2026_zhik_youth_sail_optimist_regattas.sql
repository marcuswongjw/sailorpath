-- Migration 159: Import 2026 Zhik Youth Sail Australian State Championship Optimist Regattas
--
-- Source Index: https://www.sailing.org.au/news/zhik-youth-sail-2026-save-the-dates
-- Events & Fleets Imported (5 Events, 10 Optimist Sheets):
--   1. 2026 Zhik Youth Sail Tasmania — Optimist Open (4 boats, 6 races, 1 discard)
--   2. 2026 Zhik Youth Sail Tasmania — Optimist Intermediate (7 boats, 6 races, 1 discard)
--   3. 2026 Zhik Youth Sail Queensland — Optimist Open (14 boats, 4 races, 1 discard)
--   4. 2026 Zhik Youth Sail Queensland — Optimist Intermediate (27 boats, 4 races, 1 discard)
--   5. 2026 Zhik Youth Sail South Australia — Optimist Open (4 boats, 6 races, 1 discard)
--   6. 2026 Zhik Youth Sail South Australia — Optimist Intermediate (7 boats, 4 races, 1 discard)
--   7. 2026 Zhik Youth Sail Western Australia — Optimist Open (25 boats, 9 races, 1 discard)
--   8. 2026 Zhik Youth Sail Western Australia — Optimist Intermediate (19 boats, 9 races, 1 discard)
--   9. 2026 Zhik Youth Sail New South Wales — Optimist Open (74 boats, 9 races, 1 discard)
--  10. 2026 Zhik Youth Sail New South Wales — Optimist Intermediate (32 boats, 8 races, 1 discard)
--
-- Note on other Zhik Youth Sail 2026 events:
--   - Zhik Youth Sail VIC 2026 (9–12 April 2026, SSCBC): Regatta racing cancelled due to adverse weather (0 races).
--   - Zhik Youth Sail NT 2026 (6–10 July 2026, Darwin SC): No Optimist fleet sailed (Minnow/ILCA/RS Quest only).
--
-- Total results: 213. Total race scores: 1600.
-- PDF corroboration unavailable: verified against official digital scoring portals (SailingResults.net, TopYacht, Sportspage).
-- Atomic transaction with idempotent guards.

BEGIN;

-- 1. Regatta Events
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    '8b26aa69-c745-5b8e-a479-6b3f461b478e',
    '2026 Zhik Youth Sail Tasmania (Tasmanian Youth Championships)',
    '2026-zhik-youth-sail-tas',
    '2026-03-07',
    '2026-03-09',
    'Royal Yacht Club of Tasmania, Hobart, TAS, Australia',
    'Australian Sailing / Royal Yacht Club of Tasmania (RYCT)',
    '["Optimist"]'::jsonb,
    false,
    false,
    'Zhik Youth Sail TAS coaching clinic and Tasmanian Youth Championship regatta held 7–9 March 2026 at Royal Yacht Club of Tasmania.',
    'Low Point System with 1 discard.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    'e9a0a738-bff4-5262-bda9-205f3f0ae0c1',
    '2026 Zhik Youth Sail Queensland (Queensland Youth Championships)',
    '2026-zhik-youth-sail-qld',
    '2026-09-21',
    '2026-09-26',
    'Keppel Bay Sailing Club, Yeppoon, QLD, Australia',
    'Australian Sailing / Keppel Bay Sailing Club (KBSC)',
    '["Optimist"]'::jsonb,
    false,
    false,
    'Zhik Youth Sail QLD coaching clinic (21–23 Sept) and Queensland Youth Championships (24–26 Sept 2026) at Keppel Bay Sailing Club.',
    'Low Point System with 1 discard.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    'a64e79b9-5a04-551d-a5eb-257c1b2e43c0',
    '2026 Zhik Youth Sail South Australia (SA Youth Championships)',
    '2026-zhik-youth-sail-sa',
    '2026-09-26',
    '2026-09-29',
    'Brighton & Seacliff Yacht Club, Adelaide, SA, Australia',
    'Australian Sailing / Brighton & Seacliff Yacht Club (BSYC)',
    '["Optimist"]'::jsonb,
    false,
    false,
    'Zhik Youth Sail SA coaching clinic and South Australian Youth Championships held 26–29 September 2026 at Brighton & Seacliff Yacht Club.',
    'Low Point System with 1 discard.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    'dcf57b30-c097-5d51-bd36-13b22d122d6d',
    '2026 Zhik Youth Sail Western Australia (WA Youth Championships)',
    '2026-zhik-youth-sail-wa',
    '2026-09-26',
    '2026-10-01',
    'Royal Freshwater Bay Yacht Club / Nedlands Yacht Club, Perth, WA, Australia',
    'Australian Sailing / Royal Freshwater Bay Yacht Club (RFBYC) & Nedlands Yacht Club',
    '["Optimist"]'::jsonb,
    false,
    false,
    'Zhik Youth Sail WA coaching clinic and 2026 Zhik WA Youth Championships held 26 September – 1 October 2026 on the Swan River, Perth.',
    'Low Point System with 1 discard across 9 races.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    'f967b832-71d8-5deb-8550-9d50791429fb',
    '2026 Zhik Youth Sail New South Wales (NSW Youth Championships)',
    '2026-zhik-youth-sail-nsw',
    '2026-09-30',
    '2026-10-05',
    'Toronto Amateur Sailing Club, Lake Macquarie, NSW, Australia',
    'Australian Sailing / Toronto Amateur Sailing Club (TASC)',
    '["Optimist"]'::jsonb,
    false,
    false,
    'Zhik Youth Sail NSW coaching clinic (30 Sept – 2 Oct) and NSW Youth Championships (3–5 Oct 2026) at Toronto Amateur Sailing Club, Lake Macquarie.',
    'Low Point System with 1 discard (up to 2 discards if 9 races completed; 1 discard in NSW series).'
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
    '07fc9de8-57bb-5523-a830-fbfbac955035',
    '8b26aa69-c745-5b8e-a479-6b3f461b478e',
    '2026 Zhik Youth Sail Tasmania — Optimist Open',
    '2026-zhik-youth-sail-tas-optimist-open',
    '2026-03-07',
    '2026-03-09',
    4,
    'Open',
    6,
    'AUS',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Royal Yacht Club of Tasmania, Hobart, TAS, Australia',
    'Australian Sailing / Royal Yacht Club of Tasmania (RYCT)',
    'published',
    'https://sailingresults.net/sa/results/overall.aspx?ID=82311.9',
    '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)',
    'Official results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net).',
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
    'de8d9b47-dd0d-5a30-80a9-e0983794ddb8',
    '8b26aa69-c745-5b8e-a479-6b3f461b478e',
    '2026 Zhik Youth Sail Tasmania — Optimist Intermediate',
    '2026-zhik-youth-sail-tas-optimist-intermediate',
    '2026-03-07',
    '2026-03-09',
    7,
    'Intermediate',
    6,
    'AUS',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Royal Yacht Club of Tasmania, Hobart, TAS, Australia',
    'Australian Sailing / Royal Yacht Club of Tasmania (RYCT)',
    'published',
    'https://sailingresults.net/sa/results/overall.aspx?ID=82311.8',
    '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)',
    'Official results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net).',
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
    '4896fb39-ac6d-5e68-aa89-717bf11d1f17',
    'e9a0a738-bff4-5262-bda9-205f3f0ae0c1',
    '2026 Zhik Youth Sail Queensland — Optimist Open',
    '2026-zhik-youth-sail-qld-optimist-open',
    '2026-09-21',
    '2026-09-26',
    14,
    'Open',
    4,
    'AUS',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Keppel Bay Sailing Club, Yeppoon, QLD, Australia',
    'Australian Sailing / Keppel Bay Sailing Club (KBSC)',
    'published',
    'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228',
    '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)',
    'Official results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht).',
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
    '4835f06f-3382-53a8-8a42-dc29be4a0267',
    'e9a0a738-bff4-5262-bda9-205f3f0ae0c1',
    '2026 Zhik Youth Sail Queensland — Optimist Intermediate',
    '2026-zhik-youth-sail-qld-optimist-intermediate',
    '2026-09-21',
    '2026-09-26',
    27,
    'Intermediate',
    4,
    'AUS',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Keppel Bay Sailing Club, Yeppoon, QLD, Australia',
    'Australian Sailing / Keppel Bay Sailing Club (KBSC)',
    'published',
    'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228',
    '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)',
    'Official results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht).',
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
    '9a080071-9657-5b1e-93a8-3b340195dd7e',
    'a64e79b9-5a04-551d-a5eb-257c1b2e43c0',
    '2026 Zhik Youth Sail South Australia — Optimist Open',
    '2026-zhik-youth-sail-sa-optimist-open',
    '2026-09-26',
    '2026-09-29',
    4,
    'Open',
    6,
    'AUS',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Brighton & Seacliff Yacht Club, Adelaide, SA, Australia',
    'Australian Sailing / Brighton & Seacliff Yacht Club (BSYC)',
    'published',
    'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175',
    '2026 SA Youth Championships Official Results (TopYacht)',
    'Official results from 2026 SA Youth Championships Official Results (TopYacht).',
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
    '650fcb00-d44d-5a96-bc99-42797efb2882',
    'a64e79b9-5a04-551d-a5eb-257c1b2e43c0',
    '2026 Zhik Youth Sail South Australia — Optimist Intermediate',
    '2026-zhik-youth-sail-sa-optimist-intermediate',
    '2026-09-26',
    '2026-09-29',
    7,
    'Intermediate',
    4,
    'AUS',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Brighton & Seacliff Yacht Club, Adelaide, SA, Australia',
    'Australian Sailing / Brighton & Seacliff Yacht Club (BSYC)',
    'published',
    'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175',
    '2026 SA Youth Championships Official Results (TopYacht)',
    'Official results from 2026 SA Youth Championships Official Results (TopYacht).',
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
    '6d912022-247e-566a-8637-033ef6073799',
    'dcf57b30-c097-5d51-bd36-13b22d122d6d',
    '2026 Zhik Youth Sail Western Australia — Optimist Open',
    '2026-zhik-youth-sail-wa-optimist-open',
    '2026-09-26',
    '2026-10-01',
    25,
    'Open',
    9,
    'AUS',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Royal Freshwater Bay Yacht Club / Nedlands Yacht Club, Perth, WA, Australia',
    'Australian Sailing / Royal Freshwater Bay Yacht Club (RFBYC) & Nedlands Yacht Club',
    'published',
    'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm',
    '2026 Zhik WA Youth Championships Official Results (Sportspage)',
    'Official results from 2026 Zhik WA Youth Championships Official Results (Sportspage).',
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
    'ee8e6248-a721-52ff-bcd2-c52531250a21',
    'dcf57b30-c097-5d51-bd36-13b22d122d6d',
    '2026 Zhik Youth Sail Western Australia — Optimist Intermediate',
    '2026-zhik-youth-sail-wa-optimist-intermediate',
    '2026-09-26',
    '2026-10-01',
    19,
    'Intermediate',
    9,
    'AUS',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Royal Freshwater Bay Yacht Club / Nedlands Yacht Club, Perth, WA, Australia',
    'Australian Sailing / Royal Freshwater Bay Yacht Club (RFBYC) & Nedlands Yacht Club',
    'published',
    'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm',
    '2026 Zhik WA Youth Championships Official Results (Sportspage)',
    'Official results from 2026 Zhik WA Youth Championships Official Results (Sportspage).',
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
    '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb',
    'f967b832-71d8-5deb-8550-9d50791429fb',
    '2026 Zhik Youth Sail New South Wales — Optimist Open',
    '2026-zhik-youth-sail-nsw-optimist-open',
    '2026-09-30',
    '2026-10-05',
    74,
    'Open',
    9,
    'AUS',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Toronto Amateur Sailing Club, Lake Macquarie, NSW, Australia',
    'Australian Sailing / Toronto Amateur Sailing Club (TASC)',
    'published',
    'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12',
    '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)',
    'Official results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net).',
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
    '598c5aaf-659b-5c4d-a00f-053b4c1238ad',
    'f967b832-71d8-5deb-8550-9d50791429fb',
    '2026 Zhik Youth Sail New South Wales — Optimist Intermediate',
    '2026-zhik-youth-sail-nsw-optimist-intermediate',
    '2026-09-30',
    '2026-10-05',
    32,
    'Intermediate',
    8,
    'AUS',
    'Optimist',
    'individual',
    1,
    1,
    false,
    'Toronto Amateur Sailing Club, Lake Macquarie, NSW, Australia',
    'Australian Sailing / Toronto Amateur Sailing Club (TASC)',
    'published',
    'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11',
    '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)',
    'Official results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);

-- 3. Sailor Profiles (207 profiles guaranteed)
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('045b2495-820a-5df1-b744-8439ea2e3d13', 'Edward Payne', 'opti-aus-edward-payne-1627', '1627', 'AUS', NULL, 'Hhsc') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('093b8a3b-a512-48a1-b21a-8e692dc16730', 'Forest Avery', 'forest-avery-anz26-093b8a', '4432', 'NZL', 'F', 'Kohimarama Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0ea521ac-cf94-4f05-bd88-32e0d04c1579', 'Fred Cantwell', 'fred-cantwell-anz26-0ea521', '1859', 'AUS', 'M', 'SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0f1dbaf1-c074-5cba-9abc-c91bdde4434f', 'Amelia McKelvey', 'opti-aus-amelia-mckelvey-162', '162', 'AUS', NULL, 'Ascham') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0f1eb283-e53c-533e-8113-55753e658647', 'Emma Tomkins', 'emma-tomkins-asians25', 'AUS 1781', 'AUS', 'F', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('104a8fa8-d159-48c4-b4a2-d70dd7eec5d1', 'Angus Johnston', 'angus-johnston-anz26-104a8f', '1670', 'AUS', 'M', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('159283fb-9913-4586-b9e7-d4d014439080', 'George Hayton', 'george-hayton-anz26-159283', '4755', 'NZL', 'M', 'Howick Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('15b30f88-d7b3-45f1-b9c2-a59c9972101b', 'Orlando Watts', 'orlando-watts-anz26-15b30f', '1745', 'AUS', 'M', 'RSYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('15b5c0ed-ac08-584c-874e-b7d9271dd53a', 'Sienna Murray', 'opti-aus-sienna-murray-1507', '1507', 'AUS', NULL, 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('173f9a62-5d72-4210-b057-47046ac28c95', 'Michael Schierhout', 'michael-schierhout-anz26-173f9a', '4765', 'NZL', 'M', 'Akarana Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1b22f933-9817-4f8b-a366-11315c5bc283', 'Lucy Lin', 'lucy-lin-anz26-1b22f9', '1938', 'SGP', 'F', 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1f83d34f-3841-534a-b7ff-6f06e614de9a', 'Jonathan Molloy', 'opti-aus-jonathan-molloy-1599', '1599', 'AUS', 'M', 'TYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('22198eeb-11f7-5b24-9e11-30cbdee01fb1', 'Noah Tate', 'opti-aus-noah-tate-640', '640', 'AUS', 'M', 'RQYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('223b5e00-fa91-4eb9-9fa9-83273b0760b8', 'Summer Newman', 'summer-newman-anz26-223b5e', '1899', 'AUS', 'F', 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('22670cfa-0e57-5cbd-b6b0-aef9a8d515e7', 'Olivia Dorling', 'opti-aus-olivia-dorling-372', '372', 'AUS', NULL, 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('23b717b1-7d59-5014-b1ae-3358bf3e8445', 'Laura OHara', 'opti-aus-laura-ohara-1214', '1214', 'AUS', NULL, 'NSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2552c01d-6467-5dbf-b858-c798384746a4', 'William Lawson', 'opti-aus-william-lawson-1139', '1139', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('298175a4-db74-4a70-a55c-fdd65f4d3004', 'Hamilton Zhao', 'hamilton-zhao-anz26-298175', '1640', 'SGP', 'M', 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2c632e1d-c35a-55b3-b30e-fdc04d8824b1', 'Maximilian Hultin', 'opti-aus-maximilian-hultin-1802', '1802', 'AUS', NULL, 'MHYC / NSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2e005437-68a4-51ab-bc8b-d377f51d55eb', 'Balthazar Roche', 'balthazar-roche-asians25', 'AUS 1931', 'AUS', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('30880421-1dc4-4a14-9c6b-8c00de39e4d8', 'Tom Griffiths', 'tom-griffiths-fd96wyi', '1744', 'AUS', 'M', 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('325b400d-1092-4711-b769-29b16989ea35', 'Aurelia Wilson', 'aurelia-wilson-anz26-325b40', '1941', 'AUS', 'F', 'RSYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('35f3c2cb-2ced-494d-aa27-c5f0cf3193dd', 'Erik Rydin', 'erik-rydin-anz26-35f3c2', '506', 'AUS', 'M', 'SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('365765e9-9ea4-5de4-8228-00156c596e49', 'Oliver Korn', 'opti-aus-oliver-korn-709', '709', 'AUS', NULL, 'GRSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('381285e5-8415-5fde-8418-373f492b9eca', 'Sam Hardy', 'opti-aus-sam-hardy-1481', '1481', 'AUS', NULL, 'TASC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3895ee0b-423d-54b2-ab8b-ed51a60f50a6', 'Aubrey Tan', 'opti-aus-aubrey-tan-1111', '1111', 'AUS', 'F', 'SYC/SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3cf1dd72-3f12-521f-a9be-a8dd0ba7ef0f', 'Arthur Douroux', 'opti-aus-arthur-douroux-663', '663', 'AUS', NULL, 'NSC-MHYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('49e3b629-7287-5783-a7d3-d00366db458b', 'Ollie Harry', 'opti-aus-ollie-harry-1518', '1518', 'AUS', 'M', 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('4c291012-2b60-5f2e-b850-b9e90f0c010c', 'Owen OHara', 'opti-aus-owen-ohara-1248', '1248', 'AUS', NULL, 'NSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('4ff5b3ea-abe2-47fd-87ed-f001ab207ab6', 'Mia Fenwick', 'mia-fenwick-anz26-4ff5b3', '4608', 'NZL', 'F', 'Napier Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('51a80a27-8665-4db2-afb4-0940cbc20376', 'Milton Li', 'milton-li-anz26-51a80a', '1559', 'AUS', 'M', 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('53113747-4b64-5bb9-8aca-f3a415600d66', 'Lottie Bown', 'opti-aus-lottie-bown-1090', '1090', 'AUS', NULL, 'SBSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('5359625c-bf84-49d1-b983-b908bd5b7f2e', 'Asher Williams', 'asher-williams-anz26-535962', '1316', 'AUS', 'M', 'SoPYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('53ca59e1-b29b-5fed-acfc-b65407a76960', 'Bono Svacek', 'opti-aus-bono-svacek-1855', '1855', 'AUS', 'M', 'RSYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('54b6d292-7c1e-4da4-990b-802e674c06e5', 'James Edwards', 'james-edwards-anz26-54b6d2', '1568', 'AUS', 'M', 'MYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('5a61d861-917e-55b9-85db-9c122fcc9183', 'Luca De Giosa', 'luca-de-giosa-euro26-5a61d8', 'AUS 1920', 'AUS', 'M', 'Imported official result') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('5beb9daf-9310-48ad-b865-8c00a7dca56c', 'Summer Torbet', 'summer-torbet-anz26-5beb9d', '4712', 'NZL', 'F', 'Murrays Bay Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('5e989cd1-b734-5443-9d3e-ea9794a9686f', 'Lauchlan Naylor', 'opti-aus-lauchlan-naylor-1488', '1488', 'AUS', 'M', 'RFBYC/FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('5f837edc-6728-50d4-901d-6a8ea81dc026', 'Alice Cameron', 'opti-aus-alice-cameron-325', '325', 'AUS', 'F', 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('60dd4d51-c920-5e84-b1e4-b662df586d2f', 'Caitlin Grant', 'opti-aus-caitlin-grant-327', '327', 'AUS', 'F', 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6732309a-18bb-5161-b260-d1e99b94e4dc', 'Huon Jones', 'opti-aus-huon-jones-949', '949', 'AUS', 'M', 'MSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('67957772-3fab-5f24-8fda-ea58259388aa', 'Ace Hill', 'opti-aus-ace-hill-1275', '1275', 'AUS', 'M', 'SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6809147a-acdc-5a68-9d3a-a6ff1f4ecd6e', 'Ellery Chai', 'opti-aus-ellery-chai-1078', '1078', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('685e8339-e2cf-50f4-bd0a-acd4a3a0f9d5', 'Olive Alden', 'opti-aus-olive-alden-824', '824', 'AUS', NULL, 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6bb70367-ef7b-4f22-899a-eda3a0da5fe5', 'Jasmine Fry', 'jasmine-fry-anz26-6bb703', '4568', 'NZL', 'F', 'Kohimarama Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6e620e7e-5678-525f-8760-caaacf2266a9', 'Emerald Jacobsen', 'emerald-jacobsen-asians25', 'AUS 1846', 'AUS', 'F', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('70391ae7-d567-55b9-b91c-3f80e65e3f84', 'Max Hughes', 'opti-aus-max-hughes-1734', '1734', 'AUS', 'M', 'RSYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('71010fdd-6c88-5e28-b9aa-5a1648dbe7b5', 'Anne Edwards', 'opti-aus-anne-edwards-1269', '1269', 'AUS', 'F', 'MYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7409f7c8-f1e5-57ae-b7b4-d3ce110f19a9', 'Nicholas Hasek', 'opti-aus-nicholas-hasek-1761', '1761', 'AUS', NULL, 'Cranbrook') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7411c058-0e0a-5a5d-aa05-fb3bd9edc4aa', 'Mac Darlington', 'mac-darlington-hkoda26-7411c0', 'AUS 1879', 'AUS', 'Unknown', 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('79de686e-027d-5809-99e8-453bfd3cf285', 'Miles White', 'opti-aus-miles-white-1432', '1432', 'AUS', 'M', 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7b929e9d-7925-4705-94ab-d175a82bb610', 'Kalle Gravare', 'kalle-gravare-anz26-7b929e', '1929', 'SGP', 'M', 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7f3d0b20-1951-5923-a815-94ec83024ae8', 'Lachlan King', 'opti-aus-lachlan-king-409', '409', 'AUS', 'M', 'RQYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('83116b4f-ccd0-4734-bc45-cc91ed133b60', 'Oscar Hermosillo', 'oscar-hermosillo-anz26-83116b', '4769', 'NZL', 'M', 'Tauranga Yacht & Powerboat Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('8ec76912-f222-4337-8bca-7cb5eab9fc39', 'Amelie Fenwick', 'amelie-fenwick-anz26-8ec769', '4642', 'NZL', 'F', 'Napier Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('8f29ffb3-a556-46c9-82c5-4b20f6d75356', 'Xavier James', 'xavier-james-anz26-8f29ff', '999', 'AUS', 'M', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('8ffb1e6b-203c-4bab-ac2f-18de1db064b7', 'Heidi Sinclair-Hill', 'heidi-sinclair-hill-anz26-8ffb1e', '1364', 'SGP', 'F', 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('916de616-661a-45ec-849f-23a75f4e1321', 'Dallas Noyer', 'dallas-noyer-anz26-916de6', '4714', 'NZL', 'F', 'Kohimarama Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('95ee889d-670c-4145-aca5-5b1f26cbf2cc', 'Stephen Wood', 'stephen-wood-anz26-95ee88', '4499', 'NZL', 'M', 'Murrays Bay Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('96f4f923-c23b-4098-983c-133c632e3d4d', 'Charlie Thirkettle', 'charlie-thirkettle-anz26-96f4f9', '4763', 'NZl', 'M', 'Murrays Bay Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('97f0b854-923f-5124-9cfa-8360389bc308', 'Ebba Nixey', 'opti-aus-ebba-nixey-1786', '1786', 'AUS', NULL, 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('98067f40-3792-57bb-9716-fc7bca16d664', 'Molly O''Donnell', 'opti-aus-molly-o-donnell-48', '48', 'AUS', NULL, 'Ascham') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9a41bcbd-ac5d-56f9-9c76-709aa5f78d69', 'Grace Newitt', 'opti-aus-grace-newitt-1865', '1865', 'AUS', 'F', 'RBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9b4f7a85-aa7d-5d77-9cd7-afb06469bc69', 'Sylvia Carlson', 'opti-aus-sylvia-carlson-1236', '1236', 'AUS', NULL, 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9b9378aa-37f6-470c-8944-5cf95bd13e04', 'Casey Fitness', 'casey-fitness-anz26-9b9378', '4805', 'NZL', 'M', 'Kohimarama Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9e8f469d-4386-46dc-8533-5babc753dd05', 'Jack Mcguire', 'jack-mcguire-anz26-9e8f46', '1936', 'AUS', 'M', 'RQYS/SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9ee1f9f1-aa37-4a62-8f85-67ab090c6d64', 'Axel Ryves', 'axel-ryves-anz26-9ee1f9', '1633', 'AUS', 'M', 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a1bac017-5467-45ce-9ddc-53c13bcf2852', 'Lyla Greenwood', 'lyla-greenwood-anz26-a1bac0', '1909', 'AUS', 'F', 'RQYS SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a3082455-4079-441d-8436-478f4c9024b7', 'Lily-May Weller', 'lily-may-weller-anz26-a30824', '1304', 'AUS', 'F', 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a68e8e7f-d347-5326-a405-7f795be50f87', 'Lara Dorling', 'opti-aus-lara-dorling-1729', '1729', 'AUS', NULL, 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a8621760-ffb6-4283-8e2e-12bb7890d8a4', 'Seb Tucker', 'seb-tucker-09584cg', '0', 'SGP', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a920942d-e921-4639-8fe8-bc183c330619', 'Callum Grant', 'callum-grant-anz26-a92094', '1113', 'AUS', 'M', 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ad46f601-d513-4b82-803f-46a12a4ff2eb', 'Connor Grant', 'connor-grant-anz26-ad46f6', '1291', 'AUS', 'M', 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ae10ce7d-d964-568b-98ee-3b1f370dc97a', 'Jamie Korn', 'opti-aus-jamie-korn-1666', '1666', 'AUS', NULL, 'GRSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b259b4fe-9ae6-521b-960b-34da1fe8a554', 'Jasmine Wang', 'opti-aus-jasmine-wang-1668', '1668', 'AUS', 'F', 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b2f3bfeb-f969-518e-b631-70da18fadc0d', 'William Harris', 'william-harris-asians25', 'AUS 1932', 'AUS', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b4803202-b601-5933-b9d5-c230caab796d', 'William Linscott', 'opti-aus-william-linscott-1408', '1408', 'AUS', 'M', 'SBSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b617fb8a-78ab-58d0-bf6e-6150e954658b', 'Alasdair Bonnitcha', 'opti-aus-alasdair-bonnitcha-1332', '1332', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b64cc6ae-a6e8-47a4-b702-b067d02e1f19', 'Jayden Wang', 'jayden-wang-anz26-b64cc6', '1748', 'AUS', 'M', 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b8cbccdc-a8ce-47cf-8728-5011daab6617', 'Harry Cooper', 'harry-cooper-anz26-b8cbcc', '1904', 'AUS', 'M', 'RFBYC/FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('bf23fd36-3596-4b3c-b92d-9123a1a84c14', 'Jayden Epari', 'jayden-epari-anz26-bf23fd', '1740', 'AUS', 'M', 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c06e2055-9901-5c52-9279-24d59b25d2a4', 'Rory Martin', 'opti-aus-rory-martin-877', '877', 'AUS', 'M', 'PDSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c20196f2-9a66-49ca-a9a9-8324f8b20ee6', 'Alexander Walker', 'alexander-walker-anz26-c20196', '1685', 'AUS', 'M', 'RQYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c23f1b7e-2073-524e-8a20-89af3fd18bf9', 'Tilly Gibson', 'opti-aus-tilly-gibson-1665', '1665', 'AUS', 'F', 'SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c720156e-a4fc-5c44-8505-4ad78bb60d73', 'Willow Murray', 'opti-aus-willow-murray-1863', '1863', 'AUS', NULL, 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ca6aadd0-01cf-45c2-b95d-5b2b182e3a81', 'Oliver Johnson', 'oliver-johnson-anz26-ca6aad', '1854', 'AUS', 'M', 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('cc7c3804-c292-5e08-808b-bcebb191b42a', 'Oliver Sun', 'opti-aus-oliver-sun-1606', '1606', 'AUS', NULL, 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('cf7c73d4-f50a-4283-8156-dac48dac903a', 'William Davis', 'william-davis-anz26-cf7c73', '4774', 'NZL', 'M', 'Queen Charlotte Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d164508c-c587-5c7f-9694-9b480ad61226', 'Thea Rydin', 'opti-aus-thea-rydin-218', '218', 'AUS', 'F', 'SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d4a93122-cac6-514d-a1c3-46a63c7aa978', 'Irida Bladon', 'opti-aus-irida-bladon-1222', '1222', 'AUS', 'F', 'SYC/RBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d6485671-0de9-5522-b3de-262e2cc27a13', 'Courtney Harrison', 'opti-aus-courtney-harrison-1735', '1735', 'AUS', NULL, 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d6c6fbdd-a5f2-4ac3-95ab-7ee3a7334b1a', 'Paz Avery', 'paz-avery-anz26-d6c6fb', '4609', 'NZL', 'M', 'Kohimarama Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d74ce041-92cb-578f-85a9-b1e22cb02f85', 'Felix Bradley', 'opti-aus-felix-bradley-1621', '1621', 'AUS', 'M', 'MSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d8ff4e35-8040-5c54-8d3c-f943992b3ed5', 'Francis Watts', 'opti-aus-francis-watts-1766', '1766', 'AUS', 'M', 'RSYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('db009883-9497-4b94-aebb-faefa490f260', 'Dylan Epari', 'dylan-epari-anz26-db0098', '1486', 'AUS', 'M', 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('dc9037eb-9773-5609-b677-013904a333c6', 'Ollie Walstab', 'opti-aus-ollie-walstab-1850', '1850', 'AUS', 'M', 'SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('dd86222a-4380-55f0-b7c9-f727b6f32f65', 'Maelyn Gilchrist', 'opti-aus-maelyn-gilchrist-1624', '1624', 'AUS', NULL, 'Ascham') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('dd942136-24c9-4575-a06d-81ac407486f1', 'Henry Hall', 'henry-hall-anz26-dd9421', '4820', 'NZL', 'M', 'Kohimarama Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e2a4b0c4-c2cc-4a03-b198-6378b590fc0b', 'Sebastian Cheng', 'sebastian-cheng-asianopti-aus', 'AUS 1491', 'AUS', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e6492e45-8cc3-4830-a42a-79cbf3009fe5', 'Tom Sanderson', 'tom-sanderson-anz26-e6492e', '4559', 'NZL', 'M', 'Murrays Bay Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e69e8c1b-a4f5-5f59-903b-b857e6a5cc5c', 'Sebastian Salter', 'opti-aus-sebastian-salter-1944', '1944', 'AUS', NULL, 'Cranbrook') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e912046c-3e11-5658-a475-acc04b70cb9a', 'Jack Sturm', 'opti-aus-jack-sturm-1389', '1389', 'AUS', 'M', 'RQYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e959c8e7-7d71-52bc-82d8-94e76a615407', 'Felix Sawers', 'opti-aus-felix-sawers-1724', '1724', 'AUS', NULL, 'PDSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ecf95263-9065-4e1b-861a-b9a33a968ff2', 'Ben Radich', 'ben-radich-anz26-ecf952', '4709', 'NZL', 'M', 'Royal Akarana Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('eee6d9a8-20bc-5f54-a5c5-c9ba6b51e502', 'James Paterson', 'opti-aus-james-paterson-1305', '1305', 'AUS', 'M', 'RQYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f26ce470-48a0-419e-967e-b1e936dad712', 'Lavinia Liu', 'lavinia-liu-anz26-f26ce4', '1866', 'AUS', 'F', 'ROAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f26e7a93-7b3f-5b8a-81ab-c5d767424cb8', 'Brayden Huang', 'opti-aus-brayden-huang-679', '679', 'AUS', NULL, 'NSC/MHYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f', 'Joy Cheuk Yee Shen', 'opti-aus-joy-cheuk-yee-shen-921', '921', 'AUS', 'F', 'SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f59d5ecb-926a-566c-a7c1-cfdca1cde8c2', 'Bobby Furneaux Williams', 'opti-aus-bobby-furneaux-williams-1926', '1926', 'AUS', 'M', 'IHYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f5f68b83-bb5b-4523-963f-3f367d5b4771', 'Yufu Wang', 'yufu-wang-anz26-f5f68b', '1930', 'AUS', 'M', 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('fc8d7069-1d5c-5065-982f-5b7c0d711185', 'Alex Mirceski', 'opti-aus-alex-mirceski-1791', '1791', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('fe55751a-320e-48f8-92fd-fd40bca74292', 'Reid Martin', 'reid-martin-anz26-fe5575', '1728', 'AUS', 'M', 'PDSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ff8ca5b1-553b-528c-b602-0d79507b82a2', 'William Liu', 'opti-aus-william-liu-1404', '1404', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ff95dfaa-563f-49ec-9d09-7cdd09128577', 'Jungwon Park', 'jungwon-park-anz26-ff95df', '4710', 'NZL', 'M', 'Kohimarama Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ffee66ca-ee78-504e-9fac-f2c556c77843', 'Sam Harris', 'opti-aus-sam-harris-1914', '1914', 'AUS', 'M', 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('da24b079-8fcd-5451-aaf0-f436f0cd9630', 'Willem Smith', 'opti-aus-willem-smith-1149', '1149', 'AUS', 'M', 'DARWIN SC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c3e64f7b-306c-5873-8677-0d86900183f7', 'Flynn Russell', 'opti-aus-flynn-russell-995', '995', 'AUS', 'M', 'TYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3f5ca562-0cd3-51b7-860a-8285830056e9', 'Kobi Gazzagon', 'opti-aus-kobi-gazzagon-1708', '1708', 'AUS', 'M', 'TYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('379c3f74-c685-5b15-a8d7-ada53eea17b7', 'Jude Canvin', 'opti-aus-jude-canvin-1834', '1834', 'AUS', 'M', 'SBSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('8fb51abe-6447-5c22-8502-f644470e9926', 'John Swain', 'opti-aus-john-swain-1596', '1596', 'AUS', 'M', 'TYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7af76285-52f0-5e89-8aeb-33470ca4cad4', 'Noah Cook', 'opti-aus-noah-cook-1768', '1768', 'AUS', NULL, 'Maroochy Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('979e5981-e04c-51bb-aa14-02563e9ad078', 'Harrison Gehrke', 'opti-aus-harrison-gehrke-911', '911', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('fcc78b34-55f5-597d-98c0-c5bfd31e81ef', 'Alex Walker', 'opti-aus-alex-walker-1685', '1685', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('8ad6d5b8-855d-5580-8b02-495e5419f434', 'Henry Li', 'opti-aus-henry-li-1609', '1609', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('cf48eefe-3d78-5245-9eda-f2c076ff4753', 'Samuel Naidu', 'opti-aus-samuel-naidu-1934', '1934', 'AUS', NULL, 'Maroochy Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('dfe072d0-70b4-5c50-9aa9-96f404b091f7', 'Frederick Kruger', 'opti-aus-frederick-kruger-1756', '1756', 'AUS', NULL, 'Port Denison Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('338dbdf8-775b-5600-bdea-8abb0132d78c', 'Aidan Andrews', 'opti-aus-aidan-andrews-1613', '1613', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('896c7f2c-b4b2-5875-98b9-ce8da2e40431', 'Willow Altmann', 'opti-aus-willow-altmann-811', '811', 'AUS', NULL, 'Port Denison Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('966fe5d7-15d7-5bcc-8650-27a88a29c8a0', 'Hamish King', 'opti-aus-hamish-king-958', '958', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('864a9ab1-6c75-58bf-bded-e344d88e9d25', 'Luke McLaughlin', 'opti-aus-luke-mclaughlin-1282', '1282', 'AUS', NULL, 'Humpybong Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('30134dca-069e-5e51-9c4c-dfcceeef9b62', 'Ryan Keegan', 'opti-aus-ryan-keegan-1780', '1780', 'AUS', NULL, 'Humpybong Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1cec51d9-3f14-5426-ad36-4312608d8336', 'Will Chalmers', 'opti-aus-will-chalmers-1438', '1438', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c312f3ae-498e-58bb-bbc4-4331d949d99c', 'Liam Gatkowski', 'opti-aus-liam-gatkowski-734', '734', 'AUS', NULL, 'Port Denison Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0d34c48d-8cd6-588a-8541-c4e3de4141e4', 'Laura Davison', 'opti-aus-laura-davison-1211', '1211', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('63dc82d0-2670-5460-a9cd-4a426f7947b4', 'Georgia Jeffrey', 'opti-aus-georgia-jeffrey-1725', '1725', 'AUS', NULL, 'Port Denison Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c6e6611e-f698-570d-8fd5-ec5566ae2b6d', 'Alexandra Orchard', 'opti-aus-alexandra-orchard-522', '522', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('56391c27-4fc5-552d-9493-afcbe5299380', 'Alex Stewart', 'opti-aus-alex-stewart-517', '517', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('442aeca1-7757-55cd-b547-0d3985748850', 'Jack Jones', 'opti-aus-jack-jones-1813', '1813', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('95a038a5-98e2-5fcc-b9ce-dd377472450a', 'Jasper Moore', 'opti-aus-jasper-moore-1935', '1935', 'AUS', NULL, 'Southport Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('4d30c153-949e-5cdb-848c-87c4f6ca5a32', 'Noah Carlyon', 'opti-aus-noah-carlyon-1529', '1529', 'AUS', NULL, 'Port Denison Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9cfbdd00-af91-5a97-8941-f345e2ad8f23', 'Owen Davies', 'opti-aus-owen-davies-629', '629', 'AUS', NULL, 'Southport Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0136806c-8f87-5c5b-971d-7f88336e08f8', 'Samuel Sawers', 'opti-aus-samuel-sawers-977', '977', 'AUS', NULL, 'Port Denison Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('03bd39bd-9417-50f9-8088-eb279c45cd96', 'Julian Groves', 'opti-aus-julian-groves-631', '631', 'AUS', NULL, 'Keppel Bay Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('947a9e38-5e6b-5c7b-9e00-05941778d140', 'Rory Pattenden', 'opti-aus-rory-pattenden-1427', '1427', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('5af32cad-bc1e-5d64-984d-a02b85f30667', 'Taylor Cook', 'opti-aus-taylor-cook-406', '406', 'AUS', NULL, 'Maroochy Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0f725fd6-7353-592f-84db-bbd6fda6a6a7', 'Imogen Troy', 'opti-aus-imogen-troy-1723', '1723', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ba4a1075-9189-582e-95c4-387237fd3aa3', 'Teddy Sampson', 'opti-aus-teddy-sampson-1144', '1144', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a23b49a2-9b25-5e8c-83cd-7623f57c08c6', 'Alby Jones', 'opti-aus-alby-jones-1680', '1680', 'AUS', NULL, 'Maroochy Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0ffd03e1-cd9b-5ef7-b8e6-e650960caae6', 'Caleb McCarthy', 'opti-aus-caleb-mccarthy-697', '697', 'AUS', NULL, 'Southport Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3fdc882d-1f3e-5214-b55c-9ab23761983c', 'Oliver Jeffrey', 'opti-aus-oliver-jeffrey-677', '677', 'AUS', NULL, 'Port Denison Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('df8b2353-da9f-5beb-930f-5a2caf913b15', 'Harvey Knyvett', 'opti-aus-harvey-knyvett-1619', '1619', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('22518786-717e-5398-8c6a-99c1a4e269cf', 'Ollie Johnson', 'opti-aus-ollie-johnson-1854', '1854', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a9500925-ba7f-504d-a073-e5c9b2946f0f', 'Oli Morris', 'opti-aus-oli-morris-1822', '1822', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('77778bb7-14b7-5c0b-b769-e9869adaf33e', 'Jimi Westmoreland', 'opti-aus-jimi-westmoreland-1485', '1485', 'AUS', NULL, 'GSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('24549454-ab63-5822-9a7c-be44c48cc5e5', 'Hugh Mcconnell', 'opti-aus-hugh-mcconnell-1250', '1250', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('47a69d3d-73a1-53c8-aae6-779ea71d97ff', 'Ben Dunstone', 'opti-aus-ben-dunstone-1242', '1242', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0747afe4-5dca-5983-872e-68c1c3114bff', 'Natalie Griffin', 'opti-aus-natalie-griffin-1125', '1125', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3e6f95cf-ffb2-56cf-8909-6f7337b7a0d3', 'Ozzy Kalynka', 'opti-aus-ozzy-kalynka-761', '761', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('94f0b3e4-b6cc-526f-b1e3-ddf6fc575b16', 'Isaac Bowker', 'opti-aus-isaac-bowker-1906', '1906', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('da5f1125-5a62-50ec-b538-bada4a31b0db', 'Henry Mcconnell', 'opti-aus-henry-mcconnell-747', '747', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('63e1c35a-bae1-532a-8ff9-8143132196b9', 'Lydia Edwards', 'opti-aus-lydia-edwards-1210', '1210', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9665941b-a00e-5d45-b44f-dacb4195bad6', 'Hayden Leighton', 'opti-aus-hayden-leighton-560', '560', 'AUS', NULL, 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d1a16c14-0db7-52f2-9a83-b5ddc57ae452', 'Leo Wrobel', 'opti-aus-leo-wrobel-562', '562', 'AUS', NULL, 'FSC/SOPYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0e50e1f3-1582-531e-a22f-8c830e1c66f0', 'Matthew Sanders', 'opti-aus-matthew-sanders-503', '503', 'AUS', NULL, 'RPYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('23fe2515-73f8-544c-8205-e0b55fc20b48', 'Hunter Wrobel', 'opti-aus-hunter-wrobel-498', '498', 'AUS', NULL, 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('cb9a3ee2-bfe4-5259-a130-6cf1752ce7e7', 'Daniel Saladine', 'opti-aus-daniel-saladine-1157', '1157', 'AUS', NULL, 'MBSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e2d76144-8458-5f5a-a466-7b4359a454e8', 'Charlie Boulton', 'opti-aus-charlie-boulton-947', '947', 'AUS', NULL, 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9a874041-f749-5c35-a40a-a10deb2d3d8c', 'Adeline Sanders', 'opti-aus-adeline-sanders-508', '508', 'AUS', NULL, 'RPYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6532ff66-67dd-59ba-877f-0e4a4db12199', 'Massimo Guidotti', 'opti-aus-massimo-guidotti-1861', '1861', 'AUS', NULL, 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('341233b1-e3cf-5a0e-8636-88088ce0cb20', 'Leo Stay', 'opti-aus-leo-stay-1718', '1718', 'AUS', NULL, 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('4d487477-0c02-58bd-87e3-ccfd1e2b8fc8', 'Shay Page', 'opti-aus-shay-page-563', '563', 'AUS', NULL, 'HYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0d5ed874-c95d-5332-98bd-dc214947c67c', 'Banjamin Lewis', 'opti-aus-banjamin-lewis-1521', '1521', 'AUS', NULL, 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6595c2d7-fc6c-555a-ae42-2c98ee5da394', 'Elke Bouckaert', 'opti-aus-elke-bouckaert-1371', '1371', 'AUS', NULL, 'EBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e6668df4-6390-5d15-8761-1bf98a312b78', 'Jacques Burling', 'opti-aus-jacques-burling-246', '246', 'AUS', NULL, 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('00069d4d-4df9-50d9-9551-f2212d3b7c66', 'Shun Archibald', 'opti-aus-shun-archibald-1287', '1287', 'AUS', NULL, 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('aba84567-9a62-5f40-85f5-3f5e37ad16c1', 'Louis Crowther', 'opti-aus-louis-crowther-1152', '1152', 'AUS', NULL, 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('dc73328b-c4db-541b-8d79-7020d51bf9a9', 'Thomas Carroll', 'opti-aus-thomas-carroll-593', '593', 'AUS', NULL, 'SoPYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('331d73ce-a518-5129-8c22-2b6294040fb6', 'Quade Potter', 'opti-aus-quade-potter-557', '557', 'AUS', NULL, 'WYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('73139ef4-7cdf-53d0-9e55-022fac000482', 'Archer Luffman', 'opti-aus-archer-luffman-316', '316', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9fbb7cec-2583-5d47-990a-93fdb10dba32', 'Hugo Crowther', 'opti-aus-hugo-crowther-740', '740', 'AUS', NULL, 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b6369fa8-878c-519a-a304-b9b8374d660e', 'Blake Harkin', 'opti-aus-blake-harkin-287', '287', 'AUS', NULL, 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('980b8ddb-e1d6-5ab8-a7f3-662cedff1755', 'Harry Cunningham', 'opti-aus-harry-cunningham-1677', '1677', 'AUS', NULL, 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('222d7728-95bc-5da8-8968-333f46990a5f', 'Connor Reynolds', 'opti-aus-connor-reynolds-799', '799', 'AUS', NULL, 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9fd3d1a5-43bf-58d7-ab36-bbb548bcae39', 'Edward Carter', 'opti-aus-edward-carter-658', '658', 'AUS', NULL, 'HYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a3c51e0f-01e8-5894-a709-a280e1ffe376', 'William Carroll', 'opti-aus-william-carroll-1355', '1355', 'AUS', NULL, 'SoPYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b0687a1f-46e7-53d6-932b-e8bb5a2cdeb9', 'Audrey Cameron', 'opti-aus-audrey-cameron-1203', '1203', 'AUS', NULL, 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7156515a-964c-5b40-8550-3c0f386a6d5a', 'Hector Campbell-Sloan', 'opti-aus-hector-campbell-sloan-680', '680', 'AUS', NULL, 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ed8edcb0-8d0c-5e82-a7a4-866072fd4955', 'Maya Forrester', 'opti-aus-maya-forrester-1393', '1393', 'AUS', NULL, 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ff5ae8f1-504b-5885-aba7-1618a9bfab99', 'Amy Cameron', 'opti-aus-amy-cameron-220', '220', 'AUS', NULL, 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ca8a5657-7578-51a2-9d30-ca94b022df9d', 'Vincent Jacniacki', 'opti-aus-vincent-jacniacki-604', '604', 'AUS', NULL, 'SBWC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ff8c5b6c-ec78-5769-8f0c-ae368ee1edb4', 'Zeno Brackenridge', 'opti-aus-zeno-brackenridge-1942', '1942', 'AUS', NULL, 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('8a82e08a-0937-5004-a427-9d52b1222c44', 'Edison Williams', 'opti-aus-edison-williams-566', '566', 'AUS', NULL, 'RPYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('75fede3f-6f2f-584e-b9d1-15b804cbb573', 'Victor Jacniacki', 'opti-aus-victor-jacniacki-501', '501', 'AUS', NULL, 'SBWC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0e4b7c7f-d18a-5551-b701-1ff02cf07f74', 'Theodore Altson', 'opti-aus-theodore-altson-1801', '1801', 'AUS', NULL, 'SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f309cdc5-86b9-5851-ac8f-1e70f9f7ccee', 'Zachariah Boyd', 'opti-aus-zachariah-boyd-1753', '1753', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b7624b59-ebc3-5e83-b161-8e1d2e199caf', 'Matilda Munt', 'opti-aus-matilda-munt-1367', '1367', 'AUS', 'F', 'NSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3457e10e-13f4-5fe3-9a1c-104fd86047d8', 'Astrid Thirkettle', 'opti-nzl-astrid-thirkettle-4231', '4231', 'NZL', 'F', 'MBSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e2a2b49f-557f-5861-95ef-a37cb4c2bfe8', 'Oscar Armstrong-Smith', 'opti-aus-oscar-armstrong-smith-1150', '1150', 'AUS', NULL, 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('368f20c7-7293-5f92-afed-d901a634a4f6', 'Ko-Chen Chou', 'opti-aus-ko-chen-chou-1289', '1289', 'AUS', 'F', 'MHYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a92f3324-6fb3-58ad-a586-0f093e755539', 'Jasper Ryves', 'opti-aus-jasper-ryves-1385', '1385', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('72e93146-918f-58ce-bb0b-7a420e62c528', 'Han Chia', 'opti-aus-han-chia-935', '935', 'AUS', NULL, 'NSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3c39019e-1dbd-5fda-8441-6805e0e87cc3', 'Aria Jeena', 'opti-aus-aria-jeena-1286', '1286', 'AUS', 'F', 'TASC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1fb75a6c-f136-541a-b620-6069e3d9019d', 'Edward Cantwell', 'opti-aus-edward-cantwell-912', '912', 'AUS', NULL, 'GRSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f2041fe0-2d58-5999-a413-d0822e35ab20', 'Will Hinchliffe', 'opti-aus-will-hinchliffe-926', '926', 'AUS', NULL, 'NSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('46e1b468-d253-5159-a464-9db190c99d39', 'Tristan Hultin', 'opti-aus-tristan-hultin-1547', '1547', 'AUS', NULL, 'MHYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c6bc68de-5bce-54ce-9a60-2ad5ee448249', 'Minato Cai', 'opti-aus-minato-cai-1457', '1457', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('05e26cc1-c32c-50dc-8a42-29772024492b', 'Jono Hinchliffe', 'opti-aus-jono-hinchliffe-924', '924', 'AUS', NULL, 'NSC') ON CONFLICT (id) DO NOTHING;

-- 4. Results, Participants, and Race Scores
-- Sheet: 2026 Zhik Youth Sail Tasmania — Optimist Open (4 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f989fa7f-0841-51d5-a3ce-fcdf238caa38', '1f83d34f-3841-534a-b7ff-6f06e614de9a', '07fc9de8-57bb-5523-a830-fbfbac955035', 'Jonathan Molloy', '1599', 'individual', 1, 10.0, 8.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.9', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.9', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '203bdb47-d61d-50c5-b1ea-fb60cf9af664', 'f989fa7f-0841-51d5-a3ce-fcdf238caa38', '1f83d34f-3841-534a-b7ff-6f06e614de9a', 'Jonathan Molloy', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f989fa7f-0841-51d5-a3ce-fcdf238caa38', 1, 2.0, NULL, true, '(2)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f989fa7f-0841-51d5-a3ce-fcdf238caa38', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f989fa7f-0841-51d5-a3ce-fcdf238caa38', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f989fa7f-0841-51d5-a3ce-fcdf238caa38', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f989fa7f-0841-51d5-a3ce-fcdf238caa38', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f989fa7f-0841-51d5-a3ce-fcdf238caa38', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c6ed4242-f994-5196-8927-012c174a7de9', '8f29ffb3-a556-46c9-82c5-4b20f6d75356', '07fc9de8-57bb-5523-a830-fbfbac955035', 'Xavier James', '999', 'individual', 2, 12.0, 9.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.9', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.9', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '07fba130-d781-5ab1-b57a-a9d5f3e867c6', 'c6ed4242-f994-5196-8927-012c174a7de9', '8f29ffb3-a556-46c9-82c5-4b20f6d75356', 'Xavier James', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c6ed4242-f994-5196-8927-012c174a7de9', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c6ed4242-f994-5196-8927-012c174a7de9', 2, 3.0, NULL, true, '(3)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c6ed4242-f994-5196-8927-012c174a7de9', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c6ed4242-f994-5196-8927-012c174a7de9', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c6ed4242-f994-5196-8927-012c174a7de9', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c6ed4242-f994-5196-8927-012c174a7de9', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'dfb51774-597f-546b-a831-ade0f7425e56', 'da24b079-8fcd-5451-aaf0-f436f0cd9630', '07fc9de8-57bb-5523-a830-fbfbac955035', 'Willem Smith', '1149', 'individual', 3, 16.0, 11.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.9', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.9', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ad862f42-fda7-58dd-b8e1-8150ad445111', 'dfb51774-597f-546b-a831-ade0f7425e56', 'da24b079-8fcd-5451-aaf0-f436f0cd9630', 'Willem Smith', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfb51774-597f-546b-a831-ade0f7425e56', 1, 5.0, 'DNF', true, '(5)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfb51774-597f-546b-a831-ade0f7425e56', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfb51774-597f-546b-a831-ade0f7425e56', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfb51774-597f-546b-a831-ade0f7425e56', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfb51774-597f-546b-a831-ade0f7425e56', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfb51774-597f-546b-a831-ade0f7425e56', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9d7535de-75f6-5e2c-ad34-7d9ff2825487', '104a8fa8-d159-48c4-b4a2-d70dd7eec5d1', '07fc9de8-57bb-5523-a830-fbfbac955035', 'Angus Johnston', '1670', 'individual', 4, 25.0, 20.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.9', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.9', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a2104e71-0756-5ee1-bc2b-ebca4c2036fb', '9d7535de-75f6-5e2c-ad34-7d9ff2825487', '104a8fa8-d159-48c4-b4a2-d70dd7eec5d1', 'Angus Johnston', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9d7535de-75f6-5e2c-ad34-7d9ff2825487', 1, 5.0, 'OCS', true, '(5)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9d7535de-75f6-5e2c-ad34-7d9ff2825487', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9d7535de-75f6-5e2c-ad34-7d9ff2825487', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9d7535de-75f6-5e2c-ad34-7d9ff2825487', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9d7535de-75f6-5e2c-ad34-7d9ff2825487', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9d7535de-75f6-5e2c-ad34-7d9ff2825487', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Tasmania — Optimist Intermediate (7 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '73dc0727-7931-55a7-bc52-bccca8a17a9f', 'b4803202-b601-5933-b9d5-c230caab796d', 'de8d9b47-dd0d-5a30-80a9-e0983794ddb8', 'William Linscott', '1408', 'individual', 1, 15.0, 9.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.8', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.8', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ddeb0fd1-658d-5de1-b8b7-4bf73937092f', '73dc0727-7931-55a7-bc52-bccca8a17a9f', 'b4803202-b601-5933-b9d5-c230caab796d', 'William Linscott', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('73dc0727-7931-55a7-bc52-bccca8a17a9f', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('73dc0727-7931-55a7-bc52-bccca8a17a9f', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('73dc0727-7931-55a7-bc52-bccca8a17a9f', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('73dc0727-7931-55a7-bc52-bccca8a17a9f', 4, 6.0, 'SCP', true, '(6)SCP') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('73dc0727-7931-55a7-bc52-bccca8a17a9f', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('73dc0727-7931-55a7-bc52-bccca8a17a9f', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e21bd313-4cb0-5870-9fcc-5a7a627169bb', 'c3e64f7b-306c-5873-8677-0d86900183f7', 'de8d9b47-dd0d-5a30-80a9-e0983794ddb8', 'Flynn Russell', '995', 'individual', 2, 20.0, 12.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.8', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.8', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8ba9bd45-23bc-508f-b90a-8729dd907546', 'e21bd313-4cb0-5870-9fcc-5a7a627169bb', 'c3e64f7b-306c-5873-8677-0d86900183f7', 'Flynn Russell', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e21bd313-4cb0-5870-9fcc-5a7a627169bb', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e21bd313-4cb0-5870-9fcc-5a7a627169bb', 2, 8.0, 'SCP', true, '(8)SCP') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e21bd313-4cb0-5870-9fcc-5a7a627169bb', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e21bd313-4cb0-5870-9fcc-5a7a627169bb', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e21bd313-4cb0-5870-9fcc-5a7a627169bb', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e21bd313-4cb0-5870-9fcc-5a7a627169bb', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '162951a5-2703-5ba8-a6b9-0fcf0dd73c98', '685e8339-e2cf-50f4-bd0a-acd4a3a0f9d5', 'de8d9b47-dd0d-5a30-80a9-e0983794ddb8', 'Olive Alden', '824', 'individual', 3, 25.0, 17.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.8', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.8', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd288c8d6-0170-54ee-9632-51f0893f33b0', '162951a5-2703-5ba8-a6b9-0fcf0dd73c98', '685e8339-e2cf-50f4-bd0a-acd4a3a0f9d5', 'Olive Alden', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('162951a5-2703-5ba8-a6b9-0fcf0dd73c98', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('162951a5-2703-5ba8-a6b9-0fcf0dd73c98', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('162951a5-2703-5ba8-a6b9-0fcf0dd73c98', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('162951a5-2703-5ba8-a6b9-0fcf0dd73c98', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('162951a5-2703-5ba8-a6b9-0fcf0dd73c98', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('162951a5-2703-5ba8-a6b9-0fcf0dd73c98', 6, 8.0, 'DNC', true, '(8)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c1904ba6-fd3e-5cf0-adb4-99d77a014b6c', '3f5ca562-0cd3-51b7-860a-8285830056e9', 'de8d9b47-dd0d-5a30-80a9-e0983794ddb8', 'Kobi Gazzagon', '1708', 'individual', 4, 26.0, 18.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.8', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.8', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5d0c1f35-d3fb-565f-9d85-a85b367209e8', 'c1904ba6-fd3e-5cf0-adb4-99d77a014b6c', '3f5ca562-0cd3-51b7-860a-8285830056e9', 'Kobi Gazzagon', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c1904ba6-fd3e-5cf0-adb4-99d77a014b6c', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c1904ba6-fd3e-5cf0-adb4-99d77a014b6c', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c1904ba6-fd3e-5cf0-adb4-99d77a014b6c', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c1904ba6-fd3e-5cf0-adb4-99d77a014b6c', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c1904ba6-fd3e-5cf0-adb4-99d77a014b6c', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c1904ba6-fd3e-5cf0-adb4-99d77a014b6c', 6, 8.0, 'DNC', true, '(8)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c4e363f1-95f0-5866-9e47-459a82c5fbd8', '379c3f74-c685-5b15-a8d7-ada53eea17b7', 'de8d9b47-dd0d-5a30-80a9-e0983794ddb8', 'Jude Canvin', '1834', 'individual', 5, 29.0, 21.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.8', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.8', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '65bc4ba2-9f96-5bb2-a2e1-b6fff2f6f2e2', 'c4e363f1-95f0-5866-9e47-459a82c5fbd8', '379c3f74-c685-5b15-a8d7-ada53eea17b7', 'Jude Canvin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c4e363f1-95f0-5866-9e47-459a82c5fbd8', 1, 8.0, 'DNF', true, '(8)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c4e363f1-95f0-5866-9e47-459a82c5fbd8', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c4e363f1-95f0-5866-9e47-459a82c5fbd8', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c4e363f1-95f0-5866-9e47-459a82c5fbd8', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c4e363f1-95f0-5866-9e47-459a82c5fbd8', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c4e363f1-95f0-5866-9e47-459a82c5fbd8', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '955ba260-6e42-5c46-bd6c-9265d01663d2', '8fb51abe-6447-5c22-8502-f644470e9926', 'de8d9b47-dd0d-5a30-80a9-e0983794ddb8', 'John Swain', '1596', 'individual', 6, 30.0, 22.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.8', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.8', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b589a20a-a2f5-5afc-9f70-ffda62eb7ebe', '955ba260-6e42-5c46-bd6c-9265d01663d2', '8fb51abe-6447-5c22-8502-f644470e9926', 'John Swain', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('955ba260-6e42-5c46-bd6c-9265d01663d2', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('955ba260-6e42-5c46-bd6c-9265d01663d2', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('955ba260-6e42-5c46-bd6c-9265d01663d2', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('955ba260-6e42-5c46-bd6c-9265d01663d2', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('955ba260-6e42-5c46-bd6c-9265d01663d2', 5, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('955ba260-6e42-5c46-bd6c-9265d01663d2', 6, 8.0, 'DNF', true, '(8)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f8e0df8c-04d0-5696-bed5-6598444c7ac7', '53113747-4b64-5bb9-8aca-f3a415600d66', 'de8d9b47-dd0d-5a30-80a9-e0983794ddb8', 'Lottie Bown', '1090', 'individual', 7, 37.0, 29.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.8', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.8', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '048a4049-63a7-5464-89b1-475a140ba254', 'f8e0df8c-04d0-5696-bed5-6598444c7ac7', '53113747-4b64-5bb9-8aca-f3a415600d66', 'Lottie Bown', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f8e0df8c-04d0-5696-bed5-6598444c7ac7', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f8e0df8c-04d0-5696-bed5-6598444c7ac7', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f8e0df8c-04d0-5696-bed5-6598444c7ac7', 3, 8.0, 'DNC', true, '(8)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f8e0df8c-04d0-5696-bed5-6598444c7ac7', 4, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f8e0df8c-04d0-5696-bed5-6598444c7ac7', 5, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f8e0df8c-04d0-5696-bed5-6598444c7ac7', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Queensland — Optimist Open (14 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8c155de6-463a-56d1-b175-b54c3ee25966', '9e8f469d-4386-46dc-8533-5babc753dd05', '4896fb39-ac6d-5e68-aa89-717bf11d1f17', 'Jack Mcguire', '1936', 'individual', 1, 4.0, 3.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '68a81974-470a-5835-b322-7159028190a7', '8c155de6-463a-56d1-b175-b54c3ee25966', '9e8f469d-4386-46dc-8533-5babc753dd05', 'Jack McGuire', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c155de6-463a-56d1-b175-b54c3ee25966', 1, 1.0, NULL, true, '(1)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c155de6-463a-56d1-b175-b54c3ee25966', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c155de6-463a-56d1-b175-b54c3ee25966', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c155de6-463a-56d1-b175-b54c3ee25966', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7d9eff8b-9c02-5f12-9b4e-dd104a649ec4', 'fe55751a-320e-48f8-92fd-fd40bca74292', '4896fb39-ac6d-5e68-aa89-717bf11d1f17', 'Reid Martin', '1728', 'individual', 2, 9.0, 6.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b8bbdf3d-a2c6-58b3-a178-a56f341a62e8', '7d9eff8b-9c02-5f12-9b4e-dd104a649ec4', 'fe55751a-320e-48f8-92fd-fd40bca74292', 'Reid Martin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7d9eff8b-9c02-5f12-9b4e-dd104a649ec4', 1, 3.0, NULL, true, '(3)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7d9eff8b-9c02-5f12-9b4e-dd104a649ec4', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7d9eff8b-9c02-5f12-9b4e-dd104a649ec4', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7d9eff8b-9c02-5f12-9b4e-dd104a649ec4', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b1749107-e9fd-5bd4-b0e6-7e53c1184c42', '7af76285-52f0-5e89-8aeb-33470ca4cad4', '4896fb39-ac6d-5e68-aa89-717bf11d1f17', 'Noah Cook', '1768', 'individual', 3, 14.5, 8.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8d8ed6dc-fb16-5dd9-83a0-f276a7156040', 'b1749107-e9fd-5bd4-b0e6-7e53c1184c42', '7af76285-52f0-5e89-8aeb-33470ca4cad4', 'Noah Cook', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b1749107-e9fd-5bd4-b0e6-7e53c1184c42', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b1749107-e9fd-5bd4-b0e6-7e53c1184c42', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b1749107-e9fd-5bd4-b0e6-7e53c1184c42', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b1749107-e9fd-5bd4-b0e6-7e53c1184c42', 4, 6.5, NULL, true, '(6.5)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '81b04359-52c2-5742-b4b7-2b3331493f87', 'a1bac017-5467-45ce-9ddc-53c13bcf2852', '4896fb39-ac6d-5e68-aa89-717bf11d1f17', 'Lyla Greenwood', '1909', 'individual', 4, 19.0, 12.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2c049d1c-5e28-5f43-95a7-014092a7a1f3', '81b04359-52c2-5742-b4b7-2b3331493f87', 'a1bac017-5467-45ce-9ddc-53c13bcf2852', 'Lyla Greenwood', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('81b04359-52c2-5742-b4b7-2b3331493f87', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('81b04359-52c2-5742-b4b7-2b3331493f87', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('81b04359-52c2-5742-b4b7-2b3331493f87', 3, 7.0, NULL, true, '(7)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('81b04359-52c2-5742-b4b7-2b3331493f87', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '79800057-d4c4-50de-98d9-aa2f969473a5', '979e5981-e04c-51bb-aa14-02563e9ad078', '4896fb39-ac6d-5e68-aa89-717bf11d1f17', 'Harrison Gehrke', '911', 'individual', 5, 20.0, 15.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4ac80543-7f46-52b6-bd3e-e8b9a59d422d', '79800057-d4c4-50de-98d9-aa2f969473a5', '979e5981-e04c-51bb-aa14-02563e9ad078', 'Harrison Gehrke', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('79800057-d4c4-50de-98d9-aa2f969473a5', 1, 5.0, NULL, true, '(5)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('79800057-d4c4-50de-98d9-aa2f969473a5', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('79800057-d4c4-50de-98d9-aa2f969473a5', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('79800057-d4c4-50de-98d9-aa2f969473a5', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '70a5c1e5-fe66-5a19-b0c5-68b4772fd382', 'fcc78b34-55f5-597d-98c0-c5bfd31e81ef', '4896fb39-ac6d-5e68-aa89-717bf11d1f17', 'Alex Walker', '1685', 'individual', 6, 24.5, 17.5,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7bdb554d-7abf-59dd-976d-635e20131088', '70a5c1e5-fe66-5a19-b0c5-68b4772fd382', 'fcc78b34-55f5-597d-98c0-c5bfd31e81ef', 'Alex Walker', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70a5c1e5-fe66-5a19-b0c5-68b4772fd382', 1, 7.0, NULL, true, '(7)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70a5c1e5-fe66-5a19-b0c5-68b4772fd382', 2, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70a5c1e5-fe66-5a19-b0c5-68b4772fd382', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70a5c1e5-fe66-5a19-b0c5-68b4772fd382', 4, 6.5, NULL, false, '6.5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '868c1ecf-e24c-56d5-9b51-a600df3584d5', 'e912046c-3e11-5658-a475-acc04b70cb9a', '4896fb39-ac6d-5e68-aa89-717bf11d1f17', 'Jack Sturm', '1773', 'individual', 7, 33.0, 18.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0bc19f83-13b7-5519-9bb2-2de2b1e1f70d', '868c1ecf-e24c-56d5-9b51-a600df3584d5', 'e912046c-3e11-5658-a475-acc04b70cb9a', 'Jack Sturm', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('868c1ecf-e24c-56d5-9b51-a600df3584d5', 1, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('868c1ecf-e24c-56d5-9b51-a600df3584d5', 2, 15.0, 'DNF', true, '(15 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('868c1ecf-e24c-56d5-9b51-a600df3584d5', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('868c1ecf-e24c-56d5-9b51-a600df3584d5', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8a197356-20ab-562a-accf-ec98d7910bfa', '6732309a-18bb-5161-b260-d1e99b94e4dc', '4896fb39-ac6d-5e68-aa89-717bf11d1f17', 'Huon Jones', '949', 'individual', 8, 37.0, 22.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2b999394-cd37-538b-ad98-ec874818370c', '8a197356-20ab-562a-accf-ec98d7910bfa', '6732309a-18bb-5161-b260-d1e99b94e4dc', 'Huon Jones', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a197356-20ab-562a-accf-ec98d7910bfa', 1, 15.0, 'DNF', true, '(15 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a197356-20ab-562a-accf-ec98d7910bfa', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a197356-20ab-562a-accf-ec98d7910bfa', 3, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8a197356-20ab-562a-accf-ec98d7910bfa', 4, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8f63e668-2e22-595c-bf24-8392a0decd2f', '22198eeb-11f7-5b24-9e11-30cbdee01fb1', '4896fb39-ac6d-5e68-aa89-717bf11d1f17', 'Noah Tate', '640', 'individual', 9, 34.0, 23.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd44c7306-0bd8-5fe1-9011-b6f2d7613ba9', '8f63e668-2e22-595c-bf24-8392a0decd2f', '22198eeb-11f7-5b24-9e11-30cbdee01fb1', 'Noah Tate', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8f63e668-2e22-595c-bf24-8392a0decd2f', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8f63e668-2e22-595c-bf24-8392a0decd2f', 2, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8f63e668-2e22-595c-bf24-8392a0decd2f', 3, 11.0, NULL, true, '(11)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8f63e668-2e22-595c-bf24-8392a0decd2f', 4, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'bdf5141c-5e14-5a61-b5df-cadf81cdc94a', '8ad6d5b8-855d-5580-8b02-495e5419f434', '4896fb39-ac6d-5e68-aa89-717bf11d1f17', 'Henry Li', '1609', 'individual', 10, 41.0, 28.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '80933733-5b31-518d-b2bc-3bbf5bb340cb', 'bdf5141c-5e14-5a61-b5df-cadf81cdc94a', '8ad6d5b8-855d-5580-8b02-495e5419f434', 'Henry Li', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bdf5141c-5e14-5a61-b5df-cadf81cdc94a', 1, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bdf5141c-5e14-5a61-b5df-cadf81cdc94a', 2, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bdf5141c-5e14-5a61-b5df-cadf81cdc94a', 3, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bdf5141c-5e14-5a61-b5df-cadf81cdc94a', 4, 13.0, NULL, true, '(13)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '08d97c59-0850-5a19-8246-35246078966a', '7f3d0b20-1951-5923-a815-94ec83024ae8', '4896fb39-ac6d-5e68-aa89-717bf11d1f17', 'Lachlan King', '409', 'individual', 11, 41.0, 29.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '384a3f04-59f1-54e1-8f5b-598fec8737b4', '08d97c59-0850-5a19-8246-35246078966a', '7f3d0b20-1951-5923-a815-94ec83024ae8', 'Lachlan King', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('08d97c59-0850-5a19-8246-35246078966a', 1, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('08d97c59-0850-5a19-8246-35246078966a', 2, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('08d97c59-0850-5a19-8246-35246078966a', 3, 12.0, NULL, true, '(12)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('08d97c59-0850-5a19-8246-35246078966a', 4, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e37ad8cf-ce18-5fe9-a56f-5bff74bf5221', 'eee6d9a8-20bc-5f54-a5c5-c9ba6b51e502', '4896fb39-ac6d-5e68-aa89-717bf11d1f17', 'James Paterson', '1305', 'individual', 12, 46.0, 31.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5affc082-4158-5c72-9ee0-a76d4b07c449', 'e37ad8cf-ce18-5fe9-a56f-5bff74bf5221', 'eee6d9a8-20bc-5f54-a5c5-c9ba6b51e502', 'James Paterson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e37ad8cf-ce18-5fe9-a56f-5bff74bf5221', 1, 15.0, 'DNF', true, '(15 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e37ad8cf-ce18-5fe9-a56f-5bff74bf5221', 2, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e37ad8cf-ce18-5fe9-a56f-5bff74bf5221', 3, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e37ad8cf-ce18-5fe9-a56f-5bff74bf5221', 4, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b99b3918-f8d5-5801-a6ad-5bd861b2e026', 'cf48eefe-3d78-5245-9eda-f2c076ff4753', '4896fb39-ac6d-5e68-aa89-717bf11d1f17', 'Samuel Naidu', '1934', 'individual', 13, 52.0, 37.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ed0c5ceb-1925-5ed0-867b-5312f5106c7e', 'b99b3918-f8d5-5801-a6ad-5bd861b2e026', 'cf48eefe-3d78-5245-9eda-f2c076ff4753', 'Samuel Naidu', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b99b3918-f8d5-5801-a6ad-5bd861b2e026', 1, 15.0, 'DNF', true, '(15 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b99b3918-f8d5-5801-a6ad-5bd861b2e026', 2, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b99b3918-f8d5-5801-a6ad-5bd861b2e026', 3, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b99b3918-f8d5-5801-a6ad-5bd861b2e026', 4, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'fe877764-ecb2-5f87-9eff-911788d8cdbf', 'c06e2055-9901-5c52-9279-24d59b25d2a4', '4896fb39-ac6d-5e68-aa89-717bf11d1f17', 'Rory Martin', '877', 'individual', 14, 59.0, 44.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '36ad0654-1ba1-5caa-bb5c-c9c622bfb900', 'fe877764-ecb2-5f87-9eff-911788d8cdbf', 'c06e2055-9901-5c52-9279-24d59b25d2a4', 'Rory Martin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fe877764-ecb2-5f87-9eff-911788d8cdbf', 1, 15.0, 'DNS', true, '(15 DNS)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fe877764-ecb2-5f87-9eff-911788d8cdbf', 2, 15.0, 'DNF', false, '15 DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fe877764-ecb2-5f87-9eff-911788d8cdbf', 3, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fe877764-ecb2-5f87-9eff-911788d8cdbf', 4, 15.0, 'DNS', false, '15 DNS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Queensland — Optimist Intermediate (27 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9ada946d-42b2-5f94-8143-215a2abd45e0', 'dfe072d0-70b4-5c50-9aa9-96f404b091f7', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Frederick Kruger', '1756', 'individual', 1, 11.0, 6.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1db61eda-71a5-5387-8869-40e7615fafac', '9ada946d-42b2-5f94-8143-215a2abd45e0', 'dfe072d0-70b4-5c50-9aa9-96f404b091f7', 'Frederick Kruger', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9ada946d-42b2-5f94-8143-215a2abd45e0', 1, 5.0, NULL, true, '(5)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9ada946d-42b2-5f94-8143-215a2abd45e0', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9ada946d-42b2-5f94-8143-215a2abd45e0', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9ada946d-42b2-5f94-8143-215a2abd45e0', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'bb1013b6-cbe6-573a-bf87-f53cdbffe840', '338dbdf8-775b-5600-bdea-8abb0132d78c', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Aidan Andrews', '1613', 'individual', 2, 16.5, 7.5,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3cbc1447-a714-5473-bbc0-7d753cc03166', 'bb1013b6-cbe6-573a-bf87-f53cdbffe840', '338dbdf8-775b-5600-bdea-8abb0132d78c', 'Aidan Andrews', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb1013b6-cbe6-573a-bf87-f53cdbffe840', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb1013b6-cbe6-573a-bf87-f53cdbffe840', 2, 4.5, NULL, false, '4.5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb1013b6-cbe6-573a-bf87-f53cdbffe840', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb1013b6-cbe6-573a-bf87-f53cdbffe840', 4, 9.0, NULL, true, '(9)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'cc40c583-4111-5970-8eb5-6b493a044cbc', '896c7f2c-b4b2-5875-98b9-ce8da2e40431', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Willow Altmann', '811', 'individual', 3, 17.5, 9.5,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f9897764-94da-50ad-afe8-674a1559dcd4', 'cc40c583-4111-5970-8eb5-6b493a044cbc', '896c7f2c-b4b2-5875-98b9-ce8da2e40431', 'Willow Altmann', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc40c583-4111-5970-8eb5-6b493a044cbc', 1, 8.0, NULL, true, '(8)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc40c583-4111-5970-8eb5-6b493a044cbc', 2, 4.5, NULL, false, '4.5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc40c583-4111-5970-8eb5-6b493a044cbc', 3, 3.5, NULL, false, '3.5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc40c583-4111-5970-8eb5-6b493a044cbc', 4, 1.5, NULL, false, '1.5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1f87d3f3-b163-51c6-b9b9-7d3568c8ad6c', '966fe5d7-15d7-5bcc-8650-27a88a29c8a0', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Hamish King', '958', 'individual', 4, 17.0, 10.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e92e8b54-0932-5a4e-be49-7941fba99bbd', '1f87d3f3-b163-51c6-b9b9-7d3568c8ad6c', '966fe5d7-15d7-5bcc-8650-27a88a29c8a0', 'Hamish King', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1f87d3f3-b163-51c6-b9b9-7d3568c8ad6c', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1f87d3f3-b163-51c6-b9b9-7d3568c8ad6c', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1f87d3f3-b163-51c6-b9b9-7d3568c8ad6c', 3, 7.0, NULL, true, '(7)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1f87d3f3-b163-51c6-b9b9-7d3568c8ad6c', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '40dcc7d5-973f-5d28-bb0c-47885a3afa85', '864a9ab1-6c75-58bf-bded-e344d88e9d25', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Luke McLaughlin', '1282', 'individual', 5, 39.0, 11.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fd314905-145c-57d1-87de-3af50c6c4b03', '40dcc7d5-973f-5d28-bb0c-47885a3afa85', '864a9ab1-6c75-58bf-bded-e344d88e9d25', 'Luke McLaughlin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('40dcc7d5-973f-5d28-bb0c-47885a3afa85', 1, 28.0, 'DNC', true, '(28 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('40dcc7d5-973f-5d28-bb0c-47885a3afa85', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('40dcc7d5-973f-5d28-bb0c-47885a3afa85', 3, 3.5, NULL, false, '3.5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('40dcc7d5-973f-5d28-bb0c-47885a3afa85', 4, 1.5, NULL, false, '1.5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f510ceed-a314-5c2c-9a04-e3589f1324c6', '30134dca-069e-5e51-9c4c-dfcceeef9b62', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Ryan Keegan', '1780', 'individual', 6, 44.0, 16.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fc816017-71f3-5a8b-835a-fc445f1aa83f', 'f510ceed-a314-5c2c-9a04-e3589f1324c6', '30134dca-069e-5e51-9c4c-dfcceeef9b62', 'Ryan Keegan', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f510ceed-a314-5c2c-9a04-e3589f1324c6', 1, 28.0, 'DNF', true, '(28 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f510ceed-a314-5c2c-9a04-e3589f1324c6', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f510ceed-a314-5c2c-9a04-e3589f1324c6', 3, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f510ceed-a314-5c2c-9a04-e3589f1324c6', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1070585d-6c70-52e9-a1e3-8409e9124ba9', 'd74ce041-92cb-578f-85a9-b1e22cb02f85', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Felix Bradley', '1621', 'individual', 7, 38.0, 19.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd6b8fab5-f10d-56fa-b71a-1330f397df5f', '1070585d-6c70-52e9-a1e3-8409e9124ba9', 'd74ce041-92cb-578f-85a9-b1e22cb02f85', 'Felix Bradley', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1070585d-6c70-52e9-a1e3-8409e9124ba9', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1070585d-6c70-52e9-a1e3-8409e9124ba9', 2, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1070585d-6c70-52e9-a1e3-8409e9124ba9', 3, 19.0, NULL, true, '(19)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1070585d-6c70-52e9-a1e3-8409e9124ba9', 4, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '30dbb7fd-8034-599c-8cd3-8b5aaa3ebc46', '1cec51d9-3f14-5426-ad36-4312608d8336', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Will Chalmers', '1438', 'individual', 8, 50.0, 22.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1d303b73-3c30-5237-b37a-72da9b7d4723', '30dbb7fd-8034-599c-8cd3-8b5aaa3ebc46', '1cec51d9-3f14-5426-ad36-4312608d8336', 'Will Chalmers', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30dbb7fd-8034-599c-8cd3-8b5aaa3ebc46', 1, 28.0, 'DNS', true, '(28 DNS)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30dbb7fd-8034-599c-8cd3-8b5aaa3ebc46', 2, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30dbb7fd-8034-599c-8cd3-8b5aaa3ebc46', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30dbb7fd-8034-599c-8cd3-8b5aaa3ebc46', 4, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '52d88ab3-92c4-56fd-b5e8-97bb97d6fc5f', 'c312f3ae-498e-58bb-bbc4-4331d949d99c', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Liam Gatkowski', '734', 'individual', 9, 43.0, 27.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '75d35e18-d91d-5fca-a18f-0670cf41ff40', '52d88ab3-92c4-56fd-b5e8-97bb97d6fc5f', 'c312f3ae-498e-58bb-bbc4-4331d949d99c', 'Liam Gatkowski', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52d88ab3-92c4-56fd-b5e8-97bb97d6fc5f', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52d88ab3-92c4-56fd-b5e8-97bb97d6fc5f', 2, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52d88ab3-92c4-56fd-b5e8-97bb97d6fc5f', 3, 16.0, NULL, true, '(16)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52d88ab3-92c4-56fd-b5e8-97bb97d6fc5f', 4, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'fec434c2-884d-596f-becd-ad8658657d52', '0d34c48d-8cd6-588a-8541-c4e3de4141e4', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Laura Davison', '1211', 'individual', 10, 55.0, 27.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '147a3332-05a6-5610-b384-938319454c72', 'fec434c2-884d-596f-becd-ad8658657d52', '0d34c48d-8cd6-588a-8541-c4e3de4141e4', 'Laura Davison', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fec434c2-884d-596f-becd-ad8658657d52', 1, 28.0, 'DNC', true, '(28 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fec434c2-884d-596f-becd-ad8658657d52', 2, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fec434c2-884d-596f-becd-ad8658657d52', 3, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fec434c2-884d-596f-becd-ad8658657d52', 4, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c921eb15-1a97-5df6-903b-d55c57027807', '63dc82d0-2670-5460-a9cd-4a426f7947b4', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Georgia Jeffrey', '1725', 'individual', 11, 44.0, 29.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '21e07f4d-8389-5f52-a10a-0fb4b4998a6b', 'c921eb15-1a97-5df6-903b-d55c57027807', '63dc82d0-2670-5460-a9cd-4a426f7947b4', 'Georgia Jeffrey', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c921eb15-1a97-5df6-903b-d55c57027807', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c921eb15-1a97-5df6-903b-d55c57027807', 2, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c921eb15-1a97-5df6-903b-d55c57027807', 3, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c921eb15-1a97-5df6-903b-d55c57027807', 4, 15.0, NULL, true, '(15)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7ee4d544-7008-5d37-8142-009b8edf3bf1', 'c6e6611e-f698-570d-8fd5-ec5566ae2b6d', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Alexandra Orchard', '522', 'individual', 12, 57.0, 29.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '50fa5083-2260-5e72-8013-f2c7de3fe76b', '7ee4d544-7008-5d37-8142-009b8edf3bf1', 'c6e6611e-f698-570d-8fd5-ec5566ae2b6d', 'Alexandra Orchard', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7ee4d544-7008-5d37-8142-009b8edf3bf1', 1, 28.0, 'DNC', true, '(28 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7ee4d544-7008-5d37-8142-009b8edf3bf1', 2, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7ee4d544-7008-5d37-8142-009b8edf3bf1', 3, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7ee4d544-7008-5d37-8142-009b8edf3bf1', 4, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7ad69ede-cc82-54b2-988f-d3431b8cafbd', '56391c27-4fc5-552d-9493-afcbe5299380', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Alex Stewart', '517', 'individual', 13, 46.0, 30.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9008262d-83b7-5518-b1a6-665914556801', '7ad69ede-cc82-54b2-988f-d3431b8cafbd', '56391c27-4fc5-552d-9493-afcbe5299380', 'Alex Stewart', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7ad69ede-cc82-54b2-988f-d3431b8cafbd', 1, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7ad69ede-cc82-54b2-988f-d3431b8cafbd', 2, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7ad69ede-cc82-54b2-988f-d3431b8cafbd', 3, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7ad69ede-cc82-54b2-988f-d3431b8cafbd', 4, 16.0, NULL, true, '(16)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3c094e3b-29b5-5b14-9abe-186962439e4a', '442aeca1-7757-55cd-b547-0d3985748850', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Jack Jones', '1813', 'individual', 14, 60.0, 32.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1351d351-d018-56e2-b125-aad1da974b13', '3c094e3b-29b5-5b14-9abe-186962439e4a', '442aeca1-7757-55cd-b547-0d3985748850', 'Jack Jones', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3c094e3b-29b5-5b14-9abe-186962439e4a', 1, 28.0, 'DNC', true, '(28 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3c094e3b-29b5-5b14-9abe-186962439e4a', 2, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3c094e3b-29b5-5b14-9abe-186962439e4a', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3c094e3b-29b5-5b14-9abe-186962439e4a', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c6942b26-344a-5d7c-891a-aae8127af34f', '95a038a5-98e2-5fcc-b9ce-dd377472450a', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Jasper Moore', '1935', 'individual', 15, 70.0, 42.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2313de69-1ab1-5a69-b9e8-c472ac34e280', 'c6942b26-344a-5d7c-891a-aae8127af34f', '95a038a5-98e2-5fcc-b9ce-dd377472450a', 'Jasper Moore', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c6942b26-344a-5d7c-891a-aae8127af34f', 1, 28.0, 'DNF', true, '(28 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c6942b26-344a-5d7c-891a-aae8127af34f', 2, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c6942b26-344a-5d7c-891a-aae8127af34f', 3, 14.5, NULL, false, '14.5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c6942b26-344a-5d7c-891a-aae8127af34f', 4, 13.5, NULL, false, '13.5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8e94729d-9870-52f9-9d64-32e389ea82aa', '4d30c153-949e-5cdb-848c-87c4f6ca5a32', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Noah Carlyon', '1529', 'individual', 16, 71.0, 43.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd30fa833-4909-534e-8003-46b726aa803a', '8e94729d-9870-52f9-9d64-32e389ea82aa', '4d30c153-949e-5cdb-848c-87c4f6ca5a32', 'Noah Carlyon', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8e94729d-9870-52f9-9d64-32e389ea82aa', 1, 28.0, 'DNC', true, '(28 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8e94729d-9870-52f9-9d64-32e389ea82aa', 2, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8e94729d-9870-52f9-9d64-32e389ea82aa', 3, 14.5, NULL, false, '14.5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8e94729d-9870-52f9-9d64-32e389ea82aa', 4, 13.5, NULL, false, '13.5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '82bc1646-368b-55e6-83ab-0af731c1edca', '9cfbdd00-af91-5a97-8941-f345e2ad8f23', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Owen Davies', '629', 'individual', 17, 67.0, 45.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'dfd2de36-823d-56e2-b635-ce71b1076399', '82bc1646-368b-55e6-83ab-0af731c1edca', '9cfbdd00-af91-5a97-8941-f345e2ad8f23', 'Owen Davies', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82bc1646-368b-55e6-83ab-0af731c1edca', 1, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82bc1646-368b-55e6-83ab-0af731c1edca', 2, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82bc1646-368b-55e6-83ab-0af731c1edca', 3, 22.0, NULL, true, '(22)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82bc1646-368b-55e6-83ab-0af731c1edca', 4, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a6282f1b-2166-5a96-b6ee-9552ad011354', '0136806c-8f87-5c5b-971d-7f88336e08f8', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Samuel Sawers', '977', 'individual', 18, 78.5, 50.5,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f6e4706c-d0cb-54fc-9782-4bbac997b3c9', 'a6282f1b-2166-5a96-b6ee-9552ad011354', '0136806c-8f87-5c5b-971d-7f88336e08f8', 'Samuel Sawers', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a6282f1b-2166-5a96-b6ee-9552ad011354', 1, 28.0, 'DNF', true, '(28 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a6282f1b-2166-5a96-b6ee-9552ad011354', 2, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a6282f1b-2166-5a96-b6ee-9552ad011354', 3, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a6282f1b-2166-5a96-b6ee-9552ad011354', 4, 21.5, NULL, false, '21.5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9185d37a-974d-5e99-bd0e-7fdd34f144d4', '03bd39bd-9417-50f9-8088-eb279c45cd96', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Julian Groves', '631', 'individual', 19, 83.0, 55.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '852e8d52-2cc6-50bd-82eb-723fc0289119', '9185d37a-974d-5e99-bd0e-7fdd34f144d4', '03bd39bd-9417-50f9-8088-eb279c45cd96', 'Julian Groves', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9185d37a-974d-5e99-bd0e-7fdd34f144d4', 1, 28.0, 'DNF', true, '(28 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9185d37a-974d-5e99-bd0e-7fdd34f144d4', 2, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9185d37a-974d-5e99-bd0e-7fdd34f144d4', 3, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9185d37a-974d-5e99-bd0e-7fdd34f144d4', 4, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '4879d4f6-345e-5170-8933-4d18a341d586', '947a9e38-5e6b-5c7b-9e00-05941778d140', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Rory Pattenden', '1427', 'individual', 20, 86.5, 58.5,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0e41c5a8-f347-5fdb-98c0-d7e11c998a89', '4879d4f6-345e-5170-8933-4d18a341d586', '947a9e38-5e6b-5c7b-9e00-05941778d140', 'Rory Pattenden', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4879d4f6-345e-5170-8933-4d18a341d586', 1, 28.0, 'DNC', true, '(28 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4879d4f6-345e-5170-8933-4d18a341d586', 2, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4879d4f6-345e-5170-8933-4d18a341d586', 3, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4879d4f6-345e-5170-8933-4d18a341d586', 4, 21.5, NULL, false, '21.5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b5cc4785-2c81-50b3-be80-93e8d518e71a', '5af32cad-bc1e-5d64-984d-a02b85f30667', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Taylor Cook', '406', 'individual', 21, 88.0, 60.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f6f6aefe-1b35-57b8-b233-651292925384', 'b5cc4785-2c81-50b3-be80-93e8d518e71a', '5af32cad-bc1e-5d64-984d-a02b85f30667', 'Taylor Cook', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b5cc4785-2c81-50b3-be80-93e8d518e71a', 1, 28.0, 'DNS', true, '(28 DNS)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b5cc4785-2c81-50b3-be80-93e8d518e71a', 2, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b5cc4785-2c81-50b3-be80-93e8d518e71a', 3, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b5cc4785-2c81-50b3-be80-93e8d518e71a', 4, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ec01a5a8-6141-5713-aeea-7be3d7bc7040', '0f725fd6-7353-592f-84db-bbd6fda6a6a7', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Imogen Troy', '1723', 'individual', 22, 94.0, 66.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1ca1beef-ef92-5017-bbdc-f1c6462a7472', 'ec01a5a8-6141-5713-aeea-7be3d7bc7040', '0f725fd6-7353-592f-84db-bbd6fda6a6a7', 'Imogen Troy', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ec01a5a8-6141-5713-aeea-7be3d7bc7040', 1, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ec01a5a8-6141-5713-aeea-7be3d7bc7040', 2, 28.0, 'DNC', true, '(28 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ec01a5a8-6141-5713-aeea-7be3d7bc7040', 3, 28.0, 'DNC', false, '28 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ec01a5a8-6141-5713-aeea-7be3d7bc7040', 4, 28.0, 'DNC', false, '28 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8266a290-9609-5fd8-8aba-06dc872046b1', 'ba4a1075-9189-582e-95c4-387237fd3aa3', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Teddy Sampson', '1144', 'individual', 23, 96.0, 68.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ce7bbdc0-ec3b-5439-a5c4-c9095054c509', '8266a290-9609-5fd8-8aba-06dc872046b1', 'ba4a1075-9189-582e-95c4-387237fd3aa3', 'Teddy Sampson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8266a290-9609-5fd8-8aba-06dc872046b1', 1, 28.0, 'DNC', true, '(28 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8266a290-9609-5fd8-8aba-06dc872046b1', 2, 28.0, 'DNS', false, '28 DNS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8266a290-9609-5fd8-8aba-06dc872046b1', 3, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8266a290-9609-5fd8-8aba-06dc872046b1', 4, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b66a1f9d-9aef-54cc-937c-2c703c498975', 'a23b49a2-9b25-5e8c-83cd-7623f57c08c6', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Alby Jones', '1680', 'individual', 24, 102.0, 74.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ca99a5da-77ce-5864-8091-168336343376', 'b66a1f9d-9aef-54cc-937c-2c703c498975', 'a23b49a2-9b25-5e8c-83cd-7623f57c08c6', 'Alby Jones', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b66a1f9d-9aef-54cc-937c-2c703c498975', 1, 28.0, 'DNC', true, '(28 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b66a1f9d-9aef-54cc-937c-2c703c498975', 2, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b66a1f9d-9aef-54cc-937c-2c703c498975', 3, 28.0, 'DNC', false, '28 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b66a1f9d-9aef-54cc-937c-2c703c498975', 4, 28.0, 'DNC', false, '28 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '35ba1f77-1b93-5398-b2c9-6c4ad6dd94af', '0ffd03e1-cd9b-5ef7-b8e6-e650960caae6', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Caleb McCarthy', '697', 'individual', 25, 107.0, 79.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd9305110-e736-5841-aa2d-4514bf0d1b54', '35ba1f77-1b93-5398-b2c9-6c4ad6dd94af', '0ffd03e1-cd9b-5ef7-b8e6-e650960caae6', 'Caleb McCarthy', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('35ba1f77-1b93-5398-b2c9-6c4ad6dd94af', 1, 28.0, 'DNF', true, '(28 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('35ba1f77-1b93-5398-b2c9-6c4ad6dd94af', 2, 28.0, 'DNC', false, '28 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('35ba1f77-1b93-5398-b2c9-6c4ad6dd94af', 3, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('35ba1f77-1b93-5398-b2c9-6c4ad6dd94af', 4, 28.0, 'OCS', false, '28 OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9b76d3d7-0562-509e-ae4a-841468b60d1b', '3fdc882d-1f3e-5214-b55c-9ab23761983c', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Oliver Jeffrey', '677', 'individual', 26, 112.0, 84.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '82cda94b-0f1f-584e-be6e-d07f4f198e76', '9b76d3d7-0562-509e-ae4a-841468b60d1b', '3fdc882d-1f3e-5214-b55c-9ab23761983c', 'Oliver Jeffrey', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9b76d3d7-0562-509e-ae4a-841468b60d1b', 1, 28.0, 'DNC', true, '(28 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9b76d3d7-0562-509e-ae4a-841468b60d1b', 2, 28.0, 'DNS', false, '28 DNS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9b76d3d7-0562-509e-ae4a-841468b60d1b', 3, 28.0, 'DNS', false, '28 DNS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9b76d3d7-0562-509e-ae4a-841468b60d1b', 4, 28.0, 'DNC', false, '28 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e1b6d29c-56a3-5b2e-ab78-57f1814c6091', 'df8b2353-da9f-5beb-930f-5a2caf913b15', '4835f06f-3382-53a8-8a42-dc29be4a0267', 'Harvey Knyvett', '1619', 'individual', 26, 112.0, 84.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1228', '2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Echo Course Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e36cb80e-41eb-50cd-9189-a1a5da298896', 'e1b6d29c-56a3-5b2e-ab78-57f1814c6091', 'df8b2353-da9f-5beb-930f-5a2caf913b15', 'Harvey Knyvett', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e1b6d29c-56a3-5b2e-ab78-57f1814c6091', 1, 28.0, 'DNC', true, '(28 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e1b6d29c-56a3-5b2e-ab78-57f1814c6091', 2, 28.0, 'DNC', false, '28 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e1b6d29c-56a3-5b2e-ab78-57f1814c6091', 3, 28.0, 'DNC', false, '28 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e1b6d29c-56a3-5b2e-ab78-57f1814c6091', 4, 28.0, 'DNC', false, '28 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail South Australia — Optimist Open (4 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e54aecff-7306-5c0f-96ea-160e79034394', '22518786-717e-5398-8c6a-99c1a4e269cf', '9a080071-9657-5b1e-93a8-3b340195dd7e', 'Ollie Johnson', '1854', 'individual', 1, 11.0, 6.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ed858b63-048a-5689-8f57-6f5d2394581e', 'e54aecff-7306-5c0f-96ea-160e79034394', '22518786-717e-5398-8c6a-99c1a4e269cf', 'Ollie Johnson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e54aecff-7306-5c0f-96ea-160e79034394', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e54aecff-7306-5c0f-96ea-160e79034394', 2, 5.0, 'DNF', true, '(5 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e54aecff-7306-5c0f-96ea-160e79034394', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e54aecff-7306-5c0f-96ea-160e79034394', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e54aecff-7306-5c0f-96ea-160e79034394', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e54aecff-7306-5c0f-96ea-160e79034394', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '90f2e3c8-6f5a-59e8-b041-9b291e9501f1', '223b5e00-fa91-4eb9-9fa9-83273b0760b8', '9a080071-9657-5b1e-93a8-3b340195dd7e', 'Summer Newman', '1899', 'individual', 2, 17.0, 12.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '280455c3-6be3-514c-8378-268358d121fb', '90f2e3c8-6f5a-59e8-b041-9b291e9501f1', '223b5e00-fa91-4eb9-9fa9-83273b0760b8', 'Summer Newman', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90f2e3c8-6f5a-59e8-b041-9b291e9501f1', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90f2e3c8-6f5a-59e8-b041-9b291e9501f1', 2, 5.0, 'DNF', true, '(5 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90f2e3c8-6f5a-59e8-b041-9b291e9501f1', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90f2e3c8-6f5a-59e8-b041-9b291e9501f1', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90f2e3c8-6f5a-59e8-b041-9b291e9501f1', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90f2e3c8-6f5a-59e8-b041-9b291e9501f1', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1535434c-0e00-5552-92b4-3a68aa94cbbc', 'a9500925-ba7f-504d-a073-e5c9b2946f0f', '9a080071-9657-5b1e-93a8-3b340195dd7e', 'Oli Morris', '1822', 'individual', 3, 17.0, 12.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1b1327e4-f941-5bf4-985d-25ab03da15c9', '1535434c-0e00-5552-92b4-3a68aa94cbbc', 'a9500925-ba7f-504d-a073-e5c9b2946f0f', 'Oli Morris', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1535434c-0e00-5552-92b4-3a68aa94cbbc', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1535434c-0e00-5552-92b4-3a68aa94cbbc', 2, 5.0, 'DNF', true, '(5 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1535434c-0e00-5552-92b4-3a68aa94cbbc', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1535434c-0e00-5552-92b4-3a68aa94cbbc', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1535434c-0e00-5552-92b4-3a68aa94cbbc', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1535434c-0e00-5552-92b4-3a68aa94cbbc', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '74bfc9d7-4227-5697-93d0-57fe64a4a731', '77778bb7-14b7-5c0b-b769-e9869adaf33e', '9a080071-9657-5b1e-93a8-3b340195dd7e', 'Jimi Westmoreland', '1485', 'individual', 4, 26.0, 21.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fdb6f592-5ba4-5539-96d4-944f6cae74c9', '74bfc9d7-4227-5697-93d0-57fe64a4a731', '77778bb7-14b7-5c0b-b769-e9869adaf33e', 'Jimi Westmoreland', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('74bfc9d7-4227-5697-93d0-57fe64a4a731', 1, 5.0, 'DNF', true, '(5 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('74bfc9d7-4227-5697-93d0-57fe64a4a731', 2, 5.0, 'DNF', false, '5 DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('74bfc9d7-4227-5697-93d0-57fe64a4a731', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('74bfc9d7-4227-5697-93d0-57fe64a4a731', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('74bfc9d7-4227-5697-93d0-57fe64a4a731', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('74bfc9d7-4227-5697-93d0-57fe64a4a731', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail South Australia — Optimist Intermediate (7 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '22ede8f1-b22c-504c-9b27-da7ed2028343', '24549454-ab63-5822-9a7c-be44c48cc5e5', '650fcb00-d44d-5a96-bc99-42797efb2882', 'Hugh Mcconnell', '1250', 'individual', 1, 13.0, 5.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e87d7b01-0a48-512f-b339-2f2460fb1410', '22ede8f1-b22c-504c-9b27-da7ed2028343', '24549454-ab63-5822-9a7c-be44c48cc5e5', 'Hugh Mcconnell', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('22ede8f1-b22c-504c-9b27-da7ed2028343', 1, 8.0, 'DNF', true, '(8 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('22ede8f1-b22c-504c-9b27-da7ed2028343', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('22ede8f1-b22c-504c-9b27-da7ed2028343', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('22ede8f1-b22c-504c-9b27-da7ed2028343', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '93085efc-7ebc-5a60-bcb0-e26b556ba5aa', '47a69d3d-73a1-53c8-aae6-779ea71d97ff', '650fcb00-d44d-5a96-bc99-42797efb2882', 'Ben Dunstone', '1242', 'individual', 2, 16.0, 8.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6dfaf8d4-7b48-5a8f-8a46-87754bd8d03e', '93085efc-7ebc-5a60-bcb0-e26b556ba5aa', '47a69d3d-73a1-53c8-aae6-779ea71d97ff', 'Ben Dunstone', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('93085efc-7ebc-5a60-bcb0-e26b556ba5aa', 1, 8.0, 'DNF', true, '(8 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('93085efc-7ebc-5a60-bcb0-e26b556ba5aa', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('93085efc-7ebc-5a60-bcb0-e26b556ba5aa', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('93085efc-7ebc-5a60-bcb0-e26b556ba5aa', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '96d0f0c3-484c-522c-9c06-d7ee626ff046', '0747afe4-5dca-5983-872e-68c1c3114bff', '650fcb00-d44d-5a96-bc99-42797efb2882', 'Natalie Griffin', '1125', 'individual', 3, 18.0, 10.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'edf8ca09-becf-5f0d-a848-b98fe9d78c3a', '96d0f0c3-484c-522c-9c06-d7ee626ff046', '0747afe4-5dca-5983-872e-68c1c3114bff', 'Natalie Griffin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('96d0f0c3-484c-522c-9c06-d7ee626ff046', 1, 8.0, 'DNF', true, '(8 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('96d0f0c3-484c-522c-9c06-d7ee626ff046', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('96d0f0c3-484c-522c-9c06-d7ee626ff046', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('96d0f0c3-484c-522c-9c06-d7ee626ff046', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '42f629c2-173a-56d6-9e88-67b50b61d581', '3e6f95cf-ffb2-56cf-8909-6f7337b7a0d3', '650fcb00-d44d-5a96-bc99-42797efb2882', 'Ozzy Kalynka', '761', 'individual', 4, 21.0, 13.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '008b8660-fc82-5b4c-8e70-b3d372f1b2f5', '42f629c2-173a-56d6-9e88-67b50b61d581', '3e6f95cf-ffb2-56cf-8909-6f7337b7a0d3', 'Ozzy Kalynka', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('42f629c2-173a-56d6-9e88-67b50b61d581', 1, 8.0, 'DNF', true, '(8 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('42f629c2-173a-56d6-9e88-67b50b61d581', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('42f629c2-173a-56d6-9e88-67b50b61d581', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('42f629c2-173a-56d6-9e88-67b50b61d581', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd984d012-73cb-5eed-a4f7-30e3ebab3c48', '94f0b3e4-b6cc-526f-b1e3-ddf6fc575b16', '650fcb00-d44d-5a96-bc99-42797efb2882', 'Isaac Bowker', '1906', 'individual', 5, 22.0, 14.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2278cb18-6516-55c3-aaa8-184a475a8007', 'd984d012-73cb-5eed-a4f7-30e3ebab3c48', '94f0b3e4-b6cc-526f-b1e3-ddf6fc575b16', 'Isaac Bowker', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d984d012-73cb-5eed-a4f7-30e3ebab3c48', 1, 8.0, 'DNF', true, '(8 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d984d012-73cb-5eed-a4f7-30e3ebab3c48', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d984d012-73cb-5eed-a4f7-30e3ebab3c48', 3, 8.0, 'DNF', false, '8 DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d984d012-73cb-5eed-a4f7-30e3ebab3c48', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '87b9dd21-d18c-59ed-ac0b-ec9afcbac284', 'da5f1125-5a62-50ec-b538-bada4a31b0db', '650fcb00-d44d-5a96-bc99-42797efb2882', 'Henry Mcconnell', '747', 'individual', 6, 25.0, 17.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '59c3c042-4c9e-5f49-8b9c-870b803e7dff', '87b9dd21-d18c-59ed-ac0b-ec9afcbac284', 'da5f1125-5a62-50ec-b538-bada4a31b0db', 'Henry Mcconnell', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('87b9dd21-d18c-59ed-ac0b-ec9afcbac284', 1, 8.0, 'DNF', true, '(8 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('87b9dd21-d18c-59ed-ac0b-ec9afcbac284', 2, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('87b9dd21-d18c-59ed-ac0b-ec9afcbac284', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('87b9dd21-d18c-59ed-ac0b-ec9afcbac284', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '03048731-be36-541b-9783-2c6989623469', '63e1c35a-bae1-532a-8ff9-8143132196b9', '650fcb00-d44d-5a96-bc99-42797efb2882', 'Lydia Edwards', '1210', 'individual', 7, 26.0, 18.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'cc236189-ba1a-57d7-a73f-5e44c7693513', '03048731-be36-541b-9783-2c6989623469', '63e1c35a-bae1-532a-8ff9-8143132196b9', 'Lydia Edwards', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('03048731-be36-541b-9783-2c6989623469', 1, 8.0, 'DNF', true, '(8 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('03048731-be36-541b-9783-2c6989623469', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('03048731-be36-541b-9783-2c6989623469', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('03048731-be36-541b-9783-2c6989623469', 4, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Western Australia — Optimist Open (25 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '5e1875f4-dbf7-5a59-868f-7061a453c4c6', 'b8cbccdc-a8ce-47cf-8728-5011daab6617', '6d912022-247e-566a-8637-033ef6073799', 'Harry Cooper', '1904', 'individual', 1, 40.0, 14.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '733245a7-a02f-5097-8dd2-e3f7f444375c', '5e1875f4-dbf7-5a59-868f-7061a453c4c6', 'b8cbccdc-a8ce-47cf-8728-5011daab6617', 'Harry Cooper', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5e1875f4-dbf7-5a59-868f-7061a453c4c6', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5e1875f4-dbf7-5a59-868f-7061a453c4c6', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5e1875f4-dbf7-5a59-868f-7061a453c4c6', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5e1875f4-dbf7-5a59-868f-7061a453c4c6', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5e1875f4-dbf7-5a59-868f-7061a453c4c6', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5e1875f4-dbf7-5a59-868f-7061a453c4c6', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5e1875f4-dbf7-5a59-868f-7061a453c4c6', 7, 26.0, 'OCS', true, '(26 OCS)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5e1875f4-dbf7-5a59-868f-7061a453c4c6', 8, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5e1875f4-dbf7-5a59-868f-7061a453c4c6', 9, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '272be79d-27e3-525b-88cd-0fc0f5e9ecbf', 'ad46f601-d513-4b82-803f-46a12a4ff2eb', '6d912022-247e-566a-8637-033ef6073799', 'Connor Grant', '1291', 'individual', 2, 35.0, 25.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8170291b-134a-5494-b352-2c495d93ee6c', '272be79d-27e3-525b-88cd-0fc0f5e9ecbf', 'ad46f601-d513-4b82-803f-46a12a4ff2eb', 'Connor Grant', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('272be79d-27e3-525b-88cd-0fc0f5e9ecbf', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('272be79d-27e3-525b-88cd-0fc0f5e9ecbf', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('272be79d-27e3-525b-88cd-0fc0f5e9ecbf', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('272be79d-27e3-525b-88cd-0fc0f5e9ecbf', 4, 10.0, NULL, true, '(10)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('272be79d-27e3-525b-88cd-0fc0f5e9ecbf', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('272be79d-27e3-525b-88cd-0fc0f5e9ecbf', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('272be79d-27e3-525b-88cd-0fc0f5e9ecbf', 7, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('272be79d-27e3-525b-88cd-0fc0f5e9ecbf', 8, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('272be79d-27e3-525b-88cd-0fc0f5e9ecbf', 9, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'be477886-e84f-56ab-bfe4-cfb695048b9f', 'bf23fd36-3596-4b3c-b92d-9123a1a84c14', '6d912022-247e-566a-8637-033ef6073799', 'Jayden Epari', '1740', 'individual', 3, 36.0, 25.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '37e9c722-6bc7-54a6-a060-86e9f50469be', 'be477886-e84f-56ab-bfe4-cfb695048b9f', 'bf23fd36-3596-4b3c-b92d-9123a1a84c14', 'Jayden Epari', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('be477886-e84f-56ab-bfe4-cfb695048b9f', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('be477886-e84f-56ab-bfe4-cfb695048b9f', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('be477886-e84f-56ab-bfe4-cfb695048b9f', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('be477886-e84f-56ab-bfe4-cfb695048b9f', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('be477886-e84f-56ab-bfe4-cfb695048b9f', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('be477886-e84f-56ab-bfe4-cfb695048b9f', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('be477886-e84f-56ab-bfe4-cfb695048b9f', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('be477886-e84f-56ab-bfe4-cfb695048b9f', 8, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('be477886-e84f-56ab-bfe4-cfb695048b9f', 9, 11.0, NULL, true, '(11)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '4e1cb593-73df-5be2-a179-f59dfb7c4c1c', 'db009883-9497-4b94-aebb-faefa490f260', '6d912022-247e-566a-8637-033ef6073799', 'Dylan Epari', '1516', 'individual', 4, 59.0, 42.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ddfe0727-c704-569d-8881-2954b544ac81', '4e1cb593-73df-5be2-a179-f59dfb7c4c1c', 'db009883-9497-4b94-aebb-faefa490f260', 'Dylan Epari', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4e1cb593-73df-5be2-a179-f59dfb7c4c1c', 1, 17.0, NULL, true, '(17)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4e1cb593-73df-5be2-a179-f59dfb7c4c1c', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4e1cb593-73df-5be2-a179-f59dfb7c4c1c', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4e1cb593-73df-5be2-a179-f59dfb7c4c1c', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4e1cb593-73df-5be2-a179-f59dfb7c4c1c', 5, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4e1cb593-73df-5be2-a179-f59dfb7c4c1c', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4e1cb593-73df-5be2-a179-f59dfb7c4c1c', 7, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4e1cb593-73df-5be2-a179-f59dfb7c4c1c', 8, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4e1cb593-73df-5be2-a179-f59dfb7c4c1c', 9, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a75af507-fc7f-5b13-ba4f-d2d313c531b7', 'a3082455-4079-441d-8436-478f4c9024b7', '6d912022-247e-566a-8637-033ef6073799', 'Lily-May Weller', '1304', 'individual', 5, 59.0, 43.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '91178d3f-78e0-5fc4-a9e0-b1bcaf2cd0c8', 'a75af507-fc7f-5b13-ba4f-d2d313c531b7', 'a3082455-4079-441d-8436-478f4c9024b7', 'Lily-May Weller', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a75af507-fc7f-5b13-ba4f-d2d313c531b7', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a75af507-fc7f-5b13-ba4f-d2d313c531b7', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a75af507-fc7f-5b13-ba4f-d2d313c531b7', 3, 15.0, 'SPI', false, '15 SPI') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a75af507-fc7f-5b13-ba4f-d2d313c531b7', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a75af507-fc7f-5b13-ba4f-d2d313c531b7', 5, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a75af507-fc7f-5b13-ba4f-d2d313c531b7', 6, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a75af507-fc7f-5b13-ba4f-d2d313c531b7', 7, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a75af507-fc7f-5b13-ba4f-d2d313c531b7', 8, 16.0, NULL, true, '(16)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a75af507-fc7f-5b13-ba4f-d2d313c531b7', 9, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '79df9eb5-88b0-5308-bc37-5e53fe5f2e60', '5359625c-bf84-49d1-b983-b908bd5b7f2e', '6d912022-247e-566a-8637-033ef6073799', 'Asher Williams', '1316', 'individual', 6, 57.0, 43.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2b459d35-a9a9-525a-8d01-ee410b33e6ef', '79df9eb5-88b0-5308-bc37-5e53fe5f2e60', '5359625c-bf84-49d1-b983-b908bd5b7f2e', 'Asher Williams', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('79df9eb5-88b0-5308-bc37-5e53fe5f2e60', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('79df9eb5-88b0-5308-bc37-5e53fe5f2e60', 2, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('79df9eb5-88b0-5308-bc37-5e53fe5f2e60', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('79df9eb5-88b0-5308-bc37-5e53fe5f2e60', 4, 14.0, NULL, true, '(14)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('79df9eb5-88b0-5308-bc37-5e53fe5f2e60', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('79df9eb5-88b0-5308-bc37-5e53fe5f2e60', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('79df9eb5-88b0-5308-bc37-5e53fe5f2e60', 7, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('79df9eb5-88b0-5308-bc37-5e53fe5f2e60', 8, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('79df9eb5-88b0-5308-bc37-5e53fe5f2e60', 9, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7a6a75d8-e42c-5384-952b-810823f94393', '49e3b629-7287-5783-a7d3-d00366db458b', '6d912022-247e-566a-8637-033ef6073799', 'Ollie Harry', '1520', 'individual', 7, 82.0, 56.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '63c77e4b-7e2b-517a-9435-1676f96f03e8', '7a6a75d8-e42c-5384-952b-810823f94393', '49e3b629-7287-5783-a7d3-d00366db458b', 'Ollie Harry', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7a6a75d8-e42c-5384-952b-810823f94393', 1, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7a6a75d8-e42c-5384-952b-810823f94393', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7a6a75d8-e42c-5384-952b-810823f94393', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7a6a75d8-e42c-5384-952b-810823f94393', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7a6a75d8-e42c-5384-952b-810823f94393', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7a6a75d8-e42c-5384-952b-810823f94393', 6, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7a6a75d8-e42c-5384-952b-810823f94393', 7, 26.0, 'OCS', true, '(26 OCS)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7a6a75d8-e42c-5384-952b-810823f94393', 8, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7a6a75d8-e42c-5384-952b-810823f94393', 9, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '92ee449c-40c3-5d87-a60f-d76341996eb0', 'a920942d-e921-4639-8fe8-bc183c330619', '6d912022-247e-566a-8637-033ef6073799', 'Callum Grant', '1113', 'individual', 8, 73.0, 60.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e5d63e2c-7449-519a-8a0b-789640128cbf', '92ee449c-40c3-5d87-a60f-d76341996eb0', 'a920942d-e921-4639-8fe8-bc183c330619', 'Callum Grant', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92ee449c-40c3-5d87-a60f-d76341996eb0', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92ee449c-40c3-5d87-a60f-d76341996eb0', 2, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92ee449c-40c3-5d87-a60f-d76341996eb0', 3, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92ee449c-40c3-5d87-a60f-d76341996eb0', 4, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92ee449c-40c3-5d87-a60f-d76341996eb0', 5, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92ee449c-40c3-5d87-a60f-d76341996eb0', 6, 13.0, NULL, true, '(13)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92ee449c-40c3-5d87-a60f-d76341996eb0', 7, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92ee449c-40c3-5d87-a60f-d76341996eb0', 8, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92ee449c-40c3-5d87-a60f-d76341996eb0', 9, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c3d71a7a-ad47-5ab9-8e3a-50e061b1932f', '9665941b-a00e-5d45-b44f-dacb4195bad6', '6d912022-247e-566a-8637-033ef6073799', 'Hayden Leighton', '560', 'individual', 9, 89.0, 63.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ef39f336-3b24-5235-9a4c-d3eefe4301c9', 'c3d71a7a-ad47-5ab9-8e3a-50e061b1932f', '9665941b-a00e-5d45-b44f-dacb4195bad6', 'Hayden Leighton', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3d71a7a-ad47-5ab9-8e3a-50e061b1932f', 1, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3d71a7a-ad47-5ab9-8e3a-50e061b1932f', 2, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3d71a7a-ad47-5ab9-8e3a-50e061b1932f', 3, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3d71a7a-ad47-5ab9-8e3a-50e061b1932f', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3d71a7a-ad47-5ab9-8e3a-50e061b1932f', 5, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3d71a7a-ad47-5ab9-8e3a-50e061b1932f', 6, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3d71a7a-ad47-5ab9-8e3a-50e061b1932f', 7, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3d71a7a-ad47-5ab9-8e3a-50e061b1932f', 8, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3d71a7a-ad47-5ab9-8e3a-50e061b1932f', 9, 26.0, 'DNC', true, '(26 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3aa92507-20ee-5968-810e-e2148a99d13c', 'd1a16c14-0db7-52f2-9a83-b5ddc57ae452', '6d912022-247e-566a-8637-033ef6073799', 'Leo Wrobel', '562', 'individual', 10, 79.0, 63.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8c7661d2-116c-5070-8ae9-15c65fcc7109', '3aa92507-20ee-5968-810e-e2148a99d13c', 'd1a16c14-0db7-52f2-9a83-b5ddc57ae452', 'Leo Wrobel', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3aa92507-20ee-5968-810e-e2148a99d13c', 1, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3aa92507-20ee-5968-810e-e2148a99d13c', 2, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3aa92507-20ee-5968-810e-e2148a99d13c', 3, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3aa92507-20ee-5968-810e-e2148a99d13c', 4, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3aa92507-20ee-5968-810e-e2148a99d13c', 5, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3aa92507-20ee-5968-810e-e2148a99d13c', 6, 16.0, NULL, true, '(16)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3aa92507-20ee-5968-810e-e2148a99d13c', 7, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3aa92507-20ee-5968-810e-e2148a99d13c', 8, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3aa92507-20ee-5968-810e-e2148a99d13c', 9, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '114f2200-049a-540a-8f8b-03339b15e5a0', '60dd4d51-c920-5e84-b1e4-b662df586d2f', '6d912022-247e-566a-8637-033ef6073799', 'Caitlin Grant', '327', 'individual', 11, 101.0, 85.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '91446d4c-e183-5aa3-90fd-3d958459d8be', '114f2200-049a-540a-8f8b-03339b15e5a0', '60dd4d51-c920-5e84-b1e4-b662df586d2f', 'Caitlin Grant', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('114f2200-049a-540a-8f8b-03339b15e5a0', 1, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('114f2200-049a-540a-8f8b-03339b15e5a0', 2, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('114f2200-049a-540a-8f8b-03339b15e5a0', 3, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('114f2200-049a-540a-8f8b-03339b15e5a0', 4, 16.0, NULL, true, '(16)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('114f2200-049a-540a-8f8b-03339b15e5a0', 5, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('114f2200-049a-540a-8f8b-03339b15e5a0', 6, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('114f2200-049a-540a-8f8b-03339b15e5a0', 7, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('114f2200-049a-540a-8f8b-03339b15e5a0', 8, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('114f2200-049a-540a-8f8b-03339b15e5a0', 9, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7e44ddf7-2d29-5e3a-92ac-ab302090b83b', '5e989cd1-b734-5443-9d3e-ea9794a9686f', '6d912022-247e-566a-8637-033ef6073799', 'Lauchlan Naylor', '1500', 'individual', 12, 119.0, 99.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '243ecfdd-b7fc-51e7-a1ae-3e717922e4d0', '7e44ddf7-2d29-5e3a-92ac-ab302090b83b', '5e989cd1-b734-5443-9d3e-ea9794a9686f', 'Lauchlan Naylor', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e44ddf7-2d29-5e3a-92ac-ab302090b83b', 1, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e44ddf7-2d29-5e3a-92ac-ab302090b83b', 2, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e44ddf7-2d29-5e3a-92ac-ab302090b83b', 3, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e44ddf7-2d29-5e3a-92ac-ab302090b83b', 4, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e44ddf7-2d29-5e3a-92ac-ab302090b83b', 5, 20.0, NULL, true, '(20)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e44ddf7-2d29-5e3a-92ac-ab302090b83b', 6, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e44ddf7-2d29-5e3a-92ac-ab302090b83b', 7, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e44ddf7-2d29-5e3a-92ac-ab302090b83b', 8, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e44ddf7-2d29-5e3a-92ac-ab302090b83b', 9, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f164aa0d-5241-54a4-b86e-93200010aead', '0e50e1f3-1582-531e-a22f-8c830e1c66f0', '6d912022-247e-566a-8637-033ef6073799', 'Matthew Sanders', '503', 'individual', 13, 127.0, 105.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'cb0e5ab2-4abc-5afd-adfa-2a486b6fb6ef', 'f164aa0d-5241-54a4-b86e-93200010aead', '0e50e1f3-1582-531e-a22f-8c830e1c66f0', 'Matthew Sanders', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f164aa0d-5241-54a4-b86e-93200010aead', 1, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f164aa0d-5241-54a4-b86e-93200010aead', 2, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f164aa0d-5241-54a4-b86e-93200010aead', 3, 22.0, NULL, true, '(22)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f164aa0d-5241-54a4-b86e-93200010aead', 4, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f164aa0d-5241-54a4-b86e-93200010aead', 5, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f164aa0d-5241-54a4-b86e-93200010aead', 6, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f164aa0d-5241-54a4-b86e-93200010aead', 7, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f164aa0d-5241-54a4-b86e-93200010aead', 8, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f164aa0d-5241-54a4-b86e-93200010aead', 9, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '40ecc3ef-89e1-5cdd-8f14-2cfc467378cb', '23fe2515-73f8-544c-8205-e0b55fc20b48', '6d912022-247e-566a-8637-033ef6073799', 'Hunter Wrobel', '498', 'individual', 14, 129.0, 106.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'cbb97843-c2d4-5954-a4ed-6549dee198f7', '40ecc3ef-89e1-5cdd-8f14-2cfc467378cb', '23fe2515-73f8-544c-8205-e0b55fc20b48', 'Hunter Wrobel', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('40ecc3ef-89e1-5cdd-8f14-2cfc467378cb', 1, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('40ecc3ef-89e1-5cdd-8f14-2cfc467378cb', 2, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('40ecc3ef-89e1-5cdd-8f14-2cfc467378cb', 3, 23.0, NULL, true, '(23)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('40ecc3ef-89e1-5cdd-8f14-2cfc467378cb', 4, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('40ecc3ef-89e1-5cdd-8f14-2cfc467378cb', 5, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('40ecc3ef-89e1-5cdd-8f14-2cfc467378cb', 6, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('40ecc3ef-89e1-5cdd-8f14-2cfc467378cb', 7, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('40ecc3ef-89e1-5cdd-8f14-2cfc467378cb', 8, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('40ecc3ef-89e1-5cdd-8f14-2cfc467378cb', 9, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '4deebe0a-27ea-589c-99fd-6db5b2676f89', 'cb9a3ee2-bfe4-5259-a130-6cf1752ce7e7', '6d912022-247e-566a-8637-033ef6073799', 'Daniel Saladine', '1157', 'individual', 15, 140.0, 117.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0eace067-aa68-5c8c-ae59-879633fcf06b', '4deebe0a-27ea-589c-99fd-6db5b2676f89', 'cb9a3ee2-bfe4-5259-a130-6cf1752ce7e7', 'Daniel Saladine', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4deebe0a-27ea-589c-99fd-6db5b2676f89', 1, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4deebe0a-27ea-589c-99fd-6db5b2676f89', 2, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4deebe0a-27ea-589c-99fd-6db5b2676f89', 3, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4deebe0a-27ea-589c-99fd-6db5b2676f89', 4, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4deebe0a-27ea-589c-99fd-6db5b2676f89', 5, 23.0, NULL, true, '(23)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4deebe0a-27ea-589c-99fd-6db5b2676f89', 6, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4deebe0a-27ea-589c-99fd-6db5b2676f89', 7, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4deebe0a-27ea-589c-99fd-6db5b2676f89', 8, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4deebe0a-27ea-589c-99fd-6db5b2676f89', 9, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '833bc2f2-f876-5cc1-a4c7-847a2bbdd904', 'e2d76144-8458-5f5a-a466-7b4359a454e8', '6d912022-247e-566a-8637-033ef6073799', 'Charlie Boulton', '947', 'individual', 16, 138.0, 118.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '22c577a7-89d6-5330-9d61-e2242f46f5ed', '833bc2f2-f876-5cc1-a4c7-847a2bbdd904', 'e2d76144-8458-5f5a-a466-7b4359a454e8', 'Charlie Boulton', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('833bc2f2-f876-5cc1-a4c7-847a2bbdd904', 1, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('833bc2f2-f876-5cc1-a4c7-847a2bbdd904', 2, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('833bc2f2-f876-5cc1-a4c7-847a2bbdd904', 3, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('833bc2f2-f876-5cc1-a4c7-847a2bbdd904', 4, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('833bc2f2-f876-5cc1-a4c7-847a2bbdd904', 5, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('833bc2f2-f876-5cc1-a4c7-847a2bbdd904', 6, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('833bc2f2-f876-5cc1-a4c7-847a2bbdd904', 7, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('833bc2f2-f876-5cc1-a4c7-847a2bbdd904', 8, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('833bc2f2-f876-5cc1-a4c7-847a2bbdd904', 9, 20.0, NULL, true, '(20)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '29e58332-fdda-5e1a-b2d9-7c552965cfa4', '9a874041-f749-5c35-a40a-a10deb2d3d8c', '6d912022-247e-566a-8637-033ef6073799', 'Adeline Sanders', '508', 'individual', 17, 150.0, 127.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6a75e447-7d06-5f0e-b6d6-e3c8c064e5da', '29e58332-fdda-5e1a-b2d9-7c552965cfa4', '9a874041-f749-5c35-a40a-a10deb2d3d8c', 'Adeline Sanders', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29e58332-fdda-5e1a-b2d9-7c552965cfa4', 1, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29e58332-fdda-5e1a-b2d9-7c552965cfa4', 2, 23.0, NULL, true, '(23)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29e58332-fdda-5e1a-b2d9-7c552965cfa4', 3, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29e58332-fdda-5e1a-b2d9-7c552965cfa4', 4, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29e58332-fdda-5e1a-b2d9-7c552965cfa4', 5, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29e58332-fdda-5e1a-b2d9-7c552965cfa4', 6, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29e58332-fdda-5e1a-b2d9-7c552965cfa4', 7, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29e58332-fdda-5e1a-b2d9-7c552965cfa4', 8, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29e58332-fdda-5e1a-b2d9-7c552965cfa4', 9, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '52be3cd1-0807-5092-bbf8-ec640039c9cd', 'da24b079-8fcd-5451-aaf0-f436f0cd9630', '6d912022-247e-566a-8637-033ef6073799', 'Willem Smith', '1488', 'individual', 18, 158.0, 132.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b05ad440-d833-5f8c-8d2b-47a06c3c48dd', '52be3cd1-0807-5092-bbf8-ec640039c9cd', 'da24b079-8fcd-5451-aaf0-f436f0cd9630', 'Willem Smith', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52be3cd1-0807-5092-bbf8-ec640039c9cd', 1, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52be3cd1-0807-5092-bbf8-ec640039c9cd', 2, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52be3cd1-0807-5092-bbf8-ec640039c9cd', 3, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52be3cd1-0807-5092-bbf8-ec640039c9cd', 4, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52be3cd1-0807-5092-bbf8-ec640039c9cd', 5, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52be3cd1-0807-5092-bbf8-ec640039c9cd', 6, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52be3cd1-0807-5092-bbf8-ec640039c9cd', 7, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52be3cd1-0807-5092-bbf8-ec640039c9cd', 8, 26.0, 'DNC', true, '(26 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52be3cd1-0807-5092-bbf8-ec640039c9cd', 9, 26.0, 'DNC', false, '26 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'bcea22c1-d938-51ed-b2fe-9e33e4982147', '6532ff66-67dd-59ba-877f-0e4a4db12199', '6d912022-247e-566a-8637-033ef6073799', 'Massimo Guidotti', '1861', 'individual', 19, 163.0, 140.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b580ca02-e7c3-59fc-976a-07a5bb41274d', 'bcea22c1-d938-51ed-b2fe-9e33e4982147', '6532ff66-67dd-59ba-877f-0e4a4db12199', 'Massimo Guidotti', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bcea22c1-d938-51ed-b2fe-9e33e4982147', 1, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bcea22c1-d938-51ed-b2fe-9e33e4982147', 2, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bcea22c1-d938-51ed-b2fe-9e33e4982147', 3, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bcea22c1-d938-51ed-b2fe-9e33e4982147', 4, 23.0, NULL, true, '(23)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bcea22c1-d938-51ed-b2fe-9e33e4982147', 5, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bcea22c1-d938-51ed-b2fe-9e33e4982147', 6, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bcea22c1-d938-51ed-b2fe-9e33e4982147', 7, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bcea22c1-d938-51ed-b2fe-9e33e4982147', 8, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bcea22c1-d938-51ed-b2fe-9e33e4982147', 9, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2dbd7656-074d-595e-bf48-5bf862d244a8', '341233b1-e3cf-5a0e-8636-88088ce0cb20', '6d912022-247e-566a-8637-033ef6073799', 'Leo Stay', '1718', 'individual', 20, 171.0, 145.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd22fd750-7329-5396-851e-1857f6cf73f3', '2dbd7656-074d-595e-bf48-5bf862d244a8', '341233b1-e3cf-5a0e-8636-88088ce0cb20', 'Leo Stay', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2dbd7656-074d-595e-bf48-5bf862d244a8', 1, 26.0, 'DSQ', true, '(26 DSQ)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2dbd7656-074d-595e-bf48-5bf862d244a8', 2, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2dbd7656-074d-595e-bf48-5bf862d244a8', 3, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2dbd7656-074d-595e-bf48-5bf862d244a8', 4, 26.0, 'OCS', false, '26 OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2dbd7656-074d-595e-bf48-5bf862d244a8', 5, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2dbd7656-074d-595e-bf48-5bf862d244a8', 6, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2dbd7656-074d-595e-bf48-5bf862d244a8', 7, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2dbd7656-074d-595e-bf48-5bf862d244a8', 8, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2dbd7656-074d-595e-bf48-5bf862d244a8', 9, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e37a8dc7-67e4-56e3-8d71-03c6b51e48f0', '5f837edc-6728-50d4-901d-6a8ea81dc026', '6d912022-247e-566a-8637-033ef6073799', 'Alice Cameron', '325', 'individual', 21, 174.0, 148.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0b4f6f42-1c03-5ac7-995a-b8eb65f664e0', 'e37a8dc7-67e4-56e3-8d71-03c6b51e48f0', '5f837edc-6728-50d4-901d-6a8ea81dc026', 'Alice Cameron', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e37a8dc7-67e4-56e3-8d71-03c6b51e48f0', 1, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e37a8dc7-67e4-56e3-8d71-03c6b51e48f0', 2, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e37a8dc7-67e4-56e3-8d71-03c6b51e48f0', 3, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e37a8dc7-67e4-56e3-8d71-03c6b51e48f0', 4, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e37a8dc7-67e4-56e3-8d71-03c6b51e48f0', 5, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e37a8dc7-67e4-56e3-8d71-03c6b51e48f0', 6, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e37a8dc7-67e4-56e3-8d71-03c6b51e48f0', 7, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e37a8dc7-67e4-56e3-8d71-03c6b51e48f0', 8, 26.0, 'DNC', true, '(26 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e37a8dc7-67e4-56e3-8d71-03c6b51e48f0', 9, 26.0, 'DNC', false, '26 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9bde01be-dca5-5eab-8130-848ecb2de7a7', '4d487477-0c02-58bd-87e3-ccfd1e2b8fc8', '6d912022-247e-566a-8637-033ef6073799', 'Shay Page', '563', 'individual', 22, 177.0, 153.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '13a79887-85f3-5864-be51-f5d675c37987', '9bde01be-dca5-5eab-8130-848ecb2de7a7', '4d487477-0c02-58bd-87e3-ccfd1e2b8fc8', 'Shay Page', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9bde01be-dca5-5eab-8130-848ecb2de7a7', 1, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9bde01be-dca5-5eab-8130-848ecb2de7a7', 2, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9bde01be-dca5-5eab-8130-848ecb2de7a7', 3, 24.0, NULL, true, '(24)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9bde01be-dca5-5eab-8130-848ecb2de7a7', 4, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9bde01be-dca5-5eab-8130-848ecb2de7a7', 5, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9bde01be-dca5-5eab-8130-848ecb2de7a7', 6, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9bde01be-dca5-5eab-8130-848ecb2de7a7', 7, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9bde01be-dca5-5eab-8130-848ecb2de7a7', 8, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9bde01be-dca5-5eab-8130-848ecb2de7a7', 9, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ec22437e-f461-56bb-85fb-64358232b58b', '0d5ed874-c95d-5332-98bd-dc214947c67c', '6d912022-247e-566a-8637-033ef6073799', 'Banjamin Lewis', '1521', 'individual', 23, 181.0, 158.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd7b2d3ab-3f1b-5c25-bb8a-524f6ea933c5', 'ec22437e-f461-56bb-85fb-64358232b58b', '0d5ed874-c95d-5332-98bd-dc214947c67c', 'Banjamin Lewis', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ec22437e-f461-56bb-85fb-64358232b58b', 1, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ec22437e-f461-56bb-85fb-64358232b58b', 2, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ec22437e-f461-56bb-85fb-64358232b58b', 3, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ec22437e-f461-56bb-85fb-64358232b58b', 4, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ec22437e-f461-56bb-85fb-64358232b58b', 5, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ec22437e-f461-56bb-85fb-64358232b58b', 6, 23.0, NULL, true, '(23)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ec22437e-f461-56bb-85fb-64358232b58b', 7, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ec22437e-f461-56bb-85fb-64358232b58b', 8, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ec22437e-f461-56bb-85fb-64358232b58b', 9, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e35d4f3b-2dac-5332-9156-b47d7d111a07', '6595c2d7-fc6c-555a-ae42-2c98ee5da394', '6d912022-247e-566a-8637-033ef6073799', 'Elke Bouckaert', '1371', 'individual', 24, 193.0, 168.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '26f41a3f-3c88-5643-8419-e02357c0edf1', 'e35d4f3b-2dac-5332-9156-b47d7d111a07', '6595c2d7-fc6c-555a-ae42-2c98ee5da394', 'Elke Bouckaert', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e35d4f3b-2dac-5332-9156-b47d7d111a07', 1, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e35d4f3b-2dac-5332-9156-b47d7d111a07', 2, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e35d4f3b-2dac-5332-9156-b47d7d111a07', 3, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e35d4f3b-2dac-5332-9156-b47d7d111a07', 4, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e35d4f3b-2dac-5332-9156-b47d7d111a07', 5, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e35d4f3b-2dac-5332-9156-b47d7d111a07', 6, 25.0, NULL, true, '(25)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e35d4f3b-2dac-5332-9156-b47d7d111a07', 7, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e35d4f3b-2dac-5332-9156-b47d7d111a07', 8, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e35d4f3b-2dac-5332-9156-b47d7d111a07', 9, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'cefb8c55-7804-5b07-81ce-d2cbc44e37af', 'e6668df4-6390-5d15-8761-1bf98a312b78', '6d912022-247e-566a-8637-033ef6073799', 'Jacques Burling', '246', 'individual', 25, 214.0, 189.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Open_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e31cddb9-2bd9-56ef-843b-b734771a0a21', 'cefb8c55-7804-5b07-81ce-d2cbc44e37af', 'e6668df4-6390-5d15-8761-1bf98a312b78', 'Jacques Burling', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cefb8c55-7804-5b07-81ce-d2cbc44e37af', 1, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cefb8c55-7804-5b07-81ce-d2cbc44e37af', 2, 25.0, NULL, true, '(25)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cefb8c55-7804-5b07-81ce-d2cbc44e37af', 3, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cefb8c55-7804-5b07-81ce-d2cbc44e37af', 4, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cefb8c55-7804-5b07-81ce-d2cbc44e37af', 5, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cefb8c55-7804-5b07-81ce-d2cbc44e37af', 6, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cefb8c55-7804-5b07-81ce-d2cbc44e37af', 7, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cefb8c55-7804-5b07-81ce-d2cbc44e37af', 8, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cefb8c55-7804-5b07-81ce-d2cbc44e37af', 9, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Western Australia — Optimist Intermediate (19 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b9a1b12a-a436-553a-aade-6744580bf02d', '00069d4d-4df9-50d9-9551-f2212d3b7c66', 'ee8e6248-a721-52ff-bcd2-c52531250a21', 'Shun Archibald', '1287', 'individual', 1, 29.0, 20.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0a93e95d-45ce-5ffc-9c29-d3b3b55aa515', 'b9a1b12a-a436-553a-aade-6744580bf02d', '00069d4d-4df9-50d9-9551-f2212d3b7c66', 'Shun Archibald', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9a1b12a-a436-553a-aade-6744580bf02d', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9a1b12a-a436-553a-aade-6744580bf02d', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9a1b12a-a436-553a-aade-6744580bf02d', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9a1b12a-a436-553a-aade-6744580bf02d', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9a1b12a-a436-553a-aade-6744580bf02d', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9a1b12a-a436-553a-aade-6744580bf02d', 6, 9.0, NULL, true, '(9)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9a1b12a-a436-553a-aade-6744580bf02d', 7, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9a1b12a-a436-553a-aade-6744580bf02d', 8, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9a1b12a-a436-553a-aade-6744580bf02d', 9, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'bec52226-f935-5b3e-bdfc-d04147536307', 'aba84567-9a62-5f40-85f5-3f5e37ad16c1', 'ee8e6248-a721-52ff-bcd2-c52531250a21', 'Louis Crowther', '1152', 'individual', 2, 34.0, 27.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2474b81d-3e82-54c6-9dbc-f8a41f401490', 'bec52226-f935-5b3e-bdfc-d04147536307', 'aba84567-9a62-5f40-85f5-3f5e37ad16c1', 'Louis Crowther', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bec52226-f935-5b3e-bdfc-d04147536307', 1, 7.0, NULL, true, '(7)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bec52226-f935-5b3e-bdfc-d04147536307', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bec52226-f935-5b3e-bdfc-d04147536307', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bec52226-f935-5b3e-bdfc-d04147536307', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bec52226-f935-5b3e-bdfc-d04147536307', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bec52226-f935-5b3e-bdfc-d04147536307', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bec52226-f935-5b3e-bdfc-d04147536307', 7, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bec52226-f935-5b3e-bdfc-d04147536307', 8, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bec52226-f935-5b3e-bdfc-d04147536307', 9, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'fbfd4fbb-d45e-5d31-b6c5-0efc0ad6a02a', 'dc73328b-c4db-541b-8d79-7020d51bf9a9', 'ee8e6248-a721-52ff-bcd2-c52531250a21', 'Thomas Carroll', '593', 'individual', 3, 44.0, 34.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '06bd02b3-7cd7-597a-96c6-b0c3b8e42272', 'fbfd4fbb-d45e-5d31-b6c5-0efc0ad6a02a', 'dc73328b-c4db-541b-8d79-7020d51bf9a9', 'Thomas Carroll', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fbfd4fbb-d45e-5d31-b6c5-0efc0ad6a02a', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fbfd4fbb-d45e-5d31-b6c5-0efc0ad6a02a', 2, 10.0, NULL, true, '(10)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fbfd4fbb-d45e-5d31-b6c5-0efc0ad6a02a', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fbfd4fbb-d45e-5d31-b6c5-0efc0ad6a02a', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fbfd4fbb-d45e-5d31-b6c5-0efc0ad6a02a', 5, 9.0, 'SPI', false, '9 SPI') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fbfd4fbb-d45e-5d31-b6c5-0efc0ad6a02a', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fbfd4fbb-d45e-5d31-b6c5-0efc0ad6a02a', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fbfd4fbb-d45e-5d31-b6c5-0efc0ad6a02a', 8, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fbfd4fbb-d45e-5d31-b6c5-0efc0ad6a02a', 9, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9fbf7296-63c5-5ba8-a284-f03b132d7c7f', '331d73ce-a518-5129-8c22-2b6294040fb6', 'ee8e6248-a721-52ff-bcd2-c52531250a21', 'Quade Potter', '557', 'individual', 4, 58.0, 44.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '70e27efe-aa7d-5f2b-94e2-ee86ed1653a8', '9fbf7296-63c5-5ba8-a284-f03b132d7c7f', '331d73ce-a518-5129-8c22-2b6294040fb6', 'Quade Potter', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9fbf7296-63c5-5ba8-a284-f03b132d7c7f', 1, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9fbf7296-63c5-5ba8-a284-f03b132d7c7f', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9fbf7296-63c5-5ba8-a284-f03b132d7c7f', 3, 14.0, NULL, true, '(14)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9fbf7296-63c5-5ba8-a284-f03b132d7c7f', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9fbf7296-63c5-5ba8-a284-f03b132d7c7f', 5, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9fbf7296-63c5-5ba8-a284-f03b132d7c7f', 6, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9fbf7296-63c5-5ba8-a284-f03b132d7c7f', 7, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9fbf7296-63c5-5ba8-a284-f03b132d7c7f', 8, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9fbf7296-63c5-5ba8-a284-f03b132d7c7f', 9, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '5eb9dcc3-ca8c-56dc-b26b-34bd257d30d5', '73139ef4-7cdf-53d0-9e55-022fac000482', 'ee8e6248-a721-52ff-bcd2-c52531250a21', 'Archer Luffman', '316', 'individual', 5, 60.0, 47.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '28348503-17f7-50bd-ba1d-7a6bddb3d34a', '5eb9dcc3-ca8c-56dc-b26b-34bd257d30d5', '73139ef4-7cdf-53d0-9e55-022fac000482', 'Archer Luffman', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5eb9dcc3-ca8c-56dc-b26b-34bd257d30d5', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5eb9dcc3-ca8c-56dc-b26b-34bd257d30d5', 2, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5eb9dcc3-ca8c-56dc-b26b-34bd257d30d5', 3, 13.0, 'SPI', true, '(13 SPI)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5eb9dcc3-ca8c-56dc-b26b-34bd257d30d5', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5eb9dcc3-ca8c-56dc-b26b-34bd257d30d5', 5, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5eb9dcc3-ca8c-56dc-b26b-34bd257d30d5', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5eb9dcc3-ca8c-56dc-b26b-34bd257d30d5', 7, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5eb9dcc3-ca8c-56dc-b26b-34bd257d30d5', 8, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5eb9dcc3-ca8c-56dc-b26b-34bd257d30d5', 9, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9c8b4918-d104-53ad-9aa6-57b4de464be4', '9fbb7cec-2583-5d47-990a-93fdb10dba32', 'ee8e6248-a721-52ff-bcd2-c52531250a21', 'Hugo Crowther', '740', 'individual', 6, 64.0, 53.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'db2ea73c-35bb-5e51-9778-05c6e8b13c19', '9c8b4918-d104-53ad-9aa6-57b4de464be4', '9fbb7cec-2583-5d47-990a-93fdb10dba32', 'Hugo Crowther', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c8b4918-d104-53ad-9aa6-57b4de464be4', 1, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c8b4918-d104-53ad-9aa6-57b4de464be4', 2, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c8b4918-d104-53ad-9aa6-57b4de464be4', 3, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c8b4918-d104-53ad-9aa6-57b4de464be4', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c8b4918-d104-53ad-9aa6-57b4de464be4', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c8b4918-d104-53ad-9aa6-57b4de464be4', 6, 11.0, 'SPI', true, '(11 SPI)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c8b4918-d104-53ad-9aa6-57b4de464be4', 7, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c8b4918-d104-53ad-9aa6-57b4de464be4', 8, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c8b4918-d104-53ad-9aa6-57b4de464be4', 9, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7c5e3b75-9ab5-5760-ae30-3a0b017f2802', 'b6369fa8-878c-519a-a304-b9b8374d660e', 'ee8e6248-a721-52ff-bcd2-c52531250a21', 'Blake Harkin', '287', 'individual', 7, 76.0, 56.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2ebfce26-b2b4-5e3f-b8f6-c5bb140e9674', '7c5e3b75-9ab5-5760-ae30-3a0b017f2802', 'b6369fa8-878c-519a-a304-b9b8374d660e', 'Blake Harkin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c5e3b75-9ab5-5760-ae30-3a0b017f2802', 1, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c5e3b75-9ab5-5760-ae30-3a0b017f2802', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c5e3b75-9ab5-5760-ae30-3a0b017f2802', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c5e3b75-9ab5-5760-ae30-3a0b017f2802', 4, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c5e3b75-9ab5-5760-ae30-3a0b017f2802', 5, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c5e3b75-9ab5-5760-ae30-3a0b017f2802', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c5e3b75-9ab5-5760-ae30-3a0b017f2802', 7, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c5e3b75-9ab5-5760-ae30-3a0b017f2802', 8, 20.0, 'OCS', true, '(20 OCS)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c5e3b75-9ab5-5760-ae30-3a0b017f2802', 9, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '52ed269c-8be4-5b4c-a7ff-379ef7a9e877', '980b8ddb-e1d6-5ab8-a7f3-662cedff1755', 'ee8e6248-a721-52ff-bcd2-c52531250a21', 'Harry Cunningham', '1677', 'individual', 8, 95.0, 75.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8cfc739d-d3a9-56d3-a458-8f8c8d712e79', '52ed269c-8be4-5b4c-a7ff-379ef7a9e877', '980b8ddb-e1d6-5ab8-a7f3-662cedff1755', 'Harry Cunningham', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52ed269c-8be4-5b4c-a7ff-379ef7a9e877', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52ed269c-8be4-5b4c-a7ff-379ef7a9e877', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52ed269c-8be4-5b4c-a7ff-379ef7a9e877', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52ed269c-8be4-5b4c-a7ff-379ef7a9e877', 4, 20.0, 'DNC', true, '(20 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52ed269c-8be4-5b4c-a7ff-379ef7a9e877', 5, 20.0, 'DNC', false, '20 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52ed269c-8be4-5b4c-a7ff-379ef7a9e877', 6, 20.0, 'DNC', false, '20 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52ed269c-8be4-5b4c-a7ff-379ef7a9e877', 7, 20.0, 'DNC', false, '20 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52ed269c-8be4-5b4c-a7ff-379ef7a9e877', 8, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('52ed269c-8be4-5b4c-a7ff-379ef7a9e877', 9, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0f4c7ce1-ff17-5ca3-99ef-64d858915af7', '222d7728-95bc-5da8-8968-333f46990a5f', 'ee8e6248-a721-52ff-bcd2-c52531250a21', 'Connor Reynolds', '799', 'individual', 9, 100.0, 80.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '20d741b0-94e2-52af-af1d-cdc1c73dee7e', '0f4c7ce1-ff17-5ca3-99ef-64d858915af7', '222d7728-95bc-5da8-8968-333f46990a5f', 'Connor Reynolds', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f4c7ce1-ff17-5ca3-99ef-64d858915af7', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f4c7ce1-ff17-5ca3-99ef-64d858915af7', 2, 20.0, 'DSQ', true, '(20 DSQ)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f4c7ce1-ff17-5ca3-99ef-64d858915af7', 3, 20.0, 'SPI', false, '20 SPI') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f4c7ce1-ff17-5ca3-99ef-64d858915af7', 4, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f4c7ce1-ff17-5ca3-99ef-64d858915af7', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f4c7ce1-ff17-5ca3-99ef-64d858915af7', 6, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f4c7ce1-ff17-5ca3-99ef-64d858915af7', 7, 20.0, 'DSQ', false, '20 DSQ') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f4c7ce1-ff17-5ca3-99ef-64d858915af7', 8, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f4c7ce1-ff17-5ca3-99ef-64d858915af7', 9, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'dc8cce03-3be5-5bc8-a927-ece1f306ef09', '9fd3d1a5-43bf-58d7-ab36-bbb548bcae39', 'ee8e6248-a721-52ff-bcd2-c52531250a21', 'Edward Carter', '658', 'individual', 10, 101.0, 85.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '938a5375-5844-5cc3-a6b0-056b0878c91d', 'dc8cce03-3be5-5bc8-a927-ece1f306ef09', '9fd3d1a5-43bf-58d7-ab36-bbb548bcae39', 'Edward Carter', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc8cce03-3be5-5bc8-a927-ece1f306ef09', 1, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc8cce03-3be5-5bc8-a927-ece1f306ef09', 2, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc8cce03-3be5-5bc8-a927-ece1f306ef09', 3, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc8cce03-3be5-5bc8-a927-ece1f306ef09', 4, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc8cce03-3be5-5bc8-a927-ece1f306ef09', 5, 12.0, 'SPI', false, '12 SPI') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc8cce03-3be5-5bc8-a927-ece1f306ef09', 6, 16.0, 'SPI', true, '(16 SPI)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc8cce03-3be5-5bc8-a927-ece1f306ef09', 7, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc8cce03-3be5-5bc8-a927-ece1f306ef09', 8, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc8cce03-3be5-5bc8-a927-ece1f306ef09', 9, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '21590f8d-cc8a-53b8-b17d-2e199ea8861d', 'a3c51e0f-01e8-5894-a709-a280e1ffe376', 'ee8e6248-a721-52ff-bcd2-c52531250a21', 'William Carroll', '1355', 'individual', 11, 109.0, 89.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9f620cf8-163a-5587-b3ae-3d483696b4a5', '21590f8d-cc8a-53b8-b17d-2e199ea8861d', 'a3c51e0f-01e8-5894-a709-a280e1ffe376', 'William Carroll', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('21590f8d-cc8a-53b8-b17d-2e199ea8861d', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('21590f8d-cc8a-53b8-b17d-2e199ea8861d', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('21590f8d-cc8a-53b8-b17d-2e199ea8861d', 3, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('21590f8d-cc8a-53b8-b17d-2e199ea8861d', 4, 20.0, 'DNC', true, '(20 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('21590f8d-cc8a-53b8-b17d-2e199ea8861d', 5, 20.0, 'DNC', false, '20 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('21590f8d-cc8a-53b8-b17d-2e199ea8861d', 6, 20.0, 'DNC', false, '20 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('21590f8d-cc8a-53b8-b17d-2e199ea8861d', 7, 20.0, 'DNC', false, '20 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('21590f8d-cc8a-53b8-b17d-2e199ea8861d', 8, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('21590f8d-cc8a-53b8-b17d-2e199ea8861d', 9, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c5dc4364-ade2-59bf-b4e8-f8a7227b898a', 'b0687a1f-46e7-53d6-932b-e8bb5a2cdeb9', 'ee8e6248-a721-52ff-bcd2-c52531250a21', 'Audrey Cameron', '1203', 'individual', 12, 110.0, 90.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2049701a-54c9-5886-be47-8ef6bd1d6095', 'c5dc4364-ade2-59bf-b4e8-f8a7227b898a', 'b0687a1f-46e7-53d6-932b-e8bb5a2cdeb9', 'Audrey Cameron', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c5dc4364-ade2-59bf-b4e8-f8a7227b898a', 1, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c5dc4364-ade2-59bf-b4e8-f8a7227b898a', 2, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c5dc4364-ade2-59bf-b4e8-f8a7227b898a', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c5dc4364-ade2-59bf-b4e8-f8a7227b898a', 4, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c5dc4364-ade2-59bf-b4e8-f8a7227b898a', 5, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c5dc4364-ade2-59bf-b4e8-f8a7227b898a', 6, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c5dc4364-ade2-59bf-b4e8-f8a7227b898a', 7, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c5dc4364-ade2-59bf-b4e8-f8a7227b898a', 8, 20.0, 'DNC', true, '(20 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c5dc4364-ade2-59bf-b4e8-f8a7227b898a', 9, 20.0, 'DNC', false, '20 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'fa0061d5-41c7-5ade-a470-68fc97821bd4', '7156515a-964c-5b40-8550-3c0f386a6d5a', 'ee8e6248-a721-52ff-bcd2-c52531250a21', 'Hector Campbell-Sloan', '680', 'individual', 13, 121.0, 103.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7b380848-64dc-57fe-99ee-d963223d2028', 'fa0061d5-41c7-5ade-a470-68fc97821bd4', '7156515a-964c-5b40-8550-3c0f386a6d5a', 'Hector Campbell-Sloan', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fa0061d5-41c7-5ade-a470-68fc97821bd4', 1, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fa0061d5-41c7-5ade-a470-68fc97821bd4', 2, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fa0061d5-41c7-5ade-a470-68fc97821bd4', 3, 18.0, NULL, true, '(18)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fa0061d5-41c7-5ade-a470-68fc97821bd4', 4, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fa0061d5-41c7-5ade-a470-68fc97821bd4', 5, 16.0, 'SPI', false, '16 SPI') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fa0061d5-41c7-5ade-a470-68fc97821bd4', 6, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fa0061d5-41c7-5ade-a470-68fc97821bd4', 7, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fa0061d5-41c7-5ade-a470-68fc97821bd4', 8, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fa0061d5-41c7-5ade-a470-68fc97821bd4', 9, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c481f156-3e4e-5171-95d9-f76dfec0f914', 'ed8edcb0-8d0c-5e82-a7a4-866072fd4955', 'ee8e6248-a721-52ff-bcd2-c52531250a21', 'Maya Forrester', '1393', 'individual', 14, 118.0, 103.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '01287446-656b-5c0b-85db-b4fc4c3afe99', 'c481f156-3e4e-5171-95d9-f76dfec0f914', 'ed8edcb0-8d0c-5e82-a7a4-866072fd4955', 'Maya Forrester', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c481f156-3e4e-5171-95d9-f76dfec0f914', 1, 15.0, NULL, true, '(15)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c481f156-3e4e-5171-95d9-f76dfec0f914', 2, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c481f156-3e4e-5171-95d9-f76dfec0f914', 3, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c481f156-3e4e-5171-95d9-f76dfec0f914', 4, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c481f156-3e4e-5171-95d9-f76dfec0f914', 5, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c481f156-3e4e-5171-95d9-f76dfec0f914', 6, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c481f156-3e4e-5171-95d9-f76dfec0f914', 7, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c481f156-3e4e-5171-95d9-f76dfec0f914', 8, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c481f156-3e4e-5171-95d9-f76dfec0f914', 9, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd22b8a59-8ed6-5e6c-80df-6132e2ab0109', 'ff5ae8f1-504b-5885-aba7-1618a9bfab99', 'ee8e6248-a721-52ff-bcd2-c52531250a21', 'Amy Cameron', '220', 'individual', 15, 125.0, 105.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5d6596e3-d0f2-585f-bc5e-e76a7e3de2cb', 'd22b8a59-8ed6-5e6c-80df-6132e2ab0109', 'ff5ae8f1-504b-5885-aba7-1618a9bfab99', 'Amy Cameron', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d22b8a59-8ed6-5e6c-80df-6132e2ab0109', 1, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d22b8a59-8ed6-5e6c-80df-6132e2ab0109', 2, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d22b8a59-8ed6-5e6c-80df-6132e2ab0109', 3, 20.0, 'SPI', true, '(20 SPI)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d22b8a59-8ed6-5e6c-80df-6132e2ab0109', 4, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d22b8a59-8ed6-5e6c-80df-6132e2ab0109', 5, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d22b8a59-8ed6-5e6c-80df-6132e2ab0109', 6, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d22b8a59-8ed6-5e6c-80df-6132e2ab0109', 7, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d22b8a59-8ed6-5e6c-80df-6132e2ab0109', 8, 20.0, 'DNC', false, '20 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d22b8a59-8ed6-5e6c-80df-6132e2ab0109', 9, 20.0, 'DNC', false, '20 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f980a59b-f25f-5a1f-afb6-a4cc23c2433f', 'ca8a5657-7578-51a2-9d30-ca94b022df9d', 'ee8e6248-a721-52ff-bcd2-c52531250a21', 'Vincent Jacniacki', '604', 'individual', 16, 131.0, 113.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '64355116-6ce5-5e8a-a039-08eb5c8558e7', 'f980a59b-f25f-5a1f-afb6-a4cc23c2433f', 'ca8a5657-7578-51a2-9d30-ca94b022df9d', 'Vincent Jacniacki', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f980a59b-f25f-5a1f-afb6-a4cc23c2433f', 1, 18.0, NULL, true, '(18)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f980a59b-f25f-5a1f-afb6-a4cc23c2433f', 2, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f980a59b-f25f-5a1f-afb6-a4cc23c2433f', 3, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f980a59b-f25f-5a1f-afb6-a4cc23c2433f', 4, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f980a59b-f25f-5a1f-afb6-a4cc23c2433f', 5, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f980a59b-f25f-5a1f-afb6-a4cc23c2433f', 6, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f980a59b-f25f-5a1f-afb6-a4cc23c2433f', 7, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f980a59b-f25f-5a1f-afb6-a4cc23c2433f', 8, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f980a59b-f25f-5a1f-afb6-a4cc23c2433f', 9, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '5985a29c-e25d-5db5-8c58-ae2a2a443ff6', 'ff8c5b6c-ec78-5769-8f0c-ae368ee1edb4', 'ee8e6248-a721-52ff-bcd2-c52531250a21', 'Zeno Brackenridge', '1942', 'individual', 17, 140.0, 120.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'db6c2737-44ad-554b-85b3-f34152e514e8', '5985a29c-e25d-5db5-8c58-ae2a2a443ff6', 'ff8c5b6c-ec78-5769-8f0c-ae368ee1edb4', 'Zeno Brackenridge', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5985a29c-e25d-5db5-8c58-ae2a2a443ff6', 1, 20.0, 'TLE', true, '(20 TLE)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5985a29c-e25d-5db5-8c58-ae2a2a443ff6', 2, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5985a29c-e25d-5db5-8c58-ae2a2a443ff6', 3, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5985a29c-e25d-5db5-8c58-ae2a2a443ff6', 4, 20.0, 'RET', false, '20 RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5985a29c-e25d-5db5-8c58-ae2a2a443ff6', 5, 16.0, 'SPI', false, '16 SPI') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5985a29c-e25d-5db5-8c58-ae2a2a443ff6', 6, 20.0, 'DNS', false, '20 DNS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5985a29c-e25d-5db5-8c58-ae2a2a443ff6', 7, 15.0, 'SPI', false, '15 SPI') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5985a29c-e25d-5db5-8c58-ae2a2a443ff6', 8, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5985a29c-e25d-5db5-8c58-ae2a2a443ff6', 9, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'eb675dd0-26d9-5265-b4cb-fa80fc4b27db', '8a82e08a-0937-5004-a427-9d52b1222c44', 'ee8e6248-a721-52ff-bcd2-c52531250a21', 'Edison Williams', '566', 'individual', 18, 146.0, 126.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7b23211b-aa58-50f2-a849-0f83cbc5f4ef', 'eb675dd0-26d9-5265-b4cb-fa80fc4b27db', '8a82e08a-0937-5004-a427-9d52b1222c44', 'Edison Williams', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eb675dd0-26d9-5265-b4cb-fa80fc4b27db', 1, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eb675dd0-26d9-5265-b4cb-fa80fc4b27db', 2, 20.0, 'OCS', true, '(20 OCS)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eb675dd0-26d9-5265-b4cb-fa80fc4b27db', 3, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eb675dd0-26d9-5265-b4cb-fa80fc4b27db', 4, 20.0, 'DNC', false, '20 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eb675dd0-26d9-5265-b4cb-fa80fc4b27db', 5, 20.0, 'DNS', false, '20 DNS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eb675dd0-26d9-5265-b4cb-fa80fc4b27db', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eb675dd0-26d9-5265-b4cb-fa80fc4b27db', 7, 20.0, 'DNF', false, '20 DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eb675dd0-26d9-5265-b4cb-fa80fc4b27db', 8, 20.0, 'TLE', false, '20 TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eb675dd0-26d9-5265-b4cb-fa80fc4b27db', 9, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '99cab8dd-5029-51a1-b247-38b1e626fe65', '75fede3f-6f2f-584e-b9d1-15b804cbb573', 'ee8e6248-a721-52ff-bcd2-c52531250a21', 'Victor Jacniacki', '501', 'individual', 19, 152.0, 132.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/Optimist_Intermediate_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '202932ba-b3cc-5b70-ad60-02fdd7c07c7a', '99cab8dd-5029-51a1-b247-38b1e626fe65', '75fede3f-6f2f-584e-b9d1-15b804cbb573', 'Victor Jacniacki', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99cab8dd-5029-51a1-b247-38b1e626fe65', 1, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99cab8dd-5029-51a1-b247-38b1e626fe65', 2, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99cab8dd-5029-51a1-b247-38b1e626fe65', 3, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99cab8dd-5029-51a1-b247-38b1e626fe65', 4, 20.0, 'DNF', true, '(20 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99cab8dd-5029-51a1-b247-38b1e626fe65', 5, 20.0, 'RET', false, '20 RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99cab8dd-5029-51a1-b247-38b1e626fe65', 6, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99cab8dd-5029-51a1-b247-38b1e626fe65', 7, 20.0, 'DNF', false, '20 DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99cab8dd-5029-51a1-b247-38b1e626fe65', 8, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99cab8dd-5029-51a1-b247-38b1e626fe65', 9, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail New South Wales — Optimist Open (74 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a0983aa0-5847-5427-a6cd-6c463473e6f9', '9e8f469d-4386-46dc-8533-5babc753dd05', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Jack Mcguire', '1936', 'individual', 1, 50.0, 32.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5b6d51e7-a5ea-5ee5-9bb4-fbb4bd1ff16a', 'a0983aa0-5847-5427-a6cd-6c463473e6f9', '9e8f469d-4386-46dc-8533-5babc753dd05', 'Jack McGuire', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0983aa0-5847-5427-a6cd-6c463473e6f9', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0983aa0-5847-5427-a6cd-6c463473e6f9', 2, 18.0, NULL, true, '(18)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0983aa0-5847-5427-a6cd-6c463473e6f9', 3, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0983aa0-5847-5427-a6cd-6c463473e6f9', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0983aa0-5847-5427-a6cd-6c463473e6f9', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0983aa0-5847-5427-a6cd-6c463473e6f9', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0983aa0-5847-5427-a6cd-6c463473e6f9', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0983aa0-5847-5427-a6cd-6c463473e6f9', 8, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0983aa0-5847-5427-a6cd-6c463473e6f9', 9, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3f83aecb-2b2b-5bd4-a9a8-f1c3a199b772', '7b929e9d-7925-4705-94ab-d175a82bb610', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Kalle Gravare', '1929', 'individual', 2, 73.0, 53.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '55a78bc5-6a27-50fc-a324-02e346d2dbc9', '3f83aecb-2b2b-5bd4-a9a8-f1c3a199b772', '7b929e9d-7925-4705-94ab-d175a82bb610', 'Kalle Gravare', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3f83aecb-2b2b-5bd4-a9a8-f1c3a199b772', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3f83aecb-2b2b-5bd4-a9a8-f1c3a199b772', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3f83aecb-2b2b-5bd4-a9a8-f1c3a199b772', 3, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3f83aecb-2b2b-5bd4-a9a8-f1c3a199b772', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3f83aecb-2b2b-5bd4-a9a8-f1c3a199b772', 5, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3f83aecb-2b2b-5bd4-a9a8-f1c3a199b772', 6, 20.0, NULL, true, '(20)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3f83aecb-2b2b-5bd4-a9a8-f1c3a199b772', 7, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3f83aecb-2b2b-5bd4-a9a8-f1c3a199b772', 8, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3f83aecb-2b2b-5bd4-a9a8-f1c3a199b772', 9, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'cb4ed2bd-2c35-50de-85ec-f24c75b2eeba', '5a61d861-917e-55b9-85db-9c122fcc9183', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Luca De Giosa', '1920', 'individual', 3, 128.0, 53.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'cb34ecfd-78f6-5682-b894-e4ef61346bc2', 'cb4ed2bd-2c35-50de-85ec-f24c75b2eeba', '5a61d861-917e-55b9-85db-9c122fcc9183', 'Luca De Giosa', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cb4ed2bd-2c35-50de-85ec-f24c75b2eeba', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cb4ed2bd-2c35-50de-85ec-f24c75b2eeba', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cb4ed2bd-2c35-50de-85ec-f24c75b2eeba', 3, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cb4ed2bd-2c35-50de-85ec-f24c75b2eeba', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cb4ed2bd-2c35-50de-85ec-f24c75b2eeba', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cb4ed2bd-2c35-50de-85ec-f24c75b2eeba', 6, 75.0, 'BFD', true, '(75)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cb4ed2bd-2c35-50de-85ec-f24c75b2eeba', 7, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cb4ed2bd-2c35-50de-85ec-f24c75b2eeba', 8, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cb4ed2bd-2c35-50de-85ec-f24c75b2eeba', 9, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b2283468-b702-5626-8300-dbd8a225d511', '0f1eb283-e53c-533e-8113-55753e658647', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Emma Tomkins', '1781', 'individual', 4, 73.0, 55.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4987dcb0-fe9a-5984-bf8d-8e1f22fe1e11', 'b2283468-b702-5626-8300-dbd8a225d511', '0f1eb283-e53c-533e-8113-55753e658647', 'Emma Tomkins', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b2283468-b702-5626-8300-dbd8a225d511', 1, 18.0, NULL, true, '(18)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b2283468-b702-5626-8300-dbd8a225d511', 2, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b2283468-b702-5626-8300-dbd8a225d511', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b2283468-b702-5626-8300-dbd8a225d511', 4, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b2283468-b702-5626-8300-dbd8a225d511', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b2283468-b702-5626-8300-dbd8a225d511', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b2283468-b702-5626-8300-dbd8a225d511', 7, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b2283468-b702-5626-8300-dbd8a225d511', 8, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b2283468-b702-5626-8300-dbd8a225d511', 9, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ea8276f2-9a9a-5632-be2c-154a0108fec0', 'b2f3bfeb-f969-518e-b631-70da18fadc0d', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'William Harris', '1932', 'individual', 5, 160.0, 85.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6a3eaaf1-bfc1-5058-acc1-b0e77914559e', 'ea8276f2-9a9a-5632-be2c-154a0108fec0', 'b2f3bfeb-f969-518e-b631-70da18fadc0d', 'William Harris', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea8276f2-9a9a-5632-be2c-154a0108fec0', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea8276f2-9a9a-5632-be2c-154a0108fec0', 2, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea8276f2-9a9a-5632-be2c-154a0108fec0', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea8276f2-9a9a-5632-be2c-154a0108fec0', 4, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea8276f2-9a9a-5632-be2c-154a0108fec0', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea8276f2-9a9a-5632-be2c-154a0108fec0', 6, 75.0, 'BFD', true, '(75)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea8276f2-9a9a-5632-be2c-154a0108fec0', 7, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea8276f2-9a9a-5632-be2c-154a0108fec0', 8, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea8276f2-9a9a-5632-be2c-154a0108fec0', 9, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '35b73dd0-1fed-536a-a4aa-d1427abcb453', '30880421-1dc4-4a14-9c6b-8c00de39e4d8', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Tom Griffiths', '1744', 'individual', 6, 125.0, 97.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '909b4876-6969-5561-beb4-8eff02500480', '35b73dd0-1fed-536a-a4aa-d1427abcb453', '30880421-1dc4-4a14-9c6b-8c00de39e4d8', 'Tom Griffiths', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('35b73dd0-1fed-536a-a4aa-d1427abcb453', 1, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('35b73dd0-1fed-536a-a4aa-d1427abcb453', 2, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('35b73dd0-1fed-536a-a4aa-d1427abcb453', 3, 28.0, NULL, true, '(28)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('35b73dd0-1fed-536a-a4aa-d1427abcb453', 4, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('35b73dd0-1fed-536a-a4aa-d1427abcb453', 5, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('35b73dd0-1fed-536a-a4aa-d1427abcb453', 6, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('35b73dd0-1fed-536a-a4aa-d1427abcb453', 7, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('35b73dd0-1fed-536a-a4aa-d1427abcb453', 8, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('35b73dd0-1fed-536a-a4aa-d1427abcb453', 9, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '4eaf50b4-7180-5f73-839b-7ad3fd256a57', 'f5f68b83-bb5b-4523-963f-3f367d5b4771', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Yufu Wang', '743', 'individual', 7, 174.0, 99.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0ebb6593-ccd2-5879-a350-77612eecc224', '4eaf50b4-7180-5f73-839b-7ad3fd256a57', 'f5f68b83-bb5b-4523-963f-3f367d5b4771', 'Yufu Wang', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4eaf50b4-7180-5f73-839b-7ad3fd256a57', 1, 75.0, 'OCS', true, '(75)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4eaf50b4-7180-5f73-839b-7ad3fd256a57', 2, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4eaf50b4-7180-5f73-839b-7ad3fd256a57', 3, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4eaf50b4-7180-5f73-839b-7ad3fd256a57', 4, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4eaf50b4-7180-5f73-839b-7ad3fd256a57', 5, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4eaf50b4-7180-5f73-839b-7ad3fd256a57', 6, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4eaf50b4-7180-5f73-839b-7ad3fd256a57', 7, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4eaf50b4-7180-5f73-839b-7ad3fd256a57', 8, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4eaf50b4-7180-5f73-839b-7ad3fd256a57', 9, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'cbe9049c-54a3-52ec-82cd-099b52423445', 'e2a4b0c4-c2cc-4a03-b198-6378b590fc0b', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Sebastian Cheng', '67', 'individual', 8, 182.0, 107.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c97ee2b0-65cd-5850-80fb-7abb25f1487a', 'cbe9049c-54a3-52ec-82cd-099b52423445', 'e2a4b0c4-c2cc-4a03-b198-6378b590fc0b', 'Sebastian Cheng', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cbe9049c-54a3-52ec-82cd-099b52423445', 1, 75.0, 'OCS', true, '(75)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cbe9049c-54a3-52ec-82cd-099b52423445', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cbe9049c-54a3-52ec-82cd-099b52423445', 3, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cbe9049c-54a3-52ec-82cd-099b52423445', 4, 40.0, NULL, false, '40') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cbe9049c-54a3-52ec-82cd-099b52423445', 5, 37.0, NULL, false, '37') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cbe9049c-54a3-52ec-82cd-099b52423445', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cbe9049c-54a3-52ec-82cd-099b52423445', 7, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cbe9049c-54a3-52ec-82cd-099b52423445', 8, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cbe9049c-54a3-52ec-82cd-099b52423445', 9, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '427d2694-c756-5131-ac71-56425401243f', 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Oliver Johnson', '1854', 'individual', 9, 183.0, 108.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7dc8abdd-10af-54e3-979f-254622197d33', '427d2694-c756-5131-ac71-56425401243f', 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81', 'Oliver Johnson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('427d2694-c756-5131-ac71-56425401243f', 1, 75.0, 'OCS', true, '(75)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('427d2694-c756-5131-ac71-56425401243f', 2, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('427d2694-c756-5131-ac71-56425401243f', 3, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('427d2694-c756-5131-ac71-56425401243f', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('427d2694-c756-5131-ac71-56425401243f', 5, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('427d2694-c756-5131-ac71-56425401243f', 6, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('427d2694-c756-5131-ac71-56425401243f', 7, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('427d2694-c756-5131-ac71-56425401243f', 8, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('427d2694-c756-5131-ac71-56425401243f', 9, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '02e92ebb-26c3-5207-a1d2-73a8a96acda1', 'b64cc6ae-a6e8-47a4-b702-b067d02e1f19', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Jayden Wang', '1847', 'individual', 10, 147.0, 110.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e29b85d4-6839-5554-bb7f-8dcbc2ff56e9', '02e92ebb-26c3-5207-a1d2-73a8a96acda1', 'b64cc6ae-a6e8-47a4-b702-b067d02e1f19', 'Jayden Wang', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02e92ebb-26c3-5207-a1d2-73a8a96acda1', 1, 37.0, NULL, true, '(37)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02e92ebb-26c3-5207-a1d2-73a8a96acda1', 2, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02e92ebb-26c3-5207-a1d2-73a8a96acda1', 3, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02e92ebb-26c3-5207-a1d2-73a8a96acda1', 4, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02e92ebb-26c3-5207-a1d2-73a8a96acda1', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02e92ebb-26c3-5207-a1d2-73a8a96acda1', 6, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02e92ebb-26c3-5207-a1d2-73a8a96acda1', 7, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02e92ebb-26c3-5207-a1d2-73a8a96acda1', 8, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02e92ebb-26c3-5207-a1d2-73a8a96acda1', 9, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c454f670-c8d8-5b44-b74d-273a9cb72458', 'a8621760-ffb6-4283-8e2e-12bb7890d8a4', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Seb Tucker', '1771', 'individual', 11, 213.0, 138.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '736349d0-5959-5a37-8486-69ae326805dd', 'c454f670-c8d8-5b44-b74d-273a9cb72458', 'a8621760-ffb6-4283-8e2e-12bb7890d8a4', 'Seb Tucker', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c454f670-c8d8-5b44-b74d-273a9cb72458', 1, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c454f670-c8d8-5b44-b74d-273a9cb72458', 2, 44.0, NULL, false, '44') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c454f670-c8d8-5b44-b74d-273a9cb72458', 3, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c454f670-c8d8-5b44-b74d-273a9cb72458', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c454f670-c8d8-5b44-b74d-273a9cb72458', 5, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c454f670-c8d8-5b44-b74d-273a9cb72458', 6, 75.0, 'BFD', true, '(75)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c454f670-c8d8-5b44-b74d-273a9cb72458', 7, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c454f670-c8d8-5b44-b74d-273a9cb72458', 8, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c454f670-c8d8-5b44-b74d-273a9cb72458', 9, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'dc3763ea-9329-59da-a7a4-851555f62bc5', '96f4f923-c23b-4098-983c-133c632e3d4d', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Charlie Thirkettle', '4763', 'individual', 12, 229.0, 154.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c897910a-91bd-5f84-b09e-f8be201ac164', 'dc3763ea-9329-59da-a7a4-851555f62bc5', '96f4f923-c23b-4098-983c-133c632e3d4d', 'Charlie Thirkettle', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc3763ea-9329-59da-a7a4-851555f62bc5', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc3763ea-9329-59da-a7a4-851555f62bc5', 2, 75.0, 'OCS', true, '(75)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc3763ea-9329-59da-a7a4-851555f62bc5', 3, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc3763ea-9329-59da-a7a4-851555f62bc5', 4, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc3763ea-9329-59da-a7a4-851555f62bc5', 5, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc3763ea-9329-59da-a7a4-851555f62bc5', 6, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc3763ea-9329-59da-a7a4-851555f62bc5', 7, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc3763ea-9329-59da-a7a4-851555f62bc5', 8, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc3763ea-9329-59da-a7a4-851555f62bc5', 9, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'debfe3df-7a17-5535-88e2-993faba57e17', '8ffb1e6b-203c-4bab-ac2f-18de1db064b7', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Heidi Sinclair-Hill', '1364', 'individual', 13, 194.0, 156.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd33ac252-f7c8-5fa4-9f11-cc22b4736752', 'debfe3df-7a17-5535-88e2-993faba57e17', '8ffb1e6b-203c-4bab-ac2f-18de1db064b7', 'Heidi Sinclair-Hill', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('debfe3df-7a17-5535-88e2-993faba57e17', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('debfe3df-7a17-5535-88e2-993faba57e17', 2, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('debfe3df-7a17-5535-88e2-993faba57e17', 3, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('debfe3df-7a17-5535-88e2-993faba57e17', 4, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('debfe3df-7a17-5535-88e2-993faba57e17', 5, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('debfe3df-7a17-5535-88e2-993faba57e17', 6, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('debfe3df-7a17-5535-88e2-993faba57e17', 7, 38.0, NULL, true, '(38)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('debfe3df-7a17-5535-88e2-993faba57e17', 8, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('debfe3df-7a17-5535-88e2-993faba57e17', 9, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '13c149c7-8ae5-5a9a-82bd-88cc25b27b6a', '0ea521ac-cf94-4f05-bd88-32e0d04c1579', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Fred Cantwell', '1860', 'individual', 14, 239.0, 164.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3f052f05-4a7c-5d4a-bc01-d667465803ef', '13c149c7-8ae5-5a9a-82bd-88cc25b27b6a', '0ea521ac-cf94-4f05-bd88-32e0d04c1579', 'Fred Cantwell', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('13c149c7-8ae5-5a9a-82bd-88cc25b27b6a', 1, 75.0, 'OCS', true, '(75)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('13c149c7-8ae5-5a9a-82bd-88cc25b27b6a', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('13c149c7-8ae5-5a9a-82bd-88cc25b27b6a', 3, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('13c149c7-8ae5-5a9a-82bd-88cc25b27b6a', 4, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('13c149c7-8ae5-5a9a-82bd-88cc25b27b6a', 5, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('13c149c7-8ae5-5a9a-82bd-88cc25b27b6a', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('13c149c7-8ae5-5a9a-82bd-88cc25b27b6a', 7, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('13c149c7-8ae5-5a9a-82bd-88cc25b27b6a', 8, 75.0, 'BFD', false, '75BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('13c149c7-8ae5-5a9a-82bd-88cc25b27b6a', 9, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c7643eb6-f3d2-525f-90de-d37a022452e0', '9ee1f9f1-aa37-4a62-8f85-67ab090c6d64', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Axel Ryves', '1633', 'individual', 15, 244.0, 169.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'aa35fb8a-3ca8-51dc-9585-6fd79dc65fb6', 'c7643eb6-f3d2-525f-90de-d37a022452e0', '9ee1f9f1-aa37-4a62-8f85-67ab090c6d64', 'Axel Ryves', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c7643eb6-f3d2-525f-90de-d37a022452e0', 1, 38.0, NULL, false, '38') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c7643eb6-f3d2-525f-90de-d37a022452e0', 2, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c7643eb6-f3d2-525f-90de-d37a022452e0', 3, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c7643eb6-f3d2-525f-90de-d37a022452e0', 4, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c7643eb6-f3d2-525f-90de-d37a022452e0', 5, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c7643eb6-f3d2-525f-90de-d37a022452e0', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c7643eb6-f3d2-525f-90de-d37a022452e0', 7, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c7643eb6-f3d2-525f-90de-d37a022452e0', 8, 75.0, 'BFD', true, '(75)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c7643eb6-f3d2-525f-90de-d37a022452e0', 9, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a2b4cc2a-03f6-5f6d-8218-67ff98d09dd0', 'fc8d7069-1d5c-5065-982f-5b7c0d711185', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Alex Mirceski', '1791', 'individual', 16, 244.0, 169.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a3f1c9aa-d93f-50fe-b75e-b1c87df4616a', 'a2b4cc2a-03f6-5f6d-8218-67ff98d09dd0', 'fc8d7069-1d5c-5065-982f-5b7c0d711185', 'Alex Mirceski', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2b4cc2a-03f6-5f6d-8218-67ff98d09dd0', 1, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2b4cc2a-03f6-5f6d-8218-67ff98d09dd0', 2, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2b4cc2a-03f6-5f6d-8218-67ff98d09dd0', 3, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2b4cc2a-03f6-5f6d-8218-67ff98d09dd0', 4, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2b4cc2a-03f6-5f6d-8218-67ff98d09dd0', 5, 40.0, NULL, false, '40') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2b4cc2a-03f6-5f6d-8218-67ff98d09dd0', 6, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2b4cc2a-03f6-5f6d-8218-67ff98d09dd0', 7, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2b4cc2a-03f6-5f6d-8218-67ff98d09dd0', 8, 75.0, 'BFD', true, '(75)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2b4cc2a-03f6-5f6d-8218-67ff98d09dd0', 9, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2c7c5ae9-bea7-544d-bdc9-172c36c6a223', '67957772-3fab-5f24-8fda-ea58259388aa', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Ace Hill', '1907', 'individual', 17, 230.0, 176.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a0f57ed1-602e-54c2-8454-65896c44d05c', '2c7c5ae9-bea7-544d-bdc9-172c36c6a223', '67957772-3fab-5f24-8fda-ea58259388aa', 'Ace Hill', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c7c5ae9-bea7-544d-bdc9-172c36c6a223', 1, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c7c5ae9-bea7-544d-bdc9-172c36c6a223', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c7c5ae9-bea7-544d-bdc9-172c36c6a223', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c7c5ae9-bea7-544d-bdc9-172c36c6a223', 4, 44.0, NULL, false, '44') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c7c5ae9-bea7-544d-bdc9-172c36c6a223', 5, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c7c5ae9-bea7-544d-bdc9-172c36c6a223', 6, 54.0, NULL, true, '(54)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c7c5ae9-bea7-544d-bdc9-172c36c6a223', 7, 36.0, NULL, false, '36') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c7c5ae9-bea7-544d-bdc9-172c36c6a223', 8, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c7c5ae9-bea7-544d-bdc9-172c36c6a223', 9, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ea094e58-7314-53c2-b75d-751bc4830f54', 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Joy Cheuk Yee Shen', '1877', 'individual', 18, 222.0, 176.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9a8f95dc-62fc-539f-b71a-3382f5694673', 'ea094e58-7314-53c2-b75d-751bc4830f54', 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f', 'Joy Cheuk Yee Shen', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea094e58-7314-53c2-b75d-751bc4830f54', 1, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea094e58-7314-53c2-b75d-751bc4830f54', 2, 46.0, NULL, true, '(46)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea094e58-7314-53c2-b75d-751bc4830f54', 3, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea094e58-7314-53c2-b75d-751bc4830f54', 4, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea094e58-7314-53c2-b75d-751bc4830f54', 5, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea094e58-7314-53c2-b75d-751bc4830f54', 6, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea094e58-7314-53c2-b75d-751bc4830f54', 7, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea094e58-7314-53c2-b75d-751bc4830f54', 8, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea094e58-7314-53c2-b75d-751bc4830f54', 9, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b2db3925-c185-56e3-9a93-345a10d1ab3a', '7411c058-0e0a-5a5d-aa05-fb3bd9edc4aa', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Mac Darlington', '41', 'individual', 19, 252.0, 177.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e4f58b40-401f-5d32-bc16-9acf51e4053b', 'b2db3925-c185-56e3-9a93-345a10d1ab3a', '7411c058-0e0a-5a5d-aa05-fb3bd9edc4aa', 'Mac Darlington', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b2db3925-c185-56e3-9a93-345a10d1ab3a', 1, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b2db3925-c185-56e3-9a93-345a10d1ab3a', 2, 75.0, 'OCS', true, '(75)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b2db3925-c185-56e3-9a93-345a10d1ab3a', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b2db3925-c185-56e3-9a93-345a10d1ab3a', 4, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b2db3925-c185-56e3-9a93-345a10d1ab3a', 5, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b2db3925-c185-56e3-9a93-345a10d1ab3a', 6, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b2db3925-c185-56e3-9a93-345a10d1ab3a', 7, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b2db3925-c185-56e3-9a93-345a10d1ab3a', 8, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b2db3925-c185-56e3-9a93-345a10d1ab3a', 9, 75.0, 'DNE', false, '75DNE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7a215495-7fca-5f75-b4ce-7da6cd6b3fc5', '95ee889d-670c-4145-aca5-5b1f26cbf2cc', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Stephen Wood', '4499', 'individual', 20, 220.0, 178.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '765aad46-a12e-5173-b95e-9905a4347845', '7a215495-7fca-5f75-b4ce-7da6cd6b3fc5', '95ee889d-670c-4145-aca5-5b1f26cbf2cc', 'Stephen Wood', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7a215495-7fca-5f75-b4ce-7da6cd6b3fc5', 1, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7a215495-7fca-5f75-b4ce-7da6cd6b3fc5', 2, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7a215495-7fca-5f75-b4ce-7da6cd6b3fc5', 3, 42.0, NULL, true, '(42)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7a215495-7fca-5f75-b4ce-7da6cd6b3fc5', 4, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7a215495-7fca-5f75-b4ce-7da6cd6b3fc5', 5, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7a215495-7fca-5f75-b4ce-7da6cd6b3fc5', 6, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7a215495-7fca-5f75-b4ce-7da6cd6b3fc5', 7, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7a215495-7fca-5f75-b4ce-7da6cd6b3fc5', 8, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7a215495-7fca-5f75-b4ce-7da6cd6b3fc5', 9, 37.0, NULL, false, '37') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a1d7dcff-01db-5fb9-bc9d-c1b418771938', '6e620e7e-5678-525f-8760-caaacf2266a9', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Emerald Jacobsen', '1846', 'individual', 21, 234.0, 192.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f4cb5cd0-26e4-5e1d-8ae8-9b9e75a70bd1', 'a1d7dcff-01db-5fb9-bc9d-c1b418771938', '6e620e7e-5678-525f-8760-caaacf2266a9', 'Emerald Jacobsen', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a1d7dcff-01db-5fb9-bc9d-c1b418771938', 1, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a1d7dcff-01db-5fb9-bc9d-c1b418771938', 2, 42.0, NULL, true, '(42)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a1d7dcff-01db-5fb9-bc9d-c1b418771938', 3, 38.0, NULL, false, '38') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a1d7dcff-01db-5fb9-bc9d-c1b418771938', 4, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a1d7dcff-01db-5fb9-bc9d-c1b418771938', 5, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a1d7dcff-01db-5fb9-bc9d-c1b418771938', 6, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a1d7dcff-01db-5fb9-bc9d-c1b418771938', 7, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a1d7dcff-01db-5fb9-bc9d-c1b418771938', 8, 36.0, NULL, false, '36') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a1d7dcff-01db-5fb9-bc9d-c1b418771938', 9, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3419a4b6-57ac-59ff-966b-89d1b8743a08', '0e4b7c7f-d18a-5551-b701-1ff02cf07f74', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Theodore Altson', '1801', 'individual', 22, 241.0, 197.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'beb76221-7aed-5e96-a589-b112d8d49326', '3419a4b6-57ac-59ff-966b-89d1b8743a08', '0e4b7c7f-d18a-5551-b701-1ff02cf07f74', 'Theodore Altson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3419a4b6-57ac-59ff-966b-89d1b8743a08', 1, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3419a4b6-57ac-59ff-966b-89d1b8743a08', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3419a4b6-57ac-59ff-966b-89d1b8743a08', 3, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3419a4b6-57ac-59ff-966b-89d1b8743a08', 4, 39.0, NULL, false, '39') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3419a4b6-57ac-59ff-966b-89d1b8743a08', 5, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3419a4b6-57ac-59ff-966b-89d1b8743a08', 6, 43.0, NULL, false, '43') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3419a4b6-57ac-59ff-966b-89d1b8743a08', 7, 44.0, NULL, true, '(44)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3419a4b6-57ac-59ff-966b-89d1b8743a08', 8, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3419a4b6-57ac-59ff-966b-89d1b8743a08', 9, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '5ad812d1-a9ad-5183-b5dd-0b005ccd3a34', 'a1bac017-5467-45ce-9ddc-53c13bcf2852', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Lyla Greenwood', '193', 'individual', 23, 275.0, 200.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '964f4e24-2c9c-509e-969a-4de5d80793e5', '5ad812d1-a9ad-5183-b5dd-0b005ccd3a34', 'a1bac017-5467-45ce-9ddc-53c13bcf2852', 'Lyla Greenwood', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5ad812d1-a9ad-5183-b5dd-0b005ccd3a34', 1, 50.0, NULL, false, '50') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5ad812d1-a9ad-5183-b5dd-0b005ccd3a34', 2, 75.0, 'OCS', true, '(75)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5ad812d1-a9ad-5183-b5dd-0b005ccd3a34', 3, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5ad812d1-a9ad-5183-b5dd-0b005ccd3a34', 4, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5ad812d1-a9ad-5183-b5dd-0b005ccd3a34', 5, 36.0, NULL, false, '36') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5ad812d1-a9ad-5183-b5dd-0b005ccd3a34', 6, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5ad812d1-a9ad-5183-b5dd-0b005ccd3a34', 7, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5ad812d1-a9ad-5183-b5dd-0b005ccd3a34', 8, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5ad812d1-a9ad-5183-b5dd-0b005ccd3a34', 9, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9568ae1b-f0c4-5372-8b49-97fe80030e52', 'fe55751a-320e-48f8-92fd-fd40bca74292', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Reid Martin', '1728', 'individual', 24, 284.0, 209.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4988c115-e53c-55cc-bec2-6ac67f046790', '9568ae1b-f0c4-5372-8b49-97fe80030e52', 'fe55751a-320e-48f8-92fd-fd40bca74292', 'Reid Martin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9568ae1b-f0c4-5372-8b49-97fe80030e52', 1, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9568ae1b-f0c4-5372-8b49-97fe80030e52', 2, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9568ae1b-f0c4-5372-8b49-97fe80030e52', 3, 75.0, 'BFD', true, '(75)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9568ae1b-f0c4-5372-8b49-97fe80030e52', 4, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9568ae1b-f0c4-5372-8b49-97fe80030e52', 5, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9568ae1b-f0c4-5372-8b49-97fe80030e52', 6, 75.0, 'BFD', false, '75BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9568ae1b-f0c4-5372-8b49-97fe80030e52', 7, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9568ae1b-f0c4-5372-8b49-97fe80030e52', 8, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9568ae1b-f0c4-5372-8b49-97fe80030e52', 9, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ed38ef80-0ee3-59f8-810f-fe2b8a904c6f', 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Alexander Walker', '1685', 'individual', 25, 285.0, 210.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd68a5a7c-f203-5658-8a66-d554a11e582a', 'ed38ef80-0ee3-59f8-810f-fe2b8a904c6f', 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6', 'Alexander Walker', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ed38ef80-0ee3-59f8-810f-fe2b8a904c6f', 1, 75.0, 'OCS', true, '(75)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ed38ef80-0ee3-59f8-810f-fe2b8a904c6f', 2, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ed38ef80-0ee3-59f8-810f-fe2b8a904c6f', 3, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ed38ef80-0ee3-59f8-810f-fe2b8a904c6f', 4, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ed38ef80-0ee3-59f8-810f-fe2b8a904c6f', 5, 52.0, NULL, false, '52') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ed38ef80-0ee3-59f8-810f-fe2b8a904c6f', 6, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ed38ef80-0ee3-59f8-810f-fe2b8a904c6f', 7, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ed38ef80-0ee3-59f8-810f-fe2b8a904c6f', 8, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ed38ef80-0ee3-59f8-810f-fe2b8a904c6f', 9, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '43a9937c-4349-50bf-86ac-ff9a3b9e921e', '1b22f933-9817-4f8b-a366-11315c5bc283', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Lucy Lin', '1938', 'individual', 26, 315.0, 240.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fd1b27ca-f49b-5bb2-b3d8-97c1dce84cdb', '43a9937c-4349-50bf-86ac-ff9a3b9e921e', '1b22f933-9817-4f8b-a366-11315c5bc283', 'Lucy Lin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('43a9937c-4349-50bf-86ac-ff9a3b9e921e', 1, 75.0, 'DNC', true, '(75)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('43a9937c-4349-50bf-86ac-ff9a3b9e921e', 2, 75.0, 'DNC', false, '75DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('43a9937c-4349-50bf-86ac-ff9a3b9e921e', 3, 75.0, 'DNC', false, '75DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('43a9937c-4349-50bf-86ac-ff9a3b9e921e', 4, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('43a9937c-4349-50bf-86ac-ff9a3b9e921e', 5, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('43a9937c-4349-50bf-86ac-ff9a3b9e921e', 6, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('43a9937c-4349-50bf-86ac-ff9a3b9e921e', 7, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('43a9937c-4349-50bf-86ac-ff9a3b9e921e', 8, 46.0, NULL, false, '46') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('43a9937c-4349-50bf-86ac-ff9a3b9e921e', 9, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c29afdaf-ee12-5a76-8ddc-e1a6988c996a', '045b2495-820a-5df1-b744-8439ea2e3d13', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Edward Payne', '1627', 'individual', 27, 317.0, 242.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '34258b88-204d-5df5-b702-418e4c6a7509', 'c29afdaf-ee12-5a76-8ddc-e1a6988c996a', '045b2495-820a-5df1-b744-8439ea2e3d13', 'Edward Payne', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c29afdaf-ee12-5a76-8ddc-e1a6988c996a', 1, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c29afdaf-ee12-5a76-8ddc-e1a6988c996a', 2, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c29afdaf-ee12-5a76-8ddc-e1a6988c996a', 3, 51.0, NULL, false, '51') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c29afdaf-ee12-5a76-8ddc-e1a6988c996a', 4, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c29afdaf-ee12-5a76-8ddc-e1a6988c996a', 5, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c29afdaf-ee12-5a76-8ddc-e1a6988c996a', 6, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c29afdaf-ee12-5a76-8ddc-e1a6988c996a', 7, 48.0, NULL, false, '48') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c29afdaf-ee12-5a76-8ddc-e1a6988c996a', 8, 75.0, 'BFD', true, '(75)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c29afdaf-ee12-5a76-8ddc-e1a6988c996a', 9, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f9dbe985-453b-5e24-9a7e-5b7346ad2269', '15b30f88-d7b3-45f1-b9c2-a59c9972101b', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Orlando Watts', '1943', 'individual', 28, 312.0, 254.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a9febb1f-d26a-53d1-af77-48568d4791d7', 'f9dbe985-453b-5e24-9a7e-5b7346ad2269', '15b30f88-d7b3-45f1-b9c2-a59c9972101b', 'Orlando Watts', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f9dbe985-453b-5e24-9a7e-5b7346ad2269', 1, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f9dbe985-453b-5e24-9a7e-5b7346ad2269', 2, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f9dbe985-453b-5e24-9a7e-5b7346ad2269', 3, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f9dbe985-453b-5e24-9a7e-5b7346ad2269', 4, 45.0, NULL, false, '45') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f9dbe985-453b-5e24-9a7e-5b7346ad2269', 5, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f9dbe985-453b-5e24-9a7e-5b7346ad2269', 6, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f9dbe985-453b-5e24-9a7e-5b7346ad2269', 7, 58.0, NULL, true, '(58)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f9dbe985-453b-5e24-9a7e-5b7346ad2269', 8, 39.0, NULL, false, '39') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f9dbe985-453b-5e24-9a7e-5b7346ad2269', 9, 39.0, NULL, false, '39') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '028a2bc2-699b-59f2-b22f-cccb86877abc', 'dc9037eb-9773-5609-b677-013904a333c6', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Ollie Walstab', '1850', 'individual', 29, 337.0, 262.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '339023d6-accc-5285-954e-aedf2ed73718', '028a2bc2-699b-59f2-b22f-cccb86877abc', 'dc9037eb-9773-5609-b677-013904a333c6', 'Ollie Walstab', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('028a2bc2-699b-59f2-b22f-cccb86877abc', 1, 75.0, 'OCS', true, '(75)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('028a2bc2-699b-59f2-b22f-cccb86877abc', 2, 75.0, 'DSQ', false, '75DSQ') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('028a2bc2-699b-59f2-b22f-cccb86877abc', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('028a2bc2-699b-59f2-b22f-cccb86877abc', 4, 41.0, NULL, false, '41') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('028a2bc2-699b-59f2-b22f-cccb86877abc', 5, 41.0, NULL, false, '41') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('028a2bc2-699b-59f2-b22f-cccb86877abc', 6, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('028a2bc2-699b-59f2-b22f-cccb86877abc', 7, 42.0, NULL, false, '42') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('028a2bc2-699b-59f2-b22f-cccb86877abc', 8, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('028a2bc2-699b-59f2-b22f-cccb86877abc', 9, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2c90472a-d73b-5df9-b726-48f671f6e9f1', '51a80a27-8665-4db2-afb4-0940cbc20376', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Milton Li', '1559', 'individual', 30, 339.0, 264.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e59f0ed2-ed97-5e7e-91d2-893e7a5a3164', '2c90472a-d73b-5df9-b726-48f671f6e9f1', '51a80a27-8665-4db2-afb4-0940cbc20376', 'Milton Li', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c90472a-d73b-5df9-b726-48f671f6e9f1', 1, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c90472a-d73b-5df9-b726-48f671f6e9f1', 2, 75.0, 'OCS', true, '(75)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c90472a-d73b-5df9-b726-48f671f6e9f1', 3, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c90472a-d73b-5df9-b726-48f671f6e9f1', 4, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c90472a-d73b-5df9-b726-48f671f6e9f1', 5, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c90472a-d73b-5df9-b726-48f671f6e9f1', 6, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c90472a-d73b-5df9-b726-48f671f6e9f1', 7, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c90472a-d73b-5df9-b726-48f671f6e9f1', 8, 44.0, NULL, false, '44') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c90472a-d73b-5df9-b726-48f671f6e9f1', 9, 68.0, NULL, false, '68') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '08c20b29-7afe-5bc7-a1ec-3b6c4b2f8d87', 'e912046c-3e11-5658-a475-acc04b70cb9a', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Jack Sturm', '1773', 'individual', 31, 343.0, 268.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '87e033cd-5664-5ebc-b4bf-8bab8aa47bef', '08c20b29-7afe-5bc7-a1ec-3b6c4b2f8d87', 'e912046c-3e11-5658-a475-acc04b70cb9a', 'Jack Sturm', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('08c20b29-7afe-5bc7-a1ec-3b6c4b2f8d87', 1, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('08c20b29-7afe-5bc7-a1ec-3b6c4b2f8d87', 2, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('08c20b29-7afe-5bc7-a1ec-3b6c4b2f8d87', 3, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('08c20b29-7afe-5bc7-a1ec-3b6c4b2f8d87', 4, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('08c20b29-7afe-5bc7-a1ec-3b6c4b2f8d87', 5, 54.0, NULL, false, '54') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('08c20b29-7afe-5bc7-a1ec-3b6c4b2f8d87', 6, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('08c20b29-7afe-5bc7-a1ec-3b6c4b2f8d87', 7, 37.0, NULL, false, '37') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('08c20b29-7afe-5bc7-a1ec-3b6c4b2f8d87', 8, 75.0, 'BFD', true, '(75)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('08c20b29-7afe-5bc7-a1ec-3b6c4b2f8d87', 9, 75.0, 'BFD', false, '75BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7c47ac07-137f-51f0-937f-c279f8da8eab', 'f26ce470-48a0-419e-967e-b1e936dad712', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Lavinia Liu', '1866', 'individual', 32, 324.0, 271.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b4c7a37e-25bb-51cc-a2d0-061aa6ffa190', '7c47ac07-137f-51f0-937f-c279f8da8eab', 'f26ce470-48a0-419e-967e-b1e936dad712', 'Lavinia Liu', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c47ac07-137f-51f0-937f-c279f8da8eab', 1, 39.0, NULL, false, '39') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c47ac07-137f-51f0-937f-c279f8da8eab', 2, 49.0, NULL, false, '49') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c47ac07-137f-51f0-937f-c279f8da8eab', 3, 53.0, NULL, true, '(53)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c47ac07-137f-51f0-937f-c279f8da8eab', 4, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c47ac07-137f-51f0-937f-c279f8da8eab', 5, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c47ac07-137f-51f0-937f-c279f8da8eab', 6, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c47ac07-137f-51f0-937f-c279f8da8eab', 7, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c47ac07-137f-51f0-937f-c279f8da8eab', 8, 49.0, NULL, false, '49') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c47ac07-137f-51f0-937f-c279f8da8eab', 9, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a3492d06-c842-5a8b-a1d7-c3718a41a039', '298175a4-db74-4a70-a55c-fdd65f4d3004', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Hamilton Zhao', '1878', 'individual', 33, 341.0, 274.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e38c8d04-7a3d-5a1c-a840-800c0b4cf32a', 'a3492d06-c842-5a8b-a1d7-c3718a41a039', '298175a4-db74-4a70-a55c-fdd65f4d3004', 'Hamilton Zhao', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a3492d06-c842-5a8b-a1d7-c3718a41a039', 1, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a3492d06-c842-5a8b-a1d7-c3718a41a039', 2, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a3492d06-c842-5a8b-a1d7-c3718a41a039', 3, 54.0, NULL, false, '54') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a3492d06-c842-5a8b-a1d7-c3718a41a039', 4, 36.0, NULL, false, '36') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a3492d06-c842-5a8b-a1d7-c3718a41a039', 5, 42.0, NULL, false, '42') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a3492d06-c842-5a8b-a1d7-c3718a41a039', 6, 60.0, NULL, false, '60') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a3492d06-c842-5a8b-a1d7-c3718a41a039', 7, 67.0, NULL, true, '(67)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a3492d06-c842-5a8b-a1d7-c3718a41a039', 8, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a3492d06-c842-5a8b-a1d7-c3718a41a039', 9, 42.0, NULL, false, '42') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8856c0a3-ce58-5693-a039-0c0c3b1bd68e', '6bb70367-ef7b-4f22-899a-eda3a0da5fe5', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Jasmine Fry', '4568', 'individual', 34, 349.0, 274.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e5a85126-4cd5-5016-a716-8a7b608d780c', '8856c0a3-ce58-5693-a039-0c0c3b1bd68e', '6bb70367-ef7b-4f22-899a-eda3a0da5fe5', 'Jasmine Fry', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8856c0a3-ce58-5693-a039-0c0c3b1bd68e', 1, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8856c0a3-ce58-5693-a039-0c0c3b1bd68e', 2, 75.0, 'OCS', true, '(75)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8856c0a3-ce58-5693-a039-0c0c3b1bd68e', 3, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8856c0a3-ce58-5693-a039-0c0c3b1bd68e', 4, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8856c0a3-ce58-5693-a039-0c0c3b1bd68e', 5, 45.0, NULL, false, '45') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8856c0a3-ce58-5693-a039-0c0c3b1bd68e', 6, 39.0, NULL, false, '39') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8856c0a3-ce58-5693-a039-0c0c3b1bd68e', 7, 41.0, NULL, false, '41') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8856c0a3-ce58-5693-a039-0c0c3b1bd68e', 8, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8856c0a3-ce58-5693-a039-0c0c3b1bd68e', 9, 47.0, NULL, false, '47') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3b34a656-d97b-5953-a9ff-393a20f5c489', 'dd942136-24c9-4575-a06d-81ac407486f1', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Henry Hall', '4820', 'individual', 35, 357.0, 282.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b7f74803-a88c-583f-ba0d-93a39e3d33f2', '3b34a656-d97b-5953-a9ff-393a20f5c489', 'dd942136-24c9-4575-a06d-81ac407486f1', 'Henry Hall', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b34a656-d97b-5953-a9ff-393a20f5c489', 1, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b34a656-d97b-5953-a9ff-393a20f5c489', 2, 57.0, NULL, false, '57') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b34a656-d97b-5953-a9ff-393a20f5c489', 3, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b34a656-d97b-5953-a9ff-393a20f5c489', 4, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b34a656-d97b-5953-a9ff-393a20f5c489', 5, 38.0, NULL, false, '38') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b34a656-d97b-5953-a9ff-393a20f5c489', 6, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b34a656-d97b-5953-a9ff-393a20f5c489', 7, 53.0, NULL, false, '53') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b34a656-d97b-5953-a9ff-393a20f5c489', 8, 75.0, 'BFD', true, '(75)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b34a656-d97b-5953-a9ff-393a20f5c489', 9, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '697f6105-39d4-538a-8603-6bee753735ae', '35f3c2cb-2ced-494d-aa27-c5f0cf3193dd', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Erik Rydin', '506', 'individual', 36, 363.0, 288.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '323a61c8-c8a8-558e-a24b-a871142e1ec5', '697f6105-39d4-538a-8603-6bee753735ae', '35f3c2cb-2ced-494d-aa27-c5f0cf3193dd', 'Erik Rydin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('697f6105-39d4-538a-8603-6bee753735ae', 1, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('697f6105-39d4-538a-8603-6bee753735ae', 2, 40.0, NULL, false, '40') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('697f6105-39d4-538a-8603-6bee753735ae', 3, 58.0, NULL, false, '58') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('697f6105-39d4-538a-8603-6bee753735ae', 4, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('697f6105-39d4-538a-8603-6bee753735ae', 5, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('697f6105-39d4-538a-8603-6bee753735ae', 6, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('697f6105-39d4-538a-8603-6bee753735ae', 7, 51.0, NULL, false, '51') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('697f6105-39d4-538a-8603-6bee753735ae', 8, 75.0, 'BFD', true, '(75)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('697f6105-39d4-538a-8603-6bee753735ae', 9, 58.0, NULL, false, '58') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9ada8ab7-ed3e-5820-ba24-33c937091be5', '159283fb-9913-4586-b9e7-d4d014439080', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'George Hayton', '4755', 'individual', 37, 344.0, 289.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '493ce100-552e-579f-a7b9-fb041b8f62f1', '9ada8ab7-ed3e-5820-ba24-33c937091be5', '159283fb-9913-4586-b9e7-d4d014439080', 'George Hayton', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9ada8ab7-ed3e-5820-ba24-33c937091be5', 1, 36.0, NULL, false, '36') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9ada8ab7-ed3e-5820-ba24-33c937091be5', 2, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9ada8ab7-ed3e-5820-ba24-33c937091be5', 3, 37.0, NULL, false, '37') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9ada8ab7-ed3e-5820-ba24-33c937091be5', 4, 50.0, NULL, false, '50') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9ada8ab7-ed3e-5820-ba24-33c937091be5', 5, 55.0, NULL, true, '(55)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9ada8ab7-ed3e-5820-ba24-33c937091be5', 6, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9ada8ab7-ed3e-5820-ba24-33c937091be5', 7, 46.0, NULL, false, '46') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9ada8ab7-ed3e-5820-ba24-33c937091be5', 8, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9ada8ab7-ed3e-5820-ba24-33c937091be5', 9, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'abd047d2-c68c-5b56-bfcc-65c2d979fd4b', 'cc7c3804-c292-5e08-808b-bcebb191b42a', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Oliver Sun', '1606', 'individual', 38, 356.0, 290.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '865ec8b1-f62e-528f-85cb-c62428fc5b30', 'abd047d2-c68c-5b56-bfcc-65c2d979fd4b', 'cc7c3804-c292-5e08-808b-bcebb191b42a', 'Oliver Sun', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('abd047d2-c68c-5b56-bfcc-65c2d979fd4b', 1, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('abd047d2-c68c-5b56-bfcc-65c2d979fd4b', 2, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('abd047d2-c68c-5b56-bfcc-65c2d979fd4b', 3, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('abd047d2-c68c-5b56-bfcc-65c2d979fd4b', 4, 66.0, NULL, true, '(66)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('abd047d2-c68c-5b56-bfcc-65c2d979fd4b', 5, 64.0, NULL, false, '64') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('abd047d2-c68c-5b56-bfcc-65c2d979fd4b', 6, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('abd047d2-c68c-5b56-bfcc-65c2d979fd4b', 7, 65.0, NULL, false, '65') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('abd047d2-c68c-5b56-bfcc-65c2d979fd4b', 8, 37.0, NULL, false, '37') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('abd047d2-c68c-5b56-bfcc-65c2d979fd4b', 9, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f40803c4-d8e7-5693-9a65-0cfe729de344', 'f26e7a93-7b3f-5b8a-81ab-c5d767424cb8', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Brayden Huang', '679', 'individual', 39, 375.0, 300.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0e5b49cb-1f46-53ec-8fba-4e44ed30d1f1', 'f40803c4-d8e7-5693-9a65-0cfe729de344', 'f26e7a93-7b3f-5b8a-81ab-c5d767424cb8', 'Brayden Huang', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f40803c4-d8e7-5693-9a65-0cfe729de344', 1, 75.0, 'OCS', true, '(75)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f40803c4-d8e7-5693-9a65-0cfe729de344', 2, 75.0, 'OCS', false, '75OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f40803c4-d8e7-5693-9a65-0cfe729de344', 3, 60.0, NULL, false, '60') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f40803c4-d8e7-5693-9a65-0cfe729de344', 4, 37.0, NULL, false, '37') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f40803c4-d8e7-5693-9a65-0cfe729de344', 5, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f40803c4-d8e7-5693-9a65-0cfe729de344', 6, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f40803c4-d8e7-5693-9a65-0cfe729de344', 7, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f40803c4-d8e7-5693-9a65-0cfe729de344', 8, 41.0, NULL, false, '41') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f40803c4-d8e7-5693-9a65-0cfe729de344', 9, 40.0, NULL, false, '40') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '4d5fc45a-e492-533a-b059-d1e5be823d16', '173f9a62-5d72-4210-b057-47046ac28c95', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Michael Schierhout', '4765', 'individual', 40, 364.0, 307.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '94b303cb-7f63-5b0d-b608-ec70dd069db1', '4d5fc45a-e492-533a-b059-d1e5be823d16', '173f9a62-5d72-4210-b057-47046ac28c95', 'Michael Schierhout', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4d5fc45a-e492-533a-b059-d1e5be823d16', 1, 47.0, NULL, false, '47') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4d5fc45a-e492-533a-b059-d1e5be823d16', 2, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4d5fc45a-e492-533a-b059-d1e5be823d16', 3, 40.0, NULL, false, '40') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4d5fc45a-e492-533a-b059-d1e5be823d16', 4, 55.0, NULL, false, '55') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4d5fc45a-e492-533a-b059-d1e5be823d16', 5, 39.0, NULL, false, '39') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4d5fc45a-e492-533a-b059-d1e5be823d16', 6, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4d5fc45a-e492-533a-b059-d1e5be823d16', 7, 57.0, NULL, true, '(57)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4d5fc45a-e492-533a-b059-d1e5be823d16', 8, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4d5fc45a-e492-533a-b059-d1e5be823d16', 9, 48.0, NULL, false, '48') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c015ac55-f8e0-58e3-9ed8-61a2a7ae2aaf', '916de616-661a-45ec-849f-23a75f4e1321', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Dallas Noyer', '4714', 'individual', 41, 364.0, 308.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '69cd8d28-a72d-551f-97ed-34ec11d53606', 'c015ac55-f8e0-58e3-9ed8-61a2a7ae2aaf', '916de616-661a-45ec-849f-23a75f4e1321', 'Dallas Noyer', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c015ac55-f8e0-58e3-9ed8-61a2a7ae2aaf', 1, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c015ac55-f8e0-58e3-9ed8-61a2a7ae2aaf', 2, 39.0, NULL, false, '39') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c015ac55-f8e0-58e3-9ed8-61a2a7ae2aaf', 3, 48.0, NULL, false, '48') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c015ac55-f8e0-58e3-9ed8-61a2a7ae2aaf', 4, 38.0, NULL, false, '38') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c015ac55-f8e0-58e3-9ed8-61a2a7ae2aaf', 5, 56.0, NULL, true, '(56)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c015ac55-f8e0-58e3-9ed8-61a2a7ae2aaf', 6, 46.0, NULL, false, '46') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c015ac55-f8e0-58e3-9ed8-61a2a7ae2aaf', 7, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c015ac55-f8e0-58e3-9ed8-61a2a7ae2aaf', 8, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c015ac55-f8e0-58e3-9ed8-61a2a7ae2aaf', 9, 52.0, NULL, false, '52') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '99936d36-4934-5fdd-b6ac-278ccda31c86', '4ff5b3ea-abe2-47fd-87ed-f001ab207ab6', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Mia Fenwick', '4608', 'individual', 42, 384.0, 309.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c7edf66c-c71c-50e2-89ee-7fd7210d91cd', '99936d36-4934-5fdd-b6ac-278ccda31c86', '4ff5b3ea-abe2-47fd-87ed-f001ab207ab6', 'Mia Fenwick', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99936d36-4934-5fdd-b6ac-278ccda31c86', 1, 54.0, NULL, false, '54') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99936d36-4934-5fdd-b6ac-278ccda31c86', 2, 75.0, 'OCS', true, '(75)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99936d36-4934-5fdd-b6ac-278ccda31c86', 3, 56.0, NULL, false, '56') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99936d36-4934-5fdd-b6ac-278ccda31c86', 4, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99936d36-4934-5fdd-b6ac-278ccda31c86', 5, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99936d36-4934-5fdd-b6ac-278ccda31c86', 6, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99936d36-4934-5fdd-b6ac-278ccda31c86', 7, 50.0, NULL, false, '50') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99936d36-4934-5fdd-b6ac-278ccda31c86', 8, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99936d36-4934-5fdd-b6ac-278ccda31c86', 9, 61.0, NULL, false, '61') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '63cfbf8e-9a4b-567e-99ec-7f99ba084e77', '5beb9daf-9310-48ad-b865-8c00a7dca56c', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Summer Torbet', '4712', 'individual', 43, 386.0, 311.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '298b8119-7790-5ee9-947e-4ebbf0aad98b', '63cfbf8e-9a4b-567e-99ec-7f99ba084e77', '5beb9daf-9310-48ad-b865-8c00a7dca56c', 'Summer Torbet', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63cfbf8e-9a4b-567e-99ec-7f99ba084e77', 1, 51.0, NULL, false, '51') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63cfbf8e-9a4b-567e-99ec-7f99ba084e77', 2, 75.0, 'OCS', true, '(75)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63cfbf8e-9a4b-567e-99ec-7f99ba084e77', 3, 46.0, NULL, false, '46') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63cfbf8e-9a4b-567e-99ec-7f99ba084e77', 4, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63cfbf8e-9a4b-567e-99ec-7f99ba084e77', 5, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63cfbf8e-9a4b-567e-99ec-7f99ba084e77', 6, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63cfbf8e-9a4b-567e-99ec-7f99ba084e77', 7, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63cfbf8e-9a4b-567e-99ec-7f99ba084e77', 8, 48.0, NULL, false, '48') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('63cfbf8e-9a4b-567e-99ec-7f99ba084e77', 9, 70.0, NULL, false, '70') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '87f424a2-c4e6-5f14-bc53-db3cc5fe699c', 'e959c8e7-7d71-52bc-82d8-94e76a615407', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Felix Sawers', '1724', 'individual', 44, 373.0, 312.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4dbc482a-d6a4-53f1-9346-def5318a7a9b', '87f424a2-c4e6-5f14-bc53-db3cc5fe699c', 'e959c8e7-7d71-52bc-82d8-94e76a615407', 'Felix Sawers', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('87f424a2-c4e6-5f14-bc53-db3cc5fe699c', 1, 52.0, NULL, false, '52') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('87f424a2-c4e6-5f14-bc53-db3cc5fe699c', 2, 36.0, NULL, false, '36') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('87f424a2-c4e6-5f14-bc53-db3cc5fe699c', 3, 61.0, NULL, true, '(61)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('87f424a2-c4e6-5f14-bc53-db3cc5fe699c', 4, 59.0, NULL, false, '59') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('87f424a2-c4e6-5f14-bc53-db3cc5fe699c', 5, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('87f424a2-c4e6-5f14-bc53-db3cc5fe699c', 6, 41.0, NULL, false, '41') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('87f424a2-c4e6-5f14-bc53-db3cc5fe699c', 7, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('87f424a2-c4e6-5f14-bc53-db3cc5fe699c', 8, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('87f424a2-c4e6-5f14-bc53-db3cc5fe699c', 9, 51.0, NULL, false, '51') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b671d4e4-8fef-51b5-81c2-1079087043bb', '3895ee0b-423d-54b2-ab8b-ed51a60f50a6', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Aubrey Tan', '1111', 'individual', 45, 367.0, 312.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b0fbc2ed-35c4-565f-8905-f886d304198b', 'b671d4e4-8fef-51b5-81c2-1079087043bb', '3895ee0b-423d-54b2-ab8b-ed51a60f50a6', 'Aubrey Tan', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b671d4e4-8fef-51b5-81c2-1079087043bb', 1, 41.0, NULL, false, '41') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b671d4e4-8fef-51b5-81c2-1079087043bb', 2, 50.0, NULL, false, '50') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b671d4e4-8fef-51b5-81c2-1079087043bb', 3, 43.0, NULL, false, '43') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b671d4e4-8fef-51b5-81c2-1079087043bb', 4, 54.0, NULL, false, '54') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b671d4e4-8fef-51b5-81c2-1079087043bb', 5, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b671d4e4-8fef-51b5-81c2-1079087043bb', 6, 37.0, NULL, false, '37') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b671d4e4-8fef-51b5-81c2-1079087043bb', 7, 55.0, NULL, true, '(55)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b671d4e4-8fef-51b5-81c2-1079087043bb', 8, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b671d4e4-8fef-51b5-81c2-1079087043bb', 9, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2f49aec0-1279-5568-97a6-e0b4e468efa3', 'ecf95263-9065-4e1b-861a-b9a33a968ff2', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Ben Radich', '4709', 'individual', 46, 393.0, 318.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '050a9f62-9b69-5937-bfa4-fb69128351a7', '2f49aec0-1279-5568-97a6-e0b4e468efa3', 'ecf95263-9065-4e1b-861a-b9a33a968ff2', 'Ben Radich', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f49aec0-1279-5568-97a6-e0b4e468efa3', 1, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f49aec0-1279-5568-97a6-e0b4e468efa3', 2, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f49aec0-1279-5568-97a6-e0b4e468efa3', 3, 59.0, NULL, false, '59') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f49aec0-1279-5568-97a6-e0b4e468efa3', 4, 56.0, NULL, false, '56') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f49aec0-1279-5568-97a6-e0b4e468efa3', 5, 61.0, NULL, false, '61') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f49aec0-1279-5568-97a6-e0b4e468efa3', 6, 56.0, NULL, false, '56') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f49aec0-1279-5568-97a6-e0b4e468efa3', 7, 39.0, NULL, false, '39') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f49aec0-1279-5568-97a6-e0b4e468efa3', 8, 75.0, 'BFD', true, '(75)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f49aec0-1279-5568-97a6-e0b4e468efa3', 9, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'cfababa7-859d-588d-a7b7-21aeda8c0e40', '325b400d-1092-4711-b769-29b16989ea35', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Aurelia Wilson', '1941', 'individual', 47, 393.0, 318.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9fee0ef7-9db5-5b81-a294-1496bfd307e6', 'cfababa7-859d-588d-a7b7-21aeda8c0e40', '325b400d-1092-4711-b769-29b16989ea35', 'Aurelia Wilson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cfababa7-859d-588d-a7b7-21aeda8c0e40', 1, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cfababa7-859d-588d-a7b7-21aeda8c0e40', 2, 75.0, 'DNF', true, '(75)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cfababa7-859d-588d-a7b7-21aeda8c0e40', 3, 36.0, NULL, false, '36') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cfababa7-859d-588d-a7b7-21aeda8c0e40', 4, 46.0, NULL, false, '46') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cfababa7-859d-588d-a7b7-21aeda8c0e40', 5, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cfababa7-859d-588d-a7b7-21aeda8c0e40', 6, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cfababa7-859d-588d-a7b7-21aeda8c0e40', 7, 59.0, NULL, false, '59') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cfababa7-859d-588d-a7b7-21aeda8c0e40', 8, 75.0, 'BFD', false, '75BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cfababa7-859d-588d-a7b7-21aeda8c0e40', 9, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '983e919c-499c-53a6-8b79-6310bf2154fc', 'd6485671-0de9-5522-b3de-262e2cc27a13', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Courtney Harrison', '1735', 'individual', 48, 399.0, 324.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e8ea397d-d9a0-51d2-bad4-508952a49bb7', '983e919c-499c-53a6-8b79-6310bf2154fc', 'd6485671-0de9-5522-b3de-262e2cc27a13', 'Courtney Harrison', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('983e919c-499c-53a6-8b79-6310bf2154fc', 1, 42.0, NULL, false, '42') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('983e919c-499c-53a6-8b79-6310bf2154fc', 2, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('983e919c-499c-53a6-8b79-6310bf2154fc', 3, 66.0, NULL, false, '66') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('983e919c-499c-53a6-8b79-6310bf2154fc', 4, 51.0, NULL, false, '51') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('983e919c-499c-53a6-8b79-6310bf2154fc', 5, 43.0, NULL, false, '43') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('983e919c-499c-53a6-8b79-6310bf2154fc', 6, 42.0, NULL, false, '42') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('983e919c-499c-53a6-8b79-6310bf2154fc', 7, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('983e919c-499c-53a6-8b79-6310bf2154fc', 8, 75.0, 'BFD', true, '(75)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('983e919c-499c-53a6-8b79-6310bf2154fc', 9, 43.0, NULL, false, '43') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '62cf6b2b-6e82-5948-9f28-ca1a3ec3c15e', '70391ae7-d567-55b9-b91c-3f80e65e3f84', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Max Hughes', '1734', 'individual', 49, 404.0, 329.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '18141f27-663e-51e5-aedc-819be1ba6968', '62cf6b2b-6e82-5948-9f28-ca1a3ec3c15e', '70391ae7-d567-55b9-b91c-3f80e65e3f84', 'Max Hughes', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('62cf6b2b-6e82-5948-9f28-ca1a3ec3c15e', 1, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('62cf6b2b-6e82-5948-9f28-ca1a3ec3c15e', 2, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('62cf6b2b-6e82-5948-9f28-ca1a3ec3c15e', 3, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('62cf6b2b-6e82-5948-9f28-ca1a3ec3c15e', 4, 67.0, NULL, false, '67') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('62cf6b2b-6e82-5948-9f28-ca1a3ec3c15e', 5, 67.0, NULL, false, '67') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('62cf6b2b-6e82-5948-9f28-ca1a3ec3c15e', 6, 38.0, NULL, false, '38') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('62cf6b2b-6e82-5948-9f28-ca1a3ec3c15e', 7, 54.0, NULL, false, '54') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('62cf6b2b-6e82-5948-9f28-ca1a3ec3c15e', 8, 75.0, 'BFD', true, '(75)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('62cf6b2b-6e82-5948-9f28-ca1a3ec3c15e', 9, 50.0, NULL, false, '50') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '4bd3efdf-8b9b-5e9f-a528-89c771fc2524', 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Zachariah Boyd', '1753', 'individual', 50, 406.0, 331.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bdcb31b3-0d8b-5827-9f8b-5ff6888d782b', '4bd3efdf-8b9b-5e9f-a528-89c771fc2524', 'f309cdc5-86b9-5851-ac8f-1e70f9f7ccee', 'Zachariah Boyd', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4bd3efdf-8b9b-5e9f-a528-89c771fc2524', 1, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4bd3efdf-8b9b-5e9f-a528-89c771fc2524', 2, 38.0, NULL, false, '38') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4bd3efdf-8b9b-5e9f-a528-89c771fc2524', 3, 39.0, NULL, false, '39') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4bd3efdf-8b9b-5e9f-a528-89c771fc2524', 4, 75.0, 'DNF', true, '(75)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4bd3efdf-8b9b-5e9f-a528-89c771fc2524', 5, 73.0, NULL, false, '73') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4bd3efdf-8b9b-5e9f-a528-89c771fc2524', 6, 40.0, NULL, false, '40') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4bd3efdf-8b9b-5e9f-a528-89c771fc2524', 7, 66.0, NULL, false, '66') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4bd3efdf-8b9b-5e9f-a528-89c771fc2524', 8, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4bd3efdf-8b9b-5e9f-a528-89c771fc2524', 9, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ee43d2d3-7390-5d15-a9ed-6990dcdc0fe5', 'ff95dfaa-563f-49ec-9d09-7cdd09128577', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Jungwon Park', '4710', 'individual', 51, 415.0, 340.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'cc5773a0-d300-5838-b911-caad1b905b01', 'ee43d2d3-7390-5d15-a9ed-6990dcdc0fe5', 'ff95dfaa-563f-49ec-9d09-7cdd09128577', 'Jungwon Park', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ee43d2d3-7390-5d15-a9ed-6990dcdc0fe5', 1, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ee43d2d3-7390-5d15-a9ed-6990dcdc0fe5', 2, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ee43d2d3-7390-5d15-a9ed-6990dcdc0fe5', 3, 55.0, NULL, false, '55') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ee43d2d3-7390-5d15-a9ed-6990dcdc0fe5', 4, 43.0, NULL, false, '43') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ee43d2d3-7390-5d15-a9ed-6990dcdc0fe5', 5, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ee43d2d3-7390-5d15-a9ed-6990dcdc0fe5', 6, 75.0, 'RET', true, '(75)RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ee43d2d3-7390-5d15-a9ed-6990dcdc0fe5', 7, 43.0, NULL, false, '43') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ee43d2d3-7390-5d15-a9ed-6990dcdc0fe5', 8, 75.0, 'BFD', false, '75BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ee43d2d3-7390-5d15-a9ed-6990dcdc0fe5', 9, 63.0, NULL, false, '63') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd1c8a2bf-9022-588e-839f-fc9a9a00719a', 'd4a93122-cac6-514d-a1c3-46a63c7aa978', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Irida Bladon', '1222', 'individual', 52, 411.0, 343.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '368e1a63-ed28-53ac-add8-de7142ff6386', 'd1c8a2bf-9022-588e-839f-fc9a9a00719a', 'd4a93122-cac6-514d-a1c3-46a63c7aa978', 'Irida Bladon', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1c8a2bf-9022-588e-839f-fc9a9a00719a', 1, 48.0, NULL, false, '48') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1c8a2bf-9022-588e-839f-fc9a9a00719a', 2, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1c8a2bf-9022-588e-839f-fc9a9a00719a', 3, 67.0, NULL, false, '67') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1c8a2bf-9022-588e-839f-fc9a9a00719a', 4, 68.0, NULL, true, '(68)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1c8a2bf-9022-588e-839f-fc9a9a00719a', 5, 53.0, NULL, false, '53') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1c8a2bf-9022-588e-839f-fc9a9a00719a', 6, 50.0, NULL, false, '50') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1c8a2bf-9022-588e-839f-fc9a9a00719a', 7, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1c8a2bf-9022-588e-839f-fc9a9a00719a', 8, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1c8a2bf-9022-588e-839f-fc9a9a00719a', 9, 49.0, NULL, false, '49') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7e7f373d-a673-5a97-9128-32d028bb8ff8', '53ca59e1-b29b-5fed-acfc-b65407a76960', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Bono Svacek', '1855', 'individual', 53, 423.0, 348.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bd0f7ae4-7fde-52af-992f-ff1b7ae49b7a', '7e7f373d-a673-5a97-9128-32d028bb8ff8', '53ca59e1-b29b-5fed-acfc-b65407a76960', 'Bono Svacek', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e7f373d-a673-5a97-9128-32d028bb8ff8', 1, 43.0, NULL, false, '43') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e7f373d-a673-5a97-9128-32d028bb8ff8', 2, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e7f373d-a673-5a97-9128-32d028bb8ff8', 3, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e7f373d-a673-5a97-9128-32d028bb8ff8', 4, 48.0, NULL, false, '48') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e7f373d-a673-5a97-9128-32d028bb8ff8', 5, 71.0, NULL, false, '71') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e7f373d-a673-5a97-9128-32d028bb8ff8', 6, 75.0, 'DNF', true, '(75)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e7f373d-a673-5a97-9128-32d028bb8ff8', 7, 69.0, NULL, false, '69') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e7f373d-a673-5a97-9128-32d028bb8ff8', 8, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e7f373d-a673-5a97-9128-32d028bb8ff8', 9, 44.0, NULL, false, '44') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '4940d7f5-8c7e-5ded-b545-09271eb7d63e', '83116b4f-ccd0-4734-bc45-cc91ed133b60', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Oscar Hermosillo', '4769', 'individual', 54, 426.0, 351.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f2435506-1a94-5256-9e4b-7ad0204fbfab', '4940d7f5-8c7e-5ded-b545-09271eb7d63e', '83116b4f-ccd0-4734-bc45-cc91ed133b60', 'Oscar Hermosillo', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4940d7f5-8c7e-5ded-b545-09271eb7d63e', 1, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4940d7f5-8c7e-5ded-b545-09271eb7d63e', 2, 75.0, 'OCS', true, '(75)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4940d7f5-8c7e-5ded-b545-09271eb7d63e', 3, 62.0, NULL, false, '62') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4940d7f5-8c7e-5ded-b545-09271eb7d63e', 4, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4940d7f5-8c7e-5ded-b545-09271eb7d63e', 5, 46.0, NULL, false, '46') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4940d7f5-8c7e-5ded-b545-09271eb7d63e', 6, 36.0, NULL, false, '36') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4940d7f5-8c7e-5ded-b545-09271eb7d63e', 7, 47.0, NULL, false, '47') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4940d7f5-8c7e-5ded-b545-09271eb7d63e', 8, 75.0, 'RET', false, '75RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4940d7f5-8c7e-5ded-b545-09271eb7d63e', 9, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a0a7f51e-9fd4-54e1-bd40-374d04a04ee1', 'e6492e45-8cc3-4830-a42a-79cbf3009fe5', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Tom Sanderson', '4559', 'individual', 55, 429.0, 354.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5444639d-1112-5828-8fa5-4a0f7ee1d769', 'a0a7f51e-9fd4-54e1-bd40-374d04a04ee1', 'e6492e45-8cc3-4830-a42a-79cbf3009fe5', 'Tom Sanderson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0a7f51e-9fd4-54e1-bd40-374d04a04ee1', 1, 75.0, 'OCS', true, '(75)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0a7f51e-9fd4-54e1-bd40-374d04a04ee1', 2, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0a7f51e-9fd4-54e1-bd40-374d04a04ee1', 3, 68.0, NULL, false, '68') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0a7f51e-9fd4-54e1-bd40-374d04a04ee1', 4, 49.0, NULL, false, '49') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0a7f51e-9fd4-54e1-bd40-374d04a04ee1', 5, 44.0, NULL, false, '44') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0a7f51e-9fd4-54e1-bd40-374d04a04ee1', 6, 45.0, NULL, false, '45') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0a7f51e-9fd4-54e1-bd40-374d04a04ee1', 7, 40.0, NULL, false, '40') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0a7f51e-9fd4-54e1-bd40-374d04a04ee1', 8, 52.0, NULL, false, '52') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0a7f51e-9fd4-54e1-bd40-374d04a04ee1', 9, 45.0, NULL, false, '45') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b1572c54-bc35-5f5e-bda2-e621f9933c86', '4c291012-2b60-5f2e-b850-b9e90f0c010c', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Owen OHara', '1248', 'individual', 56, 429.0, 354.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c0caf5c6-4d23-54e7-b27f-5d36be158a49', 'b1572c54-bc35-5f5e-bda2-e621f9933c86', '4c291012-2b60-5f2e-b850-b9e90f0c010c', 'Owen O''Hara', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b1572c54-bc35-5f5e-bda2-e621f9933c86', 1, 44.0, NULL, false, '44') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b1572c54-bc35-5f5e-bda2-e621f9933c86', 2, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b1572c54-bc35-5f5e-bda2-e621f9933c86', 3, 47.0, NULL, false, '47') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b1572c54-bc35-5f5e-bda2-e621f9933c86', 4, 62.0, NULL, false, '62') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b1572c54-bc35-5f5e-bda2-e621f9933c86', 5, 51.0, NULL, false, '51') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b1572c54-bc35-5f5e-bda2-e621f9933c86', 6, 75.0, 'DNF', true, '(75)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b1572c54-bc35-5f5e-bda2-e621f9933c86', 7, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b1572c54-bc35-5f5e-bda2-e621f9933c86', 8, 42.0, NULL, false, '42') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b1572c54-bc35-5f5e-bda2-e621f9933c86', 9, 53.0, NULL, false, '53') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'bb059c92-3fcf-5426-a981-4bacc055e654', 'c720156e-a4fc-5c44-8505-4ad78bb60d73', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Willow Murray', '1863', 'individual', 57, 447.0, 372.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1b0d7c2e-154e-569b-8c62-907dbe4a53b7', 'bb059c92-3fcf-5426-a981-4bacc055e654', 'c720156e-a4fc-5c44-8505-4ad78bb60d73', 'Willow Murray', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb059c92-3fcf-5426-a981-4bacc055e654', 1, 75.0, 'DNC', true, '(75)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb059c92-3fcf-5426-a981-4bacc055e654', 2, 43.0, NULL, false, '43') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb059c92-3fcf-5426-a981-4bacc055e654', 3, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb059c92-3fcf-5426-a981-4bacc055e654', 4, 58.0, NULL, false, '58') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb059c92-3fcf-5426-a981-4bacc055e654', 5, 60.0, NULL, false, '60') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb059c92-3fcf-5426-a981-4bacc055e654', 6, 49.0, NULL, false, '49') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb059c92-3fcf-5426-a981-4bacc055e654', 7, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb059c92-3fcf-5426-a981-4bacc055e654', 8, 75.0, 'DNF', false, '75DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bb059c92-3fcf-5426-a981-4bacc055e654', 9, 38.0, NULL, false, '38') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'bcd90894-5286-5edc-897a-18a45ef54954', '9a41bcbd-ac5d-56f9-9c76-709aa5f78d69', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Grace Newitt', '1844', 'individual', 58, 442.0, 374.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3efe879c-eef1-551a-b28f-9722c63fceb2', 'bcd90894-5286-5edc-897a-18a45ef54954', '9a41bcbd-ac5d-56f9-9c76-709aa5f78d69', 'Grace Newitt', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bcd90894-5286-5edc-897a-18a45ef54954', 1, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bcd90894-5286-5edc-897a-18a45ef54954', 2, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bcd90894-5286-5edc-897a-18a45ef54954', 3, 65.0, NULL, false, '65') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bcd90894-5286-5edc-897a-18a45ef54954', 4, 52.0, NULL, false, '52') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bcd90894-5286-5edc-897a-18a45ef54954', 5, 68.0, NULL, true, '(68)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bcd90894-5286-5edc-897a-18a45ef54954', 6, 52.0, NULL, false, '52') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bcd90894-5286-5edc-897a-18a45ef54954', 7, 56.0, NULL, false, '56') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bcd90894-5286-5edc-897a-18a45ef54954', 8, 40.0, NULL, false, '40') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bcd90894-5286-5edc-897a-18a45ef54954', 9, 57.0, NULL, false, '57') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '747b75d5-a108-56c5-b1da-9d3f4ac7ddd3', '365765e9-9ea4-5de4-8228-00156c596e49', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Oliver Korn', '1811', 'individual', 59, 436.0, 375.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5f52af43-6fd3-5bb6-9b20-bd8b5a9c44e4', '747b75d5-a108-56c5-b1da-9d3f4ac7ddd3', '365765e9-9ea4-5de4-8228-00156c596e49', 'Oliver Korn', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('747b75d5-a108-56c5-b1da-9d3f4ac7ddd3', 1, 61.0, NULL, true, '(61)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('747b75d5-a108-56c5-b1da-9d3f4ac7ddd3', 2, 52.0, NULL, false, '52') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('747b75d5-a108-56c5-b1da-9d3f4ac7ddd3', 3, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('747b75d5-a108-56c5-b1da-9d3f4ac7ddd3', 4, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('747b75d5-a108-56c5-b1da-9d3f4ac7ddd3', 5, 47.0, NULL, false, '47') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('747b75d5-a108-56c5-b1da-9d3f4ac7ddd3', 6, 57.0, NULL, false, '57') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('747b75d5-a108-56c5-b1da-9d3f4ac7ddd3', 7, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('747b75d5-a108-56c5-b1da-9d3f4ac7ddd3', 8, 75.0, 'DNE', false, '75DNE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('747b75d5-a108-56c5-b1da-9d3f4ac7ddd3', 9, 55.0, NULL, false, '55') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '4c700137-31f6-555d-85c9-23bae56961e2', '54b6d292-7c1e-4da4-990b-802e674c06e5', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'James Edwards', '1568', 'individual', 60, 467.0, 392.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd55e8406-7de8-5a7e-9f33-ec7b844af4fb', '4c700137-31f6-555d-85c9-23bae56961e2', '54b6d292-7c1e-4da4-990b-802e674c06e5', 'James Edwards', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4c700137-31f6-555d-85c9-23bae56961e2', 1, 75.0, 'OCS', true, '(75)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4c700137-31f6-555d-85c9-23bae56961e2', 2, 75.0, 'OCS', false, '75OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4c700137-31f6-555d-85c9-23bae56961e2', 3, 49.0, NULL, false, '49') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4c700137-31f6-555d-85c9-23bae56961e2', 4, 72.0, NULL, false, '72') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4c700137-31f6-555d-85c9-23bae56961e2', 5, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4c700137-31f6-555d-85c9-23bae56961e2', 6, 44.0, NULL, false, '44') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4c700137-31f6-555d-85c9-23bae56961e2', 7, 61.0, NULL, false, '61') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4c700137-31f6-555d-85c9-23bae56961e2', 8, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4c700137-31f6-555d-85c9-23bae56961e2', 9, 36.0, NULL, false, '36') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '755ab1b4-d301-53a1-a9d4-4f2d53ffef5a', 'c23f1b7e-2073-524e-8a20-89af3fd18bf9', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Tilly Gibson', '1665', 'individual', 61, 471.0, 399.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4e9e69dd-bc17-5595-a82c-a7d2f8627c5c', '755ab1b4-d301-53a1-a9d4-4f2d53ffef5a', 'c23f1b7e-2073-524e-8a20-89af3fd18bf9', 'Tilly Gibson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('755ab1b4-d301-53a1-a9d4-4f2d53ffef5a', 1, 46.0, NULL, false, '46') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('755ab1b4-d301-53a1-a9d4-4f2d53ffef5a', 2, 48.0, NULL, false, '48') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('755ab1b4-d301-53a1-a9d4-4f2d53ffef5a', 3, 44.0, NULL, false, '44') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('755ab1b4-d301-53a1-a9d4-4f2d53ffef5a', 4, 64.0, NULL, false, '64') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('755ab1b4-d301-53a1-a9d4-4f2d53ffef5a', 5, 50.0, NULL, false, '50') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('755ab1b4-d301-53a1-a9d4-4f2d53ffef5a', 6, 51.0, NULL, false, '51') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('755ab1b4-d301-53a1-a9d4-4f2d53ffef5a', 7, 72.0, NULL, true, '(72)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('755ab1b4-d301-53a1-a9d4-4f2d53ffef5a', 8, 50.0, NULL, false, '50') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('755ab1b4-d301-53a1-a9d4-4f2d53ffef5a', 9, 46.0, NULL, false, '46') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9a5be2bb-a9f1-5e60-8aba-a908d2d000fa', '2e005437-68a4-51ab-bc8b-d377f51d55eb', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Balthazar Roche', '1931', 'individual', 62, 476.0, 401.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6b30bb6d-fd35-5c02-9964-99e5d6908b9c', '9a5be2bb-a9f1-5e60-8aba-a908d2d000fa', '2e005437-68a4-51ab-bc8b-d377f51d55eb', 'Balthazar Roche', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9a5be2bb-a9f1-5e60-8aba-a908d2d000fa', 1, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9a5be2bb-a9f1-5e60-8aba-a908d2d000fa', 2, 58.0, NULL, false, '58') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9a5be2bb-a9f1-5e60-8aba-a908d2d000fa', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9a5be2bb-a9f1-5e60-8aba-a908d2d000fa', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9a5be2bb-a9f1-5e60-8aba-a908d2d000fa', 5, 75.0, 'RET', true, '(75)RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9a5be2bb-a9f1-5e60-8aba-a908d2d000fa', 6, 75.0, 'DNF', false, '75DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9a5be2bb-a9f1-5e60-8aba-a908d2d000fa', 7, 75.0, 'DNF', false, '75DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9a5be2bb-a9f1-5e60-8aba-a908d2d000fa', 8, 75.0, 'DNC', false, '75DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9a5be2bb-a9f1-5e60-8aba-a908d2d000fa', 9, 75.0, 'DNC', false, '75DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0365abf8-505f-553a-a01f-c9df5f372932', '093b8a3b-a512-48a1-b21a-8e692dc16730', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Forest Avery', '4432', 'individual', 63, 477.0, 407.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8a745e1c-a5df-593e-9f42-7856fb18e1b0', '0365abf8-505f-553a-a01f-c9df5f372932', '093b8a3b-a512-48a1-b21a-8e692dc16730', 'Forest Avery', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0365abf8-505f-553a-a01f-c9df5f372932', 1, 59.0, NULL, false, '59') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0365abf8-505f-553a-a01f-c9df5f372932', 2, 54.0, NULL, false, '54') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0365abf8-505f-553a-a01f-c9df5f372932', 3, 45.0, NULL, false, '45') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0365abf8-505f-553a-a01f-c9df5f372932', 4, 70.0, NULL, true, '(70)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0365abf8-505f-553a-a01f-c9df5f372932', 5, 69.0, NULL, false, '69') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0365abf8-505f-553a-a01f-c9df5f372932', 6, 48.0, NULL, false, '48') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0365abf8-505f-553a-a01f-c9df5f372932', 7, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0365abf8-505f-553a-a01f-c9df5f372932', 8, 51.0, NULL, false, '51') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0365abf8-505f-553a-a01f-c9df5f372932', 9, 54.0, NULL, false, '54') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '5a683f84-f3d4-532e-985a-a5416a40a48d', 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Bobby Furneaux Williams', '1926', 'individual', 64, 487.0, 412.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f8913f17-231a-564e-a45a-a3e65cd3d66e', '5a683f84-f3d4-532e-985a-a5416a40a48d', 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2', 'Bobby Furneaux Williams', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5a683f84-f3d4-532e-985a-a5416a40a48d', 1, 40.0, NULL, false, '40') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5a683f84-f3d4-532e-985a-a5416a40a48d', 2, 41.0, NULL, false, '41') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5a683f84-f3d4-532e-985a-a5416a40a48d', 3, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5a683f84-f3d4-532e-985a-a5416a40a48d', 4, 73.0, NULL, false, '73') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5a683f84-f3d4-532e-985a-a5416a40a48d', 5, 65.0, NULL, false, '65') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5a683f84-f3d4-532e-985a-a5416a40a48d', 6, 55.0, NULL, false, '55') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5a683f84-f3d4-532e-985a-a5416a40a48d', 7, 52.0, NULL, false, '52') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5a683f84-f3d4-532e-985a-a5416a40a48d', 8, 75.0, 'DNC', true, '(75)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5a683f84-f3d4-532e-985a-a5416a40a48d', 9, 75.0, 'DNC', false, '75DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c4eba821-f6fc-5f53-b89e-eb3b8ad04fa1', '2c632e1d-c35a-55b3-b30e-fdc04d8824b1', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Maximilian Hultin', '1802', 'individual', 65, 506.0, 434.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0d9bd3c9-76f2-55b2-8569-9a2457add351', 'c4eba821-f6fc-5f53-b89e-eb3b8ad04fa1', '2c632e1d-c35a-55b3-b30e-fdc04d8824b1', 'Maximilian Hultin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c4eba821-f6fc-5f53-b89e-eb3b8ad04fa1', 1, 45.0, NULL, false, '45') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c4eba821-f6fc-5f53-b89e-eb3b8ad04fa1', 2, 47.0, NULL, false, '47') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c4eba821-f6fc-5f53-b89e-eb3b8ad04fa1', 3, 69.0, NULL, false, '69') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c4eba821-f6fc-5f53-b89e-eb3b8ad04fa1', 4, 63.0, NULL, false, '63') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c4eba821-f6fc-5f53-b89e-eb3b8ad04fa1', 5, 72.0, NULL, true, '(72)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c4eba821-f6fc-5f53-b89e-eb3b8ad04fa1', 6, 59.0, NULL, false, '59') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c4eba821-f6fc-5f53-b89e-eb3b8ad04fa1', 7, 63.0, NULL, false, '63') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c4eba821-f6fc-5f53-b89e-eb3b8ad04fa1', 8, 47.0, NULL, false, '47') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c4eba821-f6fc-5f53-b89e-eb3b8ad04fa1', 9, 41.0, NULL, false, '41') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '99c2d1bc-f347-5c59-9602-7e40ffeefae1', '2552c01d-6467-5dbf-b858-c798384746a4', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'William Lawson', '1139', 'individual', 66, 499.0, 434.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3b22ef6f-52d0-5e60-b2ad-b9b7bcb7efc0', '99c2d1bc-f347-5c59-9602-7e40ffeefae1', '2552c01d-6467-5dbf-b858-c798384746a4', 'William Lawson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99c2d1bc-f347-5c59-9602-7e40ffeefae1', 1, 58.0, NULL, false, '58') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99c2d1bc-f347-5c59-9602-7e40ffeefae1', 2, 55.0, NULL, false, '55') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99c2d1bc-f347-5c59-9602-7e40ffeefae1', 3, 63.0, NULL, false, '63') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99c2d1bc-f347-5c59-9602-7e40ffeefae1', 4, 42.0, NULL, false, '42') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99c2d1bc-f347-5c59-9602-7e40ffeefae1', 5, 48.0, NULL, false, '48') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99c2d1bc-f347-5c59-9602-7e40ffeefae1', 6, 65.0, NULL, true, '(65)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99c2d1bc-f347-5c59-9602-7e40ffeefae1', 7, 64.0, NULL, false, '64') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99c2d1bc-f347-5c59-9602-7e40ffeefae1', 8, 45.0, NULL, false, '45') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('99c2d1bc-f347-5c59-9602-7e40ffeefae1', 9, 59.0, NULL, false, '59') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '16fc16cc-de9a-53c7-9b46-e15ccf425cae', '8ec76912-f222-4337-8bca-7cb5eab9fc39', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Amelie Fenwick', '4642', 'individual', 67, 510.0, 435.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '10746f9c-4188-59bf-ab3f-8906ad26e466', '16fc16cc-de9a-53c7-9b46-e15ccf425cae', '8ec76912-f222-4337-8bca-7cb5eab9fc39', 'Amelie Fenwick', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('16fc16cc-de9a-53c7-9b46-e15ccf425cae', 1, 75.0, 'OCS', true, '(75)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('16fc16cc-de9a-53c7-9b46-e15ccf425cae', 2, 75.0, 'OCS', false, '75OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('16fc16cc-de9a-53c7-9b46-e15ccf425cae', 3, 41.0, NULL, false, '41') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('16fc16cc-de9a-53c7-9b46-e15ccf425cae', 4, 53.0, NULL, false, '53') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('16fc16cc-de9a-53c7-9b46-e15ccf425cae', 5, 58.0, NULL, false, '58') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('16fc16cc-de9a-53c7-9b46-e15ccf425cae', 6, 75.0, 'DNF', false, '75DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('16fc16cc-de9a-53c7-9b46-e15ccf425cae', 7, 45.0, NULL, false, '45') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('16fc16cc-de9a-53c7-9b46-e15ccf425cae', 8, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('16fc16cc-de9a-53c7-9b46-e15ccf425cae', 9, 56.0, NULL, false, '56') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ca637738-42db-5857-a5a4-fe23f0d633ab', '71010fdd-6c88-5e28-b9aa-5a1648dbe7b5', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Anne Edwards', '1269', 'individual', 68, 510.0, 442.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '31eceddc-e34d-5530-83a9-dc1c69298edc', 'ca637738-42db-5857-a5a4-fe23f0d633ab', '71010fdd-6c88-5e28-b9aa-5a1648dbe7b5', 'Anne Edwards', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ca637738-42db-5857-a5a4-fe23f0d633ab', 1, 53.0, NULL, false, '53') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ca637738-42db-5857-a5a4-fe23f0d633ab', 2, 51.0, NULL, false, '51') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ca637738-42db-5857-a5a4-fe23f0d633ab', 3, 57.0, NULL, false, '57') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ca637738-42db-5857-a5a4-fe23f0d633ab', 4, 60.0, NULL, false, '60') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ca637738-42db-5857-a5a4-fe23f0d633ab', 5, 63.0, NULL, false, '63') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ca637738-42db-5857-a5a4-fe23f0d633ab', 6, 53.0, NULL, false, '53') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ca637738-42db-5857-a5a4-fe23f0d633ab', 7, 68.0, NULL, true, '(68)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ca637738-42db-5857-a5a4-fe23f0d633ab', 8, 38.0, NULL, false, '38') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ca637738-42db-5857-a5a4-fe23f0d633ab', 9, 67.0, NULL, false, '67') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '10ac5de8-35de-5808-ad17-fd3a2e8c8426', 'b7624b59-ebc3-5e83-b161-8e1d2e199caf', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Matilda Munt', '1367', 'individual', 69, 529.0, 454.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'aad7bce7-b60d-5295-b8b5-99b4246769a8', '10ac5de8-35de-5808-ad17-fd3a2e8c8426', 'b7624b59-ebc3-5e83-b161-8e1d2e199caf', 'Matilda Munt', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10ac5de8-35de-5808-ad17-fd3a2e8c8426', 1, 57.0, NULL, false, '57') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10ac5de8-35de-5808-ad17-fd3a2e8c8426', 2, 37.0, NULL, false, '37') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10ac5de8-35de-5808-ad17-fd3a2e8c8426', 3, 70.0, NULL, false, '70') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10ac5de8-35de-5808-ad17-fd3a2e8c8426', 4, 47.0, NULL, false, '47') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10ac5de8-35de-5808-ad17-fd3a2e8c8426', 5, 59.0, NULL, false, '59') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10ac5de8-35de-5808-ad17-fd3a2e8c8426', 6, 64.0, NULL, false, '64') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10ac5de8-35de-5808-ad17-fd3a2e8c8426', 7, 60.0, NULL, false, '60') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10ac5de8-35de-5808-ad17-fd3a2e8c8426', 8, 75.0, 'BFD', true, '(75)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10ac5de8-35de-5808-ad17-fd3a2e8c8426', 9, 60.0, NULL, false, '60') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '50267e62-3015-5598-91da-9dac3450cb4b', 'cf7c73d4-f50a-4283-8156-dac48dac903a', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'William Davis', '4774', 'individual', 70, 535.0, 460.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '27efe28c-1168-51bc-a877-3fd5a31c3d80', '50267e62-3015-5598-91da-9dac3450cb4b', 'cf7c73d4-f50a-4283-8156-dac48dac903a', 'William Davis', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('50267e62-3015-5598-91da-9dac3450cb4b', 1, 60.0, NULL, false, '60') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('50267e62-3015-5598-91da-9dac3450cb4b', 2, 45.0, NULL, false, '45') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('50267e62-3015-5598-91da-9dac3450cb4b', 3, 52.0, NULL, false, '52') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('50267e62-3015-5598-91da-9dac3450cb4b', 4, 57.0, NULL, false, '57') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('50267e62-3015-5598-91da-9dac3450cb4b', 5, 62.0, NULL, false, '62') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('50267e62-3015-5598-91da-9dac3450cb4b', 6, 58.0, NULL, false, '58') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('50267e62-3015-5598-91da-9dac3450cb4b', 7, 62.0, NULL, false, '62') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('50267e62-3015-5598-91da-9dac3450cb4b', 8, 75.0, 'BFD', true, '(75)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('50267e62-3015-5598-91da-9dac3450cb4b', 9, 64.0, NULL, false, '64') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd29cdf73-b089-5ebd-b46d-56697d56d80f', 'd6c6fbdd-a5f2-4ac3-95ab-7ee3a7334b1a', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Paz Avery', '4609', 'individual', 71, 545.0, 474.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6f08e1a3-8b16-5347-b397-95f0a009103d', 'd29cdf73-b089-5ebd-b46d-56697d56d80f', 'd6c6fbdd-a5f2-4ac3-95ab-7ee3a7334b1a', 'Paz Avery', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d29cdf73-b089-5ebd-b46d-56697d56d80f', 1, 55.0, NULL, false, '55') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d29cdf73-b089-5ebd-b46d-56697d56d80f', 2, 56.0, NULL, false, '56') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d29cdf73-b089-5ebd-b46d-56697d56d80f', 3, 50.0, NULL, false, '50') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d29cdf73-b089-5ebd-b46d-56697d56d80f', 4, 71.0, NULL, true, '(71)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d29cdf73-b089-5ebd-b46d-56697d56d80f', 5, 70.0, NULL, false, '70') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d29cdf73-b089-5ebd-b46d-56697d56d80f', 6, 61.0, NULL, false, '61') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d29cdf73-b089-5ebd-b46d-56697d56d80f', 7, 70.0, NULL, false, '70') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d29cdf73-b089-5ebd-b46d-56697d56d80f', 8, 43.0, NULL, false, '43') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d29cdf73-b089-5ebd-b46d-56697d56d80f', 9, 69.0, NULL, false, '69') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '70ec8d4a-6d43-5311-b75d-4a05595ad83f', '9b9378aa-37f6-470c-8944-5cf95bd13e04', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Casey Fitness', '4805', 'individual', 72, 556.0, 481.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8015c551-62c6-5940-8212-02a4b070bb22', '70ec8d4a-6d43-5311-b75d-4a05595ad83f', '9b9378aa-37f6-470c-8944-5cf95bd13e04', 'Casey Fitness', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70ec8d4a-6d43-5311-b75d-4a05595ad83f', 1, 56.0, NULL, false, '56') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70ec8d4a-6d43-5311-b75d-4a05595ad83f', 2, 53.0, NULL, false, '53') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70ec8d4a-6d43-5311-b75d-4a05595ad83f', 3, 72.0, NULL, false, '72') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70ec8d4a-6d43-5311-b75d-4a05595ad83f', 4, 65.0, NULL, false, '65') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70ec8d4a-6d43-5311-b75d-4a05595ad83f', 5, 57.0, NULL, false, '57') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70ec8d4a-6d43-5311-b75d-4a05595ad83f', 6, 63.0, NULL, false, '63') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70ec8d4a-6d43-5311-b75d-4a05595ad83f', 7, 49.0, NULL, false, '49') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70ec8d4a-6d43-5311-b75d-4a05595ad83f', 8, 75.0, 'BFD', true, '(75)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70ec8d4a-6d43-5311-b75d-4a05595ad83f', 9, 66.0, NULL, false, '66') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f76b71b8-3640-5f97-ad80-e948ee4ed8de', '23b717b1-7d59-5014-b1ae-3358bf3e8445', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Laura OHara', '1214', 'individual', 73, 565.0, 490.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2a535af7-c93c-5506-b6a3-c949147a37f4', 'f76b71b8-3640-5f97-ad80-e948ee4ed8de', '23b717b1-7d59-5014-b1ae-3358bf3e8445', 'Laura O''Hara', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f76b71b8-3640-5f97-ad80-e948ee4ed8de', 1, 75.0, 'OCS', true, '(75)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f76b71b8-3640-5f97-ad80-e948ee4ed8de', 2, 59.0, NULL, false, '59') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f76b71b8-3640-5f97-ad80-e948ee4ed8de', 3, 71.0, NULL, false, '71') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f76b71b8-3640-5f97-ad80-e948ee4ed8de', 4, 61.0, NULL, false, '61') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f76b71b8-3640-5f97-ad80-e948ee4ed8de', 5, 49.0, NULL, false, '49') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f76b71b8-3640-5f97-ad80-e948ee4ed8de', 6, 62.0, NULL, false, '62') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f76b71b8-3640-5f97-ad80-e948ee4ed8de', 7, 73.0, NULL, false, '73') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f76b71b8-3640-5f97-ad80-e948ee4ed8de', 8, 53.0, NULL, false, '53') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f76b71b8-3640-5f97-ad80-e948ee4ed8de', 9, 62.0, NULL, false, '62') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1773eea6-e0e6-5eec-8dc1-7d8882c37a2e', 'a68e8e7f-d347-5326-a405-7f795be50f87', '6c3e0183-81ef-5e3f-96c0-e41adac8dfeb', 'Lara Dorling', '1729', 'individual', 74, 581.0, 506.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.12', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ae5d3fde-3e40-58ce-9da3-3df859aabd61', '1773eea6-e0e6-5eec-8dc1-7d8882c37a2e', 'a68e8e7f-d347-5326-a405-7f795be50f87', 'Lara Dorling', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1773eea6-e0e6-5eec-8dc1-7d8882c37a2e', 1, 49.0, NULL, false, '49') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1773eea6-e0e6-5eec-8dc1-7d8882c37a2e', 2, 75.0, 'OCS', true, '(75)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1773eea6-e0e6-5eec-8dc1-7d8882c37a2e', 3, 64.0, NULL, false, '64') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1773eea6-e0e6-5eec-8dc1-7d8882c37a2e', 4, 69.0, NULL, false, '69') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1773eea6-e0e6-5eec-8dc1-7d8882c37a2e', 5, 66.0, NULL, false, '66') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1773eea6-e0e6-5eec-8dc1-7d8882c37a2e', 6, 47.0, NULL, false, '47') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1773eea6-e0e6-5eec-8dc1-7d8882c37a2e', 7, 71.0, NULL, false, '71') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1773eea6-e0e6-5eec-8dc1-7d8882c37a2e', 8, 75.0, 'BFD', false, '75BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1773eea6-e0e6-5eec-8dc1-7d8882c37a2e', 9, 65.0, NULL, false, '65') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail New South Wales — Optimist Intermediate (32 competitors)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0c2bb095-51d2-5413-a92f-95b1bed7123e', 'e69e8c1b-a4f5-5f59-903b-b857e6a5cc5c', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Sebastian Salter', '1938', 'individual', 1, 22.0, 16.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ce110cdb-cfdf-5921-ad5e-2b3ed3814d1d', '0c2bb095-51d2-5413-a92f-95b1bed7123e', 'e69e8c1b-a4f5-5f59-903b-b857e6a5cc5c', 'Sebastian Salter', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0c2bb095-51d2-5413-a92f-95b1bed7123e', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0c2bb095-51d2-5413-a92f-95b1bed7123e', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0c2bb095-51d2-5413-a92f-95b1bed7123e', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0c2bb095-51d2-5413-a92f-95b1bed7123e', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0c2bb095-51d2-5413-a92f-95b1bed7123e', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0c2bb095-51d2-5413-a92f-95b1bed7123e', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0c2bb095-51d2-5413-a92f-95b1bed7123e', 7, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0c2bb095-51d2-5413-a92f-95b1bed7123e', 8, 6.0, NULL, true, '(6)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '25b43489-8d78-5892-9134-78d9e8e869ad', '3457e10e-13f4-5fe3-9a1c-104fd86047d8', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Astrid Thirkettle', '4231', 'individual', 2, 29.0, 20.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '96cca6ba-a51d-5895-b177-c3c7c37b5c5f', '25b43489-8d78-5892-9134-78d9e8e869ad', '3457e10e-13f4-5fe3-9a1c-104fd86047d8', 'Astrid Thirkettle', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('25b43489-8d78-5892-9134-78d9e8e869ad', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('25b43489-8d78-5892-9134-78d9e8e869ad', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('25b43489-8d78-5892-9134-78d9e8e869ad', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('25b43489-8d78-5892-9134-78d9e8e869ad', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('25b43489-8d78-5892-9134-78d9e8e869ad', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('25b43489-8d78-5892-9134-78d9e8e869ad', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('25b43489-8d78-5892-9134-78d9e8e869ad', 7, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('25b43489-8d78-5892-9134-78d9e8e869ad', 8, 9.0, NULL, true, '(9)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2c5565b9-df22-524b-b179-c8e35c727ef8', 'b259b4fe-9ae6-521b-960b-34da1fe8a554', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Jasmine Wang', '1748', 'individual', 3, 63.0, 30.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd32b21a1-0a85-5f2f-81a9-f2b9801fda98', '2c5565b9-df22-524b-b179-c8e35c727ef8', 'b259b4fe-9ae6-521b-960b-34da1fe8a554', 'Jasmine Wang', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c5565b9-df22-524b-b179-c8e35c727ef8', 1, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c5565b9-df22-524b-b179-c8e35c727ef8', 2, 33.0, 'OCS', true, '(33)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c5565b9-df22-524b-b179-c8e35c727ef8', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c5565b9-df22-524b-b179-c8e35c727ef8', 4, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c5565b9-df22-524b-b179-c8e35c727ef8', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c5565b9-df22-524b-b179-c8e35c727ef8', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c5565b9-df22-524b-b179-c8e35c727ef8', 7, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c5565b9-df22-524b-b179-c8e35c727ef8', 8, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '70a64fc1-ca91-5af6-985a-d89214963c16', '98067f40-3792-57bb-9716-fc7bca16d664', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Molly O''Donnell', '1512', 'individual', 4, 55.0, 39.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '76cfe813-a569-5f4b-8839-35a6f66f58da', '70a64fc1-ca91-5af6-985a-d89214963c16', '98067f40-3792-57bb-9716-fc7bca16d664', 'Molly O''Donnell', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70a64fc1-ca91-5af6-985a-d89214963c16', 1, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70a64fc1-ca91-5af6-985a-d89214963c16', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70a64fc1-ca91-5af6-985a-d89214963c16', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70a64fc1-ca91-5af6-985a-d89214963c16', 4, 16.0, NULL, true, '(16)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70a64fc1-ca91-5af6-985a-d89214963c16', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70a64fc1-ca91-5af6-985a-d89214963c16', 6, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70a64fc1-ca91-5af6-985a-d89214963c16', 7, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('70a64fc1-ca91-5af6-985a-d89214963c16', 8, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '6ce0ed6e-8445-5bb4-aec4-9a7a9c44cf05', '79de686e-027d-5809-99e8-453bfd3cf285', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Miles White', '1882', 'individual', 5, 53.0, 41.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '93449946-0c44-5dbf-aeea-80e5484bd4fb', '6ce0ed6e-8445-5bb4-aec4-9a7a9c44cf05', '79de686e-027d-5809-99e8-453bfd3cf285', 'Miles White', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6ce0ed6e-8445-5bb4-aec4-9a7a9c44cf05', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6ce0ed6e-8445-5bb4-aec4-9a7a9c44cf05', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6ce0ed6e-8445-5bb4-aec4-9a7a9c44cf05', 3, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6ce0ed6e-8445-5bb4-aec4-9a7a9c44cf05', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6ce0ed6e-8445-5bb4-aec4-9a7a9c44cf05', 5, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6ce0ed6e-8445-5bb4-aec4-9a7a9c44cf05', 6, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6ce0ed6e-8445-5bb4-aec4-9a7a9c44cf05', 7, 12.0, NULL, true, '(12)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6ce0ed6e-8445-5bb4-aec4-9a7a9c44cf05', 8, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2e6556a7-e4f9-50d3-9d09-add99cb5d3b2', 'b617fb8a-78ab-58d0-bf6e-6150e954658b', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Alasdair Bonnitcha', '1426', 'individual', 6, 58.0, 46.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'da3572eb-cfad-5d4c-a5db-b71f793286f6', '2e6556a7-e4f9-50d3-9d09-add99cb5d3b2', 'b617fb8a-78ab-58d0-bf6e-6150e954658b', 'Alasdair Bonnitcha', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2e6556a7-e4f9-50d3-9d09-add99cb5d3b2', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2e6556a7-e4f9-50d3-9d09-add99cb5d3b2', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2e6556a7-e4f9-50d3-9d09-add99cb5d3b2', 3, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2e6556a7-e4f9-50d3-9d09-add99cb5d3b2', 4, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2e6556a7-e4f9-50d3-9d09-add99cb5d3b2', 5, 12.0, NULL, true, '(12)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2e6556a7-e4f9-50d3-9d09-add99cb5d3b2', 6, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2e6556a7-e4f9-50d3-9d09-add99cb5d3b2', 7, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2e6556a7-e4f9-50d3-9d09-add99cb5d3b2', 8, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2a2b4651-9abb-537b-9557-2ab91331fa8a', 'ffee66ca-ee78-504e-9fac-f2c556c77843', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Sam Harris', '1914', 'individual', 7, 80.0, 47.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fd11a812-ca15-5eda-8ea9-6501243d9ae3', '2a2b4651-9abb-537b-9557-2ab91331fa8a', 'ffee66ca-ee78-504e-9fac-f2c556c77843', 'Sam Harris', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2a2b4651-9abb-537b-9557-2ab91331fa8a', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2a2b4651-9abb-537b-9557-2ab91331fa8a', 2, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2a2b4651-9abb-537b-9557-2ab91331fa8a', 3, 33.0, 'BFD', true, '(33)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2a2b4651-9abb-537b-9557-2ab91331fa8a', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2a2b4651-9abb-537b-9557-2ab91331fa8a', 5, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2a2b4651-9abb-537b-9557-2ab91331fa8a', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2a2b4651-9abb-537b-9557-2ab91331fa8a', 7, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2a2b4651-9abb-537b-9557-2ab91331fa8a', 8, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '5502220e-e825-5126-866c-82c14e06f8bc', 'd8ff4e35-8040-5c54-8d3c-f943992b3ed5', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Francis Watts', '1766', 'individual', 8, 64.0, 51.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5a972e3d-efa1-5962-a3bb-e86237e7769e', '5502220e-e825-5126-866c-82c14e06f8bc', 'd8ff4e35-8040-5c54-8d3c-f943992b3ed5', 'Francis Watts', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5502220e-e825-5126-866c-82c14e06f8bc', 1, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5502220e-e825-5126-866c-82c14e06f8bc', 2, 13.0, NULL, true, '(13)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5502220e-e825-5126-866c-82c14e06f8bc', 3, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5502220e-e825-5126-866c-82c14e06f8bc', 4, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5502220e-e825-5126-866c-82c14e06f8bc', 5, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5502220e-e825-5126-866c-82c14e06f8bc', 6, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5502220e-e825-5126-866c-82c14e06f8bc', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5502220e-e825-5126-866c-82c14e06f8bc', 8, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '6881acba-2cda-556e-a6bb-f9c7426aaaed', 'ae10ce7d-d964-568b-98ee-3b1f370dc97a', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Jamie Korn', '1666', 'individual', 9, 107.0, 74.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd104568a-f6df-5daf-8e29-95b891b74dad', '6881acba-2cda-556e-a6bb-f9c7426aaaed', 'ae10ce7d-d964-568b-98ee-3b1f370dc97a', 'Jamie Korn', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6881acba-2cda-556e-a6bb-f9c7426aaaed', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6881acba-2cda-556e-a6bb-f9c7426aaaed', 2, 33.0, 'OCS', true, '(33)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6881acba-2cda-556e-a6bb-f9c7426aaaed', 3, 33.0, 'BFD', false, '33BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6881acba-2cda-556e-a6bb-f9c7426aaaed', 4, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6881acba-2cda-556e-a6bb-f9c7426aaaed', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6881acba-2cda-556e-a6bb-f9c7426aaaed', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6881acba-2cda-556e-a6bb-f9c7426aaaed', 7, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6881acba-2cda-556e-a6bb-f9c7426aaaed', 8, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f1c36529-1b2f-5dc8-a7d8-dd96d259a7bf', 'dd86222a-4380-55f0-b7c9-f727b6f32f65', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Maelyn Gilchrist', '1501', 'individual', 10, 117.0, 84.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b73918c9-d38f-52de-a833-b62fe4f02a29', 'f1c36529-1b2f-5dc8-a7d8-dd96d259a7bf', 'dd86222a-4380-55f0-b7c9-f727b6f32f65', 'Maelyn Gilchrist', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f1c36529-1b2f-5dc8-a7d8-dd96d259a7bf', 1, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f1c36529-1b2f-5dc8-a7d8-dd96d259a7bf', 2, 33.0, 'OCS', true, '(33)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f1c36529-1b2f-5dc8-a7d8-dd96d259a7bf', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f1c36529-1b2f-5dc8-a7d8-dd96d259a7bf', 4, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f1c36529-1b2f-5dc8-a7d8-dd96d259a7bf', 5, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f1c36529-1b2f-5dc8-a7d8-dd96d259a7bf', 6, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f1c36529-1b2f-5dc8-a7d8-dd96d259a7bf', 7, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f1c36529-1b2f-5dc8-a7d8-dd96d259a7bf', 8, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e610a299-bb7f-51d2-b9e4-f841e19fceb1', '9b4f7a85-aa7d-5d77-9cd7-afb06469bc69', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Sylvia Carlson', '1236', 'individual', 11, 105.0, 84.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8d679f29-5696-51de-ac6e-1d96a68dfb0c', 'e610a299-bb7f-51d2-b9e4-f841e19fceb1', '9b4f7a85-aa7d-5d77-9cd7-afb06469bc69', 'Sylvia Carlson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e610a299-bb7f-51d2-b9e4-f841e19fceb1', 1, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e610a299-bb7f-51d2-b9e4-f841e19fceb1', 2, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e610a299-bb7f-51d2-b9e4-f841e19fceb1', 3, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e610a299-bb7f-51d2-b9e4-f841e19fceb1', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e610a299-bb7f-51d2-b9e4-f841e19fceb1', 5, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e610a299-bb7f-51d2-b9e4-f841e19fceb1', 6, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e610a299-bb7f-51d2-b9e4-f841e19fceb1', 7, 21.0, NULL, true, '(21)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e610a299-bb7f-51d2-b9e4-f841e19fceb1', 8, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '37716b9b-f1d7-5657-819f-720eddbf7e49', 'ff8ca5b1-553b-528c-b602-0d79507b82a2', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'William Liu', '1404', 'individual', 12, 105.0, 88.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'dd946964-b787-59e6-8f2b-407c0f8d887f', '37716b9b-f1d7-5657-819f-720eddbf7e49', 'ff8ca5b1-553b-528c-b602-0d79507b82a2', 'William Liu', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('37716b9b-f1d7-5657-819f-720eddbf7e49', 1, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('37716b9b-f1d7-5657-819f-720eddbf7e49', 2, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('37716b9b-f1d7-5657-819f-720eddbf7e49', 3, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('37716b9b-f1d7-5657-819f-720eddbf7e49', 4, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('37716b9b-f1d7-5657-819f-720eddbf7e49', 5, 17.0, NULL, true, '(17)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('37716b9b-f1d7-5657-819f-720eddbf7e49', 6, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('37716b9b-f1d7-5657-819f-720eddbf7e49', 7, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('37716b9b-f1d7-5657-819f-720eddbf7e49', 8, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8393819d-d770-54f9-96ed-41d8cc51fd1a', '15b5c0ed-ac08-584c-874e-b7d9271dd53a', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Sienna Murray', '1507', 'individual', 13, 122.0, 89.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9d5c902d-6f86-5086-b5d4-ccab73c036f4', '8393819d-d770-54f9-96ed-41d8cc51fd1a', '15b5c0ed-ac08-584c-874e-b7d9271dd53a', 'Sienna Murray', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8393819d-d770-54f9-96ed-41d8cc51fd1a', 1, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8393819d-d770-54f9-96ed-41d8cc51fd1a', 2, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8393819d-d770-54f9-96ed-41d8cc51fd1a', 3, 33.0, 'BFD', true, '(33)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8393819d-d770-54f9-96ed-41d8cc51fd1a', 4, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8393819d-d770-54f9-96ed-41d8cc51fd1a', 5, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8393819d-d770-54f9-96ed-41d8cc51fd1a', 6, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8393819d-d770-54f9-96ed-41d8cc51fd1a', 7, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8393819d-d770-54f9-96ed-41d8cc51fd1a', 8, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b9a25cd9-c43b-5ee0-b4f3-8988e2a413dc', '0136806c-8f87-5c5b-971d-7f88336e08f8', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Samuel Sawers', '977', 'individual', 14, 127.0, 99.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '42e793d2-eefd-5912-ab4b-27d82fc9bf3a', 'b9a25cd9-c43b-5ee0-b4f3-8988e2a413dc', '0136806c-8f87-5c5b-971d-7f88336e08f8', 'Samuel Sawers', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9a25cd9-c43b-5ee0-b4f3-8988e2a413dc', 1, 28.0, NULL, true, '(28)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9a25cd9-c43b-5ee0-b4f3-8988e2a413dc', 2, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9a25cd9-c43b-5ee0-b4f3-8988e2a413dc', 3, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9a25cd9-c43b-5ee0-b4f3-8988e2a413dc', 4, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9a25cd9-c43b-5ee0-b4f3-8988e2a413dc', 5, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9a25cd9-c43b-5ee0-b4f3-8988e2a413dc', 6, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9a25cd9-c43b-5ee0-b4f3-8988e2a413dc', 7, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b9a25cd9-c43b-5ee0-b4f3-8988e2a413dc', 8, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f87d601d-4db3-58b2-a865-2f5a794a0478', 'e2a2b49f-557f-5861-95ef-a37cb4c2bfe8', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Oscar Armstrong-Smith', '1150', 'individual', 15, 138.0, 105.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a6d49d27-a0a1-5784-b88c-13b687282d2e', 'f87d601d-4db3-58b2-a865-2f5a794a0478', 'e2a2b49f-557f-5861-95ef-a37cb4c2bfe8', 'Oscar Armstrong-Smith', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f87d601d-4db3-58b2-a865-2f5a794a0478', 1, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f87d601d-4db3-58b2-a865-2f5a794a0478', 2, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f87d601d-4db3-58b2-a865-2f5a794a0478', 3, 33.0, 'BFD', true, '(33)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f87d601d-4db3-58b2-a865-2f5a794a0478', 4, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f87d601d-4db3-58b2-a865-2f5a794a0478', 5, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f87d601d-4db3-58b2-a865-2f5a794a0478', 6, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f87d601d-4db3-58b2-a865-2f5a794a0478', 7, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f87d601d-4db3-58b2-a865-2f5a794a0478', 8, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8b2c8552-ce4a-5cd1-8570-9b770985ba1e', '368f20c7-7293-5f92-afed-d901a634a4f6', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Ko-Chen Chou', '1289', 'individual', 16, 135.0, 110.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f4824b0d-fae4-5586-874a-72235fab2a3a', '8b2c8552-ce4a-5cd1-8570-9b770985ba1e', '368f20c7-7293-5f92-afed-d901a634a4f6', 'Ko-Chen Chou', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8b2c8552-ce4a-5cd1-8570-9b770985ba1e', 1, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8b2c8552-ce4a-5cd1-8570-9b770985ba1e', 2, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8b2c8552-ce4a-5cd1-8570-9b770985ba1e', 3, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8b2c8552-ce4a-5cd1-8570-9b770985ba1e', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8b2c8552-ce4a-5cd1-8570-9b770985ba1e', 5, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8b2c8552-ce4a-5cd1-8570-9b770985ba1e', 6, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8b2c8552-ce4a-5cd1-8570-9b770985ba1e', 7, 25.0, NULL, true, '(25)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8b2c8552-ce4a-5cd1-8570-9b770985ba1e', 8, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1f6d7402-d5cf-5291-b8ee-92d5e577b748', '97f0b854-923f-5124-9cfa-8360389bc308', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Ebba Nixey', '1786', 'individual', 17, 133.0, 110.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '672f6dec-2aac-53a4-a9e4-a588a1f3e747', '1f6d7402-d5cf-5291-b8ee-92d5e577b748', '97f0b854-923f-5124-9cfa-8360389bc308', 'Ebba Nixey', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1f6d7402-d5cf-5291-b8ee-92d5e577b748', 1, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1f6d7402-d5cf-5291-b8ee-92d5e577b748', 2, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1f6d7402-d5cf-5291-b8ee-92d5e577b748', 3, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1f6d7402-d5cf-5291-b8ee-92d5e577b748', 4, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1f6d7402-d5cf-5291-b8ee-92d5e577b748', 5, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1f6d7402-d5cf-5291-b8ee-92d5e577b748', 6, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1f6d7402-d5cf-5291-b8ee-92d5e577b748', 7, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1f6d7402-d5cf-5291-b8ee-92d5e577b748', 8, 23.0, NULL, true, '(23)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '73efecad-1f12-509d-9fc9-ce1897f0535c', 'd164508c-c587-5c7f-9694-9b480ad61226', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Thea Rydin', '218', 'individual', 18, 148.0, 120.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '14123beb-45d5-5eb4-b630-1eb44eba67a8', '73efecad-1f12-509d-9fc9-ce1897f0535c', 'd164508c-c587-5c7f-9694-9b480ad61226', 'Thea Rydin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('73efecad-1f12-509d-9fc9-ce1897f0535c', 1, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('73efecad-1f12-509d-9fc9-ce1897f0535c', 2, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('73efecad-1f12-509d-9fc9-ce1897f0535c', 3, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('73efecad-1f12-509d-9fc9-ce1897f0535c', 4, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('73efecad-1f12-509d-9fc9-ce1897f0535c', 5, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('73efecad-1f12-509d-9fc9-ce1897f0535c', 6, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('73efecad-1f12-509d-9fc9-ce1897f0535c', 7, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('73efecad-1f12-509d-9fc9-ce1897f0535c', 8, 28.0, NULL, true, '(28)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'efa15e65-2716-5e69-8d3e-900ccdd075ad', '3cf1dd72-3f12-521f-a9be-a8dd0ba7ef0f', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Arthur Douroux', '663', 'individual', 19, 154.0, 121.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8d295130-f8cd-58da-9b73-f729a681d75f', 'efa15e65-2716-5e69-8d3e-900ccdd075ad', '3cf1dd72-3f12-521f-a9be-a8dd0ba7ef0f', 'Arthur Douroux', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efa15e65-2716-5e69-8d3e-900ccdd075ad', 1, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efa15e65-2716-5e69-8d3e-900ccdd075ad', 2, 33.0, 'OCS', true, '(33)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efa15e65-2716-5e69-8d3e-900ccdd075ad', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efa15e65-2716-5e69-8d3e-900ccdd075ad', 4, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efa15e65-2716-5e69-8d3e-900ccdd075ad', 5, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efa15e65-2716-5e69-8d3e-900ccdd075ad', 6, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efa15e65-2716-5e69-8d3e-900ccdd075ad', 7, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('efa15e65-2716-5e69-8d3e-900ccdd075ad', 8, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '884ea38e-d34d-59bb-a99b-46e8d7fb0228', '381285e5-8415-5fde-8418-373f492b9eca', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Sam Hardy', '1481', 'individual', 20, 158.0, 131.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a2dff85d-455e-585a-acb0-87c16819ae93', '884ea38e-d34d-59bb-a99b-46e8d7fb0228', '381285e5-8415-5fde-8418-373f492b9eca', 'Sam Hardy', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('884ea38e-d34d-59bb-a99b-46e8d7fb0228', 1, 27.0, NULL, true, '(27)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('884ea38e-d34d-59bb-a99b-46e8d7fb0228', 2, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('884ea38e-d34d-59bb-a99b-46e8d7fb0228', 3, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('884ea38e-d34d-59bb-a99b-46e8d7fb0228', 4, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('884ea38e-d34d-59bb-a99b-46e8d7fb0228', 5, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('884ea38e-d34d-59bb-a99b-46e8d7fb0228', 6, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('884ea38e-d34d-59bb-a99b-46e8d7fb0228', 7, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('884ea38e-d34d-59bb-a99b-46e8d7fb0228', 8, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b46d5d5c-e87a-5858-928b-ced4bd4375b6', '0f1dbaf1-c074-5cba-9abc-c91bdde4434f', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Amelia McKelvey', '1511', 'individual', 21, 175.0, 142.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd710bc22-7912-562b-8b1e-c334c516cb3b', 'b46d5d5c-e87a-5858-928b-ced4bd4375b6', '0f1dbaf1-c074-5cba-9abc-c91bdde4434f', 'Amelia McKelvey', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b46d5d5c-e87a-5858-928b-ced4bd4375b6', 1, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b46d5d5c-e87a-5858-928b-ced4bd4375b6', 2, 33.0, 'OCS', true, '(33)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b46d5d5c-e87a-5858-928b-ced4bd4375b6', 3, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b46d5d5c-e87a-5858-928b-ced4bd4375b6', 4, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b46d5d5c-e87a-5858-928b-ced4bd4375b6', 5, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b46d5d5c-e87a-5858-928b-ced4bd4375b6', 6, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b46d5d5c-e87a-5858-928b-ced4bd4375b6', 7, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b46d5d5c-e87a-5858-928b-ced4bd4375b6', 8, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '77fcb5d8-209d-5f19-97e5-3916b907041b', '6809147a-acdc-5a68-9d3a-a6ff1f4ecd6e', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Ellery Chai', '1078', 'individual', 22, 187.0, 154.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '026e7950-a310-5374-9e19-4da2dc131f3c', '77fcb5d8-209d-5f19-97e5-3916b907041b', '6809147a-acdc-5a68-9d3a-a6ff1f4ecd6e', 'Ellery Chai', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77fcb5d8-209d-5f19-97e5-3916b907041b', 1, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77fcb5d8-209d-5f19-97e5-3916b907041b', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77fcb5d8-209d-5f19-97e5-3916b907041b', 3, 33.0, 'TLE', true, '(33)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77fcb5d8-209d-5f19-97e5-3916b907041b', 4, 33.0, 'RET', false, '33RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77fcb5d8-209d-5f19-97e5-3916b907041b', 5, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77fcb5d8-209d-5f19-97e5-3916b907041b', 6, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77fcb5d8-209d-5f19-97e5-3916b907041b', 7, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77fcb5d8-209d-5f19-97e5-3916b907041b', 8, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '4f705d53-5403-5ab7-8693-34b0de17b417', '7409f7c8-f1e5-57ae-b7b4-d3ce110f19a9', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Nicholas Hasek', '1828', 'individual', 23, 189.0, 156.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'cad22476-3552-5931-8e5a-99a80cbebf45', '4f705d53-5403-5ab7-8693-34b0de17b417', '7409f7c8-f1e5-57ae-b7b4-d3ce110f19a9', 'Nicholas Hasek', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f705d53-5403-5ab7-8693-34b0de17b417', 1, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f705d53-5403-5ab7-8693-34b0de17b417', 2, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f705d53-5403-5ab7-8693-34b0de17b417', 3, 33.0, 'BFD', true, '(33)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f705d53-5403-5ab7-8693-34b0de17b417', 4, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f705d53-5403-5ab7-8693-34b0de17b417', 5, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f705d53-5403-5ab7-8693-34b0de17b417', 6, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f705d53-5403-5ab7-8693-34b0de17b417', 7, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f705d53-5403-5ab7-8693-34b0de17b417', 8, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '4f0cb69f-0fcd-5beb-b5e2-f7b8ae4f273b', 'a92f3324-6fb3-58ad-a586-0f093e755539', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Jasper Ryves', '1385', 'individual', 24, 192.0, 159.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ad105e12-340d-5e17-b671-4e9901aa6b90', '4f0cb69f-0fcd-5beb-b5e2-f7b8ae4f273b', 'a92f3324-6fb3-58ad-a586-0f093e755539', 'Jasper Ryves', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f0cb69f-0fcd-5beb-b5e2-f7b8ae4f273b', 1, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f0cb69f-0fcd-5beb-b5e2-f7b8ae4f273b', 2, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f0cb69f-0fcd-5beb-b5e2-f7b8ae4f273b', 3, 33.0, 'RET', true, '(33)RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f0cb69f-0fcd-5beb-b5e2-f7b8ae4f273b', 4, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f0cb69f-0fcd-5beb-b5e2-f7b8ae4f273b', 5, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f0cb69f-0fcd-5beb-b5e2-f7b8ae4f273b', 6, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f0cb69f-0fcd-5beb-b5e2-f7b8ae4f273b', 7, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4f0cb69f-0fcd-5beb-b5e2-f7b8ae4f273b', 8, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'eba6c52e-16ae-5c5a-a2d0-8fb0c8cec0cb', '72e93146-918f-58ce-bb0b-7a420e62c528', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Han Chia', '935', 'individual', 25, 188.0, 159.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '04164f14-e30b-521a-b8c6-4a5afd69f1b1', 'eba6c52e-16ae-5c5a-a2d0-8fb0c8cec0cb', '72e93146-918f-58ce-bb0b-7a420e62c528', 'Han Chia', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eba6c52e-16ae-5c5a-a2d0-8fb0c8cec0cb', 1, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eba6c52e-16ae-5c5a-a2d0-8fb0c8cec0cb', 2, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eba6c52e-16ae-5c5a-a2d0-8fb0c8cec0cb', 3, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eba6c52e-16ae-5c5a-a2d0-8fb0c8cec0cb', 4, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eba6c52e-16ae-5c5a-a2d0-8fb0c8cec0cb', 5, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eba6c52e-16ae-5c5a-a2d0-8fb0c8cec0cb', 6, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eba6c52e-16ae-5c5a-a2d0-8fb0c8cec0cb', 7, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eba6c52e-16ae-5c5a-a2d0-8fb0c8cec0cb', 8, 29.0, NULL, true, '(29)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e0a69d73-5ab1-51d3-a114-ffc07651b816', '3c39019e-1dbd-5fda-8441-6805e0e87cc3', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Aria Jeena', '1286', 'individual', 26, 194.0, 161.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1f31a6e0-37f5-55a1-873a-692b56f51d2e', 'e0a69d73-5ab1-51d3-a114-ffc07651b816', '3c39019e-1dbd-5fda-8441-6805e0e87cc3', 'Aria Jeena', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0a69d73-5ab1-51d3-a114-ffc07651b816', 1, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0a69d73-5ab1-51d3-a114-ffc07651b816', 2, 33.0, 'OCS', true, '(33)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0a69d73-5ab1-51d3-a114-ffc07651b816', 3, 33.0, 'RET', false, '33RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0a69d73-5ab1-51d3-a114-ffc07651b816', 4, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0a69d73-5ab1-51d3-a114-ffc07651b816', 5, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0a69d73-5ab1-51d3-a114-ffc07651b816', 6, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0a69d73-5ab1-51d3-a114-ffc07651b816', 7, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0a69d73-5ab1-51d3-a114-ffc07651b816', 8, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'adcfe440-8843-5172-a30d-5035a170aae7', '1fb75a6c-f136-541a-b620-6069e3d9019d', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Edward Cantwell', '912', 'individual', 27, 195.0, 162.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f56331b4-a795-555c-9377-5d09e3133d90', 'adcfe440-8843-5172-a30d-5035a170aae7', '1fb75a6c-f136-541a-b620-6069e3d9019d', 'Edward Cantwell', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('adcfe440-8843-5172-a30d-5035a170aae7', 1, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('adcfe440-8843-5172-a30d-5035a170aae7', 2, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('adcfe440-8843-5172-a30d-5035a170aae7', 3, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('adcfe440-8843-5172-a30d-5035a170aae7', 4, 33.0, 'DNF', true, '(33)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('adcfe440-8843-5172-a30d-5035a170aae7', 5, 33.0, 'RET', false, '33RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('adcfe440-8843-5172-a30d-5035a170aae7', 6, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('adcfe440-8843-5172-a30d-5035a170aae7', 7, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('adcfe440-8843-5172-a30d-5035a170aae7', 8, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '5a300e03-83f3-549d-8b8e-f5d19a8fba98', '22670cfa-0e57-5cbd-b6b0-aef9a8d515e7', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Olivia Dorling', '1575', 'individual', 28, 215.0, 182.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bbd0fd8e-3968-53d3-9fd4-77ce6afc50d3', '5a300e03-83f3-549d-8b8e-f5d19a8fba98', '22670cfa-0e57-5cbd-b6b0-aef9a8d515e7', 'Olivia Dorling', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5a300e03-83f3-549d-8b8e-f5d19a8fba98', 1, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5a300e03-83f3-549d-8b8e-f5d19a8fba98', 2, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5a300e03-83f3-549d-8b8e-f5d19a8fba98', 3, 33.0, 'RET', true, '(33)RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5a300e03-83f3-549d-8b8e-f5d19a8fba98', 4, 33.0, 'RET', false, '33RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5a300e03-83f3-549d-8b8e-f5d19a8fba98', 5, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5a300e03-83f3-549d-8b8e-f5d19a8fba98', 6, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5a300e03-83f3-549d-8b8e-f5d19a8fba98', 7, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5a300e03-83f3-549d-8b8e-f5d19a8fba98', 8, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'cac75b19-37f7-5df6-8d0b-aaae3bf691c2', 'f2041fe0-2d58-5999-a413-d0822e35ab20', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Will Hinchliffe', '926', 'individual', 29, 231.0, 198.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '92c7b3c2-e544-5e9a-9a6a-ea4c9fc91a44', 'cac75b19-37f7-5df6-8d0b-aaae3bf691c2', 'f2041fe0-2d58-5999-a413-d0822e35ab20', 'Will Hinchliffe', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cac75b19-37f7-5df6-8d0b-aaae3bf691c2', 1, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cac75b19-37f7-5df6-8d0b-aaae3bf691c2', 2, 33.0, 'OCS', true, '(33)OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cac75b19-37f7-5df6-8d0b-aaae3bf691c2', 3, 33.0, 'BFD', false, '33BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cac75b19-37f7-5df6-8d0b-aaae3bf691c2', 4, 33.0, 'RET', false, '33RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cac75b19-37f7-5df6-8d0b-aaae3bf691c2', 5, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cac75b19-37f7-5df6-8d0b-aaae3bf691c2', 6, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cac75b19-37f7-5df6-8d0b-aaae3bf691c2', 7, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cac75b19-37f7-5df6-8d0b-aaae3bf691c2', 8, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '4dfc6c41-5df9-58e3-a310-20d17cc43f21', '46e1b468-d253-5159-a464-9db190c99d39', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Tristan Hultin', '1547', 'individual', 30, 256.0, 223.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '27da0297-7662-5ee3-aa83-18a4b634e44a', '4dfc6c41-5df9-58e3-a310-20d17cc43f21', '46e1b468-d253-5159-a464-9db190c99d39', 'Tristan Hultin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4dfc6c41-5df9-58e3-a310-20d17cc43f21', 1, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4dfc6c41-5df9-58e3-a310-20d17cc43f21', 2, 33.0, 'DNF', true, '(33)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4dfc6c41-5df9-58e3-a310-20d17cc43f21', 3, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4dfc6c41-5df9-58e3-a310-20d17cc43f21', 4, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4dfc6c41-5df9-58e3-a310-20d17cc43f21', 5, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4dfc6c41-5df9-58e3-a310-20d17cc43f21', 6, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4dfc6c41-5df9-58e3-a310-20d17cc43f21', 7, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4dfc6c41-5df9-58e3-a310-20d17cc43f21', 8, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7676cada-7c7d-54ed-845a-422b5769fad1', 'c6bc68de-5bce-54ce-9a60-2ad5ee448249', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Minato Cai', '1457', 'individual', 31, 257.0, 224.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b37551a2-b4f7-597b-bda5-a523c485f00d', '7676cada-7c7d-54ed-845a-422b5769fad1', 'c6bc68de-5bce-54ce-9a60-2ad5ee448249', 'Minato Cai', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7676cada-7c7d-54ed-845a-422b5769fad1', 1, 33.0, 'DNC', true, '(33)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7676cada-7c7d-54ed-845a-422b5769fad1', 2, 33.0, 'DNC', false, '33DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7676cada-7c7d-54ed-845a-422b5769fad1', 3, 33.0, 'RET', false, '33RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7676cada-7c7d-54ed-845a-422b5769fad1', 4, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7676cada-7c7d-54ed-845a-422b5769fad1', 5, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7676cada-7c7d-54ed-845a-422b5769fad1', 6, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7676cada-7c7d-54ed-845a-422b5769fad1', 7, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7676cada-7c7d-54ed-845a-422b5769fad1', 8, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd463fac6-c7de-55af-b695-b34185eb8632', '05e26cc1-c32c-50dc-8a42-29772024492b', '598c5aaf-659b-5c4d-a00f-053b4c1238ad', 'Jono Hinchliffe', '924', 'individual', 32, 264.0, 231.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.11', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f970ff9d-4e24-5a2d-9e13-eee5e4ebb438', 'd463fac6-c7de-55af-b695-b34185eb8632', '05e26cc1-c32c-50dc-8a42-29772024492b', 'Jono Hinchliffe', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d463fac6-c7de-55af-b695-b34185eb8632', 1, 33.0, 'DNF', true, '(33)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d463fac6-c7de-55af-b695-b34185eb8632', 2, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d463fac6-c7de-55af-b695-b34185eb8632', 3, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d463fac6-c7de-55af-b695-b34185eb8632', 4, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d463fac6-c7de-55af-b695-b34185eb8632', 5, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d463fac6-c7de-55af-b695-b34185eb8632', 6, 33.0, 'DNF', false, '33DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d463fac6-c7de-55af-b695-b34185eb8632', 7, 33.0, 'RET', false, '33RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d463fac6-c7de-55af-b695-b34185eb8632', 8, 33.0, 'RET', false, '33RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;

COMMIT;
