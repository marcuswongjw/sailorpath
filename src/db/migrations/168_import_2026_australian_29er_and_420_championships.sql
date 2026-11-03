-- Migration 168: Import 2026 Australian 29er & 420 Championships
--
-- Imports complete official championship scorecards for:
-- 1. 2026 Australian 29er Championship (Sandy Bay Sailing Club, Hobart, TAS; Jan 3–9, 2026)
--    - 21 boats, 42 sailors (helm + crew), 14 races, 294 race scores
-- 2. 2026 International 420 Class Australian Championship (Albury Wodonga Sailing Club, Lake Hume; Jan 19–23, 2026)
--    - 17 boats, 34 sailors (helm + crew), 10 races, 170 race scores
--
-- Sources:
-- - 29er: SailingResults.net (ID=82088.1)
-- - 420: Sailres (Series 2755)
--
-- All operations execute in a single atomic transaction.

BEGIN;

-- 1. Insert New Verified Sailor Profiles
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a6b4e58d-fbba-5f54-9d91-ea3336356cf4', 'Goro Tomishima', 'goro-tomishima-795e28', '3186', 'WSC / M16', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f36c114e-1da0-5507-8e4b-4ec4bdf7c14a', 'Orlando Sadlik', 'orlando-sadlik-7dfac2', '3186', 'WSC / M16', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'afad8146-fae3-5217-881f-449ff48bc956', 'Alasdair Cameron', 'alasdair-cameron-1c51a7', '3280', 'FSC', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3e1da03f-d00f-5604-b46e-716456fd72ee', 'Louis Polson', 'louis-polson-46039a', '3187', 'HKSI / RHKYC / RYCT', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c35e575b-b2bc-5ce3-b73b-a3e3c3733451', 'Miles Levenspiel', 'miles-levenspiel-f9287e', '3028', 'SSCBC', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'bd36fa38-3d39-5440-9c12-df5604a63c69', 'Henri Levenspiel', 'henri-levenspiel-75f230', '3028', 'SSCBC', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a7e212ec-5abd-543b-9a70-b30860543254', 'Edward Broadby', 'edward-broadby-3f2502', '3143', 'SBSC', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'b279a9a7-742d-5160-9e55-c1242cf7ab09', 'Gus Wilkie', 'gus-wilkie-810ff2', '3143', 'SBSC', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '8df00974-6881-5a8e-b674-ae1baa36e61c', 'Cate Mccoy', 'cate-mccoy-66396b', '2461', 'RGYC', 'AUS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '63986813-e6e2-5566-b20b-71732b6bf0ac', 'Josh Garner', 'josh-garner-1bf0a5', '2461', 'RGYC', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '5d9eb61e-776b-5398-ba66-c7d09d750521', 'Rory Spinaze-littlejohn', 'rory-spinaze-littlejohn-14da04', '2681', 'SBSC', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '06a09459-5212-546a-8111-82a8f133054b', 'James Ashwood', 'james-ashwood-9830e1', '2262', 'SBSC / RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd19a2b1e-92fd-5b1d-959b-ebd58537fe0d', 'Conrad Lumsden', 'conrad-lumsden-22ca34', '2262', 'SBSC / RHKYC', 'HKG', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '18b535e7-6b39-5cf5-80b7-2a69feb1e80d', 'Elysia Albery', 'elysia-albery-578fec', '3016', 'RQYS', 'AUS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '9b54bc2d-924d-5f5f-b7f7-39872371c754', 'Henry Mcquillen', 'henry-mcquillen-3f3c7a', '2288', 'SBSC', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '13f0208d-3db2-5758-9574-c3145b2b41ab', 'Allie Mclennan', 'allie-mclennan-31b693', '1527', 'SYC', 'AUS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '17a6ee20-f7d5-5df2-a96a-ad1143337947', 'Zara Challis', 'zara-challis-266792', '1527', 'SYC', 'AUS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '770ababd-c952-5955-a2c7-dd362803e641', 'Jamie Fleming', 'jamie-fleming-dd1deb', '1000', 'LYC', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '717bd4e9-7c0c-5149-9faf-031e2a7055e7', 'Jeremy Munnings', 'jeremy-munnings-15673f', '1000', 'LYC', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'f984bada-0fb2-5064-84ed-1cc8301e825b', 'Daisy Locke', 'daisy-locke-2ce133', '1932', 'KBSC / RQYS', 'AUS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a2c0a9b1-e9e9-5813-8d68-e0b6157decd4', 'Cooper Pennell', 'cooper-pennell-952796', '1932', 'KBSC / RQYS', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '10a75ea8-bb1e-541e-94b0-3c676f8a6efa', 'Linnea Townend', 'linnea-townend-547e36', '2197', 'SBSC', 'AUS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0f3e5832-27ba-5c06-b320-533423d5a5fd', 'Annelin Townend', 'annelin-townend-e099cd', '2197', 'SBSC', 'AUS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '022a86b8-a184-5502-9c68-2cf0282e91fa', 'Stewart Rose', 'stewart-rose-55670a', '55232', 'MSC', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '65388d04-67e1-56a6-b864-00361cc33a71', 'Olivia Cameron', 'olivia-cameron-c23be9', '55149', 'D''BYC', 'AUS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'a77a5051-bf23-5bba-9f0e-bc3c6f2c074f', 'Gary Cameron', 'gary-cameron-8cc6d7', '55149', 'D''BYC', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '4d0ce9b2-543b-5f0d-a3b2-555fddfa5f1a', 'Isabella Lozevski', 'isabella-lozevski-9f589f', '56674', 'WSC', 'AUS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e0603e7f-fb35-5d9c-a3d3-e0233e69cf16', 'Abbey Everett', 'abbey-everett-0c9f1f', '56006', 'SBSC', 'AUS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'dc697e24-bba4-58c6-848c-4cd743307742', 'Matthew Whitaker', 'matthew-whitaker-27b001', '56006', 'SBSC', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '591838c6-fb1c-542e-960b-c01eeecc8a47', 'Nick Meijer', 'nick-meijer-aa0236', '52422', 'SBSC', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'c4b62dd5-2f83-5879-a388-48316130f2ab', 'Jess Lowe', 'jess-lowe-781f36', '52422', 'SBSC', 'AUS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'e4c07ae9-fb15-5e50-a197-098121fdeade', 'Oscar Forbes', 'oscar-forbes-86bfe0', '56542', 'SBSC', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'd9a4994c-ac98-5647-afa6-09b96da0b509', 'Finn Meijer', 'finn-meijer-dc8cd6', '56542', 'SBSC', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '22c6ad0b-54bc-54fc-af03-e2739dc7665d', 'Gary McLennan', 'gary-mclennan-f6deb3', '55168', 'BRYC', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    'caff328b-6c2e-5a9f-8044-0db7aa969461', 'Ben Glover', 'ben-glover-492548', '55150', 'SYC', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '1f6b951f-4224-5d3a-8ce7-99d82cab58a7', 'Oliver Halse', 'oliver-halse-9905b6', '55150', 'SYC', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '832131a0-a4ef-579b-9a6d-1d242d8d2db1', 'Ilsa Ren Cohen', 'ilsa-ren-cohen-f57dae', '56615', 'WSC', 'AUS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '3ea3b023-5098-5bf8-a819-bb881de0adf5', 'Oscar Gayland', 'oscar-gayland-360131', '55104', 'LBSC', 'AUS', 'M', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);
INSERT INTO public.sailors (
    id, name, handle, sail_number, club, nationality, gender, created_at, updated_at
) VALUES (
    '0a96fc6c-3d91-5752-9f56-5504215d30ab', 'Lucy Cree', 'lucy-cree-1699d4', '55104', 'LBSC', 'AUS', 'F', clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    club = CASE WHEN public.sailors.club = 'Imported official result' OR public.sailors.club = 'N/A' THEN EXCLUDED.club ELSE public.sailors.club END,
    gender = COALESCE(public.sailors.gender, EXCLUDED.gender);

-- 2. Insert 2026 Australian 29er Championship Event & Sheet
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules,
    created_at, updated_at
) VALUES (
    '94fa20b2-09e4-571e-b899-a024b680f39a',
    '2026 Australian 29er Championship',
    '2026-australian-29er-championship',
    '2026-01-03',
    '2026-01-09',
    'Sandy Bay Sailing Club, Hobart, Tasmania',
    'Sandy Bay Sailing Club / Australian 9er Association',
    '["29er"]'::jsonb,
    false,
    false,
    'Official Australian 29er Championship 2026 held 3–9 January 2026 at Sandy Bay Sailing Club, Hobart, TAS.',
    'Low Point System with 2 discards (after race 9 and race 14).',
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, venue, organizer, geography, boat_class,
    division, entry_type, min_participants, max_participants, total_fleet_size, race_count,
    counts_for_ranking, is_selection_trial, status, official_results_url, official_results_source_name,
    created_at, updated_at
) VALUES (
    'fee77625-0acd-5b42-b336-645dd4650303',
    '94fa20b2-09e4-571e-b899-a024b680f39a',
    '2026 Australian 29er Championship — 29er',
    '2026-australian-29er-championship-29er',
    '2026-01-09',
    '2026-01-09',
    'Sandy Bay Sailing Club, Hobart, Tasmania',
    'Sandy Bay Sailing Club / Australian 9er Association',
    'AUS',
    '29er',
    'Open',
    'crew',
    2,
    2,
    21,
    14,
    false,
    false,
    'published',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'Official Australian 29er Championship 2026 Final Results (SailingResults.net ID=82088.1)',
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;

-- 3. Insert 29er Results, Participants & Race Scores
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '90569d40-260e-54ee-9357-aa2536b0253a', 'a6b4e58d-fbba-5f54-9d91-ea3336356cf4', 'fee77625-0acd-5b42-b336-645dd4650303', 'Goro Tomishima & Orlando Sadlik', '3186', 'crew', 1,
    74.6, 41.6, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: THE BUS. Helm: Goro Tomishima, Crew: Orlando Sadlik. Club: WSC / M16. State: NSW. Junior Skipper', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd2c1d83f-2ecf-52e7-85b0-67e4620f2dea', '90569d40-260e-54ee-9357-aa2536b0253a', 'a6b4e58d-fbba-5f54-9d91-ea3336356cf4', 'Goro Tomishima', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e3b54bf1-e0e2-59a0-b11f-6a0705c27f00', '90569d40-260e-54ee-9357-aa2536b0253a', 'f36c114e-1da0-5507-8e4b-4ec4bdf7c14a', 'Orlando Sadlik', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90569d40-260e-54ee-9357-aa2536b0253a', 1, 11.0, NULL, true, '(11)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90569d40-260e-54ee-9357-aa2536b0253a', 2, 7.6, NULL, false, '7.60'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90569d40-260e-54ee-9357-aa2536b0253a', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90569d40-260e-54ee-9357-aa2536b0253a', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90569d40-260e-54ee-9357-aa2536b0253a', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90569d40-260e-54ee-9357-aa2536b0253a', 6, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90569d40-260e-54ee-9357-aa2536b0253a', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90569d40-260e-54ee-9357-aa2536b0253a', 8, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90569d40-260e-54ee-9357-aa2536b0253a', 9, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90569d40-260e-54ee-9357-aa2536b0253a', 10, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90569d40-260e-54ee-9357-aa2536b0253a', 11, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90569d40-260e-54ee-9357-aa2536b0253a', 12, 22.0, 'UFD', true, '(22) UFD'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90569d40-260e-54ee-9357-aa2536b0253a', 13, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '90569d40-260e-54ee-9357-aa2536b0253a', 14, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ffcaecab-91c5-54c1-9c6d-ff6457d0a755', '8198dd01-ace2-5c18-b21e-0f108ca58d10', 'fee77625-0acd-5b42-b336-645dd4650303', 'Finley Symonds & Alasdair Cameron', '3280', 'crew', 2,
    65.0, 42.0, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: Pinch of Salt. Helm: Finley Symonds, Crew: Alasdair Cameron. Club: FSC. State: WA.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '87a28508-e9d3-53d9-bd56-a76a1864de8f', 'ffcaecab-91c5-54c1-9c6d-ff6457d0a755', '8198dd01-ace2-5c18-b21e-0f108ca58d10', 'Finley Symonds', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f204a008-8cad-50c9-bbc3-131121c462b2', 'ffcaecab-91c5-54c1-9c6d-ff6457d0a755', 'afad8146-fae3-5217-881f-449ff48bc956', 'Alasdair Cameron', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffcaecab-91c5-54c1-9c6d-ff6457d0a755', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffcaecab-91c5-54c1-9c6d-ff6457d0a755', 2, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffcaecab-91c5-54c1-9c6d-ff6457d0a755', 3, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffcaecab-91c5-54c1-9c6d-ff6457d0a755', 4, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffcaecab-91c5-54c1-9c6d-ff6457d0a755', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffcaecab-91c5-54c1-9c6d-ff6457d0a755', 6, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffcaecab-91c5-54c1-9c6d-ff6457d0a755', 7, 14.0, NULL, true, '(14)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffcaecab-91c5-54c1-9c6d-ff6457d0a755', 8, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffcaecab-91c5-54c1-9c6d-ff6457d0a755', 9, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffcaecab-91c5-54c1-9c6d-ff6457d0a755', 10, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffcaecab-91c5-54c1-9c6d-ff6457d0a755', 11, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffcaecab-91c5-54c1-9c6d-ff6457d0a755', 12, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffcaecab-91c5-54c1-9c6d-ff6457d0a755', 13, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ffcaecab-91c5-54c1-9c6d-ff6457d0a755', 14, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f33d7e82-05f6-5cfa-bbe1-f95b392fb0fe', 'abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6', 'fee77625-0acd-5b42-b336-645dd4650303', 'Ethan Kiu & Louis Polson', '3187', 'crew', 3,
    78.6, 48.0, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: Granola. Helm: Ethan Kiu, Crew: Louis Polson. Club: HKSI / RHKYC / RYCT. State: TAS / HONG KONG. Junior Skipper Junior Crew All Junior', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '301978c2-d522-5d30-b1c4-087ff9307b85', 'f33d7e82-05f6-5cfa-bbe1-f95b392fb0fe', 'abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6', 'Ethan Kiu', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'dad90e35-38cf-5584-8dc5-57b28e623be9', 'f33d7e82-05f6-5cfa-bbe1-f95b392fb0fe', '3e1da03f-d00f-5604-b46e-716456fd72ee', 'Louis Polson', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f33d7e82-05f6-5cfa-bbe1-f95b392fb0fe', 1, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f33d7e82-05f6-5cfa-bbe1-f95b392fb0fe', 2, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f33d7e82-05f6-5cfa-bbe1-f95b392fb0fe', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f33d7e82-05f6-5cfa-bbe1-f95b392fb0fe', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f33d7e82-05f6-5cfa-bbe1-f95b392fb0fe', 5, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f33d7e82-05f6-5cfa-bbe1-f95b392fb0fe', 6, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f33d7e82-05f6-5cfa-bbe1-f95b392fb0fe', 7, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f33d7e82-05f6-5cfa-bbe1-f95b392fb0fe', 8, 22.0, 'UFD', true, '(22) UFD'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f33d7e82-05f6-5cfa-bbe1-f95b392fb0fe', 9, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f33d7e82-05f6-5cfa-bbe1-f95b392fb0fe', 10, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f33d7e82-05f6-5cfa-bbe1-f95b392fb0fe', 11, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f33d7e82-05f6-5cfa-bbe1-f95b392fb0fe', 12, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f33d7e82-05f6-5cfa-bbe1-f95b392fb0fe', 13, 8.6, NULL, true, '(8.60)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f33d7e82-05f6-5cfa-bbe1-f95b392fb0fe', 14, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c85be759-39f1-572b-a605-a8a39d53bcc5', 'c35e575b-b2bc-5ce3-b73b-a3e3c3733451', 'fee77625-0acd-5b42-b336-645dd4650303', 'Miles Levenspiel & Henri Levenspiel', '3028', 'crew', 4,
    72.0, 54.0, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: PR3. Helm: Miles Levenspiel, Crew: Henri Levenspiel. Club: SSCBC. State: VIC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'de7e0b56-242b-5f09-b74f-4919f9631883', 'c85be759-39f1-572b-a605-a8a39d53bcc5', 'c35e575b-b2bc-5ce3-b73b-a3e3c3733451', 'Miles Levenspiel', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '6107e9a7-f58b-5e5d-9fc5-a3dc6846a19d', 'c85be759-39f1-572b-a605-a8a39d53bcc5', 'bd36fa38-3d39-5440-9c12-df5604a63c69', 'Henri Levenspiel', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c85be759-39f1-572b-a605-a8a39d53bcc5', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c85be759-39f1-572b-a605-a8a39d53bcc5', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c85be759-39f1-572b-a605-a8a39d53bcc5', 3, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c85be759-39f1-572b-a605-a8a39d53bcc5', 4, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c85be759-39f1-572b-a605-a8a39d53bcc5', 5, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c85be759-39f1-572b-a605-a8a39d53bcc5', 6, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c85be759-39f1-572b-a605-a8a39d53bcc5', 7, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c85be759-39f1-572b-a605-a8a39d53bcc5', 8, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c85be759-39f1-572b-a605-a8a39d53bcc5', 9, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c85be759-39f1-572b-a605-a8a39d53bcc5', 10, 9.0, NULL, true, '(9)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c85be759-39f1-572b-a605-a8a39d53bcc5', 11, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c85be759-39f1-572b-a605-a8a39d53bcc5', 12, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c85be759-39f1-572b-a605-a8a39d53bcc5', 13, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c85be759-39f1-572b-a605-a8a39d53bcc5', 14, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '1c94bcc9-d51b-5ba4-bb99-12a25ca139c1', 'a7e212ec-5abd-543b-9a70-b30860543254', 'fee77625-0acd-5b42-b336-645dd4650303', 'Edward Broadby & Gus Wilkie', '3143', 'crew', 5,
    87.0, 55.0, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: The Bus. Helm: Edward Broadby, Crew: Gus Wilkie. Club: SBSC. State: TAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '585a027e-ba6f-5f66-936d-eae00da60e68', '1c94bcc9-d51b-5ba4-bb99-12a25ca139c1', 'a7e212ec-5abd-543b-9a70-b30860543254', 'Edward Broadby', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c929b901-078b-5eb8-bf35-0dcb2a8ad91f', '1c94bcc9-d51b-5ba4-bb99-12a25ca139c1', 'b279a9a7-742d-5160-9e55-c1242cf7ab09', 'Gus Wilkie', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c94bcc9-d51b-5ba4-bb99-12a25ca139c1', 1, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c94bcc9-d51b-5ba4-bb99-12a25ca139c1', 2, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c94bcc9-d51b-5ba4-bb99-12a25ca139c1', 3, 14.0, NULL, true, '(14)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c94bcc9-d51b-5ba4-bb99-12a25ca139c1', 4, 18.0, NULL, true, '(18)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c94bcc9-d51b-5ba4-bb99-12a25ca139c1', 5, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c94bcc9-d51b-5ba4-bb99-12a25ca139c1', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c94bcc9-d51b-5ba4-bb99-12a25ca139c1', 7, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c94bcc9-d51b-5ba4-bb99-12a25ca139c1', 8, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c94bcc9-d51b-5ba4-bb99-12a25ca139c1', 9, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c94bcc9-d51b-5ba4-bb99-12a25ca139c1', 10, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c94bcc9-d51b-5ba4-bb99-12a25ca139c1', 11, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c94bcc9-d51b-5ba4-bb99-12a25ca139c1', 12, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c94bcc9-d51b-5ba4-bb99-12a25ca139c1', 13, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1c94bcc9-d51b-5ba4-bb99-12a25ca139c1', 14, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f8a87eed-15e2-5ee7-86e5-62801c703984', 'c560b015-7d93-5b95-bef6-f59c52cf271e', 'fee77625-0acd-5b42-b336-645dd4650303', 'Mia Austin & Zara Marks', '3213', 'crew', 6,
    99.0, 73.0, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: Zoom. Helm: Mia Austin, Crew: Zara Marks. Club: WSC. State: NSW. Junior Crew Female Skipper Female Crew All Female', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5fd59614-e955-5a96-9bf0-49a40d62cde4', 'f8a87eed-15e2-5ee7-86e5-62801c703984', 'c560b015-7d93-5b95-bef6-f59c52cf271e', 'Mia Austin', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'af38faac-4572-5b24-9423-e2ad059a23be', 'f8a87eed-15e2-5ee7-86e5-62801c703984', 'c6909a4b-71df-5bc8-9180-669be9e4bd10', 'Zara Marks', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f8a87eed-15e2-5ee7-86e5-62801c703984', 1, 12.0, NULL, true, '(12)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f8a87eed-15e2-5ee7-86e5-62801c703984', 2, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f8a87eed-15e2-5ee7-86e5-62801c703984', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f8a87eed-15e2-5ee7-86e5-62801c703984', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f8a87eed-15e2-5ee7-86e5-62801c703984', 5, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f8a87eed-15e2-5ee7-86e5-62801c703984', 6, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f8a87eed-15e2-5ee7-86e5-62801c703984', 7, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f8a87eed-15e2-5ee7-86e5-62801c703984', 8, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f8a87eed-15e2-5ee7-86e5-62801c703984', 9, 14.0, NULL, true, '(14)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f8a87eed-15e2-5ee7-86e5-62801c703984', 10, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f8a87eed-15e2-5ee7-86e5-62801c703984', 11, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f8a87eed-15e2-5ee7-86e5-62801c703984', 12, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f8a87eed-15e2-5ee7-86e5-62801c703984', 13, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f8a87eed-15e2-5ee7-86e5-62801c703984', 14, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e6c1cb32-b633-59c4-9d7a-6c5195dcb029', '8df00974-6881-5a8e-b674-ae1baa36e61c', 'fee77625-0acd-5b42-b336-645dd4650303', 'Cate Mccoy & Josh Garner', '2461', 'crew', 7,
    119.0, 80.0, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: Whoopachang. Helm: Cate Mccoy, Crew: Josh Garner. Club: RGYC. State: VIC. Female Skipper', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c23e5d77-66f6-50ec-ad27-adac315dca7b', 'e6c1cb32-b633-59c4-9d7a-6c5195dcb029', '8df00974-6881-5a8e-b674-ae1baa36e61c', 'Cate Mccoy', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c107a634-7029-51db-a103-763e60d7f2ad', 'e6c1cb32-b633-59c4-9d7a-6c5195dcb029', '63986813-e6e2-5566-b20b-71732b6bf0ac', 'Josh Garner', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6c1cb32-b633-59c4-9d7a-6c5195dcb029', 1, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6c1cb32-b633-59c4-9d7a-6c5195dcb029', 2, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6c1cb32-b633-59c4-9d7a-6c5195dcb029', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6c1cb32-b633-59c4-9d7a-6c5195dcb029', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6c1cb32-b633-59c4-9d7a-6c5195dcb029', 5, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6c1cb32-b633-59c4-9d7a-6c5195dcb029', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6c1cb32-b633-59c4-9d7a-6c5195dcb029', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6c1cb32-b633-59c4-9d7a-6c5195dcb029', 8, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6c1cb32-b633-59c4-9d7a-6c5195dcb029', 9, 22.0, 'RET', true, '(22) RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6c1cb32-b633-59c4-9d7a-6c5195dcb029', 10, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6c1cb32-b633-59c4-9d7a-6c5195dcb029', 11, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6c1cb32-b633-59c4-9d7a-6c5195dcb029', 12, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6c1cb32-b633-59c4-9d7a-6c5195dcb029', 13, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e6c1cb32-b633-59c4-9d7a-6c5195dcb029', 14, 17.0, NULL, true, '(17)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '5cca826a-84d4-5f4b-8fca-45fe29dd1092', '9346e9e0-9710-5750-a8ba-aef360915dca', 'fee77625-0acd-5b42-b336-645dd4650303', 'Alice Travlos & Klara Travlos', '2247', 'crew', 8,
    117.0, 82.0, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: Devil''s Ballast. Helm: Alice Travlos, Crew: Klara Travlos. Club: RFBYC / PDSC / FSC. State: WA. All Female', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '609799c4-d99f-59f4-b677-78ff238a534a', '5cca826a-84d4-5f4b-8fca-45fe29dd1092', '9346e9e0-9710-5750-a8ba-aef360915dca', 'Alice Travlos', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '76cf0681-c2d4-5bad-a002-64ea52ed9613', '5cca826a-84d4-5f4b-8fca-45fe29dd1092', 'fd68b50e-e289-50ec-8e83-14c1c57c46cc', 'Klara Travlos', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5cca826a-84d4-5f4b-8fca-45fe29dd1092', 1, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5cca826a-84d4-5f4b-8fca-45fe29dd1092', 2, 22.0, 'UFD', true, '(22) UFD'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5cca826a-84d4-5f4b-8fca-45fe29dd1092', 3, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5cca826a-84d4-5f4b-8fca-45fe29dd1092', 4, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5cca826a-84d4-5f4b-8fca-45fe29dd1092', 5, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5cca826a-84d4-5f4b-8fca-45fe29dd1092', 6, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5cca826a-84d4-5f4b-8fca-45fe29dd1092', 7, 13.0, NULL, true, '(13)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5cca826a-84d4-5f4b-8fca-45fe29dd1092', 8, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5cca826a-84d4-5f4b-8fca-45fe29dd1092', 9, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5cca826a-84d4-5f4b-8fca-45fe29dd1092', 10, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5cca826a-84d4-5f4b-8fca-45fe29dd1092', 11, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5cca826a-84d4-5f4b-8fca-45fe29dd1092', 12, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5cca826a-84d4-5f4b-8fca-45fe29dd1092', 13, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5cca826a-84d4-5f4b-8fca-45fe29dd1092', 14, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c37238bc-2fb2-5b7e-b2a7-4281351fb021', '4dc3441d-98ec-5902-a2e1-da489f634193', 'fee77625-0acd-5b42-b336-645dd4650303', 'Caelan Byrt & Robert Deards', '3281', 'crew', 9,
    109.0, 83.0, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: Full Send 2. Helm: Caelan Byrt, Crew: Robert Deards. Club: KBSC. State: QLD.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '14e5fd07-cd70-592c-81f7-a5961b6532de', 'c37238bc-2fb2-5b7e-b2a7-4281351fb021', '4dc3441d-98ec-5902-a2e1-da489f634193', 'Caelan Byrt', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '50bdaf2c-3c94-503b-917b-47ebd5925210', 'c37238bc-2fb2-5b7e-b2a7-4281351fb021', '4759381e-50b3-5fa0-813e-2183e0914382', 'Robert Deards', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c37238bc-2fb2-5b7e-b2a7-4281351fb021', 1, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c37238bc-2fb2-5b7e-b2a7-4281351fb021', 2, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c37238bc-2fb2-5b7e-b2a7-4281351fb021', 3, 13.0, NULL, true, '(13)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c37238bc-2fb2-5b7e-b2a7-4281351fb021', 4, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c37238bc-2fb2-5b7e-b2a7-4281351fb021', 5, 13.0, NULL, true, '(13)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c37238bc-2fb2-5b7e-b2a7-4281351fb021', 6, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c37238bc-2fb2-5b7e-b2a7-4281351fb021', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c37238bc-2fb2-5b7e-b2a7-4281351fb021', 8, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c37238bc-2fb2-5b7e-b2a7-4281351fb021', 9, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c37238bc-2fb2-5b7e-b2a7-4281351fb021', 10, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c37238bc-2fb2-5b7e-b2a7-4281351fb021', 11, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c37238bc-2fb2-5b7e-b2a7-4281351fb021', 12, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c37238bc-2fb2-5b7e-b2a7-4281351fb021', 13, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c37238bc-2fb2-5b7e-b2a7-4281351fb021', 14, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '87830d56-9019-5aee-b657-efb7e3ce31f6', '69843896-764b-5fbd-8754-f3b8fba0d252', 'fee77625-0acd-5b42-b336-645dd4650303', 'Kai Lawson & Andy Allt-graham', '3084', 'crew', 10,
    130.0, 96.0, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: Speed racer. Helm: Kai Lawson, Crew: Andy Allt-graham. Club: WSC. State: NSW.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '94aeaa18-441f-5738-b0d4-3320b7d29b20', '87830d56-9019-5aee-b657-efb7e3ce31f6', '69843896-764b-5fbd-8754-f3b8fba0d252', 'Kai Lawson', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c771d88f-dad3-5be7-ad3a-c637758f4d13', '87830d56-9019-5aee-b657-efb7e3ce31f6', '81fcced4-6ca3-54d1-82c4-3c37f45f706b', 'Andy Allt-graham', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87830d56-9019-5aee-b657-efb7e3ce31f6', 1, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87830d56-9019-5aee-b657-efb7e3ce31f6', 2, 22.0, 'UFD', true, '(22) UFD'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87830d56-9019-5aee-b657-efb7e3ce31f6', 3, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87830d56-9019-5aee-b657-efb7e3ce31f6', 4, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87830d56-9019-5aee-b657-efb7e3ce31f6', 5, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87830d56-9019-5aee-b657-efb7e3ce31f6', 6, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87830d56-9019-5aee-b657-efb7e3ce31f6', 7, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87830d56-9019-5aee-b657-efb7e3ce31f6', 8, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87830d56-9019-5aee-b657-efb7e3ce31f6', 9, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87830d56-9019-5aee-b657-efb7e3ce31f6', 10, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87830d56-9019-5aee-b657-efb7e3ce31f6', 11, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87830d56-9019-5aee-b657-efb7e3ce31f6', 12, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87830d56-9019-5aee-b657-efb7e3ce31f6', 13, 12.0, NULL, true, '(12)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '87830d56-9019-5aee-b657-efb7e3ce31f6', 14, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'ccc9fc4f-51aa-5fc4-883c-47fe5210ec15', 'abf791c2-8de8-5603-9304-48a1eaa36338', 'fee77625-0acd-5b42-b336-645dd4650303', 'Atlas Miller & Rory Spinaze-littlejohn', '2681', 'crew', 11,
    141.0, 109.0, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: Boatiful Idoits. Helm: Atlas Miller, Crew: Rory Spinaze-littlejohn. Club: SBSC. State: TAS. Junior Skipper', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '289e70ac-2eee-5e71-ae4a-abc59bcea84f', 'ccc9fc4f-51aa-5fc4-883c-47fe5210ec15', 'abf791c2-8de8-5603-9304-48a1eaa36338', 'Atlas Miller', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '640e1156-f7a7-5d07-bc47-b6e0b9eecc67', 'ccc9fc4f-51aa-5fc4-883c-47fe5210ec15', '5d9eb61e-776b-5398-ba66-c7d09d750521', 'Rory Spinaze-littlejohn', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ccc9fc4f-51aa-5fc4-883c-47fe5210ec15', 1, 18.0, NULL, true, '(18)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ccc9fc4f-51aa-5fc4-883c-47fe5210ec15', 2, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ccc9fc4f-51aa-5fc4-883c-47fe5210ec15', 3, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ccc9fc4f-51aa-5fc4-883c-47fe5210ec15', 4, 14.0, NULL, true, '(14)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ccc9fc4f-51aa-5fc4-883c-47fe5210ec15', 5, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ccc9fc4f-51aa-5fc4-883c-47fe5210ec15', 6, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ccc9fc4f-51aa-5fc4-883c-47fe5210ec15', 7, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ccc9fc4f-51aa-5fc4-883c-47fe5210ec15', 8, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ccc9fc4f-51aa-5fc4-883c-47fe5210ec15', 9, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ccc9fc4f-51aa-5fc4-883c-47fe5210ec15', 10, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ccc9fc4f-51aa-5fc4-883c-47fe5210ec15', 11, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ccc9fc4f-51aa-5fc4-883c-47fe5210ec15', 12, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ccc9fc4f-51aa-5fc4-883c-47fe5210ec15', 13, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'ccc9fc4f-51aa-5fc4-883c-47fe5210ec15', 14, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'bd1dd305-86d6-504d-8891-71914ad5c7f8', '06a09459-5212-546a-8111-82a8f133054b', 'fee77625-0acd-5b42-b336-645dd4650303', 'James Ashwood & Conrad Lumsden', '2262', 'crew', 12,
    158.0, 121.0, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: Flying Circus. Helm: James Ashwood, Crew: Conrad Lumsden. Club: SBSC / RHKYC. State: TAS / HONG KONG. Junior Skipper Junior Crew All Junior', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'de68416e-01a2-520c-8637-89830059609c', 'bd1dd305-86d6-504d-8891-71914ad5c7f8', '06a09459-5212-546a-8111-82a8f133054b', 'James Ashwood', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b8521a02-ca4f-5d6a-94c5-d176e1e30507', 'bd1dd305-86d6-504d-8891-71914ad5c7f8', 'd19a2b1e-92fd-5b1d-959b-ebd58537fe0d', 'Conrad Lumsden', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd1dd305-86d6-504d-8891-71914ad5c7f8', 1, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd1dd305-86d6-504d-8891-71914ad5c7f8', 2, 15.0, NULL, true, '(15)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd1dd305-86d6-504d-8891-71914ad5c7f8', 3, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd1dd305-86d6-504d-8891-71914ad5c7f8', 4, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd1dd305-86d6-504d-8891-71914ad5c7f8', 5, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd1dd305-86d6-504d-8891-71914ad5c7f8', 6, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd1dd305-86d6-504d-8891-71914ad5c7f8', 7, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd1dd305-86d6-504d-8891-71914ad5c7f8', 8, 22.0, 'UFD', true, '(22) UFD'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd1dd305-86d6-504d-8891-71914ad5c7f8', 9, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd1dd305-86d6-504d-8891-71914ad5c7f8', 10, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd1dd305-86d6-504d-8891-71914ad5c7f8', 11, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd1dd305-86d6-504d-8891-71914ad5c7f8', 12, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd1dd305-86d6-504d-8891-71914ad5c7f8', 13, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd1dd305-86d6-504d-8891-71914ad5c7f8', 14, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'b1fa27c4-8805-526b-97fa-6c77d24a947d', '004c973c-d86e-5802-beb3-a7c64cb6acc5', 'fee77625-0acd-5b42-b336-645dd4650303', 'Elspeth Clifford & Elysia Albery', '3016', 'crew', 13,
    172.0, 134.0, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: Why Knot. Helm: Elspeth Clifford, Crew: Elysia Albery. Club: RQYS. State: QLD. Junior Skipper Female Skipper Female Crew All Female', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ccaa9d9f-1199-5dc4-a043-12cf21440165', 'b1fa27c4-8805-526b-97fa-6c77d24a947d', '004c973c-d86e-5802-beb3-a7c64cb6acc5', 'Elspeth Clifford', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '33708696-a476-54e5-b5a2-a8c69c43d809', 'b1fa27c4-8805-526b-97fa-6c77d24a947d', '18b535e7-6b39-5cf5-80b7-2a69feb1e80d', 'Elysia Albery', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1fa27c4-8805-526b-97fa-6c77d24a947d', 1, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1fa27c4-8805-526b-97fa-6c77d24a947d', 2, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1fa27c4-8805-526b-97fa-6c77d24a947d', 3, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1fa27c4-8805-526b-97fa-6c77d24a947d', 4, 16.0, NULL, true, '(16)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1fa27c4-8805-526b-97fa-6c77d24a947d', 5, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1fa27c4-8805-526b-97fa-6c77d24a947d', 6, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1fa27c4-8805-526b-97fa-6c77d24a947d', 7, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1fa27c4-8805-526b-97fa-6c77d24a947d', 8, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1fa27c4-8805-526b-97fa-6c77d24a947d', 9, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1fa27c4-8805-526b-97fa-6c77d24a947d', 10, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1fa27c4-8805-526b-97fa-6c77d24a947d', 11, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1fa27c4-8805-526b-97fa-6c77d24a947d', 12, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1fa27c4-8805-526b-97fa-6c77d24a947d', 13, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'b1fa27c4-8805-526b-97fa-6c77d24a947d', 14, 22.0, 'UFD', true, '(22) UFD'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '3e03f184-5985-5757-9d8b-ecedaad55b8f', '648e9900-3772-5c6e-a162-d993f6cbb123', 'fee77625-0acd-5b42-b336-645dd4650303', 'Isaac Archer & Henry Mcquillen', '2288', 'crew', 14,
    183.0, 145.0, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: The Smiling Assassins. Helm: Isaac Archer, Crew: Henry Mcquillen. Club: SBSC. State: TAS. Junior Skipper', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1db6761a-e764-5e89-9fa9-3b0d072e5a51', '3e03f184-5985-5757-9d8b-ecedaad55b8f', '648e9900-3772-5c6e-a162-d993f6cbb123', 'Isaac Archer', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd251ed41-a342-5139-9512-5daef0fe063d', '3e03f184-5985-5757-9d8b-ecedaad55b8f', '9b54bc2d-924d-5f5f-b7f7-39872371c754', 'Henry Mcquillen', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e03f184-5985-5757-9d8b-ecedaad55b8f', 1, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e03f184-5985-5757-9d8b-ecedaad55b8f', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e03f184-5985-5757-9d8b-ecedaad55b8f', 3, 16.0, NULL, true, '(16)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e03f184-5985-5757-9d8b-ecedaad55b8f', 4, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e03f184-5985-5757-9d8b-ecedaad55b8f', 5, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e03f184-5985-5757-9d8b-ecedaad55b8f', 6, 16.0, NULL, false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e03f184-5985-5757-9d8b-ecedaad55b8f', 7, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e03f184-5985-5757-9d8b-ecedaad55b8f', 8, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e03f184-5985-5757-9d8b-ecedaad55b8f', 9, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e03f184-5985-5757-9d8b-ecedaad55b8f', 10, 22.0, 'UFD', true, '(22) UFD'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e03f184-5985-5757-9d8b-ecedaad55b8f', 11, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e03f184-5985-5757-9d8b-ecedaad55b8f', 12, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e03f184-5985-5757-9d8b-ecedaad55b8f', 13, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '3e03f184-5985-5757-9d8b-ecedaad55b8f', 14, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '68581e30-f6d7-5387-84c2-5a446c793856', 'beedd447-d06d-5ff8-b403-7a3bf04f5aa1', 'fee77625-0acd-5b42-b336-645dd4650303', 'Jess Wardell & Huon Williams', '1528', 'crew', 15,
    195.0, 163.0, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: Swaggermuffin. Helm: Jess Wardell, Crew: Huon Williams. Club: KBSC / PESC. State: TAS. Junior Skipper', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '2d249ffb-3b29-52c2-a7b7-daf181f7e982', '68581e30-f6d7-5387-84c2-5a446c793856', 'beedd447-d06d-5ff8-b403-7a3bf04f5aa1', 'Jess Wardell', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e83bee47-e3e5-52fa-a031-917b16923b05', '68581e30-f6d7-5387-84c2-5a446c793856', 'b953361a-07e9-5476-b78b-81e8b1c41679', 'Huon Williams', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '68581e30-f6d7-5387-84c2-5a446c793856', 1, 16.0, NULL, true, '(16)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '68581e30-f6d7-5387-84c2-5a446c793856', 2, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '68581e30-f6d7-5387-84c2-5a446c793856', 3, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '68581e30-f6d7-5387-84c2-5a446c793856', 4, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '68581e30-f6d7-5387-84c2-5a446c793856', 5, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '68581e30-f6d7-5387-84c2-5a446c793856', 6, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '68581e30-f6d7-5387-84c2-5a446c793856', 7, 16.0, NULL, true, '(16)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '68581e30-f6d7-5387-84c2-5a446c793856', 8, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '68581e30-f6d7-5387-84c2-5a446c793856', 9, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '68581e30-f6d7-5387-84c2-5a446c793856', 10, 16.0, NULL, false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '68581e30-f6d7-5387-84c2-5a446c793856', 11, 16.0, NULL, false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '68581e30-f6d7-5387-84c2-5a446c793856', 12, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '68581e30-f6d7-5387-84c2-5a446c793856', 13, 16.0, NULL, false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '68581e30-f6d7-5387-84c2-5a446c793856', 14, 16.0, NULL, false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '852ebd41-b46d-5d6d-822e-3c93de5c9129', '50f45ed2-0521-598c-b561-02212e288ef3', 'fee77625-0acd-5b42-b336-645dd4650303', 'Arthur Adams & Wellington Adams', '2134', 'crew', 16,
    210.0, 170.0, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: On the Sizzle. Helm: Arthur Adams, Crew: Wellington Adams. Club: KBSC / RYCT. State: TAS. Junior Skipper', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '029ba8a2-b8d5-5613-952b-c97f0d0e6c84', '852ebd41-b46d-5d6d-822e-3c93de5c9129', '50f45ed2-0521-598c-b561-02212e288ef3', 'Arthur Adams', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c2940f5a-263c-5c3e-9ab5-59f795611961', '852ebd41-b46d-5d6d-822e-3c93de5c9129', 'a630f2c0-7f3e-5f57-928b-c159ebc05ba6', 'Wellington Adams', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '852ebd41-b46d-5d6d-822e-3c93de5c9129', 1, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '852ebd41-b46d-5d6d-822e-3c93de5c9129', 2, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '852ebd41-b46d-5d6d-822e-3c93de5c9129', 3, 18.0, NULL, true, '(18)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '852ebd41-b46d-5d6d-822e-3c93de5c9129', 4, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '852ebd41-b46d-5d6d-822e-3c93de5c9129', 5, 18.0, NULL, false, '18'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '852ebd41-b46d-5d6d-822e-3c93de5c9129', 6, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '852ebd41-b46d-5d6d-822e-3c93de5c9129', 7, 17.0, NULL, false, '17'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '852ebd41-b46d-5d6d-822e-3c93de5c9129', 8, 22.0, 'UFD', true, '(22) UFD'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '852ebd41-b46d-5d6d-822e-3c93de5c9129', 9, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '852ebd41-b46d-5d6d-822e-3c93de5c9129', 10, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '852ebd41-b46d-5d6d-822e-3c93de5c9129', 11, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '852ebd41-b46d-5d6d-822e-3c93de5c9129', 12, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '852ebd41-b46d-5d6d-822e-3c93de5c9129', 13, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '852ebd41-b46d-5d6d-822e-3c93de5c9129', 14, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'f604b47f-71ea-5273-a6aa-0d17e57dabcf', '13f0208d-3db2-5758-9574-c3145b2b41ab', 'fee77625-0acd-5b42-b336-645dd4650303', 'Allie Mclennan & Zara Challis', '1527', 'crew', 17,
    218.0, 182.0, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: Swift. Helm: Allie Mclennan, Crew: Zara Challis. Club: SYC. State: VIC. All Female', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b49435e9-e0ea-53fe-815e-1fc94bf64761', 'f604b47f-71ea-5273-a6aa-0d17e57dabcf', '13f0208d-3db2-5758-9574-c3145b2b41ab', 'Allie Mclennan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9cd9660e-2626-5099-9680-3a2cc5e39b9f', 'f604b47f-71ea-5273-a6aa-0d17e57dabcf', '17a6ee20-f7d5-5df2-a96a-ad1143337947', 'Zara Challis', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f604b47f-71ea-5273-a6aa-0d17e57dabcf', 1, 17.0, NULL, false, '17'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f604b47f-71ea-5273-a6aa-0d17e57dabcf', 2, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f604b47f-71ea-5273-a6aa-0d17e57dabcf', 3, 17.0, NULL, false, '17'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f604b47f-71ea-5273-a6aa-0d17e57dabcf', 4, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f604b47f-71ea-5273-a6aa-0d17e57dabcf', 5, 17.0, NULL, false, '17'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f604b47f-71ea-5273-a6aa-0d17e57dabcf', 6, 17.0, NULL, false, '17'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f604b47f-71ea-5273-a6aa-0d17e57dabcf', 7, 18.0, NULL, true, '(18)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f604b47f-71ea-5273-a6aa-0d17e57dabcf', 8, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f604b47f-71ea-5273-a6aa-0d17e57dabcf', 9, 17.0, NULL, false, '17'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f604b47f-71ea-5273-a6aa-0d17e57dabcf', 10, 17.0, NULL, false, '17'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f604b47f-71ea-5273-a6aa-0d17e57dabcf', 11, 17.0, NULL, false, '17'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f604b47f-71ea-5273-a6aa-0d17e57dabcf', 12, 18.0, NULL, true, '(18)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f604b47f-71ea-5273-a6aa-0d17e57dabcf', 13, 17.0, NULL, false, '17'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'f604b47f-71ea-5273-a6aa-0d17e57dabcf', 14, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '247d55a1-647f-5125-a97f-0ef91be0d6b4', 'fc0907cf-6040-514b-92f3-b9bfaff2728b', 'fee77625-0acd-5b42-b336-645dd4650303', 'Victoria Chernoff & Eloise Chernoff', '3050', 'crew', 18,
    223.0, 187.0, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: Pink Zink. Helm: Victoria Chernoff, Crew: Eloise Chernoff. Club: SoPYC/FSC. State: WA. Junior Skipper Junior Crew All Junior Female Skipper Female Crew All Female', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '67ca415b-f806-59db-ac1c-3ba25f7f4fe7', '247d55a1-647f-5125-a97f-0ef91be0d6b4', 'fc0907cf-6040-514b-92f3-b9bfaff2728b', 'Victoria Chernoff', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'edcf44b8-9c0c-5b3b-8b49-0aca75958f70', '247d55a1-647f-5125-a97f-0ef91be0d6b4', '3b09bbca-acba-5d35-ae13-e5ae6ab60a37', 'Eloise Chernoff', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '247d55a1-647f-5125-a97f-0ef91be0d6b4', 1, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '247d55a1-647f-5125-a97f-0ef91be0d6b4', 2, 16.0, NULL, false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '247d55a1-647f-5125-a97f-0ef91be0d6b4', 3, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '247d55a1-647f-5125-a97f-0ef91be0d6b4', 4, 17.0, NULL, false, '17'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '247d55a1-647f-5125-a97f-0ef91be0d6b4', 5, 16.0, NULL, false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '247d55a1-647f-5125-a97f-0ef91be0d6b4', 6, 18.0, NULL, true, '(18)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '247d55a1-647f-5125-a97f-0ef91be0d6b4', 7, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '247d55a1-647f-5125-a97f-0ef91be0d6b4', 8, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '247d55a1-647f-5125-a97f-0ef91be0d6b4', 9, 16.0, NULL, false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '247d55a1-647f-5125-a97f-0ef91be0d6b4', 10, 18.0, NULL, true, '(18)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '247d55a1-647f-5125-a97f-0ef91be0d6b4', 11, 18.0, NULL, false, '18'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '247d55a1-647f-5125-a97f-0ef91be0d6b4', 12, 16.0, NULL, false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '247d55a1-647f-5125-a97f-0ef91be0d6b4', 13, 18.0, NULL, false, '18'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '247d55a1-647f-5125-a97f-0ef91be0d6b4', 14, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '189fd231-a458-5b96-b394-f2acc1868ee3', '770ababd-c952-5955-a2c7-dd362803e641', 'fee77625-0acd-5b42-b336-645dd4650303', 'Jamie Fleming & Jeremy Munnings', '1000', 'crew', 19,
    271.0, 227.0, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: A2Z. Helm: Jamie Fleming, Crew: Jeremy Munnings. Club: LYC. State: TAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '82a5c52b-046a-5067-8034-731c24639f54', '189fd231-a458-5b96-b394-f2acc1868ee3', '770ababd-c952-5955-a2c7-dd362803e641', 'Jamie Fleming', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '32813e4b-cc8f-5fe1-9ad7-e20bf3681641', '189fd231-a458-5b96-b394-f2acc1868ee3', '717bd4e9-7c0c-5149-9faf-031e2a7055e7', 'Jeremy Munnings', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '189fd231-a458-5b96-b394-f2acc1868ee3', 1, 22.0, 'DNF', true, '(22) DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '189fd231-a458-5b96-b394-f2acc1868ee3', 2, 18.0, NULL, false, '18'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '189fd231-a458-5b96-b394-f2acc1868ee3', 3, 19.0, NULL, false, '19'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '189fd231-a458-5b96-b394-f2acc1868ee3', 4, 20.0, NULL, false, '20'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '189fd231-a458-5b96-b394-f2acc1868ee3', 5, 22.0, 'DNF', true, '(22) DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '189fd231-a458-5b96-b394-f2acc1868ee3', 6, 22.0, 'DNS', false, '22 DNS'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '189fd231-a458-5b96-b394-f2acc1868ee3', 7, 22.0, 'DNC', false, '22 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '189fd231-a458-5b96-b394-f2acc1868ee3', 8, 16.0, NULL, false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '189fd231-a458-5b96-b394-f2acc1868ee3', 9, 18.0, NULL, false, '18'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '189fd231-a458-5b96-b394-f2acc1868ee3', 10, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '189fd231-a458-5b96-b394-f2acc1868ee3', 11, 19.0, NULL, false, '19'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '189fd231-a458-5b96-b394-f2acc1868ee3', 12, 17.0, NULL, false, '17'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '189fd231-a458-5b96-b394-f2acc1868ee3', 13, 22.0, 'RET', false, '22 RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '189fd231-a458-5b96-b394-f2acc1868ee3', 14, 19.0, NULL, false, '19'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '20cd72cb-c2cf-5976-a5fd-1a913fa7b479', 'f984bada-0fb2-5064-84ed-1cc8301e825b', 'fee77625-0acd-5b42-b336-645dd4650303', 'Daisy Locke & Cooper Pennell', '1932', 'crew', 20,
    282.0, 238.0, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: Barefoot Bandits. Helm: Daisy Locke, Crew: Cooper Pennell. Club: KBSC / RQYS. State: TAS / QLD. Female Skipper', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'd1a6acf6-ee6d-5a8f-9296-d84ff2c65966', '20cd72cb-c2cf-5976-a5fd-1a913fa7b479', 'f984bada-0fb2-5064-84ed-1cc8301e825b', 'Daisy Locke', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '467c2f11-2827-5828-a6b4-ef8375e7f61f', '20cd72cb-c2cf-5976-a5fd-1a913fa7b479', 'a2c0a9b1-e9e9-5813-8d68-e0b6157decd4', 'Cooper Pennell', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20cd72cb-c2cf-5976-a5fd-1a913fa7b479', 1, 20.0, NULL, false, '20'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20cd72cb-c2cf-5976-a5fd-1a913fa7b479', 2, 22.0, 'RET', true, '(22) RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20cd72cb-c2cf-5976-a5fd-1a913fa7b479', 3, 21.0, NULL, false, '21'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20cd72cb-c2cf-5976-a5fd-1a913fa7b479', 4, 19.0, NULL, false, '19'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20cd72cb-c2cf-5976-a5fd-1a913fa7b479', 5, 19.0, NULL, false, '19'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20cd72cb-c2cf-5976-a5fd-1a913fa7b479', 6, 19.0, NULL, false, '19'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20cd72cb-c2cf-5976-a5fd-1a913fa7b479', 7, 19.0, NULL, false, '19'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20cd72cb-c2cf-5976-a5fd-1a913fa7b479', 8, 17.0, NULL, false, '17'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20cd72cb-c2cf-5976-a5fd-1a913fa7b479', 9, 22.0, 'DNF', true, '(22) DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20cd72cb-c2cf-5976-a5fd-1a913fa7b479', 10, 22.0, 'DNF', false, '22 DNF'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20cd72cb-c2cf-5976-a5fd-1a913fa7b479', 11, 20.0, NULL, false, '20'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20cd72cb-c2cf-5976-a5fd-1a913fa7b479', 12, 22.0, 'RET', false, '22 RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20cd72cb-c2cf-5976-a5fd-1a913fa7b479', 13, 22.0, 'DNC', false, '22 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '20cd72cb-c2cf-5976-a5fd-1a913fa7b479', 14, 18.0, NULL, false, '18'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '9a15b042-d16e-58f9-b4e0-d77c4767aafe', '10a75ea8-bb1e-541e-94b0-3c676f8a6efa', 'fee77625-0acd-5b42-b336-645dd4650303', 'Linnea Townend & Annelin Townend', '2197', 'crew', 21,
    297.0, 253.0, false, false, 'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1',
    'https://sailingresults.net/sa/results/Overall.aspx?ID=82088.1', 'Official Australian 29er Championship 2026 Results',
    'url', '2026 Australian 29er Championship. Boat: Dumb and Dumber. Helm: Linnea Townend, Crew: Annelin Townend. Club: SBSC. State: TAS.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '2ada74ae-4153-5ef4-847a-60b8ec96d3f1', '9a15b042-d16e-58f9-b4e0-d77c4767aafe', '10a75ea8-bb1e-541e-94b0-3c676f8a6efa', 'Linnea Townend', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f5d7a94f-6679-5d75-aa87-9143de271cec', '9a15b042-d16e-58f9-b4e0-d77c4767aafe', '0f3e5832-27ba-5c06-b320-533423d5a5fd', 'Annelin Townend', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a15b042-d16e-58f9-b4e0-d77c4767aafe', 1, 19.0, NULL, false, '19'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a15b042-d16e-58f9-b4e0-d77c4767aafe', 2, 17.0, NULL, false, '17'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a15b042-d16e-58f9-b4e0-d77c4767aafe', 3, 20.0, NULL, false, '20'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a15b042-d16e-58f9-b4e0-d77c4767aafe', 4, 21.0, NULL, false, '21'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a15b042-d16e-58f9-b4e0-d77c4767aafe', 5, 22.0, 'RET', true, '(22) RET'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a15b042-d16e-58f9-b4e0-d77c4767aafe', 6, 22.0, 'DNC', true, '(22) DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a15b042-d16e-58f9-b4e0-d77c4767aafe', 7, 22.0, 'DNC', false, '22 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a15b042-d16e-58f9-b4e0-d77c4767aafe', 8, 22.0, 'DNC', false, '22 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a15b042-d16e-58f9-b4e0-d77c4767aafe', 9, 22.0, 'DNC', false, '22 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a15b042-d16e-58f9-b4e0-d77c4767aafe', 10, 22.0, 'DNC', false, '22 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a15b042-d16e-58f9-b4e0-d77c4767aafe', 11, 22.0, 'DNC', false, '22 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a15b042-d16e-58f9-b4e0-d77c4767aafe', 12, 22.0, 'DNC', false, '22 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a15b042-d16e-58f9-b4e0-d77c4767aafe', 13, 22.0, 'DNC', false, '22 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '9a15b042-d16e-58f9-b4e0-d77c4767aafe', 14, 22.0, 'DNC', false, '22 DNC'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- 4. Insert 2026 International 420 Class Australian Championship Event & Sheet
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules,
    created_at, updated_at
) VALUES (
    '461a8964-aad3-5b67-a766-a6c79d1d6a05',
    '2026 International 420 Class Australian Championship',
    '2026-international-420-class-australian-championship',
    '2026-01-19',
    '2026-01-23',
    'Albury Wodonga Sailing Club, Lake Hume, Victoria',
    'Albury Wodonga Sailing Club / Australian International 420 Class Association',
    '["420"]'::jsonb,
    false,
    false,
    'Official International 420 Class Australian Championship 2026 held 19–23 January 2026 at Albury Wodonga Sailing Club, Lake Hume, Victoria.',
    'Low Point System with 2 discards.',
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, venue, organizer, geography, boat_class,
    division, entry_type, min_participants, max_participants, total_fleet_size, race_count,
    counts_for_ranking, is_selection_trial, status, official_results_url, official_results_source_name,
    created_at, updated_at
) VALUES (
    'b4e222c7-0fe6-514f-918a-5032b4beb045',
    '461a8964-aad3-5b67-a766-a6c79d1d6a05',
    '2026 International 420 Class Australian Championship — 420',
    '2026-international-420-class-australian-championship-420',
    '2026-01-23',
    '2026-01-23',
    'Albury Wodonga Sailing Club, Lake Hume, Victoria',
    'Albury Wodonga Sailing Club / Australian International 420 Class Association',
    'AUS',
    '420',
    'Open',
    'crew',
    2,
    2,
    17,
    10,
    false,
    false,
    'published',
    'https://www.sailres.com/view.php?s=2755',
    'Official 420 Australian Championship 2026 Final Results (Sailres Series 2755)',
    clock_timestamp(),
    clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    status = EXCLUDED.status;

-- 5. Insert 420 Results, Participants & Race Scores
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'bc4fd8f9-6ebf-541f-95a0-9feed4eada7f', '471b461c-5c75-57ae-b96d-5ecf09e15791', 'b4e222c7-0fe6-514f-918a-5032b4beb045', 'William Rose & Stewart Rose', '55232', 'crew', 1,
    17.0, 9.0, false, false, 'https://www.sailres.com/view.php?s=2755',
    'https://www.sailres.com/view.php?s=2755', 'Official 420 Australian Championship 2026 Results',
    'url', '2026 International 420 Australian Championship. Boat: Mr Brightside. Helm: William Rose, Crew: Stewart Rose. Club: MSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '6e544491-ddd1-5e7b-b637-5359c8d7e441', 'bc4fd8f9-6ebf-541f-95a0-9feed4eada7f', '471b461c-5c75-57ae-b96d-5ecf09e15791', 'William Rose', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c689dcbb-4664-5ef4-9e09-5c9d0dcb6e48', 'bc4fd8f9-6ebf-541f-95a0-9feed4eada7f', '022a86b8-a184-5502-9c68-2cf0282e91fa', 'Stewart Rose', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc4fd8f9-6ebf-541f-95a0-9feed4eada7f', 1, 3.0, NULL, true, '(3)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc4fd8f9-6ebf-541f-95a0-9feed4eada7f', 2, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc4fd8f9-6ebf-541f-95a0-9feed4eada7f', 3, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc4fd8f9-6ebf-541f-95a0-9feed4eada7f', 4, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc4fd8f9-6ebf-541f-95a0-9feed4eada7f', 5, 5.0, NULL, true, '(5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc4fd8f9-6ebf-541f-95a0-9feed4eada7f', 6, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc4fd8f9-6ebf-541f-95a0-9feed4eada7f', 7, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc4fd8f9-6ebf-541f-95a0-9feed4eada7f', 8, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc4fd8f9-6ebf-541f-95a0-9feed4eada7f', 9, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bc4fd8f9-6ebf-541f-95a0-9feed4eada7f', 10, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '45e81305-b79c-53eb-acd5-c7f48b789efe', '1366873d-9230-48ae-9dc3-6ef8e8355301', 'b4e222c7-0fe6-514f-918a-5032b4beb045', 'Victoria Lin & Annabelle Sampson', '56931', 'crew', 2,
    58.0, 22.0, false, false, 'https://www.sailres.com/view.php?s=2755',
    'https://www.sailres.com/view.php?s=2755', 'Official 420 Australian Championship 2026 Results',
    'url', '2026 International 420 Australian Championship. Boat: Rush. Helm: Victoria Lin, Crew: Annabelle Sampson. Club: RPAYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'dbedffaa-09e1-500b-a911-e6b6b8a2f016', '45e81305-b79c-53eb-acd5-c7f48b789efe', '1366873d-9230-48ae-9dc3-6ef8e8355301', 'Victoria Lin', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '2fe968e4-f72e-5249-afda-bbc3ddfbb894', '45e81305-b79c-53eb-acd5-c7f48b789efe', 'fa4f83f1-7f42-5257-815c-ad62f803cd11', 'Annabelle Sampson', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e81305-b79c-53eb-acd5-c7f48b789efe', 1, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e81305-b79c-53eb-acd5-c7f48b789efe', 2, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e81305-b79c-53eb-acd5-c7f48b789efe', 3, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e81305-b79c-53eb-acd5-c7f48b789efe', 4, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e81305-b79c-53eb-acd5-c7f48b789efe', 5, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e81305-b79c-53eb-acd5-c7f48b789efe', 6, 18.0, 'DSQ', true, '(18 (DSQ))'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e81305-b79c-53eb-acd5-c7f48b789efe', 7, 18.0, 'UFD', true, '(18 (UFD))'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e81305-b79c-53eb-acd5-c7f48b789efe', 8, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e81305-b79c-53eb-acd5-c7f48b789efe', 9, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e81305-b79c-53eb-acd5-c7f48b789efe', 10, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '14652bb2-d800-5312-9cb6-9d6ab412568b', '2763312e-4580-50b0-9dbc-d644916f8d75', 'b4e222c7-0fe6-514f-918a-5032b4beb045', 'Aaveer Patil-Chaudhari & Goro Tomishima', '54351', 'crew', 3,
    48.5, 33.0, false, false, 'https://www.sailres.com/view.php?s=2755',
    'https://www.sailres.com/view.php?s=2755', 'Official 420 Australian Championship 2026 Results',
    'url', '2026 International 420 Australian Championship. Boat: In The Wind. Helm: Aaveer Patil-Chaudhari, Crew: Goro Tomishima. Club: RPAYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '1236cf24-20f2-5dcd-9a28-db3aa36b6491', '14652bb2-d800-5312-9cb6-9d6ab412568b', '2763312e-4580-50b0-9dbc-d644916f8d75', 'Aaveer Patil-Chaudhari', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '9974574d-04ad-5f77-8b48-25011fed058a', '14652bb2-d800-5312-9cb6-9d6ab412568b', 'a6b4e58d-fbba-5f54-9d91-ea3336356cf4', 'Goro Tomishima', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14652bb2-d800-5312-9cb6-9d6ab412568b', 1, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14652bb2-d800-5312-9cb6-9d6ab412568b', 2, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14652bb2-d800-5312-9cb6-9d6ab412568b', 3, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14652bb2-d800-5312-9cb6-9d6ab412568b', 4, 8.0, NULL, true, '(8)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14652bb2-d800-5312-9cb6-9d6ab412568b', 5, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14652bb2-d800-5312-9cb6-9d6ab412568b', 6, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14652bb2-d800-5312-9cb6-9d6ab412568b', 7, 7.5, NULL, true, '(7.5)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14652bb2-d800-5312-9cb6-9d6ab412568b', 8, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14652bb2-d800-5312-9cb6-9d6ab412568b', 9, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '14652bb2-d800-5312-9cb6-9d6ab412568b', 10, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'c7039bb6-d7c9-5bb9-aaf6-b43d6ffdf230', '65388d04-67e1-56a6-b864-00361cc33a71', 'b4e222c7-0fe6-514f-918a-5032b4beb045', 'Olivia Cameron & Gary Cameron', '55149', 'crew', 4,
    59.0, 34.0, false, false, 'https://www.sailres.com/view.php?s=2755',
    'https://www.sailres.com/view.php?s=2755', 'Official 420 Australian Championship 2026 Results',
    'url', '2026 International 420 Australian Championship. Boat: Azzurra. Helm: Olivia Cameron, Crew: Gary Cameron. Club: D''BYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '0376aa45-0c1f-59b0-b659-41c654ee56e2', 'c7039bb6-d7c9-5bb9-aaf6-b43d6ffdf230', '65388d04-67e1-56a6-b864-00361cc33a71', 'Olivia Cameron', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'b3064901-e43e-53a7-ad4b-5f100cad8d03', 'c7039bb6-d7c9-5bb9-aaf6-b43d6ffdf230', 'a77a5051-bf23-5bba-9f0e-bc3c6f2c074f', 'Gary Cameron', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7039bb6-d7c9-5bb9-aaf6-b43d6ffdf230', 1, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7039bb6-d7c9-5bb9-aaf6-b43d6ffdf230', 2, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7039bb6-d7c9-5bb9-aaf6-b43d6ffdf230', 3, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7039bb6-d7c9-5bb9-aaf6-b43d6ffdf230', 4, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7039bb6-d7c9-5bb9-aaf6-b43d6ffdf230', 5, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7039bb6-d7c9-5bb9-aaf6-b43d6ffdf230', 6, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7039bb6-d7c9-5bb9-aaf6-b43d6ffdf230', 7, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7039bb6-d7c9-5bb9-aaf6-b43d6ffdf230', 8, 18.0, 'DNF', true, '(18 (DNF))'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7039bb6-d7c9-5bb9-aaf6-b43d6ffdf230', 9, 7.0, NULL, true, '(7)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'c7039bb6-d7c9-5bb9-aaf6-b43d6ffdf230', 10, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '23f164d9-aa94-5e6b-a8db-c84c174cd75b', '5f3ccfc2-191c-5c24-bc07-d2f12f895671', 'b4e222c7-0fe6-514f-918a-5032b4beb045', 'Fraser Baker & William Gaylard', '55167', 'crew', 5,
    54.0, 34.0, false, false, 'https://www.sailres.com/view.php?s=2755',
    'https://www.sailres.com/view.php?s=2755', 'Official 420 Australian Championship 2026 Results',
    'url', '2026 International 420 Australian Championship. Boat: Crush. Helm: Fraser Baker, Crew: William Gaylard. Club: LBSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7211b268-234a-5374-bef7-88513e4ed157', '23f164d9-aa94-5e6b-a8db-c84c174cd75b', '5f3ccfc2-191c-5c24-bc07-d2f12f895671', 'Fraser Baker', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '273ab0b5-e239-5b6e-a146-277b9da34510', '23f164d9-aa94-5e6b-a8db-c84c174cd75b', 'bb92c9fb-2428-5f86-aa86-b64934d39765', 'William Gaylard', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23f164d9-aa94-5e6b-a8db-c84c174cd75b', 1, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23f164d9-aa94-5e6b-a8db-c84c174cd75b', 2, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23f164d9-aa94-5e6b-a8db-c84c174cd75b', 3, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23f164d9-aa94-5e6b-a8db-c84c174cd75b', 4, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23f164d9-aa94-5e6b-a8db-c84c174cd75b', 5, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23f164d9-aa94-5e6b-a8db-c84c174cd75b', 6, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23f164d9-aa94-5e6b-a8db-c84c174cd75b', 7, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23f164d9-aa94-5e6b-a8db-c84c174cd75b', 8, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23f164d9-aa94-5e6b-a8db-c84c174cd75b', 9, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '23f164d9-aa94-5e6b-a8db-c84c174cd75b', 10, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '59ceda1e-10eb-507e-bd91-55a8d561192b', '4d0ce9b2-543b-5f0d-a3b2-555fddfa5f1a', 'b4e222c7-0fe6-514f-918a-5032b4beb045', 'Isabella Lozevski & Olivia Lee', '56674', 'crew', 6,
    74.0, 45.0, false, false, 'https://www.sailres.com/view.php?s=2755',
    'https://www.sailres.com/view.php?s=2755', 'Official 420 Australian Championship 2026 Results',
    'url', '2026 International 420 Australian Championship. Boat: LiLo. Helm: Isabella Lozevski, Crew: Olivia Lee. Club: WSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7312dae2-7bbf-591b-bb87-5407b3d2ab93', '59ceda1e-10eb-507e-bd91-55a8d561192b', '4d0ce9b2-543b-5f0d-a3b2-555fddfa5f1a', 'Isabella Lozevski', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '7e812f8a-9aea-5e44-a243-a06bc8b71dd5', '59ceda1e-10eb-507e-bd91-55a8d561192b', 'a30884c9-2fc8-5a8e-ae51-ccfe7cd7acaa', 'Olivia Lee', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59ceda1e-10eb-507e-bd91-55a8d561192b', 1, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59ceda1e-10eb-507e-bd91-55a8d561192b', 2, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59ceda1e-10eb-507e-bd91-55a8d561192b', 3, 18.0, 'UFD', true, '(18 (UFD))'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59ceda1e-10eb-507e-bd91-55a8d561192b', 4, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59ceda1e-10eb-507e-bd91-55a8d561192b', 5, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59ceda1e-10eb-507e-bd91-55a8d561192b', 6, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59ceda1e-10eb-507e-bd91-55a8d561192b', 7, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59ceda1e-10eb-507e-bd91-55a8d561192b', 8, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59ceda1e-10eb-507e-bd91-55a8d561192b', 9, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '59ceda1e-10eb-507e-bd91-55a8d561192b', 10, 11.0, NULL, true, '(11)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '2c313059-21a2-5734-a9cf-8b42a045f2ab', 'afb1dbf7-00c9-4033-94d3-5259920e3d94', 'b4e222c7-0fe6-514f-918a-5032b4beb045', 'Jessica Higgins & Austin Higgins', '51978', 'crew', 7,
    76.5, 51.5, false, false, 'https://www.sailres.com/view.php?s=2755',
    'https://www.sailres.com/view.php?s=2755', 'Official 420 Australian Championship 2026 Results',
    'url', '2026 International 420 Australian Championship. Boat: Scooby &amp; Shaggy. Helm: Jessica Higgins, Crew: Austin Higgins. Club: BSYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '2d2b6313-ce0c-5b23-b877-06cbb4351aa8', '2c313059-21a2-5734-a9cf-8b42a045f2ab', 'afb1dbf7-00c9-4033-94d3-5259920e3d94', 'Jessica Higgins', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '00be9197-2dc5-561b-8da0-4c781eafb88b', '2c313059-21a2-5734-a9cf-8b42a045f2ab', '204ec49b-39ff-53d9-bb39-e1891d13b0a8', 'Austin Higgins', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c313059-21a2-5734-a9cf-8b42a045f2ab', 1, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c313059-21a2-5734-a9cf-8b42a045f2ab', 2, 12.0, NULL, true, '(12)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c313059-21a2-5734-a9cf-8b42a045f2ab', 3, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c313059-21a2-5734-a9cf-8b42a045f2ab', 4, 13.0, NULL, true, '(13)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c313059-21a2-5734-a9cf-8b42a045f2ab', 5, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c313059-21a2-5734-a9cf-8b42a045f2ab', 6, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c313059-21a2-5734-a9cf-8b42a045f2ab', 7, 7.5, NULL, false, '7.5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c313059-21a2-5734-a9cf-8b42a045f2ab', 8, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c313059-21a2-5734-a9cf-8b42a045f2ab', 9, 1.0, NULL, false, '1'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '2c313059-21a2-5734-a9cf-8b42a045f2ab', 10, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '45e6da0f-1e58-53f7-96b4-bd3e6b0e727e', 'e0603e7f-fb35-5d9c-a3d3-e0233e69cf16', 'b4e222c7-0fe6-514f-918a-5032b4beb045', 'Abbey Everett & Matthew Whitaker', '56006', 'crew', 8,
    80.0, 52.0, false, false, 'https://www.sailres.com/view.php?s=2755',
    'https://www.sailres.com/view.php?s=2755', 'Official 420 Australian Championship 2026 Results',
    'url', '2026 International 420 Australian Championship. Boat: Blimey. Helm: Abbey Everett, Crew: Matthew Whitaker. Club: SBSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '44c12f9b-96b7-5301-9365-eb7bba6a5056', '45e6da0f-1e58-53f7-96b4-bd3e6b0e727e', 'e0603e7f-fb35-5d9c-a3d3-e0233e69cf16', 'Abbey Everett', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'ae927d61-a1bc-5b73-adf9-c5dcb7da5d7a', '45e6da0f-1e58-53f7-96b4-bd3e6b0e727e', 'dc697e24-bba4-58c6-848c-4cd743307742', 'Matthew Whitaker', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e6da0f-1e58-53f7-96b4-bd3e6b0e727e', 1, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e6da0f-1e58-53f7-96b4-bd3e6b0e727e', 2, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e6da0f-1e58-53f7-96b4-bd3e6b0e727e', 3, 10.0, NULL, true, '(10)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e6da0f-1e58-53f7-96b4-bd3e6b0e727e', 4, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e6da0f-1e58-53f7-96b4-bd3e6b0e727e', 5, 18.0, 'UFD', true, '(18 (UFD))'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e6da0f-1e58-53f7-96b4-bd3e6b0e727e', 6, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e6da0f-1e58-53f7-96b4-bd3e6b0e727e', 7, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e6da0f-1e58-53f7-96b4-bd3e6b0e727e', 8, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e6da0f-1e58-53f7-96b4-bd3e6b0e727e', 9, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '45e6da0f-1e58-53f7-96b4-bd3e6b0e727e', 10, 3.0, NULL, false, '3'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '5d2cf8e7-d10d-5fdb-bfb2-3e5469dc0aa0', '591838c6-fb1c-542e-960b-c01eeecc8a47', 'b4e222c7-0fe6-514f-918a-5032b4beb045', 'Nick Meijer & Jess Lowe', '52422', 'crew', 9,
    89.0, 58.0, false, false, 'https://www.sailres.com/view.php?s=2755',
    'https://www.sailres.com/view.php?s=2755', 'Official 420 Australian Championship 2026 Results',
    'url', '2026 International 420 Australian Championship. Boat: Little Sea. Helm: Nick Meijer, Crew: Jess Lowe. Club: SBSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c3d94dbc-6fee-51c3-af2d-deb5c72eb3ec', '5d2cf8e7-d10d-5fdb-bfb2-3e5469dc0aa0', '591838c6-fb1c-542e-960b-c01eeecc8a47', 'Nick Meijer', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'c82ead7d-7f75-5963-bc5a-7213a53b5d02', '5d2cf8e7-d10d-5fdb-bfb2-3e5469dc0aa0', 'c4b62dd5-2f83-5879-a388-48316130f2ab', 'Jess Lowe', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2cf8e7-d10d-5fdb-bfb2-3e5469dc0aa0', 1, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2cf8e7-d10d-5fdb-bfb2-3e5469dc0aa0', 2, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2cf8e7-d10d-5fdb-bfb2-3e5469dc0aa0', 3, 18.0, 'UFD', true, '(18 (UFD))'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2cf8e7-d10d-5fdb-bfb2-3e5469dc0aa0', 4, 7.0, NULL, false, '7'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2cf8e7-d10d-5fdb-bfb2-3e5469dc0aa0', 5, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2cf8e7-d10d-5fdb-bfb2-3e5469dc0aa0', 6, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2cf8e7-d10d-5fdb-bfb2-3e5469dc0aa0', 7, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2cf8e7-d10d-5fdb-bfb2-3e5469dc0aa0', 8, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2cf8e7-d10d-5fdb-bfb2-3e5469dc0aa0', 9, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '5d2cf8e7-d10d-5fdb-bfb2-3e5469dc0aa0', 10, 13.0, NULL, true, '(13)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '4f5bed47-911c-50dc-b052-e9f2d8c07cab', 'b11f8bb9-78dc-583a-9536-9665f0baef65', 'b4e222c7-0fe6-514f-918a-5032b4beb045', 'Paige Grigg & Darcy Higgins', '56191', 'crew', 10,
    100.0, 64.0, false, false, 'https://www.sailres.com/view.php?s=2755',
    'https://www.sailres.com/view.php?s=2755', 'Official 420 Australian Championship 2026 Results',
    'url', '2026 International 420 Australian Championship. Boat: Fred. Helm: Paige Grigg, Crew: Darcy Higgins. Club: B&SYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '5aa6b0f3-5019-5d5b-a4ea-f161a4fbc2a7', '4f5bed47-911c-50dc-b052-e9f2d8c07cab', 'b11f8bb9-78dc-583a-9536-9665f0baef65', 'Paige Grigg', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '85509a11-ab90-58e7-935a-292e48106bec', '4f5bed47-911c-50dc-b052-e9f2d8c07cab', '1fb2f059-b733-5654-a875-7579d6267cd5', 'Darcy Higgins', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f5bed47-911c-50dc-b052-e9f2d8c07cab', 1, 18.0, 'UFD', true, '(18 (UFD))'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f5bed47-911c-50dc-b052-e9f2d8c07cab', 2, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f5bed47-911c-50dc-b052-e9f2d8c07cab', 3, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f5bed47-911c-50dc-b052-e9f2d8c07cab', 4, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f5bed47-911c-50dc-b052-e9f2d8c07cab', 5, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f5bed47-911c-50dc-b052-e9f2d8c07cab', 6, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f5bed47-911c-50dc-b052-e9f2d8c07cab', 7, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f5bed47-911c-50dc-b052-e9f2d8c07cab', 8, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f5bed47-911c-50dc-b052-e9f2d8c07cab', 9, 18.0, 'DSQ', true, '(18 (DSQ))'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '4f5bed47-911c-50dc-b052-e9f2d8c07cab', 10, 4.0, NULL, false, '4'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '06800286-d9f3-5114-a0c1-43667695dc88', 'e4c07ae9-fb15-5e50-a197-098121fdeade', 'b4e222c7-0fe6-514f-918a-5032b4beb045', 'Oscar Forbes & Finn Meijer', '56542', 'crew', 11,
    97.0, 73.0, false, false, 'https://www.sailres.com/view.php?s=2755',
    'https://www.sailres.com/view.php?s=2755', 'Official 420 Australian Championship 2026 Results',
    'url', '2026 International 420 Australian Championship. Boat: Giacomo. Helm: Oscar Forbes, Crew: Finn Meijer. Club: SBSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e84b84a7-9538-5825-b417-66173613f7d8', '06800286-d9f3-5114-a0c1-43667695dc88', 'e4c07ae9-fb15-5e50-a197-098121fdeade', 'Oscar Forbes', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '294f1e59-11ea-5444-96c9-550bfa633124', '06800286-d9f3-5114-a0c1-43667695dc88', 'd9a4994c-ac98-5647-afa6-09b96da0b509', 'Finn Meijer', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '06800286-d9f3-5114-a0c1-43667695dc88', 1, 5.0, NULL, false, '5'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '06800286-d9f3-5114-a0c1-43667695dc88', 2, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '06800286-d9f3-5114-a0c1-43667695dc88', 3, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '06800286-d9f3-5114-a0c1-43667695dc88', 4, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '06800286-d9f3-5114-a0c1-43667695dc88', 5, 12.0, NULL, true, '(12)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '06800286-d9f3-5114-a0c1-43667695dc88', 6, 12.0, NULL, true, '(12)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '06800286-d9f3-5114-a0c1-43667695dc88', 7, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '06800286-d9f3-5114-a0c1-43667695dc88', 8, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '06800286-d9f3-5114-a0c1-43667695dc88', 9, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '06800286-d9f3-5114-a0c1-43667695dc88', 10, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '60502f54-1760-503e-8ca4-6abcc07fae14', '22c6ad0b-54bc-54fc-af03-e2739dc7665d', 'b4e222c7-0fe6-514f-918a-5032b4beb045', 'Gary McLennan & Rachael Benoy', '55168', 'crew', 12,
    116.0, 80.0, false, false, 'https://www.sailres.com/view.php?s=2755',
    'https://www.sailres.com/view.php?s=2755', 'Official 420 Australian Championship 2026 Results',
    'url', '2026 International 420 Australian Championship. Boat: Wren. Helm: Gary McLennan, Crew: Rachael Benoy. Club: BRYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'e5cba8d7-d366-547a-8d2f-dae061fefcd6', '60502f54-1760-503e-8ca4-6abcc07fae14', '22c6ad0b-54bc-54fc-af03-e2739dc7665d', 'Gary McLennan', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '927a882f-be98-5206-8d2d-b9224a055d8b', '60502f54-1760-503e-8ca4-6abcc07fae14', '5ad82002-040c-4501-bad5-c7ebdd8c0fd3', 'Rachael Benoy', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '60502f54-1760-503e-8ca4-6abcc07fae14', 1, 18.0, 'UFD', true, '(18 (UFD))'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '60502f54-1760-503e-8ca4-6abcc07fae14', 2, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '60502f54-1760-503e-8ca4-6abcc07fae14', 3, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '60502f54-1760-503e-8ca4-6abcc07fae14', 4, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '60502f54-1760-503e-8ca4-6abcc07fae14', 5, 2.0, NULL, false, '2'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '60502f54-1760-503e-8ca4-6abcc07fae14', 6, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '60502f54-1760-503e-8ca4-6abcc07fae14', 7, 18.0, 'UFD', true, '(18 (UFD))'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '60502f54-1760-503e-8ca4-6abcc07fae14', 8, 16.0, NULL, false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '60502f54-1760-503e-8ca4-6abcc07fae14', 9, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '60502f54-1760-503e-8ca4-6abcc07fae14', 10, 6.0, NULL, false, '6'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'bd512200-d248-52d9-8542-a280193ceced', 'caff328b-6c2e-5a9f-8044-0db7aa969461', 'b4e222c7-0fe6-514f-918a-5032b4beb045', 'Ben Glover & Oliver Halse', '55150', 'crew', 13,
    118.0, 88.0, false, false, 'https://www.sailres.com/view.php?s=2755',
    'https://www.sailres.com/view.php?s=2755', 'Official 420 Australian Championship 2026 Results',
    'url', '2026 International 420 Australian Championship. Boat: X. Helm: Ben Glover, Crew: Oliver Halse. Club: SYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'f0be224a-4d30-5378-9980-c22a22294705', 'bd512200-d248-52d9-8542-a280193ceced', 'caff328b-6c2e-5a9f-8044-0db7aa969461', 'Ben Glover', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '999a8b64-bfbc-5bef-8df3-98568d63952d', 'bd512200-d248-52d9-8542-a280193ceced', '1f6b951f-4224-5d3a-8ce7-99d82cab58a7', 'Oliver Halse', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd512200-d248-52d9-8542-a280193ceced', 1, 9.0, NULL, false, '9'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd512200-d248-52d9-8542-a280193ceced', 2, 15.0, NULL, true, '(15)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd512200-d248-52d9-8542-a280193ceced', 3, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd512200-d248-52d9-8542-a280193ceced', 4, 15.0, NULL, true, '(15)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd512200-d248-52d9-8542-a280193ceced', 5, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd512200-d248-52d9-8542-a280193ceced', 6, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd512200-d248-52d9-8542-a280193ceced', 7, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd512200-d248-52d9-8542-a280193ceced', 8, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd512200-d248-52d9-8542-a280193ceced', 9, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'bd512200-d248-52d9-8542-a280193ceced', 10, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '61591f42-fd61-5410-a20a-fdf085617e52', 'cd6c0d2c-5458-46fa-b585-92e868fbd7c9', 'b4e222c7-0fe6-514f-918a-5032b4beb045', 'Meg Bates & Rosa Crawford', '56388', 'crew', 14,
    131.0, 99.0, false, false, 'https://www.sailres.com/view.php?s=2755',
    'https://www.sailres.com/view.php?s=2755', 'Official 420 Australian Championship 2026 Results',
    'url', '2026 International 420 Australian Championship. Boat: For Sale. Helm: Meg Bates, Crew: Rosa Crawford. Club: RPAYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'fc708f7f-58b1-5b38-9b8e-ca6cf4831c7a', '61591f42-fd61-5410-a20a-fdf085617e52', 'cd6c0d2c-5458-46fa-b585-92e868fbd7c9', 'Meg Bates', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '55202fef-4315-5337-ac06-a74027644a4e', '61591f42-fd61-5410-a20a-fdf085617e52', '1b0fb23b-469d-563f-8ac1-49ecfd995b5e', 'Rosa Crawford', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '61591f42-fd61-5410-a20a-fdf085617e52', 1, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '61591f42-fd61-5410-a20a-fdf085617e52', 2, 10.0, NULL, false, '10'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '61591f42-fd61-5410-a20a-fdf085617e52', 3, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '61591f42-fd61-5410-a20a-fdf085617e52', 4, 17.0, NULL, true, '(17)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '61591f42-fd61-5410-a20a-fdf085617e52', 5, 15.0, NULL, true, '(15)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '61591f42-fd61-5410-a20a-fdf085617e52', 6, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '61591f42-fd61-5410-a20a-fdf085617e52', 7, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '61591f42-fd61-5410-a20a-fdf085617e52', 8, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '61591f42-fd61-5410-a20a-fdf085617e52', 9, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '61591f42-fd61-5410-a20a-fdf085617e52', 10, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '1fbfaf63-6c9e-5540-8b62-57025c8e614c', '832131a0-a4ef-579b-9a6d-1d242d8d2db1', 'b4e222c7-0fe6-514f-918a-5032b4beb045', 'Ilsa Ren Cohen & Brendan Goh', '56615', 'crew', 15,
    135.0, 103.0, false, false, 'https://www.sailres.com/view.php?s=2755',
    'https://www.sailres.com/view.php?s=2755', 'Official 420 Australian Championship 2026 Results',
    'url', '2026 International 420 Australian Championship. Boat: Shogun. Helm: Ilsa Ren Cohen, Crew: Brendan Goh. Club: WSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '082e2776-9808-5744-b085-4eb0d1074b80', '1fbfaf63-6c9e-5540-8b62-57025c8e614c', '832131a0-a4ef-579b-9a6d-1d242d8d2db1', 'Ilsa Ren Cohen', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '562d73ba-e417-5f0f-9828-f421d8c423f9', '1fbfaf63-6c9e-5540-8b62-57025c8e614c', 'deaff410-7461-594b-aad5-3a389d08fc08', 'Brendan Goh', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1fbfaf63-6c9e-5540-8b62-57025c8e614c', 1, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1fbfaf63-6c9e-5540-8b62-57025c8e614c', 2, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1fbfaf63-6c9e-5540-8b62-57025c8e614c', 3, 8.0, NULL, false, '8'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1fbfaf63-6c9e-5540-8b62-57025c8e614c', 4, 16.0, NULL, true, '(16)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1fbfaf63-6c9e-5540-8b62-57025c8e614c', 5, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1fbfaf63-6c9e-5540-8b62-57025c8e614c', 6, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1fbfaf63-6c9e-5540-8b62-57025c8e614c', 7, 13.0, NULL, false, '13'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1fbfaf63-6c9e-5540-8b62-57025c8e614c', 8, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1fbfaf63-6c9e-5540-8b62-57025c8e614c', 9, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '1fbfaf63-6c9e-5540-8b62-57025c8e614c', 10, 16.0, NULL, true, '(16)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    '155383ee-aa9a-5258-8424-f3f05affd0e2', '3ea3b023-5098-5bf8-a819-bb881de0adf5', 'b4e222c7-0fe6-514f-918a-5032b4beb045', 'Oscar Gayland & Lucy Cree', '55104', 'crew', 16,
    140.0, 109.0, false, false, 'https://www.sailres.com/view.php?s=2755',
    'https://www.sailres.com/view.php?s=2755', 'Official 420 Australian Championship 2026 Results',
    'url', '2026 International 420 Australian Championship. Boat: Slip Away. Helm: Oscar Gayland, Crew: Lucy Cree. Club: LBSC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'a9f55ba3-553c-58d8-83ae-00e742da74b2', '155383ee-aa9a-5258-8424-f3f05affd0e2', '3ea3b023-5098-5bf8-a819-bb881de0adf5', 'Oscar Gayland', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '771900e7-dda7-59a8-9015-772cf6c6ac23', '155383ee-aa9a-5258-8424-f3f05affd0e2', '0a96fc6c-3d91-5752-9f56-5504215d30ab', 'Lucy Cree', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '155383ee-aa9a-5258-8424-f3f05affd0e2', 1, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '155383ee-aa9a-5258-8424-f3f05affd0e2', 2, 16.0, NULL, true, '(16)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '155383ee-aa9a-5258-8424-f3f05affd0e2', 3, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '155383ee-aa9a-5258-8424-f3f05affd0e2', 4, 12.0, NULL, false, '12'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '155383ee-aa9a-5258-8424-f3f05affd0e2', 5, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '155383ee-aa9a-5258-8424-f3f05affd0e2', 6, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '155383ee-aa9a-5258-8424-f3f05affd0e2', 7, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '155383ee-aa9a-5258-8424-f3f05affd0e2', 8, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '155383ee-aa9a-5258-8424-f3f05affd0e2', 9, 15.0, NULL, true, '(15)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    '155383ee-aa9a-5258-8424-f3f05affd0e2', 10, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank,
    total_score, nett_score, is_dns, is_overseas_commitment, official_url, evidence_url,
    evidence_name, evidence_type, evidence_notes, verification_status, verified_at,
    created_at, updated_at
) VALUES (
    'e53f7438-9fc2-5fb6-bd4e-b4b8af89255b', '81f07d35-7187-5d92-a817-e8ea2fa767e2', 'b4e222c7-0fe6-514f-918a-5032b4beb045', 'Stephanie Johnson & Georgia Griffin', '51578', 'crew', 17,
    150.0, 116.0, false, false, 'https://www.sailres.com/view.php?s=2755',
    'https://www.sailres.com/view.php?s=2755', 'Official 420 Australian Championship 2026 Results',
    'url', '2026 International 420 Australian Championship. Boat: Sheilas. Helm: Stephanie Johnson, Crew: Georgia Griffin. Club: B&SYC.', 'verified', clock_timestamp(), clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    '13f76c51-a9a4-5f57-9331-6113cc05695e', 'e53f7438-9fc2-5fb6-bd4e-b4b8af89255b', '81f07d35-7187-5d92-a817-e8ea2fa767e2', 'Stephanie Johnson', 1, 'helm', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at
) VALUES (
    'bf19f42b-54d2-5902-92ac-f0cdf4513995', 'e53f7438-9fc2-5fb6-bd4e-b4b8af89255b', '66b5397a-acd0-5977-9ada-8550a868820d', 'Georgia Griffin', 2, 'crew', 'matched', false, clock_timestamp(), clock_timestamp()
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e53f7438-9fc2-5fb6-bd4e-b4b8af89255b', 1, 15.0, NULL, false, '15'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e53f7438-9fc2-5fb6-bd4e-b4b8af89255b', 2, 17.0, NULL, true, '(17)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e53f7438-9fc2-5fb6-bd4e-b4b8af89255b', 3, 11.0, NULL, false, '11'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e53f7438-9fc2-5fb6-bd4e-b4b8af89255b', 4, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e53f7438-9fc2-5fb6-bd4e-b4b8af89255b', 5, 16.0, NULL, false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e53f7438-9fc2-5fb6-bd4e-b4b8af89255b', 6, 16.0, NULL, false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e53f7438-9fc2-5fb6-bd4e-b4b8af89255b', 7, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e53f7438-9fc2-5fb6-bd4e-b4b8af89255b', 8, 14.0, NULL, false, '14'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e53f7438-9fc2-5fb6-bd4e-b4b8af89255b', 9, 16.0, NULL, false, '16'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;
INSERT INTO public.regatta_race_results (
    regatta_result_id, race_number, score, scoring_code, discarded, raw_value
) VALUES (
    'e53f7438-9fc2-5fb6-bd4e-b4b8af89255b', 10, 17.0, NULL, true, '(17)'
) ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, discarded = EXCLUDED.discarded;

-- 6. Admin Change Log Record
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'regattas.import_championships',
  'regatta',
  'fee77625-0acd-5b42-b336-645dd4650303',
  '2026 Australian 29er & 420 Championships',
  'Imported 2 national championships (29er at SBSC and 420 at AWSC) totaling 38 boats, 76 participants, and 464 race scores.',
  jsonb_build_object(
    'regattas', jsonb_build_array('2026-australian-29er-championship-29er', '2026-international-420-class-australian-championship-420'),
    'new_profiles_created', 39,
    'races_total', 464,
    'status', 'published'
  ),
  'migration_168',
  clock_timestamp()
);

COMMIT;
